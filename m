Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E5E4798B8
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Dec 2021 06:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhLRFDw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Dec 2021 00:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhLRFDv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Dec 2021 00:03:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DAEC061574;
        Fri, 17 Dec 2021 21:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7CfBdCGGB5KqQySfvwvT6lyY1v+XtNbClXHvrFXEOgs=; b=l/oArGjyFvrjpr8xJM2Bh5UEYA
        gNZtRT594LAgBAix0ykvezlOODRZeD95aySCrdyXGNrqxmCv8zV1FHSXYEl3/z8KEN9uCgGhIVcpd
        D2dHUyDdcA5bS9uRG0ZRbPHLD2tG/2SvHOOXEotOyWAxnnp815jRLFzz50QZub2tpxyxpsNf6GBXJ
        GvmES3DEGCG5bSsWyr2D02uUmcLNFnmFhnqQKAWDt3ct6BPpBp2vC+ujiuOKPjV3NNtDJyPDqhQAc
        Tpfwv32S7tW8OX/+XoVusNugubRU/zT+X4Wdy41LWBvmPeNkFF+djqyHB0ZQG1FfyRVLLbWLIxRPf
        GMP4LRpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1myRsf-00HK7a-6n; Sat, 18 Dec 2021 05:03:37 +0000
Date:   Sat, 18 Dec 2021 05:03:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Message-ID: <Yb1rqe7u0YRxqzgh@casper.infradead.org>
References: <e93f3fc9-00fd-5404-83f9-136b372e4867@redhat.com>
 <CAHk-=wiFhVXZH_ht_dYQ_g2WNuhvWVrv8MjZ8B8_g6Kz2cZrHw@mail.gmail.com>
 <02cf4dcf-74e8-9cbd-ffbf-8888f18a9e8a@redhat.com>
 <CAHk-=wiR2Q5TQn_Vy10esOOshAego4wTCxgfDtVCxAw74hP5hg@mail.gmail.com>
 <0aa27d7d-0db6-94ee-ca16-91d19997286b@redhat.com>
 <CAHk-=wgKACiq4sygvRwvJ7bE+dnbMVftoudEVvcbyws6G_FDyw@mail.gmail.com>
 <0de1a3cb-8286-15bd-aec1-2b284bf8918a@redhat.com>
 <719D2770-97EF-4CF5-81E6-056B0B55A996@vmware.com>
 <CAHk-=wjnPt3H1JV=04iJQ6LjiF31RrM4Zg3QUKTr9MswUZk4xg@mail.gmail.com>
 <D54E059F-9757-46DB-919C-A31A067276CB@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D54E059F-9757-46DB-919C-A31A067276CB@vmware.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Dec 18, 2021 at 04:52:13AM +0000, Nadav Amit wrote:
> Take for instance memcached and assume you overcommit memory with a very fast
> swap (e.g., pmem, zram, perhaps even slower). Now, it turns out memcached
> often accesses a page first for read and shortly after for write. I
> encountered, in a similar scenario, that the page reference that
> lru_cache_add() takes during the first faultin event (for read), causes a COW
> on a write page-fault that happens shortly after [1]. So on memcached I
> assume this would also trigger frequent unnecessary COWs.

Why are we comparing page_count() against 1 and not 1 + PageLRU(page)?
Having a reference from the LRU should be expected.  Is it because of
some race that we'd need to take the page lock to protect against?
