Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2B147958D
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 21:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbhLQUhN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 15:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240806AbhLQUhN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 15:37:13 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB42DC061574
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 12:37:12 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 207so5138755ljf.10
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 12:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zvvImewBZE3KOOBwyZhJia8d6wGtMWQq9Q/GQC30qY=;
        b=cmmJ+T9R6H0IFWbkk0uCMzeP72SP3fW5aRCFk5Uf151iuIsVfkWqCFMsXlKtKA4Gqd
         qZxkNJgGXfoNb4k0TG+r5KIXQwC5jiJm8zGYr6hRMqYknes/oFLcLwPdGuDU0nYdIlx7
         A0XRbjgzD6wHwK6UWMNr0Uu7jYs2nqPHDiE5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zvvImewBZE3KOOBwyZhJia8d6wGtMWQq9Q/GQC30qY=;
        b=JlOjJwZH8t3NZnspdKEscnuafiYSEx+TGH4IGmlWqgNMDxM1YydCZVom0Hajbp39L/
         bbVFiCFPr/AXptBBbESSR+l6PaPbCSuswD9I5G7DYOe8+hXBJdOQKrBKxq231DHLQbnr
         GaSHpvXByvO+siOBB9CPW5Y2UrSgnLcYG35RDZui0EBCer8T5E8JYUFLpFXuY58XE2bO
         zS/XY6x38yhxbXXadf97ChEapvZgUbSUP/bzviQ1aXkBZWfwvN9IImb+TxzxCwC/4WFi
         7nFavkYIEKfBS6kZGm82TYp5xve3NU6Nclz4fgoTPrzX5tiGp61/HcWCOT9FMXHUAdAz
         QDgA==
X-Gm-Message-State: AOAM533OIMo4VZb9YhY4GvUrCO5xSfvrph+NVqNlSnckhXBVifbX4RsF
        +jLRNeLj2bZQ6LuTDOBRop5tnBNZDwX4LoDr4+w=
X-Google-Smtp-Source: ABdhPJxWRXuhqgQfBjSeul0XW7n5tHzuBK7wxiMiJgIsmlggTyQHQmiESSwYo1d6gIB7s1oi4mD+fA==
X-Received: by 2002:a2e:5816:: with SMTP id m22mr4160471ljb.347.1639773430815;
        Fri, 17 Dec 2021 12:37:10 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id k5sm1848126lja.34.2021.12.17.12.37.10
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 12:37:10 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id m12so5180736ljj.6
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 12:37:10 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr3841394wrp.442.1639773419659;
 Fri, 17 Dec 2021 12:36:59 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com> <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com>
In-Reply-To: <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 12:36:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
Message-ID: <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
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

On Fri, Dec 17, 2021 at 12:18 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 17.12.21 20:22, Linus Torvalds wrote:
> > On Fri, Dec 17, 2021 at 11:04 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >>
> >  - get a "readonly" copy of a local private page using FAULT_FLAG_UNSHARE.
> >
> >    This just increments the page count, because mapcount == 1.
> >
> >  - fork()
> >
> >  - unmap in the original
> >
> >  - child now has "mapcount == 1" on a page again, but refcount is
> > elevated, and child HAS TO COW before writing.
>
> Hi Linus,
>
> This is just GUP before fork(), which is in general
> problematic/incompatible with sharing.

Note that my example was not meant to be an example of a problem per
se, but purely as an example of how meaningless 'mapcount' is, and how
'mapcount==1' isn't really a very meaningful test.

So it wasn't mean to show "look, GUP before fork is problematic".  We
have that problem already solved at least for regular pages.

It was purely meant to show how "mapcount==1" isn't a meaningful thing
to test, and my worry about how you're adding that nonsensical test to
the new code.

> Let's just take a look at what refcount does *wrong*. Let's use an
> adjusted version of your example above, because it's a perfect fit:
>
> 1. mem = mmap(pagesize, MAP_PRIVATE)
> -> refcount == 1
>
> 2. memset(mem, 0, pagesize); /* Page is mapped R/W */
>
> 3. fork() /* Page gets mapped R/O */
> -> refcount > 1
>
> 4. child quits
> -> refcount == 1
>
> 5. Take a R/O pin (RDMA, VFIO, ...)
> -> refcount > 1
>
> 6. memset(mem, 0xff, pagesize);
> -> Write fault -> COW

I do not believe this is actually a bug.

You asked for a R/O pin, and you got one.

Then somebody else modified that page, and you got exactly what you
asked for - a COW event. The original R/O pin has the original page
that it asked for, and can read it just fine.

So what is your argument?

              Linus
