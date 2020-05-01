Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679851C1A6C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 May 2020 18:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgEAQO4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 May 2020 12:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgEAQOz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 May 2020 12:14:55 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D436C061A0C
        for <linux-kselftest@vger.kernel.org>; Fri,  1 May 2020 09:14:55 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id j3so3032668ljg.8
        for <linux-kselftest@vger.kernel.org>; Fri, 01 May 2020 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E9HC4TtDYcMl70D2yLsiFayEi4W3obxsAzPswR8DMak=;
        b=pA76bR8IKuynYeexWgwTHGHlEEpen9DlOqzAcw8uRr2dS5UZVc3caibWOKk4wQywFr
         /tIBHQx4gQ6zGTK5r8pZdcRadg+b3o1EuLGJSBl0DVAcAvwb98Cwc3OCOa8mLf1KJ3+c
         V0440x+rkHaMtCnquXTFtm776x49Mihk4Bjfq3PV2D/zg0q3/TQ0tODETFBO33pBx+Ds
         QDN6heShl3QVkqKYjsPMRfQo+Iv+nStFqK7Nkt6rYtSAUPDL+xygZO6mtDfYUABBvvCw
         fsUl/YsVPsW0bhXH1an1M33eSt6zU83YTb2j8dINm13kpXMVayyiQNmL8Q9rcXwNhv+P
         KtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9HC4TtDYcMl70D2yLsiFayEi4W3obxsAzPswR8DMak=;
        b=Y226Qjn1YZvWthoRaK2W46TIEb/CgnON1KNWNkxBYr3V3v8T3YJkN5cJPBsm9idyL0
         w5y42kzm1X2EzmuBwwYoZ+XyNA7IIln13tUZkpzIqOFez22UKOLlk5DpeO/nExU1LBR+
         gNbo72UhZiJsGBjCv4q4n6jNHUWOI2ET/uJK0y5TH6P7z+UCu2e27fGxZTKOUT3/Y/JF
         tdhNS9ML2vty0kB/ii4NKPscDNaCfqOa76mOrY+ivlyLe0sqDqRene/VKnqFmggK13tw
         HnHDA563BUN7Svl7SNIXY+ZGaDqn5hPYp4VFwMba4RHqF+h60LYr27tgbNOUVT0Ecet5
         W6Cg==
X-Gm-Message-State: AGi0PubgLmXnuDDD3VM9HTJvq1pr1dMc7TzcETV9gDr7ZGHPVtyyAt30
        u4vg9WhRR+UTX5VO2tx36PwVCx68sl7Ujkm2VadNvQ==
X-Google-Smtp-Source: APiQypK5sdtJ5Dm7sI1A1k7InQw/eggzM/HErJMHEHM6WNPkUFYgpxpemk5CyouOdKeiCaEqegrrWnev6LLK1lgEvtQ=
X-Received: by 2002:a05:651c:107a:: with SMTP id y26mr2869691ljm.80.1588349693754;
 Fri, 01 May 2020 09:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200501083510.1413-1-anders.roxell@linaro.org> <CANpmjNNm9DhVj5T1rhykEdNBiTvkG-YxL6O25bSfQi8ySh9KtA@mail.gmail.com>
In-Reply-To: <CANpmjNNm9DhVj5T1rhykEdNBiTvkG-YxL6O25bSfQi8ySh9KtA@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 1 May 2020 18:14:42 +0200
Message-ID: <CADYN=9KLb6FVZ1icbvCY0ondiim44CNk8g8buFCGqpC5cMqyVQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Kconfig: enable a KUNIT_RUN_ALL fragment
To:     Marco Elver <elver@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 1 May 2020 at 11:57, Marco Elver <elver@google.com> wrote:
>
> On Fri, 1 May 2020 at 10:35, Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > Make it easier to enable all KUnit fragments.  This is needed for kernel
> > test-systems, so its easy to get all KUnit tests enabled and if new gets
> > added they will be enabled as well.  Fragments that has to be builtin
> > will be missed if CONFIG_KUNIT_RUN_ALL is set as a module.
> >
> > Adding 'if !KUNIT_RUN_ALL' so individual test can be turned of if
> > someone wants that even though KUNIT_RUN_ALL is enabled.
> >
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  drivers/base/Kconfig      |  3 ++-
> >  drivers/base/test/Kconfig |  3 ++-
> >  fs/ext4/Kconfig           |  3 ++-
> >  lib/Kconfig.debug         |  6 ++++--
> >  lib/Kconfig.kcsan         |  3 ++-
> >  lib/kunit/Kconfig         | 15 ++++++++++++---
> >  security/apparmor/Kconfig |  3 ++-
> >  7 files changed, 26 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > index 5f0bc74d2409..c48e6e4ef367 100644
> > --- a/drivers/base/Kconfig
> > +++ b/drivers/base/Kconfig
> > @@ -149,8 +149,9 @@ config DEBUG_TEST_DRIVER_REMOVE
> >           test this functionality.
> >
> >  config PM_QOS_KUNIT_TEST
> > -       bool "KUnit Test for PM QoS features"
> > +       bool "KUnit Test for PM QoS features" if !KUNIT_RUN_ALL
> >         depends on KUNIT=y
> > +       default KUNIT_RUN_ALL
> >
> >  config HMEM_REPORTING
> >         bool
> > diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
> > index 305c7751184a..0d662d689f6b 100644
> > --- a/drivers/base/test/Kconfig
> > +++ b/drivers/base/test/Kconfig
> > @@ -9,5 +9,6 @@ config TEST_ASYNC_DRIVER_PROBE
> >
> >           If unsure say N.
> >  config KUNIT_DRIVER_PE_TEST
> > -       bool "KUnit Tests for property entry API"
> > +       bool "KUnit Tests for property entry API" if !KUNIT_RUN_ALL
> >         depends on KUNIT=y
> > +       default KUNIT_RUN_ALL
> > diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
> > index 2a592e38cdfe..76785143259d 100644
> > --- a/fs/ext4/Kconfig
> > +++ b/fs/ext4/Kconfig
> > @@ -103,9 +103,10 @@ config EXT4_DEBUG
> >                 echo 1 > /sys/module/ext4/parameters/mballoc_debug
> >
> >  config EXT4_KUNIT_TESTS
> > -       tristate "KUnit tests for ext4"
> > +       tristate "KUnit tests for ext4" if !KUNIT_RUN_ALL
> >         select EXT4_FS
> >         depends on KUNIT
> > +       default KUNIT_RUN_ALL
> >         help
> >           This builds the ext4 KUnit tests.
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 8e4aded46281..993e0c5549bc 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2123,8 +2123,9 @@ config TEST_SYSCTL
> >           If unsure, say N.
> >
> >  config SYSCTL_KUNIT_TEST
> > -       tristate "KUnit test for sysctl"
> > +       tristate "KUnit test for sysctl" if !KUNIT_RUN_ALL
> >         depends on KUNIT
> > +       default KUNIT_RUN_ALL
> >         help
> >           This builds the proc sysctl unit test, which runs on boot.
> >           Tests the API contract and implementation correctness of sysctl.
> > @@ -2134,8 +2135,9 @@ config SYSCTL_KUNIT_TEST
> >           If unsure, say N.
> >
> >  config LIST_KUNIT_TEST
> > -       tristate "KUnit Test for Kernel Linked-list structures"
> > +       tristate "KUnit Test for Kernel Linked-list structures" if !KUNIT_RUN_ALL
> >         depends on KUNIT
> > +       default KUNIT_RUN_ALL
> >         help
> >           This builds the linked list KUnit test suite.
> >           It tests that the API and basic functionality of the list_head type
> > diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> > index ea28245c6c1d..91398300a1bc 100644
> > --- a/lib/Kconfig.kcsan
> > +++ b/lib/Kconfig.kcsan
> > @@ -46,8 +46,9 @@ config KCSAN_SELFTEST
> >           works as intended.
> >
> >  config KCSAN_TEST
> > -       tristate "KCSAN test for integrated runtime behaviour"
> > +       tristate "KCSAN test for integrated runtime behaviour" if !KUNIT_RUN_ALL
> >         depends on TRACEPOINTS && KUNIT
> > +       default KUNIT_RUN_ALL
> >         select TORTURE_TEST
> >         help
> >           KCSAN test focusing on behaviour of the integrated runtime. Tests
>
> I think if you want this patch to be picked up you need to split it,
> with one patch for each test that is not yet in mainline or the tree
> that should pick this patch up.

OK, would it be ok to do one patch per subsystem if it's in the mainline tree,
and another patch if it's only in the next tree for the same subsystem?

>
> The KCSAN test is in the -rcu tree, but I don't expect it to be merged
> before 5.9. Most likely, we would only be able to pick up the patch
> that would make the chance to the KCSAN Kconfig entry once the rest
> here made it into mainline.
>
> Thanks,
> -- Marco
>
> > diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> > index 95d12e3d6d95..d6a912779816 100644
> > --- a/lib/kunit/Kconfig
> > +++ b/lib/kunit/Kconfig
> > @@ -15,7 +15,8 @@ menuconfig KUNIT
> >  if KUNIT
> >
> >  config KUNIT_DEBUGFS
> > -       bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation"
> > +       bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation" if !KUNIT_RUN_ALL
> > +       default KUNIT_RUN_ALL
> >         help
> >           Enable debugfs representation for kunit.  Currently this consists
> >           of /sys/kernel/debug/kunit/<test_suite>/results files for each
> > @@ -23,7 +24,8 @@ config KUNIT_DEBUGFS
> >           run that occurred.
> >
> >  config KUNIT_TEST
> > -       tristate "KUnit test for KUnit"
> > +       tristate "KUnit test for KUnit" if !KUNIT_RUN_ALL
> > +       default KUNIT_RUN_ALL
> >         help
> >           Enables the unit tests for the KUnit test framework. These tests test
> >           the KUnit test framework itself; the tests are both written using
> > @@ -32,7 +34,8 @@ config KUNIT_TEST
> >           expected.
> >
> >  config KUNIT_EXAMPLE_TEST
> > -       tristate "Example test for KUnit"
> > +       tristate "Example test for KUnit" if !KUNIT_RUN_ALL
> > +       default KUNIT_RUN_ALL
> >         help
> >           Enables an example unit test that illustrates some of the basic
> >           features of KUnit. This test only exists to help new users understand
> > @@ -41,4 +44,10 @@ config KUNIT_EXAMPLE_TEST
> >           is intended for curious hackers who would like to understand how to
> >           use KUnit for kernel development.
> >
> > +config KUNIT_RUN_ALL
> > +       tristate "KUnit run all test"
> > +       help
> > +         Enables all KUnit tests. If they can be enabled.
> > +         That depends on if KUnit is enabled as a module or builtin.
> > +
>
> s/tests. If/tests, if/ ?

correct, I will fix that.

Cheers,
Anders

>
> >  endif # KUNIT
> > diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
> > index 0fe336860773..c4648426ea5d 100644
> > --- a/security/apparmor/Kconfig
> > +++ b/security/apparmor/Kconfig
> > @@ -70,8 +70,9 @@ config SECURITY_APPARMOR_DEBUG_MESSAGES
> >           the kernel message buffer.
> >
> >  config SECURITY_APPARMOR_KUNIT_TEST
> > -       bool "Build KUnit tests for policy_unpack.c"
> > +       bool "Build KUnit tests for policy_unpack.c" if !KUNIT_RUN_ALL
> >         depends on KUNIT=y && SECURITY_APPARMOR
> > +       default KUNIT_RUN_ALL
> >         help
> >           This builds the AppArmor KUnit tests.
> >
> > --
> > 2.20.1
> >
