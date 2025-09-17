Return-Path: <linux-kselftest+bounces-41786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B30B8207E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 23:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A69F4A32E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 21:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB3430F95A;
	Wed, 17 Sep 2025 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zf/F+8ac"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9511030F55B
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145878; cv=none; b=stZMjoayk6TXsVZeM9YS6ziVzVJ5Po3NrC8uXOo1U5JeT9H3h+2Ofi6139rLBoKVw8Ye1St2mxSyw8jfojas4UaBxa4z9uC6BkREWnSseqpLM2WlcAyAcLpNLOH4vORcQn8FWwQywSQ5YN5uTgPrLpJuLL54qEiAcA0uD6xpfAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145878; c=relaxed/simple;
	bh=ZHa0B2RyRZZWLlneOhPUdWjyzFgnqipxJK7LB4AWbX0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fuZrLuzvH27FbjpU0O3zkqg/ztB7DnFi0S9lbmqi8kgpLb4Uh83fCnkYaYQRKmIVW+ze9qim6xkFWxBDoO+N1m6MRpmwzdVRmVHhk2JgvZPLlsJj4pKXbjn5WTdjDo2L5le8uz2MZM6Kj21+Ena0R9cR/tliF0WKPw9uhGi6CZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zf/F+8ac; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-26985173d8eso2053165ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 14:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758145876; x=1758750676; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5LPrk/XrebsawKeQuGZAG8oqG4rtdkfDSdLwnedRBtY=;
        b=zf/F+8acakUrGVvkPqJBm09jHumox5HWGxK10QenjcFR/HEOUrItbbDXG1FbHQF2LU
         Yn42WGuivoJ8Es0aFhzM9LBGBXfEiSv8gs6D0/SwxsP9Ds9Q1wtpr5+r3eQ6BJkdHiLV
         62ySUy9of21fXeKV1pM3tnbIM32f66Gs4D/kyek5iLdvvN4Y+M9Yzu+wfawFA/ly7Tei
         MLcE/1AWMpNpCMUX51n+FN7afZln7UdVf5qDezlx91VPrq9VwQZ2ndPdhjWigze1wFVl
         wp7N3gyZG44e5EKUer5rqcnpjNeySjSO0ZfpFslaLNvcq/6MqiYl1CZ9aBw/fFLpH550
         ZGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758145876; x=1758750676;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5LPrk/XrebsawKeQuGZAG8oqG4rtdkfDSdLwnedRBtY=;
        b=knfDP2C1yWMxagwj0lkerlBrzx2brsSa6c6ybv9MEUU2CeICbIH7GveYKjQH50rjH7
         z5SkLN5NsHCntxd9gC+NUhbRBDtSC6ByJiBZTCpD9wjKNHarOs1WNKkIHu8CfyCAx21D
         I6YEW3sGbBAJ4BwJu/l/kbb143P/Xml1dW5CFaQNM3LMQ8v10QDyOVyzFzzriD83i6Uu
         BeNQppfB22XLEClAT8YtCrgcQEVnz2bHggkmUtDRlvzYRQDyaztOXR/ueXM6ixPYIpqw
         Wm/tZDTL26AlzETNEXNe4xKwu3bY+pmQyLoK58Z1q4LeGeiG7ozgLZvVUaUk/itPDzgn
         Hkyg==
X-Forwarded-Encrypted: i=1; AJvYcCUn/iDr3UVp+OB33e65NCyQ4nX1vSUGZ9ZcGeTMvtqmjmCKR5CHixGzOfIgguuFiJTBFkf+3qDUqtBwQJayIW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVumrepmq+z4img/3peuvNtgveey+/DElOWTT3U/R9f4tROYrw
	T+qjeX64rW+eUt+vP/BaT0egArYFDWSwd/cwN5pVcYL4f+jBsZEAOrTAs9FGOQIo+/7ibXqHHVL
	+cPDiT0xDO23iAQ==
X-Google-Smtp-Source: AGHT+IFoisWsHyss64Oz8zIvxNbXaBwzLk0hgbLNl+OnOjuMwsVc60SyjmWex22OLqE66ILVy9fzMQNhZRGkuA==
X-Received: from pjwx7.prod.google.com ([2002:a17:90a:c2c7:b0:327:d54a:8c93])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:38c7:b0:264:3519:80d0 with SMTP id d9443c01a7336-268137f8405mr45310735ad.33.1758145875970;
 Wed, 17 Sep 2025 14:51:15 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:48:40 -0700
In-Reply-To: <20250917215031.2567566-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917215031.2567566-1-jmattson@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250917215031.2567566-5-jmattson@google.com>
Subject: [PATCH 4/4] KVM: selftests: Add a VMX test for LA57 nested state
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Eric Auger <eric.auger@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a selftest that verifies KVM's ability to save and restore
nested state when the L1 guest is using 5-level paging and the L2
guest is using 4-level paging. Specifically, canonicality tests of
the VMCS12 host-state fields should accept 57-bit virtual addresses.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/vmx_la57_nested_state_test.c      | 137 ++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/vmx_la57_nested_state_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 41b40c676d7f..f1958b88ec59 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -116,6 +116,7 @@ TEST_GEN_PROGS_x86 += x86/vmx_exception_with_invalid_guest_state
 TEST_GEN_PROGS_x86 += x86/vmx_msrs_test
 TEST_GEN_PROGS_x86 += x86/vmx_invalid_nested_guest_state
 TEST_GEN_PROGS_x86 += x86/vmx_set_nested_state_test
+TEST_GEN_PROGS_x86 += x86/vmx_la57_nested_state_test
 TEST_GEN_PROGS_x86 += x86/vmx_tsc_adjust_test
 TEST_GEN_PROGS_x86 += x86/vmx_nested_tsc_scaling_test
 TEST_GEN_PROGS_x86 += x86/apic_bus_clock_test
diff --git a/tools/testing/selftests/kvm/x86/vmx_la57_nested_state_test.c b/tools/testing/selftests/kvm/x86/vmx_la57_nested_state_test.c
new file mode 100644
index 000000000000..7c3c4c1c17f6
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/vmx_la57_nested_state_test.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vmx_la57_nested_state_test
+ *
+ * Copyright (C) 2025, Google LLC.
+ *
+ * Test KVM's ability to save and restore nested state when the L1 guest
+ * is using 5-level paging and the L2 guest is using 4-level paging.
+ *
+ * This test would have failed prior to commit 9245fd6b8531 ("KVM: x86:
+ * model canonical checks more precisely").
+ */
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "vmx.h"
+
+#define LA57_GS_BASE 0xff2bc0311fb00000ull
+
+static void l2_guest_code(void)
+{
+	/*
+	 * Sync with L0 to trigger save/restore.  After
+	 * resuming, execute VMCALL to exit back to L1.
+	 */
+	GUEST_SYNC(1);
+	vmcall();
+}
+
+static void l1_guest_code(struct vmx_pages *vmx_pages)
+{
+#define L2_GUEST_STACK_SIZE 64
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	u64 guest_cr4;
+	vm_paddr_t pml5_pa, pml4_pa;
+	u64 *pml5;
+	u64 exit_reason;
+
+	/* Set GS_BASE to a value that is only canonical with LA57. */
+	wrmsr(MSR_GS_BASE, LA57_GS_BASE);
+	GUEST_ASSERT(rdmsr(MSR_GS_BASE) == LA57_GS_BASE);
+
+	GUEST_ASSERT(vmx_pages->vmcs_gpa);
+	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+	GUEST_ASSERT(load_vmcs(vmx_pages));
+
+	prepare_vmcs(vmx_pages, l2_guest_code,
+		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	/*
+	 * Set up L2 with a 4-level page table by pointing its CR3 to L1's
+	 * PML4 table and clearing CR4.LA57. This creates the CR4.LA57
+	 * mismatch that exercises the bug.
+	 */
+	pml5_pa = get_cr3() & PHYSICAL_PAGE_MASK;
+	pml5 = (u64 *)pml5_pa;
+	pml4_pa = pml5[0] & PHYSICAL_PAGE_MASK;
+	vmwrite(GUEST_CR3, pml4_pa);
+
+	guest_cr4 = vmreadz(GUEST_CR4);
+	guest_cr4 &= ~X86_CR4_LA57;
+	vmwrite(GUEST_CR4, guest_cr4);
+
+	GUEST_ASSERT(!vmlaunch());
+
+	exit_reason = vmreadz(VM_EXIT_REASON);
+	GUEST_ASSERT(exit_reason == EXIT_REASON_VMCALL);
+}
+
+void guest_code(struct vmx_pages *vmx_pages)
+{
+	if (vmx_pages)
+		l1_guest_code(vmx_pages);
+
+	GUEST_DONE();
+}
+
+int main(int argc, char *argv[])
+{
+	vm_vaddr_t vmx_pages_gva = 0;
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	struct kvm_x86_state *state;
+	struct ucall uc;
+	int stage;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_LA57));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
+
+	vm = vm_create_shape_with_one_vcpu(VM_SHAPE(VM_MODE_PXXV57_4K), &vcpu,
+					   guest_code);
+
+	/*
+	 * L1 needs to read its own PML5 table to set up L2. Identity map
+	 * the PML5 table to facilitate this.
+	 */
+	virt_map(vm, vm->pgd, vm->pgd, 1);
+
+	vcpu_alloc_vmx(vm, &vmx_pages_gva);
+	vcpu_args_set(vcpu, 1, vmx_pages_gva);
+
+	for (stage = 1;; stage++) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			/* NOT REACHED */
+		case UCALL_SYNC:
+			break;
+		case UCALL_DONE:
+			goto done;
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+
+		TEST_ASSERT(uc.args[1] == stage,
+			    "Expected stage %d, got stage %lu", stage, (ulong)uc.args[1]);
+		if (stage == 1) {
+			pr_info("L2 is active; performing save/restore.\n");
+			state = vcpu_save_state(vcpu);
+
+			kvm_vm_release(vm);
+
+			/* Restore state in a new VM. */
+			vcpu = vm_recreate_with_one_vcpu(vm);
+			vcpu_load_state(vcpu, state);
+			kvm_x86_state_cleanup(state);
+		}
+	}
+
+done:
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.51.0.470.ga7dc726c21-goog


