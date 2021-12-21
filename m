Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943E247C5A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 19:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhLUSAw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 13:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhLUSAw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 13:00:52 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95B9C061574
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 10:00:51 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x15so55342140edv.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 10:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VIbA3tyKRgvmJRKKTWC54hBhDnm0QxqACXVEDucCono=;
        b=hi49HjIoBTBvSXG2A2+cFTDsRuJjpXTbXPT2YO0B5WLC6WmWLV13V5z0TR/SlDr/63
         iOmlX+Uu844DfzR1WbHs0Qw1BOG13MhIrY+PoLF4H5qxGf8+AMW/UNirqtZtyPp4EF02
         DRy+25A1pXY0epijI8EyJvK8QbbP7eNmzrRr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VIbA3tyKRgvmJRKKTWC54hBhDnm0QxqACXVEDucCono=;
        b=dopLD6k1zMKMUhSCJi/3yWhCX9eAW5RIbNHFIL2/+PaiTz15srgGCqUTd1PhhERRcO
         1tmSsE1IKM/ae796sSiUO7+98IpcgKGP72MMnscIWPelJsZLxB4VnF9F8RSVFkk8TGvg
         ZUEsLXaT7ZOt0KJTR6BvEEoff1JmsnIH7MIOtVJ13ZzwWzm9aNDE3q5kPgzcpNyO7bJ5
         xI3S7MjWf/rV6eb1oENqjADvQsFI6G3+DVKqHskoGXhe57KPU2nlO1DLjxtr1ztJNt+l
         7OK3I2DsziNboO9KCflm2Aa9rYyXHNuk/KQChkFcBKovvUydnXX6WsH83jfmj0TJrpU9
         LcHg==
X-Gm-Message-State: AOAM532Up+z1cSTE3IEJzYZkuHHABzqi2aPeZeXggyGyzIdbxz1A9hui
        Q4CpAAzawqFiBetMao2eZClqzUi14TZsoUIJCVY=
X-Google-Smtp-Source: ABdhPJz2Qk5W9SXQZiPF/+vgblSePKedY9zmifn5WvKlmdGVUklq0lA4bQ1wOolMXMzEwaH8zE3aOQ==
X-Received: by 2002:aa7:db8d:: with SMTP id u13mr4246453edt.111.1640109649959;
        Tue, 21 Dec 2021 10:00:49 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id y17sm8994352edd.31.2021.12.21.10.00.49
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 10:00:49 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso2642wme.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 10:00:49 -0800 (PST)
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr3769746wmj.155.1640109639062;
 Tue, 21 Dec 2021 10:00:39 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wj7eSOhbWDeADL_BJKLzdDF5s_5R9v7d-4P3L6v1T3mpQ@mail.gmail.com>
 <20211218184233.GB1432915@nvidia.com> <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com> <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com> <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com> <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com> <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
In-Reply-To: <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Dec 2021 10:00:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi191H+U0TNJhL7Jf7VAA+mA6y8MUQLy9DkkaS+tNgp+w@mail.gmail.com>
Message-ID: <CAHk-=wi191H+U0TNJhL7Jf7VAA+mA6y8MUQLy9DkkaS+tNgp+w@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     David Hildenbrand <david@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Nadav Amit <namit@vmware.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 21, 2021 at 9:40 AM David Hildenbrand <david@redhat.com> wrote:
>
> > I do think the existing "maybe_pinned()" logic is fine for that. The
> > "exclusive to this VM" bit can be used to *help* that decision -
> > because only an exclusive page can be pinned - bit I don't think it
> > should _replace_ that logic.
>
> The issue is that O_DIRECT uses FOLL_GET and cannot easily be changed to
> FOLL_PIN unfortunately. So I'm *trying* to make it more generic such
> that such corner cases can be handled as well correctly. But yeah, I'll
> see where this goes ... O_DIRECT has to be fixed one way or the other.
>
> John H. mentioned that he wants to look into converting that to
> FOLL_PIN. So maybe that will work eventually.

I'd really prefer that as the plan.

What exactly is the issue with O_DIRECT? Is it purely that it uses
"put_page()" instead of "unpin", or what?

I really think that if people look up pages and expect those pages to
stay coherent with the VM they looked it up for, they _have_ to
actively tell the VM layer - which means using FOLL_PIN.

Note that this is in absolutely no way a "new" issue. It has *always*
been true. If some O_DIORECT path depends on pinning behavior, it has
never worked correctly, and it is entirely on O_DIRECT, and not at all
a VM issue. We've had people doing GUP games forever, and being burnt
by those games not working reliably.

GUP (before we even had the notion of pinning) would always just take
a reference to the page, but it would not guarantee that that exact
page then kept an association with the VM.

Now, in *practice* this all works if:

 (a) the GUP user had always written to the page since the fork
(either explicitly, or with FOLL_WRITE obviously acting as such)

 (b) the GUP user never forks afterwards until the IO is done

 (c) the GUP user plays no other VM games on that address

and it's also very possible that it has worked by pure luck (ie we've
had a lot of random code that actively mis-used things and it would
work in practice just because COW would happen to cut the right
direction etc).

Is there some particular GUP user you happen to care about more than
others? I think it's a valid option to try to fix things up one by
one, even if you don't perhaps fix _all_ cases.

              Linus
