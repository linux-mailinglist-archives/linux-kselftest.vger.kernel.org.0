Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5B35989BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 19:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345231AbiHRRJH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 13:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345249AbiHRRHG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 13:07:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC2ECCE1B
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Aug 2022 10:02:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E054B82230
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Aug 2022 17:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51539C43140;
        Thu, 18 Aug 2022 17:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660842122;
        bh=5JvLo0UnJeyCZ1yxO1+Xnv5AbjhocOYtyL3ng59uNM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n+XdnltL8Vt7bGTOO35z7/pVsAdqXWvieLxLzP0XKHe9x15ZJ5B4w3mvg66sQTm1C
         7tPZI7+Ylwrpguj8Vji/vGD2GsYQrroG3FZPRMQjbG3NMjCJuWCSjF1tHNwsNZ3VUM
         ThODwutQH7VgNwQ9UAKFkYCwKmh+QTNTwEVK/V/Hvuk2ajPzaCDScCOntIMMrTxYIl
         IlIGjYuSx+HBekTLZ1TvVFLR8FkONv8kSTLN/fblUO6cYpg+2n/j9IYKd9QHbaxlKW
         lALN3rwth02h/0wL675ZG7F3MaiHzioKJzNUL/EaaDOERzRkh33h+F0+lLRQTdBt3D
         8kp9P+FXz+kzg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 4/4] kselftest/arm64: Add coverage of TPIDR2_EL0 ptrace interface
Date:   Thu, 18 Aug 2022 18:01:11 +0100
Message-Id: <20220818170111.351889-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220818170111.351889-1-broonie@kernel.org>
References: <20220818170111.351889-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3913; i=broonie@kernel.org; h=from:subject; bh=5JvLo0UnJeyCZ1yxO1+Xnv5AbjhocOYtyL3ng59uNM8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi/nBWB28b/VVGFj2CZ8OO+K9TBKMw+RoDC2fFs8kM irPZVW6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYv5wVgAKCRAk1otyXVSH0MonB/ 9djcmEicS6bXSoJIM9dEBibt63Rth150pKZnnWxVL1oslfqUhHldW3Myu2pTq2rUjFNo5SSeJ9HoD3 Y4x/r6aR6KKDIl5tvMohAXjahXD3CJmDeD0a7br656nuGFl4SC0VBbRO44vCbxGt8pOL5Xkk5LDCft LlObILN8yt2Ks4zsoVvwRQF5RcU9+CFG6puBaK2qrMIzoHP+V/X7mP63i7FwefdNJYcMgjnMaWn8Av CRN+3kMYpy+kdgLhRUpJCCtQEv6T3ZJtMs9aUYmxyZRfr2tql+MM0/76Dpr5EvRvnp07R+8/o/qpvr pERNmwmxgQ8r+gkA7jArmEv4RMCBJb
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

