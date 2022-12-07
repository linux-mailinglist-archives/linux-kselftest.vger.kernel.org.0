Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DAC645BB1
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 14:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiLGN7n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 08:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiLGN73 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 08:59:29 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572CE2BC1;
        Wed,  7 Dec 2022 05:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LMJS/qAka/Cvh0b97juo1H1YIqM1nYXExoWNXinOmoo=; b=nxwN0zHBe/XLlLov/zn/k1DN4R
        qq+vI7iNhllUUMjpsmMzLpViVP+ReDZ2hMHA2e2Ua9kUShAmBjuHOmvCUJbH/1HX7m4nzgy1Fj/Bj
        MerCjl49iPlF+l5piqGBOZ4wAGJj7pczwZ872zxD0b76SMAlCffjuEipUEIInXywJxeHRByBcVMiO
        GeyMc4JIJrEcSCsS10t/iwdzSzJjxmQGJvUhXC0tAyEoM2vQzksjSz77fHiK9Kk0JG0zbdv3om+Az
        lvKwLKVIWiQrey1fewqPfXe/XYdOoi3WbcTcrQGCtdbOm2eNbTeEsNRmtXTm7ile2IFjsx/OcLQAJ
        POJalxCQ==;
Received: from [143.107.182.242] (helo=[10.41.75.14])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1p2ux9-00GbZp-Mg; Wed, 07 Dec 2022 14:59:16 +0100
Message-ID: <04478451-4237-1aec-7edd-85049c96d7d5@igalia.com>
Date:   Wed, 7 Dec 2022 10:59:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 04/20] drm/tests: helpers: Switch to EXPORT_SYMBOL_GPL
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>
Cc:     David Gow <davidgow@google.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-media@vger.kernel.org
References: <20221123-rpi-kunit-tests-v3-0-4615a663a84a@cerno.tech>
 <20221123-rpi-kunit-tests-v3-4-4615a663a84a@cerno.tech>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20221123-rpi-kunit-tests-v3-4-4615a663a84a@cerno.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/1/22 12:11, Maxime Ripard wrote:
> drm_kunit_device_init() among other things will allocate a device and
> wrap around root_device_register. This function is exported with
> EXPORT_SYMBOL_GPL, so we can't really change the license.
> 
> Fixes: 199557fab925 ("drm/tests: helpers: Add missing export")
> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra Canal

> ---
>   drivers/gpu/drm/tests/drm_kunit_helpers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> index 9ed3cfc2ac03..4fe131141718 100644
> --- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
> +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> @@ -82,7 +82,7 @@ struct drm_device *drm_kunit_device_init(struct kunit *test, u32 features, char
>   
>   	return drm;
>   }
> -EXPORT_SYMBOL(drm_kunit_device_init);
> +EXPORT_SYMBOL_GPL(drm_kunit_device_init);
>   
>   MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
>   MODULE_LICENSE("GPL");
> 
