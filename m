Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99A3424FDF
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 11:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbhJGJR5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 05:17:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34626 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240504AbhJGJR4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 05:17:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C5D96203F6;
        Thu,  7 Oct 2021 09:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633598161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CxQ0ZV9cOOlrG2jRElhDboOH1/ncgOGYv8QD9De0aOg=;
        b=Lw7uvG7zBKms7sqR9dWZKsIPebzq3igxLuZw//KJ82jkCbX/WVCIt+ohnaMwcuCzgj/X1o
        5LlB2SJRb5Ft6RYdOCD+LQrhcspETJZ1NLEHzDutE/2DBaNkPZs15JDb3Rep0F/TldZLNc
        Z2meDzCll9YQpTWNJgF3nkYIoYernHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633598161;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CxQ0ZV9cOOlrG2jRElhDboOH1/ncgOGYv8QD9De0aOg=;
        b=8xCq5EgoVY5xRbt7QHo29GOnRCfknfEkb/GRje1CC6D7omn0OivrSNXVnP7veEnFhiakWa
        e7XgNEG+K5LURCDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5941613A98;
        Thu,  7 Oct 2021 09:16:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dPciE9C6XmHkLgAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 07 Oct 2021 09:16:00 +0000
Date:   Thu, 7 Oct 2021 11:15:58 +0200
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
Subject: Re: [PATCH v1 6/6] x86: remove memory hotplug support on X86_32
Message-ID: <YV66zoLEP3niIHEu@localhost.localdomain>
References: <20210929143600.49379-1-david@redhat.com>
 <20210929143600.49379-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929143600.49379-7-david@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 29, 2021 at 04:36:00PM +0200, David Hildenbrand wrote:
> CONFIG_MEMORY_HOTPLUG was marked BROKEN over one year and we just
> restricted it to 64 bit. Let's remove the unused x86 32bit implementation
> and simplify the Kconfig.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  arch/x86/Kconfig      |  6 +++---
>  arch/x86/mm/init_32.c | 31 -------------------------------
>  2 files changed, 3 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index ab83c22d274e..85f4762429f1 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -62,7 +62,7 @@ config X86
>  	select ARCH_32BIT_OFF_T			if X86_32
>  	select ARCH_CLOCKSOURCE_INIT
>  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if X86_64 && HUGETLB_PAGE && MIGRATION
> -	select ARCH_ENABLE_MEMORY_HOTPLUG if X86_64 || (X86_32 && HIGHMEM)
> +	select ARCH_ENABLE_MEMORY_HOTPLUG if X86_64
>  	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
>  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if (PGTABLE_LEVELS > 2) && (X86_64 || X86_PAE)
>  	select ARCH_ENABLE_THP_MIGRATION if X86_64 && TRANSPARENT_HUGEPAGE
> @@ -1615,7 +1615,7 @@ config ARCH_SELECT_MEMORY_MODEL
>  
>  config ARCH_MEMORY_PROBE
>  	bool "Enable sysfs memory/probe interface"
> -	depends on X86_64 && MEMORY_HOTPLUG
> +	depends on MEMORY_HOTPLUG
>  	help
>  	  This option enables a sysfs memory/probe interface for testing.
>  	  See Documentation/admin-guide/mm/memory-hotplug.rst for more information.
> @@ -2395,7 +2395,7 @@ endmenu
>  
>  config ARCH_HAS_ADD_PAGES
>  	def_bool y
> -	depends on X86_64 && ARCH_ENABLE_MEMORY_HOTPLUG
> +	depends on ARCH_ENABLE_MEMORY_HOTPLUG
>  
>  config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
>  	def_bool y
> diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
> index bd90b8fe81e4..5cd7ea6d645c 100644
> --- a/arch/x86/mm/init_32.c
> +++ b/arch/x86/mm/init_32.c
> @@ -779,37 +779,6 @@ void __init mem_init(void)
>  	test_wp_bit();
>  }
>  
> -#ifdef CONFIG_MEMORY_HOTPLUG
> -int arch_add_memory(int nid, u64 start, u64 size,
> -		    struct mhp_params *params)
> -{
> -	unsigned long start_pfn = start >> PAGE_SHIFT;
> -	unsigned long nr_pages = size >> PAGE_SHIFT;
> -	int ret;
> -
> -	/*
> -	 * The page tables were already mapped at boot so if the caller
> -	 * requests a different mapping type then we must change all the
> -	 * pages with __set_memory_prot().
> -	 */
> -	if (params->pgprot.pgprot != PAGE_KERNEL.pgprot) {
> -		ret = __set_memory_prot(start, nr_pages, params->pgprot);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return __add_pages(nid, start_pfn, nr_pages, params);
> -}
> -
> -void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
> -{
> -	unsigned long start_pfn = start >> PAGE_SHIFT;
> -	unsigned long nr_pages = size >> PAGE_SHIFT;
> -
> -	__remove_pages(start_pfn, nr_pages, altmap);
> -}
> -#endif
> -
>  int kernel_set_to_readonly __read_mostly;
>  
>  static void mark_nxdata_nx(void)
> -- 
> 2.31.1
> 
> 

-- 
Oscar Salvador
SUSE Labs
