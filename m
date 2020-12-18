Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D7D2DE08F
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 10:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbgLRJpa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 04:45:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:57294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbgLRJpa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 04:45:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608284683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qvWpWbEVzaGdCtT7lY02iDD8k+ikMF0dcZg/sL419MU=;
        b=XxjUmRtsLsgb930BhBZuWO8HArjYr53zHDvbqLhbU11F5AoFpegckrbl6Lp7seCfOsPrxo
        vJa7+rmjsW39l5Lim+zoAJPPG48d514n+n6dyL+fLEXm9WidgFnEUXaykQBsb8T9nHljwD
        dhrssBMDGOgEH5Nqhncc1j///AKYo/w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A480AC7B;
        Fri, 18 Dec 2020 09:44:43 +0000 (UTC)
Date:   Fri, 18 Dec 2020 10:44:42 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        osalvador@suse.de, dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org, ira.weiny@intel.com,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 06/10] memory-hotplug.rst: add a note about
 ZONE_MOVABLE and page pinning
Message-ID: <20201218094442.GU32193@dhcp22.suse.cz>
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
 <20201217185243.3288048-7-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217185243.3288048-7-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 17-12-20 13:52:39, Pavel Tatashin wrote:
> Document the special handling of page pinning when ZONE_MOVABLE present.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Suggested-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  Documentation/admin-guide/mm/memory-hotplug.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
> index 5c4432c96c4b..c6618f99f765 100644
> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
> @@ -357,6 +357,15 @@ creates ZONE_MOVABLE as following.
>     Unfortunately, there is no information to show which memory block belongs
>     to ZONE_MOVABLE. This is TBD.
>  
> +.. note::
> +   Techniques that rely on long-term pinnings of memory (especially, RDMA and
> +   vfio) are fundamentally problematic with ZONE_MOVABLE and, therefore, memory
> +   hot remove. Pinned pages cannot reside on ZONE_MOVABLE, to guarantee that
> +   memory can still get hot removed - be aware that pinning can fail even if
> +   there is plenty of free memory in ZONE_MOVABLE. In addition, using
> +   ZONE_MOVABLE might make page pinning more expensive, because pages have to be
> +   migrated off that zone first.
> +
>  .. _memory_hotplug_how_to_offline_memory:
>  
>  How to offline memory
> -- 
> 2.25.1
> 

-- 
Michal Hocko
SUSE Labs
