Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BCF3B7A8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jun 2021 00:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbhF2XAO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Jun 2021 19:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbhF2XAN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Jun 2021 19:00:13 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D8BC061760
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jun 2021 15:57:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id g7so1057533wri.7
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jun 2021 15:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1GwQpra/KQPWoCRAlFJjNi7iu4asJcHcBwiuJivAnGg=;
        b=eybKy6mFLIkvxYvPi3HSPRLHk8vvbO3rJF8/y+e3qIj8eqA4TOoGdARSmk4UUeXubi
         +5geT31XcpCN6AYcy8zCjo6A8nIxbeRym/2Dat7lpZ1KYcwnFF31qlyd22WX/okciPk/
         eCFZX5P97jM5tnCQvBB4Vy9N+KlwdYDeV04pSdDKuqj+wvySmky02g2kDCXP6ZYqb3c7
         yVAbePkZLZUhCtJSO3smJe/ETf3esXY17/iCJiIVPItyGv3TM8eR+EsE2pVEn9iL0pH0
         2e+CnwU2QR7JWImhnMp1MuIfMZs3/KljJYaFSzOQIqlYQ3PHObNTU/v4pjXtZem66nWK
         qlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1GwQpra/KQPWoCRAlFJjNi7iu4asJcHcBwiuJivAnGg=;
        b=KPyiow8VVcv1xPMPgaGzpoT9SHvl2seXjqyXka462Ty78dxbF5YCeMVl3tNuareQsC
         7fW2TA7O4z5UHttYeNOOCMhEK3GP+NTfy77c0C0l6Zobl9rqZtPo6w5bK1PfZumxJj9m
         MPGH24Vb1sAB7OUSDVtf5DfMKKJiM9Zl2uL34cGW0l4A+fH7sJmvvOjNcMaXCNNmrf+x
         6vSnq5QQJGbEbCN/+5gfPWWTclH074nw31N6PkJIEVC6LdIxOsrt8JyuqsCNMBNMd8Lw
         Nl21UFrrt3MMaB2egtDsRLIcX4dmOYkjtyUR+rfig27/BmuME6CsqiB3XnztNBbrqtYg
         GgBQ==
X-Gm-Message-State: AOAM530nyKexskY55VWmDnH9gNqEPKU0zOYkWyrAQWzInn7O9FrHgqYx
        FZl0oNFpLCrQ6eBFLNNdxgJeSXpba6UiVASRM7tm9g==
X-Google-Smtp-Source: ABdhPJzcStTNFn7PT9mdM/fs5L78Ch+MJXH77W9tD6W0B/zz8w+bfFdJPTKdUblctuomZhn/o6934pltS/EiokPbr9Q=
X-Received: by 2002:a5d:4103:: with SMTP id l3mr18118189wrp.102.1625007463255;
 Tue, 29 Jun 2021 15:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210629223541.1512296-1-rmoar@google.com>
In-Reply-To: <20210629223541.1512296-1-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 30 Jun 2021 06:57:31 +0800
Message-ID: <CABVgOSn3T1qYkDkzOYEOyZ3StPU0nprKrSwOynBF4=JScsN1pg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Fix error messages for cases of no tests and
 wrong TAP header
To:     Rae Moar <rmoar@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <shuah@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 30, 2021 at 6:36 AM Rae Moar <rmoar@google.com> wrote:
>
> In the case of the TAP output having an incorrect header format, the
> parser used to output an error message of 'no tests run!'. Additionally,
> in the case of TAP output with the correct header but no tests, the
> parser used to output an error message of 'could not parse test
> results!'.  This patch corrects the error messages for these two cases
> by switching the original outputted error messages and correcting the
> tests in kunit_toot_test.py.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

These error messages make a lot more sense, thank you!

With this patch, we can close
https://bugzilla.kernel.org/show_bug.cgi?id=207923

This is
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

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
