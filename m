Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02AE6CF45D
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 22:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjC2UTo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 16:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjC2UTn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 16:19:43 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5831BE1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 13:19:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5425c04765dso165847207b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 13:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680121179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XYCjXnCbKN0PKkjf/crQNfbLtlBmvSfxLnNMsYaCJAI=;
        b=Q4fVUhMJZ2VEoEGBOrMdLrJvCAfH4D4nBijG9a2dGjH0LYJ9xtR6jFOClavT+p3WSF
         /ieyUJplRJvO5/il4QvETEhFDZkT9nTWYBJUhyuKSKrrI7fhtMiOeJ6jwrz5N0MF0y9C
         1TLiYnzZTJOOnS/25vbgjaka/Wn2TSTbNEqgusKUZvTx0kpdYvYHub4A/Q05zg6hgGja
         b6+TZ8NFmx2JljIi2jB8nbg2yJu1/jEwPZNkIrPXdHyj7ObBMC8Uj+MomqmFCZsZZon4
         9n2Hw8wSlnhpf0zFC42QRDkvQ9w1Faonq1ucsjy/Hld9+bRisFqjXCpEkJPCqRJ4psrQ
         niFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680121179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYCjXnCbKN0PKkjf/crQNfbLtlBmvSfxLnNMsYaCJAI=;
        b=XokbQUCzr5c8b15Wf09IK+X7JMNMW/PogJAqmgI8jq1gksZCzuPi//rNZ6GDntbtAl
         QRzvtwzAti7c6cXJMqe0kXqbwyxmNDxHedXDtTs4HyksqanAPeB4CvJS97At9cMd6TiW
         O0/Xb+MeGOICJq4H3WNWaB8cpRG2VurKAVoWBR0dY4zs15h9agNWcEYLFxq2q3H4E37q
         CzbtbJiamYHFJkayNdpSg7Sx8/QB88oTIxquAKCya0o676A0I7WvhHrOCy0Uj8WHRyZc
         eHA+5RpKS/+TH3VeQu3oWipzICkeUTNDcpIuEHMHgnBEM11n990WRGr9b97ngef0Kzmb
         dZ2A==
X-Gm-Message-State: AAQBX9cEsd1GB/TdDtnkGqEHEn39bX45UQDDA+30Wg3z+tINfvNRNUsu
        HIaq8LElYTFEnt1d+EYDdJoq6NbuZ2I=
X-Google-Smtp-Source: AKy350ZIV/lRzBXoo6utQ0EIvoOZHHC57nvHhNiap20xqkupn9VmloUhByhO84IhMtiJ4j8NKFaasEDxR3Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:ec12:0:b0:545:bade:c590 with SMTP id
 q18-20020a0dec12000000b00545badec590mr8154846ywn.1.1680121179401; Wed, 29 Mar
 2023 13:19:39 -0700 (PDT)
Date:   Wed, 29 Mar 2023 13:19:37 -0700
In-Reply-To: <20230316031732.3591455-2-npiggin@gmail.com>
Mime-Version: 1.0
References: <20230316031732.3591455-1-npiggin@gmail.com> <20230316031732.3591455-2-npiggin@gmail.com>
Message-ID: <ZCSdWc9te0Noiwo3@google.com>
Subject: Re: [PATCH 1/2] KVM: PPC: Add kvm selftests support for powerpc
From:   Sean Christopherson <seanjc@google.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 16, 2023, Nicholas Piggin wrote:
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 3ea24a5f4c43..28ece960a0bb 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -153,6 +153,7 @@ const char *vm_guest_mode_string(uint32_t i)
>  		[VM_MODE_PXXV48_4K]	= "PA-bits:ANY, VA-bits:48,  4K pages",
>  		[VM_MODE_P47V64_4K]	= "PA-bits:47,  VA-bits:64,  4K pages",
>  		[VM_MODE_P44V64_4K]	= "PA-bits:44,  VA-bits:64,  4K pages",
> +		[VM_MODE_P52V52_64K]	= "PA-bits:52,  VA-bits:52, 64K pages",
>  		[VM_MODE_P36V48_4K]	= "PA-bits:36,  VA-bits:48,  4K pages",
>  		[VM_MODE_P36V48_16K]	= "PA-bits:36,  VA-bits:48, 16K pages",
>  		[VM_MODE_P36V48_64K]	= "PA-bits:36,  VA-bits:48, 64K pages",
> @@ -178,6 +179,7 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
>  	[VM_MODE_PXXV48_4K]	= {  0,  0,  0x1000, 12 },
>  	[VM_MODE_P47V64_4K]	= { 47, 64,  0x1000, 12 },
>  	[VM_MODE_P44V64_4K]	= { 44, 64,  0x1000, 12 },
> +	[VM_MODE_P52V52_64K]	= { 52, 52, 0x10000, 16 },
>  	[VM_MODE_P36V48_4K]	= { 36, 48,  0x1000, 12 },
>  	[VM_MODE_P36V48_16K]	= { 36, 48,  0x4000, 14 },
>  	[VM_MODE_P36V48_64K]	= { 36, 48, 0x10000, 16 },
> @@ -279,6 +281,14 @@ struct kvm_vm *____vm_create(enum vm_guest_mode mode)
>  	case VM_MODE_P44V64_4K:
>  		vm->pgtable_levels = 5;
>  		break;
> +	case VM_MODE_P52V52_64K:
> +#ifdef __powerpc__
> +		TEST_ASSERT(getpagesize() == 64*1024,

This can use SZ_64K (we really need to convert a bunch of open coded stuff...)

> +			    "KVM selftests requires 64K host page size\n");

What is the actual requirement?  E.g. is it that the host and guest page sizes
must match, or is that the selftest setup itself only supports 64KiB pages?  If
it's the former, would it make sense to assert outside of the switch statement, e.g.

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 298c4372fb1a..920813a71be0 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -291,6 +291,10 @@ struct kvm_vm *____vm_create(enum vm_guest_mode mode)
 #ifdef __aarch64__
        if (vm->pa_bits != 40)
                vm->type = KVM_VM_TYPE_ARM_IPA_SIZE(vm->pa_bits);
+#endif
+#ifdef __powerpc__
+       TEST_ASSERT(getpagesize() == vm->page_size, "blah blah blah");
+
 #endif
 
        vm_open(vm);

If it's the latter (selftests limitation), can you add a comment explaining the
limitation?

> +void virt_arch_pgd_alloc(struct kvm_vm *vm)
> +{
> +	struct kvm_ppc_mmuv3_cfg mmu_cfg;
> +	vm_paddr_t prtb, pgtb;
> +	uint64_t *proc_table, *page_table;
> +	size_t pgd_pages;
> +
> +	TEST_ASSERT(vm->mode == VM_MODE_P52V52_64K, "Attempt to use "
> +		"unknown or unsupported guest mode, mode: 0x%x", vm->mode);

Please don't split quoted lines, especially when it's easily avoided, e.g.

	TEST_ASSERT(vm->mode == VM_MODE_P52V52_64K,
		    "PPC doesn't support guest mode '0x%x', vm->mode);

> +
> +	/* If needed, create page table */
> +	if (vm->pgd_created)
> +		return;

Heh, every arch has this.  Any objection to moving the check to virt_pgd_alloc()
as a prep patch?

> +
> +	prtb = vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR,
> +				 vm->memslots[MEM_REGION_PT]);
> +	proc_table = addr_gpa2hva(vm, prtb);
> +	memset(proc_table, 0, vm->page_size);
> +	vm->prtb = prtb;
> +
> +	pgd_pages = 1UL << ((RADIX_PGD_INDEX_SIZE + 3) >> vm->page_shift);
> +	TEST_ASSERT(pgd_pages == 1, "PGD allocation must be single page");
> +	pgtb = vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR,
> +				 vm->memslots[MEM_REGION_PT]);
> +	page_table = addr_gpa2hva(vm, pgtb);
> +	memset(page_table, 0, vm->page_size * pgd_pages);
> +	vm->pgd = pgtb;
> +
> +	/* Set the base page directory in the proc table */
> +	proc_table[0] = cpu_to_be64(pgtb | RTS | RADIX_PGD_INDEX_SIZE);
> +
> +	mmu_cfg.process_table = prtb | 0x8000000000000000UL | 0x4; // 64K size
> +	mmu_cfg.flags = KVM_PPC_MMUV3_RADIX | KVM_PPC_MMUV3_GTSE;
> +
> +	vm_ioctl(vm, KVM_PPC_CONFIGURE_V3_MMU, &mmu_cfg);
> +
> +	vm->pgd_created = true;
> +}
> +
> +static int pt_shift(struct kvm_vm *vm, int level)
> +{
> +	switch (level) {
> +	case 1:
> +		return 13;
> +	case 2:
> +	case 3:
> +		return 9;
> +	case 4:
> +		return 5;
> +	default:
> +		TEST_ASSERT(false, "Invalid page table level %d\n", level);
> +		return 0;
> +	}
> +}
> +
> +static uint64_t pt_entry_coverage(struct kvm_vm *vm, int level)
> +{
> +	uint64_t size = vm->page_size;
> +
> +	if (level == 4)
> +		return size;
> +	size <<= pt_shift(vm, 4);
> +	if (level == 3)
> +		return size;
> +	size <<= pt_shift(vm, 3);
> +	if (level == 2)
> +		return size;
> +	size <<= pt_shift(vm, 2);
> +	return size;
> +}
> +
> +static int pt_idx(struct kvm_vm *vm, uint64_t vaddr, int level, uint64_t *nls)
> +{
> +	switch (level) {
> +	case 1:
> +		*nls = 0x9;
> +		return (vaddr >> 39) & 0x1fff;
> +	case 2:
> +		*nls = 0x9;
> +		return (vaddr >> 30) & 0x1ff;
> +	case 3:
> +// 4K		*nls = 0x9;
> +		*nls = 0x5;
> +		return (vaddr >> 21) & 0x1ff;
> +	case 4:
> +// 4K		return (vaddr >> 12) & 0x1ff;
> +		return (vaddr >> 16) & 0x1f;
> +	default:
> +		TEST_ASSERT(false, "Invalid page table level %d\n", level);
> +		return 0;
> +	}
> +}
> +
> +static uint64_t *virt_get_pte(struct kvm_vm *vm, vm_paddr_t pt,
> +			  uint64_t vaddr, int level, uint64_t *nls)
> +{
> +	uint64_t *page_table = addr_gpa2hva(vm, pt);
> +	int idx = pt_idx(vm, vaddr, level, nls);
> +
> +	return &page_table[idx];
> +}
> +
> +#define PTE_VALID	0x8000000000000000ull
> +#define PTE_LEAF	0x4000000000000000ull
> +#define PTE_REFERENCED	0x0000000000000100ull
> +#define PTE_CHANGED	0x0000000000000080ull
> +#define PTE_PRIV	0x0000000000000008ull
> +#define PTE_READ	0x0000000000000004ull
> +#define PTE_RW		0x0000000000000002ull
> +#define PTE_EXEC	0x0000000000000001ull
> +#define PTE_PAGE_MASK	0x01fffffffffff000ull
> +
> +#define PDE_VALID	PTE_VALID
> +#define PDE_NLS		0x0000000000000011ull
> +#define PDE_PT_MASK	0x0fffffffffffff00ull
> +
> +void virt_arch_pg_map(struct kvm_vm *vm, uint64_t gva, uint64_t gpa)
> +{
> +	vm_paddr_t pt = vm->pgd;
> +	uint64_t *ptep, pte;
> +	int level;
> +
> +	for (level = 1; level <= 3; level++) {
> +		uint64_t nls;
> +		uint64_t *pdep = virt_get_pte(vm, pt, gva, level, &nls);
> +		uint64_t pde = be64_to_cpu(*pdep);
> +		uint64_t *page_table;
> +
> +		if (pde) {
> +			TEST_ASSERT((pde & PDE_VALID) && !(pde & PTE_LEAF),
> +				"Invalid PDE at level: %u gva: 0x%lx pde:0x%lx\n",
> +				level, gva, pde);
> +			pt = pde & PDE_PT_MASK;
> +			continue;
> +		}
> +
> +		// XXX: 64K geometry does not require full pages!
> +		pt = vm_phy_page_alloc(vm,
> +				       KVM_GUEST_PAGE_TABLE_MIN_PADDR,
> +				       vm->memslots[MEM_REGION_PT]);
> +		page_table = addr_gpa2hva(vm, pt);
> +		memset(page_table, 0, vm->page_size);
> +		pde = PDE_VALID | nls | pt;
> +		*pdep = cpu_to_be64(pde);
> +	}
> +
> +	ptep = virt_get_pte(vm, pt, gva, level, NULL);
> +	pte = be64_to_cpu(*ptep);
> +
> +	TEST_ASSERT(!pte,
> +		"PTE already present at level: %u gva: 0x%lx pte:0x%lx\n",
> +		level, gva, pte);
> +
> +	pte = PTE_VALID | PTE_LEAF | PTE_REFERENCED | PTE_CHANGED | PTE_PRIV | PTE_READ | PTE_RW | PTE_EXEC | (gpa & PTE_PAGE_MASK);

Please wrap at 80 chars when it's convenient.  The general/unofficial style in
KVM is to honor the old 80 char limit unless there's a good reason not to.  E.g.
wrapping a line just because the terminating semicolon bumped past 80 is absurd.

> +	*ptep = cpu_to_be64(pte);
> +}
> +
> +vm_paddr_t addr_arch_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
> +{
> +	vm_paddr_t pt = vm->pgd;
> +	uint64_t *ptep, pte;
> +	int level;
> +
> +	for (level = 1; level <= 3; level++) {
> +		uint64_t nls;
> +		uint64_t *pdep = virt_get_pte(vm, pt, gva, level, &nls);
> +		uint64_t pde = be64_to_cpu(*pdep);
> +
> +		TEST_ASSERT((pde & PDE_VALID) && !(pde & PTE_LEAF),
> +			"PDE not present at level: %u gva: 0x%lx pde:0x%lx\n",
> +			level, gva, pde);
> +		pt = pde & PDE_PT_MASK;
> +	}
> +
> +	ptep = virt_get_pte(vm, pt, gva, level, NULL);
> +	pte = be64_to_cpu(*ptep);
> +
> +	TEST_ASSERT(pte,
> +		"PTE not present at level: %u gva: 0x%lx pte:0x%lx\n",
> +		level, gva, pte);
> +
> +	TEST_ASSERT((pte & PTE_VALID) && (pte & PTE_LEAF) && (pte & PTE_READ) && (pte & PTE_RW) && (pte & PTE_EXEC),

Wrap here as well.

> +		"PTE not valid at level: %u gva: 0x%lx pte:0x%lx\n",
> +		level, gva, pte);
> +
> +	return (pte & PTE_PAGE_MASK) + (gva & (vm->page_size - 1));
> +}
> +
> +static void virt_arch_dump_pt(FILE *stream, struct kvm_vm *vm, vm_paddr_t pt, vm_vaddr_t va, int level, uint8_t indent)

And here.  Actually, why bother with the helper?  There's one caller, and that
callers checks pgd_created, i.e. is already assuming its dumping only page tables.
Ooh, nevermind, it's recursive.

Can you drop "arch" from the name?  Selftests uses "arch" to tag functions that
are provided by arch code for use in generic code.

> +{
> +	uint64_t *page_table;
> +	int size, idx;
> +
> +	page_table = addr_gpa2hva(vm, pt);
> +	size = 1U << pt_shift(vm, level);
> +	for (idx = 0; idx < size; idx++) {
> +		uint64_t pte = be64_to_cpu(page_table[idx]);

Newline after variable declaration.

> +		if (pte & PTE_VALID) {
> +			if (pte & PTE_LEAF) {

Curly braces aren't necessary.

> +				fprintf(stream, "%*sgVA:0x%016lx -> gRA:0x%016llx\n", indent, "", va, pte & PTE_PAGE_MASK);

Probably worth wrapping here too.

> +			} else {
> +				virt_arch_dump_pt(stream, vm, pte & PDE_PT_MASK, va, level + 1, indent);
> +			}
> +		}
> +		va += pt_entry_coverage(vm, level);

The shift is constant for vm+level, correct?  In that case, can't this be written
as

	for (idx = 0; idx < size; idx++, va += va_coverage) {

or even without a snapshot

	for (idx = 0; idx < size; idx++, va += pt_entry_coverage(vm, level)) {

That would allow

		if (!(pte & PTE_VALID)
			continue

to reduce the indentation of the printing.

> +	}
> +
> +}
> +
> +void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
> +{
> +	vm_paddr_t pt = vm->pgd;
> +
> +	if (!vm->pgd_created)
> +		return;
> +
> +	virt_arch_dump_pt(stream, vm, pt, 0, 1, indent);
> +}
> +
> +struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
> +				  void *guest_code)
> +{
> +	size_t stack_size =  64*1024;

SZ_64K

> +	uint64_t stack_vaddr;
> +	struct kvm_regs regs;
> +	struct kvm_vcpu *vcpu;
> +	uint64_t lpcr;
> +
> +	TEST_ASSERT(vm->page_size == 64*1024, "Unsupported page size: 0x%x",

SZ_64K

> +		    vm->page_size);
> +
> +	stack_vaddr = __vm_vaddr_alloc(vm, stack_size,
> +				       DEFAULT_GUEST_STACK_VADDR_MIN,
> +				       MEM_REGION_DATA);
> +
> +	vcpu = __vm_vcpu_add(vm, vcpu_id);
> +
> +	vcpu_enable_cap(vcpu, KVM_CAP_PPC_PAPR, 1);
> +
> +	/* Setup guest registers */
> +	vcpu_regs_get(vcpu, &regs);
> +	vcpu_get_reg(vcpu, KVM_REG_PPC_LPCR_64, &lpcr);
> +
> +	regs.pc = (uintptr_t)guest_code;
> +	regs.gpr[12] = (uintptr_t)guest_code;
> +	regs.msr = 0x8000000002103032ull;
> +	regs.gpr[1] = stack_vaddr + stack_size - 256;
> +
> +	if (BYTE_ORDER == LITTLE_ENDIAN) {
> +		regs.msr |= 0x1; // LE
> +		lpcr |= 0x0000000002000000; // ILE

Would it be appropriate to add #defines to processor.h instead of open coding the
magic numbers?

> +	} else {
> +		lpcr &= ~0x0000000002000000; // !ILE
> +	}
> +
> +	vcpu_regs_set(vcpu, &regs);
> +	vcpu_set_reg(vcpu, KVM_REG_PPC_LPCR_64, lpcr);
> +
> +	return vcpu;
> +}
> +
> +void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
> +{
> +	va_list ap;
> +	struct kvm_regs regs;
> +	int i;
> +
> +	TEST_ASSERT(num >= 1 && num <= 5, "Unsupported number of args,\n"

Newlines in TEST_ASSERT() usually lead to weird formatting.

> +		    "  num: %u\n",

No quoted line wrap please.  And in this case, not wrapping is better IMO.

	TEST_ASSERT(num >= 1 && num <= 5, "Unsupported number of args: %u", num);

> +		    num);
> +
> +	va_start(ap, num);
> +	vcpu_regs_get(vcpu, &regs);
> +
> +	for (i = 0; i < num; i++)
> +		regs.gpr[i + 3] = va_arg(ap, uint64_t);
> +
> +	vcpu_regs_set(vcpu, &regs);
> +	va_end(ap);
> +}
