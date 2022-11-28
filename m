Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA8C63B2FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 21:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiK1UYH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 15:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbiK1UYE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 15:24:04 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586EA2A424;
        Mon, 28 Nov 2022 12:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QYXxZJSHFCQt3h/7y3A5kbbceUgmwfmV1IqjP3fxZUg=; b=LIik+9UMAQJCIDO+cZKWhn6+1H
        EmYKSWMp0+GBdJqBPq2aLClaiBHFKKSjwdAK0s2gcSwt/quMlH0lTaNmW+X0U8fAZNydLQjyLaUAN
        fRMltDkHl1RAaGoLhqFGbmguA0JpOni45hjzqYHJh1fn0XzVOrCOkpmSvCLFMFNoJk17Siz0VdNGX
        DgeE1KMAF5pTpMpPs30bg/FbCkVsU7UwVW2bAP3WL0qT+fvZ9DWitOXUXmIU9w84op+gG0gSi27am
        QG9sk1cSNXCNhcZ2KzJNRp7qi4YPemzGl/j+dQQ0A6zKgpdSGt50WTlabUCaEE8FrkOdwegCvCeKu
        Awkg9jfg==;
Received: from [177.34.169.227] (helo=[192.168.0.8])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ozkfM-00AcTd-CO; Mon, 28 Nov 2022 21:23:48 +0100
Message-ID: <2edc6568-fe43-5600-ef44-051026b4109f@igalia.com>
Date:   Mon, 28 Nov 2022 17:23:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 12/17] drm/vc4: crtc: Introduce a lower-level crtc init
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
 <20221123-rpi-kunit-tests-v2-12-efe5ed518b63@cerno.tech>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20221123-rpi-kunit-tests-v2-12-efe5ed518b63@cerno.tech>
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
> The current vc4_crtc_init() helper assumes that we will be using
> hardware planes and calls vc4_plane_init().
> 
> While it's a reasonable assumption, we'll want to mock the plane and
> thus provide our own. Let's create a helper that will take the plane as
> an argument.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Although the commit message explains a bit about why __vc4_crtc_init is
being created, it would be nice to add a comment in the code explaining
that __vc4_crtc_init can be used for tests as it allows mocking the
plane. This way the distinction between vc4_crtc_init and
__vc4_crtc_init will be cleaner to the reader.

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra Canal

> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 52 +++++++++++++++++++++++++++---------------
>  drivers/gpu/drm/vc4/vc4_drv.h  |  6 +++++
>  2 files changed, 39 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index 333529ed3a0d..7a2c54efecb0 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -1286,31 +1286,20 @@ static void vc4_set_crtc_possible_masks(struct drm_device *drm,
>  	}
>  }
>  
> -int vc4_crtc_init(struct drm_device *drm, struct platform_device *pdev,
> -		  struct vc4_crtc *vc4_crtc,
> -		  const struct vc4_crtc_data *data,
> -		  const struct drm_crtc_funcs *crtc_funcs,
> -		  const struct drm_crtc_helper_funcs *crtc_helper_funcs,
> -		  bool feeds_txp)
> +int __vc4_crtc_init(struct drm_device *drm,
> +		    struct platform_device *pdev,
> +		    struct vc4_crtc *vc4_crtc,
> +		    const struct vc4_crtc_data *data,
> +		    struct drm_plane *primary_plane,
> +		    const struct drm_crtc_funcs *crtc_funcs,
> +		    const struct drm_crtc_helper_funcs *crtc_helper_funcs,
> +		    bool feeds_txp)
>  {
>  	struct vc4_dev *vc4 = to_vc4_dev(drm);
>  	struct drm_crtc *crtc = &vc4_crtc->base;
> -	struct drm_plane *primary_plane;
>  	unsigned int i;
>  	int ret;
>  
> -	/* For now, we create just the primary and the legacy cursor
> -	 * planes.  We should be able to stack more planes on easily,
> -	 * but to do that we would need to compute the bandwidth
> -	 * requirement of the plane configuration, and reject ones
> -	 * that will take too much.
> -	 */
> -	primary_plane = vc4_plane_init(drm, DRM_PLANE_TYPE_PRIMARY, 0);
> -	if (IS_ERR(primary_plane)) {
> -		dev_err(drm->dev, "failed to construct primary plane\n");
> -		return PTR_ERR(primary_plane);
> -	}
> -
>  	vc4_crtc->data = data;
>  	vc4_crtc->pdev = pdev;
>  	vc4_crtc->feeds_txp = feeds_txp;
> @@ -1342,6 +1331,31 @@ int vc4_crtc_init(struct drm_device *drm, struct platform_device *pdev,
>  	return 0;
>  }
>  
> +int vc4_crtc_init(struct drm_device *drm, struct platform_device *pdev,
> +		  struct vc4_crtc *vc4_crtc,
> +		  const struct vc4_crtc_data *data,
> +		  const struct drm_crtc_funcs *crtc_funcs,
> +		  const struct drm_crtc_helper_funcs *crtc_helper_funcs,
> +		  bool feeds_txp)
> +{
> +	struct drm_plane *primary_plane;
> +
> +	/* For now, we create just the primary and the legacy cursor
> +	 * planes.  We should be able to stack more planes on easily,
> +	 * but to do that we would need to compute the bandwidth
> +	 * requirement of the plane configuration, and reject ones
> +	 * that will take too much.
> +	 */
> +	primary_plane = vc4_plane_init(drm, DRM_PLANE_TYPE_PRIMARY, 0);
> +	if (IS_ERR(primary_plane)) {
> +		dev_err(drm->dev, "failed to construct primary plane\n");
> +		return PTR_ERR(primary_plane);
> +	}
> +
> +	return __vc4_crtc_init(drm, pdev, vc4_crtc, data, primary_plane,
> +			       crtc_funcs, crtc_helper_funcs, feeds_txp);
> +}
> +
>  static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index 051c2e3b6d43..cd2002fff115 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -888,6 +888,12 @@ int vc4_bo_debugfs_init(struct drm_minor *minor);
>  /* vc4_crtc.c */
>  extern struct platform_driver vc4_crtc_driver;
>  int vc4_crtc_disable_at_boot(struct drm_crtc *crtc);
> +int __vc4_crtc_init(struct drm_device *drm, struct platform_device *pdev,
> +		    struct vc4_crtc *vc4_crtc, const struct vc4_crtc_data *data,
> +		    struct drm_plane *primary_plane,
> +		    const struct drm_crtc_funcs *crtc_funcs,
> +		    const struct drm_crtc_helper_funcs *crtc_helper_funcs,
> +		    bool feeds_txp);
>  int vc4_crtc_init(struct drm_device *drm, struct platform_device *pdev,
>  		  struct vc4_crtc *vc4_crtc, const struct vc4_crtc_data *data,
>  		  const struct drm_crtc_funcs *crtc_funcs,
> 
