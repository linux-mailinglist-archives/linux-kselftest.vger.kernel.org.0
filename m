Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEDB56FC4
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2019 19:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfFZRpH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jun 2019 13:45:07 -0400
Received: from foss.arm.com ([217.140.110.172]:38020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfFZRpH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jun 2019 13:45:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8098A360;
        Wed, 26 Jun 2019 10:45:06 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FA693F718;
        Wed, 26 Jun 2019 10:45:05 -0700 (PDT)
Date:   Wed, 26 Jun 2019 18:45:03 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        vincenzo.frascino@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC] arm64: Detecting tagged addresses
Message-ID: <20190626174502.GH29672@arrakis.emea.arm.com>
References: <20190619121619.GV20984@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619121619.GV20984@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Andrew,

Cc'ing Luc (sparse maintainer) who's been involved in the past
discussions around static checking of user pointers:

https://lore.kernel.org/linux-arm-kernel/20180905190316.a34yycthgbamx2t3@ltop.local/

So I think the difference here from the previous approach is that we
explicitly mark functions that cannot take tagged addresses (like
find_vma()) and identify the callers.

More comments below:

On Wed, Jun 19, 2019 at 01:16:20PM +0100, Andrew Murray wrote:
> The proposed introduction of a relaxed ARM64 ABI [1] will allow tagged memory
> addresses to be passed through the user-kernel syscall ABI boundary. Tagged
> memory addresses are those which contain a non-zero top byte (the hardware
> has always ignored this top byte due to TCR_EL1.TBI0) and may be useful
> for features such as HWASan.
> 
> To permit this relaxation a proposed patchset [2] strips the top byte (tag)
> from user provided memory addresses prior to use in kernel functions which
> require untagged addresses (for example comparasion/arithmetic of addresses).
> The author of this patchset relied on a variety of techniques [2] (such as
> grep, BUG_ON, sparse etc) to identify as many instances of possible where
> tags need to be stipped.
> 
> To support this effort and to catch future regressions (e.g. in new syscalls
> or ioctls), I've devised an additional approach for detecting the use of
> tagged addresses in functions that do not want them. This approach makes
> use of Smatch [3] and is outlined in this RFC. Due to the ability of Smatch
> to do flow analysis I believe we can annotate the kernel in fewer places
> than a similar approach in sparse.
> 
> I'm keen for feedback on the likely usefulness of this approach.
> 
> We first add some new annotations that are exclusively consumed by Smatch:
> 
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -19,6 +19,7 @@
>  # define __cond_lock(x,c)      ((c) ? ({ __acquire(x); 1; }) : 0)
>  # define __percpu      __attribute__((noderef, address_space(3)))
>  # define __rcu         __attribute__((noderef, address_space(4)))
> +# define __untagged    __attribute__((address_space(5)))
>  # define __private     __attribute__((noderef))
>  extern void __chk_user_ptr(const volatile void __user *);
>  extern void __chk_io_ptr(const volatile void __iomem *);
[...]
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2224,7 +2224,7 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>  EXPORT_SYMBOL(get_unmapped_area);
>  
>  /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
> -struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
> +struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long __untagged addr)
>  {
>         struct rb_node *rb_node;
>         struct vm_area_struct *vma;
[...]
> This can be further improved - the problem here is that for a given function,
> e.g. find_vma we look for callers where *any* of the parameters
> passed to find_vma are tagged addresses from userspace - i.e. not *just*
> the annotated parameter. This is also true for find_vma's callers' callers'.
> This results in the call tree having false positives.
> 
> It *is* possible to track parameters (e.g. find_vma arg 1 comes from arg 3 of
> do_pages_stat_array etc), but this is limited as if functions modify the
> data then the tracking is stopped (however this can be fixed).
[...]
> An example of a false positve is do_mlock. We untag the address and pass that
> to apply_vma_lock_flags - however we also pass a length - because the length
> came from userspace and could have the top bits set - it's flagged. However
> with improved parameter tracking we can remove this false positive and similar.

Could we track only the conversions from __user * that eventually end up
as __untagged? (I'm not familiar with smatch, so not sure what it can
do). We could assume that an unsigned long argument to a syscall is
default __untagged, unless explicitly marked as __tagged. For example,
sys_munmap() is allowed to take a tagged address.

> Prior to smatch I attempted a similar approach with sparse - however it seemed
> necessary to propogate the __untagged annotation in every function up the call tree,
> and resulted in adding the __untagged annotation to functions that would never
> get near user provided data. This leads to a littering of __untagged all over the
> kernel which doesn't seem appealing.

Indeed. We attempted this last year (see the above thread).

> Smatch is more capable, however it almost
> certainly won't pick up 100% of issues due to the difficulity of making flow
> analysis understand everything a compiler can.
> 
> Is it likely to be acceptable to use the __untagged annotation in user-path
> functions that require untagged addresses across the kernel?

If it helps with identifying missing untagged_addr() calls, I would say
yes (as long as we keep them to a minimum).

> [1] https://lkml.org/lkml/2019/6/13/534
> [2] https://patchwork.kernel.org/cover/10989517/
> [3] http://smatch.sourceforge.net/

-- 
Catalin
