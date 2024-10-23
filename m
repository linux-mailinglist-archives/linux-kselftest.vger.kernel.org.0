Return-Path: <linux-kselftest+bounces-20463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F5C9ACE48
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 17:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD6F281F42
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 15:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F7A1D4158;
	Wed, 23 Oct 2024 15:05:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181DD1D2F5D
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695933; cv=none; b=ia4qgqeCdKOM3wnkmUOMjBQwi1mDDT1mN6xrkgE/N+7J15WYiHicRgta8vxalsSRFSl2J/xj6HsbfG1j8vwC9FMCqE6SH8iZXwqFt9pO1zkYOS/eHRZSs50YDs+xjmpBoGTc3nMsv15sVEi8GH74gDnlx3Vr02voMwfOcojVec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695933; c=relaxed/simple;
	bh=t1IJfuvPtGfdGfrDNvRCffOaTvVbwwgcgklgCUokKuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8U6YaNIBIOgP/AeXI2cJyYz7cpHXQDPudYYHeASLPkzX0tKA2nTj5OPIGZ7NYG7VIngXGlXQ8aDA5J45LETOqGB79ahQcYVF/mM5CUQfO1QJi1Y5AIj9UZcQJ/Icqx0OTWXcfIiDX1uwlOYzamP7/1fyOsLjMZUo05EayziFTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20579152B;
	Wed, 23 Oct 2024 08:06:01 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BE513F528;
	Wed, 23 Oct 2024 08:05:29 -0700 (PDT)
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
	pierre.langlois@arm.com,
	shuah@kernel.org,
	sroettger@google.com,
	will@kernel.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org,
	Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v2 2/5] arm64: signal: Remove unnecessary check when saving POE state
Date: Wed, 23 Oct 2024 16:05:08 +0100
Message-ID: <20241023150511.3923558-3-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023150511.3923558-1-kevin.brodsky@arm.com>
References: <20241023150511.3923558-1-kevin.brodsky@arm.com>
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
consider poe_offset before saving POR_EL0; just remove that check.
This is in line with other frame records (FPMR, TPIDR2).

Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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


