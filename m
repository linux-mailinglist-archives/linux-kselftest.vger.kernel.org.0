Return-Path: <linux-kselftest+bounces-39449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F8FB2ED0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 06:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A11EA7BFB75
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 04:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EF32EB5C0;
	Thu, 21 Aug 2025 04:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hu2dQQHB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870F82EAB79
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 04:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750589; cv=none; b=Y4Gv/m1CyDzAXIfw7E5pUb8HedTZuezp/uj5XvYHAdCBd8nUewfDquxgw9kbXoLu7qJnQAYqs25ZGrOlKmI7Zp8sCf7vZAxuUgnOWzZENG/5nBOTd5cADmiPm7LZdZQCE1Ge0P2x0uGI+wr1teS8rMbFaNfVdl/r6isO9SZRDkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750589; c=relaxed/simple;
	bh=yodyfNMQNj0kY+Qn43ES1XKohbDNg1JVE9Wu+qtAF5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FVUaMU7s1y5zGBiOyPL9BGrr72WQg/G9+EG9MVKVgMeysPjsXxUXbEuxW+abukKhX/r9eRonwP6JmWfFwZA8DBMFE1AFefmcELAhZq22OlRC6FlIEcKh8fbqodWJshhbZRuCISRVrCpeBlKwr1TA1nGx3DeB5/HZ20pi1lB6e6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hu2dQQHB; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2e591846so598903b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 21:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750587; x=1756355387; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gj0ks3SkrjBXeSwymW22ZOEkAWDcXT2SUAzCPyMJDk0=;
        b=hu2dQQHBxX509O5IFospb/+67IEPLhO+D9rUZJbBXjc2ViV3v59Jq8hd4s4xIGH29W
         Ur+57E4Hy7VhWo+RUmPRiLiukFNJMYh+2vtSEZa28Xlnh/SPKdoR6PCqVtCIXskjp2vS
         8DJyjFcVyznP2N0hNNRQAP90bupg8wWIzub7sp3hezf70oLy3XyRYLNxAyZA0duc0liC
         ygftDMuWTzTgLgmNVY6rgLhGI6a0IS0PBjlFLemts14sJQ1muBXn1MKume2Zst06fiwy
         0Xghpwbc2a7lc1Rvc6B6BF07KTBSW+UDBUSY6cQVq/9h9KpbncbxbZWQ5uCcLddY1WiO
         SirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750587; x=1756355387;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gj0ks3SkrjBXeSwymW22ZOEkAWDcXT2SUAzCPyMJDk0=;
        b=ukyAvN/umy+GpmoGXM8uOEy3TcupYYQongZqYAbDjlJ4lieO8OceWHoacd6gAbf7Sy
         Z9hAE5HA3vaU/gSzQSFi6hrAUEMQC7j4GrcDquvUnwJxuy/7exIw0UmeTgHYjwBwKnuJ
         HhTwLRYcp3ONSqWQS9U1YSQcpjx+04uK+rdwmXC5Kc/8/9TDcV16rKw+1uQD4QgKsY+H
         gKRKxp8TwsistaAIcJ+/W5Ctb/5MfhCIVB25e1RaaGVCozXqOFwKBcjEnIoF8//mmELK
         wzRwcl0YO/Ifbk1ABf01Ox+jcOfY9vBWjDukejn3q+wvwYnO/YjGAk6CKlwrNfSNF3SW
         Q1wA==
X-Gm-Message-State: AOJu0YyDI3dm+k6x7cJsoBGs6qYjco5epsVOMcU3SiWdKKwFobqiGy07
	OcjmoIwiGHhCZ5+xibgibYZXGqeTC/ObI1MROgjrDjgwsUosWGtHIr/orxEduPpVV5RXaAbmdJY
	wnDp9srcM77PB/on3Pdzd0ZxY1M3wGbSr6Vwu2yW+FB/3kYAjUoD14zgl207YBU7JSyw28BhA7y
	MxqvjuvnEBHpHFvZFyQnBbDgVDWrvFPaTvgbnmLYYyjgI=
X-Google-Smtp-Source: AGHT+IFLKU7nQShOfjFNm85Vb/F4qNeM/zFFNY9j+AyoBkTSscow67QaxUSRWnDKVpnn460c5wYSFgcfHA==
X-Received: from pfbkh4.prod.google.com ([2002:a05:6a00:9444:b0:76e:8bc4:bb9a])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3392:b0:746:195b:bf1c
 with SMTP id d2e1a72fcca58-76ea30ca590mr1175415b3a.10.1755750586674; Wed, 20
 Aug 2025 21:29:46 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:29:08 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-16-sagis@google.com>
Subject: [PATCH v9 15/19] KVM: selftests: Hook TDX support to vm and vcpu creation
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

TDX require special handling for VM and VCPU initialization for various
reasons:
- Special ioctlss for creating VM and VCPU.
- TDX registers are inaccessible to KVM.
- TDX require special boot code trampoline for loading parameters.
- TDX only supports KVM_CAP_SPLIT_IRQCHIP.

Hook this special handling into __vm_create() and vm_arch_vcpu_add()
using the utility functions added in previous patches.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c    | 24 ++++++++-
 .../testing/selftests/kvm/lib/x86/processor.c | 49 ++++++++++++++-----
 2 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index b4c8702ba4bd..d9f0ff97770d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2018, Google LLC.
  */
+#include "tdx/tdx_util.h"
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
@@ -465,7 +466,7 @@ void kvm_set_files_rlimit(uint32_t nr_vcpus)
 static bool is_guest_memfd_required(struct vm_shape shape)
 {
 #ifdef __x86_64__
-	return shape.type == KVM_X86_SNP_VM;
+	return (shape.type == KVM_X86_SNP_VM || shape.type == KVM_X86_TDX_VM);
 #else
 	return false;
 #endif
@@ -499,6 +500,12 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 	for (i = 0; i < NR_MEM_REGIONS; i++)
 		vm->memslots[i] = 0;
 
+	if (is_tdx_vm(vm)) {
+		/* Setup additional mem regions for TDX. */
+		vm_tdx_setup_boot_code_region(vm);
+		vm_tdx_setup_boot_parameters_region(vm, nr_runnable_vcpus);
+	}
+
 	kvm_vm_elf_load(vm, program_invocation_name);
 
 	/*
@@ -1728,11 +1735,26 @@ void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa)
 	return (void *) ((uintptr_t) region->host_alias + offset);
 }
 
+static bool is_split_irqchip_required(struct kvm_vm *vm)
+{
+#ifdef __x86_64__
+	return is_tdx_vm(vm);
+#else
+	return false;
+#endif
+}
+
 /* Create an interrupt controller chip for the specified VM. */
 void vm_create_irqchip(struct kvm_vm *vm)
 {
 	int r;
 
+	if (is_split_irqchip_required(vm)) {
+		vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
+		vm->has_irqchip = true;
+		return;
+	}
+
 	/*
 	 * Allocate a fully in-kernel IRQ chip by default, but fall back to a
 	 * split model (x86 only) if that fails (KVM x86 allows compiling out
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 4802fc81bea7..5cf14f09c1b6 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -670,6 +670,11 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
 		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
 	}
 
+	if (is_tdx_vm(vm)) {
+		vm_tdx_init_vm(vm, 0);
+		vm_tdx_load_common_boot_parameters(vm);
+	}
+
 	r = __vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL);
 	TEST_ASSERT(r > 0, "KVM_GET_TSC_KHZ did not provide a valid TSC frequency.");
 	guest_tsc_khz = r;
@@ -680,9 +685,13 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
 {
 	struct kvm_regs regs;
 
-	vcpu_regs_get(vcpu, &regs);
-	regs.rip = (unsigned long) guest_code;
-	vcpu_regs_set(vcpu, &regs);
+	if (is_tdx_vm(vcpu->vm))
+		vm_tdx_set_vcpu_entry_point(vcpu, guest_code);
+	else {
+		vcpu_regs_get(vcpu, &regs);
+		regs.rip = (unsigned long) guest_code;
+		vcpu_regs_set(vcpu, &regs);
+	}
 }
 
 vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
@@ -711,6 +720,19 @@ vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
 	return stack_vaddr;
 }
 
+static void vm_tdx_vcpu_add(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpuid2 *cpuid;
+
+	cpuid = allocate_kvm_cpuid2(MAX_NR_CPUID_ENTRIES);
+	vm_tdx_vcpu_ioctl(vcpu, KVM_TDX_GET_CPUID, 0, cpuid);
+	vcpu_init_cpuid(vcpu, cpuid);
+	free(cpuid);
+	vm_tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_VCPU, 0, NULL);
+
+	vm_tdx_load_vcpu_boot_parameters(vm, vcpu);
+}
+
 struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 {
 	struct kvm_mp_state mp_state;
@@ -718,16 +740,21 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 	struct kvm_vcpu *vcpu;
 
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
-	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
-	vcpu_init_sregs(vm, vcpu);
-	vcpu_init_xcrs(vm, vcpu);
 
-	/* Setup guest general purpose registers */
-	vcpu_regs_get(vcpu, &regs);
-	regs.rflags = regs.rflags | 0x2;
-	if (vm->type != KVM_X86_TDX_VM)
+	if (is_tdx_vm(vm)) {
+		vm_tdx_vcpu_add(vm, vcpu);
+	} else {
+		vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
+
+		vcpu_init_sregs(vm, vcpu);
+		vcpu_init_xcrs(vm, vcpu);
+
+		/* Setup guest general purpose registers */
+		vcpu_regs_get(vcpu, &regs);
+		regs.rflags = regs.rflags | 0x2;
 		regs.rsp = kvm_allocate_vcpu_stack(vm);
-	vcpu_regs_set(vcpu, &regs);
+		vcpu_regs_set(vcpu, &regs);
+	}
 
 	/* Setup the MP state */
 	mp_state.mp_state = 0;
-- 
2.51.0.rc1.193.gad69d77794-goog


