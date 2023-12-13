Return-Path: <linux-kselftest+bounces-1598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9FB80D8EE
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 19:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B911F21A75
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 18:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD7651C5E;
	Mon, 11 Dec 2023 18:49:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C465102A;
	Mon, 11 Dec 2023 18:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9584DC433C8;
	Mon, 11 Dec 2023 18:49:39 +0000 (UTC)
Date: Mon, 11 Dec 2023 18:49:37 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com, broonie@kernel.org,
	dave.hansen@linux.intel.com, maz@kernel.org, oliver.upton@linux.dev,
	shuah@kernel.org, will@kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v3 14/25] arm64: implement PKEYS support
Message-ID: <ZXdZwRcc0BaEq-Uv@arm.com>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
 <20231124163510.1835740-15-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124163510.1835740-15-joey.gouly@arm.com>

On Fri, Nov 24, 2023 at 04:34:59PM +0000, Joey Gouly wrote:
> @@ -211,11 +212,24 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>  {
>  	atomic64_set(&mm->context.id, 0);
>  	refcount_set(&mm->context.pinned, 0);
> +
> +	// pkey 0 is the default, so always reserve it.
> +	mm->context.pkey_allocation_map = 0x1;

Nit: use /* */ style comments.

> @@ -151,7 +170,9 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>   * PTE_VALID bit set.
>   */
>  #define pte_access_permitted(pte, write) \
> -	(((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER)) && (!(write) || pte_write(pte)))
> +	(((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER)) && \
> +	 (!(write) || pte_write(pte)) && \
> +	 por_el0_allows_pkey(FIELD_GET(PTE_PO_IDX_MASK, pte_val(pte)), write, false))

Do not change pte_access_permitted(), just let it handle the base
permissions. This check is about the mm tables, not some current POR_EL0
setting of the thread.

As an example, with this change Linux may decide not to clear the MTE
tags just because the current POR_EL0 says no-access. The thread
subsequently changes POR_EL0 and it can read the stale tags.

I haven't checked what x86 and powerpc do here. There may be some
implications on GUP but I'd rather ignore POE for this case.

>  #define pmd_access_permitted(pmd, write) \
>  	(pte_access_permitted(pmd_pte(pmd), (write)))
>  #define pud_access_permitted(pud, write) \
> diff --git a/arch/arm64/include/asm/pkeys.h b/arch/arm64/include/asm/pkeys.h
> index 5761fb48fd53..a80c654da93d 100644
> --- a/arch/arm64/include/asm/pkeys.h
> +++ b/arch/arm64/include/asm/pkeys.h
[...]
>  static inline int execute_only_pkey(struct mm_struct *mm)
>  {
> +	// Execute-only mappings are handled by EPAN/FEAT_PAN3.
> +	WARN_ON_ONCE(!cpus_have_final_cap(ARM64_HAS_EPAN));
> +
>  	return -1;
>  }

Why the WARN_ON_ONCE() here? It will trigger if the user asks for
PROT_EXEC and I can't see any subsequent patch that changes the core
code not to call it. I think we need some arch_has_execute_only_pkey()
to avoid going on this path. Our arch would support exec-only with any
pkey.

> @@ -1490,6 +1491,38 @@ void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte
>  #ifdef CONFIG_ARCH_HAS_PKEYS
>  int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long init_val)
>  {
> -	return -ENOSPC;
> +	u64 new_por = POE_RXW;
> +	u64 old_por;
> +	u64 pkey_shift;
> +
> +	if (!arch_pkeys_enabled())
> +		return -ENOSPC;
> +
> +	/*
> +	 * This code should only be called with valid 'pkey'
> +	 * values originating from in-kernel users.  Complain
> +	 * if a bad value is observed.
> +	 */
> +	if (WARN_ON_ONCE(pkey >= arch_max_pkey()))
> +		return -EINVAL;
> +
> +	/* Set the bits we need in POR:  */
> +	if (init_val & PKEY_DISABLE_ACCESS)
> +		new_por = POE_X;

Does PKEY_DISABLE_ACCESS mean allow execute? Or does x86 not have a way
to disable execution?

> +	else if (init_val & PKEY_DISABLE_WRITE)
> +		new_por = POE_RX;
> +
> +	/* Shift the bits in to the correct place in POR for pkey: */
> +	pkey_shift = pkey * POR_BITS_PER_PKEY;
> +	new_por <<= pkey_shift;
> +
> +	/* Get old POR and mask off any old bits in place: */
> +	old_por = read_sysreg_s(SYS_POR_EL0);
> +	old_por &= ~(POE_MASK << pkey_shift);
> +
> +	/* Write old part along with new part: */
> +	write_sysreg_s(old_por | new_por, SYS_POR_EL0);
> +
> +	return 0;
>  }
>  #endif

-- 
Catalin

