Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D79363B2C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 21:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiK1UJc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 15:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiK1UJb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 15:09:31 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C805CFAD5;
        Mon, 28 Nov 2022 12:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0INozCygsrzYRHIPWCYY88aXHMGFfj1kNMWkQlBvxRM=; b=Z8qJhYlPU3DCTrelXjO2K07BcE
        On0eNgfVvJsermEmQ7OcZSA487+YB6k2mduXohpmL4e6a4kPJEzdBf8CUxL3Y7XiwLURBrzedamHJ
        oZ7sMQ7EveWpp0IUareCXQFd4wQyshUlb9kDtD/jH7ghK56LivS27fV8OfpSTgVuz4jtChapW1jSv
        R9afS9ayoWRufqgUXDVKKVaDg4AnMDv/olhafTFIT5m7IYrGhZ9T5VugJw4m2WmDqHiNwpR8UgrZY
        YogIzaPrtTuxEE7JDDTLfBMYaNoAyXo7IhrO8g1VW+070aYBEb4AoYmRJtW88jIvvOEPQcUZ0WMtE
        ubCjxwBg==;
Received: from [177.34.169.227] (helo=[192.168.0.8])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ozkRF-00AcE5-LC; Mon, 28 Nov 2022 21:09:15 +0100
Message-ID: <dffe5d84-4acf-ccb5-dacc-98f691c30352@igalia.com>
Date:   Mon, 28 Nov 2022 17:09:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 07/17] drm/tests: helpers: Make sure the device is
 bound
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
 <20221123-rpi-kunit-tests-v2-7-efe5ed518b63@cerno.tech>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20221123-rpi-kunit-tests-v2-7-efe5ed518b63@cerno.tech>
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
> The device managed resources are freed when the device is detached, so
> it has to be bound in the first place.
> 
> Let's create a fake driver that we will bind to our fake device to
> benefit from the device managed cleanups in our tests.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra Canal

> ---
>  drivers/gpu/drm/tests/drm_kunit_helpers.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> index 15678ab823b0..5d3e29353d1a 100644
> --- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
> +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> @@ -18,12 +18,32 @@ struct kunit_dev {
>  static const struct drm_mode_config_funcs drm_mode_config_funcs = {
>  };
>  
> +static int fake_probe(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static int fake_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static struct platform_driver fake_platform_driver = {
> +	.probe	= fake_probe,
> +	.remove	= fake_remove,
> +	.driver = {
> +		.name	= KUNIT_DEVICE_NAME,
> +	},
> +};
> +
>  /**
>   * drm_kunit_helper_alloc_device - Allocate a mock device for a KUnit test
>   * @test: The test context object
>   *
>   * This allocates a fake struct &device to create a mock for a Kunit
> - * test.
> + * test. The device will also be bound to a fake driver. It will thus be
> + * able to leverage the usual infrastructure and most notably the
> + * device-managed resources just like a "real" device.
>   *
>   * Callers need to make sure drm_kunit_helper_free_device() on the
>   * device when done.
> @@ -36,6 +56,9 @@ struct device *drm_kunit_helper_alloc_device(struct kunit *test)
>  	struct platform_device *pdev;
>  	int ret;
>  
> +	ret = platform_driver_register(&fake_platform_driver);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
>  	pdev = platform_device_alloc(KUNIT_DEVICE_NAME, PLATFORM_DEVID_NONE);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
>  
> @@ -58,6 +81,7 @@ void drm_kunit_helper_free_device(struct kunit *test, struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  
>  	platform_device_unregister(pdev);
> +	platform_driver_unregister(&fake_platform_driver);
>  }
>  EXPORT_SYMBOL(drm_kunit_helper_free_device);
>  
> 
