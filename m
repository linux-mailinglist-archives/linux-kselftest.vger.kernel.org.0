Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DFF735BA0
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 17:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjFSPzP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 11:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjFSPzO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 11:55:14 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ED91A6
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jun 2023 08:55:11 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-62fff19e8fdso13892046d6.1
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jun 2023 08:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1687190111; x=1689782111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAulbMfMpDXOXrQhWQKRdEBfIDfNhNI868UDiXdYbqk=;
        b=J21aIURfxr0PHqjQEpdo9c3Up+Iv/8gQBL9OnX3hdsnf7tM+k+LhVosCg2PfJFh3Xt
         nseVcgmIV91PHhZdvtjzN6F1qgQnoRznzheClwirwvtFEweOFznM4Sl2znDkRBAQK7w9
         UbPZS9ZXXRxUDK/D5kyJWtXVhvCGm5HZ3S7z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687190111; x=1689782111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAulbMfMpDXOXrQhWQKRdEBfIDfNhNI868UDiXdYbqk=;
        b=g/cw1jFcsS64QTmPo6QvNXU78Do2OAPBxuvy17ZxjUXuGp/Jb7+Cmcn2ItP8BjQS3p
         4nW6WNMIwgtFoM2XPDf5mem0qXq9esSRmo5g8/hYUp/xDqNdCBMO06+WJRFRy0QUfKPm
         jlJ7OxZpxAXccBZlGHXc7wvidqzg3iqbXcQF2pVqPKxBHzejhd5OwUYzTlzbgT+9cyfn
         O1tzdMcIA5wH/Oesn3JflW3si1an2S6tp1r/P4Te3WRYnb2zLlrlHGKdUFMBhf6m8Hrc
         zp9d4ktMrPxS+pwYnplh5OQ2ki+HR1pdkGgaGjE+lFQi7qybN65RWt/7EwTGxJbBqS68
         9SOg==
X-Gm-Message-State: AC+VfDxplXfjq8HSfTOlwwAwwrCbUXxQqOTrrO9ZswqRWefaAgOVkjYh
        hS6PDpiIWmsRnjaDssPvLet3sg==
X-Google-Smtp-Source: ACHHUZ7Mm/mS8yycEZryo5UiQFPM2cy4ZwmfV9hrd1i0Ft3uSDBphowqZBJq7TSGdXVtXimCwDtuHA==
X-Received: by 2002:a05:6214:4019:b0:62d:ed72:87b0 with SMTP id kd25-20020a056214401900b0062ded7287b0mr19884144qvb.2.1687190110754;
        Mon, 19 Jun 2023 08:55:10 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id b12-20020a0cc98c000000b00630044b530esm80169qvk.83.2023.06.19.08.55.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 08:55:10 -0700 (PDT)
Message-ID: <b87df265-7e58-5907-e215-953630a87155@joelfernandes.org>
Date:   Mon, 19 Jun 2023 11:55:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/7] mm/mremap: Optimize the start addresses in
 move_page_tables()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>
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
References: <20230531220807.2048037-1-joel@joelfernandes.org>
 <20230531220807.2048037-2-joel@joelfernandes.org>
 <f2f751ca-217e-4177-bb7f-1c9cd71e103e@lucifer.local>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <f2f751ca-217e-4177-bb7f-1c9cd71e103e@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Lorenzo,
Thanks for the review! I replied below:

On 6/17/23 18:49, Lorenzo Stoakes wrote:
 > On Wed, May 31, 2023 at 10:08:01PM +0000, Joel Fernandes (Google) wrote:
 >> Recently, we see reports [1] of a warning that triggers due to
 >> move_page_tables() doing a downward and overlapping move on a
 >> mutually-aligned offset within a PMD. By mutual alignment, I
 >> mean the source and destination addresses of the mremap are at
 >> the same offset within a PMD.
 >>
 >> This mutual alignment along with the fact that the move is downward is
 >> sufficient to cause a warning related to having an allocated PMD that
 >> does not have PTEs in it.
 >>
 >> This warning will only trigger when there is mutual alignment in the
 >> move operation. A solution, as suggested by Linus Torvalds [2], is to
 >> initiate the copy process at the PMD level whenever such alignment is
 >> present. Implementing this approach will not only prevent the warning
 >> from being triggered, but it will also optimize the operation as this
 >> method should enhance the speed of the copy process whenever there's a

[...]

 >> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
 >> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
 >> ---
 >>   mm/mremap.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 >>   1 file changed, 61 insertions(+)
 >>
 >> diff --git a/mm/mremap.c b/mm/mremap.c
 >> index 411a85682b58..bf355e4d6bd4 100644
 >> --- a/mm/mremap.c
 >> +++ b/mm/mremap.c
 >> @@ -478,6 +478,51 @@ static bool move_pgt_entry(enum pgt_entry entry, struct
 >>   	return moved;
 >>   }
 >>
 >> +/*
 >> + * A helper to check if a previous mapping exists. Required for
 >> + * move_page_tables() and realign_addr() to determine if a previous mapping
 >> + * exists before we can do realignment optimizations.
 >> + */
 >> +static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
 >> +			       unsigned long mask)
 >> +{
 >> +	unsigned long addr_masked = addr_to_align & mask;
 >> +	struct vm_area_struct *prev = NULL, *cur = NULL;
 >> +
 >> +	/*
 >> +	 * If @addr_to_align of either source or destination is not the beginning
 >> +	 * of the corresponding VMA, we can't align down or we will destroy part
 >> +	 * of the current mapping.
 >> +	 */
 >> +	if (vma->vm_start != addr_to_align)
 >> +		return false;
 >
 > See below, I think we can eliminate this check.
 >
 >> +
 >> +	/*
 >> +	 * Find the VMA before @vma to see if it subsumes the masked address.
 >> +	 * The mmap write lock is held here so the lookup is safe.
 >> +	 */
 >> +	cur = find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
 >> +	if (WARN_ON_ONCE(cur != vma))
 >> +		return false;
 >> +
 >> +	return !prev || prev->vm_end <= addr_masked;
 >
 > This is a bit clunky, and I don't think we need the WARN_ON_ONCE() check if
 > we're under the mmap_lock.
 >
 > How about something like:-
 >
 > return find_vma_intersection(vma->mm, addr_masked, vma->vm_start) == NULL;
 >
 > Which explicitly asserts that the range in [addr_masked, vma->vm_start) is
 > empty.
 >
 > But actually, we should be able to go further and replace the previous
 > check with:-
 >
 > return find_vma_intersection(vma->mm, addr_masked, addr_to_align) == NULL;
 >
 > Which will fail if addr_to_align is offset within the VMA.

Your suggestion would mean that we do a full VMA search starting from the root. That would 
not be a nice thing if say we've 1000s of VMAs?

Actually Liam told me to use find_vma_prev() because given a VMA, the maple tree would not 
have to work that hard for the common case to find the previous VMA. Per conversing with 
him, there is a chance we may have to go one step above in the tree if we hit the edge of 
a node, but that's not supposed to be the common case. In previous code, the previous VMA 
could just be obtained using the "previous VMA" pointer, however that pointer has been 
remove since the maple tree changes and given a VMA, going to the previous one using the 
maple tree is just as fast (as I'm told).

Considering this, I would keep the code as-is and perhaps you/we could consider the 
replacement with another API in a subsequent patch as it does the job for this patch.

 >> +			 unsigned long *new_addr, struct vm_area_struct *new_vma,
 >> +			 unsigned long mask)
 >> +{
 >> +	bool mutually_aligned = (*old_addr & ~mask) == (*new_addr & ~mask);
 >> +
 >> +	if ((*old_addr & ~mask) && mutually_aligned
 >
 > I may be misunderstanding something here, but doesn't the first condition
 > here disallow for offset into PMD == 0? Why?

Because in such a situation, the alignment is already done and there's nothing to align. 
The patch wants to align down to the PMD and we would not want to waste CPU cycles if 
there's nothing to do.

 >> +	    && can_align_down(old_vma, *old_addr, mask)
 >> +	    && can_align_down(new_vma, *new_addr, mask)) {
 >> +		*old_addr = *old_addr & mask;
 >> +		*new_addr = *new_addr & mask;
 >> +	}
 >> +}
 >> +
 >>   unsigned long move_page_tables(struct vm_area_struct *vma,
 >>   		unsigned long old_addr, struct vm_area_struct *new_vma,
 >>   		unsigned long new_addr, unsigned long len,
 >> @@ -493,6 +538,15 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 >>
 >>   	old_end = old_addr + len;
 >>
 >> +	/*
 >> +	 * If possible, realign addresses to PMD boundary for faster copy.
 >> +	 * Don't align for intra-VMA moves as we may destroy existing mappings.
 >> +	 */
 >> +	if ((vma != new_vma)
 >
 > Nit but these parens aren't needed.

Sure, I can drop the parens.

 > Also if we're deferring the decision as
 > to whether we realign to this function, why are we doing this check here
 > and not here?

Hmm, well the function name is realign_addr() so I kept some of the initial checks outside 
of it where we should "obviously" not realign. I could do what you're suggesting and 
change it to try_realign_addr() or something. And move those checks in there. That would 
be a bit better.

 > It feels like it'd be neater to keep all the conditions (including the
 > length one) together in one place.
 >
 >
 >> +		&& (len >= PMD_SIZE - (old_addr & ~PMD_MASK))) {

Well, yeah maybe. I'll look into it, thanks.

 > You don't mention this condition in the above comment (if we have this
 > altogether as part of the realign function could comment separately there)

Ok, sounds good -- I will add a comment with some of the explanation above.

 > - so we only go ahead and do this optimisation if the length of the remap
 > is such that the entire of old_addr -> end of its PMD (and thus the same
 > for new_addr) is copied?

Yes, correct. And in the future that could also be optimized (if say there is no 
subsequent mapping, so we can copy the tail PMD as well, however one step at a time and 
all that.)

 > I may be missing something/being naive here, but can't we just do a similar
 > check to the one done for space _below_ the VMA to see if [end, (end of
 > PMD)) is equally empty?

We can, but the warning that was triggering does not really need that to be silenced. I am 
happy to do that in a later patch if needed, or you can. ;-) But I'd like to keep the risk 
low since this was itself hard enough to get right.

 >> +		realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK);
 >> +	}
 >> +
 >>   	if (is_vm_hugetlb_page(vma))
 >>   		return move_hugetlb_page_tables(vma, new_vma, old_addr,
 >>   						new_addr, len);
 >> @@ -565,6 +619,13 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 >>
 >>   	mmu_notifier_invalidate_range_end(&range);
 >>
 >> +	/*
 >> +	 * Prevent negative return values when {old,new}_addr was realigned
 >> +	 * but we broke out of the above loop for the first PMD itself.
 >> +	 */
 >> +	if (len + old_addr < old_end)
 >> +		return 0;
 >> +
 >
 > I find this a little iffy, I mean I see that if you align [old,new]_addr to
 > PMD, then from then on in you're relying on the fact that the loop is just
 > going from old_addr (now aligned) -> old_end and thus has the correct
 > length.
 >
 > Can't we just fix this issue by correcting len? If you take my review above
 > which checks len in [maybe_]realign_addr(), you could take that as a
 > pointer and equally update that.
 >
 > Then you can drop this check.

The drawback of adjusting len is it changes what move_page_tables() users were previously 
expecting.

I think we should look at the return value of move_page_tables() as well, not just len 
independently.

len is what the user requested.

"len + old_addr - old_end" is how much was actually copied and is the return value.

If everything was copied, old_addr == old_end and len is unchanged.

The users of move_page_tables(), like move_vma() should not care whether we copied a full 
PMD or not. In fact telling them anything like may cause problems with the interpretation 
of the return value I think.

They asked us to copy len, did we copy it? hell yeah.

Note that after the first loop iteration's PMD copy, old_addr is now at the PMD boundary 
and the functionality of this function is not changed with this patch. We end up doing a 
PMD-copy just like we used to without this patch. So this patch does not really change 
anything from before.

The following are the cases:

1. If we realign and copy, yes we copied a PMD, but really it was to satisfy the requested 
length. In this situation, "len + old_addr - old_end"  is accurate and just like before. 
We copied whatever the user requested. Yes we copied a little more, but who cares? We 
copied into a mapping that does not exist anyway. It may be absurd for us to return a len 
that is greater than the requested len IMO.

2. If there are no errors (example first PMD copy did not fail), "len + old_addr - 
old_end" is identical to what it was without this patch -- as it should be. That's true 
whether we realigned or not.

3. If we realigned and the first PMD copy failed (unlikely error) -- that's where there's 
a problem. We would end up returning a negative value. That's what Linus found and 
suggested to correct. Because (old_addr - old_end) will be greater than len in such a 
situation, however unlikely.

 >>   	return len + old_addr - old_end;	/* how much done */
 >>   }
 > Also I am concerned in the hugetlb case -> len is passed to
 > move_hugetlb_page_tables() which is now strictly incorrect, I wonder if
 > this could cause an issue?
 >
 > Correcting len seems the neat way of addressing this.

That's a good point. I am wondering if we can just change that from:

	if (is_vm_hugetlb_page(vma))
		return move_hugetlb_page_tables(vma, new_vma, old_addr,
				new_addr, len);

to:
	if (is_vm_hugetlb_page(vma))
		return move_hugetlb_page_tables(vma, new_vma, old_addr,
				new_addr, old_addr - new_addr);

Or, another option is to turn it off for hugetlb by just moving:

	if (len >= PMD_SIZE - (old_addr & ~PMD_MASK))
		realign_addr(...);

to after:

	if (is_vm_hugetlb_page(vma))
		return move_hugetlb_page_tables(...);

thanks,

  - Joel

