Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8C44792DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 18:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbhLQRae (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 12:30:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59686 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236363AbhLQRad (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 12:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639762233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XpYrlXQGuGiTurswQoKfair4c1yoIHCy4su7rQT1jtY=;
        b=YdIM1VtZ8v/0V3zMitEIwSscVBefKBQhSpQSFba5BxxEQN5YKDAqQtma7Gvx/llhpGjVwF
        qJLr6HCLJfYEK4Z0WQK4KaVpjJb75C3osA3FKudyoWu7IMXY2B75O5jO7q2NqZzArZln/y
        6ijMmlaW2Q8tnnvF33zmxv5MW6BHFFQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-D2-5CPdsNAGOBvgZbzx4_w-1; Fri, 17 Dec 2021 12:30:32 -0500
X-MC-Unique: D2-5CPdsNAGOBvgZbzx4_w-1
Received: by mail-wr1-f71.google.com with SMTP id w25-20020adf8bd9000000b001a255212b7cso731728wra.18
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 09:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=XpYrlXQGuGiTurswQoKfair4c1yoIHCy4su7rQT1jtY=;
        b=rqWzNL7lbCk2nk/nj/SXPVHbvL0fdCqucOuc89esq3TNMLFRTR3zjgfsfkqg/NCB/V
         yRfj70gJDbjpT1Sr5GHKK8oZw7cb5ULdurLlVjDYETftF8wBb6M1rKY+DfRyzJfEip0A
         Wod/yhgLNV6sKy70QT2ZRvkgxrUc/nG5ZJcLgfS8BisbfGjmDXkKvw/Ifogc66lwShbk
         MKvIrIs2NHXX9AFkzFmREqvLnUlr4peH2WsXH+ynIwe0krOzARbJSKCpv2wbMLNDV1x7
         ptSqtBWBdhnqu9jqg5boAFbUp5szlTQJOrTxcqW4zhScDojmvq/tFnhV1qvdS1EDztuc
         dqLA==
X-Gm-Message-State: AOAM533zdBBaJ/dD/ThWvEC5dIrJ4OazwUYjp8PX6B2UafhSKzv+rcg8
        SiLgpBUxMeKZEePDICeNn99KktD2F8rE840qUjDTY+a77Eo7rFSPaPzyIIaLhm0fKgV+1ijscvu
        9fRQuFsWi2iTbdLURiIrBUEjM3TY3
X-Received: by 2002:a5d:6e85:: with SMTP id k5mr3514774wrz.545.1639762231062;
        Fri, 17 Dec 2021 09:30:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrXMA9V67jpui+rmft7WNUVQD8C+zSHOzezyGLBEqcDkWsoghcyJDIaNnyt3ahYOR9kJWzYQ==
X-Received: by 2002:a5d:6e85:: with SMTP id k5mr3514742wrz.545.1639762230870;
        Fri, 17 Dec 2021 09:30:30 -0800 (PST)
Received: from [192.168.3.132] (p4ff234b8.dip0.t-ipconnect.de. [79.242.52.184])
        by smtp.gmail.com with ESMTPSA id y15sm11233959wry.72.2021.12.17.09.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 09:30:30 -0800 (PST)
Message-ID: <8b2a8dc7-bad6-7c0f-12f8-a79c68f84508@redhat.com>
Date:   Fri, 17 Dec 2021 18:30:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 03/11] mm: simplify hugetlb and file-THP handling in
 __page_mapcount()
Content-Language: en-US
To:     Nadav Amit <namit@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-4-david@redhat.com>
 <10A6B16D-3570-4010-83B9-41A38B50C8A4@vmware.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <10A6B16D-3570-4010-83B9-41A38B50C8A4@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17.12.21 18:16, Nadav Amit wrote:
> 
>> On Dec 17, 2021, at 3:30 AM, David Hildenbrand <david@redhat.com> wrote:
>>
>> Let's return early for hugetlb, which really only relies on the compound
>> mapcount so far and does not support PageDoubleMap() yet. Use the chance
>> to cleanup the file-THP case to make it easier to grasp. While at it, use
>> head_compound_mapcount().
>>
>> This is a preparation for further changes.
> 
> It would be useful to add “no functional change intended” or something.

Absolutely, same applies to other "simplification" patches.

> 
>>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>> mm/util.c | 11 +++++++----
>> 1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/util.c b/mm/util.c
>> index 741ba32a43ac..3239e75c148d 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -732,15 +732,18 @@ int __page_mapcount(struct page *page)
>> {
>> 	int ret;
>>
>> -	ret = atomic_read(&page->_mapcount) + 1;
>> +	if (PageHuge(page))
>> +		return compound_mapcount(page);
> 
> Before you return, perhaps you can add an assertion like:
> 
> 	VM_BUG_ON(PageDoubleMap(page));
> 
> This would be make the code clearer and would ease debugging in the
> future (if support for double-map is expanded).
> 

I'd probably have to add this to a couple of places -- and I assume
anybody working on that has to grep the kernel for use of PageDoubleMap
already.

Thanks!

-- 
Thanks,

David / dhildenb

