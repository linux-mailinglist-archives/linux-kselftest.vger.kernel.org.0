Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13BA3504E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Mar 2021 18:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCaQpO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 12:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbhCaQpN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 12:45:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89707C061574;
        Wed, 31 Mar 2021 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LnyurCNF+pzYn73McUghCf+KgIuymWoL0n9UtfxjZ5I=; b=XX9m+e/uw0GHAz5LWPmFufWrW+
        yxEx20kNwOD6TeePa7oPeZaWN5L6RBs6vxKNsDglWAKfk7yZ1pAlSeP+l82+Uuo+yKOVoejCHYcVG
        /yeAQoePrkwLEu4HJA4WCDXIniCzUNYyH4R6EPX4BWABbRsuweiaGJrFZX5EaXoln9Hnin0hOOdSn
        NLF2sJqAoETbtTIADu4WOOsmDc+L9Bl/MiLxQXZ/nr6rqRj3E1QkRCF6IpspJuNzOSG10iROx0pHG
        BzeVEC2q34SrLVuml3tf4ACwpvhD0+ejjt5vEpPTavwnOA2//PejAaI9fYgKPZabXl1oo3qVyTDrU
        xQ7Xnt3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRdxO-004pyX-ID; Wed, 31 Mar 2021 16:44:49 +0000
Date:   Wed, 31 Mar 2021 17:44:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Mika Penttila <mika.penttila@nextfour.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v7 2/2] mm: huge_memory: debugfs for file-backed THP
 split.
Message-ID: <20210331164438.GY351017@casper.infradead.org>
References: <20210329153932.134510-1-zi.yan@sent.com>
 <20210329153932.134510-2-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329153932.134510-2-zi.yan@sent.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 29, 2021 at 11:39:32AM -0400, Zi Yan wrote:
> +	for (off_cur = off_start; off_cur < off_end;) {
> +		struct page *fpage = pagecache_get_page(mapping, off_cur,
> +						FGP_ENTRY | FGP_HEAD, 0);
> +
> +		if (xa_is_value(fpage) || !fpage) {
> +			off_cur += PAGE_SIZE;
> +			continue;
> +		}
> +
> +		if (!is_transparent_hugepage(fpage)) {
> +			off_cur += PAGE_SIZE;
> +			goto next;
> +		}
> +		total++;
> +		off_cur = fpage->index + thp_size(fpage);

That can't be right.  fpage->index is in units of pages and thp_size is
in units of bytes.  I wish C had a better type system.
I think you meant:

		off_cur = fpage->index + thp_nr_pages(fpage);

Also, I think this loop would read better as ...

	for (index = off_start; index < off_end; index += nr_pages) {
		struct page *fpage = pagecache_get_page(mapping, index,
						FGP_ENTRY | FGP_HEAD, 0);
		nr_pages = 1;
		if (xa_is_value(fpage) || !fpage)
			continue;
		if (!is_transparent_hugepage(fpage))
			goto next;
		total++;
		nr_pages = thp_nr_pages(fpage);
...

