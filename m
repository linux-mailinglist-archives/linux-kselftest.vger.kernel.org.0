Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6703C4794B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 20:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhLQTXQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 14:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240487AbhLQTXP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 14:23:15 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9B9C061574
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 11:23:15 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b7so11724646edd.6
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 11:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wsxPP4x55S3xHdetgetRuLFyO1pK7A4RVTBxuMZfoqY=;
        b=LN01Ax5zkrMJ36hMWyzfEwjvgOa05trYbyjDx9OvqN5hVC5jgm8DAsreT8ZC9IIalh
         FdsStvpmEXelZNEqxx+tiW5zfa1gTjPnHrDtMyQU36PnWl7IppVmVyKP51KznO6W4vcH
         OrJ7ICe+DK/A6cO51E7sHzoyw84upkUlBNY1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wsxPP4x55S3xHdetgetRuLFyO1pK7A4RVTBxuMZfoqY=;
        b=OPWfjmqwDpddEMcVF6wzb5AgtKK6E7NrKdhZX/UHlzxGnvQFHi+dL22VZ6bn2FLZZh
         eKciVqsp3g/fTwyKBfqZiVVQa3cJqa9wbklUinfU/0kCU/OfvHctI5woSfxVAcNCyg42
         H+nvzJ6SKDI0iC4QLXF5iOnd2yK7QHbRK+La5p2cpP4FZn1cKsTvwAIQ7sKUNo+lbKrg
         MGcZYRbm3qc1QX3w5tMMT17pctPsplQBZJiEPliJe6Ig7qvvtmsXuGSZYdSh6drplBul
         vfB8mEsVUQQCA5qtfhbIyuGHI2sI3hEO4b2Hac1SGs9Tgz5iv6A+LqHLg9j939FBbmLW
         f0hw==
X-Gm-Message-State: AOAM533IqMTpO9+LTlhhkC8Rnl2KTaNVhCeUt9vf4VjgRCzhiPv2E6E8
        K2DpRkhzYQQgBDSMzskNhDgnMcwXATCYJrsxYKo=
X-Google-Smtp-Source: ABdhPJzcGEDrh6pCmBio2+6rAM4BbfnRiG5UOFOSb5zuMp/wgi1zgm2uEY0TGsIbgxgCZa934uxPag==
X-Received: by 2002:a17:907:1c02:: with SMTP id nc2mr3828267ejc.333.1639768993866;
        Fri, 17 Dec 2021 11:23:13 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id w22sm4080821edc.62.2021.12.17.11.23.13
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 11:23:13 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so2146261wme.4
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 11:23:13 -0800 (PST)
X-Received: by 2002:a05:600c:1d97:: with SMTP id p23mr3854552wms.144.1639768983510;
 Fri, 17 Dec 2021 11:23:03 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
In-Reply-To: <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 11:22:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
Message-ID: <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
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

On Fri, Dec 17, 2021 at 11:04 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If we are doing a COW, we need an *exclusive* access to the page. That
> is not mapcount, that is the page ref.
>
> mapcount is insane, and I think this is making this worse again.

Maybe I'm misreading this, but afaik

 - get a "readonly" copy of a local private page using FAULT_FLAG_UNSHARE.

   This just increments the page count, because mapcount == 1.

 - fork()

 - unmap in the original

 - child now has "mapcount == 1" on a page again, but refcount is
elevated, and child HAS TO COW before writing.

Notice? "mapcount" is complete BS. The number of times a page is
mapped is irrelevant for COW. All that matters is that we get an
exclusive access to the page before we can write to it.

Anybody who takes mapcount into account at COW time is broken, and it
worries me how this is all mixing up with the COW logic.

Now, maybe this "unshare" case is sufficiently different from COW that
it's ok to look at mapcount for FAULT_FLAG_UNSHARE, as long as it
doesn't happen for a real COW.

But honestly, for "unshare", I still don't see that the mapcount
matters. What does "mapcount == 1" mean? Why is it meaningful?

Because if COW does things right, and always breaks a COW based on
refcount, then what's the problem with taking a read-only ref to the
page whether it is mapped multiple times or mapped just once? Anybody
who already had write access to the page can write to it regardless,
and any new writers go through COW and get a new page.

I must be missing something realyl fundamental here, but to me it
really reads like "mapcount can fundamentally never be relevant for
COW, and if it's not relevant for COW, how can it be relevant for a
read-only copy?"

             Linus
