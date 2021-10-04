Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9643421AD5
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 01:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhJDXsV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Oct 2021 19:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbhJDXsV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Oct 2021 19:48:21 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EA5C061745
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Oct 2021 16:46:31 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id l13so3341239ilo.3
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Oct 2021 16:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cCJUyDuTo6cc6p6t+R2HZjNaq1xogpnsbFLH5davQoI=;
        b=XvIgffr7PyZCMbQmezfCZpSmGg+MgmaIqqPyEkLBHninyVdLsp1GdOX4N4T93gEFDD
         4X5wK9xkm/hGysrJHJ8UeyDFWWeKUN/uW/ungertQ4ojIm98TrYRd09MWMck0lnEd+iS
         7v6SIavC1+oip032ST9fAmOpAZrNK3LdqGehbZPBHjjv4fom+xD9h0Cfb6UWVtjblTZB
         6yE2Rt0Z3OjqZRHlcKLabkU8YHM3+E+SF5eGfSLGAvkZaMM0oR8sXGFLKwBcz0Q3uIrh
         AbjtzyKXlVmto74XIvIloHoAy22f9UIk7uWwgW12+9B1C83VveXyEpP1Uo+DZGvGZfgK
         ToGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCJUyDuTo6cc6p6t+R2HZjNaq1xogpnsbFLH5davQoI=;
        b=3MrXAgyu9OFGDmvynDs+PgKcqhVE1Ws0EohBZgXuxihc+WmmD8beka4OB4FTlnBvDl
         T/1VFeazL1BpWmzlkYQvvX8I1nEDY2uWzxcwp1eyEfyz2ZcMrAfdzdx9EOJdTGE7fcHf
         agHL35S3aOa0pDbyTZT9svPLMk8Pnl9J5I8+xy8P/W0KPniZ0PxEte9ugsHwd0P9K8au
         jXcARmi34Sg/IaL/vVu7OXn+46jHexYwLpqULbchbiS83SF3mkdpJD1tnTapfxoQnmuV
         h6eWPfulvn7RQMzn4cP3DQnGfsmfxWOiGyXiy01xgmIi3FukLuE895tqJxjInEYGcAbY
         NyIQ==
X-Gm-Message-State: AOAM530kAuCmIMegrU6epnslSZHz0kexH4h+GVZybwZaAed96gG/rCAZ
        bivZKEZqrgaz4kPH5dKYpFrmZxqDmxBu3lKEX6l5WQ==
X-Google-Smtp-Source: ABdhPJwr6alGFwdkEBeQLFntcOZU90q4BHd+BFMD4hHRJM45qnMYovn7sbk/QfPrbZS9kp5dy5br0QX55WeFgsKpeT4=
X-Received: by 2002:a05:6e02:12e6:: with SMTP id l6mr569942iln.293.1633391190713;
 Mon, 04 Oct 2021 16:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211004170102.2522514-1-dlatypov@google.com> <CABVgOS=LsVTvX-RnsfE775fnq4aGQt7SUCeRpBpEd03My99NTQ@mail.gmail.com>
In-Reply-To: <CABVgOS=LsVTvX-RnsfE775fnq4aGQt7SUCeRpBpEd03My99NTQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 4 Oct 2021 16:46:18 -0700
Message-ID: <CAGS_qxpzB0r1piC9S1z9vWy-2Dz=frfN0uK-UAar6i+zvtjdjg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: yield output from run_kernel in real time
To:     David Gow <davidgow@google.com>
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

On Mon, Oct 4, 2021 at 4:34 PM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Tue, Oct 5, 2021 at 1:01 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Currently, `run_kernel()` dumps all the kernel output to a file
> > (.kunit/test.log) and then opens the file and yields it to callers.
> > This made it easier to respect the requested timeout, if any.
> >
> > But it means that we can't yield the results in real time, either to the
> > parser or to stdout (if --raw_output is set).
> >
> > This change spins up a background thread to enforce the timeout, which
> > allows us to yield the kernel output in real time, while also copying it
> > to the .kunit/test.log file.
> > It's also careful to ensure that the .kunit/test.log file is complete,
> > even in the kunit_parser throws an exception/otherwise doesn't consume
> > every line, see the new `finally` block and unit test.
> >
> > For example:
> >
> > $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --raw_output
> > <configure + build steps>
> > ...
> > <can now see output from QEMU in real time>
> >
> > This does not currently have a visible effect when --raw_output is not
> > passed, as kunit_parser.py currently only outputs everything at the end.
> > But that could change, and this patch is a necessary step towards
> > showing parsed test results in real time.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
> >  tools/testing/kunit/kunit_kernel.py    | 73 +++++++++++++++-----------
> >  tools/testing/kunit/kunit_tool_test.py | 17 ++++++
> >  2 files changed, 60 insertions(+), 30 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > index 2c6f916ccbaf..b8cba8123aa3 100644
> > --- a/tools/testing/kunit/kunit_kernel.py
> > +++ b/tools/testing/kunit/kunit_kernel.py
> > @@ -12,7 +12,8 @@ import subprocess
> >  import os
> >  import shutil
> >  import signal
> > -from typing import Iterator, Optional, Tuple
> > +import threading
> > +from typing import Iterator, List, Optional, Tuple
> >
> >  from contextlib import ExitStack
> >
> > @@ -103,8 +104,8 @@ class LinuxSourceTreeOperations(object):
> >                 if stderr:  # likely only due to build warnings
> >                         print(stderr.decode())
> >
> > -       def run(self, params, timeout, build_dir, outfile) -> None:
> > -               pass
> > +       def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
> > +               raise RuntimeError('not implemented!')
> >
> >
> >  class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
> > @@ -123,7 +124,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
> >                 kconfig.parse_from_string(self._kconfig)
> >                 base_kunitconfig.merge_in_entries(kconfig)
> >
> > -       def run(self, params, timeout, build_dir, outfile):
> > +       def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
> >                 kernel_path = os.path.join(build_dir, self._kernel_path)
> >                 qemu_command = ['qemu-system-' + self._qemu_arch,
> >                                 '-nodefaults',
> > @@ -134,18 +135,10 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
> >                                 '-nographic',
> >                                 '-serial stdio'] + self._extra_qemu_params
> >                 print('Running tests with:\n$', ' '.join(qemu_command))
> > -               with open(outfile, 'w') as output:
> > -                       process = subprocess.Popen(' '.join(qemu_command),
> > -                                                  stdin=subprocess.PIPE,
> > -                                                  stdout=output,
> > -                                                  stderr=subprocess.STDOUT,
> > -                                                  text=True, shell=True)
> > -               try:
> > -                       process.wait(timeout=timeout)
> > -               except Exception as e:
> > -                       print(e)
> > -                       process.terminate()
> > -               return process
> > +               return subprocess.Popen(' '.join(qemu_command),
> > +                                          stdout=subprocess.PIPE,
> > +                                          stderr=subprocess.STDOUT,
> > +                                          text=True, shell=True)
> >
> >  class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
> >         """An abstraction over command line operations performed on a source tree."""
> > @@ -175,17 +168,13 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
> >                 kunit_parser.print_with_timestamp(
> >                         'Starting Kernel with all configs takes a few minutes...')
> >
> > -       def run(self, params, timeout, build_dir, outfile):
> > +       def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
> >                 """Runs the Linux UML binary. Must be named 'linux'."""
> >                 linux_bin = get_file_path(build_dir, 'linux')
> > -               outfile = get_outfile_path(build_dir)
> > -               with open(outfile, 'w') as output:
> > -                       process = subprocess.Popen([linux_bin] + params,
> > -                                                  stdin=subprocess.PIPE,
>
> This breaks --raw_output under UML for me. Including the
> stdin=subprocess.PIPE again seems to fix it.

Can you give an example of what it does?

I don't see any issues with --raw_output under UML with the patch as-is.
I was mainly testing this with UML, and I must have ran it some 10s of
times, so I'm a bit surprised.

On an earlier version, I saw some mangling of --raw_output (\n was
missing), but that went away after some revisions.

>
> > -                                                  stdout=output,
> > -                                                  stderr=subprocess.STDOUT,
> > -                                                  text=True)
> > -                       process.wait(timeout)
> > +               return subprocess.Popen([linux_bin] + params,
> > +                                          stdout=subprocess.PIPE,
> > +                                          stderr=subprocess.STDOUT,
> > +                                          text=True)
> >
> >  def get_kconfig_path(build_dir) -> str:
> >         return get_file_path(build_dir, KCONFIG_PATH)
> > @@ -330,12 +319,36 @@ class LinuxSourceTree(object):
> >                 args.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
> >                 if filter_glob:
> >                         args.append('kunit.filter_glob='+filter_glob)
> > -               outfile = get_outfile_path(build_dir)
> > -               self._ops.run(args, timeout, build_dir, outfile)
> > -               subprocess.call(['stty', 'sane'])
> > -               with open(outfile, 'r') as file:
> > -                       for line in file:
> > +
> > +               process = self._ops.start(args, build_dir)
> > +               assert process.stdout is not None  # tell mypy it's set
> > +
> > +               # Enforce the timeout in a background thread.
> > +               def _wait_proc():
> > +                       try:
> > +                               process.wait(timeout=timeout)
> > +                       except Exception as e:
> > +                               print(e)
> > +                               process.terminate()
> > +                               process.wait()
> > +               waiter = threading.Thread(target=_wait_proc)
> > +               waiter.start()
> > +
> > +               output = open(get_outfile_path(build_dir), 'w')
> > +               try:
> > +                       # Tee the output to the file and to our caller in real time.
> > +                       for line in process.stdout:
> > +                               output.write(line)
> >                                 yield line
> > +               # This runs even if our caller doesn't consume every line.
> > +               finally:
> > +                       # Flush any leftover output to the file
> > +                       output.write(process.stdout.read())
> > +                       output.close()
> > +                       process.stdout.close()
> > +
> > +                       waiter.join()
> > +                       subprocess.call(['stty', 'sane'])
> >
> >         def signal_handler(self, sig, frame) -> None:
> >                 logging.error('Build interruption occurred. Cleaning console.')
> > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> > index 619c4554cbff..f9a7398a9584 100755
> > --- a/tools/testing/kunit/kunit_tool_test.py
> > +++ b/tools/testing/kunit/kunit_tool_test.py
> > @@ -14,6 +14,7 @@ import tempfile, shutil # Handling test_tmpdir
> >  import itertools
> >  import json
> >  import signal
> > +import subprocess
> >  import os
> >
> >  import kunit_config
> > @@ -291,6 +292,22 @@ class LinuxSourceTreeTest(unittest.TestCase):
> >                                 pass
> >                         tree = kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
> >
> > +       def test_run_kernel_hits_exception(self):
> > +               def fake_start(unused_args, unused_build_dir):
> > +                       return subprocess.Popen(['echo "hi\nbye"'], shell=True, text=True, stdout=subprocess.PIPE)
> > +
> > +               with tempfile.TemporaryDirectory('') as build_dir:
> > +                       tree = kunit_kernel.LinuxSourceTree(build_dir, load_config=False)
> > +                       mock.patch.object(tree._ops, 'start', side_effect=fake_start).start()
> > +
> > +                       with self.assertRaises(ValueError):
> > +                               for line in tree.run_kernel(build_dir=build_dir):
> > +                                       self.assertEqual(line, 'hi\n')
> > +                                       raise ValueError('uh oh, did not read all output')
> > +
> > +                       with open(kunit_kernel.get_outfile_path(build_dir), 'rt') as outfile:
> > +                               self.assertEqual(outfile.read(), 'hi\nbye\n', msg='Missing some output')
> > +
> >         # TODO: add more test cases.
> >
> >
> >
> > base-commit: 3b29021ddd10cfb6b2565c623595bd3b02036f33
> > --
> > 2.33.0.800.g4c38ced690-goog
> >
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/CABVgOS%3DLsVTvX-RnsfE775fnq4aGQt7SUCeRpBpEd03My99NTQ%40mail.gmail.com.
