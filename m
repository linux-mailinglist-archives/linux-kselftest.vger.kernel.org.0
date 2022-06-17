Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A5955003E
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Jun 2022 00:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbiFQW6h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jun 2022 18:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382328AbiFQW62 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jun 2022 18:58:28 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A8759964
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jun 2022 15:58:26 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-fe32122311so7221033fac.7
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jun 2022 15:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R4/YymOiBCiP7pRBgeCWzpKxz/9eOAV7dAUiqD1JUjY=;
        b=DmzTxErOVav/dRszUwcrusPd7A4R+qm8ldGcUp1+pFfVukOpDDp/X8Lk7zeQyR7C7N
         xImXAG919zVrk6W4NouIoNR52XKYKlTNJDv5oCSu+eThS2r4hi6h39rdQh7ZhTPTZlTD
         RtHGbYFuE/+GjJiA2Yre7IQnZkD7QrK0BSKtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R4/YymOiBCiP7pRBgeCWzpKxz/9eOAV7dAUiqD1JUjY=;
        b=AqGkvnuULH7CU53IiLpfHBrkAb95Ucd7acwPRmdJc4c07Hb3LTvCZOxUbL5RPzpeWu
         jn6XRlojztAufaMhJeRxqRnCrajvA7KzoamFwt3Shb9B5MZM5j4nbGw1TC3ttEsVE+tv
         OOn3llj/w62iUu4LPIksRyQAIQr0G9gy81KxzzAFqKk32upKHPJotuUPxuds9AO9Jmfo
         ddz0NKfZf8SA8l4DgbN/WCZ45HR7lyn83n9L55f2mABIHaUbCtPUtWLmVT+VmMV1WJpJ
         T6m+aUNYkyjTvb6OBr1I9I1NTm3mn/F2Y3hVzT5U8mQWjzWej/ab1ygNzVPel+xbLf3e
         1FnQ==
X-Gm-Message-State: AJIora95K53zNMMIchzkB/z2Wrjzm7Q6kZPHErj18e4UqePYKNL7Z3pp
        c3Lk29GN3SKz4bM+yN70erDboQ==
X-Google-Smtp-Source: AGRyM1sQ/n2RC2qzDChncC4XsnOlokBakgGI4B8icrGSAdLLtMfO9JEdkj6qdz7evG/85YuhvRK6Og==
X-Received: by 2002:a05:6871:7a1:b0:101:21cb:7080 with SMTP id o33-20020a05687107a100b0010121cb7080mr12390808oap.216.1655506705103;
        Fri, 17 Jun 2022 15:58:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id w16-20020a9d5a90000000b0060603221280sm3241479oth.80.2022.06.17.15.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 15:58:24 -0700 (PDT)
Subject: Re: [PATCH 02/10] drm: selftest: refactor drm_cmdline_parser
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com
Cc:     dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        Arthur Grillo <arthur.grillo@usp.br>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220615135824.15522-1-maira.canal@usp.br>
 <20220615135824.15522-3-maira.canal@usp.br>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <350cf07e-297d-0578-f139-35bf0a9c7a96@linuxfoundation.org>
Date:   Fri, 17 Jun 2022 16:58:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220615135824.15522-3-maira.canal@usp.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/15/22 7:58 AM, Maíra Canal wrote:
> From: Arthur Grillo <arthur.grillo@usp.br>
> 
> Refactor the tests by modularizing the functions to avoid code repetition.
> 

Tell me more about the refactor and how does it help. This patch seems
to combine refactor with some other formatting changes that aren't
necessary and making the code not easy to read.

Lot of code changes with no expalination on how and why this is being
refactored. Are these just refractor or are there any new tests being
added?

Please don't cobine formatting changes with refactoring. Also don't
break up the code into small chunks unless there is a good reason to
do so.

> Co-developed-by: Maíra Canal <maira.canal@usp.br>
> Signed-off-by: Arthur Grillo <arthur.grillo@usp.br>
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
> ---
>   .../drm/selftests/test-drm_cmdline_parser.c   | 579 +++++-------------
>   1 file changed, 156 insertions(+), 423 deletions(-)
> 
> diff --git a/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c b/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
> index d96cd890def6..57a229c5fc35 100644
> --- a/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
> +++ b/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
> @@ -1,6 +1,8 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (c) 2019 Bootlin
> + * Copyright (c) 2021 Ma�ra Canal <maira.canal@usp.br>,
> + * Copyright (c) 2021 Arthur Grillo <arthur.grillo@usp.br>
>    */
>   
>   #define pr_fmt(fmt) "drm_cmdline: " fmt
> @@ -17,13 +19,25 @@
>   
>   static const struct drm_connector no_connector = {};
>   
> -static int drm_cmdline_test_force_e_only(void *ignored)
> +static int drm_cmdline_test_properties(void *ignored,
> +		struct drm_cmdline_mode *mode, enum drm_connector_force force)
> +{
> +	FAIL_ON(mode->rb);
> +	FAIL_ON(mode->cvt);
> +	FAIL_ON(mode->interlace);
> +	FAIL_ON(mode->margins);
> +	FAIL_ON(mode->force != force);
> +
> +	return 0;
> +}
> +
> +static int drm_cmdline_test_force_only(void *ignored, char *cmdline,
> +		const struct drm_connector *connector, enum drm_connector_force force)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("e",
> -							   &no_connector,
> -							   &mode));
> +	FAIL_ON(!drm_mode_parse_command_line_for_connector(cmdline,
> +							   connector, &mode));

This change for example.

>   	FAIL_ON(mode.specified);
>   	FAIL_ON(mode.refresh_specified);
>   	FAIL_ON(mode.bpp_specified);
> @@ -32,95 +46,101 @@ static int drm_cmdline_test_force_e_only(void *ignored)
>   	FAIL_ON(mode.cvt);
>   	FAIL_ON(mode.interlace);
>   	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_ON);
> +	FAIL_ON(mode.force != force);
>   
>   	return 0;
>   }
>   
> -static int drm_cmdline_test_force_D_only_not_digital(void *ignored)
> +static int drm_cmdline_test_freestanding(void *ignored,
> +		struct drm_cmdline_mode *mode, char *cmdline,
> +		const struct drm_connector *connector)

These should be lined up with the first argument.

>   {
> -	struct drm_cmdline_mode mode = { };
> +	FAIL_ON(!drm_mode_parse_command_line_for_connector(cmdline,
> +							   connector, mode));
> +	FAIL_ON(mode->specified);
> +	FAIL_ON(mode->refresh_specified);
> +	FAIL_ON(mode->bpp_specified);
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("D",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(mode.specified);
> -	FAIL_ON(mode.refresh_specified);
> -	FAIL_ON(mode.bpp_specified);
> +	FAIL_ON(mode->tv_margins.right != 14);
> +	FAIL_ON(mode->tv_margins.left != 24);
> +	FAIL_ON(mode->tv_margins.bottom != 36);
> +	FAIL_ON(mode->tv_margins.top != 42);
>   

Whst are these constants for - please add defines for them with meaningful
names so it cna be maintained easily.

> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_ON);
> +	return 0;
> +}
> +
> +static int drm_cmdline_test_res_init(void *ignored,
> +		struct drm_cmdline_mode *mode, char *cmdline)
> +{
> +	FAIL_ON(!drm_mode_parse_command_line_for_connector(cmdline,
> +							   &no_connector, mode));
> +	FAIL_ON(!mode->specified);
> +	FAIL_ON(mode->xres != 720);
> +	FAIL_ON(mode->yres != 480);
> +
> +	return 0;
> +}
> +
> +static int drm_cmdline_test_res_bpp_init(void *ignored,
> +		struct drm_cmdline_mode *mode, char *cmdline)
> +{
> +	FAIL_ON(!drm_mode_parse_command_line_for_connector(cmdline,
> +							   &no_connector, mode));
> +	FAIL_ON(!mode->specified);
> +	FAIL_ON(mode->xres != 720);
> +	FAIL_ON(mode->yres != 480);
> +
> +	FAIL_ON(!mode->refresh_specified);
> +	FAIL_ON(mode->refresh != 60);
> +	FAIL_ON(!mode->bpp_specified);
> +	FAIL_ON(mode->bpp != 24);

Same here

> +
> +	return 0;
> +}
> +
> +static int drm_cmdline_test_force_e_only(void *ignored)
> +{
> +	drm_cmdline_test_force_only(ignored, "e", &no_connector, DRM_FORCE_ON);
> +
Get rid of the extra line.

> +	return 0;

Same comment here on a new routine. Let's not add new routines
> +}
> +
> +static int drm_cmdline_test_force_D_only_not_digital(void *ignored)
> +{
> +	drm_cmdline_test_force_only(ignored, "D", &no_connector, DRM_FORCE_ON);
>   
same here. What is the need to add a whole new routine for this.
It you really want to make this a marco.


>   	return 0;
>   }
>   
>   static const struct drm_connector connector_hdmi = {
>   	.connector_type	= DRM_MODE_CONNECTOR_HDMIB,
> +
>   };
>   
>   static int drm_cmdline_test_force_D_only_hdmi(void *ignored)
>   {
> -	struct drm_cmdline_mode mode = { };
> -
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("D",
> -							   &connector_hdmi,
> -							   &mode));
> -	FAIL_ON(mode.specified);
> -	FAIL_ON(mode.refresh_specified);
> -	FAIL_ON(mode.bpp_specified);
> -
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_ON_DIGITAL);
> +	drm_cmdline_test_force_only(ignored, "D", &connector_hdmi,
> +			DRM_FORCE_ON_DIGITAL);
>   
>   	return 0;
>   }
>   
>   static const struct drm_connector connector_dvi = {
>   	.connector_type	= DRM_MODE_CONNECTOR_DVII,
> +
>   };
>   
>   static int drm_cmdline_test_force_D_only_dvi(void *ignored)
>   {
> -	struct drm_cmdline_mode mode = { };
> -
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("D",
> -							   &connector_dvi,
> -							   &mode));
> -	FAIL_ON(mode.specified);
> -	FAIL_ON(mode.refresh_specified);
> -	FAIL_ON(mode.bpp_specified);
> -
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_ON_DIGITAL);
> +	drm_cmdline_test_force_only(ignored, "D", &connector_dvi,
> +			DRM_FORCE_ON_DIGITAL);
>   
>   	return 0;
>   }
>   
>   static int drm_cmdline_test_force_d_only(void *ignored)
>   {
> -	struct drm_cmdline_mode mode = { };
> -
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("d",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(mode.specified);
> -	FAIL_ON(mode.refresh_specified);
> -	FAIL_ON(mode.bpp_specified);
> -
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_OFF);
> +	drm_cmdline_test_force_only(ignored, "d", &no_connector, DRM_FORCE_OFF);
>   
>   	return 0;
>   }
> @@ -151,15 +171,9 @@ static int drm_cmdline_test_res(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> +	drm_cmdline_test_res_init(ignored, &mode, "720x480");
>   
>   	FAIL_ON(mode.refresh_specified);
> -
>   	FAIL_ON(mode.bpp_specified);
>   
>   	FAIL_ON(mode.rb);
> @@ -219,15 +233,9 @@ static int drm_cmdline_test_res_vesa(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480M",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> +	drm_cmdline_test_res_init(ignored, &mode, "720x480M");
>   
>   	FAIL_ON(mode.refresh_specified);
> -
>   	FAIL_ON(mode.bpp_specified);
>   
>   	FAIL_ON(mode.rb);
> @@ -243,15 +251,9 @@ static int drm_cmdline_test_res_vesa_rblank(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480MR",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> +	drm_cmdline_test_res_init(ignored, &mode, "720x480MR");
>   
>   	FAIL_ON(mode.refresh_specified);
> -
>   	FAIL_ON(mode.bpp_specified);
>   
>   	FAIL_ON(!mode.rb);
> @@ -267,15 +269,9 @@ static int drm_cmdline_test_res_rblank(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480R",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> +	drm_cmdline_test_res_init(ignored, &mode, "720x480R");
>   
>   	FAIL_ON(mode.refresh_specified);
> -
>   	FAIL_ON(mode.bpp_specified);
>   
>   	FAIL_ON(!mode.rb);
> @@ -291,23 +287,13 @@ static int drm_cmdline_test_res_bpp(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> +	drm_cmdline_test_res_init(ignored, &mode, "720x480-24");
>   
>   	FAIL_ON(mode.refresh_specified);
> -
>   	FAIL_ON(!mode.bpp_specified);
>   	FAIL_ON(mode.bpp != 24);
>   
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_UNSPECIFIED);
>   
>   	return 0;
>   }
> @@ -327,23 +313,13 @@ static int drm_cmdline_test_res_refresh(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480@60",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> +	drm_cmdline_test_res_init(ignored, &mode, "720x480@60");
>   
>   	FAIL_ON(!mode.refresh_specified);
>   	FAIL_ON(mode.refresh != 60);
> -
>   	FAIL_ON(mode.bpp_specified);
>   
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_UNSPECIFIED);
>   
>   	return 0;
>   }
> @@ -363,24 +339,8 @@ static int drm_cmdline_test_res_bpp_refresh(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> -
> -	FAIL_ON(!mode.refresh_specified);
> -	FAIL_ON(mode.refresh != 60);
> -
> -	FAIL_ON(!mode.bpp_specified);
> -	FAIL_ON(mode.bpp != 24);
> -
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
> +	drm_cmdline_test_res_bpp_init(ignored, &mode, "720x480-24@60");
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_UNSPECIFIED);
>   
>   	return 0;
>   }
> @@ -389,18 +349,7 @@ static int drm_cmdline_test_res_bpp_refresh_interlaced(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60i",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> -
> -	FAIL_ON(!mode.refresh_specified);
> -	FAIL_ON(mode.refresh != 60);
> -
> -	FAIL_ON(!mode.bpp_specified);
> -	FAIL_ON(mode.bpp != 24);
> +	drm_cmdline_test_res_bpp_init(ignored, &mode, "720x480-24@60i");
>   
>   	FAIL_ON(mode.rb);
>   	FAIL_ON(mode.cvt);
> @@ -415,18 +364,7 @@ static int drm_cmdline_test_res_bpp_refresh_margins(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60m",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> -
> -	FAIL_ON(!mode.refresh_specified);
> -	FAIL_ON(mode.refresh != 60);
> -
> -	FAIL_ON(!mode.bpp_specified);
> -	FAIL_ON(mode.bpp != 24);
> +	drm_cmdline_test_res_bpp_init(ignored, &mode, "720x480-24@60m");
>   
>   	FAIL_ON(mode.rb);
>   	FAIL_ON(mode.cvt);
> @@ -441,24 +379,8 @@ static int drm_cmdline_test_res_bpp_refresh_force_off(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60d",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> -
> -	FAIL_ON(!mode.refresh_specified);
> -	FAIL_ON(mode.refresh != 60);
> -
> -	FAIL_ON(!mode.bpp_specified);
> -	FAIL_ON(mode.bpp != 24);
> -
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_OFF);
> +	drm_cmdline_test_res_bpp_init(ignored, &mode, "720x480-24@60d");
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_OFF);
>   
>   	return 0;
>   }
> @@ -478,24 +400,8 @@ static int drm_cmdline_test_res_bpp_refresh_force_on(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60e",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> -
> -	FAIL_ON(!mode.refresh_specified);
> -	FAIL_ON(mode.refresh != 60);
> -
> -	FAIL_ON(!mode.bpp_specified);
> -	FAIL_ON(mode.bpp != 24);
> -
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_ON);
> +	drm_cmdline_test_res_bpp_init(ignored, &mode, "720x480-24@60e");
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_ON);
>   
>   	return 0;
>   }
> @@ -504,24 +410,8 @@ static int drm_cmdline_test_res_bpp_refresh_force_on_analog(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60D",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> -
> -	FAIL_ON(!mode.refresh_specified);
> -	FAIL_ON(mode.refresh != 60);
> -
> -	FAIL_ON(!mode.bpp_specified);
> -	FAIL_ON(mode.bpp != 24);
> -
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_ON);
> +	drm_cmdline_test_res_bpp_init(ignored, &mode, "720x480-24@60D");
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_ON);
>   
>   	return 0;
>   }
> @@ -534,8 +424,7 @@ static int drm_cmdline_test_res_bpp_refresh_force_on_digital(void *ignored)
>   	};
>   
>   	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60D",
> -							   &connector,
> -							   &mode));
> +							   &connector, &mode));

Why combine the lines here - the code was just fine earlier.

>   	FAIL_ON(!mode.specified);
>   	FAIL_ON(mode.xres != 720);
>   	FAIL_ON(mode.yres != 480);
> @@ -546,11 +435,7 @@ static int drm_cmdline_test_res_bpp_refresh_force_on_digital(void *ignored)
>   	FAIL_ON(!mode.bpp_specified);
>   	FAIL_ON(mode.bpp != 24);
>   
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_ON_DIGITAL);
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_ON_DIGITAL);
>   
>   	return 0;
>   }
> @@ -559,18 +444,7 @@ static int drm_cmdline_test_res_bpp_refresh_interlaced_margins_force_on(void *ig
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60ime",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> -
> -	FAIL_ON(!mode.refresh_specified);
> -	FAIL_ON(mode.refresh != 60);
> -
> -	FAIL_ON(!mode.bpp_specified);
> -	FAIL_ON(mode.bpp != 24);
> +	drm_cmdline_test_res_bpp_init(ignored, &mode, "720x480-24@60ime");
>   
>   	FAIL_ON(mode.rb);
>   	FAIL_ON(mode.cvt);
> @@ -585,15 +459,9 @@ static int drm_cmdline_test_res_margins_force_on(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480me",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> +	drm_cmdline_test_res_init(ignored, &mode, "720x480me");
>   
>   	FAIL_ON(mode.refresh_specified);
> -
>   	FAIL_ON(mode.bpp_specified);
>   
>   	FAIL_ON(mode.rb);
> @@ -609,15 +477,9 @@ static int drm_cmdline_test_res_vesa_margins(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480Mm",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> +	drm_cmdline_test_res_init(ignored, &mode, "720x480Mm");
>   
>   	FAIL_ON(mode.refresh_specified);
> -
>   	FAIL_ON(mode.bpp_specified);
>   
>   	FAIL_ON(mode.rb);
> @@ -673,10 +535,9 @@ static int drm_cmdline_test_name_bpp(void *ignored)
>   							   &no_connector,
>   							   &mode));
>   	FAIL_ON(strcmp(mode.name, "NTSC"));
> -
>   	FAIL_ON(mode.refresh_specified);
> -
>   	FAIL_ON(!mode.bpp_specified);
> +
>   	FAIL_ON(mode.bpp != 24);
>   
>   	return 0;
> @@ -760,23 +621,13 @@ static int drm_cmdline_test_rotate_0(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=0",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> -	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_0);
> +	drm_cmdline_test_res_init(ignored, &mode, "720x480,rotate=0");
>   
> +	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_0);
>   	FAIL_ON(mode.refresh_specified);
> -
>   	FAIL_ON(mode.bpp_specified);
>   
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_UNSPECIFIED);
>   
>   	return 0;
>   }
> @@ -785,23 +636,13 @@ static int drm_cmdline_test_rotate_90(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=90",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> -	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_90);
> +	drm_cmdline_test_res_init(ignored, &mode, "720x480,rotate=90");
>   
> +	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_90);
>   	FAIL_ON(mode.refresh_specified);
> -
>   	FAIL_ON(mode.bpp_specified);
>   
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_UNSPECIFIED);
>   
>   	return 0;
>   }
> @@ -810,23 +651,13 @@ static int drm_cmdline_test_rotate_180(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=180",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> -	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_180);
> +	drm_cmdline_test_res_init(ignored, &mode, "720x480,rotate=180");
>   
> +	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_180);
>   	FAIL_ON(mode.refresh_specified);
> -
>   	FAIL_ON(mode.bpp_specified);
>   
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_UNSPECIFIED);
>   
>   	return 0;
>   }
> @@ -835,23 +666,13 @@ static int drm_cmdline_test_rotate_270(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=270",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> -	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_270);
> +	drm_cmdline_test_res_init(ignored, &mode, "720x480,rotate=270");
>   
> +	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_270);
>   	FAIL_ON(mode.refresh_specified);
> -
>   	FAIL_ON(mode.bpp_specified);
>   
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_UNSPECIFIED);
>   
>   	return 0;
>   }
> @@ -860,9 +681,8 @@ static int drm_cmdline_test_rotate_multiple(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480,rotate=0,rotate=90",
> -							  &no_connector,
> -							  &mode));
> +	FAIL_ON(drm_mode_parse_command_line_for_connector(
> +				"720x480,rotate=0,rotate=90", &no_connector, &mode));
>   
>   	return 0;
>   }
> @@ -871,9 +691,8 @@ static int drm_cmdline_test_rotate_invalid_val(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480,rotate=42",
> -							  &no_connector,
> -							  &mode));
> +	FAIL_ON(drm_mode_parse_command_line_for_connector(
> +				"720x480,rotate=42", &no_connector, &mode));
>   
>   	return 0;
>   }
> @@ -882,9 +701,8 @@ static int drm_cmdline_test_rotate_truncated(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480,rotate=",
> -							  &no_connector,
> -							  &mode));
> +	FAIL_ON(drm_mode_parse_command_line_for_connector(
> +				"720x480,rotate=", &no_connector, &mode));
>   
>   	return 0;
>   }
> @@ -893,23 +711,13 @@ static int drm_cmdline_test_hmirror(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,reflect_x",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> -	FAIL_ON(mode.rotation_reflection != (DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_X));
> +	drm_cmdline_test_res_init(ignored, &mode, "720x480,reflect_x");
>   
> +	FAIL_ON(mode.rotation_reflection != (DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_X));
>   	FAIL_ON(mode.refresh_specified);
> -
>   	FAIL_ON(mode.bpp_specified);
>   
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_UNSPECIFIED);
>   
>   	return 0;
>   }
> @@ -918,23 +726,13 @@ static int drm_cmdline_test_vmirror(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,reflect_y",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> -	FAIL_ON(mode.rotation_reflection != (DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_Y));
> +	drm_cmdline_test_res_init(ignored, &mode, "720x480,reflect_y");
>   
> +	FAIL_ON(mode.rotation_reflection != (DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_Y));
>   	FAIL_ON(mode.refresh_specified);
> -
>   	FAIL_ON(mode.bpp_specified);
>   
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_UNSPECIFIED);
>   
>   	return 0;
>   }
> @@ -943,26 +741,18 @@ static int drm_cmdline_test_margin_options(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,margin_right=14,margin_left=24,margin_bottom=36,margin_top=42",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> +	drm_cmdline_test_res_init(ignored, &mode,
> +			"720x480,margin_right=14,margin_left=24,margin_bottom=36,margin_top=42");
> +
>   	FAIL_ON(mode.tv_margins.right != 14);
>   	FAIL_ON(mode.tv_margins.left != 24);
>   	FAIL_ON(mode.tv_margins.bottom != 36);
>   	FAIL_ON(mode.tv_margins.top != 42);
>   
>   	FAIL_ON(mode.refresh_specified);
> -
>   	FAIL_ON(mode.bpp_specified);
>   
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_UNSPECIFIED);
>   
>   	return 0;
>   }
> @@ -971,23 +761,13 @@ static int drm_cmdline_test_multiple_options(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=270,reflect_x",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> -	FAIL_ON(mode.rotation_reflection != (DRM_MODE_ROTATE_270 | DRM_MODE_REFLECT_X));
> +	drm_cmdline_test_res_init(ignored, &mode, "720x480,rotate=270,reflect_x");
>   
> +	FAIL_ON(mode.rotation_reflection != (DRM_MODE_ROTATE_270 | DRM_MODE_REFLECT_X));
>   	FAIL_ON(mode.refresh_specified);
> -
>   	FAIL_ON(mode.bpp_specified);
>   
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_UNSPECIFIED);
>   
>   	return 0;
>   }
> @@ -996,9 +776,8 @@ static int drm_cmdline_test_invalid_option(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480,test=42",
> -							  &no_connector,
> -							  &mode));
> +	FAIL_ON(drm_mode_parse_command_line_for_connector(
> +				"720x480,test=42", &no_connector, &mode));
>   
>   	return 0;
>   }
> @@ -1007,24 +786,14 @@ static int drm_cmdline_test_bpp_extra_and_option(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24e,rotate=180",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> -	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_180);
> +	drm_cmdline_test_res_init(ignored, &mode, "720x480-24e,rotate=180");
>   
> +	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_180);
>   	FAIL_ON(mode.refresh_specified);
> -
>   	FAIL_ON(!mode.bpp_specified);
>   	FAIL_ON(mode.bpp != 24);
>   
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_ON);
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_ON);
>   
>   	return 0;
>   }
> @@ -1033,22 +802,13 @@ static int drm_cmdline_test_extra_and_option(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480e,rotate=180",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(!mode.specified);
> -	FAIL_ON(mode.xres != 720);
> -	FAIL_ON(mode.yres != 480);
> -	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_180);
> +	drm_cmdline_test_res_init(ignored, &mode, "720x480e,rotate=180");
>   
> +	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_180);
>   	FAIL_ON(mode.refresh_specified);
>   	FAIL_ON(mode.bpp_specified);
>   
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_ON);
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_ON);
>   
>   	return 0;
>   }
> @@ -1057,23 +817,11 @@ static int drm_cmdline_test_freestanding_options(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("margin_right=14,margin_left=24,margin_bottom=36,margin_top=42",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(mode.specified);
> -	FAIL_ON(mode.refresh_specified);
> -	FAIL_ON(mode.bpp_specified);
> +	drm_cmdline_test_freestanding(ignored, &mode,
> +			"margin_right=14,margin_left=24,margin_bottom=36,margin_top=42",
> +			&no_connector);
>   
> -	FAIL_ON(mode.tv_margins.right != 14);
> -	FAIL_ON(mode.tv_margins.left != 24);
> -	FAIL_ON(mode.tv_margins.bottom != 36);
> -	FAIL_ON(mode.tv_margins.top != 42);
> -
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_UNSPECIFIED);
>   
>   	return 0;
>   }
> @@ -1082,23 +830,11 @@ static int drm_cmdline_test_freestanding_force_e_and_options(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("e,margin_right=14,margin_left=24,margin_bottom=36,margin_top=42",
> -							   &no_connector,
> -							   &mode));
> -	FAIL_ON(mode.specified);
> -	FAIL_ON(mode.refresh_specified);
> -	FAIL_ON(mode.bpp_specified);
> +	drm_cmdline_test_freestanding(ignored, &mode,
> +			"e,margin_right=14,margin_left=24,margin_bottom=36,margin_top=42",
> +			&no_connector);
>   
> -	FAIL_ON(mode.tv_margins.right != 14);
> -	FAIL_ON(mode.tv_margins.left != 24);
> -	FAIL_ON(mode.tv_margins.bottom != 36);
> -	FAIL_ON(mode.tv_margins.top != 42);
> -
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_ON);
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_ON);
>   
>   	return 0;
>   }
> @@ -1107,20 +843,17 @@ static int drm_cmdline_test_panel_orientation(void *ignored)
>   {
>   	struct drm_cmdline_mode mode = { };
>   
> -	FAIL_ON(!drm_mode_parse_command_line_for_connector("panel_orientation=upside_down",
> -							   &no_connector,
> -							   &mode));
> +	FAIL_ON(!drm_mode_parse_command_line_for_connector(
> +				"panel_orientation=upside_down", &no_connector, &mode));

Same here about changing the format.

> +
>   	FAIL_ON(mode.specified);
>   	FAIL_ON(mode.refresh_specified);
>   	FAIL_ON(mode.bpp_specified);
>   
> +
>   	FAIL_ON(mode.panel_orientation != DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP);
>   
> -	FAIL_ON(mode.rb);
> -	FAIL_ON(mode.cvt);
> -	FAIL_ON(mode.interlace);
> -	FAIL_ON(mode.margins);
> -	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
> +	drm_cmdline_test_properties(ignored, &mode, DRM_FORCE_UNSPECIFIED);
>   
>   	return 0;
>   }
> 

thanks,
-- Shuah
