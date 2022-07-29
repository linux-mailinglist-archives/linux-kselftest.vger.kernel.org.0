Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655B0585029
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Jul 2022 14:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiG2Mrv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Jul 2022 08:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiG2Mru (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Jul 2022 08:47:50 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADEB959F;
        Fri, 29 Jul 2022 05:47:49 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LvS3S27TdzDryr;
        Fri, 29 Jul 2022 12:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659098868; bh=Vt0VPfclkRufw77C1gyDHO5bTh47NlGy4ZqbXCi4sps=;
        h=From:To:Cc:Subject:Date:From;
        b=H6Zlmy3gEPYuxQrqXBIRWNazqAbs0Rl1NBVv4mCT7HiEZZZH7KPIIWcM61SmRM+bd
         qgDkKTY1ywRYQt+rcwQjS6W2PjxxGnTFcKFNfje4EcAgeL7bBodOmCKMzrbf9a6XIv
         fl2wmhdWPqtZmoMwU00vKmt9LR7CNpzQND6xwZ/4=
X-Riseup-User-ID: D51D301B64699EE8E41E0FB830FFA8BAC7F4CF00F83929CCD84A28A9DBC451D1
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LvS3K5sc3z5wWb;
        Fri, 29 Jul 2022 12:47:41 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        brendanhiggins@google.com, Guenter Roeck <linux@roeck-us.net>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        kernel test robot <lkp@intel.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2] drm/tests: Split up test cases in igt_check_drm_format_min_pitch
Date:   Fri, 29 Jul 2022 09:47:26 -0300
Message-Id: <20220729124726.748221-1-mairacanal@riseup.net>
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
smaller functions: one testing single plane formats, one testing
multi-planar formats, and the other testing tiled formats.

Fixes: 0421bb0baa84 ("drm: selftest: convert drm_format selftest to KUnit")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Maíra Canal <mairacanal@riseup.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: André Almeida <andrealmeid@igalia.com>
---
v1 -> v2:
- Add Guenter's Tested-by tag.
- Add André's Reviewed-by tag.
- Replace "multiple planes" for "multi-planar" (André Almeida).
- Add Fixes tag (Melissa Wen).
---
 drivers/gpu/drm/tests/drm_format_test.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_format_test.c b/drivers/gpu/drm/tests/drm_format_test.c
index 056cb8599d6d..afb4bca72187 100644
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
+static void igt_check_drm_format_min_pitch_for_multi_planar(struct kunit *test)
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
+	KUNIT_CASE(igt_check_drm_format_min_pitch_for_multi_planar),
+	KUNIT_CASE(igt_check_drm_format_min_pitch_for_tiled_format),
 	{ }
 };
 
-- 
2.37.1

