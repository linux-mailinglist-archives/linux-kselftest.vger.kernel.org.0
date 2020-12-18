Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AFC2DE09E
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 10:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgLRJvs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 04:51:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:59304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbgLRJvr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 04:51:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608285061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gj+Ab4/r/K+F7TiCHgR5KM1JBO4iooikxV3r5qIMkN0=;
        b=KJcwJZ+sBdXaNQ5VKVFVQkK7bl/c8tbiCVjiliR5Os5TgKjMPWAjz+2k7x5fU1nE6a/PBZ
        +QI0pirc1UpbxYaHxXfpsgJr9c0oEEW3NCCIr+d0qT04FpI/uxC8UHMYN28b7HFPi2E6Gs
        hMhYREbNQXgKhgx9OYOkK8IZKE6en0o=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 112FFAC7B;
        Fri, 18 Dec 2020 09:51:01 +0000 (UTC)
Date:   Fri, 18 Dec 2020 10:50:58 +0100
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
Subject: Re: [PATCH v4 07/10] mm/gup: change index type to long as it counts
 pages
Message-ID: <20201218095058.GV32193@dhcp22.suse.cz>
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
 <20201217185243.3288048-8-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217185243.3288048-8-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 17-12-20 13:52:40, Pavel Tatashin wrote:
> In __get_user_pages_locked() i counts number of pages which should be
> long.

Do we know of any caller who would like to pin so many pages it wouldn't
fit into an int? I suspect this is more to sync types of nr_pages and
the iterator right. It would be better to be explicit about this in the
changelog.

> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/gup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 591d8e2dfc70..1ebb7cc2fbe4 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1481,7 +1481,7 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
>  {
>  	struct vm_area_struct *vma;
>  	unsigned long vm_flags;
> -	int i;
> +	long i;
>  
>  	/* calculate required read or write permissions.
>  	 * If FOLL_FORCE is set, we only require the "MAY" flags.
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
