Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321EF30E1BB
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Feb 2021 19:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhBCSBk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Feb 2021 13:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbhBCSAr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Feb 2021 13:00:47 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87516C061573
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Feb 2021 10:00:06 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id v126so537622qkd.11
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Feb 2021 10:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=maK4BO0r+TiWcThPzVJ4RLB+sQqUIwmjmNwcvNFw9mM=;
        b=OYYwV/hPNphEgxWKjIs0jsEBIteW6sjsSXmm3kaRKAgNvo0roJkISTnB3HeCqjylB1
         iLoTG4ajADQexcPU77OJd+AN9V5ickef33AD3Y5bjRuNtAHpzo0+8Yw1vns5Lt5UhnC1
         uKxg7AHn0awSVc6rMvjtk3PJ5vyhywm73ut3NeHl8CZk7DWGSksRjlVCzx6En8NmAr93
         1M9M89Hj+fI+hzquvwbsBnibhh4tZtP2rpBjGZDKqcCQbz0bmK7NiWxQgCR4lwSqUAby
         tB+on+omxCPkuzrbxhR1IN8i6uluffWqHXTWxVrYzyuO2UNAn68SmpLVpA/L+mVnnkiK
         iELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=maK4BO0r+TiWcThPzVJ4RLB+sQqUIwmjmNwcvNFw9mM=;
        b=X0fRu03nuYT7fw88UlsM5u3ndnAA2NWR46jTDBX3Zgn3K7STbSgFlztAFeYOouDhDR
         7wkRSvqoAW6U89M+eY0J8msz2GIc1YtvbCJPkxeCgk5A59jMyF5WSeEwRoal2vbLCZKz
         OT7nkDnT5weEsQbvOcSMYD7azjYbmT9Uz/NhWSfu8GW1SpiFmUdBj8gCjrP3ClPje+JM
         4c5fPKFdZuKvp/cvaesUG/7C84N4KLcDI6asuIJOYEfmxUK3pTMXjnajYtjVWIUQ0Mf9
         P6eLiW1h1qENmaNhXEIEBBHIKnxvPR7saeLMHctDpiEldh4wIUn54oaYnOTYBYUJWHs+
         4yjA==
X-Gm-Message-State: AOAM5314iYKWv2O1Ncoiz1ah78nGXQbLAnSBQTnYIKNaho0v57K/a2dV
        xrPKvc2W9xNOiw778WzNOCL58Q==
X-Google-Smtp-Source: ABdhPJwEkVpBQ0h4gu1N6ijIQ9L8ChOranP2j16LpvLRdZKU1JEvM2fYv79/G9ZWclAbkk9R8dy2PQ==
X-Received: by 2002:a37:aa58:: with SMTP id t85mr3620548qke.229.1612375205841;
        Wed, 03 Feb 2021 10:00:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id h5sm1970465qti.22.2021.02.03.10.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 10:00:05 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l7MRg-0034r0-IJ; Wed, 03 Feb 2021 14:00:04 -0400
Date:   Wed, 3 Feb 2021 14:00:04 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        iamjoonsoo.kim@lge.com, mike.kravetz@oracle.com,
        rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        mgorman@suse.de, willy@infradead.org, rientjes@google.com,
        jhubbard@nvidia.com, linux-doc@vger.kernel.org,
        ira.weiny@intel.com, linux-kselftest@vger.kernel.org,
        jmorris@namei.org
Subject: Re: [PATCH v8 02/14] mm/gup: check every subpage of a compound page
 during isolation
Message-ID: <20210203180004.GS4718@ziepe.ca>
References: <20210125194751.1275316-1-pasha.tatashin@soleen.com>
 <20210125194751.1275316-3-pasha.tatashin@soleen.com>
 <05a66361-214c-2afe-22e4-12862ea1e4e2@oracle.com>
 <20210203145313.GQ4718@ziepe.ca>
 <f82dca38-52bd-aa27-2d27-b5a67f5284f5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f82dca38-52bd-aa27-2d27-b5a67f5284f5@oracle.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 03, 2021 at 04:13:21PM +0000, Joao Martins wrote:

> If check_and_migrate_movable_pages() is meant to migrate unpinned
> pages, then rather than pinning+unpinning+moving, perhaps it would
> be called in __get_user_pages() place where we are walking page
> tables and know if it's a PUD/PMD and can skip all the subpages and
> just record and migrate those instead. Was that your thinking?

I think a reasonable approach is to detect non-pinnable pages while
walking the VMAs, when found isolate them and thread them on a linked
list.

When the VMA walk is done you'll have a linked list of isolated pages
that need migration. So the check_and_migrate_movable_pages() gets
split into the top half being diffused in the VMA walk and the bottom
half still called after __get_user_pages() returns.

Jason
