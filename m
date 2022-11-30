Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EDC63D2A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 11:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbiK3KAo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 05:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiK3KAn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 05:00:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FADC2F032
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 01:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669802382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i9YloUXR8YgxG0RXDuEgcRvlMcfIOaju0pjadJIoBw0=;
        b=XNdEUaaqVimai4+9Tmo2Cw5KqwPbPIuIX7tj8HCV+UUpifoKX4pdCCkkwYftXmg3iKyP3X
        5k2XVtwqPcnvxNIiBh51ndP333yNeFqNCR9vwJWiKRSkyq5OL+bzr0ImP5Dp2N7XXBEcRe
        +Uzl+I3St+8GfrzonZYzdu32RiDEKh0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-448-V_7nBdGiNO6rO2I2K4RphA-1; Wed, 30 Nov 2022 04:59:40 -0500
X-MC-Unique: V_7nBdGiNO6rO2I2K4RphA-1
Received: by mail-wm1-f70.google.com with SMTP id z18-20020a05600c221200b003cf7fcc286aso457695wml.1
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 01:59:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9YloUXR8YgxG0RXDuEgcRvlMcfIOaju0pjadJIoBw0=;
        b=Gz7hDa1z6JsFDP90jwznEKBxWLJjw04q45lt8ufRisdBbk9VBwnwGHPpJ+vcMnjSxt
         kqY7InBqefQRIwPai8fLSLpVhloXkupyg6/WMwg4HNxtC24Mk5R1DG6NUhbycBTAo4sI
         dI9cviDRnwcNSJiH3Fh5bQR7GN24Woifk5l5Ynb8yDt6akh1IwaiwjxR/RHDnq9QR3aU
         eR5rODOzpmGoR32vndTpoF2ui0YS2yzytfTNj+irlirLAcOFDj4k3uaB4FR/+eMLd0hA
         XLQy3/R6eXClhfYnTO1OKTdPCUS93fy1mpnJE8iY37bHRZCRWBA3plNM+14wRLGGHqfE
         t4wQ==
X-Gm-Message-State: ANoB5pkVVXeT9iMWXyJdV37+MkfYgczaSGbE4AI+A1UM1iabobxKYVKI
        jhDd4hyWEak8k8f1LqijkcOhuZaKnYeh2aT8GAmUEjoHtJSsmdireCEVul46ImsujbH31jRaww1
        vOkhvm69rQE0xhv5YbLaKK5ok3CBu
X-Received: by 2002:a1c:ed04:0:b0:3cf:d08d:3eb2 with SMTP id l4-20020a1ced04000000b003cfd08d3eb2mr44719675wmh.129.1669802379213;
        Wed, 30 Nov 2022 01:59:39 -0800 (PST)
X-Google-Smtp-Source: AA0mqf79VoYVflQvJw4f+0ufZcLu3pjWScxDx/iG55eOd/S6Dqx9Zr87reES7FRBY59uRsQEURml4w==
X-Received: by 2002:a1c:ed04:0:b0:3cf:d08d:3eb2 with SMTP id l4-20020a1ced04000000b003cfd08d3eb2mr44719668wmh.129.1669802379003;
        Wed, 30 Nov 2022 01:59:39 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id fc13-20020a05600c524d00b003d04e4ed873sm5840399wmb.22.2022.11.30.01.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 01:59:38 -0800 (PST)
Message-ID: <98d47486-d04c-b81a-6ae4-fa7f62828a0e@redhat.com>
Date:   Wed, 30 Nov 2022 10:59:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 15/17] drm/vc4: tests: Introduce a mocking
 infrastructure
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
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
References: <20221123-rpi-kunit-tests-v2-0-efe5ed518b63@cerno.tech>
 <20221123-rpi-kunit-tests-v2-15-efe5ed518b63@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v2-15-efe5ed518b63@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/28/22 15:53, Maxime Ripard wrote:
> In order to test the current atomic_check hooks we need to have a DRM
> device that has roughly the same capabilities and layout that the actual
> hardware. We'll also need a bunch of functions to create arbitrary
> atomic states.
> 
> Let's create some helpers to create a device that behaves like the real
> one, and some helpers to maintain the atomic state we want to check.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

[...]

> +
> +config DRM_VC4_KUNIT_TEST
> +	bool "KUnit tests for VC4" if !KUNIT_ALL_TESTS
> +	depends on DRM_VC4 && KUNIT

shouldn't this depend on DRM_KUNIT_TEST instead ?

[...]

> +static struct vc4_dev *__mock_device(struct kunit *test, bool is_vc5)
> +{
> +	struct drm_device *drm;
> +	const struct drm_driver *drv = is_vc5 ? &vc5_drm_driver : &vc4_drm_driver;
> +	const struct vc4_mock_desc *desc = is_vc5 ? &vc5_mock : &vc4_mock;
> +	struct vc4_dev *vc4;

Since it could be vc4 or vc5, maybe can be renamed to just struct vc_dev *vc ?

> +struct vc4_dummy_plane *vc4_dummy_plane(struct kunit *test,
> +					struct drm_device *drm,
> +					enum drm_plane_type type)
> +{
> +	struct vc4_dummy_plane *dummy_plane;
> +	struct drm_plane *plane;
> +
> +	dummy_plane = drmm_universal_plane_alloc(drm,
> +						 struct vc4_dummy_plane, plane.base,
> +						 0,
> +						 &vc4_dummy_plane_funcs,
> +						 vc4_dummy_plane_formats,
> +						 ARRAY_SIZE(vc4_dummy_plane_formats),
> +						 NULL,
> +						 DRM_PLANE_TYPE_PRIMARY,
> +						 NULL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dummy_plane);
> +
> +	plane = &dummy_plane->plane.base;
> +	drm_plane_helper_add(plane, &vc4_dummy_plane_helper_funcs);
> +
> +	return dummy_plane;
> +}

I guess many of these helpers could grow to be generic, like this one since
most drivers support the DRM_FORMAT_XRGB8888 format for their primary plane.

[...]

>  
> +extern const struct vc4_pv_data bcm2835_pv0_data;
> +extern const struct vc4_pv_data bcm2835_pv1_data;
> +extern const struct vc4_pv_data bcm2835_pv2_data;
> +extern const struct vc4_pv_data bcm2711_pv0_data;
> +extern const struct vc4_pv_data bcm2711_pv1_data;
> +extern const struct vc4_pv_data bcm2711_pv2_data;
> +extern const struct vc4_pv_data bcm2711_pv3_data;
> +extern const struct vc4_pv_data bcm2711_pv4_data;
> +

Maybe the driver could expose a helper function to get the pixelvalve data
and avoid having to expose all of these variables? For example you could
define an enum vc4_pixelvalve type and have something like the following:

const struct vc4_pv_data *vc4_crtc_get_pixelvalve_data(enum vc4_pixelvalve pv);

All these are small nits though, the patch looks great to me and I think is
awesome to have this level of testing with KUnit. Hope other drivers follow
your lead.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

