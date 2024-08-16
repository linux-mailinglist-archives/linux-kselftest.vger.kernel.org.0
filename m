Return-Path: <linux-kselftest+bounces-15527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21750954DDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB22F1F253DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD331BE248;
	Fri, 16 Aug 2024 15:33:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAF71BDA86
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822390; cv=none; b=plxumX6tMdo5hWErXhvruOJmWRtyjHtgpp7qLZOU/j8hD4xaCN2yMhJkfQHifharFcLqdh2KBNGg7o1GPnlOPjbtoQCoqfgO0LxjB2qyKzZrMJFVI4950gvXBfpbBLYroG2YXaw4rx/NjeEYagps2lNF4QEsrkYa58UnpDCv/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822390; c=relaxed/simple;
	bh=XmNL3Yj6BrDrPESWIs4AmrgOBXP3Y1Df/83I3lMeETY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jeQBF4oCawDIZZWVkyR2ReohYql/8Y5GRDqiXnGg4bnML25p4E8FNvgYU4wTGnXnT8fZAvAvMDHNZHE0nYdbUNEBnNthFQaRavBpMeKTFEEWmel9JxVQlosl5c+pfxLQw8faIkEWGiDcm2ULqIEixJXt2QmDW/+LO/bbw6dbP7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59A451515;
	Fri, 16 Aug 2024 08:33:34 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 160513F6A8;
	Fri, 16 Aug 2024 08:33:06 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 6/8] kselftest/arm64: mte: fix printf type warnings about __u64
Date: Fri, 16 Aug 2024 16:32:49 +0100
Message-Id: <20240816153251.2833702-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816153251.2833702-1-andre.przywara@arm.com>
References: <20240816153251.2833702-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printing the signal context's PC, we use a "%lx" format specifier,
which matches the common userland (glibc's) definition of uint64_t as an
"unsigned long". However the structure in question is defined in a
kernel uapi header, which uses a self defined __u64 type, and the arm64
kernel headers define this using "int-ll64.h", so it becomes an
"unsigned long long". This mismatch leads to the usual compiler warning.

The common fix would be to use "PRIx64", but because this is defined by
the userland's toolchain libc headers, it wouldn't match as well. Since
we know the exact type of __u64, just use "%llx" here instead, to silence
this warning.

This also fixes a more severe typo: "$lx" is not a valid format
specifier.

Fixes: 191e678bdc9b ("kselftest/arm64: Log unexpected asynchronous MTE faults")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/testing/selftests/arm64/mte/mte_common_util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
index 69e4a67853c40..9380edca29c7d 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.c
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -38,7 +38,7 @@ void mte_default_handler(int signum, siginfo_t *si, void *uc)
 			if (cur_mte_cxt.trig_si_code == si->si_code)
 				cur_mte_cxt.fault_valid = true;
 			else
-				ksft_print_msg("Got unexpected SEGV_MTEAERR at pc=$lx, fault addr=%lx\n",
+				ksft_print_msg("Got unexpected SEGV_MTEAERR at pc=%llx, fault addr=%lx\n",
 					       ((ucontext_t *)uc)->uc_mcontext.pc,
 					       addr);
 			return;
@@ -64,7 +64,7 @@ void mte_default_handler(int signum, siginfo_t *si, void *uc)
 			exit(1);
 		}
 	} else if (signum == SIGBUS) {
-		ksft_print_msg("INFO: SIGBUS signal at pc=%lx, fault addr=%lx, si_code=%lx\n",
+		ksft_print_msg("INFO: SIGBUS signal at pc=%llx, fault addr=%lx, si_code=%x\n",
 				((ucontext_t *)uc)->uc_mcontext.pc, addr, si->si_code);
 		if ((cur_mte_cxt.trig_range >= 0 &&
 		     addr >= MT_CLEAR_TAG(cur_mte_cxt.trig_addr) &&
-- 
2.25.1


