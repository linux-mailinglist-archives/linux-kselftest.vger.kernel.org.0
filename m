Return-Path: <linux-kselftest+bounces-44007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 571C0C07421
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 18:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A179188B9A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687C32F99AE;
	Fri, 24 Oct 2025 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PwdxQo1G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F36A1FC7C5
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322730; cv=none; b=EDje+0hZrWrVv3j4NNkz8vToD2wO9hD8rk0x345lTsStAxUrfM1bVlTBLwpu8XCVUaKVnbxNIq2woIJjN2iVI4QJ//NBLUfpu4WJ3JNnY6lydZh8e6dfnvck9Vt9mRw797VUyXudPc8HDSWFYbSYBpgPUsXWblK1/wJPb6iIjNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322730; c=relaxed/simple;
	bh=+2rClT3H1t0zEq51qQjI+841NQYJ860yO2mXoKNdBEM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LzCMm5zUJDzXMdwis42wX3kAyi2xDxzODXZHzDPVKViJGnHHd8hWCfgvxik9UNdALB1iztb9TNIbanVPUrhI7AaIp3ijwv/oXPfkigDEZ0zzRe0OVL860WqukOC4NJ1bPkOOstj2fpHWCsEm6rKwLpHze0QSrMGmD/9jMpZNZQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PwdxQo1G; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b522037281bso1390434a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 09:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761322728; x=1761927528; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0DikGWmDqO4gBYd8Hx7+LpMZg4ZudxkXzAwpe0YrCfg=;
        b=PwdxQo1GxkW9ShG6HDkyis0N6uvDyvmxaLkkM+bPAtJatgF+le3O2SeyIJB4uzGZSf
         M+iIZaa8Mu5Ed6TCje9nCxGhnRSY40lrEIl7PARd9A7mTvzI+h8YKtBMjkHqCKWCPpOS
         UEsynTtCq7GPLq+d5VMteKJsIIBrzuGkEl2AHbmsnfmWUbFNBzhXrFq5iujNewMhKRj8
         jVHRyKUaVKnn696FEeLqEdiTd1ngdKsuzAO6za6MWA+q/bdsh6pkcWTUZDkHc1UcqbUl
         pw2GLQcGAQOlRDv3tkvQbTgeH/GT0TSlHQg7tt0bMOs0SRSZq2ibNKRM50WOK3hrKfTP
         vpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322728; x=1761927528;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DikGWmDqO4gBYd8Hx7+LpMZg4ZudxkXzAwpe0YrCfg=;
        b=Ym74yWwr8J0j0leolRE02M7vvKfKbK+iNvp+ik8cCO+DsxKGfqiy7eXxeW0HhYbPxC
         9oe6OzFmRT4f3gXCCqkKLvXqjdewiymadGwTheEE3JW0ahyoWy0udhLMdW0eC5mBTYW8
         n63avnoqbpx9r7fXZ42juWZIi0BSL6ufJ+CBN/L6PoSMqXPSsqcRoEZZNBPm5kHo2YZa
         r5NQCpy175bJWkrEzqxvYPLXoh1mH3nAoibUK9Gc4Q9O0XXOz3TcxMdFm6HNp6i0f5Dj
         zpD5MFrd2e3+34w4G5CglzTkAztmLvivXqemfmEOeC2myXIwgaTeSbqoyjsPyaxb2/R+
         D//w==
X-Gm-Message-State: AOJu0YzpbMBIHGuj1yZT0Iwsk8ofKRlFWjISogDIXn2ZMi5G38WpRMSX
	aKaFVzIS4cL3J2+rkneGugWM6OpbQFEgwgKCPOf/riuzp7ajrw6UFN3IdtXziRHw/YJ2Ub42/XF
	495qtWw==
X-Google-Smtp-Source: AGHT+IHBp7ELWmD4ISl8plp07YOug/eEFJnCYe2dib45aZ0dAMyytCpU4J0e+anY9QxAp8Bgu4UhXeEQGZM=
X-Received: from pjbgk8.prod.google.com ([2002:a17:90b:1188:b0:32e:a549:83e3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d8f:b0:335:2eee:19dc
 with SMTP id 98e67ed59e1d1-33bcf8f94b6mr35765813a91.28.1761322727777; Fri, 24
 Oct 2025 09:18:47 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:18:46 -0700
In-Reply-To: <20250925172851.606193-22-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com> <20250925172851.606193-22-sagis@google.com>
Message-ID: <aPum5qJjFH49YVyy@google.com>
Subject: Re: [PATCH v11 21/21] KVM: selftests: Add TDX lifecycle test
From: Sean Christopherson <seanjc@google.com>
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 25, 2025, Sagi Shahar wrote:
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index 53cfadeff8de..714413e062fd 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -328,3 +328,21 @@ void vm_tdx_finalize(struct kvm_vm *vm)
>  	load_td_private_memory(vm);
>  	vm_tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
>  }
> +
> +struct kvm_vm *vm_tdx_create_with_one_vcpu(void *guest_code,
> +					   struct kvm_vcpu **vcpu)
> +{
> +	struct vm_shape shape = {
> +		.mode = VM_MODE_DEFAULT,
> +		.type = KVM_X86_TDX_VM,
> +	};
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpus[1];
> +
> +	vm = __vm_create_with_vcpus(shape, 1, 0, guest_code, vcpus);
> +	*vcpu = vcpus[0];
> +
> +	vm_tdx_finalize(vm);
> +
> +	return vm;
> +}

Rather than add a full wrapper, and duplicate all of vm_sev_create_with_one_vcpu(),
we should just add macros to convert a type to a shape.

E.g. with this, you can simply add:

  #define VM_SHAPE_TDX	VM_TYPE(KVM_X86_TDX_VM)

And coupled with Ira's suggestion regarding vm_tdx_finalize(), there should be
no need for vm_tdx_create_with_one_vcpu().


--
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 24 Oct 2025 09:14:43 -0700
Subject: [PATCH] KVM: selftests: Add macros so simplify creating VM shapes for
 non-default types

Add VM_TYPE() and __VM_TYPE() macros to create a vm_shape structure given
a type (and mode), and use the macros to define VM_SHAPE_{SEV,SEV_ES,SNP}
shapes for x86's SEV family of VM shapes.  Providing common infrastructure
will avoid having to copy+paste vm_sev_create_with_one_vcpu() for TDX.

Use the new SEV+ shapes and drop vm_sev_create_with_one_vcpu().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  | 14 +++++++
 .../selftests/kvm/include/x86/processor.h     |  4 ++
 tools/testing/selftests/kvm/include/x86/sev.h |  2 -
 tools/testing/selftests/kvm/lib/x86/sev.c     | 16 --------
 .../selftests/kvm/x86/sev_smoke_test.c        | 40 +++++++++----------
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index af52cd938b50..af0b53987c06 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -210,6 +210,20 @@ kvm_static_assert(sizeof(struct vm_shape) == sizeof(uint64_t));
 	shape;					\
 })
 
+#define __VM_TYPE(__mode, __type)		\
+({						\
+	struct vm_shape shape = {		\
+		.mode = (__mode),		\
+		.type = (__type)		\
+	};					\
+						\
+	shape;					\
+})
+
+#define VM_TYPE(__type)				\
+	__VM_TYPE(VM_MODE_DEFAULT, __type)
+
+
 #if defined(__aarch64__)
 
 extern enum vm_guest_mode vm_mode_default;
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 51cd84b9ca66..dd21e11e1908 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -362,6 +362,10 @@ static inline unsigned int x86_model(unsigned int eax)
 	return ((eax >> 12) & 0xf0) | ((eax >> 4) & 0x0f);
 }
 
+#define VM_SHAPE_SEV		VM_TYPE(KVM_X86_SEV_VM)
+#define VM_SHAPE_SEV_ES		VM_TYPE(KVM_X86_SEV_ES_VM)
+#define VM_SHAPE_SNP		VM_TYPE(KVM_X86_SNP_VM)
+
 /* Page table bitfield declarations */
 #define PTE_PRESENT_MASK        BIT_ULL(0)
 #define PTE_WRITABLE_MASK       BIT_ULL(1)
diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index 008b4169f5e2..3c3294599ba6 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -53,8 +53,6 @@ void snp_vm_launch_start(struct kvm_vm *vm, uint64_t policy);
 void snp_vm_launch_update(struct kvm_vm *vm);
 void snp_vm_launch_finish(struct kvm_vm *vm);
 
-struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
-					   struct kvm_vcpu **cpu);
 void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement);
 
 kvm_static_assert(SEV_RET_SUCCESS == 0);
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index c3a9838f4806..1e3f6514c28d 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -158,22 +158,6 @@ void snp_vm_launch_finish(struct kvm_vm *vm)
 	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_FINISH, &launch_finish);
 }
 
-struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
-					   struct kvm_vcpu **cpu)
-{
-	struct vm_shape shape = {
-		.mode = VM_MODE_DEFAULT,
-		.type = type,
-	};
-	struct kvm_vm *vm;
-	struct kvm_vcpu *cpus[1];
-
-	vm = __vm_create_with_vcpus(shape, 1, 0, guest_code, cpus);
-	*cpu = cpus[0];
-
-	return vm;
-}
-
 void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement)
 {
 	if (is_sev_snp_vm(vm)) {
diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 77256c89bb8d..3903793c6750 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -74,7 +74,7 @@ static void compare_xsave(u8 *from_host, u8 *from_guest)
 		abort();
 }
 
-static void test_sync_vmsa(uint32_t type, uint64_t policy)
+static void test_sync_vmsa(struct vm_shape shape, uint64_t policy)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -84,7 +84,7 @@ static void test_sync_vmsa(uint32_t type, uint64_t policy)
 	double x87val = M_PI;
 	struct kvm_xsave __attribute__((aligned(64))) xsave = { 0 };
 
-	vm = vm_sev_create_with_one_vcpu(type, guest_code_xsave, &vcpu);
+	vm = vm_create_shape_with_one_vcpu(shape, &vcpu, guest_code_xsave);
 	gva = vm_vaddr_alloc_shared(vm, PAGE_SIZE, KVM_UTIL_MIN_VADDR,
 				    MEM_REGION_TEST_DATA);
 	hva = addr_gva2hva(vm, gva);
@@ -120,13 +120,13 @@ static void test_sync_vmsa(uint32_t type, uint64_t policy)
 	kvm_vm_free(vm);
 }
 
-static void test_sev(void *guest_code, uint32_t type, uint64_t policy)
+static void test_sev(void *guest_code, struct vm_shape shape, uint64_t policy)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct ucall uc;
 
-	vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
+	vm = vm_create_shape_with_one_vcpu(shape, &vcpu, guest_code);
 
 	/* TODO: Validate the measurement is as expected. */
 	vm_sev_launch(vm, policy, NULL);
@@ -171,12 +171,12 @@ static void guest_shutdown_code(void)
 	__asm__ __volatile__("ud2");
 }
 
-static void test_sev_shutdown(uint32_t type, uint64_t policy)
+static void test_sev_shutdown(struct vm_shape shape, uint64_t policy)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	vm = vm_sev_create_with_one_vcpu(type, guest_shutdown_code, &vcpu);
+	vm = vm_create_shape_with_one_vcpu(shape, &vcpu, guest_shutdown_code);
 
 	vm_sev_launch(vm, policy, NULL);
 
@@ -188,28 +188,28 @@ static void test_sev_shutdown(uint32_t type, uint64_t policy)
 	kvm_vm_free(vm);
 }
 
-static void test_sev_smoke(void *guest, uint32_t type, uint64_t policy)
+static void test_sev_smoke(void *guest, struct vm_shape shape, uint64_t policy)
 {
 	const u64 xf_mask = XFEATURE_MASK_X87_AVX;
 
-	if (type == KVM_X86_SNP_VM)
-		test_sev(guest, type, policy | SNP_POLICY_DBG);
+	if (shape.type == KVM_X86_SNP_VM)
+		test_sev(guest, shape, policy | SNP_POLICY_DBG);
 	else
-		test_sev(guest, type, policy | SEV_POLICY_NO_DBG);
-	test_sev(guest, type, policy);
+		test_sev(guest, shape, policy | SEV_POLICY_NO_DBG);
+	test_sev(guest, shape, policy);
 
-	if (type == KVM_X86_SEV_VM)
+	if (shape.type == KVM_X86_SEV_VM)
 		return;
 
-	test_sev_shutdown(type, policy);
+	test_sev_shutdown(shape, policy);
 
 	if (kvm_has_cap(KVM_CAP_XCRS) &&
 	    (xgetbv(0) & kvm_cpu_supported_xcr0() & xf_mask) == xf_mask) {
-		test_sync_vmsa(type, policy);
-		if (type == KVM_X86_SNP_VM)
-			test_sync_vmsa(type, policy | SNP_POLICY_DBG);
+		test_sync_vmsa(shape, policy);
+		if (shape.type == KVM_X86_SNP_VM)
+			test_sync_vmsa(shape, policy | SNP_POLICY_DBG);
 		else
-			test_sync_vmsa(type, policy | SEV_POLICY_NO_DBG);
+			test_sync_vmsa(shape, policy | SEV_POLICY_NO_DBG);
 	}
 }
 
@@ -217,13 +217,13 @@ int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
 
-	test_sev_smoke(guest_sev_code, KVM_X86_SEV_VM, 0);
+	test_sev_smoke(guest_sev_code, VM_SHAPE_SEV, 0);
 
 	if (kvm_cpu_has(X86_FEATURE_SEV_ES))
-		test_sev_smoke(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
+		test_sev_smoke(guest_sev_es_code, VM_SHAPE_SEV_ES, SEV_POLICY_ES);
 
 	if (kvm_cpu_has(X86_FEATURE_SEV_SNP))
-		test_sev_smoke(guest_snp_code, KVM_X86_SNP_VM, snp_default_policy());
+		test_sev_smoke(guest_snp_code, VM_SHAPE_SNP, snp_default_policy());
 
 	return 0;
 }

base-commit: 4cc167c50eb19d44ac7e204938724e685e3d8057
--

