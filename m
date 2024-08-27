Return-Path: <linux-kselftest+bounces-16366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ABB960102
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 07:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FA91C21EDB
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 05:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03EF5476B;
	Tue, 27 Aug 2024 05:19:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580F14AEEA;
	Tue, 27 Aug 2024 05:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735946; cv=none; b=ttzkmtm0HzCFAs7ASl8Hy6JZ8aeCOpdIbBngxYVp671qKq4yJ0JAqPtjsuykPLBZU6RHw4/0pq7tyw1UE8vvnoNq8gad9CNlcedsxEClUYr9Jz3TsQ7Ix9EdUz+GsiPmUc25V6GZ1AsOb4h83hRgh2VpOXulePb9XG2H+xb5EKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735946; c=relaxed/simple;
	bh=BqLX8Xp+TRwdIcJp/5YYtzwjf85hXJDuuJGZTu5GuJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qb29FFca2rCTNODVdKezSL1tZSS1v9xj3o+shT+y8XbMdIzvs7UhZLUlvzp66zzXiXhYigo5/IZ4VjDQ9F3JZed8UgAgJzwtp/KGW+LW3k354rEz9JiASdBoaxTutLlPTw9K93yaWEgErXfcVHQ/xI7mUO4CLWBKhFcBEyc4o5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EC98DA7;
	Mon, 26 Aug 2024 22:19:29 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4EC9D3F66E;
	Mon, 26 Aug 2024 22:18:59 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Catalin.Marinas@arm.com,
	will@kernel.org
Cc: broonie@kernel.org,
	ryan.roberts@arm.com,
	Anshuman.Khandual@arm.com,
	aneesh.kumar@kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] selftests/arm64: Fix build warnings for abi
Date: Tue, 27 Aug 2024 10:48:51 +0530
Message-Id: <20240827051851.3738533-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A "%s" is missing in ksft_exit_fail_msg(); instead, use the newly
introduced ksft_exit_fail_perror(). Also, uint64_t corresponds to
unsigned 64-bit integer, so use %lx instead of %llx.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
The changes in ptrace.c were earlier a part of the following:
https://lore.kernel.org/all/20240625122408.1439097-6-dev.jain@arm.com/
which were reviewed by Mark.

 tools/testing/selftests/arm64/abi/ptrace.c      | 4 ++--
 tools/testing/selftests/arm64/abi/syscall-abi.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/ptrace.c b/tools/testing/selftests/arm64/abi/ptrace.c
index e4fa507cbdd0..b51d21f78cf9 100644
--- a/tools/testing/selftests/arm64/abi/ptrace.c
+++ b/tools/testing/selftests/arm64/abi/ptrace.c
@@ -163,10 +163,10 @@ static void test_hw_debug(pid_t child, int type, const char *type_name)
 static int do_child(void)
 {
 	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL))
-		ksft_exit_fail_msg("PTRACE_TRACEME", strerror(errno));
+		ksft_exit_fail_perror("PTRACE_TRACEME");
 
 	if (raise(SIGSTOP))
-		ksft_exit_fail_msg("raise(SIGSTOP)", strerror(errno));
+		ksft_exit_fail_perror("raise(SIGSTOP)");
 
 	return EXIT_SUCCESS;
 }
diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
index d704511a0955..5ec9a18ec802 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi.c
+++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
@@ -81,7 +81,7 @@ static int check_gpr(struct syscall_cfg *cfg, int sve_vl, int sme_vl, uint64_t s
 	 */
 	for (i = 9; i < ARRAY_SIZE(gpr_in); i++) {
 		if (gpr_in[i] != gpr_out[i]) {
-			ksft_print_msg("%s SVE VL %d mismatch in GPR %d: %llx != %llx\n",
+			ksft_print_msg("%s SVE VL %d mismatch in GPR %d: %lx != %lx\n",
 				       cfg->name, sve_vl, i,
 				       gpr_in[i], gpr_out[i]);
 			errors++;
@@ -112,7 +112,7 @@ static int check_fpr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 	if (!sve_vl && !(svcr & SVCR_SM_MASK)) {
 		for (i = 0; i < ARRAY_SIZE(fpr_in); i++) {
 			if (fpr_in[i] != fpr_out[i]) {
-				ksft_print_msg("%s Q%d/%d mismatch %llx != %llx\n",
+				ksft_print_msg("%s Q%d/%d mismatch %lx != %lx\n",
 					       cfg->name,
 					       i / 2, i % 2,
 					       fpr_in[i], fpr_out[i]);
@@ -294,13 +294,13 @@ static int check_svcr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 	int errors = 0;
 
 	if (svcr_out & SVCR_SM_MASK) {
-		ksft_print_msg("%s Still in SM, SVCR %llx\n",
+		ksft_print_msg("%s Still in SM, SVCR %lx\n",
 			       cfg->name, svcr_out);
 		errors++;
 	}
 
 	if ((svcr_in & SVCR_ZA_MASK) != (svcr_out & SVCR_ZA_MASK)) {
-		ksft_print_msg("%s PSTATE.ZA changed, SVCR %llx != %llx\n",
+		ksft_print_msg("%s PSTATE.ZA changed, SVCR %lx != %lx\n",
 			       cfg->name, svcr_in, svcr_out);
 		errors++;
 	}
-- 
2.30.2


