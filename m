Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 406D342947
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 16:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfFLObz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 10:31:55 -0400
Received: from foss.arm.com ([217.140.110.172]:54464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfFLOby (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 10:31:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B72F12B;
        Wed, 12 Jun 2019 07:31:53 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71EB73F557;
        Wed, 12 Jun 2019 07:31:48 -0700 (PDT)
Subject: Re: [PATCH v17 04/15] mm, arm64: untag user pointers passed to memory
 syscalls
To:     Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
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
References: <cover.1560339705.git.andreyknvl@google.com>
 <f9b50767d639b7116aa986dc67f158131b8d4169.1560339705.git.andreyknvl@google.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <d69117fc-84e2-9be0-2686-32cdb88e9a05@arm.com>
Date:   Wed, 12 Jun 2019 15:31:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f9b50767d639b7116aa986dc67f158131b8d4169.1560339705.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/06/2019 12:43, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
> 
> This patch allows tagged pointers to be passed to the following memory
> syscalls: get_mempolicy, madvise, mbind, mincore, mlock, mlock2, mprotect,
> mremap, msync, munlock, move_pages.
> 
> The mmap and mremap syscalls do not currently accept tagged addresses.
> Architectures may interpret the tag as a background colour for the
> corresponding vma.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  mm/madvise.c   | 2 ++
>  mm/mempolicy.c | 3 +++
>  mm/migrate.c   | 2 +-
>  mm/mincore.c   | 2 ++
>  mm/mlock.c     | 4 ++++
>  mm/mprotect.c  | 2 ++
>  mm/mremap.c    | 7 +++++++
>  mm/msync.c     | 2 ++
>  8 files changed, 23 insertions(+), 1 deletion(-)
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
> diff --git a/mm/migrate.c b/mm/migrate.c
> index f2ecc2855a12..d22c45cf36b2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1616,7 +1616,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  			goto out_flush;
>  		if (get_user(node, nodes + i))
>  			goto out_flush;
> -		addr = (unsigned long)p;
> +		addr = (unsigned long)untagged_addr(p);
>  
>  		err = -ENODEV;
>  		if (node < 0 || node >= MAX_NUMNODES)
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
> index fc241d23cd97..64c9a3b8be0a 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -606,6 +606,13 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  	LIST_HEAD(uf_unmap_early);
>  	LIST_HEAD(uf_unmap);
>  
> +	/*
> +	 * Architectures may interpret the tag passed to mmap as a background
> +	 * colour for the corresponding vma. For mremap we don't allow tagged
> +	 * new_addr to preserve similar behaviour to mmap.
> +	 */
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
> 

-- 
Regards,
Vincenzo
