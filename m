Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6737C77AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 22:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343834AbjJLUME (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 16:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343828AbjJLUMD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 16:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B482BB
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Oct 2023 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697141475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Em5EkWmjEsngnt7dHkCr2mWPqoW9Gs15U305nbGgAN0=;
        b=YaJJnzGpa6Esa9+aizLqLNLb4XB0BdNyrOHGmG0HsMp2sX/xZNE7sYkp7mWNucciDvpJKp
        nNmr3PSEkt8BvDXWbUNxb3m5ELQiivwTdGAG1zbEREVrF/aUSCvg+zQn1ozKhUm0xRALDN
        oB3UuPXSSp0QbOQjWYx2hDFsG1Fbs4A=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-SVI3f1krMOucGvjNGrCXAg-1; Thu, 12 Oct 2023 16:11:13 -0400
X-MC-Unique: SVI3f1krMOucGvjNGrCXAg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7742bd869e4so22755085a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Oct 2023 13:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697141473; x=1697746273;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Em5EkWmjEsngnt7dHkCr2mWPqoW9Gs15U305nbGgAN0=;
        b=un6V3Y/N7EhnOLzeY/F3o/Bk9wXI8djufT/gEaOBTIh7DP0dVh2xUgL8M+AnGYs5D2
         xUixXyMHoHfEcyqsnvcknVjgwGJ5o1Esf+jlaeUaY4i9ykM7TCXsj7KaLZk84SQa8w3l
         VSyr1rog3gs9rQPUCpqu82RT2yQ9xfUB/de5wVM7vaNmYx15cs18Gr8mXi+RXz+jvlfj
         M1FKyrqLUJm6h0VTZ/kMZyZym6OVZ3UQ4F7bulECYsY7yPzUlNmOkzTP3SlSylLurX+7
         KaeflFAiPxRkn4DyaQf0IdJ4vGH7H6jDx/ii08ayk30X/2sgG10KMBdRZz8nKAtY8nKs
         PNXA==
X-Gm-Message-State: AOJu0Ywudj+lSvFtjFRl/37dm14k+N/ljlCfIZhZafz44htEWMwqj+pD
        ocw3hqG6+lafgQD+ZB0dBuorMSaP7cfj7iRtDa6+oJl/aHx4NO/OqrOByxISx/ADAq5Ddxs3iBJ
        aCHBUpucco9ibXo98ocjgdTqfyfc0
X-Received: by 2002:a05:620a:2915:b0:775:7520:5214 with SMTP id m21-20020a05620a291500b0077575205214mr28705703qkp.0.1697141473169;
        Thu, 12 Oct 2023 13:11:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrTzFhd634tYhp+FNrxPrpihtMkRR6O+7rzeEXn7vy0t6q0EEePDs0hzOnDb3mMY91toGulA==
X-Received: by 2002:a05:620a:2915:b0:775:7520:5214 with SMTP id m21-20020a05620a291500b0077575205214mr28705671qkp.0.1697141472802;
        Thu, 12 Oct 2023 13:11:12 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id 5-20020a05620a06c500b0076dacd14484sm54961qky.83.2023.10.12.13.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:11:12 -0700 (PDT)
Date:   Thu, 12 Oct 2023 16:11:09 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Message-ID: <ZShS3UT+cjJFmtEy@x1n>
References: <20231009064230.2952396-1-surenb@google.com>
 <20231009064230.2952396-3-surenb@google.com>
 <214b78ed-3842-5ba1-fa9c-9fa719fca129@redhat.com>
 <CAJuCfpHzSm+z9b6uxyYFeqr5b5=6LehE9O0g192DZdJnZqmQEw@mail.gmail.com>
 <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com>
 <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 09, 2023 at 05:29:08PM +0100, Lokesh Gidra wrote:
> On Mon, Oct 9, 2023 at 5:24 PM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 09.10.23 18:21, Suren Baghdasaryan wrote:
> > > On Mon, Oct 9, 2023 at 7:38 AM David Hildenbrand <david@redhat.com> wrote:
> > >>
> > >> On 09.10.23 08:42, Suren Baghdasaryan wrote:
> > >>> From: Andrea Arcangeli <aarcange@redhat.com>
> > >>>
> > >>> Implement the uABI of UFFDIO_MOVE ioctl.
> > >>> UFFDIO_COPY performs ~20% better than UFFDIO_MOVE when the application
> > >>> needs pages to be allocated [1]. However, with UFFDIO_MOVE, if pages are
> > >>> available (in userspace) for recycling, as is usually the case in heap
> > >>> compaction algorithms, then we can avoid the page allocation and memcpy
> > >>> (done by UFFDIO_COPY). Also, since the pages are recycled in the
> > >>> userspace, we avoid the need to release (via madvise) the pages back to
> > >>> the kernel [2].
> > >>> We see over 40% reduction (on a Google pixel 6 device) in the compacting
> > >>> thread’s completion time by using UFFDIO_MOVE vs. UFFDIO_COPY. This was
> > >>> measured using a benchmark that emulates a heap compaction implementation
> > >>> using userfaultfd (to allow concurrent accesses by application threads).
> > >>> More details of the usecase are explained in [2].
> > >>> Furthermore, UFFDIO_MOVE enables moving swapped-out pages without
> > >>> touching them within the same vma. Today, it can only be done by mremap,
> > >>> however it forces splitting the vma.
> > >>>
> > >>> [1] https://lore.kernel.org/all/1425575884-2574-1-git-send-email-aarcange@redhat.com/
> > >>> [2] https://lore.kernel.org/linux-mm/CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com/
> > >>>
> > >>> Update for the ioctl_userfaultfd(2)  manpage:
> > >>>
> > >>>      UFFDIO_MOVE
> > >>>          (Since Linux xxx)  Move a continuous memory chunk into the
> > >>>          userfault registered range and optionally wake up the blocked
> > >>>          thread. The source and destination addresses and the number of
> > >>>          bytes to move are specified by the src, dst, and len fields of
> > >>>          the uffdio_move structure pointed to by argp:
> > >>>
> > >>>              struct uffdio_move {
> > >>>                  __u64 dst;    /* Destination of move */
> > >>>                  __u64 src;    /* Source of move */
> > >>>                  __u64 len;    /* Number of bytes to move */
> > >>>                  __u64 mode;   /* Flags controlling behavior of move */
> > >>>                  __s64 move;   /* Number of bytes moved, or negated error */
> > >>>              };
> > >>>
> > >>>          The following value may be bitwise ORed in mode to change the
> > >>>          behavior of the UFFDIO_MOVE operation:
> > >>>
> > >>>          UFFDIO_MOVE_MODE_DONTWAKE
> > >>>                 Do not wake up the thread that waits for page-fault
> > >>>                 resolution
> > >>>
> > >>>          UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES
> > >>>                 Allow holes in the source virtual range that is being moved.
> > >>>                 When not specified, the holes will result in ENOENT error.
> > >>>                 When specified, the holes will be accounted as successfully
> > >>>                 moved memory. This is mostly useful to move hugepage aligned
> > >>>                 virtual regions without knowing if there are transparent
> > >>>                 hugepages in the regions or not, but preventing the risk of
> > >>>                 having to split the hugepage during the operation.
> > >>>
> > >>>          The move field is used by the kernel to return the number of
> > >>>          bytes that was actually moved, or an error (a negated errno-
> > >>>          style value).  If the value returned in move doesn't match the
> > >>>          value that was specified in len, the operation fails with the
> > >>>          error EAGAIN.  The move field is output-only; it is not read by
> > >>>          the UFFDIO_MOVE operation.
> > >>>
> > >>>          The operation may fail for various reasons. Usually, remapping of
> > >>>          pages that are not exclusive to the given process fail; once KSM
> > >>>          might deduplicate pages or fork() COW-shares pages during fork()
> > >>>          with child processes, they are no longer exclusive. Further, the
> > >>>          kernel might only perform lightweight checks for detecting whether
> > >>>          the pages are exclusive, and return -EBUSY in case that check fails.
> > >>>          To make the operation more likely to succeed, KSM should be
> > >>>          disabled, fork() should be avoided or MADV_DONTFORK should be
> > >>>          configured for the source VMA before fork().
> > >>>
> > >>>          This ioctl(2) operation returns 0 on success.  In this case, the
> > >>>          entire area was moved.  On error, -1 is returned and errno is
> > >>>          set to indicate the error.  Possible errors include:
> > >>>
> > >>>          EAGAIN The number of bytes moved (i.e., the value returned in
> > >>>                 the move field) does not equal the value that was
> > >>>                 specified in the len field.
> > >>>
> > >>>          EINVAL Either dst or len was not a multiple of the system page
> > >>>                 size, or the range specified by src and len or dst and len
> > >>>                 was invalid.
> > >>>
> > >>>          EINVAL An invalid bit was specified in the mode field.
> > >>>
> > >>>          ENOENT
> > >>>                 The source virtual memory range has unmapped holes and
> > >>>                 UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES is not set.
> > >>>
> > >>>          EEXIST
> > >>>                 The destination virtual memory range is fully or partially
> > >>>                 mapped.
> > >>>
> > >>>          EBUSY
> > >>>                 The pages in the source virtual memory range are not
> > >>>                 exclusive to the process. The kernel might only perform
> > >>>                 lightweight checks for detecting whether the pages are
> > >>>                 exclusive. To make the operation more likely to succeed,
> > >>>                 KSM should be disabled, fork() should be avoided or
> > >>>                 MADV_DONTFORK should be configured for the source virtual
> > >>>                 memory area before fork().
> > >>>
> > >>>          ENOMEM Allocating memory needed for the operation failed.
> > >>>
> > >>>          ESRCH
> > >>>                 The faulting process has exited at the time of a
> > >>>                 UFFDIO_MOVE operation.
> > >>>
> > >>
> > >> A general comment simply because I realized that just now: does anything
> > >> speak against limiting the operations now to a single MM?
> > >>
> > >> The use cases I heard so far don't need it. If ever required, we could
> > >> consider extending it.
> > >>
> > >> Let's reduce complexity and KIS unless really required.
> > >
> > > Let me check if there are use cases that require moves between MMs.
> > > Andrea seems to have put considerable effort to make it work between
> > > MMs and it would be a pity to lose that. I can send a follow-up patch
> > > to recover that functionality and even if it does not get merged, it
> > > can be used in the future as a reference. But first let me check if we
> > > can drop it.
> 
> For the compaction use case that we have it's fine to limit it to
> single MM. However, for general use I think Peter will have a better
> idea.

I used to have the same thought with David on whether we can simplify the
design to e.g. limit it to single mm.  Then I found that the trickiest is
actually patch 1 together with the anon_vma manipulations, and the problem
is that's not avoidable even if we restrict the api to apply on single mm.

What else we can benefit from single mm?  One less mmap read lock, but
probably that's all we can get; IIUC we need to keep most of the rest of
the code, e.g. pgtable walks, double pgtable lockings, etc.

Actually, even though I have no solid clue, but I had a feeling that there
can be some interesting way to leverage this across-mm movement, while
keeping things all safe (by e.g. elaborately requiring other proc to create
uffd and deliver to this proc).

Considering Andrea's original version already contains those bits and all
above, I'd vote that we go ahead with supporting two MMs.

Thanks,

-- 
Peter Xu

