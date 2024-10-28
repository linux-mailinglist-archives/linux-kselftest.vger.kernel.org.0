Return-Path: <linux-kselftest+bounces-20840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E31F9B3BB0
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 21:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9168283309
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 20:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB1B20400D;
	Mon, 28 Oct 2024 20:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca9O+nmc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A344A1E25ED;
	Mon, 28 Oct 2024 20:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147188; cv=none; b=UdWmyuyi8Wrl9A+dgxYQUYvR0auj5z6PX5ZTruWeGOZUuKRmF27ZgOSxgtieIaSD4GRCoOHvXmZotB0vbNLlMlffF4otV2U4wUYpN6rW0bAzUjkGHRzvAgYm2PPzoBo5JYOLTYTS5/1o27D1BKXYGkwuvzIWfsqtkkA/bo35ZQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147188; c=relaxed/simple;
	bh=d5RZlEZoZQWLA36Igji31xBn/i/cyogK0e7bQd2Qjxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BDMGRJeuDsWKImh4iyZmr9+4CnuAMpiyvA4jvKY6QaXlZOSXt/8L8zYO/SFTPCzDO2aCvfyu/D7Auw0LhJYGdmlksO2MAYhp2mCXPUUu7OlGsnJUQe6+ynfU/UG9RUJDXcQJLsbbiH6wmE2BdNmWd4+NQukB7HJW8NSEJNfx6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca9O+nmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8E5C4CEE4;
	Mon, 28 Oct 2024 20:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147187;
	bh=d5RZlEZoZQWLA36Igji31xBn/i/cyogK0e7bQd2Qjxc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ca9O+nmc/ULVPHICC06J102/ac23bPptAvij71woBc/CiUdXPY1jqmfSks2EyLu/p
	 LoS16hYAFSVSg8m+bmqFH0fsyEkpBfa0n+GH6QpmZeIUXURu5kTQjPThOEdlQD2Imv
	 XzrKZmNmKWDHAB1XO1bBfIooUH9r6j1GjfB6qTkGaB139mFAMk1UJZSixvqHWYRUeI
	 o/ql74U9c8MYpy4TyuoAIhg2i9g+Enk79ELpXhKqzybDI/bzcnTFQZgqeByyMVxh6a
	 ofzyoMsqm/15ZQ44vVVFWu6/Or5AOlILDQJNRa8doRxvctMITpSRHu/38bL9imYla2
	 hT5iMIVRqS9WQ==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 28 Oct 2024 20:24:10 +0000
Subject: [PATCH 1/9] arm64/sysreg: Update ID_AA64PFR2_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-arm64-2024-dpisa-v1-1-a38d08b008a8@kernel.org>
References: <20241028-arm64-2024-dpisa-v1-0-a38d08b008a8@kernel.org>
In-Reply-To: <20241028-arm64-2024-dpisa-v1-0-a38d08b008a8@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=771; i=broonie@kernel.org;
 h=from:subject:message-id; bh=d5RZlEZoZQWLA36Igji31xBn/i/cyogK0e7bQd2Qjxc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnH/NmtcwIhaUHJF6vujwEbcssTw5+zAnH4nKBXEeV
 7p/j+eaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZx/zZgAKCRAk1otyXVSH0KnMB/
 44tLFchLAec/zksuwpz3Xuq+jtawdVudOA57yX0bSZwwDh1CaftQpmVtcS1++VJj+vTEsSNABNu9ZD
 JPEI5cbOvMO2t3paBegspl6GMFRxFO4HHaAhgnWpKOymESR5O0xNwqx3OVQNLhxpKTIo1OheeU61Vi
 eM+OH3NE+6Awp3naCglIlW53grpKnyfOuDHk1MsDR4vZpilHo9/eWUq68dqU8pyoloRr0PZbn4R1vN
 HfeBayZB6S8JzUiqkoPeMFqQqsvN0b5HafqsJYpuLZ3kNrWjdm2+hsmSVGAFaWxZ/y28S4O4bhExam
 BDS0THEKt/mtt9BA+lSPalvM33K9kx
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 defines a new feature flags in ID_AA64PFR2_EL1
describing support for injecting UNDEF exceptions, update sysreg to
include this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 8d637ac4b7c6b9c266156b4a8518d8d64c555461..72d6ff1a9c7588dc4894ec6d673791fde108a857 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1010,7 +1010,12 @@ UnsignedEnum	35:32	FPMR
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	31:12
+Res0	31:20
+UnsignedEnum	19:16	UINJ
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+Res0	15:12
 UnsignedEnum	11:8	MTEFAR
 	0b0000	NI
 	0b0001	IMP

-- 
2.39.2


