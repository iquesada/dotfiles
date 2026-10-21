#!/usr/bin/python
# -*- coding: utf-8 -*-

from os import *
from os.path import *
from sys import exit

homedir = environ["HOME"]
dotfiles = join(homedir, "dotfiles")

def symlinkfile(fname):
    source = relpath(dotfiles+"/"+fname, dirname(homedir+"/."+fname))
    target = homedir+"/."+fname
    if not islink(target):
        if exists(target):
            print("WARNING: %s exists" % target)
        else:
            print("creating symlink: %s\n\t→ %s" % (target, source))
            symlink(source, target)

def makelinks(path = "."):
    if path != ".":
        dirpath = normpath(join(homedir,'.'+path))
    else:
        dirpath = normpath(join(homedir,path))

    if not exists(dirpath):
        print("mkdir: %s" % dirpath)
        mkdir(dirpath)

    for fname in listdir(path):
        # skip this script and files starting with a dot
        if fname == normpath(__file__) or fname[0] == '.' or (path == "." and fname == "ai"):
            print("skipping %s" % fname)
            continue

        filepath=normpath(join(path, fname))

        if isfile(filepath):
            symlinkfile(filepath)
        elif isdir(filepath):
            makelinks(filepath)
        else:
            print("neither file nor dir: %s" % filepath)

def ai_target_dir(kind):
    # Claude Code: ~/.claude/<kind>, Cursor: ~/.cursor/<kind>
    for tool in (".claude", ".cursor"):
        if isdir(join(homedir, tool, kind)):
            return join(homedir, tool, kind)
    return None

def linkai(kind):
    source_dir = join(dotfiles, "ai", kind)
    target_dir = ai_target_dir(kind)
    if not isdir(source_dir):
        return
    if target_dir is None:
        print("WARNING: no ~/.claude/%s or ~/.cursor/%s folder, skipping" % (kind, kind))
        return
    for fname in sorted(listdir(source_dir)):
        if fname[0] == '.':
            continue
        source = join(source_dir, fname)
        target = join(target_dir, fname)
        if islink(target):
            continue
        if exists(target):
            print("WARNING: %s exists" % target)
        else:
            print("creating symlink: %s\n\t→ %s" % (target, source))
            symlink(relpath(source, target_dir), target)

if abspath(".") != dotfiles:
    exit("ERROR: script must be run from ~/.dotfiles")

makelinks()
linkai("agents")
linkai("skills")
