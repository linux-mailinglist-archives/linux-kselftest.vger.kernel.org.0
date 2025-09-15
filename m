Return-Path: <linux-kselftest+bounces-41471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9CFB573F9
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 11:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4B1171EBD
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 09:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0FA2EA730;
	Mon, 15 Sep 2025 08:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IjnophdE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3691400C;
	Mon, 15 Sep 2025 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926674; cv=none; b=ZFi6b3mcDg5hGEsQ5WXI/CNL/PCb3Z43i8xc1KvmOuZSjeA909L7f+U/zLm87R+ytpfkLpa6qUCX5Qr5Q7MgiGhhefl1oh6fIndd3RPqFFp8pcyfMjpY8NMwRSijOZWxnrTiAXkDjSLv0+2poBuMYkkgPRZhO3kM9mZCc7qnBpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926674; c=relaxed/simple;
	bh=e0SMJFBpOy5/d3qbT4HP8L3kb/X4vlvHNxXtwRTDE3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgCiFIoH88onmwS5AKajgcBNAisz82Zy1oRaVGkSzuIBOn59t+pOmCBGUy3elvaw4mcuQswuyGfgCNrr5AG4OVuvUqkudQRONNcfedIiF2ULohfHZJI0s02Iil07cY9YUhBoUD06AH+OAdB1DDEj77XW2u2WGdXqoLSy5iaR8Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IjnophdE; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757926670;
	bh=e0SMJFBpOy5/d3qbT4HP8L3kb/X4vlvHNxXtwRTDE3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IjnophdEcujlUxbWSM/TmsAayR8h17N0bfCB5Bo5m9oxaCnRWX00C6D3uvqSsSA0U
	 7EKIYetgs+W+HrCHcY+te2d8/JAkiqDQDvxKpWD/cep8t/L0MCct2eaQGPgq89kqkQ
	 q1vM9YBNxwwZhla4y8JfEkiOB9iPHN/mUy0WcDx4=
Date: Mon, 15 Sep 2025 10:57:51 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 7/9] um: add infrastructure to build files using nolibc
Message-ID: <31a81a3a-e6f2-49b1-9a07-4b11df9e4091@t-8ch.de>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
 <20250915071115.1429196-8-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915071115.1429196-8-benjamin@sipsolutions.net>

On 2025-09-15 09:11:13+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Add NOLIBC_CFLAGS and NOLIBC_OBJS to build files against nolibc rather
> than libc. With this it is possible to move to nolibc in smaller steps.
> 
> Set NOLIBC_IGNORE_ERRNO, as the nolibc errno implementation is overly
> simple and cannot handle threading. nolibc provides sys_* functions that
> do not emulate the libc errno behaviour and can be used instead.
> 
> Guard the syscall definition as it is a macro in nolibc.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  arch/um/Makefile               | 21 ++++++++++++++++++++-
>  arch/um/include/shared/os.h    |  2 ++
>  arch/um/scripts/Makefile.rules |  8 +++++++-
>  3 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index a3f27d791cc0..54aa26fcc32b 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -78,6 +78,25 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
>  		-include $(srctree)/include/linux/kern_levels.h \
>  		-include $(srctree)/$(ARCH_DIR)/include/shared/user.h
>  
> +NOLIBC_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
> +		$(ARCH_INCLUDE) $(MODE_INCLUDE) $(filter -I%,$(CFLAGS)) \
> +		-I $(srctree)/tools/include \
> +		-D__EXPORTED_HEADERS__ \
> +		-D__UM_HOST__ -D__UM_NOLIBC__ \
> +		-DNOLIBC_NO_STARTCODE \
> +		-DNOLIBC_IGNORE_ERRNO \
> +		-nostdlib -nostdinc -static \
> +		-I$(srctree)/include/uapi \
> +		-I$(srctree)/$(HOST_DIR)/include/uapi \
> +		-I$(objtree)/$(HOST_DIR)/include/generated/uapi \
> +		-I $(srctree)/tools/include/nolibc \
> +		-I $(srctree)/usr/include \
> +		-include $(srctree)/include/generated/autoconf.h \
> +		-include $(srctree)/tools/include/linux/kconfig.h \
> +		-include $(srctree)/include/linux/kern_levels.h \
> +		-include $(srctree)/tools/include/nolibc/nolibc.h \

This is not needed. It doesn't hurt though.

> +		-include $(srctree)/$(ARCH_DIR)/include/shared/user.h
> +
>  #This will adjust *FLAGS accordingly to the platform.
>  include $(srctree)/$(ARCH_DIR)/Makefile-os-Linux
>  
> @@ -157,4 +176,4 @@ archclean:
>  		-o -name '*.gcov' \) -type f -print | xargs rm -f
>  	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) clean
>  
> -export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING DEV_NULL_PATH
> +export HEADER_ARCH SUBARCH USER_CFLAGS NOLIBC_CFLAGS CFLAGS_NO_HARDENING DEV_NULL_PATH
> diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
> index b35cc8ce333b..3e9f3ae61658 100644
> --- a/arch/um/include/shared/os.h
> +++ b/arch/um/include/shared/os.h
> @@ -327,7 +327,9 @@ extern int __ignore_sigio_fd(int fd);
>  /* tty.c */
>  extern int get_pty(void);
>  
> +#ifndef syscall

You could use 'ifndef NOLIBC' to make the reason clear.

>  long syscall(long number, ...);
> +#endif
>  
>  /* irqflags tracing */
>  extern void block_signals_trace(void);

(...)

