Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79FC4151227
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2020 22:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgBCVzn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Feb 2020 16:55:43 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33704 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgBCVzn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Feb 2020 16:55:43 -0500
Received: by mail-lf1-f67.google.com with SMTP id n25so10844117lfl.0
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2020 13:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xJAkb73npUQtmUSyvboyg3nc2D2eMj/LRe7QTM0JtTw=;
        b=DW4g/6/MYnXF1LPe7/2RfS04IyD4h5v6Zw7F9g9HD0UoluTY5xl5rQH07HxoIfbmSL
         LbFPoisu/4Tf5fjpwS9AZkUc3Kpx3LfxRMz8B9pPJvkrCLA7ieUqNXTThuqVrogXnyXm
         YmQ06qGBkh/Fdsm2rVaRMS0Rnw0TP30W+hypvgpymsuhXKoHKFW7l3sqQWzs6Er7Z+aE
         hf88D1ebprJj+AYGaHcWnx0tNLJhNmcUm61BuHbDtb4G838UMGhHK90rGrVQ2upG1cZ/
         o/zhxtnTwPa6UXPgEeMmNrNB7tYI4gWFHfxIfqHrrdDCxj+zCFGgWe5xu355ukz9kbT4
         S7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xJAkb73npUQtmUSyvboyg3nc2D2eMj/LRe7QTM0JtTw=;
        b=shk+9zsc4jWwhY8xkldD3s46LACGoI8JvHz6rLdFdMeMyvCZ/oTePfsZi6rwX9kXYA
         a7Uxrgxp+29cWuDNm70qL1Mbt810Os3rNXof4QXuqrFZ3oRxA8kxosyTOG6kpBQlYA49
         Ql8nAZpPNTurPsnFYy+B34q0unyXF+ruNdPSlxrWRGBE60j7pEMyL0TzM+HXGl6hqdSV
         6DthPcXb1cFbMQuCmz94O7w8Y4+Vp3YWbeB9N/b9xSrK3JAM/1wxHdj5rxXcJPhNh7Mx
         QKf27zLDznVBcHGHEFoqvgaYOsDyNer384fj5RX7xkljks5xxqXslS1M+yEXvL6RF7ri
         oClA==
X-Gm-Message-State: APjAAAU3ULL7FCNy+Gv8OIe1Q5hhi5rc+RWr5C7F7nJoCVFtSf11TO34
        lf7DbvXqAlGE+wjAPY0svtNGcQ==
X-Google-Smtp-Source: APXvYqzKhf8yy+VrDIH7P5bwPA/N4dISxyqqDNekLgToc6ApS5rJ2jA6asIx54ka9+WFODqsBDZ5WA==
X-Received: by 2002:a19:9159:: with SMTP id y25mr13507738lfj.63.1580766941406;
        Mon, 03 Feb 2020 13:55:41 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 144sm9700269lfi.67.2020.02.03.13.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 13:55:40 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 86130100AF6; Tue,  4 Feb 2020 00:55:53 +0300 (+03)
Date:   Tue, 4 Feb 2020 00:55:53 +0300
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
Subject: Re: [PATCH v3 11/12] mm/gup_benchmark: support pin_user_pages() and
 related calls
Message-ID: <20200203215553.q7zx6diprbby6ns5@box.shutemov.name>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-12-jhubbard@nvidia.com>
 <20200203135845.ymfbghs7rf67awex@box>
 <b554db44-7315-b99f-1151-ba2a1b2445ce@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b554db44-7315-b99f-1151-ba2a1b2445ce@nvidia.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 03, 2020 at 01:17:40PM -0800, John Hubbard wrote:
> On 2/3/20 5:58 AM, Kirill A. Shutemov wrote:
> ...
> >> @@ -19,6 +21,48 @@ struct gup_benchmark {
> >>  	__u64 expansion[10];	/* For future use */
> >>  };
> >>  
> >> +static void put_back_pages(unsigned int cmd, struct page **pages,
> >> +			   unsigned long nr_pages)
> >> +{
> >> +	int i;
> >> +
> >> +	switch (cmd) {
> >> +	case GUP_FAST_BENCHMARK:
> >> +	case GUP_LONGTERM_BENCHMARK:
> >> +	case GUP_BENCHMARK:
> >> +		for (i = 0; i < nr_pages; i++)
> > 
> > 'i' is 'int' and 'nr_pages' is 'unsigned long'.
> > There's space for trouble :P
> > 
> 
> Yes, I've changed it to "unsigned int", thanks.

I'm confused. If nr_pages is more than UINT_MAX, this is endless loop.
Hm?

-- 
 Kirill A. Shutemov
