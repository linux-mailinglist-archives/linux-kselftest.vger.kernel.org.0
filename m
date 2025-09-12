Return-Path: <linux-kselftest+bounces-41322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33D1B54AE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 13:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9818FA046F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 11:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73665301495;
	Fri, 12 Sep 2025 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNaJHEZC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438BE301475;
	Fri, 12 Sep 2025 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676132; cv=none; b=KjzpRs+TL80A0kCmNzH864WihUZVgTPy+gPtmL8FZe3RryAIpCo+XR9B0ARpQqZtxk57bAVV0skOXbrTD9hRsMRtZ4kHEro/iyNVWdoBU27mO5xMg/0jRQWCcTEHWWKs0Q+NkJnDLZqi7Ycu/HkjUDAwez0Kjpe8m7WdT8IfMD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676132; c=relaxed/simple;
	bh=tEz0LD0nUb9QTay3NFwM/E0GFA9eVx39ShtKmUAGyXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DwNoNwiJDa4fT2F6Lsibdtnm3RfFk/kB9P6mHKVw7jY3eC5C4ByNWwmZUbvi3zSf//eFg3yFJRrgPe1BO8capwuY/9vIH5n1/Tl0wcBzNx+XwfLSrFZ8IaKATVE0rwdKOWiIsygK48BP41+zqj0wnAskFeJ4BJ4WBbbTmgfH2kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNaJHEZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4371C4CEF4;
	Fri, 12 Sep 2025 11:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757676132;
	bh=tEz0LD0nUb9QTay3NFwM/E0GFA9eVx39ShtKmUAGyXA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CNaJHEZCaaEo2E4j3PL4R5FM8yhHh5PXEOAT7OC+YSKniultlr1w6ezN/WSaEQUbe
	 8fQamtXFns3+fOwfsVoWPoVWcuCtzSzIxhcKkenb14oHXsnKDpzhZWxhYZ5PwJpwvL
	 X0yG8mpDHBOshYQMyNknZhXDjrcPQbXkEvtxuJ+7Cv9M4+nsbcGH0a6PA/vopT3gDo
	 1ko6q1KYRCMrur9oTBTDjCd/QSUbukez5Eqqm+hGbCpoXJ75zNfJyPvltMN+l8gIq2
	 f5UaBb9Jrmjqs7U209oYnyZERMECGif+JGpJODVQycnvLPNjXrz/MtC9Iw8BbZE1fc
	 6MzpKkUl92uaw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 12 Sep 2025 10:25:29 +0100
Subject: [PATCH v16 3/6] KVM: arm64: Set PSTATE.EXLOCK when entering an
 exception
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-arm64-gcs-v16-3-6435e5ec37db@kernel.org>
References: <20250912-arm64-gcs-v16-0-6435e5ec37db@kernel.org>
In-Reply-To: <20250912-arm64-gcs-v16-0-6435e5ec37db@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=2696; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tEz0LD0nUb9QTay3NFwM/E0GFA9eVx39ShtKmUAGyXA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoxAJWddQLOEjGHb/JtftEpYebeUoHJGoEcvoG5
 ShkXO/KPI+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaMQCVgAKCRAk1otyXVSH
 0H48B/9va91KX7b6kDAmSHI6tUF0WeXt2KY3rbl4XPPR26sekC9rtI55PVJC24OgB3abh1dgipT
 k56ImZy3+ESiRy+jbdsf2bwErO9SG48BotdjQUD1rikMG6hgmWLE82BgNqxCpSJLgkrZrhzSPXZ
 uoedrm26OTsxg0s46N9SEj6oicCb8ptm2DTjPJw3otdSEnRAiujowcSyAfbVz+NC/x4/bgyG3Bi
 Vl3p/Eo8vQ7UbvNR3YAigm/xlXcy8HQulHN28UtvYt82doKvi34pMNr0ZyIOACyu21FN+TsDNI/
 UITfqlcprVQuKRIRv1WUTUYp+mWHCdnSRDrJY9jTRYlyZ5tM
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

As per DDI 0487 R_WTXBY we need to manage PSTATE.EXLOCK when entering an
exception, when the exception is entered from a lower EL the bit is cleared
while if entering from the same EL it is set to GCSCR_ELx.EXLOCKEN.
Implement this behaviour in enter_exception64().

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/uapi/asm/ptrace.h |  1 +
 arch/arm64/kvm/hyp/exception.c       | 37 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 0f39ba4f3efd..f2fb029fb61a 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -56,6 +56,7 @@
 #define PSR_C_BIT	0x20000000
 #define PSR_Z_BIT	0x40000000
 #define PSR_N_BIT	0x80000000
+#define PSR_EXLOCK_BIT 0x400000000
 
 #define PSR_BTYPE_SHIFT		10
 
diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
index 95d186e0bf54..888cea250dc2 100644
--- a/arch/arm64/kvm/hyp/exception.c
+++ b/arch/arm64/kvm/hyp/exception.c
@@ -73,6 +73,38 @@ static void __vcpu_write_spsr_und(struct kvm_vcpu *vcpu, u64 val)
 		vcpu->arch.ctxt.spsr_und = val;
 }
 
+static unsigned long compute_exlock(struct kvm_vcpu *vcpu,
+				    unsigned long mode,
+				    unsigned long target_mode)
+{
+	u64 gcscr;
+
+	if (!kvm_has_gcs(kern_hyp_va(vcpu->kvm)))
+		return 0;
+
+	/* GCS can't be enabled for 32 bit */
+	if (mode & PSR_MODE32_BIT)
+		return 0;
+
+	/* When taking an exception to a higher EL EXLOCK is cleared. */
+	if ((mode | PSR_MODE_THREAD_BIT) != target_mode)
+		return 0;
+
+	/*
+	 * When taking an exception to the same EL EXLOCK is set to
+	 * the effective value of GCSR_ELx.EXLOCKEN.
+	 */
+	if (vcpu_is_el2(vcpu))
+		gcscr = __vcpu_read_sys_reg(vcpu, GCSCR_EL2);
+	else
+		gcscr = __vcpu_read_sys_reg(vcpu, GCSCR_EL1);
+
+	if (gcscr & GCSCR_ELx_EXLOCKEN)
+		return PSR_EXLOCK_BIT;
+
+	return 0;
+}
+
 /*
  * This performs the exception entry at a given EL (@target_mode), stashing PC
  * and PSTATE into ELR and SPSR respectively, and compute the new PC/PSTATE.
@@ -162,6 +194,11 @@ static void enter_exception64(struct kvm_vcpu *vcpu, unsigned long target_mode,
 	// PSTATE.BTYPE is set to zero upon any exception to AArch64
 	// See ARM DDI 0487E.a, pages D1-2293 to D1-2294.
 
+	// PSTATE.EXLOCK is set to 0 upon any exception to a higher
+	// EL, or to GCSCR_ELx.EXLOCKEN for an exception to the same
+	// exception level.  See ARM DDI 0487 R_WTXBY.
+	new |= compute_exlock(vcpu, mode, target_mode);
+
 	new |= PSR_D_BIT;
 	new |= PSR_A_BIT;
 	new |= PSR_I_BIT;

-- 
2.47.2


