Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572DA789C93
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 11:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjH0JVz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 05:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjH0JVV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 05:21:21 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E014E1;
        Sun, 27 Aug 2023 02:21:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fef34c33d6so21952865e9.3;
        Sun, 27 Aug 2023 02:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693128077; x=1693732877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdi86NKSvxAhAAY/JTOY1oVYSbdavS4j5GkMSJME2Bk=;
        b=KUHE6OOJ53D47VuVOLuUcnayMJ1O4rnjTnP2ypPA/XptRh1YoSVB6xUMtnX4/etK1v
         Ir4SvaZWzo8yC/l5eoko02NeWsfsalSVqAGrifW8DbA8GYdM6hXOGO6zr+6YMGdqmBrs
         HVBIOKBtNRnW8urE/CQLeHd/EWe30vXng5ujvVVEBU//sXNcDD3CwOc43M7TnYKAiwk/
         IsqHtyhU5iEj2M40/ayoh2Bw2qeV6GvD1X2IVrHp85DtIxaCOdDkSXDiVRcWTMHP8zsf
         +jwRVRlH4lYJ1eQtdWIFrb0p+QUZMGKcFxQU185vzezwrvkceHHgYmtN7ZIHcGwlTavV
         uuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693128077; x=1693732877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdi86NKSvxAhAAY/JTOY1oVYSbdavS4j5GkMSJME2Bk=;
        b=Fzclu1aDR5sRGbyLgVwzr6mE9Iv0x5YGnalSiYXJdW5vZCJIdKEPKm47IEm5f4bZEI
         iBJC1f2lf6i9Lr4IHisRy4fJFQY5QuoCO6CS3INwuOXijFfknh2elmw+UUUyotpdSQhA
         VzDTSxcy1vF8i57uX5lsKQGZSYQieYu2WUIZnIE4Cigdv2s2sV0tMRCcgh4lC7QFIaQ7
         KmFVSBbFLVtF+4vDSuKRhITV1YXEGABdKBkTKWb68PSvIxFMPRMDGUjwifUJlbGattbK
         JkImaCTLYPJsVlVGz13c3djrZ9isxbLoMkYEAkZgFTlANLE8uFq4+Cb11U/SztcJwZwM
         xkTA==
X-Gm-Message-State: AOJu0YznmO4Q2vFGhazQlKg+CEed73yr6scBwyCfnRdl2QSBSymMPzUZ
        NgEukKqgRpst0riZR8lP6LY=
X-Google-Smtp-Source: AGHT+IFIBfHVzujAWrXltdbTmcIhslJaPuKAib/EtXs1THmZ5W8e+bbJMMy1vqIp1JIMrgMOQyEw2A==
X-Received: by 2002:a05:600c:2491:b0:3fc:92:73d6 with SMTP id 17-20020a05600c249100b003fc009273d6mr18390810wms.11.1693128076411;
        Sun, 27 Aug 2023 02:21:16 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fe29dc0ff2sm7376171wmc.21.2023.08.27.02.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 02:21:15 -0700 (PDT)
Date:   Sun, 27 Aug 2023 10:21:14 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: Re: [PATCH v5 2/7] mm/mremap: Allow moves within the same VMA
Message-ID: <46196ba1-c54d-4c1d-954f-a0006602af99@lucifer.local>
References: <20230822015501.791637-1-joel@joelfernandes.org>
 <20230822015501.791637-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822015501.791637-3-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 22, 2023 at 01:54:55AM +0000, Joel Fernandes (Google) wrote:
> For the stack move happening in shift_arg_pages(), the move is happening
> within the same VMA which spans the old and new ranges.
>
> In case the aligned address happens to fall within that VMA, allow such
> moves and don't abort the optimization.
>
> In the mremap case, we cannot allow any such moves as will end up
> destroying some part of the mapping (either the source of the move, or
> part of the existing mapping). So just avoid it for mremap.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  fs/exec.c          |  2 +-
>  include/linux/mm.h |  2 +-
>  mm/mremap.c        | 29 +++++++++++++++--------------
>  3 files changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 1a827d55ba94..244925307958 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -712,7 +712,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
>  	 * process cleanup to remove whatever mess we made.
>  	 */
>  	if (length != move_page_tables(vma, old_start,
> -				       vma, new_start, length, false))
> +				       vma, new_start, length, false, true))
>  		return -ENOMEM;
>
>  	lru_add_drain();
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 406ab9ea818f..e635d1fc73b6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2458,7 +2458,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen);
>  extern unsigned long move_page_tables(struct vm_area_struct *vma,
>  		unsigned long old_addr, struct vm_area_struct *new_vma,
>  		unsigned long new_addr, unsigned long len,
> -		bool need_rmap_locks);
> +		bool need_rmap_locks, bool for_stack);

It's a nit, but it'd be nice to not have 'mystery meat' booleans foo(bar, baz,
true, false, true); always ends up being a pain to track down.

However I think probably something better than that (flags or wrapper
functions) might be too much noise here so perhaps we can live with this!

>
>  /*
>   * Flags used by change_protection().  For now we make it a bitmap so
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 035fbf542a8f..06baa13bd2c8 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -490,12 +490,13 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
>  }
>
>  /*
> - * A helper to check if a previous mapping exists. Required for
> - * move_page_tables() and realign_addr() to determine if a previous mapping
> - * exists before we can do realignment optimizations.
> + * A helper to check if aligning down is OK. The aligned address should fall
> + * on *no mapping*. For the stack moving down, that's a special move within
> + * the VMA that is created to span the source and destination of the move,
> + * so we make an exception for it.
>   */
>  static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
> -			       unsigned long mask)
> +			    unsigned long mask, bool for_stack)
>  {
>  	unsigned long addr_masked = addr_to_align & mask;
>
> @@ -504,7 +505,7 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
>  	 * of the corresponding VMA, we can't align down or we will destroy part
>  	 * of the current mapping.
>  	 */
> -	if (vma->vm_start != addr_to_align)
> +	if (!for_stack && vma->vm_start != addr_to_align)
>  		return false;

I'm a little confused by this exception, is it very specifically for the
shift_arg_pages() case where can assume we are safe to just discard the
lower portion of the stack?

Wouldn't the find_vma_intersection() line below fail in this case? I may be
missing something here :)

>
>  	/*
> @@ -517,7 +518,7 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
>  /* Opportunistically realign to specified boundary for faster copy. */
>  static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma,
>  			     unsigned long *new_addr, struct vm_area_struct *new_vma,
> -			     unsigned long mask)
> +			     unsigned long mask, bool for_stack)
>  {
>  	/* Skip if the addresses are already aligned. */
>  	if ((*old_addr & ~mask) == 0)
> @@ -528,8 +529,8 @@ static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old
>  		return;
>
>  	/* Ensure realignment doesn't cause overlap with existing mappings. */
> -	if (!can_align_down(old_vma, *old_addr, mask) ||
> -	    !can_align_down(new_vma, *new_addr, mask))
> +	if (!can_align_down(old_vma, *old_addr, mask, for_stack) ||
> +	    !can_align_down(new_vma, *new_addr, mask, for_stack))
>  		return;
>
>  	*old_addr = *old_addr & mask;
> @@ -539,7 +540,7 @@ static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old
>  unsigned long move_page_tables(struct vm_area_struct *vma,
>  		unsigned long old_addr, struct vm_area_struct *new_vma,
>  		unsigned long new_addr, unsigned long len,
> -		bool need_rmap_locks)
> +		bool need_rmap_locks, bool for_stack)
>  {
>  	unsigned long extent, old_end;
>  	struct mmu_notifier_range range;
> @@ -559,9 +560,9 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  	 * If possible, realign addresses to PMD boundary for faster copy.
>  	 * Only realign if the mremap copying hits a PMD boundary.
>  	 */
> -	if ((vma != new_vma)
> -		&& (len >= PMD_SIZE - (old_addr & ~PMD_MASK)))
> -		try_realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK);
> +	if (len >= PMD_SIZE - (old_addr & ~PMD_MASK))
> +		try_realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK,
> +				 for_stack);
>
>  	flush_cache_range(vma, old_addr, old_end);
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,
> @@ -708,7 +709,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  	}
>
>  	moved_len = move_page_tables(vma, old_addr, new_vma, new_addr, old_len,
> -				     need_rmap_locks);
> +				     need_rmap_locks, false);
>  	if (moved_len < old_len) {
>  		err = -ENOMEM;
>  	} else if (vma->vm_ops && vma->vm_ops->mremap) {
> @@ -722,7 +723,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  		 * and then proceed to unmap new area instead of old.
>  		 */
>  		move_page_tables(new_vma, new_addr, vma, old_addr, moved_len,
> -				 true);
> +				 true, false);
>  		vma = new_vma;
>  		old_len = new_len;
>  		old_addr = new_addr;
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
