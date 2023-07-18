Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FB875757A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 09:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjGRHjs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 03:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjGRHjr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 03:39:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8251731
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 00:39:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so42465e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 00:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689665969; x=1692257969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sKzHZQ2ipUlUkth7RaKvfaGnffernKb0xfO+j67Sdo0=;
        b=xPSdrnqLg5JMaeNaiZdkjU+5G8uaxeJTe0fV31LKuP0HTtSwY+MHDR/jfoyF9CpFWT
         RBjxmPTTcucVQeEDBrDOC5j+dzJoJxGM1waa2XRzJ9qa7vnQ7dFmvug1+ICK26fIu3OC
         UXHgUKPHOxRRjwffu6L1ER7aNVysPStyDQunADxgyqh3U9zY0ginKQsE8m6Mirfr4H2N
         sdPha/kih1KMquvkJoUqX7/HLwrpYAF901Wrqs+udQjQHkQourPCjzkn3uIBS/NwHSLk
         tGrSPFKPaQGv3XpoYTo8hK7svXWJvKV0yKpEdVJVG1MiH85EQ/ND/OsaXlFgotYlzHDZ
         WfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689665969; x=1692257969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKzHZQ2ipUlUkth7RaKvfaGnffernKb0xfO+j67Sdo0=;
        b=iVPwpfe2KJQb0j4kGpsZID6zMCWIPRKl2JCw8NWrNA7lVY9PMiQdYMHPwwxgQNVo55
         3TG8+x5ft5O3Hg8yuX/Dv2sA0uxaxgCpcDg8/HFAB+YUCFBoDZ2yj3PvKDr/eNpryxaQ
         Yc6uyGjbD9FtR830pTnjL326MnCIySj4rZ9ik613K4b66ztkPbTikt+VlICtw+0dzCeL
         Of1IcpCeNWuQnmCfnQMrpj3rUIDQjiyWM+SKqoIaG9a/RwY8UMa2awZq30vN7zfET6l8
         3nXj1fCuqyCy14iuRAfQ6hEW+4Hvpxj0R7xCJm+2TaMIOPzt5ENpwRbyOzTm0KOsc045
         CoUA==
X-Gm-Message-State: ABy/qLb/xRRtqz0GmYKy4ySPZY/9Ay1H2vH5V2ATm+MWRJRmdPVprBLE
        FC8mbG70TB3DcfmTj3CMc9421HpkW3T/oh9OorfjIw==
X-Google-Smtp-Source: APBJJlGVXYNB/OZcTgWDOdU0cozp+REpu+c3RN1iFPskTqYf1mWH/osTSX4wyGG4kP8T3Ku+VJPWcO82yS5yZ3i/xJI=
X-Received: by 2002:a05:600c:3b1e:b0:3f7:e59f:2183 with SMTP id
 m30-20020a05600c3b1e00b003f7e59f2183mr48332wms.5.1689665969169; Tue, 18 Jul
 2023 00:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com> <20230707210947.1208717-6-rmoar@google.com>
In-Reply-To: <20230707210947.1208717-6-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 18 Jul 2023 15:39:16 +0800
Message-ID: <CABVgOSntWgQPw63Kv4bkVrOPNR-CJLE-Vv=XK+WMAdH6qL10bw@mail.gmail.com>
Subject: Re: [RFC v2 5/9] kunit: tool: Add command line interface to filter
 and report attributes
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ea7e4d0600be0305"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000ea7e4d0600be0305
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Jul 2023 at 05:10, Rae Moar <rmoar@google.com> wrote:
>
> Add ability to kunit.py to filter attributes and report a list of tests
> including attributes without running tests.
>
> Add flag "--filter" to input filters on test attributes. Tests will be
> filtered out if they do not match all inputted filters.
>
> Example: --filter speed=slow (This filter would run only the tests that are
> marked as slow)
>
> Filters have operations: <, >, <=, >=, !=, and =. But note that the
> characters < and > are often interpreted by the shell, so they may need to
> be quoted or escaped.
>
> Example: --filter "speed>slow" or --filter speed\>slow (This filter would
> run only the tests that have the speed faster than slow.
>
> Additionally, multiple filters can be used.
>
> Example: --filter "speed=slow, module!=example" (This filter would run
> only the tests that have the speed slow and are not in the "example"
> module)
>
> Note if the user wants to skip filtered tests instead of not
> running/showing them use the "--filter_skip" flag instead.
>
> Expose the output of kunit.action=list option with flag "--list_tests" to
> output a list of tests. Additionally, add flag "--list_tests_attr" to
> output a list of tests and their attributes. These flags are useful to see
> tests and test attributes without needing to run tests.
>
> Example of the output of "--list_tests_attr":
>   example
>   example.test_1
>   example.test_2
>   # example.test_2.speed: slow
>
> This output includes a suite, example, with two test cases, test_1 and
> test_2. And in this instance test_2 has been marked as slow.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---
>
> Changes since v1:
> - Change method for inputting filters to allow for spaces in filtering
>   values
> - Add option to skip filtered tests instead of not run or show them with
>   the --filter_skip flag
> - Separate the new feature to list tests and their attributes into both
>   --list_tests (lists just tests) and --list_tests_attr (lists all)
>
>  tools/testing/kunit/kunit.py           | 80 ++++++++++++++++++++++++--
>  tools/testing/kunit/kunit_kernel.py    |  6 +-
>  tools/testing/kunit/kunit_tool_test.py | 39 ++++++-------
>  3 files changed, 96 insertions(+), 29 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 3905c43369c3..6104e622ce20 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -55,8 +55,12 @@ class KunitExecRequest(KunitParseRequest):
>         build_dir: str
>         timeout: int
>         filter_glob: str
> +       filter: str
> +       filter_skip: str
>         kernel_args: Optional[List[str]]
>         run_isolated: Optional[str]
> +       list_tests: bool
> +       list_tests_attr: bool
>
>  @dataclass
>  class KunitRequest(KunitExecRequest, KunitBuildRequest):
> @@ -102,19 +106,39 @@ def config_and_build_tests(linux: kunit_kernel.LinuxSourceTree,
>
>  def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -> List[str]:
>         args = ['kunit.action=list']
> +
> +       if request.kernel_args:
> +               args.extend(request.kernel_args)
> +
> +       output = linux.run_kernel(args=args,
> +                          timeout=request.timeout,
> +                          filter_glob=request.filter_glob,
> +                          filter=request.filter,
> +                          build_dir=request.build_dir)
> +       lines = kunit_parser.extract_tap_lines(output)
> +       # Hack! Drop the dummy TAP version header that the executor prints out.
> +       lines.pop()
> +
> +       # Filter out any extraneous non-test output that might have gotten mixed in.
> +       return [l for l in output if re.match(r'^[^\s.]+\.[^\s.]+$', l)]
> +
> +def _list_tests_attr(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -> Iterable[str]:
> +       args = ['kunit.action=list_attr']
> +
>         if request.kernel_args:
>                 args.extend(request.kernel_args)
>
>         output = linux.run_kernel(args=args,
>                            timeout=request.timeout,
>                            filter_glob=request.filter_glob,
> +                          filter=request.filter,
>                            build_dir=request.build_dir)
>         lines = kunit_parser.extract_tap_lines(output)
>         # Hack! Drop the dummy TAP version header that the executor prints out.
>         lines.pop()
>
>         # Filter out any extraneous non-test output that might have gotten mixed in.
> -       return [l for l in lines if re.match(r'^[^\s.]+\.[^\s.]+$', l)]
> +       return lines
>
>  def _suites_from_test_list(tests: List[str]) -> List[str]:
>         """Extracts all the suites from an ordered list of tests."""
> @@ -128,10 +152,18 @@ def _suites_from_test_list(tests: List[str]) -> List[str]:
>                         suites.append(suite)
>         return suites
>
> -
> -
>  def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -> KunitResult:
>         filter_globs = [request.filter_glob]
> +       if request.list_tests:
> +               output = _list_tests(linux, request)
> +               for line in output:
> +                       print(line.rstrip())
> +               return KunitResult(status=KunitStatus.SUCCESS, elapsed_time=0.0)
> +       if request.list_tests_attr:
> +               attr_output = _list_tests_attr(linux, request)
> +               for line in attr_output:
> +                       print(line.rstrip())
> +               return KunitResult(status=KunitStatus.SUCCESS, elapsed_time=0.0)
>         if request.run_isolated:
>                 tests = _list_tests(linux, request)
>                 if request.run_isolated == 'test':
> @@ -145,6 +177,17 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
>
>         metadata = kunit_json.Metadata(arch=linux.arch(), build_dir=request.build_dir, def_config='kunit_defconfig')
>
> +       filter = request.filter
> +       if request.filter_skip:
> +               args = ['kunit.filter_action=skip']
> +               filter = request.filter_skip
> +               if request.kernel_args:
> +                       args.extend(request.kernel_args)

What happens if both filter and filter_skip are set? We should
probably either make those mutually exclusive (error if both are set),
or expose filter_action directly instead.

> +       elif request.kernel_args:
> +               args = request.kernel_args
> +       else:
> +               args = None
> +
>         test_counts = kunit_parser.TestCounts()
>         exec_time = 0.0
>         for i, filter_glob in enumerate(filter_globs):
> @@ -152,9 +195,10 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
>
>                 test_start = time.time()
>                 run_result = linux.run_kernel(
> -                       args=request.kernel_args,
> +                       args=args,
>                         timeout=request.timeout,
>                         filter_glob=filter_glob,
> +                       filter=filter,
>                         build_dir=request.build_dir)
>
>                 _, test_result = parse_tests(request, metadata, run_result)
> @@ -341,6 +385,18 @@ def add_exec_opts(parser: argparse.ArgumentParser) -> None:
>                             nargs='?',
>                             default='',
>                             metavar='filter_glob')
> +       parser.add_argument('--filter',
> +                           help='Filter KUnit tests with attributes, '
> +                               'filtered tests will not run, '
> +                           'e.g. speed=fast or speed=>low',

Neither fast or low are valid values for speed now.

> +                           type=str,
> +                               default='')
> +       parser.add_argument('--filter_skip',
> +                           help='Filter KUnit tests run with attributes, '
> +                               'filtered tests will be skipped, '
> +                           'e.g. speed=fast or speed=>low',

Neither fast or low are valid values for speed now.



> +                           type=str,
> +                               default='')
>         parser.add_argument('--kernel_args',
>                             help='Kernel command-line parameters. Maybe be repeated',
>                              action='append', metavar='')
> @@ -350,6 +406,10 @@ def add_exec_opts(parser: argparse.ArgumentParser) -> None:
>                             'what ran before it.',
>                             type=str,
>                             choices=['suite', 'test'])
> +       parser.add_argument('--list_tests', help='If set, list all tests',
> +                           action='store_true')
> +       parser.add_argument('--list_tests_attr', help='If set, list all tests and attributes.',
> +                           action='store_true')
>
>  def add_parse_opts(parser: argparse.ArgumentParser) -> None:
>         parser.add_argument('--raw_output', help='If set don\'t parse output from kernel. '
> @@ -398,8 +458,12 @@ def run_handler(cli_args: argparse.Namespace) -> None:
>                                         json=cli_args.json,
>                                         timeout=cli_args.timeout,
>                                         filter_glob=cli_args.filter_glob,
> +                                       filter=cli_args.filter,
> +                                       filter_skip=cli_args.filter_skip,
>                                         kernel_args=cli_args.kernel_args,
> -                                       run_isolated=cli_args.run_isolated)
> +                                       run_isolated=cli_args.run_isolated,
> +                                       list_tests=cli_args.list_tests,
> +                                       list_tests_attr=cli_args.list_tests_attr)
>         result = run_tests(linux, request)
>         if result.status != KunitStatus.SUCCESS:
>                 sys.exit(1)
> @@ -441,8 +505,12 @@ def exec_handler(cli_args: argparse.Namespace) -> None:
>                                         json=cli_args.json,
>                                         timeout=cli_args.timeout,
>                                         filter_glob=cli_args.filter_glob,
> +                                       filter=cli_args.filter,
> +                                       filter_skip=cli_args.filter_skip,
>                                         kernel_args=cli_args.kernel_args,
> -                                       run_isolated=cli_args.run_isolated)
> +                                       run_isolated=cli_args.run_isolated,
> +                                       list_tests=cli_args.list_tests,
> +                                       list_tests_attr=cli_args.list_tests_attr)
>         result = exec_tests(linux, exec_request)
>         stdout.print_with_timestamp((
>                 'Elapsed time: %.3fs\n') % (result.elapsed_time))
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 7f648802caf6..281f062a4767 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -330,11 +330,13 @@ class LinuxSourceTree:
>                         return False
>                 return self.validate_config(build_dir)
>
> -       def run_kernel(self, args: Optional[List[str]]=None, build_dir: str='', filter_glob: str='', timeout: Optional[int]=None) -> Iterator[str]:
> +       def run_kernel(self, args: Optional[List[str]]=None, build_dir: str='', filter_glob: str='', filter: str='', timeout: Optional[int]=None) -> Iterator[str]:
>                 if not args:
>                         args = []
>                 if filter_glob:
> -                       args.append('kunit.filter_glob='+filter_glob)
> +                       args.append('kunit.filter_glob=' + filter_glob)
> +               if filter:
> +                       args.append('kunit.filter="' + filter + '"')
>                 args.append('kunit.enable=1')
>
>                 process = self._ops.start(args, build_dir)
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index be35999bb84f..85a1fb72735e 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -597,7 +597,7 @@ class KUnitMainTest(unittest.TestCase):
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> -                       args=None, build_dir='.kunit', filter_glob='', timeout=300)
> +                       args=None, build_dir='.kunit', filter_glob='', filter='', timeout=300)
>                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
>
>         def test_run_passes_args_pass(self):
> @@ -605,7 +605,7 @@ class KUnitMainTest(unittest.TestCase):
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> -                       args=None, build_dir='.kunit', filter_glob='', timeout=300)
> +                       args=None, build_dir='.kunit', filter_glob='', filter='', timeout=300)
>                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
>
>         def test_exec_passes_args_fail(self):
> @@ -629,7 +629,7 @@ class KUnitMainTest(unittest.TestCase):
>                         kunit.main(['run'])
>                 self.assertEqual(e.exception.code, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> -                       args=None, build_dir='.kunit', filter_glob='', timeout=300)
> +                       args=None, build_dir='.kunit', filter_glob='', filter='', timeout=300)
>                 self.print_mock.assert_any_call(StrContains(' 0 tests run!'))
>
>         def test_exec_raw_output(self):
> @@ -670,13 +670,13 @@ class KUnitMainTest(unittest.TestCase):
>                 self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
>                 kunit.main(['run', '--raw_output', 'filter_glob'])
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> -                       args=None, build_dir='.kunit', filter_glob='filter_glob', timeout=300)
> +                       args=None, build_dir='.kunit', filter_glob='filter_glob', filter='', timeout=300)
>
>         def test_exec_timeout(self):
>                 timeout = 3453
>                 kunit.main(['exec', '--timeout', str(timeout)])
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> -                       args=None, build_dir='.kunit', filter_glob='', timeout=timeout)
> +                       args=None, build_dir='.kunit', filter_glob='', filter='', timeout=timeout)
>                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
>
>         def test_run_timeout(self):
> @@ -684,7 +684,7 @@ class KUnitMainTest(unittest.TestCase):
>                 kunit.main(['run', '--timeout', str(timeout)])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> -                       args=None, build_dir='.kunit', filter_glob='', timeout=timeout)
> +                       args=None, build_dir='.kunit', filter_glob='', filter='', timeout=timeout)
>                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
>
>         def test_run_builddir(self):
> @@ -692,7 +692,7 @@ class KUnitMainTest(unittest.TestCase):
>                 kunit.main(['run', '--build_dir=.kunit'])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> -                       args=None, build_dir=build_dir, filter_glob='', timeout=300)
> +                       args=None, build_dir=build_dir, filter_glob='', filter='', timeout=300)
>                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
>
>         def test_config_builddir(self):
> @@ -710,7 +710,7 @@ class KUnitMainTest(unittest.TestCase):
>                 build_dir = '.kunit'
>                 kunit.main(['exec', '--build_dir', build_dir])
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> -                       args=None, build_dir=build_dir, filter_glob='', timeout=300)
> +                       args=None, build_dir=build_dir, filter_glob='', filter='', timeout=300)
>                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
>
>         def test_run_kunitconfig(self):
> @@ -786,7 +786,7 @@ class KUnitMainTest(unittest.TestCase):
>                 kunit.main(['run', '--kernel_args=a=1', '--kernel_args=b=2'])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> -                     args=['a=1','b=2'], build_dir='.kunit', filter_glob='', timeout=300)
> +                     args=['a=1','b=2'], build_dir='.kunit', filter_glob='', filter='', timeout=300)
>                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
>
>         def test_list_tests(self):
> @@ -794,13 +794,11 @@ class KUnitMainTest(unittest.TestCase):
>                 self.linux_source_mock.run_kernel.return_value = ['TAP version 14', 'init: random output'] + want
>
>                 got = kunit._list_tests(self.linux_source_mock,
> -                                    kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', None, 'suite'))
> -
> +                                    kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', '', '', None, 'suite', False, False))
>                 self.assertEqual(got, want)
>                 # Should respect the user's filter glob when listing tests.
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> -                       args=['kunit.action=list'], build_dir='.kunit', filter_glob='suite*', timeout=300)
> -
> +                       args=['kunit.action=list'], build_dir='.kunit', filter_glob='suite*', filter='', timeout=300)
>
>         @mock.patch.object(kunit, '_list_tests')
>         def test_run_isolated_by_suite(self, mock_tests):
> @@ -809,10 +807,10 @@ class KUnitMainTest(unittest.TestCase):
>
>                 # Should respect the user's filter glob when listing tests.
>                 mock_tests.assert_called_once_with(mock.ANY,
> -                                    kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*.test*', None, 'suite'))
> +                                    kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*.test*', '', '', None, 'suite', False, False))
>                 self.linux_source_mock.run_kernel.assert_has_calls([
> -                       mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', timeout=300),
> -                       mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', timeout=300),
> +                       mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', filter='', timeout=300),
> +                       mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', filter='', timeout=300),
>                 ])
>
>         @mock.patch.object(kunit, '_list_tests')
> @@ -822,13 +820,12 @@ class KUnitMainTest(unittest.TestCase):
>
>                 # Should respect the user's filter glob when listing tests.
>                 mock_tests.assert_called_once_with(mock.ANY,
> -                                    kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', None, 'test'))
> +                                    kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', '', '', None, 'test', False, False))
>                 self.linux_source_mock.run_kernel.assert_has_calls([
> -                       mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', timeout=300),
> -                       mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', timeout=300),
> -                       mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test1', timeout=300),
> +                       mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', filter='', timeout=300),
> +                       mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', filter='', timeout=300),
> +                       mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test1', filter='', timeout=300),
>                 ])
>
> -
>  if __name__ == '__main__':
>         unittest.main()
> --
> 2.41.0.255.g8b1d071c50-goog
>

--000000000000ea7e4d0600be0305
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
9IGQSBx2i4m+hGXJpET+MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCRI3Z4cAidgFcv
Usqdz765x6KMZSfg/WtFrYg8ewsP2NpCxVM2+EhPyyEQ0k0DhtzdtGoI/Ug+jdFDyCKB9P2+EPLh
iMjMnFILp7Zs4r18ECHlvZuDZfH9m0BchXIxu5jLIuQyKUWrCRDZZEDNr510ZhhVfYSFPA8ms1nk
jyzYFOHYQyv5IfML/3IBFKlON5OZa+V8EZYULYcNkp03DdWglafj7SXZ1/XgAbVYrC381UvrsYN8
jndVvoa1GWwe+NVlIIK7Q3uAjV3qLEDQpaNPg1rr0oAn6YmvTccjVMqj2YNwN+RHhKNzgRGxY5ct
FaN+8fXZhRhpv3bVbAWuPZXoMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBl
7oCwfZPski3GBzpOGhzmnySZcMNbv876s5ZUSN54HDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MTgwNzM5MjlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAH6ce+js0UdhhPeWQe1U8
gfCZ25aEGrJ7Gyi4uP+iGbpIQT9jJP7STJhyTfwJ4NkkKKfNZQO3k6I3jeQMYplcYeiCm0ue13sr
SEbs+SNtYo93+H6vaYEh8ue0HNL+PIF2Qe/ZpCZm6W2v2zMeRlD4H24oFI1nQcD8lYWChyif7158
wjnI2YsXN6bp+1d43q4fiFXl6Vc/+pj6e8aEUbD/Dw+cFOnMQWSoXUq61gV7QQ/hkxZuidvz83Hw
5MuJNIbJrtScST3p6a11b3PBD5qrI+X4G6eC/a6aCX/KTk/cxVS8wtxPoVzllGDiJPs34k88ErWx
HFx+hBJmnNrlSwMvmQ==
--000000000000ea7e4d0600be0305--
