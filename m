Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D068520DD2
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 08:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbiEJG1V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 02:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbiEJG1C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 02:27:02 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D4D2B4C95
        for <linux-kselftest@vger.kernel.org>; Mon,  9 May 2022 23:22:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x18so22309379wrc.0
        for <linux-kselftest@vger.kernel.org>; Mon, 09 May 2022 23:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dvdc0yM6cPnBiwGvW8GWeZiOFv2E/kXOJ9QvUKMsgs0=;
        b=ZhEnTOrG9nTskdTWATmoxwySk3Z8SweNw4H+Z7R7wYvsR0IcDdQ1+FX1Y2dFbG6oxC
         QDTfomq4qbfQqYfR9hTOVnyP0od2RrLHBVW2llNsiATGRlch9/PoHr6oZZsMxRCN4jl6
         15v1FaBWp22iGc67POdBnDMjlX70G62OAlsfv8RFsXIlDYP8EWQBM61ycpOweY9UmosU
         /HIwYghn8RUiMXrzaflNPKMyFHCeio/0dL/OyEpt6eQQKpcfW6qsmcHOehrfg08qHrNt
         hRFGwCMLFzmoj//CSlW9EfPwHfuXXRdEvp0EppttGRqA84+z4zh1tf4kjQ2Xf6gshM5+
         SazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dvdc0yM6cPnBiwGvW8GWeZiOFv2E/kXOJ9QvUKMsgs0=;
        b=BnaCYmi6kgbUjAsHS/f4UAFpMuxEwaaJSVcrsPkIZognyGNIbT+6xdswM12OqNxULW
         KA2tsLImy4YztDT+qftXsglP8Lij3LHUrAI6q59eOiz3cPoNfC0ZtD/F6N+8J4iNqD14
         s3NmKfvcIopWxzV0nx2Ls+KmebCkCR2oAsY1nansGGJtLHdCdbnB8fU3JpUBbhYwtUUv
         mD53e3FwNh8P8iCecvaqBSp7A92YKiQx85xgRSkRQHsMtxCnUIpEg8dySPCcnYWIqBys
         5Evm5cUgyQRNOroaA8bPy+EmzhlAyWIdNerXYME/nZmhi/HNtzTVoSmB7Y1/h5eGqYYY
         FBoA==
X-Gm-Message-State: AOAM5307tR3ORBZr+m8ly6HLsS+ZDdq9Y7slEnwUCoXc2/T4hxuWMV+u
        hwwO8n6vjsU7Kl/BjMtexWTT8r2DvcYcIashXoRnwA==
X-Google-Smtp-Source: ABdhPJzYZqCsHfrGxVVOEpBI62Ysdf7Ss6RBm7mA8c6RUdwDDaI1Q1s+oh/u3mt7M38+A7NojZTOrQNVNfM2VkyM5RY=
X-Received: by 2002:a5d:4806:0:b0:20a:da03:711b with SMTP id
 l6-20020a5d4806000000b0020ada03711bmr16839042wrq.395.1652163732007; Mon, 09
 May 2022 23:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220509204909.2464496-1-dlatypov@google.com>
In-Reply-To: <20220509204909.2464496-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 10 May 2022 14:22:00 +0800
Message-ID: <CABVgOSnwFe18Em327c3bx7z0A9VfujbjdKgofoSRafFOsOjfwQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: misc cleanups
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 10, 2022 at 4:49 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> This primarily comes from running pylint over kunit tool code and
> ignoring some warnings we don't care about.
> If we ever got a fully clean setup, we could add this to run_checks.py,
> but we're not there yet.
>
> Fix things like
> * Drop unused imports
> * check `is None`, not `== None` (see PEP 8)
> * remove redundant parens around returns
> * remove redundant `else` / convert `elif` to `if` where appropriate

Personally, I find the explicit 'elif' much more readable in most of
these cases, but if we're annoying a linter, I guess we should change
them...

> * rename make_arch_qemuconfig() param to base_kunitconfig (this is the
>   name used in the subclass, and it's a better one)
> * kunit_tool_test: check the exit code for SystemExit (could be 0)
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

All of these changes seem correct to me, even if I'm not sure I'd
bother with most of them if they weren't causing pylint to show
errors.

Given that apparently it does, though, I'm okay with it going through.
(I'll just grumble quietly in my corner. :-))

Reviewed-by: David Gow <davidgow@google.com>

-- David

> Note: this patch only applies cleanly on top of https://lore.kernel.org/linux-kselftest/20220426173334.3871399-3-dlatypov@google.com
> ---
>  tools/testing/kunit/kunit.py           |  9 +++----
>  tools/testing/kunit/kunit_config.py    | 12 ++++-----
>  tools/testing/kunit/kunit_json.py      |  5 +---
>  tools/testing/kunit/kunit_kernel.py    | 10 +++----
>  tools/testing/kunit/kunit_parser.py    | 37 ++++++++++++--------------
>  tools/testing/kunit/kunit_tool_test.py | 10 ++++---
>  tools/testing/kunit/run_checks.py      |  2 +-
>  7 files changed, 39 insertions(+), 46 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 6dc710d3996b..13bd72e47da8 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -124,7 +124,7 @@ def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest)
>         lines.pop()
>
>         # Filter out any extraneous non-test output that might have gotten mixed in.
> -       return [l for l in lines if re.match('^[^\s.]+\.[^\s.]+$', l)]
> +       return [l for l in lines if re.match(r'^[^\s.]+\.[^\s.]+$', l)]
>
>  def _suites_from_test_list(tests: List[str]) -> List[str]:
>         """Extracts all the suites from an ordered list of tests."""
> @@ -188,8 +188,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
>  def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
>         if test_status in (kunit_parser.TestStatus.SUCCESS, kunit_parser.TestStatus.SKIPPED):
>                 return KunitStatus.SUCCESS
> -       else:
> -               return KunitStatus.TEST_FAILURE
> +       return KunitStatus.TEST_FAILURE
>
>  def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input_data: Iterable[str]) -> Tuple[KunitResult, kunit_parser.Test]:
>         parse_start = time.time()
> @@ -353,7 +352,7 @@ def add_exec_opts(parser) -> None:
>                             'a non-hermetic test, one that might pass/fail based on '
>                             'what ran before it.',
>                             type=str,
> -                           choices=['suite', 'test']),
> +                           choices=['suite', 'test'])
>
>  def add_parse_opts(parser) -> None:
>         parser.add_argument('--raw_output', help='If set don\'t format output from kernel. '
> @@ -497,7 +496,7 @@ def main(argv, linux=None):
>                 if result.status != KunitStatus.SUCCESS:
>                         sys.exit(1)
>         elif cli_args.subcommand == 'parse':
> -               if cli_args.file == None:
> +               if cli_args.file is None:
>                         sys.stdin.reconfigure(errors='backslashreplace')  # pytype: disable=attribute-error
>                         kunit_output = sys.stdin
>                 else:
> diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
> index ca33e4b7bcc5..75a8dc1683d4 100644
> --- a/tools/testing/kunit/kunit_config.py
> +++ b/tools/testing/kunit/kunit_config.py
> @@ -20,16 +20,15 @@ class KconfigEntry:
>
>         def __str__(self) -> str:
>                 if self.value == 'n':
> -                       return r'# CONFIG_%s is not set' % (self.name)
> -               else:
> -                       return r'CONFIG_%s=%s' % (self.name, self.value)
> +                       return f'# CONFIG_{self.name} is not set'
> +               return f'CONFIG_{self.name}={self.value}'
>
>
>  class KconfigParseError(Exception):
>         """Error parsing Kconfig defconfig or .config."""
>
>
> -class Kconfig(object):
> +class Kconfig:
>         """Represents defconfig or .config specified using the Kconfig language."""
>
>         def __init__(self) -> None:
> @@ -49,7 +48,7 @@ class Kconfig(object):
>                                 if a.value == 'n':
>                                         continue
>                                 return False
> -                       elif a.value != b:
> +                       if a.value != b:
>                                 return False
>                 return True
>
> @@ -91,6 +90,5 @@ def parse_from_string(blob: str) -> Kconfig:
>
>                 if line[0] == '#':
>                         continue
> -               else:
> -                       raise KconfigParseError('Failed to parse: ' + line)
> +               raise KconfigParseError('Failed to parse: ' + line)
>         return kconfig
> diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
> index 1212423fe6bc..10ff65689dd8 100644
> --- a/tools/testing/kunit/kunit_json.py
> +++ b/tools/testing/kunit/kunit_json.py
> @@ -8,12 +8,9 @@
>
>  from dataclasses import dataclass
>  import json
> -import os
> -
> -import kunit_parser
> +from typing import Any, Dict
>
>  from kunit_parser import Test, TestStatus
> -from typing import Any, Dict
>
>  @dataclass
>  class Metadata:
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 483f78e15ce9..93446a2b6414 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -37,7 +37,7 @@ class BuildError(Exception):
>         """Represents an error trying to build the Linux kernel."""
>
>
> -class LinuxSourceTreeOperations(object):
> +class LinuxSourceTreeOperations:
>         """An abstraction over command line operations performed on a source tree."""
>
>         def __init__(self, linux_arch: str, cross_compile: Optional[str]):
> @@ -52,7 +52,7 @@ class LinuxSourceTreeOperations(object):
>                 except subprocess.CalledProcessError as e:
>                         raise ConfigError(e.output.decode())
>
> -       def make_arch_qemuconfig(self, kconfig: kunit_config.Kconfig) -> None:
> +       def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> None:
>                 pass
>
>         def make_allyesconfig(self, build_dir: str, make_options) -> None:
> @@ -180,7 +180,7 @@ def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceT
>         config_path = os.path.join(QEMU_CONFIGS_DIR, arch + '.py')
>         if arch == 'um':
>                 return LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
> -       elif os.path.isfile(config_path):
> +       if os.path.isfile(config_path):
>                 return get_source_tree_ops_from_qemu_config(config_path, cross_compile)[1]
>
>         options = [f[:-3] for f in os.listdir(QEMU_CONFIGS_DIR) if f.endswith('.py')]
> @@ -211,7 +211,7 @@ def get_source_tree_ops_from_qemu_config(config_path: str,
>         return params.linux_arch, LinuxSourceTreeOperationsQemu(
>                         params, cross_compile=cross_compile)
>
> -class LinuxSourceTree(object):
> +class LinuxSourceTree:
>         """Represents a Linux kernel source tree with KUnit tests."""
>
>         def __init__(
> @@ -366,6 +366,6 @@ class LinuxSourceTree(object):
>                         waiter.join()
>                         subprocess.call(['stty', 'sane'])
>
> -       def signal_handler(self, sig, frame) -> None:
> +       def signal_handler(self, unused_sig, unused_frame) -> None:
>                 logging.error('Build interruption occurred. Cleaning console.')
>                 subprocess.call(['stty', 'sane'])
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index d56d530fab24..5c90842d7017 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -15,10 +15,9 @@ import sys
>
>  import datetime
>  from enum import Enum, auto
> -from functools import reduce
>  from typing import Iterable, Iterator, List, Optional, Tuple
>
> -class Test(object):
> +class Test:
>         """
>         A class to represent a test parsed from KTAP results. All KTAP
>         results within a test log are stored in a main Test object as
> @@ -126,17 +125,16 @@ class TestCounts:
>                 """
>                 if self.total() == 0:
>                         return TestStatus.NO_TESTS
> -               elif self.crashed:
> +               if self.crashed:
>                         # Crashes should take priority.
>                         return TestStatus.TEST_CRASHED
> -               elif self.failed:
> +               if self.failed:
>                         return TestStatus.FAILURE
> -               elif self.passed:
> +               if self.passed:
>                         # No failures or crashes, looks good!
>                         return TestStatus.SUCCESS
> -               else:
> -                       # We have only skipped tests.
> -                       return TestStatus.SKIPPED
> +               # We have only skipped tests.
> +               return TestStatus.SKIPPED
>
>         def add_status(self, status: TestStatus) -> None:
>                 """Increments the count for `status`."""
> @@ -381,7 +379,7 @@ def peek_test_name_match(lines: LineStream, test: Test) -> bool:
>         if not match:
>                 return False
>         name = match.group(4)
> -       return (name == test.name)
> +       return name == test.name
>
>  def parse_test_result(lines: LineStream, test: Test,
>                         expected_num: int) -> bool:
> @@ -553,17 +551,16 @@ def format_test_result(test: Test) -> str:
>         String containing formatted test result
>         """
>         if test.status == TestStatus.SUCCESS:
> -               return (green('[PASSED] ') + test.name)
> -       elif test.status == TestStatus.SKIPPED:
> -               return (yellow('[SKIPPED] ') + test.name)
> -       elif test.status == TestStatus.NO_TESTS:
> -               return (yellow('[NO TESTS RUN] ') + test.name)
> -       elif test.status == TestStatus.TEST_CRASHED:
> -               print_log(test.log)
> -               return (red('[CRASHED] ') + test.name)
> -       else:
> +               return green('[PASSED] ') + test.name
> +       if test.status == TestStatus.SKIPPED:
> +               return yellow('[SKIPPED] ') + test.name
> +       if test.status == TestStatus.NO_TESTS:
> +               return yellow('[NO TESTS RUN] ') + test.name
> +       if test.status == TestStatus.TEST_CRASHED:
>                 print_log(test.log)
> -               return (red('[FAILED] ') + test.name)
> +               return red('[CRASHED] ') + test.name
> +       print_log(test.log)
> +       return red('[FAILED] ') + test.name
>
>  def print_test_result(test: Test) -> None:
>         """
> @@ -607,7 +604,7 @@ def print_summary_line(test: Test) -> None:
>         """
>         if test.status == TestStatus.SUCCESS:
>                 color = green
> -       elif test.status == TestStatus.SKIPPED or test.status == TestStatus.NO_TESTS:
> +       elif test.status in (TestStatus.SKIPPED, TestStatus.NO_TESTS):
>                 color = yellow
>         else:
>                 color = red
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 1200e451c418..d2ab24f736f8 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -251,8 +251,8 @@ class KUnitParserTest(unittest.TestCase):
>
>         def test_ignores_hyphen(self):
>                 hyphen_log = test_data_path('test_strip_hyphen.log')
> -               file = open(hyphen_log)
> -               result = kunit_parser.parse_run_tests(file.readlines())
> +               with open(hyphen_log) as file:
> +                       result = kunit_parser.parse_run_tests(file.readlines())
>
>                 # A skipped test does not fail the whole suite.
>                 self.assertEqual(
> @@ -347,7 +347,7 @@ class LineStreamTest(unittest.TestCase):
>                 called_times = 0
>                 def generator():
>                         nonlocal called_times
> -                       for i in range(1,5):
> +                       for _ in range(1,5):
>                                 called_times += 1
>                                 yield called_times, str(called_times)
>
> @@ -553,7 +553,8 @@ class KUnitMainTest(unittest.TestCase):
>         def test_exec_no_tests(self):
>                 self.linux_source_mock.run_kernel = mock.Mock(return_value=['TAP version 14', '1..0'])
>                 with self.assertRaises(SystemExit) as e:
> -                 kunit.main(['run'], self.linux_source_mock)
> +                       kunit.main(['run'], self.linux_source_mock)
> +               self.assertEqual(e.exception.code, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
>                         args=None, build_dir='.kunit', filter_glob='', timeout=300)
>                 self.print_mock.assert_any_call(StrContains(' 0 tests run!'))
> @@ -588,6 +589,7 @@ class KUnitMainTest(unittest.TestCase):
>                 self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
>                 with self.assertRaises(SystemExit) as e:
>                         kunit.main(['run', '--raw_output=invalid'], self.linux_source_mock)
> +               self.assertNotEqual(e.exception.code, 0)
>
>         def test_run_raw_output_does_not_take_positional_args(self):
>                 # --raw_output is a string flag, but we don't want it to consume
> diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
> index 13d854afca9d..066e6f938f6d 100755
> --- a/tools/testing/kunit/run_checks.py
> +++ b/tools/testing/kunit/run_checks.py
> @@ -14,7 +14,7 @@ import shutil
>  import subprocess
>  import sys
>  import textwrap
> -from typing import Dict, List, Sequence, Tuple
> +from typing import Dict, List, Sequence
>
>  ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
>  TIMEOUT = datetime.timedelta(minutes=5).total_seconds()
> --
> 2.36.0.512.ge40c2bad7a-goog
>
