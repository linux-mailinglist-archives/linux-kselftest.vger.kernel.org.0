Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D124424FD8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 11:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhJGJQ3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 05:16:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48896 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhJGJQ3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 05:16:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9552822606;
        Thu,  7 Oct 2021 09:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633598074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cswkhhcfrLOH/Y26qTRIeZpiemgZqnbHNMLxH2x3btM=;
        b=qfOUKXsR7e87fn1oGDhaqxVIO8dxvZ+8a0dUZ45Q23dHwweUBefzTlwjQDJP1C91BTuZw0
        O9kR/2hfmVJRdw1HxSCN6nk3DiB/T81G7SQc3pADGRgMEHZXmkLTvadytYUTdJU5Q/oHMQ
        bIJof07dsWx4MnrvTBtXt4J9nFpLOAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633598074;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cswkhhcfrLOH/Y26qTRIeZpiemgZqnbHNMLxH2x3btM=;
        b=UPxs4ijNBWaFkUoGlEMQozV3GDZZu3LoEJ+AFTgJk6ogaLxMXhnjIZkqOnKZg3DS4U/ldI
        9DR7XL5x1xb6Q3CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29F4213A98;
        Thu,  7 Oct 2021 09:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gNmHB3m6XmEDLgAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 07 Oct 2021 09:14:33 +0000
Date:   Thu, 7 Oct 2021 11:14:31 +0200
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
Subject: Re: [PATCH v1 5/6] mm/memory_hotplug: remove stale function
 declarations
Message-ID: <YV66d+6FLkzb0lWR@localhost.localdomain>
References: <20210929143600.49379-1-david@redhat.com>
 <20210929143600.49379-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929143600.49379-6-david@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 29, 2021 at 04:35:59PM +0200, David Hildenbrand wrote:
> These functions no longer exist.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  include/linux/memory_hotplug.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index e5a867c950b2..be48e003a518 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -98,9 +98,6 @@ static inline void zone_seqlock_init(struct zone *zone)
>  {
>  	seqlock_init(&zone->span_seqlock);
>  }
> -extern int zone_grow_free_lists(struct zone *zone, unsigned long new_nr_pages);
> -extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
> -extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
>  extern void adjust_present_page_count(struct page *page,
>  				      struct memory_group *group,
>  				      long nr_pages);
> -- 
> 2.31.1
> 
> 

-- 
Oscar Salvador
SUSE Labs
