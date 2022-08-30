Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235FA5A7084
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiH3WUP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiH3WUM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:20:12 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B0F23BC2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:09 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id i191-20020a6387c8000000b0042b44ad723bso6098942pge.19
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=3HxxuVLsYM4LbX1ZJk6AwjOjKvaVUee6Ed1CIvyPobo=;
        b=ou2LC/uznCmojGsu2adFtZe9ePHLlOlZT45KWYzgyOLWJL73xJXhtKjtgBdciisqhP
         ScwjqvFEJKos9r6Y3kW0lEu9v46WdkMQY08oTqT/fxBVf5J6e4aeoD8weV0XQhbt1Bu9
         kmlglab9XdK/Qm1WvyOQ4+Ut04RZnKRS/mp/4SFwWgEL694sWRl50uxjBTB9wmILwPu+
         WTE6dn2LZe6E7SM+iM5hpIfjSpFbc8rYLhQ5oUgA8Nw/V3Oi9NHlXpcuLzvRTezzGHmI
         I7henPdIjV18lhNZ+o4e8jTb0LEzaSaPlluwdcMHBZ1PQzirZ/4uArlWNtSIHcopDC38
         agAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=3HxxuVLsYM4LbX1ZJk6AwjOjKvaVUee6Ed1CIvyPobo=;
        b=M4HgWp7+Rge/MCM/jPxkFkzI6U0sdcPl9Jg3gSLqSim4mq/i9TvF5BHivzA+VCN0mJ
         6MYhQvmP4Zh/xJX9uj11Uh9ypAlAm1o1eeyvWtkjIqkpQMQ1ndrTsvv4Mgq7SB2zXsr8
         iqTbKICjLAqfHe6FKwDelPWiqKXKv1QtK7G0p/Z81Sti0m9uF0NSBcBgMkGYhl7Nj+22
         K1P61dbE+mQGbG6AsZENU9Vdy0NhK52EACwNjQ228bMGubR9YW4yx2UZWA7KI0VNsLY7
         zF2+CGoNCTXsCIujipiBdMtUxa9ML0spG9ibsbRUJ1nIIgIBPvcea2xDnxCzC2PwKzI1
         6r2Q==
X-Gm-Message-State: ACgBeo06Tk09OnNxOZP5M5qJSs6gAfpVPmJn3yrw2+oLcoLGMdT2G20m
        aSNjWvc/uiZqjH98VNQ0WkFGk3b6TbZ+HnIO7J3EwMpAp3HxdkNJC/3ezyyvVSnUaGVPWzvd4HI
        euPv9UIA7Ues5C/ZXwPgUZmLaXy6jY0c5atSgoHzeMpTZIsM6o6nzubTjnE1cJhgnkfDJ4zs=
X-Google-Smtp-Source: AA6agR7JKD3ejKHzD2l9L7o0rtelwuqyQp4z5d7G1KXA0pvoNS1VYeQut5119tJCIi9ypTXiSbUw5mnSBw==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a63:8a4b:0:b0:42b:576a:bc2 with SMTP id
 y72-20020a638a4b000000b0042b576a0bc2mr20133311pgd.450.1661898008841; Tue, 30
 Aug 2022 15:20:08 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:19:45 +0000
In-Reply-To: <20220830222000.709028-1-sagis@google.com>
Mime-Version: 1.0
References: <20220830222000.709028-1-sagis@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220830222000.709028-3-sagis@google.com>
Subject: [RFC PATCH v2 02/17] KVM: selftest: Add helper functions to create
 TDX VMs
From:   Sagi Shahar <sagis@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Sagi Shahar <sagis@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Ryan Afranji <afranji@google.com>,
        Roger Wang <runanwang@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Ben Gardon <bgardon@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Xu <peterx@redhat.com>, Oliver Upton <oupton@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Yang Zhong <yang.zhong@intel.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Shier <pshier@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Like Xu <like.xu@linux.intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Erdem Aktas <erdemaktas@google.com>

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
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/kvm_util_base.h     |   6 +
 .../selftests/kvm/include/x86_64/processor.h  |   1 +
 .../selftests/kvm/lib/x86_64/processor.c      |  27 ++
 tools/testing/selftests/kvm/lib/x86_64/tdx.h  |  86 +++++
 .../selftests/kvm/lib/x86_64/tdx_lib.c        | 338 ++++++++++++++++++
 6 files changed, 459 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 690b499c3471..ad4d60dadc06 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -52,6 +52,7 @@ LIBKVM_x86_64 += lib/x86_64/handlers.S
 LIBKVM_x86_64 += lib/x86_64/perf_test_util.c
 LIBKVM_x86_64 += lib/x86_64/processor.c
 LIBKVM_x86_64 += lib/x86_64/svm.c
+LIBKVM_x86_64 += lib/x86_64/tdx_lib.c
 LIBKVM_x86_64 += lib/x86_64/ucall.c
 LIBKVM_x86_64 += lib/x86_64/vmx.c
 
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 2de7a7a2e56b..8d3bcf1719c6 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -653,6 +653,12 @@ static inline struct kvm_vm *vm_create_barebones(void)
 	return ____vm_create(VM_MODE_DEFAULT, 0, KVM_VM_TYPE_DEFAULT);
 }
 
+/* TDX VMs are always created with no memory and memory is added later */
+static inline struct kvm_vm *vm_create_tdx(void)
+{
+	return ____vm_create(VM_MODE_DEFAULT, 0, KVM_X86_TDX_VM);
+}
+
 static inline struct kvm_vm *vm_create(uint32_t nr_runnable_vcpus)
 {
 	return __vm_create(VM_MODE_DEFAULT, nr_runnable_vcpus, 0);
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 45edf45821d0..57bbab7d025c 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -855,6 +855,7 @@ enum pg_level {
 #define PG_SIZE_1G PG_LEVEL_SIZE(PG_LEVEL_1G)
 
 void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level);
+struct kvm_vcpu *vm_vcpu_add_tdx(struct kvm_vm *vm, uint32_t vcpu_id);
 
 /*
  * Basic CPU control in CR0
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index f35626df1dea..2a6e28c769f2 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -8,6 +8,7 @@
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
+#include "tdx.h"
 
 #ifndef NUM_INTERRUPTS
 #define NUM_INTERRUPTS 256
@@ -641,6 +642,32 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	return vcpu;
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
+struct kvm_vcpu *vm_vcpu_add_tdx(struct kvm_vm *vm, uint32_t vcpu_id)
+{
+	struct kvm_mp_state mp_state;
+	struct kvm_vcpu *vcpu;
+
+	vcpu = __vm_vcpu_add(vm, vcpu_id);
+	initialize_td_vcpu(vcpu);
+
+	/* Setup the MP state */
+	mp_state.mp_state = 0;
+	vcpu_mp_state_set(vcpu, &mp_state);
+
+	return vcpu;
+}
+
 struct kvm_vcpu *vm_arch_vcpu_recreate(struct kvm_vm *vm, uint32_t vcpu_id)
 {
 	struct kvm_vcpu *vcpu = __vm_vcpu_add(vm, vcpu_id);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx.h b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
new file mode 100644
index 000000000000..61b997dfc420
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef KVM_LIB_TDX_H_
+#define KVM_LIB_TDX_H_
+
+#include <kvm_util.h>
+#include "processor.h"
+
+/*
+ * Max page size for the guest image.
+ */
+#define TDX_GUEST_MAX_NR_PAGES 10000
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
+void initialize_td_vcpu(struct kvm_vcpu *vcpu);
+void prepare_source_image(struct kvm_vm *vm, void *guest_code,
+			  size_t guest_code_size,
+			  uint64_t guest_code_signature);
+
+#endif  // KVM_LIB_TDX_H_
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c b/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
new file mode 100644
index 000000000000..72bf2ff24a29
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/stringify.h>
+#include "asm/kvm.h"
+#include "tdx.h"
+#include <stdlib.h>
+#include <malloc.h>
+#include "processor.h"
+#include <string.h>
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
+#define XFEATURE_LBR		15
+#define XFEATURE_XTILECFG	17
+#define XFEATURE_XTILEDATA	18
+#define XFEATURE_MASK_LBR	(1 << XFEATURE_LBR)
+#define XFEATURE_MASK_XTILECFG	(1 << XFEATURE_XTILECFG)
+#define XFEATURE_MASK_XTILEDATA	(1 << XFEATURE_XTILEDATA)
+#define XFEATURE_MASK_XTILE	(XFEATURE_MASK_XTILECFG | XFEATURE_MASK_XTILEDATA)
+
+
+static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
+{
+	struct kvm_tdx_cmd tdx_cmd;
+	int r;
+
+	TEST_ASSERT(ioctl_no < TDX_MAX_CMD_STR, "Unknown TDX CMD : %d\n",
+		    ioctl_no);
+
+	memset(&tdx_cmd, 0x0, sizeof(tdx_cmd));
+	tdx_cmd.id = ioctl_no;
+	tdx_cmd.flags = flags;
+	tdx_cmd.data = (uint64_t)data;
+	r = ioctl(fd, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
+	TEST_ASSERT(r == 0, "%s failed: %d  %d", tdx_cmd_str[ioctl_no], r,
+		    errno);
+}
+
+static struct tdx_cpuid_data get_tdx_cpuid_data(struct kvm_vm *vm)
+{
+	static struct tdx_cpuid_data cpuid_data;
+	int ret, i;
+
+	if (cpuid_data.cpuid.nent)
+		return cpuid_data;
+
+	memset(&cpuid_data, 0, sizeof(cpuid_data));
+	cpuid_data.cpuid.nent = KVM_MAX_CPUID_ENTRIES;
+	ret = ioctl(vm->kvm_fd, KVM_GET_SUPPORTED_CPUID, &cpuid_data);
+	if (ret) {
+		TEST_FAIL("KVM_GET_SUPPORTED_CPUID failed %d %d\n",
+		    ret, errno);
+		cpuid_data.cpuid.nent = 0;
+		return cpuid_data;
+	}
+
+	for (i = 0; i < KVM_MAX_CPUID_ENTRIES; i++) {
+		struct kvm_cpuid_entry2 *e = &cpuid_data.entries[i];
+
+		/* TDX doesn't support LBR and AMX features yet.
+		 * Disable those bits from the XCR0 register.
+		 */
+		if (e->function == 0xd && (e->index == 0)) {
+			e->eax &= ~XFEATURE_MASK_LBR;
+			e->eax &= ~XFEATURE_MASK_XTILE;
+		}
+	}
+
+	return cpuid_data;
+}
+
+/*
+ * Initialize a VM as a TD.
+ *
+ */
+void initialize_td(struct kvm_vm *vm)
+{
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
+	vm_enable_cap(vm, KVM_CAP_X2APIC_API,
+		      KVM_X2APIC_API_USE_32BIT_IDS |
+			      KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK);
+	vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
+
+	/* Allocate and setup memoryfor the td guest. */
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    TDX_GUEST_PT_FIXED_ADDR,
+				    0, TDX_GUEST_MAX_NR_PAGES, 0);
+
+	memset(&init_vm, 0, sizeof(init_vm));
+
+	cpuid_data = get_tdx_cpuid_data(vm);
+
+	init_vm.max_vcpus = 1;
+	init_vm.attributes = 0;
+	memcpy(&init_vm.cpuid, &cpuid_data, sizeof(cpuid_data));
+	tdx_ioctl(vm->fd, KVM_TDX_INIT_VM, 0, &init_vm);
+}
+
+
+void initialize_td_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct tdx_cpuid_data cpuid_data;
+
+	cpuid_data = get_tdx_cpuid_data(vcpu->vm);
+	vcpu_init_cpuid(vcpu, (struct kvm_cpuid2 *) &cpuid_data);
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
2.37.2.789.g6183377224-goog

