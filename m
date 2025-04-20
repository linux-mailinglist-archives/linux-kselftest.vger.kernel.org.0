Return-Path: <linux-kselftest+bounces-31218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 334D8A94715
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Apr 2025 09:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC23B189312B
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Apr 2025 07:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEAE189F5C;
	Sun, 20 Apr 2025 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYoezqS4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33624A04;
	Sun, 20 Apr 2025 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745135127; cv=none; b=eUPoQkmtCnzvYs65LZ9XTD5SSvE7lb39c2cv+BMTFeYBqW9Eoecfjl/+NiE1onJgPNrG65RhLPwANWhTr7sVkJjcm9CRjhUZR43ykPNixOolHloxOEgb5ha6U1gEEegY3sxf89aU+dKktt3Vap+yggCs97/oxKRo+PWHKSzhf9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745135127; c=relaxed/simple;
	bh=DsbdhY57LscvNnyjNE1kz3agLbVsXKls0QiHG5ZdL0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPC5MUNXgecHUOZwqEfdZXtcq49GK6SuFNbS3nzWimizmT7EGSXYiCZO5T3X3ajO7AP/YEF7mqW8SyX5e9HD76w+m7J4DnC1TRqvzs9BYMZydTtOP3kA7RZLgRR5NZyQoGQ3Ej5lN+AD6bF2kyM0VrQl1xnCD/JZyi1H1JIZTC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYoezqS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B550C4CEE2;
	Sun, 20 Apr 2025 07:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745135126;
	bh=DsbdhY57LscvNnyjNE1kz3agLbVsXKls0QiHG5ZdL0E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZYoezqS43L35nJ+A6Nz4i3h37kxm0tGHMOGG2q3sUl2vva/jssugSwsKYtV/h+MCJ
	 kuem9fgX+xgvyYThURF8Q6sOoTgRf7GoSh7AfIkT2YqdIOfh1jy67PUP2mh6hn++pU
	 LveDJdYNF2C716guniiCapjF8P86N+I8QapO0tuI9ktGE4p50D1weEwfKDzTUvpIj5
	 KHY8aoMD8/Jvm2LTm93Wx18RJXY0S/c3OPAZvLLdHcJhSrZJcX2Tg3uiqDMlfSN5aI
	 2dj9Ln8qkbdYRKU8EmA43Udz6hJ7zptvULTXzRoHszVRCszt05MXYYAXTI2bKzHCYw
	 DbYZWQpaO0A7g==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso545038766b.3;
        Sun, 20 Apr 2025 00:45:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRXksGGwRM+voRCAr1Xv4aI1v7HS/lrUeofraRAO5Ioi9mNKnTFvbaKqoTl2mlEem0pRuTWXOL6PE7v0ei@vger.kernel.org, AJvYcCWPwMWHNnjfxzmBvzUiHhqf9v4qMazeLhsj25tQYx2mkbRMlrj/DfrfXF6RrdEuHVPlFUo=@vger.kernel.org, AJvYcCXI1RCNl8+/vl0AX2JFgkOrFqJD4lYA43LC0mWI/4oOLxjYR5txw0K8CI7CSmZWUY9Fe3IgjpTK20LmR/we499/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvt1M8kTFzy5leNj2/amzrUO4Ur/AILuhe3aynU8RPreczEvNZ
	tpTo3u6O2Skndw1+gWB1eMBQbSKdzJ/wEHsB+SPaKfVHoxV5eTbUQtqupLm4xdRBVJDC1ak/Kvs
	IheYjQ/gCuq6rNEwIp6m3OJ8T+qs=
X-Google-Smtp-Source: AGHT+IHmVHw7IYy/Cxn8cKAlYtnZLbc4MgJ9ksqd1UMddldzjRkOZtFMvTFShl7KQwLqFCq9LjOJNUZplXAlqtwc6fo=
X-Received: by 2002:a17:907:d7cb:b0:ac7:f348:b8bc with SMTP id
 a640c23a62f3a-acb74e7f708mr731480366b.61.1745135124817; Sun, 20 Apr 2025
 00:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416035455.25996-1-maobibo@loongson.cn> <20250416035455.25996-4-maobibo@loongson.cn>
In-Reply-To: <20250416035455.25996-4-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 20 Apr 2025 15:45:13 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5vggSAjh3oRHh84xi7E3oOBjuXyapMzD-YkQdPRWuiHQ@mail.gmail.com>
X-Gm-Features: ATxdqUHg59zkH_BqZdfcGcwuhYAIOdc3ozfeS_sEI-zPDVMCH7X2Id02iYTefM4
Message-ID: <CAAhV-H5vggSAjh3oRHh84xi7E3oOBjuXyapMzD-YkQdPRWuiHQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] KVM: selftests: Add core KVM selftests support for LoongArch
To: Bibo Mao <maobibo@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Wed, Apr 16, 2025 at 11:55=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> Add core KVM selftests support for LoongArch, it includes exception
> handler, mmu page table setup and vCPU startup entry support.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  .../selftests/kvm/lib/loongarch/exception.S   |  59 +++
>  .../selftests/kvm/lib/loongarch/processor.c   | 347 ++++++++++++++++++
>  2 files changed, 406 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/lib/loongarch/exception.S
>  create mode 100644 tools/testing/selftests/kvm/lib/loongarch/processor.c
>
> diff --git a/tools/testing/selftests/kvm/lib/loongarch/exception.S b/tool=
s/testing/selftests/kvm/lib/loongarch/exception.S
> new file mode 100644
> index 000000000000..88bfa505c6f5
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/loongarch/exception.S
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include "processor.h"
> +
> +/* address of refill exception should be 4K aligned */
> +.balign        4096
> +.global handle_tlb_refill
> +handle_tlb_refill:
> +       csrwr   t0, LOONGARCH_CSR_TLBRSAVE
> +       csrrd   t0, LOONGARCH_CSR_PGD
> +       lddir   t0, t0, 3
> +       lddir   t0, t0, 1
> +       ldpte   t0, 0
> +       ldpte   t0, 1
> +       tlbfill
> +       csrrd   t0, LOONGARCH_CSR_TLBRSAVE
> +       ertn
> +
> +       /*
> +        * save and restore all gprs except base register,
> +        * and default value of base register is sp ($r3).
> +        */
> +.macro save_gprs base
> +       .irp n,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,=
24,25,26,27,28,29,30,31
> +       st.d    $r\n, \base, 8 * \n
> +       .endr
> +.endm
> +
> +.macro restore_gprs base
> +       .irp n,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,=
24,25,26,27,28,29,30,31
> +       ld.d    $r\n, \base, 8 * \n
> +       .endr
> +.endm
> +
> +/* address of general exception should be 4K aligned */
> +.balign        4096
> +.global handle_exception
> +handle_exception:
> +       csrwr  sp, LOONGARCH_CSR_KS0
> +       csrrd  sp, LOONGARCH_CSR_KS1
> +       addi.d sp, sp, -EXREGS_SIZE
> +
> +       save_gprs sp
> +       /* save sp register to stack */
> +       csrrd  t0, LOONGARCH_CSR_KS0
> +       st.d   t0, sp, 3 * 8
> +
> +       csrrd  t0, LOONGARCH_CSR_ERA
> +       st.d   t0, sp, PC_OFFSET_EXREGS
> +       csrrd  t0, LOONGARCH_CSR_ESTAT
> +       st.d   t0, sp, ESTAT_OFFSET_EXREGS
> +       csrrd  t0, LOONGARCH_CSR_BADV
> +       st.d   t0, sp, BADV_OFFSET_EXREGS
> +
> +       or     a0, sp, zero
> +       bl route_exception
> +       restore_gprs sp
> +       csrrd  sp, LOONGARCH_CSR_KS0
> +       ertn
> diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tool=
s/testing/selftests/kvm/lib/loongarch/processor.c
> new file mode 100644
> index 000000000000..8595c38ca26b
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
> @@ -0,0 +1,347 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <assert.h>
> +#include <linux/compiler.h>
> +
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "ucall_common.h"
> +
> +#define LOONGARCH_GUEST_STACK_VADDR_MIN                0x200000
> +#define LOONARCH_PAGE_TABLE_PHYS_MIN           0x200000
I think here is a typo.

Huacai

> +
> +static vm_paddr_t invalid_pgtable[4];
> +static uint64_t virt_pte_index(struct kvm_vm *vm, vm_vaddr_t gva, int le=
vel)
> +{
> +       unsigned int shift;
> +       uint64_t mask;
> +
> +       shift =3D level * (vm->page_shift - 3) + vm->page_shift;
> +       mask =3D (1UL << (vm->page_shift - 3)) - 1;
> +       return (gva >> shift) & mask;
> +}
> +
> +static uint64_t pte_addr(struct kvm_vm *vm, uint64_t entry)
> +{
> +       return entry &  ~((0x1UL << vm->page_shift) - 1);
> +}
> +
> +static uint64_t ptrs_per_pte(struct kvm_vm *vm)
> +{
> +       return 1 << (vm->page_shift - 3);
> +}
> +
> +static void virt_set_pgtable(struct kvm_vm *vm, vm_paddr_t table, vm_pad=
dr_t child)
> +{
> +       uint64_t *ptep;
> +       int i, ptrs_per_pte;
> +
> +       ptep =3D addr_gpa2hva(vm, table);
> +       ptrs_per_pte =3D 1 << (vm->page_shift - 3);
> +       for (i =3D 0; i < ptrs_per_pte; i++)
> +               WRITE_ONCE(*(ptep + i), child);
> +}
> +
> +void virt_arch_pgd_alloc(struct kvm_vm *vm)
> +{
> +       int i;
> +       vm_paddr_t child, table;
> +
> +       if (vm->pgd_created)
> +               return;
> +       child =3D table =3D 0;
> +       for (i =3D 0; i < vm->pgtable_levels; i++) {
> +               invalid_pgtable[i] =3D child;
> +               table =3D vm_phy_page_alloc(vm, LOONARCH_PAGE_TABLE_PHYS_=
MIN,
> +                               vm->memslots[MEM_REGION_PT]);
> +               TEST_ASSERT(table, "Fail to allocate page tale at level %=
d\n", i);
> +               virt_set_pgtable(vm, table, child);
> +               child =3D table;
> +       }
> +       vm->pgd =3D table;
> +       vm->pgd_created =3D true;
> +}
> +
> +static int virt_pte_none(uint64_t *ptep, int level)
> +{
> +       return *ptep =3D=3D invalid_pgtable[level];
> +}
> +
> +static uint64_t *virt_populate_pte(struct kvm_vm *vm, vm_vaddr_t gva, in=
t alloc)
> +{
> +       uint64_t *ptep;
> +       vm_paddr_t child;
> +       int level;
> +
> +       if (!vm->pgd_created)
> +               goto unmapped_gva;
> +
> +       level =3D vm->pgtable_levels - 1;
> +       child =3D vm->pgd;
> +       while (level > 0) {
> +               ptep =3D addr_gpa2hva(vm, child) + virt_pte_index(vm, gva=
, level) * 8;
> +               if (virt_pte_none(ptep, level)) {
> +                       if (alloc) {
> +                               child =3D vm_alloc_page_table(vm);
> +                               virt_set_pgtable(vm, child, invalid_pgtab=
le[level - 1]);
> +                               WRITE_ONCE(*ptep, child);
> +                       } else
> +                               goto unmapped_gva;
> +
> +               } else
> +                       child =3D pte_addr(vm, *ptep);
> +               level--;
> +       }
> +
> +       ptep =3D addr_gpa2hva(vm, child) + virt_pte_index(vm, gva, level)=
 * 8;
> +       return ptep;
> +
> +unmapped_gva:
> +       TEST_FAIL("No mapping for vm virtual address, gva: 0x%lx", gva);
> +       exit(EXIT_FAILURE);
> +}
> +
> +vm_paddr_t addr_arch_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
> +{
> +       uint64_t *ptep;
> +
> +       ptep =3D virt_populate_pte(vm, gva, 0);
> +       TEST_ASSERT(*ptep !=3D 0, "Virtual address vaddr: 0x%lx not mappe=
d\n", gva);
> +
> +       return pte_addr(vm, *ptep) + (gva & (vm->page_size - 1));
> +}
> +
> +void virt_arch_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
> +{
> +       uint32_t prot_bits;
> +       uint64_t *ptep;
> +
> +       TEST_ASSERT((vaddr % vm->page_size) =3D=3D 0,
> +                       "Virtual address not on page boundary,\n"
> +                       "vaddr: 0x%lx vm->page_size: 0x%x", vaddr, vm->pa=
ge_size);
> +       TEST_ASSERT(sparsebit_is_set(vm->vpages_valid,
> +                       (vaddr >> vm->page_shift)),
> +                       "Invalid virtual address, vaddr: 0x%lx", vaddr);
> +       TEST_ASSERT((paddr % vm->page_size) =3D=3D 0,
> +                       "Physical address not on page boundary,\n"
> +                       "paddr: 0x%lx vm->page_size: 0x%x", paddr, vm->pa=
ge_size);
> +       TEST_ASSERT((paddr >> vm->page_shift) <=3D vm->max_gfn,
> +                       "Physical address beyond maximum supported,\n"
> +                       "paddr: 0x%lx vm->max_gfn: 0x%lx vm->page_size: 0=
x%x",
> +                       paddr, vm->max_gfn, vm->page_size);
> +
> +       ptep =3D virt_populate_pte(vm, vaddr, 1);
> +       prot_bits =3D _PAGE_PRESENT | __READABLE | __WRITEABLE | _CACHE_C=
C;
> +       prot_bits |=3D _PAGE_USER;
> +       WRITE_ONCE(*ptep, paddr | prot_bits);
> +}
> +
> +static void pte_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent, ui=
nt64_t page, int level)
> +{
> +       static const char * const type[] =3D { "pte", "pmd", "pud", "pgd"=
};
> +       uint64_t pte, *ptep;
> +
> +       if (level < 0)
> +               return;
> +
> +       for (pte =3D page; pte < page + ptrs_per_pte(vm) * 8; pte +=3D 8)=
 {
> +               ptep =3D addr_gpa2hva(vm, pte);
> +               if (virt_pte_none(ptep, level))
> +                       continue;
> +               fprintf(stream, "%*s%s: %lx: %lx at %p\n",
> +                               indent, "", type[level], pte, *ptep, ptep=
);
> +               pte_dump(stream, vm, indent + 1, pte_addr(vm, *ptep), lev=
el--);
> +       }
> +}
> +
> +void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
> +{
> +       int level;
> +
> +       if (!vm->pgd_created)
> +               return;
> +
> +       level =3D vm->pgtable_levels - 1;
> +       pte_dump(stream, vm, indent, vm->pgd, level);
> +}
> +
> +void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
> +{
> +}
> +
> +void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
> +{
> +       struct ucall uc;
> +
> +       if (get_ucall(vcpu, &uc) !=3D UCALL_UNHANDLED)
> +               return;
> +
> +       TEST_FAIL("Unexpected exception (pc:0x%lx, estat:0x%lx, badv:0x%l=
x)",
> +                       uc.args[0], uc.args[1], uc.args[2]);
> +}
> +
> +void route_exception(struct ex_regs *regs)
> +{
> +       unsigned long pc, estat, badv;
> +
> +       pc =3D regs->pc;
> +       estat =3D regs->estat;
> +       badv  =3D regs->badv;
> +       ucall(UCALL_UNHANDLED, 3, pc, estat, badv);
> +       while (1)
> +               ;
> +}
> +
> +void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
> +{
> +       va_list ap;
> +       struct kvm_regs regs;
> +       int i;
> +
> +       TEST_ASSERT(num >=3D 1 && num <=3D 8, "Unsupported number of args=
,\n"
> +                   "num: %u\n", num);
> +
> +       vcpu_regs_get(vcpu, &regs);
> +       va_start(ap, num);
> +       for (i =3D 0; i < num; i++)
> +               regs.gpr[i + 4] =3D va_arg(ap, uint64_t);
> +       va_end(ap);
> +       vcpu_regs_set(vcpu, &regs);
> +}
> +
> +static void loongarch_get_csr(struct kvm_vcpu *vcpu, uint64_t id, void *=
addr)
> +{
> +       uint64_t csrid;
> +
> +       csrid =3D KVM_REG_LOONGARCH_CSR | KVM_REG_SIZE_U64 | 8 * id;
> +       __vcpu_get_reg(vcpu, csrid, addr);
> +}
> +
> +static void loongarch_set_csr(struct kvm_vcpu *vcpu, uint64_t id, uint64=
_t val)
> +{
> +       uint64_t csrid;
> +
> +       csrid =3D KVM_REG_LOONGARCH_CSR | KVM_REG_SIZE_U64 | 8 * id;
> +       vcpu_set_reg(vcpu, csrid, val);
> +}
> +
> +static void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
> +{
> +       unsigned long val;
> +       int width;
> +       struct kvm_vm *vm =3D vcpu->vm;
> +
> +       switch (vm->mode) {
> +       case VM_MODE_P36V47_16K:
> +       case VM_MODE_P47V47_16K:
> +               break;
> +
> +       default:
> +               TEST_FAIL("Unknown guest mode, mode: 0x%x", vm->mode);
> +       }
> +
> +       /* user mode and page enable mode */
> +       val =3D PLV_USER | CSR_CRMD_PG;
> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_CRMD, val);
> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_PRMD, val);
> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_EUEN, 1);
> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_ECFG, 0);
> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_TCFG, 0);
> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_ASID, 1);
> +
> +       width =3D vm->page_shift - 3;
> +       val =3D 0;
> +       switch (vm->pgtable_levels) {
> +       case 4:
> +               /* pud page shift and width */
> +               val =3D (vm->page_shift + width * 2) << 20 | (width << 25=
);
> +               /* fall throuth */
> +       case 3:
> +               /* pmd page shift and width */
> +               val |=3D (vm->page_shift + width) << 10 | (width << 15);
> +               /* pte page shift and width */
> +               val |=3D vm->page_shift | width << 5;
> +               break;
> +       default:
> +               TEST_FAIL("Got %u page table levels, expected 3 or 4", vm=
->pgtable_levels);
> +       }
> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_PWCTL0, val);
> +
> +       /* PGD page shift and width */
> +       val =3D (vm->page_shift + width * (vm->pgtable_levels - 1)) | wid=
th << 6;
> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_PWCTL1, val);
> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_PGDL, vm->pgd);
> +
> +       /*
> +        * Refill exception runs on real mode
> +        * Entry address should be physical address
> +        */
> +       val =3D addr_gva2gpa(vm, (unsigned long)handle_tlb_refill);
> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_TLBRENTRY, val);
> +
> +       /*
> +        * General exception runs on page-enabled mode
> +        * Entry address should be virtual address
> +        */
> +       val =3D (unsigned long)handle_exception;
> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_EENTRY, val);
> +
> +       loongarch_get_csr(vcpu, LOONGARCH_CSR_TLBIDX, &val);
> +       val &=3D ~CSR_TLBIDX_SIZEM;
> +       val |=3D PS_DEFAULT_SIZE << CSR_TLBIDX_SIZE;
> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_TLBIDX, val);
> +
> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_STLBPGSIZE, PS_DEFAULT_SIZE=
);
> +
> +       /* LOONGARCH_CSR_KS1 is used for exception stack */
> +       val =3D __vm_vaddr_alloc(vm, vm->page_size,
> +                       LOONGARCH_GUEST_STACK_VADDR_MIN, MEM_REGION_DATA)=
;
> +       TEST_ASSERT(val !=3D 0,  "No memory for exception stack");
> +       val =3D val + vm->page_size;
> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_KS1, val);
> +
> +       loongarch_get_csr(vcpu, LOONGARCH_CSR_TLBREHI, &val);
> +       val &=3D ~CSR_TLBREHI_PS;
> +       val |=3D PS_DEFAULT_SIZE << CSR_TLBREHI_PS_SHIFT;
> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_TLBREHI, val);
> +
> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_CPUID, vcpu->id);
> +       loongarch_set_csr(vcpu, LOONGARCH_CSR_TMID,  vcpu->id);
> +}
> +
> +static struct kvm_vcpu *loongarch_vcpu_add(struct kvm_vm *vm, uint32_t v=
cpu_id)
> +{
> +       size_t stack_size;
> +       uint64_t stack_vaddr;
> +       struct kvm_regs regs;
> +       struct kvm_vcpu *vcpu;
> +
> +       vcpu =3D __vm_vcpu_add(vm, vcpu_id);
> +       stack_size =3D vm->page_size;
> +       stack_vaddr =3D __vm_vaddr_alloc(vm, stack_size,
> +                       LOONGARCH_GUEST_STACK_VADDR_MIN, MEM_REGION_DATA)=
;
> +       TEST_ASSERT(stack_vaddr !=3D 0,  "No memory for vm stack");
> +
> +       loongarch_vcpu_setup(vcpu);
> +       /* Setup guest general purpose registers */
> +       vcpu_regs_get(vcpu, &regs);
> +       regs.gpr[3] =3D stack_vaddr + stack_size;
> +       vcpu_regs_set(vcpu, &regs);
> +
> +       return vcpu;
> +}
> +
> +struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
> +{
> +       return loongarch_vcpu_add(vm, vcpu_id);
> +}
> +
> +void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
> +{
> +       struct kvm_regs regs;
> +
> +       /* Setup guest PC register */
> +       vcpu_regs_get(vcpu, &regs);
> +       regs.pc =3D (uint64_t)guest_code;
> +       vcpu_regs_set(vcpu, &regs);
> +}
> --
> 2.39.3
>

