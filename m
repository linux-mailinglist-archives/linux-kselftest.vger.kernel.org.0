Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5D61C108C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 May 2020 11:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgEAJ5x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 May 2020 05:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728492AbgEAJ5v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 May 2020 05:57:51 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8451FC09B040
        for <linux-kselftest@vger.kernel.org>; Fri,  1 May 2020 02:57:51 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id i9so610641ool.5
        for <linux-kselftest@vger.kernel.org>; Fri, 01 May 2020 02:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGaU+wKFVbV2rAss2AjKpFbiC5Lau7H8388Zbazbr4Q=;
        b=RXxxyQky5lthKQjVFb2j2sx4oRqvc9W4m50GmIJ9yBU6zC8RelJVS+wF0nx4uISIwR
         r9ZciFyAuLFo61Jz/pOWMZJyusJLScbePnqufkI+OR0nM+J0vcnhvOMtPIXetK41H76q
         7fxq81w1GbA3/j3WIwz3zEbAYgxS9T6tgOPS1TaQOj6T2cpBFINhxxAQ0HR44BYhTsNv
         0djHiZoWVom7qag5NeHX15wpxdcAqoqYGMmSrVhchKiFzbVTinRoiG6sYtwZyTntSzlv
         i18fQ4ScDoRbCVhmkp1dPbm7IUz0Pmc26eCO9DJCbEXhrh4dqGlvSlXT1jeMvhzrU8mj
         DskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGaU+wKFVbV2rAss2AjKpFbiC5Lau7H8388Zbazbr4Q=;
        b=i/UZDBnjdgTcv1ZkY+IxkJuL3JphwJVRxEd0NHXjeV6J9T51hRGzaoxhUACE3JV4LX
         kelFUrZDWiiwMoeU4JQ6m90R19Vl7qQekyCbh3INa849fNJA99WOPGu6KakPdPiPWukq
         xNc/IFvoIEDdATbO4/yJ3giGIVU/2GpTdUHDf+5mTbDYEPqgAROUvLo68crTQz+tD3b4
         iugms80AlqfuIGAgS3SzVjM1ehkoZrkmVV6EaPOJC6kCxvFrTGUa+Q1+hOWslUqXWo3r
         9z6/6mKZO6Lxqz2qZlqA2/Kez/uEG1GbrGXMIHq5fWusXNDlh0c+q67cy26fwQ+Ebv/b
         ANuA==
X-Gm-Message-State: AGi0PubWbrnc3yPHFLZpOI1yWOpML6W03HiJxFQl5cmuh3AJMWZOmx1i
        CWpoTJ5F0tHhJOEIGFfDerK1JSDaiY25tOTmNUGdpQ==
X-Google-Smtp-Source: APiQypINO1sPCoWf+LPZMpQkJdEySPVbtW74n8/VWE9is0OO2sbVA0bu/Sw2vW8nlz0V+WEWr8SDwdKWM/j24nXLI0Y=
X-Received: by 2002:a4a:e1d2:: with SMTP id n18mr3123585oot.36.1588327070112;
 Fri, 01 May 2020 02:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200501083510.1413-1-anders.roxell@linaro.org>
In-Reply-To: <20200501083510.1413-1-anders.roxell@linaro.org>
From:   Marco Elver <elver@google.com>
Date:   Fri, 1 May 2020 11:57:37 +0200
Message-ID: <CANpmjNNm9DhVj5T1rhykEdNBiTvkG-YxL6O25bSfQi8ySh9KtA@mail.gmail.com>
Subject: Re: [PATCH] kunit: Kconfig: enable a KUNIT_RUN_ALL fragment
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        LKML <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 1 May 2020 at 10:35, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Make it easier to enable all KUnit fragments.  This is needed for kernel
> test-systems, so its easy to get all KUnit tests enabled and if new gets
> added they will be enabled as well.  Fragments that has to be builtin
> will be missed if CONFIG_KUNIT_RUN_ALL is set as a module.
>
> Adding 'if !KUNIT_RUN_ALL' so individual test can be turned of if
> someone wants that even though KUNIT_RUN_ALL is enabled.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/base/Kconfig      |  3 ++-
>  drivers/base/test/Kconfig |  3 ++-
>  fs/ext4/Kconfig           |  3 ++-
>  lib/Kconfig.debug         |  6 ++++--
>  lib/Kconfig.kcsan         |  3 ++-
>  lib/kunit/Kconfig         | 15 ++++++++++++---
>  security/apparmor/Kconfig |  3 ++-
>  7 files changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 5f0bc74d2409..c48e6e4ef367 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -149,8 +149,9 @@ config DEBUG_TEST_DRIVER_REMOVE
>           test this functionality.
>
>  config PM_QOS_KUNIT_TEST
> -       bool "KUnit Test for PM QoS features"
> +       bool "KUnit Test for PM QoS features" if !KUNIT_RUN_ALL
>         depends on KUNIT=y
> +       default KUNIT_RUN_ALL
>
>  config HMEM_REPORTING
>         bool
> diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
> index 305c7751184a..0d662d689f6b 100644
> --- a/drivers/base/test/Kconfig
> +++ b/drivers/base/test/Kconfig
> @@ -9,5 +9,6 @@ config TEST_ASYNC_DRIVER_PROBE
>
>           If unsure say N.
>  config KUNIT_DRIVER_PE_TEST
> -       bool "KUnit Tests for property entry API"
> +       bool "KUnit Tests for property entry API" if !KUNIT_RUN_ALL
>         depends on KUNIT=y
> +       default KUNIT_RUN_ALL
> diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
> index 2a592e38cdfe..76785143259d 100644
> --- a/fs/ext4/Kconfig
> +++ b/fs/ext4/Kconfig
> @@ -103,9 +103,10 @@ config EXT4_DEBUG
>                 echo 1 > /sys/module/ext4/parameters/mballoc_debug
>
>  config EXT4_KUNIT_TESTS
> -       tristate "KUnit tests for ext4"
> +       tristate "KUnit tests for ext4" if !KUNIT_RUN_ALL
>         select EXT4_FS
>         depends on KUNIT
> +       default KUNIT_RUN_ALL
>         help
>           This builds the ext4 KUnit tests.
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 8e4aded46281..993e0c5549bc 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2123,8 +2123,9 @@ config TEST_SYSCTL
>           If unsure, say N.
>
>  config SYSCTL_KUNIT_TEST
> -       tristate "KUnit test for sysctl"
> +       tristate "KUnit test for sysctl" if !KUNIT_RUN_ALL
>         depends on KUNIT
> +       default KUNIT_RUN_ALL
>         help
>           This builds the proc sysctl unit test, which runs on boot.
>           Tests the API contract and implementation correctness of sysctl.
> @@ -2134,8 +2135,9 @@ config SYSCTL_KUNIT_TEST
>           If unsure, say N.
>
>  config LIST_KUNIT_TEST
> -       tristate "KUnit Test for Kernel Linked-list structures"
> +       tristate "KUnit Test for Kernel Linked-list structures" if !KUNIT_RUN_ALL
>         depends on KUNIT
> +       default KUNIT_RUN_ALL
>         help
>           This builds the linked list KUnit test suite.
>           It tests that the API and basic functionality of the list_head type
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index ea28245c6c1d..91398300a1bc 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -46,8 +46,9 @@ config KCSAN_SELFTEST
>           works as intended.
>
>  config KCSAN_TEST
> -       tristate "KCSAN test for integrated runtime behaviour"
> +       tristate "KCSAN test for integrated runtime behaviour" if !KUNIT_RUN_ALL
>         depends on TRACEPOINTS && KUNIT
> +       default KUNIT_RUN_ALL
>         select TORTURE_TEST
>         help
>           KCSAN test focusing on behaviour of the integrated runtime. Tests

I think if you want this patch to be picked up you need to split it,
with one patch for each test that is not yet in mainline or the tree
that should pick this patch up.

The KCSAN test is in the -rcu tree, but I don't expect it to be merged
before 5.9. Most likely, we would only be able to pick up the patch
that would make the chance to the KCSAN Kconfig entry once the rest
here made it into mainline.

Thanks,
-- Marco

> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 95d12e3d6d95..d6a912779816 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -15,7 +15,8 @@ menuconfig KUNIT
>  if KUNIT
>
>  config KUNIT_DEBUGFS
> -       bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation"
> +       bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation" if !KUNIT_RUN_ALL
> +       default KUNIT_RUN_ALL
>         help
>           Enable debugfs representation for kunit.  Currently this consists
>           of /sys/kernel/debug/kunit/<test_suite>/results files for each
> @@ -23,7 +24,8 @@ config KUNIT_DEBUGFS
>           run that occurred.
>
>  config KUNIT_TEST
> -       tristate "KUnit test for KUnit"
> +       tristate "KUnit test for KUnit" if !KUNIT_RUN_ALL
> +       default KUNIT_RUN_ALL
>         help
>           Enables the unit tests for the KUnit test framework. These tests test
>           the KUnit test framework itself; the tests are both written using
> @@ -32,7 +34,8 @@ config KUNIT_TEST
>           expected.
>
>  config KUNIT_EXAMPLE_TEST
> -       tristate "Example test for KUnit"
> +       tristate "Example test for KUnit" if !KUNIT_RUN_ALL
> +       default KUNIT_RUN_ALL
>         help
>           Enables an example unit test that illustrates some of the basic
>           features of KUnit. This test only exists to help new users understand
> @@ -41,4 +44,10 @@ config KUNIT_EXAMPLE_TEST
>           is intended for curious hackers who would like to understand how to
>           use KUnit for kernel development.
>
> +config KUNIT_RUN_ALL
> +       tristate "KUnit run all test"
> +       help
> +         Enables all KUnit tests. If they can be enabled.
> +         That depends on if KUnit is enabled as a module or builtin.
> +

s/tests. If/tests, if/ ?

>  endif # KUNIT
> diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
> index 0fe336860773..c4648426ea5d 100644
> --- a/security/apparmor/Kconfig
> +++ b/security/apparmor/Kconfig
> @@ -70,8 +70,9 @@ config SECURITY_APPARMOR_DEBUG_MESSAGES
>           the kernel message buffer.
>
>  config SECURITY_APPARMOR_KUNIT_TEST
> -       bool "Build KUnit tests for policy_unpack.c"
> +       bool "Build KUnit tests for policy_unpack.c" if !KUNIT_RUN_ALL
>         depends on KUNIT=y && SECURITY_APPARMOR
> +       default KUNIT_RUN_ALL
>         help
>           This builds the AppArmor KUnit tests.
>
> --
> 2.20.1
>
