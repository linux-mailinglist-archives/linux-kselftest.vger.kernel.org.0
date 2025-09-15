Return-Path: <linux-kselftest+bounces-41472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ACDB57419
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 11:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0136C3ABCB5
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 09:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF302E9EC0;
	Mon, 15 Sep 2025 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="YF9Gvzw1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0FB27604E;
	Mon, 15 Sep 2025 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927276; cv=none; b=k3RQUlsnb3wdW/rXZ7Z585qRW0c2Ve0gCBjsevZWBfA2UjkmmGEZi2RSNXMVwdTq5McNguUE2wW3TXCPQP60ouVX+fuZxiEHcwGsZTRI74ifLN+RtfELJK2i9zMTDSneMhVJvvGVgzQ7OyK2G4n6whrwCmptbP36XK9LMl7De6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927276; c=relaxed/simple;
	bh=4yuYGuUCG9ZnWQ/ykpURTCRtVPfeMJh0JSqCuvBp7Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjZjXZsWCDNG7RC55B5X0+YArK1S/VK7xVMoT1aIim2C0bgvgVwW5vrLtv6SORzX5f4JTN90k+dbDCMWE2X2KJnqVKAXjFRDfFrbaTuyWGZhCF6OZ9tJOD/2G0r9BGCxgY2XaQPxDDvk5rGqNWlqv3zusaOC2vM223AKg95pejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=YF9Gvzw1; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757927271;
	bh=4yuYGuUCG9ZnWQ/ykpURTCRtVPfeMJh0JSqCuvBp7Jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YF9Gvzw1617gAlI8HLr3bJP6ANZID1fqEojln0udCjl7467q7pSw5zRbQImSH4vfK
	 Je+2cwfLzNkXwZXT/ZeC6bqG4z5nVsZUYlKzPfmrdXsAvCJBPshS3yvJeM8i75jbGH
	 zsHsfMMe0Y7HkyAQkM0zDWM5jnsSL4mxjEZonTMA=
Date: Mon, 15 Sep 2025 11:07:51 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 9/9] um: switch ptrace FP register access to nolibc
Message-ID: <5502ceaf-0b40-4961-b9ba-0c5e63498778@t-8ch.de>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
 <20250915071115.1429196-10-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915071115.1429196-10-benjamin@sipsolutions.net>

On 2025-09-15 09:11:15+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> The registers.c file only contain the routines for floating point
> register access in ptrace mode and initial size detection. The file can
> be moved over to nolibc by replacing the ptrace libc call with a simple
> wrapper that does a direct syscall.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  arch/x86/um/os-Linux/Makefile    |  5 ++++-
>  arch/x86/um/os-Linux/registers.c | 22 ++++++++--------------
>  2 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/um/os-Linux/Makefile b/arch/x86/um/os-Linux/Makefile
> index 77a308aaa5ec..d37320430822 100644
> --- a/arch/x86/um/os-Linux/Makefile
> +++ b/arch/x86/um/os-Linux/Makefile
> @@ -3,10 +3,13 @@
>  # Licensed under the GPL
>  #
>  
> -obj-y = registers.o mcontext.o
> +obj-y = mcontext.o
>  
>  obj-$(CONFIG_X86_32) += tls.o
>  
>  USER_OBJS := $(obj-y)
>  
> +obj-y += registers.o
> +NOLIBC_OBJS := registers.o
> +
>  include $(srctree)/arch/um/scripts/Makefile.rules
> diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
> index eb1cdadc8a61..55bce0d3f5d2 100644
> --- a/arch/x86/um/os-Linux/registers.c
> +++ b/arch/x86/um/os-Linux/registers.c
> @@ -6,18 +6,20 @@
>  
>  #include <errno.h>

Given that you are explicitly disabling errno support for nolibc, is
this include necessary?

>  #include <stdlib.h>
> -#include <sys/ptrace.h>
> +#include <linux/ptrace.h>
>  #ifdef __i386__
>  #include <sys/user.h>
>  #endif
>  #include <longjmp.h>
>  #include <sysdep/ptrace_user.h>
> -#include <sys/uio.h>
> +#include <linux/uio.h>

It looks fairly trivial to add sys/uio.h to nolibc.
Only 'struct iovec' (already provided by the UAPI) and readv()/writev()
are necessary.

>  #include <asm/sigcontext.h>
>  #include <linux/elf.h>
>  #include <registers.h>
>  #include <sys/mman.h>
>  
> +#define my_ptrace(...) my_syscall4(__NR_ptrace, __VA_ARGS__)

Why not add sys/ptrace.h to nolibc and then use sys_ptrace()?
In general I'm not a fan of the my_syscall() naming scheme and would
like to change this in nolibc itself, so having fewer external users
would be nice.

> +
>  static unsigned long ptrace_regset;
>  unsigned long host_fp_size;

(...)

