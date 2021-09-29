Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9BE41CC8A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 21:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345498AbhI2TXz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 15:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245131AbhI2TXz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 15:23:55 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB8EC06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 12:22:14 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id i13so4078294ilm.4
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 12:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kiym4YUn3JE1Ort96alycOhmud8Escwd4750DshH+vE=;
        b=gne472eecHQ6m+wBteXOa+AI+kc94zrfbAJHTF1isTO/AbpIT8EILGuQWWLB68EmxL
         bljq/kADU9p/BECF2ussDchvkvuUqwZcAnOBbUmEUf0c2/i5k0aoBp9zItIyBJCwfI9w
         xrIz1jQnUbPA5FexHepuO1Okw/8RKFy9RsKZzuFXJtaUU8W6wTI16OVQMRZv5qBrE4LC
         QtS10ogM0wmEN8axpFbN+iqf0U+zN0qI1sRS+MQL6vjfUgEdcxqgZf4E2Ht61TyZNoyw
         A9ced3jCv96I/HvnEx4JpHncA+7d6+/MnFnW+9yirVpDeIpt0qDrSJqI0GI8bHvKQ5GR
         PAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kiym4YUn3JE1Ort96alycOhmud8Escwd4750DshH+vE=;
        b=uH31GPfkFHG71Cp4LuSjeeWYcCZ5jzkekEtxc5130HQhjnCcxHgn6SkVFPXIWqTLjb
         qVXJ4c1+pYogqDhnfPw39Q24PVDQq+yHgkjVIN1wJRCi2vyEj1vMH7SonQOuuB5y8Hq9
         jM2vqa+inaK/o2oWej6tX4bVaKgQIBkD2FxF+ObvdQ7kWQ7ZbqgdEV6rwb2H5PZw1BLj
         Lpib5AIHGAgHU5RuiAzoje/lTAKOHfawF66BuGWY23jpduObwtkYKi17SMjINODk04YR
         JeIcMgyn3cSIz8q3ig5k142kv3monPgFUFNGJVOc2+JitAnWdxcmERIxUCg1oi7I46fK
         gpVA==
X-Gm-Message-State: AOAM530kDOBJwKbCCoP+OP2UuKgO4WBiuuuzJ4a20Z7+m1L6QcUPAQB0
        B5VepcHYzF7WKUy3iThhcNahT96zEMvZR7VzNj+69g==
X-Google-Smtp-Source: ABdhPJw11v5a1BZEgKBlvnWoFqvPNV3r3aLRxyqwg0sGKhuvTf7A1jhtKsj1ekAgVUxxtciq4l9mr5vPo09r4Q+c7Lg=
X-Received: by 2002:a92:b301:: with SMTP id p1mr1020951ilh.10.1632943333232;
 Wed, 29 Sep 2021 12:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210928222926.1180749-1-dlatypov@google.com> <20210928222926.1180749-4-dlatypov@google.com>
 <CABVgOSnx+x1HmVWZi_Dc2HwNS8LeBX2W=0=j-jMkB+6EZhFvew@mail.gmail.com>
In-Reply-To: <CABVgOSnx+x1HmVWZi_Dc2HwNS8LeBX2W=0=j-jMkB+6EZhFvew@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 29 Sep 2021 12:22:01 -0700
Message-ID: <CAGS_qxr6xZZ6+r2qd7F0vzJicdebTPi8Bq0Z8=qK1ZgMPjN27A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kunit: tool: support running each suite/test separately
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

...On Tue, Sep 28, 2021 at 9:39 PM David Gow <davidgow@google.com> wrote:
>
> On Wed, Sep 29, 2021 at 6:29 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > The new --run_isolated flag makes the tool boot the kernel once per
> > suite or test, preventing leftover state from one suite to impact the
> > other. This can be useful as a starting point to debugging test
> > hermeticity issues.
> >
> > Note: it takes a lot longer, so people should not use it normally.
> >
> > Consider the following very simplified example:
> >
> >   bool disable_something_for_test = false;
> >   void function_being_tested() {
> >     ...
> >     if (disable_something_for_test) return;
> >     ...
> >   }
> >
> >   static void test_before(struct kunit *test)
> >   {
> >     disable_something_for_test = true;
> >     function_being_tested();
> >     /* oops, we forgot to reset it back to false */
> >   }
> >
> >   static void test_after(struct kunit *test)
> >   {
> >     /* oops, now "fixing" test_before can cause test_after to fail! */
> >     function_being_tested();
> >   }
> >
> > Presented like this, the issues are obvious, but it gets a lot more
> > complicated to track down as the amount of test setup and helper
> > functions increases.
> >
> > Another use case is memory corruption. It might not be surface as an
> Nit: "might not be surfaced" or "might not surface"

Fixed: might not be surface as an => might not be surfaced as a

>
> > failure/crash in the test case or suite that caused it. I've noticed in
> > kunit's own unit tests, the 3rd suite after might be the one to finally
> > crash after an out-of-bounds write, for example.
> >
> > Example usage:
> >
> > Per suite:
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite
> > ...
> > Starting KUnit Kernel (1/7)...
> > ============================================================
> > ======== [PASSED] kunit_executor_test ========
> > ....
> > Testing complete. 5 tests run. 0 failed. 0 crashed. 0 skipped.
> > Starting KUnit Kernel (2/7)...
> > ============================================================
> > ======== [PASSED] kunit-try-catch-test ========
> > ...
> >
> > Per test:
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=test
> > Starting KUnit Kernel (1/23)...
> > ============================================================
> > ======== [PASSED] kunit_executor_test ========
> > [PASSED] parse_filter_test
> > ============================================================
> > Testing complete. 1 tests run. 0 failed. 0 crashed. 0 skipped.
> > Starting KUnit Kernel (2/23)...
> > ============================================================
> > ======== [PASSED] kunit_executor_test ========
> > [PASSED] filter_subsuite_test
> > ...
> >
> > It works with filters as well:
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite example
> > ...
> > Starting KUnit Kernel (1/1)...
> > ============================================================
> > ======== [PASSED] example ========
> > ...
> >
> > It also handles test filters, '*.*skip*' runs these 3 tests:
> >   kunit_status.kunit_status_mark_skipped_test
> >   example.example_skip_test
> >   example.example_mark_skipped_test
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Really glad to finally have this feature.
>
> A few minor comments below (mostly mypy issues, though one of them
> seems to be a real bug). Otherwise, the main concern I have is that
> there's no final total of the tests run/passed/failed. That may be
> easier to implement post the parser rework patch, though, so I don't
> think we should hold this up for it:
> https://lore.kernel.org/linux-kselftest/20210901190623.315736-1-rmoar@google.com/
>
> Also, if we changed the TAP header stuff in patch 1, there'd need to
> be a couple of minor changes here to support it.

Yeah, I've applied the changes locally.

>
> Minor issues below aside, this is
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
>
> >  tools/testing/kunit/kunit.py           | 91 ++++++++++++++++++++------
> >  tools/testing/kunit/kunit_tool_test.py | 40 +++++++++++
> >  2 files changed, 112 insertions(+), 19 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> > index 31eec9f6ecc3..e7b92caba53d 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -16,7 +16,7 @@ assert sys.version_info >= (3, 7), "Python version is too old"
> >
> >  from collections import namedtuple
> >  from enum import Enum, auto
> > -from typing import Iterable
> > +from typing import Iterable, List
> >
> >  import kunit_config
> >  import kunit_json
> > @@ -31,13 +31,13 @@ KunitBuildRequest = namedtuple('KunitBuildRequest',
> >                                ['jobs', 'build_dir', 'alltests',
> >                                 'make_options'])
> >  KunitExecRequest = namedtuple('KunitExecRequest',
> > -                              ['timeout', 'build_dir', 'alltests',
> > -                               'filter_glob', 'kernel_args'])
> > +                             ['timeout', 'build_dir', 'alltests',
> > +                              'filter_glob', 'kernel_args', 'run_isolated'])
> >  KunitParseRequest = namedtuple('KunitParseRequest',
> >                                ['raw_output', 'build_dir', 'json'])
> >  KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
> >                                            'build_dir', 'alltests', 'filter_glob',
> > -                                          'kernel_args', 'json', 'make_options'])
> > +                                          'kernel_args', 'run_isolated', 'json', 'make_options'])
> >
> >  KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
> >
> > @@ -91,21 +91,66 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
> >                            'built kernel successfully',
> >                            build_end - build_start)
> >
> > -def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest,
> > -              parse_request: KunitParseRequest) -> KunitResult:
> > -       kunit_parser.print_with_timestamp('Starting KUnit Kernel ...')
> > -       test_start = time.time()
> > -       run_result = linux.run_kernel(
> > -               args=request.kernel_args,
> > -               timeout=None if request.alltests else request.timeout,
> > -               filter_glob=request.filter_glob,
> > -               build_dir=request.build_dir)
> > +def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -> List[str]:
> > +       args = ['kunit.action=list']
> > +       if request.kernel_args:
> > +               args.extend(request.kernel_args)
> > +
> > +       output = linux.run_kernel(args=args,
> > +                          timeout=None if request.alltests else request.timeout,
> > +                          filter_glob=request.filter_glob,
> > +                          build_dir=request.build_dir)
> > +       output = kunit_parser.extract_tap_lines(output)
>
> mypy gives an error here:
> tools/testing/kunit/kunit.py:103: error: Incompatible types in
> assignment (expression has type "LineStream", variable has type
> "Iterator[str]")
> tools/testing/kunit/kunit.py:103: note: 'LineStream' is missing
> following 'Iterator' protocol member:
> tools/testing/kunit/kunit.py:103: note:     __next__

Not an issue in the sense that it doesn't cause any runtime issues.
I've fixed it by introducing a new variable
  lines = kunit_parser.extract_tap_lines(output)

>
> > +       # Hack! Drop the TAP version header and top-level test plan.
> > +       output.pop()
> > +       output.pop()
>
> Similarly, mypy is complaining that:
> tools/testing/kunit/kunit.py:105: error: "Iterator[str]" has no attribute "pop"
> tools/testing/kunit/kunit.py:106: error: "Iterator[str]" has no attribute "pop"
>
> Also, we could get rid of one of these output.pop() lines if we
> removed the test plan in Patch 1.

Yeah, dropped one of the pops since the test plan is gone.
That should be all we need.

The mypy error goes away when using a new variable since it'll realize
we're dealing with a LineStream that does have a pop() func.

>
> > +       return list(output)
> > +
> > +def _suites_from_test_list(tests: List[str]) -> List[str]:
> > +       """Extracts all the suites from an ordered list of tests."""
> > +       suites = []  # type: List[str]
> > +       for t in tests:
> > +               parts = t.split('.', maxsplit=2)
> > +               if len(parts) != 2:
> > +                       raise ValueError(f'internal KUnit error, test name should be of the form "<suite>.<test>", got "{t}"')
> > +               suite, case = parts
> > +               if not suites or suites[-1] != suite:
> > +                       suites.append(suite)
> > +       return suites
> > +
> >
> > -       test_end = time.time()
> > -       exec_time = test_end - test_start
> >
> > -       # Named tuples are immutable, so we rebuild them here manually
> > -       result = parse_tests(parse_request, run_result)
> > +def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest,
> > +              parse_request: KunitParseRequest) -> KunitResult:
> > +       filter_globs = [request.filter_glob]
> > +       if request.run_isolated:
> > +               tests = _list_tests(linux, request)
> > +               if request.run_isolated == 'test':
> > +                       filter_globs = tests
> > +               if request.run_isolated == 'suite':
> > +                       filter_globs = _suites_from_test_list(tests)
> > +                       # Apply the test-part of the user's glob, if present.
> > +                       if '.' in request.filter_glob:
> > +                               test_glob = request.filter_glob.split('.', maxsplit=2)[1]
> > +                               filter_globs = [g + '.'+ test_glob for g in filter_globs]
> > +
> > +       overall_status = kunit_parser.TestStatus.SUCCESS
> > +       exec_time = 0
>
> This doesn't seem to work. My test run, for example, gave:
> Elapsed time: 71.706s total, 0.001s configuring, 3.241s building, 0.001s running
>
> The 0.001s running time seems way too small here.
>
> Digging into this, it might be related to this mypy warning:
> tools/testing/kunit/kunit.py:150: error: Incompatible types in
> assignment (expression has type "float", variable has type "int")
>
> Should it be exec_time = 0.0 or similar?

It should be 0.0 to be more clear about the type and make mypy happy.

But that doesn't "fix" the low runtime.
That's actually a pre-existing bug in kunit.py.

The problem is that `run_kernel()` doesn't actually block until the
kernel exits.
run_kernel() just gives back an iterator.

If I do run_result = list(linux.run_kernel(...)), that forces it to
block until the end.
That gives a more reasonable time breakdown:
Elapsed time: 14.969s total, 0.001s configuring, 3.012s building, 8.927s running

But doing so makes it impossible for us to parse results as they come in.
So I can instead do

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 3a3195d3c87d..59ef30b39602 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -145,10 +145,10 @@ def exec_tests(linux:
kunit_kernel.LinuxSourceTree, request: KunitExecRequest,
                        filter_glob=filter_glob,
                        build_dir=request.build_dir)

+               result = parse_tests(parse_request, run_result)
                test_end = time.time()
                exec_time += test_end - test_start

-               result = parse_tests(parse_request, run_result)
                overall_status =
kunit_parser.max_status(overall_status, result.status)

        return KunitResult(status=result.status, result=result.result,
elapsed_time=exec_time)

and that'll produce a more realistic number as well.
But it'll factor in the parsing overhead into execution time.

>
>
> > +       for i, filter_glob in enumerate(filter_globs):
> > +               kunit_parser.print_with_timestamp('Starting KUnit Kernel ({}/{})...'.format(i+1, len(filter_globs)))
> > +
> > +               test_start = time.time()
> > +               run_result = linux.run_kernel(
> > +                       args=request.kernel_args,
> > +                       timeout=None if request.alltests else request.timeout,
> > +                       filter_glob=filter_glob,
> > +                       build_dir=request.build_dir)
> > +
> > +               test_end = time.time()
> > +               exec_time += test_end - test_start
> > +
> > +               result = parse_tests(parse_request, run_result)
> > +               overall_status = kunit_parser.max_status(overall_status, result.status)
> >
> >         return KunitResult(status=result.status, result=result.result, elapsed_time=exec_time)
> >
> > @@ -166,7 +211,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
> >
> >         exec_request = KunitExecRequest(request.timeout, request.build_dir,
> >                                  request.alltests, request.filter_glob,
> > -                                request.kernel_args)
> > +                                request.kernel_args, request.run_isolated)
> >         parse_request = KunitParseRequest(request.raw_output,
> >                                           request.build_dir,
> >                                           request.json)
> > @@ -250,6 +295,12 @@ def add_exec_opts(parser) -> None:
> >         parser.add_argument('--kernel_args',
> >                             help='Kernel command-line parameters. Maybe be repeated',
> >                              action='append')
> > +       parser.add_argument('--run_isolated', help='If set, boot the kernel for each '
> > +                           'individual suite/test. This is can be useful for debugging '
> > +                           'a non-hermetic test, one that might pass/fail based on '
> > +                           'what ran before it.',
> > +                           type=str,
> > +                           choices=['suite', 'test']),
> >
> >  def add_parse_opts(parser) -> None:
> >         parser.add_argument('--raw_output', help='If set don\'t format output from kernel. '
> > @@ -323,6 +374,7 @@ def main(argv, linux=None):
> >                                        cli_args.alltests,
> >                                        cli_args.filter_glob,
> >                                        cli_args.kernel_args,
> > +                                      cli_args.run_isolated,
> >                                        cli_args.json,
> >                                        cli_args.make_options)
> >                 result = run_tests(linux, request)
> > @@ -378,7 +430,8 @@ def main(argv, linux=None):
> >                                                 cli_args.build_dir,
> >                                                 cli_args.alltests,
> >                                                 cli_args.filter_glob,
> > -                                               cli_args.kernel_args)
> > +                                               cli_args.kernel_args,
> > +                                               cli_args.run_isolated)
> >                 parse_request = KunitParseRequest(cli_args.raw_output,
> >                                                   cli_args.build_dir,
> >                                                   cli_args.json)
> > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> > index 619c4554cbff..bcfdc6664c9d 100755
> > --- a/tools/testing/kunit/kunit_tool_test.py
> > +++ b/tools/testing/kunit/kunit_tool_test.py
> > @@ -477,6 +477,46 @@ class KUnitMainTest(unittest.TestCase):
> >                       args=['a=1','b=2'], build_dir='.kunit', filter_glob='', timeout=300)
> >                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
> >
> > +       def test_list_tests(self):
> > +               want = ['suite.test1', 'suite.test2', 'suite2.test1']
> > +               self.linux_source_mock.run_kernel.return_value = ['TAP version 14', '1..0'] + want
> > +
> > +               got = kunit._list_tests(self.linux_source_mock,
> > +                                    kunit.KunitExecRequest(300, '.kunit', False, 'suite*', None, 'suite'))
> > +
> > +               self.assertEqual(got, want)
> > +               # Should respect the user's filter glob when listing tests.
> > +               self.linux_source_mock.run_kernel.assert_called_once_with(
> > +                       args=['kunit.action=list'], build_dir='.kunit', filter_glob='suite*', timeout=300)
> > +
> > +
> > +       @mock.patch.object(kunit, '_list_tests')
> > +       def test_run_isolated_by_suite(self, mock_tests):
> > +               mock_tests.return_value = ['suite.test1', 'suite.test2', 'suite2.test1']
> > +               kunit.main(['exec', '--run_isolated=suite', 'suite*.test*'], self.linux_source_mock)
> > +
> > +               # Should respect the user's filter glob when listing tests.
> > +               mock_tests.assert_called_once_with(mock.ANY,
> > +                                    kunit.KunitExecRequest(300, '.kunit', False, 'suite*.test*', None, 'suite'))
> > +               self.linux_source_mock.run_kernel.assert_has_calls([
> > +                       mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', timeout=300),
> > +                       mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', timeout=300),
> > +               ])
> > +
> > +       @mock.patch.object(kunit, '_list_tests')
> > +       def test_run_isolated_by_test(self, mock_tests):
> > +               mock_tests.return_value = ['suite.test1', 'suite.test2', 'suite2.test1']
> > +               kunit.main(['exec', '--run_isolated=test', 'suite*'], self.linux_source_mock)
> > +
> > +               # Should respect the user's filter glob when listing tests.
> > +               mock_tests.assert_called_once_with(mock.ANY,
> > +                                    kunit.KunitExecRequest(300, '.kunit', False, 'suite*', None, 'test'))
> > +               self.linux_source_mock.run_kernel.assert_has_calls([
> > +                       mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', timeout=300),
> > +                       mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', timeout=300),
> > +                       mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test1', timeout=300),
> > +               ])
> > +
> >
> >  if __name__ == '__main__':
> >         unittest.main()
> > --
> > 2.33.0.685.g46640cef36-goog
> >
