Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A0F2DE078
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 10:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbgLRJhm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 04:37:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:53424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733025AbgLRJhl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 04:37:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608284215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IhZ+0dR8LrfQCW5eO/oS4fti2P98eOhf3JUH9BPkMbU=;
        b=YS6Qhe3nSl14I6h7xJIeKCv0k7PD3x96Zt4uY8TV5Riai2MNh6SwiauxTkswUURJaPbEXA
        39BxWbxlbthzr2VuIIkFZzCM87b11f1J/NQIr8wQeRs3ighVMbnXDE8h3D2PVaO6Sn7T7t
        wcevud+YDfGTQNVUR2eLEdtgb3FxOgY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04A0DABC6;
        Fri, 18 Dec 2020 09:36:55 +0000 (UTC)
Date:   Fri, 18 Dec 2020 10:36:53 +0100
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
Subject: Re: [PATCH v4 03/10] mm: apply per-task gfp constraints in fast path
Message-ID: <20201218093653.GS32193@dhcp22.suse.cz>
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
 <20201217185243.3288048-4-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217185243.3288048-4-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 17-12-20 13:52:36, Pavel Tatashin wrote:
[..]
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 469016222cdb..d9546f5897f4 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3234,11 +3234,12 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
>  unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>  				gfp_t gfp_mask, nodemask_t *nodemask)
>  {
> +	gfp_t current_gfp_mask = current_gfp_context(gfp_mask);
>  	unsigned long nr_reclaimed;
>  	struct scan_control sc = {
>  		.nr_to_reclaim = SWAP_CLUSTER_MAX,
> -		.gfp_mask = current_gfp_context(gfp_mask),
> -		.reclaim_idx = gfp_zone(gfp_mask),
> +		.gfp_mask = current_gfp_mask,
> +		.reclaim_idx = gfp_zone(current_gfp_mask),
>  		.order = order,
>  		.nodemask = nodemask,
>  		.priority = DEF_PRIORITY,
> @@ -4158,17 +4159,18 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
>  {
>  	/* Minimum pages needed in order to stay on node */
>  	const unsigned long nr_pages = 1 << order;
> +	gfp_t current_gfp_mask = current_gfp_context(gfp_mask);
>  	struct task_struct *p = current;
>  	unsigned int noreclaim_flag;
>  	struct scan_control sc = {
>  		.nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),
> -		.gfp_mask = current_gfp_context(gfp_mask),
> +		.gfp_mask = current_gfp_mask,
>  		.order = order,
>  		.priority = NODE_RECLAIM_PRIORITY,
>  		.may_writepage = !!(node_reclaim_mode & RECLAIM_WRITE),
>  		.may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
>  		.may_swap = 1,
> -		.reclaim_idx = gfp_zone(gfp_mask),
> +		.reclaim_idx = gfp_zone(current_gfp_mask),
>  	};
>  
>  	trace_mm_vmscan_node_reclaim_begin(pgdat->node_id, order,

I was hoping we had agreed these are not necessary and they shouldn't be
touched in the patch.
-- 
Michal Hocko
SUSE Labs
