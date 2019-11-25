Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 163A810949C
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2019 21:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfKYUUD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Nov 2019 15:20:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45665 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfKYUUD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Nov 2019 15:20:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id w7so6964077plz.12
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Nov 2019 12:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xREpwucOOU4x07dlH8AS8RLhHBYoa54/pGxJzGMLh/U=;
        b=UFI2NR3RoQ/NlQaasK7qc+w8Z8M54ZZJ0JndaolcZ1a5pjJYZnEg9KNE5L8EtqHqjt
         w+T3GFGazVRKfyFN5Pw7OY6A4al6qV0sGYyI4l5g5UIWwfNwTIFgK+4NNz29EpMNlzkg
         +/dwNnlMeTIzQorI688S4tur4EoYg2iYgm4bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xREpwucOOU4x07dlH8AS8RLhHBYoa54/pGxJzGMLh/U=;
        b=ABRmJ6Lp/WpQNZDs/4r2KFSSUJJJEYx2zdKZqo86NA6nMMGWCVEdO+kxP5rr4q6Ewe
         X5kGgNwf2uQFLdFKDvSlLo8Ov45QopkPa26iwccyXn5YZTKypH+yJe0uvqEKtrAXriku
         02bfhapmrN/ZLuLkaeWTKvUf5IZIo1VDl3BFqeaxJSn4Ma5sX6G84Gsrb7iVSh/lE5fv
         MYasO+oQTFZJpf/jIjrhKaPRzpF4IUUvv58AYQ8/8EwZyJZHH7KYm4wCvas+RVf6lhPg
         oE4vK3JUd0UVd/9nqXkPLHeoeibzjf0ieLUF7yu19OwSdZoxirVipK42gER4+P8MvIuZ
         btCw==
X-Gm-Message-State: APjAAAUhNL4N+YT2KHqyv9uQbHLoObS5m9IVb4sGW5POho7j5TAgQFgq
        KsmZshfhpIuwSelq+ue+jTQdXg==
X-Google-Smtp-Source: APXvYqwJUiUuCfgPZoWhn99mTCEBSQnBeCbbxZW58h1oCDGrSPmNRr3Sne4ERCwuSY4RnxDRzfm/ug==
X-Received: by 2002:a17:90a:f00d:: with SMTP id bt13mr1084835pjb.43.1574713202310;
        Mon, 25 Nov 2019 12:20:02 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id a26sm9295506pff.155.2019.11.25.12.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 12:20:01 -0800 (PST)
Date:   Mon, 25 Nov 2019 12:19:59 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Angus Ainslie <angus@akkea.ca>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-pm@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v3 1/4] PM / QoS: Initial kunit test
Message-ID: <20191125201959.GA228856@google.com>
References: <cover.1574699610.git.leonard.crestez@nxp.com>
 <023ab2f86445e5eb81b39fc471bebe9bc173f993.1574699610.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <023ab2f86445e5eb81b39fc471bebe9bc173f993.1574699610.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 25, 2019 at 06:42:16PM +0200, Leonard Crestez wrote:
> The pm_qos family of APIs are used in relatively difficult to reproduce
> scenarios such as thermal throttling so they benefit from unit testing.

indeed, a unit test is useful in this case!

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
>  drivers/base/power/qos-test.c | 116 ++++++++++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+)
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
> index 000000000000..8267d91332a8
> --- /dev/null
> +++ b/drivers/base/power/qos-test.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 NXP
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
> +	freq_qos_remove_request(&req2);
> +	KUNIT_EXPECT_EQ(test, ret, 1);

This checks (again) the return value of the above freq_qos_add_request() call,
which I suppose is not intended. Remove?

> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN), 1000);
> +
> +	freq_qos_remove_request(&req1);
> +	KUNIT_EXPECT_EQ(test, ret, 1);

ditto

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
> +	/* Remove max 2000, new max 1000 */

the code doesn't match the comment, max 1000 is removed

> +	ret = freq_qos_remove_request(&req1);
> +	KUNIT_EXPECT_EQ(test, ret, 1);
> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MAX), 2000);
> +}
> +
> +/*
> + * Test that a freq_qos_request can be readded after removal

nit: 're-added'. It took me a few secs to figure this is not a about
'read'ing something
