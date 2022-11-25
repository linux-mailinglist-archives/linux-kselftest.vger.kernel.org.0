Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42BB638823
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 12:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiKYLCD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 06:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiKYLBw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 06:01:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C79D4A9C0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 03:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669374056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/ZkLtm8A9FTaUIt1krh1NXQg3mdZeQrz9lNHvK9Ra0=;
        b=KgajXx6a91KZg6gAWYWp2w9Tt6S+yTqr6lTP0OfXrDgIh0xNRZqCkdX2PoqBa4HHZ+D9SU
        +TbQvAWN90T4S/ScVDhjEIYl8w4oFxF34ylD0hfXNQv38P/gvKP2Rk3mRY4TIhrg/he7hJ
        IrIx1HBCTttfDuWxCZyzHxJkhs5bB0Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-522-J7k3gu5nOJC-t413ju5JCw-1; Fri, 25 Nov 2022 06:00:47 -0500
X-MC-Unique: J7k3gu5nOJC-t413ju5JCw-1
Received: by mail-wm1-f72.google.com with SMTP id c10-20020a7bc84a000000b003cf81c2d3efso1675292wml.7
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 03:00:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H/ZkLtm8A9FTaUIt1krh1NXQg3mdZeQrz9lNHvK9Ra0=;
        b=gRfpNuyLWvtc8dc8kyJxsggfJEC+xQadRyyLuLE4Xt/25taVFHR9F8sqJZ47FB+mPI
         PX73/tUnNQC8uAkWB2BIsmvfc7K+7Z01h7UrlErZpVQd0Wi9sAYd8udJiGlHnpwuPlbh
         32gsZ31ieIsHQdHAmLIopOUo9B01TpXY0d5zUubBMtjy4a85SCjlzLV+UJqY1/ZPb7Fk
         b1arwGHzFOvEec9TATxtEP9bvlDH05mDpjht+Fv+ACtUxpqhFq9oCrfaphZtB1DAI0I6
         IW7fuMM+D/afxrf/O4YSY8CebS1zeeyPgaGoYIup0MYedDGuEv7qMiCTgGFNhN6icL3o
         VLdA==
X-Gm-Message-State: ANoB5pnqBcF1koTr2kyJG2lCB7Xip77iqv+lEGj0rgDxjeAcDCNv1nWC
        stZXnLC8PIWKyzjXdL8U1QBrZfs6o68ROD5R6Z/FybOVXoo3oe73PWRgPDGZGraLievezcqfjjg
        /Fp2Hz8FegyMkExmlfe72XZnnA9hL
X-Received: by 2002:adf:e508:0:b0:236:588f:b5d with SMTP id j8-20020adfe508000000b00236588f0b5dmr11244638wrm.255.1669374046472;
        Fri, 25 Nov 2022 03:00:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7Xu/NP6mlFBtx0snOLhZERGkaY9p8k3uPMLjkAV/xFHCXfHC5Y76yhHYrvcopCb8lv41h+LQ==
X-Received: by 2002:adf:e508:0:b0:236:588f:b5d with SMTP id j8-20020adfe508000000b00236588f0b5dmr11244612wrm.255.1669374046175;
        Fri, 25 Nov 2022 03:00:46 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4cba4ef71sm8531125wmi.41.2022.11.25.03.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 03:00:45 -0800 (PST)
Message-ID: <2762e41f-0508-2e25-b787-7b68d5014a77@redhat.com>
Date:   Fri, 25 Nov 2022 12:00:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 10/24] drm/vc4: kms: Sort the CRTCs by output before
 assigning them
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
 <20221123-rpi-kunit-tests-v1-10-051a0bb60a16@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v1-10-051a0bb60a16@cerno.tech>
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
> On the vc4 devices (and later), the blending is done by a single device
> called the HVS. The HVS has three FIFO that can operate in parallel, and
> route their output to 6 CRTCs and 7 encoders on the BCM2711.
> 
> Each of these CRTCs and encoders have some contraints on which FIFO they

constraints.

> can feed from, so we need some code to take all those constraints into
> account and assign FIFOs to CRTCs.
> 
> The problem can be simplified by assigning those FIFOs to CRTCs by
> ascending output index number. We had a comment mentioning it already,
> but we were never actually enforcing it.
> 
> It was working still in most situations because the probe order is
> roughly equivalent, except for the (optional, and fairly rarely used on
> the Pi4) VEC which was last in the probe order sequence, but one of the
> earliest device to assign.
> 
> This resulted in configurations that were rejected by our code but were
> still valid with a different assignment.
> 
> We can fix this by making sure we assign CRTCs to FIFOs by ordering
> them by ascending HVS output index.
> 
> Fixes: 87ebcd42fb7b ("drm/vc4: crtc: Assign output to channel automatically")
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

[...]

>  
> -	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
> -		struct vc4_crtc_state *old_vc4_crtc_state =
> -			to_vc4_crtc_state(old_crtc_state);
> -		struct vc4_crtc_state *new_vc4_crtc_state =
> -			to_vc4_crtc_state(new_crtc_state);
> -		struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
> +	/*
> +	 * The problem we have to solve here is that we have up to 7
> +	 * encoders, connected to up to 6 CRTCs.
> +	 *
> +	 * Those CRTCs, depending on the instance, can be routed to 1, 2
> +	 * or 3 HVS FIFOs, and we need to set the change the muxing

This sentence sounds a little bit off to me. Did you mean:

"we need to set the muxing between" or "we need to change the muxing" ?

I'm not familiar with VC4 but the patch seems to do what the commit message
says, so the changes look good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

