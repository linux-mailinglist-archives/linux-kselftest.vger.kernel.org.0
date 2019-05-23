Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAFB92841F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 18:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbfEWQni (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 12:43:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731374AbfEWQnh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 12:43:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25647300C035;
        Thu, 23 May 2019 16:43:37 +0000 (UTC)
Received: from thuth.com (ovpn-116-94.ams2.redhat.com [10.36.116.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1EB0643E1;
        Thu, 23 May 2019 16:43:32 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 6/9] KVM: selftests: Add processor code for s390x
Date:   Thu, 23 May 2019 18:43:06 +0200
Message-Id: <20190523164309.13345-7-thuth@redhat.com>
In-Reply-To: <20190523164309.13345-1-thuth@redhat.com>
References: <20190523164309.13345-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 23 May 2019 16:43:37 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Code that takes care of basic CPU setup, page table walking, etc.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/s390x/processor.h   |  22 ++
 .../selftests/kvm/lib/s390x/processor.c       | 286 ++++++++++++++++++
 4 files changed, 310 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/s390x/processor.h
 create mode 100644 tools/testing/selftests/kvm/lib/s390x/processor.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cfbea4ce575..c05aa32dfbbe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8663,6 +8663,7 @@ F:	arch/s390/include/asm/gmap.h
 F:	arch/s390/include/asm/kvm*
 F:	arch/s390/kvm/
 F:	arch/s390/mm/gmap.c
+F:	tools/testing/selftests/kvm/*/s390x/
 
 KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)
 M:	Paolo Bonzini <pbonzini@redhat.com>
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 79c524395ebe..8495670ad107 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -9,6 +9,7 @@ UNAME_M := $(shell uname -m)
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/ucall.c lib/sparsebit.c
 LIBKVM_x86_64 = lib/x86_64/processor.c lib/x86_64/vmx.c
 LIBKVM_aarch64 = lib/aarch64/processor.c
+LIBKVM_s390x = lib/s390x/processor.c
 
 TEST_GEN_PROGS_x86_64 = x86_64/platform_info_test
 TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
diff --git a/tools/testing/selftests/kvm/include/s390x/processor.h b/tools/testing/selftests/kvm/include/s390x/processor.h
new file mode 100644
index 000000000000..e0e96a5f608c
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/s390x/processor.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * s390x processor specific defines
+ */
+#ifndef SELFTEST_KVM_PROCESSOR_H
+#define SELFTEST_KVM_PROCESSOR_H
+
+/* Bits in the region/segment table entry */
+#define REGION_ENTRY_ORIGIN	~0xfffUL /* region/segment table origin	   */
+#define REGION_ENTRY_PROTECT	0x200	 /* region protection bit	   */
+#define REGION_ENTRY_NOEXEC	0x100	 /* region no-execute bit	   */
+#define REGION_ENTRY_OFFSET	0xc0	 /* region table offset		   */
+#define REGION_ENTRY_INVALID	0x20	 /* invalid region table entry	   */
+#define REGION_ENTRY_TYPE	0x0c	 /* region/segment table type mask */
+#define REGION_ENTRY_LENGTH	0x03	 /* region third length		   */
+
+/* Bits in the page table entry */
+#define PAGE_INVALID	0x400		/* HW invalid bit    */
+#define PAGE_PROTECT	0x200		/* HW read-only bit  */
+#define PAGE_NOEXEC	0x100		/* HW no-execute bit */
+
+#endif
diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
new file mode 100644
index 000000000000..c8759445e7d3
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KVM selftest s390x library code - CPU-related functions (page tables...)
+ *
+ * Copyright (C) 2019, Red Hat, Inc.
+ */
+
+#define _GNU_SOURCE /* for program_invocation_name */
+
+#include "processor.h"
+#include "kvm_util.h"
+#include "../kvm_util_internal.h"
+
+#define KVM_GUEST_PAGE_TABLE_MIN_PADDR		0x180000
+
+#define PAGES_PER_REGION 4
+
+void virt_pgd_alloc(struct kvm_vm *vm, uint32_t memslot)
+{
+	vm_paddr_t paddr;
+
+	TEST_ASSERT(vm->page_size == 4096, "Unsupported page size: 0x%x",
+		    vm->page_size);
+
+	if (vm->pgd_created)
+		return;
+
+	paddr = vm_phy_pages_alloc(vm, PAGES_PER_REGION,
+				   KVM_GUEST_PAGE_TABLE_MIN_PADDR, memslot);
+	memset(addr_gpa2hva(vm, paddr), 0xff, PAGES_PER_REGION * vm->page_size);
+
+	vm->pgd = paddr;
+	vm->pgd_created = true;
+}
+
+/*
+ * Allocate 4 pages for a region/segment table (ri < 4), or one page for
+ * a page table (ri == 4). Returns a suitable region/segment table entry
+ * which points to the freshly allocated pages.
+ */
+static uint64_t virt_alloc_region(struct kvm_vm *vm, int ri, uint32_t memslot)
+{
+	uint64_t taddr;
+
+	taddr = vm_phy_pages_alloc(vm,  ri < 4 ? PAGES_PER_REGION : 1,
+				   KVM_GUEST_PAGE_TABLE_MIN_PADDR, memslot);
+	memset(addr_gpa2hva(vm, taddr), 0xff, PAGES_PER_REGION * vm->page_size);
+
+	return (taddr & REGION_ENTRY_ORIGIN)
+		| (((4 - ri) << 2) & REGION_ENTRY_TYPE)
+		| ((ri < 4 ? (PAGES_PER_REGION - 1) : 0) & REGION_ENTRY_LENGTH);
+}
+
+/*
+ * VM Virtual Page Map
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   gva - VM Virtual Address
+ *   gpa - VM Physical Address
+ *   memslot - Memory region slot for new virtual translation tables
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Within the VM given by vm, creates a virtual translation for the page
+ * starting at vaddr to the page starting at paddr.
+ */
+void virt_pg_map(struct kvm_vm *vm, uint64_t gva, uint64_t gpa,
+		 uint32_t memslot)
+{
+	int ri, idx;
+	uint64_t *entry;
+
+	TEST_ASSERT((gva % vm->page_size) == 0,
+		"Virtual address not on page boundary,\n"
+		"  vaddr: 0x%lx vm->page_size: 0x%x",
+		gva, vm->page_size);
+	TEST_ASSERT(sparsebit_is_set(vm->vpages_valid,
+		(gva >> vm->page_shift)),
+		"Invalid virtual address, vaddr: 0x%lx",
+		gva);
+	TEST_ASSERT((gpa % vm->page_size) == 0,
+		"Physical address not on page boundary,\n"
+		"  paddr: 0x%lx vm->page_size: 0x%x",
+		gva, vm->page_size);
+	TEST_ASSERT((gpa >> vm->page_shift) <= vm->max_gfn,
+		"Physical address beyond beyond maximum supported,\n"
+		"  paddr: 0x%lx vm->max_gfn: 0x%lx vm->page_size: 0x%x",
+		gva, vm->max_gfn, vm->page_size);
+
+	/* Walk through region and segment tables */
+	entry = addr_gpa2hva(vm, vm->pgd);
+	for (ri = 1; ri <= 4; ri++) {
+		idx = (gva >> (64 - 11 * ri)) & 0x7ffu;
+		if (entry[idx] & REGION_ENTRY_INVALID)
+			entry[idx] = virt_alloc_region(vm, ri, memslot);
+		entry = addr_gpa2hva(vm, entry[idx] & REGION_ENTRY_ORIGIN);
+	}
+
+	/* Fill in page table entry */
+	idx = (gva >> 12) & 0x0ffu;		/* page index */
+	if (!(entry[idx] & PAGE_INVALID))
+		fprintf(stderr,
+			"WARNING: PTE for gpa=0x%"PRIx64" already set!\n", gpa);
+	entry[idx] = gpa;
+}
+
+/*
+ * Address Guest Virtual to Guest Physical
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   gpa - VM virtual address
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Equivalent VM physical address
+ *
+ * Translates the VM virtual address given by gva to a VM physical
+ * address and then locates the memory region containing the VM
+ * physical address, within the VM given by vm.  When found, the host
+ * virtual address providing the memory to the vm physical address is
+ * returned.
+ * A TEST_ASSERT failure occurs if no region containing translated
+ * VM virtual address exists.
+ */
+vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
+{
+	int ri, idx;
+	uint64_t *entry;
+
+	TEST_ASSERT(vm->page_size == 4096, "Unsupported page size: 0x%x",
+		    vm->page_size);
+
+	entry = addr_gpa2hva(vm, vm->pgd);
+	for (ri = 1; ri <= 4; ri++) {
+		idx = (gva >> (64 - 11 * ri)) & 0x7ffu;
+		TEST_ASSERT(!(entry[idx] & REGION_ENTRY_INVALID),
+			    "No region mapping for vm virtual address 0x%lx",
+			    gva);
+		entry = addr_gpa2hva(vm, entry[idx] & REGION_ENTRY_ORIGIN);
+	}
+
+	idx = (gva >> 12) & 0x0ffu;		/* page index */
+
+	TEST_ASSERT(!(entry[idx] & PAGE_INVALID),
+		    "No page mapping for vm virtual address 0x%lx", gva);
+
+	return (entry[idx] & ~0xffful) + (gva & 0xffful);
+}
+
+static void virt_dump_ptes(FILE *stream, struct kvm_vm *vm, uint8_t indent,
+			   uint64_t ptea_start)
+{
+	uint64_t *pte, ptea;
+
+	for (ptea = ptea_start; ptea < ptea_start + 0x100 * 8; ptea += 8) {
+		pte = addr_gpa2hva(vm, ptea);
+		if (*pte & PAGE_INVALID)
+			continue;
+		fprintf(stream, "%*spte @ 0x%lx: 0x%016lx\n",
+			indent, "", ptea, *pte);
+	}
+}
+
+static void virt_dump_region(FILE *stream, struct kvm_vm *vm, uint8_t indent,
+			     uint64_t reg_tab_addr)
+{
+	uint64_t addr, *entry;
+
+	for (addr = reg_tab_addr; addr < reg_tab_addr + 0x400 * 8; addr += 8) {
+		entry = addr_gpa2hva(vm, addr);
+		if (*entry & REGION_ENTRY_INVALID)
+			continue;
+		fprintf(stream, "%*srt%lde @ 0x%lx: 0x%016lx\n",
+			indent, "", 4 - ((*entry & REGION_ENTRY_TYPE) >> 2),
+			addr, *entry);
+		if (*entry & REGION_ENTRY_TYPE) {
+			virt_dump_region(stream, vm, indent + 2,
+					 *entry & REGION_ENTRY_ORIGIN);
+		} else {
+			virt_dump_ptes(stream, vm, indent + 2,
+				       *entry & REGION_ENTRY_ORIGIN);
+		}
+	}
+}
+
+void virt_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
+{
+	if (!vm->pgd_created)
+		return;
+
+	virt_dump_region(stream, vm, indent, vm->pgd);
+}
+
+/*
+ * Create a VM with reasonable defaults
+ *
+ * Input Args:
+ *   vcpuid - The id of the single VCPU to add to the VM.
+ *   extra_mem_pages - The size of extra memories to add (this will
+ *                     decide how much extra space we will need to
+ *                     setup the page tables using mem slot 0)
+ *   guest_code - The vCPU's entry point
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Pointer to opaque structure that describes the created VM.
+ */
+struct kvm_vm *vm_create_default(uint32_t vcpuid, uint64_t extra_mem_pages,
+				 void *guest_code)
+{
+	/*
+	 * The additional amount of pages required for the page tables is:
+	 * 1 * n / 256 + 4 * (n / 256) / 2048 + 4 * (n / 256) / 2048^2 + ...
+	 * which is definitely smaller than (n / 256) * 2.
+	 */
+	uint64_t extra_pg_pages = extra_mem_pages / 256 * 2;
+	struct kvm_vm *vm;
+
+	vm = vm_create(VM_MODE_DEFAULT,
+		       DEFAULT_GUEST_PHY_PAGES + extra_pg_pages, O_RDWR);
+
+	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
+	vm_vcpu_add_default(vm, vcpuid, guest_code);
+
+	return vm;
+}
+
+/*
+ * Adds a vCPU with reasonable defaults (i.e. a stack and initial PSW)
+ *
+ * Input Args:
+ *   vcpuid - The id of the VCPU to add to the VM.
+ *   guest_code - The vCPU's entry point
+ */
+void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
+{
+	size_t stack_size =  DEFAULT_STACK_PGS * getpagesize();
+	uint64_t stack_vaddr;
+	struct kvm_regs regs;
+	struct kvm_sregs sregs;
+	struct kvm_run *run;
+
+	TEST_ASSERT(vm->page_size == 4096, "Unsupported page size: 0x%x",
+		    vm->page_size);
+
+	stack_vaddr = vm_vaddr_alloc(vm, stack_size,
+				     DEFAULT_GUEST_STACK_VADDR_MIN, 0, 0);
+
+	vm_vcpu_add(vm, vcpuid, 0, 0);
+
+	/* Setup guest registers */
+	vcpu_regs_get(vm, vcpuid, &regs);
+	regs.gprs[15] = stack_vaddr + (DEFAULT_STACK_PGS * getpagesize()) - 160;
+	vcpu_regs_set(vm, vcpuid, &regs);
+
+	vcpu_sregs_get(vm, vcpuid, &sregs);
+	sregs.crs[1] = vm->pgd | 0xf;		/* Primary region table */
+	vcpu_sregs_set(vm, vcpuid, &sregs);
+
+	run = vcpu_state(vm, vcpuid);
+	run->psw_mask = 0x0400000180000000ULL;  /* DAT enabled + 64 bit mode */
+	run->psw_addr = (uintptr_t)guest_code;
+}
+
+void vcpu_setup(struct kvm_vm *vm, int vcpuid, int pgd_memslot, int gdt_memslot)
+{
+	struct kvm_sregs sregs;
+
+	vcpu_sregs_get(vm, vcpuid, &sregs);
+	sregs.crs[0] |= 0x00040000;		/* Enable floating point regs */
+	vcpu_sregs_set(vm, vcpuid, &sregs);
+}
+
+void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
+{
+	struct vcpu *vcpu = vm->vcpu_head;
+
+	fprintf(stream, "%*spstate: psw: 0x%.16llx:0x%.16llx\n",
+		indent, "", vcpu->state->psw_mask, vcpu->state->psw_addr);
+}
-- 
2.21.0

