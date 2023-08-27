Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F24789C82
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 11:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjH0JJr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 05:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjH0JJ1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 05:09:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E63AD;
        Sun, 27 Aug 2023 02:09:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31771bb4869so1874443f8f.0;
        Sun, 27 Aug 2023 02:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693127363; x=1693732163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=16ej8jkORN/yBp8fsrqI74F8aM9OkYgp4bNE44thl6c=;
        b=KhP1ao4pEaZllbaspLNuEFMgLiO/UdJkkLpU9VfoIS1/kh+6JNqNZCNJgzWa6nD7Pj
         CUeBn93T5W5TrJrel93eDZsyD2Ldxr6Om8oOivwWOf1SyG39oFmaDa45OrYmUkq49FZA
         ytOaUztWS7UPw8MQHGP0mu/A4v7IpaFrmHMxJLRsGACIDgwlOZ40d0fQGNtWm48YI7Wr
         EGAhKRYLPNjvnsFCRj2wLUcsmERy0HvttPA6MbBTsyuzn2ovSPL+sdru/Qb47CyEP9uu
         /lWyA8aMGi6rPHBpkRJ/UZMKkwaCyQpbypf/oNsdQoq+4NK0kUGGdC7QAbYqqGkPY17g
         sBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693127363; x=1693732163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16ej8jkORN/yBp8fsrqI74F8aM9OkYgp4bNE44thl6c=;
        b=fmMNxoW8CLVuxC46bBdK6+3D0Ypv0FfTwbH+cTJfSZymmzu0tvysQ2KXjXCQU/+968
         KA4b559sRZjJa5+WYuf9jY+lvyW7OwPddCRd0sUPYtfInBSb/a3KuaGweNBuNDt+QRHE
         jjAuml9Qj5Utlykv7wAnN1djy53QlRadnxh8icKRm1mqWTYQGpwnp+z389oiHDZhVGJI
         aRzTMR4L+zzWhuL5Nw6E1srqVzsSqO9Lk8+vLjhRH3RdzaS8qxAxO1eYyp9iX6+mxtO3
         oH5V1t3k8+4spv4Uz+gijN3WDdBTPi+jxYCMjX9PvABOW+YJFqYXBdKSode2RKEAIsGV
         Qp6w==
X-Gm-Message-State: AOJu0YwUCDh9znYoAJqtFNhUPUUUqohvir98O/p/gm4anOMnI/JXm/Nt
        y0LRSFfIwxZzKx3EJKY2KSU=
X-Google-Smtp-Source: AGHT+IGyyr3fE4lf0fhmm1twBMt91R1BLix5VFAhhl/xU2ixqmahQiUz/yJRPPxlQ8vP38qmAwaiIg==
X-Received: by 2002:a5d:5222:0:b0:319:8ce0:4e52 with SMTP id i2-20020a5d5222000000b003198ce04e52mr17436110wra.67.1693127363271;
        Sun, 27 Aug 2023 02:09:23 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d4e8d000000b0031753073abcsm7107192wru.36.2023.08.27.02.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 02:09:22 -0700 (PDT)
Date:   Sun, 27 Aug 2023 10:09:21 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: Re: [PATCH v5 1/7] mm/mremap: Optimize the start addresses in
 move_page_tables()
Message-ID: <58e63c5e-e043-4651-bf6d-9fc52f78cce6@lucifer.local>
References: <20230822015501.791637-1-joel@joelfernandes.org>
 <20230822015501.791637-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822015501.791637-2-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 22, 2023 at 01:54:54AM +0000, Joel Fernandes (Google) wrote:
> Recently, we see reports [1] of a warning that triggers due to
> move_page_tables() doing a downward and overlapping move on a
> mutually-aligned offset within a PMD. By mutual alignment, I
> mean the source and destination addresses of the mremap are at
> the same offset within a PMD.
>
> This mutual alignment along with the fact that the move is downward is
> sufficient to cause a warning related to having an allocated PMD that
> does not have PTEs in it.
>
> This warning will only trigger when there is mutual alignment in the
> move operation. A solution, as suggested by Linus Torvalds [2], is to
> initiate the copy process at the PMD level whenever such alignment is
> present. Implementing this approach will not only prevent the warning
> from being triggered, but it will also optimize the operation as this
> method should enhance the speed of the copy process whenever there's a
> possibility to start copying at the PMD level.
>
> Some more points:
> a. The optimization can be done only when both the source and
> destination of the mremap do not have anything mapped below it up to a
> PMD boundary. I add support to detect that.
>
> b. #1 is not a problem for the call to move_page_tables() from exec.c as
> nothing is expected to be mapped below the source. However, for
> non-overlapping mutually aligned moves as triggered by mremap(2), I
> added support for checking such cases.
>
> c. I currently only optimize for PMD moves, in the future I/we can build
> on this work and do PUD moves as well if there is a need for this. But I
> want to take it one step at a time.
>
> d. We need to be careful about mremap of ranges within the VMA itself.
> For this purpose, I added checks to determine if the address after
> alignment falls within its VMA itself.
>
> [1] https://lore.kernel.org/all/ZB2GTBD%2FLWTrkOiO@dhcp22.suse.cz/
> [2] https://lore.kernel.org/all/CAHk-=whd7msp8reJPfeGNyt0LiySMT0egExx3TVZSX3Ok6X=9g@mail.gmail.com/
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  mm/mremap.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 11e06e4ab33b..035fbf542a8f 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -489,6 +489,53 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
>  	return moved;
>  }
>
> +/*
> + * A helper to check if a previous mapping exists. Required for
> + * move_page_tables() and realign_addr() to determine if a previous mapping
> + * exists before we can do realignment optimizations.
> + */
> +static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
> +			       unsigned long mask)
> +{
> +	unsigned long addr_masked = addr_to_align & mask;
> +
> +	/*
> +	 * If @addr_to_align of either source or destination is not the beginning
> +	 * of the corresponding VMA, we can't align down or we will destroy part
> +	 * of the current mapping.
> +	 */
> +	if (vma->vm_start != addr_to_align)
> +		return false;
> +
> +	/*
> +	 * Make sure the realignment doesn't cause the address to fall on an
> +	 * existing mapping.
> +	 */
> +	return find_vma_intersection(vma->vm_mm, addr_masked, addr_to_align) == NULL;
> +}
> +
> +/* Opportunistically realign to specified boundary for faster copy. */
> +static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma,
> +			     unsigned long *new_addr, struct vm_area_struct *new_vma,
> +			     unsigned long mask)
> +{
> +	/* Skip if the addresses are already aligned. */
> +	if ((*old_addr & ~mask) == 0)
> +		return;
> +
> +	/* Only realign if the new and old addresses are mutually aligned. */
> +	if ((*old_addr & ~mask) != (*new_addr & ~mask))
> +		return;
> +
> +	/* Ensure realignment doesn't cause overlap with existing mappings. */
> +	if (!can_align_down(old_vma, *old_addr, mask) ||
> +	    !can_align_down(new_vma, *new_addr, mask))
> +		return;
> +
> +	*old_addr = *old_addr & mask;
> +	*new_addr = *new_addr & mask;
> +}
> +
>  unsigned long move_page_tables(struct vm_area_struct *vma,
>  		unsigned long old_addr, struct vm_area_struct *new_vma,
>  		unsigned long new_addr, unsigned long len,
> @@ -508,6 +555,14 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  		return move_hugetlb_page_tables(vma, new_vma, old_addr,
>  						new_addr, len);
>
> +	/*
> +	 * If possible, realign addresses to PMD boundary for faster copy.
> +	 * Only realign if the mremap copying hits a PMD boundary.
> +	 */
> +	if ((vma != new_vma)
> +		&& (len >= PMD_SIZE - (old_addr & ~PMD_MASK)))
> +		try_realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK);
> +
>  	flush_cache_range(vma, old_addr, old_end);
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,
>  				old_addr, old_end);
> @@ -577,6 +632,13 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>
>  	mmu_notifier_invalidate_range_end(&range);
>
> +	/*
> +	 * Prevent negative return values when {old,new}_addr was realigned
> +	 * but we broke out of the above loop for the first PMD itself.
> +	 */
> +	if (len + old_addr < old_end)
> +		return 0;
> +
>  	return len + old_addr - old_end;	/* how much done */
>  }
>
> --
> 2.42.0.rc1.204.g551eb34607-goog
>

Looks good to me! Thanks for the changes :)

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
