Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AA547CE4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 09:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbhLVIaL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 03:30:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229652AbhLVIaK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 03:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640161810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K5R13w0zfTN1gfH0nX3lNZrmWuAI/MqkwgiuEDiE6RY=;
        b=O93wayn/KU4ZguD4+m6FPB5hcY+5RMEe5G6KE9j87IQFvZkbE0DH5dbuh/ODK6sVhq9Xau
        TujAwAgWnkN1WEQv5ufmaKF1/pL53rsnVF9UT4I+ibzhWo90+0cNKwRMl4b7YWZTBjm40D
        yPI4AM4qJ7fSLUirNXFTteFADH++1PQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-pAXh2lMZNAGfJ9SK-YYiUQ-1; Wed, 22 Dec 2021 03:30:08 -0500
X-MC-Unique: pAXh2lMZNAGfJ9SK-YYiUQ-1
Received: by mail-wm1-f70.google.com with SMTP id m19-20020a05600c4f5300b00345cb6e8dd4so101648wmq.3
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Dec 2021 00:30:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=K5R13w0zfTN1gfH0nX3lNZrmWuAI/MqkwgiuEDiE6RY=;
        b=ykXsYHpIzl5OYyrw4RT2k/AbMlmgiEDD3ljX5669AhFfpi7WlDY11wR3iimiEal5WT
         PgziLQaX02M9t2NZniZdk1v9OJXtNlKQMdwxmRCH9xQoKWEJyLlv+admQ2kpNfqo5Kb+
         duw1ss7jtDryIrWMS8HBWx4lDxQCx+jfMCqgADm4lnC85BFppAY0JHIFojsAuzQVVcha
         SQ6S21G9U04KwS++NL1QU3HRVPhAYa04MhRPenJP+ZZtB/dbBK5d681QiY3SMj5jmw9i
         QWiFdPG3zulEfsKCwGTyYnR9bOzZK+gKZXBHcxzbKo70w7KXXwKqzAdS7enUXDcGhD0L
         6zQA==
X-Gm-Message-State: AOAM5318gwi14XggXuVzOPnRyGyJqDHRhw4TX9xPUh3EXBqEN5PfqTJb
        3WeNcumPR07+TevpFsELXddVTLJ1Z7FsUHbndLAsAk2VRlGFNFfNY6hS6PumbmU12nGrCwc9Nv4
        gu9OuhA3PleYj7Ml7vybSxvgzGFe4
X-Received: by 2002:a1c:4d0d:: with SMTP id o13mr119030wmh.70.1640161806601;
        Wed, 22 Dec 2021 00:30:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxaZ676bBfkbDM9ipvMcx7Mwzr6YXpVK+BGvG7K1IdqnkI9kzwsmGfVYCo0meG5jwXnlGK2Tw==
X-Received: by 2002:a1c:4d0d:: with SMTP id o13mr119007wmh.70.1640161806438;
        Wed, 22 Dec 2021 00:30:06 -0800 (PST)
Received: from [192.168.3.132] (p5b0c646a.dip0.t-ipconnect.de. [91.12.100.106])
        by smtp.gmail.com with ESMTPSA id m35sm10660481wms.1.2021.12.22.00.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 00:30:06 -0800 (PST)
Message-ID: <e6d5d38c-c309-5646-84e2-5840fc037a5c@redhat.com>
Date:   Wed, 22 Dec 2021 09:30:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
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
 <20211221235916.GI1432915@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211221235916.GI1432915@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 22.12.21 00:59, Jason Gunthorpe wrote:
> On Tue, Dec 21, 2021 at 06:40:30PM +0100, David Hildenbrand wrote:
> 
>> What adds complexity to correctly maintain the "exclusive" state are at
>> least:
>> * KSM (might be harder, have to think about it)
> 
> I know little about it, but isn't KSM like fork where it is trying to
> WP pages with the intention of copying them? Shouldn't KSM completely
> reject WP'ing a page that is under any kind of writable GUP?

I think KSM will, similar to fork(), always have to try removing
PageAnonExclusive() while synchronizing against concurrent GUP pins. If
that fails, the page cannot be converted to KSM and consequently not be
shared.

That will need some rework of KSM  AFAIU, but shouldn't be impossible to do.

-- 
Thanks,

David / dhildenb

