Return-Path: <linux-kselftest+bounces-3509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DE183B6E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 02:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB92A1F23913
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 01:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D937464;
	Thu, 25 Jan 2024 01:54:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2347C6FD0;
	Thu, 25 Jan 2024 01:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706147674; cv=none; b=kpjQaRZxYqCecOUBOvj+5UneQvGJkiIxhDXgWDqt0zk2bZKc2qGDgGFUdqNop+rx770Ecp2yjfjpcT+06P6jdi/9fYybqbkQJHbQpa+84ZCU1zPYlbRwCZFKI3LC9k1U3EEuFXAyCKTDmYc9wbb3jAXz6ybkNEzqaMXnuVjhkTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706147674; c=relaxed/simple;
	bh=TDLce5IE/8g6lMbZjoUUXhLlY6Ruma5xEBVUtzqw03A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iTO9UVFwIR6AhZJT4nXD3UTyFsqsqMuvYMp4HHuWbm8vWG/UhkTfNdKYCw3xwfD2b+NJjrfvMYHSo58ifQbGR6Qs5QYVj0IqjDwaah6Rb8cEfido8xeyno2/uYvsjfWBIJy06COITAzxJYmiXA6vjEfGaDDI5QPiNdenkbeY2RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxDOtWv7FlsT0FAA--.9991S3;
	Thu, 25 Jan 2024 09:54:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxVMxMv7FlojkYAA--.45641S4;
	Thu, 25 Jan 2024 09:54:29 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v6 2/4] KVM: selftests: Add core KVM selftests support for LoongArch
Date: Thu, 25 Jan 2024 09:54:18 +0800
Message-Id: <20240125015420.1960090-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240125015420.1960090-1-maobibo@loongson.cn>
References: <20240125015420.1960090-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxVMxMv7FlojkYAA--.45641S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3tF1UAw1rWF17Xr1fXFWkGrX_yoWktFWxpF
	yfC3yrJrWrt3ZxXaykJr4v9F45Jwsakw4xZFyxGrWYkw47XryUJry8tFW3AFW5Ww18Ww1S
	v3ZYyF4xZa10q3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
	XVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x07UCoGQUUUUU=

From: Tianrui Zhao <zhaotianrui@loongson.cn>

Add core KVM selftests support for LoongArch, it includes exception
handler, mmu page table setup and vcpu startup entry supporting etc.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 .../selftests/kvm/lib/loongarch/exception.S   |  59 ++++
 .../selftests/kvm/lib/loongarch/processor.c   | 332 ++++++++++++++++++
 2 files changed, 391 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/lib/loongarch/exception.S
 create mode 100644 tools/testing/selftests/kvm/lib/loongarch/processor.c

diff --git a/tools/testing/selftests/kvm/lib/loongarch/exception.S b/tools/testing/selftests/kvm/lib/loongarch/exception.S
new file mode 100644
index 000000000000..88bfa505c6f5
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/loongarch/exception.S
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "processor.h"
+
+/* address of refill exception should be 4K aligned */
+.balign	4096
+.global handle_tlb_refill
+handle_tlb_refill:
+	csrwr	t0, LOONGARCH_CSR_TLBRSAVE
+	csrrd	t0, LOONGARCH_CSR_PGD
+	lddir	t0, t0, 3
+	lddir	t0, t0, 1
+	ldpte	t0, 0
+	ldpte	t0, 1
+	tlbfill
+	csrrd	t0, LOONGARCH_CSR_TLBRSAVE
+	ertn
+
+	/*
+	 * save and restore all gprs except base register,
+	 * and default value of base register is sp ($r3).
+	 */
+.macro save_gprs base
+	.irp n,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
+	st.d    $r\n, \base, 8 * \n
+	.endr
+.endm
+
+.macro restore_gprs base
+	.irp n,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
+	ld.d    $r\n, \base, 8 * \n
+	.endr
+.endm
+
+/* address of general exception should be 4K aligned */
+.balign	4096
+.global handle_exception
+handle_exception:
+	csrwr  sp, LOONGARCH_CSR_KS0
+	csrrd  sp, LOONGARCH_CSR_KS1
+	addi.d sp, sp, -EXREGS_SIZE
+
+	save_gprs sp
+	/* save sp register to stack */
+	csrrd  t0, LOONGARCH_CSR_KS0
+	st.d   t0, sp, 3 * 8
+
+	csrrd  t0, LOONGARCH_CSR_ERA
+	st.d   t0, sp, PC_OFFSET_EXREGS
+	csrrd  t0, LOONGARCH_CSR_ESTAT
+	st.d   t0, sp, ESTAT_OFFSET_EXREGS
+	csrrd  t0, LOONGARCH_CSR_BADV
+	st.d   t0, sp, BADV_OFFSET_EXREGS
+
+	or     a0, sp, zero
+	bl route_exception
+	restore_gprs sp
+	csrrd  sp, LOONGARCH_CSR_KS0
+	ertn
diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tools/testing/selftests/kvm/lib/loongarch/processor.c
new file mode 100644
index 000000000000..e6d1cd549944
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <assert.h>
+#include <linux/compiler.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+
+static vm_paddr_t invalid_pgtable[4];
+static uint64_t virt_pte_index(struct kvm_vm *vm, vm_vaddr_t gva, int level)
+{
+	unsigned int shift;
+	uint64_t mask;
+
+	shift = level * (vm->page_shift - 3) + vm->page_shift;
+	mask = (1UL << (vm->page_shift - 3)) - 1;
+	return (gva >> shift) & mask;
+}
+
+static uint64_t pte_addr(struct kvm_vm *vm, uint64_t entry)
+{
+	return entry &  ~((0x1UL << vm->page_shift) - 1);
+}
+
+static uint64_t ptrs_per_pte(struct kvm_vm *vm)
+{
+	return 1 << (vm->page_shift - 3);
+}
+
+static void virt_set_pgtable(struct kvm_vm *vm, vm_paddr_t table, vm_paddr_t child)
+{
+	uint64_t *ptep;
+	int i, ptrs_per_pte;
+
+	ptep = addr_gpa2hva(vm, table);
+	ptrs_per_pte = 1 << (vm->page_shift - 3);
+	for (i = 0; i < ptrs_per_pte; i++)
+		*(ptep + i) = child;
+}
+
+void virt_arch_pgd_alloc(struct kvm_vm *vm)
+{
+	int i;
+	vm_paddr_t child, table;
+
+	if (vm->pgd_created)
+		return;
+	child = table = 0;
+	for (i = 0; i < vm->pgtable_levels; i++) {
+		invalid_pgtable[i] = child;
+		table = vm_phy_page_alloc(vm, DEFAULT_LOONARCH64_PAGE_TABLE_MIN,
+				vm->memslots[MEM_REGION_PT]);
+		TEST_ASSERT(table, "Fail to allocate page tale at level %d\n", i);
+		virt_set_pgtable(vm, table, child);
+		child = table;
+	}
+	vm->pgd = table;
+	vm->pgd_created = true;
+}
+
+static int virt_pte_none(uint64_t *ptep, int level)
+{
+	return *ptep == invalid_pgtable[level];
+}
+
+static uint64_t *virt_populate_pte(struct kvm_vm *vm, vm_vaddr_t gva, int alloc)
+{
+	uint64_t *ptep;
+	vm_paddr_t child;
+	int level;
+
+	if (!vm->pgd_created)
+		goto unmapped_gva;
+
+	level = vm->pgtable_levels - 1;
+	child = vm->pgd;
+	while (level > 0) {
+		ptep = addr_gpa2hva(vm, child) + virt_pte_index(vm, gva, level) * 8;
+		if (virt_pte_none(ptep, level)) {
+			if (alloc) {
+				child = vm_alloc_page_table(vm);
+				virt_set_pgtable(vm, child, invalid_pgtable[level - 1]);
+				*ptep = child;
+			} else
+				goto unmapped_gva;
+
+		} else
+			child = pte_addr(vm, *ptep);
+		level--;
+	}
+
+	ptep = addr_gpa2hva(vm, child) + virt_pte_index(vm, gva, level) * 8;
+	return ptep;
+
+unmapped_gva:
+	TEST_FAIL("No mapping for vm virtual address, gva: 0x%lx", gva);
+	exit(EXIT_FAILURE);
+}
+
+vm_paddr_t addr_arch_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
+{
+	uint64_t *ptep;
+
+	ptep = virt_populate_pte(vm, gva, 0);
+	TEST_ASSERT(*ptep != 0, "Virtual address vaddr: 0x%lx not mapped\n", gva);
+
+	return pte_addr(vm, *ptep) + (gva & (vm->page_size - 1));
+}
+
+void virt_arch_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
+{
+	uint32_t prot_bits;
+	uint64_t *ptep;
+
+	TEST_ASSERT((vaddr % vm->page_size) == 0,
+			"Virtual address not on page boundary,\n"
+			"vaddr: 0x%lx vm->page_size: 0x%x", vaddr, vm->page_size);
+	TEST_ASSERT(sparsebit_is_set(vm->vpages_valid,
+			(vaddr >> vm->page_shift)),
+			"Invalid virtual address, vaddr: 0x%lx", vaddr);
+	TEST_ASSERT((paddr % vm->page_size) == 0,
+			"Physical address not on page boundary,\n"
+			"paddr: 0x%lx vm->page_size: 0x%x", paddr, vm->page_size);
+	TEST_ASSERT((paddr >> vm->page_shift) <= vm->max_gfn,
+			"Physical address beyond maximum supported,\n"
+			"paddr: 0x%lx vm->max_gfn: 0x%lx vm->page_size: 0x%x",
+			paddr, vm->max_gfn, vm->page_size);
+
+	ptep = virt_populate_pte(vm, vaddr, 1);
+	prot_bits = _PAGE_PRESENT | __READABLE | __WRITEABLE | _CACHE_CC;
+	prot_bits |= _PAGE_USER;
+	*ptep = paddr | prot_bits;
+}
+
+static void pte_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent, uint64_t page, int level)
+{
+	static const char * const type[] = { "pte", "pmd", "pud", "pgd"};
+	uint64_t pte, *ptep;
+
+	if (level < 0)
+		return;
+
+	for (pte = page; pte < page + ptrs_per_pte(vm) * 8; pte += 8) {
+		ptep = addr_gpa2hva(vm, pte);
+		if (virt_pte_none(ptep, level))
+			continue;
+		fprintf(stream, "%*s%s: %lx: %lx at %p\n",
+				indent, "", type[level], pte, *ptep, ptep);
+		pte_dump(stream, vm, indent + 1, pte_addr(vm, *ptep), level--);
+	}
+}
+
+void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
+{
+	int level;
+
+	if (!vm->pgd_created)
+		return;
+
+	level = vm->pgtable_levels - 1;
+	pte_dump(stream, vm, indent, vm->pgd, level);
+}
+
+void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
+{
+}
+
+void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	if (get_ucall(vcpu, &uc) != UCALL_UNHANDLED)
+		return;
+
+	TEST_FAIL("Unexpected exception (pc:0x%lx, estat:0x%lx, badv:0x%lx)",
+			uc.args[0], uc.args[1], uc.args[2]);
+}
+
+void route_exception(struct ex_regs *regs)
+{
+	unsigned long pc, estat, badv;
+
+	pc = regs->pc;
+	estat = regs->estat;
+	badv  = regs->badv;
+	ucall(UCALL_UNHANDLED, 3, pc, estat, badv);
+	while (1);
+}
+
+void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
+{
+	va_list ap;
+	struct kvm_regs regs;
+	int i;
+
+	TEST_ASSERT(num >= 1 && num <= 8, "Unsupported number of args,\n"
+		    "num: %u\n", num);
+
+	vcpu_regs_get(vcpu, &regs);
+	va_start(ap, num);
+	for (i = 0; i < num; i++)
+		regs.gpr[i + 4] = va_arg(ap, uint64_t);
+	va_end(ap);
+	vcpu_regs_set(vcpu, &regs);
+}
+
+static void loongarch_get_csr(struct kvm_vcpu *vcpu, uint64_t id, void *addr)
+{
+	uint64_t csrid;
+
+	csrid = KVM_REG_LOONGARCH_CSR | KVM_REG_SIZE_U64 | 8 * id;
+	vcpu_get_reg(vcpu, csrid, addr);
+}
+
+static void loongarch_set_csr(struct kvm_vcpu *vcpu, uint64_t id, uint64_t val)
+{
+	uint64_t csrid;
+
+	csrid = KVM_REG_LOONGARCH_CSR | KVM_REG_SIZE_U64 | 8 * id;
+	vcpu_set_reg(vcpu, csrid, val);
+}
+
+static void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
+{
+	unsigned long val;
+	int width;
+	struct kvm_vm *vm = vcpu->vm;
+
+	switch (vm->mode) {
+	case VM_MODE_P48V48_16K:
+	case VM_MODE_P40V48_16K:
+	case VM_MODE_P36V48_16K:
+	case VM_MODE_P36V47_16K:
+		break;
+
+	default:
+		TEST_FAIL("Unknown guest mode, mode: 0x%x", vm->mode);
+	}
+
+	/* user mode and page enable mode */
+	val = PLV_USER | CSR_CRMD_PG;
+	loongarch_set_csr(vcpu, LOONGARCH_CSR_CRMD, val);
+	loongarch_set_csr(vcpu, LOONGARCH_CSR_PRMD, val);
+	loongarch_set_csr(vcpu, LOONGARCH_CSR_EUEN, 1);
+	loongarch_set_csr(vcpu, LOONGARCH_CSR_ECFG, 0);
+	loongarch_set_csr(vcpu, LOONGARCH_CSR_TCFG, 0);
+	loongarch_set_csr(vcpu, LOONGARCH_CSR_ASID, 1);
+
+	width = vm->page_shift - 3;
+	val = 0;
+	switch (vm->pgtable_levels) {
+	case 4:
+		/* pud page shift and width */
+		val = (vm->page_shift + width * 2) << 20 | (width << 25);
+		/* fall throuth */
+	case 3:
+		/* pmd page shift and width */
+		val |= (vm->page_shift + width) << 10 | (width << 15);
+		/* pte page shift and width */
+		val |= vm->page_shift | width << 5;
+		break;
+	default:
+		TEST_FAIL("Got %u page table levels, expected 3 or 4", vm->pgtable_levels);
+	}
+	loongarch_set_csr(vcpu, LOONGARCH_CSR_PWCTL0, val);
+
+	/* pgd page shift and width */
+	val = (vm->page_shift + width * (vm->pgtable_levels - 1)) | width << 6;
+	loongarch_set_csr(vcpu, LOONGARCH_CSR_PWCTL1, val);
+
+	loongarch_set_csr(vcpu, LOONGARCH_CSR_PGDL, vm->pgd);
+
+	/*
+	 * refill exception runs on real mode, entry address should
+	 * be physical address
+	 */
+	val = addr_gva2gpa(vm, (unsigned long)handle_tlb_refill);
+	loongarch_set_csr(vcpu, LOONGARCH_CSR_TLBRENTRY, val);
+
+	/*
+	 * general exception runs on page-enabled mode, entry address should
+	 * be virtual address
+	 */
+	val = (unsigned long)handle_exception;
+	loongarch_set_csr(vcpu, LOONGARCH_CSR_EENTRY, val);
+
+	loongarch_get_csr(vcpu, LOONGARCH_CSR_TLBIDX, &val);
+	val &= ~CSR_TLBIDX_SIZEM;
+	val |= PS_DEFAULT_SIZE << CSR_TLBIDX_SIZE;
+	loongarch_set_csr(vcpu, LOONGARCH_CSR_TLBIDX, val);
+
+	loongarch_set_csr(vcpu, LOONGARCH_CSR_STLBPGSIZE, PS_DEFAULT_SIZE);
+
+	/* LOONGARCH_CSR_KS1 is used for exception stack */
+	val = __vm_vaddr_alloc(vm, vm->page_size,
+			DEFAULT_LOONARCH64_STACK_MIN, MEM_REGION_DATA);
+	TEST_ASSERT(val != 0,  "No memory for exception stack");
+	val = val + vm->page_size;
+	loongarch_set_csr(vcpu, LOONGARCH_CSR_KS1, val);
+
+	loongarch_get_csr(vcpu, LOONGARCH_CSR_TLBREHI, &val);
+	val &= ~CSR_TLBREHI_PS;
+	val |= PS_DEFAULT_SIZE << CSR_TLBREHI_PS_SHIFT;
+	loongarch_set_csr(vcpu, LOONGARCH_CSR_TLBREHI, val);
+
+	loongarch_set_csr(vcpu, LOONGARCH_CSR_CPUID, vcpu->id);
+	loongarch_set_csr(vcpu, LOONGARCH_CSR_TMID,  vcpu->id);
+}
+
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
+				  void *guest_code)
+{
+	size_t stack_size;
+	uint64_t stack_vaddr;
+	struct kvm_regs regs;
+	struct kvm_vcpu *vcpu;
+
+	vcpu = __vm_vcpu_add(vm, vcpu_id);
+	stack_size = vm->page_size;
+	stack_vaddr = __vm_vaddr_alloc(vm, stack_size,
+			DEFAULT_LOONARCH64_STACK_MIN, MEM_REGION_DATA);
+	TEST_ASSERT(stack_vaddr != 0,  "No memory for vm stack");
+
+	loongarch_vcpu_setup(vcpu);
+	/* Setup guest general purpose registers */
+	vcpu_regs_get(vcpu, &regs);
+	regs.gpr[3] = stack_vaddr + stack_size;
+	regs.pc = (uint64_t)guest_code;
+	vcpu_regs_set(vcpu, &regs);
+
+	return vcpu;
+}
-- 
2.39.3


