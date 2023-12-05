Return-Path: <linux-kselftest+bounces-1159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B829A805A56
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA51B21052
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBDD5C8EB;
	Tue,  5 Dec 2023 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZZPbcVd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCB04174B;
	Tue,  5 Dec 2023 16:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEE4C433CC;
	Tue,  5 Dec 2023 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701795081;
	bh=S3NMLYQ19RrEAdoy2+4KbBwGNVT5MhUVc+1BjCfl9/g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DZZPbcVdX6uoNANo8sWSB0TLE+kL48bS2twTwM5l4YoEmkV91+8HKuktE28AKoz/E
	 WUJuLvEe51Ix4LgFAnOFSwoc0N77c2rdYlPwXEd/EUWNyWlgjHOs9CClavT5UCYqtr
	 OMXPvHlxF/sBErlmETESmFxM/oASZSCSdaeaezuZQb7uUVLczT0URi5yoOr15sySoY
	 Kb+syezVVyIGQeXE/axf3E5RSaqORG4nCCuYAvy7rYC6d6rX7pLoKcrH/1MLsN4css
	 y0/XXZ6AFdyvht+mzw8YmFpnjz//xwpKeQveuWulMjC4/dt9ekoOzmjAF1mH2mQa1s
	 hV6a4dhr5v6XQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 05 Dec 2023 16:48:01 +0000
Subject: [PATCH v3 03/21] arm64/sysreg: Add definition for ID_AA64ISAR3_EL1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-3-dbcbcd867a7f@kernel.org>
References: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
In-Reply-To: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=broonie@kernel.org;
 h=from:subject:message-id; bh=S3NMLYQ19RrEAdoy2+4KbBwGNVT5MhUVc+1BjCfl9/g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1TrGOb2jvRQaEf1M3wFPk1u9bRLf5uYzQoUEzvy
 /XSuJOmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U6wAKCRAk1otyXVSH0LD5B/
 99D29MUG9pg2WSRHsIzvG3h9U5lLOK3bkS8LVHFibFOFFuez3PqD1zCfCe4upcfQd0tEr0VkbYXx0a
 yrb514ri0dQ9NSFnemew4ZI7ZF9k09ftGPkMjnDpC3m3yqHZdCC5aJcWyG9sVEZX74xjcqTGOE5tnt
 KgRpbr6x3NPLcVSHi0A74PC2Mx98A17SGiYfgFUN+ObQbb6Pa7Z6QefubPGknxC6ldzzcH2t+rHhJP
 ybM32ZhOWL/TOfnZEWlUmCwkXrYtE8WIMYVAD9lQ25h99jaiozV3cRHOA9rZktL37BqvLOcaRffQso
 LQ7Tbj1GO2jFgIPSwzFXA0XVvk9xM9
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2023-09 adds a new system register ID_AA64ISAR3_EL1 enumerating
new floating point and TLB invalidation features. Add a defintion for it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 27d79644e1a0..3d623a04934c 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1433,6 +1433,23 @@ UnsignedEnum	3:0	WFxT
 EndEnum
 EndSysreg
 
+Sysreg	ID_AA64ISAR3_EL1	3	0	0	6	3
+Res0	63:12
+UnsignedEnum	11:8	TLBIW
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	7:4	FAMINMAX
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	3:0	CPA
+	0b0000	NI
+	0b0001	IMP
+	0b0010	CPA2
+EndEnum
+EndSysreg
+
 Sysreg	ID_AA64MMFR0_EL1	3	0	0	7	0
 UnsignedEnum	63:60	ECV
 	0b0000	NI

-- 
2.30.2


