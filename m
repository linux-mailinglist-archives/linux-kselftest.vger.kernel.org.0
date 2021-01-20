Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C9A2FD1CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jan 2021 14:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbhATN11 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jan 2021 08:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730313AbhATNUU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jan 2021 08:20:20 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E07C061757
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jan 2021 05:19:40 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id j18so10836526qvu.3
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jan 2021 05:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JuQvGRvkQQfVRzn/FUI+haarmzYqzGiLWBP9Je4qZPE=;
        b=QHJVd3T5Tsl7WmiiJ+h+AhTVu4iAWpt/4foFcd4/mjShCb05HeiGCXzKAj+Da/VDvV
         QqCbyDX+iw+0+XERIeP1O2cu/DekTw4hKakyJ638PzTcE2mQiR/oPwKEsyQv81ntuBUA
         IxtkYJu/+X8kTXcCLKn+qpX/46Ms6sZfYWWaIdX0MhJg6q5zRuogluR7m7+4GTW68pJy
         CNJzr2I+/7YWY6RRVTZNzBKAWMuIFxMbyHZqzIQbmdcme9ixdyOYyqXa3nCZnV08TVmf
         t1RQvZOApFqM68tMKYBli2pd1wrLaIUXypZac/PIJ2HSrwUtOfWNghJ1LMNXXysB4qCX
         6JDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JuQvGRvkQQfVRzn/FUI+haarmzYqzGiLWBP9Je4qZPE=;
        b=fQAdoJkrpxs/YwFaB6DBFS1WhP0FioO9WVRN4QmiC3bpW6TjWkUk8ly74aztNY3BvZ
         b4038xft4lkA6CVFLTX+Og/kyyuzYkIDTTbPnuB9DsXETcxh4VW7Kt7TgbJBFjl1AXOU
         mWi94zGDmheuGaqAREXrk7mCMPNGyOCJ8Fhp1hSX0E2YNqR5xmIOvv1palWLh6o6eaxO
         pCa3wWzdwBmjvyfTNI35J+ou6WnPPK3+mbGJ9tmq4n4FlsSBdz6rauN7dttLKJNyyddt
         fBwptl97NzpMpMcwoGWl6YanWYjbZDRoRwb9BclJ+5FQQY4BYiy41myt691sPZN/lGbO
         KrHA==
X-Gm-Message-State: AOAM533T5cvzucus+Sn/xBK9hCTWLq8YnfBeHe1VMXCXrJHC3gycsQVz
        dtvKoelUDjx57vIdeGcPiDb6HA==
X-Google-Smtp-Source: ABdhPJz4cQZ1YMTMG0FLUN0ZbA69O2/qIdTs4LRKLu+daL+1MgPSen3w52S63HZWxLilbEYISziQdA==
X-Received: by 2002:a05:6214:1110:: with SMTP id e16mr9110666qvs.62.1611148779431;
        Wed, 20 Jan 2021 05:19:39 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id b67sm1249374qkc.44.2021.01.20.05.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 05:19:38 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l2DOb-004Tve-SU; Wed, 20 Jan 2021 09:19:37 -0400
Date:   Wed, 20 Jan 2021 09:19:37 -0400
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
Subject: Re: [PATCH v6 12/14] mm/gup: longterm pin migration cleaup
Message-ID: <20210120131937.GG4605@ziepe.ca>
References: <20210120014333.222547-1-pasha.tatashin@soleen.com>
 <20210120014333.222547-13-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120014333.222547-13-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 19, 2021 at 08:43:31PM -0500, Pavel Tatashin wrote:
> When pages are longterm pinned, we must migrated them out of movable zone.
> The function that migrates them has a hidden loop with goto. The loop is
> to retry on isolation failures, and after successful migration.
> 
> Make this code better by moving this loop to the caller.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>  mm/gup.c | 88 +++++++++++++++++++++++---------------------------------
>  1 file changed, 36 insertions(+), 52 deletions(-)

This looks OK, it is better

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I really dislike we always have to go over the page list twice in pin
mode

The is_pinnable_page() and LRU isolation should really be done inside
__get_user_pages_locked() as each page is added to the output list

But that is more of a larger issue than this series

Jason
