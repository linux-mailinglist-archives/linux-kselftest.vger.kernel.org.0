Return-Path: <linux-kselftest+bounces-27373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FACA42B7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 19:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3D4188CB59
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 18:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313C6265CBC;
	Mon, 24 Feb 2025 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xT8/L8fL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA1F264FBA
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422052; cv=none; b=MZE5i//2+zfYhOUlx4Jo8iU/WMAck8CLbHOpjt/Ou5QsBkdnH1+tDmtHlYBR1o8y3edBE3BP6ujxSDPgU4/Wh6w445pmAZnf8ZaRrHWOOo4hPckfgsjcciun1uN1/UnNe52qVHTK91NwzXvIuX7nrtahQMO2ja1/GRHnV0WfTMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422052; c=relaxed/simple;
	bh=N6sN2FLPigYamqhEvCvuLt9xM109+ohlHbli7MlCrcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liyEsjUx504Or3cW3T2Xke5yVSRy25vYLsZManveZo+g7GPZD3ewvCLmkan0VO4V+uXFXxMUQWiXxyWB3zThVDSyUN3//kZ3hvnjR3XNo2Cq/ARBrlbQs08vVWrxLi6I8hUe930WqrCal5GyQL5aTJM1Gkxz9EryKDroXs+k+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xT8/L8fL; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 24 Feb 2025 18:33:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740422046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8VL12o/LdH3kCkg/mh0i2BdX2UIk8jnH58+NaO0DIrQ=;
	b=xT8/L8fLq1i85pmRhANtO5xDDs6sWhQs+Cz98cxFnKGXNDsTMZVEB6QDplt+qdCBzTIfyk
	cDeND6C3OzcdenhVew7ZiEAiwpwheJlgN45ykmaX4oNoLRMvUHrLSnmOR++qjMk8MxZ4xm
	ob7h4loev+VUbuhvWoNW3tnp47qMWiY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Brendan Jackman <jackmanb@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC 3/4] mm/page_alloc_test: Add logic to isolate a node
 for testing
Message-ID: <Z7y7ltOSDjamYmhP@google.com>
References: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com>
 <20250224-page-alloc-kunit-v1-3-d337bb440889@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224-page-alloc-kunit-v1-3-d337bb440889@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 24, 2025 at 02:47:13PM +0000, Brendan Jackman wrote:
> In order to test the page allocator, we need an "instance" of the page
> allocator that is not subject to unpredictable perturbation by the live
> system. The closest thing that we have to an "instance" of the allocator
> is a NUMA node.
> 
> So, introduce a new concept of an "isolated" node. This is an extension
> of the existing concept of a "fake" node, with the addition that nothing
> else in the system will touch it unless instructed to by the test code.
> 
> The node is created during boot but has no memory nor any CPUs attached.
> It is not on any other node's fallback lists. Any code that pays general
> attention to NODE_DATA in such a way that might cause the page allocator
> data structures to be modified asynchronously to the test, is
> enlightened to ignore it via the node_isolated() helper.
> 
> Then, during initialization of the allocator test suite, hotplug out
> some memory and then plug it back in to the isolated node. The node can
> then be used for testing.
> 
> Because it's easy to miss code that needs enlightenment, which can lead
> to confusing test behaviour, also add some defensive checks to try and
> interference with the isolated node before the start of the test.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  drivers/base/memory.c    |   5 +-
>  include/linux/memory.h   |   4 ++
>  include/linux/nodemask.h |  13 +++++
>  kernel/kthread.c         |   3 +
>  mm/.kunitconfig          |  10 +++-
>  mm/Kconfig               |   2 +-
>  mm/internal.h            |  11 ++++
>  mm/memory_hotplug.c      |  26 ++++++---
>  mm/numa_memblks.c        |  22 ++++++++
>  mm/page_alloc.c          |  37 +++++++++++-
>  mm/page_alloc_test.c     | 142 ++++++++++++++++++++++++++++++++++++++++++++++-
>  11 files changed, 260 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 348c5dbbfa68ad30d34b344ace1dd8deac0e1947..cdb893d7f13324862ee0943df080440d19fbd957 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -26,6 +26,8 @@
>  #include <linux/atomic.h>
>  #include <linux/uaccess.h>
>  
> +#include <kunit/visibility.h>
> +
>  #define MEMORY_CLASS_NAME	"memory"
>  
>  static const char *const online_type_to_str[] = {
> @@ -183,7 +185,7 @@ static inline unsigned long memblk_nr_poison(struct memory_block *mem)
>  /*
>   * Must acquire mem_hotplug_lock in write mode.
>   */
> -static int memory_block_online(struct memory_block *mem)
> +VISIBLE_IF_KUNIT int memory_block_online(struct memory_block *mem)
>  {
>  	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
>  	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
> @@ -250,6 +252,7 @@ static int memory_block_online(struct memory_block *mem)
>  	mem_hotplug_done();
>  	return ret;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(memory_block_online);
>  
>  /*
>   * Must acquire mem_hotplug_lock in write mode.
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index c0afee5d126ef65d420770e1f8669842c499c8de..99139a6e9c11a407a8d7bfb17b7bbe3d276048ff 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -177,6 +177,10 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
>  	register_memory_notifier(&fn##_mem_nb);			\
>  })
>  
> +#ifdef CONFIG_KUNIT

Why not CONFIG_PAGE_ALLOC_KUNIT_TEST?

> +int memory_block_online(struct memory_block *mem);
> +#endif
> +
>  #ifdef CONFIG_NUMA
>  void memory_block_add_nid(struct memory_block *mem, int nid,
>  			  enum meminit_context context);
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index 9fd7a0ce9c1a7336df46f12622867e6786a5c0a9..6ea38963487e1fbb800eab69e5e6413aa17a8047 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -536,6 +536,19 @@ static __always_inline int node_random(const nodemask_t *maskp)
>  #define for_each_node(node)	   for_each_node_state(node, N_POSSIBLE)
>  #define for_each_online_node(node) for_each_node_state(node, N_ONLINE)
>  
> +
> +#ifdef CONFIG_PAGE_ALLOC_KUNIT_TEST
> +/*
> + * An isolated node is a fake node for testing, that boots with no memory and no
> + * attached CPUs, and nothing should touch it except for test code.
> + */
> +extern bool node_isolated(int node);
> +/* Only one isolated node is supported at present and it cannot be un-isolated. */
> +extern void node_set_isolated(int node);
> +#else
> +static inline bool node_isolated(int node) { return false; }
> +#endif /* CONFIG_PAGE_ALLOC_KUNIT_TEST */
> +
>  /*
>   * For nodemask scratch area.
>   * NODEMASK_ALLOC(type, name) allocates an object with a specified type and
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 5dc5b0d7238e85ad4074076e4036062c7bfcae74..93f65c5935cba8a59c7d3df2e36335130c3e1f71 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -9,6 +9,7 @@
>   */
>  #include <uapi/linux/sched/types.h>
>  #include <linux/mm.h>
> +#include <linux/mmdebug.h>
>  #include <linux/mmu_context.h>
>  #include <linux/sched.h>
>  #include <linux/sched/mm.h>
> @@ -511,6 +512,8 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
>  	struct kthread_create_info *create = kmalloc(sizeof(*create),
>  						     GFP_KERNEL);
>  
> +	VM_WARN_ON(node != NUMA_NO_NODE && node_isolated(node));
> +
>  	if (!create)
>  		return ERR_PTR(-ENOMEM);
>  	create->threadfn = threadfn;
> diff --git a/mm/.kunitconfig b/mm/.kunitconfig
> index fcc28557fa1c1412b21f9dbddbf6a63adca6f2b4..4ff4e1654c3e9b364072d33bfffb3a2336825859 100644
> --- a/mm/.kunitconfig
> +++ b/mm/.kunitconfig
> @@ -1,2 +1,10 @@
>  CONFIG_KUNIT=y
> -CONFIG_PAGE_ALLOC_KUNIT_TEST=y
> \ No newline at end of file
> +CONFIG_PAGE_ALLOC_KUNIT_TEST=y
> +
> +# Required for NUMA
> +CONFIG_SMP=y
> +# Used by tests to carve out fake node for isolating page_alloc data.
> +CONFIG_NUMA=y
> +CONFIG_NUMA_EMU=y
> +CONFIG_MEMORY_HOTPLUG=y
> +CONFIG_MEMORY_HOTREMOVE=y
> \ No newline at end of file
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 1fac51c536c66243a1321195a78eb40668386158..64c3794120002a839f56e3feb284c6d5c2635f40 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1360,7 +1360,7 @@ config PT_RECLAIM
>  
>  config PAGE_ALLOC_KUNIT_TEST
>  	tristate "KUnit test for page allocator" if !KUNIT_ALL_TESTS
> -	depends on KUNIT
> +	depends on KUNIT && NUMA && MEMORY_HOTREMOVE
>  	default KUNIT_ALL_TESTS
>  	help
>  	  Builds unit tests for page allocator.
> diff --git a/mm/internal.h b/mm/internal.h
> index 109ef30fee11f8b399f6bac42eab078cd51e01a5..9dbe5853b90b53ff261ba1b2fca12eabfda1a9de 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1545,5 +1545,16 @@ static inline bool reclaim_pt_is_enabled(unsigned long start, unsigned long end,
>  }
>  #endif /* CONFIG_PT_RECLAIM */
>  
> +#ifdef CONFIG_PAGE_ALLOC_KUNIT_TEST
> +/*
> + * Note that node_isolated() is separate, that's a "public API". But only
> + * test code needs to look up which node is isolated.
> + */
> +extern int isolated_node;
> +#endif
> +
> +#ifdef CONFIG_KUNIT

Same here, why not just put it in the above #ifdef?

> +void drain_pages(unsigned int cpu);
> +#endif
>  
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index e3655f07dd6e33efb3e811cab07f240649487441..968c23b6f347cf6a0c30d00cb556166b8df9c9c3 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1198,10 +1198,12 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
>  	arg.nr_pages = nr_pages;
>  	node_states_check_changes_online(nr_pages, zone, &arg);
>  
> -	ret = memory_notify(MEM_GOING_ONLINE, &arg);
> -	ret = notifier_to_errno(ret);
> -	if (ret)
> -		goto failed_addition;
> +	if (!node_isolated(nid)) {
> +		ret = memory_notify(MEM_GOING_ONLINE, &arg);
> +		ret = notifier_to_errno(ret);
> +		if (ret)
> +			goto failed_addition;
> +	}
>  
>  	/*
>  	 * Fixup the number of isolated pageblocks before marking the sections
> @@ -1242,19 +1244,27 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
>  	/* reinitialise watermarks and update pcp limits */
>  	init_per_zone_wmark_min();
>  
> -	kswapd_run(nid);
> -	kcompactd_run(nid);
> +	/*
> +	 * Don't run daemons on the special test node, if that needs to be
> +	 * tested the test should run it.
> +	 */
> +	if (!node_isolated(nid)) {
> +		kswapd_run(nid);
> +		kcompactd_run(nid);
> +	}
>  
>  	writeback_set_ratelimit();
>  
> -	memory_notify(MEM_ONLINE, &arg);
> +	if (!node_isolated(nid))
> +		memory_notify(MEM_ONLINE, &arg);

I am not familiar with this code, I am wondering if we can move things
around to have a single block of things we skip for isolated nodes. It
depends on ordering dependencies so we need someone who knows this code
to tell us.

>  	return 0;
>  
>  failed_addition:
>  	pr_debug("online_pages [mem %#010llx-%#010llx] failed\n",
>  		 (unsigned long long) pfn << PAGE_SHIFT,
>  		 (((unsigned long long) pfn + nr_pages) << PAGE_SHIFT) - 1);
> -	memory_notify(MEM_CANCEL_ONLINE, &arg);
> +	if (!node_isolated(nid))
> +		memory_notify(MEM_CANCEL_ONLINE, &arg);
>  	remove_pfn_range_from_zone(zone, pfn, nr_pages);
>  	return ret;
>  }
[..]
> -static struct kunit_suite test_suite = {
> +struct kunit_suite page_alloc_test_suite = {

We should probably just intrdouce the suite as page_alloc_test_suite to
begin with?

>  	.name = "page_alloc",
>  	.test_cases = test_cases,
> +	.suite_init = populate_isolated_node,
> +	.suite_exit = depopulate_isolated_node,
> +	.init = test_init,
>  };
> -kunit_test_suite(test_suite);
> +kunit_test_suite(page_alloc_test_suite);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
> 
> -- 
> 2.48.1.601.g30ceb7b040-goog
> 

