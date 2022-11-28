Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B21463B31A
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 21:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbiK1U1B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 15:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiK1U0y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 15:26:54 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20B42CCB2;
        Mon, 28 Nov 2022 12:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/sTcXOAXGAMuK5G/ElNc5ZSL+smBi2LaSE+7f87t0JM=; b=Qu+a2WRrFH5Cn/iLLZ07s8GGX6
        h0vwLadZK7Z3fPuhokWU4/sgPTgFOGPQyOT3SwR4XhXmJ5FvZHJNbei+GS8Q1FzmtKenVNwwzeUFD
        K/Gf2qejFUfcF/N3bwkNd4Ixc5bUx3aTVOLDpmt0fYrQ/HvGU8ISukfR5IUy4F+/4GvXu6YCldc9V
        QWAbNNaHixECEZulOkrsQYQ0KWGqHYWfhNDT8NZWAafXbx+61yYFfyNfHob0e6VwVO807hOrkB45Z
        5GIJ3rXchH/l8X3KVGY3mfVz/ENUjFe0aktAOY1gZcnngXSolpjKiNv9LA7vIwr0e6B2bm/YjyPiA
        i1HmOL8w==;
Received: from [177.34.169.227] (helo=[192.168.0.8])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ozkiA-00AcWv-Jz; Mon, 28 Nov 2022 21:26:42 +0100
Message-ID: <8eab7706-e86a-7e2b-3107-76fe10639e70@igalia.com>
Date:   Mon, 28 Nov 2022 17:26:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 13/17] drm/vc4: crtc: Make encoder lookup helper public
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
References: <20221123-rpi-kunit-tests-v2-0-efe5ed518b63@cerno.tech>
 <20221123-rpi-kunit-tests-v2-13-efe5ed518b63@cerno.tech>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20221123-rpi-kunit-tests-v2-13-efe5ed518b63@cerno.tech>
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
> We'll need a function that looks up an encoder by its vc4_encoder_type.
> Such a function is already present in the CRTC code, so let's make it
> public so that we can reuse it in the unit tests.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra Canal

> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 17 +----------------
>  drivers/gpu/drm/vc4/vc4_drv.h  | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index 7a2c54efecb0..59e473059fa2 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -486,21 +486,6 @@ static int vc4_crtc_disable(struct drm_crtc *crtc,
>  	return 0;
>  }
>  
> -static struct drm_encoder *vc4_crtc_get_encoder_by_type(struct drm_crtc *crtc,
> -							enum vc4_encoder_type type)
> -{
> -	struct drm_encoder *encoder;
> -
> -	drm_for_each_encoder(encoder, crtc->dev) {
> -		struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
> -
> -		if (vc4_encoder->type == type)
> -			return encoder;
> -	}
> -
> -	return NULL;
> -}
> -
>  int vc4_crtc_disable_at_boot(struct drm_crtc *crtc)
>  {
>  	struct drm_device *drm = crtc->dev;
> @@ -536,7 +521,7 @@ int vc4_crtc_disable_at_boot(struct drm_crtc *crtc)
>  
>  	pv_data = vc4_crtc_to_vc4_pv_data(vc4_crtc);
>  	encoder_type = pv_data->encoder_types[encoder_sel];
> -	encoder = vc4_crtc_get_encoder_by_type(crtc, encoder_type);
> +	encoder = vc4_find_encoder_by_type(drm, encoder_type);
>  	if (WARN_ON(!encoder))
>  		return 0;
>  
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index cd2002fff115..54352db48476 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -495,6 +495,22 @@ to_vc4_encoder(const struct drm_encoder *encoder)
>  	return container_of(encoder, struct vc4_encoder, base);
>  }
>  
> +static inline
> +struct drm_encoder *vc4_find_encoder_by_type(struct drm_device *drm,
> +					     enum vc4_encoder_type type)
> +{
> +	struct drm_encoder *encoder;
> +
> +	drm_for_each_encoder(encoder, drm) {
> +		struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
> +
> +		if (vc4_encoder->type == type)
> +			return encoder;
> +	}
> +
> +	return NULL;
> +}
> +
>  struct vc4_crtc_data {
>  	const char *name;
>  
> 
