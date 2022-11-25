Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA567638857
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 12:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiKYLM0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 06:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiKYLMZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 06:12:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C05D22B07
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 03:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669374684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bXK7NEAftcHsfPhR8xLmiSPyb+Ng0LBgXVA+cCW5sV8=;
        b=elGz/XR+clak2f43PZlubXrFplPW7ONrwBFicP6O3wIa1QPJLOtrjFz1ewe7vvjgRCVLNO
        dI1UPHmVJ3vzydBGaGQDljhjH9hDVJIJX4JJEQB8sn/K2Sn5Ld5fzOWKbM/urG8lGDnVcl
        PvPI332VaBSR11W3mhFQ7ntmB9fb93I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-606-k1FdI5EpOzq2Lf5EvSvuFA-1; Fri, 25 Nov 2022 06:11:23 -0500
X-MC-Unique: k1FdI5EpOzq2Lf5EvSvuFA-1
Received: by mail-wr1-f71.google.com with SMTP id d11-20020adfa40b000000b00241db65ec27so784417wra.10
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 03:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXK7NEAftcHsfPhR8xLmiSPyb+Ng0LBgXVA+cCW5sV8=;
        b=VPbvyJsHXMrhn9y58fdDifyrJ4c89QWfGPJUFSfvvIGMCQ6OHVhPrDZIIVuLKCm0Hl
         xjWdJcHd6vmTHsHnnZhrHVpzGQmjGurY/FRiilV0fkNADlbubtSLFolWQSQoAwuxKTH/
         g1hGp483sKtX/tDNDFmV61m5bkaR4jKYmOxdwA/4nXIVD4i0QpTMfQvWhbWDKzwN2XV9
         vfs5b7T68xKRvr7DVrA+Mn2OyGnswBpiJ4Zsi7LQzPCarRF/Z4/xd39E08TV+NYxSx1L
         oq8xVjLWw2p/AcMSYcxyH33Ni/qE9BcI689DRP/7w8rvpIfui42DLuPjLCHDA4d3z1Lz
         tt8w==
X-Gm-Message-State: ANoB5pkqsjVciHT01480KA/CKCdrM3WH6GYuegaMufSk6jpbQyuVZ8Jq
        LvYOGidyPPOS1Yg9PETDgm8HD35rZrBtA2b0fRyJcxuCDhm+4pRawO4oUbT2DpPGbJfuJECH/oE
        zqjfi++0/Ru3iGPR0SnKkcTEQtU4O
X-Received: by 2002:adf:bc12:0:b0:241:bc6a:ceb with SMTP id s18-20020adfbc12000000b00241bc6a0cebmr22077601wrg.514.1669374681933;
        Fri, 25 Nov 2022 03:11:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf50vACH/nxqsgQ+LdWr/oW1K7P9EvuBwdf6WTZcR7NJizA5OCGwk+5+gUp1U3sa0s25anlUtg==
X-Received: by 2002:adf:bc12:0:b0:241:bc6a:ceb with SMTP id s18-20020adfbc12000000b00241bc6a0cebmr22077572wrg.514.1669374681761;
        Fri, 25 Nov 2022 03:11:21 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v15-20020a05600c444f00b003a1980d55c4sm9529366wmn.47.2022.11.25.03.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 03:11:21 -0800 (PST)
Message-ID: <df32e940-7517-e98d-a48c-1942bfa89289@redhat.com>
Date:   Fri, 25 Nov 2022 12:11:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 15/24] drm/vc4: Add TXP encoder type
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
 <20221123-rpi-kunit-tests-v1-15-051a0bb60a16@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v1-15-051a0bb60a16@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/23/22 16:25, Maxime Ripard wrote:
> The TXP is integrated as a separate CRTC/Encoder/Connector combo, but
> for some reason doesn't rely on the vc4_encoder type and it's associated
> type.
> 
> Let's create a type to make it consistent with the other encoders.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

