Return-Path: <linux-kselftest+bounces-31222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A95B5A94A25
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 03:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61735188F7AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 01:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4D12A8D0;
	Mon, 21 Apr 2025 01:25:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ED533C9;
	Mon, 21 Apr 2025 01:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745198730; cv=none; b=XreiaEtvFaZXGqT5aCYpA9dW8wQpdi1cNiPpYrfwHxryGJKsnRDk47DbQ9g/SFnOBZUA+fpGkRy/LrmtS24vLxqTfkl48798JtTI6+8oaQgpQdjmwQv5xFmypt9wZDgEGpzHpnSTaMX2ZS5cMcY43GkjTU1GA7vDLZq3yo6j28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745198730; c=relaxed/simple;
	bh=nMHVu0wkeIUxnsrlaw39/mj6995yLB9BNee52jE/fj8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZMMSoib7Rdwc7612Z6N2Y3oW5DQWa3qAh3Tutk7tuVg0KPi6N86WF8bs/nt3NGIp1lqK9rColyIbVus8tUna4D1wocQ4BBPTbO45slVsdbwxiHRUbTY8Ops6hVJCpSQ/Qbf5RKAVGOAUJAuIGXYmnRJW2xbethY43xVnRZ8TSU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxvnKEngVoLiXDAA--.61316S3;
	Mon, 21 Apr 2025 09:25:24 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMCx_caCngVomZqNAA--.27436S3;
	Mon, 21 Apr 2025 09:25:23 +0800 (CST)
Subject: Re: [PATCH v9 3/5] KVM: selftests: Add core KVM selftests support for
 LoongArch
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250416035455.25996-1-maobibo@loongson.cn>
 <20250416035455.25996-4-maobibo@loongson.cn>
 <CAAhV-H5vggSAjh3oRHh84xi7E3oOBjuXyapMzD-YkQdPRWuiHQ@mail.gmail.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <67040b34-5375-fed5-8528-d65a1ead8df9@loongson.cn>
Date: Mon, 21 Apr 2025 09:24:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5vggSAjh3oRHh84xi7E3oOBjuXyapMzD-YkQdPRWuiHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCx_caCngVomZqNAA--.27436S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3tFWfKFy3tF4xAr1fGr1xJFc_yoW8Gry8uo
	W3KF4Igr1fGr12yr97Kry0qa42v3409a1UC3W5Cw4fXa1Uta45Wr15Gr4fAr4fWFW8GrWU
	CasrXa4xAFZ7Xwn8l-sFpf9Il3svdjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYA7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uuWJUUUUU==



On 2025/4/20 下午3:45, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Wed, Apr 16, 2025 at 11:55 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Add core KVM selftests support for LoongArch, it includes exception
>> handler, mmu page table setup and vCPU startup entry support.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   .../selftests/kvm/lib/loongarch/exception.S   |  59 +++
>>   .../selftests/kvm/lib/loongarch/processor.c   | 347 ++++++++++++++++++
>>   2 files changed, 406 insertions(+)
>>   create mode 100644 tools/testing/selftests/kvm/lib/loongarch/exception.S
>>   create mode 100644 tools/testing/selftests/kvm/lib/loongarch/processor.c
>>
>> diff --git a/tools/testing/selftests/kvm/lib/loongarch/exception.S b/tools/testing/selftests/kvm/lib/loongarch/exception.S
>> new file mode 100644
>> index 000000000000..88bfa505c6f5
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/lib/loongarch/exception.S
>> @@ -0,0 +1,59 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#include "processor.h"
>> +
>> +/* address of refill exception should be 4K aligned */
>> +.balign        4096
>> +.global handle_tlb_refill
>> +handle_tlb_refill:
>> +       csrwr   t0, LOONGARCH_CSR_TLBRSAVE
>> +       csrrd   t0, LOONGARCH_CSR_PGD
>> +       lddir   t0, t0, 3
>> +       lddir   t0, t0, 1
>> +       ldpte   t0, 0
>> +       ldpte   t0, 1
>> +       tlbfill
>> +       csrrd   t0, LOONGARCH_CSR_TLBRSAVE
>> +       ertn
>> +
>> +       /*
>> +        * save and restore all gprs except base register,
>> +        * and default value of base register is sp ($r3).
>> +        */
>> +.macro save_gprs base
>> +       .irp n,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
>> +       st.d    $r\n, \base, 8 * \n
>> +       .endr
>> +.endm
>> +
>> +.macro restore_gprs base
>> +       .irp n,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
>> +       ld.d    $r\n, \base, 8 * \n
>> +       .endr
>> +.endm
>> +
>> +/* address of general exception should be 4K aligned */
>> +.balign        4096
>> +.global handle_exception
>> +handle_exception:
>> +       csrwr  sp, LOONGARCH_CSR_KS0
>> +       csrrd  sp, LOONGARCH_CSR_KS1
>> +       addi.d sp, sp, -EXREGS_SIZE
>> +
>> +       save_gprs sp
>> +       /* save sp register to stack */
>> +       csrrd  t0, LOONGARCH_CSR_KS0
>> +       st.d   t0, sp, 3 * 8
>> +
>> +       csrrd  t0, LOONGARCH_CSR_ERA
>> +       st.d   t0, sp, PC_OFFSET_EXREGS
>> +       csrrd  t0, LOONGARCH_CSR_ESTAT
>> +       st.d   t0, sp, ESTAT_OFFSET_EXREGS
>> +       csrrd  t0, LOONGARCH_CSR_BADV
>> +       st.d   t0, sp, BADV_OFFSET_EXREGS
>> +
>> +       or     a0, sp, zero
>> +       bl route_exception
>> +       restore_gprs sp
>> +       csrrd  sp, LOONGARCH_CSR_KS0
>> +       ertn
>> diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tools/testing/selftests/kvm/lib/loongarch/processor.c
>> new file mode 100644
>> index 000000000000..8595c38ca26b
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
>> @@ -0,0 +1,347 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <assert.h>
>> +#include <linux/compiler.h>
>> +
>> +#include "kvm_util.h"
>> +#include "processor.h"
>> +#include "ucall_common.h"
>> +
>> +#define LOONGARCH_GUEST_STACK_VADDR_MIN                0x200000
>> +#define LOONARCH_PAGE_TABLE_PHYS_MIN           0x200000
> I think here is a typo.
yes, there is a typo issue :(
Will fix in next version.

Regards
Bibo Mao
> 
> Huacai
> 
>> +
>> +static vm_paddr_t invalid_pgtable[4];
>> +static uint64_t virt_pte_index(struct kvm_vm *vm, vm_vaddr_t gva, int level)
>> +{
>> +       unsigned int shift;
>> +       uint64_t mask;
>> +
>> +       shift = level * (vm->page_shift - 3) + vm->page_shift;
>> +       mask = (1UL << (vm->page_shift - 3)) - 1;
>> +       return (gva >> shift) & mask;
>> +}
>> +
>> +static uint64_t pte_addr(struct kvm_vm *vm, uint64_t entry)
>> +{
>> +       return entry &  ~((0x1UL << vm->page_shift) - 1);
>> +}
>> +
>> +static uint64_t ptrs_per_pte(struct kvm_vm *vm)
>> +{
>> +       return 1 << (vm->page_shift - 3);
>> +}
>> +
>> +static void virt_set_pgtable(struct kvm_vm *vm, vm_paddr_t table, vm_paddr_t child)
>> +{
>> +       uint64_t *ptep;
>> +       int i, ptrs_per_pte;
>> +
>> +       ptep = addr_gpa2hva(vm, table);
>> +       ptrs_per_pte = 1 << (vm->page_shift - 3);
>> +       for (i = 0; i < ptrs_per_pte; i++)
>> +               WRITE_ONCE(*(ptep + i), child);
>> +}
>> +
>> +void virt_arch_pgd_alloc(struct kvm_vm *vm)
>> +{
>> +       int i;
>> +       vm_paddr_t child, table;
>> +
>> +       if (vm->pgd_created)
>> +               return;
>> +       child = table = 0;
>> +       for (i = 0; i < vm->pgtable_levels; i++) {
>> +               invalid_pgtable[i] = child;
>> +               table = vm_phy_page_alloc(vm, LOONARCH_PAGE_TABLE_PHYS_MIN,
>> +                               vm->memslots[MEM_REGION_PT]);
>> +               TEST_ASSERT(table, "Fail to allocate page tale at level %d\n", i);
>> +               virt_set_pgtable(vm, table, child);
>> +               child = table;
>> +       }
>> +       vm->pgd = table;
>> +       vm->pgd_created = true;
>> +}
>> +
>> +static int virt_pte_none(uint64_t *ptep, int level)
>> +{
>> +       return *ptep == invalid_pgtable[level];
>> +}
>> +
>> +static uint64_t *virt_populate_pte(struct kvm_vm *vm, vm_vaddr_t gva, int alloc)
>> +{
>> +       uint64_t *ptep;
>> +       vm_paddr_t child;
>> +       int level;
>> +
>> +       if (!vm->pgd_created)
>> +               goto unmapped_gva;
>> +
>> +       level = vm->pgtable_levels - 1;
>> +       child = vm->pgd;
>> +       while (level > 0) {
>> +               ptep = addr_gpa2hva(vm, child) + virt_pte_index(vm, gva, level) * 8;
>> +               if (virt_pte_none(ptep, level)) {
>> +                       if (alloc) {
>> +                               child = vm_alloc_page_table(vm);
>> +                               virt_set_pgtable(vm, child, invalid_pgtable[level - 1]);
>> +                               WRITE_ONCE(*ptep, child);
>> +                       } else
>> +                               goto unmapped_gva;
>> +
>> +               } else
>> +                       child = pte_addr(vm, *ptep);
>> +               level--;
>> +       }
>> +
>> +       ptep = addr_gpa2hva(vm, child) + virt_pte_index(vm, gva, level) * 8;
>> +       return ptep;
>> +
>> +unmapped_gva:
>> +       TEST_FAIL("No mapping for vm virtual address, gva: 0x%lx", gva);
>> +       exit(EXIT_FAILURE);
>> +}
>> +
>> +vm_paddr_t addr_arch_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
>> +{
>> +       uint64_t *ptep;
>> +
>> +       ptep = virt_populate_pte(vm, gva, 0);
>> +       TEST_ASSERT(*ptep != 0, "Virtual address vaddr: 0x%lx not mapped\n", gva);
>> +
>> +       return pte_addr(vm, *ptep) + (gva & (vm->page_size - 1));
>> +}
>> +
>> +void virt_arch_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
>> +{
>> +       uint32_t prot_bits;
>> +       uint64_t *ptep;
>> +
>> +       TEST_ASSERT((vaddr % vm->page_size) == 0,
>> +                       "Virtual address not on page boundary,\n"
>> +                       "vaddr: 0x%lx vm->page_size: 0x%x", vaddr, vm->page_size);
>> +       TEST_ASSERT(sparsebit_is_set(vm->vpages_valid,
>> +                       (vaddr >> vm->page_shift)),
>> +                       "Invalid virtual address, vaddr: 0x%lx", vaddr);
>> +       TEST_ASSERT((paddr % vm->page_size) == 0,
>> +                       "Physical address not on page boundary,\n"
>> +                       "paddr: 0x%lx vm->page_size: 0x%x", paddr, vm->page_size);
>> +       TEST_ASSERT((paddr >> vm->page_shift) <= vm->max_gfn,
>> +                       "Physical address beyond maximum supported,\n"
>> +                       "paddr: 0x%lx vm->max_gfn: 0x%lx vm->page_size: 0x%x",
>> +                       paddr, vm->max_gfn, vm->page_size);
>> +
>> +       ptep = virt_populate_pte(vm, vaddr, 1);
>> +       prot_bits = _PAGE_PRESENT | __READABLE | __WRITEABLE | _CACHE_CC;
>> +       prot_bits |= _PAGE_USER;
>> +       WRITE_ONCE(*ptep, paddr | prot_bits);
>> +}
>> +
>> +static void pte_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent, uint64_t page, int level)
>> +{
>> +       static const char * const type[] = { "pte", "pmd", "pud", "pgd"};
>> +       uint64_t pte, *ptep;
>> +
>> +       if (level < 0)
>> +               return;
>> +
>> +       for (pte = page; pte < page + ptrs_per_pte(vm) * 8; pte += 8) {
>> +               ptep = addr_gpa2hva(vm, pte);
>> +               if (virt_pte_none(ptep, level))
>> +                       continue;
>> +               fprintf(stream, "%*s%s: %lx: %lx at %p\n",
>> +                               indent, "", type[level], pte, *ptep, ptep);
>> +               pte_dump(stream, vm, indent + 1, pte_addr(vm, *ptep), level--);
>> +       }
>> +}
>> +
>> +void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
>> +{
>> +       int level;
>> +
>> +       if (!vm->pgd_created)
>> +               return;
>> +
>> +       level = vm->pgtable_levels - 1;
>> +       pte_dump(stream, vm, indent, vm->pgd, level);
>> +}
>> +
>> +void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
>> +{
>> +}
>> +
>> +void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
>> +{
>> +       struct ucall uc;
>> +
>> +       if (get_ucall(vcpu, &uc) != UCALL_UNHANDLED)
>> +               return;
>> +
>> +       TEST_FAIL("Unexpected exception (pc:0x%lx, estat:0x%lx, badv:0x%lx)",
>> +                       uc.args[0], uc.args[1], uc.args[2]);
>> +}
>> +
>> +void route_exception(struct ex_regs *regs)
>> +{
>> +       unsigned long pc, estat, badv;
>> +
>> +       pc = regs->pc;
>> +       estat = regs->estat;
>> +       badv  = regs->badv;
>> +       ucall(UCALL_UNHANDLED, 3, pc, estat, badv);
>> +       while (1)
>> +               ;
>> +}
>> +
>> +void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
>> +{
>> +       va_list ap;
>> +       struct kvm_regs regs;
>> +       int i;
>> +
>> +       TEST_ASSERT(num >= 1 && num <= 8, "Unsupported number of args,\n"
>> +                   "num: %u\n", num);
>> +
>> +       vcpu_regs_get(vcpu, &regs);
>> +       va_start(ap, num);
>> +       for (i = 0; i < num; i++)
>> +               regs.gpr[i + 4] = va_arg(ap, uint64_t);
>> +       va_end(ap);
>> +       vcpu_regs_set(vcpu, &regs);
>> +}
>> +
>> +static void loongarch_get_csr(struct kvm_vcpu *vcpu, uint64_t id, void *addr)
>> +{
>> +       uint64_t csrid;
>> +
>> +       csrid = KVM_REG_LOONGARCH_CSR | KVM_REG_SIZE_U64 | 8 * id;
>> +       __vcpu_get_reg(vcpu, csrid, addr);
>> +}
>> +
>> +static void loongarch_set_csr(struct kvm_vcpu *vcpu, uint64_t id, uint64_t val)
>> +{
>> +       uint64_t csrid;
>> +
>> +       csrid = KVM_REG_LOONGARCH_CSR | KVM_REG_SIZE_U64 | 8 * id;
>> +       vcpu_set_reg(vcpu, csrid, val);
>> +}
>> +
>> +static void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
>> +{
>> +       unsigned long val;
>> +       int width;
>> +       struct kvm_vm *vm = vcpu->vm;
>> +
>> +       switch (vm->mode) {
>> +       case VM_MODE_P36V47_16K:
>> +       case VM_MODE_P47V47_16K:
>> +               break;
>> +
>> +       default:
>> +               TEST_FAIL("Unknown guest mode, mode: 0x%x", vm->mode);
>> +       }
>> +
>> +       /* user mode and page enable mode */
>> +       val = PLV_USER | CSR_CRMD_PG;
>> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_CRMD, val);
>> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_PRMD, val);
>> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_EUEN, 1);
>> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_ECFG, 0);
>> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_TCFG, 0);
>> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_ASID, 1);
>> +
>> +       width = vm->page_shift - 3;
>> +       val = 0;
>> +       switch (vm->pgtable_levels) {
>> +       case 4:
>> +               /* pud page shift and width */
>> +               val = (vm->page_shift + width * 2) << 20 | (width << 25);
>> +               /* fall throuth */
>> +       case 3:
>> +               /* pmd page shift and width */
>> +               val |= (vm->page_shift + width) << 10 | (width << 15);
>> +               /* pte page shift and width */
>> +               val |= vm->page_shift | width << 5;
>> +               break;
>> +       default:
>> +               TEST_FAIL("Got %u page table levels, expected 3 or 4", vm->pgtable_levels);
>> +       }
>> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_PWCTL0, val);
>> +
>> +       /* PGD page shift and width */
>> +       val = (vm->page_shift + width * (vm->pgtable_levels - 1)) | width << 6;
>> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_PWCTL1, val);
>> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_PGDL, vm->pgd);
>> +
>> +       /*
>> +        * Refill exception runs on real mode
>> +        * Entry address should be physical address
>> +        */
>> +       val = addr_gva2gpa(vm, (unsigned long)handle_tlb_refill);
>> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_TLBRENTRY, val);
>> +
>> +       /*
>> +        * General exception runs on page-enabled mode
>> +        * Entry address should be virtual address
>> +        */
>> +       val = (unsigned long)handle_exception;
>> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_EENTRY, val);
>> +
>> +       loongarch_get_csr(vcpu, LOONGARCH_CSR_TLBIDX, &val);
>> +       val &= ~CSR_TLBIDX_SIZEM;
>> +       val |= PS_DEFAULT_SIZE << CSR_TLBIDX_SIZE;
>> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_TLBIDX, val);
>> +
>> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_STLBPGSIZE, PS_DEFAULT_SIZE);
>> +
>> +       /* LOONGARCH_CSR_KS1 is used for exception stack */
>> +       val = __vm_vaddr_alloc(vm, vm->page_size,
>> +                       LOONGARCH_GUEST_STACK_VADDR_MIN, MEM_REGION_DATA);
>> +       TEST_ASSERT(val != 0,  "No memory for exception stack");
>> +       val = val + vm->page_size;
>> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_KS1, val);
>> +
>> +       loongarch_get_csr(vcpu, LOONGARCH_CSR_TLBREHI, &val);
>> +       val &= ~CSR_TLBREHI_PS;
>> +       val |= PS_DEFAULT_SIZE << CSR_TLBREHI_PS_SHIFT;
>> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_TLBREHI, val);
>> +
>> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_CPUID, vcpu->id);
>> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_TMID,  vcpu->id);
>> +}
>> +
>> +static struct kvm_vcpu *loongarch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
>> +{
>> +       size_t stack_size;
>> +       uint64_t stack_vaddr;
>> +       struct kvm_regs regs;
>> +       struct kvm_vcpu *vcpu;
>> +
>> +       vcpu = __vm_vcpu_add(vm, vcpu_id);
>> +       stack_size = vm->page_size;
>> +       stack_vaddr = __vm_vaddr_alloc(vm, stack_size,
>> +                       LOONGARCH_GUEST_STACK_VADDR_MIN, MEM_REGION_DATA);
>> +       TEST_ASSERT(stack_vaddr != 0,  "No memory for vm stack");
>> +
>> +       loongarch_vcpu_setup(vcpu);
>> +       /* Setup guest general purpose registers */
>> +       vcpu_regs_get(vcpu, &regs);
>> +       regs.gpr[3] = stack_vaddr + stack_size;
>> +       vcpu_regs_set(vcpu, &regs);
>> +
>> +       return vcpu;
>> +}
>> +
>> +struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
>> +{
>> +       return loongarch_vcpu_add(vm, vcpu_id);
>> +}
>> +
>> +void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
>> +{
>> +       struct kvm_regs regs;
>> +
>> +       /* Setup guest PC register */
>> +       vcpu_regs_get(vcpu, &regs);
>> +       regs.pc = (uint64_t)guest_code;
>> +       vcpu_regs_set(vcpu, &regs);
>> +}
>> --
>> 2.39.3
>>


