Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA11B645B9F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 14:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiLGN6L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 08:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiLGN57 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 08:57:59 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291DFC4E;
        Wed,  7 Dec 2022 05:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xpxd7dkkl5q/KfS0CZUbzeIRSdaT0Ah5HzKQhmaMNp0=; b=iEInDFH947pg3B8SyceyF7tc1j
        wwP1ORmMPS5rvfEgJ1iNcND1f1blfyq0cP0kD0kFUmCSUaNheCWxXwvnle6mf7S5Xrx1J2Sgc3NbG
        dTt/DtHtonV7Rvy/f3NvEGMYgs9n+mmNvvXKhvX5Ex+yTvpN3Zc/6qFjTT0INd5SHxd3dDqhRTCdF
        kVb7NsAq3NF653osB67a2W+9/l8/yLMoAMsJ99BzJxpd4UDlKUkjTDcN19/ybAdGP16MVuQMijLZh
        /3xoqLQ6mqgeSH901gFlRn6ijti1e5RF6eHJ0mnJ++Lp/9NW6bkLq32roOTxWAcj6ognkSrB21Tim
        zd8Ciiuw==;
Received: from [143.107.182.242] (helo=[10.41.75.14])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1p2uve-00GbYI-6l; Wed, 07 Dec 2022 14:57:42 +0100
Message-ID: <35023956-d838-55af-63c2-e679a78a27eb@igalia.com>
Date:   Wed, 7 Dec 2022 10:57:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 02/20] drm/tests: Introduce a config option for the
 KUnit helpers
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
 <20221123-rpi-kunit-tests-v3-2-4615a663a84a@cerno.tech>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20221123-rpi-kunit-tests-v3-2-4615a663a84a@cerno.tech>
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
> Driver-specific tests will need access to the helpers without pulling
> every DRM framework test. Let's create an intermediate Kconfig options
> for the helpers.
> 
> Suggested-by: Maíra Canal <mcanal@igalia.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra Canal

> ---
>   drivers/gpu/drm/Kconfig        | 7 +++++++
>   drivers/gpu/drm/Makefile       | 2 +-
>   drivers/gpu/drm/tests/Makefile | 4 +++-
>   3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 315cbdf61979..9f019cd053e1 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -63,6 +63,12 @@ config DRM_USE_DYNAMIC_DEBUG
>   	  bytes per callsite, the .data costs can be substantial, and
>   	  are therefore configurable.
>   
> +config DRM_KUNIT_TEST_HELPERS
> +	tristate
> +	depends on DRM && KUNIT
> +	help
> +	  KUnit Helpers for KMS drivers.
> +
>   config DRM_KUNIT_TEST
>   	tristate "KUnit tests for DRM" if !KUNIT_ALL_TESTS
>   	depends on DRM && KUNIT
> @@ -73,6 +79,7 @@ config DRM_KUNIT_TEST
>   	select DRM_KMS_HELPER
>   	select DRM_BUDDY
>   	select DRM_EXPORT_FOR_TESTS if m
> +	select DRM_KUNIT_TEST_HELPERS
>   	default KUNIT_ALL_TESTS
>   	help
>   	  This builds unit tests for DRM. This option is not useful for
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index f92cd7892711..8d61fbdfdfac 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -125,7 +125,7 @@ obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
>   # Drivers and the rest
>   #
>   
> -obj-$(CONFIG_DRM_KUNIT_TEST) += tests/
> +obj-y			+= tests/
>   
>   obj-$(CONFIG_DRM_MIPI_DBI) += drm_mipi_dbi.o
>   obj-$(CONFIG_DRM_MIPI_DSI) += drm_mipi_dsi.o
> diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
> index 94fe546d937d..ef14bd481139 100644
> --- a/drivers/gpu/drm/tests/Makefile
> +++ b/drivers/gpu/drm/tests/Makefile
> @@ -1,5 +1,8 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
> +obj-$(CONFIG_DRM_KUNIT_TEST_HELPERS) += \
> +	drm_kunit_helpers.o
> +
>   obj-$(CONFIG_DRM_KUNIT_TEST) += \
>   	drm_buddy_test.o \
>   	drm_cmdline_parser_test.o \
> @@ -9,7 +12,6 @@ obj-$(CONFIG_DRM_KUNIT_TEST) += \
>   	drm_format_helper_test.o \
>   	drm_format_test.o \
>   	drm_framebuffer_test.o \
> -	drm_kunit_helpers.o \
>   	drm_mm_test.o \
>   	drm_modes_test.o \
>   	drm_plane_helper_test.o \
> 
