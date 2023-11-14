Return-Path: <linux-kselftest+bounces-95-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E36D7EB241
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 15:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6201C20A23
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B967141233;
	Tue, 14 Nov 2023 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlpAM4p/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9559541229;
	Tue, 14 Nov 2023 14:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CF3C116B4;
	Tue, 14 Nov 2023 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699972569;
	bh=p49U0rB8BLfyvHeTkXNyujHDJxY2xWglioVFZrQRPgM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AlpAM4p/PpDtnGa+P+8MSgHGTJ0ojhyv3MXbEXP5fT2nd+uKNEhre27nS3KShUuOw
	 yv1LT6A8pMrshhhOeqccPV/j0EmbpO89/6v63x7E2GX84G0ngC5F9cPFgUcJypBWLa
	 juOJYFe8Qu7RMoI+ALWZAtXZCEiGkhXTyXIIAFRt7P2O0fRnBsuq0mclLGf3uhM5RT
	 gouns62U5thbp4juKWG56dUPRJrkPJEdTVEHPq0zu3N5AVYZsUUfZVJtVGo+bUnIQe
	 6KaKGtRtZVsjbYiH9cAmi+qngFKBCBIesxcdg4spOPiOCCXt8MLN26b6G2p19grEG5
	 vHj3e1XHGxFYg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 14 Nov 2023 14:34:59 +0000
Subject: [PATCH v2 14/21] KVM: arm64: Add newly allocated ID registers to
 register descriptions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-14-47251894f6a8@kernel.org>
References: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
In-Reply-To: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=broonie@kernel.org;
 h=from:subject:message-id; bh=p49U0rB8BLfyvHeTkXNyujHDJxY2xWglioVFZrQRPgM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WfNE845a8JBj/7uYktPGecHrfg665x4pinSKM3
 7IYoRbiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFnwAKCRAk1otyXVSH0EPRB/
 0ej5UCRBRTqxqq1+eo0b3oJ3DQGFdnXwe003TSlUsDlKV3KkFJCceXkwq3fxrsW2Q+LMfcDMMSd5OY
 foJyuloV449NruHS2/7rzQW+3aaURgprNDwmu8yJjtO+cDH6VucQK4dFBWQz36wuw/G3z+L5Sk/4BU
 BNSeOCUZsXMNqWiH6+bYjN2onVo/oUY1I/JIY/01cCu+XfgYz2SBm0s8dNKf5H8l2MCF6X0yWFxp6j
 seYcd3kLbVN3MRPNy4LNoCQLgW7uWOf8k+zuC+Zp6IheOj5CPN6l5/I8qZnc9D9B5K/LCco2kyUrJ8
 tp3828pzHxoG36ciTt0ft3yCCnuKAx
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The 2023 architecture extensions have allocated some new ID registers, add
them to the KVM system register descriptions so that they are visible to
guests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4735e1b37fb3..b843da5e4bb9 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2139,12 +2139,12 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 		   ID_AA64PFR0_EL1_AdvSIMD |
 		   ID_AA64PFR0_EL1_FP), },
 	ID_SANITISED(ID_AA64PFR1_EL1),
-	ID_UNALLOCATED(4,2),
+	ID_SANITISED(ID_AA64PFR2_EL1),
 	ID_UNALLOCATED(4,3),
 	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
 	ID_HIDDEN(ID_AA64SMFR0_EL1),
 	ID_UNALLOCATED(4,6),
-	ID_UNALLOCATED(4,7),
+	ID_SANITISED(ID_AA64FPFR0_EL1),
 
 	/* CRm=5 */
 	{ SYS_DESC(SYS_ID_AA64DFR0_EL1),
@@ -2171,7 +2171,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_WRITABLE(ID_AA64ISAR2_EL1, ~(ID_AA64ISAR2_EL1_RES0 |
 					ID_AA64ISAR2_EL1_APA3 |
 					ID_AA64ISAR2_EL1_GPA3)),
-	ID_UNALLOCATED(6,3),
+	ID_WRITABLE(ID_AA64ISAR3_EL1, ~ID_AA64ISAR3_EL1_RES0),
 	ID_UNALLOCATED(6,4),
 	ID_UNALLOCATED(6,5),
 	ID_UNALLOCATED(6,6),

-- 
2.30.2


