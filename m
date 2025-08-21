Return-Path: <linux-kselftest+bounces-39453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4A7B2ED04
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 06:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1C21B60EE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 04:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21C82EE608;
	Thu, 21 Aug 2025 04:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xHkkvJuk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE72ED843
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 04:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750595; cv=none; b=RovpSyi1gzRJI8OenHixkL7dij4gZpN7vuTdnV80nvBlO14wg9IZOsastlZ9gU83BpsSOs5vkQaKzcY9XtV6BiAYAUcpaDyFKlUQyjC7B+T5/Csd/0chbIOkLBv2mgRh7Ha74y0Bcok6SZ3goT9DX6MvwnIFhOhW1iEzwbWnATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750595; c=relaxed/simple;
	bh=SCj5vpqbGdcyeL9WchYjYHXxlh3Syca50DvMtgJYdEE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BooDo2/u2e8q3xy5IBHah/3VkMHpg7Ac1/RhNiKssQSk8Wk97NZ7RtNrrVcQ73L5xotpdSirwU9f4z4BoLKrmIlrRdC2466SFmVikbK8+iZzPnmYw5xEWqS5b7fEXfiOBNJoykSjYsl6KHGOv+rrTU/+I4CsdBUtAhYTIpGyy0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xHkkvJuk; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47174c667aso477267a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 21:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750593; x=1756355393; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ni6/1QBXYyjIXVNXrHE6sKBQ7BBSjz5QhIiIQ0TLw0=;
        b=xHkkvJukcRVlHvRycT/ROvRXkIL7mR6QvpK1rfBUxGtjiMXJQ+gp7UoLPne9V2sgfc
         pIBF60lr+mGD+aOPUPZ4FuqmuNFJrmZiCNft3lLeRrExJQ+vCUKEvzEZ+PgjY78mi0rl
         lidPQzu9/HT2JT6vZwBKmFR5m1kfEcWyvfzSOFfBSYPw/xuWvcSikJjBllWwvDlbVacQ
         CHsojMId5NmA6NApGObogY850w17RjYrR9HuridwyzjLjKdkMTPt5GvFSaFTxjsD6puE
         lm9VitWq70oqwpVZn3yshVewjmXg/rVN6iYbAPSs8Ra5/Ba+Y+TDBXcccZOKW79vA6a1
         3g0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750593; x=1756355393;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ni6/1QBXYyjIXVNXrHE6sKBQ7BBSjz5QhIiIQ0TLw0=;
        b=Z2HVpNA0tElZD5gm7twP8fbi+rn+qB364FDOLv9//9WHi/mboCDSK0hN4qfdeaYAEs
         HwdhWwVkz8rfImpg3MXJpfgwZTfkpuNuiDIEmvBoXGc0GcpTfYLLjNNmXDPGWfB3BNz9
         nS7d/Y7xn44muYxQ34P57zuab8ud/TLQLTixF8I/jY/pa/V0UNLV2t2tlj7HXUsUiQoA
         KMQwalV9kUwOr73iOEYCkB4jSmeYOU9EIj0vAH3K7b9t4U2Q3BFA+Il03YqgfWunqD8K
         kClJ4c0c9Hv5TosCVTsEttlSNRIg5nNM434ynDbKME8ozHpRzaIwuHz7Nz0Ds1vGkt7M
         z2Hw==
X-Gm-Message-State: AOJu0YwbwZJAJ6FRSAWzibCBuQ50R0daNWrba38kH57V/r5ZUGwee+Xr
	8MFXN35fUr+wyiYTX6141PMHldBMlCt6xASAAEsGyLsjEE25AKblbDDftMME71pzuRIXDFQcaNZ
	DRlLmyug0oWTrA2HvMDztSHcy0fRUAbQyM8ravg9n6UFxK3UC9YgRn/6BN8sXxri6SZcDZ2XGWK
	KSLDZxicIC5un5WZ2uX+hl1O14ZMSXtKKssnp7YdULaA0=
X-Google-Smtp-Source: AGHT+IF47pIKGfWNf380vL880YXdNEf+FWPdQExp1mJvaZsLgHJ8I4ZDENH3hqy/aqETue6DuLS1LEQ09w==
X-Received: from pgbdp6.prod.google.com ([2002:a05:6a02:f06:b0:b47:61f6:dd10])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734a:b0:240:30c:276a
 with SMTP id adf61e73a8af0-24330aa5c52mr1472690637.39.1755750592600; Wed, 20
 Aug 2025 21:29:52 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:29:12 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-20-sagis@google.com>
Subject: [PATCH v9 19/19] KVM: selftests: Add TDX lifecycle test
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

Adding a test to verify TDX lifecycle by creating a simple TD.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h  | 10 ++++++
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 18 +++++++++++
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 31 +++++++++++++++++++
 4 files changed, 60 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/tdx_vm_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 8d1aaebd746e..86c101fbe1a0 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -155,6 +155,7 @@ TEST_GEN_PROGS_x86 += rseq_test
 TEST_GEN_PROGS_x86 += steal_time
 TEST_GEN_PROGS_x86 += system_counter_offset_test
 TEST_GEN_PROGS_x86 += pre_fault_memory_test
+TEST_GEN_PROGS_x86 += x86/tdx_vm_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index 2467b6c35557..775ca249f74d 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -11,6 +11,14 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
 	return vm->type == KVM_X86_TDX_VM;
 }
 
+/*
+ * Verify that TDX is supported by KVM.
+ */
+static inline bool is_tdx_enabled(void)
+{
+	return !!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_TDX_VM));
+}
+
 /*
  * TDX ioctls
  */
@@ -72,5 +80,7 @@ void vm_tdx_load_vcpu_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
 void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
 
 void vm_tdx_finalize(struct kvm_vm *vm);
+struct kvm_vm *vm_tdx_create_with_one_vcpu(void *guest_code,
+					   struct kvm_vcpu **vcpu);
 
 #endif // SELFTESTS_TDX_TDX_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index 4024587ed3c2..8b18f1a8da62 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -371,3 +371,21 @@ void vm_tdx_finalize(struct kvm_vm *vm)
 	load_td_private_memory(vm);
 	vm_tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
 }
+
+struct kvm_vm *vm_tdx_create_with_one_vcpu(void *guest_code,
+					   struct kvm_vcpu **vcpu)
+{
+	struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = KVM_X86_TDX_VM,
+	};
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpus[1];
+
+	vm = __vm_create_with_vcpus(shape, 1, 0, guest_code, vcpus);
+	*vcpu = vcpus[0];
+
+	vm_tdx_finalize(vm);
+
+	return vm;
+}
diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
new file mode 100644
index 000000000000..a9ee489eea1a
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "kvm_util.h"
+#include "tdx/tdx_util.h"
+#include "ucall_common.h"
+#include "kselftest_harness.h"
+
+static void guest_code_lifecycle(void)
+{
+	GUEST_DONE();
+}
+
+TEST(verify_td_lifecycle)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	vm = vm_tdx_create_with_one_vcpu(guest_code_lifecycle, &vcpu);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_DONE);
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char **argv)
+{
+	TEST_REQUIRE(is_tdx_enabled());
+	return test_harness_run(argc, argv);
+}
-- 
2.51.0.rc1.193.gad69d77794-goog


