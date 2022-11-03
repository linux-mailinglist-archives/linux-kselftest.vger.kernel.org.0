Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98551618002
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 15:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiKCOv5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 10:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiKCOvr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 10:51:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF27C1928E;
        Thu,  3 Nov 2022 07:51:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84E2FB828B3;
        Thu,  3 Nov 2022 14:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFF6C4347C;
        Thu,  3 Nov 2022 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667487103;
        bh=U21HowsYMW+tMOo5sJIGkQiIMjJyWPnB67qQL0JHuPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WKBxf0BFTFEyae+QvYY5zlJAByXXlmYcFQACMxS53FF1ajk4//2cD5lPOE8jocRur
         d/eLwgryKzT0OQPNr6VovlctGClTmfXRA1NofuwqXCzEuqROy0luaECNaTAwz2uNwX
         1GUfvK+cOUVLnKdLhEh8x7O5ITqkiWHLhoezAlayhuCnk1k7sN8e9ACv0Sw7zA6BSr
         C8DXC2Ux6RRE8Q21szPE2MqcOSHLCWgzCBWTPXGiPOXvhttMQ/yYy7DNs5vx3oRuOW
         dlgRhiazFeoiug3BAHtZPUxYU9t8eIMSHilSvs20Dy37Dt6Gfc29DxLFhuq9lqEPsf
         klTlNuSD62H5A==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1oqbZE-0076b4-0K;
        Thu, 03 Nov 2022 14:51:40 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Daniel Latypov" <dlatypov@google.com>,
        "Isabella Basso" <isabbasso@riseup.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, igt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Subject: [PATCH RFC v2 5/8] drm/i915: add live selftests to KUnit
Date:   Thu,  3 Nov 2022 14:51:35 +0000
Message-Id: <7a0221045bcec317cf8353c72f0c26cc62935273.1667486144.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667486144.git.mchehab@kernel.org>
References: <cover.1667486144.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that i915 KUnit has PCI support, add live tests as well.

NOTE: currently, some tests are failing when excecuting via
KUnit. I'll do a further investigation to check why, and if
this patch can be safely merged or not.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH RFC v2 0/8] at: https://lore.kernel.org/all/cover.1667486144.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/selftests/i915_kunit.c | 35 ++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_kunit.c b/drivers/gpu/drm/i915/selftests/i915_kunit.c
index 430610864f6e..f5281c866d75 100644
--- a/drivers/gpu/drm/i915/selftests/i915_kunit.c
+++ b/drivers/gpu/drm/i915/selftests/i915_kunit.c
@@ -177,6 +177,31 @@ static struct kunit_case i915_mock_tests[] = {
 };
 #undef selftest
 
+/*
+ * Suite 2: live selftests
+ */
+
+/* Declare selftest functions */
+#define selftest(x, __y) int __y(struct drm_i915_private *i915);
+#include "i915_live_selftests.h"
+#undef selftest
+
+/* Create selftest functions */
+#define selftest(__x, __y) 				\
+	static void live_##__x(struct kunit *test) {	\
+		run_pci_test(test, __y);		\
+	}
+#include "i915_live_selftests.h"
+#undef selftest
+
+/* Fill tests array */
+#define selftest(__x, __y) KUNIT_CASE(live_##__x),
+static struct kunit_case i915_live_tests[] = {
+#include "i915_live_selftests.h"
+	{}
+};
+#undef selftest
+
 /*
  * Declare test suites
  */
@@ -187,9 +212,17 @@ static struct kunit_suite i915_test_suites[] = {
 		.test_cases = i915_mock_tests,
 		.init = initialize_i915_selftests,
 	},
+	{
+		.name = "i915 live selftests",
+		.test_cases = i915_live_tests,
+		.init = initialize_i915_selftests,
+		.suite_init = i915_pci_init_suite,
+		.suite_exit = i915_pci_exit_suite,
+	},
 };
 
-kunit_test_suites(i915_test_suites);
+kunit_test_suites(&i915_test_suites[0],
+		  &i915_test_suites[1]);
 
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(I915_SELFTEST);
-- 
2.38.1

