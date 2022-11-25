Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42EF63885F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 12:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiKYLNS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 06:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiKYLNM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 06:13:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E364D5F5
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 03:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669374733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2lxU1Rbb/abSsZvZ6c7uR6nOCdyrA7Yjf5rgzN1ey7M=;
        b=bIq0/wW3cfbmomHWU9rrPZfNhhlkaJIaN6MZJCmhg/tgvmE67hBwwekCSsAnMut+QbvgyF
        1uu6P13/QUUNeFseULuvYtYj3f8pjCiLjGcwFcgryZkTZYFX/IRhsTVC1jSAyFYUVKv2bo
        mah7Zn23yEeWEaCf9GzIjtCDb1NmGTc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-RB2HdcgpP4ej4Ul67wIF4w-1; Fri, 25 Nov 2022 06:12:12 -0500
X-MC-Unique: RB2HdcgpP4ej4Ul67wIF4w-1
Received: by mail-wm1-f72.google.com with SMTP id l32-20020a05600c1d2000b003cfefa531c9so3948285wms.0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 03:12:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lxU1Rbb/abSsZvZ6c7uR6nOCdyrA7Yjf5rgzN1ey7M=;
        b=KHzsAmKALY0BuqyhqRmrI3OfvIWQfeVSmoio+nBK7fE3aDDFHidn9OyPm+pdSY64kD
         gqXQTke5neydDAGQ8EJ7qQga48GS9rotlsAYDmqKUt40R7IEYFuCTNGzPIm91CS3w6IC
         BZIydcfjU4QGEtV6hNx4M9lvugnw/O8lhRYyU1NCwsmncVPbSIcR8fOLEjm3c6XOsauN
         EEj8srTBTENmubsJuaPmQiLUdGKJZX+8IJ/XhkY15kwLMQZvmV4umvWfEPkEDAkU3D6z
         Lx4783gEdShvBawny4w5rqYWsAIj48Nt/pe6l7woJgaejOpKhE18ic6gSQ2M5fe+6g2Y
         rALg==
X-Gm-Message-State: ANoB5pmJO2eOLcXYQRdPH5iRrum/zACSBCOd958CsOBX542JoxTWZjAo
        8J8RnWyIMpjpRTwlXNWCJUtf1Ul8Koz7eFPj18Q16/QU59HXuFBol7RVB1e2LYP5zQJ38EM0M4I
        kiUo4ttsvzVpTLARyNnNl4JDswzfT
X-Received: by 2002:a05:6000:1c0e:b0:241:e4d1:d192 with SMTP id ba14-20020a0560001c0e00b00241e4d1d192mr10209322wrb.534.1669374731092;
        Fri, 25 Nov 2022 03:12:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7p1vj0N8iVuX9+tqZWhKZmYo4t7Jz83x2SXNSaxC/wK47BdRJZAm4d8wEODTWCBcg4oGQSAA==
X-Received: by 2002:a05:6000:1c0e:b0:241:e4d1:d192 with SMTP id ba14-20020a0560001c0e00b00241e4d1d192mr10209298wrb.534.1669374730903;
        Fri, 25 Nov 2022 03:12:10 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id hg27-20020a05600c539b00b003a3170a7af9sm5141530wmb.4.2022.11.25.03.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 03:12:10 -0800 (PST)
Message-ID: <c7995e42-7802-a432-7ff5-412b4f3d0cc3@redhat.com>
Date:   Fri, 25 Nov 2022 12:12:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 16/24] drm/vc4: txp: Initialise the CRTC before the
 encoder and connector
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
 <20221123-rpi-kunit-tests-v1-16-051a0bb60a16@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v1-16-051a0bb60a16@cerno.tech>
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
> It makes more sense to register the CRTC before the encoder and
> connectors, so let's move our call around.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

