Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488C8638BDE
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 15:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiKYOKR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 09:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiKYOKR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 09:10:17 -0500
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D795420379;
        Fri, 25 Nov 2022 06:10:12 -0800 (PST)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4NJcFb5ZXkzDrVl;
        Fri, 25 Nov 2022 14:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1669385412; bh=URYH0IzqLdcTRk2nEZuYkw52NB+0goWIxpVAqrktmWk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hmhdwpA3y7+ljO6AAmdV08S1hROra14B1YqTtMA/+M0I4UE38BCbPQogQs+32v9j6
         rM4cxEOLFa0LYx0se2bUnQzMWeAdvXBYr3aeYVBYDFwmFmKpgNKG3CzzEEmrC0q9bf
         Ylr1XPmwiZX1oFMkGAN6UKii9hQ/lIvgcelTj00o=
X-Riseup-User-ID: 71B09A1F920CD941466DEE4BA3A0B31413D3BD54FB7AA6B05413A8EB5A9CC69A
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4NJcFV4BCfz5vbk;
        Fri, 25 Nov 2022 14:10:06 +0000 (UTC)
Message-ID: <6a817cad-df46-42ac-3c14-dbdce681cde6@riseup.net>
Date:   Fri, 25 Nov 2022 11:10:02 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 01/24] drm/tests: helpers: Rename the device init helper
To:     Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org
References: <20221123-rpi-kunit-tests-v1-0-051a0bb60a16@cerno.tech>
 <20221123-rpi-kunit-tests-v1-1-051a0bb60a16@cerno.tech>
Content-Language: en-US
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20221123-rpi-kunit-tests-v1-1-051a0bb60a16@cerno.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/23/22 12:25, Maxime Ripard wrote:
> The name doesn't really fit the conventions for the other helpers in
> DRM/KMS, so let's rename it to make it obvious that we allocate a new
> DRM device.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Although I believe using "drm_device" on the function name is a bit 
redundant (maybe drm_kunit_helper_alloc_dev or 
drm_kunit_helper_alloc_device would be cleaner),

Reviewed-by: Maíra Canal <mairacanal@riseup.net>

Best Regards,
- Maíra Canal

> ---
>   drivers/gpu/drm/tests/drm_client_modeset_test.c | 2 +-
>   drivers/gpu/drm/tests/drm_kunit_helpers.c       | 4 +++-
>   drivers/gpu/drm/tests/drm_kunit_helpers.h       | 5 ++++-
>   3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_client_modeset_test.c b/drivers/gpu/drm/tests/drm_client_modeset_test.c
> index 362a5fbd82f5..e469d1634e2d 100644
> --- a/drivers/gpu/drm/tests/drm_client_modeset_test.c
> +++ b/drivers/gpu/drm/tests/drm_client_modeset_test.c
> @@ -41,7 +41,7 @@ static int drm_client_modeset_test_init(struct kunit *test)
>   
>   	test->priv = priv;
>   
> -	priv->drm = drm_kunit_device_init(test, DRIVER_MODESET, "drm-client-modeset-test");
> +	priv->drm = drm_kunit_helper_alloc_drm_device(test, DRIVER_MODESET, "drm-client-modeset-test");
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->drm);
>   
>   	ret = drmm_connector_init(priv->drm, &priv->connector,
> diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> index f1662091f250..a4ad030ed101 100644
> --- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
> +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> @@ -36,7 +36,9 @@ static void dev_free(struct kunit_resource *res)
>   	root_device_unregister(dev);
>   }
>   
> -struct drm_device *drm_kunit_device_init(struct kunit *test, u32 features, char *name)
> +struct drm_device *
> +drm_kunit_helper_alloc_drm_device(struct kunit *test,
> +				  u32 features, char *name)
>   {
>   	struct kunit_dev *kdev;
>   	struct drm_device *drm;
> diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.h b/drivers/gpu/drm/tests/drm_kunit_helpers.h
> index 20ab6eec4c89..e9870c7911fe 100644
> --- a/drivers/gpu/drm/tests/drm_kunit_helpers.h
> +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.h
> @@ -6,6 +6,9 @@
>   struct drm_device;
>   struct kunit;
>   
> -struct drm_device *drm_kunit_device_init(struct kunit *test, u32 features, char *name);
> +struct drm_device *
> +drm_kunit_helper_alloc_drm_device(struct kunit *test,
> +				  u32 features,
> +				  char *name);
>   
>   #endif // DRM_KUNIT_HELPERS_H_
> 
