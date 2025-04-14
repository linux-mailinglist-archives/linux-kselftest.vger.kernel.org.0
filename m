Return-Path: <linux-kselftest+bounces-30802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0F0A88F28
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 00:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7D9177FD2
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 22:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0465F1F30C3;
	Mon, 14 Apr 2025 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M7WwdZvx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50601DB128;
	Mon, 14 Apr 2025 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744670169; cv=none; b=aSRwZTNWooH0rBwrYBK67Gdg1NFgKHW6aZDHt56copvdCLOe/fPn+7vahn7SyOWQIPyqHA6Q0hMpERmWPpWVt79W1goxzKhp3HV4jgusEvg9rJ7NXPGwLP8bypH5kDcKL7l0rp8o3VZlkMJnyui3JxXUcqnF3fvlp8o8bKEq9ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744670169; c=relaxed/simple;
	bh=4BXi8C2tlu1/+zsff0oHHU23Mqhxy499n+viyd862NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKDQrFa8zRbf6G+jPFiIN8GruGR7iVX3Pk7YZVPGk7kOKD2XlJAhd3rRR75W+100f0Hqp57BHN+a6QcegI2LrowgYNihhTwc1q1M9b8mxKcxLtwFllWC2Q3ow262KzcKF1uw/oHSTz8+1LIQjPgk+Uxf/JwHjy5Jac0zm7Y8pEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M7WwdZvx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=BD09sozXk7mDc/vLq4jmW/slDmud21XMtjmESSd0XDI=; b=M7WwdZvxYUIKye09kI1jeq2R3I
	2qacZI5ou3EO0VHyC3ym7veCiHt4juqgxHKNQ/UwscJ5IKglZ0kuOnPEv8TI/ka3Y/N+/IbjBLzaC
	9UObCzeCzOvc3HxV6m6q3BFTaduY5wgolfHn1OI5BH29hRaNqaYX/RnpYwBFG2OTpLkV8vbZNIivj
	bgwruO3/5PjQ5x8yKrUpj/GkLqttS5MzPCOdFb+8kBANV5TEMjmV1trYQdVHMrdofdNzPK1+wHQVI
	2ZM1tWh3T0TXhXEN9P9AtXlNr43tNqII+loTPSUdJeBuJA2us3Z+FgyUvsNv6jNL0gqP2LdiY9wgc
	kkkLn69Q==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4SNU-00000002mNv-3QOZ;
	Mon, 14 Apr 2025 22:34:10 +0000
Message-ID: <8fbdd651-c965-4fa7-a715-e01092f5de7b@infradead.org>
Date: Mon, 14 Apr 2025 15:33:38 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] mm: document (m)THP defer usage
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: akpm@linux-foundation.org, corbet@lwn.net, shuah@kernel.org,
 david@redhat.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 ryan.roberts@arm.com, willy@infradead.org, peterx@redhat.com,
 ioworker0@gmail.com, ziy@nvidia.com, wangkefeng.wang@huawei.com,
 dev.jain@arm.com, mhocko@suse.com, rientjes@google.com, hannes@cmpxchg.org,
 zokeefe@google.com, surenb@google.com, jglisse@google.com, cl@gentwo.org,
 jack@suse.cz, dave.hansen@linux.intel.com, will@kernel.org, tiwai@suse.de,
 catalin.marinas@arm.com, anshuman.khandual@arm.com, raquini@redhat.com,
 aarcange@redhat.com, kirill.shutemov@linux.intel.com,
 yang@os.amperecomputing.com, thomas.hellstrom@linux.intel.com,
 vishal.moola@gmail.com, sunnanyong@huawei.com, usamaarif642@gmail.com,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org
References: <20250414222456.43212-1-npache@redhat.com>
 <20250414222456.43212-3-npache@redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250414222456.43212-3-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/14/25 3:24 PM, Nico Pache wrote:
> The new defer option for (m)THPs allows for a more conservative
> approach to (m)THPs. Document its usage in the transhuge admin-guide.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 31 ++++++++++++++++------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index f0d4e78cedaa..d3f072bdd932 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -88,8 +88,9 @@ In certain cases when hugepages are enabled system wide, application
>  may end up allocating more memory resources. An application may mmap a
>  large region but only touch 1 byte of it, in that case a 2M page might
>  be allocated instead of a 4k page for no good. This is why it's
> -possible to disable hugepages system-wide and to only have them inside
> -MADV_HUGEPAGE madvise regions.
> +possible to disable hugepages system-wide, only have them inside
> +MADV_HUGEPAGE madvise regions, or defer them away from the page fault
> +handler to khugepaged.
>  
>  Embedded systems should enable hugepages only inside madvise regions
>  to eliminate any risk of wasting any precious byte of memory and to
> @@ -99,6 +100,15 @@ Applications that gets a lot of benefit from hugepages and that don't
>  risk to lose memory by using hugepages, should use
>  madvise(MADV_HUGEPAGE) on their critical mmapped regions.
>  
> +Applications that would like to benefit from THPs but would still like a
> +more memory conservative approach can choose 'defer'. This avoids
> +inserting THPs at the page fault handler unless they are MADV_HUGEPAGE.
> +Khugepaged will then scan the mappings for potential collapses into (m)THP
> +pages. Admins using this the 'defer' setting should consider
> +tweaking khugepaged/max_ptes_none. The current default of 511 may
> +aggressively collapse your PTEs into PMDs. Lower this value to conserve
> +more memory (ie. max_ptes_none=64).

                i.e.,

> +
>  .. _thp_sysfs:
>  
>  sysfs
> @@ -109,11 +119,14 @@ Global THP controls
>  
>  Transparent Hugepage Support for anonymous memory can be entirely disabled
>  (mostly for debugging purposes) or only enabled inside MADV_HUGEPAGE
> -regions (to avoid the risk of consuming more memory resources) or enabled
> -system wide. This can be achieved per-supported-THP-size with one of::
> +regions (to avoid the risk of consuming more memory resources), defered to

                                                                   deferred

> +khugepaged, or enabled system wide.
> +
> +This can be achieved per-supported-THP-size with one of::
>  
>  	echo always >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>  	echo madvise >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
> +	echo defer >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>  	echo never >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>  
>  where <size> is the hugepage size being addressed, the available sizes
> @@ -136,6 +149,7 @@ The top-level setting (for use with "inherit") can be set by issuing
>  one of the following commands::
>  
>  	echo always >/sys/kernel/mm/transparent_hugepage/enabled
> +	echo defer >/sys/kernel/mm/transparent_hugepage/enabled
>  	echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
>  	echo never >/sys/kernel/mm/transparent_hugepage/enabled
>  
> @@ -281,7 +295,8 @@ of small pages into one large page::
>  A higher value leads to use additional memory for programs.
>  A lower value leads to gain less thp performance. Value of
>  max_ptes_none can waste cpu time very little, you can
> -ignore it.
> +ignore it. Consider lowering this value when using
> +``transparent_hugepage=defer``
>  
>  ``max_ptes_swap`` specifies how many pages can be brought in from
>  swap when collapsing a group of pages into a transparent huge page::
> @@ -306,14 +321,14 @@ Boot parameters
>  
>  You can change the sysfs boot time default for the top-level "enabled"
>  control by passing the parameter ``transparent_hugepage=always`` or
> -``transparent_hugepage=madvise`` or ``transparent_hugepage=never`` to the
> -kernel command line.
> +``transparent_hugepage=madvise`` or ``transparent_hugepage=defer`` or
> +``transparent_hugepage=never`` to the kernel command line.
>  
>  Alternatively, each supported anonymous THP size can be controlled by
>  passing ``thp_anon=<size>[KMG],<size>[KMG]:<state>;<size>[KMG]-<size>[KMG]:<state>``,
>  where ``<size>`` is the THP size (must be a power of 2 of PAGE_SIZE and
>  supported anonymous THP)  and ``<state>`` is one of ``always``, ``madvise``,
> -``never`` or ``inherit``.
> +``defer``, ``never`` or ``inherit``.
>  
>  For example, the following will set 16K, 32K, 64K THP to ``always``,
>  set 128K, 512K to ``inherit``, set 256K to ``madvise`` and 1M, 2M

-- 
~Randy


