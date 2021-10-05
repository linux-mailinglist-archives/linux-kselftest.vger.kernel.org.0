Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2768421B6C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 03:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhJEBKm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Oct 2021 21:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhJEBKm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Oct 2021 21:10:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDA3C061745
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Oct 2021 18:08:52 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v25so23363658wra.2
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Oct 2021 18:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlXIOA8cnA3mtXiZEUOvasWxQMcXXZ6+gQS85Trl9kg=;
        b=e5j/jefjr2innilKbb2wPU640Kx8t8wSTBMzeOv3ra2R1PY5cews4ZjIIqsvRd2TIO
         a2Nx0ail20Jd15Cau3EMajfv6f4pgOzyQphPEUbCY+W9pBbB33UIjo88X4GEf87+UwiY
         GCLorXYN+v0Zg3ocSa08nbPPNe6gKiw3PqH/DoOrO8yvX1yugQuQe0kNVRCu50EFlv2q
         a6tKQH1cfsWeWx+Egm0WcaCcuKjDbOhWHM94h2JSsgQf9kRpqF7Ytxum7iX/Db3k1KLd
         zx3KVOyDTWn4e1MugL/zz5IWmDsnpbsurrHOQLNBaGnIyds8gEzqkdk584ziBEMs08tg
         QThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlXIOA8cnA3mtXiZEUOvasWxQMcXXZ6+gQS85Trl9kg=;
        b=A08wycr3h5jWjLkBWb3RfWIUD1W371ZeusG/4kGcZsavRgGHoR4yycwwN8V5IdKQfY
         r4lYPG4wy1Ur7o8kUKWbl6ZfmyvCknPr7nMQhwMExQ0Y8nBo0hRLRHsXC+HAXRr8MFEx
         E177GSOfewT/n1WTr9UraBj0Aqk7cXpNDYkkvJOSiV1PYHrrAa4/NVvZSWVBwJt6e1tU
         aoAMoplmt46AYonJlnw35f5/N3lk01WQod7RuL6tWOd0sglbCMLZzW+hh8AcL8vJEOmp
         pIb44ueilHrz227s60uJgCvVkRMQJ0uwCM1KjCbR4Ts4PhbK7iJTEqjpNqym1qxRgdxa
         Lq0Q==
X-Gm-Message-State: AOAM533XD343p2jwWP+cfIg5kEAixPBqgXtMjE/Erzbq1WNDUIEJvplx
        VE4B2K7AYC2jTbQpjFS4zcaVYmVGBCo9zsd1lIKjoQ==
X-Google-Smtp-Source: ABdhPJxh68TX7qgLnyoHIH21tT9vFp02VI3kizAsopH+bpUvIDx5C78ILtMiBAAlFfjuDLQ1wGwwYnXHMBUkKfKMPo4=
X-Received: by 2002:adf:f6c7:: with SMTP id y7mr17944187wrp.44.1633396130645;
 Mon, 04 Oct 2021 18:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211004170102.2522514-1-dlatypov@google.com> <CABVgOS=LsVTvX-RnsfE775fnq4aGQt7SUCeRpBpEd03My99NTQ@mail.gmail.com>
 <CAGS_qxpzB0r1piC9S1z9vWy-2Dz=frfN0uK-UAar6i+zvtjdjg@mail.gmail.com>
 <CABVgOS==C7r+9JAV5+NcCqgCdqdYy+Yyr8ht7RUVwrpAmqR1vg@mail.gmail.com> <CAGS_qxpo0xLYWzUib6drELbE-PvbwmaB80Y25H2_S5KOGeW7iA@mail.gmail.com>
In-Reply-To: <CAGS_qxpo0xLYWzUib6drELbE-PvbwmaB80Y25H2_S5KOGeW7iA@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 5 Oct 2021 09:08:39 +0800
Message-ID: <CABVgOSnXBtCHEMDYYqrbXWvKcrSbY9BXP4MJjsT+vzZS6W4J=w@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: yield output from run_kernel in real time
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 5, 2021 at 8:36 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Mon, Oct 4, 2021 at 4:58 PM David Gow <davidgow@google.com> wrote:
> >
> > On Tue, Oct 5, 2021 at 7:46 AM Daniel Latypov <dlatypov@google.com> wrote:
> > >
> > > On Mon, Oct 4, 2021 at 4:34 PM 'David Gow' via KUnit Development
> > > <kunit-dev@googlegroups.com> wrote:
> > > >
> > > > On Tue, Oct 5, 2021 at 1:01 AM Daniel Latypov <dlatypov@google.com> wrote:
> > > > >
> > > > > Currently, `run_kernel()` dumps all the kernel output to a file
> > > > > (.kunit/test.log) and then opens the file and yields it to callers.
> > > > > This made it easier to respect the requested timeout, if any.
> > > > >
> > > > > But it means that we can't yield the results in real time, either to the
> > > > > parser or to stdout (if --raw_output is set).
> > > > >
> > > > > This change spins up a background thread to enforce the timeout, which
> > > > > allows us to yield the kernel output in real time, while also copying it
> > > > > to the .kunit/test.log file.
> > > > > It's also careful to ensure that the .kunit/test.log file is complete,
> > > > > even in the kunit_parser throws an exception/otherwise doesn't consume
> > > > > every line, see the new `finally` block and unit test.
> > > > >
> > > > > For example:
> > > > >
> > > > > $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --raw_output
> > > > > <configure + build steps>
> > > > > ...
> > > > > <can now see output from QEMU in real time>
> > > > >
> > > > > This does not currently have a visible effect when --raw_output is not
> > > > > passed, as kunit_parser.py currently only outputs everything at the end.
> > > > > But that could change, and this patch is a necessary step towards
> > > > > showing parsed test results in real time.
> > > > >
> > > > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > > > ---
> > > > >  tools/testing/kunit/kunit_kernel.py    | 73 +++++++++++++++-----------
> > > > >  tools/testing/kunit/kunit_tool_test.py | 17 ++++++
> > > > >  2 files changed, 60 insertions(+), 30 deletions(-)
> > > > >
> > > > > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > > > > index 2c6f916ccbaf..b8cba8123aa3 100644
> > > > > --- a/tools/testing/kunit/kunit_kernel.py
> > > > > +++ b/tools/testing/kunit/kunit_kernel.py
> > > > > @@ -12,7 +12,8 @@ import subprocess
> > > > >  import os
> > > > >  import shutil
> > > > >  import signal
> > > > > -from typing import Iterator, Optional, Tuple
> > > > > +import threading
> > > > > +from typing import Iterator, List, Optional, Tuple
> > > > >
> > > > >  from contextlib import ExitStack
> > > > >
> > > > > @@ -103,8 +104,8 @@ class LinuxSourceTreeOperations(object):
> > > > >                 if stderr:  # likely only due to build warnings
> > > > >                         print(stderr.decode())
> > > > >
> > > > > -       def run(self, params, timeout, build_dir, outfile) -> None:
> > > > > -               pass
> > > > > +       def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
> > > > > +               raise RuntimeError('not implemented!')
> > > > >
> > > > >
> > > > >  class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
> > > > > @@ -123,7 +124,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
> > > > >                 kconfig.parse_from_string(self._kconfig)
> > > > >                 base_kunitconfig.merge_in_entries(kconfig)
> > > > >
> > > > > -       def run(self, params, timeout, build_dir, outfile):
> > > > > +       def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
> > > > >                 kernel_path = os.path.join(build_dir, self._kernel_path)
> > > > >                 qemu_command = ['qemu-system-' + self._qemu_arch,
> > > > >                                 '-nodefaults',
> > > > > @@ -134,18 +135,10 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
> > > > >                                 '-nographic',
> > > > >                                 '-serial stdio'] + self._extra_qemu_params
> > > > >                 print('Running tests with:\n$', ' '.join(qemu_command))
> > > > > -               with open(outfile, 'w') as output:
> > > > > -                       process = subprocess.Popen(' '.join(qemu_command),
> > > > > -                                                  stdin=subprocess.PIPE,
> > > > > -                                                  stdout=output,
> > > > > -                                                  stderr=subprocess.STDOUT,
> > > > > -                                                  text=True, shell=True)
> > > > > -               try:
> > > > > -                       process.wait(timeout=timeout)
> > > > > -               except Exception as e:
> > > > > -                       print(e)
> > > > > -                       process.terminate()
> > > > > -               return process
> > > > > +               return subprocess.Popen(' '.join(qemu_command),
> > > > > +                                          stdout=subprocess.PIPE,
> > > > > +                                          stderr=subprocess.STDOUT,
> > > > > +                                          text=True, shell=True)
> > > > >
> > > > >  class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
> > > > >         """An abstraction over command line operations performed on a source tree."""
> > > > > @@ -175,17 +168,13 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
> > > > >                 kunit_parser.print_with_timestamp(
> > > > >                         'Starting Kernel with all configs takes a few minutes...')
> > > > >
> > > > > -       def run(self, params, timeout, build_dir, outfile):
> > > > > +       def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
> > > > >                 """Runs the Linux UML binary. Must be named 'linux'."""
> > > > >                 linux_bin = get_file_path(build_dir, 'linux')
> > > > > -               outfile = get_outfile_path(build_dir)
> > > > > -               with open(outfile, 'w') as output:
> > > > > -                       process = subprocess.Popen([linux_bin] + params,
> > > > > -                                                  stdin=subprocess.PIPE,
> > > >
> > > > This breaks --raw_output under UML for me. Including the
> > > > stdin=subprocess.PIPE again seems to fix it.
> > >
> > > Can you give an example of what it does?
> > >
> > > I don't see any issues with --raw_output under UML with the patch as-is.
> > > I was mainly testing this with UML, and I must have ran it some 10s of
> > > times, so I'm a bit surprised.
> > >
> > > On an earlier version, I saw some mangling of --raw_output (\n was
> > > missing), but that went away after some revisions.
> > >
> >
> > Yeah, that's the sort of thing I'm seeing: \n being treated as just a
> > new line (without the carriage return).
> > It happens pretty consistently, though sometimes the text wraps and
> > sometimes (well, once) everything gets forced into the last column of
> > the terminal. I've not been able to get it to work at all without
> > having stdin be subprocess.PIPE.
>
> I can't repro in the shell I was using while writing this.
> Starting up a new session, I get:
> * good
> * bad x3
> * good
> * bad x3
> * good
> * bad x3
> * bad, but not as bad (phew, I thought this was cursed)
>
> .kunit/test.log contains the output with proper \n each time I checked.
>
> Doesn't seem to repro when redirected into a file:
>
> $ ./tools/testing/kunit/kunit.py exec --raw_output > /tmp/out && diff
> /tmp/out .kunit/test.log | grep -m1 '^>'
>
> Piping it through cat also seems 100% fine:
> $ ./tools/testing/kunit/kunit.py exec --raw_output | cat
>
> So having stdin be subprocess.PIPE sorta makes sense in some twisted way.
> I can also now repro that setting stdin=subprocess.PIPE seems to fix it.
>
> I don't want to put back subprocess.PIPE, but I'm not confident in
> being able to find a better solution...

So it turns out that there are a few issues with UML assuming stdin ==
stdout (or at least that stdin and stdout are related), as seen in
this ongoing thread on linux-um:
http://lists.infradead.org/pipermail/linux-um/2021-October/001805.html

Some of the coments in UML's chan_user.c seem pretty related, too, in
that termios is used to set this weird
"mostly-raw-but-\n-includes-carriage-returns" mode:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/um/drivers/chan_user.c#n90

My theory is that UML sets "raw" mode based on what stdin is, then
only sets OPOST if stdout is a tty, so there's a mismatch here. So,
probably this is fundamentally a UML bug, but worth us working around
in it kunit_tool for the time being. That being said, I've not been
able to find anything obviously stdin-y setting raw mode thus far, so
I could be wrong.

My preference is that we put stdin=subprocess.PIPE back for now, since
we don't want a regression, and if a cause in UML is found and fixed,
we can remove it after the fix has propagated comfortably everywhere.

-- David

>
> >
> > It occurs both under tmux and not, and under Konsole and xterm, so it
> > doesn't appear to be specific to any given terminal implementation.
> > Still occurs even after running 'reset', and with a clean build.
> > QEMU-based --raw_output works fine.
> >
> >
