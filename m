Return-Path: <linux-kselftest+bounces-3634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8133F83E2A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 20:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67641C21B21
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 19:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CE2224E4;
	Fri, 26 Jan 2024 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BdG+fjbV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43069250F2
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Jan 2024 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297556; cv=none; b=QNrJOL0hNC4tFh2QFGHKzslvBPhItcwk6Lt5v2vIRNjtW600tvC++jB1W1t45oLkxaDZHkuGeGhdiQkfE6kT4idkEGpPLW9bdELwp69MCvMMf2thuxJDazj+3GJZ4Wy2NjdjkkLEdW6X5n71oef+Dw3Mjv7XlJeBrXeUzBhAzUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297556; c=relaxed/simple;
	bh=G7bXN1UU7tRHuhRNiFDWOUYFSBIKcFwI1z+6qWkllUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bn+lBnnwyVbrdkNt8uQzaUKYuwJPa0AOrxyaAQobTEZSSLqLoJAKl7MJQiitSQxuIlMQ8F5OdwR3sYFU+JzbcZ/P6cllxylFSqZfQirbXIbzMYeU7DECsBHWueJFtZbvgK2qx/hn+3MsZkiG7rXxzSQvcqMya48LMFgWWvX0SWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BdG+fjbV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6dde011a87eso607300b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jan 2024 11:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706297552; x=1706902352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZnAUMJ/rBNfk0zriTt4DNaLm50XXQ05JIKVH4sIBy8=;
        b=BdG+fjbVyUIqrKOw3uVUKxJ8o/XFwNRo0rwZYz4jD/lnHkacK5/bItbaX4IVsj+Cfq
         0UMaS5QAx8nqewtyAF/WU4og8GesrXHxckaca9Lu2zkazGVUiMOTgTqVPBAP023SGG9e
         2iriWh31YizgBjXz6lkjIJz7cZSSYXDWeH4X0718UymPnjiwKZMb296jy/eWT2eF/fCF
         eVuIRBgi/V2QpfnHnqXKVNVrSUifLA2vrRDYU+OgGoVLwujNVC/KpAtzFbcQY4sEBa7r
         5p9KzxQ+G+l5szsgQkp4MUl/LNno/buj79kk7z5V8+ViS4MS896AYzU08hIhvwJBJyJl
         a/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706297552; x=1706902352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZnAUMJ/rBNfk0zriTt4DNaLm50XXQ05JIKVH4sIBy8=;
        b=WVichAR8XGr53r9cLdtaWyyvYw6C/KxBXuMhy8dr+V2zHAHSydM8AZOrc7s8lDJBdv
         y0B4+pJ4pPh1538Fg673L8b1mQ8BIBJKeVKcyh4y76MqYfrzwB6OZkaqAKj+DmLnsYI1
         dZxLsCWkEg54a8AOMLcl9ideru/sgnWuDgOjLjH0IGYu8b7shFAyXladFfZm2I8hVUTA
         OM+FPBEr7BEsGcSE09yCCyQGH1vGGWkxvz3m7ezfyyYS3fDVRAZQXAOuBqK9mFiyo85e
         G/Wh84W9XHlQCwbhTv18KDlx2Xd1CC5yvCx5u7KPCG6+fJ4+QFQkwClc/BAFUxxCNUTg
         vdpw==
X-Gm-Message-State: AOJu0YyyNTQ9292pyFIfTgkj37MpEWDlOuhN6qe4Zl+fzqKiVHBvdj32
	sshhoQ7ArmkxMrbzUpMe05hvMinEk4PI/DBjf6a8sALygM0K+a1wTAl4oDOCs5FVjw2vW/sEjrB
	C8g==
X-Google-Smtp-Source: AGHT+IHM5VqGTPfsIsGNcbuR2VfSqB1AGkIPq1pRvYCtl3Dzv46BIfBqP1NL9KevmFyYzQje/NXy4EWVYsU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1bc4:b0:6d9:b26d:d05d with SMTP id
 o4-20020a056a001bc400b006d9b26dd05dmr27073pfw.6.1706297552566; Fri, 26 Jan
 2024 11:32:32 -0800 (PST)
Date: Fri, 26 Jan 2024 11:32:31 -0800
In-Reply-To: <20231005143839.365297-8-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005143839.365297-1-thuth@redhat.com> <20231005143839.365297-8-thuth@redhat.com>
Message-ID: <ZbQIz3thIczeRhCs@google.com>
Subject: Re: [PATCH v2 7/7] KVM: selftests: x86: Use TAP interface in the
 userspace_msr_exit test
From: Sean Christopherson <seanjc@google.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 05, 2023, Thomas Huth wrote:
> Use the kselftest_harness.h interface in this test to get TAP
> output, so that it is easier for the user to see what the test
> is doing.
> 
> Note: We're not using the KVM_ONE_VCPU_TEST() macro here (but the
> generic TEST() macro from kselftest_harness.h) since each of the
> tests needs a different guest code function.

I would much rather we add a KVM framework that can deal with this, i.e. build
something that is flexible from the get-go.  Allowing tests to set the entry point
after vCPU is fairly straightforward (patch below, compile tested only on x86).

With that, my vote would be to have KVM_ONE_VCPU_TEST_SUITE() *always* pass NULL
for the entry point, and instead always require sub-tests to pass the guest code
to KVM_ONE_VCPU_TEST().  I think having the sub-test explicitly specify its guest
code will be helpful for developers reading the code.  And maybe waaay down the
road if we can get all tests converted to the framework, we can drop @guest_code
from vm_create_with_one_vcpu() entirely.

Apologies for the horrifically slow review, I got waylaid by non-upstream stuff
for almost all of November=>January. :-(

---
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jan 2024 11:15:13 -0800
Subject: [PATCH] KVM: selftests: Move setting a vCPU's entry point to a
 dedicated API

Extract the code to set a vCPU's entry point out of vm_arch_vcpu_add() and
into a new API, vcpu_arch_set_entry_point().  Providing a separate API
will allow creating a KVM selftests hardness that can handle tests that
use different entry points for sub-tests, whereas *requiring* the entry
point to be specified at vCPU creation makes it difficult to create a
generic harness, e.g. the boilerplate setup/teardown can't easily create
and destroy the VM and vCPUs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     | 11 +++++----
 .../selftests/kvm/lib/aarch64/processor.c     | 23 ++++++++++++++-----
 .../selftests/kvm/lib/riscv/processor.c       |  9 +++++---
 .../selftests/kvm/lib/s390x/processor.c       | 13 ++++++-----
 .../selftests/kvm/lib/x86_64/processor.c      | 13 ++++++++---
 5 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 9e5afc472c14..a6e7738a8db7 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -969,15 +969,18 @@ static inline void vcpu_dump(FILE *stream, struct kvm_vcpu *vcpu,
  * Input Args:
  *   vm - Virtual Machine
  *   vcpu_id - The id of the VCPU to add to the VM.
- *   guest_code - The vCPU's entry point
  */
-struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
-				  void *guest_code);
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id);
+void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
 
 static inline struct kvm_vcpu *vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 					   void *guest_code)
 {
-	return vm_arch_vcpu_add(vm, vcpu_id, guest_code);
+	struct kvm_vcpu *vcpu = vm_arch_vcpu_add(vm, vcpu_id);
+
+	vcpu_arch_set_entry_point(vcpu, guest_code);
+
+	return vcpu;
 }
 
 /* Re-create a vCPU after restarting a VM, e.g. for state save/restore tests. */
diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 43b9a7283360..ed4ab29f4fad 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -365,8 +365,13 @@ void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
 		indent, "", pstate, pc);
 }
 
-struct kvm_vcpu *aarch64_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
-				  struct kvm_vcpu_init *init, void *guest_code)
+void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
+{
+	vcpu_set_reg(vcpu, ARM64_CORE_REG(regs.pc), (uint64_t)guest_code);
+}
+
+static struct kvm_vcpu *__aarch64_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
+					   struct kvm_vcpu_init *init)
 {
 	size_t stack_size;
 	uint64_t stack_vaddr;
@@ -381,15 +386,21 @@ struct kvm_vcpu *aarch64_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	aarch64_vcpu_setup(vcpu, init);
 
 	vcpu_set_reg(vcpu, ARM64_CORE_REG(sp_el1), stack_vaddr + stack_size);
-	vcpu_set_reg(vcpu, ARM64_CORE_REG(regs.pc), (uint64_t)guest_code);
+}
+
+struct kvm_vcpu *aarch64_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
+				  struct kvm_vcpu_init *init, void *guest_code)
+{
+	struct kvm_vcpu *vcpu = __aarch64_vcpu_add(vm, vcpu_id, init);
+
+	vcpu_arch_set_entry_point(vcpu, guest_code);
 
 	return vcpu;
 }
 
-struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
-				  void *guest_code)
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 {
-	return aarch64_vcpu_add(vm, vcpu_id, NULL, guest_code);
+	return __aarch64_vcpu_add(vm, vcpu_id, NULL);
 }
 
 void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index 2bb33a8ac03c..6d5ef6ed0234 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -277,8 +277,12 @@ static void __aligned(16) guest_unexp_trap(void)
 		  0, 0, 0, 0, 0, 0);
 }
 
-struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
-				  void *guest_code)
+void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
+{
+	vcpu_set_reg(vcpu, RISCV_CORE_REG(regs.pc), (unsigned long)guest_code);
+}
+
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 {
 	int r;
 	size_t stack_size;
@@ -312,7 +316,6 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 
 	/* Setup stack pointer and program counter of guest */
 	vcpu_set_reg(vcpu, RISCV_CORE_REG(regs.sp), stack_vaddr + stack_size);
-	vcpu_set_reg(vcpu, RISCV_CORE_REG(regs.pc), (unsigned long)guest_code);
 
 	/* Setup default exception vector of guest */
 	vcpu_set_reg(vcpu, RISCV_GENERAL_CSR_REG(stvec), (unsigned long)guest_unexp_trap);
diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
index f6d227892cbc..4ad4492eea1d 100644
--- a/tools/testing/selftests/kvm/lib/s390x/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
@@ -155,15 +155,18 @@ void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 	virt_dump_region(stream, vm, indent, vm->pgd);
 }
 
-struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
-				  void *guest_code)
+void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
+{
+	vcpu->run->psw_addr = (uintptr_t)guest_code;
+}
+
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 {
 	size_t stack_size =  DEFAULT_STACK_PGS * getpagesize();
 	uint64_t stack_vaddr;
 	struct kvm_regs regs;
 	struct kvm_sregs sregs;
 	struct kvm_vcpu *vcpu;
-	struct kvm_run *run;
 
 	TEST_ASSERT(vm->page_size == 4096, "Unsupported page size: 0x%x",
 		    vm->page_size);
@@ -184,9 +187,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	sregs.crs[1] = vm->pgd | 0xf;		/* Primary region table */
 	vcpu_sregs_set(vcpu, &sregs);
 
-	run = vcpu->run;
-	run->psw_mask = 0x0400000180000000ULL;  /* DAT enabled + 64 bit mode */
-	run->psw_addr = (uintptr_t)guest_code;
+	vcpu->run->psw_mask = 0x0400000180000000ULL;  /* DAT enabled + 64 bit mode */
 
 	return vcpu;
 }
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 4bc52948447d..18dfabc1c6e7 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -562,8 +562,16 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
 	sync_global_to_guest(vm, host_cpu_is_amd);
 }
 
-struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
-				  void *guest_code)
+void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
+{
+	struct kvm_regs regs;
+
+	vcpu_regs_get(vcpu, &regs);
+	regs.rip = (unsigned long) guest_code;
+	vcpu_regs_set(vcpu, &regs);
+}
+
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 {
 	struct kvm_mp_state mp_state;
 	struct kvm_regs regs;
@@ -597,7 +605,6 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	vcpu_regs_get(vcpu, &regs);
 	regs.rflags = regs.rflags | 0x2;
 	regs.rsp = stack_vaddr;
-	regs.rip = (unsigned long) guest_code;
 	vcpu_regs_set(vcpu, &regs);
 
 	/* Setup the MP state */

base-commit: e19ec6e3e05fa223f05c72806028dfa531dbd0ae
-- 


