Return-Path: <linux-kselftest+bounces-4370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D20B84E9ED
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 21:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184111F22434
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 20:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121FB5102B;
	Thu,  8 Feb 2024 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghLWCvg8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B295026E
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Feb 2024 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707425350; cv=none; b=leVEa3/l1wCZMxqKoQWWvAQ2piJ7ZUEbVfTOF4EqTT7pXkFZ9zwM+WReVFJqKFrkgVH/8DsyD6O2SGyFI4CfvvkepLZ0ySBKTAxJCH9YNMdL6sZ+MQvOPW8TJjlp9QHCHXsZtkLmN2bj9bO/DrNBBf2cBgNmhnxZk2ISotgnfas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707425350; c=relaxed/simple;
	bh=4jFJKN6LVOTvoENVERYlx3BX42kUwr4xWT812ssHnTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcUtifNhfUeVpy7JNyUA3VvNv0tcG1r0qRVovjzBHyOyw/vRvmTWbg/Mn1hx7lGRTh0niWxtAjlwkMOsoRGkcVdI6crGeBkOFL7/L49H+iN0fVtSCWkqHPCKOzVu6o2m3caGA/pEJ5w2njPxjeIm3rwuUD3TwvZOmY4Fq23nb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ghLWCvg8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707425347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvBT64/oLU+IfVRDquZlevwUrUAKsh5CvmhVsSc+u/4=;
	b=ghLWCvg8YLaZkmcOAIUtKMYWfkPH/RxUjFyu6k+soOuXzBXhc24kUiZTM2pIcQQdJQknK2
	OzHQ60kszTeZZ7n5GnW8LrzfhG9mcKJ3WkHPAGxOFB58Cwodcho2gRZXZ8aS5VLwzGBjCp
	M8ut+v22WMy5I2fcSZ0txOjzTrNNUds=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-dP3yEAzJMJuRL4GDOr75Yw-1; Thu,
 08 Feb 2024 15:49:03 -0500
X-MC-Unique: dP3yEAzJMJuRL4GDOr75Yw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A9DC1C05141;
	Thu,  8 Feb 2024 20:49:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EE5541C10C0C;
	Thu,  8 Feb 2024 20:49:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v3 7/8] KVM: selftests: x86: Use TAP interface in the vmx_pmu_caps test
Date: Thu,  8 Feb 2024 21:48:43 +0100
Message-ID: <20240208204844.119326-8-thuth@redhat.com>
In-Reply-To: <20240208204844.119326-1-thuth@redhat.com>
References: <20240208204844.119326-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Use the kvm_test_harness.h interface in this test to get TAP
output, so that it is easier for the user to see what the test
is doing.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  | 50 ++++---------------
 1 file changed, 11 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index 2a8d4ac2f0204..11953c3ded756 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -15,6 +15,7 @@
 
 #include <linux/bitmap.h>
 
+#include "kvm_test_harness.h"
 #include "kvm_util.h"
 #include "vmx.h"
 
@@ -32,7 +33,7 @@ union perf_capabilities {
 		u64	anythread_deprecated:1;
 	};
 	u64	capabilities;
-};
+} host_cap;
 
 /*
  * The LBR format and most PEBS features are immutable, all other features are
@@ -73,19 +74,19 @@ static void guest_code(uint64_t current_val)
 	GUEST_DONE();
 }
 
+KVM_ONE_VCPU_TEST_SUITE(vmx_pmu_caps);
+
 /*
  * Verify that guest WRMSRs to PERF_CAPABILITIES #GP regardless of the value
  * written, that the guest always sees the userspace controlled value, and that
  * PERF_CAPABILITIES is immutable after KVM_RUN.
  */
-static void test_guest_wrmsr_perf_capabilities(union perf_capabilities host_cap)
+KVM_ONE_VCPU_TEST(vmx_pmu_caps, guest_wrmsr_perf_capabilities, guest_code)
 {
-	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	struct ucall uc;
 	int r, i;
 
-	vm_init_descriptor_tables(vm);
+	vm_init_descriptor_tables(vcpu->vm);
 	vcpu_init_descriptor_tables(vcpu);
 
 	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.capabilities);
@@ -117,31 +118,21 @@ static void test_guest_wrmsr_perf_capabilities(union perf_capabilities host_cap)
 		TEST_ASSERT(!r, "Post-KVM_RUN write '0x%llx'didn't fail",
 			    host_cap.capabilities ^ BIT_ULL(i));
 	}
-
-	kvm_vm_free(vm);
 }
 
 /*
  * Verify KVM allows writing PERF_CAPABILITIES with all KVM-supported features
  * enabled, as well as '0' (to disable all features).
  */
-static void test_basic_perf_capabilities(union perf_capabilities host_cap)
+KVM_ONE_VCPU_TEST(vmx_pmu_caps, basic_perf_capabilities, guest_code)
 {
-	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm = vm_create_with_one_vcpu(&vcpu, NULL);
-
 	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, 0);
 	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.capabilities);
-
-	kvm_vm_free(vm);
 }
 
-static void test_fungible_perf_capabilities(union perf_capabilities host_cap)
+KVM_ONE_VCPU_TEST(vmx_pmu_caps, fungible_perf_capabilities, guest_code)
 {
 	const uint64_t fungible_caps = host_cap.capabilities & ~immutable_caps.capabilities;
-
-	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm = vm_create_with_one_vcpu(&vcpu, NULL);
 	int bit;
 
 	for_each_set_bit(bit, &fungible_caps, 64) {
@@ -150,8 +141,6 @@ static void test_fungible_perf_capabilities(union perf_capabilities host_cap)
 			     host_cap.capabilities & ~BIT_ULL(bit));
 	}
 	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.capabilities);
-
-	kvm_vm_free(vm);
 }
 
 /*
@@ -160,14 +149,11 @@ static void test_fungible_perf_capabilities(union perf_capabilities host_cap)
  * separately as they are multi-bit values, e.g. toggling or setting a single
  * bit can generate a false positive without dedicated safeguards.
  */
-static void test_immutable_perf_capabilities(union perf_capabilities host_cap)
+KVM_ONE_VCPU_TEST(vmx_pmu_caps, immutable_perf_capabilities, guest_code)
 {
 	const uint64_t reserved_caps = (~host_cap.capabilities |
 					immutable_caps.capabilities) &
 				       ~format_caps.capabilities;
-
-	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm = vm_create_with_one_vcpu(&vcpu, NULL);
 	union perf_capabilities val = host_cap;
 	int r, bit;
 
@@ -201,8 +187,6 @@ static void test_immutable_perf_capabilities(union perf_capabilities host_cap)
 		TEST_ASSERT(!r, "Bad PEBS FMT = 0x%x didn't fail, host = 0x%x",
 			    val.pebs_format, host_cap.pebs_format);
 	}
-
-	kvm_vm_free(vm);
 }
 
 /*
@@ -211,17 +195,13 @@ static void test_immutable_perf_capabilities(union perf_capabilities host_cap)
  * LBR_TOS as those bits are writable across all uarch implementations (arch
  * LBRs will need to poke a different MSR).
  */
-static void test_lbr_perf_capabilities(union perf_capabilities host_cap)
+KVM_ONE_VCPU_TEST(vmx_pmu_caps, lbr_perf_capabilities, guest_code)
 {
-	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm;
 	int r;
 
 	if (!host_cap.lbr_format)
 		return;
 
-	vm = vm_create_with_one_vcpu(&vcpu, NULL);
-
 	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.capabilities);
 	vcpu_set_msr(vcpu, MSR_LBR_TOS, 7);
 
@@ -229,14 +209,10 @@ static void test_lbr_perf_capabilities(union perf_capabilities host_cap)
 
 	r = _vcpu_set_msr(vcpu, MSR_LBR_TOS, 7);
 	TEST_ASSERT(!r, "Writing LBR_TOS should fail after disabling vPMU");
-
-	kvm_vm_free(vm);
 }
 
 int main(int argc, char *argv[])
 {
-	union perf_capabilities host_cap;
-
 	TEST_REQUIRE(get_kvm_param_bool("enable_pmu"));
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_PDCM));
 
@@ -248,9 +224,5 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(host_cap.full_width_write,
 		    "Full-width writes should always be supported");
 
-	test_basic_perf_capabilities(host_cap);
-	test_fungible_perf_capabilities(host_cap);
-	test_immutable_perf_capabilities(host_cap);
-	test_guest_wrmsr_perf_capabilities(host_cap);
-	test_lbr_perf_capabilities(host_cap);
+	return test_harness_run(argc, argv);
 }
-- 
2.43.0


