Return-Path: <linux-kselftest+bounces-44212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC2C16EB6
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 22:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443F31C21FAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 21:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEB8350D71;
	Tue, 28 Oct 2025 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JyrXlD0E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C834CFC8
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 21:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686459; cv=none; b=gq65vUc/4nebJ0vKhOMWKuObiSqEq/84cwdqH6aK0TEzcMEPPnUk9eRVqVTKW6kDX4lRCGVSR2JiiRpzXJ1OZH229xEHYNSapLY3Dln+DyPx8F22rz74Jd3/PvRzhRnjNl+NQUid4SwnwAmy00LW8ZL84ikWAz4WRUAo/VkHLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686459; c=relaxed/simple;
	bh=1taRtnVW6cATeCX53WJ7F7rAY20El5Aqn3oYb2ry0KY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jeQzOSQz0XaEspZknvlJlGDcPybXRgs3VAC0Z9TGqd8Z3oYKMC4CgNfJS4oi7J8I1HzONbvrqsg8FxYNRb8yx+B6dNAQ8IkDZdJQokZlntcGqEC3G8rE1FzYH0qujHLxghiNerj21AHYCI1u576Ld15eSV0ppJZJrn/iofzh6K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JyrXlD0E; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-93e8e029e0cso1759876539f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 14:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686456; x=1762291256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p7v7/UUME0K6OufONPcieqq83sRrWQqrOjB3BM2ME/o=;
        b=JyrXlD0EnMHCqZzQYMYn/CeY6Tb403Y0w4GpVveB6lY/mYK7mAqgiB0+0U+esIvggF
         GNkLi97zdJGU11xWmWo9OZZz+WBKHHVQf32HBgD4P2wWcw3IVT8vZd4yhf177F7vMtqG
         BBo+7J6D4yq4228Fq4cq3O7UVul2Q1ZkhrICjQnUGxtd2oIRU5BHpCPGhOqr3WK0KWJ1
         ANgzyunn13ghI3CLanfrbsFQ3fDS8826nuw0QRZko6epnxydzimVfbD0e0xIb9PsgPDL
         wzfFS0Nub5KqQHy/7XGm9UrIgJicHTN31lxvWck8DE2s/rXWvhRlgw71J77vzvMoMyGm
         olGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686456; x=1762291256;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7v7/UUME0K6OufONPcieqq83sRrWQqrOjB3BM2ME/o=;
        b=og3tfzhLoHHYE73U8WOT+7EbWsUyF0y0uSdrXVUYoM4Ds4wNlRU46hw53VRLa2dJv3
         I1awz/cH5xiNYEFNFt0r7Bca2C4bAt+e6IhrqbsPRZckaavK+hCrwQy/p3ecLP4fv/CP
         5JNXc9koc5h9Dd4Lakde1eJAPb961oWtx/8d2i+E+fSkXf6ZNbU/fAtS9o+NZOZPKe/V
         ZKnZ/NYDaBUDO5PmxRVpHIUZbQF8PwM3qkCfTqQ1gMF9HlRgbziMyjowBlLiuSxy2xkP
         G5HPOBq/U8q68dyUko8x4dMRvF/JbZ5eJZy9b4U5YK0QoqJtQmEm0uHvxfKZPNkm5598
         95mQ==
X-Gm-Message-State: AOJu0Ywyeoqv/OXrp96yBQIkLjQLASnGZzjc63mMTd09uUNVHGTabMbR
	g4FocUeKWM+E21im8z0eBiUk5ICehHvM8SVpgrcKgOucUUfbUVub4s4pkUctZGdedlQxAZEe2nz
	/v9uDRhqKp4oCyV/p/b89CH9u7C98qKlgCcfCry9KQnNviBBUCoy/utDdz7mdR1OntK/AE6ZOHV
	U0XfyC4eR2JYHa+vwbfScCnccmQYWsfcGOiE+Yx7aD2fo=
X-Google-Smtp-Source: AGHT+IHNXgJLtfugfZ8phIcSQWQdiDgA9oVsbmqb4/VEjcfKWvug5tIMa6jcolDnkLWp3M99cFU8XavGwQ==
X-Received: from iobeh1.prod.google.com ([2002:a05:6602:4a01:b0:943:9a0c:d618])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:2ccb:b0:943:edb3:ce65
 with SMTP id ca18e2360f4ac-945c97f2fddmr159522739f.15.1761686456312; Tue, 28
 Oct 2025 14:20:56 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:27 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-2-sagis@google.com>
Subject: [PATCH v12 01/23] KVM: selftests: Add macros so simplify creating VM
 shapes for non-default types
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

From: Sean Christopherson <seanjc@google.com>

Add VM_TYPE() and __VM_TYPE() macros to create a vm_shape structure given
a type (and mode), and use the macros to define VM_SHAPE_{SEV,SEV_ES,SNP}
shapes for x86's SEV family of VM shapes.  Providing common infrastructure
will avoid having to copy+paste vm_sev_create_with_one_vcpu() for TDX.

Use the new SEV+ shapes and drop vm_sev_create_with_one_vcpu().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  | 14 +++++++
 .../selftests/kvm/include/x86/processor.h     |  4 ++
 tools/testing/selftests/kvm/include/x86/sev.h |  2 -
 tools/testing/selftests/kvm/lib/x86/sev.c     | 16 --------
 .../selftests/kvm/x86/sev_smoke_test.c        | 40 +++++++++----------
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index d3f3e455c031..310ec2b8afb7 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -209,6 +209,20 @@ kvm_static_assert(sizeof(struct vm_shape) == sizeof(uint64_t));
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
-- 
2.51.1.851.g4ebd6896fd-goog


