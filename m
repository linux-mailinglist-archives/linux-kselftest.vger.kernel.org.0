Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A5063B2D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 21:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiK1UOo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 15:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiK1UOo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 15:14:44 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3733D27B04;
        Mon, 28 Nov 2022 12:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=08/2Un2YGzJddEhSx7wn1daARTMK5OvPSBMOvCMzINI=; b=LqtalMNyuU4+k5RTvZu/mPL98S
        o8GMW4mfahXsFshKuSALJ04tWQVB6919Y+DwyUVMW4FzDoaXGmaDae3SnWsCa34ugNaDwPfU0TA1g
        x0B+OWKB5hW+KCcUcZ6W/WRwSamd1hmwt4v85UybVzZe32GveqRH5m7WnWKksjNl+fA7muEAqKkVP
        mZPWh6QtnhxbOhVNgOAiUu08rVMyrWxtiPnr/2moN3KV4ZzBCNMn2IjTbf/RzRSXUzCWsX+/hJWql
        6raDkSqrNL5q1eeKxgTEAFNJDIUufD985vTjoD4uryoikaPRCE26ZKQOHRPmCtCdRMjwNJiot8Xic
        379Bak0w==;
Received: from [177.34.169.227] (helo=[192.168.0.8])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ozkWK-00AcJO-Rs; Mon, 28 Nov 2022 21:14:29 +0100
Message-ID: <b48c4585-52b9-5311-5210-fd5679bda90f@igalia.com>
Date:   Mon, 28 Nov 2022 17:14:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 10/17] drm/tests: Add a test for DRM managed actions
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-media@vger.kernel.org
References: <20221123-rpi-kunit-tests-v2-0-efe5ed518b63@cerno.tech>
 <20221123-rpi-kunit-tests-v2-10-efe5ed518b63@cerno.tech>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20221123-rpi-kunit-tests-v2-10-efe5ed518b63@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/28/22 11:53, Maxime Ripard wrote:
> DRM-managed actions are supposed to be ran whenever the device is
> released. Let's introduce a basic unit test to make sure it happens.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra Canal

> ---
>  drivers/gpu/drm/tests/Makefile           |  1 +
>  drivers/gpu/drm/tests/drm_managed_test.c | 71 ++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
> index 94fe546d937d..486053052ba9 100644
> --- a/drivers/gpu/drm/tests/Makefile
> +++ b/drivers/gpu/drm/tests/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_DRM_KUNIT_TEST) += \
>  	drm_format_test.o \
>  	drm_framebuffer_test.o \
>  	drm_kunit_helpers.o \
> +	drm_managed_test.o \
>  	drm_mm_test.o \
>  	drm_modes_test.o \
>  	drm_plane_helper_test.o \
> diff --git a/drivers/gpu/drm/tests/drm_managed_test.c b/drivers/gpu/drm/tests/drm_managed_test.c
> new file mode 100644
> index 000000000000..1652dca11d30
> --- /dev/null
> +++ b/drivers/gpu/drm/tests/drm_managed_test.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <drm/drm_drv.h>
> +#include <drm/drm_kunit_helpers.h>
> +#include <drm/drm_managed.h>
> +
> +#include <kunit/resource.h>
> +
> +#include <linux/device.h>
> +
> +/* Ought to be enough for anybody */
> +#define TEST_TIMEOUT_MS	100
> +
> +struct managed_test_priv {
> +	bool action_done;
> +	wait_queue_head_t action_wq;
> +};
> +
> +static void drm_action(struct drm_device *drm, void *ptr)
> +{
> +	struct managed_test_priv *priv = ptr;
> +
> +	priv->action_done = true;
> +	wake_up_interruptible(&priv->action_wq);
> +}
> +
> +static void drm_test_managed_run_action(struct kunit *test)
> +{
> +	struct managed_test_priv *priv;
> +	struct drm_device *drm;
> +	struct device *dev;
> +	int ret;
> +
> +	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> +	init_waitqueue_head(&priv->action_wq);
> +
> +	dev = drm_kunit_helper_alloc_device(test);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> +
> +	drm = __drm_kunit_helper_alloc_drm_device(test, dev, sizeof(*drm), 0, DRIVER_MODESET);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
> +
> +	ret = drmm_add_action_or_reset(drm, drm_action, priv);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	ret = drm_dev_register(drm, 0);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	drm_dev_unregister(drm);
> +	drm_kunit_helper_free_device(test, dev);
> +
> +	ret = wait_event_interruptible_timeout(priv->action_wq, priv->action_done,
> +					       msecs_to_jiffies(TEST_TIMEOUT_MS));
> +	KUNIT_EXPECT_GT(test, ret, 0);
> +}
> +
> +static struct kunit_case drm_managed_tests[] = {
> +	KUNIT_CASE(drm_test_managed_run_action),
> +	{}
> +};
> +
> +static struct kunit_suite drm_managed_test_suite = {
> +	.name = "drm-test-managed",
> +	.test_cases = drm_managed_tests
> +};
> +
> +kunit_test_suite(drm_managed_test_suite);
> +
> +MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
> +MODULE_LICENSE("GPL");
> 
