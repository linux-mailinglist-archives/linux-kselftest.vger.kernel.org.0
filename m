Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF9A792831
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 18:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbjIEQHP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 12:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353570AbjIEGrh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 02:47:37 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD171B4;
        Mon,  4 Sep 2023 23:47:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so17633265e9.1;
        Mon, 04 Sep 2023 23:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693896452; x=1694501252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AsIlpZm/Q7WJcI9ZjnlyhKhWKNwVjgPwx9B6UP2Qye4=;
        b=p4UQEVyyLLID4qwRo0eACsleVjtxdbutGEUnaaaq8d506+s9czA1398BsxOSJFMgCp
         qiHDD2SBnw7m3JatvYmAudBB+hcD19rpqkUvkPuC7dA5dA9cL0Od57vKyimnXKBQHrgp
         tBnmpgyuZYc9T1CGO/ami4UCNPfG+IEk/EhihYh30SoYF2NedhGuJvcjL2N6oJ+YdOrR
         jWK6ZLMgZiq/glrchiJOUdH42m8lpo01njuQI18F3P8B0g9SGNXKiFONK7snWB/qcECM
         KB/lZV8Z4NPqrFSYHLQ+BEqmab7mB3OKW/t3TpxVCewhalb8T5atK+wBgSlmDkDX0twZ
         +sLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693896452; x=1694501252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsIlpZm/Q7WJcI9ZjnlyhKhWKNwVjgPwx9B6UP2Qye4=;
        b=AUMaEEPUElb/QWfH/FgNperOPVBdTpia/YxGFA59rKFE6wIgm24OPfkFdTeHGu2j6v
         M08R83SCbl4FVnEswvtU1IlSV8CIVYrOusQxD4qIMkgz3n43AAFUKJewiqJ+8+f5Hpu5
         uFB5QUFBdFrERXwVIrrBeyO1mYy0doFZsA6U7kyRkAXEvN9cv2xw0BgnnM+xlAIW/IaR
         dGjijHp97jyK/wHri/sbU8LqBu4JXTnj86dQv8OT0NZ//1r8e3GTdLAqIAL7K5M56znH
         jv/2BDSr9frOCsDrktj+XtZIF7h5kxMe3RaMj01ljr8rchSnVt512BHHdui5VgHwH/rL
         sUGA==
X-Gm-Message-State: AOJu0YyhWMSRU4e8zpj/hUmSP/8NByPyu3r4bVCBMVakvOl07JUNgdfX
        i50u9vHvhgQjuIVhvqXHJhg=
X-Google-Smtp-Source: AGHT+IGpONnR47VKjbPdCEkGwBQyJ0MB1IECKLwIQe4RgkuBECQNtizBE8jYG7Guj/7+91bWfg6FUg==
X-Received: by 2002:a5d:6451:0:b0:317:52ba:81f2 with SMTP id d17-20020a5d6451000000b0031752ba81f2mr11051958wrw.16.1693896452209;
        Mon, 04 Sep 2023 23:47:32 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id c20-20020a7bc854000000b003feef5b0bb7sm15846529wml.40.2023.09.04.23.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 23:47:31 -0700 (PDT)
Date:   Tue, 5 Sep 2023 07:47:30 +0100
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
Subject: Re: [PATCH v6 2/7] mm/mremap: Allow moves within the same VMA for
 stack moves
Message-ID: <a26f9ef0-5102-4e2b-928d-14307633dee3@lucifer.local>
References: <20230903151328.2981432-1-joel@joelfernandes.org>
 <20230903151328.2981432-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903151328.2981432-3-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Sep 03, 2023 at 03:13:23PM +0000, Joel Fernandes (Google) wrote:
> For the stack move happening in shift_arg_pages(), the move is happening
> within the same VMA which spans the old and new ranges.
>
> In case the aligned address happens to fall within that VMA, allow such
> moves and don't abort the mremap alignment optimization.
>
> In the regular non-stack mremap case, we cannot allow any such moves as
> will end up destroying some part of the mapping (either the source of
> the move, or part of the existing mapping). So just avoid it for stack
> moves.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  fs/exec.c          |  2 +-
>  include/linux/mm.h |  2 +-
>  mm/mremap.c        | 33 +++++++++++++++++++--------------
>  3 files changed, 21 insertions(+), 16 deletions(-)
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
>
>  /*
>   * Flags used by change_protection().  For now we make it a bitmap so
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 1011326b7b80..2b51f8b7cad8 100644
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
> @@ -504,9 +505,13 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
>  	 * of the corresponding VMA, we can't align down or we will destroy part
>  	 * of the current mapping.
>  	 */
> -	if (vma->vm_start != addr_to_align)
> +	if (!for_stack && vma->vm_start != addr_to_align)
>  		return false;
>
> +	/* In the stack case we explicitly permit in-VMA alignment. */
> +	if (for_stack && addr_masked >= vma->vm_start)
> +		return true;
> +
>  	/*
>  	 * Make sure the realignment doesn't cause the address to fall on an
>  	 * existing mapping.
> @@ -517,7 +522,7 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
>  /* Opportunistically realign to specified boundary for faster copy. */
>  static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma,
>  			     unsigned long *new_addr, struct vm_area_struct *new_vma,
> -			     unsigned long mask)
> +			     unsigned long mask, bool for_stack)
>  {
>  	/* Skip if the addresses are already aligned. */
>  	if ((*old_addr & ~mask) == 0)
> @@ -528,8 +533,8 @@ static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old
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
> @@ -539,7 +544,7 @@ static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old
>  unsigned long move_page_tables(struct vm_area_struct *vma,
>  		unsigned long old_addr, struct vm_area_struct *new_vma,
>  		unsigned long new_addr, unsigned long len,
> -		bool need_rmap_locks)
> +		bool need_rmap_locks, bool for_stack)
>  {
>  	unsigned long extent, old_end;
>  	struct mmu_notifier_range range;
> @@ -559,9 +564,9 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
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
> @@ -708,7 +713,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  	}
>
>  	moved_len = move_page_tables(vma, old_addr, new_vma, new_addr, old_len,
> -				     need_rmap_locks);
> +				     need_rmap_locks, false);
>  	if (moved_len < old_len) {
>  		err = -ENOMEM;
>  	} else if (vma->vm_ops && vma->vm_ops->mremap) {
> @@ -722,7 +727,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  		 * and then proceed to unmap new area instead of old.
>  		 */
>  		move_page_tables(new_vma, new_addr, vma, old_addr, moved_len,
> -				 true);
> +				 true, false);
>  		vma = new_vma;
>  		old_len = new_len;
>  		old_addr = new_addr;
> --
> 2.42.0.283.g2d96d420d3-goog
>

Looks good to me, thanks

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
