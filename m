Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67427638828
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 12:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiKYLDE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 06:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiKYLDD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 06:03:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA054B990
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 03:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669374117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TfA9A7l0JYE/L8ETH4uO/o+2VqeJpw2uLOXbWd1Oacg=;
        b=RYF5ajSd17NP2QCq0u0G1BHrNoKXMY9bLk046xPAznEs0hZv44MD9g9zLO18F31bxrTLKk
        FxJ5sqSYgB0x9/RjRQO5E/+UFe5Iybra9G6COKCOP686MeuLG7ooPFHE6eAGqFDRfV4//7
        +yqLUIj4d2ztA1JS/D6DgC/RF24D1Fg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-522-46aaLZEdNmiZxzJ2io3rrA-1; Fri, 25 Nov 2022 06:01:53 -0500
X-MC-Unique: 46aaLZEdNmiZxzJ2io3rrA-1
Received: by mail-wm1-f69.google.com with SMTP id m34-20020a05600c3b2200b003cf549cb32bso4049519wms.1
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 03:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfA9A7l0JYE/L8ETH4uO/o+2VqeJpw2uLOXbWd1Oacg=;
        b=21gzlr8wHtm+H4xT48iLFE7TQqIJb6dkNYRWXcqHuNSN6bM/IfSy336wT2+/Ble7Xz
         RzYwGZ+LQbNneMn5DpnwNPls7vQMYe8l5N3IVtaxXc+LEVPvYDf+fw9LtZ5bU6lD1xi2
         rdPsfRcz5GJMnnKmHL+XsZWINKEdsowpqYZopGpCLjYy7zihIK0pUXmTBglPwY1NX/1l
         r6Jr4qpNsAonCJajLAbEyCmw4LDp3gXN5LXPzJ+oLy+PpDkyRIGIsgwT1eUz4QerP9l/
         B7DE2pOGQuVMUA4Ud/bnJmShfXFCpTe91lePx7CRGWFZyUFNu+P66jB9+tTbwMY2ftht
         +D2w==
X-Gm-Message-State: ANoB5pkXJqnHfZ1ifs+uHn0V9Ket5zKpEUs2Ft6xgu2chE1X6zIu8blK
        aqbgtkHQhdzJDuu5ecTrivkdddlmBgcnEMFdzhuSBvRswN7mDhw4Hr2yc18O6e8uBN9u6VaXrFZ
        qro2sSRKLPK5KRK9juyy7P4dn3dBj
X-Received: by 2002:a7b:c456:0:b0:3a5:f600:502e with SMTP id l22-20020a7bc456000000b003a5f600502emr18311884wmi.39.1669374111319;
        Fri, 25 Nov 2022 03:01:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf54zF2uRxU4RbTU39UVEvJ1RZet14YgzdlvBFjd7gpCV0KEEizmQ7IkJumuXXzHwnc2Bml0/Q==
X-Received: by 2002:a7b:c456:0:b0:3a5:f600:502e with SMTP id l22-20020a7bc456000000b003a5f600502emr18311846wmi.39.1669374111092;
        Fri, 25 Nov 2022 03:01:51 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c35cb00b003a84375d0d1sm9723651wmq.44.2022.11.25.03.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 03:01:50 -0800 (PST)
Message-ID: <8df31d1d-1ed9-eb6e-80bd-1f82adfb0185@redhat.com>
Date:   Fri, 25 Nov 2022 12:01:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 11/24] drm/vc4: Constify container_of wrappers
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
 <20221123-rpi-kunit-tests-v1-11-051a0bb60a16@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v1-11-051a0bb60a16@cerno.tech>
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
> None of our wrappers around container_of to access our objects from the
> DRM object pointer actually modify the latter.
> 
> Let's make them const.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

