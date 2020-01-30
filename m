Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5548214D9D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2020 12:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgA3LbX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Jan 2020 06:31:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35859 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA3LbX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Jan 2020 06:31:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so2956231ljg.3
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jan 2020 03:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/EN520UCUxsEUBwp+gxS6OoGlcVQKRNBVBF0BZx9y+I=;
        b=Tsy8nAO0PvaScoyPHxQ8u0Q+uBQzLnebXEkKCAg+P2fPtHalLWm98o3bNIETmJk5Ax
         GIRK0uSiHJ59wddWXiQye/G8OPgZv2mm0LsDsZ2nZHJirH3IYNo46TkDYqgz5CMTQ1xw
         3wr3AseYMfQDfaItEw9mxy6wVkEHMXK3pBatYbOrO+QJm5HvMdWQdcvT4UvyPjEjlV2I
         c7o3jEmW8+sHIEpnAt1EMA8iI5ykE01yWc3XdnCvW/XjyKW71c9UFc0YbgGm38DCjXvU
         4b7+TJJVVG8NR6O6Z0y2TSvGBoBUJu7xGq45uwGY0olDpcFxUsT1bVJAtVtVMKT7uqdU
         My4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/EN520UCUxsEUBwp+gxS6OoGlcVQKRNBVBF0BZx9y+I=;
        b=dRxMkLw1ypzs2dD5XabVEXnKKZ4sxsDsiUo8Okgsb0GjnpQz6Bn5AaQ+v80kj5Sqn1
         H3uHSeA7sFroMzzJV8ed232/ADIuody0p1MgtwGZBymIIAE5OF/ojxKk+Czi9yh711JR
         YUw3OHMAH+c3BMHw/C+ph4miOsbKojqQhhHUWeNszeLEDmJr/3VmoLte+GwbM6r2l7e5
         cg7EPmb2zkNOsDcDJzE3Am0XEmwo9JzQLjQt7iAqKQ11xupMeV0bMiRjKKnzQT6fdXO3
         VwQ7bUzk8dI/GKVAD9n5MOSHU8MD8V39K2pHuSlcy/OYBN5EfZ0SY3QYhtBWimrfEDmE
         wpcA==
X-Gm-Message-State: APjAAAUgxRL9DjMyR9JeXlzvVVxPdZBa7W42yabkWnECye30zNGag53E
        r5fSjrkdb6bv0O0URDO1SCJM6w==
X-Google-Smtp-Source: APXvYqzOfHleShWYEZ7+vculAYaLdAq1R8IjRRLv6oV11NywrAJ0QawfN5bbH06GtSQcqK2Wevv/Xw==
X-Received: by 2002:a2e:9218:: with SMTP id k24mr2468907ljg.262.1580383878986;
        Thu, 30 Jan 2020 03:31:18 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u25sm2683666ljj.70.2020.01.30.03.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 03:31:18 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id C35F8100B00; Thu, 30 Jan 2020 14:31:26 +0300 (+03)
Date:   Thu, 30 Jan 2020 14:31:26 +0300
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
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 4/8] mm/gup: track FOLL_PIN pages
Message-ID: <20200130113126.5ftq4gd5k7o7tipj@box>
References: <20200129032417.3085670-1-jhubbard@nvidia.com>
 <20200129032417.3085670-5-jhubbard@nvidia.com>
 <20200129135153.knie7ptvsxcgube6@box>
 <0be743df-e9af-6da9-c593-9e25ab194acf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be743df-e9af-6da9-c593-9e25ab194acf@nvidia.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 29, 2020 at 10:44:50PM -0800, John Hubbard wrote:
> On 1/29/20 5:51 AM, Kirill A. Shutemov wrote:
> > > +/**
> > > + * page_dma_pinned() - report if a page is pinned for DMA.
> > > + *
> > > + * This function checks if a page has been pinned via a call to
> > > + * pin_user_pages*().
> > > + *
> > > + * For non-huge pages, the return value is partially fuzzy: false is not fuzzy,
> > > + * because it means "definitely not pinned for DMA", but true means "probably
> > > + * pinned for DMA, but possibly a false positive due to having at least
> > > + * GUP_PIN_COUNTING_BIAS worth of normal page references".
> > > + *
> > > + * False positives are OK, because: a) it's unlikely for a page to get that many
> > > + * refcounts, and b) all the callers of this routine are expected to be able to
> > > + * deal gracefully with a false positive.
> > 
> > I wounder if we should reverse the logic and name -- page_not_dma_pinned()
> > or something -- too emphasise that we can only know for sure when the page
> > is not pinned, but not necessary when it is.
> > 
> 
> This is an interesting point. I agree that it's worth maybe adding information
> into the function name, but I'd like to keep the bool "positive", because there
> will be a number of callers that ask "if it is possibly dma-pinned, then ...".
> So combining that, how about this function name:
> 
> 	page_maybe_dma_pinned()
> 
> , which I could live with and I think would be acceptable?

I would still prefer the negative version, but up to you.

> > I see opportunity to split the patch further.
> 
> 
> ah, OK. I wasn't sure how far to go before I get tagged for "excessive
> patch splitting"! haha. Anyway, are you suggesting to put the
> page_ref_sub_return() routine into it's own patch?
> 
> Another thing to split out would be adding the flags to the remaining
> functions, such as undo_dev_pagemap(). That burns quite a few lines of
> diff. Anything else to split out?

Nothing I see immediately.

> 
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index 0a55dec68925..b1079aaa6f24 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -958,6 +958,11 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
> > >   	 */
> > >   	WARN_ONCE(flags & FOLL_COW, "mm: In follow_devmap_pmd with FOLL_COW set");
> > > +	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
> > > +	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
> > > +			 (FOLL_PIN | FOLL_GET)))
> > 
> > Too many parentheses.
> 
> 
> OK, I'll remove at least one. :)

I see two.

-- 
 Kirill A. Shutemov
