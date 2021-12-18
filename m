Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412F8479886
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Dec 2021 05:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhLREDY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 23:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhLREDY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 23:03:24 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11BFC06173E
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 20:03:23 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z5so15226418edd.3
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 20:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iDz9wbDMHn9MeIeMeVs1g93TcSMjFNt5KhDPV7GWmW8=;
        b=JZWsZ9zzivWVUnONWc6WXUrfS9G5bbi5gt+peI0yOlau9BFB8rndAwtdKJ2qX2ZnUf
         OQ+2eD5CGCh2TBG+PQVESOHPfQzWG7avZX5F/+5/9t4X10C604kFp0d+2CFTwOowQY+g
         h1Hrnva1kIJXMOMq6KKMozGFUEUYAP+iMVhiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iDz9wbDMHn9MeIeMeVs1g93TcSMjFNt5KhDPV7GWmW8=;
        b=qbvV8SvtjKtF9iohAsPckN60z+q6i7AEJg5QJa9gK/FxXXv56cKPScB0rWijswHeEw
         zaH5MumcF0QFd8PBIyir+3t/4xQLUY4HX6C2ZegFfpawCHiMwahjJWgEGJIZmE0frp/9
         zyMS7y8rWjoDINhQgOtTek1ZWozuhkmCg0jggwlcHiOI7qVc4WGD+xKKQ4Fm3/qAkBci
         uNZ5S2FL/+1RuX7U4M/i8UGp8ojYjWjdqyEKyN5DtmkZrYLbxVlKya3JismVakthGPxg
         smnXrLpURMnvBIDhZLzpTHNKWivP32gc9u3MYL9YuPInV8ipEvu+HcT4qRtg6f4Y/AKt
         mPfQ==
X-Gm-Message-State: AOAM53068TePP9yIv2ODzbqDkyk1t/kKuaFgs1u2PTjmWBCIVyZVWZ6P
        FatsRx9UtTfK4ChrxzzIDJh9sCYhTx9Dm4Opl28=
X-Google-Smtp-Source: ABdhPJziHOxadnpTv6dKpEBG2UBlcYyrwiMWV4vNRLSGCx03KkSebM91uYrftOuZOh2cof4EOJc+QQ==
X-Received: by 2002:a50:c38c:: with SMTP id h12mr5745370edf.72.1639800202244;
        Fri, 17 Dec 2021 20:03:22 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id a14sm4255421edt.95.2021.12.17.20.03.22
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 20:03:22 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so2719441wmc.2
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 20:03:22 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr12036558wmq.8.1639800191035;
 Fri, 17 Dec 2021 20:03:11 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <9c3ba92e-9e36-75a9-9572-a08694048c1d@redhat.com> <CAHk-=wghsZByyzCqb5EbKzZtAbrFvQCViD+jK9HQL4viqUb6Ow@mail.gmail.com>
 <e93f3fc9-00fd-5404-83f9-136b372e4867@redhat.com> <CAHk-=wiFhVXZH_ht_dYQ_g2WNuhvWVrv8MjZ8B8_g6Kz2cZrHw@mail.gmail.com>
 <02cf4dcf-74e8-9cbd-ffbf-8888f18a9e8a@redhat.com> <CAHk-=wiR2Q5TQn_Vy10esOOshAego4wTCxgfDtVCxAw74hP5hg@mail.gmail.com>
 <0aa27d7d-0db6-94ee-ca16-91d19997286b@redhat.com> <CAHk-=wgKACiq4sygvRwvJ7bE+dnbMVftoudEVvcbyws6G_FDyw@mail.gmail.com>
 <0de1a3cb-8286-15bd-aec1-2b284bf8918a@redhat.com> <719D2770-97EF-4CF5-81E6-056B0B55A996@vmware.com>
In-Reply-To: <719D2770-97EF-4CF5-81E6-056B0B55A996@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 20:02:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjnPt3H1JV=04iJQ6LjiF31RrM4Zg3QUKTr9MswUZk4xg@mail.gmail.com>
Message-ID: <CAHk-=wjnPt3H1JV=04iJQ6LjiF31RrM4Zg3QUKTr9MswUZk4xg@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     Nadav Amit <namit@vmware.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Fri, Dec 17, 2021 at 3:53 PM Nadav Amit <namit@vmware.com> wrote:
>
> I understand the discussion mainly revolves correctness, which is
> obviously the most important property, but I would like to mention
> that having transient get_page() calls causing unnecessary COWs can
> cause hard-to-analyze and hard-to-avoid performance degradation.

Note that the COW itself is pretty cheap. Yes, there's the page
allocation and copy, but it's mostly a local thing.

So that falls under the "good to avoid" heading, but in the end it's
not an immense deal.

In contrast, the page lock has been an actual big user-visible latency
issue, to the point of correctness.

A couple of years ago, we literally had NMI watchdog timeouts due to
the page wait-queues growing basically boundlessly. This was some
customer internal benchmark code that I never saw, so it wasn't
*quite* clear exactly what was going on, but we ended up having to
split up the page wait list traversal using bookmark entries, because
it was such a huge latency issue.

That was mostly NUMA balancing faults, I think, but the point I'm
making is that avoiding the page lock can be a *much* bigger deal than
avoiding some local allocation and copying of a page of data. There
are real loads where the page-lock gets insanely bad, and I think it's
because we use it much too much.

See commit 2554db916586 ("sched/wait: Break up long wake list walk")
for some of that saga.

So I really think that having to serialize with the page lock in order
to do some "exact page use counting" is a false economy. Yes, maybe
you'd be able to avoid a COW or two, but at what locking cost?

                Linus
