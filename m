Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA70560330B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Oct 2022 21:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJRTIC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Oct 2022 15:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJRTHd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Oct 2022 15:07:33 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDD97E029;
        Tue, 18 Oct 2022 12:07:32 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4MsNfC6GCmz9rxC;
        Tue, 18 Oct 2022 19:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1666120051; bh=fQnbGpGZfDXUVN8TEQ6J4PJGnkdeh5hTdyaxSltnCzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FB8tzY8BTS+fnvs7CqjZtRW22jAcQreOtX16l6PdYSu6ONIH/iwCJmqfPKcS5hYso
         5x+1ohRsE6/9n+RcLf/oEaxCbAFYs6kzBIokple7p2ShM/o94x5KbGQPKnvUFQStAx
         v0OjJkJGv32Ww0v1/2fB/ohz1ThbPMrYf0qWkfHg=
X-Riseup-User-ID: 72239DC35B82CF92403005FA9EE344CC298AA82D66EDDF64FF994CF61A4C39D0
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4MsNf712FVz214Q;
        Tue, 18 Oct 2022 19:07:26 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Brendan Higgins <brendanhiggins@google.com>, davidgow@google.com,
        Daniel Latypov <dlatypov@google.com>, airlied@gmail.com,
        daniel@ffwll.ch, davem@davemloft.net, kuba@kernel.org,
        jose.exposito89@gmail.com, javierm@redhat.com
Cc:     andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH v6 3/3] kunit: Use KUNIT_EXPECT_MEMEQ macro
Date:   Tue, 18 Oct 2022 16:05:41 -0300
Message-Id: <20221018190541.189780-4-mairacanal@riseup.net>
In-Reply-To: <20221018190541.189780-1-mairacanal@riseup.net>
References: <20221018190541.189780-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use KUNIT_EXPECT_MEMEQ to compare memory blocks in replacement of the
KUNIT_EXPECT_EQ macro. Therefor, the statement

    KUNIT_EXPECT_EQ(test, memcmp(foo, bar, size), 0);

is replaced by:

    KUNIT_EXPECT_MEMEQ(test, foo, bar, size);

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
Acked-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 drivers/gpu/drm/tests/drm_format_helper_test.c | 12 ++++++------
 net/core/dev_addr_lists_test.c                 |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 8d86c250c2ec..dbbf53a8dd2f 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -315,7 +315,7 @@ static void drm_test_fb_xrgb8888_to_gray8(struct kunit *test)
 	iosys_map_set_vaddr(&src, xrgb8888);
 
 	drm_fb_xrgb8888_to_gray8(&dst, &result->dst_pitch, &src, &fb, &params->clip);
-	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
 static void drm_test_fb_xrgb8888_to_rgb332(struct kunit *test)
@@ -345,7 +345,7 @@ static void drm_test_fb_xrgb8888_to_rgb332(struct kunit *test)
 	iosys_map_set_vaddr(&src, xrgb8888);
 
 	drm_fb_xrgb8888_to_rgb332(&dst, &result->dst_pitch, &src, &fb, &params->clip);
-	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
 static void drm_test_fb_xrgb8888_to_rgb565(struct kunit *test)
@@ -375,10 +375,10 @@ static void drm_test_fb_xrgb8888_to_rgb565(struct kunit *test)
 	iosys_map_set_vaddr(&src, xrgb8888);
 
 	drm_fb_xrgb8888_to_rgb565(&dst, &result->dst_pitch, &src, &fb, &params->clip, false);
-	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 
 	drm_fb_xrgb8888_to_rgb565(&dst, &result->dst_pitch, &src, &fb, &params->clip, true);
-	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected_swab, dst_size), 0);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected_swab, dst_size);
 }
 
 static void drm_test_fb_xrgb8888_to_rgb888(struct kunit *test)
@@ -408,7 +408,7 @@ static void drm_test_fb_xrgb8888_to_rgb888(struct kunit *test)
 	iosys_map_set_vaddr(&src, xrgb8888);
 
 	drm_fb_xrgb8888_to_rgb888(&dst, &result->dst_pitch, &src, &fb, &params->clip);
-	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
 static void drm_test_fb_xrgb8888_to_xrgb2101010(struct kunit *test)
@@ -439,7 +439,7 @@ static void drm_test_fb_xrgb8888_to_xrgb2101010(struct kunit *test)
 
 	drm_fb_xrgb8888_to_xrgb2101010(&dst, &result->dst_pitch, &src, &fb, &params->clip);
 	buf = le32buf_to_cpu(test, buf, TEST_BUF_SIZE);
-	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
 static struct kunit_case drm_format_helper_test_cases[] = {
diff --git a/net/core/dev_addr_lists_test.c b/net/core/dev_addr_lists_test.c
index 049cfbc58aa9..90e7e3811ae7 100644
--- a/net/core/dev_addr_lists_test.c
+++ b/net/core/dev_addr_lists_test.c
@@ -71,11 +71,11 @@ static void dev_addr_test_basic(struct kunit *test)
 
 	memset(addr, 2, sizeof(addr));
 	eth_hw_addr_set(netdev, addr);
-	KUNIT_EXPECT_EQ(test, 0, memcmp(netdev->dev_addr, addr, sizeof(addr)));
+	KUNIT_EXPECT_MEMEQ(test, netdev->dev_addr, addr, sizeof(addr));
 
 	memset(addr, 3, sizeof(addr));
 	dev_addr_set(netdev, addr);
-	KUNIT_EXPECT_EQ(test, 0, memcmp(netdev->dev_addr, addr, sizeof(addr)));
+	KUNIT_EXPECT_MEMEQ(test, netdev->dev_addr, addr, sizeof(addr));
 }
 
 static void dev_addr_test_sync_one(struct kunit *test)
-- 
2.37.3

