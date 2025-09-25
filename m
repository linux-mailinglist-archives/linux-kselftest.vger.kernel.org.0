Return-Path: <linux-kselftest+bounces-42369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFC6BA0D8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48521BC407C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBA1312821;
	Thu, 25 Sep 2025 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GAPbxzYJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F7311945
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821346; cv=none; b=G7QAj7YQMdiuRge5yi514/13xI10prB38XgQ2WVzzTrN+gIXbL+/POsWbzlQCk45QjUtHvBEnsBM4kl8o2s2CRax+L4Ar399T47+vSf32vETuFTRUysFXC71LaZwoFZ6DKU9bnJYHb3HRDvNgW1bqFV0UssgY2+vTdB+cGMLDUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821346; c=relaxed/simple;
	bh=ajazmAXcgCXOhCMgF6c8IA9hIPNsZ0Ny8LW/+nRUD1w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=arSahJ67EQdH43zo2H9+Kg7w/DBHuia9FJLjLsQ+0UGTYOhDdaeatpiT519aWtPDpzoAtsaiMGKJ+vw3mJmfILgCs8jb7XVWagQd9h0cs6Y/485FDlPE1ZDwjqhVvDnTBuE8jkVh2imR6ur4Ht3+vrfAx5Nd5h/CbRXjuZIWG0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GAPbxzYJ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-780d26fb6b4so1199496b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821344; x=1759426144; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+8ifmburBeSC8WUGUcPT3YChUFYu/ybrkpYDbnSiwtw=;
        b=GAPbxzYJmmjsn5ytIy0TwP0HLmMLkLPdwp9zUmZO9p5UiHBCsRAgpTyGVWtAB7/BeM
         Sbg9agTN4ArccRopGujM+0uNEdzFnTiUirCmR/Vyz+iNeH4LTRZs88knBWZoK0F8//Ce
         uNpa7NZZvMLy8wDkqMzOAOYhBrFELcPpn6G+PDGG2JLZslU4SxtHeoQ8w/WjX8+6lDy7
         FAqH6oDsAPE3ow/VlVN78tkO7f4FOh5cAbmyVaZ7xNXogXlf+f4VJjWCUhW/xF7BxiQ/
         6Pt6e2w0UvTwk/ZmvgK3V0Yv5Wl+Z0eUtI08kJjBHbbkr6USOUGm0y9eyN3YKDM/zrk3
         lGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821344; x=1759426144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8ifmburBeSC8WUGUcPT3YChUFYu/ybrkpYDbnSiwtw=;
        b=ZPHAntlw2hCXFGXuOyE8To6gCkDL/xLAWnixpya3jOYmoccHvtm6+uZU7SilbQZurt
         sLrKnChAqFVzTui53uwBjHEVjkU1f6yrW/iK45W4OMhflxiVGkqOmSobXJjR1ROm8VWp
         EapQfazJVZSstONHJ2vsSwy6VUtRCjDLN3DJtwz+hPN/QicziHxeKFKttxqwrbapIV3/
         ryPWAzrDhkeEOUCUoKGw9g4Jf+i6R/WGn/XvPb4sEqZAHamtq42udBOAy0UvH39kJAn8
         /axk1TR6sOy0Bx9DQ/Cj7WIVBFU/jWm++5Ru4VaeBXG2o89kZVCLGRyyseSs4NbX5xPS
         +1sA==
X-Gm-Message-State: AOJu0YwHIBNNJyc5yStx9hrH2YISp9U/NnNNudT/dlGmIus/x57At3od
	83/1Jb4lIUhSRva7wTCW7+OhD49v4KiU88IGb6NjVg2k5iRnMbYAcu8YaGxH9D2ku1GY1BnDDrm
	7IfuPPt/feJ6urio8snoV6/HEt65FvmtAbiDvAxFRV5clw5DVcPLoUoVrI8iskZt2Qj/67EyEFR
	1n4kH9poPlfAPYoecV1hll3d3EjMwa9elSxAtdeSXpgAY=
X-Google-Smtp-Source: AGHT+IGrkyBRHghioEEsNPLgX1a/QnnxGkOYM+tTJb1o+oHPLCPFpT249t2kyMMvcKAJwNIDKc0vdnUxMA==
X-Received: from pfbhr17-n1.prod.google.com ([2002:a05:6a00:6b91:10b0:76b:3822:35ea])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3902:b0:772:86aa:ed0a
 with SMTP id d2e1a72fcca58-780fced989emr5023794b3a.25.1758821343828; Thu, 25
 Sep 2025 10:29:03 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:28:30 -0700
In-Reply-To: <20250925172851.606193-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172851.606193-3-sagis@google.com>
Subject: [PATCH v11 02/21] KVM: selftests: Expose functions to get default
 sregs values
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

TDX can't set sregs values directly using KVM_SET_SREGS. Expose the
default values of certain sregs used by TDX VMs so they can be set
manually.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/processor.h     | 33 +++++++++++++++++++
 .../testing/selftests/kvm/lib/x86/processor.c | 12 +++----
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 2efb05c2f2fb..f610c09cadf4 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -27,6 +27,10 @@ extern uint64_t guest_tsc_khz;
 #define MAX_NR_CPUID_ENTRIES 100
 #endif
 
+#ifndef NUM_INTERRUPTS
+#define NUM_INTERRUPTS 256
+#endif
+
 #define NONCANONICAL 0xaaaaaaaaaaaaaaaaull
 
 /* Forced emulation prefix, used to invoke the emulator unconditionally. */
@@ -1456,4 +1460,33 @@ void virt_map_level(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 
 bool sys_clocksource_is_based_on_tsc(void);
 
+static inline uint16_t kvm_get_default_idt_limit(void)
+{
+	return NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
+}
+
+static inline uint16_t kvm_get_default_gdt_limit(void)
+{
+	return getpagesize() - 1;
+}
+
+static inline uint64_t kvm_get_default_cr0(void)
+{
+	return X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
+}
+
+static inline uint64_t kvm_get_default_cr4(void)
+{
+	uint64_t cr4 = X86_CR4_PAE | X86_CR4_OSFXSR;
+
+	if (kvm_cpu_has(X86_FEATURE_XSAVE))
+		cr4 |= X86_CR4_OSXSAVE;
+	return cr4;
+}
+
+static inline uint64_t kvm_get_default_efer(void)
+{
+	return EFER_LME | EFER_LMA | EFER_NX;
+}
+
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index d4c19ac885a9..83efcf48faad 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -498,15 +498,13 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 	vcpu_sregs_get(vcpu, &sregs);
 
 	sregs.idt.base = vm->arch.idt;
-	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
+	sregs.idt.limit = kvm_get_default_idt_limit();
 	sregs.gdt.base = vm->arch.gdt;
-	sregs.gdt.limit = getpagesize() - 1;
+	sregs.gdt.limit = kvm_get_default_gdt_limit();
 
-	sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
-	sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
-	if (kvm_cpu_has(X86_FEATURE_XSAVE))
-		sregs.cr4 |= X86_CR4_OSXSAVE;
-	sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
+	sregs.cr0 = kvm_get_default_cr0();
+	sregs.cr4 |= kvm_get_default_cr4();
+	sregs.efer |= kvm_get_default_efer();
 
 	kvm_seg_set_unusable(&sregs.ldt);
 	kvm_seg_set_kernel_code_64bit(&sregs.cs);
-- 
2.51.0.536.g15c5d4f767-goog


