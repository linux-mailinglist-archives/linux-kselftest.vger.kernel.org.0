Return-Path: <linux-kselftest+bounces-34762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 317EDAD60F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 23:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022F51BC2956
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 21:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE20E247DE1;
	Wed, 11 Jun 2025 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qZ+shGyL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5055D246797
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676622; cv=none; b=TlW4ssVPhFfT1oLJ46CG7DnRUz/9f5chnWHxzlLzJ0ENKHs17wa5VZwGX4ePBrvNX5yzV2CpIe8NDLiD+KUDGKh6EjU/WXFzSoBFf7fp04py1opZ4zLqfffF8DWce+C+hA3ZUQRZ7vPgpd/jn1kB1NHUWzilDq+DVu/2HLX4s2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676622; c=relaxed/simple;
	bh=EliRXJasvagyPsAst5/DK5fV9+Nz9GPWmMU52maUMAU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aR+Y1aujjI1l1qyCrjPIXMKut2WTQOoLdy8pDaw3xs1OzC81XzaL9RjzHxLLNdTPGqBSXJIXbmtqOY0Ko6jKmArvnN7TUpBzwtPqf7keIPHIJT0Nhzrl5larldInA0ymvEsnLsMU4X+SZgCMXZA+YVK3VZ+RhAnnPmIOwL8hPg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qZ+shGyL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-747d394f45fso216532b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749676620; x=1750281420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sBfca3HTQRqrJJwA201rhl29YEXxOvfPcejKdAe4i9w=;
        b=qZ+shGyLSQDl3spdrL0FFV3vW8iGhGw1Z4h2wPqXxeuGsCLcQ83MZ8ue9g2j+X11kA
         z4f2FeAxrBjXCuL4LI1Kg1+KYbESqQMmvL8jLkkPTxWAR6ZW2Q6/UnkSxArJMqajDHyt
         9qus/WWX/IdL0fyCnsrbg2U6v746JoU7MwQ1wurBfJP2vMY73ehVDrAeJPPXN6dQfK5k
         Nn+FGefxQTSUJWI4TZuMcNKTV/94VEbZ8wG9wIpFGIO5prdLP8gGGVIB5j5cOWTLUBkU
         GvIRC8K0EkDvz5yImlGoUJLt0rIqKbN7g3XXsS4ZnaaVHbvFTSVZ+nNRiZ1Sf6avuKPa
         JutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749676620; x=1750281420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBfca3HTQRqrJJwA201rhl29YEXxOvfPcejKdAe4i9w=;
        b=QDlSIDt4CDkun555RIxJsXpRgBtm/7iVeS99QuEnlPQCpaoxs3ftrQGHDE/5et9/Ez
         yvnHm51osg7u+I+Jq54S6JTi40K5UOOZ5eMCQxEbPycgAkRyL7qo3bMvuuywzkgtJbpm
         l+33zeVQLwTnL5+kGjxZyJPWdtlptq6MuRCcdi3xDaqc3wFdzmdgXXK4L0R3oiHvL5Ry
         pH46qCw46fJHmEeQm+eIs5huUM0Co6hYuvDRo/Ad9ytxzoLeDNKI/h1Dth3bTKuzI2NG
         RwoLw4ZoHWV37MppTrG9h82bjcTuGFeurq3EJIm06UvDzuc/denS/b4VcffEzOhdG6Up
         CebA==
X-Forwarded-Encrypted: i=1; AJvYcCUOdua2at7JkIFm/3Ddwr4XL09e94yNaM8uDm6lus4uIaO/j4NGCzq+aSO+w0AdTBqQ4wuMSiHKtROLVubxoJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YylGk5SWlFTUCWG4A1yUNCBWn0vrEtPI0265BqjSreP63LBJWDr
	cSE30b0BmgP4NChiWMWePW1kAyrvu6SrOmn7EovuYZ+TvKV0rwWPbzfcRHzx9oGg1Neb4BaPTsr
	/gNHB1D3sAQ==
X-Google-Smtp-Source: AGHT+IEwt8NGYhwzS0nUmHsR7Wm0KUS2I53PheVpr9xT2i86QWOhPPHtzrsha444DVNmTlDTkv6MnyHBFveF
X-Received: from pfblm9.prod.google.com ([2002:a05:6a00:3c89:b0:746:3244:f1e6])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:194b:b0:748:3485:b99d
 with SMTP id d2e1a72fcca58-7487c338367mr1420302b3a.18.1749676620423; Wed, 11
 Jun 2025 14:17:00 -0700 (PDT)
Date: Wed, 11 Jun 2025 21:16:30 +0000
In-Reply-To: <cover.1749672978.git.afranji@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1749672978.git.afranji@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <c55644ec81c22e7239d52f97e744eb4bafeccac3.1749672978.git.afranji@google.com>
Subject: [RFC PATCH v2 03/10] KVM: TDX: Add base implementation for tdx_vm_move_enc_context_from
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

This should mostly match the logic in sev_vm_move_enc_context_from.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 arch/x86/kvm/vmx/main.c    | 12 +++++++++++-
 arch/x86/kvm/vmx/tdx.c     | 24 ++++++++++++++++++++++++
 arch/x86/kvm/vmx/x86_ops.h |  1 +
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index d1e02e567b57..125af25fd09a 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -879,6 +879,14 @@ static int vt_gmem_private_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn)
 	return 0;
 }
 
+static int vt_move_enc_context_from(struct kvm *kvm, struct kvm *source_kvm)
+{
+	if (!is_td(kvm))
+		return -ENOTTY;
+
+	return tdx_vm_move_enc_context_from(kvm, source_kvm);
+}
+
 #define vt_op(name) vt_##name
 #define vt_op_tdx_only(name) vt_##name
 #else /* CONFIG_KVM_INTEL_TDX */
@@ -1044,7 +1052,9 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.mem_enc_ioctl = vt_op_tdx_only(mem_enc_ioctl),
 	.vcpu_mem_enc_ioctl = vt_op_tdx_only(vcpu_mem_enc_ioctl),
 
-	.private_max_mapping_level = vt_op_tdx_only(gmem_private_max_mapping_level)
+	.private_max_mapping_level = vt_op_tdx_only(gmem_private_max_mapping_level),
+
+	.vm_move_enc_context_from = vt_move_enc_context_from
 };
 
 struct kvm_x86_init_ops vt_init_ops __initdata = {
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b952bc673271..07583a11d6e3 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -626,6 +626,7 @@ int tdx_vm_init(struct kvm *kvm)
 	kvm->arch.has_protected_state = true;
 	kvm->arch.has_private_mem = true;
 	kvm->arch.disabled_quirks |= KVM_X86_QUIRK_IGNORE_GUEST_PAT;
+	kvm->arch.use_vm_enc_ctxt_op = true;
 
 	/*
 	 * Because guest TD is protected, VMM can't parse the instruction in TD.
@@ -3524,3 +3525,26 @@ int __init tdx_bringup(void)
 	enable_tdx = 0;
 	return 0;
 }
+
+static __always_inline bool tdx_finalized(struct kvm *kvm)
+{
+	struct kvm_tdx *tdx_kvm = to_kvm_tdx(kvm);
+
+	return tdx_kvm->state == TD_STATE_RUNNABLE;
+}
+
+static int tdx_migrate_from(struct kvm *dst, struct kvm *src)
+{
+	return -EINVAL;
+}
+
+int tdx_vm_move_enc_context_from(struct kvm *kvm, struct kvm *src_kvm)
+{
+	if (!is_td(kvm) || !is_td(src_kvm))
+		return -EINVAL;
+
+	if (tdx_finalized(kvm) || !tdx_finalized(src_kvm))
+		return -EINVAL;
+
+	return tdx_migrate_from(kvm, src_kvm);
+}
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index b4596f651232..001f1540a560 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -164,6 +164,7 @@ void tdx_flush_tlb_current(struct kvm_vcpu *vcpu);
 void tdx_flush_tlb_all(struct kvm_vcpu *vcpu);
 void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level);
 int tdx_gmem_private_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn);
+int tdx_vm_move_enc_context_from(struct kvm *kvm, struct kvm *source_kvm);
 #endif
 
 #endif /* __KVM_X86_VMX_X86_OPS_H */
-- 
2.50.0.rc1.591.g9c95f17f64-goog


