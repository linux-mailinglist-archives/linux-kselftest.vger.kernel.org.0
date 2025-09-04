Return-Path: <linux-kselftest+bounces-40750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F87FB43332
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 09:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79A6189CF82
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 07:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D942BFC9D;
	Thu,  4 Sep 2025 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jOJzRI/B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1431D2BE628
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968939; cv=none; b=tP4Gd3fd8E6egxfNYLyTR+SEc1UrdyB4xF+ljDKwybBoQgCHQlRSw14/2iMtBgDkwUi7f4um5BXmbpYehBX22nABIZiAw/K/PAe8q1rYH9oTygjO08yL6Q7lSZyl9n5cc4hs7N1am+idrpNDPztfdD6H0CQYmOQrDe0xRd7KZio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968939; c=relaxed/simple;
	bh=n5R2ZA5nD4duw34bOYSLZZY4wDHfqasy7+07P7hy0UE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OcvlDk7vOSalgLikpnDZ4n7V6cjOOSmvW10CmafEWYne5mGaWPcBPSGPTp4BBgvA1IvSj9YCF4C6xCaS2LAFYXlxjZdpdCkVfj7efWcOm7OPkVtGZQ9R8iPFns1rIWRq0MZC3YUoMhduBJWMLEaIg57MzSc0PpO+rAQqniM/fv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jOJzRI/B; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-329e0a8337bso852066a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 23:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968935; x=1757573735; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4yB9yOXY7Gz8M5J2AkG68rpmry/ggMKSfTcUt8sHdGE=;
        b=jOJzRI/BfWsq5s7ff1vcKDdyHqZUZoGAhuR0iY/PJ1OwlkQdcg5Xm+vafLj/f9kQly
         004hN2ekrmD7gcHCZmHICgaiRXvRFznTDTDxTQ2NhXjgNRizzpMptfWhYcM0sZSdAJyX
         gCLab0nOW+FmOgsof/w1JZ7XzKueeNdmAAla5q+hySBqIA3W99PZUWqbSlXLqJhF3h2g
         iNMrvVExEDKRCI99lL9uC+PmyhLqMMa7W85O7kHC1qI68a9ZxuZJme0uiX4YPAq0cfJd
         u7oJCJ8mNZ/9VI9LSUWt6VXmx47rSHOyeyKpBabuk5KSFf43PHS0v7hoc6+wVoACMDSD
         pYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968935; x=1757573735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yB9yOXY7Gz8M5J2AkG68rpmry/ggMKSfTcUt8sHdGE=;
        b=UQYfwQ/8zlhtEEWTBdK5q1flzpfFa32/hzLejGZOHcvdBNbPJoFxST6YYTANd3OMOy
         3K1Wi1w97pAsia5TM8tWkltxmilnLTBXSpCltFAOpuV3G2a605kEfxQoFggrW4pmNXL4
         KnX8ve09nGzvK3duONA6zqxaJGa/YtvXW84xtM7ai9R8uR8SpPbNubMbJKtXp0xfz8WE
         vqGy6eM5DYH3BI+0BiA13CINW1Gaw/UIS+od9S0IcJj2UtfxST4aL6vfghJs2UD3X7Ac
         MOO2ewjzO6RjCNFPZSs6vwQ1gxbPtho30oktbLNJ7jAJH2YRtBCbbG0XlVhjQQ2rQFYG
         Y/5g==
X-Gm-Message-State: AOJu0YzmUMIjB5r6xMOMXhhMWysnlQYb0h+3EPq0mrrHA9XzrfDZ/yim
	C+GZXE25EB2E4bGx11T7lOJ2eTUUnGnKAZ6q+RIW+SwI/RkygkmZPeu0bf8pZZy3HM0L6qlBoGX
	lXsKkWlJCWkGvs3qRx9hsfxPk2fOiduvGJvyj+AFRPs3DNtxz1UfqHPkf0T84ItPcSXsln7vFir
	YNawUl7GvkIVPUjd40gyJRJEbKGQ2HzV4mSkiWzxUWpCw=
X-Google-Smtp-Source: AGHT+IFpJtOTBtEH30kjlV9qshasFJ6VZRx9xb8RK+RSnnYf1AYHxgBz5mEyM5mVxSvYniQwjkKBo72C8w==
X-Received: from pjh5.prod.google.com ([2002:a17:90b:3f85:b0:325:7c49:9cce])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ecc:b0:329:e3dc:db6c
 with SMTP id 98e67ed59e1d1-329e3dcdc0bmr11848843a91.23.1756968935487; Wed, 03
 Sep 2025 23:55:35 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:54:51 -0700
In-Reply-To: <20250904065453.639610-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904065453.639610-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904065453.639610-22-sagis@google.com>
Subject: [PATCH v10 21/21] KVM: selftests: Add TDX lifecycle test
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
index 1a73e08c8437..1a76e9fa45d6 100644
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
index d5df2de81a75..a2764f5d687c 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -334,3 +334,21 @@ void vm_tdx_finalize(struct kvm_vm *vm)
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
2.51.0.338.gd7d06c2dae-goog


