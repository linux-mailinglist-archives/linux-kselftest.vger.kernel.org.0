Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 142C41507A0
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2020 14:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgBCNpV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Feb 2020 08:45:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45706 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgBCNpU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Feb 2020 08:45:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id f25so14649553ljg.12
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2020 05:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IUnQxMQHK0UYauIcgeOHrO2ytoGAz4cOuFspZoniEQM=;
        b=DURGIzxzZtlePaPxLJuosPF5IgjZvLdBpBnJnfYw6LYoKYQi//fW9+VuRZubXpKrEs
         3LMX+Dpp/1wWzauoESO6FvNHyyFvT4ul/xmaQLRrO4IMpiPr5U4TM20F1rk36BsGETrD
         OAVS3E71vo6UWrJIn/2DbLCgJt0lXqBdU2N+2Guw47TBqPHCoLufJi+bKVRkmIWqivfM
         zt/fxcxR0rw0vkfLZVGljC++AW9VE8+TNO4ilAZwM87sCtqkbKX4ppGWe913SsRoISk5
         efZHmY3oSI37vKDvFb11D4iu7C2qLtXgX0OhF/qKJduP3x4bnKRRtidhdUVeVNILt/cB
         x37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IUnQxMQHK0UYauIcgeOHrO2ytoGAz4cOuFspZoniEQM=;
        b=tAzZZEe7ODPWT2bNETnxVAhUY3mPY1tvHT8JoeGiUZV/8qRbmNIXHFt8smo9putwer
         d1d/ez39dZh+O5iCKGqb9vDZQKOeZ0xCdP2rWe/5B/9mXBSq89PV0okbOLjO3/qlcIKr
         2CO+Vxy0THdYAcPSBkidwGCd/W9ZicbEBSXHn4GJ69BKWbuKZlEKcHEHYx590yUCx797
         GbYXRBYvswSemlT0h4JeXD0sEelmdungpd1DE0qxo3jatKkeirRwTN/64ZK6NlYweYVq
         l3z4o6lCwNQSahlViTQaSYfQQEE27RcFO9utkhRU36CkNsYOggQtuAd7rVIqRSYy5mOi
         8F3A==
X-Gm-Message-State: APjAAAWiro854uTTW6THoGj7oho9PUf1X77BowIGqiS0yqQnOVhUkBIG
        0vZFgkKvurdxujkHwrF47a9Guw==
X-Google-Smtp-Source: APXvYqz21QOHxuJSZYBWZNueW6EmQAJJS09hunv0rSU3v6P4mQLVjJclJr9NDXL+6UxPq3PhvyF1oA==
X-Received: by 2002:a2e:8188:: with SMTP id e8mr14013556ljg.57.1580737518361;
        Mon, 03 Feb 2020 05:45:18 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 11sm9941435lju.103.2020.02.03.05.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:45:17 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id EE551100DC8; Mon,  3 Feb 2020 16:45:29 +0300 (+03)
Date:   Mon, 3 Feb 2020 16:45:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/12] mm/gup: page->hpage_pinned_refcount: exact pin
 counts for huge pages
Message-ID: <20200203134529.onxociznb5mgtjhf@box>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-9-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201034029.4063170-9-jhubbard@nvidia.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 31, 2020 at 07:40:25PM -0800, John Hubbard wrote:
> For huge pages (and in fact, any compound page), the
> GUP_PIN_COUNTING_BIAS scheme tends to overflow too easily, each tail
> page increments the head page->_refcount by GUP_PIN_COUNTING_BIAS
> (1024). That limits the number of huge pages that can be pinned.
> 
> This patch removes that limitation, by using an exact form of pin
> counting for compound pages of order > 1. The "order > 1" is required
> because this approach uses the 3rd struct page in the compound page, and
> order 1 compound pages only have two pages, so that won't work there.

Could you update the comment for HPAGE_PMD_ORDER < 2 check in
hugepage_init() to reflect addtional user for the condition.
> 
> A new struct page field, hpage_pinned_refcount, has been added,
> replacing a padding field in the union (so no new space is used).
> 
> This enhancement also has a useful side effect: huge pages and compound
> pages (of order > 1) do not suffer from the "potential false positives"
> problem that is discussed in the page_dma_pinned() comment block. That
> is because these compound pages have extra space for tracking things, so
> they get exact pin counts instead of overloading page->_refcount.
> 
> Documentation/core-api/pin_user_pages.rst is updated accordingly.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
