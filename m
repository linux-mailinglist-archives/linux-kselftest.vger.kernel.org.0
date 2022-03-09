Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC544D2E8D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 13:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbiCIMBL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 07:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiCIMBJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 07:01:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D213A101F0F
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 04:00:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E240B8210E
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 12:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15488C340F3;
        Wed,  9 Mar 2022 12:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646827207;
        bh=2E7uIWYZCN8xmFIKClu5aTL1Cz8xGvqQNKDpgLwojB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YIaPG2itm+d1Cq3Hsu3ishi6xLMK+D2Nl/7QfUq1tiTsuLeIbRoT61oAf1GP+y2Jl
         AcjharWr1bEGsfTj9iPioy+6BuRlntL+X/nW+kwqP/yMYATrw29c7qnvjVPjjMPh06
         qL/FYJlmdBdcC31x2SSxrm6IsH39rL4AO4w8wEZutVtTBXXlFWOqnTxjYhd1chg9Rv
         MiG4xIbkOgSpnMmtbXGzYEJc4qTR8RScVXt7VNuPX+/2z6xu0BilZU5TDyIqgiWK2k
         q8AYIZw9N6VVwcn9+ywlIgBRaDNudtJuWKCbdYyiG3Iz/YiMyyhy+ry/rBtFeG1Wuu
         iCsgFV1JHAlZg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/3] kselftest/arm64: Remove assumption that tasks start FPSIMD only
Date:   Wed,  9 Mar 2022 11:59:17 +0000
Message-Id: <20220309115918.22469-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220309115918.22469-1-broonie@kernel.org>
References: <20220309115918.22469-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3664; h=from:subject; bh=2E7uIWYZCN8xmFIKClu5aTL1Cz8xGvqQNKDpgLwojB0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiKJaU0Ers4ZA/fEotvJMU9VjcJZERn1z0mR+qPTRR CTXvcfiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYiiWlAAKCRAk1otyXVSH0C/0B/ 9BkdjiX2NsN2ez4+qj7rn2gEkXLmjPgXPoUBtlam3O1FOb/BHpKg6C3UN2V0jneFGeMCQPZWfxbFvS KrzGCBrDjSWN0dDLvj/9I3O3/Ntb0ddoqI/2d89AGd+YRj9PUFSvD0kHApY0pBwub3sFajH2nHZhbP s3KHBRmCIU3Kgh93sUHLQhSaUTbXt8e+fgcCDwdvwCDpIqyJ+J3UOjIjtJKXostXbXcRkhQsSeEYIW VnK828iLsn7Ur6ysBjYfTx3m6wX+Hw2AbiZfQuK2w8N1NpaGQ6CJEG0moqC97LN4jIeC4F8mJlOB0M BGDV3VdZERE/C7FfsmfQOqNjUCU+1Y
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 39 ++++++++-----------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 6b139d5f67f1..ccd3ff1e8c06 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -48,7 +48,7 @@ static const struct vec_type vec_types[] = {
 
 #define VL_TESTS (((SVE_VQ_MAX - SVE_VQ_MIN) + 1) * 3)
 #define FLAG_TESTS 2
-#define FPSIMD_TESTS 3
+#define FPSIMD_TESTS 2
 
 #define EXPECTED_TESTS ((VL_TESTS + FLAG_TESTS + FPSIMD_TESTS) * ARRAY_SIZE(vec_types))
 
@@ -242,28 +242,24 @@ static void check_u32(unsigned int vl, const char *reg,
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
@@ -275,12 +271,11 @@ static void ptrace_sve_fpsimd(pid_t child, const struct vec_type *type)
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

