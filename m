Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A3E63D2DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 11:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbiK3KLK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 05:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbiK3KLH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 05:11:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F86D2B24B
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 02:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669803003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NoPdGdP1XN2IHlWy3xzG7ljlYAvy6qLxs9MsnW+HAEQ=;
        b=ZlZdyiD78BGnR/7hjwAEKvQuX3EWxeCxZAEK1un/gXLY11oC2oLzTipH7O2gQvjAkNXSfl
        VWCLswQXrsJ0DeE4uElLYmxNPYlFjF7gMIja7EsP/eBVb8zgPxM2525nGISImPvjh3nbLQ
        xTmuQ3MdMBKlw/dgan7AxN2Yc7Qd600=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-390-SSj_R-C-Na2GQt5tzWF4zw-1; Wed, 30 Nov 2022 05:10:02 -0500
X-MC-Unique: SSj_R-C-Na2GQt5tzWF4zw-1
Received: by mail-wm1-f72.google.com with SMTP id o5-20020a05600c510500b003cfca1a327fso9171617wms.8
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 02:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NoPdGdP1XN2IHlWy3xzG7ljlYAvy6qLxs9MsnW+HAEQ=;
        b=6g1aQq/0dtjKDGuB5oDXs/aMO0dkjY+jA9y9sa8okQv72XwCuxFdIZOTMFkMG+a8Ob
         SNKvP90ThgwBjfkNnervRGnHEUA3wKIn4TGDTH6fRidBcUzEOpLjc+2xh2mjlbk+RhMa
         S2e9jgp1+F4AGxHpTvJT8KMU0EjtcjwFFr3mc3vSLDXrCZ28xXu/uMByASDzf1NFTnWr
         0FcWUyVtv1geXzWCwJDfv6LHXYkLhiYe5Uaeoj7GsE0LID3EXZp528xm0ViUkaZ9nKG1
         zNedq59rRREUxFcyj5g2XzRmRKpYKOz5OsKxW7dzcx0AuSjB4H0iexCA6UoC57h+O1l2
         jTCw==
X-Gm-Message-State: ANoB5pkwQ1nYFqaS3ib/VpmERGUAVjEPAqjb9Im/KkUlSFg4TVCy+Fv/
        jex9OpQFvQBGoG1c4jqkis8hf4Mo9pYOU5+Lb3UcgqoMGrhIipG2ZnHd8ZNfkm8fb2Q4d15NYad
        al8/aiDnc1T3fTu4HUC0YVTtCe38h
X-Received: by 2002:a5d:504d:0:b0:242:246c:2f89 with SMTP id h13-20020a5d504d000000b00242246c2f89mr3758401wrt.108.1669803000957;
        Wed, 30 Nov 2022 02:10:00 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5FkWQT/k1GHgrsZnt54cNcc31t/15SG2tVARml33QGcmHm1VSq1hvfrPDi51V6Qbq5abMc4Q==
X-Received: by 2002:a5d:504d:0:b0:242:246c:2f89 with SMTP id h13-20020a5d504d000000b00242246c2f89mr3758377wrt.108.1669803000781;
        Wed, 30 Nov 2022 02:10:00 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b18-20020a5d5512000000b0023c8026841csm514653wrv.23.2022.11.30.02.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 02:10:00 -0800 (PST)
Message-ID: <31351d94-91ba-b0fe-cb20-3dcc8254fb66@redhat.com>
Date:   Wed, 30 Nov 2022 11:09:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 16/17] drm/vc4: tests: Fail the current test if we
 access a register
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
 <20221123-rpi-kunit-tests-v2-16-efe5ed518b63@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v2-16-efe5ed518b63@cerno.tech>
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
> Accessing a register when running under kunit is a bad idea since our
> device is completely mocked.
> 
> Fail the current test if we ever access any of our hardware registers.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

[...]

> -#define CRTC_WRITE(offset, val) writel(val, vc4_crtc->regs + (offset))
> -#define CRTC_READ(offset) readl(vc4_crtc->regs + (offset))
> +#define CRTC_WRITE(offset, val)								\
> +	do {										\
> +		kunit_fail_current_test("Accessing a register in a unit test!\n");	\
> +		writel(val, vc4_crtc->regs + (offset));					\
> +	} while (0)
> +
> +#define CRTC_READ(offset)								\
> +	({										\
> +		kunit_fail_current_test("Accessing a register in a unit test!\n");	\
> +		readl(vc4_crtc->regs + (offset));					\
> +	})
> 

Should this be made conditional on whether DRM_VC4_KUNIT_TEST is enabled ? 

That is, just define the simpler macros when is disabled? The kunit_fail_current_test()
is just a no-op if CONFIG_KUNIT isn't enabled, but I think my question still stands.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

