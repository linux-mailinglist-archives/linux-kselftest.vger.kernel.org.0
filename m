Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37AB47C6F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 19:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241556AbhLUSvM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 13:51:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241560AbhLUSvL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 13:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640112671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KdDB4kop2D9Kd7A6GvY14mN9CfVM1HxKMPkAPbonSUY=;
        b=AOKVuL8+R802LOZcGy2j9fF3Ad1zvk29OQlr338p0+fypnCJ0Y3z/WGsPt2DdMxF4W+eqk
        Uinz5e+KiCaylG94wj8UYM98wDO1FJgK5zSVLU3SlTfZzicnV4MhgWjWXRHNj4dqrumXJl
        TI4VogGhGYV//UuP8H6TB/18jBVO9H0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-P_nQVGatOQm-voyhS_5SZQ-1; Tue, 21 Dec 2021 13:51:10 -0500
X-MC-Unique: P_nQVGatOQm-voyhS_5SZQ-1
Received: by mail-wr1-f69.google.com with SMTP id n22-20020adf8b16000000b001a22f61b29cso4883506wra.23
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 10:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=KdDB4kop2D9Kd7A6GvY14mN9CfVM1HxKMPkAPbonSUY=;
        b=1Xw4uOSfxC3lndsTU+FQHIeChGfo09KQLtz7iLu2Ipw/v0N0WOJBQ1BoeUNX1yeGIv
         3usn9WHtUALQAotJIKn5/1zGk91vJqtgRkA1SiR37H7yHtzQmDK9psVdOyO2iXboME5O
         qOaRKlTk1nJb7zHvCrvJvcU0n+0VRO0btmvqWgUajVz3hTDlpiNADOGf11pJOogyO8a7
         Hi/M2tG8EaFhD9zBo9kpUSc53Wxaa1dqGvzwYwCoeHgX0GVX9SFVWj9okejZtPLTVgnb
         /uFHZi1IOOf2lp+Npvrlt8g27GhQS5RmKXkikB4sQi8fM98Bg0gt0L/9PnR/+w1aagFv
         ryBA==
X-Gm-Message-State: AOAM532Gn8CpnBAqUyMpJFw6xuIzuH1RIKucnIL3sVFDGShQPUe4vtqc
        Wlks6JKO0QLimPh9S546bQxQZWA411KxjHDf5CWBEodm7pBB9+IYdbLbfKfqEgnnxMz5f+SbPRL
        RbWEdElAlXWfgvgoMqn44RiqyqoEA
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr3933010wmf.187.1640112668995;
        Tue, 21 Dec 2021 10:51:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwM+bksT9Y2Ns9VVTHnMXz/Z2lA+uiCyhoZvC+eiFeXXwvpSu/vBZOkk4sa5iKh/WRsBXorbg==
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr3932994wmf.187.1640112668811;
        Tue, 21 Dec 2021 10:51:08 -0800 (PST)
Received: from [192.168.3.132] (p5b0c64a4.dip0.t-ipconnect.de. [91.12.100.164])
        by smtp.gmail.com with ESMTPSA id v6sm3197557wmh.8.2021.12.21.10.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 10:51:08 -0800 (PST)
Message-ID: <d23ede12-5df7-2f28-00fd-ea58d85ae400@redhat.com>
Date:   Tue, 21 Dec 2021 19:51:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Nadav Amit <namit@vmware.com>,
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
References: <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
 <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
 <20211221180705.GA32603@quack2.suse.cz>
 <CAHk-=wiyxQ==vnHFHW99S_OPwA=u1Qrfg2OGr_6zPcBAuhQY2w@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHk-=wiyxQ==vnHFHW99S_OPwA=u1Qrfg2OGr_6zPcBAuhQY2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 21.12.21 19:30, Linus Torvalds wrote:
> On Tue, Dec 21, 2021 at 10:07 AM Jan Kara <jack@suse.cz> wrote:
>>
>> For record we always intended (and still intend) to make O_DIRECT use
>> FOLL_PIN. Just it is tricky because some users mix pages pinned with GUP
>> and pages acquired through get_page() in a single bio (such as zero page)
>> and thus it is non-trivial to do the right thing on IO completion (unpin or
>> just put_page).
> 
> Side note: the new "exclusive VM" bit wouldn't _solve_ this issue, but
> it might make it much easier to debug and catch.
> 
> If we only set the exclusive VM bit on pages that get mapped into user
> space, and we guarantee that GUP only looks up such pages, then we can
> also add a debug test to the "unpin" case that the bit is still set.
> 
> And that would catch anybody who ends up using other pages for
> unpin(), and you could have a WARN_ON() for it (obviously also trigger
> on the page count being too small to unpin).

It would also catch if someone would be wrongly dropping the exclusive
flag although there are users (pin) relying on the page staying exclusive.

> 
> That way, at least from a kernel debugging and development standpoint
> it would make it easy to see "ok, this unpinning got a page that
> wasn't pinned"

For that purpose the pincount would already kind-off work. Not precise,
but at least something ("this page cannot possibly have been pinned").


-- 
Thanks,

David / dhildenb

