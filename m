Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5176047D3F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 15:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241426AbhLVOsj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 09:48:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231224AbhLVOsi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 09:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640184518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ysFZc3PcwsKiLv7/T8kvp9irIa0KaTSGauHVtOY+NM=;
        b=ZiKMCDq4pgpTPpp0PZRAfJTflWBVmxB2O/cF5wFtSgpVaGs22m/BAHP8VBkl/HdwxxORe8
        SNXZeAkQhKSKQaNPjXDfhe4QUyinqB7DUCbgcYRfvSfS7S2AsCLROD6T5cBl7+4lwuf8se
        NalmzmuH+DTOXjJCl6Pr7Ffbo4bs7Oc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-1YKPCjk_PX2P9kawc7Oz5w-1; Wed, 22 Dec 2021 09:48:37 -0500
X-MC-Unique: 1YKPCjk_PX2P9kawc7Oz5w-1
Received: by mail-wm1-f71.google.com with SMTP id r2-20020a05600c35c200b00345c3b82b22so1254210wmq.0
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Dec 2021 06:48:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=3ysFZc3PcwsKiLv7/T8kvp9irIa0KaTSGauHVtOY+NM=;
        b=OHffS29bgqtZcxpz1uTRoQr8oJ7eToGfPd295G3HKYGYncyx02iQ76/ydwdNvhMdUY
         jUUW6CJnbkYSmghIQVzqFPDrla328ytiylqrBsEOQQIOGhq9ArpeJQW+4DcX/gBxqKyV
         WlfiPMUoIJYeZ9vY/iB5E/l4j8DwS4Le5VbABo2W3mMawIcMqeljDN5mhmotXyzKUIL7
         TPvw7p4vql7W3PZnMZGma7aCHhngqTUW0GtwsQljGeefTOaeZM57wF/MWgvq9k1awFPm
         XPPg2po3wsvjiv+WJw34HcWl4adXECx2baVBvHxCjYfzvL0OxAbmFH2LCLTG0vppc7Ol
         UjSQ==
X-Gm-Message-State: AOAM530JHvNa9/zSFK9RvPL1T1HAAzOuKUe9/gSohyK6vEPTJhxDjydm
        Aj8jNhqHPf+qV29kpu9yfgxU648QTOzv/kgDjTzECId3Z3MOOEUb7HoqbDLErIyxhPjqNR/DSXc
        G0xRTSQJtMpnaL88OTQa9w2Y6HLe+
X-Received: by 2002:a5d:59af:: with SMTP id p15mr2400748wrr.422.1640184516091;
        Wed, 22 Dec 2021 06:48:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzs94LbEOPQ0orxF56DEs0Qlsxjs3+SD5a8O6tpjufwOywHmGl7SQSLlNxvlgdUF3zjoLVEEA==
X-Received: by 2002:a5d:59af:: with SMTP id p15mr2400735wrr.422.1640184515809;
        Wed, 22 Dec 2021 06:48:35 -0800 (PST)
Received: from [192.168.3.132] (p5b0c646a.dip0.t-ipconnect.de. [91.12.100.106])
        by smtp.gmail.com with ESMTPSA id l2sm2250738wrs.43.2021.12.22.06.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 06:48:35 -0800 (PST)
Message-ID: <505d3d0f-23ee-0eec-0571-8058b8eedb97@redhat.com>
Date:   Wed, 22 Dec 2021 15:48:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
References: <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
 <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
 <20211221190706.GG1432915@nvidia.com>
 <3e0868e6-c714-1bf8-163f-389989bf5189@redhat.com>
 <dfe1c8d5-6fac-9040-0272-6d77bafa6a16@redhat.com>
 <20211222124141.GA685@quack2.suse.cz>
 <4a28e8a0-2efa-8b5e-10b5-38f1fc143a98@redhat.com>
 <20211222144255.GE685@quack2.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211222144255.GE685@quack2.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 22.12.21 15:42, Jan Kara wrote:
> On Wed 22-12-21 14:09:41, David Hildenbrand wrote:
>>>> IIUC, our COW logic makes sure that a shared anonymous page that might
>>>> still be used by a R/O FOLL_GET cannot be modified, because any attempt
>>>> to modify it would result in a copy.
>>>
>>> Well, we defined FOLL_PIN to mean the intent that the caller wants to access
>>> not only page state (for which is enough FOLL_GET and there are some users
>>> - mostly inside mm - who need this) but also page data. Eventually, we even
>>> wanted to make FOLL_GET unavailable to broad areas of kernel (and keep it
>>> internal to only MM for its dirty deeds ;)) to reduce the misuse of GUP.
>>>
>>> For file pages we need this data vs no-data access distinction so that
>>> filesystems can detect when someone can be accessing page data although the
>>> page is unmapped.  Practically, filesystems care most about when someone
>>> can be *modifying* page data (we need to make sure data is stable e.g. when
>>> writing back data to disk or doing data checksumming or other operations)
>>> so using FOLL_GET when wanting to only read page data should be OK for
>>> filesystems but honestly I would be reluctant to break the rule of "use
>>> FOLL_PIN when wanting to access page data" to keep things simple and
>>> reasonably easy to understand for parties such as filesystem developers or
>>> driver developers who all need to interact with pinned pages...
>>
>> Right, from an API perspective we really want people to use FOLL_PIN.
>>
>> To optimize this case in particular it would help if we would have the
>> FOLL flags on the unpin path. Then we could just decide internally
>> "well, short-term R/O FOLL_PIN can be really lightweight, we can treat
>> this like a FOLL_GET instead". And we would need that as well if we were
>> to keep different counters for R/O vs. R/W pinned.
> 
> Well, I guess the question here is: Which GUP user needs only R/O access to
> page data and is so performance critical that it would be worth it to
> sacrifice API clarity for speed? I'm not aware of any but I was not looking
> really hard...

I'd be interested in examples as well. Maybe databases that use O_DIRECT
after fork()?


-- 
Thanks,

David / dhildenb

