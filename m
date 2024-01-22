Return-Path: <linux-kselftest+bounces-3344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CD0836D66
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 18:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53EEB336A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA706BB31;
	Mon, 22 Jan 2024 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOYSsMvB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B576BB2C;
	Mon, 22 Jan 2024 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940942; cv=none; b=Kh7bMyAUwNEKusOx4lYVEtByLVhdxTruTPxpEvqO40lREu2sTnfvKhiKvWReu1vOXBZZsP2HpffvI+Z3FtaHlqJxPqEB2H4pdO74zaAgMBvnGEAb2UXtJNCwcZvc6k1+sS+NFsjUzII2XWAf8rdx7an7OU/uUsx9E1DQrTQA/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940942; c=relaxed/simple;
	bh=u/4aCn8rWOpEaVAHAOFXzMKEh0Hsu6r2iIRWPEGcEWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n8oRPxtdyRICs/iRVpXqbo1MXkfWKStw9WRD6hEt+Q/U9it7pyy9JPYoSxkZWdT+nGqBTeqOD+MgsqS2Hzxtqe8tjAmuGP21pxEUpKBtSdevc0Va/CSKNLMy9NMcjE8XyT9hi47TCOXo+KZWio80iU+MojMUhZzH661l9B6ru5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOYSsMvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41ADC43330;
	Mon, 22 Jan 2024 16:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705940941;
	bh=u/4aCn8rWOpEaVAHAOFXzMKEh0Hsu6r2iIRWPEGcEWw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kOYSsMvB6OgpfsJQf1jtUnjhhGxL892ekkHiUuIKdoqvkKQM2XizmIkOsYm6LFXhw
	 Lx0IfkzdtuJr0e6/VUQcThQDJufKWtLpBixg3F4I8U9/LxzYOA23BMywj3wyePeI3+
	 G44B5JGWXSLPRMWJCPdoKoiluV1kwuVK61JLV8sGORAcSA4AU/WUn4fGOIdmKAGc/S
	 gtssKibl1KDzofYrUlebCKkaNwkbEirBSX+GWBYEjR6uxGOh2/R5fu0qK8V31KsE0U
	 1hig4NuVI3cP4piLvuB3CAP+3byLOwx3S46Zq753PdrH/fqaaDIB1LxMXLDfwumW4g
	 BolfuqHp5eTPg==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Jan 2024 16:28:13 +0000
Subject: [PATCH v4 10/14] KVM: arm64: Share all userspace hardened thread
 data with the hypervisor
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-arm64-2023-dpisa-v4-10-776e094861df@kernel.org>
References: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
In-Reply-To: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <dave.martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=5087; i=broonie@kernel.org;
 h=from:subject:message-id; bh=u/4aCn8rWOpEaVAHAOFXzMKEh0Hsu6r2iIRWPEGcEWw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrpejGuYT+q8xsJvHeWcoLNXBCTdVprcoInqqAkzW
 FOxjMv6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa6XowAKCRAk1otyXVSH0FyTB/
 91Fs78b8C3Tc0dBAEsoE7GI32+NJKGvCYgBgJutIzL3Pi3Cf83qZlU5q7VH615bKrvtNotk73cfvas
 qOoUi5Tp5se2a6iNkoYaglJYqAhXct8hBozcFUg5cewlyJ2e0Yc6M0RKYKxqlCzlraxLG3bQsdlFMP
 BmxUq7qEmmqeRjpIm00Srn/Lim3B2eVB4N4HTMe4iVNSM9FwB07x2gGHL800eGbk7wsOc8zQs9M+oK
 4GGv3z087YTucH/hf1H3SyFi99qrvjbixyo82EB5wt9ZFPWbPBcYNIv/tMv1vf9HOKWdhc69X6aPq2
 RmJdIquAqQra9YsNg8UWzacbE+95tr
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
index 7993694a54af..c4fdcc94d733 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -27,6 +27,7 @@
 #include <asm/fpsimd.h>
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
+#include <asm/processor.h>
 #include <asm/vncr_mapping.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
@@ -601,7 +602,7 @@ struct kvm_vcpu_arch {
 	struct kvm_guest_debug_arch vcpu_debug_state;
 	struct kvm_guest_debug_arch external_debug_state;
 
-	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
+	struct thread_struct_uw *host_uw;	/* hyp VA */
 	struct task_struct *parent_task;
 
 	struct {
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index b453c66d3fae..544baa57f9b9 100644
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
 		unsigned long	fpmr;
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index e3e611e30e91..6cf22cd8f020 100644
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
index a038320cdb08..27fcdfd432b9 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -371,7 +371,7 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 
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


