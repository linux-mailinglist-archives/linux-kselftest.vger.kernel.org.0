Return-Path: <linux-kselftest+bounces-6788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E150890EFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7238AB2353C
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CBC848E;
	Fri, 29 Mar 2024 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoIFU6vi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709F8747F;
	Fri, 29 Mar 2024 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671238; cv=none; b=XfEFJ5CTiAAnhm5vuMNTuq2v+T8bE88Fdy6mDXHPwD6lwX+gTQHgoA3rbu+xxMN4Ti8EbYptakE/cr2JTnjXtQA+lPa/hpBjIHW1xwWXu/0iH8ogr6B/1zNa1HpXtsoY4rrBwfzGKmPYZSJoztbbCX1n8laz1dn91cBtsfxS1/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671238; c=relaxed/simple;
	bh=JDqU0s6FSirWyIEdcD4KYNY0MDkXzITXMMkssZv+Ci0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CF4Rha4MIgF6A5q8cXoCrllfVu5z8iF5VmqysNEStKZMu9SsSgADu2npdEXKcIolrwB2893UZWEBpFxt6LXLFDAgXhO6GVBNF1VeIJsZe8oUDtFxxfZmMC3/JpoTBPCxlzJh6wgyukrMuMiON8a+BFqS1GwhIAHkzh5lgbAEMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoIFU6vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CF3C433A6;
	Fri, 29 Mar 2024 00:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711671238;
	bh=JDqU0s6FSirWyIEdcD4KYNY0MDkXzITXMMkssZv+Ci0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DoIFU6viMdIEQSjd1ljsnK+ZpW0bbV/0JAXzdlCF6cJ+R/ewGKrRxtA3s0HTX7NV7
	 OFHxkraqGqc44OEgWxZAgvrNZV05+Yl0arDidXk6EM0T69K0X3RuYJvBoygWni/D13
	 U0fKTM9YdH471HvJ5LiwAMuDgMkdRkq1DBC4GeTkx7eMa/EtZM9Ulw2VYNclDZk4fL
	 QTBTYaFHKnS8zL4QhbkBhARSJrB3K+9A2/jZ4H1ywxAGce4sNE3MTVCyOD6dm6/ZQ2
	 bzWQkuHWdAMP1GyZ7ofWtn0vO4oZVHW1dKeqMFUt4oGcwXxAYUIca0Uu8PWH0BqPF+
	 H4pdpA05eePAQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 29 Mar 2024 00:13:42 +0000
Subject: [PATCH v6 1/5] KVM: arm64: Share all userspace hardened thread
 data with the hypervisor
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-arm64-2023-dpisa-v6-1-ba42db6c27f3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5078; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JDqU0s6FSirWyIEdcD4KYNY0MDkXzITXMMkssZv+Ci0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmBge7EkB6Mfpz5ZYw9vj91uP4suY44c/0Q98N5j4g
 zzMaKumJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZgYHuwAKCRAk1otyXVSH0LqyB/
 9OffvPdwI5dRB5X9kyU+h1Z0YEVGX9PcGwLXagaEC8Sr0NavGQIBaaZN/8Bwlr/L+xfkAbEsscgkNL
 5/GFB+gs2tznIxTxnfp5W+BaFZ05PAzkvcNH1Bbj+guArM7iD013hsOFBIm+acpvFsVfwmXx64b8/v
 lqd1i3sdG1c8Hwtyi3rH80ZxRx0klE8086uscaiMIlSJQ5PIxjhS318my4VBtzbMjY11TPFrtIEpXk
 5IiDF5kGYZtQ5UJHQBmzuOjh13vdGWCH37jJkHNYx3JpfTNJAzSY943AvNAfeRsvYSuWOIJqIuQf2x
 gxGePTmtHa9uofZPBFfNzIN2G7uowN
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

As part of the lazy FPSIMD state transitioning done by the hypervisor we
currently share the userpsace FPSIMD state in thread->uw.fpsimd_state with
the host. Since this struct is non-extensible userspace ABI we have to keep
the definition as is but the addition of FPMR in the 2023 dpISA means that
we will want to share more storage with the host. To facilitate this
refactor the current code to share the entire thread->uw rather than just
the one field.

The large number of references to fpsimd_state make it very inconvenient
to add an additional wrapper struct.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h       |  3 ++-
 arch/arm64/include/asm/processor.h      |  2 +-
 arch/arm64/kvm/fpsimd.c                 | 13 ++++++-------
 arch/arm64/kvm/hyp/include/hyp/switch.h |  2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      |  4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 9e8a496fb284..8a251f0da900 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -27,6 +27,7 @@
 #include <asm/fpsimd.h>
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
+#include <asm/processor.h>
 #include <asm/vncr_mapping.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
@@ -640,7 +641,7 @@ struct kvm_vcpu_arch {
 	struct kvm_guest_debug_arch vcpu_debug_state;
 	struct kvm_guest_debug_arch external_debug_state;
 
-	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
+	struct thread_struct_uw *host_uw;	/* hyp VA */
 	struct task_struct *parent_task;
 
 	struct {
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index f77371232d8c..78781333ee26 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -152,7 +152,7 @@ struct thread_struct {
 	 * Maintainers must ensure manually that this contains no
 	 * implicit padding.
 	 */
-	struct {
+	struct thread_struct_uw {
 		unsigned long	tp_value;	/* TLS register */
 		unsigned long	tp2_value;
 		u64		fpmr;
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 826307e19e3a..8a0fedbb6f39 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -17,13 +17,13 @@
 void kvm_vcpu_unshare_task_fp(struct kvm_vcpu *vcpu)
 {
 	struct task_struct *p = vcpu->arch.parent_task;
-	struct user_fpsimd_state *fpsimd;
+	struct thread_struct_uw *uw;
 
 	if (!is_protected_kvm_enabled() || !p)
 		return;
 
-	fpsimd = &p->thread.uw.fpsimd_state;
-	kvm_unshare_hyp(fpsimd, fpsimd + 1);
+	uw = &p->thread.uw;
+	kvm_unshare_hyp(uw, uw + 1);
 	put_task_struct(p);
 }
 
@@ -39,17 +39,16 @@ void kvm_vcpu_unshare_task_fp(struct kvm_vcpu *vcpu)
 int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
 {
 	int ret;
-
-	struct user_fpsimd_state *fpsimd = &current->thread.uw.fpsimd_state;
+	struct thread_struct_uw *uw = &current->thread.uw;
 
 	kvm_vcpu_unshare_task_fp(vcpu);
 
 	/* Make sure the host task fpsimd state is visible to hyp: */
-	ret = kvm_share_hyp(fpsimd, fpsimd + 1);
+	ret = kvm_share_hyp(uw, uw + 1);
 	if (ret)
 		return ret;
 
-	vcpu->arch.host_fpsimd_state = kern_hyp_va(fpsimd);
+	vcpu->arch.host_uw = kern_hyp_va(uw);
 
 	/*
 	 * We need to keep current's task_struct pinned until its data has been
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index e3fcf8c4d5b4..a9a11893c191 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -377,7 +377,7 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 
 	/* Write out the host state if it's in the registers */
 	if (vcpu->arch.fp_state == FP_STATE_HOST_OWNED)
-		__fpsimd_save_state(vcpu->arch.host_fpsimd_state);
+		__fpsimd_save_state(&(vcpu->arch.host_uw->fpsimd_state));
 
 	/* Restore the guest state */
 	if (sve_guest)
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 2385fd03ed87..eb2208009875 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -42,7 +42,7 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 	hyp_vcpu->vcpu.arch.fp_state	= host_vcpu->arch.fp_state;
 
 	hyp_vcpu->vcpu.arch.debug_ptr	= kern_hyp_va(host_vcpu->arch.debug_ptr);
-	hyp_vcpu->vcpu.arch.host_fpsimd_state = host_vcpu->arch.host_fpsimd_state;
+	hyp_vcpu->vcpu.arch.host_uw	= host_vcpu->arch.host_uw;
 
 	hyp_vcpu->vcpu.arch.vsesr_el2	= host_vcpu->arch.vsesr_el2;
 
@@ -64,7 +64,7 @@ static void sync_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 	host_vcpu->arch.fault		= hyp_vcpu->vcpu.arch.fault;
 
 	host_vcpu->arch.iflags		= hyp_vcpu->vcpu.arch.iflags;
-	host_vcpu->arch.fp_state	= hyp_vcpu->vcpu.arch.fp_state;
+	host_vcpu->arch.host_uw		= hyp_vcpu->vcpu.arch.host_uw;
 
 	host_cpu_if->vgic_hcr		= hyp_cpu_if->vgic_hcr;
 	for (i = 0; i < hyp_cpu_if->used_lrs; ++i)

-- 
2.30.2


