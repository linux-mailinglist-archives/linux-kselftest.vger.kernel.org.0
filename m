Return-Path: <linux-kselftest+bounces-39437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AAFB2ECCE
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 06:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40D45E3070
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 04:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9D82E88AA;
	Thu, 21 Aug 2025 04:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QLIeOsSW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684872E2289
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750570; cv=none; b=dXoLZIs0fRmeG+37bMdbPyD82IfZxWGgXQTWtCEoQU8HbEV5DNhLko0iJUtPg+IlQsIhzVoxRPefFy8IScSxfQnTV3Uyup8BOz5KQ6DJSEg1injwJpx/k2lOr2qthzwin36h9eAWqj7qzhocu4zyFeL3izkcJtB8eQibUVCo7/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750570; c=relaxed/simple;
	bh=oza6hx2ntzUZXObmix0KiLo9V3JboBdBQCO1cnzK8hQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rB92kELbJEcDqsLi/7dLnlmXdtbXC38gHZXhlmWDphfyiKp73apqeacI/0cVq1e+TM2evXJ65Wx0mju7Mo97yXx0JCnWq6LUrbzeC0fmwB4AbZH557IwB6dibns8r7T1riJ8rrw0LDIVnSTV5kAXwdvFqohyOnOB5yK3jO+HNAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QLIeOsSW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326de9d22so635182a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 21:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750569; x=1756355369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRFEjTGnGKNT/7J5APntzZoA6CylwPAhIKfI752BiBs=;
        b=QLIeOsSWZeX5BMpWErJKXTfvsKQm7zA+El5U/KF+IgezD1FEBNTaTGjzDeE6JLy1Hj
         5ppasuhhRA00dXxRTpQf2Q2T488pFcFRns3XJIFvR5s9YTMJQlwHTcDwDnXfNmJS0DY9
         bhnvzlAmhLScqFQtQCOAKmoJKkKCPaSwpgSebbNVG1UuJnN02/bx7YjrakmTpeiXOsdc
         l5VN81M4n66agAxcH3Pe5ezspDt4Uies61vt0NZ7/wwcf2Cs+nMhLbxWc7fuOTOk9Pti
         Yxsoyhd+K2pHDpUs3+6XxT/J7AccXjLQRdeb4e2Y7yJRYLE4fSBhVjbiSuT67sxw0Ps+
         G/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750569; x=1756355369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRFEjTGnGKNT/7J5APntzZoA6CylwPAhIKfI752BiBs=;
        b=SBGqYmG9vtbMcMBbiWBnsjqJwy0W3HP0EwxkyWuVTci8Y8wq/qiFp8EQVotKjCecfG
         mt79MyW34h1JbVnWFV5ty0l+cgCdLznwzt5iy4QuWxR+kH9Y6LL7YsoEfPPnmt/OITds
         +Opl3dnX+h255Xbd9lP4VfcxFQvnw6SSP+9BcbQtkXoCQTf4rxaiX3vxd1WBjzNM3S4M
         97I2VKRUjqyDomZ0xvbHATmIiiXlCrkM5DujegzyISWpv7USAjeCXLmUtAXFXwf6qwiR
         3Hc78nHRsd8mrO3hUM9+EWAhn8BIt2vlS6pUyHYyH7VpNQ+E+sqnvJdrcwj0ZjV7oVJg
         o8MA==
X-Gm-Message-State: AOJu0Yxjtww80yLmWNuu5W5qvz24CVr6/fmRM4FrfEBC0UU1dhoNa/+Q
	1KwU1IedP3OBYLDp8JVZQKOtAGoloQJBXLBPXno40ThgyzTYwGI+I+0uj5GmBs2ZEpBI4El/hKY
	GCfEopOrgWSeMmAoJEqZ1o3ecjr9r27URFnm/QpD2QWSOLpemtfh8qVplV7vq9cDH/l3LUjHdIi
	DIngbh2csZzDDxwRGroJBYvNaWpGYdQaHa+647AmkruNQ=
X-Google-Smtp-Source: AGHT+IGgXv0HXZJEaeYeMRs0Tu4Cdx9jcHbVap6aLHFdU7b6D7sdqdWyIH1R2tQe7TkoFGhR8InX65S0gA==
X-Received: from pjbsl4.prod.google.com ([2002:a17:90b:2e04:b0:312:ea08:fa64])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c90:b0:30a:3e8e:ea30
 with SMTP id 98e67ed59e1d1-324eedf50bfmr1190919a91.11.1755750568559; Wed, 20
 Aug 2025 21:29:28 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:28:56 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-4-sagis@google.com>
Subject: [PATCH v9 03/19] KVM: selftests: Expose functions to get default
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

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/processor.h     |  6 +++
 .../testing/selftests/kvm/lib/x86/processor.c | 41 +++++++++++++++----
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 2efb05c2f2fb..5c16507f9b2d 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1026,6 +1026,12 @@ static inline struct kvm_cpuid2 *allocate_kvm_cpuid2(int nr_entries)
 
 void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid);
 
+uint16_t kvm_get_default_idt_limit(void);
+uint16_t kvm_get_default_gdt_limit(void);
+uint64_t kvm_get_default_cr0(void);
+uint64_t kvm_get_default_cr4(void);
+uint64_t kvm_get_default_efer(void);
+
 static inline void vcpu_get_cpuid(struct kvm_vcpu *vcpu)
 {
 	vcpu_ioctl(vcpu, KVM_GET_CPUID2, vcpu->cpuid);
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index d4c19ac885a9..b2a4b11ac8c0 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -488,6 +488,35 @@ static void kvm_seg_set_tss_64bit(vm_vaddr_t base, struct kvm_segment *segp)
 	segp->present = 1;
 }
 
+uint16_t kvm_get_default_idt_limit(void)
+{
+	return NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
+}
+
+uint16_t kvm_get_default_gdt_limit(void)
+{
+	return getpagesize() - 1;
+}
+
+uint64_t kvm_get_default_cr0(void)
+{
+	return X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
+}
+
+uint64_t kvm_get_default_cr4(void)
+{
+	uint64_t cr4 = X86_CR4_PAE | X86_CR4_OSFXSR;
+
+	if (kvm_cpu_has(X86_FEATURE_XSAVE))
+		cr4 |= X86_CR4_OSXSAVE;
+	return cr4;
+}
+
+uint64_t kvm_get_default_efer(void)
+{
+	return EFER_LME | EFER_LMA | EFER_NX;
+}
+
 static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 {
 	struct kvm_sregs sregs;
@@ -498,15 +527,13 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
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
2.51.0.rc1.193.gad69d77794-goog


