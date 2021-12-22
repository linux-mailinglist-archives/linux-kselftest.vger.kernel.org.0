Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5818E47D703
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 19:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344812AbhLVSks (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 13:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbhLVSkr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 13:40:47 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ED9C061574
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Dec 2021 10:40:47 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bt1so7234806lfb.13
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Dec 2021 10:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aq/wssbJW97LOVr0Eh6yDelER0nFi1ZCZpjRsYoDD3M=;
        b=REM7DgpgJmkfIJdXvPcefxx96s82wJsCzGWmJn0cvbBNm41AzviVhzuNtpthlyec3s
         UGTiKQqTbUxvgaQ7HgM0DrpzcNs62ueQTQhGdqh1NAJHhNe+Su+eXdejZMNZl6kf7Sg1
         AOMnLNyEuDxkkkjn3LNUqoR/nzbn3aEL5NIHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aq/wssbJW97LOVr0Eh6yDelER0nFi1ZCZpjRsYoDD3M=;
        b=48D2zyQuWCYC3HZf8M4waPnM8S0hb7cBgRov09J0IFZDrkcV851tmaQSVBp/VIs9Dd
         SVcTwpWdwWfCQtH3btGqA8KCCQA0qPVMSw4FHukJl7l0aZMrxQ/st4z1T0brbhswZjLZ
         ZM237P7XQ/tcEh3i9FBkd53srK1Kq/AIjYRUYRC7bz20xGLy5TdAYulmFr4gU6Xnb8+O
         UZ4dz7UV5K6FX1NocDZnXfjSufSQ7eJaa+IN5TCKLm9FPWjBICr8dMaJg2mf22Nirx7l
         DkmFMfhuNEXKjdUUcSQdDTIkx1MV7IGDFALma2HpZMiEEVkvEnAegFy+P0bST31a7mGO
         EZVw==
X-Gm-Message-State: AOAM533ZsB5ypl9KnUxMxTJ9RBZQD3J4scnwF51ctYgGDifBn09WtBNT
        cf+zYsP3aZNNbikQcz4ya0lmnLyLnV4F+Q6cXn0=
X-Google-Smtp-Source: ABdhPJxBt7pUBmAHZpjel8/vJuENEunkSO3mpq9LXUdro8GcG0RHT8fmIGEmfoH/2AXZPZMZ+y9P7Q==
X-Received: by 2002:a05:6512:3f8d:: with SMTP id x13mr3141819lfa.213.1640198445386;
        Wed, 22 Dec 2021 10:40:45 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id l20sm215023ljb.108.2021.12.22.10.40.45
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 10:40:45 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id bn20so5202601ljb.8
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Dec 2021 10:40:45 -0800 (PST)
X-Received: by 2002:a5d:6211:: with SMTP id y17mr2950577wru.97.1640198434545;
 Wed, 22 Dec 2021 10:40:34 -0800 (PST)
MIME-Version: 1.0
References: <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
 <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com> <20211221190706.GG1432915@nvidia.com>
 <3e0868e6-c714-1bf8-163f-389989bf5189@redhat.com> <dfe1c8d5-6fac-9040-0272-6d77bafa6a16@redhat.com>
 <20211222124141.GA685@quack2.suse.cz> <4a28e8a0-2efa-8b5e-10b5-38f1fc143a98@redhat.com>
 <20211222144255.GE685@quack2.suse.cz> <505d3d0f-23ee-0eec-0571-8058b8eedb97@redhat.com>
 <20211222160846.GH685@quack2.suse.cz>
In-Reply-To: <20211222160846.GH685@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Dec 2021 10:40:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjUeCUo7dRkzTeqGMJ5-NE4=Xj09mMB0HCkCnMFxsbmwA@mail.gmail.com>
Message-ID: <CAHk-=wjUeCUo7dRkzTeqGMJ5-NE4=Xj09mMB0HCkCnMFxsbmwA@mail.gmail.com>
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

On Wed, Dec 22, 2021 at 8:08 AM Jan Kara <jack@suse.cz> wrote:
>
> Well, but O_DIRECT reads must use FOLL_PIN in any case because they modify
> page data (and so we need to detect them both for COW and filesystem needs).

Well, O_DIRECT reads do, but not necessarily writes.

And hey, even reads have been dodgy in the past when we didn't really
have the pinning logic - there's been a lot of users that just wanted
it to work for their particular use-case rather than in general and in
all situations..

             Linus
