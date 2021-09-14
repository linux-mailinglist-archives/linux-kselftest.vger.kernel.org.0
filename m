Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5DD40B378
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 17:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbhINPuM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 11:50:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234925AbhINPuI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 11:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631634530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNFS2qgQHK2vi95uN3wusPasopF88FlnkNTthAniwNU=;
        b=RQX6ATA21Bsi5GWfqD0SOa42sbhjj+K4OzTl8t14wCWmuyCbs4fSm9XQgmyOQNqujxi6Jx
        Uxr3EtnH/UZvvGvKuoQZYDSVGI6fnrRcJI6Eqqdynaek0Yuqy0+nMEESprGSbVwt09HBB+
        CAcGaGw/w6ESaoTkJQRnfIoqLclABiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-RkpTmGzvPj-3vG4O2PY63w-1; Tue, 14 Sep 2021 11:48:49 -0400
X-MC-Unique: RkpTmGzvPj-3vG4O2PY63w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45F3B1084684;
        Tue, 14 Sep 2021 15:48:47 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD09F5C1BB;
        Tue, 14 Sep 2021 15:48:39 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Bandan Das <bsd@redhat.com>,
        linux-kernel@vger.kernel.org (open list),
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Wei Huang <wei.huang2@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        Maxim Levitsky <mlevitsk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Shuah Khan <shuah@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>
Subject: [PATCH 02/14] KVM: x86: selftests: test simultaneous uses of V_IRQ from L1 and L0
Date:   Tue, 14 Sep 2021 18:48:13 +0300
Message-Id: <20210914154825.104886-3-mlevitsk@redhat.com>
In-Reply-To: <20210914154825.104886-1-mlevitsk@redhat.com>
References: <20210914154825.104886-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test that if:

* L1 disables virtual interrupt masking, and INTR intercept.

* L1 setups a virtual interrupt to be injected to L2 and enters L2 with
  interrupts disabled, thus the virtual interrupt is pending.

* Now an external interrupt arrives in L1 and since
  L1 doesn't intercept it, it should be delivered to L2 when
  it enables interrupts.

  to do this L0 (abuses) V_IRQ to setup an
  interrupt window, and returns to L2.

* L2 enables interrupts.
  This should trigger the interrupt window,
  injection of the external interrupt and delivery
  of the virtual interrupt that can now be done.

* Test that now L2 gets those interrupts.

This is the test that demonstrates the issue that was
fixed in the previous patch.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/svm_int_ctl_test.c   | 128 ++++++++++++++++++
 3 files changed, 130 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 36896d251977..eb98958b15e4 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -23,6 +23,7 @@
 /x86_64/smm_test
 /x86_64/state_test
 /x86_64/svm_vmcall_test
+/x86_64/svm_int_ctl_test
 /x86_64/sync_regs_test
 /x86_64/tsc_msrs_test
 /x86_64/userspace_msr_exit_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index c103873531e0..3b8b143daecc 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -56,6 +56,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/smm_test
 TEST_GEN_PROGS_x86_64 += x86_64/state_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
 TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
+TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
 TEST_GEN_PROGS_x86_64 += x86_64/sync_regs_test
 TEST_GEN_PROGS_x86_64 += x86_64/userspace_msr_exit_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_apic_access_test
diff --git a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
new file mode 100644
index 000000000000..df04f56ce859
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * svm_int_ctl_test
+ *
+ * Copyright (C) 2021, Red Hat, Inc.
+ *
+ * Nested SVM testing: test simultaneous use of V_IRQ from L1 and L0.
+ */
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+#include "apic.h"
+
+#define VCPU_ID		0
+
+static struct kvm_vm *vm;
+
+bool vintr_irq_called;
+bool intr_irq_called;
+
+#define VINTR_IRQ_NUMBER 0x20
+#define INTR_IRQ_NUMBER 0x30
+
+static void vintr_irq_handler(struct ex_regs *regs)
+{
+	vintr_irq_called = true;
+}
+
+static void intr_irq_handler(struct ex_regs *regs)
+{
+	x2apic_write_reg(APIC_EOI, 0x00);
+	intr_irq_called = true;
+}
+
+static void l2_guest_code(struct svm_test_data *svm)
+{
+	/* This code raises interrupt INTR_IRQ_NUMBER in the L1's LAPIC,
+	 * and since L1 didn't enable virtual interrupt masking,
+	 * L2 should receive it and not L1.
+	 *
+	 * L2 also has virtual interrupt 'VINTR_IRQ_NUMBER' pending in V_IRQ
+	 * so it should also receive it after the following 'sti'.
+	 */
+	x2apic_write_reg(APIC_ICR,
+		APIC_DEST_SELF | APIC_INT_ASSERT | INTR_IRQ_NUMBER);
+
+	__asm__ __volatile__(
+		"sti\n"
+		"nop\n"
+	);
+
+	GUEST_ASSERT(vintr_irq_called);
+	GUEST_ASSERT(intr_irq_called);
+
+	__asm__ __volatile__(
+		"vmcall\n"
+	);
+}
+
+static void l1_guest_code(struct svm_test_data *svm)
+{
+	#define L2_GUEST_STACK_SIZE 64
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	struct vmcb *vmcb = svm->vmcb;
+
+	x2apic_enable();
+
+	/* Prepare for L2 execution. */
+	generic_svm_setup(svm, l2_guest_code,
+			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	/* No virtual interrupt masking */
+	vmcb->control.int_ctl &= ~V_INTR_MASKING_MASK;
+
+	/* No intercepts for real and virtual interrupts */
+	vmcb->control.intercept &= ~(1ULL << INTERCEPT_INTR | INTERCEPT_VINTR);
+
+	/* Make a virtual interrupt VINTR_IRQ_NUMBER pending */
+	vmcb->control.int_ctl |= V_IRQ_MASK | (0x1 << V_INTR_PRIO_SHIFT);
+	vmcb->control.int_vector = VINTR_IRQ_NUMBER;
+
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT(vmcb->control.exit_code == SVM_EXIT_VMMCALL);
+	GUEST_DONE();
+}
+
+int main(int argc, char *argv[])
+{
+	vm_vaddr_t svm_gva;
+
+	nested_svm_check_supported();
+
+	vm = vm_create_default(VCPU_ID, 0, (void *) l1_guest_code);
+
+	vm_init_descriptor_tables(vm);
+	vcpu_init_descriptor_tables(vm, VCPU_ID);
+
+	vm_install_exception_handler(vm, VINTR_IRQ_NUMBER, vintr_irq_handler);
+	vm_install_exception_handler(vm, INTR_IRQ_NUMBER, intr_irq_handler);
+
+	vcpu_alloc_svm(vm, &svm_gva);
+	vcpu_args_set(vm, VCPU_ID, 1, svm_gva);
+
+	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+	struct ucall uc;
+
+	vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
+		    "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
+		    run->exit_reason,
+		    exit_reason_str(run->exit_reason));
+
+	switch (get_ucall(vm, VCPU_ID, &uc)) {
+	case UCALL_ABORT:
+		TEST_FAIL("%s", (const char *)uc.args[0]);
+		break;
+		/* NOT REACHED */
+	case UCALL_DONE:
+		goto done;
+	default:
+		TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
+	}
+done:
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.26.3

