Return-Path: <linux-kselftest+bounces-667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD15B7FAC20
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 22:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242C01C20C3A
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 21:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574CD3EA60;
	Mon, 27 Nov 2023 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yzDbR+kT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D812031735;
	Mon, 27 Nov 2023 21:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E8DC433C9;
	Mon, 27 Nov 2023 21:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701118857;
	bh=d0FagZci1PXFMezi/BonwyYv+7yV34Dht6vxRLQOKK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yzDbR+kT8L1Ms6G8xL0TrV5ITh7u9pHV2Tf3NB55xhtilyqokg+gTeQDHkcIheVm8
	 DFA9Di1naDUQ7+V1qm6//jzz5SoG4oQI202ZHvMMcRWO/D2v+XJx6r6wBn7BU8ic6i
	 nNpDcKvEsu+FmI1qaMNFFOqckiGwHehyfX1VN2tA=
Date: Mon, 27 Nov 2023 13:00:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: hannes@cmpxchg.org, cerasuolodomenico@gmail.com, yosryahmed@google.com,
 sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
 muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
 kernel-team@meta.com, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v6 6/6] zswap: shrinks zswap pool based on memory
 pressure
Message-Id: <20231127130055.30c455906d912e09dcb7e79b@linux-foundation.org>
In-Reply-To: <20231127193703.1980089-7-nphamcs@gmail.com>
References: <20231127193703.1980089-1-nphamcs@gmail.com>
	<20231127193703.1980089-7-nphamcs@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 11:37:03 -0800 Nhat Pham <nphamcs@gmail.com> wrote:

> Currently, we only shrink the zswap pool when the user-defined limit is
> hit. This means that if we set the limit too high, cold data that are
> unlikely to be used again will reside in the pool, wasting precious
> memory. It is hard to predict how much zswap space will be needed ahead
> of time, as this depends on the workload (specifically, on factors such
> as memory access patterns and compressibility of the memory pages).
> 
> This patch implements a memcg- and NUMA-aware shrinker for zswap, that
> is initiated when there is memory pressure. The shrinker does not
> have any parameter that must be tuned by the user, and can be opted in
> or out on a per-memcg basis.
> 
> Furthermore, to make it more robust for many workloads and prevent
> overshrinking (i.e evicting warm pages that might be refaulted into
> memory), we build in the following heuristics:
> 
> * Estimate the number of warm pages residing in zswap, and attempt to
>   protect this region of the zswap LRU.
> * Scale the number of freeable objects by an estimate of the memory
>   saving factor. The better zswap compresses the data, the fewer pages
>   we will evict to swap (as we will otherwise incur IO for relatively
>   small memory saving).
> * During reclaim, if the shrinker encounters a page that is also being
>   brought into memory, the shrinker will cautiously terminate its
>   shrinking action, as this is a sign that it is touching the warmer
>   region of the zswap LRU.
> 
> As a proof of concept, we ran the following synthetic benchmark:
> build the linux kernel in a memory-limited cgroup, and allocate some
> cold data in tmpfs to see if the shrinker could write them out and
> improved the overall performance. Depending on the amount of cold data
> generated, we observe from 14% to 35% reduction in kernel CPU time used
> in the kernel builds.
> 
> ...
>
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -22,6 +22,7 @@
>  #include <linux/mm_types.h>
>  #include <linux/page-flags.h>
>  #include <linux/local_lock.h>
> +#include <linux/zswap.h>
>  #include <asm/page.h>
>  
>  /* Free memory management - zoned buddy allocator.  */
> @@ -641,6 +642,7 @@ struct lruvec {
>  #ifdef CONFIG_MEMCG
>  	struct pglist_data *pgdat;
>  #endif
> +	struct zswap_lruvec_state zswap_lruvec_state;

Normally we'd put this in #ifdef CONFIG_ZSWAP.

> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -5,20 +5,40 @@
>  #include <linux/types.h>
>  #include <linux/mm_types.h>
>  
> +struct lruvec;
> +
>  extern u64 zswap_pool_total_size;
>  extern atomic_t zswap_stored_pages;
>  
>  #ifdef CONFIG_ZSWAP
>  
> +struct zswap_lruvec_state {
> +	/*
> +	 * Number of pages in zswap that should be protected from the shrinker.
> +	 * This number is an estimate of the following counts:
> +	 *
> +	 * a) Recent page faults.
> +	 * b) Recent insertion to the zswap LRU. This includes new zswap stores,
> +	 *    as well as recent zswap LRU rotations.
> +	 *
> +	 * These pages are likely to be warm, and might incur IO if the are written
> +	 * to swap.
> +	 */
> +	atomic_long_t nr_zswap_protected;
> +};
> +
>  bool zswap_store(struct folio *folio);
>  bool zswap_load(struct folio *folio);
>  void zswap_invalidate(int type, pgoff_t offset);
>  void zswap_swapon(int type);
>  void zswap_swapoff(int type);
>  void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
> -
> +void zswap_lruvec_state_init(struct lruvec *lruvec);
> +void zswap_lruvec_swapin(struct page *page);
>  #else
>  
> +struct zswap_lruvec_state {};

But instead you made it an empty struct in this case.

That's a bit funky, but I guess OK.  It does send a careful reader of
struct lruvec over to look at the zswap_lruvec_state definition to
understand what's going on.

>  static inline bool zswap_store(struct folio *folio)
>  {
>  	return false;
> @@ -33,7 +53,8 @@ static inline void zswap_invalidate(int type, pgoff_t offset) {}
>  static inline void zswap_swapon(int type) {}
>  static inline void zswap_swapoff(int type) {}
>  static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg) {}
> -
> +static inline void zswap_lruvec_init(struct lruvec *lruvec) {}
> +static inline void zswap_lruvec_swapin(struct page *page) {}

Needed this build fix:

--- a/include/linux/zswap.h~zswap-shrinks-zswap-pool-based-on-memory-pressure-fix
+++ a/include/linux/zswap.h
@@ -54,6 +54,7 @@ static inline void zswap_swapon(int type
 static inline void zswap_swapoff(int type) {}
 static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg) {}
 static inline void zswap_lruvec_init(struct lruvec *lruvec) {}
+static inline void zswap_lruvec_state_init(struct lruvec *lruvec) {}
 static inline void zswap_lruvec_swapin(struct page *page) {}
 #endif
 
_


