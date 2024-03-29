Return-Path: <linux-kselftest+bounces-6789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC785890F00
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7815828B415
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD315A34;
	Fri, 29 Mar 2024 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBtptPS4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D53F1097B;
	Fri, 29 Mar 2024 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671241; cv=none; b=tD6ga1n9F4hyMPdCAQ6vs0nbRZjGolQhQcbUbmLIcPgvt8Jp8+0uSg35Db4L+7jgMlNvmN6fW1Sn80Tf2VeIAafv1v+5m6Lq8XtL8QiLuxq5b+K3tvv1v6tNTn30CnkR4UTp23iDbHYxh/UOAC5Ng9HWnOM/htq5IxmgcBEJOow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671241; c=relaxed/simple;
	bh=ZafasIdykUQRzTv9jB3X2/BpgZV9b0ujkx1QsU2wROY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q4E1HnmPh5+ljS27SIiGvpw1B1F+ZayfGYP8bS0R+ieQDm4kuBbjEWHGzFO/J4JlqWsZuDc2xU240ljUHIne6axHqPFVZtGRPiWo+7IDyozKVMeY7kT4TbqDnNq+t5UvQAPgWkWZYT07FuY1nN2+9HSpI65dOj9QfDEXTolc+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBtptPS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6626FC433F1;
	Fri, 29 Mar 2024 00:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711671241;
	bh=ZafasIdykUQRzTv9jB3X2/BpgZV9b0ujkx1QsU2wROY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZBtptPS4xr4ntj13FZabRwA4yMMpeR2olu/fuz9M7vwRqDxz5nxE8bZeVfjeBoo02
	 T6yxnYIINt9pjyQfNPqeqA+q1bdV/iGe0DXM6XT7OMRMWS5teBkbBboS3mlxAMMRme
	 kV5P8pu0juaxLBSiK69MFCqD+1wDiKoQgJWlyPDnzsUnoPgSvB7maYyb5t1Q6NFCHm
	 AzbFa3R1Y6uLmlrw5qzzWo0rtJUWQQrTJMCkHYJy+gSpMahySs/5WNpYBgqjpKsiIX
	 rA638DlYaK+iEVbTUsrs8LdnYfE5A5B29Djh9ucO/S5S4Xaa++Mz5XmGExFUdlMXwI
	 IfZ/wgl8kGCWQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 29 Mar 2024 00:13:43 +0000
Subject: [PATCH v6 2/5] KVM: arm64: Add newly allocated ID registers to
 register descriptions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-arm64-2023-dpisa-v6-2-ba42db6c27f3@kernel.org>
References: <20240329-arm64-2023-dpisa-v6-0-ba42db6c27f3@kernel.org>
In-Reply-To: <20240329-arm64-2023-dpisa-v6-0-ba42db6c27f3@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1796; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZafasIdykUQRzTv9jB3X2/BpgZV9b0ujkx1QsU2wROY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmBge8CN5tRHW3rA8Bvs8N7qMi+3j8y8mk4z7pHdpR
 9S5WNoCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZgYHvAAKCRAk1otyXVSH0Dy1B/
 9SUa4VUiUG74Rj8TyggAR/LLueU5FDqBOY3ahtZ1KoPZDKuWj/qXQCpbaKTYPp61tya4PX3dwVX2MR
 cQcA/Usu1uikhE+0yY+ybOgUH9CwBnE3EI5FHbNygvowCEWU+c8xTsa7y+pYSP4kPtbF8q1Gg24vn1
 KqGhYXDER/GHwxEPohjNFWFgXoUHrejhFshjolZ+6c0adI8tNJKjI7oOlXyUOfwAmJyiEB12QT6K4F
 BzrXUOjpoiQeWXGo4oMTGKriNgYohMpWcH5AjCG31886m4fWtJ2DKQizE0lwAIEyY5hsZjfiS1oboG
 91NoWFUjR/0DWc2jCZmEgXluAFo8Gn
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The 2023 architecture extensions have allocated some new ID registers, add
them to the KVM system register descriptions so that they are visible to
guests.

We make the newly introduced dpISA features writeable, as well as
allowing writes to ID_AA64ISAR3_EL1.CPA for FEAT_CPA which only
introduces straigforward new instructions with no additional
architectural state or traps.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c9f4f387155f..a3c20d1a36aa 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2293,12 +2293,15 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 		   ID_AA64PFR0_EL1_AdvSIMD |
 		   ID_AA64PFR0_EL1_FP), },
 	ID_SANITISED(ID_AA64PFR1_EL1),
-	ID_UNALLOCATED(4,2),
+	ID_WRITABLE(ID_AA64PFR2_EL1, ~(ID_AA64PFR2_EL1_RES0 |
+				       ID_AA64PFR2_EL1_MTEFAR |
+				       ID_AA64PFR2_EL1_MTESTOREONLY |
+				       ID_AA64PFR2_EL1_MTEPERM)),
 	ID_UNALLOCATED(4,3),
 	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
 	ID_HIDDEN(ID_AA64SMFR0_EL1),
 	ID_UNALLOCATED(4,6),
-	ID_UNALLOCATED(4,7),
+	ID_WRITABLE(ID_AA64FPFR0_EL1, ~ID_AA64FPFR0_EL1_RES0),
 
 	/* CRm=5 */
 	{ SYS_DESC(SYS_ID_AA64DFR0_EL1),
@@ -2325,7 +2328,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_WRITABLE(ID_AA64ISAR2_EL1, ~(ID_AA64ISAR2_EL1_RES0 |
 					ID_AA64ISAR2_EL1_APA3 |
 					ID_AA64ISAR2_EL1_GPA3)),
-	ID_UNALLOCATED(6,3),
+	ID_WRITABLE(ID_AA64ISAR3_EL1, ~(ID_AA64ISAR2_EL1_RES0 |
+					ID_AA64ISAR3_EL1_PACM |
+					ID_AA64ISAR3_EL1_TLBIW)),
 	ID_UNALLOCATED(6,4),
 	ID_UNALLOCATED(6,5),
 	ID_UNALLOCATED(6,6),

-- 
2.30.2


