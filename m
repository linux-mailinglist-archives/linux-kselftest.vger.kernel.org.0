Return-Path: <linux-kselftest+bounces-20843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F099B3BBA
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 21:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663B01C222CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 20:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A752040AA;
	Mon, 28 Oct 2024 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3C0ddgp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955171E25F8;
	Mon, 28 Oct 2024 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147197; cv=none; b=WGme/BQ+TODY7jMWX/owOC3wQVfFdHYsmv4hAy5AHeaHMgCkRzyyiQUeNuGlk3o4+KR16DLruobagavaLbPX/dsvsE+q0ViCEvaaEUvrpgWRImWOw/RptmCCGTVvsnvmx8efrCS0GYnOPCP0+NsmO5vBxnGMZWzdc2dslsTgT1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147197; c=relaxed/simple;
	bh=FN01wAAM5D8ZMfrYQkBkqRMg6r+p3qmFRREh7tSlgYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ATFrdDo2MShW7xA39kaAYws1VuXXn/371YuE+HGMNAadvyLDWeCddOaS6hoJoJ6S23VX59pTp/AfumqQslm4o5wWLHBsyDUMaeOZpIXAiu1cokbWi9A54M0tLKIuAfCq2IN6eeCDVzN0UUvuNTpX4PvFBYiwLBeL14NfLK5wALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3C0ddgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E4EC4CEE4;
	Mon, 28 Oct 2024 20:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147196;
	bh=FN01wAAM5D8ZMfrYQkBkqRMg6r+p3qmFRREh7tSlgYo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P3C0ddgp4phz7rTiKtrn+fbmvzltuGLSD+3p+Au18P72iXatX5ce7fvsRnFjBbYqj
	 QipLXVvqhMxyL9mFgsi4y1qU1u7xgFRKZmJaDSJezL0IFf2s5j1IHM2exEhd8mkCHz
	 uOv5WokY6qtcIi+cfa9LMoMBaf3nU9+Bm9QcQItDxhPG1iJJwseN5Bm5zWNJZSgTkf
	 PKmSp3T+COJUc3f4cwSdMMGvuqDAU89JrkkoTbYHO1TJlQzOPoqMPNrVyVGx4s4wsG
	 kXplxAixT1Thq+rH2uzki76Wufh0CjMVp4rCVwXUyJlDKwuzF7ZNfDFkcoji57A0/q
	 yeIdarDR0v6Hw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 28 Oct 2024 20:24:13 +0000
Subject: [PATCH 4/9] arm64/sysreg: Update ID_AA64ZFR0_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-arm64-2024-dpisa-v1-4-a38d08b008a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FN01wAAM5D8ZMfrYQkBkqRMg6r+p3qmFRREh7tSlgYo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnH/NoFqkcnBz5GKBfDodahpIRTDaaf4zSQp/88sVI
 r9TS7PyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZx/zaAAKCRAk1otyXVSH0FzMB/
 96ysFmW6P71QjtffhaS+xwXkOmBCPFj+RfWbn6KXXPQ0pqf5VxBamOOlh0hjvifAHQ8DClaDeupO5H
 9/qXOFxmb9tJLD8pC5OxDdCJT2tRBIzEwP9fOJW4h1kD9N5ZczGGiOYsSrScvrKqO3WUZPij2pd4ks
 j0n8HTPMWOlZXhtNk7OHlaFdQrvjEVjnCY1A0kzAusHYnImNGMAuXrV1/aHcGoiT8sWWBftSNo6FFr
 BlsTWLMYWf5sopFeNA5y/iVHffBe0QLCxCo3HfzdwghVYvbJ6HVCp23aARQfFC43L4+4I0hkvgHJHu
 uY1EesCMNi9sjo1Qf+JXtkFkM+jlHS
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 introduces SVE 2.2 as well as a few new optional features,
update sysreg to reflect the changes in ID_AA64ZFR0_EL1 enumerating them.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 26f1350c9d2e3baf39ac3bdcc96fc1e6deb5a5c6..d487c78520b97c8f96c70181e39eccb91d6fe1af 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1040,7 +1040,10 @@ UnsignedEnum	55:52	F32MM
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	51:48
+UnsignedEnum	51:48	F16MM
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 UnsignedEnum	47:44	I8MM
 	0b0000	NI
 	0b0001	IMP
@@ -1058,6 +1061,7 @@ Res0	31:28
 UnsignedEnum	27:24	B16B16
 	0b0000	NI
 	0b0001	IMP
+	0b0010	BFSCALE
 EndEnum
 UnsignedEnum	23:20	BF16
 	0b0000	NI
@@ -1068,16 +1072,22 @@ UnsignedEnum	19:16	BitPerm
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	15:8
+UnsignedEnum	15:12	EltPerm
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+Res0	11:8
 UnsignedEnum	7:4	AES
 	0b0000	NI
 	0b0001	IMP
 	0b0010	PMULL128
+	0b0011	AES2
 EndEnum
 UnsignedEnum	3:0	SVEver
 	0b0000	IMP
 	0b0001	SVE2
 	0b0010	SVE2p1
+	0b0011	SVE2p2
 EndEnum
 EndSysreg
 

-- 
2.39.2


