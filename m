Return-Path: <linux-kselftest+bounces-39637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5125FB30B35
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 04:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D61B61961
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 01:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC15928935C;
	Fri, 22 Aug 2025 01:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8+F/bPw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA411FBEA6;
	Fri, 22 Aug 2025 01:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827731; cv=none; b=dLSvP2CLp9r/nnfgBXSX/9CG1RGhYBrVDefsJ1TIe9rMss4KAK/16lh+3cMyga7E4wT5SNrveOJDn7jRsJoMNyphCaOS1oJnl1kJKuXKdyU0GAbhzSsVHXxuxBboLJh/vLx3+36yqsKoPpjVhHgeNlZfzS3wIgzxqevx30wLXD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827731; c=relaxed/simple;
	bh=s9OgbUV3jMegR4yK5YJZn39bA8MN2bqc20M/qGI/rlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ig/H/aLnrrKFgneC0p1zBdw/FnBVWYrFgBDjPtgSZ4Y6hXEeWENYYufcarPFoNHCWnFsQM+GMDdTfAsajdXQkh6pB9aaQV03C1wzXcgZWpv7MbTWpr9Hw9AbeP+lSseDDX16HWUP6sfbUiqPlgryvBChzCTpgsgYIP4P7MpRil4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8+F/bPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D9FC4CEEB;
	Fri, 22 Aug 2025 01:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755827731;
	bh=s9OgbUV3jMegR4yK5YJZn39bA8MN2bqc20M/qGI/rlg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r8+F/bPwDnjx3PW+1K+PfYpsYZOG3boGlYS+v7yXc7666DiMo7cMMmz/C1F/CjieN
	 A0V1++nJtJzwRwweFNbHcrf/TWyOGGvb5J0eZYOg3Tzr3/SNfFV6V4n+2qSPH46jxl
	 Ql2ZGOO4r0dl93hQ9pTxaMKQ57LaGgjenFlNsb++ZBXX804NZCHK7cmGKqzhs23HyF
	 Y2YNpLNtHsiAw0cp1Qr84ek3m2FuXqGauacG70TP1Bs5/hDmoscVDIW1EM4RDM7/PQ
	 v5u6UK97sPmkW7U4+SZPAQlR+X2zsoZb7BUUmbg2a3KvvJIJYoB6iZ621Tx48+J843
	 s5C+NDIoLew9Q==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Aug 2025 02:53:46 +0100
Subject: [PATCH v7 17/29] KVM: arm64: Support TPIDR2_EL0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-kvm-arm64-sme-v7-17-7a65d82b8b10@kernel.org>
References: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
In-Reply-To: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=3465; i=broonie@kernel.org;
 h=from:subject:message-id; bh=s9OgbUV3jMegR4yK5YJZn39bA8MN2bqc20M/qGI/rlg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBop83FGVS0KWqKNvAlONV3hETel4NcSUAM/aj0j
 0aoaNpVSJKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKfNxQAKCRAk1otyXVSH
 0NzWB/9KKtPaXuIKr/ECc2Rv/FcTi1K4u1461JdAw19F2JZS2w0WMjSSN+prsvnTIFjqaA27yzm
 kZxn+CdPlsC3RwDbbgnjTZ8OzsG1wcMltmWAGyzbnbbi4pPE8y3bzED/RqusY4UROoav0ULUPTX
 Rd2QJNU99KfdK0R2wPtITQyZy2B4dyA7gyX5IePoGQfmZ9IpMSBc551EvH57sLEfOJZ3OOYUw32
 mfpOMd8YYv0T7iyM9udn5dtJEHlIJo1IoKlanksKx6Avq9Rm0OQUwQqoMDgsLvbUtv/ubKMlzFO
 1NCSjIB6blIgQNFm88TNL/rbX6ggGBpBtHLogWsi3M2Zj97O
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME adds a new thread ID register, TPIDR2_EL0. This is used in userspace
for delayed saving of the ZA state but in terms of the architecture is
not really connected to SME other than being part of FEAT_SME. It has an
independent fine grained trap and the runtime connection with the rest
of SME is purely software defined.

Expose the register as a system register if the guest supports SME,
context switching it along with the other EL0 TPIDRs.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h          |  1 +
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 15 +++++++++++++++
 arch/arm64/kvm/sys_regs.c                  |  3 ++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index edb2acdb4bd1..632c74397fa9 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -450,6 +450,7 @@ enum vcpu_sysreg {
 	CSSELR_EL1,	/* Cache Size Selection Register */
 	TPIDR_EL0,	/* Thread ID, User R/W */
 	TPIDRRO_EL0,	/* Thread ID, User R/O */
+	TPIDR2_EL0,	/* Thread ID, Register 2 */
 	TPIDR_EL1,	/* Thread ID, Privileged */
 	CNTKCTL_EL1,	/* Timer Control Register (EL1) */
 	PAR_EL1,	/* Physical Address Register */
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index 5624fd705ae3..8c3b3d6df99f 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -88,6 +88,17 @@ static inline bool ctxt_has_sctlr2(struct kvm_cpu_context *ctxt)
 	return kvm_has_sctlr2(kern_hyp_va(vcpu->kvm));
 }
 
+static inline bool ctxt_has_sme(struct kvm_cpu_context *ctxt)
+{
+	struct kvm_vcpu *vcpu;
+
+	if (!system_supports_sme())
+		return false;
+
+	vcpu = ctxt_to_vcpu(ctxt);
+	return kvm_has_sme(kern_hyp_va(vcpu->kvm));
+}
+
 static inline bool ctxt_is_guest(struct kvm_cpu_context *ctxt)
 {
 	return host_data_ptr(host_ctxt) != ctxt;
@@ -127,6 +138,8 @@ static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, TPIDR_EL0)	= read_sysreg(tpidr_el0);
 	ctxt_sys_reg(ctxt, TPIDRRO_EL0)	= read_sysreg(tpidrro_el0);
+	if (ctxt_has_sme(ctxt))
+		ctxt_sys_reg(ctxt, TPIDR2_EL0)	= read_sysreg_s(SYS_TPIDR2_EL0);
 }
 
 static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
@@ -204,6 +217,8 @@ static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
 {
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL0),	tpidr_el0);
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDRRO_EL0),	tpidrro_el0);
+	if (ctxt_has_sme(ctxt))
+		write_sysreg_s(ctxt_sys_reg(ctxt, TPIDR2_EL0), SYS_TPIDR2_EL0);
 }
 
 static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt,
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 81742e9237c0..4166d396450d 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3243,7 +3243,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	  .visibility = s1poe_visibility },
 	{ SYS_DESC(SYS_TPIDR_EL0), NULL, reset_unknown, TPIDR_EL0 },
 	{ SYS_DESC(SYS_TPIDRRO_EL0), NULL, reset_unknown, TPIDRRO_EL0 },
-	{ SYS_DESC(SYS_TPIDR2_EL0), undef_access },
+	{ SYS_DESC(SYS_TPIDR2_EL0), NULL, reset_unknown, TPIDR2_EL0,
+	  .visibility = sme_visibility},
 
 	{ SYS_DESC(SYS_SCXTNUM_EL0), undef_access },
 

-- 
2.39.5


