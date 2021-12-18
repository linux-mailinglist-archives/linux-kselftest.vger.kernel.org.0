Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B675479A27
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Dec 2021 11:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhLRKHD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Dec 2021 05:07:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54847 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229847AbhLRKHC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Dec 2021 05:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639822022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZ2/2GDqjwmlPCqWnOt2byTpaYB/3SglXvSt+1GORAs=;
        b=Jj4Lk7knnQRQTPvI0mCnORufeo3k+Y/hi937bg3o3YVZEK9sqKTkw9x+n0rzBRFGDP+H6V
        k26Y2nsJIawiaOBlD1J2a27H8ko4x6Ls7SbxaGA7FMSrGRRxP1XQhz9gwnlvqQEn1l69JL
        AUhaOumItp9o9+naF0izSRmA7x2IBhI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-NBCsOCplPlS1oHjJY-T5CQ-1; Sat, 18 Dec 2021 05:07:00 -0500
X-MC-Unique: NBCsOCplPlS1oHjJY-T5CQ-1
Received: by mail-wm1-f72.google.com with SMTP id v190-20020a1cacc7000000b003456d598510so4236271wme.6
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Dec 2021 02:07:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=XZ2/2GDqjwmlPCqWnOt2byTpaYB/3SglXvSt+1GORAs=;
        b=qP/DdpehweHZTxFTGFyLbs07n6rZYg1ceW6kVuUlrDipcuTNh0SyI5AHVSGrgo2+6r
         tLCZ0waxLVmRxapWhbWhsZPLMtZKM5MJpcRG/7w8K3QzBtX2nTzXxkpheFARLwjbEzIB
         iORCOW19ik5uVLG9n2H0pRdGp3Bq5JnFHWuovR9+37ip+KmsbWWPxxvfFs3LvK4fOa2I
         VXs4anDWJed+TgY3LhZvON/YkMEpOYM23fQnfGnpuUsNrNwkrHv2T372t9b32BixPpYe
         O47kJzy0lEziEjg2aPkvguML5mTzM9ORD2K590bDosJ37UwSnFw0adUmSRdS5lqSD7+c
         1Uhg==
X-Gm-Message-State: AOAM532RD78sIUIzKCCdVxk4snX3KEi4gQ3yE/ULLLlUJUKlv03Ccfai
        G1aylheVS39CyJmVIEudvNfEUMjVimb1vFgZnxEX1GmVy5mcdoawBJjPyrdDoG6UhPL2VgOd8HJ
        eCLO5C34rD3muCdKIG+IPJqkIrtoF
X-Received: by 2002:a5d:64e4:: with SMTP id g4mr5622447wri.510.1639822019719;
        Sat, 18 Dec 2021 02:06:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyE6IcrxlQD0ttKE3+QlbV92H6zyi5iah32fTwcoLS9Mg22cTAzNLO8d6jIQan1384A88Cdag==
X-Received: by 2002:a5d:64e4:: with SMTP id g4mr5622424wri.510.1639822019520;
        Sat, 18 Dec 2021 02:06:59 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6703.dip0.t-ipconnect.de. [91.12.103.3])
        by smtp.gmail.com with ESMTPSA id l2sm2726112wru.83.2021.12.18.02.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 02:06:59 -0800 (PST)
Message-ID: <f3479378-48bc-23be-d651-3ec52bb0085d@redhat.com>
Date:   Sat, 18 Dec 2021 11:06:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
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
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com>
 <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com>
 <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
 <CAHk-=wgw5bEe8+qifra-aY9fAOf2Pscp1vuXX=f4hESyCK_xLg@mail.gmail.com>
 <CAHk-=wjjNx2Ch2j7P+7vDceK39PpmrOqby3gXuTY4aj62dowFw@mail.gmail.com>
 <CAHk-=wj+VpgJ3RfRQNxYS3xN9O01rwWnSBX7mztxFaE6BTLzFw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHk-=wj+VpgJ3RfRQNxYS3xN9O01rwWnSBX7mztxFaE6BTLzFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 18.12.21 03:42, Linus Torvalds wrote:
> On Fri, Dec 17, 2021 at 6:17 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I think the hugepage code should use the exact same logic that the
>> regular wp fault code does.
> 
> IOW, I think that this stupid (AND UNTESTED) patch should likely just
> fix David's test-case with the hugepage and splice thing..
> 
> Or at least be somewhat close.  But it should be paired with the GUP
> side doing the right thing too, of course. Maybe it already does,
> maybe it doesn't, I didn't check...
> 
> And maybe there's something subtle about the page_count() of a THP
> entry. Again, I can't really claim to have tested this all, but I'm
> hoping this makes somebody go "Ahh, now I see what Linus means"

Not the reaction you are hoping for: "Gah, Linus still doesn't see why
the page_count is just wrong". :)

See the mail I just wrote, let's get a common understanding of how our
check should actually look like.

-- 
Thanks,

David / dhildenb

