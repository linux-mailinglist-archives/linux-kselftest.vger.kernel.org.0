Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC47463D178
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 10:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiK3JOj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 04:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiK3JOi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 04:14:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0DF20F58
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 01:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669799625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4kmVPYqwbxGU6PTsZRjCspb80cku12to9pgPPCu54U=;
        b=FtuB+7YjciKqs9N6vLGULn+VHZxt9Ox2AZo6rFJPIogvUT6h0WMSpYMH/xCFhiBBgl3gK4
        SY9BsyvJY0PkyVnBfsLKZ4PMtdFooa3JmMjqaWGN/OUu9gCG4r0WDysSlm68YrYND7/D1s
        jxjk5reddvRAtdyZ/ZPqdMV35gmIJLo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-90-HiFYPaEHNPy6QhWNUj5opQ-1; Wed, 30 Nov 2022 04:13:43 -0500
X-MC-Unique: HiFYPaEHNPy6QhWNUj5opQ-1
Received: by mail-wm1-f71.google.com with SMTP id 8-20020a05600c228800b003d0376e42deso412314wmf.4
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 01:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4kmVPYqwbxGU6PTsZRjCspb80cku12to9pgPPCu54U=;
        b=LMitHHPf5Pran52iqZinxTQUMFPr1NJdwwwCEiKem343HBVFnPjbvd/Xzcc25Bqjce
         Q9ituVWkJNi2pvV2dKzXGTWUTBmAHcthxConXo064DeHDImR9D6I+orD092uZEjDw9ou
         lv24ezQSyLixKWJkR3jRuvU2iNwj0pzwqHKYGigzJwYzmB6NVCAlWKR4M2HW/vGJPmm/
         vrbc121dbzt9WUBLYdd4ELTZVnOLfwMD0RvKt4y0a4jEakJc+lR7lihmYUPE11oTUUWR
         geE/ON1Wld98Zju9nnE7hFfB9iXx5r56R+GlLzli2o9JiOWFpJg6jfhTlNwkrHQ0d0hn
         Mg9A==
X-Gm-Message-State: ANoB5pkJfKr8N3WnKVBtIOa1feXEPmG7HRVkV3gA/6yKv8dkFtOnafUJ
        he51AuWiARhKiw8K4e7nqN25eHG2s9CayVi7Mn2ch0uTIv/szr1PXPXFzsazmmOaiRp2KTDEE+w
        97Vu2hwPExi0bD+DbV+2IN7uxXCJw
X-Received: by 2002:a1c:7513:0:b0:3cf:8896:e1c9 with SMTP id o19-20020a1c7513000000b003cf8896e1c9mr46817780wmc.119.1669799621487;
        Wed, 30 Nov 2022 01:13:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5vvCv9O/1R9RXSG17BNuO4k/AT1pMos0jlXhZZ5YoVQ/8d1PLV/cKODBBZcjZF5bgcENOdFQ==
X-Received: by 2002:a1c:7513:0:b0:3cf:8896:e1c9 with SMTP id o19-20020a1c7513000000b003cf8896e1c9mr46817770wmc.119.1669799621277;
        Wed, 30 Nov 2022 01:13:41 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h4-20020a5d5044000000b00241bc4880fesm905866wrt.111.2022.11.30.01.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 01:13:40 -0800 (PST)
Message-ID: <a86a67d8-59dc-1af8-4176-b3236ef0f0a1@redhat.com>
Date:   Wed, 30 Nov 2022 10:13:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 08/17] drm/tests: helpers: Allow for a custom device
 struct to be allocated
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
 <20221123-rpi-kunit-tests-v2-8-efe5ed518b63@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v2-8-efe5ed518b63@cerno.tech>
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
> The current helper to allocate a DRM device doesn't allow for any
> subclassing by drivers, which is going to be troublesome as we work on
> getting some kunit testing on atomic modesetting code.
> 
> Let's use a similar pattern to the other allocation helpers by providing
> the structure size and offset as arguments.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

[...]

> -EXPORT_SYMBOL(drm_kunit_helper_alloc_drm_device);
> +EXPORT_SYMBOL(__drm_kunit_helper_alloc_drm_device);
>

I'm not sure if I would add a __ prefix to exported symbols, but I see that
this is a convention in the DRM subsystem so I'm OK with it. 

Another thing that came to mind is if we want to use EXPORT_SYMBOL_GPL()
instead for the DRM KUnit helpers. But that's not related to this series.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>  

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

