Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC6D47CE7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 09:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbhLVIve (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 03:51:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243465AbhLVIvd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 03:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640163093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRvPpmnSEt5Rvd34gy/AZJdD22ErE5su7GVxhYTxDPU=;
        b=ORETmMXCPZ2mEDmqjUZkPhtKeyaSUlp+grosWrNV9KRD36z+eP1xq9vkBrQvsOvdK8byKE
        lsVIB6Hx5U62UNONbdY4dGgkeqf4GwpCsn7+Gz9hGjvEm3ZxHGFze2BXB8WzJE38lKMJME
        kZ+0wRPYA0o10LKru1HKX4eHJDR5Qyc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-1GTqBOSeNK6r998Nx0DhBQ-1; Wed, 22 Dec 2021 03:51:31 -0500
X-MC-Unique: 1GTqBOSeNK6r998Nx0DhBQ-1
Received: by mail-wm1-f72.google.com with SMTP id ay40-20020a05600c1e2800b003458b72e865so383187wmb.9
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Dec 2021 00:51:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=nRvPpmnSEt5Rvd34gy/AZJdD22ErE5su7GVxhYTxDPU=;
        b=0URjlMdscXrvDSCcL5neBM23ie3631t5e/m/D76vjJ7cKtp7ZnwnyjFn1uYYolii86
         yiybc3FYOn3EZ0OKfZ1qUXB5J6ngv0PzumsEWzF3s4dWfw5JjxXJQmQ04F0VG1sqRXRU
         mtOFiAoe3Iamy8wOHtbz2setwJ1BYqM0rtjP52JqWXEZmIUTT2kXtki8JyuAtxW1cqQY
         ijkvK1+5a7xEe2eH0JYr4Ga6V0Wem49GSv8T2piW8DxHYGKtYccDTltxXdqk4EGAzWvW
         kcMgEyORo8IfJcjrWiBpF5OSLLVMTGMYNdvvmAf1oLPm7/hNs9lS7Yzgl3IjCKjvmoLK
         efBg==
X-Gm-Message-State: AOAM533q8/KIDI9ztsNtoexNsp6sCZ93Xh8X9ZS0aETLegcmUZ9dAjEa
        FvXaqyq+A9pGV0NrgvbKxVcwCXCAgNPramvqexSWXZDyjhHtr876kBIGKTlz8x4JV2hz3TRI/8J
        gBeHISp4v1zSnhMVG7jbuz7eb2CK7
X-Received: by 2002:adf:fbc5:: with SMTP id d5mr1350819wrs.291.1640163090500;
        Wed, 22 Dec 2021 00:51:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQMP+gg2IazNMUXRkhEzF32QnEjZyzB2DCEgSFhBQY5dN8NepNFzMV52fB9tfCbRd1xCQ93w==
X-Received: by 2002:adf:fbc5:: with SMTP id d5mr1350801wrs.291.1640163090217;
        Wed, 22 Dec 2021 00:51:30 -0800 (PST)
Received: from [192.168.3.132] (p5b0c646a.dip0.t-ipconnect.de. [91.12.100.106])
        by smtp.gmail.com with ESMTPSA id w25sm4451796wmk.20.2021.12.22.00.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 00:51:29 -0800 (PST)
Message-ID: <3e0868e6-c714-1bf8-163f-389989bf5189@redhat.com>
Date:   Wed, 22 Dec 2021 09:51:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
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
 <20211221190706.GG1432915@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
In-Reply-To: <20211221190706.GG1432915@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 21.12.21 20:07, Jason Gunthorpe wrote:
> On Tue, Dec 21, 2021 at 06:40:30PM +0100, David Hildenbrand wrote:
> 
>> 2) is certainly the cherry on top. But it just means that R/O pins don't
>> have to be the weird kid. And yes, achieving 2) would require
>> FAULT_FLAG_EXCLUSIVE / FAULT_FLAG_UNSHARED, but it would really 99% do
>> what existing COW logic does, just bypass the "map writable" and
>> "trigger write fault" semantics.
> 
> I still don't agree with this - when you come to patches can you have
> this work at the end and under a good cover letter? Maybe it will make
> more sense then.

Yes. But really, I think it's the logical consequence of what Linus said
[1]:

  "And then all GUP-fast would need to do is to refuse to look up a page
   that isn't exclusive to that VM. We already have the situation that
   GUP-fast can fail for non-writable pages etc, so it's just another
   test."

We must not FOLL_PIN a page that is not exclusive (not only on gup-fast,
but really, on any gup). If we special case R/O FOLL_PIN, we cannot
enable the sanity check on unpin as suggested by Linus [2]:

  "If we only set the exclusive VM bit on pages that get mapped into
   user space, and we guarantee that GUP only looks up such pages, then
   we can also add a debug test to the "unpin" case that the bit is
   still set."

There are really only two feasible options I see when we want to take a
R/O FOLL_PIN on a !PageAnonExclusive() anon page

(1) Fail the pinning completely. This implies that we'll have to fail
    O_DIRECT once converted to FOLL_PIN.
(2) Request to mark the page PageAnonExclusive() via a
    FAULT_FLAG_UNSHARE and let it succeed.


Anything else would require additional accounting that we already
discussed in the past is hard -- for example, to differentiate R/O from
R/W pins requiring two pin counters.

The only impact would be that FOLL_PIN after fork() has to go via a
FAULT_FLAG_UNSHARE once, to turn the page PageAnonExclusive. IMHO this
is the right thing to do for FOLL_LONGTERM. For !FOLL_LONGTERM it would
be nice to optimize this, to *not* do that, but again ... this would
require even more counters I think, for example, to differentiate
between "R/W short/long-term or R/O long-term pin" and "R/O short-term pin".

So unless we discover a way to do additional accounting for ordinary 4k
pages, I think we really can only do (1) or (2) to make sure we never
ever pin a !PageAnonExclusive() page.


[1]
https://lkml.kernel.org/r/CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com
[2]
https://lkml.kernel.org/r/CAHk-=wiyxQ==vnHFHW99S_OPwA=u1Qrfg2OGr_6zPcBAuhQY2w@mail.gmail.com


-- 
Thanks,

David / dhildenb

