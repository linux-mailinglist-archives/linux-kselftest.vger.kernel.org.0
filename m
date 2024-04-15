Return-Path: <linux-kselftest+bounces-8011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627FD8A5995
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 20:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670641C20C10
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 18:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67264139CEC;
	Mon, 15 Apr 2024 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YezVzfj4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FBF71B50;
	Mon, 15 Apr 2024 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204710; cv=none; b=Mf6McYlSZlMJ+LBub+r39NOa/gov0h3goyK1QqlkY8saySP/EZU5F4VqCDlook0vaZVUtXmNgZz50/Pdi60NEcomQ+KvcKqU41UtPkwoRn0OIY06L8dFs9Agp6IcUAc/SOMctdL7a15WBTszcgmRcsPkkUbO7WsVmuouuILjxBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204710; c=relaxed/simple;
	bh=jo07CigfaCbbeFT8fMA4YCCzv+cQB8i9RNH1Lx+BdsI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h6tDPGKOJ8qQa3ksRfUihce7jpG3KWdKC6sKozyTF7Qxjbsi5QaIFhqH4MsNR/ftkml6rsVkf5TWaZbUSNR2iBi210pJ4VTjYr4g4fWTNpTXl6C0UsbuVSCskHmpfAACAk/2A3IKrsHt9TI7ugYkyQIthAGa9Q2K17/e8GXVD5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YezVzfj4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713204706;
	bh=jo07CigfaCbbeFT8fMA4YCCzv+cQB8i9RNH1Lx+BdsI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=YezVzfj4oodAmHUI0krKFfGkqUk1aha55UXahQLtEL+f3qRRlmnpQrvGWDNXk3Ite
	 3yqXuGo2cXXsxjw2dOyfm1Mrqcu3AjH/aY99dEgWLuOk6xhrKUwCdyiDIALtBvUock
	 lXd76Dwt97XDzYJ8LCRcopx6E3ZMqfTtdkZug1D/zu4q7XopdWr0WnOHLEPePi/6KO
	 YejzwXGHJY4c/uAItA3FZ28psVOSppjbLOO0NGAZ/wZxwGEOZqeArhUTzim2iLyOA1
	 NWymJt3//H408AO3aCCGl91ye02ExIQ0FQdupseIgSnzZc/2ZQ4yFuPnonJ4Aaso7x
	 3mtSMMgBqt5VQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 366E43781107;
	Mon, 15 Apr 2024 18:11:38 +0000 (UTC)
Message-ID: <d7ed2809-95d5-453a-9169-abf14a52b2e4@collabora.com>
Date: Mon, 15 Apr 2024 23:12:11 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, jeffxu@google.com,
 jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 pedro.falcato@gmail.com, dave.hansen@intel.com,
 linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v10 1/5] mseal: Wire up mseal syscall
To: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
 jannh@google.com, sroettger@google.com, willy@infradead.org,
 gregkh@linuxfoundation.org, torvalds@linux-foundation.org, corbet@lwn.net,
 Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com,
 rdunlap@infradead.org
References: <20240415163527.626541-1-jeffxu@chromium.org>
 <20240415163527.626541-2-jeffxu@chromium.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240415163527.626541-2-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/24 9:35 PM, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Wire up mseal syscall for all architectures.
It isn't logical to wire up something which isn't present. Please first add
the mseal() and then wire up. Please swap first and second patches. I've
seen this same comment before.

> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
>  arch/arm/tools/syscall.tbl                  | 1 +
>  arch/arm64/include/asm/unistd.h             | 2 +-
>  arch/arm64/include/asm/unistd32.h           | 2 ++
>  arch/m68k/kernel/syscalls/syscall.tbl       | 1 +
>  arch/microblaze/kernel/syscalls/syscall.tbl | 1 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl   | 1 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl   | 1 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl   | 1 +
>  arch/parisc/kernel/syscalls/syscall.tbl     | 1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    | 1 +
>  arch/s390/kernel/syscalls/syscall.tbl       | 1 +
>  arch/sh/kernel/syscalls/syscall.tbl         | 1 +
>  arch/sparc/kernel/syscalls/syscall.tbl      | 1 +
>  arch/x86/entry/syscalls/syscall_32.tbl      | 1 +
>  arch/x86/entry/syscalls/syscall_64.tbl      | 1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     | 1 +
>  include/uapi/asm-generic/unistd.h           | 5 ++++-
>  kernel/sys_ni.c                             | 1 +
>  19 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index 8ff110826ce2..d8f96362e9f8 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -501,3 +501,4 @@
>  569	common	lsm_get_self_attr		sys_lsm_get_self_attr
>  570	common	lsm_set_self_attr		sys_lsm_set_self_attr
>  571	common	lsm_list_modules		sys_lsm_list_modules
> +572	common  mseal				sys_mseal
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index b6c9e01e14f5..2ed7d229c8f9 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -475,3 +475,4 @@
>  459	common	lsm_get_self_attr		sys_lsm_get_self_attr
>  460	common	lsm_set_self_attr		sys_lsm_set_self_attr
>  461	common	lsm_list_modules		sys_lsm_list_modules
> +462	common	mseal				sys_mseal
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> index 491b2b9bd553..1346579f802f 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -39,7 +39,7 @@
>  #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
>  #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
>  
> -#define __NR_compat_syscalls		462
> +#define __NR_compat_syscalls		463
>  #endif
>  
>  #define __ARCH_WANT_SYS_CLONE
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index 7118282d1c79..266b96acc014 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -929,6 +929,8 @@ __SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
>  __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
>  #define __NR_lsm_list_modules 461
>  __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
> +#define __NR_mseal 462
> +__SYSCALL(__NR_mseal, sys_mseal)
>  
>  /*
>   * Please add new compat syscalls above this comment and update
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index 7fd43fd4c9f2..22a3cbd4c602 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -461,3 +461,4 @@
>  459	common	lsm_get_self_attr		sys_lsm_get_self_attr
>  460	common	lsm_set_self_attr		sys_lsm_set_self_attr
>  461	common	lsm_list_modules		sys_lsm_list_modules
> +462	common	mseal				sys_mseal
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index b00ab2cabab9..2b81a6bd78b2 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -467,3 +467,4 @@
>  459	common	lsm_get_self_attr		sys_lsm_get_self_attr
>  460	common	lsm_set_self_attr		sys_lsm_set_self_attr
>  461	common	lsm_list_modules		sys_lsm_list_modules
> +462	common	mseal				sys_mseal
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> index 83cfc9eb6b88..cc869f5d5693 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -400,3 +400,4 @@
>  459	n32	lsm_get_self_attr		sys_lsm_get_self_attr
>  460	n32	lsm_set_self_attr		sys_lsm_set_self_attr
>  461	n32	lsm_list_modules		sys_lsm_list_modules
> +462	n32	mseal				sys_mseal
> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> index 532b855df589..1464c6be6eb3 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -376,3 +376,4 @@
>  459	n64	lsm_get_self_attr		sys_lsm_get_self_attr
>  460	n64	lsm_set_self_attr		sys_lsm_set_self_attr
>  461	n64	lsm_list_modules		sys_lsm_list_modules
> +462	n64	mseal				sys_mseal
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index f45c9530ea93..008ebe60263e 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -449,3 +449,4 @@
>  459	o32	lsm_get_self_attr		sys_lsm_get_self_attr
>  460	o32	lsm_set_self_attr		sys_lsm_set_self_attr
>  461	o32	lsm_list_modules		sys_lsm_list_modules
> +462	o32	mseal				sys_mseal
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index b236a84c4e12..b13c21373974 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -460,3 +460,4 @@
>  459	common	lsm_get_self_attr		sys_lsm_get_self_attr
>  460	common	lsm_set_self_attr		sys_lsm_set_self_attr
>  461	common	lsm_list_modules		sys_lsm_list_modules
> +462	common	mseal				sys_mseal
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 17173b82ca21..3656f1ca7a21 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -548,3 +548,4 @@
>  459	common	lsm_get_self_attr		sys_lsm_get_self_attr
>  460	common	lsm_set_self_attr		sys_lsm_set_self_attr
>  461	common	lsm_list_modules		sys_lsm_list_modules
> +462	common	mseal				sys_mseal
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index 095bb86339a7..bd0fee24ad10 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -464,3 +464,4 @@
>  459  common	lsm_get_self_attr	sys_lsm_get_self_attr		sys_lsm_get_self_attr
>  460  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
>  461  common	lsm_list_modules	sys_lsm_list_modules		sys_lsm_list_modules
> +462  common	mseal			sys_mseal			sys_mseal
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index 86fe269f0220..bbf83a2db986 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -464,3 +464,4 @@
>  459	common	lsm_get_self_attr		sys_lsm_get_self_attr
>  460	common	lsm_set_self_attr		sys_lsm_set_self_attr
>  461	common	lsm_list_modules		sys_lsm_list_modules
> +462	common	mseal				sys_mseal
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index b23d59313589..ac6c281ccfe0 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -507,3 +507,4 @@
>  459	common	lsm_get_self_attr		sys_lsm_get_self_attr
>  460	common	lsm_set_self_attr		sys_lsm_set_self_attr
>  461	common	lsm_list_modules		sys_lsm_list_modules
> +462	common	mseal 				sys_mseal
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 5f8591ce7f25..7fd1f57ad3d3 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -466,3 +466,4 @@
>  459	i386	lsm_get_self_attr	sys_lsm_get_self_attr
>  460	i386	lsm_set_self_attr	sys_lsm_set_self_attr
>  461	i386	lsm_list_modules	sys_lsm_list_modules
> +462	i386	mseal 			sys_mseal
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 7e8d46f4147f..52df0dec70da 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -383,6 +383,7 @@
>  459	common	lsm_get_self_attr	sys_lsm_get_self_attr
>  460	common	lsm_set_self_attr	sys_lsm_set_self_attr
>  461	common	lsm_list_modules	sys_lsm_list_modules
> +462 	common  mseal			sys_mseal
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index dd116598fb25..67083fc1b2f5 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -432,3 +432,4 @@
>  459	common	lsm_get_self_attr		sys_lsm_get_self_attr
>  460	common	lsm_set_self_attr		sys_lsm_set_self_attr
>  461	common	lsm_list_modules		sys_lsm_list_modules
> +462	common	mseal 				sys_mseal
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 75f00965ab15..d983c48a3b6a 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -842,8 +842,11 @@ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
>  #define __NR_lsm_list_modules 461
>  __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
>  
> +#define __NR_mseal 462
> +__SYSCALL(__NR_mseal, sys_mseal)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 462
> +#define __NR_syscalls 463
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index faad00cce269..d7eee421d4bc 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -196,6 +196,7 @@ COND_SYSCALL(migrate_pages);
>  COND_SYSCALL(move_pages);
>  COND_SYSCALL(set_mempolicy_home_node);
>  COND_SYSCALL(cachestat);
> +COND_SYSCALL(mseal);
>  
>  COND_SYSCALL(perf_event_open);
>  COND_SYSCALL(accept4);

-- 
BR,
Muhammad Usama Anjum

