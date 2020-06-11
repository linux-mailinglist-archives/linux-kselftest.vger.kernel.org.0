Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8871F6F66
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jun 2020 23:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgFKVXJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 17:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgFKVXI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 17:23:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993A5C08C5C2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 14:23:08 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 185so3068242pgb.10
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 14:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MiTYCuQl+ZdzBFJn18UFrqqp+8lTnOBH02+yJi7n6H8=;
        b=MDNccs3/jgCvJ+k03M7K8vLs8G1VreIDmA7Gsol0dqoBc3OOF7Q5cRc1VLsXpSQG67
         ZnBL3dK5ZyJ08Mg2fEXJtl8qp9v4WYh3KTQKoZxusHXJx4uLi+jjYJbD7hxyeHHdDL7s
         yDrqMY92jY7xn46lP4OAojkqxvE5GDpKIXgsaNHCC6EDpSpbj5FqXaBuiysXzqKurM/G
         JG9CdSeiq5ZtsJa+orugo5bGmYMmmROTHbum3tgcs+Ex14TRGHxaYWjWJs9LfwWZGAsq
         Uc4l2MiQxm0uVq/2bl3rACY7kiP42MXtztYj8yfAcVWnOQc1k7lcJhiTzkfA2y9+rx+1
         wy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MiTYCuQl+ZdzBFJn18UFrqqp+8lTnOBH02+yJi7n6H8=;
        b=Ov9gvpfFTe9obt6PpHohRL+FuiMnCl2almcyCxK3H/8I48EtvWLZ3aspNnnBK+i4wy
         qX6e+m48LK3ICwlubx3Aqzp3DtyuP1tffLaUOCSqJ6UqixKKBXisWbEjDYrk7YIS6ETx
         /3DR5BIcv4WZ7LOTMGewtkZVTuDi0ZYGXESm6SPHc/8RiPwy9qgs/Od3+9jHuvDGgv2R
         qf+HnI/PaLEcrhwEMOw9NT+LND8uA8tXLaruksUHwTPZWBjgNo7fjrEQwncSxqSktTIU
         RiVTIRVzNc8afM76qsPh9abC+sKTIPfp63cqN7DKoyye3z1srsUv0uTHY2qbYJdjiHcn
         DIlg==
X-Gm-Message-State: AOAM530qHaNbfp1M10FqqVydHITzap8sYm/Cw+aQJPfxwTTAcKUIliOE
        SH4pjFJ7OTnksk6uXmgtaxhRcHzi1o19MIlI9aurHQ==
X-Google-Smtp-Source: ABdhPJwtEHBVGRfqIzEXIXx/tubQ7/m124fwiIaNsvfPEkxZiUvoNj87umNfW6vDyZJ604qm5w8Mr07LKHxXQl328PU=
X-Received: by 2002:a65:45c2:: with SMTP id m2mr7977244pgr.201.1591910587677;
 Thu, 11 Jun 2020 14:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200611210545.173886-1-urielguajardojr@gmail.com>
In-Reply-To: <20200611210545.173886-1-urielguajardojr@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 11 Jun 2020 14:22:56 -0700
Message-ID: <CAFd5g44qv_GvF09jCS1KxhRRzi9qc9rJ_1n8Bnumd2LaoW2z7g@mail.gmail.com>
Subject: Re: [PATCH] kunit: show error if kunit results are not present
To:     Uriel Guajardo <urielguajardojr@gmail.com>,
        Will Chen <chenwi@google.com>
Cc:     Uriel Guajardo <urielguajardo@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+Will Chen

On Thu, Jun 11, 2020 at 2:17 PM Uriel Guajardo
<urielguajardojr@gmail.com> wrote:
>
> From: Uriel Guajardo <urielguajardo@google.com>
>
> Currently, if the kernel is configured incorrectly or if it crashes before any
> kunit tests are run, kunit finishes without error, reporting
> that 0 test cases were run.
>
> To fix this, an error is shown when the tap header is not found, which
> indicates that kunit was not able to run at all.
>
> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> ---
>  tools/testing/kunit/kunit_parser.py               |   8 ++++----
>  tools/testing/kunit/kunit_tool_test.py            |  11 +++++++++++
>  .../kunit/test_data/test_insufficient_memory.log  | Bin 0 -> 856 bytes
>  3 files changed, 15 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/kunit/test_data/test_insufficient_memory.log
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 64aac9dcd431..f13e0c0d6663 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -265,11 +265,9 @@ def bubble_up_suite_errors(test_suite_list: List[TestSuite]) -> TestStatus:
>         return bubble_up_errors(lambda x: x.status, test_suite_list)
>
>  def parse_test_result(lines: List[str]) -> TestResult:
> -       if not lines:
> -               return TestResult(TestStatus.NO_TESTS, [], lines)
>         consume_non_diagnositic(lines)
> -       if not parse_tap_header(lines):
> -               return None
> +       if not lines or not parse_tap_header(lines):
> +               return TestResult(TestStatus.NO_TESTS, [], lines)
>         test_suites = []
>         test_suite = parse_test_suite(lines)
>         while test_suite:
> @@ -282,6 +280,8 @@ def parse_run_tests(kernel_output) -> TestResult:
>         failed_tests = 0
>         crashed_tests = 0
>         test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
> +       if test_result.status == TestStatus.NO_TESTS:
> +               print_with_timestamp(red('[ERROR] ') + 'no kunit output detected')
>         for test_suite in test_result.suites:
>                 if test_suite.status == TestStatus.SUCCESS:
>                         print_suite_divider(green('[PASSED] ') + test_suite.name)
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 984588d6ba95..4a7ef2eef831 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -170,6 +170,17 @@ class KUnitParserTest(unittest.TestCase):
>                         result.status)
>                 file.close()
>
> +       def test_no_kunit_output(self):
> +               crash_log = get_absolute_path(
> +                       'test_data/test_insufficient_memory.log')
> +               file = open(crash_log)
> +               print_mock = mock.patch('builtins.print').start()
> +               result = kunit_parser.parse_run_tests(
> +                       kunit_parser.isolate_kunit_output(file.readlines()))
> +               print_mock.assert_any_call(StrContains("no kunit output detected"))
> +               print_mock.stop()
> +               file.close()
> +
>         def test_crashed_test(self):
>                 crashed_log = get_absolute_path(
>                         'test_data/test_is_test_passed-crash.log')
> diff --git a/tools/testing/kunit/test_data/test_insufficient_memory.log b/tools/testing/kunit/test_data/test_insufficient_memory.log
> new file mode 100644
> index 0000000000000000000000000000000000000000..6c9e4da7b6d763a03c0c83302b2faa6dc21a6ea6
> GIT binary patch
> literal 856
> zcmbu6Piw<448`yH6xx0L3mw^@hf#VOv}5$J+fZ#KHj8CrJK6H>=Z2=CgO$<hA}n~n
> z_av{ZCy=#qP-&xMfG4=6vR)i)5n%+={(WUX@f3QQc$@8JeI=@sWh+JEQ*#MXVFVXF
> z3Ic%)LLrv~p$(Btnp72VZT95Dcs$;|{9!uqlCTqzsVj`yGB}JvL1F#T<`SpJ4?L6&
> zvLJa#bUk?B5jWafHpCGc^cwdSg)SXJ+Sp0$Q$V&%X;`!D6P@>grwf=!Y9>J$&;ioE
> z(YWH`vCdK5Yv8@UZFe8*_w@>lK?j;o`2XCkM`zDc9)5TBu*ma#3i~#uEu#ge+Mv@N
> z!H}`OJ&aI@v}o*ZK;I-rL20Tal*zuYY-cSL^z~bR2OA<uaygqX^7-Rzeh;N?h?hs>
> F><3Em&*A_8
>
> literal 0
> HcmV?d00001
>
> --
> 2.27.0.278.ge193c7cf3a9-goog
>
