Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F87947A2A1
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Dec 2021 23:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbhLSW00 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Dec 2021 17:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhLSW0Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Dec 2021 17:26:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F83BC061574;
        Sun, 19 Dec 2021 14:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WrMo2FbvfTHE2R5AHHoM6zUbBYPY7DJveiU7/Kb21KM=; b=eiVsACMV9Ai87OPY8MkPsR+PEn
        k8h/WwoF9VdHtxnfNWZdzV76qz/DNUUT/ZBihkD8ApttdV7ghAVkLsH6lPgmPqlQ3jZ0o5NRP04r7
        u/e5kJ4TMPH71pJubK9zyxijsEaWKMlrhuGgUX+IBEJN+0Y3y40IOcLmPwoGtV6nT77ByOry+PGOs
        87uWJ5piTe8lkdo5Oy/kUPieXahmcFVBao4EwxRfhttHqahlp7Ey8sK5Hs4Ip804LmGYjbbgkC3tj
        5EFiSoKQUjd9swbgNj2FnCcMSQ8eWLmC40xHh26yMA/kTUxWkhlu06++c2LpsJVzrJDr3UGNyAMyB
        90IEUvhw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mz4dB-0014v5-Pz; Sun, 19 Dec 2021 22:26:13 +0000
Date:   Sun, 19 Dec 2021 22:26:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <Yb+xhZNp5RADRQ94@casper.infradead.org>
References: <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <Yb+gId/gXocrlJYD@casper.infradead.org>
 <CAHk-=wiAzmB-jiHvF+EZ1-b0X3ts4LAYHaVhzpzXEjmC0X95eg@mail.gmail.com>
 <Yb+oi8fg1dJe1uBm@casper.infradead.org>
 <CAHk-=wgLLRT_KeM5Se1AxGcf-g5MkCS-JmPy169Rpdeky_YkXg@mail.gmail.com>
 <Yb+r2W6RCKhO5toC@casper.infradead.org>
 <CAHk-=wibQevWUPb4V67gs0FsUBKO+bSMvp9tpOU3PM4Mg_4i4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wibQevWUPb4V67gs0FsUBKO+bSMvp9tpOU3PM4Mg_4i4Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Dec 19, 2021 at 02:12:04PM -0800, Linus Torvalds wrote:
> On Sun, Dec 19, 2021 at 2:02 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > I'd like to get rid of ->mapcount for file pages too.  And those are
> > definitely never mapped in the majority of cases.
> 
> Fair enough.
> 
> You'd probably be better off checking "is this mapping mapped" though.
> Because otherwise you have to get the page lock to serialize each
> page.

Truncate already has the page locked, eg
truncate_inode_pages_range()
  find_lock_entries()
  truncate_cleanup_page()
    if (page_mapped(page))
      unmap_mapping_page(page)

I think anyone calling unmap_mapping_page() really ought to have the
page lock.  Oh, we actually have an assert already to that effect ;-)
        VM_BUG_ON(!PageLocked(page));

