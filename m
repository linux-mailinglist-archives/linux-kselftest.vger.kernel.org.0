Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520D62A960A
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 13:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgKFMOS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 07:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgKFMOS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 07:14:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C120C0613CF;
        Fri,  6 Nov 2020 04:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wdArR4SHu2gVwVCDPOZrqVGBGWB7EWn5STqcT4bB33k=; b=aOkaNP8WZH4t1Wns/ePyMSfp5O
        155hPzRmP47qJCbmYtSQvXMqvRjT43bFMlTyiCKhIu25g6ZNZ61hhu6RRcePjR7HRtHf5BFqScCgY
        wC+CrZOl8xhJ4LGMfj06PRCHNvouk1xIyuoh3rz6S+eX5f0+wk35xlfsDHIy/LfRSMBWjfRRuc/4I
        i6rwfhMnKN2PiMR1hTVfOLsV6KoSUcNNtzkuFGcwClnRC2me+NCB+UTOGSDB69/JZx7yrzuz5tcDj
        xLebLHADq8qaWnlZH36ddbmZtSfNSfE3A3e1Pg45fmRxj7uHMzvkM5vL0iPCODUeUjxCApzedsJJl
        A38knfLg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb0d5-0006Re-7j; Fri, 06 Nov 2020 12:14:07 +0000
Date:   Fri, 6 Nov 2020 12:14:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/6] mm/thp: add prep_transhuge_device_private_page()
Message-ID: <20201106121407.GQ17076@casper.infradead.org>
References: <20201106005147.20113-1-rcampbell@nvidia.com>
 <20201106005147.20113-2-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106005147.20113-2-rcampbell@nvidia.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 05, 2020 at 04:51:42PM -0800, Ralph Campbell wrote:
> Add a helper function to allow device drivers to create device private
> transparent huge pages. This is intended to help support device private
> THP migrations.

I think you'd be better off with these calling conventions:

-void prep_transhuge_page(struct page *page)
+struct page *thp_prep(struct page *page)
 {
+       if (!page || compound_order(page) == 0)
+               return page;
        /*
-        * we use page->mapping and page->indexlru in second tail page
+        * we use page->mapping and page->index in second tail page
         * as list_head: assuming THP order >= 2
         */
+       BUG_ON(compound_order(page) == 1);
 
        INIT_LIST_HEAD(page_deferred_list(page));
        set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
+
+       return page;
 }

It simplifies the users.

> +void prep_transhuge_device_private_page(struct page *page)
> +{
> +	prep_compound_page(page, HPAGE_PMD_ORDER);
> +	prep_transhuge_page(page);
> +	/* Only the head page has a reference to the pgmap. */
> +	percpu_ref_put_many(page->pgmap->ref, HPAGE_PMD_NR - 1);
> +}
> +EXPORT_SYMBOL_GPL(prep_transhuge_device_private_page);

Something else that may interest you from my patch series is support
for page sizes other than PMD_SIZE.  I don't know what page sizes your
hardware supports.  There's no support for page sizes other than PMD
for anonymous memory, so this might not be too useful for you yet.
