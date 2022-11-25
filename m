Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58F363883B
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 12:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiKYLFs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 06:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKYLFr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 06:05:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531B84D5C7
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 03:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669374289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EIsNFOFnhjxNTgJU/2vZA8CiSz+sEWLC1ebQetbQ8TI=;
        b=J0htrsI1iMMNBauhUT0okw92P+dAo8l747W15LzbGnsKa5o8mG9ZkrJU1cpQIZJvDmfVGy
        bayY9gZ8m0YWbtykscUEstjzE7kQJ4P2SFc6hrcEUSzHGNmGQMBEHb6eFPlaZx1Xlnbr2I
        bTb0YfV08XcC2LVc/cBAPYn3ISbTW6k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-575-EQnGUcJhPuCLGbnyGK8bTQ-1; Fri, 25 Nov 2022 06:04:48 -0500
X-MC-Unique: EQnGUcJhPuCLGbnyGK8bTQ-1
Received: by mail-wm1-f69.google.com with SMTP id u9-20020a05600c00c900b003cfb12839d6so1679881wmm.5
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 03:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIsNFOFnhjxNTgJU/2vZA8CiSz+sEWLC1ebQetbQ8TI=;
        b=uSJG9512moruGWMOd3QMZ6yDzgkRoDhXGWjIyZJ/2wNxjfKtAZUi4ch1XK5a37woRe
         6BNIn2gO3qh7hLaibc9fqnxlvo9fLhQxi3BC7TYxc1rpoIVRAU8T87H1U+O/uzh9soBH
         9wBlS9OEyDj7Zonz6DHNtSAyJHmmurKep8IR1Ag+y8kp5TIWATe/a0+mKVPSFq0VE5nz
         M/NdbyMDhoBBANC+nQ+uJvDkDRU3SuRsFcZEq87+Xthm6wQR2CZd3XxEVXMIydC6XYrL
         yoCMGk/ZKaejvea5uJ0ZsS4RpdoOorOA5VZkPvJqSLlUAY3ZPYekwB4mfb2br4y2sb06
         Ez0g==
X-Gm-Message-State: ANoB5pnVB3mbvc92XriWMpaBVYkQ7hBMXVn4a+xQo8Se1dPaksG9NK9h
        1M3fyv0TdM6my+36fs6sISMgUIKZzbdwC7hcDColltrk0qQA/OL5YT8Uu3ygjxuyc1c4WyfcZkk
        9NkAOtVZxYcMWEika2wL18+NnoLXI
X-Received: by 2002:adf:f6d1:0:b0:241:e2af:444f with SMTP id y17-20020adff6d1000000b00241e2af444fmr10706112wrp.676.1669374287048;
        Fri, 25 Nov 2022 03:04:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4ai6UB7oIeeI+sRTVyelphEoAhUUiZPfWL2SD5YRQotSiu7iQrCPjltzySG4CbRwXoVo/zjA==
X-Received: by 2002:adf:f6d1:0:b0:241:e2af:444f with SMTP id y17-20020adff6d1000000b00241e2af444fmr10706084wrp.676.1669374286732;
        Fri, 25 Nov 2022 03:04:46 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003c6f3e5ba42sm10164544wmg.46.2022.11.25.03.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 03:04:45 -0800 (PST)
Message-ID: <d5451d30-be68-c492-6ec8-41681db400e2@redhat.com>
Date:   Fri, 25 Nov 2022 12:04:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 12/24] drm/vc4: Move HVS state to main header
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
 <20221123-rpi-kunit-tests-v1-12-051a0bb60a16@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v1-12-051a0bb60a16@cerno.tech>
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
> In order to introduce unit tests for the HVS state computation, we'll
> need access to the vc4_hvs_state struct definition and its associated
> helpers.
> 
> Let's move them in our driver header.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

