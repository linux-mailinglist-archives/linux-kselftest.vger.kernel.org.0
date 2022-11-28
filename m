Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2009363B246
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 20:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiK1TbS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 14:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiK1TbR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 14:31:17 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD842CC85;
        Mon, 28 Nov 2022 11:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=79D1N/wvlSFl18BNsKU0k/is/jrD25t41qoW9u3UtNQ=; b=QYDjpAPHhLoF6BlYY/NN/zcF72
        FetOordi88yKv+vvVBN5IdCIWm8y6lE5krrM28WdRwivYaIvy1nvRVdf801nGkEA8sBAmv83H1/LI
        HOzFGfTkz7jkUHeTUx7KAHWhKyPUv4Cc+4t02ITyJlRKeF49A3vCVsFs4FJtX6xyZTbrToOuF4TtQ
        KT35xJLL+dcnCungBjAXZk+yxgX0ic3rDnT0XWLE56wnO0v73HcrBbFAcR0SEdGg/zBcwH2yuTDho
        2vs7/Wuf1cE6b56WFrBYOr4cruTInuSO52wu5oHjKop41y4S4aa9l/SCj8ydRB1XFGCS4ds3xW3eP
        DoEXCVUg==;
Received: from [177.34.169.227] (helo=[192.168.0.8])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ozjq1-00AbB7-Eo; Mon, 28 Nov 2022 20:30:45 +0100
Message-ID: <264ee4eb-4385-d9b2-bcfa-fcc5dc27f611@igalia.com>
Date:   Mon, 28 Nov 2022 16:30:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 02/17] drm/tests: helpers: Document
 drm_kunit_device_init()
To:     Maxime Ripard <maxime@cerno.tech>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-media@vger.kernel.org
References: <20221123-rpi-kunit-tests-v2-0-efe5ed518b63@cerno.tech>
 <20221123-rpi-kunit-tests-v2-2-efe5ed518b63@cerno.tech>
Content-Language: en-US
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20221123-rpi-kunit-tests-v2-2-efe5ed518b63@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/28/22 11:53, Maxime Ripard wrote:
> Commit 44a3928324e9 ("drm/tests: Add Kunit Helpers") introduced the
> drm_kunit_device_init() function but didn't document it properly. Add
> that documentation.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Just a minor nit on naming, besides that:

Reviewed-by: Maíra Canal <mcanal@igalia.com>

> ---
>  drivers/gpu/drm/tests/drm_kunit_helpers.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> index 6600a4db3158..46a68c2fd80c 100644
> --- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
> +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> @@ -35,6 +35,23 @@ static void dev_free(struct kunit_resource *res)
>  	root_device_unregister(dev);
>  }
>  
> +/**
> + * drm_kunit_device_init - Allocates a mock DRM device for Kunit tests

s/Kunit/KUnit

Best Regards,
- Maíra Canal

> + * @test: The test context object
> + * @features: Mocked DRM device driver features
> + * @name: Name of the struct &device to allocate
> + *
> + * This function allocates a new struct &device, creates a struct
> + * &drm_driver and will create a struct &drm_device using both.
> + *
> + * The device and driver are tied to the @test context and will get
> + * cleaned at the end of the test. The drm_device is allocated through
> + * devm_drm_dev_alloc() and will thus be freed through a device-managed
> + * resource.
> + *
> + * Returns:
> + * A pointer to the new drm_device, or an ERR_PTR() otherwise.
> + */
>  struct drm_device *drm_kunit_device_init(struct kunit *test, u32 features, char *name)
>  {
>  	struct kunit_dev *kdev;
> 
