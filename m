Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14345777D1
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Jul 2022 20:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiGQSny (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 17 Jul 2022 14:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQSnx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 17 Jul 2022 14:43:53 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7D92DD6;
        Sun, 17 Jul 2022 11:43:50 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LmDWn3s8mzDr5C;
        Sun, 17 Jul 2022 18:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1658083429; bh=KfVesRIHTSH9TyqXuw4ZgjoMcp7Ex8wySKfXnS9bb5U=;
        h=From:To:Cc:Subject:Date:From;
        b=WcOUNsf925qO4bxBPyuPfK7l3t6e9vBhFCiyAHB4HZnf2AszgysmEyyWeiblkj+uJ
         +pHh4Mu2iANn4/8K8sdraAklhJnmcuvthHLDhpovAdBEo2WoRKhDBUW4ilUTLWXUU3
         8dBX073fc/6d5bXc4/oM94fVr4KHq/2VWzaxHJbc=
X-Riseup-User-ID: B8955547438B93442ECC227E5620CD495D1C9D259D4944337C5BF7181AAFA3E3
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4LmDWf4sVBz1yWZ;
        Sun, 17 Jul 2022 18:43:42 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        brendanhiggins@google.com, Guenter Roeck <linux@roeck-us.net>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/tests: Split up test cases in igt_check_drm_format_min_pitch
Date:   Sun, 17 Jul 2022 15:43:36 -0300
Message-Id: <20220717184336.1197723-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The igt_check_drm_format_min_pitch() function had a lot of
KUNIT_EXPECT_* calls, all of which ended up allocating and initializing
various test assertion structures on the stack.

This behavior was producing -Wframe-larger-than warnings on PowerPC, i386,
and MIPS architectures, such as:

drivers/gpu/drm/tests/drm_format_test.c: In function 'igt_check_drm_format_min_pitch':
drivers/gpu/drm/tests/drm_format_test.c:271:1: error: the frame size of
3712 bytes is larger than 2048 bytes

So, the igt_check_drm_format_min_pitch() test case was split into three
smaller functions: one testing single plane formats, one testing multiple
planes formats, and the other testing tiled formats.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/tests/drm_format_test.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_format_test.c b/drivers/gpu/drm/tests/drm_format_test.c
index 056cb8599d6d..28f2b8f88818 100644
--- a/drivers/gpu/drm/tests/drm_format_test.c
+++ b/drivers/gpu/drm/tests/drm_format_test.c
@@ -91,7 +91,7 @@ static void igt_check_drm_format_block_height(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, drm_format_info_block_height(info, -1));
 }
 
-static void igt_check_drm_format_min_pitch(struct kunit *test)
+static void igt_check_drm_format_min_pitch_for_single_plane(struct kunit *test)
 {
 	const struct drm_format_info *info = NULL;
 
@@ -175,6 +175,11 @@ static void igt_check_drm_format_min_pitch(struct kunit *test)
 			(uint64_t)UINT_MAX * 4);
 	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, (UINT_MAX - 1)),
 			(uint64_t)(UINT_MAX - 1) * 4);
+}
+
+static void igt_check_drm_format_min_pitch_for_multiple_planes(struct kunit *test)
+{
+	const struct drm_format_info *info = NULL;
 
 	/* Test 2 planes format */
 	info = drm_format_info(DRM_FORMAT_NV12);
@@ -249,6 +254,11 @@ static void igt_check_drm_format_min_pitch(struct kunit *test)
 			(uint64_t)(UINT_MAX - 1) / 2);
 	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, (UINT_MAX - 1) / 2),
 			(uint64_t)(UINT_MAX - 1) / 2);
+}
+
+static void igt_check_drm_format_min_pitch_for_tiled_format(struct kunit *test)
+{
+	const struct drm_format_info *info = NULL;
 
 	/* Test tiled format */
 	info = drm_format_info(DRM_FORMAT_X0L2);
@@ -273,7 +283,9 @@ static void igt_check_drm_format_min_pitch(struct kunit *test)
 static struct kunit_case drm_format_tests[] = {
 	KUNIT_CASE(igt_check_drm_format_block_width),
 	KUNIT_CASE(igt_check_drm_format_block_height),
-	KUNIT_CASE(igt_check_drm_format_min_pitch),
+	KUNIT_CASE(igt_check_drm_format_min_pitch_for_single_plane),
+	KUNIT_CASE(igt_check_drm_format_min_pitch_for_multiple_planes),
+	KUNIT_CASE(igt_check_drm_format_min_pitch_for_tiled_format),
 	{ }
 };
 
-- 
2.36.1

