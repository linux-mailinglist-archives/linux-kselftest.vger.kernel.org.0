Return-Path: <linux-kselftest+bounces-40577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 143BDB3FE5A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 13:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F351890A70
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F63305043;
	Tue,  2 Sep 2025 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZuYqXi+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BAE2FC020;
	Tue,  2 Sep 2025 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813540; cv=none; b=PA5DuptkHQXqfX4OAXzoEj98wBfG5yWrAP8KDfPXKiRZHBOyNmFVPwVGE5jBFjk/XI1X2KcH0scNh+ES/GdbUOdCnzv9k9x12G3jAkpImTsTyKAUPzP0dfzztIGGnZRGUB5yplG0cINft36NdFY4ZhfJ6WILcDg17aJf9KyD1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813540; c=relaxed/simple;
	bh=s9OgbUV3jMegR4yK5YJZn39bA8MN2bqc20M/qGI/rlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p6eSV7pUlMw32pP7iPQL04hxPV6nCvx2V28cd2an5caFEipSek6HN3FZX85/ZkbRUd6YJGzCN/HgADjMLBdnLw4itg8RogIBRQ3xXCp3jVYfxkNN5hQV6tciBzGmBBHA+KRTb6V0mRwmpO94uK8Z87yz5C3bJOeQLq7CjLCQ5j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZuYqXi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C9CC4CEED;
	Tue,  2 Sep 2025 11:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813538;
	bh=s9OgbUV3jMegR4yK5YJZn39bA8MN2bqc20M/qGI/rlg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QZuYqXi+TSZTdOoPLIGC+xq12gG0BUGZV/l6O6cGxTjuMso+gHFB60OFQQWy4bZwG
	 SCl+AxUwSejvbC60tDeruUtR24GXcbQQ6POOapbxD9gl7Qk9KIvGndoHeGR0HcMPFK
	 owi4z68OUMZ8Y665JLPPIoRATIwi/q7V/JuGTDYsluS/CBGfNB4lt5BmnaxVDgjxVg
	 J2WY1CgntRGRyILwRZB42gohn2824HLssRVhlsGmJUQER/Br6V7UJ9DEAk7q9tbmMr
	 yvK8ZWRDLOCLzs+9IWrHM4BfqjRE4vUFyYbr2efzrX3AqrZ4pXQHu5v78xaWCvMfJu
	 UFcE5fo+5oUUg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 12:36:20 +0100
Subject: [PATCH v8 17/29] KVM: arm64: Support TPIDR2_EL0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-kvm-arm64-sme-v8-17-2cb2199c656c@kernel.org>
References: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
In-Reply-To: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=3465; i=broonie@kernel.org;
 h=from:subject:message-id; bh=s9OgbUV3jMegR4yK5YJZn39bA8MN2bqc20M/qGI/rlg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBottiHDFKJXw5f2H21IFF1uQvm/fPZsanmuSrom
 /a5i86XmZ6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbYhwAKCRAk1otyXVSH
 0OahB/9y3zF/euhwkQBojIIq0LMsL+jbp3v2b9QbC0+ZlZGtcktmT5/5mY8wKvAJGw/Tgu0/Q+Z
 5YLpJf5cp+gcsIV93+PFIPh42owo6MklqRVtxOj/8RF4g2vC3akJV1XD1lrZpZe/CZRXF7J+vDU
 F1TcDxb6Vh781UNrLAs9cTMINcu0R3QJXaCySGQ0WFb6tbvPPj+urfNZYwHq9/1rMKCKN7olb1X
 +bredmoG7fhmcywiAEgR0n8kF3V2SIiDigFPkMjT812i+nJqbGeXRVe6YE9rh+tQBPuXTR+deMH
 OVLTPtaUy6h8TRHTboPrmy7/OQaEJU05Iec6EPI2ZssuiBGw
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


