Return-Path: <linux-kselftest+bounces-15524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C691954DD7
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F53F1C20A2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 15:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607A21BE24F;
	Fri, 16 Aug 2024 15:33:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1D1BDA83
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822385; cv=none; b=C9dxhUciJLzfURTEfhMzFchb74ETU49uBPMnuJPrxTCa1I88Y6jSOOVOgAFvTacK4c9h9EDRhSxe4VSHwi3DyHhVnAhP8Dc4oZ/G8fFd2ph1Kv/0KjzT7L+elRe3UvRfRMGeU5Gz2PRdppDTq78+QvHQ68Q/WDa3ImVVxrqhah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822385; c=relaxed/simple;
	bh=3zkeI+sbhbm3M6miGMam+yEoKyNlBpXhfNdd/yjTVrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=InQ0xztCCiZq0RvRBVkL6r2nPMEhYUjSLJyuZ4Ey0NWqw/9jRflt9bkGdAX3QlDDM69OJ9QOjLM4mwqK1ROrCzLn4PguwygqY8XMrKLvibK4gnzBKA/63ts8PZkUEdoflaO3NZmb9NydG31okNqWNIbGhRJPKeCvqQ1Cw+RaYVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92B75143D;
	Fri, 16 Aug 2024 08:33:29 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F6DB3F6A8;
	Fri, 16 Aug 2024 08:33:02 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/8] kselftest/arm64: mte: use proper SKIP syntax
Date: Fri, 16 Aug 2024 16:32:46 +0100
Message-Id: <20240816153251.2833702-4-andre.przywara@arm.com>
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

If MTE is not available on a system, we detect this early and skip all
the MTE selftests. However this happens before we print the TAP plan, so
tools parsing the TAP output get confused and report an error.

Use the existing ksft_exit_skip() function to handle this, which uses a
dummy plan to work with tools expecting proper TAP syntax, as described
in the TAP specification.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/testing/selftests/arm64/mte/mte_common_util.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
index 00ffd34c66d30..69e4a67853c40 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.c
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -319,10 +319,9 @@ int mte_default_setup(void)
 	unsigned long en = 0;
 	int ret;
 
-	if (!(hwcaps2 & HWCAP2_MTE)) {
-		ksft_print_msg("SKIP: MTE features unavailable\n");
-		return KSFT_SKIP;
-	}
+	if (!(hwcaps2 & HWCAP2_MTE))
+		ksft_exit_skip("MTE features unavailable\n");
+
 	/* Get current mte mode */
 	ret = prctl(PR_GET_TAGGED_ADDR_CTRL, en, 0, 0, 0);
 	if (ret < 0) {
-- 
2.25.1


