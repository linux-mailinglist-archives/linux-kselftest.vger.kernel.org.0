Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F00541D167
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 04:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347731AbhI3C3e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 22:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347694AbhI3C3d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 22:29:33 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FB2C06176A
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 19:27:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d26so7393738wrb.6
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 19:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qJCZwroDanrzKDprTwlLjJIB/pD6O/FPMEn2QDpBYt8=;
        b=rPq88ibBNm68c/f49UJE9M2UyBrcJVZXVmUhHFJxvwn8n9BkqlmpO9Tu8ll2Yz+i0Z
         gGF/5EX5Qfe3y8//7Ndg/fZkiQBsN4xwFGFWJBAy6d4VB3Cd6VwLDPeLE20HD5caoZvS
         bXRHMNsG2uO6TYjsa3EZ7QUJYrJtc5ceRafUrbHOyfyH/6Hg+gxeGpWacFELx4+5+Fuc
         sbNCMASQntFwD46CPyFkz5DZb9ZgUA2eS98EIhhFE/MR+GI0daAzlTttlbHBWJT0sXTw
         Ux6Pwak0BM8kwQlDhLK2bdFWGl/YKAf9DBqyAttlR17X3yFN8l5fORjMbN3BLNkRtSSZ
         TUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJCZwroDanrzKDprTwlLjJIB/pD6O/FPMEn2QDpBYt8=;
        b=kjLVJMLCTQTCYCOSQbg/DBLBPOOzaSd6s3jnQqQSK4MxlE17iJc2lK7PyVsRHe2koV
         OlH2+qPRb5pF/0WzVOM1T1d6TF4w8mT1/h6caMo8EzdrEy14u9Q230siz7maL7yaJVwV
         KQ898xLsmlOZm8n17Rb8bPzZsayzW1gxKg9RAcQDnn7kZwiIvEATor/3iqZv8xkM4Q48
         0PIQSHrkZhM4KfHO7ch9dPaqbGnfo6MOqu02WcK+bwaeE8uM3J5T1FFK9i7VPUId3WLw
         lDE5l0EzNhT/avQF5RfRdcptrMO50EkGDxgI2d4dNsrSV8ZYKjmkZpgnu1MM1s3bjvcg
         4o8A==
X-Gm-Message-State: AOAM533yjmj7zyU0qj1s/Q2+EQsq+59mukVXXBXG14Bgvsdt5hOGN8Iq
        tlgXFvxBY3OYd8H/7iMRikOOWpZO/hoqoPI7/QniZA==
X-Google-Smtp-Source: ABdhPJwDSypkPC9mFh3iCgeQzp7ygfKP0SFn8eW0TXBaoq4D4IlTCoVZEY8brmy6blb/ACGLUVj6vX+/+lUgUSSyTls=
X-Received: by 2002:adf:f6c7:: with SMTP id y7mr3356375wrp.44.1632968870203;
 Wed, 29 Sep 2021 19:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210929195436.1405996-1-dlatypov@google.com> <20210929195436.1405996-5-dlatypov@google.com>
In-Reply-To: <20210929195436.1405996-5-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 30 Sep 2021 10:27:39 +0800
Message-ID: <CABVgOSne4ymK6ajB8vT-=pptvKJNxBNppzA3X7Jv2mghjsf4RQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] kunit: tool: support running each suite/test separately
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

On Thu, Sep 30, 2021 at 3:54 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> The new --run_isolated flag makes the tool boot the kernel once per
> suite or test, preventing leftover state from one suite to impact the
> other. This can be useful as a starting point to debugging test
> hermeticity issues.
>
> Note: it takes a lot longer, so people should not use it normally.
>
> Consider the following very simplified example:
>
>   bool disable_something_for_test = false;
>   void function_being_tested() {
>     ...
>     if (disable_something_for_test) return;
>     ...
>   }
>
>   static void test_before(struct kunit *test)
>   {
>     disable_something_for_test = true;
>     function_being_tested();
>     /* oops, we forgot to reset it back to false */
>   }
>
>   static void test_after(struct kunit *test)
>   {
>     /* oops, now "fixing" test_before can cause test_after to fail! */
>     function_being_tested();
>   }
>
> Presented like this, the issues are obvious, but it gets a lot more
> complicated to track down as the amount of test setup and helper
> functions increases.
>
> Another use case is memory corruption. It might not be surfaced as a
> failure/crash in the test case or suite that caused it. I've noticed in
> kunit's own unit tests, the 3rd suite after might be the one to finally
> crash after an out-of-bounds write, for example.
>
> Example usage:
>
> Per suite:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite
> ...
> Starting KUnit Kernel (1/7)...
> ============================================================
> ======== [PASSED] kunit_executor_test ========
> ....
> Testing complete. 5 tests run. 0 failed. 0 crashed. 0 skipped.
> Starting KUnit Kernel (2/7)...
> ============================================================
> ======== [PASSED] kunit-try-catch-test ========
> ...
>
> Per test:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=test
> Starting KUnit Kernel (1/23)...
> ============================================================
> ======== [PASSED] kunit_executor_test ========
> [PASSED] parse_filter_test
> ============================================================
> Testing complete. 1 tests run. 0 failed. 0 crashed. 0 skipped.
> Starting KUnit Kernel (2/23)...
> ============================================================
> ======== [PASSED] kunit_executor_test ========
> [PASSED] filter_subsuite_test
> ...
>
> It works with filters as well:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite example
> ...
> Starting KUnit Kernel (1/1)...
> ============================================================
> ======== [PASSED] example ========
> ...
>
> It also handles test filters, '*.*skip*' runs these 3 tests:
>   kunit_status.kunit_status_mark_skipped_test
>   example.example_skip_test
>   example.example_mark_skipped_test
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>
> ---

Thanks. This is good. A part of me still would've preferred the TAP
header to have been altered, but it probably makes more sense to leave
that until after Rae's parser rework patch anyway, which has better
support for multiple possible TAP headers anyway.

I did find an issue when running this under qemu/i386: a timing
problem with interleaved lines. We could do something drastic, like
having a marker at the start of every line to identify which ones are
tests, but that does seem like overkill for a (hopefully) rare
problem. Just ignoring obviously invalid lines should do it. Futher
details below.

-- David

>  tools/testing/kunit/kunit.py           | 95 ++++++++++++++++++++------
>  tools/testing/kunit/kunit_tool_test.py | 40 +++++++++++
>  2 files changed, 114 insertions(+), 21 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 5e717594df5b..b9d63f558765 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -16,7 +16,7 @@ assert sys.version_info >= (3, 7), "Python version is too old"
>
>  from collections import namedtuple
>  from enum import Enum, auto
> -from typing import Iterable
> +from typing import Iterable, List
>
>  import kunit_config
>  import kunit_json
> @@ -31,13 +31,13 @@ KunitBuildRequest = namedtuple('KunitBuildRequest',
>                                ['jobs', 'build_dir', 'alltests',
>                                 'make_options'])
>  KunitExecRequest = namedtuple('KunitExecRequest',
> -                              ['timeout', 'build_dir', 'alltests',
> -                               'filter_glob', 'kernel_args'])
> +                             ['timeout', 'build_dir', 'alltests',
> +                              'filter_glob', 'kernel_args', 'run_isolated'])
>  KunitParseRequest = namedtuple('KunitParseRequest',
>                                ['raw_output', 'build_dir', 'json'])
>  KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
>                                            'build_dir', 'alltests', 'filter_glob',
> -                                          'kernel_args', 'json', 'make_options'])
> +                                          'kernel_args', 'run_isolated', 'json', 'make_options'])
>
>  KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
>
> @@ -91,23 +91,68 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
>                            'built kernel successfully',
>                            build_end - build_start)
>
> +def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -> List[str]:
> +       args = ['kunit.action=list']
> +       if request.kernel_args:
> +               args.extend(request.kernel_args)
> +
> +       output = linux.run_kernel(args=args,
> +                          timeout=None if request.alltests else request.timeout,
> +                          filter_glob=request.filter_glob,
> +                          build_dir=request.build_dir)
> +       lines = kunit_parser.extract_tap_lines(output)
> +       # Hack! Drop the dummy TAP version header that the executor prints out.
> +       lines.pop()
> +       return list(lines)
> +
> +def _suites_from_test_list(tests: List[str]) -> List[str]:
> +       """Extracts all the suites from an ordered list of tests."""
> +       suites = []  # type: List[str]
> +       for t in tests:
> +               parts = t.split('.', maxsplit=2)
> +               if len(parts) != 2:
> +                       raise ValueError(f'internal KUnit error, test name should be of the form "<suite>.<test>", got "{t}"')

It turns out that this can trigger on some machines/architectures if
there are other lines of kernel output which either get interspersed
in the test list, or -- more likely -- between the test list and the
"Restarting System" line.

On i386, under qemu, I'm seeing this output:
$ qemu-system-x86_64 -nodefaults -m 1024 -kernel
.kunit/arch/x86/boot/bzImage -append 'kunit.action=list mem=1G
console=tty kunit_shutdown=halt console=ttyS0 kunit_shutdown=reboot'
-no-reboot -nographic -serial stdio
...
property-entry.pe_test_reference
random: fast init done
input: ImExPS/2 Generic Explorer Mouse as
/devices/platform/i8042/serio1/input/input2
reboot: Restarting system
reboot: machine restart

Which translates into the following kunit_tool error:
$ ./tools/testing/kunit/kunit.py run --run_isolated=suite --arch=i386
...
 File "./tools/testing/kunit/kunit.py", line 114, in _suites_from_test_list
   raise ValueError(f'internal KUnit error, test name should be of the
form "<suite>.<test>", got "{t}"')
ValueError: internal KUnit error, test name should be of the form
"<suite>.<test>", got "random: fast init done"


Could we maybe ignore entries of the incorrect form?


> +               suite, case = parts
> +               if not suites or suites[-1] != suite:
> +                       suites.append(suite)
> +       return suites
> +
> +
> +
>  def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest,
>                parse_request: KunitParseRequest) -> KunitResult:
> -       kunit_parser.print_with_timestamp('Starting KUnit Kernel ...')
> -       test_start = time.time()
> -       run_result = linux.run_kernel(
> -               args=request.kernel_args,
> -               timeout=None if request.alltests else request.timeout,
> -               filter_glob=request.filter_glob,
> -               build_dir=request.build_dir)
> -
> -       result = parse_tests(parse_request, run_result)
> -
> -       # run_kernel() doesn't block on the kernel exiting.
> -       # That only happens after we get the last line of output from `run_result`.
> -       # So exec_time here actually contains parsing + execution time, which is fine.
> -       test_end = time.time()
> -       exec_time = test_end - test_start
> +       filter_globs = [request.filter_glob]
> +       if request.run_isolated:
> +               tests = _list_tests(linux, request)
> +               if request.run_isolated == 'test':
> +                       filter_globs = tests
> +               if request.run_isolated == 'suite':
> +                       filter_globs = _suites_from_test_list(tests)
> +                       # Apply the test-part of the user's glob, if present.
> +                       if '.' in request.filter_glob:
> +                               test_glob = request.filter_glob.split('.', maxsplit=2)[1]
> +                               filter_globs = [g + '.'+ test_glob for g in filter_globs]
> +
> +       overall_status = kunit_parser.TestStatus.SUCCESS
> +       exec_time = 0.0
> +       for i, filter_glob in enumerate(filter_globs):
> +               kunit_parser.print_with_timestamp('Starting KUnit Kernel ({}/{})...'.format(i+1, len(filter_globs)))
> +
> +               test_start = time.time()
> +               run_result = linux.run_kernel(
> +                       args=request.kernel_args,
> +                       timeout=None if request.alltests else request.timeout,
> +                       filter_glob=filter_glob,
> +                       build_dir=request.build_dir)
> +
> +               result = parse_tests(parse_request, run_result)
> +               # run_kernel() doesn't block on the kernel exiting.
> +               # That only happens after we get the last line of output from `run_result`.
> +               # So exec_time here actually contains parsing + execution time, which is fine.
> +               test_end = time.time()
> +               exec_time += test_end - test_start
> +
> +               overall_status = kunit_parser.max_status(overall_status, result.status)
>
>         return KunitResult(status=result.status, result=result.result, elapsed_time=exec_time)
>
> @@ -168,7 +213,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
>
>         exec_request = KunitExecRequest(request.timeout, request.build_dir,
>                                  request.alltests, request.filter_glob,
> -                                request.kernel_args)
> +                                request.kernel_args, request.run_isolated)
>         parse_request = KunitParseRequest(request.raw_output,
>                                           request.build_dir,
>                                           request.json)
> @@ -252,6 +297,12 @@ def add_exec_opts(parser) -> None:
>         parser.add_argument('--kernel_args',
>                             help='Kernel command-line parameters. Maybe be repeated',
>                              action='append')
> +       parser.add_argument('--run_isolated', help='If set, boot the kernel for each '
> +                           'individual suite/test. This is can be useful for debugging '
> +                           'a non-hermetic test, one that might pass/fail based on '
> +                           'what ran before it.',
> +                           type=str,
> +                           choices=['suite', 'test']),
>
>  def add_parse_opts(parser) -> None:
>         parser.add_argument('--raw_output', help='If set don\'t format output from kernel. '
> @@ -325,6 +376,7 @@ def main(argv, linux=None):
>                                        cli_args.alltests,
>                                        cli_args.filter_glob,
>                                        cli_args.kernel_args,
> +                                      cli_args.run_isolated,
>                                        cli_args.json,
>                                        cli_args.make_options)
>                 result = run_tests(linux, request)
> @@ -380,7 +432,8 @@ def main(argv, linux=None):
>                                                 cli_args.build_dir,
>                                                 cli_args.alltests,
>                                                 cli_args.filter_glob,
> -                                               cli_args.kernel_args)
> +                                               cli_args.kernel_args,
> +                                               cli_args.run_isolated)
>                 parse_request = KunitParseRequest(cli_args.raw_output,
>                                                   cli_args.build_dir,
>                                                   cli_args.json)
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 619c4554cbff..1ff35c08d2c8 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -477,6 +477,46 @@ class KUnitMainTest(unittest.TestCase):
>                       args=['a=1','b=2'], build_dir='.kunit', filter_glob='', timeout=300)
>                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
>
> +       def test_list_tests(self):
> +               want = ['suite.test1', 'suite.test2', 'suite2.test1']
> +               self.linux_source_mock.run_kernel.return_value = ['TAP version 14'] + want
> +
> +               got = kunit._list_tests(self.linux_source_mock,
> +                                    kunit.KunitExecRequest(300, '.kunit', False, 'suite*', None, 'suite'))
> +
> +               self.assertEqual(got, want)
> +               # Should respect the user's filter glob when listing tests.
> +               self.linux_source_mock.run_kernel.assert_called_once_with(
> +                       args=['kunit.action=list'], build_dir='.kunit', filter_glob='suite*', timeout=300)
> +
> +
> +       @mock.patch.object(kunit, '_list_tests')
> +       def test_run_isolated_by_suite(self, mock_tests):
> +               mock_tests.return_value = ['suite.test1', 'suite.test2', 'suite2.test1']
> +               kunit.main(['exec', '--run_isolated=suite', 'suite*.test*'], self.linux_source_mock)
> +
> +               # Should respect the user's filter glob when listing tests.
> +               mock_tests.assert_called_once_with(mock.ANY,
> +                                    kunit.KunitExecRequest(300, '.kunit', False, 'suite*.test*', None, 'suite'))
> +               self.linux_source_mock.run_kernel.assert_has_calls([
> +                       mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', timeout=300),
> +                       mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', timeout=300),
> +               ])
> +
> +       @mock.patch.object(kunit, '_list_tests')
> +       def test_run_isolated_by_test(self, mock_tests):
> +               mock_tests.return_value = ['suite.test1', 'suite.test2', 'suite2.test1']
> +               kunit.main(['exec', '--run_isolated=test', 'suite*'], self.linux_source_mock)
> +
> +               # Should respect the user's filter glob when listing tests.
> +               mock_tests.assert_called_once_with(mock.ANY,
> +                                    kunit.KunitExecRequest(300, '.kunit', False, 'suite*', None, 'test'))
> +               self.linux_source_mock.run_kernel.assert_has_calls([
> +                       mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', timeout=300),
> +                       mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', timeout=300),
> +                       mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test1', timeout=300),
> +               ])
> +
>
>  if __name__ == '__main__':
>         unittest.main()
> --
> 2.33.0.685.g46640cef36-goog
>
