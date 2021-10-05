Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7D6421D11
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 05:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhJEEBe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 00:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhJEEBe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 00:01:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7DDC061749
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Oct 2021 20:59:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t2so11272575wrb.8
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Oct 2021 20:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PcUlJttku7eOqy41c+hVLHjFymIPTNrajpFHb1IvB0M=;
        b=TIfcnjsLRO8Zqp2g4bNA7/U66Yhr/l7h8fQJNIQ9LFXzs1XPMbjq1BtqExt4CfzXMx
         3VAjiTEQ2D0qMZP7Pj8BSEQQ4X63ZEiTS+tTtswscSewRFRbFSyBiH6Pb6QkizMmbPVh
         UNMl9IzOKeUjx6COAC/RQ/1xiGggC+yWGqdUehUEnaQcfrm1XUsWumEsgzL0kOCtsiZ1
         D4cIDgJpm6jw3RH1Mq4/lgnA3Qompsk54wOuWK56H3WgaGnl9EEhT6oAIf2Xi7iMYnLU
         8bLYnnW1JVcpZyFEsp7vmtwuz7o5rVRjUS8wL5fsX3ssW7yih7Qet84KT7fl8deyDFH9
         c6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PcUlJttku7eOqy41c+hVLHjFymIPTNrajpFHb1IvB0M=;
        b=XYPNAOiR+CqBnnSkAALPd6FuR0aA0rh6JEOV04mLF3V04OETF9C2UDvSL81Eax9zAF
         +pNaFbsV1JyhoIc1Ofw6u/3gRPxQISdU5cGnxyAfIhAMZ7A89wmVPnT44VS/fc+ek+2O
         S3z1xOEba20MdGyb6MCeWk7CtbNlX74+lJoFaQ3gtgz8QKmbafBWVq3YXxmLbNPKrlx9
         n8Z9a4Wp2sIVEulOqaVoF/sEes6IZMTT5e0rnUM2drpuhkJ0WNfdspnwUd5nywcL2Krq
         cupZIa7fBJVjshz/S/d6P6NCbW0qABP5hAOLE9Q8u9YsK3VInyZ54y0VYAP2YJiz8y6w
         K2JQ==
X-Gm-Message-State: AOAM533qWjhIvx6mcfz8TlR7sFve7sMjCrRBTSKC3DHiG4CD+5X04cyp
        liF5x05Wcyb4oAxQ6Nfk3eIAGdJwPn/XzmqZNMRGEg==
X-Google-Smtp-Source: ABdhPJwo+855f3UDu9ia0n34bccm7sNmkUSs41D1dAwHu9SXyrlOL1C+iFzYjpp0VUQTnIUgK6Rq1P9Tzf6Ge5QlXak=
X-Received: by 2002:adf:a152:: with SMTP id r18mr18930758wrr.317.1633406382494;
 Mon, 04 Oct 2021 20:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211005011340.2826268-1-dlatypov@google.com>
In-Reply-To: <20211005011340.2826268-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 5 Oct 2021 11:59:31 +0800
Message-ID: <CABVgOSmVZsGdRnvpX55+iK4ZqHACWA44MjacKgHb6gZE4WLPyg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: yield output from run_kernel in real time
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

On Tue, Oct 5, 2021 at 9:13 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently, `run_kernel()` dumps all the kernel output to a file
> (.kunit/test.log) and then opens the file and yields it to callers.
> This made it easier to respect the requested timeout, if any.
>
> But it means that we can't yield the results in real time, either to the
> parser or to stdout (if --raw_output is set).
>
> This change spins up a background thread to enforce the timeout, which
> allows us to yield the kernel output in real time, while also copying it
> to the .kunit/test.log file.
> It's also careful to ensure that the .kunit/test.log file is complete,
> even in the kunit_parser throws an exception/otherwise doesn't consume
> every line, see the new `finally` block and unit test.
>
> For example:
>
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --raw_output
> <configure + build steps>
> ...
> <can now see output from QEMU in real time>
>
> This does not currently have a visible effect when --raw_output is not
> passed, as kunit_parser.py currently only outputs everything at the end.
> But that could change, and this patch is a necessary step towards
> showing parsed test results in real time.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
> v1 -> v2: restore stdin=subprocess.PIPE to avoid a UML (?) bug.
> https://lore.kernel.org/linux-kselftest/CABVgOSnXBtCHEMDYYqrbXWvKcrSbY9BXP4MJjsT+vzZS6W4J=w@mail.gmail.com/
> ---

This looks good and works well here, thanks. This is particularly nice
with the slow time_test_cases:time64_to_tm_test_date_range test.

Reviewed-by: David Gow <davidgow@google.com>

Thanks,
-- David

>  tools/testing/kunit/kunit_kernel.py    | 75 +++++++++++++++-----------
>  tools/testing/kunit/kunit_tool_test.py | 17 ++++++
>  2 files changed, 62 insertions(+), 30 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 2c6f916ccbaf..450f1c386e01 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -12,7 +12,8 @@ import subprocess
>  import os
>  import shutil
>  import signal
> -from typing import Iterator, Optional, Tuple
> +import threading
> +from typing import Iterator, List, Optional, Tuple
>
>  from contextlib import ExitStack
>
> @@ -103,8 +104,8 @@ class LinuxSourceTreeOperations(object):
>                 if stderr:  # likely only due to build warnings
>                         print(stderr.decode())
>
> -       def run(self, params, timeout, build_dir, outfile) -> None:
> -               pass
> +       def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
> +               raise RuntimeError('not implemented!')
>
>
>  class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
> @@ -123,7 +124,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
>                 kconfig.parse_from_string(self._kconfig)
>                 base_kunitconfig.merge_in_entries(kconfig)
>
> -       def run(self, params, timeout, build_dir, outfile):
> +       def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
>                 kernel_path = os.path.join(build_dir, self._kernel_path)
>                 qemu_command = ['qemu-system-' + self._qemu_arch,
>                                 '-nodefaults',
> @@ -134,18 +135,11 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
>                                 '-nographic',
>                                 '-serial stdio'] + self._extra_qemu_params
>                 print('Running tests with:\n$', ' '.join(qemu_command))
> -               with open(outfile, 'w') as output:
> -                       process = subprocess.Popen(' '.join(qemu_command),
> -                                                  stdin=subprocess.PIPE,
> -                                                  stdout=output,
> -                                                  stderr=subprocess.STDOUT,
> -                                                  text=True, shell=True)
> -               try:
> -                       process.wait(timeout=timeout)
> -               except Exception as e:
> -                       print(e)
> -                       process.terminate()
> -               return process
> +               return subprocess.Popen(' '.join(qemu_command),
> +                                          stdin=subprocess.PIPE,
> +                                          stdout=subprocess.PIPE,
> +                                          stderr=subprocess.STDOUT,
> +                                          text=True, shell=True)
>
>  class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
>         """An abstraction over command line operations performed on a source tree."""
> @@ -175,17 +169,14 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
>                 kunit_parser.print_with_timestamp(
>                         'Starting Kernel with all configs takes a few minutes...')
>
> -       def run(self, params, timeout, build_dir, outfile):
> +       def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
>                 """Runs the Linux UML binary. Must be named 'linux'."""
>                 linux_bin = get_file_path(build_dir, 'linux')
> -               outfile = get_outfile_path(build_dir)
> -               with open(outfile, 'w') as output:
> -                       process = subprocess.Popen([linux_bin] + params,
> -                                                  stdin=subprocess.PIPE,
> -                                                  stdout=output,
> -                                                  stderr=subprocess.STDOUT,
> -                                                  text=True)
> -                       process.wait(timeout)
> +               return subprocess.Popen([linux_bin] + params,
> +                                          stdin=subprocess.PIPE,
> +                                          stdout=subprocess.PIPE,
> +                                          stderr=subprocess.STDOUT,
> +                                          text=True)
>
>  def get_kconfig_path(build_dir) -> str:
>         return get_file_path(build_dir, KCONFIG_PATH)
> @@ -330,12 +321,36 @@ class LinuxSourceTree(object):
>                 args.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
>                 if filter_glob:
>                         args.append('kunit.filter_glob='+filter_glob)
> -               outfile = get_outfile_path(build_dir)
> -               self._ops.run(args, timeout, build_dir, outfile)
> -               subprocess.call(['stty', 'sane'])
> -               with open(outfile, 'r') as file:
> -                       for line in file:
> +
> +               process = self._ops.start(args, build_dir)
> +               assert process.stdout is not None  # tell mypy it's set
> +
> +               # Enforce the timeout in a background thread.
> +               def _wait_proc():
> +                       try:
> +                               process.wait(timeout=timeout)
> +                       except Exception as e:
> +                               print(e)
> +                               process.terminate()
> +                               process.wait()
> +               waiter = threading.Thread(target=_wait_proc)
> +               waiter.start()
> +
> +               output = open(get_outfile_path(build_dir), 'w')
> +               try:
> +                       # Tee the output to the file and to our caller in real time.
> +                       for line in process.stdout:
> +                               output.write(line)
>                                 yield line
> +               # This runs even if our caller doesn't consume every line.
> +               finally:
> +                       # Flush any leftover output to the file
> +                       output.write(process.stdout.read())
> +                       output.close()
> +                       process.stdout.close()
> +
> +                       waiter.join()
> +                       subprocess.call(['stty', 'sane'])
>
>         def signal_handler(self, sig, frame) -> None:
>                 logging.error('Build interruption occurred. Cleaning console.')
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 619c4554cbff..f9a7398a9584 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -14,6 +14,7 @@ import tempfile, shutil # Handling test_tmpdir
>  import itertools
>  import json
>  import signal
> +import subprocess
>  import os
>
>  import kunit_config
> @@ -291,6 +292,22 @@ class LinuxSourceTreeTest(unittest.TestCase):
>                                 pass
>                         tree = kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
>
> +       def test_run_kernel_hits_exception(self):
> +               def fake_start(unused_args, unused_build_dir):
> +                       return subprocess.Popen(['echo "hi\nbye"'], shell=True, text=True, stdout=subprocess.PIPE)
> +
> +               with tempfile.TemporaryDirectory('') as build_dir:
> +                       tree = kunit_kernel.LinuxSourceTree(build_dir, load_config=False)
> +                       mock.patch.object(tree._ops, 'start', side_effect=fake_start).start()
> +
> +                       with self.assertRaises(ValueError):
> +                               for line in tree.run_kernel(build_dir=build_dir):
> +                                       self.assertEqual(line, 'hi\n')
> +                                       raise ValueError('uh oh, did not read all output')
> +
> +                       with open(kunit_kernel.get_outfile_path(build_dir), 'rt') as outfile:
> +                               self.assertEqual(outfile.read(), 'hi\nbye\n', msg='Missing some output')
> +
>         # TODO: add more test cases.
>
>
>
> base-commit: 3b29021ddd10cfb6b2565c623595bd3b02036f33
> --
> 2.33.0.800.g4c38ced690-goog
>
