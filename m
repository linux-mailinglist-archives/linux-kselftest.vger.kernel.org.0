Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3098A72AA48
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 10:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjFJI3y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jun 2023 04:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbjFJI3s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jun 2023 04:29:48 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC30B3C15
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 01:29:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f7024e66adso16515e9.1
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 01:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686385778; x=1688977778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5j5Ctf9x097F8Hl/N0jpZdDiM8+9US8wFkm2gz62iCw=;
        b=bylL8htQXqW3kaWeF7XQ1N12iBx6U7kkJKt2mSg5ktAyRzOszpEJGIaQg67qgUK2XJ
         l1Zi2hfvc/hF+AXCNo/ZQZaTThBJ2H8ISOZhVT8g/xRHj2YP2fm6G55S17wZ8Fclc5Ke
         3fVYRGNReismzJvPx2OrfHZG4LoVSXnkqSgR4T7BG5xwT2mdEif3/gd4yjMWRpSe6X8x
         fpIjfgb8YgA6B/7qUzPyYBIrMiBoF/sqNuVOlMfYr/JnNDNqiK7BAsLF84UW7N2yAIvw
         ZlXqcu/oIgwYGbeqHiOkfo0wQ+VT7UxMB6GGcWJdd5tSBbHkw5EXGpl9HcJPpw9jIkkG
         z7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686385778; x=1688977778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5j5Ctf9x097F8Hl/N0jpZdDiM8+9US8wFkm2gz62iCw=;
        b=Vso7+Eq/oWpWb0r4YSqbYaWbcGNewm5ygLVb8a2Vg1UhPrYpnrSULQnj+J+ORjk8fr
         ccwYX/DoHI17Yh8K27vWoLFKMOHDY8QYZ2MDC75pEz9SGeHh40pk/kQFAeJIukBwzuBw
         yVRNE16plXpyTolcPlDodqWUf+ah5hRau3oEX9W5dbbKWYF5zOQ8aQiWQhpnw+0iCGtO
         /B9839I7a42ggZqU1AL8LsRZYmL575noXAC1xPM+3h5a6q1qLUrR9zMRnl8MxejOZ3UY
         Wwnz1yJkjlVqUkrzcRyhq2W6gbNKqbS7+1CYcPtGMNpc5c9YD9kwNkdNmpMgpkp0CPvl
         XscA==
X-Gm-Message-State: AC+VfDxG7fsTWnbsn5kqd37cXN3lisyM4ncU5dfEEzAWAWoIdugutLeo
        ip+FUR1mY6WjOCwaUq07gIwrCyYx00NoD2FNZ9I8rw==
X-Google-Smtp-Source: ACHHUZ6p+pXHJWNdkhKvxVoIJoikIUSlpQZYmLsFeQxcpfCqzKQFOkHjHK56DGgg5MZJmzvcG9MLRrZ26QkkBeotQJI=
X-Received: by 2002:a05:600c:19cf:b0:3f7:ba55:d038 with SMTP id
 u15-20020a05600c19cf00b003f7ba55d038mr72443wmq.6.1686385778078; Sat, 10 Jun
 2023 01:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230610005149.1145665-1-rmoar@google.com> <20230610005149.1145665-5-rmoar@google.com>
In-Reply-To: <20230610005149.1145665-5-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 10 Jun 2023 16:29:25 +0800
Message-ID: <CABVgOS=rC+EtinxAcqJK_ATCXwvtfffEFZsG-nx=ig35pavHdQ@mail.gmail.com>
Subject: Re: [RFC v1 4/6] kunit: tool: Add command line interface to filter
 and report attributes
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000047ceeb05fdc2490a"
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

--00000000000047ceeb05fdc2490a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 10 Jun 2023 at 08:52, Rae Moar <rmoar@google.com> wrote:
>
> Add ability to use kunit.py to filter attributes and to report a list of
> tests including attributes without running tests.
>
> Add flag "--filter" to input filters on test attributes. Tests will be
> filtered out if they do not match all inputted filters.
>
> Example: --filter speed=3Dslow
>
> This filter would run only the tests that are marked as slow. Note there
> cannot be spaces within a filter.

Within a filter's name, value, or the entire filter string. Is this a
restriction we can remove?

>
> As said in the previous patch, filters can have different operations: <, =
>,
> <=3D, >=3D, !=3D, and =3D. Note that the characters < and > are often int=
erpreted
> by the shell, so they may need to be quoted or escaped.
>
> Example: --filter "speed>=3Dnormal" or =E2=80=93filter speed\>=3Dnormal
>
> This filter would run only the tests that have the speed faster than or
> equal to normal.
>
> Add flag "--list_tests" to output a list of tests and their attributes
> without running tests. This will be useful to see test attributes and whi=
ch
> tests will run with given filters.

Please note that this comes from the kernel's kunit.action=3Dlist option.
>
> Example of the output of these tests:
>   example
>   example.test_1
>   example.test_2
>   # example.test_2.speed: slow
>
> This output includes a suite, example, with two test cases, test_1 and
> test_2. And in this instance test_2 has been marked as slow.
>

It's unrelated, so perhaps best split out into its own patch, but I'd
love the option to list tests without the attributes as well. That
would allow doing things like piping the list of tests to wc -l to
count them, etc.


> Signed-off-by: Rae Moar <rmoar@google.com>
> ---
>  tools/testing/kunit/kunit.py           | 34 +++++++++++++++++----
>  tools/testing/kunit/kunit_kernel.py    |  6 ++--
>  tools/testing/kunit/kunit_tool_test.py | 41 +++++++++++++-------------
>  3 files changed, 54 insertions(+), 27 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 3905c43369c3..661c39f7acf5 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -55,8 +55,10 @@ class KunitExecRequest(KunitParseRequest):
>         build_dir: str
>         timeout: int
>         filter_glob: str
> +       filter: Optional[List[str]]
>         kernel_args: Optional[List[str]]
>         run_isolated: Optional[str]
> +       list_tests: Optional[bool]
>
>  @dataclass
>  class KunitRequest(KunitExecRequest, KunitBuildRequest):
> @@ -100,7 +102,7 @@ def config_and_build_tests(linux: kunit_kernel.LinuxS=
ourceTree,
>
>         return build_tests(linux, request)
>
> -def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecR=
equest) -> List[str]:
> +def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecR=
equest) -> Iterable[str]:
>         args =3D ['kunit.action=3Dlist']
>         if request.kernel_args:
>                 args.extend(request.kernel_args)
> @@ -108,13 +110,17 @@ def _list_tests(linux: kunit_kernel.LinuxSourceTree=
, request: KunitExecRequest)
>         output =3D linux.run_kernel(args=3Dargs,
>                            timeout=3Drequest.timeout,
>                            filter_glob=3Drequest.filter_glob,
> +                          filter=3Drequest.filter,
>                            build_dir=3Drequest.build_dir)
>         lines =3D kunit_parser.extract_tap_lines(output)
>         # Hack! Drop the dummy TAP version header that the executor print=
s out.
>         lines.pop()
>
>         # Filter out any extraneous non-test output that might have gotte=
n mixed in.
> -       return [l for l in lines if re.match(r'^[^\s.]+\.[^\s.]+$', l)]
> +       return output
> +
> +def _get_tests(output: Iterable[str]) -> List[str]:
> +       return [l for l in output if re.match(r'^[^\s.]+\.[^\s.]+$', l)]
>
>  def _suites_from_test_list(tests: List[str]) -> List[str]:
>         """Extracts all the suites from an ordered list of tests."""
> @@ -132,8 +138,14 @@ def _suites_from_test_list(tests: List[str]) -> List=
[str]:
>
>  def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRe=
quest) -> KunitResult:
>         filter_globs =3D [request.filter_glob]
> +       if request.list_tests:
> +               output =3D _list_tests(linux, request)
> +               for line in output:
> +                       print(line.rstrip())
> +               return KunitResult(status=3DKunitStatus.SUCCESS, elapsed_=
time=3D0.0)
>         if request.run_isolated:
> -               tests =3D _list_tests(linux, request)
> +               output =3D _list_tests(linux, request)
> +               tests =3D _get_tests(output)
>                 if request.run_isolated =3D=3D 'test':
>                         filter_globs =3D tests
>                 elif request.run_isolated =3D=3D 'suite':
> @@ -155,6 +167,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, r=
equest: KunitExecRequest) -
>                         args=3Drequest.kernel_args,
>                         timeout=3Drequest.timeout,
>                         filter_glob=3Dfilter_glob,
> +                       filter=3Drequest.filter,
>                         build_dir=3Drequest.build_dir)
>
>                 _, test_result =3D parse_tests(request, metadata, run_res=
ult)
> @@ -341,6 +354,11 @@ def add_exec_opts(parser: argparse.ArgumentParser) -=
> None:
>                             nargs=3D'?',
>                             default=3D'',
>                             metavar=3D'filter_glob')
> +       parser.add_argument('--filter',
> +                           help=3D'Filter which KUnit tests run by attri=
butes'
> +                           'e.g. speed=3Dfast or speed=3D>low',
> +                           type=3Dstr,
> +                           nargs=3D'*')
>         parser.add_argument('--kernel_args',
>                             help=3D'Kernel command-line parameters. Maybe=
 be repeated',
>                              action=3D'append', metavar=3D'')
> @@ -350,6 +368,8 @@ def add_exec_opts(parser: argparse.ArgumentParser) ->=
 None:
>                             'what ran before it.',
>                             type=3Dstr,
>                             choices=3D['suite', 'test'])
> +       parser.add_argument('--list_tests', help=3D'If set, list all test=
s and attributes.',
> +                           action=3D'store_true')
>
>  def add_parse_opts(parser: argparse.ArgumentParser) -> None:
>         parser.add_argument('--raw_output', help=3D'If set don\'t parse o=
utput from kernel. '
> @@ -398,8 +418,10 @@ def run_handler(cli_args: argparse.Namespace) -> Non=
e:
>                                         json=3Dcli_args.json,
>                                         timeout=3Dcli_args.timeout,
>                                         filter_glob=3Dcli_args.filter_glo=
b,
> +                                       filter=3Dcli_args.filter,
>                                         kernel_args=3Dcli_args.kernel_arg=
s,
> -                                       run_isolated=3Dcli_args.run_isola=
ted)
> +                                       run_isolated=3Dcli_args.run_isola=
ted,
> +                                       list_tests=3Dcli_args.list_tests)
>         result =3D run_tests(linux, request)
>         if result.status !=3D KunitStatus.SUCCESS:
>                 sys.exit(1)
> @@ -441,8 +463,10 @@ def exec_handler(cli_args: argparse.Namespace) -> No=
ne:
>                                         json=3Dcli_args.json,
>                                         timeout=3Dcli_args.timeout,
>                                         filter_glob=3Dcli_args.filter_glo=
b,
> +                                       filter=3Dcli_args.filter,
>                                         kernel_args=3Dcli_args.kernel_arg=
s,
> -                                       run_isolated=3Dcli_args.run_isola=
ted)
> +                                       run_isolated=3Dcli_args.run_isola=
ted,
> +                                       list_tests=3Dcli_args.list_tests)
>         result =3D exec_tests(linux, exec_request)
>         stdout.print_with_timestamp((
>                 'Elapsed time: %.3fs\n') % (result.elapsed_time))
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/ku=
nit_kernel.py
> index 7f648802caf6..62cb8200f60e 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -330,11 +330,13 @@ class LinuxSourceTree:
>                         return False
>                 return self.validate_config(build_dir)
>
> -       def run_kernel(self, args: Optional[List[str]]=3DNone, build_dir:=
 str=3D'', filter_glob: str=3D'', timeout: Optional[int]=3DNone) -> Iterato=
r[str]:
> +       def run_kernel(self, args: Optional[List[str]]=3DNone, build_dir:=
 str=3D'', filter_glob: str=3D'', filter: Optional[List[str]]=3DNone, timeo=
ut: Optional[int]=3DNone) -> Iterator[str]:
>                 if not args:
>                         args =3D []
>                 if filter_glob:
> -                       args.append('kunit.filter_glob=3D'+filter_glob)
> +                       args.append('kunit.filter_glob=3D' + filter_glob)
> +               if filter:
> +                       args.append('kunit.filter=3D' + (','.join(filter)=
))
>                 args.append('kunit.enable=3D1')
>
>                 process =3D self._ops.start(args, build_dir)
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit=
/kunit_tool_test.py
> index be35999bb84f..4a7f3112d06c 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -14,6 +14,7 @@ import tempfile, shutil # Handling test_tmpdir
>  import itertools
>  import json
>  import os
> +import re
>  import signal
>  import subprocess
>  from typing import Iterable
> @@ -597,7 +598,7 @@ class KUnitMainTest(unittest.TestCase):
>                 self.assertEqual(self.linux_source_mock.build_reconfig.ca=
ll_count, 0)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_c=
ount, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', timeout=3D300)
> +                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', filter=3DNone, timeout=3D300)
>                 self.print_mock.assert_any_call(StrContains('Testing comp=
lete.'))
>
>         def test_run_passes_args_pass(self):
> @@ -605,7 +606,7 @@ class KUnitMainTest(unittest.TestCase):
>                 self.assertEqual(self.linux_source_mock.build_reconfig.ca=
ll_count, 1)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_c=
ount, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', timeout=3D300)
> +                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', filter=3DNone, timeout=3D300)
>                 self.print_mock.assert_any_call(StrContains('Testing comp=
lete.'))
>
>         def test_exec_passes_args_fail(self):
> @@ -629,7 +630,7 @@ class KUnitMainTest(unittest.TestCase):
>                         kunit.main(['run'])
>                 self.assertEqual(e.exception.code, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', timeout=3D300)
> +                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', filter=3DNone, timeout=3D300)
>                 self.print_mock.assert_any_call(StrContains(' 0 tests run=
!'))
>
>         def test_exec_raw_output(self):
> @@ -670,13 +671,13 @@ class KUnitMainTest(unittest.TestCase):
>                 self.linux_source_mock.run_kernel =3D mock.Mock(return_va=
lue=3D[])
>                 kunit.main(['run', '--raw_output', 'filter_glob'])
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'filter_glob', timeout=3D300)
> +                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'filter_glob', filter=3DNone, timeout=3D300)
>
>         def test_exec_timeout(self):
>                 timeout =3D 3453
>                 kunit.main(['exec', '--timeout', str(timeout)])
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', timeout=3Dtimeout)
> +                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', filter=3DNone, timeout=3Dtimeout)
>                 self.print_mock.assert_any_call(StrContains('Testing comp=
lete.'))
>
>         def test_run_timeout(self):
> @@ -684,7 +685,7 @@ class KUnitMainTest(unittest.TestCase):
>                 kunit.main(['run', '--timeout', str(timeout)])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.ca=
ll_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', timeout=3Dtimeout)
> +                       args=3DNone, build_dir=3D'.kunit', filter_glob=3D=
'', filter=3DNone, timeout=3Dtimeout)
>                 self.print_mock.assert_any_call(StrContains('Testing comp=
lete.'))
>
>         def test_run_builddir(self):
> @@ -692,7 +693,7 @@ class KUnitMainTest(unittest.TestCase):
>                 kunit.main(['run', '--build_dir=3D.kunit'])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.ca=
ll_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                       args=3DNone, build_dir=3Dbuild_dir, filter_glob=
=3D'', timeout=3D300)
> +                       args=3DNone, build_dir=3Dbuild_dir, filter_glob=
=3D'', filter=3DNone, timeout=3D300)
>                 self.print_mock.assert_any_call(StrContains('Testing comp=
lete.'))
>
>         def test_config_builddir(self):
> @@ -710,7 +711,7 @@ class KUnitMainTest(unittest.TestCase):
>                 build_dir =3D '.kunit'
>                 kunit.main(['exec', '--build_dir', build_dir])
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                       args=3DNone, build_dir=3Dbuild_dir, filter_glob=
=3D'', timeout=3D300)
> +                       args=3DNone, build_dir=3Dbuild_dir, filter_glob=
=3D'', filter=3DNone, timeout=3D300)
>                 self.print_mock.assert_any_call(StrContains('Testing comp=
lete.'))
>
>         def test_run_kunitconfig(self):
> @@ -786,7 +787,7 @@ class KUnitMainTest(unittest.TestCase):
>                 kunit.main(['run', '--kernel_args=3Da=3D1', '--kernel_arg=
s=3Db=3D2'])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.ca=
ll_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                     args=3D['a=3D1','b=3D2'], build_dir=3D'.kunit', fil=
ter_glob=3D'', timeout=3D300)
> +                     args=3D['a=3D1','b=3D2'], build_dir=3D'.kunit', fil=
ter_glob=3D'', filter=3DNone, timeout=3D300)
>                 self.print_mock.assert_any_call(StrContains('Testing comp=
lete.'))
>
>         def test_list_tests(self):
> @@ -794,12 +795,13 @@ class KUnitMainTest(unittest.TestCase):
>                 self.linux_source_mock.run_kernel.return_value =3D ['TAP =
version 14', 'init: random output'] + want
>
>                 got =3D kunit._list_tests(self.linux_source_mock,
> -                                    kunit.KunitExecRequest(None, None, '=
.kunit', 300, 'suite*', None, 'suite'))
> +                                    kunit.KunitExecRequest(None, None, '=
.kunit', 300, 'suite*', None, None, 'suite', False))
> +               tests =3D kunit._get_tests(got)
>
> -               self.assertEqual(got, want)
> +               self.assertEqual(tests, want)
>                 # Should respect the user's filter glob when listing test=
s.
>                 self.linux_source_mock.run_kernel.assert_called_once_with=
(
> -                       args=3D['kunit.action=3Dlist'], build_dir=3D'.kun=
it', filter_glob=3D'suite*', timeout=3D300)
> +                       args=3D['kunit.action=3Dlist'], build_dir=3D'.kun=
it', filter_glob=3D'suite*', filter=3DNone, timeout=3D300)
>
>
>         @mock.patch.object(kunit, '_list_tests')
> @@ -809,10 +811,10 @@ class KUnitMainTest(unittest.TestCase):
>
>                 # Should respect the user's filter glob when listing test=
s.
>                 mock_tests.assert_called_once_with(mock.ANY,
> -                                    kunit.KunitExecRequest(None, None, '=
.kunit', 300, 'suite*.test*', None, 'suite'))
> +                                    kunit.KunitExecRequest(None, None, '=
.kunit', 300, 'suite*.test*', None, None, 'suite', False))
>                 self.linux_source_mock.run_kernel.assert_has_calls([
> -                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite.test*', timeout=3D300),
> -                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite2.test*', timeout=3D300),
> +                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite.test*', filter=3DNone, timeout=3D300),
> +                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite2.test*', filter=3DNone, timeout=3D300),
>                 ])
>
>         @mock.patch.object(kunit, '_list_tests')
> @@ -822,13 +824,12 @@ class KUnitMainTest(unittest.TestCase):
>
>                 # Should respect the user's filter glob when listing test=
s.
>                 mock_tests.assert_called_once_with(mock.ANY,
> -                                    kunit.KunitExecRequest(None, None, '=
.kunit', 300, 'suite*', None, 'test'))
> +                                    kunit.KunitExecRequest(None, None, '=
.kunit', 300, 'suite*', None, None, 'test', False))
>                 self.linux_source_mock.run_kernel.assert_has_calls([
> -                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite.test1', timeout=3D300),
> -                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite.test2', timeout=3D300),
> -                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite2.test1', timeout=3D300),
> +                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite.test1', filter=3DNone, timeout=3D300),
> +                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite.test2', filter=3DNone, timeout=3D300),
> +                       mock.call(args=3DNone, build_dir=3D'.kunit', filt=
er_glob=3D'suite2.test1', filter=3DNone, timeout=3D300),
>                 ])
>
> -
>  if __name__ =3D=3D '__main__':
>         unittest.main()
> --
> 2.41.0.162.gfafddb0af9-goog
>

--00000000000047ceeb05fdc2490a
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDy
AMGABnZEgbQkONKg0oXrIE7MEGFQEyR9suDsmNHtDTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA2MTAwODI5MzhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAX+Gjzmc/BNJaElincSen
cK0kAC7R/BxGCYZmNEtx75MWclQLymUAs5dJPosemRtCwdfMpYV1tLRJkiyFM35IU80giEHKR3nc
eOZonb1sGo1jXuCrb3/67XlNL/j57mAz96YHMoVdtRzckNA38TYAypWmYgYByg/JCjCvGYCHXJ9o
VSJZH1vcJx95gM06kV5kpWsIFHR+j0RdLvpbxblT2AhDfO5Jr7Ty4jtZqfv+yJlYPxdfy4HKKlP/
XxR6HFp0ROn+1+/h55kcQa5IEP5k466vuMtFXNLAIj1NmjvYamEY+j/uTieqFMlslUfOLOyVXM79
y5Y9IjzSp4JojmXv8w==
--00000000000047ceeb05fdc2490a--
