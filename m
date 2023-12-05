Return-Path: <linux-kselftest+bounces-1164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AE3805A5D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26EB8281E6C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D6C5C8F1;
	Tue,  5 Dec 2023 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJJAN/sd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7054174B;
	Tue,  5 Dec 2023 16:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E66C433C7;
	Tue,  5 Dec 2023 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701795097;
	bh=TRfwOBP1ct8dRqN5onbbksp9izfKksijyA3SFS57tL8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GJJAN/sdgW9lhyQnig67GRbm2cbkYg1U4DWRVPeKYiM3i/TYzLd3fPVDrGJgix8Mm
	 FuBQLMzYOSaV+7mhEBTPz/D64h/z+OILnf7FGbGHoIoS2O9bTg+jtz3Zr8Llno4q37
	 ehtoCLl5oGh1RMHo+nQnFi0A9hV+8MxUj9jDgjsOz0jasV4/l4WrTT/uVpL+PXCSdS
	 fyN/Ns30isTwXbF+AXafUWgi7Xkar4nRgzMZVDEETy2hX/GE/X51ze4nH4NP1EgXhS
	 Nj9hc00IafLWlUWBqfe7M6fzCkhGFjhCg/QCFPqCoQPxLCSAyJxerAGHlFMgjjjJmV
	 LR9AITvK6EAUQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 05 Dec 2023 16:48:06 +0000
Subject: [PATCH v3 08/21] arm64/sysreg: Add definition for FPMR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-8-dbcbcd867a7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=975; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TRfwOBP1ct8dRqN5onbbksp9izfKksijyA3SFS57tL8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1TvVsjO+1Ho6qAlj6qwCmPte6Bb7DMChC7dyCkd
 PySIUMuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U7wAKCRAk1otyXVSH0Kt6B/
 9CefQbQVJNo9MwymwwWXuS68fFeyVNw2SeJiyB6yG6JaaIldk3ZEoHjyKVwthWwBkAlh0D+F4BgnSI
 0uqu35O4JMVRTn55wEe1Kz2+3C3g5n7/jfPsDfvEfdR+p3taYvvSJxUbMDoAGuorPot3y6ADVHTeMF
 Rb/Ui71ogWxW1R+hAD9us2c1MluIM69SXC7SIxsdQDLWH/SZho9p5j1f6pXxiJ9081AQva7XhRR2j8
 5GRdYVyr1rQpclvsx4lsqZUjeZJWzER+bQSmPiAc17iKf27jKVmnjB6bhop2TipQYaohmgIyAOivVh
 cK5nL8FVat4M64Cv/mMfygRV7eQlEV
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2023-09 defines a new sysrem register FPMR (Floating Point Mode
Register) which configures the new FP8 features. Add a definition of this
register.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 0b1a33a77074..67173576115a 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2138,6 +2138,29 @@ Field	1	ZA
 Field	0	SM
 EndSysreg
 
+Sysreg	FPMR	3	3	4	4	2
+Res0	63:38
+Field	37:32	LSCALE2
+Field	31:24	NSCALE
+Res0	23
+Field	22:16	LSCALE
+Field	15	OSC
+Field	14	OSM
+Res0	13:9
+UnsignedEnum	8:6	F8D
+	0b000	E5M2
+	0b001	E4M3
+EndEnum
+UnsignedEnum	5:3	F8S2
+	0b000	E5M2
+	0b001	E4M3
+EndEnum
+UnsignedEnum	2:0	F8S1
+	0b000	E5M2
+	0b001	E4M3
+EndEnum
+EndSysreg
+
 SysregFields	HFGxTR_EL2
 Field	63	nAMAIR2_EL1
 Field	62	nMAIR2_EL1

-- 
2.30.2


