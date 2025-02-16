Return-Path: <linux-kselftest+bounces-26740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60852A373A5
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 10:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B7E3A4ECC
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 09:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11521422A8;
	Sun, 16 Feb 2025 09:49:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CB1290F;
	Sun, 16 Feb 2025 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699387; cv=none; b=YSQn7MrJU8JhXsVxJzTubgBPjTGEllYfycVHSHJnoRbCIHGI3TtNF+Z2QS/PkPl4RdxuRMhTDYxiuxaqoOIrXfkKBWXQReEOcReV338JaZRbb9wA3wR/h+0WzBMfenp6qtagoYWHo5pbYBUz6bEWFiLxYY0TdHj+N4lzu+Kjg5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699387; c=relaxed/simple;
	bh=ExHWyYT+VUwOuUINOYWJzmyr5lzt9j/8pLe6kjE1TT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxZSqaRV9hLqlca9SZvwsS2dTW49Rkx8uXkghBJsHurc/dNuYbDLRQNsf0f+QOOTUvEve5okIm9oBwgyMefqzHHKa3HUNl9JAdWmnmGiwJgl+KmA/Zw1rYAxKHtFkAIMJHXnmpONCYYPoCK+GpaU9tNa18QGkm9TSZtobInlZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 51G9nc24002324;
	Sun, 16 Feb 2025 10:49:38 +0100
Date: Sun, 16 Feb 2025 10:49:38 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mips@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] tools/nolibc: add support for N64 and N32 ABIs
Message-ID: <20250216094938.GB2192@1wt.eu>
References: <20250212-nolibc-mips-n32-v1-1-6892e58d1321@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250212-nolibc-mips-n32-v1-1-6892e58d1321@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Feb 12, 2025 at 07:49:53PM +0100, Thomas Weißschuh wrote:
> +#if defined(_ABIO32)
> +
>  #define _NOLIBC_SYSCALL_CLOBBERLIST \
>  	"memory", "cc", "at", "v1", "hi", "lo", \
>  	"t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"
> +#define _NOLIBC_SYSCALL_STACK_RESERVE "addiu $sp, $sp, -32\n"
> +#define _NOLIBC_SYSCALL_STACK_UNRESERVE "addiu $sp, $sp, 32\n"
> +
> +#elif defined(_ABIN32) || defined(_ABI64)
> +
> +/* binutils, GCC and clang disagree about register aliases, use numbers instead. */

Is this often encountered despite this ? I guess it can cause portability
issues :-/

> +#if defined(_ABIO32)
> +
>  #define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
>  ({                                                                            \
>  	register long _num __asm__ ("v0") = (num);                            \
(...)
> @@ -178,6 +201,50 @@
>  	_arg4 ? -_num : _num;                                                 \
>  })
>  
> +#else
> +

Here you should indicate which ABI is covered by this #else, because one
has to go up to previous definitions to figure it's _ABIN32 and _ABI64.

> +#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
> +({                                                                            \
> +	register long _num __asm__ ("v0") = (num);                            \
> +	register long _arg1 __asm__ ("$4") = (long)(arg1);                    \
> +	register long _arg2 __asm__ ("$5") = (long)(arg2);                    \
> +	register long _arg3 __asm__ ("$6") = (long)(arg3);                    \
> +	register long _arg4 __asm__ ("$7") = (long)(arg4);                    \
> +	register long _arg5 __asm__ ("$8") = (long)(arg5);                    \
(...)
> @@ -190,13 +257,33 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector __
>  		"1:\n"
>  		".cpload $ra\n"
>  		"move  $a0, $sp\n"       /* save stack pointer to $a0, as arg1 of _start_c */
> +
> +#if defined(_ABIO32)
>  		"addiu $sp, $sp, -4\n"   /* space for .cprestore to store $gp              */
>  		".cprestore 0\n"
>  		"li    $t0, -8\n"
>  		"and   $sp, $sp, $t0\n"  /* $sp must be 8-byte aligned                     */
>  		"addiu $sp, $sp, -16\n"  /* the callee expects to save a0..a3 there        */
> -		"lui $t9, %hi(_start_c)\n" /* ABI requires current function address in $t9 */
> +#else

So same here. I think you should do it for all #else since you're generally
grouping 2 ABIs vs one between a #if and a #else and it's not trivial to
figure what a #else covers, like below.

> +		"daddiu $sp, $sp, -8\n"  /* space for .cprestore to store $gp              */
> +		".cpsetup $ra, 0, 1b\n"
> +		"li    $t0, -16\n"
> +		"and   $sp, $sp, $t0\n"  /* $sp must be 16-byte aligned                    */
> +#endif
> +
> +		/* ABI requires current function address in $t9 */
> +#if defined(_ABIO32) || defined(_ABIN32)
> +		"lui $t9, %hi(_start_c)\n"
>  		"ori $t9, %lo(_start_c)\n"
> +#else

This one indeed covers only _ABI64

> +		"lui  $t9, %highest(_start_c)\n"
> +		"ori  $t9, %higher(_start_c)\n"
> +		"dsll $t9, 0x10\n"
> +		"ori  $t9, %hi(_start_c)\n"
> +		"dsll $t9, 0x10\n"
> +		"ori  $t9, %lo(_start_c)\n"
> +#endif

With the tiny details above, this looks fine. It's great that syscall
numbers didn't change so that you can cover an extra arch with only a
few ifdefs. I have not tested but I guess you did :-) So that's OK for
me:

Acked-by: Willy Tarreau <w@1wt.eu>

Thanks!
Willy

