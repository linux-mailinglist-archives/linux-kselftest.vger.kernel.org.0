Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FDE734462
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jun 2023 00:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjFQWtI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Jun 2023 18:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjFQWtH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Jun 2023 18:49:07 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2F510CF;
        Sat, 17 Jun 2023 15:49:05 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so2681244e87.2;
        Sat, 17 Jun 2023 15:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687042143; x=1689634143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xv7EgGhL36l2E3gdf0tc0pHjyAPM7mI/kMuNzs8yeVk=;
        b=T0Bx7HAtoNsb2RhxIprcNzY1AvNE/10TP8/AueXP0lBoMkn0MwG3tziLqbd0/4hssg
         QZ27eLLDbQcIEYWNJjQnadOUMFHV+BPja3BOxMiI0tnGADs6WSG2enKHdrP1Uv1NcPcv
         4dd5SPP0NG0R3S+YVFfllCQDwzn+eU4gwa00h/IO6JPEfh7StPGYZILbHvlPZh7IlSvk
         fJVnlmkVxefUszY1C7aeYGac8HTDeUELrcI2ioAfee9sIa1fp6Vkt8B1+1fo4RFhmKs6
         vAmK7Bhgp24LKjlO0bJt0oQItInBB6Vz7LDcNAv3V7z0XnAU5eCpRbSvuSXkahg5Y60f
         4rNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687042143; x=1689634143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xv7EgGhL36l2E3gdf0tc0pHjyAPM7mI/kMuNzs8yeVk=;
        b=ITKeBo2B0buDICnZyDAAbrKjkv/fMH1hlcxkNoE0c2dbrSijWOa1xfAObpJBidiGcc
         M8Kvs9O+Qi4duCgHVD4oeTaWrBfnuQ7WZSkD0D6E6Cs899fZ1ameUst+ZMV0a9TQ3845
         SL9KqpbTtsIC/hmOLh/hptNYv2zYYWFs/jeI32Xola7FFJ8SGRHcqMfFUW78OYWKDFJS
         fx960mGUZ26gBHQc8vzNiD6mTXJDcJ9BmF4DFjPVqEvnUpfODIvuGDse0aexlQXB0Bw9
         2LAWxQ5F5V6a6fMKnWoKJ1n6EmHRHry4FLPykQ87M1l4bdx0mJW5WmYmbHjLM+lqeoTs
         LHWw==
X-Gm-Message-State: AC+VfDwta/KULj734fjulAYx0teWlLtR+koXRwsTPxK6TKVCZeINtaQs
        v2jOXO/+JDYZVvb/sTfqbCo=
X-Google-Smtp-Source: ACHHUZ6CJUCD5yVPS+FecHR2u+OUus/P3dyrT5K3iQqnI0oC46YgND/NIJt3MWsebEnKIKKKZCU1KQ==
X-Received: by 2002:a19:ca52:0:b0:4f7:68eb:7c27 with SMTP id h18-20020a19ca52000000b004f768eb7c27mr2865189lfj.29.1687042143106;
        Sat, 17 Jun 2023 15:49:03 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id l15-20020a7bc44f000000b003f90846d8a7sm2090784wmi.6.2023.06.17.15.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 15:49:02 -0700 (PDT)
Date:   Sat, 17 Jun 2023 23:49:01 +0100
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
        Lokesh Gidra <lokeshgidra@google.com>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Subject: Re: [PATCH v4 1/7] mm/mremap: Optimize the start addresses in
 move_page_tables()
Message-ID: <f2f751ca-217e-4177-bb7f-1c9cd71e103e@lucifer.local>
References: <20230531220807.2048037-1-joel@joelfernandes.org>
 <20230531220807.2048037-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531220807.2048037-2-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 31, 2023 at 10:08:01PM +0000, Joel Fernandes (Google) wrote:
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
> b. #a is not a problem for the call to move_page_tables() from exec.c as
> nothing is expected to be mapped below the source. However, for
> non-overlapping mutually aligned moves as triggered by mremap(2), I
> added support for checking such cases.
>
> c. I currently only optimize for PMD moves, in the future I/we can build
> on this work and do PUD moves as well if there is a need for this. But I
> want to take it one step at a time.
>
> d. We need to be careful about mremap of ranges within the VMA itself.
> For this purpose, I added checks to determine if the address to align
> is not the beginning of the VMA which that address corresponds to.
>
> [1] https://lore.kernel.org/all/ZB2GTBD%2FLWTrkOiO@dhcp22.suse.cz/
> [2] https://lore.kernel.org/all/CAHk-=whd7msp8reJPfeGNyt0LiySMT0egExx3TVZSX3Ok6X=9g@mail.gmail.com/
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  mm/mremap.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 411a85682b58..bf355e4d6bd4 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -478,6 +478,51 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
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
> +	struct vm_area_struct *prev = NULL, *cur = NULL;
> +
> +	/*
> +	 * If @addr_to_align of either source or destination is not the beginning
> +	 * of the corresponding VMA, we can't align down or we will destroy part
> +	 * of the current mapping.
> +	 */
> +	if (vma->vm_start != addr_to_align)
> +		return false;

See below, I think we can eliminate this check.

> +
> +	/*
> +	 * Find the VMA before @vma to see if it subsumes the masked address.
> +	 * The mmap write lock is held here so the lookup is safe.
> +	 */
> +	cur = find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
> +	if (WARN_ON_ONCE(cur != vma))
> +		return false;
> +
> +	return !prev || prev->vm_end <= addr_masked;

This is a bit clunky, and I don't think we need the WARN_ON_ONCE() check if
we're under the mmap_lock.

How about something like:-

return find_vma_intersection(vma->mm, addr_masked, vma->vm_start) == NULL;

Which explicitly asserts that the range in [addr_masked, vma->vm_start) is
empty.

But actually, we should be able to go further and replace the previous
check with:-

return find_vma_intersection(vma->mm, addr_masked, addr_to_align) == NULL;

Which will fail if addr_to_align is offset within the VMA.

> +}
> +
> +/* Opportunistically realign to specified boundary for faster copy. */
> +static void realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma,

Something of a nit, but this isn't _always_ realigning the address, so perhaps
something like maybe_realign_addr() or try_realign_addr() is better?

This is probably debatable, as the comment already explains it is opportunistic
:)

> +			 unsigned long *new_addr, struct vm_area_struct *new_vma,
> +			 unsigned long mask)
> +{
> +	bool mutually_aligned = (*old_addr & ~mask) == (*new_addr & ~mask);
> +
> +	if ((*old_addr & ~mask) && mutually_aligned

I may be misunderstanding something here, but doesn't the first condition
here disallow for offset into PMD == 0? Why?

> +	    && can_align_down(old_vma, *old_addr, mask)
> +	    && can_align_down(new_vma, *new_addr, mask)) {
> +		*old_addr = *old_addr & mask;
> +		*new_addr = *new_addr & mask;
> +	}
> +}
> +
>  unsigned long move_page_tables(struct vm_area_struct *vma,
>  		unsigned long old_addr, struct vm_area_struct *new_vma,
>  		unsigned long new_addr, unsigned long len,
> @@ -493,6 +538,15 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>
>  	old_end = old_addr + len;
>
> +	/*
> +	 * If possible, realign addresses to PMD boundary for faster copy.
> +	 * Don't align for intra-VMA moves as we may destroy existing mappings.
> +	 */
> +	if ((vma != new_vma)

Nit but these parens aren't needed. Also if we're deferring the decision as
to whether we realign to this function, why are we doing this check here
and not here?

It feels like it'd be neater to keep all the conditions (including the
length one) together in one place.


> +		&& (len >= PMD_SIZE - (old_addr & ~PMD_MASK))) {

You don't mention this condition in the above comment (if we have this
altogether as part of the realign function could comment separately there)
- so we only go ahead and do this optimisation if the length of the remap
is such that the entire of old_addr -> end of its PMD (and thus the same
for new_addr) is copied?

I may be missing something/being naive here, but can't we just do a similar
check to the one done for space _below_ the VMA to see if [end, (end of
PMD)) is equally empty?

> +		realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK);
> +	}
> +
>  	if (is_vm_hugetlb_page(vma))
>  		return move_hugetlb_page_tables(vma, new_vma, old_addr,
>  						new_addr, len);
> @@ -565,6 +619,13 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
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

I find this a little iffy, I mean I see that if you align [old,new]_addr to
PMD, then from then on in you're relying on the fact that the loop is just
going from old_addr (now aligned) -> old_end and thus has the correct
length.

Can't we just fix this issue by correcting len? If you take my review above
which checks len in [maybe_]realign_addr(), you could take that as a
pointer and equally update that.

Then you can drop this check.

Also I am concerned in the hugetlb case -> len is passed to
move_hugetlb_page_tables() which is now strictly incorrect, I wonder if
this could cause an issue?

Correcting len seems the neat way of addressing this.

>  	return len + old_addr - old_end;	/* how much done */
>  }
>
> --
> 2.41.0.rc2.161.g9c6817b8e7-goog
>
