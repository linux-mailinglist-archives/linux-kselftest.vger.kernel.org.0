Return-Path: <linux-kselftest+bounces-20960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336F89B4C6C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6422A1C224D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 14:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A206A1865E3;
	Tue, 29 Oct 2024 14:46:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02DC10F9
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213165; cv=none; b=V4sOkRzrlIc1YsCBPhZ+LzE4uzEDlBSlvEFwEGD/y106dsd8vNGvjecds/MKntSM9hteJ7ejy7JZx+2ASrLTHtHABP63PdneUDfBEmYGGGtfq1VopbL3/pc3xtKjRW+77viA6ny1kARxcmkr74HF8wdcV6iQvJHGIhiRujG32EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213165; c=relaxed/simple;
	bh=U6u4m5dAMScgk+ayARRMh8i0VFL/SfA7DC0Iolgdydw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgrIBamAL33XJ88t32nqpTBDNFb1sKKWQeRCd1sE6jTxvFFXg+j1eDofUDWd3NddhYAzkWt/5nAazNdnOc96NPz7sd6RstzbkEEU2lMN8p/IwY5/kh3LyDkyYN56lTLRDEi8AaMeq/zzBTh22xnkF+GtSGyB9XGlJM9VDMTnSeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0D1215BF;
	Tue, 29 Oct 2024 07:46:32 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 541ED3F528;
	Tue, 29 Oct 2024 07:46:00 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	aruna.ramakrishna@oracle.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	Dave.Martin@arm.com,
	jeffxu@chromium.org,
	joey.gouly@arm.com,
	keith.lucas@oracle.com,
	pierre.langlois@arm.com,
	shuah@kernel.org,
	sroettger@google.com,
	tglx@linutronix.de,
	will@kernel.org,
	yury.khrustalev@arm.com,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v3 2/5] arm64: signal: Remove unnecessary check when saving POE state
Date: Tue, 29 Oct 2024 14:45:36 +0000
Message-ID: <20241029144539.111155-3-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029144539.111155-1-kevin.brodsky@arm.com>
References: <20241029144539.111155-1-kevin.brodsky@arm.com>
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
index c7d311d8b92a..d5eb517cc4df 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -1154,7 +1154,7 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 		err |= preserve_fpmr_context(fpmr_ctx);
 	}
 
-	if (system_supports_poe() && err == 0 && user->poe_offset) {
+	if (system_supports_poe() && err == 0) {
 		struct poe_context __user *poe_ctx =
 			apply_user_offset(user, user->poe_offset);
 
-- 
2.43.0


