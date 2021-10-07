Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF742424FA1
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 11:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhJGJEL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 05:04:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48562 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhJGJEK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 05:04:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 30EC22262B;
        Thu,  7 Oct 2021 09:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633597335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TvTy7OIFpMRsbso1NF1f6Ks+BgvmrJ6wkv3NW7NfJyY=;
        b=GNTEZSz7kgdAFwe28alhJ/eP+02Z1EOihzX+n9vgBwes/WRv9pASKWGhtrUDxgfMG1b8bt
        eD1XA2PxyYXX9LAPbMAWcHuixO0YxRCluf3P/ht02R7TKYo50KBLYUtBCNMgLJEKjh6WKV
        20A4InA3XI2jHfLnQHnOad/06SY09Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633597335;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TvTy7OIFpMRsbso1NF1f6Ks+BgvmrJ6wkv3NW7NfJyY=;
        b=LnmiiJ98gJZKCmXY5/iYk60e5PM03lAS4VN2Ge0taIvYAilG9n+pj9T7gNMBcMdDsc9obF
        rnsZE5qa74+KAUCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34A8B13B1B;
        Thu,  7 Oct 2021 09:02:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QJzlB5W3XmG6KAAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 07 Oct 2021 09:02:13 +0000
Date:   Thu, 7 Oct 2021 11:02:11 +0200
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
Subject: Re: [PATCH v1 3/6] mm/memory_hotplug: restrict CONFIG_MEMORY_HOTPLUG
 to 64 bit
Message-ID: <YV63kyvrxt0tx/Ru@localhost.localdomain>
References: <20210929143600.49379-1-david@redhat.com>
 <20210929143600.49379-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929143600.49379-4-david@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 29, 2021 at 04:35:57PM +0200, David Hildenbrand wrote:
> 32 bit support is broken in various ways: for example, we can online
> memory that should actually go to ZONE_HIGHMEM to ZONE_MOVABLE or in
> some cases even to one of the other kernel zones.
> 
> We marked it BROKEN in commit b59d02ed0869 ("mm/memory_hotplug: disable the
> functionality for 32b") almost one year ago. According to that commit
> it might be broken at least since 2017. Further, there is hardly a sane use
> case nowadays.
> 
> Let's just depend completely on 64bit, dropping the "BROKEN" dependency to
> make clear that we are not going to support it again. Next, we'll remove
> some HIGHMEM leftovers from memory hotplug code to clean up.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ea8762cd8e1e..88273dd5c6d6 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -125,7 +125,7 @@ config MEMORY_HOTPLUG
>  	select MEMORY_ISOLATION
>  	depends on SPARSEMEM
>  	depends on ARCH_ENABLE_MEMORY_HOTPLUG
> -	depends on 64BIT || BROKEN
> +	depends on 64BIT
>  	select NUMA_KEEP_MEMINFO if NUMA
>  
>  config MEMORY_HOTPLUG_DEFAULT_ONLINE
> -- 
> 2.31.1
> 
> 

-- 
Oscar Salvador
SUSE Labs
