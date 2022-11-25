Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9AC6387FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 11:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiKYKzH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 05:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiKYKzH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 05:55:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F61490A0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 02:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669373647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9tvd04/iu26771wlB7WciR/DkQpotQap05SOjl7Y+To=;
        b=IFO8O5CCbjGtmhQgqNuDDRkyEspYsmnx8s5Gmb51qDl3pWMB9sXL7HVH3/zISByJXCkQ7I
        VV4NAtp9Kl9LBBJ5eUseklz1viXCoob8rU7b4WgBD0uMAj6os50VUflohTaelRBmmLKPfM
        WGXaRm1I6yMKSmmD9YpiXxfK7Q3GgEY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-379-n2lAVyCQM36AsNbaZJYCfg-1; Fri, 25 Nov 2022 05:54:06 -0500
X-MC-Unique: n2lAVyCQM36AsNbaZJYCfg-1
Received: by mail-wm1-f70.google.com with SMTP id l42-20020a05600c1d2a00b003cf8e70c1ecso4028041wms.4
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 02:54:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tvd04/iu26771wlB7WciR/DkQpotQap05SOjl7Y+To=;
        b=w2z+odjIwmWD6h7ZxlqTRiONa6Zb0A9Ccm4lNxyQ/MHJvQQ7oKwg/Pb9CDr3XUhTk7
         ez5GcqaIwTw+xTMoXup131dVB3Y2AC0jl5Hsb99m84OxnV59FsyH+g9f69uejOmpa6bC
         jmjtwvtNyS/McbsXT6UX/RghpmR9MWhU4CasJgc7mfBjXwHwXnWCNissdTtGNaRguumE
         ZEn1qbw63hhQwAO//Jtg5+nlg1N78HKXGTRQaTy57vG95kREKAd+aalHzGxbHPsmxaWu
         mvuKLVAPwdhgBRdL1837Zs/g1lwv0AkUI7bdWv0exfhSI3meFWU8TDObyPEpaJ9iI4Ge
         iing==
X-Gm-Message-State: ANoB5pkhGooqWyVyvlQTaY4YhngK0e53tv+teYGbH31nxVl7h8aqFYi+
        EISaWxrRelGdNvWmaHJ7fBdHiXLqXUyl2RcEVMlEGNkx4059GMt4Xq27auBRLXeh3dqxDeCHIsB
        xvttss0H7VQ0AL9CSABjOqDQkCPVk
X-Received: by 2002:adf:e94c:0:b0:236:6d79:b312 with SMTP id m12-20020adfe94c000000b002366d79b312mr22866558wrn.699.1669373645076;
        Fri, 25 Nov 2022 02:54:05 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4MhXPJaPoTEfI4yng3ZY2kweBGK0CbbycrpZOheo/dL+NoYUdJpT+aQbCzIEhJ5+Sz9WdagQ==
X-Received: by 2002:adf:e94c:0:b0:236:6d79:b312 with SMTP id m12-20020adfe94c000000b002366d79b312mr22866536wrn.699.1669373644817;
        Fri, 25 Nov 2022 02:54:04 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l11-20020a1c790b000000b003b4a699ce8esm8527114wme.6.2022.11.25.02.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 02:54:04 -0800 (PST)
Message-ID: <1b0c23f4-eb5c-38d2-b1ff-541140ac32a0@redhat.com>
Date:   Fri, 25 Nov 2022 11:54:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 09/24] drm/atomic: Constify the old/new state accessors
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
 <20221123-rpi-kunit-tests-v1-9-051a0bb60a16@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v1-9-051a0bb60a16@cerno.tech>
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
> The drm_atomic_get_(old|new)_*_state don't modify the passed
> drm_atomic_state, so we can make it const.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

