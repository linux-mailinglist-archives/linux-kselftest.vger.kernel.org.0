Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B43810ED7F
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2019 17:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfLBQth (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Dec 2019 11:49:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44014 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfLBQtg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Dec 2019 11:49:36 -0500
Received: by mail-pl1-f193.google.com with SMTP id q16so152286plr.10
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2019 08:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1iCCkUslfjQ47gR1lHWI0RjnwmhOr9xiRv5WvDSSwsQ=;
        b=U8PbCcoYdOqXRXeUfIwGvOjAThj1ja+VrtwqqnDp2QF1i5PLxhTXezSDewiM+8Gc86
         xVqRMpgAjIf3CAI+7lm0s9RuBxM+tkGHaRN9WK5LAxL3/ps7YFX3tqM5pBhkz0VwR0Ml
         +qHkzw6C371OlFdq4M9oMqCFCIg6YZSkVUfapfhOi1SzfX2Ze8g/WkinTWXVPLQbE7rU
         gzJqNFgC/WK0MuA1I6REqTel+GVkZbfdThX943P8xkRgqC7w4W/HGOFc2M6b+AN9GPjw
         BgPnC5rNi/dr3GzRlN8gXinD1GQysnKKIdIUgqtKf20vREwImO6BGd6aGotXe3Ulk4qV
         lLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1iCCkUslfjQ47gR1lHWI0RjnwmhOr9xiRv5WvDSSwsQ=;
        b=Vmjr3KdoMA0cYbvk83oZlWducZEbCmX3x4wNof4eHDZQwr1f6ZWxm2isOrnucVORm5
         XoNZNldlzu4mXqqDAU+0NOLzwsz0Ik87sTzaVPtV7mepmhNH3XRRrSkC0+USgQDUFqZz
         41BAJaU4y3y4qFBdiP/mvmMLoeAETaLFifH4tJry9s5aT4YfNvl/sgbEBwyr3OW0M0GA
         4IApkgEKh7gnqD7Aq1lTJwm/L9xwYCDcHmsrxeOlINaHYWP+jQGkFmm+Gc3CGcN1f4kR
         qLbqwLU/qUKg7VDKB9q1Ax3v0th0zIO2LfKwQr/4HqGOhd/B4woiiEBj8fajH+kMB6m1
         52Jg==
X-Gm-Message-State: APjAAAUuGnarxsi772dWsNdLwWC41DDhcZlWO/dsRSEzfq68FGUgykpJ
        +r9AY3zU8+FpNc0qG6oRxs1elhvP02MCFdwuFGzKhw==
X-Google-Smtp-Source: APXvYqwptZntt15ZFcLi4M0jd+NOUQoHR/GaemRipdBNPvGVldZMUx8vwkrCJH71j6+L4MaxbD1YD6SIlhKKSM40Rys=
X-Received: by 2002:a17:90a:ff02:: with SMTP id ce2mr148868pjb.117.1575305373955;
 Mon, 02 Dec 2019 08:49:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574781196.git.leonard.crestez@nxp.com> <be196b656bb5fbf2c59a179e6453aa963b862109.1574781196.git.leonard.crestez@nxp.com>
 <20191126200414.GD228856@google.com> <VI1PR04MB70234D1D3953E6E7C69A5ED6EE440@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB70234D1D3953E6E7C69A5ED6EE440@VI1PR04MB7023.eurprd04.prod.outlook.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Dec 2019 08:49:24 -0800
Message-ID: <CAFd5g44M=osF1C9B8heTBpb+cy-x8112Vk8RPX6ppP9j+2NtVQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] PM / QoS: Initial kunit test
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Angus Ainslie <angus@akkea.ca>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 27, 2019 at 3:40 PM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On 26.11.2019 22:04, Matthias Kaehlcke wrote:
> > On Tue, Nov 26, 2019 at 05:17:10PM +0200, Leonard Crestez wrote:
> >> The pm_qos family of APIs are used in relatively difficult to reproduce
> >> scenarios such as thermal throttling so they benefit from unit testing.
> >>
> >> Start by adding basic tests from the the freq_qos APIs. It includes
> >> tests for issues that were brought up on mailing lists:
> >>
> >> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

> >> ---
> >>   drivers/base/Kconfig          |   4 ++
> >>   drivers/base/power/Makefile   |   1 +
> >>   drivers/base/power/qos-test.c | 117 ++++++++++++++++++++++++++++++++++
> >>   3 files changed, 122 insertions(+)
> >>   create mode 100644 drivers/base/power/qos-test.c
> >>
> >> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> >> index e37d37684132..d4ae1c1adf69 100644
> >> --- a/drivers/base/Kconfig
> >> +++ b/drivers/base/Kconfig
> >> @@ -155,10 +155,14 @@ config DEBUG_TEST_DRIVER_REMOVE
> >>
> >>        This option is expected to find errors and may render your system
> >>        unusable. You should say N here unless you are explicitly looking to
> >>        test this functionality.
> >>
> >> +config PM_QOS_KUNIT_TEST
> >> +    bool "KUnit Test for PM QoS features"
> >> +    depends on KUNIT
> >> +
> >>   config HMEM_REPORTING
> >>      bool
> >>      default n
> >>      depends on NUMA
> >>      help
> >> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> >> index ec5bb190b9d0..8fdd0073eeeb 100644
> >> --- a/drivers/base/power/Makefile
> >> +++ b/drivers/base/power/Makefile
> >> @@ -2,7 +2,8 @@
> >>   obj-$(CONFIG_PM)   += sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
> >>   obj-$(CONFIG_PM_SLEEP)     += main.o wakeup.o wakeup_stats.o
> >>   obj-$(CONFIG_PM_TRACE_RTC) += trace.o
> >>   obj-$(CONFIG_PM_GENERIC_DOMAINS)   +=  domain.o domain_governor.o
> >>   obj-$(CONFIG_HAVE_CLK)     += clock_ops.o
> >> +obj-$(CONFIG_PM_QOS_KUNIT_TEST) += qos-test.o
> >>
> >>   ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
> >> diff --git a/drivers/base/power/qos-test.c b/drivers/base/power/qos-test.c
> >> new file mode 100644
> >> index 000000000000..3115db08d56b
> >> --- /dev/null
> >> +++ b/drivers/base/power/qos-test.c
> >> @@ -0,0 +1,117 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright 2019 NXP
> >> + */
> >> +#include <kunit/test.h>
> >> +#include <linux/pm_qos.h>
> >> +
> >> +/* Basic test for aggregating two "min" requests */
> >> +static void freq_qos_test_min(struct kunit *test)
> >> +{
> >> +    struct freq_constraints qos;
> >> +    struct freq_qos_request req1, req2;
> >> +    int ret;
> >> +
> >> +    freq_constraints_init(&qos);
> >> +    memset(&req1, 0, sizeof(req1));
> >> +    memset(&req2, 0, sizeof(req2));
> >> +
> >> +    ret = freq_qos_add_request(&qos, &req1, FREQ_QOS_MIN, 1000);
> >> +    KUNIT_EXPECT_EQ(test, ret, 1);
> >> +    ret = freq_qos_add_request(&qos, &req2, FREQ_QOS_MIN, 2000);
> >> +    KUNIT_EXPECT_EQ(test, ret, 1);
> >> +
> >> +    KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN), 2000);
> >> +
> >> +    ret = freq_qos_remove_request(&req2);
> >> +    KUNIT_EXPECT_EQ(test, ret, 1);
> >> +    KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN), 1000);
> >> +
> >> +    ret = freq_qos_remove_request(&req1);
> >> +    KUNIT_EXPECT_EQ(test, ret, 1);
> >> +    KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN),
> >> +                    FREQ_QOS_MIN_DEFAULT_VALUE);
> >> +}
> >> +
> >> +/* Test that requests for MAX_DEFAULT_VALUE have no effect */
> >> +static void freq_qos_test_maxdef(struct kunit *test)
> >> +{
> >> +    struct freq_constraints qos;
> >> +    struct freq_qos_request req1, req2;
> >> +    int ret;
> >> +
> >> +    freq_constraints_init(&qos);
> >> +    memset(&req1, 0, sizeof(req1));
> >> +    memset(&req2, 0, sizeof(req2));
> >> +    KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MAX),
> >> +                    FREQ_QOS_MAX_DEFAULT_VALUE);
> >> +
> >> +    ret = freq_qos_add_request(&qos, &req1, FREQ_QOS_MAX,
> >> +                    FREQ_QOS_MAX_DEFAULT_VALUE);
> >> +    KUNIT_EXPECT_EQ(test, ret, 0);
> >> +    ret = freq_qos_add_request(&qos, &req2, FREQ_QOS_MAX,
> >> +                    FREQ_QOS_MAX_DEFAULT_VALUE);
> >> +    KUNIT_EXPECT_EQ(test, ret, 0);
> >> +
> >> +    /* Add max 1000 */
> >> +    ret = freq_qos_update_request(&req1, 1000);
> >> +    KUNIT_EXPECT_EQ(test, ret, 1);
> >> +    KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MAX), 1000);
> >> +
> >> +    /* Add max 2000, no impact */
> >> +    ret = freq_qos_update_request(&req2, 2000);
> >> +    KUNIT_EXPECT_EQ(test, ret, 0);
> >> +    KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MAX), 1000);
> >> +
> >> +    /* Remove max 1000, new max 2000 */
> >> +    ret = freq_qos_remove_request(&req1);
> >> +    KUNIT_EXPECT_EQ(test, ret, 1);
> >> +    KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MAX), 2000);
> >
> > nit: this last part isn't really related with MAX_DEFAULT_VALUE. It's a
> > worthwhile test, but not necessarily in this test case. It might make more sense
> > to set one of the constraints to FREQ_QOS_MAX_DEFAULT_VALUE again, and verify it
> > doesn't have an impact.
> >
> > Just a comment, there's nothing really wrong with how it is.
> >
> >> +}
> >> +
> >> +/*
> >> + * Test that a freq_qos_request can be added again after removal
> >> + *
> >> + * This issue was solved by commit 05ff1ba412fd ("PM: QoS: Invalidate frequency
> >> + * QoS requests after removal")
> >> + */
> >> +static void freq_qos_test_readd(struct kunit *test)
> >> +{
> >> +    struct freq_constraints qos;
> >> +    struct freq_qos_request req;
> >> +    int ret;
> >> +
> >> +    freq_constraints_init(&qos);
> >> +    memset(&req, 0, sizeof(req));
> >> +    KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN),
> >> +                    FREQ_QOS_MIN_DEFAULT_VALUE);
> >
> > nit: you could do this check once in a dedicated test and omit it
> > in other tests to de-clutter
> >
> >> +
> >> +    /* Add */
> >> +    ret = freq_qos_add_request(&qos, &req, FREQ_QOS_MIN, 1000);
> >> +    KUNIT_EXPECT_EQ(test, ret, 1);
> >> +    KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN), 1000);
> >
> > similar here, this test validates re-adding, another dedicated test
> > could verify once that the aggregate value is correct after adding a single
> > request. Checking the return value still is sensible, just in case.
> >
> > I guess it can be argued either way, checking the values every time is
> > extra-safe, omitting the checks reduces clutter and might help to make it
> > clearer what the test really intends to verify.
>
> The complaint of "too many assertions" is odd for an unit test; I just
> wrote enough code to validate corectness without relying on a pile of
> external shell scripts and DTS hacks.

I think Matthias was just trying to say that it might be a little
cleaner if each test case only had expectations corresponding to the
particular property that the test case is asserting, which I agree
with.

I created the KUNIT_ASSERT_* variants just for this case; the idea is
that you ASSERT the preconditions for the test case and you EXPECT the
result you want. Hopefully this should make it immediately obvious
when examining a test case what assertions/expectations correspond to
the properties that the test is trying to prove and which are
prerequisite.

> If we had more tests then the constant checking of every single return
> value might get tedious, but right now there are only 3 and their logic
> is reasonably easy to follow.

I didn't have any trouble following your test. I agree with Matthias
that these are potential minor improvements, but I also think it is
fine as is.

> > Anyway, my comments are just about possible improvements, it's also fine
> > as is:
> >
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Cheers!
