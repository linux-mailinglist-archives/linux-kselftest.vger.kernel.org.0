Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A641A618005
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 15:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiKCOv6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 10:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiKCOvr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 10:51:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0AD19280;
        Thu,  3 Nov 2022 07:51:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E4C0B828A3;
        Thu,  3 Nov 2022 14:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B011C433D6;
        Thu,  3 Nov 2022 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667487103;
        bh=aBiqaKM+JH7n4Gr1RSbFfPLj/Tspjy42oxH/2AtYZuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PP8D6vwogDrReAZBrJYHfHbN3jPMgkwi0GC7tzE4b9IRuXDaDUuqHYaeCcN530tOe
         PyvNLDEV0NFmWvGqPxyGAMECDo5Lt7AvoSA3W+c6+XTl1n7H4+OhnbbJvthYt/4PFy
         6pnuhVSRNApVh7R/N1J7FvSd4loBmbFkXDMSsaSvuYoBMg877oxTWEHsvW2I2qQDtX
         4OD8Ii7cKGxmJuuZFi1OjZXSl3Qvx9/Rn3aYjn3s3jvpHQpmqCI9KyWn9qdQaQ0duO
         m+OhBzFHhUpZGsyLN80DWjoS5V1yP3QBNGuwhwcIaCsQcVyoELKsCRB4uFUJ4XCHdO
         wvw6tu6AwLDSQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1oqbZE-0076b7-0O;
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
Subject: [PATCH RFC v2 6/8] drm/i915: add perf selftests to KUnit
Date:   Thu,  3 Nov 2022 14:51:36 +0000
Message-Id: <048d54e7e5718ba6c7606be61482cedd7cb92dfd.1667486144.git.mchehab@kernel.org>
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

Now that i915 KUnit has PCI support, add perf tests as well.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH RFC v2 0/8] at: https://lore.kernel.org/all/cover.1667486144.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/selftests/i915_kunit.c | 34 ++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_kunit.c b/drivers/gpu/drm/i915/selftests/i915_kunit.c
index f5281c866d75..6de5d3fa8920 100644
--- a/drivers/gpu/drm/i915/selftests/i915_kunit.c
+++ b/drivers/gpu/drm/i915/selftests/i915_kunit.c
@@ -202,6 +202,30 @@ static struct kunit_case i915_live_tests[] = {
 };
 #undef selftest
 
+/*
+ * Suite 3: live selftests
+ */
+
+#define selftest(x, __y) int __y(struct drm_i915_private *i915);
+#include "i915_perf_selftests.h"
+#undef selftest
+
+/* Create selftest functions */
+#define selftest(__x, __y)				\
+	static void perf_##__x(struct kunit *test) {	\
+		run_pci_test(test, __y);		\
+	}
+#include "i915_perf_selftests.h"
+#undef selftest
+
+/* Fill tests array */
+#define selftest(__x, __y) KUNIT_CASE(perf_##__x),
+static struct kunit_case i915_perf_tests[] = {
+#include "i915_perf_selftests.h"
+	{}
+};
+#undef selftest
+
 /*
  * Declare test suites
  */
@@ -219,10 +243,18 @@ static struct kunit_suite i915_test_suites[] = {
 		.suite_init = i915_pci_init_suite,
 		.suite_exit = i915_pci_exit_suite,
 	},
+	{
+		.name = "i915 perf selftests",
+		.test_cases = i915_perf_tests,
+		.init = initialize_i915_selftests,
+		.suite_init = i915_pci_init_suite,
+		.suite_exit = i915_pci_exit_suite,
+	},
 };
 
 kunit_test_suites(&i915_test_suites[0],
-		  &i915_test_suites[1]);
+		  &i915_test_suites[1],
+		  &i915_test_suites[2]);
 
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(I915_SELFTEST);
-- 
2.38.1

