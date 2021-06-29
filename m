Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB403B7AA0
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jun 2021 01:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbhF2XQQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Jun 2021 19:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbhF2XQP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Jun 2021 19:16:15 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62C3C061760
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jun 2021 16:13:47 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id v5so914405ilo.5
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jun 2021 16:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tiobBDIQld9dYsgkm0AZ3GKWgOyeCJkyHrH4ASDqKKs=;
        b=r3SFSKaUJ+xM0Jzgxudbu7aSagqo6b9gN7Boc+4lvfnCFoyrgGX5cIMGS8x+KtHtJV
         zAIBOboZ/tpZU2Zob57pPW8b+PoZuFs7+4xsxSTkFrTftwa1r6+RnVDbuuaZxC3dka9X
         7ZTJrHCL9D2Q2oWpG2Z8gczU+TPB6sNKYbyEEo2xffnYUt17Ln7Ai2to8WuTdkgGkRb3
         HF7zXaqFIE7IbZlFag3MxzBcTyuQ2WBrOAf2fX6PUmIU6ZSZxDwjGi2VWQX4b58K8p+6
         YQA/xZo3vCoWN9f+QpSdORN0UhOuJBfjNPWletbaDpH8b83S2yHPlbgZDKEocwflaJzY
         aXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tiobBDIQld9dYsgkm0AZ3GKWgOyeCJkyHrH4ASDqKKs=;
        b=TCFjnRIwlItPpww5YHvl/IwxF93ZTdSdtDAO4eq9cHN1vxa5kht0uEGJp1DFeE9Kc+
         /TLh7sx8LioFpbBuwygE2eKOGge+ulLJJ/abmD+u5IlL+b3fpcvPqT0tpOURuMjrwGHF
         e4KI3Vd96RBpDt4qWczDVrL7u3wm7zbRpx5f1adBnhifj2nrYspwoTfV0B+h8xAyPE1r
         SzKt1pkYlXkAKgl+6mdtjorHE2tktAcFJfxqNmuWIFi4bRVcztV3UA7ZIhRnvnCSt2KT
         Tv2ECUiFkgKsHxJFWmBnBhFJSpXdZbSzVfX7w37N0it3kp7S/RQrbeNIp6qaFUeSPnPn
         APcg==
X-Gm-Message-State: AOAM531wuJW2od6royvO4QZo9hSzba1rf+HS5i4RyYoPct/RO7EvkWMi
        Ew9bTbdLqk0GH1hb9uPa6vm+R3TTXx5d0CVwznliSg==
X-Google-Smtp-Source: ABdhPJy5Bm3pG2e1+1hqMJQzY6xlJP2gjDA8cjgszq9Jt6mGe8ljIjXt86IF2hDqP/zP7MCQ89xG5dYCdiinLeYq8oA=
X-Received: by 2002:a92:2a0a:: with SMTP id r10mr24263642ile.274.1625008426775;
 Tue, 29 Jun 2021 16:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210629223541.1512296-1-rmoar@google.com>
In-Reply-To: <20210629223541.1512296-1-rmoar@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 29 Jun 2021 16:13:35 -0700
Message-ID: <CAGS_qxpbVZQva0bGPyGkWQccqoPXu-fCi5Jk4=tgFUEPsXgBFw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Fix error messages for cases of no tests and
 wrong TAP header
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com, shuah@kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 29, 2021 at 3:36 PM Rae Moar <rmoar@google.com> wrote:
>
> In the case of the TAP output having an incorrect header format, the
> parser used to output an error message of 'no tests run!'. Additionally,
> in the case of TAP output with the correct header but no tests, the
> parser used to output an error message of 'could not parse test
> results!'.  This patch corrects the error messages for these two cases
> by switching the original outputted error messages and correcting the
> tests in kunit_toot_test.py.

You might want to include an example like this in your commit description:

Before:
$ ./tools/testing/kunit/kunit.py parse /dev/null
[ERROR] no tests run!
...

After:
$ ./tools/testing/kunit/kunit.py parse /dev/null
[ERROR] could not parse test results!
...

We could also include an example with a header but 0 tests, but I
think /dev/null illustrates this enough.
But if we wanted to:

Before:
$ echo -e 'TAP version 14\n1..0' | ./tools/testing/kunit/kunit.py parse
[ERROR] could not parse test results!

After:
$ echo -e 'TAP version 14\n1..0' | ./tools/testing/kunit/kunit.py parse
[ERROR] no tests run!


>
> Signed-off-by: Rae Moar <rmoar@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Looks good to me.
One minor nit/request about the new test log we've added.

> ---
>  tools/testing/kunit/kunit_parser.py           |  6 +-
>  tools/testing/kunit/kunit_tool_test.py        | 16 +++-
>  ...is_test_passed-no_tests_run_no_header.log} |  0
>  ...s_test_passed-no_tests_run_with_header.log | 77 +++++++++++++++++++
>  4 files changed, 94 insertions(+), 5 deletions(-)
>  rename tools/testing/kunit/test_data/{test_is_test_passed-no_tests_run.log => test_is_test_passed-no_tests_run_no_header.log} (100%)
>  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_with_header.log
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index c3c524b79db8..b88db3f51dc5 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -338,9 +338,11 @@ def bubble_up_suite_errors(test_suites: Iterable[TestSuite]) -> TestStatus:
>  def parse_test_result(lines: LineStream) -> TestResult:
>         consume_non_diagnostic(lines)
>         if not lines or not parse_tap_header(lines):
> -               return TestResult(TestStatus.NO_TESTS, [], lines)
> +               return TestResult(TestStatus.FAILURE_TO_PARSE_TESTS, [], lines)
>         expected_test_suite_num = parse_test_plan(lines)
> -       if not expected_test_suite_num:
> +       if expected_test_suite_num == 0:
> +               return TestResult(TestStatus.NO_TESTS, [], lines)
> +       elif expected_test_suite_num is None:
>                 return TestResult(TestStatus.FAILURE_TO_PARSE_TESTS, [], lines)
>         test_suites = []
>         for i in range(1, expected_test_suite_num + 1):
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index bdae0e5f6197..75045aa0f8a1 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -157,8 +157,18 @@ class KUnitParserTest(unittest.TestCase):
>                         kunit_parser.TestStatus.FAILURE,
>                         result.status)
>
> +       def test_no_header(self):
> +               empty_log = test_data_path('test_is_test_passed-no_tests_run_no_header.log')
> +               with open(empty_log) as file:
> +                       result = kunit_parser.parse_run_tests(
> +                               kunit_parser.extract_tap_lines(file.readlines()))
> +               self.assertEqual(0, len(result.suites))
> +               self.assertEqual(
> +                       kunit_parser.TestStatus.FAILURE_TO_PARSE_TESTS,
> +                       result.status)
> +
>         def test_no_tests(self):
> -               empty_log = test_data_path('test_is_test_passed-no_tests_run.log')
> +               empty_log = test_data_path('test_is_test_passed-no_tests_run_with_header.log')
>                 with open(empty_log) as file:
>                         result = kunit_parser.parse_run_tests(
>                                 kunit_parser.extract_tap_lines(file.readlines()))
> @@ -173,7 +183,7 @@ class KUnitParserTest(unittest.TestCase):
>                 with open(crash_log) as file:
>                         result = kunit_parser.parse_run_tests(
>                                 kunit_parser.extract_tap_lines(file.readlines()))
> -               print_mock.assert_any_call(StrContains('no tests run!'))
> +               print_mock.assert_any_call(StrContains('could not parse test results!'))
>                 print_mock.stop()
>                 file.close()
>
> @@ -309,7 +319,7 @@ class KUnitJsonTest(unittest.TestCase):
>                         result["sub_groups"][1]["test_cases"][0])
>
>         def test_no_tests_json(self):
> -               result = self._json_for('test_is_test_passed-no_tests_run.log')
> +               result = self._json_for('test_is_test_passed-no_tests_run_with_header.log')
>                 self.assertEqual(0, len(result['sub_groups']))
>
>  class StrContains(str):
> diff --git a/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_no_header.log
> similarity index 100%
> rename from tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log
> rename to tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_no_header.log
> diff --git a/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_with_header.log b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_with_header.log
> new file mode 100644
> index 000000000000..18215b236783
> --- /dev/null
> +++ b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_with_header.log

Can we truncate this log down to a smaller one w/ just the essential bits?
I don't know that printing out lines about Brendan's workstation is
necessarily relevant to the test :)

The main part we need is

+TAP version 14
+1..0

I know this is just copying from what we had before in the "no_header"
version, but it feels a bit excessive to have all this.

> @@ -0,0 +1,77 @@
> +Core dump limits :
> +       soft - 0
> +       hard - NONE
> +Checking environment variables for a tempdir...none found
> +Checking if /dev/shm is on tmpfs...OK
> +Checking PROT_EXEC mmap in /dev/shm...OK
> +Adding 24743936 bytes to physical memory to account for exec-shield gap
> +Linux version 4.12.0-rc3-00010-g7319eb35f493-dirty (brendanhiggins@mactruck.svl.corp.google.com) (gcc version 7.3.0 (Debian 7.3.0-5) ) #29 Thu Mar 15 14:57:19 PDT 2018
> +Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 14038
> +Kernel command line: root=98:0
> +PID hash table entries: 256 (order: -1, 2048 bytes)
> +Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
> +Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
> +Memory: 27868K/56932K available (1681K kernel code, 480K rwdata, 400K rodata, 89K init, 205K bss, 29064K reserved, 0K cma-reserved)
> +SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> +NR_IRQS:15
> +clocksource: timer: mask: 0xffffffffffffffff max_cycles: 0x1cd42e205, max_idle_ns: 881590404426 ns
> +Calibrating delay loop... 7384.26 BogoMIPS (lpj=36921344)
> +pid_max: default: 32768 minimum: 301
> +Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> +Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes)
> +Checking that host ptys support output SIGIO...Yes
> +Checking that host ptys support SIGIO on close...No, enabling workaround
> +Using 2.6 host AIO
> +clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
> +futex hash table entries: 256 (order: 0, 6144 bytes)
> +clocksource: Switched to clocksource timer
> +console [stderr0] disabled
> +mconsole (version 2) initialized on /usr/local/google/home/brendanhiggins/.uml/6Ijecl/mconsole
> +Checking host MADV_REMOVE support...OK
> +workingset: timestamp_bits=62 max_order=13 bucket_order=0
> +Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
> +io scheduler noop registered
> +io scheduler deadline registered
> +io scheduler cfq registered (default)
> +io scheduler mq-deadline registered
> +io scheduler kyber registered
> +Initialized stdio console driver
> +Using a channel type which is configured out of UML
> +setup_one_line failed for device 1 : Configuration failed
> +Using a channel type which is configured out of UML
> +setup_one_line failed for device 2 : Configuration failed
> +Using a channel type which is configured out of UML
> +setup_one_line failed for device 3 : Configuration failed
> +Using a channel type which is configured out of UML
> +setup_one_line failed for device 4 : Configuration failed
> +Using a channel type which is configured out of UML
> +setup_one_line failed for device 5 : Configuration failed
> +Using a channel type which is configured out of UML
> +setup_one_line failed for device 6 : Configuration failed
> +Using a channel type which is configured out of UML
> +setup_one_line failed for device 7 : Configuration failed
> +Using a channel type which is configured out of UML
> +setup_one_line failed for device 8 : Configuration failed
> +Using a channel type which is configured out of UML
> +setup_one_line failed for device 9 : Configuration failed
> +Using a channel type which is configured out of UML
> +setup_one_line failed for device 10 : Configuration failed
> +Using a channel type which is configured out of UML
> +setup_one_line failed for device 11 : Configuration failed
> +Using a channel type which is configured out of UML
> +setup_one_line failed for device 12 : Configuration failed
> +Using a channel type which is configured out of UML
> +setup_one_line failed for device 13 : Configuration failed
> +Using a channel type which is configured out of UML
> +setup_one_line failed for device 14 : Configuration failed
> +Using a channel type which is configured out of UML
> +setup_one_line failed for device 15 : Configuration failed
> +Console initialized on /dev/tty0
> +console [tty0] enabled
> +console [mc-1] enabled
> +TAP version 14
> +1..0
> +List of all partitions:
> +No filesystem could mount root, tried:
> +
> +Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(98,0)
> --
> 2.32.0.93.g670b81a890-goog
>
