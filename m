Return-Path: <linux-kselftest+bounces-16757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 265DE9656E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 07:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FBF2847AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 05:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9547114A624;
	Fri, 30 Aug 2024 05:29:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBCFEEB7;
	Fri, 30 Aug 2024 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724995765; cv=none; b=PS6hewzayDKzW6jZiQWSvBp1QfXSTzuRVZfU0rVokeqAfOYuQAq4B5xPDdqE006w5SdeOuMw3kamIx+WuGu+m5JMo2H8c2X+3gcs7LNHbLRJlTyl+5GrfLXu58lgON0x2Sl4bX5oFqOka7dZcgJphKs1zugqDK9uV0YDJZVGRKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724995765; c=relaxed/simple;
	bh=Crpk8GurwSOfIGtyT66VOvfMGfIPnQObVQrPOCzNSg0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BDpGDdr7a9VdsmCro9y1IJgJwCkCOAkzSx67gf4OsZh7pGaSQJ1ZiJ3PpF9KB3VNNAXSPyZXQMu9BG5Iv12b6UEEDAWSALeANvxhlfAI3c71FDAES2g/01tfJtAvIiNTw+IdbhPwNCZNJAhu2pTUeX6L3KlLtmw6FtqRyVOw3Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF71C1063;
	Thu, 29 Aug 2024 22:29:48 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.40.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE0073F66E;
	Thu, 29 Aug 2024 22:29:18 -0700 (PDT)
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
Subject: [PATCH] kselftest/arm64: Fix build warnings for ptrace
Date: Fri, 30 Aug 2024 10:59:11 +0530
Message-Id: <20240830052911.4040970-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A "%s" is missing in ksft_exit_fail_msg(); instead, use the newly
introduced ksft_exit_fail_perror().

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/arm64/abi/ptrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.30.2


