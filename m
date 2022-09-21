Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3125BF309
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Sep 2022 03:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiIUBpy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Sep 2022 21:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiIUBpw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Sep 2022 21:45:52 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0167AC0D;
        Tue, 20 Sep 2022 18:45:51 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4MXLpl2dFMz9sFV;
        Wed, 21 Sep 2022 01:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1663724751; bh=iFbKdVTUqU9vaOZpXdfH9jOuaXhN/xqaIIRjsRn3wOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8xbe4WI22SdXMwoOnXMr+WazwBDt+8rTFWF2sBGSfF36ogzU7PM5wS9EKRzNcWOO
         2DzzpD5FfPBUFnpjWEUo1Vt3D9kaIDk3ND7ha45sYm0GbZPLR6PUIKcBpd+XoURom3
         syIQFuxcPbKkQbwY8oTJMJE3+0/9nfc1w8xPdxdo=
X-Riseup-User-ID: D4A74AB70EA45172B4364F8A79F3A5E2D1A5FAAAFBB24C3E9C3F291F43B62EAB
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4MXLph43Yqz5vMb;
        Wed, 21 Sep 2022 01:45:48 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Brendan Higgins <brendanhiggins@google.com>, davidgow@google.com,
        Daniel Latypov <dlatypov@google.com>, daniel@ffwll.ch,
        davem@davemloft.net, kuba@kernel.org, jose.exposito89@gmail.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH v5 3/3] kunit: Use KUNIT_EXPECT_MEMEQ macro
Date:   Tue, 20 Sep 2022 22:45:15 -0300
Message-Id: <20220921014515.113062-4-mairacanal@riseup.net>
In-Reply-To: <20220921014515.113062-1-mairacanal@riseup.net>
References: <20220921014515.113062-1-mairacanal@riseup.net>
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
 drivers/gpu/drm/tests/drm_format_helper_test.c | 6 +++---
 net/core/dev_addr_lists_test.c                 | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index ab49f5e8796c..e2746429ea3e 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -219,7 +219,7 @@ static void drm_test_fb_xrgb8888_to_rgb332(struct kunit *test)
 	iosys_map_set_vaddr(&src, xrgb8888);
 
 	drm_fb_xrgb8888_to_rgb332(&dst, &result->dst_pitch, &src, &fb, &params->clip);
-	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
 static void drm_test_fb_xrgb8888_to_rgb565(struct kunit *test)
@@ -249,10 +249,10 @@ static void drm_test_fb_xrgb8888_to_rgb565(struct kunit *test)
 	iosys_map_set_vaddr(&src, xrgb8888);
 
 	drm_fb_xrgb8888_to_rgb565(&dst, &result->dst_pitch, &src, &fb, &params->clip, false);
-	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 
 	drm_fb_xrgb8888_to_rgb565(&dst, &result->dst_pitch, &src, &fb, &params->clip, true);
-	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected_swab, dst_size), 0);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected_swab, dst_size);
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

