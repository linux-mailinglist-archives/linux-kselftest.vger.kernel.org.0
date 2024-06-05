Return-Path: <linux-kselftest+bounces-11246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 301478FCC8C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 14:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A6E1F219CD
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 12:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712B31BD4FF;
	Wed,  5 Jun 2024 11:56:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABE91BD4EC;
	Wed,  5 Jun 2024 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588581; cv=none; b=cDp4VjD23JVgKffN+jdrjhV3tcMRMU9Geu7A1mI7IgQNxjVu/o4EGcNwUyR6veX87zTYgIdfPAEJPGrs7LPlq9HXFLzp2jFqTkEMHh04ES7i/IYw1bTIqO777dVv0CyImz32KaFEab7EevFwzm5TgbVH12hWXKwsIIfxoJGsi+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588581; c=relaxed/simple;
	bh=Zy9IzQB3ejrKR2POqOn3wcMgHH1MCGBVI1V+s+78v5U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PcN3o1WtBX1hrvpfeUvrXizyfoig3yzhTRkpMw1g3ociTeEP2cbqT4lctnmNVP2SlGvGr4/bTpbd1cxdIp46FBrZwLXc2JBuq2oO/lU5BV3OEI35ueB3848inTNetYbXiWgXDpIpeC/nncMRH0h2AwU0y9tHKojBvoFqPNkp6Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37701339;
	Wed,  5 Jun 2024 04:56:42 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.40.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 625493F762;
	Wed,  5 Jun 2024 04:56:14 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] selftests: arm64: Fix redundancy of a testcase
Date: Wed,  5 Jun 2024 17:24:48 +0530
Message-Id: <20240605115448.640717-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we are writing the same value as we read, into the TLS
register; hence, we cannot confirm updation of the register, making the
testcase "verify_tpidr_one" redundant. Fix this; while at it, do a style
change.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/arm64/abi/ptrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/ptrace.c b/tools/testing/selftests/arm64/abi/ptrace.c
index abe4d58d731d..c105703442f9 100644
--- a/tools/testing/selftests/arm64/abi/ptrace.c
+++ b/tools/testing/selftests/arm64/abi/ptrace.c
@@ -47,7 +47,7 @@ static void test_tpidr(pid_t child)
 
 	/* ...write a new value.. */
 	write_iov.iov_len = sizeof(uint64_t);
-	write_val[0] = read_val[0]++;
+	write_val[0] = read_val[0] + 1;
 	ret = ptrace(PTRACE_SETREGSET, child, NT_ARM_TLS, &write_iov);
 	ksft_test_result(ret == 0, "write_tpidr_one\n");
 
@@ -108,7 +108,7 @@ static void test_tpidr(pid_t child)
 		/* Writing only TPIDR... */
 		write_iov.iov_len = sizeof(uint64_t);
 		memcpy(write_val, read_val, sizeof(read_val));
-		write_val[0] += 1;
+		++write_val[0];
 		ret = ptrace(PTRACE_SETREGSET, child, NT_ARM_TLS, &write_iov);
 
 		if (ret == 0) {
-- 
2.39.2


