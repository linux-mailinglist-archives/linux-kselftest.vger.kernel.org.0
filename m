Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BD0295647
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Oct 2020 04:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894894AbgJVCHt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Oct 2020 22:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894889AbgJVCHt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Oct 2020 22:07:49 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D75C0613CE
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 19:07:48 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r127so184484lff.12
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 19:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9wdkRtr7X7CfvuI3jpE6RlFo76G+xNlRBeHr1kIcog4=;
        b=SdqeRLZRTbGDGdVvNAvsSZ8tQBucooi1ZtBoiQQBbtHz9J9PTIVllag0dxPSeAz4Qy
         XJlofZw4AlYetgajDTD3xdkJf7Nlr+fRGhRcYFsXv2ts3nhkGtJprXudT1a14+5ZKouv
         na/QLUKV/8Yo7PM5lG3f+3jZJ1KKXzuk82GX3ppohJCOgCUCOfoZwCdrfjX1Kx8vAljW
         dMlVqDFnGULI/+TlfbKjexi0eGieB+o3DuzdZgZ6mmi9XSTFGK7ERgU6vWVM9A4QVeZW
         YbTY6dvf8MYd85o5tsj3nJGsul8MsUIX8w6XLzZ/KHA4bg3IA11D6qbGlLlaQceMJZd7
         Y15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wdkRtr7X7CfvuI3jpE6RlFo76G+xNlRBeHr1kIcog4=;
        b=B/aSzV/7u+vUDs3oP2+YE2Gn7PpXDkXcENDc3ns8FhPmBBDjIHNO9ICN5XIughvxHd
         M6L2KnNg8bHz7H9FsfsECPEnWHwewmU3sIO+o3gxaDcWIKjHJ4I8FuJjy11G3Akr/35P
         DYl+KPrPISuHRpcZrJAH6Yd9AvoGw51W879P8ljIj+tTaOjOHU0MY9Leqr0g36mM6P78
         OPHUOPz1DiFAGtKFNp5MbN1QDNzJPwAWwE8S04DKcB5B8fD23wIgR5PpBtirIqP58Y7j
         gHVpcIIlrXkfa9xlarp2okOJm3/ktuVanjeBFRxQdESMcGDO/DQJ5TeM/UljYf/jxG7C
         +FFQ==
X-Gm-Message-State: AOAM532MAn8yD6ko6NoWOV+tOzm5UmB+t8FWtp39t8EyPcdybLJl0NxB
        Y+x/hE6a6ZKDBTGz/zwX65Thkc5G+l9d3U9PYBDdfQ==
X-Google-Smtp-Source: ABdhPJwayUj/Jluz98tD0+Kk7vaGNzyrcuJtlxjrMOUFa8ivIV+yUqVRbBd2ZEeBZH98Pw9aC7UVQrAaci9DMDekhMo=
X-Received: by 2002:a19:241:: with SMTP id 62mr53845lfc.165.1603332466549;
 Wed, 21 Oct 2020 19:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201021203914.2650778-1-brendanhiggins@google.com>
In-Reply-To: <20201021203914.2650778-1-brendanhiggins@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 22 Oct 2020 10:07:35 +0800
Message-ID: <CABVgOSmJR2zEy7g_8bY+zdyVv0k_N=oS_6sj5E5p=2a7B0Y0sA@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: tools: fix kunit_tool tests for parsing test plans
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 22, 2020 at 4:39 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Some tests logs for kunit_tool tests are missing their test plans
> causing their tests to fail; fix this by adding the test plans.
>
> Fixes: 45dcbb6f5ef7 ("kunit: test: add test plan to KUnit TAP format")
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Excellent: this fixes all of the failing tests in kunit_tool_test.py for me.

Reviewed-by: David Gow <davidgow@google.com>

-- David

> ---
>  tools/testing/kunit/kunit_tool_test.py        |  32 ++++++++++++++----
>  .../test_data/test_config_printk_time.log     | Bin 1584 -> 1605 bytes
>  .../test_data/test_interrupted_tap_output.log | Bin 1982 -> 2003 bytes
>  .../test_data/test_kernel_panic_interrupt.log | Bin 1321 -> 1342 bytes
>  .../test_data/test_multiple_prefixes.log      | Bin 1832 -> 1861 bytes
>  .../kunit/test_data/test_pound_no_prefix.log  | Bin 1193 -> 1200 bytes
>  .../kunit/test_data/test_pound_sign.log       | Bin 1656 -> 1676 bytes
>  7 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 99c3c5671ea48..0b60855fb8198 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -179,7 +179,7 @@ class KUnitParserTest(unittest.TestCase):
>                 print_mock = mock.patch('builtins.print').start()
>                 result = kunit_parser.parse_run_tests(
>                         kunit_parser.isolate_kunit_output(file.readlines()))
> -               print_mock.assert_any_call(StrContains("no kunit output detected"))
> +               print_mock.assert_any_call(StrContains('no tests run!'))
>                 print_mock.stop()
>                 file.close()
>
> @@ -198,39 +198,57 @@ class KUnitParserTest(unittest.TestCase):
>                         'test_data/test_config_printk_time.log')
>                 with open(prefix_log) as file:
>                         result = kunit_parser.parse_run_tests(file.readlines())
> -               self.assertEqual('kunit-resource-test', result.suites[0].name)
> +                       self.assertEqual(
> +                               kunit_parser.TestStatus.SUCCESS,
> +                               result.status)
> +                       self.assertEqual('kunit-resource-test', result.suites[0].name)
>
>         def test_ignores_multiple_prefixes(self):
>                 prefix_log = get_absolute_path(
>                         'test_data/test_multiple_prefixes.log')
>                 with open(prefix_log) as file:
>                         result = kunit_parser.parse_run_tests(file.readlines())
> -               self.assertEqual('kunit-resource-test', result.suites[0].name)
> +                       self.assertEqual(
> +                               kunit_parser.TestStatus.SUCCESS,
> +                               result.status)
> +                       self.assertEqual('kunit-resource-test', result.suites[0].name)
>
>         def test_prefix_mixed_kernel_output(self):
>                 mixed_prefix_log = get_absolute_path(
>                         'test_data/test_interrupted_tap_output.log')
>                 with open(mixed_prefix_log) as file:
>                         result = kunit_parser.parse_run_tests(file.readlines())
> -               self.assertEqual('kunit-resource-test', result.suites[0].name)
> +                       self.assertEqual(
> +                               kunit_parser.TestStatus.SUCCESS,
> +                               result.status)
> +                       self.assertEqual('kunit-resource-test', result.suites[0].name)
>
>         def test_prefix_poundsign(self):
>                 pound_log = get_absolute_path('test_data/test_pound_sign.log')
>                 with open(pound_log) as file:
>                         result = kunit_parser.parse_run_tests(file.readlines())
> -               self.assertEqual('kunit-resource-test', result.suites[0].name)
> +                       self.assertEqual(
> +                               kunit_parser.TestStatus.SUCCESS,
> +                               result.status)
> +                       self.assertEqual('kunit-resource-test', result.suites[0].name)
>
>         def test_kernel_panic_end(self):
>                 panic_log = get_absolute_path('test_data/test_kernel_panic_interrupt.log')
>                 with open(panic_log) as file:
>                         result = kunit_parser.parse_run_tests(file.readlines())
> -               self.assertEqual('kunit-resource-test', result.suites[0].name)
> +                       self.assertEqual(
> +                               kunit_parser.TestStatus.TEST_CRASHED,
> +                               result.status)
> +                       self.assertEqual('kunit-resource-test', result.suites[0].name)
>
>         def test_pound_no_prefix(self):
>                 pound_log = get_absolute_path('test_data/test_pound_no_prefix.log')
>                 with open(pound_log) as file:
>                         result = kunit_parser.parse_run_tests(file.readlines())
> -               self.assertEqual('kunit-resource-test', result.suites[0].name)
> +                       self.assertEqual(
> +                               kunit_parser.TestStatus.SUCCESS,
> +                               result.status)
> +                       self.assertEqual('kunit-resource-test', result.suites[0].name)
>
>  class KUnitJsonTest(unittest.TestCase):
>
> diff --git a/tools/testing/kunit/test_data/test_config_printk_time.log b/tools/testing/kunit/test_data/test_config_printk_time.log
> index c02ca773946d641291e27d44d73174cc16a17d9d..6bdb57f76eacef0396e68942cb3fa983b6992bab 100644
> GIT binary patch
> delta 25
> hcmdnMbChSob{0cDJ>$uC%rcYXnAkR+OlM`}0sw1)2Xg=b
>
> delta 10
> RcmX@gvw>&A_Kl}2Spgdh1kV5f
>
> diff --git a/tools/testing/kunit/test_data/test_interrupted_tap_output.log b/tools/testing/kunit/test_data/test_interrupted_tap_output.log
> index 5c73fb3a1c6fd13a9b163a48d02eb33b0315a375..1fb677728abeb0fe6aa5edb3a0387c05906b9815 100644
> GIT binary patch
> delta 21
> dcmdnTf0=*6b{0cDJ>$t2n3Xo3{L0421prz=2g3jW
>
> delta 17
> Zcmcc2zmI>y_Q@YucqXy1ZM^%H4FE=v2d@AC
>
> diff --git a/tools/testing/kunit/test_data/test_kernel_panic_interrupt.log b/tools/testing/kunit/test_data/test_kernel_panic_interrupt.log
> index c045eee75f27fefaabf3ba073d9e282721c19a67..a014ffe9725e3c4e81697f742cee2652a41b2108 100644
> GIT binary patch
> delta 25
> hcmZ3<wU2AUb{0cDJ>$uC%rcYXnAkR+OkiQ;0sv{Y2U!3B
>
> delta 10
> RcmdnTwUTSX_Kl~DSO6Mc1hoJF
>
> diff --git a/tools/testing/kunit/test_data/test_multiple_prefixes.log b/tools/testing/kunit/test_data/test_multiple_prefixes.log
> index bc48407dcc36c44665c7d2ac620e42e7caf98481..0ad78481a0b450bf463ca7aaab0ae739d4e43018 100644
> GIT binary patch
> delta 16
> YcmZ3%ca(3!^~t;}vKwy%urYE005`P-oB#j-
>
> delta 15
> XcmX@gw}NlN^~vX$gf_D>+Oq)wG*bm+
>
> diff --git a/tools/testing/kunit/test_data/test_pound_no_prefix.log b/tools/testing/kunit/test_data/test_pound_no_prefix.log
> index 2ceb360be7d52cbee4b0a5a426456605ded7466e..dc4cf09a96d077bbc0b5fbcb312251742e390379 100644
> GIT binary patch
> delta 17
> YcmZ3<xq)*+J&U29p7F+79Tr9|05Q}Ar~m)}
>
> delta 10
> RcmdnMxsr22{l-=;762DW1K$7u
>
> diff --git a/tools/testing/kunit/test_data/test_pound_sign.log b/tools/testing/kunit/test_data/test_pound_sign.log
> index 28ffa5ba03bfa81ea02ea9d38e7de7acf3dd9e5d..3f358e3a7ba0d118c1dc15e5f637fb8ffb5aa388 100644
> GIT binary patch
> delta 19
> bcmeyt)5AMqJBy*7p7G>PCZ&xh*RuiuM}Y?y
>
> delta 14
> WcmeC-{lPO~`{cDuLL2X{X9WN;2?l!r
>
>
> base-commit: 7cf726a59435301046250c42131554d9ccc566b8
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
