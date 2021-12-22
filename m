Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C8A47D2AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 14:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240756AbhLVNJu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 08:09:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236878AbhLVNJs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 08:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640178588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CfGQJ8VLCAkR3VAHE3KwEWNYdOWUKHoL0zlrbiTMV8w=;
        b=M8yH0ynkgK98ZCITtHNEfczeLW+b9oJTWexk6bmYdOKkEpHYCZfu7Vp8TJ+/ONOTGzheIu
        mgPGS+QcS8GSxrN3n4b41ea0Nj1oURlNga65fp45pL3o4ZQX0RrR2cM60sNTnarLl326F8
        lhARJHvcFh3dg9N1qvff+9NAGa36/i0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-yuLvS8FhPiSEZSdNq1oPkw-1; Wed, 22 Dec 2021 08:09:45 -0500
X-MC-Unique: yuLvS8FhPiSEZSdNq1oPkw-1
Received: by mail-wr1-f71.google.com with SMTP id r9-20020adfb1c9000000b001a2981d9356so663092wra.20
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Dec 2021 05:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=CfGQJ8VLCAkR3VAHE3KwEWNYdOWUKHoL0zlrbiTMV8w=;
        b=k9f+RUXgV8bHnxeyV9HgitizkZAtO3Um13dw7vAbj1zseHWCQZwKPWjF9tygtc2twS
         MfLW6o8Ix0Mv+Fe8rEC53em/bk69nVvroOOtQoo1hyBmxZ00/AH4ILfZMxAoCxyYe9Cr
         cezKUrrJOk3yaz+QU45ED6WLkAn0r0P0kqbwOIYi5osufe4rZ5Q1FubyCFK9n6rBle5d
         mQeiEFbKu/DY27UpGNpErcwFoFtkS870IbjrVycUy+dKl5mXY4NyVKVu8GnNBhgWQ2QE
         lyRUZAjZNURe2S9DtJeK/NeGoxxlABzYbEuerLh3zCktF56iZCHMO8jd2gB3ThscTYuy
         cRQg==
X-Gm-Message-State: AOAM531SqY3MIJoEN2WpTOe4oIRW4Mi7Zx5Gzq9Qr5p5p3YvhOOM+VZ2
        7zNaGad1cAJv3s/bP0LAprBzLlLcBia9CyovJHOOSQlXcoDxQBdUFjCLutFYcLLm/HzIipuxth4
        0PT+nxk0f83sUZC5h4yB4Pm+zDyS8
X-Received: by 2002:a1c:2606:: with SMTP id m6mr952079wmm.52.1640178584276;
        Wed, 22 Dec 2021 05:09:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVw0VkRoILxmXz6ntlhHpAsfmiaJOO/xnfDe7yGOHGMLtP0t1L14n//3hYvbXuKWfqxczqDw==
X-Received: by 2002:a1c:2606:: with SMTP id m6mr952048wmm.52.1640178583964;
        Wed, 22 Dec 2021 05:09:43 -0800 (PST)
Received: from [192.168.3.132] (p5b0c646a.dip0.t-ipconnect.de. [91.12.100.106])
        by smtp.gmail.com with ESMTPSA id bg12sm2178645wmb.5.2021.12.22.05.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 05:09:43 -0800 (PST)
Message-ID: <4a28e8a0-2efa-8b5e-10b5-38f1fc143a98@redhat.com>
Date:   Wed, 22 Dec 2021 14:09:41 +0100
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
References: <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
 <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
 <20211221190706.GG1432915@nvidia.com>
 <3e0868e6-c714-1bf8-163f-389989bf5189@redhat.com>
 <dfe1c8d5-6fac-9040-0272-6d77bafa6a16@redhat.com>
 <20211222124141.GA685@quack2.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211222124141.GA685@quack2.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>> IIUC, our COW logic makes sure that a shared anonymous page that might
>> still be used by a R/O FOLL_GET cannot be modified, because any attempt
>> to modify it would result in a copy.
> 
> Well, we defined FOLL_PIN to mean the intent that the caller wants to access
> not only page state (for which is enough FOLL_GET and there are some users
> - mostly inside mm - who need this) but also page data. Eventually, we even
> wanted to make FOLL_GET unavailable to broad areas of kernel (and keep it
> internal to only MM for its dirty deeds ;)) to reduce the misuse of GUP.
> 
> For file pages we need this data vs no-data access distinction so that
> filesystems can detect when someone can be accessing page data although the
> page is unmapped.  Practically, filesystems care most about when someone
> can be *modifying* page data (we need to make sure data is stable e.g. when
> writing back data to disk or doing data checksumming or other operations)
> so using FOLL_GET when wanting to only read page data should be OK for
> filesystems but honestly I would be reluctant to break the rule of "use
> FOLL_PIN when wanting to access page data" to keep things simple and
> reasonably easy to understand for parties such as filesystem developers or
> driver developers who all need to interact with pinned pages...

Right, from an API perspective we really want people to use FOLL_PIN.

To optimize this case in particular it would help if we would have the
FOLL flags on the unpin path. Then we could just decide internally
"well, short-term R/O FOLL_PIN can be really lightweight, we can treat
this like a FOLL_GET instead". And we would need that as well if we were
to keep different counters for R/O vs. R/W pinned.

-- 
Thanks,

David / dhildenb

