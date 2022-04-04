Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673834F11A7
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Apr 2022 11:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349477AbiDDJIa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Apr 2022 05:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346223AbiDDJI0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Apr 2022 05:08:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24A63BA61
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Apr 2022 02:06:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C96761252
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Apr 2022 09:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1843FC34112;
        Mon,  4 Apr 2022 09:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649063189;
        bh=a4jTOkRQpJP6+3na2bi7YpmqAd5XXyn7buPNcfTQ1WE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+oZlCxkNMpQKAOlHkdZnT0qUTDjKnqAtPys0wFfICS44T/k13Sn04Y9D7X7rf1Jj
         uLm4+P/yEOY8B/OJUNrEt74ZRR9SOpKMYUa6ZuCMJJW4zqNcNNzF0t6L77HpFTZrqX
         melQuKI5XgKk55kFjjK4JZFkIh+DyDdWaoOsvVAXdY5zrxdMA0pORVqfYCVjUwoxgX
         pky/ZCnH3eehRFOmhOCWbgiJ8c/DhpHqCBORBQd2iSorHd+JFk7STVafOVvfTyJS8n
         K4wr8aM9JOFdMSAVNR8OO2l0XG/UJzJiLBhRKqO4xVN+OU5MLsyiGsdpwsmEvpdGEh
         C/+ac37sI5MLQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/3] kselftest/arm64: Remove assumption that tasks start FPSIMD only
Date:   Mon,  4 Apr 2022 10:06:12 +0100
Message-Id: <20220404090613.181272-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404090613.181272-1-broonie@kernel.org>
References: <20220404090613.181272-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3717; h=from:subject; bh=a4jTOkRQpJP6+3na2bi7YpmqAd5XXyn7buPNcfTQ1WE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiSrUB2Yj2qaE22cbeGjQpnhdqs87ucVV8by5rRUVN s+bZuxeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYkq1AQAKCRAk1otyXVSH0HcIB/ 4yo8lPRrVzFAnelE/fFyAoL2rrArx3J0hwCcyOQxZ2fvarKxUmanOohVVqVg1daP9WZ4QMi5tXIqlm 6yHjjC8eFZk+DV/W4HgtIvrV/NQE7fYFdvVlFf+V0PpM9F5DJIUA4IvEVIQ0S8ivqcXKUNk+w0ocHG 3QrKZlrc5bsMWIrv45btKR23PkO6ofQJvyhoymbqUOJcaPhto/h72phiRfvkRshUp7X7iYiY6cHKeT RsupYZfwP5YvfxcAiJljTXSCt0DmE3udxeuXxE90kGm7vdAsa9S99i/iWfYTdz1BD0GzgWN8yCwsOY YKRf5vlPn5T8x8JxRFcgFvybJpYKrM
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the sve-ptrace test for setting and reading FPSIMD data assumes
that the child will start off in FPSIMD only mode and that it can use this
to read some FPSIMD mode SVE ptrace data, skipping the test if it can't.
This isn't an assumption guaranteed by the ABI and also limits how we can
use this testcase within the program. Instead skip the initial read and
just generate a FPSIMD format buffer for the write part of the test, making
the coverage more robust in the face of future kernel and test program
changes.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 39 ++++++++-----------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 7682798adbba..8f6146d89ca4 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -46,7 +46,7 @@ static const struct vec_type vec_types[] = {
 
 #define VL_TESTS (((SVE_VQ_MAX - SVE_VQ_MIN) + 1) * 3)
 #define FLAG_TESTS 2
-#define FPSIMD_TESTS 3
+#define FPSIMD_TESTS 2
 
 #define EXPECTED_TESTS ((VL_TESTS + FLAG_TESTS + FPSIMD_TESTS) * ARRAY_SIZE(vec_types))
 
@@ -240,28 +240,24 @@ static void check_u32(unsigned int vl, const char *reg,
 /* Access the FPSIMD registers via the SVE regset */
 static void ptrace_sve_fpsimd(pid_t child, const struct vec_type *type)
 {
-	void *svebuf = NULL;
-	size_t svebufsz = 0;
+	void *svebuf;
 	struct user_sve_header *sve;
 	struct user_fpsimd_state *fpsimd, new_fpsimd;
 	unsigned int i, j;
 	unsigned char *p;
+	int ret;
 
-	/* New process should start with FPSIMD registers only */
-	sve = get_sve(child, type, &svebuf, &svebufsz);
-	if (!sve) {
-		ksft_test_result_fail("get_sve(%s): %s\n",
-				      type->name, strerror(errno));
-
+	svebuf = malloc(SVE_PT_SIZE(0, SVE_PT_REGS_FPSIMD));
+	if (!svebuf) {
+		ksft_test_result_fail("Failed to allocate FPSIMD buffer\n");
 		return;
-	} else {
-		ksft_test_result_pass("get_sve(%s FPSIMD)\n", type->name);
 	}
 
-	ksft_test_result((sve->flags & SVE_PT_REGS_MASK) == SVE_PT_REGS_FPSIMD,
-			 "Got FPSIMD registers via %s\n", type->name);
-	if ((sve->flags & SVE_PT_REGS_MASK) != SVE_PT_REGS_FPSIMD)
-		goto out;
+	memset(svebuf, 0, SVE_PT_SIZE(0, SVE_PT_REGS_FPSIMD));
+	sve = svebuf;
+	sve->flags = SVE_PT_REGS_FPSIMD;
+	sve->size = SVE_PT_SIZE(0, SVE_PT_REGS_FPSIMD);
+	sve->vl = 16;  /* We don't care what the VL is */
 
 	/* Try to set a known FPSIMD state via PT_REGS_SVE */
 	fpsimd = (struct user_fpsimd_state *)((char *)sve +
@@ -273,12 +269,11 @@ static void ptrace_sve_fpsimd(pid_t child, const struct vec_type *type)
 			p[j] = j;
 	}
 
-	if (set_sve(child, type, sve)) {
-		ksft_test_result_fail("set_sve(%s FPSIMD): %s\n",
-				      type->name, strerror(errno));
-
+	ret = set_sve(child, type, sve);
+	ksft_test_result(ret == 0, "%s FPSIMD set via SVE: %d\n",
+			 type->name, ret);
+	if (ret)
 		goto out;
-	}
 
 	/* Verify via the FPSIMD regset */
 	if (get_fpsimd(child, &new_fpsimd)) {
@@ -548,11 +543,9 @@ static int do_parent(pid_t child)
 		if (getauxval(vec_types[i].hwcap_type) & vec_types[i].hwcap) {
 			ptrace_sve_fpsimd(child, &vec_types[i]);
 		} else {
-			ksft_test_result_skip("%s FPSIMD get via SVE\n",
-					      vec_types[i].name);
 			ksft_test_result_skip("%s FPSIMD set via SVE\n",
 					      vec_types[i].name);
-			ksft_test_result_skip("%s set read via FPSIMD\n",
+			ksft_test_result_skip("%s FPSIMD read\n",
 					      vec_types[i].name);
 		}
 
-- 
2.30.2

