Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAA4F10A506
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 21:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfKZUES (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 15:04:18 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41751 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfKZUER (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 15:04:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id t8so8556028plr.8
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2019 12:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dJopp9pR4UowE4MKKxONEjDdV0BlsklEMTw+PvfsY8Q=;
        b=eE7PGm7QXHba+0OsXaxVpSOnF3RoooKge3/iQo44EP2ZR4fNvLPjYyOMzJfZRkcgWC
         i/PmIiymlF20YyHLDMVFgk2eMoTEKUzwly7uYTFl2Iv59/ysfwQE8Wr7JFYPDe/E0s+2
         q++fWnBvD/n0oM7s6NJjMgZmyFfS86YhZo/f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dJopp9pR4UowE4MKKxONEjDdV0BlsklEMTw+PvfsY8Q=;
        b=RkBPTvSplISzDxaWP3YHzNZTu7iJ1l6Xp2toC1TQqWCbaQnHwBTWWVW64eYYbh7WQu
         ZV0/roc7TXNl1TLsL8hYdqqnsdSzpf/reBnSwpJWTvUhuliqkzmd38J2u44BINfUFQNx
         wBuPMLeiY4wHDnAx7WEjyM7HezLUaneRfRrJIyax299Lel9CZ+41XTZrm/Y3rzVlLTHj
         iIUEMyASxm8EB4L63ZTWrh+X+V6LaxCTtuGzVWCwKD58h+0QPsGwvIUYFiPsEML6uKYl
         eMQibR6K6klEM7OKMhQkRGpGUBdOVVGGk3aBe+Ge+a/d5OthVWrk9TPsufCHsfuV3GDR
         mSgQ==
X-Gm-Message-State: APjAAAUXY4knVXTH0sFXS+URo9Y5vpvoL2+R+bIYlJ5tLhe88ihgpCuH
        D+X+7DUphJ4bUUfHEKItPTQqOA==
X-Google-Smtp-Source: APXvYqwY5ODtk28juSNQIExCxXe/O2ELRtOVwOgtZeXW7WIFGrhKTjWpQMzJE9AghyvkNW9+h7di2Q==
X-Received: by 2002:a17:90b:4006:: with SMTP id ie6mr1158551pjb.50.1574798656886;
        Tue, 26 Nov 2019 12:04:16 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id y1sm13764278pfq.138.2019.11.26.12.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 12:04:16 -0800 (PST)
Date:   Tue, 26 Nov 2019 12:04:14 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Angus Ainslie <angus@akkea.ca>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-pm@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v4 1/4] PM / QoS: Initial kunit test
Message-ID: <20191126200414.GD228856@google.com>
References: <cover.1574781196.git.leonard.crestez@nxp.com>
 <be196b656bb5fbf2c59a179e6453aa963b862109.1574781196.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be196b656bb5fbf2c59a179e6453aa963b862109.1574781196.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 26, 2019 at 05:17:10PM +0200, Leonard Crestez wrote:
> The pm_qos family of APIs are used in relatively difficult to reproduce
> scenarios such as thermal throttling so they benefit from unit testing.
> 
> Start by adding basic tests from the the freq_qos APIs. It includes
> tests for issues that were brought up on mailing lists:
> 
> https://patchwork.kernel.org/patch/11252425/#23017005
> https://patchwork.kernel.org/patch/11253421/
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/base/Kconfig          |   4 ++
>  drivers/base/power/Makefile   |   1 +
>  drivers/base/power/qos-test.c | 117 ++++++++++++++++++++++++++++++++++
>  3 files changed, 122 insertions(+)
>  create mode 100644 drivers/base/power/qos-test.c
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index e37d37684132..d4ae1c1adf69 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -155,10 +155,14 @@ config DEBUG_TEST_DRIVER_REMOVE
>  
>  	  This option is expected to find errors and may render your system
>  	  unusable. You should say N here unless you are explicitly looking to
>  	  test this functionality.
>  
> +config PM_QOS_KUNIT_TEST
> +	bool "KUnit Test for PM QoS features"
> +	depends on KUNIT
> +
>  config HMEM_REPORTING
>  	bool
>  	default n
>  	depends on NUMA
>  	help
> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> index ec5bb190b9d0..8fdd0073eeeb 100644
> --- a/drivers/base/power/Makefile
> +++ b/drivers/base/power/Makefile
> @@ -2,7 +2,8 @@
>  obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
>  obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o wakeup_stats.o
>  obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
>  obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
>  obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
> +obj-$(CONFIG_PM_QOS_KUNIT_TEST) += qos-test.o
>  
>  ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
> diff --git a/drivers/base/power/qos-test.c b/drivers/base/power/qos-test.c
> new file mode 100644
> index 000000000000..3115db08d56b
> --- /dev/null
> +++ b/drivers/base/power/qos-test.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 NXP
> + */
> +#include <kunit/test.h>
> +#include <linux/pm_qos.h>
> +
> +/* Basic test for aggregating two "min" requests */
> +static void freq_qos_test_min(struct kunit *test)
> +{
> +	struct freq_constraints	qos;
> +	struct freq_qos_request	req1, req2;
> +	int ret;
> +
> +	freq_constraints_init(&qos);
> +	memset(&req1, 0, sizeof(req1));
> +	memset(&req2, 0, sizeof(req2));
> +
> +	ret = freq_qos_add_request(&qos, &req1, FREQ_QOS_MIN, 1000);
> +	KUNIT_EXPECT_EQ(test, ret, 1);
> +	ret = freq_qos_add_request(&qos, &req2, FREQ_QOS_MIN, 2000);
> +	KUNIT_EXPECT_EQ(test, ret, 1);
> +
> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN), 2000);
> +
> +	ret = freq_qos_remove_request(&req2);
> +	KUNIT_EXPECT_EQ(test, ret, 1);
> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN), 1000);
> +
> +	ret = freq_qos_remove_request(&req1);
> +	KUNIT_EXPECT_EQ(test, ret, 1);
> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN),
> +			FREQ_QOS_MIN_DEFAULT_VALUE);
> +}
> +
> +/* Test that requests for MAX_DEFAULT_VALUE have no effect */
> +static void freq_qos_test_maxdef(struct kunit *test)
> +{
> +	struct freq_constraints	qos;
> +	struct freq_qos_request	req1, req2;
> +	int ret;
> +
> +	freq_constraints_init(&qos);
> +	memset(&req1, 0, sizeof(req1));
> +	memset(&req2, 0, sizeof(req2));
> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MAX),
> +			FREQ_QOS_MAX_DEFAULT_VALUE);
> +
> +	ret = freq_qos_add_request(&qos, &req1, FREQ_QOS_MAX,
> +			FREQ_QOS_MAX_DEFAULT_VALUE);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +	ret = freq_qos_add_request(&qos, &req2, FREQ_QOS_MAX,
> +			FREQ_QOS_MAX_DEFAULT_VALUE);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	/* Add max 1000 */
> +	ret = freq_qos_update_request(&req1, 1000);
> +	KUNIT_EXPECT_EQ(test, ret, 1);
> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MAX), 1000);
> +
> +	/* Add max 2000, no impact */
> +	ret = freq_qos_update_request(&req2, 2000);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MAX), 1000);
> +
> +	/* Remove max 1000, new max 2000 */
> +	ret = freq_qos_remove_request(&req1);
> +	KUNIT_EXPECT_EQ(test, ret, 1);
> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MAX), 2000);

nit: this last part isn't really related with MAX_DEFAULT_VALUE. It's a
worthwhile test, but not necessarily in this test case. It might make more sense
to set one of the constraints to FREQ_QOS_MAX_DEFAULT_VALUE again, and verify it
doesn't have an impact.

Just a comment, there's nothing really wrong with how it is.

> +}
> +
> +/*
> + * Test that a freq_qos_request can be added again after removal
> + *
> + * This issue was solved by commit 05ff1ba412fd ("PM: QoS: Invalidate frequency
> + * QoS requests after removal")
> + */
> +static void freq_qos_test_readd(struct kunit *test)
> +{
> +	struct freq_constraints	qos;
> +	struct freq_qos_request	req;
> +	int ret;
> +
> +	freq_constraints_init(&qos);
> +	memset(&req, 0, sizeof(req));
> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN),
> +			FREQ_QOS_MIN_DEFAULT_VALUE);

nit: you could do this check once in a dedicated test and omit it
in other tests to de-clutter

> +
> +	/* Add */
> +	ret = freq_qos_add_request(&qos, &req, FREQ_QOS_MIN, 1000);
> +	KUNIT_EXPECT_EQ(test, ret, 1);
> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN), 1000);

similar here, this test validates re-adding, another dedicated test
could verify once that the aggregate value is correct after adding a single
request. Checking the return value still is sensible, just in case.

I guess it can be argued either way, checking the values every time is
extra-safe, omitting the checks reduces clutter and might help to make it
clearer what the test really intends to verify.

> +
> +	/* Remove */
> +	ret = freq_qos_remove_request(&req);
> +	KUNIT_EXPECT_EQ(test, ret, 1);
> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN),
> +			FREQ_QOS_MIN_DEFAULT_VALUE);

ditto

> +	/* Add again */
> +	ret = freq_qos_add_request(&qos, &req, FREQ_QOS_MIN, 2000);
> +	KUNIT_EXPECT_EQ(test, ret, 1);
> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN), 2000);

Here the explicit check makes sense, since we verify re-adding.

Anyway, my comments are just about possible improvements, it's also fine
as is:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
