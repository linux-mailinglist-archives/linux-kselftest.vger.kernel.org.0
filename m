Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F18F7C829D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 11:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjJMJ5W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 05:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjJMJ5V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 05:57:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCEEC0
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Oct 2023 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697190997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R9Nes4o/OPm7jVacYP7oyYJpCPXDJR40Q0Sq3rgGM8g=;
        b=Gkzscqt36T8XQoQazIwVtEJ8Jic1XEiIfYrQ82X0laXIiQpdY8BGqrkLmNFirHcBVegqOa
        KNhG7n4QGVoIQgsgtN00P1JgrwE2dTcqDaDhUFn5Wvc4YxI57EXETNtGI4Ajwjp2kLnqBQ
        Hk+VeCeGmTHPFZkSShWgZgmQvQK9e0g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-UF8wwAivOHiysXZbi6PDuw-1; Fri, 13 Oct 2023 05:56:35 -0400
X-MC-Unique: UF8wwAivOHiysXZbi6PDuw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32d879cac50so1131909f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Oct 2023 02:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697190994; x=1697795794;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R9Nes4o/OPm7jVacYP7oyYJpCPXDJR40Q0Sq3rgGM8g=;
        b=PGAzcPpWC64uu/mxtWtA68+pU/BocTcwt4p6r2IUHjfawr/MfiDfJ8E73o9czRUGJC
         v4u97Gg9f7QGkwteMwdnPcA9BqxPZlNw63EzpaCjUdnzTBA+2ipO2VaebGUvegxTqR7z
         IGACQfaUCWO4QT0jjHGNbfc0LaYNI2kdoytOmUAKhdCGXiuRHIFuoXcUT3SM18y6SgXn
         TYY8OHUAl63AJQBdrKLDQNTFxrtG0mtqNXOWJ9EGVou+wmVhQmRjwZ0Y4OXovO7jZDtb
         zMBUndcmGkOBD9sYnoKECVYCo0T0ez0TnuDaDnkPhCrNKLRDD5kAfMR1HDaNft9ojANb
         nCNA==
X-Gm-Message-State: AOJu0YyprzcuyJlDcbcWyCLkplPW79gQROTYZnwsQ43s/p6bjDcp2skt
        LdyhbDa9CJkjaMdtzp3NSmxQURt3uBHhCyscyfIHu6G4IpD4qfwMw89nheKuU0jTrdOhENY3ESw
        +bx2z7MMLhQGTzoAvZYY3hOiCnJ7U
X-Received: by 2002:adf:a19b:0:b0:32d:8942:a000 with SMTP id u27-20020adfa19b000000b0032d8942a000mr4804876wru.20.1697190994105;
        Fri, 13 Oct 2023 02:56:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDmR8ay0Jo6bUN7SnkfjJvl1Y+K6Q+GuBFpH5FfJ1pGwuzNq5/eAJEgPiKOvx8Fv92EbKkDQ==
X-Received: by 2002:adf:a19b:0:b0:32d:8942:a000 with SMTP id u27-20020adfa19b000000b0032d8942a000mr4804847wru.20.1697190993574;
        Fri, 13 Oct 2023 02:56:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:9300:1381:43e2:7c78:b68f? (p200300cbc7189300138143e27c78b68f.dip0.t-ipconnect.de. [2003:cb:c718:9300:1381:43e2:7c78:b68f])
        by smtp.gmail.com with ESMTPSA id t4-20020a0560001a4400b0032763287473sm20703578wry.75.2023.10.13.02.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 02:56:33 -0700 (PDT)
Message-ID: <205abf01-9699-ff1c-3e4e-621913ada64e@redhat.com>
Date:   Fri, 13 Oct 2023 11:56:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, Lokesh Gidra <lokeshgidra@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
References: <20231009064230.2952396-1-surenb@google.com>
 <20231009064230.2952396-3-surenb@google.com>
 <214b78ed-3842-5ba1-fa9c-9fa719fca129@redhat.com>
 <CAJuCfpHzSm+z9b6uxyYFeqr5b5=6LehE9O0g192DZdJnZqmQEw@mail.gmail.com>
 <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com>
 <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
 <ZShS3UT+cjJFmtEy@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
In-Reply-To: <ZShS3UT+cjJFmtEy@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12.10.23 22:11, Peter Xu wrote:
> On Mon, Oct 09, 2023 at 05:29:08PM +0100, Lokesh Gidra wrote:
>> On Mon, Oct 9, 2023 at 5:24 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 09.10.23 18:21, Suren Baghdasaryan wrote:
>>>> On Mon, Oct 9, 2023 at 7:38 AM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 09.10.23 08:42, Suren Baghdasaryan wrote:
>>>>>> From: Andrea Arcangeli <aarcange@redhat.com>
>>>>>>
>>>>>> Implement the uABI of UFFDIO_MOVE ioctl.
>>>>>> UFFDIO_COPY performs ~20% better than UFFDIO_MOVE when the application
>>>>>> needs pages to be allocated [1]. However, with UFFDIO_MOVE, if pages are
>>>>>> available (in userspace) for recycling, as is usually the case in heap
>>>>>> compaction algorithms, then we can avoid the page allocation and memcpy
>>>>>> (done by UFFDIO_COPY). Also, since the pages are recycled in the
>>>>>> userspace, we avoid the need to release (via madvise) the pages back to
>>>>>> the kernel [2].
>>>>>> We see over 40% reduction (on a Google pixel 6 device) in the compacting
>>>>>> thread’s completion time by using UFFDIO_MOVE vs. UFFDIO_COPY. This was
>>>>>> measured using a benchmark that emulates a heap compaction implementation
>>>>>> using userfaultfd (to allow concurrent accesses by application threads).
>>>>>> More details of the usecase are explained in [2].
>>>>>> Furthermore, UFFDIO_MOVE enables moving swapped-out pages without
>>>>>> touching them within the same vma. Today, it can only be done by mremap,
>>>>>> however it forces splitting the vma.
>>>>>>
>>>>>> [1] https://lore.kernel.org/all/1425575884-2574-1-git-send-email-aarcange@redhat.com/
>>>>>> [2] https://lore.kernel.org/linux-mm/CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com/
>>>>>>
>>>>>> Update for the ioctl_userfaultfd(2)  manpage:
>>>>>>
>>>>>>       UFFDIO_MOVE
>>>>>>           (Since Linux xxx)  Move a continuous memory chunk into the
>>>>>>           userfault registered range and optionally wake up the blocked
>>>>>>           thread. The source and destination addresses and the number of
>>>>>>           bytes to move are specified by the src, dst, and len fields of
>>>>>>           the uffdio_move structure pointed to by argp:
>>>>>>
>>>>>>               struct uffdio_move {
>>>>>>                   __u64 dst;    /* Destination of move */
>>>>>>                   __u64 src;    /* Source of move */
>>>>>>                   __u64 len;    /* Number of bytes to move */
>>>>>>                   __u64 mode;   /* Flags controlling behavior of move */
>>>>>>                   __s64 move;   /* Number of bytes moved, or negated error */
>>>>>>               };
>>>>>>
>>>>>>           The following value may be bitwise ORed in mode to change the
>>>>>>           behavior of the UFFDIO_MOVE operation:
>>>>>>
>>>>>>           UFFDIO_MOVE_MODE_DONTWAKE
>>>>>>                  Do not wake up the thread that waits for page-fault
>>>>>>                  resolution
>>>>>>
>>>>>>           UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES
>>>>>>                  Allow holes in the source virtual range that is being moved.
>>>>>>                  When not specified, the holes will result in ENOENT error.
>>>>>>                  When specified, the holes will be accounted as successfully
>>>>>>                  moved memory. This is mostly useful to move hugepage aligned
>>>>>>                  virtual regions without knowing if there are transparent
>>>>>>                  hugepages in the regions or not, but preventing the risk of
>>>>>>                  having to split the hugepage during the operation.
>>>>>>
>>>>>>           The move field is used by the kernel to return the number of
>>>>>>           bytes that was actually moved, or an error (a negated errno-
>>>>>>           style value).  If the value returned in move doesn't match the
>>>>>>           value that was specified in len, the operation fails with the
>>>>>>           error EAGAIN.  The move field is output-only; it is not read by
>>>>>>           the UFFDIO_MOVE operation.
>>>>>>
>>>>>>           The operation may fail for various reasons. Usually, remapping of
>>>>>>           pages that are not exclusive to the given process fail; once KSM
>>>>>>           might deduplicate pages or fork() COW-shares pages during fork()
>>>>>>           with child processes, they are no longer exclusive. Further, the
>>>>>>           kernel might only perform lightweight checks for detecting whether
>>>>>>           the pages are exclusive, and return -EBUSY in case that check fails.
>>>>>>           To make the operation more likely to succeed, KSM should be
>>>>>>           disabled, fork() should be avoided or MADV_DONTFORK should be
>>>>>>           configured for the source VMA before fork().
>>>>>>
>>>>>>           This ioctl(2) operation returns 0 on success.  In this case, the
>>>>>>           entire area was moved.  On error, -1 is returned and errno is
>>>>>>           set to indicate the error.  Possible errors include:
>>>>>>
>>>>>>           EAGAIN The number of bytes moved (i.e., the value returned in
>>>>>>                  the move field) does not equal the value that was
>>>>>>                  specified in the len field.
>>>>>>
>>>>>>           EINVAL Either dst or len was not a multiple of the system page
>>>>>>                  size, or the range specified by src and len or dst and len
>>>>>>                  was invalid.
>>>>>>
>>>>>>           EINVAL An invalid bit was specified in the mode field.
>>>>>>
>>>>>>           ENOENT
>>>>>>                  The source virtual memory range has unmapped holes and
>>>>>>                  UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES is not set.
>>>>>>
>>>>>>           EEXIST
>>>>>>                  The destination virtual memory range is fully or partially
>>>>>>                  mapped.
>>>>>>
>>>>>>           EBUSY
>>>>>>                  The pages in the source virtual memory range are not
>>>>>>                  exclusive to the process. The kernel might only perform
>>>>>>                  lightweight checks for detecting whether the pages are
>>>>>>                  exclusive. To make the operation more likely to succeed,
>>>>>>                  KSM should be disabled, fork() should be avoided or
>>>>>>                  MADV_DONTFORK should be configured for the source virtual
>>>>>>                  memory area before fork().
>>>>>>
>>>>>>           ENOMEM Allocating memory needed for the operation failed.
>>>>>>
>>>>>>           ESRCH
>>>>>>                  The faulting process has exited at the time of a
>>>>>>                  UFFDIO_MOVE operation.
>>>>>>
>>>>>
>>>>> A general comment simply because I realized that just now: does anything
>>>>> speak against limiting the operations now to a single MM?
>>>>>
>>>>> The use cases I heard so far don't need it. If ever required, we could
>>>>> consider extending it.
>>>>>
>>>>> Let's reduce complexity and KIS unless really required.
>>>>
>>>> Let me check if there are use cases that require moves between MMs.
>>>> Andrea seems to have put considerable effort to make it work between
>>>> MMs and it would be a pity to lose that. I can send a follow-up patch
>>>> to recover that functionality and even if it does not get merged, it
>>>> can be used in the future as a reference. But first let me check if we
>>>> can drop it.
>>
>> For the compaction use case that we have it's fine to limit it to
>> single MM. However, for general use I think Peter will have a better
>> idea.
> 

Hi Peter,

> I used to have the same thought with David on whether we can simplify the
> design to e.g. limit it to single mm.  Then I found that the trickiest is
> actually patch 1 together with the anon_vma manipulations, and the problem
> is that's not avoidable even if we restrict the api to apply on single mm.
> 
> What else we can benefit from single mm?  One less mmap read lock, but
> probably that's all we can get; IIUC we need to keep most of the rest of
> the code, e.g. pgtable walks, double pgtable lockings, etc.

No existing mechanisms move anon pages between unrelated processes, that 
naturally makes me nervous if we're doing it "just because we can".

> 
> Actually, even though I have no solid clue, but I had a feeling that there
> can be some interesting way to leverage this across-mm movement, while
> keeping things all safe (by e.g. elaborately requiring other proc to create
> uffd and deliver to this proc).

Okay, but no real use cases yet.

> 
> Considering Andrea's original version already contains those bits and all
> above, I'd vote that we go ahead with supporting two MMs.

You can do nasty things with that, as it stands, on the upstream codebase.

If you pin the page in src_mm and move it to dst_mm, you successfully 
broke an invariant that "exclusive" means "no other references from 
other processes". That page is marked exclusive but it is, in fact, not 
exclusive.

Once you achieved that, you can easily have src_mm not have 
MMF_HAS_PINNED, so you can just COW-share that page. Now you 
successfully broke the invariant that COW-shared pages must not be 
pinned. And you can even trigger VM_BUG_ONs, like in 
sanity_check_pinned_pages().

Can it all be fixed? Sure, with more complexity. For something without 
clear motivation, I'll have to pass.

Once there is real demand, we can revisit it and explore what else we 
would have to take care of (I don't know how memcg behaves when moving 
between completely unrelated processes, maybe that works as expected, I 
don't know and I have no time to spare on reviewing features with no 
real use cases) and announce it as a new feature.


Note: that (with only reading the documentation) it also kept me 
wondering how the MMs are even implied from

        struct uffdio_move {
            __u64 dst;    /* Destination of move */
            __u64 src;    /* Source of move */
            __u64 len;    /* Number of bytes to move */
            __u64 mode;   /* Flags controlling behavior of move */
            __s64 move;   /* Number of bytes moved, or negated error */
        };

That probably has to be documented as well, in which address space dst 
and src reside.

-- 
Cheers,

David / dhildenb

