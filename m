Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7202572698C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 21:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjFGTOW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 15:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFGTOV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 15:14:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C5619D;
        Wed,  7 Jun 2023 12:14:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2014164300;
        Wed,  7 Jun 2023 19:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB3BC433EF;
        Wed,  7 Jun 2023 19:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686165258;
        bh=KfdYqS6DANNlBbav36OC1ZuYxEdBQAwyhbCKCDoNG5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KnaFzIB+OqwZqu04p9+yaoxSSTokPr4R8WRtxmxDHOIAS9CMFBAgHmbzd2gg7bJQT
         QC+rpNeU9wiyN3i0UZ5C2vJfS4Ce/dOaYtzMmPfl+1gqjKxPEe9Hmf9XOjDtcL0Mmq
         0K11BlisoHeAmhH8uBos/mtUdEi5P/1w14J39gv0=
Date:   Wed, 7 Jun 2023 21:14:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] drivers: base: Add basic devm tests for root
 devices
Message-ID: <2023060731-handwash-manager-9861@gregkh>
References: <20230329-kunit-devm-inconsistencies-test-v1-0-015b1574d673@kernel.org>
 <20230329-kunit-devm-inconsistencies-test-v1-1-015b1574d673@kernel.org>
 <2023060339-unvaried-keenness-c14a@gregkh>
 <ngable7tvu3bpbxm4gjkposta73coii5f3w5myghqfysarrcvz@mdnczc33ixjc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ngable7tvu3bpbxm4gjkposta73coii5f3w5myghqfysarrcvz@mdnczc33ixjc>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jun 04, 2023 at 10:31:42AM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Sat, Jun 03, 2023 at 04:43:51PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Jun 02, 2023 at 05:20:43PM +0200, Maxime Ripard wrote:
> > > From: Maxime Ripard <maxime@cerno.tech>
> > > 
> > > The root devices show some odd behaviours compared to regular "bus" devices
> > > that have been probed through the usual mechanism, so let's create kunit
> > > tests to exercise those paths and odd cases.
> > > 
> > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > > ---
> > >  drivers/base/test/.kunitconfig       |   2 +
> > >  drivers/base/test/Kconfig            |   4 ++
> > >  drivers/base/test/Makefile           |   2 +
> > >  drivers/base/test/root-device-test.c | 120 +++++++++++++++++++++++++++++++++++
> > >  4 files changed, 128 insertions(+)
> > > 
> > > diff --git a/drivers/base/test/.kunitconfig b/drivers/base/test/.kunitconfig
> > > new file mode 100644
> > > index 000000000000..473923f0998b
> > > --- /dev/null
> > > +++ b/drivers/base/test/.kunitconfig
> > > @@ -0,0 +1,2 @@
> > > +CONFIG_KUNIT=y
> > > +CONFIG_DM_KUNIT_TEST=y
> > > diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
> > > index 610a1ba7a467..9d42051f8f8e 100644
> > > --- a/drivers/base/test/Kconfig
> > > +++ b/drivers/base/test/Kconfig
> > > @@ -9,6 +9,10 @@ config TEST_ASYNC_DRIVER_PROBE
> > >  
> > >  	  If unsure say N.
> > >  
> > > +config DM_KUNIT_TEST
> > > +	tristate "KUnit Tests for the device model" if !KUNIT_ALL_TESTS
> > > +	depends on KUNIT
> > > +
> > >  config DRIVER_PE_KUNIT_TEST
> > >  	bool "KUnit Tests for property entry API" if !KUNIT_ALL_TESTS
> > >  	depends on KUNIT=y
> > > diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
> > > index 7f76fee6f989..d589ca3fa8fc 100644
> > > --- a/drivers/base/test/Makefile
> > > +++ b/drivers/base/test/Makefile
> > > @@ -1,5 +1,7 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+= test_async_driver_probe.o
> > >  
> > > +obj-$(CONFIG_DM_KUNIT_TEST)	+= root-device-test.o
> > > +
> > >  obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) += property-entry-test.o
> > >  CFLAGS_property-entry-test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
> > > diff --git a/drivers/base/test/root-device-test.c b/drivers/base/test/root-device-test.c
> > > new file mode 100644
> > > index 000000000000..fcb55d8882aa
> > > --- /dev/null
> > > +++ b/drivers/base/test/root-device-test.c
> > > @@ -0,0 +1,120 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +// Copyright 2023 Maxime Ripard <mripard@kernel.org>
> > > +
> > > +#include <kunit/resource.h>
> > > +
> > > +#include <linux/device.h>
> > > +
> > > +#define DEVICE_NAME "test"
> > > +
> > > +struct test_priv {
> > > +	bool probe_done;
> > > +	bool release_done;
> > > +	wait_queue_head_t release_wq;
> > > +	struct device *dev;
> > > +};
> > > +
> > > +static void devm_device_action(void *ptr)
> > > +{
> > > +	struct test_priv *priv = ptr;
> > > +
> > > +	priv->release_done = true;
> > > +	wake_up_interruptible(&priv->release_wq);
> > > +}
> > > +
> > > +static void devm_put_device_action(void *ptr)
> > > +{
> > > +	struct test_priv *priv = ptr;
> > > +
> > > +	put_device(priv->dev);
> > > +	priv->release_done = true;
> > > +	wake_up_interruptible(&priv->release_wq);
> > > +}
> > > +
> > > +#define RELEASE_TIMEOUT_MS	500
> > > +
> > > +static void root_device_devm_register_unregister_test(struct kunit *test)
> > > +{
> > > +	struct test_priv *priv;
> > > +	int ret;
> > > +
> > > +	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> > > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> > > +	init_waitqueue_head(&priv->release_wq);
> > > +
> > > +	priv->dev = root_device_register(DEVICE_NAME);
> > > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
> > > +
> > > +	ret = devm_add_action_or_reset(priv->dev, devm_device_action, priv);
> > > +	KUNIT_ASSERT_EQ(test, ret, 0);
> > > +
> > > +	root_device_unregister(priv->dev);
> > > +
> > > +	ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
> > > +					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
> > > +	KUNIT_EXPECT_GT(test, ret, 0);
> > > +}
> > > +
> > > +static void root_device_devm_register_get_put_unregister_test(struct kunit *test)
> > > +{
> > > +	struct test_priv *priv;
> > > +	int ret;
> > > +
> > > +	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> > > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> > > +	init_waitqueue_head(&priv->release_wq);
> > > +
> > > +	priv->dev = root_device_register(DEVICE_NAME);
> > > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
> > > +
> > > +	get_device(priv->dev);
> > 
> > Why are you incrementing the reference here?
> > 
> > > +
> > > +	ret = devm_add_action_or_reset(priv->dev, devm_device_action, priv);
> > > +	KUNIT_ASSERT_EQ(test, ret, 0);
> > > +
> > > +	put_device(priv->dev);
> > 
> > And then dropping it here?
> > 
> > What did that accomplish?  You shouldn't have needed to do that at all,
> > right?
> > 
> > THat's all the difference from the previous function?  What is this
> > testing?
> > 
> > 
> > > +
> > > +	root_device_unregister(priv->dev);
> > > +
> > > +	ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
> > > +					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
> > > +	KUNIT_EXPECT_GT(test, ret, 0);
> > > +}
> > > +
> > > +static void root_device_devm_register_get_unregister_with_devm_test(struct kunit *test)
> > > +{
> > > +	struct test_priv *priv;
> > > +	int ret;
> > > +
> > > +	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> > > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> > > +	init_waitqueue_head(&priv->release_wq);
> > > +
> > > +	priv->dev = root_device_register(DEVICE_NAME);
> > > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
> > > +
> > > +	get_device(priv->dev);
> > > +
> > > +	ret = devm_add_action_or_reset(priv->dev, devm_put_device_action, priv);
> > > +	KUNIT_ASSERT_EQ(test, ret, 0);
> > > +
> > > +	root_device_unregister(priv->dev);
> > > +
> > > +	ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
> > > +					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
> > > +	KUNIT_EXPECT_GT(test, ret, 0);
> > > +}
> > > +
> > > +static struct kunit_case root_device_devm_tests[] = {
> > > +	KUNIT_CASE(root_device_devm_register_unregister_test),
> > > +	KUNIT_CASE(root_device_devm_register_get_put_unregister_test),
> > > +	KUNIT_CASE(root_device_devm_register_get_unregister_with_devm_test),
> > 
> > I can't figure out what you are trying to test here at all, which
> > doesn't bode well for this patchset.
> > 
> > Can you document it better?  What should be happening (or not happening)
> > that you are trying to ensure works properly?
> > 
> > All I see is a register/devm_something/unregister sequence and then wait
> > for the device to be freed.  Am I missing something else?
> 
> So I guess most of the context was dropped since I first posted that
> series (and I believe that the following will also answer the comment on
> the other patch).

You have to have the context in the patch changelog itself, otherwise it
is useless (remember, some of us review hundreds of patches a week, and
have the short-term-memory of a squirrel.)

> It spawned from the discussion here:
> https://lore.kernel.org/linux-kselftest/20230324123157.bbwvfq4gsxnlnfwb@houat/
> 
> Basically, depending on the bus (platform vs root devices), and whether
> a driver was bound to the device or not, the device managed actions
> might or might not run.

And is that correct?  I don't remember if we said it was or not.

So why test something we don't know if it should be?

> This lead us in DRM to create helpers that will register a platform
> device and bind it to a dumb driver so that we can have the proper
> behaviour (ie, when we free the device, the device managed actions are
> executed).
> 
> We wanted to create generic helpers for kunit to create a new device
> instance to run a test on, and you were (not surprisingly) not really
> along with it. We discussed the above fact that the bus and bind-ness of
> a device was affecting device managed actions, I provided a bunch of
> kunit tests showing the inconsistencies that led to what we did in DRM,
> and you offered to fix it if I submitted the tests.
> 
> https://lore.kernel.org/linux-kselftest/ZB2a291P5abeah6s@kroah.com/
> 
> And so here we are :)
> 
> Those tests are not doing much indeed but checking whether a device
> managed action would run in various scenarii. If you run them, you'll
> end up with:

Then document them please.  You can't have tests that aren't obvious
what they are actually supposed to be testing, otherwise we have no idea
if the test is correct or not (or if the code it is testing is correct.)

> $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/base/test/
> [10:28:39] Configuring KUnit Kernel ...
> Regenerating .config ...
> Populating config with:
> $ make ARCH=um O=.kunit olddefconfig
> [10:28:40] Building KUnit Kernel ...
> Populating config with:
> $ make ARCH=um O=.kunit olddefconfig
> Building with:
> $ make ARCH=um O=.kunit --jobs=32
> [10:28:50] Starting KUnit Kernel (1/1)...
> [10:28:50] ============================================================
> [10:28:50] ============== root-device-devm (3 subtests) ===============
> [10:28:50] [PASSED] root_device_devm_register_unregister_test
> [10:28:50] [PASSED] root_device_devm_register_get_put_unregister_test
> [10:28:50] # root_device_devm_register_get_unregister_with_devm_test: EXPECTATION FAILED at drivers/base/test/root-device-test.c:105
> [10:28:50] Expected ret > 0, but
> [10:28:50]     ret == 0 (0x0)
> [10:28:50] [FAILED] root_device_devm_register_get_unregister_with_devm_test
> [10:28:50] # root-device-devm: pass:2 fail:1 skip:0 total:3
> [10:28:50] # Totals: pass:2 fail:1 skip:0 total:3
> [10:28:50] ================ [FAILED] root-device-devm =================
> [10:28:50] ============ platform-device-devm (6 subtests) =============
> [10:28:50] [PASSED] platform_device_devm_register_unregister_test
> [10:28:51] [PASSED] platform_device_devm_register_get_put_unregister_test
> [10:28:51] # platform_device_devm_register_get_unregister_with_devm_test: EXPECTATION FAILED at drivers/base/test/platform-device-test.c:123
> [10:28:51] Expected ret > 0, but
> [10:28:51]     ret == 0 (0x0)
> [10:28:51] [FAILED] platform_device_devm_register_get_unregister_with_devm_test
> [10:28:51] [PASSED] probed_platform_device_devm_register_unregister_test
> [10:28:51] [PASSED] probed_platform_device_devm_register_get_put_unregister_test
> [10:28:51] [PASSED] probed_platform_device_devm_register_get_unregister_with_devm_test
> [10:28:51] # platform-device-devm: pass:5 fail:1 skip:0 total:6
> [10:28:51] # Totals: pass:5 fail:1 skip:0 total:6
> [10:28:51] ============== [FAILED] platform-device-devm ===============
> [10:28:51] ============================================================
> [10:28:51] Testing complete. Ran 9 tests: passed: 7, failed: 2
> [10:28:51] Elapsed time: 11.701s total, 0.979s configuring, 9.601s building, 1.087s running
> 
> So you can see (and test) those inconsistencies: if you're using devm,
> you need to have a "bus" device bound to a driver. Failing that, devm
> actions will not run, which we all believed was a bug in that thread
> above.

So, what is the correct thing to do here?  Fix the driver core?  Don't
fix the driver core but document it?  Something else?  I don't think it
is to create an undocumented test :)

thanks,

greg k-h
