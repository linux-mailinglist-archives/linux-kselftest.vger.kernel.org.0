Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5977BE316
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 16:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjJIOjU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 10:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjJIOjT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 10:39:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7DFA3
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Oct 2023 07:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696862310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j5S0u5gaTjMHujObA+IkbhZqVdwJqY3N87xRM3sPrJM=;
        b=gvN0ruuIwAoIzFYWOHg4q0AOF9c8x3ElIMrKvknIrzRU6E30HAVZCCk1whU36wTPlNdbnv
        gGk8ibTmq6hb7u2zcqaoblLst9gEJEqIJFMfOvFOxMwWHXD++SpyEhrW15RtZALEv3m+XQ
        mMw94iPgqSmSTkMkPaH25Gj8AGj45is=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-wLijeHfLMwGEqqFYU7ss-Q-1; Mon, 09 Oct 2023 10:38:23 -0400
X-MC-Unique: wLijeHfLMwGEqqFYU7ss-Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so29521565e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Oct 2023 07:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696862303; x=1697467103;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5S0u5gaTjMHujObA+IkbhZqVdwJqY3N87xRM3sPrJM=;
        b=XxHjb15Qv/6MebSqWjrw8V8Q6vmc5k8y21LNmsvkb84KX0HTQHdOaaEzNv0MJBB3gg
         y3zKo1oyEaVUTJx0PrhMSrhCQzywH7X8d7F0OBDSkf0vpPviiLHkRYY13EXDNnGhOGUS
         FG1KdQA0BLWM8AJSoUJrwr57PCZm7qefgRZeRxr5zkRNRSzJDO3QBPE3t6ty39KS25bi
         aWuVqtxkZpo/vhJQOUZiZnIP+PXDvxiTxchlblsV0ntidMQH7UlYNcnHQMDnKPZqkrcc
         AOkSpllfwHmX5buHqo3wlQ/shC3R7J2ZOGUHezG0hJPlD2AbJHtF3rf2Ebw8Vbt6jr30
         aEtQ==
X-Gm-Message-State: AOJu0YykYU71s2RGz4MGeUw0BUiNQrRr+ASSlfO3N4wWVH+kicrmPhmu
        AIiiSDhWb8WNIqwB/pl/B6zPwAgK3VXSPG1UEYL0cSawOBwira+XhRal0tp6LtnqmnTOXU6NlOq
        fOokqCLdP9aumW72N5U5PH17WbWm7
X-Received: by 2002:a05:600c:255:b0:405:3d83:2b76 with SMTP id 21-20020a05600c025500b004053d832b76mr13725651wmj.13.1696862302690;
        Mon, 09 Oct 2023 07:38:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/lgJh9xLkSgPGi1UDBVlS9dc93GXgV1bUU7zwzwIH/LQSAB3KVA+j1T7kMzmAEhw6poQhlQ==
X-Received: by 2002:a05:600c:255:b0:405:3d83:2b76 with SMTP id 21-20020a05600c025500b004053d832b76mr13725617wmj.13.1696862302236;
        Mon, 09 Oct 2023 07:38:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:6400:ae10:4bb7:9712:8548? (p200300cbc7336400ae104bb797128548.dip0.t-ipconnect.de. [2003:cb:c733:6400:ae10:4bb7:9712:8548])
        by smtp.gmail.com with ESMTPSA id k22-20020a7bc416000000b00404719b05b5sm11395985wmi.27.2023.10.09.07.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 07:38:21 -0700 (PDT)
Message-ID: <214b78ed-3842-5ba1-fa9c-9fa719fca129@redhat.com>
Date:   Mon, 9 Oct 2023 16:38:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
References: <20231009064230.2952396-1-surenb@google.com>
 <20231009064230.2952396-3-surenb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20231009064230.2952396-3-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 09.10.23 08:42, Suren Baghdasaryan wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
> 
> Implement the uABI of UFFDIO_MOVE ioctl.
> UFFDIO_COPY performs ~20% better than UFFDIO_MOVE when the application
> needs pages to be allocated [1]. However, with UFFDIO_MOVE, if pages are
> available (in userspace) for recycling, as is usually the case in heap
> compaction algorithms, then we can avoid the page allocation and memcpy
> (done by UFFDIO_COPY). Also, since the pages are recycled in the
> userspace, we avoid the need to release (via madvise) the pages back to
> the kernel [2].
> We see over 40% reduction (on a Google pixel 6 device) in the compacting
> thread’s completion time by using UFFDIO_MOVE vs. UFFDIO_COPY. This was
> measured using a benchmark that emulates a heap compaction implementation
> using userfaultfd (to allow concurrent accesses by application threads).
> More details of the usecase are explained in [2].
> Furthermore, UFFDIO_MOVE enables moving swapped-out pages without
> touching them within the same vma. Today, it can only be done by mremap,
> however it forces splitting the vma.
> 
> [1] https://lore.kernel.org/all/1425575884-2574-1-git-send-email-aarcange@redhat.com/
> [2] https://lore.kernel.org/linux-mm/CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com/
> 
> Update for the ioctl_userfaultfd(2)  manpage:
> 
>     UFFDIO_MOVE
>         (Since Linux xxx)  Move a continuous memory chunk into the
>         userfault registered range and optionally wake up the blocked
>         thread. The source and destination addresses and the number of
>         bytes to move are specified by the src, dst, and len fields of
>         the uffdio_move structure pointed to by argp:
> 
>             struct uffdio_move {
>                 __u64 dst;    /* Destination of move */
>                 __u64 src;    /* Source of move */
>                 __u64 len;    /* Number of bytes to move */
>                 __u64 mode;   /* Flags controlling behavior of move */
>                 __s64 move;   /* Number of bytes moved, or negated error */
>             };
> 
>         The following value may be bitwise ORed in mode to change the
>         behavior of the UFFDIO_MOVE operation:
> 
>         UFFDIO_MOVE_MODE_DONTWAKE
>                Do not wake up the thread that waits for page-fault
>                resolution
> 
>         UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES
>                Allow holes in the source virtual range that is being moved.
>                When not specified, the holes will result in ENOENT error.
>                When specified, the holes will be accounted as successfully
>                moved memory. This is mostly useful to move hugepage aligned
>                virtual regions without knowing if there are transparent
>                hugepages in the regions or not, but preventing the risk of
>                having to split the hugepage during the operation.
> 
>         The move field is used by the kernel to return the number of
>         bytes that was actually moved, or an error (a negated errno-
>         style value).  If the value returned in move doesn't match the
>         value that was specified in len, the operation fails with the
>         error EAGAIN.  The move field is output-only; it is not read by
>         the UFFDIO_MOVE operation.
> 
>         The operation may fail for various reasons. Usually, remapping of
>         pages that are not exclusive to the given process fail; once KSM
>         might deduplicate pages or fork() COW-shares pages during fork()
>         with child processes, they are no longer exclusive. Further, the
>         kernel might only perform lightweight checks for detecting whether
>         the pages are exclusive, and return -EBUSY in case that check fails.
>         To make the operation more likely to succeed, KSM should be
>         disabled, fork() should be avoided or MADV_DONTFORK should be
>         configured for the source VMA before fork().
> 
>         This ioctl(2) operation returns 0 on success.  In this case, the
>         entire area was moved.  On error, -1 is returned and errno is
>         set to indicate the error.  Possible errors include:
> 
>         EAGAIN The number of bytes moved (i.e., the value returned in
>                the move field) does not equal the value that was
>                specified in the len field.
> 
>         EINVAL Either dst or len was not a multiple of the system page
>                size, or the range specified by src and len or dst and len
>                was invalid.
> 
>         EINVAL An invalid bit was specified in the mode field.
> 
>         ENOENT
>                The source virtual memory range has unmapped holes and
>                UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES is not set.
> 
>         EEXIST
>                The destination virtual memory range is fully or partially
>                mapped.
> 
>         EBUSY
>                The pages in the source virtual memory range are not
>                exclusive to the process. The kernel might only perform
>                lightweight checks for detecting whether the pages are
>                exclusive. To make the operation more likely to succeed,
>                KSM should be disabled, fork() should be avoided or
>                MADV_DONTFORK should be configured for the source virtual
>                memory area before fork().
> 
>         ENOMEM Allocating memory needed for the operation failed.
> 
>         ESRCH
>                The faulting process has exited at the time of a
>                UFFDIO_MOVE operation.
> 

A general comment simply because I realized that just now: does anything 
speak against limiting the operations now to a single MM?

The use cases I heard so far don't need it. If ever required, we could 
consider extending it.

Let's reduce complexity and KIS unless really required.


Further: see "22) Do not crash the kernel" in coding-style.rst. All 
these BUG_ON need to go. Ideally, use WARN_ON_ONCE() or just VM_WARN_ON().

-- 
Cheers,

David / dhildenb

