Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A57C760D5D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 10:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjGYIoC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 04:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjGYInh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 04:43:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CC3268B
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 01:42:37 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so37885e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 01:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690274555; x=1690879355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UTlfLCTQDdYNnT4sdCUs0UbLqETwWl1AznO+clcmomg=;
        b=Ae9vqONnNaWh1yooVDWsWcqyZqk/KZr7/gnSdEX+FsA17XrkBLrClQCxo2IDMSCtJf
         5CHSftlg4tqTzJmhn4zBg3Tie/NdSuZpIypp7/qTcvyZx0jEwFVbNHzAV4smu42FyKUx
         PebFdHKd4q+sRnzo5Yy8pVfBbt8bB6hqCgFs+uqe5+z2gHxHHpsltM7TEoPvQ5C6TB5s
         3ZVwZ9Ku2sKu4+D9R3DHHUIXerBIEGUYN0pGru7MWUFgq4BubtMPm1Bc3el942Vyl7Br
         3PSYRD27EGJXKropLow6cjqsUJ3Y0Sqk5z4a9j2/gRtja4Z225xE5qoXAy0zIBUQXU06
         cr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274555; x=1690879355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTlfLCTQDdYNnT4sdCUs0UbLqETwWl1AznO+clcmomg=;
        b=R1INSz/T+1vfqTsEY2hd75kxECaQZxOrj1gccRme+ObiYm6a8xWdHpYaGo2X4nfa1t
         lz+mipyxYkUU5rpekvaOrmKXaVw2N2YtvIY1NPLInvoHhKY3pNwMpoWPpmUXAw9R/klS
         hsNQArkHClQ9T+A/2by8tEV0AGU3AQnUduqrejzEPoUwP9hDosiynoVvCY6rhBhfcYcz
         4E7HWvj6sVWFq0nYL5JTZKpoP1XOEZlGuq/FXy/XsE1VFfIk8aS+jg7UWpiKfeseG5tu
         BpYKXmpCv0O+9ojSUGs1vUrTV0mNWMxB1ovmS6lKFiQah44Xu4F7rkQMUWaM0uL7fSt6
         ZTZA==
X-Gm-Message-State: ABy/qLbR3yli54hwg2HeKYaLppZ5LiGz5eS5+Oi6WxPu2ZFg5x3OWB9B
        lBe82GTv0Kvek68z46VHHmKf79vtn+DZoVyuJnNkJw==
X-Google-Smtp-Source: APBJJlFRt3cwduziOFQ8rVhsPd05hwqCEzGZRceIdn41dig70hW30vmUcd/nwwQQ697yy+IHDz5v1xiQCq7Vz1+i6GY=
X-Received: by 2002:a7b:cd93:0:b0:3f6:f4b:d4a6 with SMTP id
 y19-20020a7bcd93000000b003f60f4bd4a6mr33475wmj.7.1690274555439; Tue, 25 Jul
 2023 01:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230724162834.1354164-1-rmoar@google.com> <20230724162834.1354164-6-rmoar@google.com>
In-Reply-To: <20230724162834.1354164-6-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 25 Jul 2023 16:42:23 +0800
Message-ID: <CABVgOS=R8OvM8JJr35ap1F_srw19M85Vr_7=KVmscOz0=bzC4g@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] kunit: tool: Add command line interface to filter
 and report attributes
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000078ea4406014bb62b"
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

--00000000000078ea4406014bb62b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Jul 2023 at 00:30, Rae Moar <rmoar@google.com> wrote:
>
> Add ability to kunit.py to filter attributes and report a list of tests
> including attributes without running tests.
>
> Add flag "--filter" to input filters on test attributes. Tests will be
> filtered out if they do not match all inputted filters.
>
> Example: --filter speed=3Dslow (This filter would run only the tests that=
 are
> marked as slow)
>
> Filters have operations: <, >, <=3D, >=3D, !=3D, and =3D. But note that t=
he
> characters < and > are often interpreted by the shell, so they may need t=
o
> be quoted or escaped.
>
> Example: --filter "speed>slow" or --filter speed\>slow (This filter would
> run only the tests that have the speed faster than slow.
>
> Additionally, multiple filters can be used.
>
> Example: --filter "speed=3Dslow, module!=3Dexample" (This filter would ru=
n
> only the tests that have the speed slow and are not in the "example"
> module)
>
> Note if the user wants to skip filtered tests instead of not
> running/showing them use the "--filter_action=3Dskip" flag.
>
> Expose the output of kunit.action=3Dlist option with flag "--list_tests" =
to
> output a list of tests. Additionally, add flag "--list_tests_attr" to
> output a list of tests and their attributes. These flags are useful to se=
e
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

Looks good, working well here.

Reviewed-by: David Gow <davidgow@google.com>


-- David

>
> Changes since v1:
> - No major changes
>
> Changes since RFC v2:
> - Remove --filter_skip flag and replace with =E2=80=93-filter_action
> - Make KUnit executor errors visible in kunit.py and raw_output
> - Fix up help comments
>
> Changes since RFC v1:
> - Change method for inputting filters to allow for spaces in filtering
>   values
> - Add option to skip filtered tests instead of not run or show them with
>   the -=E2=80=93filter_skip flag
> - Separate the new feature to list tests and their attributes into both
>   =E2=80=93-list_tests (lists just tests) and =E2=80=93-list_tests_attr (=
lists all)
>
>  tools/testing/kunit/kunit.py           | 70 ++++++++++++++++++++++++--
>  tools/testing/kunit/kunit_kernel.py    |  8 ++-
>  tools/testing/kunit/kunit_parser.py    | 11 +++-
>  tools/testing/kunit/kunit_tool_test.py | 39 +++++++-------
>  4 files changed, 99 insertions(+), 29 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 3905c43369c3..bc74088c458a 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -55,8 +55,12 @@ class KunitExecRequest(KunitParseRequest):
>         build_dir: str
>         timeout: int
>         filter_glob: str
> +       filter: str
> +       filter_action: Optional[str]
>         kernel_args: Optional[List[str]]
>         run_isolated: Optional[str]
> +       list_tests: bool
> +       list_tests_attr: bool
>
>  @dataclass
>  class KunitRequest(KunitExecRequest, KunitBuildRequest):
> @@ -102,19 +106,41 @@ def config_and_build_tests(linux: kunit_kernel.Linu=
xSourceTree,
>
>  def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecR=
equest) -> List[str]:
>         args =3D ['kunit.action=3Dlist']
> +
> +       if request.kernel_args:
> +               args.extend(request.kernel_args)
> +
> +       output =3D linux.run_kernel(args=3Dargs,
> +                          timeout=3Drequest.timeout,
> +                          filter_glob=3Drequest.filter_glob,
> +                          filter=3Drequest.filter,
> +                          filter_action=3Drequest.filter_action,
> +                          build_dir=3Drequest.build_dir)
> +       lines =3D kunit_parser.extract_tap_lines(output)
> +       # Hack! Drop the dummy TAP version header that the executor print=
s out.
> +       lines.pop()
> +
> +       # Filter out any extraneous non-test output that might have gotte=
n mixed in.
> +       return [l for l in output if re.match(r'^[^\s.]+\.[^\s.]+$', l)]
> +
> +def _list_tests_attr(linux: kunit_kernel.LinuxSourceTree, request: Kunit=
ExecRequest) -> Iterable[str]:
> +       args =3D ['kunit.action=3Dlist_attr']
> +
>         if request.kernel_args:
>                 args.extend(request.kernel_args)
>
>         output =3D linux.run_kernel(args=3Dargs,
>                            timeout=3Drequest.timeout,
>                            filter_glob=3Drequest.filter_glob,
> +                          filter=3Drequest.filter,
> +                          filter_action=3Drequest.filter_action,
>                            build_dir=3Drequest.build_dir)
>         lines =3D kunit_parser.extract_tap_lines(output)
>         # Hack! Drop the dummy TAP version header that the executor print=
s out.
>         lines.pop()
>
>         # Filter out any extraneous non-test output that might have gotte=
n mixed in.
> -       return [l for l in lines if re.match(r'^[^\s.]+\.[^\s.]+$', l)]
> +       return lines
>
>  def _suites_from_test_list(tests: List[str]) -> List[str]:
>         """Extracts all the suites from an ordered list of tests."""
> @@ -128,10 +154,18 @@ def _suites_from_test_list(tests: List[str]) -> Lis=
t[str]:
>                         suites.append(suite)
>         return suites
>
> -
> -
>  def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRe=
quest) -> KunitResult:
>         filter_globs =3D [request.filter_glob]
> +       if request.list_tests:
> +               output =3D _list_tests(linux, request)
> +               for line in output:
> +                       print(line.rstrip())
> +               return KunitResult(status=3DKunitStatus.SUCCESS, elapsed_=
time=3D0.0)
> +       if request.list_tests_attr:
> +               attr_output =3D _list_tests_attr(linux, request)
> +               for line in attr_output:
> +                       print(line.rstrip())
> +               return KunitResult(status=3DKunitStatus.SUCCESS, elapsed_=
time=3D0.0)
>         if request.run_isolated:
>                 tests =3D _list_tests(linux, request)
>                 if request.run_isolated =3D=3D 'test':
> @@ -155,6 +189,8 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, r=
equest: KunitExecRequest) -
>                         args=3Drequest.kernel_args,
>                         timeout=3Drequest.timeout,
>                         filter_glob=3Dfilter_glob,
> +                       filter=3Drequest.filter,
> +                       filter_action=3Drequest.filter_action,
>                         build_dir=3Drequest.build_dir)
>
>                 _, test_result =3D parse_tests(request, metadata, run_res=
ult)
> @@ -341,6 +377,16 @@ def add_exec_opts(parser: argparse.ArgumentParser) -=
> None:
>                             nargs=3D'?',
>                             default=3D'',
>                             metavar=3D'filter_glob')
> +       parser.add_argument('--filter',
> +                           help=3D'Filter KUnit tests with attributes, '
> +                           'e.g. module=3Dexample or speed>slow',
> +                           type=3Dstr,
> +                               default=3D'')
> +       parser.add_argument('--filter_action',
> +                           help=3D'If set to skip, filtered tests will b=
e skipped, '
> +                               'e.g. --filter_action=3Dskip. Otherwise t=
hey will not run.',
> +                           type=3Dstr,
> +                               choices=3D['skip'])
>         parser.add_argument('--kernel_args',
>                             help=3D'Kernel command-line parameters. Maybe=
 be repeated',
>                              action=3D'append', metavar=3D'')
> @@ -350,6 +396,12 @@ def add_exec_opts(parser: argparse.ArgumentParser) -=
> None:
>                             'what ran before it.',
>                             type=3Dstr,
>                             choices=3D['suite', 'test'])
> +       parser.add_argument('--list_tests', help=3D'If set, list all test=
s that will be '
> +                           'run.',
> +                           action=3D'store_true')
> +       parser.add_argument('--list_tests_attr', help=3D'If set, list all=
 tests and test '
> +                           'attributes.',
> +                           action=3D'store_true')
>
>  def add_parse_opts(parser: argparse.ArgumentParser) -> None:
>         parser.add_argument('--raw_output', help=3D'If set don\'t parse o=
utput from kernel. '
> @@ -398,8 +450,12 @@ def run_handler(cli_args: argparse.Namespace) -> Non=
e:
>                                         json=3Dcli_args.json,
>                                         timeout=3Dcli_args.timeout,
>                                         filter_glob=3Dcli_args.filter_glo=
b,
> +                                       filter=3Dcli_args.filter,
> +                                       filter_action=3Dcli_args.filter_a=
ction,
>                                         kernel_args=3Dcli_args.kernel_arg=
s,
> -                                       run_isolated=3Dcli_args.run_isola=
ted)
> +                                       run_isolated=3Dcli_args.run_isola=
ted,
> +                                       list_tests=3Dcli_args.list_tests,
> +                                       list_tests_attr=3Dcli_args.list_t=
ests_attr)
>         result =3D run_tests(linux, request)
>         if result.status !=3D KunitStatus.SUCCESS:
>                 sys.exit(1)
> @@ -441,8 +497,12 @@ def exec_handler(cli_args: argparse.Namespace) -> No=
ne:
>                                         json=3Dcli_args.json,
>                                         timeout=3Dcli_args.timeout,
>                                         filter_glob=3Dcli_args.filter_glo=
b,
> +                                       filter=3Dcli_args.filter,
> +                                       filter_action=3Dcli_args.filter_a=
ction,
>                                         kernel_args=3Dcli_args.kernel_arg=
s,
> -                                       run_isolated=3Dcli_args.run_isola=
ted)
> +                                       run_isolated=3Dcli_args.run_isola=
ted,
> +                                       list_tests=3Dcli_args.list_tests,
> +                                       list_tests_attr=3Dcli_args.list_t=
ests_attr)
>         result =3D exec_tests(linux, exec_request)
>         stdout.print_with_timestamp((
>                 'Elapsed time: %.3fs\n') % (result.elapsed_time))
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/ku=
nit_kernel.py
> index 7f648802caf6..0b6488efed47 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -330,11 +330,15 @@ class LinuxSourceTree:
>                         return False
>                 return self.validate_config(build_dir)
>
> -       def run_kernel(self, args: Optional[List[str]]=3DNone, build_dir:=
 str=3D'', filter_glob: str=3D'', timeout: Optional[int]=3DNone) -> Iterato=
r[str]:
> +       def run_kernel(self, args: Optional[List[str]]=3DNone, build_dir:=
 str=3D'', filter_glob: str=3D'', filter: str=3D'', filter_action: Optional=
[str]=3DNone, timeout: Optional[int]=3DNone) -> Iterator[str]:
>                 if not args:
>                         args =3D []
>                 if filter_glob:
> -                       args.append('kunit.filter_glob=3D'+filter_glob)
> +                       args.append('kunit.filter_glob=3D' + filter_glob)
> +               if filter:
> +                       args.append('kunit.filter=3D"' + filter + '"')
> +               if filter_action:
> +                       args.append('kunit.filter_action=3D' + filter_act=
ion)
>                 args.append('kunit.enable=3D1')
>
>                 process =3D self._ops.start(args, build_dir)
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/ku=
nit_parser.py
> index fbc094f0567e..79d8832c862a 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -212,6 +212,7 @@ KTAP_START =3D re.compile(r'\s*KTAP version ([0-9]+)$=
')
>  TAP_START =3D re.compile(r'\s*TAP version ([0-9]+)$')
>  KTAP_END =3D re.compile(r'\s*(List of all partitions:|'
>         'Kernel panic - not syncing: VFS:|reboot: System halted)')
> +EXECUTOR_ERROR =3D re.compile(r'\s*kunit executor: (.*)$')
>
>  def extract_tap_lines(kernel_output: Iterable[str]) -> LineStream:
>         """Extracts KTAP lines from the kernel output."""
> @@ -242,6 +243,8 @@ def extract_tap_lines(kernel_output: Iterable[str]) -=
> LineStream:
>                                 # remove the prefix, if any.
>                                 line =3D line[prefix_len:]
>                                 yield line_num, line
> +                       elif EXECUTOR_ERROR.search(line):
> +                               yield line_num, line
>         return LineStream(lines=3Disolate_ktap_output(kernel_output))
>
>  KTAP_VERSIONS =3D [1]
> @@ -447,7 +450,7 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
>         Log of diagnostic lines
>         """
>         log =3D []  # type: List[str]
> -       non_diagnostic_lines =3D [TEST_RESULT, TEST_HEADER, KTAP_START]
> +       non_diagnostic_lines =3D [TEST_RESULT, TEST_HEADER, KTAP_START, T=
AP_START]
>         while lines and not any(re.match(lines.peek())
>                         for re in non_diagnostic_lines):
>                 log.append(lines.pop())
> @@ -713,6 +716,11 @@ def parse_test(lines: LineStream, expected_num: int,=
 log: List[str], is_subtest:
>         """
>         test =3D Test()
>         test.log.extend(log)
> +
> +       # Parse any errors prior to parsing tests
> +       err_log =3D parse_diagnostic(lines)
> +       test.log.extend(err_log)
> +
>         if not is_subtest:
>                 # If parsing the main/top-level test, parse KTAP version =
line and
>                 # test plan
> @@ -774,6 +782,7 @@ def parse_test(lines: LineStream, expected_num: int, =
log: List[str], is_subtest:
>                 # Don't override a bad status if this test had one report=
ed.
>                 # Assumption: no subtests means CRASHED is from Test.__in=
it__()
>                 if test.status in (TestStatus.TEST_CRASHED, TestStatus.SU=
CCESS):
> +                       print_log(test.log)
>                         test.status =3D TestStatus.NO_TESTS
>                         test.add_error('0 tests run!')
>
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit=
/kunit_tool_test.py
> index be35999bb84f..b28c1510be2e 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -597,7 +597,7 @@ class KUnitMainTest(unittest.TestCase):
>                 self.assertEqual(self.linux_source_mock.build_reconfig.ca=
ll_count, 0)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_c=
ount, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', timeout=3D300)
> +                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', filter=3D'', filter_action=3DNone, timeout=3D300)
>                 self.print_mock.assert_any_call(StrContains('Testing comp=
lete.'))
>
>         def test_run_passes_args_pass(self):
> @@ -605,7 +605,7 @@ class KUnitMainTest(unittest.TestCase):
>                 self.assertEqual(self.linux_source_mock.build_reconfig.ca=
ll_count, 1)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_c=
ount, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', timeout=3D300)
> +                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', filter=3D'', filter_action=3DNone, timeout=3D300)
>                 self.print_mock.assert_any_call(StrContains('Testing comp=
lete.'))
>
>         def test_exec_passes_args_fail(self):
> @@ -629,7 +629,7 @@ class KUnitMainTest(unittest.TestCase):
>                         kunit.main(['run'])
>                 self.assertEqual(e.exception.code, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', timeout=3D300)
> +                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', filter=3D'', filter_action=3DNone, timeout=3D300)
>                 self.print_mock.assert_any_call(StrContains(' 0 tests run=
!'))
>
>         def test_exec_raw_output(self):
> @@ -670,13 +670,13 @@ class KUnitMainTest(unittest.TestCase):
>                 self.linux_source_mock.run_kernel =3D mock.Mock(return_va=
lue=3D[])
>                 kunit.main(['run', '--raw_output', 'filter_glob'])
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'filter_glob', timeout=3D300)
> +                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'filter_glob', filter=3D'', filter_action=3DNone, timeout=3D300)
>
>         def test_exec_timeout(self):
>                 timeout =3D 3453
>                 kunit.main(['exec', '--timeout', str(timeout)])
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', timeout=3Dtimeout)
> +                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', filter=3D'', filter_action=3DNone, timeout=3Dtimeout)
>                 self.print_mock.assert_any_call(StrContains('Testing comp=
lete.'))
>
>         def test_run_timeout(self):
> @@ -684,7 +684,7 @@ class KUnitMainTest(unittest.TestCase):
>                 kunit.main(['run', '--timeout', str(timeout)])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.ca=
ll_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', timeout=3Dtimeout)
> +                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', filter=3D'', filter_action=3DNone, timeout=3Dtimeout)
>                 self.print_mock.assert_any_call(StrContains('Testing comp=
lete.'))
>
>         def test_run_builddir(self):
> @@ -692,7 +692,7 @@ class KUnitMainTest(unittest.TestCase):
>                 kunit.main(['run', '--build_dir=3D.kunit'])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.ca=
ll_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                       args=3DNone, build_dir=3Dbuild_dir, filter_glob=
=3D'', timeout=3D300)
> +                       args=3DNone, build_dir=3Dbuild_dir, filter_glob=
=3D'', filter=3D'', filter_action=3DNone, timeout=3D300)
>                 self.print_mock.assert_any_call(StrContains('Testing comp=
lete.'))
>
>         def test_config_builddir(self):
> @@ -710,7 +710,7 @@ class KUnitMainTest(unittest.TestCase):
>                 build_dir =3D '.kunit'
>                 kunit.main(['exec', '--build_dir', build_dir])
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                       args=3DNone, build_dir=3Dbuild_dir, filter_glob=
=3D'', timeout=3D300)
> +                       args=3DNone, build_dir=3Dbuild_dir, filter_glob=
=3D'', filter=3D'', filter_action=3DNone, timeout=3D300)
>                 self.print_mock.assert_any_call(StrContains('Testing comp=
lete.'))
>
>         def test_run_kunitconfig(self):
> @@ -786,7 +786,7 @@ class KUnitMainTest(unittest.TestCase):
>                 kunit.main(['run', '--kernel_args=3Da=3D1', '--kernel_arg=
s=3Db=3D2'])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.ca=
ll_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                     args=3D['a=3D1','b=3D2'], build_dir=3D'.kunit', fil=
ter_glob=3D'', timeout=3D300)
> +                     args=3D['a=3D1','b=3D2'], build_dir=3D'.kunit', fil=
ter_glob=3D'', filter=3D'', filter_action=3DNone, timeout=3D300)
>                 self.print_mock.assert_any_call(StrContains('Testing comp=
lete.'))
>
>         def test_list_tests(self):
> @@ -794,13 +794,11 @@ class KUnitMainTest(unittest.TestCase):
>                 self.linux_source_mock.run_kernel.return_value =3D ['TAP =
version 14', 'init: random output'] + want
>
>                 got =3D kunit._list_tests(self.linux_source_mock,
> -                                    kunit.KunitExecRequest(None, None, '=
.kunit', 300, 'suite*', None, 'suite'))
> -
> +                                    kunit.KunitExecRequest(None, None, '=
.kunit', 300, 'suite*', '', None, None, 'suite', False, False))
>                 self.assertEqual(got, want)
>                 # Should respect the user's filter glob when listing test=
s.
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                       args=3D['kunit.action=3Dlist'], build_dir=3D'.kun=
it', filter_glob=3D'suite*', timeout=3D300)
> -
> +                       args=3D['kunit.action=3Dlist'], build_dir=3D'.kun=
it', filter_glob=3D'suite*', filter=3D'', filter_action=3DNone, timeout=3D3=
00)
>
>         @mock.patch.object(kunit, '_list_tests')
>         def test_run_isolated_by_suite(self, mock_tests):
> @@ -809,10 +807,10 @@ class KUnitMainTest(unittest.TestCase):
>
>                 # Should respect the user's filter glob when listing test=
s.
>                 mock_tests.assert_called_once_with(mock.ANY,
> -                                    kunit.KunitExecRequest(None, None, '=
.kunit', 300, 'suite*.test*', None, 'suite'))
> +                                    kunit.KunitExecRequest(None, None, '=
.kunit', 300, 'suite*.test*', '', None, None, 'suite', False, False))
>                 self.linux_source_mock.run_kernel.assert_has_calls([
> -                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite.test*', timeout=3D300),
> -                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite2.test*', timeout=3D300),
> +                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite.test*', filter=3D'', filter_action=3DNone, timeout=3D300),
> +                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite2.test*', filter=3D'', filter_action=3DNone, timeout=3D300)=
,
>                 ])
>
>         @mock.patch.object(kunit, '_list_tests')
> @@ -822,13 +820,12 @@ class KUnitMainTest(unittest.TestCase):
>
>                 # Should respect the user's filter glob when listing test=
s.
>                 mock_tests.assert_called_once_with(mock.ANY,
> -                                    kunit.KunitExecRequest(None, None, '=
.kunit', 300, 'suite*', None, 'test'))
> +                                    kunit.KunitExecRequest(None, None, '=
.kunit', 300, 'suite*', '', None, None, 'test', False, False))
>                 self.linux_source_mock.run_kernel.assert_has_calls([
> -                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite.test1', timeout=3D300),
> -                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite.test2', timeout=3D300),
> -                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite2.test1', timeout=3D300),
> +                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite.test1', filter=3D'', filter_action=3DNone, timeout=3D300),
> +                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite.test2', filter=3D'', filter_action=3DNone, timeout=3D300),
> +                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite2.test1', filter=3D'', filter_action=3DNone, timeout=3D300)=
,
>                 ])
>
> -
>  if __name__ =3D=3D '__main__':
>         unittest.main()
> --
> 2.41.0.487.g6d72f3e995-goog
>

--00000000000078ea4406014bb62b
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA3
4p3b2Thc3ulFKIHsb0nJrAF6B5emHJ8LUWAbsd8NCzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MjUwODQyMzVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAYDKGT/KfKnJp0YLym+bF
HI6wafdusN4ji/ko994sD9nOymP5IfoJRdROHfV10WO0C1jCei6etCo9d1TTf2vpHjb6t087PisQ
PGlsCXyzz5HtJG/1pwSR+jnJHYJFfsNbij0FCl/zm1c72Npme5FwCF4+KFHzdfSbaFjDQ/dQiYaR
kq0EzUBkHnkURNuf1rmDba6MqEgaxQwjOv8oiRds9REk8njTXisAeSxDglDPv8heNGSj1gDIZ/b3
P2xoZUbci21P2IL3EvpGSqyUS8aOcxEjA2iaIi50GwJwFwB8boY5ynt2AwVhseHxmMAXVEZ3DACj
rXpZKCT2ggYPA1EzHA==
--00000000000078ea4406014bb62b--
