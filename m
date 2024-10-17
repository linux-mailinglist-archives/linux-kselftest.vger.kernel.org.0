Return-Path: <linux-kselftest+bounces-19957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C599A2424
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 15:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB2FB21EBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396621DE2B6;
	Thu, 17 Oct 2024 13:40:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED6B1D88AD
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172423; cv=none; b=Z5mRCnCIbh5aO5oth3gFDCeD7c6WDC+ExQgDbYVWLe9ifixfHRDYEdU4uRSN0GQDlojkF1foJZtKZ8wm1f2fTYbbuSU0zTpBPLlj16ValcYBUMWTfLwX0xjTEq3CTxRYdWSLlY6pRgeB8b26RYLgHt9Lh4W0VgbZV7w38x/aJm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172423; c=relaxed/simple;
	bh=mQbizh8ALoNLex+KUAn8R6nLC2KGxKrUIitA9TmTcJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAnw7WO55oiM54nieLrgDp4pa9SumwZSXZmD8JAJMx2rrJDJ+mP9TIIkEya29CJ/sqmKJnRLrNiQJy6oKKV0hpNsIx+RpEVMQJdEerqDl0KbWBXYpAiEbiKDPmHDOx1js7D3yP9Xsgw8Sq2J2uflSjblK/wextxMntPTMKf2ZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DB0A150C;
	Thu, 17 Oct 2024 06:40:46 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 702923F71E;
	Thu, 17 Oct 2024 06:40:14 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	aruna.ramakrishna@oracle.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	dave.martin@arm.com,
	jeffxu@chromium.org,
	joey.gouly@arm.com,
	shuah@kernel.org,
	will@kernel.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 2/5] arm64: signal: Remove unnecessary check when saving POE state
Date: Thu, 17 Oct 2024 14:39:06 +0100
Message-ID: <20241017133909.3837547-3-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017133909.3837547-1-kevin.brodsky@arm.com>
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The POE frame record is allocated unconditionally if POE is
supported. If the allocation fails, a SIGSEGV is delivered before
setup_sigframe() can be reached. As a result there is no need to
check that poe_offset has been checked before saving POR_EL0; this
is in line with other frame records (FPMR, TPIDR2).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index dc998326e24d..f5fb48dabebe 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -1092,7 +1092,7 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 		err |= preserve_fpmr_context(fpmr_ctx);
 	}
 
-	if (system_supports_poe() && err == 0 && user->poe_offset) {
+	if (system_supports_poe() && err == 0) {
 		struct poe_context __user *poe_ctx =
 			apply_user_offset(user, user->poe_offset);
 
-- 
2.43.0


