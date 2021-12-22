Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A390547D248
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 13:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhLVMoX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 07:44:23 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44782 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhLVMoX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 07:44:23 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 80D5E2112B;
        Wed, 22 Dec 2021 12:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640177061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qy9gFIp2QxGl6WSv0UolBUI85R2Q8lLoLh2lTwoavFk=;
        b=gPSZWtxqFRZZ4KYSXRQOlHU1Vtzaz1MVqqA9I2kvB7ngleLRUnJ0pKIZFbByHTkRhNAhhf
        JsB3sZtNH4drYNDmMY53AP59YzK0mOQRF9rNJZdPIdY/Lz8ty0td2+IHTTZ3GzrJKbsr5u
        7S7EVOkAIeUr0UbGMWRmmlw8KcNhjas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640177061;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qy9gFIp2QxGl6WSv0UolBUI85R2Q8lLoLh2lTwoavFk=;
        b=0GCk4fJ1+0SXjygAjwsjRaLC7Mu6dmG1KrJSOe+cpupyUT24+CFPMoDzHQkFsNRVH+mSIS
        IgVCteXCYXE8/0Ag==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 66E23A3B83;
        Wed, 22 Dec 2021 12:44:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4517C1F2CEF; Wed, 22 Dec 2021 13:44:21 +0100 (CET)
Date:   Wed, 22 Dec 2021 13:44:21 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
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
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Message-ID: <20211222124421.GB685@quack2.suse.cz>
References: <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
 <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
 <20211221235916.GI1432915@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221235916.GI1432915@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue 21-12-21 19:59:16, Jason Gunthorpe wrote:
> On Tue, Dec 21, 2021 at 06:40:30PM +0100, David Hildenbrand wrote:
> 
> > What adds complexity to correctly maintain the "exclusive" state are at
> > least:
> > * KSM (might be harder, have to think about it)
> 
> I know little about it, but isn't KSM like fork where it is trying to
> WP pages with the intention of copying them? Shouldn't KSM completely
> reject WP'ing a page that is under any kind of writable GUP?

I know little about KSM as well but I think fundamentally it has similar
requirements for anon pages as filesystems have for page cache pages e.g.
when doing block deduplication or data checksumming... I.e., it needs to
make sure data in the page is stable and nobody can modify it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
