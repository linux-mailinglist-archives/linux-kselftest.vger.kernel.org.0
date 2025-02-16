Return-Path: <linux-kselftest+bounces-26747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB9CA3752D
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 16:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFD316E8CC
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 15:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FDD156236;
	Sun, 16 Feb 2025 15:42:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E45E567;
	Sun, 16 Feb 2025 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739720525; cv=none; b=TG3u3NDTCdAOpJiKEDGSyLhKiUd0RDfkhLypLsOjDGmJYsD3KhTMNVsgFjBoKeVAxi8dsVXlmvJzoXfj25LrwAm3iLPbnhPfJv9cGHtFYURQ4Ech1m1vFRAOM1BoO5J/2DHGB8npymumwPjp1q/YvOfuZobntjR0hKnrf7ClxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739720525; c=relaxed/simple;
	bh=eSzKgV/qkiFhJkkCzIQX0Z+jgrhpsUclZiqEZFUe9z8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EFQJUbTnxvYto+4BOb/tXtV9PUBj9VyNfNCQxGKIklex8K82YjSoI6uZZ+j9Zuzlg51sMkAEfBzLXug98xAEAoIQIZLBf2JVZ/e6Bree1JDMB8PKZp/709boCP1YxQb6dTLXYvQK0/RfwhuUJTpCOiNz95gxtOuGLnCHjagLc80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 5DB2792009C; Sun, 16 Feb 2025 16:41:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 574B892009B;
	Sun, 16 Feb 2025 15:41:55 +0000 (GMT)
Date: Sun, 16 Feb 2025 15:41:55 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    linux-mips@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] tools/nolibc: add support for N64 and N32 ABIs
In-Reply-To: <20250212-nolibc-mips-n32-v1-1-6892e58d1321@weissschuh.net>
Message-ID: <alpine.DEB.2.21.2502161523290.65342@angie.orcam.me.uk>
References: <20250212-nolibc-mips-n32-v1-1-6892e58d1321@weissschuh.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 12 Feb 2025, Thomas Weißschuh wrote:

> diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
> index 753a8ed2cf695f0b5eac4b5e4d317fdb383ebf93..638520a3427a985fdbd5f5a49b55853bbadeee75 100644
> --- a/tools/include/nolibc/arch-mips.h
> +++ b/tools/include/nolibc/arch-mips.h
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
> +		"daddiu $sp, $sp, -8\n"  /* space for .cprestore to store $gp              */
> +		".cpsetup $ra, 0, 1b\n"
> +		"li    $t0, -16\n"
> +		"and   $sp, $sp, $t0\n"  /* $sp must be 16-byte aligned                    */
> +#endif

 Why is this code breaking stack alignment just to have to fix it up two 
instructions down the line?  Or is it that the incoming $sp is not aligned 
in the first place (in which case we're having a deeper problem).

> +
> +		/* ABI requires current function address in $t9 */
> +#if defined(_ABIO32) || defined(_ABIN32)
> +		"lui $t9, %hi(_start_c)\n"
>  		"ori $t9, %lo(_start_c)\n"
> +#else
> +		"lui  $t9, %highest(_start_c)\n"
> +		"ori  $t9, %higher(_start_c)\n"
> +		"dsll $t9, 0x10\n"
> +		"ori  $t9, %hi(_start_c)\n"
> +		"dsll $t9, 0x10\n"
> +		"ori  $t9, %lo(_start_c)\n"

 This could be optimised using a temporary (e.g. $at, but I guess any will 
do as I gather we don't have any ABI abnormalities here).

> +#endif
> +
>  		"jalr $t9\n"             /* transfer to c runtime
> */
>  		" nop\n"                 /* delayed slot

 On an unrelated matter JALR above ought to be JAL (or otherwise there's 
no point in using the .cprestore pseudo-op).  And I fail to see why this 
code has to be "noreorder" (except for the .cpload piece, of course), it's 
just asking for troubles.

  Maciej

