Return-Path: <linux-kselftest+bounces-49381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BCBD3AFE0
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 17:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5605A30C8C4E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 15:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D0D38BF97;
	Mon, 19 Jan 2026 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/vIYDzJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C6238BF66;
	Mon, 19 Jan 2026 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768838244; cv=none; b=UzMyVwgDJ7ETUlOFJ4nRPaMwieF7+IZwSgdpYrzuaFvsJ0jLQ4uNoOc/N0tk1d4S/ovEA092Xp9QjkTQEER1sKKtO4BzJ7ILdAJMfjJ7KofRRsn1mTQ7nSNSmUUnkqUg6P6yG7l5QCvXD1IXgQTDCnShikgeWCnA32gAjyZaMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768838244; c=relaxed/simple;
	bh=bEBSCZfXLR1tJf1vwoAqITNqg+ipt9Ps9iqCK6K38wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8tFqkIqgHhBfgIp4jaZcdz+iO6ckZPEHs3vsHrD3NHR5MfVakPVHiI5s8g9iXfaAdzcNLdJu0/7qXNcXMXHnmn+ORr1Ee35ststowFqCLrS4mOq8EZM3Raz82tY8uN1pOJ7J06lrrg2mzSM2dOaD4Rrfbdo2/BQoQ1MkgkTpFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/vIYDzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A002EC116C6;
	Mon, 19 Jan 2026 15:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768838243;
	bh=bEBSCZfXLR1tJf1vwoAqITNqg+ipt9Ps9iqCK6K38wU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o/vIYDzJ2uTrb2kbHa5FfDunUeBlmLEU0PhnTOPodO4bYqwWwlCiUTlpv+80WfWJE
	 bon8nQLNe5/SVPp8zumiJiuIkFH9371fc3BqrS4WlvBjS9HpQEiYwArT/7hKvIA96P
	 mPfUUBxcgFIaPk7pIdu4badTWfKPkkqwn7eVsHo4loM16n+/E6BTmxBjtuWqYBNBuq
	 ++s+W/ZXUqHX79XVEvxb0znwB1Ehhbwe234Zas1r2hFcGNzTHdlHHvAmDyMkll/bkn
	 7v9M9QTsm0cJspiTgu4gU7vzhTnEm1oQDLIgRmBdb0fBvqFQAnZ5md3wsyNdJCi7ap
	 w6PCbttDE3tQg==
Date: Mon, 19 Jan 2026 15:57:16 +0000
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
Subject: Re: [PATCH v11 RESEND 5/9] arm64: futex: refactor futex atomic
 operation
Message-ID: <aW5UXFz-TykfkGpV@willie-the-truck>
References: <20251214112248.901769-1-yeoreum.yun@arm.com>
 <20251214112248.901769-6-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214112248.901769-6-yeoreum.yun@arm.com>

On Sun, Dec 14, 2025 at 11:22:44AM +0000, Yeoreum Yun wrote:
> Refactor futex atomic operations using ll/sc method with
> clearing PSTATE.PAN to prepare to apply FEAT_LSUI on them.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/futex.h | 128 +++++++++++++++++++++------------
>  1 file changed, 82 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
> index bc06691d2062..f8cb674bdb3f 100644
> --- a/arch/arm64/include/asm/futex.h
> +++ b/arch/arm64/include/asm/futex.h
> @@ -7,17 +7,21 @@
> 
>  #include <linux/futex.h>
>  #include <linux/uaccess.h>
> +#include <linux/stringify.h>
> 
>  #include <asm/errno.h>
> 
>  #define FUTEX_MAX_LOOPS	128 /* What's the largest number you can think of? */
> 
> -#define __futex_atomic_op(insn, ret, oldval, uaddr, tmp, oparg)		\
> -do {									\
> +#define LLSC_FUTEX_ATOMIC_OP(op, insn)					\
> +static __always_inline int						\
> +__llsc_futex_atomic_##op(int oparg, u32 __user *uaddr, int *oval)	\
> +{									\
>  	unsigned int loops = FUTEX_MAX_LOOPS;				\
> +	int ret, oldval, tmp;						\
>  									\
>  	uaccess_enable_privileged();					\
> -	asm volatile(							\
> +	asm volatile("// __llsc_futex_atomic_" #op "\n"			\
>  "	prfm	pstl1strm, %2\n"					\
>  "1:	ldxr	%w1, %2\n"						\
>  	insn "\n"							\
> @@ -35,45 +39,103 @@ do {									\
>  	: "r" (oparg), "Ir" (-EAGAIN)					\
>  	: "memory");							\
>  	uaccess_disable_privileged();					\
> -} while (0)
> +									\
> +	if (!ret)							\
> +		*oval = oldval;						\
> +									\
> +	return ret;							\
> +}
> +
> +LLSC_FUTEX_ATOMIC_OP(add, "add	%w3, %w1, %w5")
> +LLSC_FUTEX_ATOMIC_OP(or,  "orr	%w3, %w1, %w5")
> +LLSC_FUTEX_ATOMIC_OP(and, "and	%w3, %w1, %w5")
> +LLSC_FUTEX_ATOMIC_OP(eor, "eor	%w3, %w1, %w5")
> +LLSC_FUTEX_ATOMIC_OP(set, "mov	%w3, %w5")

Since you're reworking this code, how about we take the opportunity to
use named arguments instead of the numbers?

Will

