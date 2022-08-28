Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03D95A3F17
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Aug 2022 20:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiH1S0s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 Aug 2022 14:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiH1S0s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 Aug 2022 14:26:48 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F866BC87;
        Sun, 28 Aug 2022 11:26:47 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4MG28j6SPTz9sCN;
        Sun, 28 Aug 2022 18:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1661711206; bh=cVZKV733FhwSJ9ann5TaxDwpk2a9uxqmV7l6k2LLnyA=;
        h=From:To:Cc:Subject:Date:From;
        b=U8giS/jsUXGNNlx9tL6PfLaLwB+1FJ2qEoArbjQEoIseotQceUjApFUtA2Xn4yEnm
         mrlawU81y2hJKRdtSo4Bm7LUOOBtFyT62u6snNDPRvcPaITBMgvMOSj29natpjuaSz
         CW7JVRAXnf13ld7OxycqXhnonyai3DfV6iGxQa4w=
X-Riseup-User-ID: 632E099168EDC2B6EA5082995449A6C79448FAD18ED28205D4B018B63EC3B43B
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4MG28b1j5Qz20SJ;
        Sun, 28 Aug 2022 18:26:39 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Gow <davidgow@google.com>, brendanhiggins@google.com,
        Arthur Grillo <arthur.grillo@usp.br>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/mm: Reduce stack frame usage in __igt_reserve
Date:   Sun, 28 Aug 2022 15:25:43 -0300
Message-Id: <20220828182543.155415-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The struct drm_mm is being allocated on the stack, which is causing the
following -Wframe-larger-than warning on ARM:

../drivers/gpu/drm/tests/drm_mm_test.c:344:12: error: stack frame size
(1064) exceeds limit (1024) in '__igt_reserve' [-Werror,-Wframe-larger-than]

static int __igt_reserve(struct kunit *test, unsigned int count, u64 size)
           ^
1 error generated.

So, fix this warning by dynamically allocating the struct drm_mm.

Fixes: fc8d29e298cf ("drm: selftest: convert drm_mm selftest to KUnit")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/tests/drm_mm_test.c | 33 ++++++++++++++++-------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_mm_test.c b/drivers/gpu/drm/tests/drm_mm_test.c
index 1e2c1aa524bd..fbd8dcbc12ee 100644
--- a/drivers/gpu/drm/tests/drm_mm_test.c
+++ b/drivers/gpu/drm/tests/drm_mm_test.c
@@ -344,7 +344,7 @@ static bool check_reserve_boundaries(struct kunit *test, struct drm_mm *mm,
 static int __igt_reserve(struct kunit *test, unsigned int count, u64 size)
 {
 	DRM_RND_STATE(prng, random_seed);
-	struct drm_mm mm;
+	struct drm_mm *mm;
 	struct drm_mm_node tmp, *nodes, *node, *next;
 	unsigned int *order, n, m, o = 0;
 	int ret, err;
@@ -366,17 +366,20 @@ static int __igt_reserve(struct kunit *test, unsigned int count, u64 size)
 	nodes = vzalloc(array_size(count, sizeof(*nodes)));
 	KUNIT_ASSERT_TRUE(test, nodes);
 
+	mm = kunit_kzalloc(test, sizeof(struct drm_mm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mm);
+
 	ret = -EINVAL;
-	drm_mm_init(&mm, 0, count * size);
+	drm_mm_init(mm, 0, count * size);
 
-	if (!check_reserve_boundaries(test, &mm, count, size))
+	if (!check_reserve_boundaries(test, mm, count, size))
 		goto out;
 
 	for (n = 0; n < count; n++) {
 		nodes[n].start = order[n] * size;
 		nodes[n].size = size;
 
-		err = drm_mm_reserve_node(&mm, &nodes[n]);
+		err = drm_mm_reserve_node(mm, &nodes[n]);
 		if (err) {
 			KUNIT_FAIL(test, "reserve failed, step %d, start %llu\n",
 				   n, nodes[n].start);
@@ -390,23 +393,23 @@ static int __igt_reserve(struct kunit *test, unsigned int count, u64 size)
 			goto out;
 		}
 
-		if (!expect_reserve_fail(test, &mm, &nodes[n]))
+		if (!expect_reserve_fail(test, mm, &nodes[n]))
 			goto out;
 	}
 
 	/* After random insertion the nodes should be in order */
-	if (!assert_continuous(test, &mm, size))
+	if (!assert_continuous(test, mm, size))
 		goto out;
 
 	/* Repeated use should then fail */
 	drm_random_reorder(order, count, &prng);
 	for (n = 0; n < count; n++) {
-		if (!expect_reserve_fail(test, &mm, set_node(&tmp, order[n] * size, 1)))
+		if (!expect_reserve_fail(test, mm, set_node(&tmp, order[n] * size, 1)))
 			goto out;
 
 		/* Remove and reinsert should work */
 		drm_mm_remove_node(&nodes[order[n]]);
-		err = drm_mm_reserve_node(&mm, &nodes[order[n]]);
+		err = drm_mm_reserve_node(mm, &nodes[order[n]]);
 		if (err) {
 			KUNIT_FAIL(test, "reserve failed, step %d, start %llu\n",
 				   n, nodes[n].start);
@@ -415,16 +418,16 @@ static int __igt_reserve(struct kunit *test, unsigned int count, u64 size)
 		}
 	}
 
-	if (!assert_continuous(test, &mm, size))
+	if (!assert_continuous(test, mm, size))
 		goto out;
 
 	/* Overlapping use should then fail */
 	for (n = 0; n < count; n++) {
-		if (!expect_reserve_fail(test, &mm, set_node(&tmp, 0, size * count)))
+		if (!expect_reserve_fail(test, mm, set_node(&tmp, 0, size * count)))
 			goto out;
 	}
 	for (n = 0; n < count; n++) {
-		if (!expect_reserve_fail(test, &mm, set_node(&tmp, size * n, size * (count - n))))
+		if (!expect_reserve_fail(test, mm, set_node(&tmp, size * n, size * (count - n))))
 			goto out;
 	}
 
@@ -437,7 +440,7 @@ static int __igt_reserve(struct kunit *test, unsigned int count, u64 size)
 
 		for (m = 0; m < n; m++) {
 			node = &nodes[order[(o + m) % count]];
-			err = drm_mm_reserve_node(&mm, node);
+			err = drm_mm_reserve_node(mm, node);
 			if (err) {
 				KUNIT_FAIL(test, "reserve failed, step %d/%d, start %llu\n",
 					   m, n, node->start);
@@ -448,15 +451,15 @@ static int __igt_reserve(struct kunit *test, unsigned int count, u64 size)
 
 		o += n;
 
-		if (!assert_continuous(test, &mm, size))
+		if (!assert_continuous(test, mm, size))
 			goto out;
 	}
 
 	ret = 0;
 out:
-	drm_mm_for_each_node_safe(node, next, &mm)
+	drm_mm_for_each_node_safe(node, next, mm)
 		drm_mm_remove_node(node);
-	drm_mm_takedown(&mm);
+	drm_mm_takedown(mm);
 	vfree(nodes);
 	kfree(order);
 err:
-- 
2.37.2

