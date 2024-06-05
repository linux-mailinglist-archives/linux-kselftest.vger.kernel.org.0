Return-Path: <linux-kselftest+bounces-11276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5248FDAD2
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 01:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64C01C22BF4
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 23:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E1015FA9C;
	Wed,  5 Jun 2024 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9wOINd0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A205B2AE7F;
	Wed,  5 Jun 2024 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631243; cv=none; b=T/VZVQYr8KfR4EfyVMmirv0n9mN/AsVxyKnwrZFlWL9a3mBnxAe5BDVC9RkiKhzk+TrV7mKR5kI5NzavQI3QVjRpY17VSqxXnkTmgYamZGnQfZI/zDL4Lnq2disaRDmSwAC8oCWBgJXGpf1ATTAHBY6w/hMIl4hQ9fAO5vGWjTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631243; c=relaxed/simple;
	bh=Yh7e+MZK1NlEEhfWUcUENcGAh0vhZ1kB0W2n+WAnn1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMW+G4Q0Haw/u2xiK8ezHQr86/gj6qE+N8z0bVN4NznoSvB7kB4gVHmChIyngGBOjF+XtrIXeqNdmH5fGdEMEvfuQ0sgWJF2GXHtvb49CixShNq/1vQI6hgtxt7RbKOHY3KK1TWZEHL+X7w8BjoGPNbEBrF7dHu8/yXvEkU74Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9wOINd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA99C2BD11;
	Wed,  5 Jun 2024 23:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717631243;
	bh=Yh7e+MZK1NlEEhfWUcUENcGAh0vhZ1kB0W2n+WAnn1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T9wOINd0EQxN3A7+sl/amyoBdEKWAPiNYbYDP/UM0nzDUIB9RZtk3/3omKpnMp/d2
	 kEXQiDghGj1O29YJ50YIm6M3QmkgSOgPd/ytxOjMq/xFAe4Yv2JwMxh+ky1kv9VoNk
	 3uM5b7zN4735K02XRMaw8OfnGeZmLYicw1RZBwlssdvl2HtTKaBilCTYYrS8jhO6XK
	 cOEGTQGqQerA7DgTtMBtoC6U3VrVDreB4grGjV6KjPouTUjJxyUD0Xm975oIgU0TQ0
	 D8fuia0s12Nr9GN8fSXFpIuv5jJzrJMGJdhKqL/aKfQKQdNicxEHo+ise2QwybExFf
	 khHfCXTeE5nXQ==
Date: Wed, 5 Jun 2024 17:47:20 -0600
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	patches@lists.linux.dev, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Daniel Latypov <dlatypov@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v5 05/11] of: Add a KUnit test for overlays and test
 managed APIs
Message-ID: <20240605234720.GA3441001-robh@kernel.org>
References: <20240603223811.3815762-1-sboyd@kernel.org>
 <20240603223811.3815762-6-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603223811.3815762-6-sboyd@kernel.org>

On Mon, Jun 03, 2024 at 03:38:02PM -0700, Stephen Boyd wrote:
> Test the KUnit test managed overlay APIs. Confirm that platform devices
> are created and destroyed properly. This provides us confidence that the
> test managed APIs work correctly and can be relied upon to provide tests
> with fake platform devices and device nodes via overlays compiled into
> the kernel image.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Daniel Latypov <dlatypov@google.com>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/of/.kunitconfig            |   1 +
>  drivers/of/Kconfig                 |  10 +++
>  drivers/of/Makefile                |   1 +
>  drivers/of/kunit_overlay_test.dtso |   9 +++
>  drivers/of/overlay_test.c          | 116 +++++++++++++++++++++++++++++
>  5 files changed, 137 insertions(+)
>  create mode 100644 drivers/of/kunit_overlay_test.dtso
>  create mode 100644 drivers/of/overlay_test.c
> 
> diff --git a/drivers/of/.kunitconfig b/drivers/of/.kunitconfig
> index 5a8fee11978c..4c53d2c7a275 100644
> --- a/drivers/of/.kunitconfig
> +++ b/drivers/of/.kunitconfig
> @@ -1,3 +1,4 @@
>  CONFIG_KUNIT=y
>  CONFIG_OF=y
>  CONFIG_OF_KUNIT_TEST=y
> +CONFIG_OF_OVERLAY_KUNIT_TEST=y
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index dd726c7056bf..0e2d608c3e20 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -107,6 +107,16 @@ config OF_OVERLAY
>  	  While this option is selected automatically when needed, you can
>  	  enable it manually to improve device tree unit test coverage.
>  
> +config OF_OVERLAY_KUNIT_TEST
> +	tristate "Device Tree overlay KUnit tests" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	select OF_OVERLAY
> +	help
> +	  This option builds KUnit unit tests for the device tree overlay code.
> +
> +	  If unsure, say N here, but this option is safe to enable.
> +
>  config OF_NUMA
>  	bool
>  
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index 2ae909adde49..abd9c578343b 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -21,5 +21,6 @@ endif
>  
>  obj-$(CONFIG_KUNIT) += of_kunit_helpers.o
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
> index 000000000000..9a8083c3a659
> --- /dev/null
> +++ b/drivers/of/overlay_test.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for device tree overlays
> + */
> +#include <linux/device/bus.h>
> +#include <linux/kconfig.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
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
> +/*
> + * Test that of_overlay_apply_kunit() creates platform devices with the
> + * expected device_node
> + */
> +static void of_overlay_apply_kunit_platform_device(struct kunit *test)
> +{
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +
> +	KUNIT_ASSERT_EQ(test, 0,
> +			of_overlay_apply_kunit(test, kunit_overlay_test));
> +
> +	np = of_find_node_by_name(NULL, kunit_node_name);
> +	of_node_put_kunit(test, np);

Moving target, but we now have of_node_put() cleanups. Would that work 
here instead?

> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
> +
> +	pdev = of_find_device_by_node(np);
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, pdev);
> +	if (pdev)
> +		put_device(&pdev->dev);
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
> +	struct kunit fake;
> +	struct platform_device *pdev;
> +	struct device *dev;
> +	struct device_node *np;
> +
> +	if (!IS_ENABLED(CONFIG_OF_OVERLAY))
> +		kunit_skip(test, "requires CONFIG_OF_OVERLAY");
> +	if (!IS_ENABLED(CONFIG_OF_EARLY_FLATTREE))
> +		kunit_skip(test, "requires CONFIG_OF_EARLY_FLATTREE for root node");
> +
> +	kunit_init_test(&fake, "fake test", NULL);
> +	KUNIT_ASSERT_EQ(test, fake.status, KUNIT_SUCCESS);
> +
> +	KUNIT_ASSERT_EQ(test, 0,
> +			of_overlay_apply_kunit(&fake, kunit_overlay_test));
> +
> +	np = of_find_node_by_name(NULL, kunit_node_name);
> +	of_node_put(np); /* Not derefing 'np' after this */
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
> +
> +	pdev = of_find_device_by_node(np);

Don't you need to hold a ref on np until here?


> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +	put_device(&pdev->dev); /* Not derefing 'pdev' after this */
> +
> +	/* Remove overlay */
> +	kunit_cleanup(&fake);
> +
> +	/* The node and device should be removed */
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

