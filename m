Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9DB52B3E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 09:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiERHst (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 03:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiERHsr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 03:48:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B4A101C9
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 00:48:45 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r30so1390570wra.13
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 00:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YYkjxn2cJ8PUflgpavVBQJlzogSe94I6eGTKkYiFpu0=;
        b=qtdcIhwmx6hgfCDFUX7uD3d3krmnGGVfcJl00pEHZ5PasiN9rHd6FHK1CEn6RGyge3
         b+xv4RrpHvuiltrsKpgZ54Spqv3SIO8jsES8lticVCqKGe+xkbfUfJVaR92UDeKuvrGM
         DjAm09cXwRjVQCjlH14cJb+U7e2vEiXiPc3gnEC5Ehj1Xvi/vG6CVgM8HYHCQF7LhoCm
         S2wJAdJHXB1kjcUemL7+A+ETztorzwZ0NMgWVGoMOvbSlCogtcyz38Bb4TpDaGpdMYAM
         RrRAhifxMEwiX/r5LXAdKPuZ/P8YcA/LDeH5jxOYgvUw9wwVxL+0R4eorIbCXSH5KOhQ
         +ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYkjxn2cJ8PUflgpavVBQJlzogSe94I6eGTKkYiFpu0=;
        b=QqknjHXWQoEgizwNym6Io/moegA7/APdAkFLlo2QucHuLGqe2KqHjjobV7/9c2QyUo
         UYXfD/K3fh7QLBBGqcBx3FdTI+Gy1outQzo63N8yeZGoKFuMoeMvX9mVsAMJuwhugCBg
         dIoj76XC0MXCDBt2Y64SxL8IGo6Y59HVis1JfYRbguuQ4lT+J9IUDnSoEqPHqR8Hp9fz
         AzGoIGM7qDI4xx5peapoJUn/co8jd/uVKoah3zjUH52sRTvCSyb1RY+zkixmBfS7gDR5
         SIvPuIKnTpOO8p52YHr7cD5bh9kreJdEuKFpPOeJ4+kC/yaF23u8pwG2hKgVJXMtqvSm
         DmqQ==
X-Gm-Message-State: AOAM532P7rB5IrKFxBKjYtUZgySNaU5e9sktbGHz1wpFFy5f0gccOYwt
        45/UNtH9ZQfih01Mk/8HE4bNCo+CGOzVCWp1/nvmXw==
X-Google-Smtp-Source: ABdhPJyFe8NgoaFEBciePpf1Q2kFCgzNM88Uf7tWM3M+dPuHUGQ0QpgeCRLJbD2wlGA8cgwhM/JqUEPDkgnoau6PrQg=
X-Received: by 2002:a5d:6041:0:b0:20d:8e4:7bb8 with SMTP id
 j1-20020a5d6041000000b0020d08e47bb8mr11488390wrt.652.1652860123517; Wed, 18
 May 2022 00:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220516194730.1546328-1-dlatypov@google.com> <20220516194730.1546328-3-dlatypov@google.com>
In-Reply-To: <20220516194730.1546328-3-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 18 May 2022 15:48:32 +0800
Message-ID: <CABVgOSn1Hq6AX-+=+m_uLwKne3wuUadrsE=uPRsgYH3+TFBEuA@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: tool: refactoring printing logic into kunit_printer.py
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008d784105df447cc1"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000008d784105df447cc1
Content-Type: text/plain; charset="UTF-8"

On Tue, May 17, 2022 at 3:48 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Context:
> * kunit_kernel.py is importing kunit_parser.py just to use the
>   print_with_timestamp() function
> * the parser is directly printing to stdout, which will become an issue
>   if we ever try to run multiple kernels in parallel
>
> This patch introduces a kunit_printer.py file and migrates callers of
> kunit_parser.print_with_timestamp() to call
> kunit_printer.stdout.print_with_timestamp() instead.
>
> Future changes:
> If we want to support showing results for parallel runs, we could then
> create new Printer's that don't directly write to stdout and refactor
> the code to pass around these Printer objects.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

I agree that this will be useful down the line, as running multiple
kernels in parallel is definitely something which could be useful. I
know the original idea for that was to have multiple parsers, and just
to combine the results they gave after the fact, but given that
incremental output is so useful, I agree that this is the better path.

My only super-minor gripe (which I can live with) is that importing
'stdout' and using it as 'stdout.print_with_timestamp()' is a little
confusing: I'd've assumed an stdout variable imported into the global
namespace was sys.stdout, not a wrapper. Explicitly using
kunit_printer.stdout would be a little clearer, IMO. Up to you,
though.

Regardless,
Reviewed-by: David Gow <davidgow@google.com>

-- David

>  tools/testing/kunit/kunit.py           | 17 +++----
>  tools/testing/kunit/kunit_kernel.py    |  8 ++--
>  tools/testing/kunit/kunit_parser.py    | 63 ++++++++------------------
>  tools/testing/kunit/kunit_printer.py   | 48 ++++++++++++++++++++
>  tools/testing/kunit/kunit_tool_test.py |  4 +-
>  5 files changed, 82 insertions(+), 58 deletions(-)
>  create mode 100644 tools/testing/kunit/kunit_printer.py
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 8a90d80ee66e..114e548e4f04 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -22,6 +22,7 @@ from typing import Iterable, List, Optional, Sequence, Tuple
>  import kunit_json
>  import kunit_kernel
>  import kunit_parser
> +from kunit_printer import stdout
>
>  class KunitStatus(Enum):
>         SUCCESS = auto()
> @@ -72,7 +73,7 @@ def get_kernel_root_path() -> str:
>
>  def config_tests(linux: kunit_kernel.LinuxSourceTree,
>                  request: KunitConfigRequest) -> KunitResult:
> -       kunit_parser.print_with_timestamp('Configuring KUnit Kernel ...')
> +       stdout.print_with_timestamp('Configuring KUnit Kernel ...')
>
>         config_start = time.time()
>         success = linux.build_reconfig(request.build_dir, request.make_options)
> @@ -85,7 +86,7 @@ def config_tests(linux: kunit_kernel.LinuxSourceTree,
>
>  def build_tests(linux: kunit_kernel.LinuxSourceTree,
>                 request: KunitBuildRequest) -> KunitResult:
> -       kunit_parser.print_with_timestamp('Building KUnit Kernel ...')
> +       stdout.print_with_timestamp('Building KUnit Kernel ...')
>
>         build_start = time.time()
>         success = linux.build_kernel(request.alltests,
> @@ -158,7 +159,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
>         test_counts = kunit_parser.TestCounts()
>         exec_time = 0.0
>         for i, filter_glob in enumerate(filter_globs):
> -               kunit_parser.print_with_timestamp('Starting KUnit Kernel ({}/{})...'.format(i+1, len(filter_globs)))
> +               stdout.print_with_timestamp('Starting KUnit Kernel ({}/{})...'.format(i+1, len(filter_globs)))
>
>                 test_start = time.time()
>                 run_result = linux.run_kernel(
> @@ -221,7 +222,7 @@ def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input
>                 else:
>                         with open(request.json, 'w') as f:
>                                 f.write(json_str)
> -                       kunit_parser.print_with_timestamp("Test results stored in %s" %
> +                       stdout.print_with_timestamp("Test results stored in %s" %
>                                 os.path.abspath(request.json))
>
>         if test_result.status != kunit_parser.TestStatus.SUCCESS:
> @@ -245,7 +246,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
>
>         run_end = time.time()
>
> -       kunit_parser.print_with_timestamp((
> +       stdout.print_with_timestamp((
>                 'Elapsed time: %.3fs total, %.3fs configuring, %.3fs ' +
>                 'building, %.3fs running\n') % (
>                                 run_end - run_start,
> @@ -446,7 +447,7 @@ def main(argv):
>                 request = KunitConfigRequest(build_dir=cli_args.build_dir,
>                                              make_options=cli_args.make_options)
>                 result = config_tests(linux, request)
> -               kunit_parser.print_with_timestamp((
> +               stdout.print_with_timestamp((
>                         'Elapsed time: %.3fs\n') % (
>                                 result.elapsed_time))
>                 if result.status != KunitStatus.SUCCESS:
> @@ -458,7 +459,7 @@ def main(argv):
>                                             jobs=cli_args.jobs,
>                                             alltests=cli_args.alltests)
>                 result = config_and_build_tests(linux, request)
> -               kunit_parser.print_with_timestamp((
> +               stdout.print_with_timestamp((
>                         'Elapsed time: %.3fs\n') % (
>                                 result.elapsed_time))
>                 if result.status != KunitStatus.SUCCESS:
> @@ -474,7 +475,7 @@ def main(argv):
>                                                 kernel_args=cli_args.kernel_args,
>                                                 run_isolated=cli_args.run_isolated)
>                 result = exec_tests(linux, exec_request)
> -               kunit_parser.print_with_timestamp((
> +               stdout.print_with_timestamp((
>                         'Elapsed time: %.3fs\n') % (result.elapsed_time))
>                 if result.status != KunitStatus.SUCCESS:
>                         sys.exit(1)
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 8bc8305ba817..b51ce102d82e 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -18,7 +18,7 @@ import threading
>  from typing import Iterator, List, Optional, Tuple
>
>  import kunit_config
> -import kunit_parser
> +from kunit_printer import stdout
>  import qemu_config
>
>  KCONFIG_PATH = '.config'
> @@ -138,7 +138,7 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
>                 super().__init__(linux_arch='um', cross_compile=cross_compile)
>
>         def make_allyesconfig(self, build_dir: str, make_options) -> None:
> -               kunit_parser.print_with_timestamp(
> +               stdout.print_with_timestamp(
>                         'Enabling all CONFIGs for UML...')
>                 command = ['make', 'ARCH=um', 'O=' + build_dir, 'allyesconfig']
>                 if make_options:
> @@ -148,13 +148,13 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
>                         stdout=subprocess.DEVNULL,
>                         stderr=subprocess.STDOUT)
>                 process.wait()
> -               kunit_parser.print_with_timestamp(
> +               stdout.print_with_timestamp(
>                         'Disabling broken configs to run KUnit tests...')
>
>                 with open(get_kconfig_path(build_dir), 'a') as config:
>                         with open(BROKEN_ALLCONFIG_PATH, 'r') as disable:
>                                 config.write(disable.read())
> -               kunit_parser.print_with_timestamp(
> +               stdout.print_with_timestamp(
>                         'Starting Kernel with all configs takes a few minutes...')
>
>         def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index c5569b367c69..12d3ec77f427 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -13,10 +13,11 @@ from __future__ import annotations
>  import re
>  import sys
>
> -import datetime
>  from enum import Enum, auto
>  from typing import Iterable, Iterator, List, Optional, Tuple
>
> +from kunit_printer import stdout
> +
>  class Test:
>         """
>         A class to represent a test parsed from KTAP results. All KTAP
> @@ -55,7 +56,7 @@ class Test:
>         def add_error(self, error_message: str) -> None:
>                 """Records an error that occurred while parsing this test."""
>                 self.counts.errors += 1
> -               print_with_timestamp(red('[ERROR]') + f' Test: {self.name}: {error_message}')
> +               stdout.print_with_timestamp(stdout.red('[ERROR]') + f' Test: {self.name}: {error_message}')
>
>  class TestStatus(Enum):
>         """An enumeration class to represent the status of a test."""
> @@ -461,32 +462,6 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
>
>  DIVIDER = '=' * 60
>
> -RESET = '\033[0;0m'
> -
> -def red(text: str) -> str:
> -       """Returns inputted string with red color code."""
> -       if not sys.stdout.isatty():
> -               return text
> -       return '\033[1;31m' + text + RESET
> -
> -def yellow(text: str) -> str:
> -       """Returns inputted string with yellow color code."""
> -       if not sys.stdout.isatty():
> -               return text
> -       return '\033[1;33m' + text + RESET
> -
> -def green(text: str) -> str:
> -       """Returns inputted string with green color code."""
> -       if not sys.stdout.isatty():
> -               return text
> -       return '\033[1;32m' + text + RESET
> -
> -ANSI_LEN = len(red(''))
> -
> -def print_with_timestamp(message: str) -> None:
> -       """Prints message with timestamp at beginning."""
> -       print('[%s] %s' % (datetime.datetime.now().strftime('%H:%M:%S'), message))
> -
>  def format_test_divider(message: str, len_message: int) -> str:
>         """
>         Returns string with message centered in fixed width divider.
> @@ -529,12 +504,12 @@ def print_test_header(test: Test) -> None:
>                         message += ' (1 subtest)'
>                 else:
>                         message += f' ({test.expected_count} subtests)'
> -       print_with_timestamp(format_test_divider(message, len(message)))
> +       stdout.print_with_timestamp(format_test_divider(message, len(message)))
>
>  def print_log(log: Iterable[str]) -> None:
>         """Prints all strings in saved log for test in yellow."""
>         for m in log:
> -               print_with_timestamp(yellow(m))
> +               stdout.print_with_timestamp(stdout.yellow(m))
>
>  def format_test_result(test: Test) -> str:
>         """
> @@ -551,16 +526,16 @@ def format_test_result(test: Test) -> str:
>         String containing formatted test result
>         """
>         if test.status == TestStatus.SUCCESS:
> -               return green('[PASSED] ') + test.name
> +               return stdout.green('[PASSED] ') + test.name
>         if test.status == TestStatus.SKIPPED:
> -               return yellow('[SKIPPED] ') + test.name
> +               return stdout.yellow('[SKIPPED] ') + test.name
>         if test.status == TestStatus.NO_TESTS:
> -               return yellow('[NO TESTS RUN] ') + test.name
> +               return stdout.yellow('[NO TESTS RUN] ') + test.name
>         if test.status == TestStatus.TEST_CRASHED:
>                 print_log(test.log)
> -               return red('[CRASHED] ') + test.name
> +               return stdout.red('[CRASHED] ') + test.name
>         print_log(test.log)
> -       return red('[FAILED] ') + test.name
> +       return stdout.red('[FAILED] ') + test.name
>
>  def print_test_result(test: Test) -> None:
>         """
> @@ -572,7 +547,7 @@ def print_test_result(test: Test) -> None:
>         Parameters:
>         test - Test object representing current test being printed
>         """
> -       print_with_timestamp(format_test_result(test))
> +       stdout.print_with_timestamp(format_test_result(test))
>
>  def print_test_footer(test: Test) -> None:
>         """
> @@ -585,8 +560,8 @@ def print_test_footer(test: Test) -> None:
>         test - Test object representing current test being printed
>         """
>         message = format_test_result(test)
> -       print_with_timestamp(format_test_divider(message,
> -               len(message) - ANSI_LEN))
> +       stdout.print_with_timestamp(format_test_divider(message,
> +               len(message) - stdout.color_len()))
>
>  def print_summary_line(test: Test) -> None:
>         """
> @@ -603,12 +578,12 @@ def print_summary_line(test: Test) -> None:
>         test - Test object representing current test being printed
>         """
>         if test.status == TestStatus.SUCCESS:
> -               color = green
> +               color = stdout.green
>         elif test.status in (TestStatus.SKIPPED, TestStatus.NO_TESTS):
> -               color = yellow
> +               color = stdout.yellow
>         else:
> -               color = red
> -       print_with_timestamp(color(f'Testing complete. {test.counts}'))
> +               color = stdout.red
> +       stdout.print_with_timestamp(color(f'Testing complete. {test.counts}'))
>
>  # Other methods:
>
> @@ -762,7 +737,7 @@ def parse_run_tests(kernel_output: Iterable[str]) -> Test:
>         Return:
>         Test - the main test object with all subtests.
>         """
> -       print_with_timestamp(DIVIDER)
> +       stdout.print_with_timestamp(DIVIDER)
>         lines = extract_tap_lines(kernel_output)
>         test = Test()
>         if not lines:
> @@ -773,6 +748,6 @@ def parse_run_tests(kernel_output: Iterable[str]) -> Test:
>                 test = parse_test(lines, 0, [])
>                 if test.status != TestStatus.NO_TESTS:
>                         test.status = test.counts.get_status()
> -       print_with_timestamp(DIVIDER)
> +       stdout.print_with_timestamp(DIVIDER)
>         print_summary_line(test)
>         return test
> diff --git a/tools/testing/kunit/kunit_printer.py b/tools/testing/kunit/kunit_printer.py
> new file mode 100644
> index 000000000000..5f1cc55ecdf5
> --- /dev/null
> +++ b/tools/testing/kunit/kunit_printer.py
> @@ -0,0 +1,48 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Utilities for printing and coloring output.
> +#
> +# Copyright (C) 2022, Google LLC.
> +# Author: Daniel Latypov <dlatypov@google.com>
> +
> +import datetime
> +import sys
> +import typing
> +
> +_RESET = '\033[0;0m'
> +
> +class Printer:
> +       """Wraps a file object, providing utilities for coloring output, etc."""
> +
> +       def __init__(self, output: typing.IO):
> +               self._output = output
> +               self._use_color = output.isatty()
> +
> +       def print(self, message: str) -> None:
> +               print(message, file=self._output)
> +
> +       def print_with_timestamp(self, message: str) -> None:
> +               ts = datetime.datetime.now().strftime('%H:%M:%S')
> +               self.print(f'[{ts}] {message}')
> +
> +       def _color(self, code: str, text: str) -> str:
> +               if not self._use_color:
> +                       return text
> +               return code + text + _RESET
> +
> +       def red(self, text: str) -> str:
> +               return self._color('\033[1;31m', text)
> +
> +       def yellow(self, text: str) -> str:
> +               return self._color('\033[1;33m', text)
> +
> +       def green(self, text: str) -> str:
> +               return self._color('\033[1;32m', text)
> +
> +       def color_len(self) -> int:
> +               """Returns the length of the color escape codes."""
> +               return len(self.red(''))
> +
> +# Provides a default instance that prints to stdout
> +stdout = Printer(sys.stdout)
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index baee11d96474..2973402c5053 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -222,7 +222,7 @@ class KUnitParserTest(unittest.TestCase):
>
>         def test_no_kunit_output(self):
>                 crash_log = test_data_path('test_insufficient_memory.log')
> -               print_mock = mock.patch('builtins.print').start()
> +               print_mock = mock.patch('kunit_printer.Printer.print').start()
>                 with open(crash_log) as file:
>                         result = kunit_parser.parse_run_tests(
>                                 kunit_parser.extract_tap_lines(file.readlines()))
> @@ -500,7 +500,7 @@ class KUnitMainTest(unittest.TestCase):
>                 with open(path) as file:
>                         all_passed_log = file.readlines()
>
> -               self.print_mock = mock.patch('builtins.print').start()
> +               self.print_mock = mock.patch('kunit_printer.Printer.print').start()
>                 self.addCleanup(mock.patch.stopall)
>
>                 self.mock_linux_init = mock.patch.object(kunit_kernel, 'LinuxSourceTree').start()
> --
> 2.36.1.124.g0e6072fb45-goog
>

--0000000000008d784105df447cc1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
G7p3AiuB2sgfq6cOpbO5MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBsL34EJkCtu9Nu
2+R6l1Qzno5Gl+N2Cm6/YLujukDGYa1JW27txXiilR9dGP7yl60HYyG2Exd5i6fiLDlaNEw0SqzE
dw9ZSIak3Qvm2UybR8zcnB0deCUiwahqh7ZncEPlhnPpB08ETEUtwBEqCEnndNEkIN67yz4kniCZ
jZstNF/BUnI3864fATiXSbnNqBwlJS3YkoaCTpbI9qNTrf5VIvnbryT69xJ6f25yfmxrXNJJe5OG
ncB34Cwnb7xQyk+uRLZ465yUBkbjk9pC/yamL0O7SOGYUclrQl2c5zzGuVBD84YcQGDOK6gSPj6w
QuBfOooZPOyZZZ8AMih7J980MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAi
I4u3nsxKb+8A7pR+l+DPUy0MHDHfKFyxX7hPrSWwCDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA1MTgwNzQ4NDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAguVdHEau73+5TjbxrmdM
QAwN8nqDFENu4gfWbfrvhNG79tmKdcNPpOdb1GHSsOg8HXH/zamX20QhbceThUeV3mjLaO3EY/2N
/2dwy7wsrbbqleS1WJTabrhXeRXmmVBQIjoEDUE9MFb4czefYrrwFKQTpplu9/GFUHmcZH0K3Hf+
bcL1XW2r+G92ZYAywlTgIN04z+7qh06YsfhkZl0hrKDrgP/Jlbo8R3IQR1B15VWhTeGEAJEy8PGo
df0n+b5F+++Lz3QWNPbemLOM8a6ATeUMy95bW1By+hPoRuIarq7o01viQm6KtoJx080lWw2syOe+
RJdoD9/ytBHc9zEqHw==
--0000000000008d784105df447cc1--
