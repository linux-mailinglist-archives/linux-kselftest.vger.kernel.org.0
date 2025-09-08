Return-Path: <linux-kselftest+bounces-41003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48801B49C41
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 23:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DD33AC8F9
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 21:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EA0322A34;
	Mon,  8 Sep 2025 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j7KRMTbT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A350C322A32;
	Mon,  8 Sep 2025 21:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367230; cv=none; b=h4fX2mgUB2QvI7GegtUPS3kyIOYgnmWVn/69EQllTj8q2JiyZktFPVmDYU+uiKLvG4iRtjecjIGeRTJadKAS288y39FfDCW4NWRlVoejJHPzpPMKEokcImqAAePFKuyqX+ujCMJ/E2f+KY0wUC7OpXtbnVrpLcaVNqs4zJa6arg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367230; c=relaxed/simple;
	bh=cWjZ/0tujnxmnc8VcuuOQHPCItl8OhAMSkPsY3SIRCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgYi8A5FuxvmoxppEjSemmrKKzkKjIr8ZCkuxHhGmxxVgX61v3t8tv39VWQ/gD2XkTYOuWAyh1XpS82pL/FWmXclbKljm64vxaz0uBuP/9BlF2daDJO8hw7tvKic8O/ijlQqUUs/Up3Py66f67wL7H1zLQmFH+S3JYMQUxEOTkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j7KRMTbT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=YMBiXsmw3+pphIcAsuGv9ZDurAs5Mc73MEcRV/bqKLE=; b=j7KRMTbTSoct2yth0mxl6n/Dun
	WCgeohzSmkryZCDkKbfYbPpadCGiwb3cn1OZ8JKXD9PrZSkVELmfRJoZdF14k/it9ptGmiCDGkxvn
	Ivj/q2tQe9VC7ZUOi0D+vl3mPlFncfvjxMIzTGcZs+vq1zLOJOnSI+TsCNgrov6bSSiiWQG6LgNKR
	y0dZgtqtEX25ZvmtSLD0f25c+w+/ZIy7OYJny/FsDkK94j+xtASkN3C8lmVqu7kjsPbOQloo7qbG9
	kkUqvhNMXKrDuLGwznjZf+MqBmaMiO156wXKvqLtUgVVOmLkjKXdCeRb0Yq8rrvnrcoYFVMqRrdnx
	oQvrAHdQ==;
Received: from griffoul by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvjUg-0000000DOEe-3ILa;
	Mon, 08 Sep 2025 21:33:46 +0000
From: Fred Griffoul <griffoul@infradead.org>
To: kvm@vger.kernel.org
Cc: griffoul@gmail.com,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 5/5] KVM: selftests: Add nested VMX APIC cache invalidation test
Date: Mon,  8 Sep 2025 22:32:30 +0100
Message-ID: <20250908213241.3189113-6-griffoul@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908213241.3189113-1-griffoul@infradead.org>
References: <20250908213241.3189113-1-griffoul@infradead.org>
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
index 90f03f00cb04..5d4505c7f6f0 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -136,6 +136,7 @@ TEST_GEN_PROGS_x86 += x86/max_vcpuid_cap_test
 TEST_GEN_PROGS_x86 += x86/triple_fault_event_test
 TEST_GEN_PROGS_x86 += x86/recalc_apic_map_test
 TEST_GEN_PROGS_x86 += x86/aperfmperf_test
+TEST_GEN_PROGS_x86 += x86/vmx_apic_update_test
 TEST_GEN_PROGS_x86 += access_tracking_perf_test
 TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/x86/vmx_apic_update_test.c b/tools/testing/selftests/kvm/x86/vmx_apic_update_test.c
new file mode 100644
index 000000000000..22f82cf6dd0c
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/vmx_apic_update_test.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vmx_apic_update_test
+ *
+ * Copyright (C) 2025, mazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * Test L2 guest APIC access page writes with concurrent MMU
+ * notifications and memslot move updates.
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
+	prepare_eptp(vmx, vm, 0);
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
2.51.0


