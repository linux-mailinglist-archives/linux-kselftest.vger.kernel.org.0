Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784BF2FBF6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 19:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387730AbhASStF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jan 2021 13:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404355AbhASSF7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jan 2021 13:05:59 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2573AC061575
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 10:05:14 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id b64so22728237qkc.12
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 10:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VdWMG/uGCJ43g2jyUu+cOqHYdfz8BVsdLX4Jg//Lvgk=;
        b=j05GmtUhLQZqMespMujz2B04lEC5T+G/IfPEWSLg9vszMTM84+Zwtv7YEyyGBOnOMD
         YZC13ZpoqFi0CBqzxMyMLz5MGzx9rrfUGkf8WoTmWLe+XPRMAlK9wStYfMqqlkPknPAq
         yGDvTKn7uo+pfQGH7wmxQgS0VxVr6WuRqwgAHe+hR8rmQgHR51984f46IM/N2BUDhuUS
         YJMag/9hIm93ON0T4gX5kXGSFdmvo91YglWHnbp2mCOm7C6wA5Cg0t+d33mCD3gJD5CY
         VLG4PZoRo65ssQgEKGnjk49NqZBmRBjXDP1dFdICMM9Iv1Yj7cOvkh0ctNhWEORsk4bd
         7Mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VdWMG/uGCJ43g2jyUu+cOqHYdfz8BVsdLX4Jg//Lvgk=;
        b=RxRx0k+G2bvK0NdLOGMfFh+bVnN+8G6y7O7tKeKP/SD0HGj19TaiUad1SNULjfdMRK
         5Lyzh/5C9RhEyVx2Iil/b+Mi1t28foKoTrTB7WWML+tmVXXQqCCNhuB/C3/jboWT0Zcz
         37ojNfiUTxeLu9owcGYjf+tscv5mYYpPJgcinXPP330b9w8/goxtcHP30Iax8t6dNY+e
         LoEo4WaGpr69V6r35gq1kb5obdnGmJgf7SQqdZDyrFeOtm22ye5VheSky+UVcs0gO1CB
         viCeMq5C+6LlHCe0T4Ta4KTRAapeB+u5mmKbKvGSpwD11Lpp3z2cxJshbJ4dRZL6qVeM
         SrCA==
X-Gm-Message-State: AOAM531SyRzGDCZPhL4MjT9/IekTq4oBkBIHuwvxZWriko4UoQeBBNq2
        +S69JSYRihvb/lrFC4CiPeOfjA==
X-Google-Smtp-Source: ABdhPJx7MA8sBMbEtUSV41m+37ci8w0m1RGlrZnwqu/7wxd6/5Vt3/6VIuQwvxqlLT6y5Ik3JcwCyA==
X-Received: by 2002:a37:a50c:: with SMTP id o12mr5590816qke.98.1611079513428;
        Tue, 19 Jan 2021 10:05:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id o5sm12802873qti.47.2021.01.19.10.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 10:05:13 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l1vNQ-003pFv-F7; Tue, 19 Jan 2021 14:05:12 -0400
Date:   Tue, 19 Jan 2021 14:05:12 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        iamjoonsoo.kim@lge.com, mike.kravetz@oracle.com,
        rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        mgorman@suse.de, willy@infradead.org, rientjes@google.com,
        jhubbard@nvidia.com, linux-doc@vger.kernel.org,
        ira.weiny@intel.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 02/14] mm/gup: check every subpage of a compound page
 during isolation
Message-ID: <20210119180512.GY4605@ziepe.ca>
References: <20210119043920.155044-1-pasha.tatashin@soleen.com>
 <20210119043920.155044-3-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119043920.155044-3-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 18, 2021 at 11:39:08PM -0500, Pavel Tatashin wrote:
> When pages are isolated in check_and_migrate_movable_pages() we skip
> compound number of pages at a time. However, as Jason noted, it is
> not necessary correct that pages[i] corresponds to the pages that
> we skipped. This is because it is possible that the addresses in
> this range had split_huge_pmd()/split_huge_pud(), and these functions
> do not update the compound page metadata.
> 
> The problem can be reproduced if something like this occurs:
> 
> 1. User faulted huge pages.
> 2. split_huge_pmd() was called for some reason
> 3. User has unmapped some sub-pages in the range
> 4. User tries to longterm pin the addresses.
> 
> The resulting pages[i] might end-up having pages which are not compound
> size page aligned.
> 
> Fixes: aa712399c1e8 ("mm/gup: speed up check_and_migrate_cma_pages() on huge page")
> 
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>

No new line after fixes

> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>  mm/gup.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)

Looks good

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason
