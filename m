Return-Path: <linux-kselftest+bounces-34768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 729CBAD610C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 23:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291F5167A46
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 21:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B602580DE;
	Wed, 11 Jun 2025 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QzLizjIE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420D4254B03
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676633; cv=none; b=IDHBT2Rzv+yvhC5yzIjuOQnZQiRQTYfQ5U8OgNRXy66ISif5kwm0IHpDy2hpo/Zfc2XErn728Cms3T+yi3fHczChefS8KtAl7J/ygLUnwNZa/vma1FOLA9hAQBhngNuM4LLPd0ZCQtyvrCeHO2S+cW0Vkb6sTcKTTtWOquCLeC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676633; c=relaxed/simple;
	bh=3IrONkjSfZHSUwPR/efaP61FbpeztFmotATV6TKU0Sg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rMHmunHG+A/4HqQXqCDS8YBA24RgTB+5zL6HtzSJ1PZArNlkQIg3QTdrVMpXAeLQnWbHCvyl91Y0/2KFoAqwr2UNusLdK/a0XKAgAwMqm2ETkOfDt9C3KC1Vhoej0/WmcW9EZ4ZC65fmWfU3x0nrTmmYkceBUlRbx4l27VEQY8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QzLizjIE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23228c09e14so3252445ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 14:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749676630; x=1750281430; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QL/RdKZkxRdzT4JBOycXHxG8/DXNnGB2DrLug1v+dg0=;
        b=QzLizjIEbHmnTqzPmI8H+M0jARKhiC6q/+DC5kaqSa4sWrmltBP+ZVmiuNI5lP8eP9
         OzN12uy98sTPn6niPtKYwVLoCqQe9IPRQxA3dzAW1wrvUamEZ3F/oGwpOmDmgcogbsfE
         tgJSqGtcv6oNRastGWCCP62jGtaa5ESEwA9SFcUCWeB//GHJcmuB9sUDZ2+/gp4OcOqY
         MxVBciLxCAHlTAV07QK0IekheckSEgaopBkMx8pxTw+AaWkinBf6RF//rNjTP7BnJYMK
         shIcNvHiuGjQwkC3mNjpF0RZDocgtJYYAmbxTn7xmLtuoBt4ViUfYCa/HKpd3LtZJnnr
         f8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749676630; x=1750281430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QL/RdKZkxRdzT4JBOycXHxG8/DXNnGB2DrLug1v+dg0=;
        b=o9KtFXjK8GEYeVeGMnqd6Fg6gpz4GweoONglYyg5P/etcMD5TIpX+te6qRxct42+Vj
         6a/+LOUuSKlzXdXLgouHXZ9p0tKS1TL7b8OnoSlESlU3FsvP7hHdnFnKwgmUVG4iR9aD
         UZ53leFOAIhr/pHofckZpN+hILfyGx03DI+9NkBuvQpAhsc5IHuC5RsIG72kWTnL9V/r
         pNXg/EByz5+BUcnilqB1km5cE7clDvmLiicMUErCwL/t9ZtcUqDyMk0+OKoeZTwWi7Nl
         w6wyrkw7TiQ8pDzC8sM5k4Xm4H1UIMz3+ygzwDe/GgXs/kedpnAJ2P2Xz56iNVMc/BbY
         6Vrg==
X-Forwarded-Encrypted: i=1; AJvYcCXQqw+vqOLToB5TiJGZoOAtETitTZ+VODTFJuo5YDDieSMPFppVPqGJbqqOoWTHG2Eg6SgUvkMYbAxqaPWWubQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU7YCW5uOrKiLpJYfEWew0wQ1/p6YjhitI0mGj+YPDWNJXPQRB
	y8AlcMjWSP8uiTaaY4bJ+p50j/R3/dk2okx5tYt/wSzlT3vXsqYdhoVCOBQx/P3V5PpuAPx0SL1
	lS3AE2IeZUA==
X-Google-Smtp-Source: AGHT+IH14aTAy2iw/U4wnQQFAPnkTzil6bCM78S3xEy8UEiHKZBuOafN0hQzXY+znZ0hE18aaQ9zR5PzBo4m
X-Received: from plog2.prod.google.com ([2002:a17:902:8682:b0:235:85e:1fac])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f60e:b0:236:363e:55d
 with SMTP id d9443c01a7336-23641b19883mr73107675ad.28.1749676630519; Wed, 11
 Jun 2025 14:17:10 -0700 (PDT)
Date: Wed, 11 Jun 2025 21:16:36 +0000
In-Reply-To: <cover.1749672978.git.afranji@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1749672978.git.afranji@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <09d68c4748c0804f86aa6d943cf416742ef0f741.1749672978.git.afranji@google.com>
Subject: [RFC PATCH v2 09/10] KVM: selftests: Add TDX support for ucalls
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

From: Ackerley Tng <ackerleytng@google.com>

ucalls for non-Coco VMs work by having the guest write to the rdi
register, then perform an io instruction to exit to the host. The host
then reads rdi using kvm_get_regs().

CPU registers can't be read using kvm_get_regs() for TDX, so TDX
guests use MMIO to pass the struct ucall's hva to the host. MMIO was
chosen because it is one of the simplest (hence unlikely to fail)
mechanisms that support passing 8 bytes from guest to host.

A new kvm_mem_region_type, MEM_REGION_UCALL, is added so TDX VMs can
set up a different memslot for the ucall_pool that is set up as shared
memory.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |   1 +
 .../testing/selftests/kvm/include/x86/ucall.h |   4 +-
 .../testing/selftests/kvm/lib/ucall_common.c  |   2 +-
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      |  40 +++++++
 tools/testing/selftests/kvm/lib/x86/ucall.c   | 108 ++++++++++++------
 5 files changed, 118 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 1b6489081e74..8b252a668c78 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -80,6 +80,7 @@ enum kvm_mem_region_type {
 	MEM_REGION_PT,
 	MEM_REGION_TEST_DATA,
 	MEM_REGION_TDX_BOOT_PARAMS,
+	MEM_REGION_UCALL,
 	NR_MEM_REGIONS,
 };
 
diff --git a/tools/testing/selftests/kvm/include/x86/ucall.h b/tools/testing/selftests/kvm/include/x86/ucall.h
index d3825dcc3cd9..0494a4a21557 100644
--- a/tools/testing/selftests/kvm/include/x86/ucall.h
+++ b/tools/testing/selftests/kvm/include/x86/ucall.h
@@ -6,8 +6,6 @@
 
 #define UCALL_EXIT_REASON       KVM_EXIT_IO
 
-static inline void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
-{
-}
+void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa);
 
 #endif
diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
index 42151e571953..5f195d4d15dc 100644
--- a/tools/testing/selftests/kvm/lib/ucall_common.c
+++ b/tools/testing/selftests/kvm/lib/ucall_common.c
@@ -33,7 +33,7 @@ void ucall_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
 	int i;
 
 	vaddr = vm_vaddr_alloc_shared(vm, sizeof(*hdr), KVM_UTIL_MIN_VADDR,
-				      MEM_REGION_DATA);
+				      MEM_REGION_UCALL);
 	hdr = (struct ucall_header *)addr_gva2hva(vm, vaddr);
 	memset(hdr, 0, sizeof(*hdr));
 
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index ef03d42f58d0..a3612bf187a0 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -11,6 +11,7 @@
 #include "tdx/td_boot.h"
 #include "tdx/tdx.h"
 #include "test_util.h"
+#include "ucall_common.h"
 
 uint64_t tdx_s_bit;
 
@@ -568,6 +569,43 @@ static void td_setup_boot_parameters(struct kvm_vm *vm, enum vm_mem_backing_src_
 	TEST_ASSERT_EQ(addr, TD_BOOT_PARAMETERS_GPA);
 }
 
+/*
+ * GPA where ucall headers/pool will be set up
+ *
+ * TD_UCALL_POOL_GPA is arbitrarily chosen to
+ *
+ * + Be within the 4GB address space
+ * + Not clash with the other memslots for boot parameters, boot code and test
+ *   code
+ */
+#define TD_UCALL_POOL_GPA 0x30000000
+/*
+ * GPA to use for ucall MMIO writes
+ *
+ * TD_UCALL_MMIO_GPA is arbitrarily chosen to
+ *
+ * + Be within the 4GB address space
+ * + Not clash with the other memslots for boot parameters, boot code and test
+ *   code
+ * + Not be configured in any memslot (unconfigured GPAs are treated as
+ *   MMIOs). For now, TDX VMs can't be used with KVM_MEM_READONLY so using
+ *   readonly memslots won't work for TDX VMs.
+ */
+#define TD_UCALL_MMIO_GPA 0x40000000
+#define TD_UCALL_MEMSLOT  4
+
+static void td_setup_ucall(struct kvm_vm *vm)
+{
+	int npages;
+
+	npages = ucall_nr_pages_required(PAGE_SIZE);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, TD_UCALL_POOL_GPA,
+				    TD_UCALL_MEMSLOT, npages, 0);
+	vm->memslots[MEM_REGION_UCALL] = TD_UCALL_MEMSLOT;
+
+	ucall_init(vm, TD_UCALL_MMIO_GPA);
+}
+
 void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		   uint64_t attributes)
 {
@@ -593,6 +631,8 @@ void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 
 	td_setup_boot_code(vm, src_type);
 	td_setup_boot_parameters(vm, src_type);
+
+	td_setup_ucall(vm);
 }
 
 void td_finalize(struct kvm_vm *vm)
diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/selftests/kvm/lib/x86/ucall.c
index 1265cecc7dd1..5cf915dbb588 100644
--- a/tools/testing/selftests/kvm/lib/x86/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
@@ -5,52 +5,94 @@
  * Copyright (C) 2018, Red Hat, Inc.
  */
 #include "kvm_util.h"
+#include "kvm_util_types.h"
+#include "tdx/tdx.h"
 
 #define UCALL_PIO_PORT ((uint16_t)0x1000)
 
+static uint8_t vm_type;
+static vm_paddr_t host_ucall_mmio_gpa;
+static vm_paddr_t ucall_mmio_gpa;
+
+void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
+{
+	vm_type = vm->type;
+	sync_global_to_guest(vm, vm_type);
+
+	host_ucall_mmio_gpa = ucall_mmio_gpa = mmio_gpa;
+
+#ifdef __x86_64__
+	if (vm_type == KVM_X86_TDX_VM)
+		ucall_mmio_gpa |= vm->arch.s_bit;
+#endif
+
+	sync_global_to_guest(vm, ucall_mmio_gpa);
+}
+
 void ucall_arch_do_ucall(vm_vaddr_t uc)
 {
-	/*
-	 * FIXME: Revert this hack (the entire commit that added it) once nVMX
-	 * preserves L2 GPRs across a nested VM-Exit.  If a ucall from L2, e.g.
-	 * to do a GUEST_SYNC(), lands the vCPU in L1, any and all GPRs can be
-	 * clobbered by L1.  Save and restore non-volatile GPRs (clobbering RBP
-	 * in particular is problematic) along with RDX and RDI (which are
-	 * inputs), and clobber volatile GPRs. *sigh*
-	 */
-#define HORRIFIC_L2_UCALL_CLOBBER_HACK	\
+	switch (vm_type) {
+	case KVM_X86_TDX_VM:
+		tdg_vp_vmcall_ve_request_mmio_write(ucall_mmio_gpa, 8, uc);
+		return;
+	default:
+		/*
+		 * FIXME: Revert this hack (the entire commit that added it)
+		 * once nVMX preserves L2 GPRs across a nested VM-Exit.  If a
+		 * ucall from L2, e.g.  to do a GUEST_SYNC(), lands the vCPU in
+		 * L1, any and all GPRs can be clobbered by L1.  Save and
+		 * restore non-volatile GPRs (clobbering RBP in particular is
+		 * problematic) along with RDX and RDI (which are inputs), and
+		 * clobber volatile GPRs. *sigh*
+		 */
+#define HORRIFIC_L2_UCALL_CLOBBER_HACK		\
 	"rcx", "rsi", "r8", "r9", "r10", "r11"
 
-	asm volatile("push %%rbp\n\t"
-		     "push %%r15\n\t"
-		     "push %%r14\n\t"
-		     "push %%r13\n\t"
-		     "push %%r12\n\t"
-		     "push %%rbx\n\t"
-		     "push %%rdx\n\t"
-		     "push %%rdi\n\t"
-		     "in %[port], %%al\n\t"
-		     "pop %%rdi\n\t"
-		     "pop %%rdx\n\t"
-		     "pop %%rbx\n\t"
-		     "pop %%r12\n\t"
-		     "pop %%r13\n\t"
-		     "pop %%r14\n\t"
-		     "pop %%r15\n\t"
-		     "pop %%rbp\n\t"
-		: : [port] "d" (UCALL_PIO_PORT), "D" (uc) : "rax", "memory",
-		     HORRIFIC_L2_UCALL_CLOBBER_HACK);
+		asm volatile("push %%rbp\n\t"
+			     "push %%r15\n\t"
+			     "push %%r14\n\t"
+			     "push %%r13\n\t"
+			     "push %%r12\n\t"
+			     "push %%rbx\n\t"
+			     "push %%rdx\n\t"
+			     "push %%rdi\n\t"
+			     "in %[port], %%al\n\t"
+			     "pop %%rdi\n\t"
+			     "pop %%rdx\n\t"
+			     "pop %%rbx\n\t"
+			     "pop %%r12\n\t"
+			     "pop %%r13\n\t"
+			     "pop %%r14\n\t"
+			     "pop %%r15\n\t"
+			     "pop %%rbp\n\t"
+			     :
+			     : [port] "d"(UCALL_PIO_PORT), "D"(uc)
+			     : "rax", "memory", HORRIFIC_L2_UCALL_CLOBBER_HACK);
+	}
 }
 
 void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
 
-	if (run->exit_reason == KVM_EXIT_IO && run->io.port == UCALL_PIO_PORT) {
-		struct kvm_regs regs;
+	switch (vm_type) {
+	case KVM_X86_TDX_VM:
+		if (vcpu->run->exit_reason == KVM_EXIT_MMIO &&
+		    vcpu->run->mmio.phys_addr == host_ucall_mmio_gpa &&
+		    vcpu->run->mmio.len == 8 && vcpu->run->mmio.is_write) {
+			uint64_t data = *(uint64_t *)vcpu->run->mmio.data;
+
+			return (void *)data;
+		}
+		return NULL;
+	default:
+		if (run->exit_reason == KVM_EXIT_IO &&
+		    run->io.port == UCALL_PIO_PORT) {
+			struct kvm_regs regs;
 
-		vcpu_regs_get(vcpu, &regs);
-		return (void *)regs.rdi;
+			vcpu_regs_get(vcpu, &regs);
+			return (void *)regs.rdi;
+		}
+		return NULL;
 	}
-	return NULL;
 }
-- 
2.50.0.rc1.591.g9c95f17f64-goog


