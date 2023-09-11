Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F0379BE81
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 02:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345049AbjIKVTT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbjIKJvW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 05:51:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91150E44;
        Mon, 11 Sep 2023 02:51:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B657AC433CC;
        Mon, 11 Sep 2023 09:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694425878;
        bh=n39qjqZdna7s4aCBSr+Q6tsGFUv34ZNjq8iqqrLVaKg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ZeoL1/kUHKOlVAzAFsVO97NPTxM/vmkW9yVfZFiR7o1ir8KqlTcCKnnGOvOxGMFA0
         1tcvRhd6AKrG1u0bppmbD9BDjzcPOunJoNxUTiz4Q2V7TBEjMbIUwr83faKGyMXaLP
         RWCayMzbaJakOFimPqacGJy2Ps06jwL00JapzLZv+FQp7ZVAIdAUSuby0PutrABk0F
         iIOW4oCXAx+nUV8YpDAvH4G6xX1m8EOLmU8J8gjzhwsE5dmpbaIfDgiaZhQawRObNh
         rI3rj8bGYwR/5+ICGViQHgSbv9/78FuSSPPotKUFxVpBvNa4K7L1kY2z/yFf+X1asy
         MZHABQZ8oeX+A==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Mon, 11 Sep 2023 11:51:06 +0200
Subject: [PATCH 2/2] drm/tests: Flag slow tests as such
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-kms-slow-tests-v1-2-d3800a69a1a1@kernel.org>
References: <20230911-kms-slow-tests-v1-0-d3800a69a1a1@kernel.org>
In-Reply-To: <20230911-kms-slow-tests-v1-0-d3800a69a1a1@kernel.org>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2575; i=mripard@kernel.org;
 h=from:subject:message-id; bh=n39qjqZdna7s4aCBSr+Q6tsGFUv34ZNjq8iqqrLVaKg=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCn/HvP+StiTeqav+O31b0s/Zr3nt3v7ospZ+nn9k8cXz
 v6TvxZ1uKOUhUGMi0FWTJElRth8SdypWa872fjmwcxhZQIZwsDFKQATcQpm+F+yMnequ1KKWpCB
 Y4tZ8Jnt2qoahce5T3wV/6Z/g/nwQ25GhoPChiud5wusvn6/eyu7H/+C9SdnvD4jsK+ielv13/s
 2T/kA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kunit recently gained a speed attribute that allows to filter out slow
tests. A slow test is defined in the documentation as a test taking more
than a second to execute.

Let's flag the few tests that are doing so on my machine when running:

./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/tests \
	--cross_compile aarch64-linux-gnu- --arch arm64

Suggested-by: David Gow <davidgow@google.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_buddy_test.c |  2 +-
 drivers/gpu/drm/tests/drm_mm_test.c    | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
index 09ee6f6af896..6f79cde2df55 100644
--- a/drivers/gpu/drm/tests/drm_buddy_test.c
+++ b/drivers/gpu/drm/tests/drm_buddy_test.c
@@ -742,7 +742,7 @@ static struct kunit_case drm_buddy_tests[] = {
 	KUNIT_CASE(drm_test_buddy_alloc_range),
 	KUNIT_CASE(drm_test_buddy_alloc_optimistic),
 	KUNIT_CASE(drm_test_buddy_alloc_pessimistic),
-	KUNIT_CASE(drm_test_buddy_alloc_smoke),
+	KUNIT_CASE_SLOW(drm_test_buddy_alloc_smoke),
 	KUNIT_CASE(drm_test_buddy_alloc_pathological),
 	{}
 };
diff --git a/drivers/gpu/drm/tests/drm_mm_test.c b/drivers/gpu/drm/tests/drm_mm_test.c
index 186b28dc7038..c1e662c2a76c 100644
--- a/drivers/gpu/drm/tests/drm_mm_test.c
+++ b/drivers/gpu/drm/tests/drm_mm_test.c
@@ -2228,23 +2228,23 @@ module_param(max_prime, uint, 0400);
 static struct kunit_case drm_mm_tests[] = {
 	KUNIT_CASE(drm_test_mm_init),
 	KUNIT_CASE(drm_test_mm_debug),
-	KUNIT_CASE(drm_test_mm_reserve),
-	KUNIT_CASE(drm_test_mm_insert),
-	KUNIT_CASE(drm_test_mm_replace),
-	KUNIT_CASE(drm_test_mm_insert_range),
+	KUNIT_CASE_SLOW(drm_test_mm_reserve),
+	KUNIT_CASE_SLOW(drm_test_mm_insert),
+	KUNIT_CASE_SLOW(drm_test_mm_replace),
+	KUNIT_CASE_SLOW(drm_test_mm_insert_range),
 	KUNIT_CASE(drm_test_mm_frag),
 	KUNIT_CASE(drm_test_mm_align),
 	KUNIT_CASE(drm_test_mm_align32),
 	KUNIT_CASE(drm_test_mm_align64),
-	KUNIT_CASE(drm_test_mm_evict),
+	KUNIT_CASE_SLOW(drm_test_mm_evict),
 	KUNIT_CASE(drm_test_mm_evict_range),
 	KUNIT_CASE(drm_test_mm_topdown),
 	KUNIT_CASE(drm_test_mm_bottomup),
 	KUNIT_CASE(drm_test_mm_lowest),
 	KUNIT_CASE(drm_test_mm_highest),
 	KUNIT_CASE(drm_test_mm_color),
-	KUNIT_CASE(drm_test_mm_color_evict),
-	KUNIT_CASE(drm_test_mm_color_evict_range),
+	KUNIT_CASE_SLOW(drm_test_mm_color_evict),
+	KUNIT_CASE_SLOW(drm_test_mm_color_evict_range),
 	{}
 };
 

-- 
2.41.0

