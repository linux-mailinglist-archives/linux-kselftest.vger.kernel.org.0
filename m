Return-Path: <linux-kselftest+bounces-34765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 724D2AD60FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 23:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544373AB2CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 21:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E3424DCE7;
	Wed, 11 Jun 2025 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VHjZDJc/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FB724A06B
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676627; cv=none; b=hS2vPqo+nLsJnlPy7RtaKcA9+TdcYWV/bO7aK4ZO1QvmRhSmy3RYxLEuSVBeUFVoWp5Ce4BUfYwJgke3utXYQ+nw11foJ00jhkTTz9qRIxtRrn6uaXqeI65vaBYmRquldVYYf2tvSsUXaRL6T1v3SrDXwvKIOcL+3pWjhFTM6kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676627; c=relaxed/simple;
	bh=x3k8bhvleSPHVSZM+Hu9CVZnDZNGJdDQHXfon2q0JNg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EVtLbMp/bxBH0JF/zlsZi93ZKJeI/w+xYXB1yJjN9wfhgn66htpA+F590KBJB/U+IAQv2WHK9ogIbh0QpkBKADlNz+FhFnLOKkIrFLNzlESzBrQcxTsbmLuukJ+6HprSi5a5IsInlpm2NzTEK9XJ9dEQGc2lzkSbONR0NLP9G30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VHjZDJc/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3139c0001b5so264758a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 14:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749676625; x=1750281425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sUa6MDoTcZ9fiqDL9aF0ZXv2kKdfYnDn1hf7TqaAmz0=;
        b=VHjZDJc/Y9l5PmFrsPGNW0CrFoJrgplwW4NKLlbpdBvuuXcmBYULslJjEF+GoMewGQ
         +Aqu1AO26tF6a17cxBGSyLHESlIfPqxO2+B6yJjo1PSTb9EOXv94hPs2SVhHIVDL4dBk
         yXb6sfISfTN3+Manx9zRaE19yAaY9YxLzfVnhQFcNe30Qqt6FRGJ0JIgjgmDGghUVFtL
         m91vgS/E1MecHtVe9iffuR88v6ItkxopCZ1hp5t4og2R/HLp4Ty3Fbj8p96UMonnTbeq
         gnY+w3WuT3Ef/tHVjwO36pgQqhLaFfJr1fdeR7lVfaQVDZWghD8sMEIqshDktCe6tply
         pMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749676625; x=1750281425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUa6MDoTcZ9fiqDL9aF0ZXv2kKdfYnDn1hf7TqaAmz0=;
        b=QEkl4UozWBL2reHy4cT1ERN58dcwCQxvnlBL3KKx81NDcH40D90fMjJe7hWUzTQ3Jw
         E9sYYYvFZ0n6afDr7bh68CYV0BA8o2Om58KsiRkdj8foWp7q75eGv8dG+7QpMLFZqTyN
         DwPhNHInKeJ+Rx0zjuaHpgtBXyQxdT8FMIc8wZotKUam86a87w7GTw1c6+HFExi2xfTq
         i7lOeQ4i+Le3FLdxaNNahk4cvIzUi5c2s7D3UhcR+cZmMBxMM8CAihO9+xNViT+iS2LP
         +JSMYqy7QFxK5cUN+deSsVYXf+hvR9qKXSN6XmqW6tXJT0Ihz16YjZ2e87D8WLtWnaBI
         9M0w==
X-Forwarded-Encrypted: i=1; AJvYcCVe+LJF07ubj+gR1KT/r1nOnUNlYGSq8WC5wi3sD+8f22by/HbpR+giDT11DvWQ04rm3L2G7PMf82zdGA9pzJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1w/BnfFcd32iz/BtqU7yjAHrp19oizbtStwGnWQ+hgli08fdL
	r6LqAQ/Q6sDqh7uRmSOeNn/6mtkiksHFAmQOq5WSWLkvkFcPmRlf68IQB/bx6s4+ouK1Od4Ov5j
	oNT40qTl2nA==
X-Google-Smtp-Source: AGHT+IFvw3e8kSlOft2Aa67tR4tbWriXJAz6qMW5rx2kfDteHiCjVlYUYiTe4hevdIc3/x6NCe31w22UVNJM
X-Received: from pjoo4.prod.google.com ([2002:a17:90b:5824:b0:30a:7da4:f075])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b87:b0:311:d05c:936
 with SMTP id 98e67ed59e1d1-313bfbf521fmr1449542a91.17.1749676625477; Wed, 11
 Jun 2025 14:17:05 -0700 (PDT)
Date: Wed, 11 Jun 2025 21:16:33 +0000
In-Reply-To: <cover.1749672978.git.afranji@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1749672978.git.afranji@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <b3b61de3224f17792bb26e0e9bcf267cf4ebbcc7.1749672978.git.afranji@google.com>
Subject: [RFC PATCH v2 06/10] KVM: TDX: Add core logic for TDX intra-host migration
From: Ryan Afranji <afranji@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: sagis@google.com, bp@alien8.de, chao.p.peng@linux.intel.com, 
	dave.hansen@linux.intel.com, dmatlack@google.com, erdemaktas@google.com, 
	isaku.yamahata@intel.com, kai.huang@intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de, 
	zhi.wang.linux@gmail.com, ackerleytng@google.com, andrew.jones@linux.dev, 
	david@redhat.com, hpa@zytor.com, kirill.shutemov@linux.intel.com, 
	linux-kselftest@vger.kernel.org, tabba@google.com, vannapurve@google.com, 
	yan.y.zhao@intel.com, rick.p.edgecombe@intel.com, 
	Ryan Afranji <afranji@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Sagi Shahar <sagis@google.com>

Adds the core logic for transferring state between source and
destination TDs during intra-host migration.

Signed-off-by: Sagi Shahar <sagis@google.com>
Co-developed-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 193 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 192 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 4582f94175b7..268aca28d878 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -3534,9 +3534,200 @@ static __always_inline bool tdx_finalized(struct kvm *kvm)
 	return tdx_kvm->state == TD_STATE_RUNNABLE;
 }
 
+#define MAX_APIC_VECTOR 256
+
+static int tdx_migrate_vcpus(struct kvm *dst, struct kvm *src)
+{
+	struct kvm_vcpu *src_vcpu;
+	struct kvm_tdx *dst_tdx;
+	unsigned long i;
+
+	dst_tdx = to_kvm_tdx(dst);
+
+	kvm_for_each_vcpu(i, src_vcpu, src)
+		tdx_flush_vp_on_cpu(src_vcpu);
+
+	/* Copy per-vCPU state. */
+	kvm_for_each_vcpu(i, src_vcpu, src) {
+		struct vcpu_tdx *dst_tdx_vcpu, *src_tdx_vcpu;
+		struct kvm_lapic_state src_lapic_state;
+		struct kvm_vcpu *dst_vcpu;
+		u64 apic_base;
+		u32 vector;
+		int ret;
+
+		src_tdx_vcpu = to_tdx(src_vcpu);
+		dst_vcpu = kvm_get_vcpu(dst, i);
+		dst_tdx_vcpu = to_tdx(dst_vcpu);
+
+		dst_vcpu->cpu = -1;
+
+		/* Destination vCPU initialization skipped so do it here. */
+		apic_base = APIC_DEFAULT_PHYS_BASE | LAPIC_MODE_X2APIC |
+			(kvm_vcpu_is_reset_bsp(dst_vcpu) ?
+			 MSR_IA32_APICBASE_BSP : 0);
+		if (kvm_apic_set_base(dst_vcpu, apic_base, true))
+			return -EINVAL;
+
+		/* Copy lapic state. */
+		ret = kvm_apic_get_state(src_vcpu, &src_lapic_state);
+		if (ret)
+			return -EINVAL;
+
+		ret = kvm_apic_set_state(dst_vcpu, &src_lapic_state);
+		if (ret)
+			return -EINVAL;
+
+		/*
+		 * pi_desc stores state of posted interrupts for VMs which are
+		 * processed by pcpu during VM entry/runtime. For
+		 * non-confidential VMs, this storage is synchronized to vcpu
+		 * state using set_lapic_state(sync_pir_to_virr).
+		 *
+		 * For TDX VMs, KVM doesn't have access to virtual lapic page,
+		 * so in order to preserve the interrupt state, copy over
+		 * pi_desc contents to destination VM during copyless migration.
+		 */
+		dst_tdx_vcpu->vt = src_tdx_vcpu->vt;
+		for (vector = 0; vector < MAX_APIC_VECTOR; vector++) {
+			if (pi_test_pir(vector, &src_tdx_vcpu->vt.pi_desc)) {
+				__vmx_deliver_posted_interrupt(
+						dst_vcpu,
+						&dst_tdx_vcpu->vt.pi_desc,
+						vector);
+			}
+		}
+
+		/* Copy non-TDX vCPU state. */
+		memcpy(dst_vcpu->arch.regs, src_vcpu->arch.regs,
+		       NR_VCPU_REGS * sizeof(src_vcpu->arch.regs[0]));
+
+		dst_vcpu->arch.regs_avail = src_vcpu->arch.regs_avail;
+		dst_vcpu->arch.regs_dirty = src_vcpu->arch.regs_dirty;
+		dst_vcpu->arch.tsc_offset = dst_tdx->tsc_offset;
+		dst_vcpu->arch.guest_state_protected =
+			src_vcpu->arch.guest_state_protected;
+		dst_vcpu->arch.xfd_no_write_intercept =
+			src_vcpu->arch.xfd_no_write_intercept;
+		dst_vcpu->arch.tsc_offset = dst_tdx->tsc_offset;
+
+		/* Copy TD structures. */
+		dst_tdx_vcpu->vp.tdvpr_page = src_tdx_vcpu->vp.tdvpr_page;
+		dst_tdx_vcpu->vp.tdcx_pages = src_tdx_vcpu->vp.tdcx_pages;
+
+		td_vmcs_write64(dst_tdx_vcpu, POSTED_INTR_DESC_ADDR,
+				__pa(&dst_tdx_vcpu->vt.pi_desc));
+
+		/* Copy current vCPU status. */
+		dst_tdx_vcpu->ext_exit_qualification =
+			src_tdx_vcpu->ext_exit_qualification;
+		dst_tdx_vcpu->exit_gpa = src_tdx_vcpu->exit_gpa;
+		dst_tdx_vcpu->vp_enter_args = src_tdx_vcpu->vp_enter_args;
+		dst_tdx_vcpu->vp_enter_ret = src_tdx_vcpu->vp_enter_ret;
+		dst_tdx_vcpu->guest_entered = src_tdx_vcpu->guest_entered;
+		dst_tdx_vcpu->map_gpa_next = src_tdx_vcpu->map_gpa_next;
+		dst_tdx_vcpu->map_gpa_end = src_tdx_vcpu->map_gpa_end;
+
+		/* Copy mirror EPT tables. */
+		vcpu_load(dst_vcpu);
+		if (kvm_mmu_move_mirror_pages_from(dst_vcpu, src_vcpu)) {
+			vcpu_put(dst_vcpu);
+			return -EINVAL;
+		}
+		vcpu_put(dst_vcpu);
+
+		dst_vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
+		dst_tdx_vcpu->state = VCPU_TD_STATE_INITIALIZED;
+
+		/*
+		 * Set these source's vCPU migrated structures to NULL to avoid
+		 * freeing them during source VM shutdown.
+		 */
+		src_tdx_vcpu->vp.tdvpr_page = NULL;
+		src_tdx_vcpu->vp.tdcx_pages = NULL;
+	}
+
+	return 0;
+}
+
 static int tdx_migrate_from(struct kvm *dst, struct kvm *src)
 {
-	return -EINVAL;
+	struct kvm_tdx *src_tdx, *dst_tdx;
+	bool charged = false;
+	int ret;
+
+	src_tdx = to_kvm_tdx(src);
+	dst_tdx = to_kvm_tdx(dst);
+
+	ret = -EINVAL;
+
+	if (src_tdx->state != TD_STATE_RUNNABLE) {
+		pr_warn("Cannot migrate from a non finalized VM\n");
+		goto abort;
+	}
+
+	/* Transfer miscellaneous cgroup. */
+	dst_tdx->misc_cg = get_current_misc_cg();
+	if (dst_tdx->misc_cg != src_tdx->misc_cg) {
+		ret = misc_cg_try_charge(MISC_CG_RES_TDX, dst_tdx->misc_cg, 1);
+		if (ret)
+			goto abort_dst_cgroup;
+		charged = true;
+	}
+
+	dst_tdx->hkid = src_tdx->hkid;
+
+	/* Copy VM data. */
+	dst_tdx->attributes = src_tdx->attributes;
+	dst_tdx->xfam = src_tdx->xfam;
+	dst_tdx->tsc_offset = src_tdx->tsc_offset;
+	dst_tdx->tsc_multiplier = src_tdx->tsc_multiplier;
+	dst_tdx->nr_premapped = src_tdx->nr_premapped;
+	dst_tdx->wait_for_sept_zap = src_tdx->wait_for_sept_zap;
+	dst_tdx->kvm.arch.gfn_direct_bits = src_tdx->kvm.arch.gfn_direct_bits;
+
+	/* Copy TD structures. */
+	dst_tdx->td.tdcs_nr_pages = src_tdx->td.tdcs_nr_pages;
+	dst_tdx->td.tdcx_nr_pages = src_tdx->td.tdcx_nr_pages;
+	dst_tdx->td.tdr_page = src_tdx->td.tdr_page;
+	dst_tdx->td.tdcs_pages = src_tdx->td.tdcs_pages;
+
+	/* Copy per-vCPU state. */
+	ret = tdx_migrate_vcpus(dst, src);
+	if (ret)
+		goto late_abort;
+
+	dst->mem_attr_array.xa_head = src->mem_attr_array.xa_head;
+	src->mem_attr_array.xa_head = NULL;
+
+	dst_tdx->state = TD_STATE_RUNNABLE;
+
+	/*
+	 * Set these source's vCPU migrated structures to NULL to avoid
+	 * freeing them during source VM shutdown.
+	 */
+	src_tdx->hkid = -1;
+	src_tdx->td.tdr_page = NULL;
+	src_tdx->td.tdcs_pages = NULL;
+
+	return 0;
+
+late_abort:
+	/*
+	 * If we aborted after the state transfer already started, the src VM
+	 * is no longer valid.
+	 */
+	kvm_vm_dead(src);
+
+abort_dst_cgroup:
+	if (charged)
+		misc_cg_uncharge(MISC_CG_RES_TDX, dst_tdx->misc_cg, 1);
+	put_misc_cg(dst_tdx->misc_cg);
+	dst_tdx->misc_cg = NULL;
+abort:
+	dst_tdx->hkid = -1;
+	dst_tdx->td.tdr_page = 0;
+	return ret;
 }
 
 int tdx_vm_move_enc_context_from(struct kvm *kvm, struct kvm *src_kvm)
-- 
2.50.0.rc1.591.g9c95f17f64-goog


