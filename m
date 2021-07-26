Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A07E3D66D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jul 2021 20:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhGZSB7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jul 2021 14:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbhGZSB7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jul 2021 14:01:59 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44F6C061764
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jul 2021 11:42:27 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id r11-20020a17090a2e8bb029017382031497so12087809pjd.5
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jul 2021 11:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2LawM6kfVl+cYTN8Cs/IOkKy0EhWBmwvfyCh0la2VoY=;
        b=ruOSQgormd/VJF3tjdcNyaGq99m2WusKRu2i/csy09nhXlvQtCeYFIXPCHfMteSHxx
         cMLiNCHCF+AIKq9pg/OtYXatCjTXwZ9CqHFGFxreuj5Bz5Sn66Q3nfMZXQWa3Lwn0FyR
         bVB4uB++VyXjw3/hFoiI1J/NXjtIruL72a6zBC/uEmbKIss3mW9GwTKxh5FqTgQ5bwj7
         FzrM+o0lNSj2b2QGErHDE+X2coR3xtNGT/4WTPgyzcpCSnDXElCLAKkpuHQSCXq2a4I8
         tOuTL/fOREMljzUURo/x7NfgtLzawl6bbpTecWwITC+rupCQR04micX9FeexHMcbJ6Ny
         fNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2LawM6kfVl+cYTN8Cs/IOkKy0EhWBmwvfyCh0la2VoY=;
        b=ZxvhO/LRgxHu++RTq1ENZDjsTiHfk1HDIu4xqS/6PHTPh10PeB9utlKUUmfgnsBMsK
         JIsXsm/obPLG0sOLw2Buh1c3HEvPVdoQ57926pPvchA2Fw/Dn6Wcm8LMa7ZPJq0qjCZ9
         X8S5p2uTMRkKn9nL5U5WwQS35doa/+mXg+o0toAEN1MvwqwHIw2pFn8TlXMs1JudCwT7
         qePELOBn/tYGnbcQw7wTbsAE9z27wy1GSo9qay3AL1WceA7SU85LRAmx/kKiHdvNAI7p
         G08cP8J9ooEeX8KoRwJc2oI5BU0MG2KCYsw7Y46YbEyGAfNZLBcZglpA8jmOegUQ4LEL
         +kQw==
X-Gm-Message-State: AOAM532AQyyZpQUGVnlxM55YKKYJM9xbxKjDgJYBqwkQ1HlR83lZzb0f
        Ea7Oo+cexk9pzlgF+JGxmtX+adYfJ0slmnmVlUG9I5ct4OsgWkgGMUTqMlv7hjuXWrV4KIVvLcE
        RjksVpI90wTAeeKjYdQxw5YF6F6WLHW5pAavBIoJl5ZLWHoerHHlWva6PwA23/JxuR0H8mD+zqt
        EKdKK3R+j+
X-Google-Smtp-Source: ABdhPJw5GkG/Yjlikgw95c9LeFcdvQbm4Sc2m4K8qa/MTeJzKhlFHYP985t5JSBXqVaIX3/XkN09VOPG5ObnFoxO
X-Received: from nehir.kir.corp.google.com ([2620:15c:29:204:e222:115f:790c:cd0f])
 (user=erdemaktas job=sendgmr) by 2002:a17:90b:688:: with SMTP id
 m8mr343400pjz.45.1627324946924; Mon, 26 Jul 2021 11:42:26 -0700 (PDT)
Date:   Mon, 26 Jul 2021 11:37:55 -0700
In-Reply-To: <20210726183816.1343022-1-erdemaktas@google.com>
Message-Id: <20210726183816.1343022-3-erdemaktas@google.com>
Mime-Version: 1.0
References: <20210726183816.1343022-1-erdemaktas@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [RFC PATCH 2/4] KVM: selftest: Add helper functions to create TDX VMs
From:   Erdem Aktas <erdemaktas@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     erdemaktas@google.com, Sean Christopherson <seanjc@google.com>,
        Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Sagi Shahar <sagis@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Ben Gardon <bgardon@google.com>, Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Eric Auger <eric.auger@redhat.com>,
        Ricardo Koller <ricarkol@google.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
        Like Xu <like.xu@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE (KVM)" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

TDX requires additional IOCTLs to initialize VM and  vCPUs, to add
private memory and to finalize the VM memory. Also additional utility
functions are provided to create a guest image that will include test code.

TDX enabled VM's memory is encrypted and cannot be modified or observed
by the VMM. We need to create a guest image that includes the testing
code.

When TDX is enabled, vCPUs will enter guest mode with 32 bit mode with
paging disabled. TDX requires the CPU to run on long mode with paging
enabled. The guest image should have transition code from 32 bit to 64
bit, enable paging and run the testing code. There has to be predifined
offset values for each data structure that will be used by the guest code.
The guest image layout is as following:

| Page Tables | GDTR | GDT | Stack | Testing Code | Transition Boot Code |

Guest image will be loaded to the bottom of the first 4GB of the memory.

Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Peter Gonda <pgonda@google.com>
Reviewed-by: Marc Orr <marcorr@google.com>
Reviewed-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   5 +-
 .../selftests/kvm/include/x86_64/processor.h  |   5 +
 .../selftests/kvm/lib/x86_64/processor.c      |  23 ++
 tools/testing/selftests/kvm/lib/x86_64/tdx.h  |  89 +++++
 .../selftests/kvm/lib/x86_64/tdx_lib.c        | 314 ++++++++++++++++++
 5 files changed, 432 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index b634926e2..d84c09b5e 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -34,7 +34,7 @@ ifeq ($(ARCH),s390)
 endif
 
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c
-LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
+LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S /lib/x86_64/tdx_lib.c
 LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S
 LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
 
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index f5cb6fba6..62b26b50f 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -422,6 +422,11 @@ struct kvm_cpuid2 *kvm_get_supported_hv_cpuid(void);
 void vcpu_set_hv_cpuid(struct kvm_vm *vm, uint32_t vcpuid);
 struct kvm_cpuid2 *vcpu_get_supported_hv_cpuid(struct kvm_vm *vm, uint32_t vcpuid);
 
+void vm_vcpu_add_tdx(struct kvm_vm *vm, uint32_t vcpuid);
+
+#define __stringify_1(x) #x
+#define __stringify(x)  __stringify_1(x)
+
 /*
  * Basic CPU control in CR0
  */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index a8906e60a..d97d40fa9 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -8,6 +8,7 @@
 #include "test_util.h"
 #include "kvm_util.h"
 #include "../kvm_util_internal.h"
+#include "tdx.h"
 #include "processor.h"
 
 #ifndef NUM_INTERRUPTS
@@ -578,6 +579,28 @@ static void vcpu_setup(struct kvm_vm *vm, int vcpuid, int pgd_memslot, int gdt_m
 	vcpu_sregs_set(vm, vcpuid, &sregs);
 }
 
+/*
+ * Adds a vCPU to a TD (Trusted Domain) with minimum  defaults. It will not set
+ * up any general purpose registers as they will be initialized by the TDX. In
+ * TDX, vCPUs RIP is set to 0xFFFFFFF0. See Intel TDX EAS Section "Initial State
+ * of Guest GPRs" for more information on vCPUs initial register values when
+ * entering the TD first time.
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - The id of the VCPU to add to the VM.
+ */
+void vm_vcpu_add_tdx(struct kvm_vm *vm, uint32_t vcpuid)
+{
+	struct kvm_mp_state mp_state;
+
+	vm_vcpu_add(vm, vcpuid);
+	initialize_td_vcpu(vm, vcpuid);
+
+	mp_state.mp_state = 0;
+	vcpu_set_mp_state(vm, vcpuid, &mp_state);
+}
+
 void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
 {
 	struct kvm_mp_state mp_state;
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx.h b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
new file mode 100644
index 000000000..6e3e8384e
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef KVM_LIB_TDX_H_
+#define KVM_LIB_TDX_H_
+
+#include <kvm_util.h>
+#include "../kvm_util_internal.h"
+
+/*
+ * Max page size for the guest image.
+ */
+#define TDX_GUEST_MAX_NR_PAGES 10000
+#define PAGE_SIZE 4096
+
+/*
+ * Page Table Address used when paging is enabled.
+ */
+#define TDX_GUEST_PT_FIXED_ADDR (0xFFFFFFFF -\
+				 (TDX_GUEST_MAX_NR_PAGES * PAGE_SIZE) + 1)
+
+/*
+ * Max Page Table Size
+ * To map 4GB memory region with 2MB pages, there needs to be 1 page for PML4,
+ * 1 Page for PDPT, 4 pages for PD. Reserving 6 pages for PT.
+ */
+#define TDX_GUEST_NR_PT_PAGES (1 + 1 + 4)
+
+/*
+ * Predefined GDTR values.
+ */
+#define TDX_GUEST_GDTR_ADDR (TDX_GUEST_PT_FIXED_ADDR + (TDX_GUEST_NR_PT_PAGES *\
+							PAGE_SIZE))
+#define TDX_GUEST_GDTR_BASE (TDX_GUEST_GDTR_ADDR + PAGE_SIZE)
+#define TDX_GUEST_LINEAR_CODE64_SEL 0x38
+
+#define TDX_GUEST_STACK_NR_PAGES (3)
+#define TDX_GUEST_STACK_BASE (TDX_GUEST_GDTR_BASE + (TDX_GUEST_STACK_NR_PAGES *\
+						     PAGE_SIZE) - 1)
+/*
+ * Reserving some pages to copy the test code. This is an arbitrary number for
+ * now to simplify to guest image layout calculation.
+ * TODO: calculate the guest code dynamcially.
+ */
+#define TDX_GUEST_CODE_ENTRY (TDX_GUEST_GDTR_BASE + (TDX_GUEST_STACK_NR_PAGES *\
+						     PAGE_SIZE))
+
+#define KVM_MAX_CPUID_ENTRIES 256
+
+/*
+ * TODO: Move page attributes to processor.h file.
+ */
+#define _PAGE_PRESENT       (1UL<<0)       /* is present */
+#define _PAGE_RW            (1UL<<1)       /* writeable */
+#define _PAGE_PS            (1UL<<7)       /* page size bit*/
+
+#define TDX_TEST_PORT 0x33
+
+#define GDT_ENTRY(flags, base, limit)				\
+		((((base)  & 0xff000000ULL) << (56-24)) |	\
+		 (((flags) & 0x0000f0ffULL) << 40) |		\
+		 (((limit) & 0x000f0000ULL) << (48-16)) |	\
+		 (((base)  & 0x00ffffffULL) << 16) |		\
+		 (((limit) & 0x0000ffffULL)))
+
+struct tdx_cpuid_data {
+	struct kvm_cpuid2 cpuid;
+	struct kvm_cpuid_entry2 entries[KVM_MAX_CPUID_ENTRIES];
+};
+
+struct __packed tdx_gdtr {
+	uint16_t limit;
+	uint32_t base;
+};
+
+struct page_table {
+	uint64_t  pml4[512];
+	uint64_t  pdpt[512];
+	uint64_t  pd[4][512];
+};
+
+void add_td_memory(struct kvm_vm *vm, void *source_page,
+		   uint64_t gpa, int size);
+void finalize_td_memory(struct kvm_vm *vm);
+void initialize_td(struct kvm_vm *vm);
+void initialize_td_vcpu(struct kvm_vm *vm, uint32_t vcpuid);
+void prepare_source_image(struct kvm_vm *vm, void *guest_code,
+			  size_t guest_code_size,
+			  uint64_t guest_code_signature);
+
+#endif  // KVM_LIB_TDX_H_
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c b/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
new file mode 100644
index 000000000..03f0c3af8
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "tdx.h"
+#include <stdlib.h>
+#include <malloc.h>
+#include "processor.h"
+
+char *tdx_cmd_str[] = {
+	"KVM_TDX_CAPABILITIES",
+	"KVM_TDX_INIT_VM",
+	"KVM_TDX_INIT_VCPU",
+	"KVM_TDX_INIT_MEM_REGION",
+	"KVM_TDX_FINALIZE_VM"
+};
+
+#define TDX_MAX_CMD_STR (ARRAY_SIZE(tdx_cmd_str))
+#define EIGHT_INT3_INSTRUCTIONS 0xCCCCCCCCCCCCCCCC
+
+static void tdx_ioctl(int fd, int ioctl_no, uint32_t metadata, void *data)
+{
+	struct kvm_tdx_cmd tdx_cmd;
+	int r;
+
+	TEST_ASSERT(ioctl_no < TDX_MAX_CMD_STR, "Unknown TDX CMD : %d\n",
+		    ioctl_no);
+
+	memset(&tdx_cmd, 0x0, sizeof(tdx_cmd));
+	tdx_cmd.id = ioctl_no;
+	tdx_cmd.metadata = metadata;
+	tdx_cmd.data = (uint64_t)data;
+	r = ioctl(fd, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
+	TEST_ASSERT(r == 0, "%s failed: %d  %d", tdx_cmd_str[ioctl_no], r,
+		    errno);
+}
+
+/*
+ * Initialize a VM as a TD.
+ *
+ */
+void initialize_td(struct kvm_vm *vm)
+{
+	int ret, i;
+	struct tdx_cpuid_data cpuid_data;
+	int rc;
+
+	/* No guest VMM controlled cpuid information yet. */
+	struct kvm_tdx_init_vm init_vm;
+
+	rc = kvm_check_cap(KVM_CAP_X2APIC_API);
+	TEST_ASSERT(rc, "TDX: KVM_CAP_X2APIC_API is not supported!");
+	rc = kvm_check_cap(KVM_CAP_SPLIT_IRQCHIP);
+	TEST_ASSERT(rc, "TDX: KVM_CAP_SPLIT_IRQCHIP is not supported!");
+
+	struct kvm_enable_cap cap = {
+		.cap = KVM_CAP_X2APIC_API,
+		.args[0] = KVM_X2APIC_API_USE_32BIT_IDS |
+				KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK
+	};
+	vm_enable_cap(vm, &cap);
+	struct kvm_enable_cap cap2 = {
+		.cap = KVM_CAP_SPLIT_IRQCHIP,
+		.args[0] = 24
+	};
+	vm_enable_cap(vm, &cap2);
+
+	/* Allocate and setup memoryfor the td guest. */
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    TDX_GUEST_PT_FIXED_ADDR,
+				    0, TDX_GUEST_MAX_NR_PAGES, 0);
+
+	memset(&init_vm, 0, sizeof(init_vm));
+	memset(&cpuid_data, 0, sizeof(cpuid_data));
+	cpuid_data.cpuid.nent = KVM_MAX_CPUID_ENTRIES;
+	ret = ioctl(vm->kvm_fd, KVM_GET_SUPPORTED_CPUID, &cpuid_data);
+	TEST_ASSERT(ret == 0, "KVM_GET_SUPPORTED_CPUID failed %d %d\n",
+		    ret, errno);
+	for (i = 0; i < KVM_MAX_CPUID_ENTRIES; i++) {
+		struct kvm_cpuid_entry2 *e = &cpuid_data.entries[i];
+
+		/* Setting max VA and PA bits to 48. This will make sure that
+		 * TDX module will use 4 level SEPT structures.
+		 */
+		if (e->function == 0x80000008 && (e->index == 0)) {
+			e->eax = 0x3030;
+			break;
+		}
+	}
+	init_vm.max_vcpus = 1;
+	init_vm.attributes = 0;
+	init_vm.cpuid = (uint64_t)&cpuid_data;
+	tdx_ioctl(vm->fd, KVM_TDX_INIT_VM, 0, &init_vm);
+}
+
+
+void initialize_td_vcpu(struct kvm_vm *vm, uint32_t vcpuid)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+
+	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
+	tdx_ioctl(vcpu->fd, KVM_TDX_INIT_VCPU, 0, NULL);
+}
+
+void add_td_memory(struct kvm_vm *vm, void *source_pages,
+		   uint64_t gpa, int size)
+{
+	struct kvm_tdx_init_mem_region mem_region = {
+		.source_addr = (uint64_t)source_pages,
+		.gpa = gpa,
+		.nr_pages = size / PAGE_SIZE,
+	};
+	uint32_t metadata = KVM_TDX_MEASURE_MEMORY_REGION;
+
+	TEST_ASSERT((mem_region.nr_pages > 0) &&
+		   ((mem_region.nr_pages * PAGE_SIZE) == size),
+		   "Cannot add partial pages to the guest memory.\n");
+	TEST_ASSERT(((uint64_t)source_pages & (PAGE_SIZE - 1)) == 0,
+		    "Source memory buffer is not page aligned\n");
+	tdx_ioctl(vm->fd, KVM_TDX_INIT_MEM_REGION, metadata, &mem_region);
+}
+
+void finalize_td_memory(struct kvm_vm *vm)
+{
+	tdx_ioctl(vm->fd, KVM_TDX_FINALIZE_VM, 0, NULL);
+}
+
+void build_gdtr_table(void *gdtr_target, void *gdt_target)
+{
+	uint64_t gdt_table[] = {
+		GDT_ENTRY(0, 0, 0),              // NULL_SEL
+		GDT_ENTRY(0xc093, 0, 0xfffff),   // LINEAR_DATA32_SEL
+		GDT_ENTRY(0xc09b, 0, 0xfffff),   // LINEAR_CODE32_SEL
+		GDT_ENTRY(0, 0, 0),              // NULL_SEL
+		GDT_ENTRY(0, 0, 0),              // NULL_SEL
+		GDT_ENTRY(0, 0, 0),              // NULL_SEL
+		GDT_ENTRY(0, 0, 0),              // NULL_SEL
+		GDT_ENTRY(0xa09b, 0, 0xfffff)    // LINEAR_CODE64_SEL
+	};
+
+	struct tdx_gdtr gdtr;
+
+	gdtr.limit = sizeof(gdt_table) - 1;
+	gdtr.base = TDX_GUEST_GDTR_BASE;
+
+	memcpy(gdt_target, gdt_table, sizeof(gdt_table));
+	memcpy(gdtr_target, &gdtr, sizeof(gdtr));
+
+}
+
+
+/*
+ * Constructing 1:1 mapping for the lowest 4GB address space using 2MB pages
+ * which will be used by the TDX guest when paging is enabled.
+ * TODO: use virt_pg_map() functions to dynamically allocate the page tables.
+ */
+void build_page_tables(void *pt_target, uint64_t  pml4_base_address)
+{
+	uint64_t i;
+	struct page_table *pt;
+
+	pt = malloc(sizeof(struct page_table));
+	TEST_ASSERT(pt != NULL, "Could not allocate memory for page tables!\n");
+	memset((void *) &(pt->pml4[0]), 0, sizeof(pt->pml4));
+	memset((void *) &(pt->pdpt[0]), 0, sizeof(pt->pdpt));
+	for (i = 0; i < 4; i++)
+		memset((void *) &(pt->pd[i][0]), 0, sizeof(pt->pd[i]));
+
+	pt->pml4[0] = (pml4_base_address + PAGE_SIZE) |
+		      _PAGE_PRESENT | _PAGE_RW;
+	for (i = 0; i < 4; i++)
+		pt->pdpt[i] = (pml4_base_address + (i + 2) * PAGE_SIZE) |
+				_PAGE_PRESENT | _PAGE_RW;
+
+	uint64_t *pde = &(pt->pd[0][0]);
+
+	for (i = 0; i < sizeof(pt->pd) / sizeof(pt->pd[0][0]); i++, pde++)
+		*pde = (i << 21) | _PAGE_PRESENT | _PAGE_RW | _PAGE_PS;
+	memcpy(pt_target, pt, 6 * PAGE_SIZE);
+}
+
+static void
+__attribute__((__flatten__, section("guest_boot_section"))) guest_boot(void)
+{
+	asm volatile(" .code32\n\t;"
+		     "main_32:\n\t;"
+		     "	cli\n\t;"
+		     "	movl $" __stringify(TDX_GUEST_STACK_BASE) ", %%esp\n\t;"
+		     "	movl $" __stringify(TDX_GUEST_GDTR_ADDR) ", %%eax\n\t;"
+		     "	lgdt (%%eax)\n\t;"
+		     "	movl $0x660, %%eax\n\t;"
+		     "	movl %%eax, %%cr4\n\t;"
+		     "	movl $" __stringify(TDX_GUEST_PT_FIXED_ADDR) ", %%eax\n\t;"
+		     "	movl %%eax, %%cr3\n\t;"
+		     "	movl $0x80000023, %%eax\n\t;"
+		     "	movl %%eax, %%cr0\n\t;"
+		     "	ljmp $" __stringify(TDX_GUEST_LINEAR_CODE64_SEL)
+		     ", $" __stringify(TDX_GUEST_CODE_ENTRY) "\n\t;"
+		     /*
+		      * This is where the CPU will start running.
+		      * Do not remove any int3 instruction below.
+		      */
+		     "reset_vector:\n\t;"
+		     "	jmp main_32\n\t;"
+		     "	int3\n\t;"
+		     "	int3\n\t;"
+		     "	int3\n\t;"
+		     "	int3\n\t;"
+		     "	int3\n\t;"
+		     "	int3\n\t;"
+		     "	int3\n\t;"
+		     "	int3\n\t;"
+		     "	int3\n\t;"
+		     "	int3\n\t;"
+		     "	int3\n\t;"
+		     "	int3\n\t;"
+		     "	int3\n\t;"
+		     "	int3\n\t;"
+		     ".code64\n\t"
+		     :::"rax");
+}
+
+extern char *__start_guest_boot_section;
+extern char *__stop_guest_boot_section;
+#define GUEST_BOOT_SIZE ((uint64_t)&__stop_guest_boot_section -\
+			(uint64_t)&__start_guest_boot_section)
+
+/*
+ * Copies the guest code to the guest image. If signature value is not 0, it
+ * will verify that the guest code ends with the signature provided. We might
+ * need to check the signature to prevent compiler to add additional instruction
+ * to the end of the guest code which might create problems in some cases ie
+ * when copying code for resetvector.
+ */
+void copy_guest_code(void *target, void *guest_function, size_t code_size,
+		     uint64_t signature)
+{
+	uint64_t *end;
+
+	TEST_ASSERT((target != NULL) && (guest_function != NULL) &&
+		    (code_size > 0), "Invalid inputs to copy guest code\n");
+	if (signature) {
+		while (code_size >= sizeof(signature)) {
+			end = guest_function + code_size - sizeof(signature);
+			if (*end == signature)
+				break;
+			/* Trimming the unwanted code at the end added by
+			 * compiler. We need to add nop instruction to the
+			 * begginning of the buffer to make sure that the guest
+			 * code is aligned from the bottom and top as expected
+			 * based on the original code size. This is important
+			 * for reset vector which is copied to the bottom of
+			 * the first 4GB memory.
+			 */
+			code_size--;
+			*(unsigned char *)target = 0x90;
+			target++;
+		}
+		TEST_ASSERT(code_size >= sizeof(signature),
+			    "Guest code does not end with the signature: %lx\n"
+			    , signature);
+	}
+
+	memcpy(target, guest_function, code_size);
+}
+
+void prepare_source_image(struct kvm_vm *vm, void *guest_code,
+			  size_t guest_code_size, uint64_t guest_code_signature)
+{
+	void *source_mem, *pt_address, *code_address, *gdtr_address,
+	     *gdt_address, *guest_code_base;
+	int number_of_pages;
+
+	number_of_pages = (GUEST_BOOT_SIZE + guest_code_size) / PAGE_SIZE + 1 +
+			TDX_GUEST_NR_PT_PAGES + TDX_GUEST_STACK_NR_PAGES;
+	TEST_ASSERT(number_of_pages < TDX_GUEST_MAX_NR_PAGES,
+		    "Initial image does not fit to the memory");
+
+	source_mem = memalign(PAGE_SIZE,
+				   (TDX_GUEST_MAX_NR_PAGES * PAGE_SIZE));
+	TEST_ASSERT(source_mem != NULL,
+		    "Could not allocate memory for guest image\n");
+
+	pt_address = source_mem;
+	gdtr_address = source_mem + (TDX_GUEST_NR_PT_PAGES * PAGE_SIZE);
+	gdt_address = gdtr_address + PAGE_SIZE;
+	code_address = source_mem + (TDX_GUEST_MAX_NR_PAGES * PAGE_SIZE) -
+			GUEST_BOOT_SIZE;
+	guest_code_base =  gdt_address + (TDX_GUEST_STACK_NR_PAGES *
+					  PAGE_SIZE);
+
+	build_page_tables(pt_address, TDX_GUEST_PT_FIXED_ADDR);
+	build_gdtr_table(gdtr_address, gdt_address);
+
+	/* reset vector code should end with int3 instructions.
+	 * The unused bytes at the reset vector with int3 to trigger triple
+	 * fault shutdown if the guest manages to get into the unused code.
+	 * Using the last 8 int3 instruction as a signature to find the function
+	 * end offset for guest boot code that includes the instructions for
+	 * reset vector.
+	 * TODO: Using signature to find the exact size is a little strange but
+	 * compiler might add additional bytes to the end of the function which
+	 * makes it hard to calculate the offset addresses correctly.
+	 * Alternatively, we can construct the jmp instruction for the reset
+	 * vector manually to prevent any offset mismatch when copying the
+	 * compiler generated code.
+	 */
+	copy_guest_code(code_address, guest_boot, GUEST_BOOT_SIZE,
+			EIGHT_INT3_INSTRUCTIONS);
+	if (guest_code)
+		copy_guest_code(guest_code_base, guest_code, guest_code_size,
+				guest_code_signature);
+
+	add_td_memory(vm, source_mem, TDX_GUEST_PT_FIXED_ADDR,
+		      (TDX_GUEST_MAX_NR_PAGES * PAGE_SIZE));
+	free(source_mem);
+}
-- 
2.32.0.432.gabb21c7263-goog

