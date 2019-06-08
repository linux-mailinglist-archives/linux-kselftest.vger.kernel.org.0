Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD5439A77
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2019 05:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbfFHDwP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jun 2019 23:52:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42175 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730963AbfFHDwO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jun 2019 23:52:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so2217932pff.9
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2019 20:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+sAqEcYebSGTQqNUHJjZvXdBrlSAt8m9jXPFyYB00fA=;
        b=CtSxM/iJFdFOilMt5IYz49fhtrPJpe1biMjSLL9dNHxYjLjFZgiPdCXtt2Os7+WUWp
         2h97ew7Js16BFPaL91oYsoUi+i2fwl58zxZoJKC+5LpNlJocOwDirIXVuEvjdms0IvZ/
         xj006iO3/Sm/g4St20TSl0BbuhpEFIrb4EXp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+sAqEcYebSGTQqNUHJjZvXdBrlSAt8m9jXPFyYB00fA=;
        b=p85UmHw84Ljrbb0o68XGefIFmKDhqN+WWesYJP4njpMmH+oCxKDYGlBFQksTSY8m9W
         wfBmLFXEaLUtK8/eX73yhX6rArDPyBo0RRcqaUfw8HVh8Ad0nWT6Ne6/zns9YNdg2vNJ
         w6SF9CyaWTsdiFw0IWAdT62CyHfU6K/2A0VhBqTpJ7rj3JOfAZ+QK80JbaXqUg4iMTK/
         akKAIgHvlYdTqyjYXHvx3L5fvJFZjfQXi7THYCmqQ26QDCEUJt2MY7P5e5EDR+Ta4UAY
         gCNguDHy/29jxgoZPpOOfwcN35/bstuYUWPTsp/0jxZerKjRXT7QBj0A7HgbjtLxzh7a
         2IUg==
X-Gm-Message-State: APjAAAU7g4YjtlwTo69YSBStw0ZpXsRCzIE9JELYHZIJydvKIC54son3
        ZtGFGR1nZYuYqIacSH0rR2FkAA==
X-Google-Smtp-Source: APXvYqwaFwR9TdiH8fcP0E7/plCUQ2bJqcAs+FgbmWIC/6eFKnV6hJ+Yk3YTH/8Vcg8+zQmbsZgqwQ==
X-Received: by 2002:a17:90a:b104:: with SMTP id z4mr9232885pjq.102.1559965909964;
        Fri, 07 Jun 2019 20:51:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k13sm3360691pgq.45.2019.06.07.20.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 20:51:49 -0700 (PDT)
Date:   Fri, 7 Jun 2019 20:51:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v16 05/16] arm64: untag user pointers passed to memory
 syscalls
Message-ID: <201906072051.7B66635BE@keescook>
References: <cover.1559580831.git.andreyknvl@google.com>
 <045a94326401693e015bf80c444a4d946a5c68ed.1559580831.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <045a94326401693e015bf80c444a4d946a5c68ed.1559580831.git.andreyknvl@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 03, 2019 at 06:55:07PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
> 
> This patch allows tagged pointers to be passed to the following memory
> syscalls: get_mempolicy, madvise, mbind, mincore, mlock, mlock2, mprotect,
> mremap, msync, munlock.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  mm/madvise.c   | 2 ++
>  mm/mempolicy.c | 3 +++
>  mm/mincore.c   | 2 ++
>  mm/mlock.c     | 4 ++++
>  mm/mprotect.c  | 2 ++
>  mm/mremap.c    | 2 ++
>  mm/msync.c     | 2 ++
>  7 files changed, 17 insertions(+)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 628022e674a7..39b82f8a698f 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -810,6 +810,8 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
>  	size_t len;
>  	struct blk_plug plug;
>  
> +	start = untagged_addr(start);
> +
>  	if (!madvise_behavior_valid(behavior))
>  		return error;
>  
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 01600d80ae01..78e0a88b2680 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1360,6 +1360,7 @@ static long kernel_mbind(unsigned long start, unsigned long len,
>  	int err;
>  	unsigned short mode_flags;
>  
> +	start = untagged_addr(start);
>  	mode_flags = mode & MPOL_MODE_FLAGS;
>  	mode &= ~MPOL_MODE_FLAGS;
>  	if (mode >= MPOL_MAX)
> @@ -1517,6 +1518,8 @@ static int kernel_get_mempolicy(int __user *policy,
>  	int uninitialized_var(pval);
>  	nodemask_t nodes;
>  
> +	addr = untagged_addr(addr);
> +
>  	if (nmask != NULL && maxnode < nr_node_ids)
>  		return -EINVAL;
>  
> diff --git a/mm/mincore.c b/mm/mincore.c
> index c3f058bd0faf..64c322ed845c 100644
> --- a/mm/mincore.c
> +++ b/mm/mincore.c
> @@ -249,6 +249,8 @@ SYSCALL_DEFINE3(mincore, unsigned long, start, size_t, len,
>  	unsigned long pages;
>  	unsigned char *tmp;
>  
> +	start = untagged_addr(start);
> +
>  	/* Check the start address: needs to be page-aligned.. */
>  	if (start & ~PAGE_MASK)
>  		return -EINVAL;
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 080f3b36415b..e82609eaa428 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -674,6 +674,8 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
>  	unsigned long lock_limit;
>  	int error = -ENOMEM;
>  
> +	start = untagged_addr(start);
> +
>  	if (!can_do_mlock())
>  		return -EPERM;
>  
> @@ -735,6 +737,8 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
>  {
>  	int ret;
>  
> +	start = untagged_addr(start);
> +
>  	len = PAGE_ALIGN(len + (offset_in_page(start)));
>  	start &= PAGE_MASK;
>  
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index bf38dfbbb4b4..19f981b733bc 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -465,6 +465,8 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  	const bool rier = (current->personality & READ_IMPLIES_EXEC) &&
>  				(prot & PROT_READ);
>  
> +	start = untagged_addr(start);
> +
>  	prot &= ~(PROT_GROWSDOWN|PROT_GROWSUP);
>  	if (grows == (PROT_GROWSDOWN|PROT_GROWSUP)) /* can't be both */
>  		return -EINVAL;
> diff --git a/mm/mremap.c b/mm/mremap.c
> index fc241d23cd97..1d98281f7204 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -606,6 +606,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  	LIST_HEAD(uf_unmap_early);
>  	LIST_HEAD(uf_unmap);
>  
> +	addr = untagged_addr(addr);
> +
>  	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
>  		return ret;
>  
> diff --git a/mm/msync.c b/mm/msync.c
> index ef30a429623a..c3bd3e75f687 100644
> --- a/mm/msync.c
> +++ b/mm/msync.c
> @@ -37,6 +37,8 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, len, int, flags)
>  	int unmapped_error = 0;
>  	int error = -EINVAL;
>  
> +	start = untagged_addr(start);
> +
>  	if (flags & ~(MS_ASYNC | MS_INVALIDATE | MS_SYNC))
>  		goto out;
>  	if (offset_in_page(start))
> -- 
> 2.22.0.rc1.311.g5d7573a151-goog
> 

-- 
Kees Cook
