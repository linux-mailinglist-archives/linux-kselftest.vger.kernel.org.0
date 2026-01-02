Return-Path: <linux-kselftest+bounces-48065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 904FACEEC0F
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 15:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B92C303E67B
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 14:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE803128B4;
	Fri,  2 Jan 2026 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGbFXvKQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C832D543D
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Jan 2026 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767363887; cv=none; b=SuAcy4PlvD0LAtnhqAzwH/BjAztfMrZldbpCLLFW/m/7MH2kH/BaVW+HKQ8WfgfOfW0u8pyGZO2jnwylk76rJEYyQf16fVZVHQMammDLxWp8xGqRQB8TBTw4HC35d7U1TM2ovklKWqOWLpCjUosr6AkFiHULXfMsC8Qt2YQw5ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767363887; c=relaxed/simple;
	bh=utGhH/vBu6F5k2cy6lxebN5Dcx7bcrG5Ujf2AhisgBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdT4bCH54qmVhG0Z7wZJg5AsrKNostuU2yRe9Esatf9RoFzuuUz8mrxFvnmRSqsD9mwwZUOmI7vMOWcf9IrTqHtlut1/rN33284PzpxQ/+bu0dsj0WDnmFHkRNoldb0r56hZY/Pd978/c6m4i4ubsIwT/ia0F5G2QojpNXJ3heo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGbFXvKQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47aa03d3326so77488645e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 06:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767363882; x=1767968682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2/QLr2SXMGh8i/m+z+gs7iW0z1d9rsfY8JDpEa9am0=;
        b=eGbFXvKQcSejUP3aPee90hI6wAGMuBNqVGTek5tkIxuLUkgcNbHA+++frrV0shbp3c
         nH5Ye9jhOtbb3KrI9EVVYsa6niB7DwhFidr9fREeS9lW2WOWpdwF4wc4l4P17biee6gT
         lAf4RIUNUX/g/kWSEmAsj3RGCnQC2B/N10WhS0WRM2CALokpe9PSGKlwUpy9jFKMddcL
         v69sEoOqiRZYyWy0wghGUuN3EFI3P879GG8/ctSKgxijyjprl63wB8jcJQ76t6+3Bo5k
         eJQ5KIedlSIhBqSrr8PaPA1dJu91imjgkSZDceRQnha4GOAgvyX1ET4tz+E/KE2mI1AT
         kjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767363882; x=1767968682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C2/QLr2SXMGh8i/m+z+gs7iW0z1d9rsfY8JDpEa9am0=;
        b=p5mYwFcgnyD+pdx6gl2S9pzMaU2uPG2P/ql/8VzDCz1uA1jas60Rg67k/Z0KeYma/a
         TmBOPFntXjQ/1+DLtWCKaBBu+Ubs62f4BskF0MpOb6jjlZfAXwQjSPKGbJnfC+rDHYKT
         N2lH0eaAYy0X3B1kgK1m6+jaBvvp94ldk/vVh2a9ultoRrMZm3fd8TMk1h/6JDp759eD
         ta5ZcEDCiZ+2wUw4/HWacRjPFnNJ6cwnVqXFMl6ELr5Cl+FGVxYrBBAv0/n0hqJ/mark
         3vrLOm7iUeHPnyCnGJ+PC/D19sa3jvqTQXEDzReGNl6Rk2nrWQg+pgw0j4YYrFO/AWXK
         lErQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwu3smhK2WSTKnfhbpYMgRxJCO4+cFJo6fkqIOIit2ul0OQnUvs+Yaz22HOsldFOcezJrARpSwKemecLxFsYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTycl4/ehrOV67JC5yb5CVTm7URtoLBnzko1yLzTHnfZrnfGZ7
	kA4PRzhyfC/+ePn/Q/G/f6buvLj73oDGUQEYs96zY7Wz9OM/qjzbBlUz
X-Gm-Gg: AY/fxX436Bfkhle85Xn6YMz7Nrjbsv754Q9SHA1EpPmHWieKpojPoYiZRaa4iv08EUF
	CxKoZCLC++n/kyOC9WxYUKOoP4vw/5S+hzASFo0N7Oy9JmWo6+aD3xNR/8ULNU7LT1wWp1+oJLg
	6QiF/cYXubjxl2ky/1dPqATksEMrZhe87DkAHKuyRL76CCErG6KM5PPc+aewFppMMWv6kejbZNB
	nu7f4pVy5HoLqA475XkJF+ohmBCEhuRJE0KtTT2NvHJVOBEH5OJI2ppWT7NotCaiiohskDVwUlP
	qcvyYuoBNbXhdzdODgc7QBS+OQJ/4eApOBvmgAHMs5IKQnDs+Miu8gY9JlP5xrYSkeyIGKLz0+v
	Q484HQrYUdN4JuaGlkcZZEOkSjnLiumS0QhlLTOGmv67UafPW/+87Zb7xq73ccsyDMyRcO70OKL
	DdkZKnF/YgBrDu9yTsol0NJVYk0I2lTLFolhFAmM1dbkcDXZu0T7EqwJLDlnaFiaJwftmIE8sUN
	kERm5ucrQ6mzEEtGiXV1WvVSHKVJb2dVBrmXRGHxt0=
X-Google-Smtp-Source: AGHT+IGd8RDTTGsVA0Vf8gvH4GfAmBbqLobvhFdeVXK/Ts1lMoHCd1NR/dR723RSivgBhhsnDDetpA==
X-Received: by 2002:a05:600c:35c4:b0:475:dd9a:f791 with SMTP id 5b1f17b1804b1-47d195869e7mr582300855e9.28.1767363881747;
        Fri, 02 Jan 2026 06:24:41 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b0d5asm806409235e9.13.2026.01.02.06.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 06:24:41 -0800 (PST)
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
Subject: [PATCH v4 05/10] KVM: selftests: Add nested VMX APIC cache invalidation test
Date: Fri,  2 Jan 2026 14:24:24 +0000
Message-ID: <20260102142429.896101-6-griffoul@gmail.com>
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

Introduce selftest to verify nested VMX APIC virtualization page cache
invalidation and refresh mechanisms for pfncache implementation.

The test exercises the nested VMX APIC cache invalidation path through:

- L2 guest setup: creates a nested environment where L2 accesses the
  APIC access page that is cached by KVM using pfncache.

- Cache invalidation triggers: a separate update thread periodically
  invalidates the cached pages using either:
   - madvise(MADV_DONTNEED) to trigger MMU notifications.
   - vm_mem_region_move() to trigger memslot changes.

The test validates that:
- L2 can successfully access APIC page before and after invalidation.
- KVM properly handles cache refresh without guest-visible errors.
- Both MMU notification and memslot change invalidation paths work
  correctly.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/vmx_apic_update_test.c  | 302 ++++++++++++++++++
 2 files changed, 303 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/vmx_apic_update_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index ba5c2b643efa..756c3922899b 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -139,6 +139,7 @@ TEST_GEN_PROGS_x86 += x86/max_vcpuid_cap_test
 TEST_GEN_PROGS_x86 += x86/triple_fault_event_test
 TEST_GEN_PROGS_x86 += x86/recalc_apic_map_test
 TEST_GEN_PROGS_x86 += x86/aperfmperf_test
+TEST_GEN_PROGS_x86 += x86/vmx_apic_update_test
 TEST_GEN_PROGS_x86 += access_tracking_perf_test
 TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/x86/vmx_apic_update_test.c b/tools/testing/selftests/kvm/x86/vmx_apic_update_test.c
new file mode 100644
index 000000000000..6b2f4bf6a3e9
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/vmx_apic_update_test.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vmx_apic_update_test
+ *
+ * Copyright (C) 2025, Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * Test L2 guest APIC access page writes with concurrent MMU
+ * notification and memslot move updates.
+ */
+#include <pthread.h>
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "vmx.h"
+
+#define VAPIC_GPA	0xc0000000
+#define VAPIC_SLOT	1
+
+#define L2_GUEST_STACK_SIZE 64
+
+#define L2_DELAY	(100)
+
+static void l2_guest_code(void)
+{
+	uint32_t *vapic_addr = (uint32_t *) (VAPIC_GPA + 0x80);
+
+	/* Unroll the loop to avoid any compiler side effect */
+
+	WRITE_ONCE(*vapic_addr, 1 << 0);
+	udelay(msecs_to_usecs(L2_DELAY));
+
+	WRITE_ONCE(*vapic_addr, 1 << 1);
+	udelay(msecs_to_usecs(L2_DELAY));
+
+	WRITE_ONCE(*vapic_addr, 1 << 2);
+	udelay(msecs_to_usecs(L2_DELAY));
+
+	WRITE_ONCE(*vapic_addr, 1 << 3);
+	udelay(msecs_to_usecs(L2_DELAY));
+
+	WRITE_ONCE(*vapic_addr, 1 << 4);
+	udelay(msecs_to_usecs(L2_DELAY));
+
+	WRITE_ONCE(*vapic_addr, 1 << 5);
+	udelay(msecs_to_usecs(L2_DELAY));
+
+	WRITE_ONCE(*vapic_addr, 1 << 6);
+	udelay(msecs_to_usecs(L2_DELAY));
+
+	WRITE_ONCE(*vapic_addr, 0);
+	udelay(msecs_to_usecs(L2_DELAY));
+
+	/* Exit to L1 */
+	vmcall();
+}
+
+static void l1_guest_code(struct vmx_pages *vmx_pages)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	uint32_t control, exit_reason;
+
+	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+	GUEST_ASSERT(load_vmcs(vmx_pages));
+	prepare_vmcs(vmx_pages, l2_guest_code,
+		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	/* Enable APIC access */
+	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
+	control |= CPU_BASED_ACTIVATE_SECONDARY_CONTROLS;
+	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
+	control = vmreadz(SECONDARY_VM_EXEC_CONTROL);
+	control |= SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;
+	vmwrite(SECONDARY_VM_EXEC_CONTROL, control);
+	vmwrite(APIC_ACCESS_ADDR, VAPIC_GPA);
+
+	GUEST_SYNC1(0);
+	GUEST_ASSERT(!vmlaunch());
+again:
+	exit_reason = vmreadz(VM_EXIT_REASON);
+	if (exit_reason == EXIT_REASON_APIC_ACCESS) {
+		uint64_t guest_rip = vmreadz(GUEST_RIP);
+		uint64_t instr_len = vmreadz(VM_EXIT_INSTRUCTION_LEN);
+
+		vmwrite(GUEST_RIP, guest_rip + instr_len);
+		GUEST_ASSERT(!vmresume());
+		goto again;
+	}
+
+	GUEST_SYNC1(exit_reason);
+	GUEST_ASSERT(exit_reason == EXIT_REASON_VMCALL);
+	GUEST_DONE();
+}
+
+static const char *progname;
+static int update_period_ms = L2_DELAY / 4;
+
+struct update_control {
+	pthread_mutex_t mutex;
+	pthread_cond_t start_cond;
+	struct kvm_vm *vm;
+	bool running;
+	bool started;
+	int updates;
+};
+
+static void wait_for_start_signal(struct update_control *ctrl)
+{
+	pthread_mutex_lock(&ctrl->mutex);
+	while (!ctrl->started)
+		pthread_cond_wait(&ctrl->start_cond, &ctrl->mutex);
+
+	pthread_mutex_unlock(&ctrl->mutex);
+	printf("%s: starting update\n", progname);
+}
+
+static bool is_running(struct update_control *ctrl)
+{
+	return READ_ONCE(ctrl->running);
+}
+
+static void set_running(struct update_control *ctrl, bool running)
+{
+	WRITE_ONCE(ctrl->running, running);
+}
+
+static void signal_thread_start(struct update_control *ctrl)
+{
+	pthread_mutex_lock(&ctrl->mutex);
+	if (!ctrl->started) {
+		ctrl->started = true;
+		pthread_cond_signal(&ctrl->start_cond);
+	}
+	pthread_mutex_unlock(&ctrl->mutex);
+}
+
+static void *update_madvise(void *arg)
+{
+	struct update_control *ctrl = arg;
+	void *hva;
+
+	wait_for_start_signal(ctrl);
+
+	hva = addr_gpa2hva(ctrl->vm, VAPIC_GPA);
+	memset(hva, 0x45, ctrl->vm->page_size);
+
+	while (is_running(ctrl)) {
+		usleep(update_period_ms * 1000);
+		madvise(hva, ctrl->vm->page_size, MADV_DONTNEED);
+		ctrl->updates++;
+	}
+
+	return NULL;
+}
+
+static void *update_move_memslot(void *arg)
+{
+	struct update_control *ctrl = arg;
+	uint64_t gpa = VAPIC_GPA;
+
+	wait_for_start_signal(ctrl);
+
+	while (is_running(ctrl)) {
+		usleep(update_period_ms * 1000);
+		gpa += 0x10000;
+		vm_mem_region_move(ctrl->vm, VAPIC_SLOT, gpa);
+		ctrl->updates++;
+	}
+
+	return NULL;
+}
+
+static void run(void * (*update)(void *), const char *name)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	struct vmx_pages *vmx;
+	struct update_control ctrl;
+	struct ucall uc;
+	vm_vaddr_t vmx_pages_gva;
+	pthread_t update_thread;
+	bool done = false;
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+
+	/* Allocate VMX pages */
+	vmx = vcpu_alloc_vmx(vm, &vmx_pages_gva);
+
+	/* Allocate memory and create VAPIC memslot */
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, VAPIC_GPA,
+				    VAPIC_SLOT, 1, 0);
+
+	/* Allocate guest page table */
+	virt_map(vm, VAPIC_GPA, VAPIC_GPA, 1);
+
+	/* Set up nested EPT */
+	prepare_eptp(vmx, vm);
+	nested_map_memslot(vmx, vm, 0);
+	nested_map_memslot(vmx, vm, VAPIC_SLOT);
+	nested_map(vmx, vm, VAPIC_GPA, VAPIC_GPA, vm->page_size);
+
+	vcpu_args_set(vcpu, 1, vmx_pages_gva);
+
+	pthread_mutex_init(&ctrl.mutex, NULL);
+	pthread_cond_init(&ctrl.start_cond, NULL);
+	ctrl.vm = vm;
+	ctrl.running = true;
+	ctrl.started = false;
+	ctrl.updates = 0;
+
+	pthread_create(&update_thread, NULL, update, &ctrl);
+
+	printf("%s: running %s (tsc_khz %lu)\n", progname, name, guest_tsc_khz);
+
+	while (!done) {
+		vcpu_run(vcpu);
+
+		switch (vcpu->run->exit_reason) {
+		case KVM_EXIT_IO:
+			switch (get_ucall(vcpu, &uc)) {
+			case UCALL_SYNC:
+				printf("%s: sync(%ld)\n", progname, uc.args[0]);
+				if (uc.args[0] == 0)
+					signal_thread_start(&ctrl);
+				break;
+			case UCALL_ABORT:
+				REPORT_GUEST_ASSERT(uc);
+				/* NOT REACHED */
+			case UCALL_DONE:
+				done = true;
+				break;
+			default:
+				TEST_ASSERT(false, "Unknown ucall %lu", uc.cmd);
+			}
+			break;
+		case KVM_EXIT_MMIO:
+			/* Handle APIC MMIO access after memslot move */
+			printf
+			    ("%s: APIC MMIO access at 0x%llx (memslot move effect)\n",
+			     progname, vcpu->run->mmio.phys_addr);
+			break;
+		default:
+			TEST_FAIL("%s: Unexpected exit reason: %d (flags 0x%x)",
+				  progname,
+				  vcpu->run->exit_reason, vcpu->run->flags);
+		}
+	}
+
+	set_running(&ctrl, false);
+	if (!ctrl.started)
+		signal_thread_start(&ctrl);
+	pthread_join(update_thread, NULL);
+	printf("%s: completed with %d updates\n", progname, ctrl.updates);
+
+	pthread_mutex_destroy(&ctrl.mutex);
+	pthread_cond_destroy(&ctrl.start_cond);
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	int opt_madvise = 0;
+	int opt_memslot_move = 0;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
+	TEST_REQUIRE(kvm_cpu_has_ept());
+
+	if (argc == 1) {
+		opt_madvise = 1;
+		opt_memslot_move = 1;
+	} else {
+		int opt;
+
+		while ((opt = getopt(argc, argv, "amp:")) != -1) {
+			switch (opt) {
+			case 'a':
+				opt_madvise = 1;
+				break;
+			case 'm':
+				opt_memslot_move = 1;
+				break;
+			case 'p':
+				update_period_ms = atoi(optarg);
+				break;
+			default:
+				exit(1);
+			}
+		}
+	}
+
+	TEST_ASSERT(opt_madvise
+		    || opt_memslot_move, "No update test configured");
+
+	progname = argv[0];
+
+	if (opt_madvise)
+		run(update_madvise, "madvise");
+
+	if (opt_memslot_move)
+		run(update_move_memslot, "move memslot");
+
+	return 0;
+}
-- 
2.43.0


