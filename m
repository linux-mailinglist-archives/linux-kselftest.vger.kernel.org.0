Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E74FD117D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 16:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbfJIOlL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Oct 2019 10:41:11 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40086 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbfJIOlL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Oct 2019 10:41:11 -0400
Received: by mail-qk1-f195.google.com with SMTP id y144so2425794qkb.7
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Oct 2019 07:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5mWAIekQxCJRutIz3kxdljirr7ZNQzHVpU/Nup5Odw=;
        b=PCx/45cE38DolyXNRf6C3LkD1LCXEOYr26qpnCFjrjMj+lWW/q7VRhUYdQ6T7rsUP2
         lLmnt56b6E8s8SJV0w0DfFr5bpZQf+nGlGxl05DxzL5rSZ0HLSMPmxDvHIhZ/UoVht9E
         bHh1TrBkgOvgpwcSS4gfvihMXL1WGeklyQvH0n+/cJ07zaY+MvQs1TmcUZNHBP9s0w7a
         JgypRfjPXvK1TxIHBw4/6q5JN0ET2BJrkUZQF750/zQj6OAw2QGNx90vrT57cpByf6Ud
         LVZi9c1FvctGMpT7ANawTW1Bea/QMffPF/6tl24FjAWhhfvdkKESKxNxJegXJfTByysZ
         pVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5mWAIekQxCJRutIz3kxdljirr7ZNQzHVpU/Nup5Odw=;
        b=VFti9P0KW+Oqtc0UO6nioY50X0hpricFs1dnIV8d2RRomg+1zlSVC16vaxCKcUScSk
         hc7S/iQJdUVIxaT4f7fQzSDBx7aVhniChjzYUztMydp/BFZI5NnlGZtAPxdUkuq2x+vU
         C64tJ3kk3iwXB73HAVs3vDzC/ai4O7l5+Nxv5LYA4YEGlV1oGnzXjYwZDRmWz7cUBbAc
         dFp1GBcKqB4rGPtNdgm/DGYaYq7bWZoV6/kEJmtXw08+UQ7URXS4U1jSJ3QAADAyrHOG
         pZ6L6Snd7cmlQuzvc82QUC2oOL48DoTTYtbkfHu5HBM6HSPY0/1aDSBnESOsc9RG9U4T
         xAmg==
X-Gm-Message-State: APjAAAWOqbkCQnywpfacT9DGBLF+kEr2EiM1xBjz0Od9QT/9TEqLYHBQ
        OdHuZ8BT1DLkBdrLUvzea8sNR7IZ4gQdj5+rTob9qA==
X-Google-Smtp-Source: APXvYqzLzgmiFj63SLEzmkD8UGX/19GGegnRxIMrRpNhnUdITp4U2ha3+AamWVWqG3pjWy9w6/PdIq2XzsjGfBy5dJM=
X-Received: by 2002:a37:65d0:: with SMTP id z199mr3576929qkb.407.1570632069499;
 Wed, 09 Oct 2019 07:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191009142446.6997-1-rpalethorpe@suse.com>
In-Reply-To: <20191009142446.6997-1-rpalethorpe@suse.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 9 Oct 2019 16:40:56 +0200
Message-ID: <CACT4Y+b0tTAQ0r_2gCVjjRh--Xwv=aLzh6MY=ciXMMrK+cAQsA@mail.gmail.com>
Subject: Re: [RFC PATCH] LTP Wrapper for Syzkaller reproducers
To:     Richard Palethorpe <rpalethorpe@suse.com>
Cc:     ltp@lists.linux.it, syzkaller <syzkaller@googlegroups.com>,
        kernelci@groups.io,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org, shuah <shuah@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>, chrubis@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 9, 2019 at 4:26 PM Richard Palethorpe <rpalethorpe@suse.com> wrote:
>
> First attempt at wrapping the Syzkaller reproducers in the LTP library. I am
> posting this in case anyone wants to experiment with it early or has a
> radically different approach in mind.
>
> This just uses exec to run the reproducer executables as per Metan's
> suggestion. There is a simple script which creates a runtest file allowing it
> to work with existing LTP test runners, albeit with a bit of extra work for
> now.
>
> This would benefit from the following LTP library patch:
> https://patchwork.ozlabs.org/patch/935568/
>
> Running it without KASAN and the other kernel debugging options is not a good
> idea. We can easily detect when the kernel config is wrong and print a
> warning or even refuse to run, but I haven't added it yet.
>
> Having to download, compile and install the reproducers seperately is annoying
> and I bet most users won't do it. We can probably automate that as part of the
> install, it is just a question of how much we do as default.
>
> ---
>  runtest/.gitignore                            |  1 +
>  testcases/kernel/Makefile                     |  1 +
>  testcases/kernel/syzkaller-repros/.gitignore  |  1 +
>  testcases/kernel/syzkaller-repros/Makefile    | 10 +++
>  testcases/kernel/syzkaller-repros/README.md   | 39 +++++++++
>  .../kernel/syzkaller-repros/gen-runtest.sh    |  8 ++
>  testcases/kernel/syzkaller-repros/syzwrap.c   | 85 +++++++++++++++++++
>  7 files changed, 145 insertions(+)
>  create mode 100644 runtest/.gitignore
>  create mode 100644 testcases/kernel/syzkaller-repros/.gitignore
>  create mode 100644 testcases/kernel/syzkaller-repros/Makefile
>  create mode 100644 testcases/kernel/syzkaller-repros/README.md
>  create mode 100755 testcases/kernel/syzkaller-repros/gen-runtest.sh
>  create mode 100644 testcases/kernel/syzkaller-repros/syzwrap.c
>
> diff --git a/runtest/.gitignore b/runtest/.gitignore
> new file mode 100644
> index 000000000..e3725dd42
> --- /dev/null
> +++ b/runtest/.gitignore
> @@ -0,0 +1 @@
> +syzkaller-repros
> diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
> index 3319b3163..0150cfb4f 100644
> --- a/testcases/kernel/Makefile
> +++ b/testcases/kernel/Makefile
> @@ -53,6 +53,7 @@ SUBDIRS                       += connectors \
>                            sched \
>                            security \
>                            sound \
> +                          syzkaller-repros \
>                            tracing \
>                            uevents \
>
> diff --git a/testcases/kernel/syzkaller-repros/.gitignore b/testcases/kernel/syzkaller-repros/.gitignore
> new file mode 100644
> index 000000000..dbda1c71f
> --- /dev/null
> +++ b/testcases/kernel/syzkaller-repros/.gitignore
> @@ -0,0 +1 @@
> +syzwrap
> diff --git a/testcases/kernel/syzkaller-repros/Makefile b/testcases/kernel/syzkaller-repros/Makefile
> new file mode 100644
> index 000000000..8e74805c2
> --- /dev/null
> +++ b/testcases/kernel/syzkaller-repros/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2019 Linux Test Project
> +
> +top_srcdir             ?= ../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +CFLAGS                 += -D_GNU_SOURCE
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syzkaller-repros/README.md b/testcases/kernel/syzkaller-repros/README.md
> new file mode 100644
> index 000000000..e95ae19e2
> --- /dev/null
> +++ b/testcases/kernel/syzkaller-repros/README.md
> @@ -0,0 +1,39 @@
> +LTP wrapper for Syzkaller reproducers
> +=====================================
> +
> +This allows you to run the autogenerated bug reproducers from the Syzkaller
> +fuzzer within the LTP framework. Meaning that you may use an existing test
> +runner compatible with the LTP.
> +
> +However some extra setup is currently required.
> +
> +Instructions
> +------------
> +
> +1. Download and compile the reproducers.
> +2. Build the LTP as normal
> +3. Use the gen-runtest.sh script to create a runtest file
> +4. Install the LTP and the reproducers to the SUT
> +5. Execute the tests in the syzkaller-repros runtest file
> +
> +For now you can download the reproducers from here:
> +https://github.com/dvyukov/syzkaller-repros. Soon they will be available on
> +kernel.org.
> +
> +The gen-runtest takes two arguments:
> +
> +1. The directory where the reproducer executables are currently accessible
> +2. The *absolute* path to the directory where they will be on the SUT (If
> +   different, can be omitted)
> +
> +For example:
> +```
> +./gen-runtest.sh ~/qa/syzkaller-repros/bin /mnt/syzkaller-repros/bin >
> +~/qa/ltp-build/runtest/syzkaller-repros
> +```
> +
> +For the LTP, just doing `make install` will copy all the relevant files
> +(assuming you put the runtest file in the runtest folder). However you will
> +need to copy the reproducers yourself.
> +
> +
> diff --git a/testcases/kernel/syzkaller-repros/gen-runtest.sh b/testcases/kernel/syzkaller-repros/gen-runtest.sh
> new file mode 100755
> index 000000000..091818fb2
> --- /dev/null
> +++ b/testcases/kernel/syzkaller-repros/gen-runtest.sh
> @@ -0,0 +1,8 @@
> +#!/usr/bin/sh
> +
> +BUILD_DIR=$1
> +SUT_DIR=$2
> +
> +for f in $(ls $BUILD_DIR); do
> +    echo $f syzwrap -d ${SUT_DIR:-$BUILD_DIR} -n $f
> +done
> diff --git a/testcases/kernel/syzkaller-repros/syzwrap.c b/testcases/kernel/syzkaller-repros/syzwrap.c
> new file mode 100644
> index 000000000..7951d1819
> --- /dev/null
> +++ b/testcases/kernel/syzkaller-repros/syzwrap.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
> + *
> + * Run a single reproducer generated by the Syzkaller fuzzer.
> + */
> +
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <signal.h>
> +#include <stdio.h>
> +
> +#include "tst_test.h"
> +#include "tst_taint.h"
> +#include "tst_safe_stdio.h"
> +
> +static char *dir;
> +static char *name;
> +static char *path;
> +
> +static struct tst_option options[] = {
> +       {"d:", &dir, "Mandatory directory containing reproducers"},
> +       {"n:", &name, "Mandatory executable name of reproducer"},
> +       {NULL, NULL, NULL}
> +};
> +
> +static void setup(void)
> +{
> +       tst_taint_init(TST_TAINT_W | TST_TAINT_D);
> +
> +       if (!dir)
> +               tst_brk(TBROK, "No reproducer directory specified");
> +
> +       if (!name)
> +               tst_brk(TBROK, "No reproducer name specified");
> +
> +       tst_res(TINFO, "https://syzkaller.appspot.com/bug?id=%s", name);
> +
> +       SAFE_ASPRINTF(&path, "%s/%s", dir, name);
> +       tst_res(TINFO, "%s", path);
> +}
> +
> +static void run(void)
> +{
> +       unsigned int backoff = 100;
> +       int rem, status, sent_kill = 0;
> +       float exec_time_start = (float)tst_timeout_remaining();
> +       int pid = SAFE_FORK();
> +
> +       if (!pid) {
> +               execle(path, name, environ);
> +               tst_brk(TBROK | TERRNO, "Failed to exec reproducer");
> +       }
> +
> +       while (!waitpid(pid, &status, WNOHANG)) {
> +               rem = tst_timeout_remaining();
> +
> +               if (!sent_kill && rem / exec_time_start < 0.98) {
> +                       tst_res(TINFO, "Timeout; killing reproducer");
> +
> +                       TEST(kill(pid, SIGKILL));
> +                       if (TST_RET == -1)
> +                               tst_res(TWARN | TTERRNO, "kill() failed");
> +                       else
> +                               sent_kill = 1;
> +               }
> +
> +               usleep(backoff);
> +               backoff = MIN(2 * backoff, 1000000);
> +       }
> +
> +       if (tst_taint_check()) {
> +               tst_res(TFAIL, "Kernel is tainted");
> +       } else {
> +               tst_res(TPASS, "Kernel is not tainted");
> +       }
> +}
> +
> +static struct tst_test test = {
> +       .setup = setup,
> +       .test_all = run,
> +       .options = options,
> +       .needs_tmpdir = 1,
> +       .forks_child = 1,
> +};

Hi Richard,

I don't have prior experience with LTP tests, but from reading the
code it looks reasonable to me.

I assume that .needs_tmpdir = 1 ensures that each test runs in its own
new temp dir, which is later removed.

I've stared for a while at "rem / exec_time_start < 0.98" trying to
understand what is that tst_timeout_remaining() returns that we want
to kill that process when the ratio is < 0.98... provided that we
convert 1 to float but not the other var. I failed to come up with the
answer. I have potential answers for "<0.02" and ">0.98". But I assume
you know what you are doing :)

Re tst_res(TINFO, "Timeout; killing reproducer"). Not sure how much it
pollutes output on 3000 tests. If it is, it can make sense to remove
it. Lots of tests run forever, killing it is not something of
particular interest generally.
