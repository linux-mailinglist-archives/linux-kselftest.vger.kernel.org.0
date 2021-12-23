Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915A247E3C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Dec 2021 13:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348474AbhLWMyn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Dec 2021 07:54:43 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37168 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbhLWMyn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Dec 2021 07:54:43 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BBDCD2114D;
        Thu, 23 Dec 2021 12:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640264081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eU2dAFM5zS+uVh2lRvtlyJRj9FfYeVDEc6APBTOIi+o=;
        b=bCQMozAdvCr14vBZ9lXLSa8xR5buQDoDBI9oaKvlTwfdb2iMVpph9yXb1olv9eksvk0AUU
        Cr99QXR6rG9rOYwRgBemO5gY4yDF9XJ79mZ8c3NEQ4/dF3wok3+KD5VU6pKHsdLVYl2Aog
        uxcb8ZEb4yEafRQoVNHRL2NJ1BuDLe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640264081;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eU2dAFM5zS+uVh2lRvtlyJRj9FfYeVDEc6APBTOIi+o=;
        b=Y9YrTEVlw4eC4XT5Oi7tGfIe3kKOT3/KSPvS7/ewQsFVhP9vKduTwgXODNn0ggjpqJakdD
        aMcp/6+MWIp0qmAA==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 9D1CAA3B84;
        Thu, 23 Dec 2021 12:54:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0D2CE1E1328; Thu, 23 Dec 2021 13:54:38 +0100 (CET)
Date:   Thu, 23 Dec 2021 13:54:38 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Nadav Amit <namit@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Message-ID: <20211223125438.GA19129@quack2.suse.cz>
References: <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
 <20211221190706.GG1432915@nvidia.com>
 <3e0868e6-c714-1bf8-163f-389989bf5189@redhat.com>
 <dfe1c8d5-6fac-9040-0272-6d77bafa6a16@redhat.com>
 <20211222124141.GA685@quack2.suse.cz>
 <4a28e8a0-2efa-8b5e-10b5-38f1fc143a98@redhat.com>
 <20211222144255.GE685@quack2.suse.cz>
 <505d3d0f-23ee-0eec-0571-8058b8eedb97@redhat.com>
 <20211222160846.GH685@quack2.suse.cz>
 <CAHk-=wjUeCUo7dRkzTeqGMJ5-NE4=Xj09mMB0HCkCnMFxsbmwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjUeCUo7dRkzTeqGMJ5-NE4=Xj09mMB0HCkCnMFxsbmwA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed 22-12-21 10:40:18, Linus Torvalds wrote:
> On Wed, Dec 22, 2021 at 8:08 AM Jan Kara <jack@suse.cz> wrote:
> >
> > Well, but O_DIRECT reads must use FOLL_PIN in any case because they modify
> > page data (and so we need to detect them both for COW and filesystem needs).
> 
> Well, O_DIRECT reads do, but not necessarily writes.

I agree.

> And hey, even reads have been dodgy in the past when we didn't really
> have the pinning logic - there's been a lot of users that just wanted
> it to work for their particular use-case rather than in general and in
> all situations..

Yes, but currently a malicious user can take the system down (BUG_ON) or
cause DIF/DIX failures if he is nasty and tries hard enough with O_DIRECT
reads (practically, the window is small so I haven't really seen a report
that I could trace to O_DIRECT reads but in principle the problem is the
same as with pinning & dirtying done e.g. by video capture drivers and
there we've seen these problem happen). So forcing pinning for O_DIRECT
reads is IMO mandatory.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
