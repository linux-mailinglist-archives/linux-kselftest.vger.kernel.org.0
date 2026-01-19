Return-Path: <linux-kselftest+bounces-49382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8963D3B248
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 17:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DBB730AA834
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 16:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32B938F236;
	Mon, 19 Jan 2026 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zj1i8k90"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAB732E126;
	Mon, 19 Jan 2026 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840661; cv=none; b=J5+sryMyEm6Ml5BjyzdMXRkdVe8ag9py5UJtcx4eqhIYlEjUAOB8xoxfXJ20nl5CMccSpUg2gOhMvJhUxHp0Q7tmVw+UCUt0aLnKQwBIMzvQGm3tzLaolPokayE9o4yXzRv40CxTMo4MeQMY8sZlwNR+JGoDYQ04G8/E7uy+K4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840661; c=relaxed/simple;
	bh=oSn6eeMjVt0BdckSdLlrBsRGgN6O4ooWNqYJ4Q6NUyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emMgdDGMwOspwas1XTBBt6bls6HTNzxOO2Xe8JH56ZlIAVZNXbDE+H4DnhmNg+dizjpsY4wrsXSVQ9DZI2t2tqK3ktO7pI2sat2No+zHZNtIjYjZF2RSaE8TYNrhS3G7bmU+8gDuQNeC8LhJxLmhTEyGgf53e9qzNm2zwG/d8s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zj1i8k90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE2FC116C6;
	Mon, 19 Jan 2026 16:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840661;
	bh=oSn6eeMjVt0BdckSdLlrBsRGgN6O4ooWNqYJ4Q6NUyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zj1i8k90WEUW6SxcQ/g4vVNC85cl4uQEQOL0Ob6m3v6FIChZ2NAPoVxjf5hiyhxFe
	 U+vnzci8BY8Lw0ecSrqIa+cIlqJjcyMlaXkFuGs179r2uOAmVEw3Tw0va566yEsSH2
	 im0reOy9tcxZFXztZnzcFy/DY+B/1XqxdgJbN4SuA4wn3u45qnjdq3NHqijYEgktHu
	 xPdul4mSnLMbjXq3CLvgDsX3hvgRekot1zqBe6jKQ/8c0hQat91jimlcxIfd0QjeZK
	 87DaOV/B+WLHEs9IJsOBBYsuV7YFci0h9sJlUBJAlBmh8E5HDy4vzMFErHpTHmKvtN
	 kFK0j5cnDGzPw==
Date: Mon, 19 Jan 2026 16:37:33 +0000
From: Will Deacon <will@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, maz@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, miko.lenczewski@arm.com,
	kevin.brodsky@arm.com, ardb@kernel.org, suzuki.poulose@arm.com,
	lpieralisi@kernel.org, yangyicong@hisilicon.com,
	scott@os.amperecomputing.com, joey.gouly@arm.com,
	yuzenghui@huawei.com, pbonzini@redhat.com, shuah@kernel.org,
	mark.rutland@arm.com, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 RESEND 6/9] arm64: futex: support futex with FEAT_LSUI
Message-ID: <aW5dzb0ldp8u8Rdm@willie-the-truck>
References: <20251214112248.901769-1-yeoreum.yun@arm.com>
 <20251214112248.901769-7-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214112248.901769-7-yeoreum.yun@arm.com>

On Sun, Dec 14, 2025 at 11:22:45AM +0000, Yeoreum Yun wrote:
> Current futex atomic operations are implemented with ll/sc instructions
> and clearing PSTATE.PAN.
> 
> Since Armv9.6, FEAT_LSUI supplies not only load/store instructions but
> also atomic operation for user memory access in kernel it doesn't need
> to clear PSTATE.PAN bit anymore.
> 
> With theses instructions some of futex atomic operations don't need to
> be implmented with ldxr/stlxr pair instead can be implmented with
> one atomic operation supplied by FEAT_LSUI.
> 
> However, some of futex atomic operation don't have matched
> instructuion i.e) eor or cmpxchg with word size.
> For those operation, uses cas{al}t to implement them.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm64/include/asm/futex.h | 180 ++++++++++++++++++++++++++++++++-
>  1 file changed, 178 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
> index f8cb674bdb3f..6778ff7e1c0e 100644
> --- a/arch/arm64/include/asm/futex.h
> +++ b/arch/arm64/include/asm/futex.h
> @@ -9,6 +9,8 @@
>  #include <linux/uaccess.h>
>  #include <linux/stringify.h>
> 
> +#include <asm/alternative.h>
> +#include <asm/alternative-macros.h>
>  #include <asm/errno.h>
> 
>  #define FUTEX_MAX_LOOPS	128 /* What's the largest number you can think of? */
> @@ -86,11 +88,185 @@ __llsc_futex_cmpxchg(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
>  	return ret;
>  }
> 
> +#ifdef CONFIG_AS_HAS_LSUI
> +
> +/*
> + * When the LSUI feature is present, the CPU also implements PAN, because
> + * FEAT_PAN has been mandatory since Armv8.1. Therefore, there is no need to
> + * call uaccess_ttbr0_enable()/uaccess_ttbr0_disable() around each LSUI
> + * operation.
> + */

I'd prefer not to rely on these sorts of properties because:

  - CPU bugs happen all the time
  - Virtualisation and idreg overrides mean illegal feature combinations
    can show up
  - The architects sometimes change their mind

So let's either drop the assumption that we have PAN if LSUI *or* actually
test that someplace during feature initialisation.

> +
> +#define __LSUI_PREAMBLE	".arch_extension lsui\n"
> +
> +#define LSUI_FUTEX_ATOMIC_OP(op, asm_op, mb)				\
> +static __always_inline int						\
> +__lsui_futex_atomic_##op(int oparg, u32 __user *uaddr, int *oval)	\
> +{									\
> +	int ret = 0;							\
> +	int oldval;							\
> +									\
> +	asm volatile("// __lsui_futex_atomic_" #op "\n"			\
> +	__LSUI_PREAMBLE							\
> +"1:	" #asm_op #mb "	%w3, %w2, %1\n"					\

What's the point in separating the barrier suffix from the rest of the
instruction mnemonic? All the callers use -AL.

> +"2:\n"									\
> +	_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w0)				\
> +	: "+r" (ret), "+Q" (*uaddr), "=r" (oldval)			\
> +	: "r" (oparg)							\
> +	: "memory");							\
> +									\
> +	if (!ret)							\
> +		*oval = oldval;						\
> +									\
> +	return ret;							\
> +}
> +
> +LSUI_FUTEX_ATOMIC_OP(add, ldtadd, al)
> +LSUI_FUTEX_ATOMIC_OP(or, ldtset, al)
> +LSUI_FUTEX_ATOMIC_OP(andnot, ldtclr, al)
> +LSUI_FUTEX_ATOMIC_OP(set, swpt, al)
> +
> +static __always_inline int
> +__lsui_cmpxchg64(u64 __user *uaddr, u64 *oldval, u64 newval)
> +{
> +	int ret = 0;
> +
> +	asm volatile("// __lsui_cmpxchg64\n"
> +	__LSUI_PREAMBLE
> +"1:	casalt	%x2, %x3, %1\n"


How bizarre, they changed the order of the AL and T compared to SWPTAL.
Fair enough...

Also, I don't think you need the 'x' prefix on the 64-bit variables.

> +"2:\n"
> +	_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w0)
> +	: "+r" (ret), "+Q" (*uaddr), "+r" (*oldval)
> +	: "r" (newval)
> +	: "memory");

Don't you need to update *oldval here if the CAS didn't fault?

> +
> +	return ret;
> +}
> +
> +static __always_inline int
> +__lsui_cmpxchg32(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
> +{
> +	u64 __user *uaddr64;
> +	bool futex_on_lo;
> +	int ret = -EAGAIN, i;
> +	u32 other, orig_other;
> +	union {
> +		struct futex_on_lo {
> +			u32 val;
> +			u32 other;
> +		} lo_futex;
> +
> +		struct futex_on_hi {
> +			u32 other;
> +			u32 val;
> +		} hi_futex;
> +
> +		u64 raw;
> +	} oval64, orig64, nval64;
> +
> +	uaddr64 = (u64 __user *) PTR_ALIGN_DOWN(uaddr, sizeof(u64));
> +	futex_on_lo = (IS_ALIGNED((unsigned long)uaddr, sizeof(u64)) ==
> +			IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN));

Just make LSUI depend on !CPU_BIG_ENDIAN in Kconfig. The latter already
depends on BROKEN and so we'll probably drop it soon anyway. There's
certainly no need to care about it for new features and it should simplify
the code you have here if you can assume little-endian.

> +
> +	for (i = 0; i < FUTEX_MAX_LOOPS; i++) {
> +		if (get_user(oval64.raw, uaddr64))
> +			return -EFAULT;

Since oldval is passed to us as an argument, can we get away with a
32-bit get_user() here?

> +
> +		nval64.raw = oval64.raw;
> +
> +		if (futex_on_lo) {
> +			oval64.lo_futex.val = oldval;
> +			nval64.lo_futex.val = newval;
> +		} else {
> +			oval64.hi_futex.val = oldval;
> +			nval64.hi_futex.val = newval;
> +		}
> +
> +		orig64.raw = oval64.raw;
> +
> +		if (__lsui_cmpxchg64(uaddr64, &oval64.raw, nval64.raw))
> +			return -EFAULT;
> +
> +		if (futex_on_lo) {
> +			oldval = oval64.lo_futex.val;
> +			other = oval64.lo_futex.other;
> +			orig_other = orig64.lo_futex.other;
> +		} else {
> +			oldval = oval64.hi_futex.val;
> +			other = oval64.hi_futex.other;
> +			orig_other = orig64.hi_futex.other;
> +		}
> +
> +		if (other == orig_other) {
> +			ret = 0;
> +			break;
> +		}
> +	}
> +
> +	if (!ret)
> +		*oval = oldval;

Shouldn't we set *oval to the value we got back from the CAS?

> +
> +	return ret;
> +}
> +
> +static __always_inline int
> +__lsui_futex_atomic_and(int oparg, u32 __user *uaddr, int *oval)
> +{
> +	return __lsui_futex_atomic_andnot(~oparg, uaddr, oval);

Please a comment about the bitwise negation of oparg here as we're undoing
the one from the caller.

> +}
> +
> +static __always_inline int
> +__lsui_futex_atomic_eor(int oparg, u32 __user *uaddr, int *oval)
> +{
> +	u32 oldval, newval, val;
> +	int ret, i;
> +
> +	/*
> +	 * there are no ldteor/stteor instructions...
> +	 */
> +	for (i = 0; i < FUTEX_MAX_LOOPS; i++) {
> +		if (get_user(oldval, uaddr))
> +			return -EFAULT;
> +
> +		newval = oldval ^ oparg;
> +
> +		ret = __lsui_cmpxchg32(uaddr, oldval, newval, &val);
> +		if (ret)
> +			return ret;
> +
> +		if (val == oldval) {
> +			*oval = val;
> +			return 0;
> +		}
> +	}
> +
> +	return -EAGAIN;
> +}
> +
> +static __always_inline int
> +__lsui_futex_cmpxchg(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
> +{
> +	return __lsui_cmpxchg32(uaddr, oldval, newval, oval);
> +}
> +
> +#define __lsui_llsc_body(op, ...)					\
> +({									\
> +	alternative_has_cap_likely(ARM64_HAS_LSUI) ?			\

This doesn't seem like it should be the "likely" case just yet?

Will

