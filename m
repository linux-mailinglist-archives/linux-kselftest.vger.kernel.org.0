Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9210D5A50AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 17:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiH2Pvd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 11:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiH2Pvc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 11:51:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F3C8A6FA
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 08:51:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3C38611C6
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 15:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB809C433D6;
        Mon, 29 Aug 2022 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661788290;
        bh=5JvLo0UnJeyCZ1yxO1+Xnv5AbjhocOYtyL3ng59uNM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CIxfyRixFzSP4Ukr2U48e+cIQMszx0z6HA1ZpkORTNAhgf8Fjc3zkKTotstfMa7jC
         TYA6EWw8TYJ1kP7V523k0jDyvsE9937aaeof898PEl4naH+sCMkfIOWAeJ98e9atTY
         HhWdWBr9AklL3in/awMUYDdrHbYyi9jsmkn7J9BXT9gYEjb+hcQKBtD1NR89lsc7bh
         p+F1Onu/3yeoRqiYLMLjB1mnLkj4pj0p5CYp+khNbE7kFzj869A74k8LXcDLt79PjM
         KYpCs3jKrzKnpRgHyyRe77GmtqBRZUvEnigUc9xvvGjuQvEu0UP6mRnRd65GW8PhNE
         fgBKorBImPFdg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 4/4] kselftest/arm64: Add coverage of TPIDR2_EL0 ptrace interface
Date:   Mon, 29 Aug 2022 16:49:21 +0100
Message-Id: <20220829154921.837871-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829154921.837871-1-broonie@kernel.org>
References: <20220829154921.837871-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3913; i=broonie@kernel.org; h=from:subject; bh=5JvLo0UnJeyCZ1yxO1+Xnv5AbjhocOYtyL3ng59uNM8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDOAAB28b/VVGFj2CZ8OO+K9TBKMw+RoDC2fFs8kM irPZVW6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzgAAAKCRAk1otyXVSH0Mz0B/ 4r5JX6xz2NggAebmjtdpJ8fIalwxptGK5c+xWCVUu0KF2EUmvcGkWM659dLrIWPHvT+ttV3ysPnTp0 q6XLqd739g5orSIBJtZ9hnjDYVp6EpUtqCS9F4D0qb9/O5z+6O3h49uOMK17NWFOGT74swCL/8UWL4 zRpdLQME07BqU7TUTzh8Rocezgh80NGZgzUy9zmfz/V4u5bf/qmZ/UjgLUHQQ59K2r3p0FpmMe7WqC spF3A98qQvfQx41iRAbBMsIQlJgjP0g9u7eXmg+xvpXcItFnAPYJV0ILIkvI8LYQeejYKWCYHHVezY zI8GtET/pq5aDToqe3kCJr7/pnzWHY
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

Extend the ptrace test support for NT_ARM_TLS to cover TPIDR2_EL0 - on
systems that support SME the NT_ARM_TLS regset can be up to 2 elements
long with the second element containing TPIDR2_EL0. On systems
supporting SME we verify that this value can be read and written while
on systems that do not support SME we verify correct truncation of reads
and writes.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/ptrace.c | 82 +++++++++++++++++++++-
 1 file changed, 79 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/ptrace.c b/tools/testing/selftests/arm64/abi/ptrace.c
index a74157dcc4fc..be952511af22 100644
--- a/tools/testing/selftests/arm64/abi/ptrace.c
+++ b/tools/testing/selftests/arm64/abi/ptrace.c
@@ -20,9 +20,9 @@
 
 #include "../../kselftest.h"
 
-#define EXPECTED_TESTS 3
+#define EXPECTED_TESTS 7
 
-#define MAX_TPIDRS 1
+#define MAX_TPIDRS 2
 
 static bool have_sme(void)
 {
@@ -34,7 +34,8 @@ static void test_tpidr(pid_t child)
 	uint64_t read_val[MAX_TPIDRS];
 	uint64_t write_val[MAX_TPIDRS];
 	struct iovec read_iov, write_iov;
-	int ret;
+	bool test_tpidr2 = false;
+	int ret, i;
 
 	read_iov.iov_base = read_val;
 	write_iov.iov_base = write_val;
@@ -54,6 +55,81 @@ static void test_tpidr(pid_t child)
 	ret = ptrace(PTRACE_GETREGSET, child, NT_ARM_TLS, &read_iov);
 	ksft_test_result(ret == 0 && write_val[0] == read_val[0],
 			 "verify_tpidr_one\n");
+
+	/* If we have TPIDR2 we should be able to read it */
+	read_iov.iov_len = sizeof(read_val);
+	ret = ptrace(PTRACE_GETREGSET, child, NT_ARM_TLS, &read_iov);
+	if (ret == 0) {
+		/* If we have SME there should be two TPIDRs */
+		if (read_iov.iov_len >= sizeof(read_val))
+			test_tpidr2 = true;
+
+		if (have_sme() && test_tpidr2) {
+			ksft_test_result(test_tpidr2, "count_tpidrs\n");
+		} else {
+			ksft_test_result(read_iov.iov_len % sizeof(uint64_t) == 0,
+					 "count_tpidrs\n");
+		}
+	} else {
+		ksft_test_result_fail("count_tpidrs\n");
+	}
+
+	if (test_tpidr2) {
+		/* Try to write new values to all known TPIDRs... */
+		write_iov.iov_len = sizeof(write_val);
+		for (i = 0; i < MAX_TPIDRS; i++)
+			write_val[i] = read_val[i] + 1;
+		ret = ptrace(PTRACE_SETREGSET, child, NT_ARM_TLS, &write_iov);
+
+		ksft_test_result(ret == 0 &&
+				 write_iov.iov_len == sizeof(write_val),
+				 "tpidr2_write\n");
+
+		/* ...then read them back */
+		read_iov.iov_len = sizeof(read_val);
+		ret = ptrace(PTRACE_GETREGSET, child, NT_ARM_TLS, &read_iov);
+
+		if (have_sme()) {
+			/* Should read back the written value */
+			ksft_test_result(ret == 0 &&
+					 read_iov.iov_len >= sizeof(read_val) &&
+					 memcmp(read_val, write_val,
+						sizeof(read_val)) == 0,
+					 "tpidr2_read\n");
+		} else {
+			/* TPIDR2 should read as zero */
+			ksft_test_result(ret == 0 &&
+					 read_iov.iov_len >= sizeof(read_val) &&
+					 read_val[0] == write_val[0] &&
+					 read_val[1] == 0,
+					 "tpidr2_read\n");
+		}
+
+		/* Writing only TPIDR... */
+		write_iov.iov_len = sizeof(uint64_t);
+		memcpy(write_val, read_val, sizeof(read_val));
+		write_val[0] += 1;
+		ret = ptrace(PTRACE_SETREGSET, child, NT_ARM_TLS, &write_iov);
+
+		if (ret == 0) {
+			/* ...should leave TPIDR2 untouched */
+			read_iov.iov_len = sizeof(read_val);
+			ret = ptrace(PTRACE_GETREGSET, child, NT_ARM_TLS,
+				     &read_iov);
+
+			ksft_test_result(ret == 0 &&
+					 read_iov.iov_len >= sizeof(read_val) &&
+					 memcmp(read_val, write_val,
+						sizeof(read_val)) == 0,
+					 "write_tpidr_only\n");
+		} else {
+			ksft_test_result_fail("write_tpidr_only\n");
+		}
+	} else {
+		ksft_test_result_skip("tpidr2_write\n");
+		ksft_test_result_skip("tpidr2_read\n");
+		ksft_test_result_skip("write_tpidr_only\n");
+	}
 }
 
 static int do_child(void)
-- 
2.30.2

