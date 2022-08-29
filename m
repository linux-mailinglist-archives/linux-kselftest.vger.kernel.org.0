Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E805A4041
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 02:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiH2AKQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 Aug 2022 20:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiH2AKL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 Aug 2022 20:10:11 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946B222BE2;
        Sun, 28 Aug 2022 17:10:04 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4MG9mq0vbVzDrgM;
        Mon, 29 Aug 2022 00:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1661731803; bh=GqYqpPbeOc3SjjOOqv4u8JdDVfsfn7HITY3mPh8GK74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQrhd3DI9Tkvfi8b9btJi+1qblNzmjU/J90LnnOjNkYHIVcFC9YLimZRj2spMurmT
         SWv7xUcXsozflAa6GubJQmFUWdPk8erbKrzKsjoyvrqGrgyxv5wHCH4OE4BUE3FSr2
         ZFYs5u7UAwMZ8CzDzs+yfJBeQLqmG5VvxwdJiE+M=
X-Riseup-User-ID: 917F8FFE9CD523F10637D9A466C228627F64C6493909752F6C5CE9D789C5504D
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4MG9mk0Nkdz5vkC;
        Mon, 29 Aug 2022 00:09:57 +0000 (UTC)
From:   Isabella Basso <isabbasso@riseup.net>
To:     igt-dev@lists.freedesktop.org
Cc:     magalilemes00@gmail.com, maira.canal@usp.br,
        tales.aparecida@gmail.com, rodrigo.siqueira@amd.com,
        mwen@igalia.com, andrealmeid@riseup.net, twoerner@gmail.com,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        kunit-dev@googlegroups.com, davidgow@google.com,
        dlatypov@google.com, brendanhiggins@google.com, daniel@ffwll.ch,
        skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel@fooishbar.org,
        linux-kernel@vger.kernel.org, Isabella Basso <isabbasso@riseup.net>
Subject: [PATCH i-g-t v2 4/4] tests: DRM selftests: switch to KUnit
Date:   Sun, 28 Aug 2022 21:09:20 -0300
Message-Id: <20220829000920.38185-5-isabbasso@riseup.net>
In-Reply-To: <20220829000920.38185-1-isabbasso@riseup.net>
References: <20220829000920.38185-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As the DRM selftests are now using KUnit [1], update IGT tests as well.

[1] - https://lore.kernel.org/all/20220708203052.236290-1-maira.canal@usp.br/

Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
 tests/drm_buddy.c    |  7 ++++---
 tests/drm_mm.c       |  7 ++++---
 tests/kms_selftest.c | 12 +++++++++---
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/tests/drm_buddy.c b/tests/drm_buddy.c
index 06876e0c..74c06dce 100644
--- a/tests/drm_buddy.c
+++ b/tests/drm_buddy.c
@@ -6,9 +6,10 @@
 #include "igt.h"
 #include "igt_kmod.h"
 
-IGT_TEST_DESCRIPTION("Basic sanity check of DRM's buddy allocator (struct drm_buddy)");
+IGT_TEST_DESCRIPTION("Basic sanity check of DRM's buddy allocator (struct \
+		      drm_buddy) using KUnit");
 
-igt_main
+igt_simple_main
 {
-	igt_kselftests("test-drm_buddy", NULL, NULL, NULL);
+	igt_kunit("drm_buddy_test", NULL);
 }
diff --git a/tests/drm_mm.c b/tests/drm_mm.c
index 2052b115..75fc6682 100644
--- a/tests/drm_mm.c
+++ b/tests/drm_mm.c
@@ -24,9 +24,10 @@
 #include "igt.h"
 #include "igt_kmod.h"
 
-IGT_TEST_DESCRIPTION("Basic sanity check of DRM's range manager (struct drm_mm)");
+IGT_TEST_DESCRIPTION("Basic sanity check of DRM's range manager (struct drm_mm)\
+		     using KUnit");
 
-igt_main
+igt_simple_main
 {
-	igt_kselftests("test-drm_mm", NULL, NULL, NULL);
+	igt_kunit("drm_mm_test", NULL);
 }
diff --git a/tests/kms_selftest.c b/tests/kms_selftest.c
index abc4bfe9..bbf24c2b 100644
--- a/tests/kms_selftest.c
+++ b/tests/kms_selftest.c
@@ -24,9 +24,15 @@
 #include "igt.h"
 #include "igt_kmod.h"
 
-IGT_TEST_DESCRIPTION("Basic sanity check of KMS selftests.");
+IGT_TEST_DESCRIPTION("Basic sanity check of KMS selftests using KUnit");
 
-igt_main
+igt_simple_main
 {
-	igt_kselftests("test-drm_modeset", NULL, NULL, NULL);
+	igt_kunit("drm_cmdline_parser_test", NULL);
+	igt_kunit("drm_damage_helper_test", NULL);
+	igt_kunit("drm_dp_mst_helper_test", NULL);
+	igt_kunit("drm_format_helper_test", NULL);
+	igt_kunit("drm_format_test", NULL);
+	igt_kunit("drm_framebuffer_test", NULL);
+	igt_kunit("drm_plane_helper_test", NULL);
 }
-- 
2.37.2

