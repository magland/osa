# osa
OSA pipeline development

## Learn about git...

In addition to reading this README file, try one of the following tutorials:

* https://product.hubspot.com/blog/git-and-github-tutorial-for-beginners
* https://git-scm.com/book/en/v2
* https://help.github.com/articles/set-up-git/

Or search the web. There's plenty of info to help.

## Getting started with this repo...

First clone this repo:

```
https://github.com/magland/osa.git osa
```

That should make a new directory on your computer called osa. There's a very important (hidden) folder in osa called .git. Take a look like this:

```
cd osa/.git
ls
```

You should see various files and folders such as `branches`, `COMMIT_EDITMSG`, etc. Those are all the internal things that the git system keeps track of. You don't need to worry about it. Just be aware that it is there. Now cd back to the osa directory:

```
cd ..
```

Now modify a file and then check the status of your working directory as follows:

```
echo "some stuff" > new_file.txt
git status
```

You will notice that the status shows the new file as an untracked change. Here's something very important to understand: some files in your working directory are part of the repo, and some are not. By default, `new_file.txt` is not part of the working directory. In other words, it will not show up on github, and if somebody else clones the repo, they won't get that file. In this case, if you wanted to add this to the repo you would do the following:

```
git add new_file.txt
git commit -m "Added a new file"
```

Note the two steps. First we add, then we commit (and every commit needs a comment message). Why two steps, not one? It's because git allows us to do multiple adds (or other staged changes) before committing. The first steps (add, rm, mv) are called staging changes, and the commit step is called committing those changes.

But, there's a third step. Those changes are still not on github -- they're only on your computer. So do the following to push your commit:

```
git push
```

If everything went well, the new committed file just got uploaded to github! So if other people clone the repo, then they will get the changes.

What if your friend makes a change, and you want to get it on your computer. Do you need to clone again? ... NO. Instead you do the following within your working directory:

```
git pull
```

That will pull the changes down to your computer.

There's a lot more to understand about git and github, but this is the basic flow:

* Pull (`git pull`, or if it's the first time `git clone [repo]`)
* Modify some files
* Stage the changes (`git add [filenames]`)
* Check the status (`git status`)
* Commit `git commit -m "explain what you did"`
* Push `git push`
* View the github website to browse your changes

If something goes wrong (which it most certainly will), don't forget the following crucial advice: https://xkcd.com/1597/

It is also possible to modify files directly from github, but that is somewhat discouraged (not in the spirit of git). But I usually do that for editing this README.md file. Sometimes it makes sense to do it this way.

Tip: If you modify some files that are already in the repo, and you want to commit all of your changes (this is often the case), then use the following:

```
git add -u
git status
git commit -m "Explain what you did"
git push
```

Note that it is important to do `git status` so that you can see what is about to be committed.

Very important: DO NOT stage/commit very large files! Only commit small source code files (like scripts and things).

**Which files should you commit?** As mentioned above, some of the files in your working directory are in the repo, and others are not in the repo. Which should be in the repo? Roughly speaking, if it is source code, then yes it should be in the repo. If it is files that are generated by running a program, then no it should not be in the repo. The idea is that those files that get generated should be generated separately by each person who clones the repo.

One nice thing about git is that it remembers versions of your repo. So each time you make a commit, it's like taking a snapshot of your project. If you mess something up, you can always go back to a past snapshot.

## What's in this repo?

* `README.md` This file!
* `LICENSE` It's good to have a license file in every repo.
* `code` This is the code we will work with (.m files and stuff)
* `code-original` A copy of the original code before we modified it -- so you don't need to worry about trying stuff out. But remember anyway that git keeps track of all previous versions of the code.

## What's that MRklar-master folder?

You will notice there is a folder called `code/MRklar-master`. This is a different project that is hosted on github too! It was downloaded from here:

https://github.com/gkaguirrelab/MRklar

The person who downloaded it made some changes, so the version in this repo is a bit different, and has some extra things. On the MRklar page we see the following:

### Required software:
- Freesurfer (https://surfer.nmr.mgh.harvard.edu/)
- FSL (https://fsl.fmrib.ox.ac.uk/fsl/fslwiki)
- MRIcron (https://www.nitrc.org/projects/mricron/)
---

So it's important that we install that stuff before we get started.


