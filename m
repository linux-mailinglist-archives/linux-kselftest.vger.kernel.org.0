Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A21B56C330
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Jul 2022 01:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbiGHUcr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 16:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240202AbiGHUc0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 16:32:26 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334D3A025B
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jul 2022 13:32:16 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id be10so49870oib.7
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jul 2022 13:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Wxtfairzp6Avm5dD32IgPD0XPtY12kqTpIO6ptW/t8=;
        b=LGU6xtfGlV0Sw8OY9CqkkN0+7oqtzuzsSLRZGuMLV1NXg4eztbgJzXvmSfgLv91XnH
         1z0ZPGWt050y+oAhbqOYYWAnXYmYidiPlcfkYO7qhHb9b9j7OnfSoTXkrd7doKd6Njor
         bRMms88sS2KywRdSvRky9c6XKG3KBmPcgal32ON8eRr8Qu0VprY8TlYy6a8ccWXatUsH
         mBO8JudT4F11wee3qP4yhmyl3DMVfebVxWkZRbKGbIoGKKSxQp2fD+2X9EDIjOQVpbk4
         xIEo6/mqf3VBtKq6Eq5NhfuSwCD0KdUcRsZDRZ7HdPQ0AUJBJnEwqI1afrRVLxZPZjoH
         wnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Wxtfairzp6Avm5dD32IgPD0XPtY12kqTpIO6ptW/t8=;
        b=V21Uk+fiZ3as7Q1BPaul9nh0NEPK+RsN/jSxdB7+B3+tuW4k7NiUnLs2RSikVAWX5A
         6cIqtDBEsGEHS1VFSLCDvkWjO1yr7ivN/SHgvECyxEi+1wEDzJz3IlSzuKanoiSjf8GK
         AfJOpDGJmMuYEZIpgD/I7Vo/Fv+j/rsiWwMHao65ScgJQ2gKydrmYC63GeLdu88mTuNK
         hh61ts9U2ARj7mZdBh90QQhP8/0cETgVRbG0bqIN/ybrmfw2FE5Cf0JN8OhzMe2vTELZ
         9C7EHB3ITC3Gu2WTXVl0Uwt/WHfRL0xNHC+0qpCGVKyhfM8i//723Mt+blplJoUa0BJ0
         M4TQ==
X-Gm-Message-State: AJIora88y4/UFoiyI4BvsrIdFQFZrxSp2H5yHS5KEHUriQ/rr5lSAlm1
        uUUEOvaLqyJRVHx38hWeY0QviQ==
X-Google-Smtp-Source: AGRyM1vb0JRC/3CXdwCzIFWz/GjUVkr3dgygw9X4uXB9j4h/0wyZ/9mE5dWWgkG7SN2p0B5Cu1N9iw==
X-Received: by 2002:a05:6808:17a6:b0:337:ac34:8051 with SMTP id bg38-20020a05680817a600b00337ac348051mr958230oib.190.1657312335405;
        Fri, 08 Jul 2022 13:32:15 -0700 (PDT)
Received: from fedora.. ([143.107.182.242])
        by smtp.gmail.com with ESMTPSA id ci10-20020a05683063ca00b0061c309b1dc2sm742225otb.39.2022.07.08.13.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 13:32:14 -0700 (PDT)
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
        Rubens Gomes Neto <rubens.gomes.neto@usp.br>
Subject: [PATCH v5 6/9] drm: selftest: convert drm_dp_mst_helper selftest to KUnit
Date:   Fri,  8 Jul 2022 17:30:49 -0300
Message-Id: <20220708203052.236290-7-maira.canal@usp.br>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220708203052.236290-1-maira.canal@usp.br>
References: <20220708203052.236290-1-maira.canal@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Considering the current adoption of the KUnit framework, convert the
DRM DP MST helper selftest to the KUnit API.

Co-developed-by: Rubens Gomes Neto <rubens.gomes.neto@usp.br>
Signed-off-by: Rubens Gomes Neto <rubens.gomes.neto@usp.br>
Tested-by: David Gow <davidgow@google.com>
Acked-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/selftests/Makefile            |  3 +-
 .../gpu/drm/selftests/drm_modeset_selftests.h |  2 -
 .../drm/selftests/test-drm_modeset_common.h   |  2 -
 drivers/gpu/drm/tests/Makefile                |  3 +-
 .../drm_dp_mst_helper_test.c}                 | 89 +++++++++++--------
 5 files changed, 53 insertions(+), 46 deletions(-)
 rename drivers/gpu/drm/{selftests/test-drm_dp_mst_helper.c => tests/drm_dp_mst_helper_test.c} (72%)

diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
index 9e0ccb482841..1539f55db9a7 100644
--- a/drivers/gpu/drm/selftests/Makefile
+++ b/drivers/gpu/drm/selftests/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-test-drm_modeset-y := test-drm_modeset_common.o test-drm_framebuffer.o \
-					test-drm_dp_mst_helper.o
+test-drm_modeset-y := test-drm_modeset_common.o test-drm_framebuffer.o
 
 obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o \
 				    test-drm_buddy.o
diff --git a/drivers/gpu/drm/selftests/drm_modeset_selftests.h b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
index 22e467f6465a..40a29b8cf386 100644
--- a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
+++ b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
@@ -7,5 +7,3 @@
  * Tests are executed in order by igt/drm_selftests_helper
  */
 selftest(check_drm_framebuffer_create, igt_check_drm_framebuffer_create)
-selftest(dp_mst_calc_pbn_mode, igt_dp_mst_calc_pbn_mode)
-selftest(dp_mst_sideband_msg_req_decode, igt_dp_mst_sideband_msg_req_decode)
diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.h b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
index 790f3cf31f0d..3feb2fea1a6b 100644
--- a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
+++ b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
@@ -17,7 +17,5 @@
 #define FAIL_ON(x) FAIL((x), "%s", "FAIL_ON(" __stringify(x) ")\n")
 
 int igt_check_drm_framebuffer_create(void *ignored);
-int igt_dp_mst_calc_pbn_mode(void *ignored);
-int igt_dp_mst_sideband_msg_req_decode(void *ignored);
 
 #endif
diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index 4d44006a4f23..5ffacd3eacf3 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_DRM_KUNIT_TEST) += drm_format_helper_test.o drm_damage_helper_test.o \
-	drm_cmdline_parser_test.o drm_rect_test.o drm_format_test.o drm_plane_helper_test.o
+	drm_cmdline_parser_test.o drm_rect_test.o drm_format_test.o drm_plane_helper_test.o \
+	drm_dp_mst_helper_test.o
diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/tests/drm_dp_mst_helper_test.c
similarity index 72%
rename from drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
rename to drivers/gpu/drm/tests/drm_dp_mst_helper_test.c
index 4caa9be900ac..1d2fade56227 100644
--- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
+++ b/drivers/gpu/drm/tests/drm_dp_mst_helper_test.c
@@ -1,19 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Test cases for the DRM DP MST helpers
+ *
+ * Copyright (c) 2022 Maíra Canal <mairacanal@riseup.net>
  */
 
 #define PREFIX_STR "[drm_dp_mst_helper]"
 
+#include <kunit/test.h>
+
 #include <linux/random.h>
 
 #include <drm/display/drm_dp_mst_helper.h>
 #include <drm/drm_print.h>
 
 #include "../display/drm_dp_mst_topology_internal.h"
-#include "test-drm_modeset_common.h"
 
-int igt_dp_mst_calc_pbn_mode(void *ignored)
+static void igt_dp_mst_calc_pbn_mode(struct kunit *test)
 {
 	int pbn, i;
 	const struct {
@@ -33,13 +36,11 @@ int igt_dp_mst_calc_pbn_mode(void *ignored)
 		pbn = drm_dp_calc_pbn_mode(test_params[i].rate,
 					   test_params[i].bpp,
 					   test_params[i].dsc);
-		FAIL(pbn != test_params[i].expected,
-		     "Expected PBN %d for clock %d bpp %d, got %d\n",
+		KUNIT_EXPECT_EQ_MSG(test, pbn, test_params[i].expected,
+				    "Expected PBN %d for clock %d bpp %d, got %d\n",
 		     test_params[i].expected, test_params[i].rate,
 		     test_params[i].bpp, pbn);
 	}
-
-	return 0;
 }
 
 static bool
@@ -176,66 +177,64 @@ sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
 	return result;
 }
 
-int igt_dp_mst_sideband_msg_req_decode(void *unused)
+static void igt_dp_mst_sideband_msg_req_decode(struct kunit *test)
 {
 	struct drm_dp_sideband_msg_req_body in = { 0 };
 	u8 data[] = { 0xff, 0x0, 0xdd };
 	int i;
 
-#define DO_TEST() FAIL_ON(!sideband_msg_req_encode_decode(&in))
-
 	in.req_type = DP_ENUM_PATH_RESOURCES;
 	in.u.port_num.port_number = 5;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 
 	in.req_type = DP_POWER_UP_PHY;
 	in.u.port_num.port_number = 5;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 
 	in.req_type = DP_POWER_DOWN_PHY;
 	in.u.port_num.port_number = 5;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 
 	in.req_type = DP_ALLOCATE_PAYLOAD;
 	in.u.allocate_payload.number_sdp_streams = 3;
 	for (i = 0; i < in.u.allocate_payload.number_sdp_streams; i++)
 		in.u.allocate_payload.sdp_stream_sink[i] = i + 1;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 	in.u.allocate_payload.port_number = 0xf;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 	in.u.allocate_payload.vcpi = 0x7f;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 	in.u.allocate_payload.pbn = U16_MAX;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 
 	in.req_type = DP_QUERY_PAYLOAD;
 	in.u.query_payload.port_number = 0xf;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 	in.u.query_payload.vcpi = 0x7f;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 
 	in.req_type = DP_REMOTE_DPCD_READ;
 	in.u.dpcd_read.port_number = 0xf;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 	in.u.dpcd_read.dpcd_address = 0xfedcb;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 	in.u.dpcd_read.num_bytes = U8_MAX;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 
 	in.req_type = DP_REMOTE_DPCD_WRITE;
 	in.u.dpcd_write.port_number = 0xf;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 	in.u.dpcd_write.dpcd_address = 0xfedcb;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 	in.u.dpcd_write.num_bytes = ARRAY_SIZE(data);
 	in.u.dpcd_write.bytes = data;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 
 	in.req_type = DP_REMOTE_I2C_READ;
 	in.u.i2c_read.port_number = 0xf;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 	in.u.i2c_read.read_i2c_device_id = 0x7f;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 	in.u.i2c_read.num_transactions = 3;
 	in.u.i2c_read.num_bytes_read = ARRAY_SIZE(data) * 3;
 	for (i = 0; i < in.u.i2c_read.num_transactions; i++) {
@@ -244,32 +243,44 @@ int igt_dp_mst_sideband_msg_req_decode(void *unused)
 		in.u.i2c_read.transactions[i].i2c_dev_id = 0x7f & ~i;
 		in.u.i2c_read.transactions[i].i2c_transaction_delay = 0xf & ~i;
 	}
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 
 	in.req_type = DP_REMOTE_I2C_WRITE;
 	in.u.i2c_write.port_number = 0xf;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 	in.u.i2c_write.write_i2c_device_id = 0x7f;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 	in.u.i2c_write.num_bytes = ARRAY_SIZE(data);
 	in.u.i2c_write.bytes = data;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 
 	in.req_type = DP_QUERY_STREAM_ENC_STATUS;
 	in.u.enc_status.stream_id = 1;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 	get_random_bytes(in.u.enc_status.client_id,
 			 sizeof(in.u.enc_status.client_id));
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 	in.u.enc_status.stream_event = 3;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 	in.u.enc_status.valid_stream_event = 0;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 	in.u.enc_status.stream_behavior = 3;
-	DO_TEST();
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 	in.u.enc_status.valid_stream_behavior = 1;
-	DO_TEST();
-
-#undef DO_TEST
-	return 0;
+	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
 }
+
+static struct kunit_case drm_dp_mst_helper_tests[] = {
+	KUNIT_CASE(igt_dp_mst_calc_pbn_mode),
+	KUNIT_CASE(igt_dp_mst_sideband_msg_req_decode),
+	{ }
+};
+
+static struct kunit_suite drm_dp_mst_helper_test_suite = {
+	.name = "drm_dp_mst_helper",
+	.test_cases = drm_dp_mst_helper_tests,
+};
+
+kunit_test_suite(drm_dp_mst_helper_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.35.3

