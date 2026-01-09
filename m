Return-Path: <linux-kselftest+bounces-48606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1BFD0A6A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 14:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C66630124D1
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E60359F8B;
	Fri,  9 Jan 2026 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llL55zqj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7921D3F4;
	Fri,  9 Jan 2026 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767965333; cv=none; b=sX90hXrfTvRCX9bFIeFj02DBON4wRuqCXMRQVVF0XLAgANqkSY1qMWPn86rOfs/YDf0rH6oNhr8HZFLVzS/z0lwyoVAwaKWqcpm6hM00jCQlHE7+s/2gYaLYnzS/LFNuoliWaZYk0MX14NjzRgFGoAD/46fgxYsz5LCEqafW5ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767965333; c=relaxed/simple;
	bh=KbGNKDR58KSn4+oTOJL1NdoFtGGmzkqP2D4O9W11qko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jxv3MBctVqi6WGXGW2KvEUmR3X65p6JJEiOAOCildxzVVx4nYJ4DAvUEwEqKatKmotIYOoNP++OuxO9eFlTzY0Q4TooJlOzwRR0/AgV7RcEc8J5xV0OTGYTEU+8NkuBtfQpjtNys8kxna0pcFHoDk0ZuRZUzGzaiAjeMlqZm9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llL55zqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD68AC4CEF1;
	Fri,  9 Jan 2026 13:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767965333;
	bh=KbGNKDR58KSn4+oTOJL1NdoFtGGmzkqP2D4O9W11qko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=llL55zqjqi+MT92LPRj4SFMimqMF6ITiHAVUU1cLWrTf0TVZfjetX53J3dPEPjAXj
	 qV6WzGKL/23BEdDanD9wA02+lSX8dh15NzcDjdSFtCINTReIC8Q58OYORr6GSgRWD+
	 UH8oRGbB6lpl/lLZBF350wdYHN0k5GXOPIb/JWfwiyi0PXkG8YZopbVSo6UqrZqzWq
	 PYGawZf6RL8p96oA1+TcxhOs9sqGB4HQlalFlKqLh2b3PATLisuPYZJIWni/C+1tI/
	 0RgeEYAP8hGhpHJMUaLcmGXkvrGSdxxKXykY5kxxsb9Om5YN5pi183VK+ZRZpnYel/
	 bzwLe8wPPcrxw==
Message-ID: <b5502d6c-62c2-41bb-9564-3741656e07e2@kernel.org>
Date: Fri, 9 Jan 2026 14:28:43 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loongarch: wire up memfd_secret system call
To: Lain Fearyncess Yang <fearyncess@aosc.io>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>, Mingcong Bai <jeffbai@aosc.io>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20260109051054.188030-1-fearyncess@aosc.io>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
In-Reply-To: <20260109051054.188030-1-fearyncess@aosc.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/26 06:10, Lain Fearyncess Yang wrote:
> From: "Lain \"Fearyncess\" Yang" <fearyncess@aosc.io>
> 
> LoongArch supports ARCH_HAS_SET_DIRECT_MAP, therefore wire up the
> memfd_secret system call, which depends on it.
> 
> Signed-off-by: Lain "Fearyncess" Yang <fearyncess@aosc.io>
> ---
>   arch/loongarch/include/asm/unistd.h     | 1 +
>   arch/loongarch/kernel/Makefile.syscalls | 6 +++---
>   tools/testing/selftests/mm/Makefile     | 2 +-
>   3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/unistd.h b/arch/loongarch/include/asm/unistd.h
> index e2c0f3d86c7bd..e7649c1582482 100644
> --- a/arch/loongarch/include/asm/unistd.h
> +++ b/arch/loongarch/include/asm/unistd.h
> @@ -10,5 +10,6 @@
>   
>   #define __ARCH_WANT_NEW_STAT
>   #define __ARCH_WANT_SYS_CLONE
> +#define __ARCH_WANT_MEMFD_SECRET
>   
>   #define NR_syscalls (__NR_syscalls)
> diff --git a/arch/loongarch/kernel/Makefile.syscalls b/arch/loongarch/kernel/Makefile.syscalls
> index cd46c2b69c7fd..6360381baf931 100644
> --- a/arch/loongarch/kernel/Makefile.syscalls
> +++ b/arch/loongarch/kernel/Makefile.syscalls
> @@ -1,5 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
> -# No special ABIs on loongarch so far
> -syscall_abis_32 +=
> -syscall_abis_64 +=
> +# Add memfd_secret explictly for la64 and la32
> +syscall_abis_32 += memfd_secret
> +syscall_abis_64 += memfd_secret
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index eaf9312097f7b..79582438efc4d 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -72,7 +72,7 @@ TEST_GEN_FILES += madv_populate
>   TEST_GEN_FILES += map_fixed_noreplace
>   TEST_GEN_FILES += map_hugetlb
>   TEST_GEN_FILES += map_populate
> -ifneq (,$(filter $(ARCH),arm64 riscv riscv64 x86 x86_64))
> +ifneq (,$(filter $(ARCH),arm64 riscv riscv64 x86 x86_64 loongarch32 loongarch64))

For the core-mm bits

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

