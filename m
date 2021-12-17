Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B66479598
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 21:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240821AbhLQUmq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 15:42:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240725AbhLQUmq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 15:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639773764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yoQ5b3tWSR/7M0GXEFtZ51EVC0Or2dbhzeqMAw0VG5s=;
        b=OM2gUlWQmBiaJ5ecbZ7DQZsfKkCbkZGH+dGPUwLIy4ysLLvKfZT+r8KsS/BQfn2Gz2l4Va
        /27/tKa8tU3jbLhRPbcKOBuqH38TOfHBd4LI+i024nBRtpjuB52k+3hLjlZ11ZPTMeGMJG
        FhqFwCvHL9J/N8Dx864+Y3MrrtHo0oQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-DJGsiJMMMZyZxPAFF0pBvQ-1; Fri, 17 Dec 2021 15:42:43 -0500
X-MC-Unique: DJGsiJMMMZyZxPAFF0pBvQ-1
Received: by mail-wm1-f70.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso3460755wms.4
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 12:42:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=yoQ5b3tWSR/7M0GXEFtZ51EVC0Or2dbhzeqMAw0VG5s=;
        b=vifZgpg4gIW6gCAgaQ4656FUlDPTltAsY2l5ulmCHnb7jQZU6uL6rrdbbJdVC43B/Z
         cB1iM26UNscElBwGzSi6px9Ekhb5cV2wqprdBYwsJfUH2JAGf2OFVcfiKfKfWOOmtWpi
         /3gA9J6xqb8BuneHSixlPgI7GOJHMI224yawLg3Kw6JJdJI39U7imewu+Liqf6Q16/yH
         1/7EUXag7XriQHmWFFC1pize0WclZX2PFujGb4AnukCrdkbnGrTq+DRjePUdaRzDQbJ4
         tbwWEjvuGyO1gu0RPkteiS7ROAWzlYRcV0nns+X5ZxZrOwUvquo37wrgV4EaWa3+yeo0
         f3bA==
X-Gm-Message-State: AOAM5316MDxEQpIvAxc+hjP4Ymts7NAqMHJW/nuZamwvc0goB6cTni1N
        FwUmxaumKTXhaBOhnSkPXO7CDdzFZgZwvNn6Zj4wnBr1e1NFed2LzWDn+RNM54eCxsEabvbArSw
        K6jzTg01L6LWZrfh7MfFqhH4KXmdc
X-Received: by 2002:adf:dbc3:: with SMTP id e3mr2099510wrj.150.1639773762408;
        Fri, 17 Dec 2021 12:42:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfwYR63RH/Y39rstTmOD+1KVKrDQCtQl5Ge3r/m8m87GTGG69yqtvC3dttx2+h33K6gRe9sQ==
X-Received: by 2002:adf:dbc3:: with SMTP id e3mr2099488wrj.150.1639773762223;
        Fri, 17 Dec 2021 12:42:42 -0800 (PST)
Received: from [192.168.3.132] (p4ff234b8.dip0.t-ipconnect.de. [79.242.52.184])
        by smtp.gmail.com with ESMTPSA id c187sm9480848wme.33.2021.12.17.12.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 12:42:41 -0800 (PST)
Message-ID: <17bfb2fd-da51-1264-513f-f9e928ec36c6@redhat.com>
Date:   Fri, 17 Dec 2021 21:42:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com>
 <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17.12.21 21:36, Linus Torvalds wrote:
> On Fri, Dec 17, 2021 at 12:18 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 17.12.21 20:22, Linus Torvalds wrote:
>>> On Fri, Dec 17, 2021 at 11:04 AM Linus Torvalds
>>> <torvalds@linux-foundation.org> wrote:
>>>>
>>>  - get a "readonly" copy of a local private page using FAULT_FLAG_UNSHARE.
>>>
>>>    This just increments the page count, because mapcount == 1.
>>>
>>>  - fork()
>>>
>>>  - unmap in the original
>>>
>>>  - child now has "mapcount == 1" on a page again, but refcount is
>>> elevated, and child HAS TO COW before writing.
>>
>> Hi Linus,
>>
>> This is just GUP before fork(), which is in general
>> problematic/incompatible with sharing.
> 
> Note that my example was not meant to be an example of a problem per
> se, but purely as an example of how meaningless 'mapcount' is, and how
> 'mapcount==1' isn't really a very meaningful test.
> 
> So it wasn't mean to show "look, GUP before fork is problematic".  We
> have that problem already solved at least for regular pages.
> 
> It was purely meant to show how "mapcount==1" isn't a meaningful thing
> to test, and my worry about how you're adding that nonsensical test to
> the new code.
> 
>> Let's just take a look at what refcount does *wrong*. Let's use an
>> adjusted version of your example above, because it's a perfect fit:
>>
>> 1. mem = mmap(pagesize, MAP_PRIVATE)
>> -> refcount == 1
>>
>> 2. memset(mem, 0, pagesize); /* Page is mapped R/W */
>>
>> 3. fork() /* Page gets mapped R/O */
>> -> refcount > 1
>>
>> 4. child quits
>> -> refcount == 1
>>
>> 5. Take a R/O pin (RDMA, VFIO, ...)
>> -> refcount > 1
>>
>> 6. memset(mem, 0xff, pagesize);
>> -> Write fault -> COW
> 
> I do not believe this is actually a bug.

It's debatable if it's a BUG or not (I think it is one). It's for sure
inconsistent.

> 
> You asked for a R/O pin, and you got one.
> 
> Then somebody else modified that page, and you got exactly what you
> asked for - a COW event. The original R/O pin has the original page
> that it asked for, and can read it just fine.

Where in the code did I ask for a COW event? I asked for a R/O pin, not
any kind of memory protection.

-- 
Thanks,

David / dhildenb

