Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F7D63B2AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 21:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiK1UBv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 15:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiK1UBu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 15:01:50 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE4114026;
        Mon, 28 Nov 2022 12:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ISyLvvVbmkVMtysV5RC9fGrmHd3bXOuCgdRekBqVUuQ=; b=r5MQVKtbgyTmArJRqAObkt+Huo
        1YLaklT6xQoWF0ibenjtpkC7v0/shWVftQ4U2j9KxQfx1ceIFcsD92/9qca5DgSzPz2tfXh/3D//N
        9ybeK4Ho+l3GMPhmBdjiZchWvH4jDldxLYsrKVdG/QWnN9k4WXNBO1gvlQsl68CnRNuTTwXWcqdPY
        3nCRN06alHSkHp21JSn+8/D87F4nIX5XTwkH8r4avvd2q5xyqARioU32lEGnTw1GJu8driWyTd3h8
        9NsVQzszN422DMdRsEFlIHNRMuKmAJgvTrUaqp2tScNDAlGUruP6Cm5UySbQJq+kdDMoTH5rab6w8
        d76yaa0w==;
Received: from [177.34.169.227] (helo=[192.168.0.8])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ozkJl-00Aboh-5u; Mon, 28 Nov 2022 21:01:29 +0100
Message-ID: <0ae37916-ecc1-d97c-6a98-c8008fdd05f6@igalia.com>
Date:   Mon, 28 Nov 2022 17:01:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 06/17] drm/tests: helpers: Switch to a platform_device
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
 <20221123-rpi-kunit-tests-v2-6-efe5ed518b63@cerno.tech>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20221123-rpi-kunit-tests-v2-6-efe5ed518b63@cerno.tech>
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
> The device managed resources are ran if the device has bus, which is not
> the case of a root_device.
> 
> Let's use a platform_device instead.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra Canal

> ---
>  drivers/gpu/drm/tests/drm_kunit_helpers.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> index 9fb045fa685f..15678ab823b0 100644
> --- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
> +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> @@ -7,6 +7,7 @@
>  #include <kunit/resource.h>
>  
>  #include <linux/device.h>
> +#include <linux/platform_device.h>
>  
>  #define KUNIT_DEVICE_NAME	"drm-kunit-mock-device"
>  
> @@ -32,7 +33,16 @@ static const struct drm_mode_config_funcs drm_mode_config_funcs = {
>   */
>  struct device *drm_kunit_helper_alloc_device(struct kunit *test)
>  {
> -	return root_device_register(KUNIT_DEVICE_NAME);
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	pdev = platform_device_alloc(KUNIT_DEVICE_NAME, PLATFORM_DEVID_NONE);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +
> +	ret = platform_device_add(pdev);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	return &pdev->dev;
>  }
>  EXPORT_SYMBOL(drm_kunit_helper_alloc_device);
>  
> @@ -45,7 +55,9 @@ EXPORT_SYMBOL(drm_kunit_helper_alloc_device);
>   */
>  void drm_kunit_helper_free_device(struct kunit *test, struct device *dev)
>  {
> -	root_device_unregister(dev);
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	platform_device_unregister(pdev);
>  }
>  EXPORT_SYMBOL(drm_kunit_helper_free_device);
>  
> 
