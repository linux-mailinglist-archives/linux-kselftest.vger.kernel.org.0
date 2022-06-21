Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5E0553B2C
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jun 2022 22:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354006AbiFUUKd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jun 2022 16:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351199AbiFUUKc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jun 2022 16:10:32 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8F12B199
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 13:10:29 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id j10so2594618oih.4
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 13:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LrBIhT9picrq54R8u1rLYrZBRgwkKehCLKahlRRpyD4=;
        b=tqAnnDeEziwoQESJb7sXyI7PexRgF3eqenoQss2O8AyxuI8C+h0NovwZwj48uAd1S6
         HJ+oNOVqFQCBgD0NnQFE2ricw8ggSCjTXNAMPX/DmF1CT3T46CWqHiDcbYn1EwXc9fLI
         KOtTJyPq5kuS247ZYEHxMi+ceRKDjPPFiYAbsQl+eeatQJDNH179uD5egy2aLmefIByF
         WcWk64Oqz3VhaBSRRcYYImtyaApuaayJZH8zfvz/ZtdYHEfnn9fWTtwz5+LTtx7Iq3ae
         gBBg+nUbrrxM5w+vr0HtgFYToh5x8ITdyxYDBrDkd1/qLTNXzZ638wf1yd302IHH9vpk
         eIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LrBIhT9picrq54R8u1rLYrZBRgwkKehCLKahlRRpyD4=;
        b=qwHqLTzAfWstyGIQFY53WKsKDodYgA/OzhUa30/J13RAnfcg7WEGtzULAxNRCN+m9+
         n42XgCzbLcESwqmjiTfne5j38NMcA0/TBIUs3MUIaZuX8uHvTSdLmepswFkSRx3UaQqZ
         3+A9+655v+oXv4Ci7LjqHFI7/my3i3/npof954Ry97EzYs5Jt9+OuAMCy72f3qdIc6i4
         iPnccCbLnZQzw/Kz9U05et6O/tJpyeZUKQ+9fxg4+ib61tMwpl69Vz74SLUIO30sKQvE
         Qdy2/pt+ElFuVC4o8KeYAwBWD9UC/PRvvQZNhkSM9YzGQPO1eHd1Q3HWKE6UOiqY14eh
         yimA==
X-Gm-Message-State: AJIora9h6Y43YyGsX7ZMStMJbmtdUf8rG1OCTF/7lXK2Dtjql5uDvDW+
        rnsUSIF6ZDLizXsO4eQpquDahQ==
X-Google-Smtp-Source: AGRyM1tHiBq5xMJfm7MLQhGP1xnCTlsIpeIiSfgJQ1FYlPR9GNUMlSfx/JEWPRevqBvneJN7EfX4yw==
X-Received: by 2002:a05:6808:1527:b0:32e:e4a0:d819 with SMTP id u39-20020a056808152700b0032ee4a0d819mr15667868oiw.237.1655842228802;
        Tue, 21 Jun 2022 13:10:28 -0700 (PDT)
Received: from fedora.. ([2804:14d:8084:84c6:fe26:c42d:aab9:fa8a])
        by smtp.gmail.com with ESMTPSA id o206-20020acad7d7000000b0032b7a0c5da1sm9759771oig.27.2022.06.21.13.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 13:10:28 -0700 (PDT)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
        Arthur Grillo <arthur.grillo@usp.br>
Subject: [PATCH v2 2/9] drm: selftest: convert drm_cmdline_parser selftest to KUnit
Date:   Tue, 21 Jun 2022 17:09:19 -0300
Message-Id: <20220621200926.257002-3-maira.canal@usp.br>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621200926.257002-1-maira.canal@usp.br>
References: <20220621200926.257002-1-maira.canal@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Considering the current adoption of the KUnit framework, convert the
DRM cmdline parser selftest to the KUnit API.

Tested-by: David Gow <davidgow@google.com>
Co-developed-by: Arthur Grillo <arthur.grillo@usp.br>
Signed-off-by: Arthur Grillo <arthur.grillo@usp.br>
Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/selftests/Makefile            |    2 +-
 .../gpu/drm/selftests/drm_cmdline_selftests.h |   68 -
 .../drm/selftests/test-drm_cmdline_parser.c   | 1141 -----------------
 drivers/gpu/drm/tests/Makefile                |    2 +-
 .../gpu/drm/tests/drm_cmdline_parser_test.c   | 1078 ++++++++++++++++
 5 files changed, 1080 insertions(+), 1211 deletions(-)
 delete mode 100644 drivers/gpu/drm/selftests/drm_cmdline_selftests.h
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
 create mode 100644 drivers/gpu/drm/tests/drm_cmdline_parser_test.c

diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
index 7a1a732e0a1b..8633bb9ea717 100644
--- a/drivers/gpu/drm/selftests/Makefile
+++ b/drivers/gpu/drm/selftests/Makefile
@@ -3,5 +3,5 @@ test-drm_modeset-y := test-drm_modeset_common.o test-drm_plane_helper.o \
                       test-drm_format.o test-drm_framebuffer.o \
 		      test-drm_dp_mst_helper.o test-drm_rect.o
 
-obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o test-drm_cmdline_parser.o \
+obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o \
 				    test-drm_buddy.o
diff --git a/drivers/gpu/drm/selftests/drm_cmdline_selftests.h b/drivers/gpu/drm/selftests/drm_cmdline_selftests.h
deleted file mode 100644
index 29e367db6118..000000000000
--- a/drivers/gpu/drm/selftests/drm_cmdline_selftests.h
+++ /dev/null
@@ -1,68 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* List each unit test as selftest(function)
- *
- * The name is used as both an enum and expanded as igt__name to create
- * a module parameter. It must be unique and legal for a C identifier.
- *
- * Tests are executed in order by igt/drm_mm
- */
-
-#define cmdline_test(test)	selftest(test, test)
-
-cmdline_test(drm_cmdline_test_force_d_only)
-cmdline_test(drm_cmdline_test_force_D_only_dvi)
-cmdline_test(drm_cmdline_test_force_D_only_hdmi)
-cmdline_test(drm_cmdline_test_force_D_only_not_digital)
-cmdline_test(drm_cmdline_test_force_e_only)
-cmdline_test(drm_cmdline_test_margin_only)
-cmdline_test(drm_cmdline_test_interlace_only)
-cmdline_test(drm_cmdline_test_res)
-cmdline_test(drm_cmdline_test_res_missing_x)
-cmdline_test(drm_cmdline_test_res_missing_y)
-cmdline_test(drm_cmdline_test_res_bad_y)
-cmdline_test(drm_cmdline_test_res_missing_y_bpp)
-cmdline_test(drm_cmdline_test_res_vesa)
-cmdline_test(drm_cmdline_test_res_vesa_rblank)
-cmdline_test(drm_cmdline_test_res_rblank)
-cmdline_test(drm_cmdline_test_res_bpp)
-cmdline_test(drm_cmdline_test_res_bad_bpp)
-cmdline_test(drm_cmdline_test_res_refresh)
-cmdline_test(drm_cmdline_test_res_bad_refresh)
-cmdline_test(drm_cmdline_test_res_bpp_refresh)
-cmdline_test(drm_cmdline_test_res_bpp_refresh_interlaced)
-cmdline_test(drm_cmdline_test_res_bpp_refresh_margins)
-cmdline_test(drm_cmdline_test_res_bpp_refresh_force_off)
-cmdline_test(drm_cmdline_test_res_bpp_refresh_force_on_off)
-cmdline_test(drm_cmdline_test_res_bpp_refresh_force_on)
-cmdline_test(drm_cmdline_test_res_bpp_refresh_force_on_analog)
-cmdline_test(drm_cmdline_test_res_bpp_refresh_force_on_digital)
-cmdline_test(drm_cmdline_test_res_bpp_refresh_interlaced_margins_force_on)
-cmdline_test(drm_cmdline_test_res_margins_force_on)
-cmdline_test(drm_cmdline_test_res_vesa_margins)
-cmdline_test(drm_cmdline_test_res_invalid_mode)
-cmdline_test(drm_cmdline_test_res_bpp_wrong_place_mode)
-cmdline_test(drm_cmdline_test_name)
-cmdline_test(drm_cmdline_test_name_bpp)
-cmdline_test(drm_cmdline_test_name_refresh)
-cmdline_test(drm_cmdline_test_name_bpp_refresh)
-cmdline_test(drm_cmdline_test_name_refresh_wrong_mode)
-cmdline_test(drm_cmdline_test_name_refresh_invalid_mode)
-cmdline_test(drm_cmdline_test_name_option)
-cmdline_test(drm_cmdline_test_name_bpp_option)
-cmdline_test(drm_cmdline_test_rotate_0)
-cmdline_test(drm_cmdline_test_rotate_90)
-cmdline_test(drm_cmdline_test_rotate_180)
-cmdline_test(drm_cmdline_test_rotate_270)
-cmdline_test(drm_cmdline_test_rotate_multiple)
-cmdline_test(drm_cmdline_test_rotate_invalid_val)
-cmdline_test(drm_cmdline_test_rotate_truncated)
-cmdline_test(drm_cmdline_test_hmirror)
-cmdline_test(drm_cmdline_test_vmirror)
-cmdline_test(drm_cmdline_test_margin_options)
-cmdline_test(drm_cmdline_test_multiple_options)
-cmdline_test(drm_cmdline_test_invalid_option)
-cmdline_test(drm_cmdline_test_bpp_extra_and_option)
-cmdline_test(drm_cmdline_test_extra_and_option)
-cmdline_test(drm_cmdline_test_freestanding_options)
-cmdline_test(drm_cmdline_test_freestanding_force_e_and_options)
-cmdline_test(drm_cmdline_test_panel_orientation)
diff --git a/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c b/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
deleted file mode 100644
index d96cd890def6..000000000000
--- a/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
+++ /dev/null
@@ -1,1141 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2019 Bootlin
- */
-
-#define pr_fmt(fmt) "drm_cmdline: " fmt
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-
-#include <drm/drm_connector.h>
-#include <drm/drm_modes.h>
-
-#define TESTS "drm_cmdline_selftests.h"
-#include "drm_selftest.h"
-#include "test-drm_modeset_common.h"
-
-static const struct drm_connector no_connector = {};
-
-static int drm_cmdline_test_force_e_only(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("e",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(mode.specified);
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON);
-
-	return 0;
-}
-
-static int drm_cmdline_test_force_D_only_not_digital(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("D",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(mode.specified);
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON);
-
-	return 0;
-}
-
-static const struct drm_connector connector_hdmi = {
-	.connector_type	= DRM_MODE_CONNECTOR_HDMIB,
-};
-
-static int drm_cmdline_test_force_D_only_hdmi(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("D",
-							   &connector_hdmi,
-							   &mode));
-	FAIL_ON(mode.specified);
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON_DIGITAL);
-
-	return 0;
-}
-
-static const struct drm_connector connector_dvi = {
-	.connector_type	= DRM_MODE_CONNECTOR_DVII,
-};
-
-static int drm_cmdline_test_force_D_only_dvi(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("D",
-							   &connector_dvi,
-							   &mode));
-	FAIL_ON(mode.specified);
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON_DIGITAL);
-
-	return 0;
-}
-
-static int drm_cmdline_test_force_d_only(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("d",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(mode.specified);
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_OFF);
-
-	return 0;
-}
-
-static int drm_cmdline_test_margin_only(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("m",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_interlace_only(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("i",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_res(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_missing_x(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("x480",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_missing_y(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("1024x",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_bad_y(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("1024xtest",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_missing_y_bpp(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("1024x-24",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_vesa(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480M",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(!mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_vesa_rblank(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480MR",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(!mode.rb);
-	FAIL_ON(!mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_rblank(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480R",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(!mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_bpp(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_bad_bpp(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480-test",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_refresh(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480@60",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(!mode.refresh_specified);
-	FAIL_ON(mode.refresh != 60);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_bad_refresh(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480@refresh",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_bpp_refresh(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(!mode.refresh_specified);
-	FAIL_ON(mode.refresh != 60);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_bpp_refresh_interlaced(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60i",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(!mode.refresh_specified);
-	FAIL_ON(mode.refresh != 60);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(!mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_bpp_refresh_margins(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60m",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(!mode.refresh_specified);
-	FAIL_ON(mode.refresh != 60);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(!mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_bpp_refresh_force_off(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60d",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(!mode.refresh_specified);
-	FAIL_ON(mode.refresh != 60);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_OFF);
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_bpp_refresh_force_on_off(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480-24@60de",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_bpp_refresh_force_on(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60e",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(!mode.refresh_specified);
-	FAIL_ON(mode.refresh != 60);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON);
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_bpp_refresh_force_on_analog(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60D",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(!mode.refresh_specified);
-	FAIL_ON(mode.refresh != 60);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON);
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_bpp_refresh_force_on_digital(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-	static const struct drm_connector connector = {
-		.connector_type = DRM_MODE_CONNECTOR_DVII,
-	};
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60D",
-							   &connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(!mode.refresh_specified);
-	FAIL_ON(mode.refresh != 60);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON_DIGITAL);
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_bpp_refresh_interlaced_margins_force_on(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60ime",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(!mode.refresh_specified);
-	FAIL_ON(mode.refresh != 60);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(!mode.interlace);
-	FAIL_ON(!mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON);
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_margins_force_on(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480me",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(!mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON);
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_vesa_margins(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480Mm",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(!mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(!mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_invalid_mode(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480f",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_res_bpp_wrong_place_mode(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480e-24",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_name(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("NTSC",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(strcmp(mode.name, "NTSC"));
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
-
-	return 0;
-}
-
-static int drm_cmdline_test_name_bpp(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("NTSC-24",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(strcmp(mode.name, "NTSC"));
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	return 0;
-}
-
-static int drm_cmdline_test_name_bpp_refresh(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("NTSC-24@60",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_name_refresh(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("NTSC@60",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_name_refresh_wrong_mode(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("NTSC@60m",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_name_refresh_invalid_mode(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("NTSC@60f",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_name_option(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("NTSC,rotate=180",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(strcmp(mode.name, "NTSC"));
-	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_180);
-
-	return 0;
-}
-
-static int drm_cmdline_test_name_bpp_option(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("NTSC-24,rotate=180",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(strcmp(mode.name, "NTSC"));
-	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_180);
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	return 0;
-}
-
-static int drm_cmdline_test_rotate_0(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=0",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_0);
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-static int drm_cmdline_test_rotate_90(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=90",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_90);
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-static int drm_cmdline_test_rotate_180(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=180",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_180);
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-static int drm_cmdline_test_rotate_270(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=270",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_270);
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-static int drm_cmdline_test_rotate_multiple(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480,rotate=0,rotate=90",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_rotate_invalid_val(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480,rotate=42",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_rotate_truncated(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480,rotate=",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_hmirror(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,reflect_x",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != (DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_X));
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-static int drm_cmdline_test_vmirror(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,reflect_y",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != (DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_Y));
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-static int drm_cmdline_test_margin_options(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,margin_right=14,margin_left=24,margin_bottom=36,margin_top=42",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.tv_margins.right != 14);
-	FAIL_ON(mode.tv_margins.left != 24);
-	FAIL_ON(mode.tv_margins.bottom != 36);
-	FAIL_ON(mode.tv_margins.top != 42);
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-static int drm_cmdline_test_multiple_options(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=270,reflect_x",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != (DRM_MODE_ROTATE_270 | DRM_MODE_REFLECT_X));
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-static int drm_cmdline_test_invalid_option(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480,test=42",
-							  &no_connector,
-							  &mode));
-
-	return 0;
-}
-
-static int drm_cmdline_test_bpp_extra_and_option(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24e,rotate=180",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_180);
-
-	FAIL_ON(mode.refresh_specified);
-
-	FAIL_ON(!mode.bpp_specified);
-	FAIL_ON(mode.bpp != 24);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON);
-
-	return 0;
-}
-
-static int drm_cmdline_test_extra_and_option(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480e,rotate=180",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(!mode.specified);
-	FAIL_ON(mode.xres != 720);
-	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != DRM_MODE_ROTATE_180);
-
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON);
-
-	return 0;
-}
-
-static int drm_cmdline_test_freestanding_options(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("margin_right=14,margin_left=24,margin_bottom=36,margin_top=42",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(mode.specified);
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.tv_margins.right != 14);
-	FAIL_ON(mode.tv_margins.left != 24);
-	FAIL_ON(mode.tv_margins.bottom != 36);
-	FAIL_ON(mode.tv_margins.top != 42);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-static int drm_cmdline_test_freestanding_force_e_and_options(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("e,margin_right=14,margin_left=24,margin_bottom=36,margin_top=42",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(mode.specified);
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.tv_margins.right != 14);
-	FAIL_ON(mode.tv_margins.left != 24);
-	FAIL_ON(mode.tv_margins.bottom != 36);
-	FAIL_ON(mode.tv_margins.top != 42);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_ON);
-
-	return 0;
-}
-
-static int drm_cmdline_test_panel_orientation(void *ignored)
-{
-	struct drm_cmdline_mode mode = { };
-
-	FAIL_ON(!drm_mode_parse_command_line_for_connector("panel_orientation=upside_down",
-							   &no_connector,
-							   &mode));
-	FAIL_ON(mode.specified);
-	FAIL_ON(mode.refresh_specified);
-	FAIL_ON(mode.bpp_specified);
-
-	FAIL_ON(mode.panel_orientation != DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP);
-
-	FAIL_ON(mode.rb);
-	FAIL_ON(mode.cvt);
-	FAIL_ON(mode.interlace);
-	FAIL_ON(mode.margins);
-	FAIL_ON(mode.force != DRM_FORCE_UNSPECIFIED);
-
-	return 0;
-}
-
-#include "drm_selftest.c"
-
-static int __init test_drm_cmdline_init(void)
-{
-	int err;
-
-	err = run_selftests(selftests, ARRAY_SIZE(selftests), NULL);
-
-	return err > 0 ? 0 : err;
-}
-module_init(test_drm_cmdline_init);
-
-MODULE_AUTHOR("Maxime Ripard <maxime.ripard@bootlin.com>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index 181ac2c9977a..f9929ac10765 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_DRM_KUNIT_TEST) += drm_damage_helper_test.o
+obj-$(CONFIG_DRM_KUNIT_TEST) += drm_damage_helper_test.o drm_cmdline_parser_test.o
diff --git a/drivers/gpu/drm/tests/drm_cmdline_parser_test.c b/drivers/gpu/drm/tests/drm_cmdline_parser_test.c
new file mode 100644
index 000000000000..ca7669350c64
--- /dev/null
+++ b/drivers/gpu/drm/tests/drm_cmdline_parser_test.c
@@ -0,0 +1,1078 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Bootlin
+ */
+
+#include <kunit/test.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_modes.h>
+
+static const struct drm_connector no_connector = {};
+
+static void drm_cmdline_test_force_e_only(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("e",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_FALSE(test, mode.specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON);
+}
+
+static void drm_cmdline_test_force_D_only_not_digital(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("D",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_FALSE(test, mode.specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON);
+}
+
+static const struct drm_connector connector_hdmi = {
+	.connector_type	= DRM_MODE_CONNECTOR_HDMIB,
+};
+
+static void drm_cmdline_test_force_D_only_hdmi(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("D",
+							   &connector_hdmi,
+							   &mode));
+	KUNIT_EXPECT_FALSE(test, mode.specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON_DIGITAL);
+}
+
+static const struct drm_connector connector_dvi = {
+	.connector_type	= DRM_MODE_CONNECTOR_DVII,
+};
+
+static void drm_cmdline_test_force_D_only_dvi(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("D",
+							   &connector_dvi,
+							   &mode));
+	KUNIT_EXPECT_FALSE(test, mode.specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON_DIGITAL);
+}
+
+static void drm_cmdline_test_force_d_only(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("d",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_FALSE(test, mode.specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_OFF);
+}
+
+static void drm_cmdline_test_margin_only(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector("m",
+							  &no_connector,
+							  &mode));
+}
+
+static void drm_cmdline_test_interlace_only(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector("i",
+							  &no_connector,
+							  &mode));
+}
+
+static void drm_cmdline_test_res(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static void drm_cmdline_test_res_missing_x(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector("x480",
+							  &no_connector,
+							  &mode));
+}
+
+static void drm_cmdline_test_res_missing_y(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector("1024x",
+							  &no_connector,
+							  &mode));
+}
+
+static void drm_cmdline_test_res_bad_y(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector("1024xtest",
+							  &no_connector,
+							  &mode));
+}
+
+static void drm_cmdline_test_res_missing_y_bpp(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector("1024x-24",
+							  &no_connector,
+							  &mode));
+}
+
+static void drm_cmdline_test_res_vesa(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480M",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_TRUE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static void drm_cmdline_test_res_vesa_rblank(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480MR",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_TRUE(test, mode.rb);
+	KUNIT_EXPECT_TRUE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static void drm_cmdline_test_res_rblank(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480R",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_TRUE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static void drm_cmdline_test_res_bpp(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480-24",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static void drm_cmdline_test_res_bad_bpp(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector("720x480-test",
+							  &no_connector,
+							  &mode));
+}
+
+static void drm_cmdline_test_res_refresh(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480@60",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_TRUE(test, mode.refresh_specified);
+	KUNIT_EXPECT_EQ(test, mode.refresh, 60);
+
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static void drm_cmdline_test_res_bad_refresh(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector("720x480@refresh",
+							  &no_connector,
+							  &mode));
+}
+
+static void drm_cmdline_test_res_bpp_refresh(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480-24@60",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_TRUE(test, mode.refresh_specified);
+	KUNIT_EXPECT_EQ(test, mode.refresh, 60);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static void drm_cmdline_test_res_bpp_refresh_interlaced(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480-24@60i",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_TRUE(test, mode.refresh_specified);
+	KUNIT_EXPECT_EQ(test, mode.refresh, 60);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_TRUE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static void drm_cmdline_test_res_bpp_refresh_margins(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480-24@60m",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_TRUE(test, mode.refresh_specified);
+	KUNIT_EXPECT_EQ(test, mode.refresh, 60);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_TRUE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static void drm_cmdline_test_res_bpp_refresh_force_off(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480-24@60d",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_TRUE(test, mode.refresh_specified);
+	KUNIT_EXPECT_EQ(test, mode.refresh, 60);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_OFF);
+}
+
+static void drm_cmdline_test_res_bpp_refresh_force_on_off(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector("720x480-24@60de",
+							  &no_connector,
+							  &mode));
+}
+
+static void drm_cmdline_test_res_bpp_refresh_force_on(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480-24@60e",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_TRUE(test, mode.refresh_specified);
+	KUNIT_EXPECT_EQ(test, mode.refresh, 60);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON);
+}
+
+static void drm_cmdline_test_res_bpp_refresh_force_on_analog(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480-24@60D",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_TRUE(test, mode.refresh_specified);
+	KUNIT_EXPECT_EQ(test, mode.refresh, 60);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON);
+}
+
+static void drm_cmdline_test_res_bpp_refresh_force_on_digital(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+	static const struct drm_connector connector = {
+		.connector_type = DRM_MODE_CONNECTOR_DVII,
+	};
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480-24@60D",
+							   &connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_TRUE(test, mode.refresh_specified);
+	KUNIT_EXPECT_EQ(test, mode.refresh, 60);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON_DIGITAL);
+}
+
+static void drm_cmdline_test_res_bpp_refresh_interlaced_margins_force_on(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480-24@60ime",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_TRUE(test, mode.refresh_specified);
+	KUNIT_EXPECT_EQ(test, mode.refresh, 60);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_TRUE(test, mode.interlace);
+	KUNIT_EXPECT_TRUE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON);
+}
+
+static void drm_cmdline_test_res_margins_force_on(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480me",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_TRUE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON);
+}
+
+static void drm_cmdline_test_res_vesa_margins(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480Mm",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_TRUE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_TRUE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static void drm_cmdline_test_res_invalid_mode(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector("720x480f",
+							  &no_connector,
+							  &mode));
+}
+
+static void drm_cmdline_test_res_bpp_wrong_place_mode(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector("720x480e-24",
+							  &no_connector,
+							  &mode));
+}
+
+static void drm_cmdline_test_name(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("NTSC",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_STREQ(test, mode.name, "NTSC");
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+}
+
+static void drm_cmdline_test_name_bpp(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("NTSC-24",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_STREQ(test, mode.name, "NTSC");
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+}
+
+static void drm_cmdline_test_name_bpp_refresh(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector("NTSC-24@60",
+							  &no_connector,
+							  &mode));
+}
+
+static void drm_cmdline_test_name_refresh(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector("NTSC@60",
+							  &no_connector,
+							  &mode));
+}
+
+static void drm_cmdline_test_name_refresh_wrong_mode(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector("NTSC@60m",
+							  &no_connector,
+							  &mode));
+}
+
+static void drm_cmdline_test_name_refresh_invalid_mode(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector("NTSC@60f",
+							  &no_connector,
+							  &mode));
+}
+
+static void drm_cmdline_test_name_option(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("NTSC,rotate=180",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_STREQ(test, mode.name, "NTSC");
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, DRM_MODE_ROTATE_180);
+}
+
+static void drm_cmdline_test_name_bpp_option(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("NTSC-24,rotate=180",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_STREQ(test, mode.name, "NTSC");
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, DRM_MODE_ROTATE_180);
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+}
+
+static void drm_cmdline_test_rotate_0(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480,rotate=0",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, DRM_MODE_ROTATE_0);
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static void drm_cmdline_test_rotate_90(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480,rotate=90",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, DRM_MODE_ROTATE_90);
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static void drm_cmdline_test_rotate_180(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480,rotate=180",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, DRM_MODE_ROTATE_180);
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static void drm_cmdline_test_rotate_270(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480,rotate=270",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, DRM_MODE_ROTATE_270);
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static void drm_cmdline_test_rotate_multiple(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector("720x480,rotate=0,rotate=90",
+							  &no_connector,
+							  &mode));
+}
+
+static void drm_cmdline_test_rotate_invalid_val(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector("720x480,rotate=42",
+							  &no_connector,
+							  &mode));
+}
+
+static void drm_cmdline_test_rotate_truncated(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector("720x480,rotate=",
+							  &no_connector,
+							  &mode));
+}
+
+static void drm_cmdline_test_hmirror(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480,reflect_x",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, (DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_X));
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static void drm_cmdline_test_vmirror(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480,reflect_y",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, (DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_Y));
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static void drm_cmdline_test_margin_options(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector(
+					"720x480,margin_right=14,margin_left=24,margin_bottom=36,margin_top=42",
+					&no_connector,
+					&mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.right, 14);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.left, 24);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.bottom, 36);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.top, 42);
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static void drm_cmdline_test_multiple_options(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480,rotate=270,reflect_x",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, (DRM_MODE_ROTATE_270 | DRM_MODE_REFLECT_X));
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static void drm_cmdline_test_invalid_option(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_FALSE(test, drm_mode_parse_command_line_for_connector("720x480,test=42",
+							  &no_connector,
+							  &mode));
+}
+
+static void drm_cmdline_test_bpp_extra_and_option(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480-24e,rotate=180",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, DRM_MODE_ROTATE_180);
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+
+	KUNIT_EXPECT_TRUE(test, mode.bpp_specified);
+	KUNIT_EXPECT_EQ(test, mode.bpp, 24);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON);
+}
+
+static void drm_cmdline_test_extra_and_option(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("720x480e,rotate=180",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_TRUE(test, mode.specified);
+	KUNIT_EXPECT_EQ(test, mode.xres, 720);
+	KUNIT_EXPECT_EQ(test, mode.yres, 480);
+	KUNIT_EXPECT_EQ(test, mode.rotation_reflection, DRM_MODE_ROTATE_180);
+
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON);
+}
+
+static void drm_cmdline_test_freestanding_options(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector(
+						"margin_right=14,margin_left=24,margin_bottom=36,margin_top=42",
+						&no_connector,
+						&mode));
+	KUNIT_EXPECT_FALSE(test, mode.specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.right, 14);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.left, 24);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.bottom, 36);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.top, 42);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static void drm_cmdline_test_freestanding_force_e_and_options(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector(
+						"e,margin_right=14,margin_left=24,margin_bottom=36,margin_top=42",
+						&no_connector,
+						&mode));
+	KUNIT_EXPECT_FALSE(test, mode.specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.right, 14);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.left, 24);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.bottom, 36);
+	KUNIT_EXPECT_EQ(test, mode.tv_margins.top, 42);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_ON);
+}
+
+static void drm_cmdline_test_panel_orientation(struct kunit *test)
+{
+	struct drm_cmdline_mode mode = { };
+
+	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector("panel_orientation=upside_down",
+							   &no_connector,
+							   &mode));
+	KUNIT_EXPECT_FALSE(test, mode.specified);
+	KUNIT_EXPECT_FALSE(test, mode.refresh_specified);
+	KUNIT_EXPECT_FALSE(test, mode.bpp_specified);
+
+	KUNIT_EXPECT_EQ(test, mode.panel_orientation, DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP);
+
+	KUNIT_EXPECT_FALSE(test, mode.rb);
+	KUNIT_EXPECT_FALSE(test, mode.cvt);
+	KUNIT_EXPECT_FALSE(test, mode.interlace);
+	KUNIT_EXPECT_FALSE(test, mode.margins);
+	KUNIT_EXPECT_EQ(test, mode.force, DRM_FORCE_UNSPECIFIED);
+}
+
+static struct kunit_case drm_cmdline_parser_tests[] = {
+	KUNIT_CASE(drm_cmdline_test_force_d_only),
+	KUNIT_CASE(drm_cmdline_test_force_D_only_dvi),
+	KUNIT_CASE(drm_cmdline_test_force_D_only_hdmi),
+	KUNIT_CASE(drm_cmdline_test_force_D_only_not_digital),
+	KUNIT_CASE(drm_cmdline_test_force_e_only),
+	KUNIT_CASE(drm_cmdline_test_margin_only),
+	KUNIT_CASE(drm_cmdline_test_interlace_only),
+	KUNIT_CASE(drm_cmdline_test_res),
+	KUNIT_CASE(drm_cmdline_test_res_missing_x),
+	KUNIT_CASE(drm_cmdline_test_res_missing_y),
+	KUNIT_CASE(drm_cmdline_test_res_bad_y),
+	KUNIT_CASE(drm_cmdline_test_res_missing_y_bpp),
+	KUNIT_CASE(drm_cmdline_test_res_vesa),
+	KUNIT_CASE(drm_cmdline_test_res_vesa_rblank),
+	KUNIT_CASE(drm_cmdline_test_res_rblank),
+	KUNIT_CASE(drm_cmdline_test_res_bpp),
+	KUNIT_CASE(drm_cmdline_test_res_bad_bpp),
+	KUNIT_CASE(drm_cmdline_test_res_refresh),
+	KUNIT_CASE(drm_cmdline_test_res_bad_refresh),
+	KUNIT_CASE(drm_cmdline_test_res_bpp_refresh),
+	KUNIT_CASE(drm_cmdline_test_res_bpp_refresh_interlaced),
+	KUNIT_CASE(drm_cmdline_test_res_bpp_refresh_margins),
+	KUNIT_CASE(drm_cmdline_test_res_bpp_refresh_force_off),
+	KUNIT_CASE(drm_cmdline_test_res_bpp_refresh_force_on_off),
+	KUNIT_CASE(drm_cmdline_test_res_bpp_refresh_force_on),
+	KUNIT_CASE(drm_cmdline_test_res_bpp_refresh_force_on_analog),
+	KUNIT_CASE(drm_cmdline_test_res_bpp_refresh_force_on_digital),
+	KUNIT_CASE(drm_cmdline_test_res_bpp_refresh_interlaced_margins_force_on),
+	KUNIT_CASE(drm_cmdline_test_res_margins_force_on),
+	KUNIT_CASE(drm_cmdline_test_res_vesa_margins),
+	KUNIT_CASE(drm_cmdline_test_res_invalid_mode),
+	KUNIT_CASE(drm_cmdline_test_res_bpp_wrong_place_mode),
+	KUNIT_CASE(drm_cmdline_test_name),
+	KUNIT_CASE(drm_cmdline_test_name_bpp),
+	KUNIT_CASE(drm_cmdline_test_name_refresh),
+	KUNIT_CASE(drm_cmdline_test_name_bpp_refresh),
+	KUNIT_CASE(drm_cmdline_test_name_refresh_wrong_mode),
+	KUNIT_CASE(drm_cmdline_test_name_refresh_invalid_mode),
+	KUNIT_CASE(drm_cmdline_test_name_option),
+	KUNIT_CASE(drm_cmdline_test_name_bpp_option),
+	KUNIT_CASE(drm_cmdline_test_rotate_0),
+	KUNIT_CASE(drm_cmdline_test_rotate_90),
+	KUNIT_CASE(drm_cmdline_test_rotate_180),
+	KUNIT_CASE(drm_cmdline_test_rotate_270),
+	KUNIT_CASE(drm_cmdline_test_rotate_multiple),
+	KUNIT_CASE(drm_cmdline_test_rotate_invalid_val),
+	KUNIT_CASE(drm_cmdline_test_rotate_truncated),
+	KUNIT_CASE(drm_cmdline_test_hmirror),
+	KUNIT_CASE(drm_cmdline_test_vmirror),
+	KUNIT_CASE(drm_cmdline_test_margin_options),
+	KUNIT_CASE(drm_cmdline_test_multiple_options),
+	KUNIT_CASE(drm_cmdline_test_invalid_option),
+	KUNIT_CASE(drm_cmdline_test_bpp_extra_and_option),
+	KUNIT_CASE(drm_cmdline_test_extra_and_option),
+	KUNIT_CASE(drm_cmdline_test_freestanding_options),
+	KUNIT_CASE(drm_cmdline_test_freestanding_force_e_and_options),
+	KUNIT_CASE(drm_cmdline_test_panel_orientation),
+	{}
+};
+
+static struct kunit_suite drm_cmdline_parser_test_suite = {
+	.name = "drm_cmdline_parser",
+	.test_cases = drm_cmdline_parser_tests
+};
+
+kunit_test_suite(drm_cmdline_parser_test_suite);
+
+MODULE_AUTHOR("Maxime Ripard <maxime.ripard@bootlin.com>");
+MODULE_LICENSE("GPL");
-- 
2.36.1

