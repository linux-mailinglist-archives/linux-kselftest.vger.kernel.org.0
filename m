Return-Path: <linux-kselftest+bounces-48817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F46D1606E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 01:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA1D230768DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 00:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8798C2C21C0;
	Tue, 13 Jan 2026 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4b4D5+Mm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F6F2BE64A
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264253; cv=none; b=fhbJap+J+HOrzsnmnxAl4GvSfUpTUk90Pdjddq0k+f+BF5gznZezf5qArk7VnugP9S36fUOdzv6deqmmHpbk3Yp8cEU0rSpNXMSxZ7EoM+NMuRzbSSqb9p2oGkSVBUw7ARET2VCMA1jCkobnFHaGI7EZatjodY4/vzcgBuoo7WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264253; c=relaxed/simple;
	bh=hGCiSkk2EBolZustVaOiP+LECc3YnfEYNit5uAIwZnA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XI4wRUm/HMnz2J2uByNL9L2WO2l9dZdfnOjO/4m9h9uPlTy6KWsGy2z36x9WOFISpUis504l2hdnzpXWJ1OaWGltrh8TBMu4yUBxEF72WpQCeR5kSKFt30gPGZZhbyyIFN05nSgaBkyNkZsb3pOj4+ZE5N9DvmnOgsZkXtl4Xac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4b4D5+Mm; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6097ca315bso2597069a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 16:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768264251; x=1768869051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ef4zDaW2cBltnSPT5RcXJcjwf9gVDFkqnQzUcvdCBs=;
        b=4b4D5+MmH4tmp6+7sPutfZHrisj7xyETVTpf80mRj8Rzf7I9h8VTQ8PepXURo+Nab8
         1sLHY52O0tyMYrpme3OL+HiX3Zsnx58HB7wqLEKInz4CeETteQSLX3++1LumzEHVBkp+
         2fzcRqL96YmCvG1085bjrzGX2aEsa/IXBaECChFKGlWpVjZyu1hNjSwpU40RGF7A4QU0
         td3cg/jMOTjGXI3Z+ojny37QUbVbhro1boPso/kR2qwYv4l1BpGaaUPh8qBMP0o6D+9o
         kn8TVlXS4HhW9lNtUKv16kgNZT7c+H2qdLiwUp15cIPPej5W0Qh4pmIqvsDp5/uvlnQr
         oXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768264251; x=1768869051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ef4zDaW2cBltnSPT5RcXJcjwf9gVDFkqnQzUcvdCBs=;
        b=KXaW6lL+hpr4IrrJ6JtrswLhcRmpDFQ/NqClmUJdnS8ra7Q7owLmeTUMW0QSzGX+pf
         i97jt2uylGFILlEncmD9d7CM+0nzryd0S0a9JMOS4rXeh5JT272wNHZYMXAGgHhMPwA/
         aqEAKzT20gRLD8QheOgSyWBkvbAuEqNOOo6qJr51+GT8AEedoY7RwJQ33LoMIllQA6gR
         4V9CxPlWy4ROsHlX21M7WNkPyXSXqNsP4epECAxPQPCdpNIrFQCiI7d6sWMtUXU4V9Vm
         XJqHxFkPe/oCIRQpsLWJ2U7H7ckA5yGMJW4n/tLv+7pGgWvIllGZffS9AcUPhZPD7PbF
         yU+g==
X-Forwarded-Encrypted: i=1; AJvYcCWufTx4idMQjG6pVylNSPLUb+js35UYtf945zcCO84FZQLcI+iSSIbGpC2KEyZOujK8KTzX/TajZRP2wphmOPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1udAGRFHM5+SFl4vngHcCxi3dt0r0ryc7nACOnARcGP45ne6/
	LMGt+4KjjgCu8S/vgVYQeYo5SQn/nBNLtLNoAEnSe+GPKT9ZcKmNdO5Ot01cLtb6RbMnec7lC5T
	0iF7nkfyy2OPB9g==
X-Google-Smtp-Source: AGHT+IEgCCEmGnYrWwB2pJKu0dfcPxNrazrjjw1NKn7gY3gc2LB6ZrtBhatDmWbxTyHnmyDZA7lzsMrG0hDshg==
X-Received: from pjua12.prod.google.com ([2002:a17:90a:cb8c:b0:34c:d212:cb7f])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a113:b0:35d:5d40:6d75 with SMTP id adf61e73a8af0-3898f907cd5mr17560093637.29.1768264251124;
 Mon, 12 Jan 2026 16:30:51 -0800 (PST)
Date: Mon, 12 Jan 2026 16:30:05 -0800
In-Reply-To: <20260113003016.3511895-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260113003016.3511895-1-jmattson@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260113003016.3511895-11-jmattson@google.com>
Subject: [PATCH 10/10] KVM: selftests: nSVM: Add svm_nested_pat test
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Avi Kivity <avi@redhat.com>, Alexander Graf <agraf@suse.de>, 
	"=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>, David Hildenbrand <david@kernel.org>, Cathy Avery <cavery@redhat.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Verify KVM's virtualization of the PAT MSR and--when nested NPT is
enabled--the VMCB12 g_pat field and the guest PAT register.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/svm_nested_pat_test.c   | 357 ++++++++++++++++++
 2 files changed, 358 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_pat_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 33ff81606638..27f8087eafec 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -109,6 +109,7 @@ TEST_GEN_PROGS_x86 += x86/state_test
 TEST_GEN_PROGS_x86 += x86/vmx_preemption_timer_test
 TEST_GEN_PROGS_x86 += x86/svm_vmcall_test
 TEST_GEN_PROGS_x86 += x86/svm_int_ctl_test
+TEST_GEN_PROGS_x86 += x86/svm_nested_pat_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
 TEST_GEN_PROGS_x86 += x86/tsc_scaling_sync
diff --git a/tools/testing/selftests/kvm/x86/svm_nested_pat_test.c b/tools/testing/selftests/kvm/x86/svm_nested_pat_test.c
new file mode 100644
index 000000000000..fa016e65dbf6
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/svm_nested_pat_test.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KVM nested SVM PAT test
+ *
+ * Copyright (C) 2026, Google LLC.
+ *
+ * Test that KVM correctly virtualizes the PAT MSR and VMCB g_pat field
+ * for nested SVM guests:
+ *
+ * o With nested NPT disabled:
+ *     - L1 and L2 share the same PAT
+ *     - The vmcb12.g_pat is ignored
+ * o With nested NPT enabled:
+ *     - Invalid g_pat in vmcb12 should cause VMEXIT_INVALID
+ *     - L2 should see vmcb12.g_pat via RDMSR, not L1's PAT
+ *     - L2's writes to PAT should be saved to vmcb12 on exit
+ *     - L1's PAT should be restored after #VMEXIT from L2
+ *     - State save/restore should preserve both L1's and L2's PAT values
+ */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+
+#define L2_GUEST_STACK_SIZE 256
+
+#define PAT_DEFAULT		0x0007040600070406ULL
+#define L1_PAT_VALUE		0x0007040600070404ULL  /* Change PA0 to WT */
+#define L2_VMCB12_PAT		0x0606060606060606ULL  /* All WB */
+#define L2_PAT_MODIFIED		0x0606060606060604ULL  /* Change PA0 to WT */
+#define INVALID_PAT_VALUE	0x0808080808080808ULL  /* 8 is reserved */
+
+/*
+ * Shared state between L1 and L2 for verification.
+ */
+struct pat_test_data {
+	uint64_t l2_pat_read;
+	uint64_t l2_pat_after_write;
+	uint64_t l1_pat_after_vmexit;
+	uint64_t vmcb12_gpat_after_exit;
+	bool l2_done;
+};
+
+static struct pat_test_data *pat_data;
+
+static void l2_guest_code_npt_disabled(void)
+{
+	pat_data->l2_pat_read = rdmsr(MSR_IA32_CR_PAT);
+	wrmsr(MSR_IA32_CR_PAT, L2_PAT_MODIFIED);
+	pat_data->l2_pat_after_write = rdmsr(MSR_IA32_CR_PAT);
+	pat_data->l2_done = true;
+	vmmcall();
+}
+
+static void l2_guest_code_npt_enabled(void)
+{
+	pat_data->l2_pat_read = rdmsr(MSR_IA32_CR_PAT);
+	wrmsr(MSR_IA32_CR_PAT, L2_PAT_MODIFIED);
+	pat_data->l2_pat_after_write = rdmsr(MSR_IA32_CR_PAT);
+	pat_data->l2_done = true;
+	vmmcall();
+}
+
+static void l2_guest_code_saverestoretest(void)
+{
+	pat_data->l2_pat_read = rdmsr(MSR_IA32_CR_PAT);
+
+	GUEST_SYNC(1);
+	GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), pat_data->l2_pat_read);
+
+	wrmsr(MSR_IA32_CR_PAT, L2_PAT_MODIFIED);
+	pat_data->l2_pat_after_write = rdmsr(MSR_IA32_CR_PAT);
+
+	GUEST_SYNC(2);
+	GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L2_PAT_MODIFIED);
+
+	pat_data->l2_done = true;
+	vmmcall();
+}
+
+static void l1_svm_code_npt_disabled(struct svm_test_data *svm,
+				     struct pat_test_data *data)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	struct vmcb *vmcb = svm->vmcb;
+
+	pat_data = data;
+
+	wrmsr(MSR_IA32_CR_PAT, L1_PAT_VALUE);
+	GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L1_PAT_VALUE);
+
+	generic_svm_setup(svm, l2_guest_code_npt_disabled,
+			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	vmcb->save.g_pat = L2_VMCB12_PAT;
+
+	vmcb->control.intercept &= ~(1ULL << INTERCEPT_MSR_PROT);
+
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	GUEST_ASSERT(data->l2_done);
+
+	GUEST_ASSERT_EQ(data->l2_pat_read, L1_PAT_VALUE);
+
+	GUEST_ASSERT_EQ(data->l2_pat_after_write, L2_PAT_MODIFIED);
+
+	data->l1_pat_after_vmexit = rdmsr(MSR_IA32_CR_PAT);
+	GUEST_ASSERT_EQ(data->l1_pat_after_vmexit, L2_PAT_MODIFIED);
+
+	GUEST_DONE();
+}
+
+static void l1_svm_code_invalid_gpat(struct svm_test_data *svm,
+				     struct pat_test_data *data)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	struct vmcb *vmcb = svm->vmcb;
+
+	pat_data = data;
+
+	generic_svm_setup(svm, l2_guest_code_npt_enabled,
+			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	vmcb->save.g_pat = INVALID_PAT_VALUE;
+
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_ERR);
+
+	GUEST_ASSERT(!data->l2_done);
+
+	GUEST_DONE();
+}
+
+static void l1_svm_code_npt_enabled(struct svm_test_data *svm,
+				    struct pat_test_data *data)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	struct vmcb *vmcb = svm->vmcb;
+	uint64_t l1_pat_before;
+
+	pat_data = data;
+
+	wrmsr(MSR_IA32_CR_PAT, L1_PAT_VALUE);
+	l1_pat_before = rdmsr(MSR_IA32_CR_PAT);
+	GUEST_ASSERT_EQ(l1_pat_before, L1_PAT_VALUE);
+
+	generic_svm_setup(svm, l2_guest_code_npt_enabled,
+			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	vmcb->save.g_pat = L2_VMCB12_PAT;
+
+	vmcb->control.intercept &= ~(1ULL << INTERCEPT_MSR_PROT);
+
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	GUEST_ASSERT(data->l2_done);
+
+	GUEST_ASSERT_EQ(data->l2_pat_read, L2_VMCB12_PAT);
+
+	GUEST_ASSERT_EQ(data->l2_pat_after_write, L2_PAT_MODIFIED);
+
+	data->vmcb12_gpat_after_exit = vmcb->save.g_pat;
+	GUEST_ASSERT_EQ(data->vmcb12_gpat_after_exit, L2_PAT_MODIFIED);
+
+	data->l1_pat_after_vmexit = rdmsr(MSR_IA32_CR_PAT);
+	GUEST_ASSERT_EQ(data->l1_pat_after_vmexit, L1_PAT_VALUE);
+
+	GUEST_DONE();
+}
+
+static void l1_svm_code_saverestore(struct svm_test_data *svm,
+				    struct pat_test_data *data)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	struct vmcb *vmcb = svm->vmcb;
+
+	pat_data = data;
+
+	wrmsr(MSR_IA32_CR_PAT, L1_PAT_VALUE);
+
+	generic_svm_setup(svm, l2_guest_code_saverestoretest,
+			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	vmcb->save.g_pat = L2_VMCB12_PAT;
+	vmcb->control.intercept &= ~(1ULL << INTERCEPT_MSR_PROT);
+
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	GUEST_ASSERT(data->l2_done);
+
+	GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L1_PAT_VALUE);
+
+	GUEST_ASSERT_EQ(vmcb->save.g_pat, L2_PAT_MODIFIED);
+
+	GUEST_DONE();
+}
+
+/*
+ * L2 guest code for multiple VM-entry test.
+ * On first VM-entry, read and modify PAT, then VM-exit.
+ * On second VM-entry, verify we see our modified PAT from first VM-entry.
+ */
+static void l2_guest_code_multi_vmentry(void)
+{
+	pat_data->l2_pat_read = rdmsr(MSR_IA32_CR_PAT);
+	wrmsr(MSR_IA32_CR_PAT, L2_PAT_MODIFIED);
+	pat_data->l2_pat_after_write = rdmsr(MSR_IA32_CR_PAT);
+	vmmcall();
+
+	pat_data->l2_pat_read = rdmsr(MSR_IA32_CR_PAT);
+	pat_data->l2_done = true;
+	vmmcall();
+}
+
+static void l1_svm_code_multi_vmentry(struct svm_test_data *svm,
+				      struct pat_test_data *data)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	struct vmcb *vmcb = svm->vmcb;
+
+	pat_data = data;
+
+	wrmsr(MSR_IA32_CR_PAT, L1_PAT_VALUE);
+
+	generic_svm_setup(svm, l2_guest_code_multi_vmentry,
+			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	vmcb->save.g_pat = L2_VMCB12_PAT;
+	vmcb->control.intercept &= ~(1ULL << INTERCEPT_MSR_PROT);
+
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+
+	GUEST_ASSERT_EQ(data->l2_pat_after_write, L2_PAT_MODIFIED);
+
+	GUEST_ASSERT_EQ(vmcb->save.g_pat, L2_PAT_MODIFIED);
+
+	GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L1_PAT_VALUE);
+
+	vmcb->save.rip += 3;  /* vmmcall */
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	GUEST_ASSERT(data->l2_done);
+
+	GUEST_ASSERT_EQ(data->l2_pat_read, L2_PAT_MODIFIED);
+
+	GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L1_PAT_VALUE);
+
+	GUEST_DONE();
+}
+
+static void l1_guest_code(struct svm_test_data *svm, struct pat_test_data *data,
+			  int test_num)
+{
+	switch (test_num) {
+	case 0:
+		l1_svm_code_npt_disabled(svm, data);
+		break;
+	case 1:
+		l1_svm_code_invalid_gpat(svm, data);
+		break;
+	case 2:
+		l1_svm_code_npt_enabled(svm, data);
+		break;
+	case 3:
+		l1_svm_code_saverestore(svm, data);
+		break;
+	case 4:
+		l1_svm_code_multi_vmentry(svm, data);
+		break;
+	}
+}
+
+static void run_test(int test_number, const char *test_name, bool npt_enabled,
+		     bool do_save_restore)
+{
+	struct pat_test_data *data_hva;
+	vm_vaddr_t svm_gva, data_gva;
+	struct kvm_x86_state *state;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	pr_info("Testing: %d: %s\n", test_number, test_name);
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+	if (npt_enabled)
+		vm_enable_npt(vm);
+
+	vcpu_alloc_svm(vm, &svm_gva);
+
+	data_gva = vm_vaddr_alloc_page(vm);
+	data_hva = addr_gva2hva(vm, data_gva);
+	memset(data_hva, 0, sizeof(*data_hva));
+
+	if (npt_enabled)
+		tdp_identity_map_default_memslots(vm);
+
+	vcpu_args_set(vcpu, 3, svm_gva, data_gva, test_number);
+
+	for (;;) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			/* NOT REACHED */
+		case UCALL_SYNC:
+			if (do_save_restore) {
+				pr_info("  Save/restore at sync point %ld\n",
+					uc.args[1]);
+				state = vcpu_save_state(vcpu);
+				kvm_vm_release(vm);
+				vcpu = vm_recreate_with_one_vcpu(vm);
+				vcpu_load_state(vcpu, state);
+				kvm_x86_state_cleanup(state);
+			}
+			break;
+		case UCALL_DONE:
+			pr_info("  PASSED\n");
+			kvm_vm_free(vm);
+			return;
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_NPT));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
+
+	run_test(0, "nested NPT disabled", false, false);
+
+	run_test(1, "invalid g_pat", true, false);
+
+	run_test(2, "nested NPT enabled", true, false);
+
+	run_test(3, "save/restore", true, true);
+
+	run_test(4, "multiple entries", true, false);
+
+	return 0;
+}
-- 
2.52.0.457.g6b5491de43-goog


