Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8213E63D005
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 09:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbiK3IBI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 03:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbiK3IBG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 03:01:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2227391F8
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 00:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669795208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2a8xmX2uqZ7NUsrGlJ+pz4pKlQs3R+YDShsHCw2aB8=;
        b=jNNQa17HSX18/sywOQlGceO1Y9wMXW1SB3lmYzNJEaqxd7B0s520ZeJ5dbohNpB8Pv0V03
        eNJda6lskbGtSFLw6kFqP8gKM2kA0BugO48CT8lSX1EU8Th/QklEECtkVsxjET+/dInoAG
        c3o/V8gXr+oWhqZ0QCYtFwcqZGBWy78=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-470-UbLzEhiVMtO1T91zm0etyA-1; Wed, 30 Nov 2022 03:00:06 -0500
X-MC-Unique: UbLzEhiVMtO1T91zm0etyA-1
Received: by mail-wm1-f70.google.com with SMTP id az40-20020a05600c602800b003cfa26c40easo574943wmb.1
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 00:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2a8xmX2uqZ7NUsrGlJ+pz4pKlQs3R+YDShsHCw2aB8=;
        b=5+QXFJqdt3eBslarwvBnhqTzOXjU4PFFgm7rzaDygll6UmIAubWaXCAoRWXk2eMMvf
         EauYuOjeQGNZSmEM7D680f+gSYWIVe3LUfl+mdv8qiUUVo0lKzf+hTOerhXLsklqefmT
         f9K/yUByDR2sMOdYSFWYpsXgUvH12vCI6Crf9+nI1Uhi/wSKCYU9kJRR98wQPB9diO4d
         DMBtrXnIp81RlRM9ymC9RNoAhQ+KvRLZLkNLWUavNEhJZjeTml9S75sB93BILhjfyvng
         GpRkmp1c+aMqk3H4IcoeKiCoPf76yCh6m4dm0nn+FxAG3eAQrfbJNP+JSCDhMluzK3jo
         uteg==
X-Gm-Message-State: ANoB5plITQYuR+S2A0adixGZItSQ4Pq5/QWpgDePNAMME9xu0XiFWsfU
        QmvziCZqHZVdEX25q4F3/cEkRcaKhSeuIMato1FercrfSNMJCMDInH+MqFlYfdm2hiSmBDSPymh
        a7bEmTCJ+OrzPFd9+Kuu95qIGVJWN
X-Received: by 2002:a05:600c:24e:b0:3c5:f9f1:f956 with SMTP id 14-20020a05600c024e00b003c5f9f1f956mr30842041wmj.50.1669795205264;
        Wed, 30 Nov 2022 00:00:05 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Ey5+o85KLpwLVMTdnP29Su8T24kkvZHNDgYMdluRgMtIMgcoctfGdxRoxGf1Zvfd2hRrQBg==
X-Received: by 2002:a05:600c:24e:b0:3c5:f9f1:f956 with SMTP id 14-20020a05600c024e00b003c5f9f1f956mr30842007wmj.50.1669795205007;
        Wed, 30 Nov 2022 00:00:05 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c124-20020a1c3582000000b003cf894dbc4fsm1046855wma.25.2022.11.30.00.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 00:00:04 -0800 (PST)
Message-ID: <ebe02c21-7770-0415-096e-76a839bad154@redhat.com>
Date:   Wed, 30 Nov 2022 09:00:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 01/17] drm/tests: helpers: Move the helper header to
 include/drm
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
 <20221123-rpi-kunit-tests-v2-1-efe5ed518b63@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v2-1-efe5ed518b63@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/28/22 15:53, Maxime Ripard wrote:
> We'll need to use those helpers from drivers too, so let's move it to a
> more visible location.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/tests/drm_client_modeset_test.c            | 3 +--
>  drivers/gpu/drm/tests/drm_kunit_helpers.c                  | 3 +--
>  drivers/gpu/drm/tests/drm_modes_test.c                     | 3 +--
>  drivers/gpu/drm/tests/drm_probe_helper_test.c              | 3 +--
>  {drivers/gpu/drm/tests => include/drm}/drm_kunit_helpers.h | 0
>  5 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_client_modeset_test.c b/drivers/gpu/drm/tests/drm_client_modeset_test.c
> index 52929536a158..ed2f62e92fea 100644
> --- a/drivers/gpu/drm/tests/drm_client_modeset_test.c
> +++ b/drivers/gpu/drm/tests/drm_client_modeset_test.c
> @@ -8,12 +8,11 @@
>  #include <drm/drm_connector.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_drv.h>
> +#include <drm/drm_kunit_helpers.h>

I wonder if now that this header was moved outside of the tests directory,
if we should add stub functions in the header file that are just defined
but do nothing if CONFIG_DRM_KUNIT_TEST isn't enabled. So that including
it in drivers will be a no-op.

Or do you plan to conditionally include this header file in drivers? So
that is only included when CONFIG_DRM_KUNIT_TEST is enabled?

Another thing that wondered is if we want a different namespace for this
header, i.e: <drm/testing/drm_kunit_helpers.h>, to make it clear that is
not part of the DRM API but just for testing helpers.

But these are open questions really, and they can be done as follow-up:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

