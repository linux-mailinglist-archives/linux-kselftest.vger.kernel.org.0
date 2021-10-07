Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D5E424F1A
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 10:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240627AbhJGIWg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 04:22:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57768 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240552AbhJGIWg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 04:22:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B27CA1FF45;
        Thu,  7 Oct 2021 08:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633594841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+1l1YM0OMWcwwXHiU6Pvi6oXj7hXdm44oAgArGX78Y=;
        b=FlVA3903R8AUXw9njlLiJciA6HUAVUvgc2/D5wE9FIOBNiNqPJbGCw2Wl/0abLJHQRzmgI
        SkiiqtmJO9v30oOxQ+gi9FqdbqI1COluJwPJf/ALInJGuD11FwdUD0zUeF7cyIRcASgFVs
        W5wbG0pQY7QIx4l3A+HQzD9DtU8Y9+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633594841;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+1l1YM0OMWcwwXHiU6Pvi6oXj7hXdm44oAgArGX78Y=;
        b=IHrzimFaXIx0H5MfxFnEaO3X+GlrWAF88SjthZvbbqh8oD/IkxiWTITz0CkrGJXEEc/Zyj
        qlLBJARBO8XKaCCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3081A132D4;
        Thu,  7 Oct 2021 08:20:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XqVECNitXmFDFQAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 07 Oct 2021 08:20:40 +0000
Date:   Thu, 7 Oct 2021 10:20:38 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v1 2/6] mm/memory_hotplug: remove
 CONFIG_MEMORY_HOTPLUG_SPARSE
Message-ID: <YV6t1lYLXd9mcNG+@localhost.localdomain>
References: <20210929143600.49379-1-david@redhat.com>
 <20210929143600.49379-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929143600.49379-3-david@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 29, 2021 at 04:35:56PM +0200, David Hildenbrand wrote:
> CONFIG_MEMORY_HOTPLUG depends on CONFIG_SPARSEMEM, so there is no need for
> CONFIG_MEMORY_HOTPLUG_SPARSE anymore; adjust all instances to use
> CONFIG_MEMORY_HOTPLUG and remove CONFIG_MEMORY_HOTPLUG_SPARSE.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

> ---
>  arch/powerpc/include/asm/machdep.h            |  2 +-
>  arch/powerpc/kernel/setup_64.c                |  2 +-
>  arch/powerpc/platforms/powernv/setup.c        |  4 ++--
>  arch/powerpc/platforms/pseries/setup.c        |  2 +-
>  drivers/base/Makefile                         |  2 +-
>  drivers/base/node.c                           |  9 ++++-----
>  drivers/virtio/Kconfig                        |  2 +-
>  include/linux/memory.h                        | 18 +++++++-----------
>  include/linux/node.h                          |  4 ++--
>  lib/Kconfig.debug                             |  2 +-
>  mm/Kconfig                                    |  4 ----
>  mm/memory_hotplug.c                           |  2 --
>  tools/testing/selftests/memory-hotplug/config |  1 -
>  13 files changed, 21 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
> index 764f2732a821..d8a2ca007082 100644
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -32,7 +32,7 @@ struct machdep_calls {
>  	void		(*iommu_save)(void);
>  	void		(*iommu_restore)(void);
>  #endif
> -#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
> +#ifdef CONFIG_MEMORY_HOTPLUG
>  	unsigned long	(*memory_block_size)(void);
>  #endif
>  #endif /* CONFIG_PPC64 */
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index eaa79a0996d1..21f15d82f062 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -912,7 +912,7 @@ void __init setup_per_cpu_areas(void)
>  }
>  #endif
>  
> -#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
> +#ifdef CONFIG_MEMORY_HOTPLUG
>  unsigned long memory_block_size_bytes(void)
>  {
>  	if (ppc_md.memory_block_size)
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index a8db3f153063..ad56a54ac9c5 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -440,7 +440,7 @@ static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
>  }
>  #endif /* CONFIG_KEXEC_CORE */
>  
> -#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
> +#ifdef CONFIG_MEMORY_HOTPLUG
>  static unsigned long pnv_memory_block_size(void)
>  {
>  	/*
> @@ -553,7 +553,7 @@ define_machine(powernv) {
>  #ifdef CONFIG_KEXEC_CORE
>  	.kexec_cpu_down		= pnv_kexec_cpu_down,
>  #endif
> -#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
> +#ifdef CONFIG_MEMORY_HOTPLUG
>  	.memory_block_size	= pnv_memory_block_size,
>  #endif
>  };
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index f79126f16258..d29f6f1f7f37 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -1089,7 +1089,7 @@ define_machine(pseries) {
>  	.machine_kexec          = pSeries_machine_kexec,
>  	.kexec_cpu_down         = pseries_kexec_cpu_down,
>  #endif
> -#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
> +#ifdef CONFIG_MEMORY_HOTPLUG
>  	.memory_block_size	= pseries_memory_block_size,
>  #endif
>  };
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index ef8e44a7d288..02f7f1358e86 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -13,7 +13,7 @@ obj-y			+= power/
>  obj-$(CONFIG_ISA_BUS_API)	+= isa.o
>  obj-y				+= firmware_loader/
>  obj-$(CONFIG_NUMA)	+= node.o
> -obj-$(CONFIG_MEMORY_HOTPLUG_SPARSE) += memory.o
> +obj-$(CONFIG_MEMORY_HOTPLUG) += memory.o
>  ifeq ($(CONFIG_SYSFS),y)
>  obj-$(CONFIG_MODULES)	+= module.o
>  endif
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index c56d34f8158f..b5a4ba18f9f9 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -629,7 +629,7 @@ static void node_device_release(struct device *dev)
>  {
>  	struct node *node = to_node(dev);
>  
> -#if defined(CONFIG_MEMORY_HOTPLUG_SPARSE) && defined(CONFIG_HUGETLBFS)
> +#if defined(CONFIG_MEMORY_HOTPLUG) && defined(CONFIG_HUGETLBFS)
>  	/*
>  	 * We schedule the work only when a memory section is
>  	 * onlined/offlined on this node. When we come here,
> @@ -782,7 +782,7 @@ int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
> +#ifdef CONFIG_MEMORY_HOTPLUG
>  static int __ref get_nid_for_pfn(unsigned long pfn)
>  {
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> @@ -958,10 +958,9 @@ static int node_memory_callback(struct notifier_block *self,
>  	return NOTIFY_OK;
>  }
>  #endif	/* CONFIG_HUGETLBFS */
> -#endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
> +#endif /* CONFIG_MEMORY_HOTPLUG */
>  
> -#if !defined(CONFIG_MEMORY_HOTPLUG_SPARSE) || \
> -    !defined(CONFIG_HUGETLBFS)
> +#if !defined(CONFIG_MEMORY_HOTPLUG) || !defined(CONFIG_HUGETLBFS)
>  static inline int node_memory_callback(struct notifier_block *self,
>  				unsigned long action, void *arg)
>  {
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index ce1b3f6ec325..3654def9915c 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -98,7 +98,7 @@ config VIRTIO_MEM
>  	default m
>  	depends on X86_64
>  	depends on VIRTIO
> -	depends on MEMORY_HOTPLUG_SPARSE
> +	depends on MEMORY_HOTPLUG
>  	depends on MEMORY_HOTREMOVE
>  	depends on CONTIG_ALLOC
>  	help
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index 7efc0a7c14c9..dd6e608c3e0b 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -110,7 +110,7 @@ struct mem_section;
>  #define SLAB_CALLBACK_PRI       1
>  #define IPC_CALLBACK_PRI        10
>  
> -#ifndef CONFIG_MEMORY_HOTPLUG_SPARSE
> +#ifndef CONFIG_MEMORY_HOTPLUG
>  static inline void memory_dev_init(void)
>  {
>  	return;
> @@ -126,7 +126,11 @@ static inline int memory_notify(unsigned long val, void *v)
>  {
>  	return 0;
>  }
> -#else
> +#define hotplug_memory_notifier(fn, pri)	({ 0; })
> +/* These aren't inline functions due to a GCC bug. */
> +#define register_hotmemory_notifier(nb)    ({ (void)(nb); 0; })
> +#define unregister_hotmemory_notifier(nb)  ({ (void)(nb); })
> +#else /* CONFIG_MEMORY_HOTPLUG */
>  extern int register_memory_notifier(struct notifier_block *nb);
>  extern void unregister_memory_notifier(struct notifier_block *nb);
>  int create_memory_block_devices(unsigned long start, unsigned long size,
> @@ -149,9 +153,6 @@ struct memory_group *memory_group_find_by_id(int mgid);
>  typedef int (*walk_memory_groups_func_t)(struct memory_group *, void *);
>  int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
>  			       struct memory_group *excluded, void *arg);
> -#endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
> -
> -#ifdef CONFIG_MEMORY_HOTPLUG
>  #define hotplug_memory_notifier(fn, pri) ({		\
>  	static __meminitdata struct notifier_block fn##_mem_nb =\
>  		{ .notifier_call = fn, .priority = pri };\
> @@ -159,12 +160,7 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
>  })
>  #define register_hotmemory_notifier(nb)		register_memory_notifier(nb)
>  #define unregister_hotmemory_notifier(nb) 	unregister_memory_notifier(nb)
> -#else
> -#define hotplug_memory_notifier(fn, pri)	({ 0; })
> -/* These aren't inline functions due to a GCC bug. */
> -#define register_hotmemory_notifier(nb)    ({ (void)(nb); 0; })
> -#define unregister_hotmemory_notifier(nb)  ({ (void)(nb); })
> -#endif
> +#endif /* CONFIG_MEMORY_HOTPLUG */
>  
>  /*
>   * Kernel text modification mutex, used for code patching. Users of this lock
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 8e5a29897936..bb21fd631b16 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -85,7 +85,7 @@ struct node {
>  	struct device	dev;
>  	struct list_head access_list;
>  
> -#if defined(CONFIG_MEMORY_HOTPLUG_SPARSE) && defined(CONFIG_HUGETLBFS)
> +#if defined(CONFIG_MEMORY_HOTPLUG) && defined(CONFIG_HUGETLBFS)
>  	struct work_struct	node_work;
>  #endif
>  #ifdef CONFIG_HMEM_REPORTING
> @@ -98,7 +98,7 @@ struct memory_block;
>  extern struct node *node_devices[];
>  typedef  void (*node_registration_func_t)(struct node *);
>  
> -#if defined(CONFIG_MEMORY_HOTPLUG_SPARSE) && defined(CONFIG_NUMA)
> +#if defined(CONFIG_MEMORY_HOTPLUG) && defined(CONFIG_NUMA)
>  void link_mem_sections(int nid, unsigned long start_pfn,
>  		       unsigned long end_pfn,
>  		       enum meminit_context context);
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2a9b6dcdac4f..669fee1d26b8 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -877,7 +877,7 @@ config DEBUG_MEMORY_INIT
>  
>  config MEMORY_NOTIFIER_ERROR_INJECT
>  	tristate "Memory hotplug notifier error injection module"
> -	depends on MEMORY_HOTPLUG_SPARSE && NOTIFIER_ERROR_INJECTION
> +	depends on MEMORY_HOTPLUG && NOTIFIER_ERROR_INJECTION
>  	help
>  	  This option provides the ability to inject artificial errors to
>  	  memory hotplug notifier chain callbacks.  It is controlled through
> diff --git a/mm/Kconfig b/mm/Kconfig
> index b7fb3f0b485e..ea8762cd8e1e 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -128,10 +128,6 @@ config MEMORY_HOTPLUG
>  	depends on 64BIT || BROKEN
>  	select NUMA_KEEP_MEMINFO if NUMA
>  
> -config MEMORY_HOTPLUG_SPARSE
> -	def_bool y
> -	depends on SPARSEMEM && MEMORY_HOTPLUG
> -
>  config MEMORY_HOTPLUG_DEFAULT_ONLINE
>  	bool "Online the newly added memory blocks by default"
>  	depends on MEMORY_HOTPLUG
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 9fd0be32a281..8d7b2b593a26 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -220,7 +220,6 @@ static void release_memory_resource(struct resource *res)
>  	kfree(res);
>  }
>  
> -#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
>  static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
>  		const char *reason)
>  {
> @@ -1163,7 +1162,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	mem_hotplug_done();
>  	return ret;
>  }
> -#endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
>  
>  static void reset_node_present_pages(pg_data_t *pgdat)
>  {
> diff --git a/tools/testing/selftests/memory-hotplug/config b/tools/testing/selftests/memory-hotplug/config
> index a7e8cd5bb265..1eef042a31e1 100644
> --- a/tools/testing/selftests/memory-hotplug/config
> +++ b/tools/testing/selftests/memory-hotplug/config
> @@ -1,5 +1,4 @@
>  CONFIG_MEMORY_HOTPLUG=y
> -CONFIG_MEMORY_HOTPLUG_SPARSE=y
>  CONFIG_NOTIFIER_ERROR_INJECTION=y
>  CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
>  CONFIG_MEMORY_HOTREMOVE=y
> -- 
> 2.31.1
> 
> 

-- 
Oscar Salvador
SUSE Labs
