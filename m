Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E0A6385B9
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 09:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiKYI6V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 03:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKYI6U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 03:58:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17FA109D
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 00:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669366647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Zasw8bTF5Rv7J9KCKu2Jsu6Fuo3MdgsNAsJkLxlZjY=;
        b=LPpNh+n1prqno3RBgrlj6Pspx4skPv2W8uE/ENxgV9NDKxqp0LCphbMuyZm2WsMJcpEa5Z
        +rFStnX51h4NiTwx/vtxESKP4Pn3gu5evdHtcwCEzESiz9nQt4wQ1GU2D1nrsXmnsfMO6Q
        L6GV1+jCHcU2Uk/mtKUc0RwRkRmbQ0A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-sbdvk0IHM3-Uy8jplnbMNg-1; Fri, 25 Nov 2022 03:57:26 -0500
X-MC-Unique: sbdvk0IHM3-Uy8jplnbMNg-1
Received: by mail-wm1-f71.google.com with SMTP id az40-20020a05600c602800b003cfa26c40easo3686332wmb.1
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 00:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Zasw8bTF5Rv7J9KCKu2Jsu6Fuo3MdgsNAsJkLxlZjY=;
        b=dkqjDPBYLSo2KrjNx4WecJZw3bNJzXJHFZ5jRz26WPUfK4SFHwaME6opQ5FtL4tv+E
         eKKCOslDNUT4RsKY7VRnRh9TNfLLQSnGC8VFNVz1prMnleshZ/RCDN5GOGgtD3M3VzRA
         fzQWhAYZBfYn4mS2elb9133QVnSI9S1ihg9WCwiMOOZM9pqT9QamXD0WNN0jqQ0OqK4A
         Fxhsz6zMkHXCRbGKimhN0pgqMDG+L5emtNyo3mgATyQB+1fu2QF75Wyd83CTw/e++EnD
         J+z7X+m+2e7/FeTZQ/2E3qRnn54rvKGUd+fBXOLAyUCajzOYTLU8FTt8qzQhFQtUpb/o
         Tg6w==
X-Gm-Message-State: ANoB5pny7Z6IQYKmiXQh8e267xkMtkFAJidkpTqOdP23V0scgG5I2/fy
        TX0YWFlRRkDfxWtHCRHFpIWZk6KpcdcgRzzySqs2fetKfLhp17Y1l8wsbM1NFD5n/7iQm4nlSKl
        I+EbZ4Vp2Ao+3x62NYhVz6BJW/2PD
X-Received: by 2002:adf:de8f:0:b0:241:df57:80a7 with SMTP id w15-20020adfde8f000000b00241df5780a7mr11243003wrl.191.1669366645226;
        Fri, 25 Nov 2022 00:57:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6I9dIfw7rl+C6lpH9D4FzplrH7lHVT+4+0sx5/OzVH2zqrsMW/YbaUpZl0bbTphLuFhCwwqA==
X-Received: by 2002:adf:de8f:0:b0:241:df57:80a7 with SMTP id w15-20020adfde8f000000b00241df5780a7mr11242992wrl.191.1669366645018;
        Fri, 25 Nov 2022 00:57:25 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i19-20020a1c5413000000b003cfc02ab8basm8929498wmb.33.2022.11.25.00.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 00:57:24 -0800 (PST)
Message-ID: <cb95b9c7-a975-1990-caed-a7ce80860809@redhat.com>
Date:   Fri, 25 Nov 2022 09:57:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 02/24] drm/tests: helpers: Remove the name parameter
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Gow <davidgow@google.com>, linaro-mm-sig@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        linux-media@vger.kernel.org, kunit-dev@googlegroups.com,
        dri-devel@lists.freedesktop.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20221123-rpi-kunit-tests-v1-0-051a0bb60a16@cerno.tech>
 <20221123-rpi-kunit-tests-v1-2-051a0bb60a16@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v1-2-051a0bb60a16@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/23/22 16:25, Maxime Ripard wrote:
> The device name isn't really useful, we can just define it instead of
> exposing it in the API.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/tests/drm_client_modeset_test.c | 2 +-
>  drivers/gpu/drm/tests/drm_kunit_helpers.c       | 6 ++++--
>  drivers/gpu/drm/tests/drm_kunit_helpers.h       | 3 +--
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_client_modeset_test.c b/drivers/gpu/drm/tests/drm_client_modeset_test.c
> index e469d1634e2d..6920c3ffdfdf 100644
> --- a/drivers/gpu/drm/tests/drm_client_modeset_test.c
> +++ b/drivers/gpu/drm/tests/drm_client_modeset_test.c
> @@ -41,7 +41,7 @@ static int drm_client_modeset_test_init(struct kunit *test)
>  
>  	test->priv = priv;
>  
> -	priv->drm = drm_kunit_helper_alloc_drm_device(test, DRIVER_MODESET, "drm-client-modeset-test");
> +	priv->drm = drm_kunit_helper_alloc_drm_device(test, DRIVER_MODESET);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->drm);
>  
>  	ret = drmm_connector_init(priv->drm, &priv->connector,
> diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> index a4ad030ed101..7f69f56f5892 100644
> --- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
> +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> @@ -9,6 +9,8 @@
>  
>  #include "drm_kunit_helpers.h"
>  
> +#define FAKE_DEVICE_NAME	"drm-kunit-fake-device"
> +

I think that KUNIT_DEVICE_NAME and "drm-kunit-mock-device" are more descriptive
names here. But I'm also OK with the patch as is.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

