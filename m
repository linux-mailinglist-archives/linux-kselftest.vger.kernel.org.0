Return-Path: <linux-kselftest+bounces-12640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E119167C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 14:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55881C260D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 12:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9155D1586C3;
	Tue, 25 Jun 2024 12:25:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087E2157A6C;
	Tue, 25 Jun 2024 12:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318301; cv=none; b=iu8SuhN201Z5q4XbE5zeUKVQxXt3ohp9DDT5ltVRA+U7GKSh6UZIrqQ8DxvatNqLHoMxDTIU5bArru5ZOjcJmImGhehxSU7U0kDEV9t9AfR3oPH9VlwkuFH072hj9YUtmrXvzJZ0A4fZKbYDWAOdF8LNPuBnKWAGA1w1U4GlrqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318301; c=relaxed/simple;
	bh=scqmnxgNz27zPBIBIvH13F67ZFzsL+21QGepEUJWBsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EVxwL0iBIQ3iSzzofaquU4oY3rtr+tOSUByToiUGDDtcfrt02VxHgb6a2dE9TnZsXfHz9KxUh1xqx5cp9nteZZ6d0BNGqtS1XBIuH7GeDxfqjwI/pGG7292cYyvGCbmSKBr9WSX88zlj3IrfW5sP+/A2AO5l7Cv7cIUVldW07L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B7B1339;
	Tue, 25 Jun 2024 05:25:24 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B9ED83F766;
	Tue, 25 Jun 2024 05:24:54 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Catalin.Marinas@arm.com,
	will@kernel.org
Cc: broonie@kernel.org,
	ryan.roberts@arm.com,
	rob.herring@arm.com,
	mark.rutland@arm.com,
	linux@armlinux.org.uk,
	suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com,
	aneesh.kumar@kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v3 5/9] selftests/arm64: Fix build warnings for ptrace
Date: Tue, 25 Jun 2024 17:54:04 +0530
Message-Id: <20240625122408.1439097-6-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625122408.1439097-1-dev.jain@arm.com>
References: <20240625122408.1439097-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"%s" should have been used in ksft_exit_fail_msg(). Anyways, replace that
with the recently introduced ksft_exit_fail_perror(). Also fix no mention of
type_name in ksft_test_result_skip().

NOTE: This patch can be applied independently of the series, but the
next patch depends on this one.

Fixes: ecaf4d3f734f ("kselftest/arm64: Add test coverage for NT_ARM_TLS")
Fixes: cb5aa6379438 ("kselftest/arm64: Add a smoke test for ptracing hardware break/watch points")
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/arm64/abi/ptrace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/ptrace.c b/tools/testing/selftests/arm64/abi/ptrace.c
index abe4d58d731d..c83f0441e9d0 100644
--- a/tools/testing/selftests/arm64/abi/ptrace.c
+++ b/tools/testing/selftests/arm64/abi/ptrace.c
@@ -156,17 +156,17 @@ static void test_hw_debug(pid_t child, int type, const char *type_name)
 		/* Zero is not currently architecturally valid */
 		ksft_test_result(arch, "%s_arch_set\n", type_name);
 	} else {
-		ksft_test_result_skip("%s_arch_set\n");
+		ksft_test_result_skip("%s_arch_set\n", type_name);
 	}
 }
 
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
-- 
2.39.2


