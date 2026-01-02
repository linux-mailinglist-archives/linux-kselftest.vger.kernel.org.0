Return-Path: <linux-kselftest+bounces-48070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 980DFCEEC3C
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 15:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67AD0306FFCF
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 14:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6ED314B88;
	Fri,  2 Jan 2026 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDuPBOH3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A5A313536
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Jan 2026 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767363895; cv=none; b=LFgbdado8wwNfdvQ7Tzl3WcRDxIGiVd7Bhi/o34C6RR+p+Ullir09ckaBOX6pCZvGjXLtBWbUlJSesd635m0MQyBFaD4Pf59nJTIpNPg76jq0pYFykGwU8yUTZZJhLayLaxouNuezAifcMvinEeDsE+92daGeafwvwb5bPsKkqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767363895; c=relaxed/simple;
	bh=KpJRB2juYu75d3D+tIx1lXLGPYsLm8mJKfy+0v7vXwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fV4Mjn+0+zLUazZKPPT6qxZzkirnyQBnkmbNs+r7F5IFzPgIEdbc5M5WWBF/cBg0vbKmNhA8VbfNZGo3hlsYnQ7K+BU4G5TqCPHcQI3LqUApNpWmp4Lqt3eM2G3ygCO2r08c4/8j3Sn88B3njTMF495hdc5hX+x7HjXdUY2XF14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDuPBOH3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-430f57cd471so5726223f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 06:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767363889; x=1767968689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVJDUjOkVK2qbkQbb2Wm9TnrhlHDAfzdrRLNUPyPGwk=;
        b=iDuPBOH3lu4x6q97yV7Ij3bIgJC/yZiNPwuQKvs/GLZqmurdUd+fAtqedDa0T+S6iX
         k/oI6UhIxtrkuMXrPXqPRjqriFHPSmugk7zo5q6KB04aXjeXByM5toxY65qquxBYmlAu
         wGFI4zlUi7DsImRrBlXD8yDwFvk3ej/t6ds1CkyhM2EHxAXgUY/u0/b9s2JRvhoCuZr8
         G/1sqkaGez61IHQXLJ7WFjxh+7eQTOiaI1vayDzVqJbNbdoBcmQlJrwdqXhcXb7y8Y7W
         wNGanGCz4pine/PWNoOm0Es4mgYuVEn0HbsdhtEFkVbD7VzVQZlJPxlHkKDdyKsxaBy2
         dGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767363889; x=1767968689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zVJDUjOkVK2qbkQbb2Wm9TnrhlHDAfzdrRLNUPyPGwk=;
        b=uNcS4dO2JniSqzsrZzI9VXPyhpynsz3nqh4TUxlKEhnwqn0aBzXmb8aZWWRjqRlb25
         G5SLtI5QGVcxtGI9seJzGQwiYoaKsRt7YiB0oYZ0N3V9Z3aWK/diLaEML30rLTYcQyqe
         KxP7H29Egh7ouLKhUDfsbS65ETnstQNUrnslaXpAAH3rBumiAVOsHcsWawgcoUJSrrkl
         NuNegn1TkX9Lq/uOQnOHEUO2zf5zOV98/VxO1rUKYi4WTMH9rL/Fh5twfRMXyGszLJi+
         MwfSppj3w5eTYNoFhwpQ0jAxjyn24uFYsddB6/SvvaXAJCXkn2OZwurziEGXpFIcWHtS
         ltHA==
X-Forwarded-Encrypted: i=1; AJvYcCUyavV/w+u7b+6/I3CZjnjOuU2vfpo6htajU3hMbu3DyjMdfvvGuPzcm6zWYCStVckxSamY7BSkS/FFfXPG8ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDRwktxtgwvQ1Hk1Qx8Edh2uOignf9NQEkGPwseHSyT7YmcUb
	pOTvz73Q1j5HtBUHszhhVo9ZlabcwFnJqKlqlRx1/wWJtXrlXE3eH+pQ
X-Gm-Gg: AY/fxX58eYYWqmAsq1W6twGJ55S34Tlin+YTirHpCxAb3mUPzTe8WJ/RJo8JQSiUkiC
	owaVRDRAylMuZixgjO0lQhW97cwJFJFy4NLKYuEJATywbKQrtEuXhsXCZnBCjrfQi6qP/hHYMMJ
	yEm50gQ9L1ZAqqZ/nKaszYaZiEMBDwzCnwgPv3QxpILl2tBqOYZPdscWsHq5DzWzB60McIfLFbz
	XhncrCk7aSJl0ng4aJgizdGGfw4iOK5bmymoKGXlzKXtVkMX5y3syTz/t3tjnr9m0KdpQdTuXR3
	XthYswxBNCJLQrDlzE2Po66i8K/7QorxutrGnxOWiBZiBaJOT6DdxBp1tlWWubvGnH2zYynWsYN
	y8ejCUm6KNbSF7ltUijJBgMUXqzZ+BwNeju0UilAPWFxItakd1z4O09fKUzBBimJJU1mLZc8Lza
	+U5AcvNF54a0ZJnfueq4lNK/78XOGSl8NjUU5tvh5jlzkvDe+p7oGctC1fEkoooB6fw9keVQXdh
	UC3iAK31bSO/PyBO4bQSQnL8iFTuDpu
X-Google-Smtp-Source: AGHT+IGmMA3Ey/13njSusK/KJK8Pqej4M42la6jOKyH4c9LB6Pzf6jGOL1PftD1GAutXELNp2HIhpQ==
X-Received: by 2002:a05:600c:3e0b:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-47d19555af8mr499922545e9.10.1767363888761;
        Fri, 02 Jan 2026 06:24:48 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b0d5asm806409235e9.13.2026.01.02.06.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 06:24:48 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	vkuznets@redhat.com,
	shuah@kernel.org,
	dwmw@amazon.co.uk,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fred Griffoul <fgriffo@amazon.co.uk>
Subject: [PATCH v4 10/10] KVM: selftests: Add L2 vcpu context switch test
Date: Fri,  2 Jan 2026 14:24:29 +0000
Message-ID: <20260102142429.896101-11-griffoul@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260102142429.896101-1-griffoul@gmail.com>
References: <20260102142429.896101-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

Add selftest to validate nested VMX context switching between multiple
L2 vCPUs running on the same L1 vCPU. The test exercises both direct
VMX interface (using vmptrld/vmclear operations) and enlightened VMCS
(eVMCS) interface for Hyper-V nested scenarios.

The test creates multiple VMCS structures and switches between them to
verify that the nested_context kvm counters are correct, according to
the number of L2 vCPUs and the number of switches.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/vmx_l2_switch_test.c    | 416 ++++++++++++++++++
 2 files changed, 417 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/vmx_l2_switch_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 756c3922899b..52a1f27f0cb1 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -140,6 +140,7 @@ TEST_GEN_PROGS_x86 += x86/triple_fault_event_test
 TEST_GEN_PROGS_x86 += x86/recalc_apic_map_test
 TEST_GEN_PROGS_x86 += x86/aperfmperf_test
 TEST_GEN_PROGS_x86 += x86/vmx_apic_update_test
+TEST_GEN_PROGS_x86 += x86/vmx_l2_switch_test
 TEST_GEN_PROGS_x86 += access_tracking_perf_test
 TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/x86/vmx_l2_switch_test.c b/tools/testing/selftests/kvm/x86/vmx_l2_switch_test.c
new file mode 100644
index 000000000000..5ec0da2f8386
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/vmx_l2_switch_test.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test nested VMX context switching between multiple VMCS
+ */
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "vmx.h"
+
+#define L2_GUEST_STACK_SIZE 64
+#define L2_VCPU_MAX 16
+
+struct l2_vcpu_config {
+	vm_vaddr_t hv_pages_gva;	/* Guest VA for eVMCS */
+	vm_vaddr_t vmx_pages_gva;	/* Guest VA for VMX pages */
+	unsigned long stack[L2_GUEST_STACK_SIZE];
+	uint16_t vpid;
+};
+
+struct l1_test_config {
+	struct l2_vcpu_config l2_vcpus[L2_VCPU_MAX];
+	uint64_t hypercall_gpa;
+	uint32_t nr_l2_vcpus;
+	uint32_t nr_switches;
+	bool enable_vpid;
+	bool use_evmcs;
+	bool sched_only;
+};
+
+static void l2_guest(void)
+{
+	while (1)
+		vmcall();
+}
+
+static void run_l2_guest_evmcs(struct hyperv_test_pages *hv_pages,
+			       struct vmx_pages *vmx,
+			       void *guest_rip,
+			       void *guest_rsp,
+			       uint16_t vpid)
+{
+	GUEST_ASSERT(load_evmcs(hv_pages));
+	prepare_vmcs(vmx, guest_rip, guest_rsp);
+	current_evmcs->hv_enlightenments_control.msr_bitmap = 1;
+	vmwrite(VIRTUAL_PROCESSOR_ID, vpid);
+
+	GUEST_ASSERT(!vmlaunch());
+	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_VMCALL);
+	current_evmcs->guest_rip += 3;	/* vmcall */
+
+	GUEST_ASSERT(!vmresume());
+	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_VMCALL);
+}
+
+static void run_l2_guest_vmx_migrate(struct vmx_pages *vmx,
+				     void *guest_rip,
+				     void *guest_rsp,
+				     uint16_t vpid,
+				     bool start)
+{
+	uint32_t control;
+
+	/*
+	 * Emulate L2 vCPU migration: vmptrld/vmlaunch/vmclear
+	 */
+
+	if (start)
+		GUEST_ASSERT(load_vmcs(vmx));
+	else
+		GUEST_ASSERT(!vmptrld(vmx->vmcs_gpa));
+
+	prepare_vmcs(vmx, guest_rip, guest_rsp);
+
+	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
+	control |= CPU_BASED_USE_MSR_BITMAPS;
+	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
+	vmwrite(VIRTUAL_PROCESSOR_ID, vpid);
+
+	GUEST_ASSERT(!vmlaunch());
+	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_VMCALL);
+
+	GUEST_ASSERT(vmptrstz() == vmx->vmcs_gpa);
+	GUEST_ASSERT(!vmclear(vmx->vmcs_gpa));
+}
+
+static void run_l2_guest_vmx_sched(struct vmx_pages *vmx,
+				   void *guest_rip,
+				   void *guest_rsp,
+				   uint16_t vpid,
+				   bool start)
+{
+	/*
+	 * Emulate L2 vCPU multiplexing: vmptrld/vmresume
+	 */
+
+	if (start) {
+		uint32_t control;
+
+		GUEST_ASSERT(load_vmcs(vmx));
+		prepare_vmcs(vmx, guest_rip, guest_rsp);
+
+		control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
+		control |= CPU_BASED_USE_MSR_BITMAPS;
+		vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
+		vmwrite(VIRTUAL_PROCESSOR_ID, vpid);
+
+		GUEST_ASSERT(!vmlaunch());
+	} else {
+		GUEST_ASSERT(!vmptrld(vmx->vmcs_gpa));
+		GUEST_ASSERT(!vmresume());
+	}
+
+	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_VMCALL);
+
+	vmwrite(GUEST_RIP,
+		vmreadz(GUEST_RIP) + vmreadz(VM_EXIT_INSTRUCTION_LEN));
+}
+
+static void l1_guest_evmcs(struct l1_test_config *config)
+{
+	struct hyperv_test_pages *hv_pages;
+	struct vmx_pages *vmx_pages;
+	uint32_t i, j;
+
+	/* Initialize Hyper-V MSRs */
+	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
+	wrmsr(HV_X64_MSR_HYPERCALL, config->hypercall_gpa);
+
+	/* Enable VP assist page */
+	hv_pages = (struct hyperv_test_pages *)config->l2_vcpus[0].hv_pages_gva;
+	enable_vp_assist(hv_pages->vp_assist_gpa, hv_pages->vp_assist);
+
+	/* Enable evmcs */
+	evmcs_enable();
+
+	vmx_pages = (struct vmx_pages *)config->l2_vcpus[0].vmx_pages_gva;
+	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+
+	for (i = 0; i < config->nr_switches; i++) {
+		for (j = 0; j < config->nr_l2_vcpus; j++) {
+			struct l2_vcpu_config *l2 = &config->l2_vcpus[j];
+
+			hv_pages = (struct hyperv_test_pages *)l2->hv_pages_gva;
+			vmx_pages = (struct vmx_pages *)l2->vmx_pages_gva;
+
+			run_l2_guest_evmcs(hv_pages, vmx_pages, l2_guest,
+					   &l2->stack[L2_GUEST_STACK_SIZE],
+					   l2->vpid);
+		}
+	}
+
+	GUEST_DONE();
+}
+
+static void l1_guest_vmx(struct l1_test_config *config)
+{
+	struct vmx_pages *vmx_pages;
+	uint32_t i, j;
+
+	vmx_pages = (struct vmx_pages *)config->l2_vcpus[0].vmx_pages_gva;
+	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+
+	for (i = 0; i < config->nr_switches; i++) {
+		for (j = 0; j < config->nr_l2_vcpus; j++) {
+			struct l2_vcpu_config *l2 = &config->l2_vcpus[j];
+
+			vmx_pages = (struct vmx_pages *)l2->vmx_pages_gva;
+
+			if (config->sched_only)
+				run_l2_guest_vmx_sched(vmx_pages, l2_guest,
+						       &l2->stack[L2_GUEST_STACK_SIZE],
+						       l2->vpid, i == 0);
+			else
+				run_l2_guest_vmx_migrate(vmx_pages, l2_guest,
+							 &l2->stack[L2_GUEST_STACK_SIZE],
+							 l2->vpid, i == 0);
+		}
+	}
+
+	if (config->sched_only) {
+		for (j = 0; j < config->nr_l2_vcpus; j++) {
+			struct l2_vcpu_config *l2 = &config->l2_vcpus[j];
+
+			vmx_pages = (struct vmx_pages *)l2->vmx_pages_gva;
+			vmclear(vmx_pages->vmcs_gpa);
+		}
+	}
+
+	GUEST_DONE();
+}
+
+static void vcpu_clone_hyperv_test_pages(struct kvm_vm *vm,
+					 vm_vaddr_t src_gva,
+					 vm_vaddr_t *dst_gva)
+{
+	struct hyperv_test_pages *src, *dst;
+	vm_vaddr_t evmcs_gva;
+
+	*dst_gva = vm_vaddr_alloc_page(vm);
+
+	src = addr_gva2hva(vm, src_gva);
+	dst = addr_gva2hva(vm, *dst_gva);
+	memcpy(dst, src, sizeof(*dst));
+
+	/* Allocate a new evmcs page */
+	evmcs_gva = vm_vaddr_alloc_page(vm);
+	dst->enlightened_vmcs = (void *)evmcs_gva;
+	dst->enlightened_vmcs_hva = addr_gva2hva(vm, evmcs_gva);
+	dst->enlightened_vmcs_gpa = addr_gva2gpa(vm, evmcs_gva);
+}
+
+static void prepare_vcpu(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
+			 uint32_t nr_l2_vcpus, uint32_t nr_switches,
+			 bool enable_vpid, bool use_evmcs,
+			 bool sched_only)
+{
+	vm_vaddr_t config_gva;
+	struct l1_test_config *config;
+	vm_vaddr_t hypercall_page_gva = 0;
+	uint32_t i;
+
+	TEST_ASSERT(nr_l2_vcpus <= L2_VCPU_MAX,
+		    "Too many L2 vCPUs: %u (max %u)", nr_l2_vcpus, L2_VCPU_MAX);
+
+	/* Allocate config structure in guest memory */
+	config_gva = vm_vaddr_alloc(vm, sizeof(*config), 0x1000);
+	config = addr_gva2hva(vm, config_gva);
+	memset(config, 0, sizeof(*config));
+
+	if (use_evmcs) {
+		/* Allocate hypercall page */
+		hypercall_page_gva = vm_vaddr_alloc_page(vm);
+		memset(addr_gva2hva(vm, hypercall_page_gva), 0, getpagesize());
+		config->hypercall_gpa = addr_gva2gpa(vm, hypercall_page_gva);
+
+		/* Enable Hyper-V enlightenments */
+		vcpu_set_hv_cpuid(vcpu);
+		vcpu_enable_evmcs(vcpu);
+	}
+
+	/* Allocate resources for each L2 vCPU */
+	for (i = 0; i < nr_l2_vcpus; i++) {
+		vm_vaddr_t vmx_pages_gva;
+
+		/* Allocate VMX pages (needed for both VMX and eVMCS) */
+		vcpu_alloc_vmx(vm, &vmx_pages_gva);
+		config->l2_vcpus[i].vmx_pages_gva = vmx_pages_gva;
+
+		if (use_evmcs) {
+			vm_vaddr_t hv_pages_gva;
+
+			/* Allocate or clone hyperv_test_pages */
+			if (i == 0) {
+				vcpu_alloc_hyperv_test_pages(vm, &hv_pages_gva);
+			} else {
+				vm_vaddr_t first_hv_gva =
+				    config->l2_vcpus[0].hv_pages_gva;
+				vcpu_clone_hyperv_test_pages(vm, first_hv_gva,
+							     &hv_pages_gva);
+			}
+			config->l2_vcpus[i].hv_pages_gva = hv_pages_gva;
+		}
+
+		/* Set VPID */
+		config->l2_vcpus[i].vpid = enable_vpid ? (i + 3) : 0;
+	}
+
+	config->nr_l2_vcpus = nr_l2_vcpus;
+	config->nr_switches = nr_switches;
+	config->enable_vpid = enable_vpid;
+	config->use_evmcs = use_evmcs;
+	config->sched_only = use_evmcs ? false : sched_only;
+
+	/* Pass single pointer to config structure */
+	vcpu_args_set(vcpu, 1, config_gva);
+
+	if (use_evmcs)
+		vcpu_set_msr(vcpu, HV_X64_MSR_VP_INDEX, vcpu->id);
+}
+
+static bool opt_enable_vpid = true;
+static const char *progname;
+
+static void check_stats(struct kvm_vm *vm,
+			uint32_t nr_l2_vcpus,
+			uint32_t nr_switches,
+			bool use_evmcs,
+			bool sched_only)
+{
+	uint64_t reuse = 0;
+	uint64_t recycle = 0;
+
+	reuse = vm_get_stat(vm, nested_context_reuse);
+	recycle = vm_get_stat(vm, nested_context_recycle);
+
+	if (nr_l2_vcpus <= KVM_NESTED_OVERSUB_RATIO) {
+		GUEST_ASSERT_EQ(reuse, nr_l2_vcpus * (nr_switches - 1));
+		GUEST_ASSERT_EQ(recycle, 0);
+	} else {
+		if (sched_only) {
+			/*
+			 * When scheduling only no L2 vCPU vmcs is cleared so
+			 * we reuse up to the max. number of contexts, but we
+			 * cannot recycle any of them.
+			 */
+			GUEST_ASSERT_EQ(reuse,
+					KVM_NESTED_OVERSUB_RATIO *
+					(nr_switches - 1));
+			GUEST_ASSERT_EQ(recycle, 0);
+		} else {
+			/*
+			 * When migration we cycle in LRU order so no context
+			 * can be reused they are all recycled.
+			 */
+			GUEST_ASSERT_EQ(reuse, 0);
+			GUEST_ASSERT_EQ(recycle,
+					(nr_l2_vcpus * nr_switches) -
+					KVM_NESTED_OVERSUB_RATIO);
+		}
+	}
+
+	printf("%s %u switches with %u L2 vCPUS (%s) reuse %" PRIu64
+	       " recycle %" PRIu64 "\n", progname, nr_switches, nr_l2_vcpus,
+	       use_evmcs ? "evmcs" : (sched_only ? "vmx sched" : "vmx migrate"),
+	       reuse, recycle);
+}
+
+static void run_test(uint32_t nr_l2_vcpus, uint32_t nr_switches,
+		     bool use_evmcs, bool sched_only)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	vm = vm_create_with_one_vcpu(&vcpu, use_evmcs
+				     ? l1_guest_evmcs : l1_guest_vmx);
+
+	prepare_vcpu(vm, vcpu, nr_l2_vcpus, nr_switches,
+		     opt_enable_vpid, use_evmcs, sched_only);
+
+	for (;;) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_DONE:
+			goto done;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+		default:
+			TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
+		}
+	}
+
+done:
+	check_stats(vm, nr_l2_vcpus, nr_switches, use_evmcs, sched_only);
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	uint32_t opt_nr_l2_vcpus = 0;
+	uint32_t opt_nr_switches = 0;
+	bool opt_sched_only = true;
+	int opt;
+	int i;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
+
+	progname = argv[0];
+
+	while ((opt = getopt(argc, argv, "c:rs:v")) != -1) {
+		switch (opt) {
+		case 'c':
+			opt_nr_l2_vcpus = atoi_paranoid(optarg);
+			break;
+		case 'r':
+			opt_sched_only = false;
+			break;
+		case 's':
+			opt_nr_switches = atoi_paranoid(optarg);
+			break;
+		case 'v':
+			opt_enable_vpid = false;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (opt_nr_l2_vcpus && opt_nr_switches) {
+		run_test(opt_nr_l2_vcpus, opt_nr_switches, false,
+			 opt_sched_only);
+
+		if (kvm_has_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS))
+			run_test(opt_nr_l2_vcpus, opt_nr_switches,
+				 true, false);
+	} else {
+		/* VMX vmlaunch */
+		for (i = 2; i <= 16; i++)
+			run_test(i, 4, false, false);
+
+		/* VMX vmresume */
+		for (i = 2; i <= 16; i++)
+			run_test(i, 4, false, true);
+
+		/* eVMCS */
+		if (kvm_has_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS)) {
+			for (i = 2; i <= 16; i++)
+				run_test(i, 4, true, false);
+		}
+	}
+
+	return 0;
+}
-- 
2.43.0


