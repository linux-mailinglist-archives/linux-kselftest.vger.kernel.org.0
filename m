Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9651FD51B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jun 2020 21:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgFQTF2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jun 2020 15:05:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:48989 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgFQTF0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jun 2020 15:05:26 -0400
IronPort-SDR: rWOlf+KEPivNXjSJoSjQgPetUTvQJArbAH+Cu1LtRTozHUGKO2agV5xct5ZTp+Svr/ty8LwIgN
 AK602w/AeZtA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 12:05:10 -0700
IronPort-SDR: vJEpKL+AIa7KhEzPupD3WbOKuBWu+CYvk8p+IiV4ZdOZMRARIttvSmd3m0FmydNAtiba+osmr/
 hjQT5dpQEtyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="273609661"
Received: from gza.jf.intel.com ([10.54.75.28])
  by orsmga003.jf.intel.com with ESMTP; 17 Jun 2020 12:05:10 -0700
From:   John Andersen <john.s.andersen@intel.com>
To:     corbet@lwn.net, pbonzini@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        shuah@kernel.org, sean.j.christopherson@intel.com,
        liran.alon@oracle.com, drjones@redhat.com,
        rick.p.edgecombe@intel.com, kristen@linux.intel.com
Cc:     vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, mchehab+huawei@kernel.org,
        gregkh@linuxfoundation.org, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com, jgross@suse.com,
        mike.kravetz@oracle.com, oneukum@suse.com, luto@kernel.org,
        peterz@infradead.org, fenghua.yu@intel.com,
        reinette.chatre@intel.com, vineela.tummalapalli@intel.com,
        dave.hansen@linux.intel.com, john.s.andersen@intel.com,
        arjan@linux.intel.com, caoj.fnst@cn.fujitsu.com, bhe@redhat.com,
        nivedita@alum.mit.edu, keescook@chromium.org,
        dan.j.williams@intel.com, eric.auger@redhat.com,
        aaronlewis@google.com, peterx@redhat.com,
        makarandsonare@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH 3/4] selftests: kvm: add test for CR pinning with SMM
Date:   Wed, 17 Jun 2020 12:07:56 -0700
Message-Id: <20200617190757.27081-4-john.s.andersen@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617190757.27081-1-john.s.andersen@intel.com>
References: <20200617190757.27081-1-john.s.andersen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Check that paravirtualized control register pinning blocks modifications
of pinned CR values stored in SMRAM on exit from SMM.

Signed-off-by: John Andersen <john.s.andersen@intel.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/x86_64/processor.h  |  13 ++
 .../selftests/kvm/x86_64/smm_cr_pin_test.c    | 207 ++++++++++++++++++
 4 files changed, 222 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/smm_cr_pin_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 452787152748..c0666c3efcbb 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -10,6 +10,7 @@
 /x86_64/platform_info_test
 /x86_64/set_sregs_test
 /x86_64/smm_test
+/x86_64/smm_cr_pin_test
 /x86_64/state_test
 /x86_64/vmx_preemption_timer_test
 /x86_64/svm_vmcall_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 4a166588d99f..c5c205637f38 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -45,6 +45,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/mmio_warning_test
 TEST_GEN_PROGS_x86_64 += x86_64/platform_info_test
 TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
 TEST_GEN_PROGS_x86_64 += x86_64/smm_test
+TEST_GEN_PROGS_x86_64 += x86_64/smm_cr_pin_test
 TEST_GEN_PROGS_x86_64 += x86_64/state_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
 TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 82b7fe16a824..8a2da0449772 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -200,6 +200,11 @@ static inline uint64_t get_cr0(void)
 	return cr0;
 }
 
+static inline void set_cr0(uint64_t val)
+{
+	__asm__ __volatile__("mov %0, %%cr0" : : "r" (val) : "memory");
+}
+
 static inline uint64_t get_cr3(void)
 {
 	uint64_t cr3;
@@ -383,4 +388,12 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits);
 /* VMX_EPT_VPID_CAP bits */
 #define VMX_EPT_VPID_CAP_AD_BITS       (1ULL << 21)
 
+/* KVM MSRs */
+#define MSR_KVM_CR0_PIN_ALLOWED	0x4b564d08
+#define MSR_KVM_CR4_PIN_ALLOWED	0x4b564d09
+#define MSR_KVM_CR0_PINNED_LOW	0x4b564d0a
+#define MSR_KVM_CR0_PINNED_HIGH	0x4b564d0b
+#define MSR_KVM_CR4_PINNED_LOW	0x4b564d0c
+#define MSR_KVM_CR4_PINNED_HIGH	0x4b564d0d
+
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/x86_64/smm_cr_pin_test.c b/tools/testing/selftests/kvm/x86_64/smm_cr_pin_test.c
new file mode 100644
index 000000000000..a32f577ca1e5
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/smm_cr_pin_test.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests for control register pinning not being affected by SMRAM writes.
+ */
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <linux/stringify.h>
+
+#include "test_util.h"
+
+#include "kvm_util.h"
+
+#include "processor.h"
+
+#define VCPU_ID	      1
+
+#define PAGE_SIZE  4096
+
+#define SMRAM_SIZE 65536
+#define SMRAM_MEMSLOT ((1 << 16) | 1)
+#define SMRAM_PAGES (SMRAM_SIZE / PAGE_SIZE)
+#define SMRAM_GPA 0x1000000
+#define SMRAM_STAGE_SUCCESS 0xfe
+#define SMRAM_STAGE_FAILURE 0xfd
+
+#define XSTR(s) __stringify(s)
+
+#define SYNC_PORT 0xe
+#define DONE 0xff
+
+#define CR0_PINNED X86_CR0_WP
+#define CR4_PINNED (X86_CR4_SMAP | X86_CR4_UMIP)
+#define CR4_ALL (CR4_PINNED | X86_CR4_SMEP)
+
+/*
+ * This is compiled as normal 64-bit code, however, SMI handler is executed
+ * in real-address mode. To stay simple we're limiting ourselves to a mode
+ * independent subset of asm here.
+ * SMI handler always report back fixed stage SMRAM_STAGE_SUCCESS.
+ */
+uint8_t smi_handler_success[] = {
+	0xb0, SMRAM_STAGE_SUCCESS,    /* mov $SMRAM_STAGE_SUCCESS, %al */
+	0xe4, SYNC_PORT,              /* in $SYNC_PORT, %al */
+	0x0f, 0xaa,                   /* rsm */
+};
+uint8_t smi_handler_fault[] = {
+	0xb0, SMRAM_STAGE_FAILURE,    /* mov $SMRAM_STAGE_FAILURE, %al */
+	0xe4, SYNC_PORT,              /* in $SYNC_PORT, %al */
+	0x0f, 0xaa,                   /* rsm */
+};
+
+/* We opt not to use GUEST_SYNC() here because we also have to make a sync call
+ * from SMM. As such, the address of the ucall struct we'd need to pass isn't
+ * something we can put into the above machine code in a maintainable way
+ */
+static inline void sync_with_host(uint64_t phase)
+{
+	asm volatile("in $" XSTR(SYNC_PORT)", %%al\n"
+		     : "+a" (phase));
+}
+
+void self_smi(void)
+{
+	wrmsr(APIC_BASE_MSR + (APIC_ICR >> 4),
+	      APIC_DEST_SELF | APIC_INT_ASSERT | APIC_DM_SMI);
+}
+
+void guest_code(void)
+{
+	uint64_t apicbase = rdmsr(MSR_IA32_APICBASE);
+
+	sync_with_host(1);
+
+	wrmsr(MSR_IA32_APICBASE, apicbase | X2APIC_ENABLE);
+
+	sync_with_host(2);
+
+	set_cr0(get_cr0() | CR0_PINNED);
+
+	wrmsr(MSR_KVM_CR0_PINNED_HIGH, CR0_PINNED);
+
+	sync_with_host(3);
+
+	set_cr4(get_cr4() | CR4_PINNED);
+
+	sync_with_host(4);
+
+	/* Pin SMEP low */
+	wrmsr(MSR_KVM_CR4_PINNED_HIGH, CR4_PINNED);
+
+	sync_with_host(5);
+
+	self_smi();
+
+	sync_with_host(DONE);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_regs regs;
+	struct kvm_sregs sregs;
+	struct kvm_vm *vm;
+	struct kvm_run *run;
+	struct kvm_x86_state *state;
+	int failure, stage, stage_reported;
+	u64 *cr;
+
+	for (failure = 0; failure <= 1; failure++) {
+		stage_reported = 0;
+
+		/* Create VM */
+		vm = vm_create_default(VCPU_ID, 0, guest_code);
+
+		vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
+
+		run = vcpu_state(vm, VCPU_ID);
+
+		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, SMRAM_GPA,
+					    SMRAM_MEMSLOT, SMRAM_PAGES, 0);
+		TEST_ASSERT(vm_phy_pages_alloc(vm, SMRAM_PAGES, SMRAM_GPA, SMRAM_MEMSLOT)
+			    == SMRAM_GPA, "could not allocate guest physical addresses?");
+
+		memset(addr_gpa2hva(vm, SMRAM_GPA), 0x0, SMRAM_SIZE);
+		if (failure) {
+			memcpy(addr_gpa2hva(vm, SMRAM_GPA) + 0x8000, smi_handler_fault,
+			       sizeof(smi_handler_fault));
+		} else {
+			memcpy(addr_gpa2hva(vm, SMRAM_GPA) + 0x8000, smi_handler_success,
+			       sizeof(smi_handler_success));
+		}
+		vcpu_set_msr(vm, VCPU_ID, MSR_IA32_SMBASE, SMRAM_GPA);
+
+		for (stage = 1;; stage++) {
+			_vcpu_run(vm, VCPU_ID);
+
+			memset(&regs, 0, sizeof(regs));
+			vcpu_regs_get(vm, VCPU_ID, &regs);
+
+			memset(&sregs, 0, sizeof(sregs));
+			vcpu_sregs_get(vm, VCPU_ID, &sregs);
+
+			/* stage_reported is currrently the last stage reported */
+			if (failure && stage_reported == SMRAM_STAGE_FAILURE) {
+				/* Ensure that we exit on smram modification of CR4 */
+				TEST_ASSERT(run->exit_reason == KVM_EXIT_INTERNAL_ERROR &&
+					    run->internal.suberror == KVM_INTERNAL_ERROR_EMULATION,
+					    "Stage %d: unexpected exit reason: %u, suberror: %u (%s),\n",
+					    stage, run->exit_reason, run->internal.suberror,
+					    exit_reason_str(run->exit_reason));
+				if (run->exit_reason == KVM_EXIT_INTERNAL_ERROR)
+					goto done;
+			} else {
+				TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
+					    "Stage %d: unexpected exit reason: %u (%s),\n",
+					    stage, run->exit_reason,
+					    exit_reason_str(run->exit_reason));
+			}
+
+			stage_reported = regs.rax & 0xff;
+
+			if (stage_reported == DONE) {
+				TEST_ASSERT((sregs.cr0 & CR0_PINNED) == CR0_PINNED,
+					    "Unexpected cr0. Bits missing: %llx",
+					    sregs.cr0 ^ (CR0_PINNED | sregs.cr0));
+				TEST_ASSERT((sregs.cr4 & CR4_ALL) == CR4_PINNED,
+					    "Unexpected cr4. Bits missing: %llx, cr4: %llx",
+					    sregs.cr4 ^ (CR4_ALL | sregs.cr4),
+					    sregs.cr4);
+				goto done;
+			}
+
+			TEST_ASSERT(stage_reported == stage ||
+				    stage_reported == SMRAM_STAGE_SUCCESS ||
+				    stage_reported == SMRAM_STAGE_FAILURE,
+				    "Unexpected stage: #%x, got %x",
+				    stage, stage_reported);
+
+			/* Within SMM modify CR0/4 to not contain pinned bits. */
+			if (stage_reported == SMRAM_STAGE_FAILURE) {
+				cr = (u64 *)(addr_gpa2hva(vm, SMRAM_GPA + 0x8000 + 0x7f58));
+				*cr &= ~CR0_PINNED;
+
+				cr = (u64 *)(addr_gpa2hva(vm, SMRAM_GPA + 0x8000 + 0x7f48));
+				/* Unset pinned, set one that was pinned low */
+				*cr &= ~CR4_PINNED;
+				*cr |= X86_CR4_SMEP;
+			}
+
+			state = vcpu_save_state(vm, VCPU_ID);
+			kvm_vm_release(vm);
+			kvm_vm_restart(vm, O_RDWR);
+			vm_vcpu_add(vm, VCPU_ID);
+			vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
+			vcpu_load_state(vm, VCPU_ID, state);
+			run = vcpu_state(vm, VCPU_ID);
+			free(state);
+		}
+
+done:
+		kvm_vm_free(vm);
+	}
+}
-- 
2.21.0

