#!/usr/bin/python3
# This scripts builds all the modules using maven and dockerizes them
# Dependencies: maven (mvn), docker
# 
# To run the script, see the arguments: 
# $ ./build_all.py --help
#
#
# Author: Puneet Joshi

import subprocess
import os
import glob
import argparse
import logging
import sys

# Relative paths here
MODULES = ['../../mosip-kernel/',
           '../../mosip-prereg-services/']

BUILD_OPTS = '-DskipTests -Dspring.cloud.config.label=master'
BUILD_NUMBER = 'latest'

logger = None # Global

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--clean', action ='store_true', help='To build clean up all jars and build fresh again. Default=False')
    parser.add_argument('--dockerize', action ='store_true', help='Dockerize all built artifacts. Default=Fauls')
    parser.add_argument('--dockerlist_path', action='store', help='Path of output docker list. Default=./dockerlist.txt', default='./dockerlist.txt')
    return parser.parse_args()

def init_logger(module_name):
    logger = logging.getLogger(module_name)
    logger.setLevel(logging.DEBUG)  # Set to lowest level
    fh = logging.StreamHandler(sys.stdout) 
    formatter = logging.Formatter('[%(asctime)s][%(name)s][%(levelname)s]: %(message)s')
    fh.setFormatter(formatter)
    logger.addHandler(fh)
    return logger

def build(module_dir, clean):
    """
    Args:
        module_dir: Base directory of module (repository) 
        clean: Boolean to clean build. 
        logger: Instance of logger
    """
    cwd = os.getcwd()
    os.chdir(module_dir)
    if clean:
        subprocess.call('mvn clean', shell=True)
    logger.info('Building %s ..' % module_dir)
    subprocess.call('mvn install %s' % BUILD_OPTS, shell=True)
    
    os.chdir(cwd)  # Restore

def dockerize(module_dir, build_number):
    """
    Args:
        module_dir: Base directory of module (repository) 
        build_number: Used to tag docker image. E.g. '0.9.0'
    """
    cwd = os.getcwd()
    os.chdir(module_dir)
    images = [] # List of all images
    docker_files = glob.glob('**/Dockerfile', recursive=True)
    for docker_file in docker_files:
        submodule = docker_file.split('/')[-2].strip()    
        if submodule == '': 
            logger.error('Submodule name empty for %s. Exiting..' % docker_file)
            print('Exiting ..') 
            exit(0) 

        logger.info('Build docker image for %s' % submodule)
        os.chdir(os.path.dirname(docker_file))

        # Clean previous image
        logger.info('Removing previous image %s -------------' % submodule)
        image_name = '%s:%s' % (submodule, build_number) 
        subprocess.call('docker rmi %s' % image_name, shell=True) 
     
        # Dockerize
        logger.info('Dockerizing %s' % submodule) 
        subprocess.call('docker build -t %s .' % image_name, shell=True)

        images.append(image_name)
        
        os.chdir(cwd)
        os.chdir(module_dir)
 
    os.chdir(cwd) # Restore

    return images

def create_docker_list(images, list_path):
        fd = open(list_path, 'wt') 
        for image in images:
            fd.write('%s\n' % image)
        fd.close()

def main():
    global logger

    args = parse_args()
 
    logger = init_logger('BUILD')

    modules = MODULES

    for module in modules: 
        build(module, args.clean)

    if args.dockerize:
        all_images = []
        for module in modules: 
            images = dockerize(module, BUILD_NUMBER)
            all_images += images
        
        create_docker_list(all_images, args.dockerlist_path)

if __name__=='__main__':
    main()
