Return-Path: <linux-kselftest+bounces-23673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF7F9F9705
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2D2188BA6F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A62E21B196;
	Fri, 20 Dec 2024 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPgjhNy0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466FB21A45A;
	Fri, 20 Dec 2024 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713480; cv=none; b=ZcAXmgcyeVEnS5zaLldlp+AAXZeDfqFpflSkf3iaqRN6KyTxJmyWQJDaCMIO+ehsLGuKpH0JfC3CzPiEPIZL72/zodIH8+WaBl5FIKhx+8bRvY9vnq+6NRcVrAWnlaGVbk3eqRsNkmOIRhkVaO4YJ6n57bJcc9Gk84hJNx7hy7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713480; c=relaxed/simple;
	bh=FQHYwXdmL3GR1X0fB9NNfgXhfHPcJEGCJwnB7whsybM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iI6IwBOyxyKljMCItKDv8R0jDP77G9DrQJzwbeePDaGruqaRDurGfnG+rlkHhl0vAd/FyozorhgmKiwbv7d3hTavHQvO/16+C44tuitVkzWMXSaR58UhZB+9IZiYW2VyONxsmpFAgulXoIuOJbIkeec+Za9lS9g/wQjA6f/tNRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPgjhNy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FB2C4CEDC;
	Fri, 20 Dec 2024 16:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713479;
	bh=FQHYwXdmL3GR1X0fB9NNfgXhfHPcJEGCJwnB7whsybM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sPgjhNy0pQKxJmsHGssak/MuCZK0aWt8tI8thh7Ae1mYzo8bd/TG5eVWNdGdoCbat
	 uhsduMcY4oz+ozc2revjhXx5Ldwd1tUs1mbdHzzqvAy//oLujy57t/PM1i9A3p0Nub
	 mdeL6ThJaawK+c185FioTm68KJk0O1YgsDofyKeKjeHv1yFjsK5vsdDBVK/1OJCiZM
	 ldjMcZeZNFIo7QxH02lr5TZehIbMzW4naWTGh4+nUmdwOv9LbldTXEl5+lhS3pke75
	 AlZHD8K0aqKZ45t2sii65DiV0vD8fj+BJuKdfndpTf5Cf+1tp8appwhRUbYMix1aeT
	 qMpcvUEnLKZQg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Dec 2024 16:46:31 +0000
Subject: [PATCH RFC v3 06/27] KVM: arm64: Pull ctxt_has_ helpers to start
 of sysreg-sr.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-kvm-arm64-sme-v3-6-05b018c1ffeb@kernel.org>
References: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
In-Reply-To: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2305; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FQHYwXdmL3GR1X0fB9NNfgXhfHPcJEGCJwnB7whsybM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBZgmK/htQnfZrdQRb9ftVqYA9k0EzKH9YaTlHT
 OJFL6e+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgWQAKCRAk1otyXVSH0CzFB/
 9j6wPn0JHK8/QjGznInjFWbpmWtsO145mBHDy9gv2tvca9YZMjsAUZtnDXUvpcSrkpBx/jXpG6ytgq
 7XDa+pa2H5NQ1gj/Rq39700Ks+VG2FD4l8mxJW+k67UAJrVWHrcFPmbruxwgKOFEDZEOmns7L+v6u3
 qhfFaSKWmiAwdmNqo8rrfoUvLUsBj88wdGyI/UzD0SiEVx/HvDtIpqX9wyORNCGkOhumngUqYW3Sgw
 wANy0gt4totBOrUpWdnf8xnhpP2NjDOaMMU/HPlMODt07U/NElcodWuT/SQ5lL1MwpMxjcUuATF8wK
 +JaOWIYQjAWxxaIDZFs42qEFNYffZT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Rather than add earlier prototypes of specific ctxt_has_ helpers let's just
pull all their definitions to the top of sysreg-sr.h so they're all
available to all the individual save/restore functions.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 32 ++++++++++++++----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index a651c43ad679fcc5a13ab7a619e252d96fd46281..8c234d53acb2753c59aa37d7a66f856f2eb87882 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -16,23 +16,6 @@
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
 
-static inline bool ctxt_has_s1poe(struct kvm_cpu_context *ctxt);
-
-static inline void __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
-{
-	ctxt_sys_reg(ctxt, MDSCR_EL1)	= read_sysreg(mdscr_el1);
-
-	// POR_EL0 can affect uaccess, so must be saved/restored early.
-	if (ctxt_has_s1poe(ctxt))
-		ctxt_sys_reg(ctxt, POR_EL0)	= read_sysreg_s(SYS_POR_EL0);
-}
-
-static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
-{
-	ctxt_sys_reg(ctxt, TPIDR_EL0)	= read_sysreg(tpidr_el0);
-	ctxt_sys_reg(ctxt, TPIDRRO_EL0)	= read_sysreg(tpidrro_el0);
-}
-
 static inline struct kvm_vcpu *ctxt_to_vcpu(struct kvm_cpu_context *ctxt)
 {
 	struct kvm_vcpu *vcpu = ctxt->__hyp_running_vcpu;
@@ -83,6 +66,21 @@ static inline bool ctxt_has_s1poe(struct kvm_cpu_context *ctxt)
 	return kvm_has_s1poe(kern_hyp_va(vcpu->kvm));
 }
 
+static inline void __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
+{
+	ctxt_sys_reg(ctxt, MDSCR_EL1)	= read_sysreg(mdscr_el1);
+
+	// POR_EL0 can affect uaccess, so must be saved/restored early.
+	if (ctxt_has_s1poe(ctxt))
+		ctxt_sys_reg(ctxt, POR_EL0)	= read_sysreg_s(SYS_POR_EL0);
+}
+
+static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
+{
+	ctxt_sys_reg(ctxt, TPIDR_EL0)	= read_sysreg(tpidr_el0);
+	ctxt_sys_reg(ctxt, TPIDRRO_EL0)	= read_sysreg(tpidrro_el0);
+}
+
 static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, SCTLR_EL1)	= read_sysreg_el1(SYS_SCTLR);

-- 
2.39.5


