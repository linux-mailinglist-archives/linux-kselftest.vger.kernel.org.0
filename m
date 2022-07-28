Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D898584082
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Jul 2022 16:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiG1ODw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Jul 2022 10:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiG1ODu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Jul 2022 10:03:50 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADC3419B2
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jul 2022 07:03:49 -0700 (PDT)
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mx0.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Ltsnd1bG9zDrtL
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jul 2022 14:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659017029; bh=MTS6lwR1cUaStcsOm8OlR/Y0V2O6MFV0lRwyDK+j76E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OAu+6df7H+kVosjwB7/NxyzXmEo2G48i+nIYM0XAZMGuSxGkfa/6T0eLrm8F6Puek
         4WdA+yvRP+kTBZViD9F0fLCDMGGlD7H7lBqLk/Ds813heQTOqjgAIbxc9Ov9P4bVkd
         0ATLnNmF6jdiLeUJ8QMgtHYZeFiz519X5dU1Y4pI=
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4LtsnZ2QDQz9svC;
        Thu, 28 Jul 2022 14:03:46 +0000 (UTC)
X-Riseup-User-ID: A4C3B34712D439ADA01C6FA6C9FEF32D3ED7A0E63E5B56E59A8DD15BF3152E3A
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LtsnT01cxz5vh4;
        Thu, 28 Jul 2022 14:03:40 +0000 (UTC)
Message-ID: <4269b585-3373-99d4-dfae-5f207575f203@riseup.net>
Date:   Thu, 28 Jul 2022 11:03:38 -0300
MIME-Version: 1.0
Subject: Re: [PATCH] drm/tests: Split up test cases in
 igt_check_drm_format_min_pitch
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        brendanhiggins@google.com, Guenter Roeck <linux@roeck-us.net>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20220717184336.1197723-1-mairacanal@riseup.net>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@riseup.net>
In-Reply-To: <20220717184336.1197723-1-mairacanal@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Às 15:43 de 17/07/22, Maíra Canal escreveu:
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
> ---

Reviewed-by: André Almeida <andrealmeid@igalia.com>

>  drivers/gpu/drm/tests/drm_format_test.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_format_test.c b/drivers/gpu/drm/tests/drm_format_test.c
> index 056cb8599d6d..28f2b8f88818 100644
> --- a/drivers/gpu/drm/tests/drm_format_test.c
> +++ b/drivers/gpu/drm/tests/drm_format_test.c
> @@ -91,7 +91,7 @@ static void igt_check_drm_format_block_height(struct kunit *test)
>  	KUNIT_EXPECT_FALSE(test, drm_format_info_block_height(info, -1));
>  }
>  
> -static void igt_check_drm_format_min_pitch(struct kunit *test)
> +static void igt_check_drm_format_min_pitch_for_single_plane(struct kunit *test)
>  {
>  	const struct drm_format_info *info = NULL;
>  
> @@ -175,6 +175,11 @@ static void igt_check_drm_format_min_pitch(struct kunit *test)
>  			(uint64_t)UINT_MAX * 4);
>  	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, (UINT_MAX - 1)),
>  			(uint64_t)(UINT_MAX - 1) * 4);
> +}
> +
> +static void igt_check_drm_format_min_pitch_for_multiple_planes(struct kunit *test)

Minor nit: I think the wording is usually "multi-planar"

> +{
> +	const struct drm_format_info *info = NULL;
>  
>  	/* Test 2 planes format */
>  	info = drm_format_info(DRM_FORMAT_NV12);
> @@ -249,6 +254,11 @@ static void igt_check_drm_format_min_pitch(struct kunit *test)
>  			(uint64_t)(UINT_MAX - 1) / 2);
>  	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, (UINT_MAX - 1) / 2),
>  			(uint64_t)(UINT_MAX - 1) / 2);
> +}
> +
> +static void igt_check_drm_format_min_pitch_for_tiled_format(struct kunit *test)
> +{
> +	const struct drm_format_info *info = NULL;
>  
>  	/* Test tiled format */
>  	info = drm_format_info(DRM_FORMAT_X0L2);
> @@ -273,7 +283,9 @@ static void igt_check_drm_format_min_pitch(struct kunit *test)
>  static struct kunit_case drm_format_tests[] = {
>  	KUNIT_CASE(igt_check_drm_format_block_width),
>  	KUNIT_CASE(igt_check_drm_format_block_height),
> -	KUNIT_CASE(igt_check_drm_format_min_pitch),
> +	KUNIT_CASE(igt_check_drm_format_min_pitch_for_single_plane),
> +	KUNIT_CASE(igt_check_drm_format_min_pitch_for_multiple_planes),
> +	KUNIT_CASE(igt_check_drm_format_min_pitch_for_tiled_format),
>  	{ }
>  };
>  
