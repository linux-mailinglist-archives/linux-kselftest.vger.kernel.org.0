Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A176479592
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 21:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhLQUkM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 15:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238824AbhLQUkK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 15:40:10 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67779C06173E
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 12:40:10 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id t5so12599268edd.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 12:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1fFYHj/85wq9sp2q1J+u1Ml7YxuIRP5NvJyUtf+MXyA=;
        b=cJw7R6IKrWDvsdo4quNKJl7yowzlSAHbDI1qyzLRE08kUlNHdph4InZjJ8Da37rlMW
         TYTu57W8GfVaR3uyaMrsqy6OJvP+dnCqaEhL+vDOl/t5etD3LFAphX+fle4Z+4q5JUHs
         HptT4U/SfI31C1p3odw09uIZxNiTnn51wMLzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fFYHj/85wq9sp2q1J+u1Ml7YxuIRP5NvJyUtf+MXyA=;
        b=WE8DaRQ8HeM2JMeSr1Vk0TpHOHBqlYz/94z1YBoSbGgEwGeqNy8j1agpo5UlM+u5Lu
         svZ+EV098t6+JxaOQ8Nmw4fZ4cNwclDK0BpTk7xYWws+kHckmJ7XTT1U7Iyk2Lwg7u3I
         NYW063gS/yZUHKyhfW8e+c472ayR7yakvi6RIWH0NOIXt10O4t8F05CHYsXmurVhHmdH
         ERPJem2Ea1yP/F4J8fse55coJDyWsz359S6yGqK61EEKq9GvyrClUPXnCjyEBPG8Zs05
         9D2lgXtXfAHOPTi/pU90TWI/eet1zmcjoA3adXv5045lSVzYu4MePWwR3KuNRDah8Jcd
         5tyw==
X-Gm-Message-State: AOAM533c53NqyEvraAkqErP90kAT7+cTlFD+ppsN+4cwPw3rpEf+O7yG
        Z/7/I8iMo+x9v2SpyKsRNlO8bAqcdRUHbKAYqJA=
X-Google-Smtp-Source: ABdhPJxdM7yZ8XLJ/X0D8Muvnw3NjN3frAhdAgJEUGoeldzcb9rxu6yp44hqahJ3BJFkaV9l00ZNUA==
X-Received: by 2002:a17:907:7d8f:: with SMTP id oz15mr3674201ejc.245.1639773608930;
        Fri, 17 Dec 2021 12:40:08 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id lk22sm3121000ejb.83.2021.12.17.12.40.08
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 12:40:08 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id t5so12599172edd.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 12:40:08 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr3847861wrp.442.1639773598131;
 Fri, 17 Dec 2021 12:39:58 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com> <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 12:39:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgD1Y_hV3eCRL55m+sGfmwic0wbq+0LV8youYKirHJTog@mail.gmail.com>
Message-ID: <CAHk-=wgD1Y_hV3eCRL55m+sGfmwic0wbq+0LV8youYKirHJTog@mail.gmail.com>
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

On Fri, Dec 17, 2021 at 12:36 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> >
> > 5. Take a R/O pin (RDMA, VFIO, ...)
> > -> refcount > 1
> >
> > 6. memset(mem, 0xff, pagesize);
> > -> Write fault -> COW
>
> I do not believe this is actually a bug.
>
> You asked for a R/O pin, and you got one.

If you want a shared pin that actually follows the changes of your
process around, then that is what you should have asked for.

At the time of such a shared pin, you can do what we already do:
re-use the page if it has a refcount of 1. Or do an early COW event
(feel free to avoid the "mark it writable and dirty").

But note: *refcount* of 1. Not "mapcount". Because mapcount would be
broken garbage.

                Linus
