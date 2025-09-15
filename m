Return-Path: <linux-kselftest+bounces-41470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE1CB573BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 10:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933C5188B8C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 08:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D328F2F1FE2;
	Mon, 15 Sep 2025 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Fl+1jpAq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4032D5C61;
	Mon, 15 Sep 2025 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926547; cv=none; b=dq2lctV7AONEgwVDz4I7uujWuI4oCkXZSjnsD0elV50FLKWDTd1ja3TVrFMJkhNHXituWEQaFGMfWAilRwX5mY0K8qFTmZKVmSc6Twd/4KRHr2P7Ry9cshhaWmlsu/LrE25etH0fFviw6J6qMV8yBXsceJxu6/x69s/R58/dFIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926547; c=relaxed/simple;
	bh=wumQeK4aV33ZODZF7p8zwB+eZepT7/KIxwdWnzj3rqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbEumzWtCDvyL8LhS75Jdn7JgCTTD8lhxVY9TN216+zUFyvfrAd5zV8Pb989CePNKv+nwzHvb8KpQoHj5AypbPd1HOox9pQF77BhLPCu5xDtFP4ny3XspZCcR8Bv0lMrJqKPuiy9cOLglP1T5r7Ib7Sx1jXS+Mfa0xzVrSunisU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Fl+1jpAq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757926543;
	bh=wumQeK4aV33ZODZF7p8zwB+eZepT7/KIxwdWnzj3rqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fl+1jpAqH0FHqqwTKgrcFGzynJRpfwmNC9e7CqhsJUTZNS2/RFX8fZVfYPLvq2uJx
	 463NTzafmNeUbz8S3a0LCQEKfqBENv+q7Zuc380YZIsfnZLX+a8VzigQ4PS7W9l0li
	 Tn+Dxqjr1ykhhB/Tyq44MeGJheZsWced8yXw9lxg=
Date: Mon, 15 Sep 2025 10:55:44 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 6/9] tools/nolibc: add option to disable startup code
Message-ID: <e2f2b0e3-a72d-4b6f-9677-02de711b7d3a@t-8ch.de>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
 <20250915071115.1429196-7-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915071115.1429196-7-benjamin@sipsolutions.net>

On 2025-09-15 09:11:12+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> In principle, it is possible to use nolibc for only some object files in
> a program. In that case, the startup code in _start and _start_c is not
> going to be used. Add the NOLIBC_NO_STARTCODE compile time option to
> disable it entirely and also remove anything that depends on it.

Not a big fan of the naming. More than only _start()/_start_c() are
disabled. Maybe NOLIBC_NO_RUNTIME?  I'm horrible at naming...

> Doing this avoids warnings from modpost for UML as the _start_c code
> references the main function from the .init.text section while it is not
> inside .init itself.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  tools/include/nolibc/arch-arm.h       | 2 ++
>  tools/include/nolibc/arch-arm64.h     | 2 ++
>  tools/include/nolibc/arch-loongarch.h | 2 ++
>  tools/include/nolibc/arch-m68k.h      | 2 ++
>  tools/include/nolibc/arch-mips.h      | 2 ++
>  tools/include/nolibc/arch-powerpc.h   | 2 ++
>  tools/include/nolibc/arch-riscv.h     | 2 ++
>  tools/include/nolibc/arch-s390.h      | 2 ++
>  tools/include/nolibc/arch-sh.h        | 2 ++
>  tools/include/nolibc/arch-sparc.h     | 2 ++
>  tools/include/nolibc/arch-x86.h       | 4 ++++
>  tools/include/nolibc/crt.h            | 3 +++
>  tools/include/nolibc/stackprotector.h | 2 ++
>  tools/include/nolibc/stdlib.h         | 2 ++
>  tools/include/nolibc/sys.h            | 3 ++-
>  tools/include/nolibc/sys/auxv.h       | 3 +++
>  16 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
> index 1f66e7e5a444..24ad348cc1e8 100644
> --- a/tools/include/nolibc/arch-arm.h
> +++ b/tools/include/nolibc/arch-arm.h
> @@ -185,6 +185,7 @@
>  })
>  
>  /* startup code */
> +#ifndef NOLIBC_NO_STARTCODE

I'd prefer the ifdef around the comments.

>  void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
>  {
>  	__asm__ volatile (
> @@ -193,5 +194,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
>  	);
>  	__nolibc_entrypoint_epilogue();
>  }
> +#endif /* NOLIBC_NO_STARTCODE */

(...)

