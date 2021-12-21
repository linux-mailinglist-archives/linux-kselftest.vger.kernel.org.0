Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B969147C6A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 19:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbhLUSb3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 13:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbhLUSb3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 13:31:29 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA42C06173F
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 10:31:28 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id x7so6773150lfu.8
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 10:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kr2TxL6wnne8Q9bYsPk7XLye7r5BDis7uMpH40CjpuM=;
        b=UMZi0Hx4yN8uS8EBWgD+gNYmL13lzK1vKaY6zW2PFGKQwwgxzxKbuKQjiUmhtbIulS
         rmztzOpTqtEghOW6rMW16mKk1ILe+hsFn7rh5L+vQygm5jShj6QoCzImZ8AR3odal/hZ
         X3poz6NiOlDdXIa9nYc39Mc7M1gNl6Suze1pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kr2TxL6wnne8Q9bYsPk7XLye7r5BDis7uMpH40CjpuM=;
        b=yqt/gETGMwiFUhU5xM0+v+x8wBxOOqRkfu2YcYnEWImgJh4uF3eyYVBVUqURYch1DI
         QKqM8fPGniMud7MgywzZbSY37TQgVO5/ulatJwHz9rkvhWT8Sx5dV8VBx1l+yNusCf8N
         BpV0koP2Rq0bA95XONVzdrXdOsj+Seu/iF7Lz39jB42S0272ok4zOextYvWrrK81uYSv
         1lonKr7y/LrLFjp+iCvkntjYVWGyARgDtw6MzRmV4GN3tSW5TV7sK2aroVso1fN1dck6
         l7ciBRDvOlrRxA7bSEm6NgFvCHUfjevqF1xcY4VDNJHvzywLwz+vcqnRnCy4UZdAjaFw
         9N1g==
X-Gm-Message-State: AOAM5309iq3aUlGjGNr9p1A9gik9LcovLjdCdHVBg14wLjBt9EsZmuOe
        TYAG0DjqfFqRK7MyII39ELP4HnfigeNC/8MrCKs=
X-Google-Smtp-Source: ABdhPJzCYfWWR2bFRO77XxqhNwXDFSRk/7Kf0P4yxn2P1axGpBZHtsanHuBFwTYeY0whv3LFfKsyjQ==
X-Received: by 2002:ac2:5f55:: with SMTP id 21mr4207314lfz.283.1640111487032;
        Tue, 21 Dec 2021 10:31:27 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id n17sm2791030ljg.128.2021.12.21.10.31.26
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 10:31:26 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id b22so31290782lfb.9
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 10:31:26 -0800 (PST)
X-Received: by 2002:a05:6000:10d2:: with SMTP id b18mr3617856wrx.193.1640111475384;
 Tue, 21 Dec 2021 10:31:15 -0800 (PST)
MIME-Version: 1.0
References: <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com> <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com> <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com> <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com> <20211221180705.GA32603@quack2.suse.cz>
In-Reply-To: <20211221180705.GA32603@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Dec 2021 10:30:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiyxQ==vnHFHW99S_OPwA=u1Qrfg2OGr_6zPcBAuhQY2w@mail.gmail.com>
Message-ID: <CAHk-=wiyxQ==vnHFHW99S_OPwA=u1Qrfg2OGr_6zPcBAuhQY2w@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     Jan Kara <jack@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 21, 2021 at 10:07 AM Jan Kara <jack@suse.cz> wrote:
>
> For record we always intended (and still intend) to make O_DIRECT use
> FOLL_PIN. Just it is tricky because some users mix pages pinned with GUP
> and pages acquired through get_page() in a single bio (such as zero page)
> and thus it is non-trivial to do the right thing on IO completion (unpin or
> just put_page).

Side note: the new "exclusive VM" bit wouldn't _solve_ this issue, but
it might make it much easier to debug and catch.

If we only set the exclusive VM bit on pages that get mapped into user
space, and we guarantee that GUP only looks up such pages, then we can
also add a debug test to the "unpin" case that the bit is still set.

And that would catch anybody who ends up using other pages for
unpin(), and you could have a WARN_ON() for it (obviously also trigger
on the page count being too small to unpin).

That way, at least from a kernel debugging and development standpoint
it would make it easy to see "ok, this unpinning got a page that
wasn't pinned", and it would help find these cases where some
situation had used just a get_page() rather than a pin to get a page
pointer.

No?

                  Linus
