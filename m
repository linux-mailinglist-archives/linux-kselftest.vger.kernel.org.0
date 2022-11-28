Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D68663B36A
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 21:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiK1Uhz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 15:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbiK1Uhi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 15:37:38 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103FC2ED5C;
        Mon, 28 Nov 2022 12:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xaI7kfEv+57J7JeLWjOKUpJS945rhDdD3ROyxxgB7fk=; b=pox/hC3JV0INcGpWW+6ZeZxNCE
        s3xaal6dZMHkGcGrxpXd/i77u8PIRkDjmFMZw1l+PcifSziNy013rIf3JvDdJ/S42Fzxgk6rKXG+g
        P50H67hIei5IjAGlfgEuxhbD44sxihk2iT6I6R1JQFh0LTF4ANU06d/npES3hXRQY4NNiQpv3uL36
        ihk929EoTXS4Otyz4FxiyjyVe43aJfs64WrU16FR6RaswDDMmAwQ+pZZv7ylj5OkhG2xgj9H6hKQR
        IdbeJsehYtcD6v9IisftOhNgLPVKQXd3N7Oowu7u74fHMDqg6bX85qomeqWUj1LdXgqmC7kp28lDw
        QR4H6rkQ==;
Received: from [177.34.169.227] (helo=[192.168.0.8])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ozksD-00Acgd-SH; Mon, 28 Nov 2022 21:37:06 +0100
Message-ID: <d4a216a3-aa4f-70b2-6ff6-363b415d7fbc@igalia.com>
Date:   Mon, 28 Nov 2022 17:36:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 03/17] drm/tests: helpers: Rename the device init
 helper
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
 <20221123-rpi-kunit-tests-v2-3-efe5ed518b63@cerno.tech>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20221123-rpi-kunit-tests-v2-3-efe5ed518b63@cerno.tech>
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
> The name doesn't really fit the conventions for the other helpers in
> DRM/KMS, so let's rename it to make it obvious that we allocate a new
> DRM device.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra Canal

> ---
>  drivers/gpu/drm/tests/drm_client_modeset_test.c | 3 ++-
>  drivers/gpu/drm/tests/drm_kunit_helpers.c       | 8 +++++---
>  drivers/gpu/drm/tests/drm_modes_test.c          | 3 ++-
>  drivers/gpu/drm/tests/drm_probe_helper_test.c   | 5 +++--
>  include/drm/drm_kunit_helpers.h                 | 5 ++++-
>  5 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_client_modeset_test.c b/drivers/gpu/drm/tests/drm_client_modeset_test.c
> index ed2f62e92fea..6cdf08f582ce 100644
> --- a/drivers/gpu/drm/tests/drm_client_modeset_test.c
> +++ b/drivers/gpu/drm/tests/drm_client_modeset_test.c
> @@ -59,7 +59,8 @@ static int drm_client_modeset_test_init(struct kunit *test)
>  
>  	test->priv = priv;
>  
> -	priv->drm = drm_kunit_device_init(test, DRIVER_MODESET, "drm-client-modeset-test");
> +	priv->drm = drm_kunit_helper_alloc_drm_device(test, DRIVER_MODESET,
> +						      "drm-client-modeset-test");
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->drm);
>  
>  	ret = drmm_connector_init(priv->drm, &priv->connector,
> diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> index 46a68c2fd80c..2f67f6cf78d0 100644
> --- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
> +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> @@ -36,7 +36,7 @@ static void dev_free(struct kunit_resource *res)
>  }
>  
>  /**
> - * drm_kunit_device_init - Allocates a mock DRM device for Kunit tests
> + * drm_kunit_helper_alloc_drm_device - Allocates a mock DRM device for Kunit tests
>   * @test: The test context object
>   * @features: Mocked DRM device driver features
>   * @name: Name of the struct &device to allocate
> @@ -52,7 +52,9 @@ static void dev_free(struct kunit_resource *res)
>   * Returns:
>   * A pointer to the new drm_device, or an ERR_PTR() otherwise.
>   */
> -struct drm_device *drm_kunit_device_init(struct kunit *test, u32 features, char *name)
> +struct drm_device *
> +drm_kunit_helper_alloc_drm_device(struct kunit *test,
> +				  u32 features, char *name)
>  {
>  	struct kunit_dev *kdev;
>  	struct drm_device *drm;
> @@ -82,7 +84,7 @@ struct drm_device *drm_kunit_device_init(struct kunit *test, u32 features, char
>  
>  	return drm;
>  }
> -EXPORT_SYMBOL(drm_kunit_device_init);
> +EXPORT_SYMBOL(drm_kunit_helper_alloc_drm_device);
>  
>  MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/gpu/drm/tests/drm_modes_test.c b/drivers/gpu/drm/tests/drm_modes_test.c
> index 3953e478c4d0..6723089dff9f 100644
> --- a/drivers/gpu/drm/tests/drm_modes_test.c
> +++ b/drivers/gpu/drm/tests/drm_modes_test.c
> @@ -22,7 +22,8 @@ static int drm_test_modes_init(struct kunit *test)
>  	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, priv);
>  
> -	priv->drm = drm_kunit_device_init(test, DRIVER_MODESET, "drm-modes-test");
> +	priv->drm = drm_kunit_helper_alloc_drm_device(test, DRIVER_MODESET,
> +						      "drm-modes-test");
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->drm);
>  
>  	test->priv = priv;
> diff --git a/drivers/gpu/drm/tests/drm_probe_helper_test.c b/drivers/gpu/drm/tests/drm_probe_helper_test.c
> index 1f3941c150ae..85236ff4744f 100644
> --- a/drivers/gpu/drm/tests/drm_probe_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_probe_helper_test.c
> @@ -39,8 +39,9 @@ static int drm_probe_helper_test_init(struct kunit *test)
>  	KUNIT_ASSERT_NOT_NULL(test, priv);
>  	test->priv = priv;
>  
> -	priv->drm = drm_kunit_device_init(test, DRIVER_MODESET | DRIVER_ATOMIC,
> -					  "drm-probe-helper-test");
> +	priv->drm = drm_kunit_helper_alloc_drm_device(test,
> +						      DRIVER_MODESET | DRIVER_ATOMIC,
> +						      "drm-probe-helper-test");
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->drm);
>  
>  	connector = &priv->connector;
> diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
> index 20ab6eec4c89..e9870c7911fe 100644
> --- a/include/drm/drm_kunit_helpers.h
> +++ b/include/drm/drm_kunit_helpers.h
> @@ -6,6 +6,9 @@
>  struct drm_device;
>  struct kunit;
>  
> -struct drm_device *drm_kunit_device_init(struct kunit *test, u32 features, char *name);
> +struct drm_device *
> +drm_kunit_helper_alloc_drm_device(struct kunit *test,
> +				  u32 features,
> +				  char *name);
>  
>  #endif // DRM_KUNIT_HELPERS_H_
> 
