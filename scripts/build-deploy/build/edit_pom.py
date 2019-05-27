#!/usr/bin/python3
# This scripts modified pom.xml from top level repository of mosip such that 
# it can be used for module wise split repository
# 
# Author: Puneet Joshi

import xml.etree.ElementTree as ET 
import sys
import argparse

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('original_pom', action ='store', help='Full path to top level pom.xml of consolidated repo') 
    parser.add_argument('modified_pom', action = 'store', help='Full path of modified pom.xml')
    parser.add_argument('module', action='store', help='Name of the module that needs to be retained from original as mentioned in original pom.xml. E.g. kernel, pre-registration')
    return parser.parse_args()

def main():

    args = parse_args()
    
    tree = ET.parse(args.original_pom)
    root = tree.getroot()
    namespace = '{http://maven.apache.org/POM/4.0.0}'
    # To make sure 'ns0' is not printed in output
    ET.register_namespace("", 'http://maven.apache.org/POM/4.0.0')
    modules = root.findall(namespace + 'modules')
    modules = modules[0]  # Only one modules tag in pom.xml
    remove = []
    for module in modules:
        if module.text.strip() != args.module: # Retain only args.module 
            remove.append(module) 
    
    for module in remove:
        modules.remove(module)
    
    tree.write(args.modified_pom)

if __name__ == '__main__':
    main()

