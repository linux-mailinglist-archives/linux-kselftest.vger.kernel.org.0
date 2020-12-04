Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147332CF3D2
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Dec 2020 19:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgLDSTJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Dec 2020 13:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbgLDSTG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Dec 2020 13:19:06 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56E7C061A52
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Dec 2020 10:18:26 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id z136so6701434iof.3
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Dec 2020 10:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tyzhaOntxGoZCdu/AWAta3ick3zzo0z3NSO9Ng3ArzM=;
        b=IYIg8serPFP4EU/s5kZJ0dofMxj7m/9wc2/OwJNF1Pr656kiSxRricNroqDK97vlnb
         fSK5hAZqwmLiNnl69rOHHWu9rfyJ3Wo9/+5n5GZ5DtNAGPE/2b7ebWO/na2iq360W9ZC
         2lOGKhiGhVHcygzb6+P45AyNvNdEOBuuOOdsAr8S5ymhsN2p4ES1xCqdk97oEPxt2nDT
         5MIp/s2KrJbXttK4DMkPQGTKFbnY1ZXXAkPQ2NVZbXG1nkOr6vMlh2KdDLNZpHYICT26
         2/Kfti1ql7bdfoeuaxjZZgdkWNa1GC1+pQYbjpBdlhmYwvg/pXzqcDC4Nuq2S6pQZw8y
         h+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tyzhaOntxGoZCdu/AWAta3ick3zzo0z3NSO9Ng3ArzM=;
        b=sh2vE7b+IXnzaU7tW1OijvUwHtWKBvQFTQBTJzP5O4cbWU2Y/KQ5jkDX14H9fDgx7G
         6StOVP95Yu7gCLKcptN4mL83vtroz4sa1XJU9feOxpXXzOY55AYYHgLD3DgdTGHapf1m
         AYwOPa7NtibTS7FHsRzbODRkFa08ozwdr24jwnZ7wSUwrGTRqbc810aiMw5JS80oBpwO
         HHgul3WAVN/4nOuQHUT37qZuYPzpGcxahbzbAFpuFvu5xyx0VUWKc5cEtkd/Ek7HwCif
         IlhZ8qCZdrF6y2IEXkar97QRIb7bjEjdh+woWr12tz+1kNoQciFFcVAgKQw9u6J5pFci
         V9aw==
X-Gm-Message-State: AOAM531TWSPe5BDz3ITJOS+UwW3ckZDE7nddu9fgep8C1vnezsUfvaDd
        h3bBIC3qgRJCyNXd9m8QArI9VOkNcaxvwYBqro78cg==
X-Google-Smtp-Source: ABdhPJzeBdr6CtdA5D2BmpKu9k07kysQ7ZuSzKC5gqKCv6nKVgDNMF35a1Hsx/5MeZJi7qoFc8Jy0Ek1Xjm9cnyVkvo=
X-Received: by 2002:a02:a498:: with SMTP id d24mr7945643jam.4.1607105905464;
 Fri, 04 Dec 2020 10:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20201203194127.1813731-1-dlatypov@google.com> <20201203194127.1813731-3-dlatypov@google.com>
 <CABVgOS=YfJdqmmU22XR4e84YyHudhksQc8X2rR1mz=6ukN=emA@mail.gmail.com>
In-Reply-To: <CABVgOS=YfJdqmmU22XR4e84YyHudhksQc8X2rR1mz=6ukN=emA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 4 Dec 2020 10:18:14 -0800
Message-ID: <CAGS_qxriVvSn5GXtAHdCjh+Y6k8+tNpVJ-Qm=kVOEOEXQJ4ACQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: tool: move kunitconfig parsing into __init__
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 3, 2020 at 7:57 PM David Gow <davidgow@google.com> wrote:
>
> On Fri, Dec 4, 2020 at 3:41 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > LinuxSourceTree will unceremoniously crash if the user doesn't call
> > read_kunitconfig() first in a number of functions.
>
> This patch seems to partly be reverting the changes here, right:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/tools/testing/kunit?h=kunit&id=fcdb0bc08ced274078f371e1e0fe6421a97fa9f2
> (That patch moved the reading of kunitconfig out of __init__)

Yes.

>
> My overall concern is that, really, there are some operations that
> shouldn't need a kunitconfig (even if they do at the moment), so we'd
> ideally want at least some of the operations currently under
> LinuxSourceTree to be able to be run without first reading a
> kunitconfig. Most notably, it'd be nice if kunit.py exec (and hence
> LinuxSourceTree::run_kernel()) didn't need a kunitconfig, as the
> kernel ought to already be built at this point.
>
> Now, this is all a little bit hypothetical, as we haven't bothered to
> make kunit.py exec work without a kunitconfig thus far, but I'm a
> touch hesitant to make it harder to bypass the kunitconfig reading
> anyway.

Fair point.

So one alternative to this to make type-checkers happy is to declare
_config instead of sneakily setting it in some random later method.
Then in all the places that rely on _config, we'd need to add in
checks that it's in fact set to give a better error message (so it's
clear to the user that it's an internal tool bug and has nothing to do
with them).

The copy-paste of create+read_kunitconfig() is annoying, which is why
I went with this.
How about __init__ takes an optional argument that can disable this parsing?

E.g.

def __init__(kconfig = None):
   if kconfig is not None:
     self._config = kconfig
   else:
     // create and read

Or if we don't like the idea of requiring users who don't want a
kconfig to pass in a dummy,

def __init__(load_kconfig=True):
   if not load_kconfig:
     self._config = None
   ...

>
> >
> > Adn currently every place we create an instance, the caller also calls
> > create_kunitconfig() and read_kunitconfig().
> >
> > Move these instead into __init__() so they can't be forgotten and to
> > reduce copy-paste.
>
> This seems to now be missing the create_kunitconfig() stuff (see below).

Ah good catch. Completely unintentional.
I'm sure I had the create_kunitconfig() stuff in __init__() at some
point but must have inadvertently removed it somehow later on.

> >
> > The https://github.com/google/pytype type-checker complained that
> > _config wasn't initialized. With this, kunit_tool now type checks
> > under both pytype and mypy.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
> >  tools/testing/kunit/kunit.py        | 20 ++++----------------
> >  tools/testing/kunit/kunit_kernel.py | 19 +++++++------------
> >  2 files changed, 11 insertions(+), 28 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> > index 08951a114654..b58fb3733cfa 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -256,10 +256,7 @@ def main(argv, linux=None):
> >                         os.mkdir(cli_args.build_dir)
> >
> >                 if not linux:
> > -                       linux = kunit_kernel.LinuxSourceTree()
> > -
> > -               linux.create_kunitconfig(cli_args.build_dir)
> > -               linux.read_kunitconfig(cli_args.build_dir)
> > +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
> >
> >                 request = KunitRequest(cli_args.raw_output,
> >                                        cli_args.timeout,
> > @@ -277,10 +274,7 @@ def main(argv, linux=None):
> >                         os.mkdir(cli_args.build_dir)
> >
> >                 if not linux:
> > -                       linux = kunit_kernel.LinuxSourceTree()
> > -
> > -               linux.create_kunitconfig(cli_args.build_dir)
> > -               linux.read_kunitconfig(cli_args.build_dir)
> > +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
> >
> >                 request = KunitConfigRequest(cli_args.build_dir,
> >                                              cli_args.make_options)
> > @@ -292,10 +286,7 @@ def main(argv, linux=None):
> >                         sys.exit(1)
> >         elif cli_args.subcommand == 'build':
> >                 if not linux:
> > -                       linux = kunit_kernel.LinuxSourceTree()
> > -
> > -               linux.create_kunitconfig(cli_args.build_dir)
> > -               linux.read_kunitconfig(cli_args.build_dir)
> > +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
> >
> >                 request = KunitBuildRequest(cli_args.jobs,
> >                                             cli_args.build_dir,
> > @@ -309,10 +300,7 @@ def main(argv, linux=None):
> >                         sys.exit(1)
> >         elif cli_args.subcommand == 'exec':
> >                 if not linux:
> > -                       linux = kunit_kernel.LinuxSourceTree()
> > -
> > -               linux.create_kunitconfig(cli_args.build_dir)
> > -               linux.read_kunitconfig(cli_args.build_dir)
> > +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
> >
> >                 exec_request = KunitExecRequest(cli_args.timeout,
> >                                                 cli_args.build_dir,
> > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > index bda7c4fd4d3e..79793031d2c4 100644
> > --- a/tools/testing/kunit/kunit_kernel.py
> > +++ b/tools/testing/kunit/kunit_kernel.py
> > @@ -129,10 +129,15 @@ def get_outfile_path(build_dir) -> str:
> >  class LinuxSourceTree(object):
> >         """Represents a Linux kernel source tree with KUnit tests."""
> >
> > -       def __init__(self) -> None:
> > -               self._ops = LinuxSourceTreeOperations()
> > +       def __init__(self, build_dir: str, defconfig=DEFAULT_KUNITCONFIG_PATH) -> None:
> >                 signal.signal(signal.SIGINT, self.signal_handler)
> >
> > +               self._ops = LinuxSourceTreeOperations()
> > +
> > +               kunitconfig_path = get_kunitconfig_path(build_dir)
> > +               self._kconfig = kunit_config.Kconfig()
> > +               self._kconfig.read_from_file(kunitconfig_path)
> > +
> >         def clean(self) -> bool:
> >                 try:
> >                         self._ops.make_mrproper()
> > @@ -141,16 +146,6 @@ class LinuxSourceTree(object):
> >                         return False
> >                 return True
> >
> > -       def create_kunitconfig(self, build_dir, defconfig=DEFAULT_KUNITCONFIG_PATH) -> None:
> > -               kunitconfig_path = get_kunitconfig_path(build_dir)
> > -               if not os.path.exists(kunitconfig_path):
> > -                       shutil.copyfile(defconfig, kunitconfig_path)
> > -
>
> What happened to create_kunitconfig() here? With this patch, I can no
> longer run .../kunit.py run with an empty build_dir and get results,
> instead getting:
> ---
> Traceback (most recent call last):
>  File "./tools/testing/kunit/kunit.py", line 336, in <module>
>    main(sys.argv[1:])
>  File "./tools/testing/kunit/kunit.py", line 259, in main
>    linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
>  File "./tools/testing/kunit/kunit_kernel.py", line 139, in __init__
>    self._kconfig.read_from_file(kunitconfig_path)
>  File "./tools/testing/kunit/kunit_config.py", line 89, in read_from_file
>    with open(path, 'r') as f:
> FileNotFoundError: [Errno 2] No such file or directory: 'asdf/.kunitconfig'
> ---
>
> Prior to this change, the defconfig is copied over, and the kernel is
> built, tests run succesfully.
>
>
> > -       def read_kunitconfig(self, build_dir) -> None:
> > -               kunitconfig_path = get_kunitconfig_path(build_dir)
> > -               self._kconfig = kunit_config.Kconfig()
> > -               self._kconfig.read_from_file(kunitconfig_path)
> > -
> >         def validate_config(self, build_dir) -> bool:
> >                 kconfig_path = get_kconfig_path(build_dir)
> >                 validated_kconfig = kunit_config.Kconfig()
> > --
> > 2.29.2.576.ga3fc446d84-goog
> >
