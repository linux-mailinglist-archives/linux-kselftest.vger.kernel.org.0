Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D13C72ED3F
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 22:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbjFMUom (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 16:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjFMUol (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 16:44:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0997E53
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 13:44:38 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f76386e0daso163e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 13:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686689077; x=1689281077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wm9W1Hk990As5rbjh+u+6t9j/r8w1Y3vH1NFtJnV0Ic=;
        b=cVSW9dcHYB1pmidplpCRVvxAbCabK+aXLBPb/2JMnLh8MwvX+8qF0HBDNBllA44wCl
         MsefKXQVovSgiXUr3T/4E1dX1usHcA8VFFWwEqK/YzLIkFQWEuMWQAfttBBBf99XgK6l
         ng51WBxuLOQJ2D/ZMPoWwJyNmiAfCW++JNlnVHXjnoVdHZeJ7DkvYpCXJpKpFBsgWlEj
         iOygSYSReLHYWADG7CKf5HWUmYHfjfWo6fb2+m0/FjMT0YlMqHMxYQBJqoqmh1ZAJHXp
         aeXhbQ9gpnOb3IFH5Rg9Sv/uOP4LlKbycvIVPQR+CukO6ONlG8lYoaLsVbY+h7pDeJ6y
         Sr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686689077; x=1689281077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wm9W1Hk990As5rbjh+u+6t9j/r8w1Y3vH1NFtJnV0Ic=;
        b=PerSTP/jcGs7DuVJYVf1dAimMsa/dC5a896jci26ACRgh00lKmlEYCmSZJ107udVbY
         on0qN2jRAD+ZEvWThqfgaGlIKD1YgDaIizDRiJmCvVUAQfmmZx9lLP6eqDiBu6D5rHMm
         v1OIESDif4t+TVjkORgLQId89tYWZxOMhaSFq/egyP+jUl0TuB/HWHsqYpGavkST7ndV
         NMKqQhdGTY+asGrlkGKmzc8aVapto7FqivxEKlLZ34eXqur56xooTMYKTm/M/uWXkgtX
         06tDu+g/34IjuGv7UQ0jaLiZI70TFM/3hOCLjOLBDHmeYZ8o2miqiPfrjyeq+foMWix1
         92mQ==
X-Gm-Message-State: AC+VfDy2IW3s01Q73kzPKwZH+IUemlcMu2tS8wMl4OQrI9wbBSwNXG/f
        zKFuPNGNnEbXrWsEAYzPFJ5lXlxVP3OLVX6iXSjccg==
X-Google-Smtp-Source: ACHHUZ4VO3wqOWFTS1u9vAbsr48qvxUfmU4Rt3z/T5ZsMtnI850GGNCGij8Eflfoh3+C5koiigw0SWfnKkE9RjrNSS8=
X-Received: by 2002:ac2:5292:0:b0:4f6:3c00:1764 with SMTP id
 q18-20020ac25292000000b004f63c001764mr22614lfm.5.1686689076865; Tue, 13 Jun
 2023 13:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230610005149.1145665-1-rmoar@google.com> <20230610005149.1145665-5-rmoar@google.com>
 <CABVgOS=rC+EtinxAcqJK_ATCXwvtfffEFZsG-nx=ig35pavHdQ@mail.gmail.com>
In-Reply-To: <CABVgOS=rC+EtinxAcqJK_ATCXwvtfffEFZsG-nx=ig35pavHdQ@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 13 Jun 2023 16:44:25 -0400
Message-ID: <CA+GJov5sxHOug0kYYGcazPKrgS1FH81QPWMLjveN8_YO-OhxNg@mail.gmail.com>
Subject: Re: [RFC v1 4/6] kunit: tool: Add command line interface to filter
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 10, 2023 at 4:29=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Sat, 10 Jun 2023 at 08:52, Rae Moar <rmoar@google.com> wrote:
> >
> > Add ability to use kunit.py to filter attributes and to report a list o=
f
> > tests including attributes without running tests.
> >
> > Add flag "--filter" to input filters on test attributes. Tests will be
> > filtered out if they do not match all inputted filters.
> >
> > Example: --filter speed=3Dslow
> >
> > This filter would run only the tests that are marked as slow. Note ther=
e
> > cannot be spaces within a filter.
>
> Within a filter's name, value, or the entire filter string. Is this a
> restriction we can remove?
>

Currently this implementation does not allow for spaces anywhere in
the filter string so for the example: "--filter speed=3Dslow", there
cannot be spaces within "speed=3Dslow".

I would be interested in removing this restriction by allowing the
user to use quotes if there are spaces.

I originally thought this would be potentially a future change.
However, it may be best to implement earlier as it would cause the
implementation to change quite a bit. The module_param_array may need
to be changed to be a string that is then parsed.

> >
> > As said in the previous patch, filters can have different operations: <=
, >,
> > <=3D, >=3D, !=3D, and =3D. Note that the characters < and > are often i=
nterpreted
> > by the shell, so they may need to be quoted or escaped.
> >
> > Example: --filter "speed>=3Dnormal" or =E2=80=93filter speed\>=3Dnormal
> >
> > This filter would run only the tests that have the speed faster than or
> > equal to normal.
> >
> > Add flag "--list_tests" to output a list of tests and their attributes
> > without running tests. This will be useful to see test attributes and w=
hich
> > tests will run with given filters.
>
> Please note that this comes from the kernel's kunit.action=3Dlist option.

Got it. Will do in the next version.

> >
> > Example of the output of these tests:
> >   example
> >   example.test_1
> >   example.test_2
> >   # example.test_2.speed: slow
> >
> > This output includes a suite, example, with two test cases, test_1 and
> > test_2. And in this instance test_2 has been marked as slow.
> >
>
> It's unrelated, so perhaps best split out into its own patch, but I'd
> love the option to list tests without the attributes as well. That
> would allow doing things like piping the list of tests to wc -l to
> count them, etc.
>

I really like this idea of allowing two options: list tests only and
then also include attributes. I wonder if I should include the tests
in the second option. My instinct would be yes (to show all tests not
just those with attributes) but let me know what you think.

Thanks!
-Rae

>
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
> >  tools/testing/kunit/kunit.py           | 34 +++++++++++++++++----
> >  tools/testing/kunit/kunit_kernel.py    |  6 ++--
> >  tools/testing/kunit/kunit_tool_test.py | 41 +++++++++++++-------------
> >  3 files changed, 54 insertions(+), 27 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.p=
y
> > index 3905c43369c3..661c39f7acf5 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -55,8 +55,10 @@ class KunitExecRequest(KunitParseRequest):
> >         build_dir: str
> >         timeout: int
> >         filter_glob: str
> > +       filter: Optional[List[str]]
> >         kernel_args: Optional[List[str]]
> >         run_isolated: Optional[str]
> > +       list_tests: Optional[bool]
> >
> >  @dataclass
> >  class KunitRequest(KunitExecRequest, KunitBuildRequest):
> > @@ -100,7 +102,7 @@ def config_and_build_tests(linux: kunit_kernel.Linu=
xSourceTree,
> >
> >         return build_tests(linux, request)
> >
> > -def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExe=
cRequest) -> List[str]:
> > +def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExe=
cRequest) -> Iterable[str]:
> >         args =3D ['kunit.action=3Dlist']
> >         if request.kernel_args:
> >                 args.extend(request.kernel_args)
> > @@ -108,13 +110,17 @@ def _list_tests(linux: kunit_kernel.LinuxSourceTr=
ee, request: KunitExecRequest)
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
> > +       return output
> > +
> > +def _get_tests(output: Iterable[str]) -> List[str]:
> > +       return [l for l in output if re.match(r'^[^\s.]+\.[^\s.]+$', l)=
]
> >
> >  def _suites_from_test_list(tests: List[str]) -> List[str]:
> >         """Extracts all the suites from an ordered list of tests."""
> > @@ -132,8 +138,14 @@ def _suites_from_test_list(tests: List[str]) -> Li=
st[str]:
> >
> >  def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExec=
Request) -> KunitResult:
> >         filter_globs =3D [request.filter_glob]
> > +       if request.list_tests:
> > +               output =3D _list_tests(linux, request)
> > +               for line in output:
> > +                       print(line.rstrip())
> > +               return KunitResult(status=3DKunitStatus.SUCCESS, elapse=
d_time=3D0.0)
> >         if request.run_isolated:
> > -               tests =3D _list_tests(linux, request)
> > +               output =3D _list_tests(linux, request)
> > +               tests =3D _get_tests(output)
> >                 if request.run_isolated =3D=3D 'test':
> >                         filter_globs =3D tests
> >                 elif request.run_isolated =3D=3D 'suite':
> > @@ -155,6 +167,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree,=
 request: KunitExecRequest) -
> >                         args=3Drequest.kernel_args,
> >                         timeout=3Drequest.timeout,
> >                         filter_glob=3Dfilter_glob,
> > +                       filter=3Drequest.filter,
> >                         build_dir=3Drequest.build_dir)
> >
> >                 _, test_result =3D parse_tests(request, metadata, run_r=
esult)
> > @@ -341,6 +354,11 @@ def add_exec_opts(parser: argparse.ArgumentParser)=
 -> None:
> >                             nargs=3D'?',
> >                             default=3D'',
> >                             metavar=3D'filter_glob')
> > +       parser.add_argument('--filter',
> > +                           help=3D'Filter which KUnit tests run by att=
ributes'
> > +                           'e.g. speed=3Dfast or speed=3D>low',
> > +                           type=3Dstr,
> > +                           nargs=3D'*')
> >         parser.add_argument('--kernel_args',
> >                             help=3D'Kernel command-line parameters. May=
be be repeated',
> >                              action=3D'append', metavar=3D'')
> > @@ -350,6 +368,8 @@ def add_exec_opts(parser: argparse.ArgumentParser) =
-> None:
> >                             'what ran before it.',
> >                             type=3Dstr,
> >                             choices=3D['suite', 'test'])
> > +       parser.add_argument('--list_tests', help=3D'If set, list all te=
sts and attributes.',
> > +                           action=3D'store_true')
> >
> >  def add_parse_opts(parser: argparse.ArgumentParser) -> None:
> >         parser.add_argument('--raw_output', help=3D'If set don\'t parse=
 output from kernel. '
> > @@ -398,8 +418,10 @@ def run_handler(cli_args: argparse.Namespace) -> N=
one:
> >                                         json=3Dcli_args.json,
> >                                         timeout=3Dcli_args.timeout,
> >                                         filter_glob=3Dcli_args.filter_g=
lob,
> > +                                       filter=3Dcli_args.filter,
> >                                         kernel_args=3Dcli_args.kernel_a=
rgs,
> > -                                       run_isolated=3Dcli_args.run_iso=
lated)
> > +                                       run_isolated=3Dcli_args.run_iso=
lated,
> > +                                       list_tests=3Dcli_args.list_test=
s)
> >         result =3D run_tests(linux, request)
> >         if result.status !=3D KunitStatus.SUCCESS:
> >                 sys.exit(1)
> > @@ -441,8 +463,10 @@ def exec_handler(cli_args: argparse.Namespace) -> =
None:
> >                                         json=3Dcli_args.json,
> >                                         timeout=3Dcli_args.timeout,
> >                                         filter_glob=3Dcli_args.filter_g=
lob,
> > +                                       filter=3Dcli_args.filter,
> >                                         kernel_args=3Dcli_args.kernel_a=
rgs,
> > -                                       run_isolated=3Dcli_args.run_iso=
lated)
> > +                                       run_isolated=3Dcli_args.run_iso=
lated,
> > +                                       list_tests=3Dcli_args.list_test=
s)
> >         result =3D exec_tests(linux, exec_request)
> >         stdout.print_with_timestamp((
> >                 'Elapsed time: %.3fs\n') % (result.elapsed_time))
> > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/=
kunit_kernel.py
> > index 7f648802caf6..62cb8200f60e 100644
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
r: str=3D'', filter_glob: str=3D'', filter: Optional[List[str]]=3DNone, tim=
eout: Optional[int]=3DNone) -> Iterator[str]:
> >                 if not args:
> >                         args =3D []
> >                 if filter_glob:
> > -                       args.append('kunit.filter_glob=3D'+filter_glob)
> > +                       args.append('kunit.filter_glob=3D' + filter_glo=
b)
> > +               if filter:
> > +                       args.append('kunit.filter=3D' + (','.join(filte=
r)))
> >                 args.append('kunit.enable=3D1')
> >
> >                 process =3D self._ops.start(args, build_dir)
> > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kun=
it/kunit_tool_test.py
> > index be35999bb84f..4a7f3112d06c 100755
> > --- a/tools/testing/kunit/kunit_tool_test.py
> > +++ b/tools/testing/kunit/kunit_tool_test.py
> > @@ -14,6 +14,7 @@ import tempfile, shutil # Handling test_tmpdir
> >  import itertools
> >  import json
> >  import os
> > +import re
> >  import signal
> >  import subprocess
> >  from typing import Iterable
> > @@ -597,7 +598,7 @@ class KUnitMainTest(unittest.TestCase):
> >                 self.assertEqual(self.linux_source_mock.build_reconfig.=
call_count, 0)
> >                 self.assertEqual(self.linux_source_mock.run_kernel.call=
_count, 1)
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', timeout=3D300)
> > +                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', filter=3DNone, timeout=3D300)
> >                 self.print_mock.assert_any_call(StrContains('Testing co=
mplete.'))
> >
> >         def test_run_passes_args_pass(self):
> > @@ -605,7 +606,7 @@ class KUnitMainTest(unittest.TestCase):
> >                 self.assertEqual(self.linux_source_mock.build_reconfig.=
call_count, 1)
> >                 self.assertEqual(self.linux_source_mock.run_kernel.call=
_count, 1)
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', timeout=3D300)
> > +                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', filter=3DNone, timeout=3D300)
> >                 self.print_mock.assert_any_call(StrContains('Testing co=
mplete.'))
> >
> >         def test_exec_passes_args_fail(self):
> > @@ -629,7 +630,7 @@ class KUnitMainTest(unittest.TestCase):
> >                         kunit.main(['run'])
> >                 self.assertEqual(e.exception.code, 1)
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', timeout=3D300)
> > +                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', filter=3DNone, timeout=3D300)
> >                 self.print_mock.assert_any_call(StrContains(' 0 tests r=
un!'))
> >
> >         def test_exec_raw_output(self):
> > @@ -670,13 +671,13 @@ class KUnitMainTest(unittest.TestCase):
> >                 self.linux_source_mock.run_kernel =3D mock.Mock(return_=
value=3D[])
> >                 kunit.main(['run', '--raw_output', 'filter_glob'])
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'filter_glob', timeout=3D300)
> > +                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'filter_glob', filter=3DNone, timeout=3D300)
> >
> >         def test_exec_timeout(self):
> >                 timeout =3D 3453
> >                 kunit.main(['exec', '--timeout', str(timeout)])
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', timeout=3Dtimeout)
> > +                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', filter=3DNone, timeout=3Dtimeout)
> >                 self.print_mock.assert_any_call(StrContains('Testing co=
mplete.'))
> >
> >         def test_run_timeout(self):
> > @@ -684,7 +685,7 @@ class KUnitMainTest(unittest.TestCase):
> >                 kunit.main(['run', '--timeout', str(timeout)])
> >                 self.assertEqual(self.linux_source_mock.build_reconfig.=
call_count, 1)
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', timeout=3Dtimeout)
> > +                       args=3DNone, build_dir=3D'.kunit', filter_glob=
=3D'', filter=3DNone, timeout=3Dtimeout)
> >                 self.print_mock.assert_any_call(StrContains('Testing co=
mplete.'))
> >
> >         def test_run_builddir(self):
> > @@ -692,7 +693,7 @@ class KUnitMainTest(unittest.TestCase):
> >                 kunit.main(['run', '--build_dir=3D.kunit'])
> >                 self.assertEqual(self.linux_source_mock.build_reconfig.=
call_count, 1)
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                       args=3DNone, build_dir=3Dbuild_dir, filter_glob=
=3D'', timeout=3D300)
> > +                       args=3DNone, build_dir=3Dbuild_dir, filter_glob=
=3D'', filter=3DNone, timeout=3D300)
> >                 self.print_mock.assert_any_call(StrContains('Testing co=
mplete.'))
> >
> >         def test_config_builddir(self):
> > @@ -710,7 +711,7 @@ class KUnitMainTest(unittest.TestCase):
> >                 build_dir =3D '.kunit'
> >                 kunit.main(['exec', '--build_dir', build_dir])
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                       args=3DNone, build_dir=3Dbuild_dir, filter_glob=
=3D'', timeout=3D300)
> > +                       args=3DNone, build_dir=3Dbuild_dir, filter_glob=
=3D'', filter=3DNone, timeout=3D300)
> >                 self.print_mock.assert_any_call(StrContains('Testing co=
mplete.'))
> >
> >         def test_run_kunitconfig(self):
> > @@ -786,7 +787,7 @@ class KUnitMainTest(unittest.TestCase):
> >                 kunit.main(['run', '--kernel_args=3Da=3D1', '--kernel_a=
rgs=3Db=3D2'])
> >                 self.assertEqual(self.linux_source_mock.build_reconfig.=
call_count, 1)
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                     args=3D['a=3D1','b=3D2'], build_dir=3D'.kunit', f=
ilter_glob=3D'', timeout=3D300)
> > +                     args=3D['a=3D1','b=3D2'], build_dir=3D'.kunit', f=
ilter_glob=3D'', filter=3DNone, timeout=3D300)
> >                 self.print_mock.assert_any_call(StrContains('Testing co=
mplete.'))
> >
> >         def test_list_tests(self):
> > @@ -794,12 +795,13 @@ class KUnitMainTest(unittest.TestCase):
> >                 self.linux_source_mock.run_kernel.return_value =3D ['TA=
P version 14', 'init: random output'] + want
> >
> >                 got =3D kunit._list_tests(self.linux_source_mock,
> > -                                    kunit.KunitExecRequest(None, None,=
 '.kunit', 300, 'suite*', None, 'suite'))
> > +                                    kunit.KunitExecRequest(None, None,=
 '.kunit', 300, 'suite*', None, None, 'suite', False))
> > +               tests =3D kunit._get_tests(got)
> >
> > -               self.assertEqual(got, want)
> > +               self.assertEqual(tests, want)
> >                 # Should respect the user's filter glob when listing te=
sts.
> >                 self.linux_source_mock.run_kernel.assert_called_once_wi=
th(
> > -                       args=3D['kunit.action=3Dlist'], build_dir=3D'.k=
unit', filter_glob=3D'suite*', timeout=3D300)
> > +                       args=3D['kunit.action=3Dlist'], build_dir=3D'.k=
unit', filter_glob=3D'suite*', filter=3DNone, timeout=3D300)
> >
> >
> >         @mock.patch.object(kunit, '_list_tests')
> > @@ -809,10 +811,10 @@ class KUnitMainTest(unittest.TestCase):
> >
> >                 # Should respect the user's filter glob when listing te=
sts.
> >                 mock_tests.assert_called_once_with(mock.ANY,
> > -                                    kunit.KunitExecRequest(None, None,=
 '.kunit', 300, 'suite*.test*', None, 'suite'))
> > +                                    kunit.KunitExecRequest(None, None,=
 '.kunit', 300, 'suite*.test*', None, None, 'suite', False))
> >                 self.linux_source_mock.run_kernel.assert_has_calls([
> > -                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite.test*', timeout=3D300),
> > -                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite2.test*', timeout=3D300),
> > +                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite.test*', filter=3DNone, timeout=3D300),
> > +                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite2.test*', filter=3DNone, timeout=3D300),
> >                 ])
> >
> >         @mock.patch.object(kunit, '_list_tests')
> > @@ -822,13 +824,12 @@ class KUnitMainTest(unittest.TestCase):
> >
> >                 # Should respect the user's filter glob when listing te=
sts.
> >                 mock_tests.assert_called_once_with(mock.ANY,
> > -                                    kunit.KunitExecRequest(None, None,=
 '.kunit', 300, 'suite*', None, 'test'))
> > +                                    kunit.KunitExecRequest(None, None,=
 '.kunit', 300, 'suite*', None, None, 'test', False))
> >                 self.linux_source_mock.run_kernel.assert_has_calls([
> > -                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite.test1', timeout=3D300),
> > -                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite.test2', timeout=3D300),
> > -                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite2.test1', timeout=3D300),
> > +                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite.test1', filter=3DNone, timeout=3D300),
> > +                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite.test2', filter=3DNone, timeout=3D300),
> > +                       mock.call(args=3DNone, build_dir=3D'.kunit', fi=
lter_glob=3D'suite2.test1', filter=3DNone, timeout=3D300),
> >                 ])
> >
> > -
> >  if __name__ =3D=3D '__main__':
> >         unittest.main()
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
