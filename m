Return-Path: <linux-kselftest+bounces-37301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160BBB04B3E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 01:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFBB3B1F53
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 23:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C988289E12;
	Mon, 14 Jul 2025 22:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eGLY0u6C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7CF279DAC
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533982; cv=none; b=UApzvrqYHihWS3wpX3drRDEmq770ziu4PI+l6uxLDBBEvsOi1YLZiIn9EdCF08rA6p72DBIU888cmyIWh6EHQQjyFooBLEQ8fntiGJ9RRXGgp17FQqE2HngJeoDwnDw1hZh6BNUVriLxO08bqqI1pU4yN4dKQkJCQsLr4JEsSWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533982; c=relaxed/simple;
	bh=JP8zf6L3hflAD9DfHgHhFb+z9U9XgJ/aXorJou5xHMY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sdd8NGtGxh9MqiA/YLdkKzIjgLDip9g6DT7DbZspcRFLM3Ac6qt+tti4PJeW6ajnuo6yP0cr94Hb6wUaJJNMm13wJYOPsRnU2Lm0dgpuDFmTZaS/G4fbd5fIQ1ng9Qbzljc7DVKrbtThXPVxntUU9wvVc81WCopEjP0ORHb2SJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eGLY0u6C; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-86cfff5669bso475196339f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 15:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752533978; x=1753138778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJZ+xwDjyMIGIgaKCFQ3UPZ4fJ+Lh0B/3NWWuRP6Bzw=;
        b=eGLY0u6CFnxwv/RPEJcT+LpqFXCvh1BMcsuGBXwJc+sx3IoVmJSNKdlswWg+CMn7gz
         foZzuOhgTK/j1659Voo2EeHBWdoeDXjK0CzkESDDu+7lq5yFN9/v/zzDtjFcfxWNMY6D
         JVkb3QUNO28luHCECOU4mewKSIY4lBwCaktDVP41Rhu4B5MBxfH2pbAYDYn0FjuyjcQQ
         HgWbWHjnQbd+h3SmRud/Qhp/5vyjFiL38iFo78Bwqgl934g5wZBZFyt1xAl+4ZElCkgg
         +lPtDZ+Fsl46VsST//NQaAb/Mx2cl4aL9aHRJZizvC0sI+dGzVGMH+izp6JtWz3Ym/Zi
         Nrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752533978; x=1753138778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJZ+xwDjyMIGIgaKCFQ3UPZ4fJ+Lh0B/3NWWuRP6Bzw=;
        b=MQny625pmY6LI6LR4pNY+PjYWCcw4oe73BXRqyaaVy/O0nYlGLT2Enp160B1yjwA4D
         +8WaMk4fPEG/iOP5sZxVIiHFDdJEIhOVUFUOZI0rPEq366IH/TmaUKp9Bq8Yy2JEV9Jw
         2Xr7W8oYbpEI8xLbBWf84o+oCXL45BFWQDnwZiIGVi8IAxZQ1i6kKrs19XLSBRNVDkMK
         +kzJXElQ4f1RmsF1lf2oNmCCvbhbeIrbj7WXflE0KWHQV38v9vYdLeNSkxzCloHLtnA0
         8riJm13LY8qe2ZUAAx867LIoEeF1RLcY2ULVzupmQC2NcbpqZp7MFpa3BspCe1StPx5j
         0R/w==
X-Forwarded-Encrypted: i=1; AJvYcCXkdLDeEGLwDFOXPFotOyFC4g+i7/Xys4p/p/en1CGO+x8FODgv5wPEZ9B+NKm3WkJN0IcBqJ11HqFuNnmNp+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI7IrI08O8ouZJl0F1zE9ECVisyCG22xPAQtgOsaLv/hiIupLY
	vOJqK0DaJOU+ex6GOMIVBSgL9Z+1tDaW2TQxuu55gRpleAgs0wI5MuaNQy76nKpNz6ZU4O4FKlY
	iG8ZaRJSMLI2MXzgmgXKRvTEYbA==
X-Google-Smtp-Source: AGHT+IGcsfYXq37Q6WkECHaXfuTpZ4xUC2MHD5EzXhz1ZNa8q/Bm5uigtDkeVAlpUUfariaZ73ybTmOi3F0pZZ07NA==
X-Received: from ioxw3.prod.google.com ([2002:a05:6602:5c3:b0:86c:9981:d21d])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6602:3411:b0:876:b17c:dec3 with SMTP id ca18e2360f4ac-879af05ab13mr188823039f.8.1752533978200;
 Mon, 14 Jul 2025 15:59:38 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:59:02 +0000
In-Reply-To: <20250714225917.1396543-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714225917.1396543-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714225917.1396543-9-coltonlewis@google.com>
Subject: [PATCH v4 08/23] KVM: arm64: Introduce non-UNDEF FGT control
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Mark Brown <broonie@kernel.org>

We have support for determining a set of fine grained traps to enable for
the guest which is tied to the support for injecting UNDEFs for undefined
features. This means that we can't use the mechanism for system registers
which should be present but need emulation, such as SMPRI_EL1 which should
be accessible when SME is present but if SME priority support is absent
SMPRI_EL1.Priority should be RAZ.

Add an additional set of fine grained traps fgt, mirroring the existing fgu
array. We use the same format where we always set the bit for the trap in
the array as for FGU. This makes it clear what is being explicitly managed
and keeps the code consistent.

We do not convert the handling of ARM_WORKAROUND_AMPERE_ACO3_CPU_38 to this
mechanism since this only enables a write trap and when implementing the
existing UNDEF that we would share the read and write trap enablement (this
being the overwhelmingly common case).

Signed-off-by: Mark Brown <broonie@kernel.org>
[Removed unused vcpu argument from macro]
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/kvm_host.h       | 6 ++++++
 arch/arm64/kvm/hyp/include/hyp/switch.h | 7 ++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 92d672429233..f705eb4538c3 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -301,6 +301,12 @@ struct kvm_arch {
 	 */
 	u64 fgu[__NR_FGT_GROUP_IDS__];
 
+	/*
+	 * Additional FGTs to enable for the guests, eg. for emulated
+	 * registers,
+	 */
+	u64 fgt[__NR_FGT_GROUP_IDS__];
+
 	/*
 	 * Stage 2 paging state for VMs with nested S2 using a virtual
 	 * VMID.
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 7599844908c0..7fe5b087c95a 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -153,9 +153,9 @@ static inline void __activate_traps_fpsimd32(struct kvm_vcpu *vcpu)
 		id;							\
 	})
 
-#define compute_undef_clr_set(vcpu, kvm, reg, clr, set)			\
+#define compute_trap_clr_set(kvm, trap, reg, clr, set)			\
 	do {								\
-		u64 hfg = kvm->arch.fgu[reg_to_fgt_group_id(reg)];	\
+		u64 hfg = kvm->arch.trap[reg_to_fgt_group_id(reg)];	\
 		struct fgt_masks *m = reg_to_fgt_masks(reg);		\
 		set |= hfg & m->mask;					\
 		clr |= hfg & m->nmask;					\
@@ -171,7 +171,8 @@ static inline void __activate_traps_fpsimd32(struct kvm_vcpu *vcpu)
 		if (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu))		\
 			compute_clr_set(vcpu, reg, c, s);		\
 									\
-		compute_undef_clr_set(vcpu, kvm, reg, c, s);		\
+		compute_trap_clr_set(kvm, fgu, reg, c, s);		\
+		compute_trap_clr_set(kvm, fgt, reg, c, s);		\
 									\
 		val = m->nmask;						\
 		val |= s;						\
-- 
2.50.0.727.gbf7dc18ff4-goog


