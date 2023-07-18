Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50EA758634
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 22:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjGRUnE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 16:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGRUnD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 16:43:03 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181E41992
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 13:43:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so117025e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 13:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689712978; x=1692304978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnfR6ox4zAw+ceAH15oEj3Ni1pPPnbtuF8M4evtF0qE=;
        b=615HuIqu9fM0riA1OPplRhgJvxgQWus4XPJlr7DUbNmhrFetL25Zjfkubol2DAUxY8
         MyBxW3xIt9SZUVsrN1DZbwHy4+PgBPsM5jp8l6q90J2/XsOcuJ2ItBCleBQ9LWLof1Fq
         QfRATGOtlAhTiAArjs+Q+Ke6dAIYaqm5wmZacwQWjeMkyQmeshorCzz/64kijcEEszJT
         NUeSLcgLvQiEWgqjvuTH6z5z7aPz8Jw7B4WNPSX9PB0kjb3WhXwYQIXWSO4OGRgeXmhZ
         66SpD03m0hQBDL1JzrsuSOq/tQOA2F2251uXC3Ch4N/7BLw0AV06hvDJ69dtAhBzIr+K
         I66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689712978; x=1692304978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnfR6ox4zAw+ceAH15oEj3Ni1pPPnbtuF8M4evtF0qE=;
        b=PQfZROVat6mAiUQOZSOCtFXNvK5fcWo+UEUTsQnJ9bo5cqzudsOS1zRDizZ0hhZ5WB
         S29qOIGLnLteVVSFdU1bjEwSc1bHsB/bBl0Vm0PFrejjgeGWDoVSCSVLitMoMPmFwPg8
         vqXAAdnZ6olVBuj3g7b5B2pwjMm0lb1r3hL6U6tZ4oPqqoSK75BIjO4hDsl6ifs3J2TC
         bhgtmAyjVegiucPH2EtWbiUgligmbIoLJ5+a7xP+HgvfmxagUeZXmQ5XfSTzQc3iI+Gc
         Zz9OeX8gn6ke9Vz0UxhkeV7jqL5J+V6ytVYZ6ZjbonQ+aTXHqnfedo4sj++iAwvhNvSb
         pr5Q==
X-Gm-Message-State: ABy/qLbOTLPSUfE8kCRFLgvhqcOoJRDnKtYMYihBAuIh3g0VmwVZo9uw
        dXck0vl1yCWHmgFiIIBx8D0ROMJLyH1WnBl9RCVu0Q==
X-Google-Smtp-Source: APBJJlE7wLb0fMOkKC4SCAN1vQm9nGgdtmPp6r/wi9J988vboQQNSCVrvtKtJzL32P1AoXEFsff9dpwuv726WWxVjxY=
X-Received: by 2002:a05:600c:3ba8:b0:3f1:6fe9:4a95 with SMTP id
 n40-20020a05600c3ba800b003f16fe94a95mr162289wms.4.1689712978339; Tue, 18 Jul
 2023 13:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com> <20230707210947.1208717-6-rmoar@google.com>
 <CABVgOSntWgQPw63Kv4bkVrOPNR-CJLE-Vv=XK+WMAdH6qL10bw@mail.gmail.com>
In-Reply-To: <CABVgOSntWgQPw63Kv4bkVrOPNR-CJLE-Vv=XK+WMAdH6qL10bw@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 18 Jul 2023 16:42:44 -0400
Message-ID: <CA+GJov4k5bieqQyEnFWsa2jnX+jj--BtToS+2jAjei4D-4zfYw@mail.gmail.com>
Subject: Re: [RFC v2 5/9] kunit: tool: Add command line interface to filter
 and report attributes
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 18, 2023 at 3:39=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Sat, 8 Jul 2023 at 05:10, Rae Moar <rmoar@google.com> wrote:
> >
> > Add ability to kunit.py to filter attributes and report a list of tests
> > including attributes without running tests.
> >
> > Add flag "--filter" to input filters on test attributes. Tests will be
> > filtered out if they do not match all inputted filters.
> >
> > Example: --filter speed=3Dslow (This filter would run only the tests th=
at are
> > marked as slow)
> >
> > Filters have operations: <, >, <=3D, >=3D, !=3D, and =3D. But note that=
 the
> > characters < and > are often interpreted by the shell, so they may need=
 to
> > be quoted or escaped.
> >
> > Example: --filter "speed>slow" or --filter speed\>slow (This filter wou=
ld
> > run only the tests that have the speed faster than slow.
> >
> > Additionally, multiple filters can be used.
> >
> > Example: --filter "speed=3Dslow, module!=3Dexample" (This filter would =
run
> > only the tests that have the speed slow and are not in the "example"
> > module)
> >
> > Note if the user wants to skip filtered tests instead of not
> > running/showing them use the "--filter_skip" flag instead.
> >
> > Expose the output of kunit.action=3Dlist option with flag "--list_tests=
" to
> > output a list of tests. Additionally, add flag "--list_tests_attr" to
> > output a list of tests and their attributes. These flags are useful to =
see
> > tests and test attributes without needing to run tests.
> >
> > Example of the output of "--list_tests_attr":
> >   example
> >   example.test_1
> >   example.test_2
> >   # example.test_2.speed: slow
> >
> > This output includes a suite, example, with two test cases, test_1 and
> > test_2. And in this instance test_2 has been marked as slow.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
> >
> > Changes since v1:
> > - Change method for inputting filters to allow for spaces in filtering
> >   values
> > - Add option to skip filtered tests instead of not run or show them wit=
h
> >   the --filter_skip flag
> > - Separate the new feature to list tests and their attributes into both
> >   --list_tests (lists just tests) and --list_tests_attr (lists all)
> >
> >  tools/testing/kunit/kunit.py           | 80 ++++++++++++++++++++++++--
> >  tools/testing/kunit/kunit_kernel.py    |  6 +-
> >  tools/testing/kunit/kunit_tool_test.py | 39 ++++++-------
> >  3 files changed, 96 insertions(+), 29 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.p=
y
> > index 3905c43369c3..6104e622ce20 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -55,8 +55,12 @@ class KunitExecRequest(KunitParseRequest):
> >         build_dir: str
> >         timeout: int
> >         filter_glob: str
> > +       filter: str
> > +       filter_skip: str
> >         kernel_args: Optional[List[str]]
> >         run_isolated: Optional[str]
> > +       list_tests: bool
> > +       list_tests_attr: bool
> >
> >  @dataclass
> >  class KunitRequest(KunitExecRequest, KunitBuildRequest):
> > @@ -102,19 +106,39 @@ def config_and_build_tests(linux: kunit_kernel.Li=
nuxSourceTree,
> >
> >  def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExe=
cRequest) -> List[str]:
> >         args =3D ['kunit.action=3Dlist']
> > +
> > +       if request.kernel_args:
> > +               args.extend(request.kernel_args)
> > +
> > +       output =3D linux.run_kernel(args=3Dargs,
> > +                          timeout=3Drequest.timeout,
> > +                          filter_glob=3Drequest.filter_glob,
> > +                          filter=3Drequest.filter,
> > +                          build_dir=3Drequest.build_dir)
> > +       lines =3D kunit_parser.extract_tap_lines(output)
> > +       # Hack! Drop the dummy TAP version header that the executor pri=
nts out.
> > +       lines.pop()
> > +
> > +       # Filter out any extraneous non-test output that might have got=
ten mixed in.
> > +       return [l for l in output if re.match(r'^[^\s.]+\.[^\s.]+$', l)=
]
> > +
> > +def _list_tests_attr(linux: kunit_kernel.LinuxSourceTree, request: Kun=
itExecRequest) -> Iterable[str]:
> > +       args =3D ['kunit.action=3Dlist_attr']
> > +
> >         if request.kernel_args:
> >                 args.extend(request.kernel_args)
> >
> >         output =3D linux.run_kernel(args=3Dargs,
> >                            timeout=3Drequest.timeout,
> >                            filter_glob=3Drequest.filter_glob,
> > +                          filter=3Drequest.filter,
> >                            build_dir=3Drequest.build_dir)
> >         lines =3D kunit_parser.extract_tap_lines(output)
> >         # Hack! Drop the dummy TAP version header that the executor pri=
nts out.
> >         lines.pop()
> >
> >         # Filter out any extraneous non-test output that might have got=
ten mixed in.
> > -       return [l for l in lines if re.match(r'^[^\s.]+\.[^\s.]+$', l)]
> > +       return lines
> >
> >  def _suites_from_test_list(tests: List[str]) -> List[str]:
> >         """Extracts all the suites from an ordered list of tests."""
> > @@ -128,10 +152,18 @@ def _suites_from_test_list(tests: List[str]) -> L=
ist[str]:
> >                         suites.append(suite)
> >         return suites
> >
> > -
> > -
> >  def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExec=
Request) -> KunitResult:
> >         filter_globs =3D [request.filter_glob]
> > +       if request.list_tests:
> > +               output =3D _list_tests(linux, request)
> > +               for line in output:
> > +                       print(line.rstrip())
> > +               return KunitResult(status=3DKunitStatus.SUCCESS, elapse=
d_time=3D0.0)
> > +       if request.list_tests_attr:
> > +               attr_output =3D _list_tests_attr(linux, request)
> > +               for line in attr_output:
> > +                       print(line.rstrip())
> > +               return KunitResult(status=3DKunitStatus.SUCCESS, elapse=
d_time=3D0.0)
> >         if request.run_isolated:
> >                 tests =3D _list_tests(linux, request)
> >                 if request.run_isolated =3D=3D 'test':
> > @@ -145,6 +177,17 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree=
, request: KunitExecRequest) -
> >
> >         metadata =3D kunit_json.Metadata(arch=3Dlinux.arch(), build_dir=
=3Drequest.build_dir, def_config=3D'kunit_defconfig')
> >
> > +       filter =3D request.filter
> > +       if request.filter_skip:
> > +               args =3D ['kunit.filter_action=3Dskip']
> > +               filter =3D request.filter_skip
> > +               if request.kernel_args:
> > +                       args.extend(request.kernel_args)
>
> What happens if both filter and filter_skip are set? We should
> probably either make those mutually exclusive (error if both are set),
> or expose filter_action directly instead.

That's a great idea. I wouldn't mind just using filter_action instead
of filter_skip. I will change this for the next version.

>
> > +       elif request.kernel_args:
> > +               args =3D request.kernel_args
> > +       else:
> > +               args =3D None
> > +
> >         test_counts =3D kunit_parser.TestCounts()
> >         exec_time =3D 0.0
> >         for i, filter_glob in enumerate(filter_globs):
> > @@ -152,9 +195,10 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree=
, request: KunitExecRequest) -
> >
> >                 test_start =3D time.time()
> >                 run_result =3D linux.run_kernel(
> > -                       args=3Drequest.kernel_args,
> > +                       args=3Dargs,
> >                         timeout=3Drequest.timeout,
> >                         filter_glob=3Dfilter_glob,
> > +                       filter=3Dfilter,
> >                         build_dir=3Drequest.build_dir)
> >
> >                 _, test_result =3D parse_tests(request, metadata, run_r=
esult)
> > @@ -341,6 +385,18 @@ def add_exec_opts(parser: argparse.ArgumentParser)=
 -> None:
> >                             nargs=3D'?',
> >                             default=3D'',
> >                             metavar=3D'filter_glob')
> > +       parser.add_argument('--filter',
> > +                           help=3D'Filter KUnit tests with attributes,=
 '
> > +                               'filtered tests will not run, '
> > +                           'e.g. speed=3Dfast or speed=3D>low',
>
> Neither fast or low are valid values for speed now.

Sorry about this. I have changed this for the next version.

>
> > +                           type=3Dstr,
> > +                               default=3D'')
> > +       parser.add_argument('--filter_skip',
> > +                           help=3D'Filter KUnit tests run with attribu=
tes, '
> > +                               'filtered tests will be skipped, '
> > +                           'e.g. speed=3Dfast or speed=3D>low',
>
> Neither fast or low are valid values for speed now.
>
>

Oops. I have changed this for the next version.

>
> > +                           type=3Dstr,
> > +                               default=3D'')
> >         parser.add_argument('--kernel_args',
> >                             help=3D'Kernel command-line parameters. May=
be be repeated',
> >                              action=3D'append', metavar=3D'')
> > @@ -350,6 +406,10 @@ def add_exec_opts(parser: argparse.ArgumentParser)=
 -> None:
> >                             'what ran before it.',
> >                             type=3Dstr,
> >                             choices=3D['suite', 'test'])
> > +       parser.add_argument('--list_tests', help=3D'If set, list all te=
sts',
> > +                           action=3D'store_true')
> > +       parser.add_argument('--list_tests_attr', help=3D'If set, list a=
ll tests and attributes.',
> > +                           action=3D'store_true')
> >
> >  def add_parse_opts(parser: argparse.ArgumentParser) -> None:
> >         parser.add_argument('--raw_output', help=3D'If set don\'t parse=
 output from kernel. '
> > @@ -398,8 +458,12 @@ def run_handler(cli_args: argparse.Namespace) -> N=
one:
> >                                         json=3Dcli_args.json,
> >                                         timeout=3Dcli_args.timeout,
> >                                         filter_glob=3Dcli_args.filter_g=
lob,
> > +                                       filter=3Dcli_args.filter,
> > +                                       filter_skip=3Dcli_args.filter_s=
kip,
> >                                         kernel_args=3Dcli_args.kernel_a=
rgs,
> > -                                       run_isolated=3Dcli_args.run_iso=
lated)
> > +                                       run_isolated=3Dcli_args.run_iso=
lated,
> > +                                       list_tests=3Dcli_args.list_test=
s,
> > +                                       list_tests_attr=3Dcli_args.list=
_tests_attr)
> >         result =3D run_tests(linux, request)
> >         if result.status !=3D KunitStatus.SUCCESS:
> >                 sys.exit(1)
> > @@ -441,8 +505,12 @@ def exec_handler(cli_args: argparse.Namespace) -> =
None:
> >                                         json=3Dcli_args.json,
> >                                         timeout=3Dcli_args.timeout,
> >                                         filter_glob=3Dcli_args.filter_g=
lob,
> > +                                       filter=3Dcli_args.filter,
> > +                                       filter_skip=3Dcli_args.filter_s=
kip,
> >                                         kernel_args=3Dcli_args.kernel_a=
rgs,
> > -                                       run_isolated=3Dcli_args.run_iso=
lated)
> > +                                       run_isolated=3Dcli_args.run_iso=
lated,
> > +                                       list_tests=3Dcli_args.list_test=
s,
> > +                                       list_tests_attr=3Dcli_args.list=
_tests_attr)
> >         result =3D exec_tests(linux, exec_request)
> >         stdout.print_with_timestamp((
> >                 'Elapsed time: %.3fs\n') % (result.elapsed_time))
> > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/=
kunit_kernel.py
> > index 7f648802caf6..281f062a4767 100644
> > --- a/tools/testing/kunit/kunit_kernel.py
> > +++ b/tools/testing/kunit/kunit_kernel.py
> > @@ -330,11 +330,13 @@ class LinuxSourceTree:
> >                         return False
> >                 return self.validate_config(build_dir)
> >
> > -       def run_kernel(self, args: Optional[List[str]]=3DNone, build_di=
r: str=3D'', filter_glob: str=3D'', timeout: Optional[int]=3DNone) -> Itera=
tor[str]:
> > +       def run_kernel(self, args: Optional[List[str]]=3DNone, build_di=
r: str=3D'', filter_glob: str=3D'', filter: str=3D'', timeout: Optional[int=
]=3DNone) -> Iterator[str]:
> >                 if not args:
> >                         args =3D []
> >                 if filter_glob:
> > -                       args.append('kunit.filter_glob=3D'+filter_glob)
> > +                       args.append('kunit.filter_glob=3D' + filter_glo=
b)
> > +               if filter:
> > +                       args.append('kunit.filter=3D"' + filter + '"')
> >                 args.append('kunit.enable=3D1')
> >
> >                 process =3D self._ops.start(args, build_dir)
> > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kun=
it/kunit_tool_test.py
> > index be35999bb84f..85a1fb72735e 100755
> > --- a/tools/testing/kunit/kunit_tool_test.py
> > +++ b/tools/testing/kunit/kunit_tool_test.py
> > @@ -597,7 +597,7 @@ class KUnitMainTest(unittest.TestCase):
> >                 self.assertEqual(self.linux_source_mock.build_reconfig.=
call_count, 0)
> >                 self.assertEqual(self.linux_source_mock.run_kernel.call=
_count, 1)
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', timeout=3D300)
> > +                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', filter=3D'', timeout=3D300)
> >                 self.print_mock.assert_any_call(StrContains('Testing co=
mplete.'))
> >
> >         def test_run_passes_args_pass(self):
> > @@ -605,7 +605,7 @@ class KUnitMainTest(unittest.TestCase):
> >                 self.assertEqual(self.linux_source_mock.build_reconfig.=
call_count, 1)
> >                 self.assertEqual(self.linux_source_mock.run_kernel.call=
_count, 1)
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', timeout=3D300)
> > +                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', filter=3D'', timeout=3D300)
> >                 self.print_mock.assert_any_call(StrContains('Testing co=
mplete.'))
> >
> >         def test_exec_passes_args_fail(self):
> > @@ -629,7 +629,7 @@ class KUnitMainTest(unittest.TestCase):
> >                         kunit.main(['run'])
> >                 self.assertEqual(e.exception.code, 1)
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', timeout=3D300)
> > +                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', filter=3D'', timeout=3D300)
> >                 self.print_mock.assert_any_call(StrContains(' 0 tests r=
un!'))
> >
> >         def test_exec_raw_output(self):
> > @@ -670,13 +670,13 @@ class KUnitMainTest(unittest.TestCase):
> >                 self.linux_source_mock.run_kernel =3D mock.Mock(return_=
value=3D[])
> >                 kunit.main(['run', '--raw_output', 'filter_glob'])
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'filter_glob', timeout=3D300)
> > +                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'filter_glob', filter=3D'', timeout=3D300)
> >
> >         def test_exec_timeout(self):
> >                 timeout =3D 3453
> >                 kunit.main(['exec', '--timeout', str(timeout)])
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', timeout=3Dtimeout)
> > +                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', filter=3D'', timeout=3Dtimeout)
> >                 self.print_mock.assert_any_call(StrContains('Testing co=
mplete.'))
> >
> >         def test_run_timeout(self):
> > @@ -684,7 +684,7 @@ class KUnitMainTest(unittest.TestCase):
> >                 kunit.main(['run', '--timeout', str(timeout)])
> >                 self.assertEqual(self.linux_source_mock.build_reconfig.=
call_count, 1)
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', timeout=3Dtimeout)
> > +                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', filter=3D'', timeout=3Dtimeout)
> >                 self.print_mock.assert_any_call(StrContains('Testing co=
mplete.'))
> >
> >         def test_run_builddir(self):
> > @@ -692,7 +692,7 @@ class KUnitMainTest(unittest.TestCase):
> >                 kunit.main(['run', '--build_dir=3D.kunit'])
> >                 self.assertEqual(self.linux_source_mock.build_reconfig.=
call_count, 1)
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                       args=3DNone, build_dir=3Dbuild_dir, filter_glob=
=3D'', timeout=3D300)
> > +                       args=3DNone, build_dir=3Dbuild_dir, filter_glob=
=3D'', filter=3D'', timeout=3D300)
> >                 self.print_mock.assert_any_call(StrContains('Testing co=
mplete.'))
> >
> >         def test_config_builddir(self):
> > @@ -710,7 +710,7 @@ class KUnitMainTest(unittest.TestCase):
> >                 build_dir =3D '.kunit'
> >                 kunit.main(['exec', '--build_dir', build_dir])
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                       args=3DNone, build_dir=3Dbuild_dir, filter_glob=
=3D'', timeout=3D300)
> > +                       args=3DNone, build_dir=3Dbuild_dir, filter_glob=
=3D'', filter=3D'', timeout=3D300)
> >                 self.print_mock.assert_any_call(StrContains('Testing co=
mplete.'))
> >
> >         def test_run_kunitconfig(self):
> > @@ -786,7 +786,7 @@ class KUnitMainTest(unittest.TestCase):
> >                 kunit.main(['run', '--kernel_args=3Da=3D1', '--kernel_a=
rgs=3Db=3D2'])
> >                 self.assertEqual(self.linux_source_mock.build_reconfig.=
call_count, 1)
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                     args=3D['a=3D1','b=3D2'], build_dir=3D'.kunit', f=
ilter_glob=3D'', timeout=3D300)
> > +                     args=3D['a=3D1','b=3D2'], build_dir=3D'.kunit', f=
ilter_glob=3D'', filter=3D'', timeout=3D300)
> >                 self.print_mock.assert_any_call(StrContains('Testing co=
mplete.'))
> >
> >         def test_list_tests(self):
> > @@ -794,13 +794,11 @@ class KUnitMainTest(unittest.TestCase):
> >                 self.linux_source_mock.run_kernel.return_value =3D ['TA=
P version 14', 'init: random output'] + want
> >
> >                 got =3D kunit._list_tests(self.linux_source_mock,
> > -                                    kunit.KunitExecRequest(None, None,=
 '.kunit', 300, 'suite*', None, 'suite'))
> > -
> > +                                    kunit.KunitExecRequest(None, None,=
 '.kunit', 300, 'suite*', '', '', None, 'suite', False, False))
> >                 self.assertEqual(got, want)
> >                 # Should respect the user's filter glob when listing te=
sts.
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                       args=3D['kunit.action=3Dlist'], build_dir=3D'.k=
unit', filter_glob=3D'suite*', timeout=3D300)
> > -
> > +                       args=3D['kunit.action=3Dlist'], build_dir=3D'.k=
unit', filter_glob=3D'suite*', filter=3D'', timeout=3D300)
> >
> >         @mock.patch.object(kunit, '_list_tests')
> >         def test_run_isolated_by_suite(self, mock_tests):
> > @@ -809,10 +807,10 @@ class KUnitMainTest(unittest.TestCase):
> >
> >                 # Should respect the user's filter glob when listing te=
sts.
> >                 mock_tests.assert_called_once_with(mock.ANY,
> > -                                    kunit.KunitExecRequest(None, None,=
 '.kunit', 300, 'suite*.test*', None, 'suite'))
> > +                                    kunit.KunitExecRequest(None, None,=
 '.kunit', 300, 'suite*.test*', '', '', None, 'suite', False, False))
> >                 self.linux_source_mock.run_kernel.assert_has_calls([
> > -                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite.test*', timeout=3D300),
> > -                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite2.test*', timeout=3D300),
> > +                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite.test*', filter=3D'', timeout=3D300),
> > +                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite2.test*', filter=3D'', timeout=3D300),
> >                 ])
> >
> >         @mock.patch.object(kunit, '_list_tests')
> > @@ -822,13 +820,12 @@ class KUnitMainTest(unittest.TestCase):
> >
> >                 # Should respect the user's filter glob when listing te=
sts.
> >                 mock_tests.assert_called_once_with(mock.ANY,
> > -                                    kunit.KunitExecRequest(None, None,=
 '.kunit', 300, 'suite*', None, 'test'))
> > +                                    kunit.KunitExecRequest(None, None,=
 '.kunit', 300, 'suite*', '', '', None, 'test', False, False))
> >                 self.linux_source_mock.run_kernel.assert_has_calls([
> > -                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite.test1', timeout=3D300),
> > -                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite.test2', timeout=3D300),
> > -                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite2.test1', timeout=3D300),
> > +                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite.test1', filter=3D'', timeout=3D300),
> > +                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite.test2', filter=3D'', timeout=3D300),
> > +                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite2.test1', filter=3D'', timeout=3D300),
> >                 ])
> >
> > -
> >  if __name__ =3D=3D '__main__':
> >         unittest.main()
> > --
> > 2.41.0.255.g8b1d071c50-goog
> >
