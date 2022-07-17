Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167585777E1
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Jul 2022 21:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiGQTM0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 17 Jul 2022 15:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGQTMZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 17 Jul 2022 15:12:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA782615B;
        Sun, 17 Jul 2022 12:12:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso10719457pjk.3;
        Sun, 17 Jul 2022 12:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vd4RXeTOy0VCuvAN3yoH7JTxP0Cym7SXxM02BMLPeF8=;
        b=L+G+S+P1ytZ54S7XChoqfsGVVoKFXlRCX6M6xnZLg6bmEVdYppWSa5XjDcPLob0zaD
         qTltledq5GwicXbJvpaf96iVpFrY5mby4KyNInbrYHIGXOfJLUqBo+ylsbSW5hCbg7kv
         z4m2UvKRa5sIR2YuKdqj7tdPxXucyMt2lmOLuKDHgWLWvQbos/5JhzEHESqdnL0hNjQU
         YtI2nLsOR/oHpRRhWmK4uaKnZjUscW0kMurSHlUaFebRzCYPqBlb7gJy2+CIc/ieHrO/
         cJ4O+AErk2IL/eExWvGhyvmwSsW0I39mKoqeDL36kiELSCpGOeQX8G4THbk7SBwTJFhE
         z52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vd4RXeTOy0VCuvAN3yoH7JTxP0Cym7SXxM02BMLPeF8=;
        b=E30aPZ+g/RaYXVKwI783OXdH2nU3J8gu1N3GxOeyZ/GsTwR5AOOCRI7Znt1+24uTNN
         0GACVq0wtCLK2xAz5nlUcRSam1SmqdSiAGs7tXR4b2DrTfCYYP+MqbncuIIiY1bgRLL7
         jh93pIqHJYkE7QQJKjZhTL7AKPxaOzuAi8aIjeKBFiYNGjaykd0SDhqeBW2o6fy8GSDj
         KbsrxP0LRpy+mVmGh1OrNtueIYYBU4oHLNJ+EsaOEtSuHz4nd7B7qfmKiC9mdE9MiZ9I
         VAK5sqqiLRR2Tydxe+MejEor3ARIwXcd9ilvDVgEhRRcGpUU1xKV7jKWtUvbfYqGe6P4
         7wxA==
X-Gm-Message-State: AJIora97OObIRhsJ4YtS12WIQiWa+2Egt4s+hUU24fRn7Wg7BRP13SD6
        sKXxEckhHHkre4CAn1cDZ0U=
X-Google-Smtp-Source: AGRyM1tKzF5spR+ad/2Fzzlrd80dKgB/zJ4SxJod+jViIfAfNENBZZnWyb43iI70Qp7ZSdO+iGHMgg==
X-Received: by 2002:a17:90b:4f91:b0:1cd:3a73:3a5d with SMTP id qe17-20020a17090b4f9100b001cd3a733a5dmr27906645pjb.98.1658085144358;
        Sun, 17 Jul 2022 12:12:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id oa12-20020a17090b1bcc00b001ef8de342b8sm7677799pjb.15.2022.07.17.12.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 12:12:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ce0c16d0-6c4c-6569-a254-14ae0904b4c7@roeck-us.net>
Date:   Sun, 17 Jul 2022 12:12:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/tests: Split up test cases in
 igt_check_drm_format_min_pitch
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20220717184336.1197723-1-mairacanal@riseup.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220717184336.1197723-1-mairacanal@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/17/22 11:43, Maíra Canal wrote:
> The igt_check_drm_format_min_pitch() function had a lot of
> KUNIT_EXPECT_* calls, all of which ended up allocating and initializing
> various test assertion structures on the stack.
> 
> This behavior was producing -Wframe-larger-than warnings on PowerPC, i386,
> and MIPS architectures, such as:
> 
> drivers/gpu/drm/tests/drm_format_test.c: In function 'igt_check_drm_format_min_pitch':
> drivers/gpu/drm/tests/drm_format_test.c:271:1: error: the frame size of
> 3712 bytes is larger than 2048 bytes
> 
> So, the igt_check_drm_format_min_pitch() test case was split into three
> smaller functions: one testing single plane formats, one testing multiple
> planes formats, and the other testing tiled formats.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Maíra Canal <mairacanal@riseup.net>

I applied the patch to next-20220714 (the fixed file is gone
in next-20220715) and tested with i386, ppc, and mips compilers.
The problem is no longer seen after this patch is applied.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>   drivers/gpu/drm/tests/drm_format_test.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_format_test.c b/drivers/gpu/drm/tests/drm_format_test.c
> index 056cb8599d6d..28f2b8f88818 100644
> --- a/drivers/gpu/drm/tests/drm_format_test.c
> +++ b/drivers/gpu/drm/tests/drm_format_test.c
> @@ -91,7 +91,7 @@ static void igt_check_drm_format_block_height(struct kunit *test)
>   	KUNIT_EXPECT_FALSE(test, drm_format_info_block_height(info, -1));
>   }
>   
> -static void igt_check_drm_format_min_pitch(struct kunit *test)
> +static void igt_check_drm_format_min_pitch_for_single_plane(struct kunit *test)
>   {
>   	const struct drm_format_info *info = NULL;
>   
> @@ -175,6 +175,11 @@ static void igt_check_drm_format_min_pitch(struct kunit *test)
>   			(uint64_t)UINT_MAX * 4);
>   	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, (UINT_MAX - 1)),
>   			(uint64_t)(UINT_MAX - 1) * 4);
> +}
> +
> +static void igt_check_drm_format_min_pitch_for_multiple_planes(struct kunit *test)
> +{
> +	const struct drm_format_info *info = NULL;
>   
>   	/* Test 2 planes format */
>   	info = drm_format_info(DRM_FORMAT_NV12);
> @@ -249,6 +254,11 @@ static void igt_check_drm_format_min_pitch(struct kunit *test)
>   			(uint64_t)(UINT_MAX - 1) / 2);
>   	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, (UINT_MAX - 1) / 2),
>   			(uint64_t)(UINT_MAX - 1) / 2);
> +}
> +
> +static void igt_check_drm_format_min_pitch_for_tiled_format(struct kunit *test)
> +{
> +	const struct drm_format_info *info = NULL;
>   
>   	/* Test tiled format */
>   	info = drm_format_info(DRM_FORMAT_X0L2);
> @@ -273,7 +283,9 @@ static void igt_check_drm_format_min_pitch(struct kunit *test)
>   static struct kunit_case drm_format_tests[] = {
>   	KUNIT_CASE(igt_check_drm_format_block_width),
>   	KUNIT_CASE(igt_check_drm_format_block_height),
> -	KUNIT_CASE(igt_check_drm_format_min_pitch),
> +	KUNIT_CASE(igt_check_drm_format_min_pitch_for_single_plane),
> +	KUNIT_CASE(igt_check_drm_format_min_pitch_for_multiple_planes),
> +	KUNIT_CASE(igt_check_drm_format_min_pitch_for_tiled_format),
>   	{ }
>   };
>   

