Return-Path: <linux-kselftest+bounces-46219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AF5C78B57
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 12:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 698344EA7C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 11:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52BE34C826;
	Fri, 21 Nov 2025 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrhE2BdH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5D934BA24
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723505; cv=none; b=H3bTgLBDOnQzs6ghrv/Yn4IFh2zBiqoItQmMGlH+x7okfPwChGuWnkPSy6TlUOsHuVcHOvzsf9+OtPhMjB0tIGoo7HwkYwBXUrSkuRGLFahN8hA2uhoVnvsGtUTcrLjkWLHmll7BF9ypc7ihgRVFCu4OI9USxb9/O+m6bacIsP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723505; c=relaxed/simple;
	bh=xzwRLQEcrDtgwyEHwiBCiDScE8JYSDiIrumzHzd6MhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCLE2oUsjfj25xxZOmYvRhLvdVGV2zlX69fgOfb/5ljKY0pUVs3JqL0+Uee3fwa4BlDqVybtmILF0Nmg2YOrKwYeivN6+Rf49nIIRwFpl49OQoN9D8uonxeGTa8Oxhd3VqZf1nU07uxj6hgbvlF5+a41ui8ogGP5oq0R0GeHEvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrhE2BdH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso18526225e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 03:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763723498; x=1764328298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezTG0c03OD07wwSaXajwua3oK74Hbi6tRsK/GFCnf+c=;
        b=XrhE2BdHviXUAmm56XRnPdvYjEGqHBduNSlI2eOB/Lvu20CEDCOef+edGSP4GwDOKy
         lKZVfgC9Nba18T3Zm+jtjH5rAQb9BqM6PCDgjAJeXbjUe3n7VHAUzn4cANIJYKJvq9/o
         Qt3aHRk7JcsLJK3VFXfLfZj16BEEP73tbu8b6tD51Z+awE/gDV+hu3cRf368hV01/5A/
         Pu85FZGQ74vr2bH1QgmFR9owbRLrfsOXku+afUQ50C9f1lI4iOeaGY5hR8PQe9y/58BH
         mVasaTck492n+76ZE8vZ+y0KFx5hgglet5kojVBGw+4VT4dFBEeE+5QJGhrF1xQwaP/5
         fUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763723498; x=1764328298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ezTG0c03OD07wwSaXajwua3oK74Hbi6tRsK/GFCnf+c=;
        b=hQ9HT2CxeTfKYldGtecoPRObgxH1LBnSs6Z3UavFkAn8aXAb6gk5RtV8p1iatYTHSY
         XzEl5fOX1YliBvLHZqKx0UAkpBePLqmpkfd4942Dwo3Cb8g2EqtlK88MpNbXnteG+kWR
         sT4SGIbRmekEKOkxxtUqduLMO3cdmCcQ5gbNxeAMrN0KBrQ5oZBMImSIW2fNa33jwJCi
         gKTSSTi9p+vIZgNFSMm8693+Oyk6LVPhs+s786x79plYsRTYU9SUaGApwQx6HiC3ooDi
         So1X2Egn1QJZ4mHvRUYN9vkv21UrfD1bYIsI4ZZr1xFeM99cq/Va8Ktr9QXi5H53RSQj
         yOhg==
X-Forwarded-Encrypted: i=1; AJvYcCWfvTJUAL8Vl0oBVS5URZmci4RAzlheTS49tdenKYBioc5CIQpQTnvB7vYoNPNrc1a+UK9zEi7DnJsluq86nPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6EqR5RO6lLkUv0AXU64CbKordx/Y6kIS3DnxYpuyKV1Jw+3QC
	f4NT7regjp1lUT0NJbPU9KtPoivLI7Zk7FdXJ0vslasjIciSwl8Ie0nl
X-Gm-Gg: ASbGncv8EuturOEt+MpXeB0FoAuvdTESWGMW3WhG5BnXoyLCFh5qTwgbM1CAcNO4SQr
	83E1biFQGoh8J1tHnnVZaZdxrlorOM2nLlOt5/y0c5HULQeNzo2+vZBrcvcSVyMthgEL6Njba2y
	i1tZXim3qiwlACbCqntkDN7qZ++INcejC/ZkWeUxZ6DRjpV0sW6MxasvjS3HEpI4CknP2CSwbed
	lbnxhr2RQCWOxE5Pv5SJAAOVbMPPhpD4hXpAOhzklPYRJqtRJTmNrvEMkO/EH5Gm+iMsJ/xfqnG
	y5wV4CqNRAl68nLjWpGd+j1AKBdan+Tp3f5JJOguQQkT0wprtDKqgfG1/FvWD/mYIyRQ+mKUPgh
	x7u2NWe4ezLHho71cx3NWcpNgW7lKv/hqljIMnjwWkCGZCIo01IauVpeNhsHcxwQJdD1xmYoHsC
	zoxJy089khQAQkAV90gb4RH231hEc/95DcnoC1F4qzEqMeye+AAbGifPZohsutSor0AljEOJ4SD
	JMMJg+UCymkinaqSbl4SeZumFz9ePI0LEFNCnnVL00=
X-Google-Smtp-Source: AGHT+IHt/kAAQWENOHXpe3yzAVmcIXRSnXZLw0S538PHuVkTpnQN+guqXm5d++Cpovl+Y87I7qmd2Q==
X-Received: by 2002:a05:600c:354b:b0:46f:b327:ecfb with SMTP id 5b1f17b1804b1-477c0184c45mr19010215e9.9.1763723498088;
        Fri, 21 Nov 2025 03:11:38 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363e4sm10484180f8f.12.2025.11.21.03.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:11:37 -0800 (PST)
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
Subject: [PATCH v3 10/10] KVM: selftests: Add L2 vcpu context switch test
Date: Fri, 21 Nov 2025 11:11:13 +0000
Message-ID: <20251121111113.456628-11-griffoul@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121111113.456628-1-griffoul@gmail.com>
References: <20251121111113.456628-1-griffoul@gmail.com>
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
index 3431568d837e..5d47afa5789b 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -138,6 +138,7 @@ TEST_GEN_PROGS_x86 += x86/triple_fault_event_test
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


