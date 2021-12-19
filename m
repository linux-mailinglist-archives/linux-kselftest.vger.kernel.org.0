Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873E647A293
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Dec 2021 23:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbhLSWMd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Dec 2021 17:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbhLSWMc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Dec 2021 17:12:32 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90826C06173F
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Dec 2021 14:12:32 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y22so30937868edq.2
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Dec 2021 14:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1EeGlidL5zxbN8lavZvrIotlPnJ2iSVy9AUU7Sk+Ag=;
        b=NdJgcvEjsZfkR59wZEXSS0eAS2OrzVKVMrHaeDy2k3yG7QDmcSTrqgVUsjoRTxYAYZ
         vCIPJCJjuPYvuxe2TKemOH14PEfxj7KcsAVyY5LORM9MPvai7r31koyJWODlLOnNa1hM
         YVOo44slRSUgIgcV41XWNlfxShfEvbw6SoJH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1EeGlidL5zxbN8lavZvrIotlPnJ2iSVy9AUU7Sk+Ag=;
        b=rOIABUSKFr86Ydy7ybGiSAXxSABJcu/fVBYQEv+SsV7VefwOrlAlPYQ9qyUQOpFemA
         XcPvE3U5u36BLjKDu24JnrO7dwJbXddTdaOAjDi1iDvGYMW+Bf53wehJSY+DqFL7dowz
         biyW2kBzxcXTOgVUHX3TkEo14DSyVjcICevho1GYffXKT/t1A9FDR+XQa5EWn3MrG/hV
         yNtQEETs+A0V8m/LqlNWMDt3Q+EKpCkGONsG3LbEz0tUkiQbP7BC83v+4q3TmDpjEpS2
         QdusN/RpfavhJEKS5Ioi6SymVG3WMpmuh0OZgJLjoSazIuvxGX8k6nipq05wL5rJE1z9
         sSNQ==
X-Gm-Message-State: AOAM532eNBXNIbMwFPSyJ1PiCE+KTJUYIZfpaBPZJUrkz/p5kwIguL//
        1Pcfc86wid7XNwF4nI/b8NQQ3FWGBJLJ+2IOP4U=
X-Google-Smtp-Source: ABdhPJxGX7b2S8jCGKtk18Dc4teiElfh6Ioz0kkG/gsRyB9QNpDXQBLR0wAYcgwMVa3cdXk/zxCKaw==
X-Received: by 2002:a05:6402:354e:: with SMTP id f14mr12887225edd.245.1639951951117;
        Sun, 19 Dec 2021 14:12:31 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id sd28sm4819131ejc.37.2021.12.19.14.12.30
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 14:12:30 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id y83-20020a1c7d56000000b003456dfe7c5cso7370651wmc.1
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Dec 2021 14:12:30 -0800 (PST)
X-Received: by 2002:a05:600c:1e01:: with SMTP id ay1mr9481320wmb.152.1639951940498;
 Sun, 19 Dec 2021 14:12:20 -0800 (PST)
MIME-Version: 1.0
References: <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com> <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com> <Yb+gId/gXocrlJYD@casper.infradead.org>
 <CAHk-=wiAzmB-jiHvF+EZ1-b0X3ts4LAYHaVhzpzXEjmC0X95eg@mail.gmail.com>
 <Yb+oi8fg1dJe1uBm@casper.infradead.org> <CAHk-=wgLLRT_KeM5Se1AxGcf-g5MkCS-JmPy169Rpdeky_YkXg@mail.gmail.com>
 <Yb+r2W6RCKhO5toC@casper.infradead.org>
In-Reply-To: <Yb+r2W6RCKhO5toC@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Dec 2021 14:12:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wibQevWUPb4V67gs0FsUBKO+bSMvp9tpOU3PM4Mg_4i4Q@mail.gmail.com>
Message-ID: <CAHk-=wibQevWUPb4V67gs0FsUBKO+bSMvp9tpOU3PM4Mg_4i4Q@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     Matthew Wilcox <willy@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Dec 19, 2021 at 2:02 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> I'd like to get rid of ->mapcount for file pages too.  And those are
> definitely never mapped in the majority of cases.

Fair enough.

You'd probably be better off checking "is this mapping mapped" though.
Because otherwise you have to get the page lock to serialize each
page.

               Linus
