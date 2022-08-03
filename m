Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC4B58943B
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Aug 2022 23:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbiHCV7a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Aug 2022 17:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238501AbiHCV72 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Aug 2022 17:59:28 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513EC5C9D6;
        Wed,  3 Aug 2022 14:59:27 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4Lym3f4tmrz9t4M;
        Wed,  3 Aug 2022 21:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659563966; bh=46QMNNu+FK8isynfWdGkGqc+HS477sp2/1QXbvEgpxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lwKy0nEglZFjSrWXbCi+YN3PgxPSU54SKWCfW0GdbtSrKpbGhjKsq34U29UBrAIJ4
         cJSIzAxnHVl0CimnwMxd5lksKmH/p0BN5TuHnyX7TWEDjlqONoolucf8xBFVHN9/gz
         kmLdLAfsOamGY0mxo/jP6D6vr/OjdnKeyrlDPIHg=
X-Riseup-User-ID: 932639AD08357356C2A742C45BE4863C0B8E1F17DB734F891B927579ABF1588D
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4Lym3Z104Sz1ySb;
        Wed,  3 Aug 2022 21:59:21 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Brendan Higgins <brendanhiggins@google.com>, davidgow@google.com,
        Daniel Latypov <dlatypov@google.com>, airlied@linux.ie,
        daniel@ffwll.ch, davem@davemloft.net, kuba@kernel.org,
        jose.exposito89@gmail.com, javierm@redhat.com
Cc:     andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH v3 3/3] kunit: Use KUNIT_EXPECT_MEMEQ macro
Date:   Wed,  3 Aug 2022 18:58:55 -0300
Message-Id: <20220803215855.258704-4-mairacanal@riseup.net>
In-Reply-To: <20220803215855.258704-1-mairacanal@riseup.net>
References: <20220803215855.258704-1-mairacanal@riseup.net>
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
---
v1 -> v2:
- Change the macro KUNIT_EXPECT_ARREQ to KUNIT_EXPECT_MEMEQ, in order to make
it easier for users to infer the right size unit (Daniel Latypov).

v2 -> v3: No changes.
---
 drivers/gpu/drm/tests/drm_format_helper_test.c | 6 +++---
 net/core/dev_addr_lists_test.c                 | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 26ecf3b4b137..482136282273 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -217,7 +217,7 @@ static void xrgb8888_to_rgb332_test(struct kunit *test)

 	drm_fb_xrgb8888_to_rgb332(dst, result->dst_pitch, src, &fb,
 				  &params->clip);
-	KUNIT_EXPECT_EQ(test, memcmp(dst, result->expected, dst_size), 0);
+	KUNIT_EXPECT_MEMEQ(test, dst, result->expected, dst_size);
 }

 static void xrgb8888_to_rgb565_test(struct kunit *test)
@@ -245,11 +245,11 @@ static void xrgb8888_to_rgb565_test(struct kunit *test)

 	drm_fb_xrgb8888_to_rgb565(dst, result->dst_pitch, src, &fb,
 				  &params->clip, false);
-	KUNIT_EXPECT_EQ(test, memcmp(dst, result->expected, dst_size), 0);
+	KUNIT_EXPECT_MEMEQ(test, dst, result->expected, dst_size);

 	drm_fb_xrgb8888_to_rgb565(dst, result->dst_pitch, src, &fb,
 				  &params->clip, true);
-	KUNIT_EXPECT_EQ(test, memcmp(dst, result->expected_swab, dst_size), 0);
+	KUNIT_EXPECT_MEMEQ(test, dst, result->expected_swab, dst_size);
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
2.37.1

