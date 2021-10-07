Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7280E424EB8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 10:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240561AbhJGILC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 04:11:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36256 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbhJGILB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 04:11:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9CFFE225F4;
        Thu,  7 Oct 2021 08:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633594146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vZ78DbAR+r/e/r6GYTwg4MxP7fk6xf1yQWORN1dcpaw=;
        b=p/Sjmspufjnzjjein9NvN3QmLYZhdyAyB0P0BiEw/nO0oDKX6ZKsoQDpDfFMhkcKuArLRN
        fPH4WEuNCqaQ9xxgOiNhGRVVrXuN1qC+dLhq3H65JcZz//9vtSrXeX6sw73n9G6uYsPW0s
        2H+6gC3mhVlYrBwHlU2eArtih6Dm2FY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633594146;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vZ78DbAR+r/e/r6GYTwg4MxP7fk6xf1yQWORN1dcpaw=;
        b=d7GACDCTta4X67QvurOXYEnWzqbvKqOo3kXRGX7FXuY1MWnD0h4KBmo3KUWYLvUGJahujc
        q2Aj7atscFaMIcDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CC2813A9B;
        Thu,  7 Oct 2021 08:09:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i1ruByGrXmEPEAAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 07 Oct 2021 08:09:05 +0000
Date:   Thu, 7 Oct 2021 10:09:03 +0200
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
Subject: Re: [PATCH v1 1/6] mm/memory_hotplug: remove CONFIG_X86_64_ACPI_NUMA
 dependency from CONFIG_MEMORY_HOTPLUG
Message-ID: <YV6rH31mpJG0WLLQ@localhost.localdomain>
References: <20210929143600.49379-1-david@redhat.com>
 <20210929143600.49379-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929143600.49379-2-david@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 29, 2021 at 04:35:55PM +0200, David Hildenbrand wrote:
> SPARSEMEM is the only possible memory model for x86-64, FLATMEM is not
> possible:
> 	config ARCH_FLATMEM_ENABLE
> 		def_bool y
> 		depends on X86_32 && !NUMA
> 
> And X86_64_ACPI_NUMA (obviously) only supports x86-64:
> 	config X86_64_ACPI_NUMA
> 		def_bool y
> 		depends on X86_64 && NUMA && ACPI && PCI
> 
> Let's just remove the CONFIG_X86_64_ACPI_NUMA dependency, as it does no
> longer make sense.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index d16ba9249bc5..b7fb3f0b485e 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -123,7 +123,7 @@ config ARCH_ENABLE_MEMORY_HOTPLUG
>  config MEMORY_HOTPLUG
>  	bool "Allow for memory hot-add"
>  	select MEMORY_ISOLATION
> -	depends on SPARSEMEM || X86_64_ACPI_NUMA
> +	depends on SPARSEMEM
>  	depends on ARCH_ENABLE_MEMORY_HOTPLUG
>  	depends on 64BIT || BROKEN
>  	select NUMA_KEEP_MEMINFO if NUMA
> -- 
> 2.31.1
> 
> 

-- 
Oscar Salvador
SUSE Labs
