Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094FE20FEA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jun 2020 23:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgF3VXr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Jun 2020 17:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgF3VXq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Jun 2020 17:23:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7FAC061755;
        Tue, 30 Jun 2020 14:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n8SHJfzy7p8PW3wOzwIG1BQWiEf6w6qyoS+BP0Vtvzc=; b=CWOPBHTbbV7jN6/0NnoGwn1IDU
        /8KBtqnWiJHtbzZnkwChwmYJjDAb2XDLufpU89h7mqwO7TlRcjxxI6rjcpTKLMx6q0Ff7L2fgDHmO
        DRsSGKj2b5iviSdaZSUjHgmK6nzwT7QXmpDPtFAA/CgPqJpNdmN5cJZhkbGZtrfYyBUuRpPE6pQ/D
        fhrlZYuY5B3JC8jSeH9oPEyVT7vUzZwwZOItAp00BZLjBSCipFKj1lWvQoNNkHIIbc/nmOp3Uh4fm
        AgPWvtO+pb0HLSss5V8jEjJebl1GuZvzjDkD8LqeTRHug9r51lYFKveyh+de9kE2sdRSrg8bliJHF
        wAIENPMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqNjD-00007m-C1; Tue, 30 Jun 2020 21:23:43 +0000
Date:   Tue, 30 Jun 2020 22:23:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH v2 2/5] mm/hmm: add output flags for PMD/PUD page mapping
Message-ID: <20200630212343.GP25523@casper.infradead.org>
References: <20200630195737.8667-1-rcampbell@nvidia.com>
 <20200630195737.8667-3-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630195737.8667-3-rcampbell@nvidia.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 30, 2020 at 12:57:34PM -0700, Ralph Campbell wrote:
> hmm_range_fault() returns an array of page frame numbers and flags for
> how the pages are mapped in the requested process' page tables. The PFN
> can be used to get the struct page with hmm_pfn_to_page() and the page
> size order can be determined with compound_order(page) but if the page
> is larger than order 0 (PAGE_SIZE), there is no indication that a
> compound page is mapped by the CPU using a larger page size. Without
> this information, the caller can't safely use a large device PTE to map
> the compound page because the CPU might be using smaller PTEs with
> different read/write permissions.
> 
> Add two new output flags to indicate the mapping size (PMD or PUD sized)
> so that callers know the pages are being mapped with consistent permissions
> and a large device page table mapping can be used if one is available.

The problem I have with this is that PTE/PMD/PUD are not the only choices
for how the CPU might choose to map something.  For example, ARM has
the ability to map 64kB pages using 16 consecutive page table entries
(marked specially so the CPU knows to use a single TLB entry for the
64kB range).  Some other CPUs have similar capabilities.

I'd rather you encoded the order of the mapping in the flags (eg a
number between 0 and 31) so that we have the flexibility in the future
to describe how memory is mapped.
