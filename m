Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E866665EA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jan 2023 16:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjAKPDX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Jan 2023 10:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjAKPCz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Jan 2023 10:02:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9872D13E1E;
        Wed, 11 Jan 2023 07:02:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FB0661D49;
        Wed, 11 Jan 2023 15:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C121C433AC;
        Wed, 11 Jan 2023 15:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673449372;
        bh=UDpxO7rCpbkXZAOhJIiuell38ocfyxx962el9ZejsLk=;
        h=From:Date:Subject:To:Cc:From;
        b=niuLuHYV7lRffZio4EU8X6stclJYVM8Fax5gfeTpoPZKTT4sUSDHwIMAqBJCI3Ipm
         TjcTAJirj1H3BY4hkhKqJazI73G0nmgK7VHoNNMp+liZIDoy34XRflr6aPrtWrq1/m
         bdvozHRD17J0iM00g+2xcqM3iUAqCy04msWVywTqfrA3hnuWZAk6+TzaekoqXehOds
         JVcJqJR6Flbh4QBluP8dOinE27cxehBer0SgpiHxadw+iEihqbIgMgbNSVSf7/cjwb
         +HvHAIiVVmrpl7xDRnI/Bd4CHk2GrUSyqjhsGRlyruQ6o0uFY1mpBUmGce1GAau3bM
         YlLMsxgfSIb2Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 11 Jan 2023 15:02:41 +0000
Subject: [PATCH] kselftest/arm64: Limit the maximum VL we try to set via ptrace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230111-arm64-kselftest-ptrace-max-vl-v1-1-8167f41d1ad8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJHPvmMC/x2NQQ6CQAwAv0J6tglFguhXjIfuWmQDLKTdIAnh7
 y4eZw4zO5hoEINHsYPKGizMMQNdCvA9x49geGeGqqyuJREh69TUOJiMXRJLuCRlLzjxhuuIVDXS
 utq19xtBbjg2QaccfX9WvrMOp15UurD9t8/XcfwAHjZniIYAAAA=
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-8b3d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3606; i=broonie@kernel.org;
 h=from:subject:message-id; bh=UDpxO7rCpbkXZAOhJIiuell38ocfyxx962el9ZejsLk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjvs+aSkD4Zcju3QuXggplQ2pgVnRTSRJeS4Pgo67Q
 xq5i5yyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY77PmgAKCRAk1otyXVSH0N+oB/
 9dsYuRUBMPs3iARfDlyxlgKeogXBrz2h8uDlyK0xHXyk3jcf3EGJcg7l+1E1PkQ/W+7IvcU9r6Ubi+
 ddz9ZGIefA2i/b1AQh2LHWgOxcZFKV6ze3W1XGo+YCUrk1oNy12qY+eUWnDXb9om1rAPdGppaHVBH8
 yKNBQ4L3wg5qzdTOd9b0xSWpjDwYBhWBIJiTtkbx17lsZI/LU+v9y9LUY1JccTudPIYLq2YA7lX5UG
 rpdVXdeQASJHuUPEdjk5gVrjo2WPgxkKCmUnK6gkqBp9ZznlUTYbdNsegKDtj8DO6CzpJrg4VhsyfF
 +msO9L/JaQZ79fVhjxC38OjpX4rCBx
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When SVE was initially merged we chose to export the maximum VQ in the ABI
as being 512, rather more than the architecturally supported maximum of 16.
For the ptrace tests this results in us generating a lot of test cases and
hence log output which are redundant since a system couldn't possibly
support them. Instead only check values up to the current architectural
limit, plus one more so that we're covering the constraining of higher
vector lengths.

This makes no practical difference to our test coverage, speeds things up
on slower consoles and makes the output much more managable.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 14 ++++++++++++--
 tools/testing/selftests/arm64/fp/za-ptrace.c  | 14 ++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 8c4847977583..6d61992fe8a0 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -30,6 +30,16 @@
 #define NT_ARM_SSVE 0x40b
 #endif
 
+/*
+ * The architecture defines the maximum VQ as 16 but for extensibility
+ * the kernel specifies the SVE_VQ_MAX as 512 resulting in us running
+ * a *lot* more tests than are useful if we use it.  Until the
+ * architecture is extended let's limit our coverage to what is
+ * currently allowed, plus one extra to ensure we cover constraining
+ * the VL as expected.
+ */
+#define TEST_VQ_MAX 17
+
 struct vec_type {
 	const char *name;
 	unsigned long hwcap_type;
@@ -55,7 +65,7 @@ static const struct vec_type vec_types[] = {
 	},
 };
 
-#define VL_TESTS (((SVE_VQ_MAX - SVE_VQ_MIN) + 1) * 4)
+#define VL_TESTS (((TEST_VQ_MAX - SVE_VQ_MIN) + 1) * 4)
 #define FLAG_TESTS 2
 #define FPSIMD_TESTS 2
 
@@ -689,7 +699,7 @@ static int do_parent(pid_t child)
 		}
 
 		/* Step through every possible VQ */
-		for (vq = SVE_VQ_MIN; vq <= SVE_VQ_MAX; vq++) {
+		for (vq = SVE_VQ_MIN; vq <= TEST_VQ_MAX; vq++) {
 			vl = sve_vl_from_vq(vq);
 
 			/* First, try to set this vector length */
diff --git a/tools/testing/selftests/arm64/fp/za-ptrace.c b/tools/testing/selftests/arm64/fp/za-ptrace.c
index bf6158654056..ac27d87396fc 100644
--- a/tools/testing/selftests/arm64/fp/za-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/za-ptrace.c
@@ -25,7 +25,17 @@
 #define NT_ARM_ZA 0x40c
 #endif
 
-#define EXPECTED_TESTS (((SVE_VQ_MAX - SVE_VQ_MIN) + 1) * 3)
+/*
+ * The architecture defines the maximum VQ as 16 but for extensibility
+ * the kernel specifies the SVE_VQ_MAX as 512 resulting in us running
+ * a *lot* more tests than are useful if we use it.  Until the
+ * architecture is extended let's limit our coverage to what is
+ * currently allowed, plus one extra to ensure we cover constraining
+ * the VL as expected.
+ */
+#define TEST_VQ_MAX 17
+
+#define EXPECTED_TESTS (((TEST_VQ_MAX - SVE_VQ_MIN) + 1) * 3)
 
 static void fill_buf(char *buf, size_t size)
 {
@@ -301,7 +311,7 @@ static int do_parent(pid_t child)
 	ksft_print_msg("Parent is %d, child is %d\n", getpid(), child);
 
 	/* Step through every possible VQ */
-	for (vq = SVE_VQ_MIN; vq <= SVE_VQ_MAX; vq++) {
+	for (vq = SVE_VQ_MIN; vq <= TEST_VQ_MAX; vq++) {
 		vl = sve_vl_from_vq(vq);
 
 		/* First, try to set this vector length */

---
base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
change-id: 20230111-arm64-kselftest-ptrace-max-vl-126e8b4b8971

Best regards,
-- 
Mark Brown <broonie@kernel.org>
