Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153A5479685
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 22:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhLQVuh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 16:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhLQVug (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 16:50:36 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529E9C061574
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 13:50:36 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g14so12900126edb.8
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 13:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IT7bJL8Gu3iIVMeGRya6tlK3726EWsW9mIrP6+6lFJY=;
        b=LTaR9/gIjpCzf1TLq5JMGe8O7dKzXi7YBEwxczaRl0c/qzlwPqOVjlWw6RBOSfzGNy
         vBpCOKVyBNGR4ugV+/s3OcXRdGoG8mfqRX/0dF2KitumiMFGg2kTpkPIb3AHUPaU2CYw
         uHD7GGhkBfrspD+Gwcu5o3JrqoCKFHFYxm4f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IT7bJL8Gu3iIVMeGRya6tlK3726EWsW9mIrP6+6lFJY=;
        b=0KPGxCJ7rSX7wbfjntEAjs/3hAedk/FwAFVQa3ZofHW7qL3F5laSvRhriDo+05HrCw
         VO4lmwh69FylW5bzdueLCNUSDK/qW5zzSClkK520XNKFIOL8HTTWeRa5z3KCN/TbA7vl
         1Z1vk58MoVyOBvs60E+29UI5U+pOpGlXVzowLZ/GOo0G52HmtzT0wMuy+eCdkxnXYtzv
         iXpxnKpAedwSMg8A4ofxJtaLsn68Nox81Q9c4NxVgADZZttMMkQzgansjd99XD1ivWSL
         GKz5RR97pLhJR1bZ+jdka5jeIqqJxwSqdhIWdfebc4z9q4/YlRwmlmE5WWfwDyx4GpqM
         GnyA==
X-Gm-Message-State: AOAM533121WKWCZgF2byWAEdzksA0ycYVcu0LDtJ5gr+8YZ75GzWqOpT
        hII4Udx8P5hGnyyEAXvqcO2vRRhRyLJogtnnPkI=
X-Google-Smtp-Source: ABdhPJwh0UhxmVeH4G1zQd3hvEo92y6llUqF4isgBoV+10KF0u9H8U85VHtbQp7HZI2tCTmYEeevKQ==
X-Received: by 2002:a05:6402:849:: with SMTP id b9mr4533587edz.373.1639777834808;
        Fri, 17 Dec 2021 13:50:34 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id a13sm3977229edk.29.2021.12.17.13.50.34
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 13:50:34 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id o29so2495614wms.2
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 13:50:34 -0800 (PST)
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr11341018wmj.155.1639777824159;
 Fri, 17 Dec 2021 13:50:24 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <9c3ba92e-9e36-75a9-9572-a08694048c1d@redhat.com> <CAHk-=wghsZByyzCqb5EbKzZtAbrFvQCViD+jK9HQL4viqUb6Ow@mail.gmail.com>
 <e93f3fc9-00fd-5404-83f9-136b372e4867@redhat.com> <CAHk-=wiFhVXZH_ht_dYQ_g2WNuhvWVrv8MjZ8B8_g6Kz2cZrHw@mail.gmail.com>
 <02cf4dcf-74e8-9cbd-ffbf-8888f18a9e8a@redhat.com>
In-Reply-To: <02cf4dcf-74e8-9cbd-ffbf-8888f18a9e8a@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 13:50:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiR2Q5TQn_Vy10esOOshAego4wTCxgfDtVCxAw74hP5hg@mail.gmail.com>
Message-ID: <CAHk-=wiR2Q5TQn_Vy10esOOshAego4wTCxgfDtVCxAw74hP5hg@mail.gmail.com>
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

On Fri, Dec 17, 2021 at 1:47 PM David Hildenbrand <david@redhat.com> wrote:
>
> For now I have not heard a compelling argument why the mapcount is
> dubious, I repeat:
>
> * mapcount can only increase due to fork()
> * mapcount can decrease due to unmap / zap
>
> We can protect from the transtition == 1 -> >1 using the mmap_lock.
>
> For COW the mapcount is the only thing that matters *if we take GUP* out
> of the equation. And that's exactly what we

What do you have against just doing what we already do in other parts,
that a/b thing?

Which avoids the whole mmap_sem issue. That was a big issue for the
rdma people, afaik.

                Linus
