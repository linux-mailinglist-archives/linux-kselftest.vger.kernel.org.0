Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC57B36BD31
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Apr 2021 04:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhD0CUp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Apr 2021 22:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhD0CUp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Apr 2021 22:20:45 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3163C061574
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Apr 2021 19:20:02 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id q4so14851359qtn.5
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Apr 2021 19:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Pnjy0987JUk+XLq8j9TrVexd3W3Gw7OXJFli75KyJ+4=;
        b=u64LXe7Cb+0e8JDoca4bg7GXvns1jVhNN/1lrHEK6AA0rHZtcLkcX3be1h7jskVl31
         fE25+77GZ9g/Dc4UE0PHM6PbWpyK94nJXiHFVI2S9vzugysoYgwhzfIbV0AqEOEQcd0u
         4+TlPstRSAiJQsm55Z6xOyzKXlcAFoB+1oztR/mueVwrjc0Oapr5vAmogWbYlqxSEqZU
         TO+bOlio/PqbIqWfzTi3jGzHbVkEpvdfVj+Khpyuk9J5Vl8o+xolrF3N3mQRdqfjhQe4
         wJvTUoTHPmjWaYTgeqHslGJuIT9SVI/R24WrDMy5psIDPMJ7Y6QncSSQKmkKOEn9ye9w
         wPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Pnjy0987JUk+XLq8j9TrVexd3W3Gw7OXJFli75KyJ+4=;
        b=V0tX7QMcgV7hsbRCL9XKUS3ugVCYsuxuCylzEMQyGPq7jNARAbZUjwJ2hm+Ht7ZHYa
         cf6zBrExucF6InY/0BsrWyZ1U5UBpFkxKumKWEo4uDrqU3uASXrL6/z53S1mkl4xwMP/
         xYts0ocxFxVAf1u+o/2vfx0+2UNhpr1aM9n1J1JcLjokdvexxfoEDaQvsZl8JhKrN+ck
         OS88TVcM870o+p1ZdJ9asTEVY9v/4ilrjJt+E991Cqk+aFm4lFWe51iv+A6G67BaZdOG
         Q9vPjZK+5uh5f9PHzXDLOvYWqhgv9mxiXxkCmg7fzU3l4VwiQqerNFT18aeHIJu1W4da
         VCXQ==
X-Gm-Message-State: AOAM532teGu99nHF4KqMcYKs5kOnKTRzv9DEIySDbrsC082rPoxqNM0a
        B0bm3115tkHZG/FcVmDHLhpGmw==
X-Google-Smtp-Source: ABdhPJxyAyKDzzCT+LoVorKFwJsNfqzw1n6Udw1ypZ16lcbMZ2s8WnBbaReftHIWcDVX8txvy6ZvyQ==
X-Received: by 2002:a05:622a:245:: with SMTP id c5mr10322745qtx.350.1619490001558;
        Mon, 26 Apr 2021 19:20:01 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 185sm1855770qko.99.2021.04.26.19.19.59
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 26 Apr 2021 19:20:01 -0700 (PDT)
Date:   Mon, 26 Apr 2021 19:19:58 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 03/10] userfaultfd/shmem: support UFFDIO_CONTINUE for
 shmem
In-Reply-To: <20210420220804.486803-4-axelrasmussen@google.com>
Message-ID: <alpine.LSU.2.11.2104261906390.2998@eggly.anvils>
References: <20210420220804.486803-1-axelrasmussen@google.com> <20210420220804.486803-4-axelrasmussen@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 20 Apr 2021, Axel Rasmussen wrote:

> With this change, userspace can resolve a minor fault within a
> shmem-backed area with a UFFDIO_CONTINUE ioctl. The semantics for this
> match those for hugetlbfs - we look up the existing page in the page
> cache, and install a PTE for it.
> 
> This commit introduces a new helper: mcopy_atomic_install_pte.
> 
> Why handle UFFDIO_CONTINUE for shmem in mm/userfaultfd.c, instead of in
> shmem.c? The existing userfault implementation only relies on shmem.c
> for VM_SHARED VMAs. However, minor fault handling / CONTINUE work just
> fine for !VM_SHARED VMAs as well. We'd prefer to handle CONTINUE for
> shmem in one place, regardless of shared/private (to reduce code
> duplication).
> 
> Why add a new mcopy_atomic_install_pte helper? A problem we have with
> continue is that shmem_mcopy_atomic_pte() and mcopy_atomic_pte() are
> *close* to what we want, but not exactly. We do want to setup the PTEs
> in a CONTINUE operation, but we don't want to e.g. allocate a new page,
> charge it (e.g. to the shmem inode), manipulate various flags, etc. Also
> we have the problem stated above: shmem_mcopy_atomic_pte() and
> mcopy_atomic_pte() both handle one-half of the problem (shared /
> private) continue cares about. So, introduce mcontinue_atomic_pte(), to
> handle all of the shmem continue cases. Introduce the helper so it
> doesn't duplicate code with mcopy_atomic_pte().
> 
> In a future commit, shmem_mcopy_atomic_pte() will also be modified to
> use this new helper. However, since this is a bigger refactor, it seems
> most clear to do it as a separate change.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

If this "03/10" had been numbered 04/10, I would have said
Acked-by: Hugh Dickins <hughd@google.com>

But I find this new ordering incomprehensible - I'm surprised that it
even builds this way around (if it does): this patch is so much about
what has been enabled in "04/10" (references to UFFDIO_CONTINUE shmem
VMAs etc).

Does Peter still think this way round is better? If he does, then we
shall have to compromise by asking you just to squash the two together.

> ---
>  mm/userfaultfd.c | 172 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 127 insertions(+), 45 deletions(-)
