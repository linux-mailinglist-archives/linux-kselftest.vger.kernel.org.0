Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D05147C724
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 19:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbhLUS7M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 13:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241661AbhLUS7M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 13:59:12 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB466C061401
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 10:59:11 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id o20so55740690eds.10
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 10:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uSk5VvDYQsZZcaVaJlmVspcVDu3v4JssNYlR5otPJd8=;
        b=L0bWadFfaqA46PbcjZuYpBZ2kmMk5OH+dN7TlMlE8TpSSS6Wc3H8L6rr8vSayRRMnd
         nwOKt4bpcsJBVBwIopwedchXVmYOMPNTwupzZeQIbR5GFhrlNsEIY+AZA0NmQrvb5J0W
         S/x1LVFT4naoo3sVe0dEbJThlFDOiCtk087iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uSk5VvDYQsZZcaVaJlmVspcVDu3v4JssNYlR5otPJd8=;
        b=6VBfTS9aX92rSKqBpLAWDsO3jes5RftScfOeQt/osF7BkMlgmXTqdTvbqeIdteGJu0
         1Xo8Bmq/6iz2sy/yjKmO3ahI1Ao7RNVMQuitPxGq4eH78xIk+PdtLdCjMhcAuf/gJWQf
         8QaEcp9dbOmLRwngK+bth/p0HkK9QOA4iW91Xxn7+BeqdwxlvY1FS86Gr1GcRcsLTMGi
         Z7OrskLeqKsIEttbE94iUAw9LABew+g1sZM35IFFYnFv669ObohnOLWKOVCrrBvZWemQ
         FH6HrQWj9fM94/ymvYUi9V1I5FnXKuqYsiG1AFaNHQKIwHYn6bRpJKmZ937h6YwgEo79
         cNDw==
X-Gm-Message-State: AOAM530eyZG/PB09U76mX0CvEKHCJGhtiGIlgA1/VauMPwmpl6c+Jh6G
        AaHInE2TiEhsGUtmFEeSo2Nm10OyFPNxse1dIBQ=
X-Google-Smtp-Source: ABdhPJybJKUWVKo0T4IoFbGOoaAhdjsTi4VFKyfoiIn46oy1XH3hZjmnoQsdQGagjGJuggr1mmVhjw==
X-Received: by 2002:a05:6402:3589:: with SMTP id y9mr4766236edc.44.1640113150332;
        Tue, 21 Dec 2021 10:59:10 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id 26sm6770322ejk.138.2021.12.21.10.59.09
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 10:59:10 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id v11so28800676wrw.10
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 10:59:09 -0800 (PST)
X-Received: by 2002:adf:8b0e:: with SMTP id n14mr3650177wra.281.1640113138726;
 Tue, 21 Dec 2021 10:58:58 -0800 (PST)
MIME-Version: 1.0
References: <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com> <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com> <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com> <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com> <20211221180705.GA32603@quack2.suse.cz>
 <CAHk-=wiyxQ==vnHFHW99S_OPwA=u1Qrfg2OGr_6zPcBAuhQY2w@mail.gmail.com> <d23ede12-5df7-2f28-00fd-ea58d85ae400@redhat.com>
In-Reply-To: <d23ede12-5df7-2f28-00fd-ea58d85ae400@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Dec 2021 10:58:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=whJeoncgYjzfLOR_dQbJUyOiE1NxE753m1mvAtXZ00tMw@mail.gmail.com>
Message-ID: <CAHk-=whJeoncgYjzfLOR_dQbJUyOiE1NxE753m1mvAtXZ00tMw@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     David Hildenbrand <david@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@nvidia.com>,
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

On Tue, Dec 21, 2021 at 10:51 AM David Hildenbrand <david@redhat.com> wrote:
>
> For that purpose the pincount would already kind-off work. Not precise,
> but at least something ("this page cannot possibly have been pinned").

That part actually exists already, ie put_page_refs() has this:

  #ifdef CONFIG_DEBUG_VM
        if (VM_WARN_ON_ONCE_PAGE(page_ref_count(page) < refs, page))
                return;
  #endif

And yeah, it shouldn't have that '#ifdef CONFIG_DEBUG_VM' there, but I
think it's because the non-CONFIG_DEBUG_VM #define for
VM_WARN_ON_ONCE_PAGE() is broken, and doesn't return 0.

                   Linus
