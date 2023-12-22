Return-Path: <linux-kselftest+bounces-2387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F98581CCD7
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C331F2386B
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165102554F;
	Fri, 22 Dec 2023 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="safjcEer"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C42E83B;
	Fri, 22 Dec 2023 16:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C80BC433C8;
	Fri, 22 Dec 2023 16:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262132;
	bh=u4v5arQiVHeHKG21SqvtNIX4Uypu7C8ZmOnD8i2QJvk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=safjcEerjxHT4v9fqyu8H3Pk18LpZri/1oiPivDCOT8Xm4lPx5buMMKXBHPwPh6As
	 DpGdZaplNm5hQ4EY1BL7Y9ez8WILIFWER/rjCD0VrPRiczEx5N4M6t29WIFAfErnss
	 Wew+lfuJ9rHnA0aXfpP4sdb/i7HqD/XE4KxDItAnZvbRpLeeuzv5X/kvknGMAFuTZJ
	 EheaXMdSekz9aMe2851O5FIEe8203VDBCoJ/Gl4tkMxPf50S+IwU/q/OEyk9ClwbLl
	 PqJ6g7iKrV/0Sxg/eBEEDsB3HnpyyHMerlr8/zLY94urIneEk5MziCcI1TTzruWCJ0
	 xyOs6XL4G6xCQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:18 +0000
Subject: [PATCH RFC v2 10/22] KVM: arm64: Add support for TPIDR2_EL0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-10-da226cb180bb@kernel.org>
References: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
In-Reply-To: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=4496; i=broonie@kernel.org;
 h=from:subject:message-id; bh=u4v5arQiVHeHKG21SqvtNIX4Uypu7C8ZmOnD8i2QJvk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhbeDZDIuZUB0BWHutkWWfa/uyst8Rqwgp0BkytLY
 eq6je6+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYW3gwAKCRAk1otyXVSH0PoxB/
 9aQxKHA/jL5ktDLPjAxNWbFdGzLvQlLB4//KteJbLwoVKoarQlEOTyu9CYJJ6GMMq/8Yk8wnw6BpL+
 tyWQKzxGHHN0kJIo1RG9iJWIYbwtPWz3U/KhDw9DnNVqmmf4LyMq8+AfrsiNWEWWwbM0bGnyGf+olE
 jGepcz3n0vTFZU0r+qdWNPcMRXiWVbNS2s/B67XRZEh6vPXeUJyZSW/FZ5uNh/BMwgx7U4QAfnY1ZJ
 6kwxeyczFGZTZLNmgN5f+dFBrkfGR6hddjKCcQtOwW2pKMZW+Ypi1LuXcjYvmKyZ2az9MsHjg60ZJ/
 GTvLipwr1ua82wsTWbqk0G3ZJqOwxN
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME adds a new user register TPIDR2_EL0, implement support for mananging
this for guests. We provide system register access to it, disable traps
and context switch it along with the other TPIDRs for guests with SME.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h          | 3 +++
 arch/arm64/kvm/hyp/include/hyp/switch.h    | 5 ++++-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 6 ++++++
 arch/arm64/kvm/sys_regs.c                  | 2 +-
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 4be5dda9734d..36bf9d7e92e1 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -347,6 +347,7 @@ enum vcpu_sysreg {
 	CONTEXTIDR_EL1,	/* Context ID Register */
 	TPIDR_EL0,	/* Thread ID, User R/W */
 	TPIDRRO_EL0,	/* Thread ID, User R/O */
+	TPIDR2_EL0,	/* Thread ID 2, User R/W */
 	TPIDR_EL1,	/* Thread ID, Privileged */
 	AMAIR_EL1,	/* Aux Memory Attribute Indirection Register */
 	CNTKCTL_EL1,	/* Timer Control Register (EL1) */
@@ -885,6 +886,7 @@ static inline bool __vcpu_read_sys_reg_from_cpu(int reg, u64 *val)
 	case CONTEXTIDR_EL1:	*val = read_sysreg_s(SYS_CONTEXTIDR_EL12);break;
 	case TPIDR_EL0:		*val = read_sysreg_s(SYS_TPIDR_EL0);	break;
 	case TPIDRRO_EL0:	*val = read_sysreg_s(SYS_TPIDRRO_EL0);	break;
+	case TPIDR2_EL0:	*val = read_sysreg_s(SYS_TPIDR2_EL0);	break;
 	case TPIDR_EL1:		*val = read_sysreg_s(SYS_TPIDR_EL1);	break;
 	case AMAIR_EL1:		*val = read_sysreg_s(SYS_AMAIR_EL12);	break;
 	case CNTKCTL_EL1:	*val = read_sysreg_s(SYS_CNTKCTL_EL12);	break;
@@ -928,6 +930,7 @@ static inline bool __vcpu_write_sys_reg_to_cpu(u64 val, int reg)
 	case VBAR_EL1:		write_sysreg_s(val, SYS_VBAR_EL12);	break;
 	case CONTEXTIDR_EL1:	write_sysreg_s(val, SYS_CONTEXTIDR_EL12);break;
 	case TPIDR_EL0:		write_sysreg_s(val, SYS_TPIDR_EL0);	break;
+	case TPIDR2_EL0:	write_sysreg_s(val, SYS_TPIDR2_EL0);	break;
 	case TPIDRRO_EL0:	write_sysreg_s(val, SYS_TPIDRRO_EL0);	break;
 	case TPIDR_EL1:		write_sysreg_s(val, SYS_TPIDR_EL1);	break;
 	case AMAIR_EL1:		write_sysreg_s(val, SYS_AMAIR_EL12);	break;
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 9601212bd3ce..72982e752972 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -93,7 +93,10 @@ static inline void __activate_traps_hfgxtr(struct kvm_vcpu *vcpu)
 	ctxt_sys_reg(hctxt, HFGWTR_EL2) = read_sysreg_s(SYS_HFGWTR_EL2);
 
 	if (cpus_have_final_cap(ARM64_SME)) {
-		tmp = HFGxTR_EL2_nSMPRI_EL1_MASK | HFGxTR_EL2_nTPIDR2_EL0_MASK;
+		tmp = HFGxTR_EL2_nSMPRI_EL1_MASK;
+
+		if (!vcpu_has_sme(vcpu))
+			tmp |= HFGxTR_EL2_nTPIDR2_EL0_MASK;
 
 		r_clr |= tmp;
 		w_clr |= tmp;
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index fb84834cd2a0..5436b33d50b7 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -35,6 +35,9 @@ static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, TPIDR_EL0)	= read_sysreg(tpidr_el0);
 	ctxt_sys_reg(ctxt, TPIDRRO_EL0)	= read_sysreg(tpidrro_el0);
+
+	if (ctxt_has_sme(ctxt))
+		ctxt_sys_reg(ctxt, TPIDR2_EL0) = read_sysreg_s(SYS_TPIDR2_EL0);
 }
 
 static inline bool ctxt_has_mte(struct kvm_cpu_context *ctxt)
@@ -105,6 +108,9 @@ static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
 {
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL0),	tpidr_el0);
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDRRO_EL0),	tpidrro_el0);
+
+	if (ctxt_has_sme(ctxt))
+		write_sysreg_s(ctxt_sys_reg(ctxt, TPIDR2_EL0), SYS_TPIDR2_EL0);
 }
 
 static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index e6339ca1d8dc..a33ad12dc3ab 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2369,7 +2369,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_TPIDR_EL0), NULL, reset_unknown, TPIDR_EL0 },
 	{ SYS_DESC(SYS_TPIDRRO_EL0), NULL, reset_unknown, TPIDRRO_EL0 },
-	{ SYS_DESC(SYS_TPIDR2_EL0), undef_access },
+	{ SYS_DESC(SYS_TPIDR2_EL0), NULL, reset_unknown, TPIDR2_EL0, 0, .visibility = sme_visibility },
 
 	{ SYS_DESC(SYS_SCXTNUM_EL0), undef_access },
 

-- 
2.30.2


