Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A6F47D3D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 15:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343518AbhLVOm5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 09:42:57 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58800 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238818AbhLVOm5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 09:42:57 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 923811F37E;
        Wed, 22 Dec 2021 14:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640184175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TD6SyuS6GP3tP2PxyJFk+oWkTje4JimB4WrUsHB4NpA=;
        b=vB6Uer+9JxDX9iRUHObopR92ZAOV2bRWMdULdB211qdN/IEBFSEGWFx+CxVN94MvlidGhh
        vczdaa2zfn8SdAU5vWvhQCS6wePDYrSfJiVQ2u0JDyG+wFbm48wmOvBA49TWRJjYKXo1tu
        N21nOTWUJ80LHWfAO8QrkHv0M+AoNfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640184175;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TD6SyuS6GP3tP2PxyJFk+oWkTje4JimB4WrUsHB4NpA=;
        b=Icwwag7tI4SkKcuYo19hnKM42HuXIUwKOhLtuaV5Dy5Ag5dDGibjcOExN58uaX9dSCbQ1y
        b3T6BlrATDQ3joCA==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 5C90AA3B81;
        Wed, 22 Dec 2021 14:42:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3EFE51F2CEF; Wed, 22 Dec 2021 15:42:55 +0100 (CET)
Date:   Wed, 22 Dec 2021 15:42:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20211222144255.GE685@quack2.suse.cz>
References: <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
 <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
 <20211221190706.GG1432915@nvidia.com>
 <3e0868e6-c714-1bf8-163f-389989bf5189@redhat.com>
 <dfe1c8d5-6fac-9040-0272-6d77bafa6a16@redhat.com>
 <20211222124141.GA685@quack2.suse.cz>
 <4a28e8a0-2efa-8b5e-10b5-38f1fc143a98@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a28e8a0-2efa-8b5e-10b5-38f1fc143a98@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed 22-12-21 14:09:41, David Hildenbrand wrote:
> >> IIUC, our COW logic makes sure that a shared anonymous page that might
> >> still be used by a R/O FOLL_GET cannot be modified, because any attempt
> >> to modify it would result in a copy.
> > 
> > Well, we defined FOLL_PIN to mean the intent that the caller wants to access
> > not only page state (for which is enough FOLL_GET and there are some users
> > - mostly inside mm - who need this) but also page data. Eventually, we even
> > wanted to make FOLL_GET unavailable to broad areas of kernel (and keep it
> > internal to only MM for its dirty deeds ;)) to reduce the misuse of GUP.
> > 
> > For file pages we need this data vs no-data access distinction so that
> > filesystems can detect when someone can be accessing page data although the
> > page is unmapped.  Practically, filesystems care most about when someone
> > can be *modifying* page data (we need to make sure data is stable e.g. when
> > writing back data to disk or doing data checksumming or other operations)
> > so using FOLL_GET when wanting to only read page data should be OK for
> > filesystems but honestly I would be reluctant to break the rule of "use
> > FOLL_PIN when wanting to access page data" to keep things simple and
> > reasonably easy to understand for parties such as filesystem developers or
> > driver developers who all need to interact with pinned pages...
> 
> Right, from an API perspective we really want people to use FOLL_PIN.
> 
> To optimize this case in particular it would help if we would have the
> FOLL flags on the unpin path. Then we could just decide internally
> "well, short-term R/O FOLL_PIN can be really lightweight, we can treat
> this like a FOLL_GET instead". And we would need that as well if we were
> to keep different counters for R/O vs. R/W pinned.

Well, I guess the question here is: Which GUP user needs only R/O access to
page data and is so performance critical that it would be worth it to
sacrifice API clarity for speed? I'm not aware of any but I was not looking
really hard...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
