Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ECE721084
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 16:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjFCOn5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 10:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjFCOn4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 10:43:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B32CCE;
        Sat,  3 Jun 2023 07:43:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2251B60B84;
        Sat,  3 Jun 2023 14:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CF7C433D2;
        Sat,  3 Jun 2023 14:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685803434;
        bh=OYMTWJF1Q+gBXXlGXBwzKqkU3xzdoScwu13Nufr4Ipo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ny+20gK79EpRdOsD/vWX5zHOkW2WRPVmoG4Z6l6RWV1RfIMFo3zDZUBxAq9LlHYvg
         4KgkXMTGMgxbg0knvVzPw/9PN8SuVD401Uu/JX5HQ6v9/0fbfRQpHsLhrJA19pP7YZ
         UhChmP14Y68cAFJLWlnF2/Cop0kWC66zc7wJrVpM=
Date:   Sat, 3 Jun 2023 16:43:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH RESEND 1/2] drivers: base: Add basic devm tests for root
 devices
Message-ID: <2023060339-unvaried-keenness-c14a@gregkh>
References: <20230329-kunit-devm-inconsistencies-test-v1-0-015b1574d673@kernel.org>
 <20230329-kunit-devm-inconsistencies-test-v1-1-015b1574d673@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329-kunit-devm-inconsistencies-test-v1-1-015b1574d673@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 02, 2023 at 05:20:43PM +0200, Maxime Ripard wrote:
> From: Maxime Ripard <maxime@cerno.tech>
> 
> The root devices show some odd behaviours compared to regular "bus" devices
> that have been probed through the usual mechanism, so let's create kunit
> tests to exercise those paths and odd cases.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/base/test/.kunitconfig       |   2 +
>  drivers/base/test/Kconfig            |   4 ++
>  drivers/base/test/Makefile           |   2 +
>  drivers/base/test/root-device-test.c | 120 +++++++++++++++++++++++++++++++++++
>  4 files changed, 128 insertions(+)
> 
> diff --git a/drivers/base/test/.kunitconfig b/drivers/base/test/.kunitconfig
> new file mode 100644
> index 000000000000..473923f0998b
> --- /dev/null
> +++ b/drivers/base/test/.kunitconfig
> @@ -0,0 +1,2 @@
> +CONFIG_KUNIT=y
> +CONFIG_DM_KUNIT_TEST=y
> diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
> index 610a1ba7a467..9d42051f8f8e 100644
> --- a/drivers/base/test/Kconfig
> +++ b/drivers/base/test/Kconfig
> @@ -9,6 +9,10 @@ config TEST_ASYNC_DRIVER_PROBE
>  
>  	  If unsure say N.
>  
> +config DM_KUNIT_TEST
> +	tristate "KUnit Tests for the device model" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +
>  config DRIVER_PE_KUNIT_TEST
>  	bool "KUnit Tests for property entry API" if !KUNIT_ALL_TESTS
>  	depends on KUNIT=y
> diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
> index 7f76fee6f989..d589ca3fa8fc 100644
> --- a/drivers/base/test/Makefile
> +++ b/drivers/base/test/Makefile
> @@ -1,5 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+= test_async_driver_probe.o
>  
> +obj-$(CONFIG_DM_KUNIT_TEST)	+= root-device-test.o
> +
>  obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) += property-entry-test.o
>  CFLAGS_property-entry-test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
> diff --git a/drivers/base/test/root-device-test.c b/drivers/base/test/root-device-test.c
> new file mode 100644
> index 000000000000..fcb55d8882aa
> --- /dev/null
> +++ b/drivers/base/test/root-device-test.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright 2023 Maxime Ripard <mripard@kernel.org>
> +
> +#include <kunit/resource.h>
> +
> +#include <linux/device.h>
> +
> +#define DEVICE_NAME "test"
> +
> +struct test_priv {
> +	bool probe_done;
> +	bool release_done;
> +	wait_queue_head_t release_wq;
> +	struct device *dev;
> +};
> +
> +static void devm_device_action(void *ptr)
> +{
> +	struct test_priv *priv = ptr;
> +
> +	priv->release_done = true;
> +	wake_up_interruptible(&priv->release_wq);
> +}
> +
> +static void devm_put_device_action(void *ptr)
> +{
> +	struct test_priv *priv = ptr;
> +
> +	put_device(priv->dev);
> +	priv->release_done = true;
> +	wake_up_interruptible(&priv->release_wq);
> +}
> +
> +#define RELEASE_TIMEOUT_MS	500
> +
> +static void root_device_devm_register_unregister_test(struct kunit *test)
> +{
> +	struct test_priv *priv;
> +	int ret;
> +
> +	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> +	init_waitqueue_head(&priv->release_wq);
> +
> +	priv->dev = root_device_register(DEVICE_NAME);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
> +
> +	ret = devm_add_action_or_reset(priv->dev, devm_device_action, priv);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	root_device_unregister(priv->dev);
> +
> +	ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
> +					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
> +	KUNIT_EXPECT_GT(test, ret, 0);
> +}
> +
> +static void root_device_devm_register_get_put_unregister_test(struct kunit *test)
> +{
> +	struct test_priv *priv;
> +	int ret;
> +
> +	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> +	init_waitqueue_head(&priv->release_wq);
> +
> +	priv->dev = root_device_register(DEVICE_NAME);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
> +
> +	get_device(priv->dev);

Why are you incrementing the reference here?

> +
> +	ret = devm_add_action_or_reset(priv->dev, devm_device_action, priv);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	put_device(priv->dev);

And then dropping it here?

What did that accomplish?  You shouldn't have needed to do that at all,
right?

THat's all the difference from the previous function?  What is this
testing?


> +
> +	root_device_unregister(priv->dev);
> +
> +	ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
> +					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
> +	KUNIT_EXPECT_GT(test, ret, 0);
> +}
> +
> +static void root_device_devm_register_get_unregister_with_devm_test(struct kunit *test)
> +{
> +	struct test_priv *priv;
> +	int ret;
> +
> +	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> +	init_waitqueue_head(&priv->release_wq);
> +
> +	priv->dev = root_device_register(DEVICE_NAME);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
> +
> +	get_device(priv->dev);
> +
> +	ret = devm_add_action_or_reset(priv->dev, devm_put_device_action, priv);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	root_device_unregister(priv->dev);
> +
> +	ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
> +					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
> +	KUNIT_EXPECT_GT(test, ret, 0);
> +}
> +
> +static struct kunit_case root_device_devm_tests[] = {
> +	KUNIT_CASE(root_device_devm_register_unregister_test),
> +	KUNIT_CASE(root_device_devm_register_get_put_unregister_test),
> +	KUNIT_CASE(root_device_devm_register_get_unregister_with_devm_test),

I can't figure out what you are trying to test here at all, which
doesn't bode well for this patchset.

Can you document it better?  What should be happening (or not happening)
that you are trying to ensure works properly?

All I see is a register/devm_something/unregister sequence and then wait
for the device to be freed.  Am I missing something else?

thanks,

greg k-h
