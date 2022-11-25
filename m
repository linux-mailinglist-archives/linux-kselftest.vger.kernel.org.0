Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93326385DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 10:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiKYJHf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 04:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiKYJHe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 04:07:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DDA2A721
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 01:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669367203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M7QTtRRbL7+Wq11xJkPqBXcSqP3SyIaC64ZZMRaftKc=;
        b=KtB3XnCGlV29khiUMh5RghpR89U+cVZYzqvojEyAKlDrE9aolrZwKrqqYumWYGUmAjLFi4
        uQfUiNINxkIDO69wTt7fkGUN2igmBOScWk9Mf9MLJuhB66IAQ4lAKQVCMlJIuTmQaDRsTa
        y1noFcxHMrpevm0T+Qu9QLsoagxILzE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-47-V_L-mldHM--iM3mdQSuwbQ-1; Fri, 25 Nov 2022 04:06:41 -0500
X-MC-Unique: V_L-mldHM--iM3mdQSuwbQ-1
Received: by mail-wr1-f71.google.com with SMTP id s1-20020adfa281000000b00241f7467851so713174wra.17
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 01:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7QTtRRbL7+Wq11xJkPqBXcSqP3SyIaC64ZZMRaftKc=;
        b=yGt5gPHURTSbMA9UjWXqPmaQ1o0egL7ARDUgPKBl2B508wZYuAsfSJye2qNc2vwdmI
         o2JtXhdeS0lHO17D98jAoiiedsA9QBy+Ca84uOGdUA+GR4ouvn5D0lkQTEtWb5WKC/lZ
         bDnUUFVK7iTOshkhDb/83DlSxS5i51B00SjHBEEvVonCBSL3mhWwFnvhgFNdeYej4ea6
         kG3sfHB7oux3q5zigGWcIbKFODvMlfsN7rlYdtVKBXUi5cyE0PWiO1jKQD8OR0qERi57
         krsZU+lHVYkD1GJL8wh5hybGKuA7HpFkBONIA8noLsDp4vpSBX9Dsp+UHvBz+dYItqYR
         8ZAQ==
X-Gm-Message-State: ANoB5pn8opMgEa7KA/InV0cO/sT27qRivhdLED0eLmYa+fEey7iIy5hZ
        TbGpAU0JqytoandidEIxVkxVuZ0iwc4IIN1FxiNIx6ec50xYv0EGgbeWxNNZGMhM9BSHgeAHyAk
        CXsPsr+4EKwYgpXoaBzwv8S9w/GYC
X-Received: by 2002:adf:e305:0:b0:236:6089:cc5e with SMTP id b5-20020adfe305000000b002366089cc5emr13634720wrj.118.1669367200525;
        Fri, 25 Nov 2022 01:06:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5a4/3UUdnTCVdtjBQVAGdYcgL9eE9W0y2TcH3nZQvBy0bZE1SSPYRFB9nYPNcK7okvPIxpQA==
X-Received: by 2002:adf:e305:0:b0:236:6089:cc5e with SMTP id b5-20020adfe305000000b002366089cc5emr13634702wrj.118.1669367200332;
        Fri, 25 Nov 2022 01:06:40 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j8-20020adff548000000b002367ad808a9sm3235859wrp.30.2022.11.25.01.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 01:06:38 -0800 (PST)
Message-ID: <d5df9a73-c093-3584-31f4-e2f4f7bd9272@redhat.com>
Date:   Fri, 25 Nov 2022 10:06:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 03/24] drm/tests: helpers: Create the device in another
 function
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
 <20221123-rpi-kunit-tests-v1-3-051a0bb60a16@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v1-3-051a0bb60a16@cerno.tech>
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
> We'll need in some tests to control when the device needs to be added
> and removed, so let's split the device creation from the DRM device
> creation function.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

[...]

> -static int dev_init(struct kunit_resource *res, void *ptr)
> +struct device *drm_kunit_helper_alloc_device(struct kunit *test)
>  {
> -	char *name = ptr;
> -	struct device *dev;
> -
> -	dev = root_device_register(name);
> -	if (IS_ERR(dev))
> -		return PTR_ERR(dev);
> -
> -	res->data = dev;
> -	return 0;
> +	return root_device_register(FAKE_DEVICE_NAME);

I was going to ask if a platform device could be used here, to prevent the
issue you mentioned the other day of root_device not having a bus set. But
I see now that you are doing that change in the next patch.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

