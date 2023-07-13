Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0AD752B6E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 22:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjGMULr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 16:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjGMULq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 16:11:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C7D30CB;
        Thu, 13 Jul 2023 13:11:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93DB261B50;
        Thu, 13 Jul 2023 20:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A12C433C8;
        Thu, 13 Jul 2023 20:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689279062;
        bh=pefhisUmRsg+2EzyXrIeOHRp6qKwWRumC3ginNtyGbg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=IFrTAcPEgpsvm3EHMhXwpsqfxTmSpuqajNYjOslXWK4dh+jbHplsmrSs8Fb6BnPRu
         CP/eYAUyWRjG/clgJo6KawD8+bHtKBSRatScz+MU+zn3ba3eLIBx5ELADNKxZHETYT
         B612okPlZ36n26mv4SEQOe4elNK6vE4BfNQYE2Xiaic2aAu1VhqnHx35YmEbxICcmM
         k3sIx6dj2lYhkdfd6QfaBIjC3lsour570ZCzl2vaaPAaplL0J24rN448pwWcrwnHmR
         ZxD15ZG2avOCNBMStj97lD96phzejTBFWlG6jrKLissj6rA5wnKVR8U8artAcYi5/L
         Lcocnrmnll3Nw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 13 Jul 2023 21:06:05 +0100
Subject: [PATCH 2/3] kselftest/arm64: Add a test case for SVE VL changes
 with SME active
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-arm64-fix-sve-sme-vl-change-v1-2-129dd8611413@kernel.org>
References: <20230713-arm64-fix-sve-sme-vl-change-v1-0-129dd8611413@kernel.org>
In-Reply-To: <20230713-arm64-fix-sve-sme-vl-change-v1-0-129dd8611413@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     David Spickett <David.Spickett@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=4758; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pefhisUmRsg+2EzyXrIeOHRp6qKwWRumC3ginNtyGbg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBksFpOcK0+T8pCWAuXL/8zAm0/WFELWdgLFEWfAMyI
 3YX08uSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLBaTgAKCRAk1otyXVSH0Hi+B/
 9h4U7cnGc47k8jKeNn8cCML9cHNXsPXGEqUE1GNoIL2sW8X20OnE36eQbPm2qXE5xpYeQ1biIhue9g
 gZq7RiqwAyz4jO6vHRhjEjLLBDJkfPdNeWw0n4Ay+V4BmGAPwN8Wxwgy8NuLtis5spMxgqrZ4JaKEo
 pxgo5E/xFGMGc4yHoF2zCSFfibZTnfGVRp055aPQSR+vT6l7nP/riYdEBvhVreROazVrYncHmcJyTI
 +9GbgrNFratJ7XMUKwQrAZ1JiPtEQBJlTkVlHGCdtFMDhlTD0h2T+9J3oqopAAyHfoxNLV9lHDbGML
 5daepMDk/Di9fa3vXuOOBgrXXunnvA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We just fixed an issue where changing the SVE VL while SME was active could
result in us attempting to save the streaming mode SVE vectors without any
backing storage. Add a test case which provokes that issue, ideally we
should also verify that the contents of ZA are unaffected by any of what we
did.

Note that since we need to keep streaming mode enabled we can't use any
syscalls to trigger the issue, we have to sit in a loop in usersapce and
hope to be preempted. The chosen numbers trigger with defconfig on all the
virtual platforms for me, this won't be 100% on all systems but avoid an
overcomplicated test implementation.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 105 +++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c b/tools/testing/selftests/arm64/fp/vec-syscfg.c
index 9bcfcdc34ee9..58ea4bde5be7 100644
--- a/tools/testing/selftests/arm64/fp/vec-syscfg.c
+++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
@@ -6,6 +6,7 @@
 #include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <stdbool.h>
 #include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -39,9 +40,11 @@ struct vec_data {
 	int max_vl;
 };
 
+#define VEC_SVE 0
+#define VEC_SME 1
 
 static struct vec_data vec_data[] = {
-	{
+	[VEC_SVE] = {
 		.name = "SVE",
 		.hwcap_type = AT_HWCAP,
 		.hwcap = HWCAP_SVE,
@@ -51,7 +54,7 @@ static struct vec_data vec_data[] = {
 		.prctl_set = PR_SVE_SET_VL,
 		.default_vl_file = "/proc/sys/abi/sve_default_vector_length",
 	},
-	{
+	[VEC_SME] = {
 		.name = "SME",
 		.hwcap_type = AT_HWCAP2,
 		.hwcap = HWCAP2_SME,
@@ -644,18 +647,107 @@ static const test_type tests[] = {
 	prctl_set_all_vqs,
 };
 
+static inline void smstart(void)
+{
+	asm volatile("msr S0_3_C4_C7_3, xzr");
+}
+
+static inline void smstart_sm(void)
+{
+	asm volatile("msr S0_3_C4_C3_3, xzr");
+}
+
+static inline void smstop(void)
+{
+	asm volatile("msr S0_3_C4_C6_3, xzr");
+}
+
+
+/*
+ * Verify we can change the SVE vector length while SME is active and
+ * continue to use SME afterwards.
+ */
+static void change_sve_with_za(void)
+{
+	struct vec_data *sve_data = &vec_data[VEC_SVE];
+	bool pass = true;
+	int ret, i;
+
+	if (sve_data->min_vl == sve_data->max_vl) {
+		ksft_print_msg("Only one SVE VL supported, can't change\n");
+		ksft_test_result_skip("change_sve_while_sme\n");
+		return;
+	}
+
+	/* Ensure we will trigger a change when we set the maximum */
+	ret = prctl(sve_data->prctl_set, sve_data->min_vl);
+	if (ret != sve_data->min_vl) {
+		ksft_print_msg("Failed to set SVE VL %d: %d\n",
+			       sve_data->min_vl, ret);
+		pass = false;
+	}
+
+	/* Enable SM and ZA */
+	smstart();
+
+	/* Trigger another VL change */
+	ret = prctl(sve_data->prctl_set, sve_data->max_vl);
+	if (ret != sve_data->max_vl) {
+		ksft_print_msg("Failed to set SVE VL %d: %d\n",
+			       sve_data->max_vl, ret);
+		pass = false;
+	}
+
+	/*
+	 * Spin for a bit with SM enabled to try to trigger another
+	 * save/restore.  We can't use syscalls without exiting
+	 * streaming mode.
+	 */
+	for (i = 0; i < 100000000; i++)
+		smstart_sm();
+
+	/*
+	 * TODO: Verify that ZA was preserved over the VL change and
+	 * spin.
+	 */
+
+	/* Clean up after ourselves */
+	smstop();
+	ret = prctl(sve_data->prctl_set, sve_data->default_vl);
+	if (ret != sve_data->default_vl) {
+	        ksft_print_msg("Failed to restore SVE VL %d: %d\n",
+			       sve_data->default_vl, ret);
+		pass = false;
+	}
+
+	ksft_test_result(pass, "change_sve_with_za\n");
+}
+
+typedef void (*test_all_type)(void);
+
+static const struct {
+	const char *name;
+	test_all_type test;
+}  all_types_tests[] = {
+	{ "change_sve_with_za", change_sve_with_za },
+};
+
 int main(void)
 {
+	bool all_supported = true;
 	int i, j;
 
 	ksft_print_header();
-	ksft_set_plan(ARRAY_SIZE(tests) * ARRAY_SIZE(vec_data));
+	ksft_set_plan(ARRAY_SIZE(tests) * ARRAY_SIZE(vec_data) +
+		      ARRAY_SIZE(all_types_tests));
 
 	for (i = 0; i < ARRAY_SIZE(vec_data); i++) {
 		struct vec_data *data = &vec_data[i];
 		unsigned long supported;
 
 		supported = getauxval(data->hwcap_type) & data->hwcap;
+		if (!supported)
+			all_supported = false;
 
 		for (j = 0; j < ARRAY_SIZE(tests); j++) {
 			if (supported)
@@ -666,5 +758,12 @@ int main(void)
 		}
 	}
 
+	for (i = 0; i < ARRAY_SIZE(all_types_tests); i++) {
+		if (all_supported)
+			all_types_tests[i].test();
+		else
+			ksft_test_result_skip("%s\n", all_types_tests[i].name);
+	}
+
 	ksft_exit_pass();
 }

-- 
2.30.2

