Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77A76D9B76
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 17:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbjDFPAD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 11:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbjDFO7t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 10:59:49 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5F79EE1;
        Thu,  6 Apr 2023 07:59:24 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id l18so29235947oic.13;
        Thu, 06 Apr 2023 07:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680793158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcyQ9PVr/q3d+Z2b5CyPmPNAX1Bn6Htbl2OP4BAR1uE=;
        b=xtIPrB9mnPkv01wG6BfT/mBnevWeJrS1Gci3xHrEVKnYznV5VRRFa3iIbpDKvg/7pY
         MqlmcEAShgk/ozYFQ4C1L5r+lKQC1QE+tzfVsHVR3TvPG6mClO6CTOtErvvEiKA6pqcv
         pBoYMeY6e/7k4JxxtfaEtJjdXgty2TuSFty5xb/P2Kcpe4hPpRAme2cHkd/nhsfhgRM/
         wl/JLBW4BVyoEF69U2xQbLJuzgM3P5l+NrPjznREDxL9tJ3wx5OE9+L6DBxyrfnTwjZX
         3YMXtZ5oucR3RqlWEgIH8eMLBG/s+L6rNKrtyKU24+9dzasMZb+DCopaQG5iiFI/fxKs
         Q5kA==
X-Gm-Message-State: AAQBX9fiNTETMRNi1mAhNtEnyZygrewjztiiOci7sr+G3VcI64oHaQGT
        keAhXgZtLHtwFBx7+5W1Vg==
X-Google-Smtp-Source: AKy350bjhoej/GkPRCQguDVc7FGMvBb8pRji3Y3UcdAY1y3ZiLemp4BMpemZ7xkxLgitjCt5O7uYJQ==
X-Received: by 2002:a05:6808:f12:b0:389:122c:ad2c with SMTP id m18-20020a0568080f1200b00389122cad2cmr5138452oiw.27.1680793157817;
        Thu, 06 Apr 2023 07:59:17 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 17-20020aca1211000000b0038b862bc35bsm401800ois.8.2023.04.06.07.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:59:17 -0700 (PDT)
Received: (nullmailer pid 3082000 invoked by uid 1000);
        Thu, 06 Apr 2023 14:59:16 -0000
Date:   Thu, 6 Apr 2023 09:59:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v3 05/11] of: Add a KUnit test for overlays and test
 managed APIs
Message-ID: <20230406145916.GB3036886-robh@kernel.org>
References: <20230327222159.3509818-1-sboyd@kernel.org>
 <20230327222159.3509818-6-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327222159.3509818-6-sboyd@kernel.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 27, 2023 at 03:21:53PM -0700, Stephen Boyd wrote:
> Test the KUnit test managed overlay APIs. Confirm that platform devices
> are created and destroyed properly. This provides us confidence that the
> test managed work correctly and can be relied upon to provide tests with
> fake platform devices and device nodes via overlays compiled into the
> kernel image.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/of/.kunitconfig            |   2 +
>  drivers/of/Kconfig                 |  10 +++
>  drivers/of/Makefile                |   1 +
>  drivers/of/kunit_overlay_test.dtso |   9 +++
>  drivers/of/overlay_test.c          | 110 +++++++++++++++++++++++++++++
>  5 files changed, 132 insertions(+)
>  create mode 100644 drivers/of/kunit_overlay_test.dtso
>  create mode 100644 drivers/of/overlay_test.c
> 
> diff --git a/drivers/of/.kunitconfig b/drivers/of/.kunitconfig
> index 5a8fee11978c..7d570cb922a1 100644
> --- a/drivers/of/.kunitconfig
> +++ b/drivers/of/.kunitconfig
> @@ -1,3 +1,5 @@
>  CONFIG_KUNIT=y
>  CONFIG_OF=y
>  CONFIG_OF_KUNIT_TEST=y
> +CONFIG_OF_OVERLAY=y
> +CONFIG_OF_OVERLAY_KUNIT_TEST=y
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 1b995cecf5be..5bdeba11268d 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -113,6 +113,16 @@ config OF_OVERLAY
>  	  While this option is selected automatically when needed, you can
>  	  enable it manually to improve device tree unit test coverage.
>  
> +config OF_OVERLAY_KUNIT_TEST
> +	tristate "Device Tree overlay KUnit tests" if !KUNIT_ALL_TESTS
> +	depends on OF_OVERLAY
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This option builds KUnit unit tests for the device tree overlay code.
> +
> +	  If unsure, say N here, but this option is safe to enable.
> +
>  config OF_NUMA
>  	bool
>  
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index c694f998b9f5..2ad60d5b87ac 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -21,5 +21,6 @@ endif
>  
>  obj-$(CONFIG_KUNIT) += of_kunit.o
>  obj-$(CONFIG_OF_KUNIT_TEST) += of_test.o
> +obj-$(CONFIG_OF_OVERLAY_KUNIT_TEST) += overlay_test.o kunit_overlay_test.dtbo.o
>  
>  obj-$(CONFIG_OF_UNITTEST) += unittest-data/
> diff --git a/drivers/of/kunit_overlay_test.dtso b/drivers/of/kunit_overlay_test.dtso
> new file mode 100644
> index 000000000000..85f20b4b4c16
> --- /dev/null
> +++ b/drivers/of/kunit_overlay_test.dtso
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +/plugin/;
> +
> +&{/} {
> +	kunit-test {
> +		compatible = "test,empty";
> +	};
> +};
> diff --git a/drivers/of/overlay_test.c b/drivers/of/overlay_test.c
> new file mode 100644
> index 000000000000..66b1dceea568
> --- /dev/null
> +++ b/drivers/of/overlay_test.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for device tree overlays
> + */
> +#include <linux/device/bus.h>
> +#include <linux/kconfig.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +#include <kunit/of.h>
> +#include <kunit/test.h>
> +
> +static const char * const kunit_node_name = "kunit-test";
> +static const char * const kunit_compatible = "test,empty";
> +
> +/* Test that of_overlay_apply_kunit() adds a node to the live tree */
> +static void of_overlay_apply_kunit_apply(struct kunit *test)
> +{
> +	struct device_node *np;
> +
> +	KUNIT_ASSERT_EQ(test, 0,
> +			of_overlay_apply_kunit(test, kunit_overlay_test));
> +
> +	np = of_find_node_by_name(NULL, kunit_node_name);
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, np);
> +	of_node_put(np);
> +}
> +
> +static int bus_match_np(struct device *dev, const void *data)
> +{
> +	const struct device_node *np = data;
> +
> +	return np == dev->of_node;
> +}
> +
> +/*
> + * Test that of_overlay_apply_kunit() creates platform devices with the
> + * expected device_node
> + */
> +static void of_overlay_apply_kunit_platform_device(struct kunit *test)
> +{
> +	struct device *dev;
> +	struct device_node *np;
> +
> +	KUNIT_ASSERT_EQ(test, 0,
> +			of_overlay_apply_kunit(test, kunit_overlay_test));
> +
> +	np = of_find_node_by_name(NULL, kunit_node_name);
> +	of_node_put_kunit(test, np);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
> +
> +	dev = bus_find_device(&platform_bus_type, NULL, np, bus_match_np);

of_find_device_by_node()

> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, dev);
> +	put_device(dev);
> +}
> +
> +static int of_overlay_bus_match_compatible(struct device *dev, const void *data)
> +{
> +	return of_device_is_compatible(dev->of_node, data);
> +}
> +
> +/* Test that of_overlay_apply_kunit() cleans up after the test is finished */
> +static void of_overlay_apply_kunit_cleanup(struct kunit *test)
> +{
> +	struct device *dev;
> +	struct device_node *np;
> +
> +	KUNIT_ASSERT_EQ(test, 0,
> +			of_overlay_apply_kunit(test, kunit_overlay_test));
> +
> +	np = of_find_node_by_name(NULL, kunit_node_name);
> +	of_node_put(np); /* Not derefing 'np' after this */
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
> +
> +	dev = bus_find_device(&platform_bus_type, NULL, np, bus_match_np);

And here.

> +	put_device(dev); /* Not derefing 'device' after this */
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> +
> +	/* Remove overlay */
> +	kunit_cleanup(test);

I guess this is testing the cleanup. It's not that obvious given the 
overlay is removed by kunit_cleanup(). Not sure if anything can be done 
though...

> +
> +	np = of_find_node_by_name(NULL, kunit_node_name);
> +	KUNIT_EXPECT_PTR_EQ(test, NULL, np);
> +	of_node_put(np);
> +
> +	dev = bus_find_device(&platform_bus_type, NULL, kunit_compatible,
> +			      of_overlay_bus_match_compatible);
> +	KUNIT_EXPECT_PTR_EQ(test, NULL, dev);
> +	put_device(dev);
> +}
> +
> +static struct kunit_case of_overlay_apply_kunit_test_cases[] = {
> +	KUNIT_CASE(of_overlay_apply_kunit_apply),
> +	KUNIT_CASE(of_overlay_apply_kunit_platform_device),
> +	KUNIT_CASE(of_overlay_apply_kunit_cleanup),
> +	{}
> +};
> +
> +/*
> + * Test suite for test managed device tree overlays.
> + */
> +static struct kunit_suite of_overlay_apply_kunit_suite = {
> +	.name = "of_overlay_apply_kunit",
> +	.test_cases = of_overlay_apply_kunit_test_cases,
> +};
> +
> +kunit_test_suites(
> +	&of_overlay_apply_kunit_suite,
> +);
> +MODULE_LICENSE("GPL");
> -- 
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
> 
