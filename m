Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C036547987A
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Dec 2021 04:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhLRDjJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 22:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhLRDjJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 22:39:09 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6D2C061574
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 19:39:08 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 13so6215951ljj.11
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 19:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BxFK+093IJRQnbXW5Og88SuGPphlDPFlB6O2bfY/1Ws=;
        b=AAZ+me/h1XGaSaNRrJXizPg0Km/qG0INBdJS0TmFPdkE5f9PsFTYB6Txr2Gz38XLIX
         zPP/iYefPweJa/M91dvLwmoT3+O9qR+Qjw0z2ZxHVcC+2bWTEslsEbGndeCEoqoGaoON
         TWmidbo8qai3FAIzAu88GdctoyASGDe47Cq0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxFK+093IJRQnbXW5Og88SuGPphlDPFlB6O2bfY/1Ws=;
        b=BIqvjSqcLT3Uuu0go5xXUuZ+ImYQ7mbnoUhIOsBQ+fES7ma5GnKjUXHMo7T8+9Xxsh
         7Gk3Dhmz+/dm3dm04cZkdoISRnNpf5wYWuR9QjzEOJbNLo38HowBBEWfYKv1qQ9alu8I
         PSOCLFaDwQPkkEKaXuwUIOv9TJWIHcFP90SVlNa7cG+rGJSOzG8ByIOj+NPzteOOZftv
         ik7VtVX+7jrhcF8hhEELCmcqW6EsFMRHKl8r+3XiqtJCyUEjThpDCeE871+helhxdEo1
         MSr/V+OXg5SXmNhxsN3mgSfDZcKvbcGtRDn0OBLIvhIU+lFv49g9tAgjy3gZiYbebMFz
         YGNA==
X-Gm-Message-State: AOAM532iJCIpJhoCAKdLGwscOKlEB+Q+aDcxioapd7Yqe9zsIM8bc59P
        A2SWTTSVOOyG5dQPE4+Bb3AD9wrYF/H/ceS/lII=
X-Google-Smtp-Source: ABdhPJwyM5iFKwQPzc+NuEISMJ6FnjjtwVISdyUjB7hEcQS9xYYYxO27N04pVahwBK00AIlnwkVNLA==
X-Received: by 2002:a2e:99cf:: with SMTP id l15mr5496533ljj.111.1639798746673;
        Fri, 17 Dec 2021 19:39:06 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id b32sm1918950ljf.41.2021.12.17.19.39.06
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 19:39:06 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id u22so6270921lju.7
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 19:39:06 -0800 (PST)
X-Received: by 2002:a05:6000:10d2:: with SMTP id b18mr3943603wrx.193.1639798735711;
 Fri, 17 Dec 2021 19:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com> <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com> <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
 <CAHk-=wgw5bEe8+qifra-aY9fAOf2Pscp1vuXX=f4hESyCK_xLg@mail.gmail.com>
 <20211218030509.GA1432915@nvidia.com> <5C0A673F-8326-4484-B976-DA844298DB29@vmware.com>
In-Reply-To: <5C0A673F-8326-4484-B976-DA844298DB29@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 19:38:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj7eSOhbWDeADL_BJKLzdDF5s_5R9v7d-4P3L6v1T3mpQ@mail.gmail.com>
Message-ID: <CAHk-=wj7eSOhbWDeADL_BJKLzdDF5s_5R9v7d-4P3L6v1T3mpQ@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     Nadav Amit <namit@vmware.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
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

On Fri, Dec 17, 2021 at 7:30 PM Nadav Amit <namit@vmware.com> wrote:
>
> In such a case, I do think it makes sense to fail uffd-wp (when
> page_count() > 1), and in a prototype I am working on I do something
> like that.

Ack. If uddf-wp finds a page that is pinned, just skip it as not
write-protectable.

Because some of the pinners might be writing to it, of course - just
not through the page tables.

So that sounds like the right thing to do. I _think_ we discussed this
the last time this came up. I have some dim memory of that. Jason,
ring a bell?

             Linus
