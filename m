Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE024795CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 21:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbhLQUvz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 15:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240925AbhLQUvw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 15:51:52 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC78C06173E
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 12:51:52 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x15so12600754edv.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 12:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TG2f+1lEN9hemuQjgMe4Yp+YI3NU/6U4WSw8/cJzPxw=;
        b=Yrgcl5joP5IKSH1feNkTltzJLVVG8zrXENqo7vUe3EVV9XknZ07REOeQRBojTzTO86
         ru0XQjTptmuCTBKHvUxnc0k1m5boTQTeFASvq7tIIKB6yCjG9+KF1TpJp2uSt5cPlXfQ
         mvyq0AjNx+7bb2we1uo6ifMBNTtiDYvBUnRhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TG2f+1lEN9hemuQjgMe4Yp+YI3NU/6U4WSw8/cJzPxw=;
        b=0QC1YyKAB5kkvCYKdTSZ3Z8mNZFY9A+it6u9q3xWsigPdgssR5iImGeIehEiDQ9mGT
         aJsyCf0c0nba1EXi9iCwkc9PHuC755EYjzKgIf+cRjIrRzv8USYDNijFLHq5SHhk5dIl
         qJBowjf4dye5gBNA2pq46AKjKbis3agO9wtJl05RVUb9+lHyDZZCIOGTL3YcjUW2N4q5
         PMKtnzFClu8cMlbhNjC72mBHGaRBV0FLr/KX9QGdkgx+Xx2MR16gDyHIKFhNcFQb9LyA
         V91Dt3v4OsHwPRDQnncbiIQLcN1SG0cil2aXlAAw5xdPe0S481In29aCLdxqTnrCpjaA
         LTPQ==
X-Gm-Message-State: AOAM531jBbjSBO37G7O8JmYKeI+eKTX7M3QYbL2i21VsabXC2MlIbvtn
        31RzvndyP25FDHkSZWYkq3pFFc2D9QwOwjiWGmg=
X-Google-Smtp-Source: ABdhPJyh8AA/gwSpAhuDlS3cs67PjF9uksCU68PitEEfeFKGew0FWfW2PThvHyn2R3efne/NPFUyqg==
X-Received: by 2002:a17:907:7b98:: with SMTP id ne24mr3790929ejc.14.1639774310400;
        Fri, 17 Dec 2021 12:51:50 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id o1sm2057570edv.2.2021.12.17.12.51.49
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 12:51:50 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id y83-20020a1c7d56000000b003456dfe7c5cso3954577wmc.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 12:51:49 -0800 (PST)
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr11082980wmq.26.1639774298625;
 Fri, 17 Dec 2021 12:51:38 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com> <9c3ba92e-9e36-75a9-9572-a08694048c1d@redhat.com>
In-Reply-To: <9c3ba92e-9e36-75a9-9572-a08694048c1d@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 12:51:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wghsZByyzCqb5EbKzZtAbrFvQCViD+jK9HQL4viqUb6Ow@mail.gmail.com>
Message-ID: <CAHk-=wghsZByyzCqb5EbKzZtAbrFvQCViD+jK9HQL4viqUb6Ow@mail.gmail.com>
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

On Fri, Dec 17, 2021 at 12:45 PM David Hildenbrand <david@redhat.com> wrote:
>
> If a page is mapped exactly once, page_mapcount(page) == 1 and there is
> nothing to do.

Why?

You state that, but you stating that doesn't magically make it so.

What makes "mapcount==1" stable and special? Your "it's an
atomic_read()" argument is nonsense - it implies that the count can be
changing, but you will get _one_ answer.

What makes that one answer of a changing count special?

What if there are other references to that same page, gotten with
vmsplice(), and just about to be mapped into another address space?

This is the meat of my argument. You claim that "mapcount==1" is
special. I claim that you haven't explained why it would be. And I do
not believe it is.

                 Linus
