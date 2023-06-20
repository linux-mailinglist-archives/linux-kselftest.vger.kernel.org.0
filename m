Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3272B736A35
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 13:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjFTLCh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 07:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjFTLCg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 07:02:36 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4021DB;
        Tue, 20 Jun 2023 04:02:33 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f918922954so21904715e9.2;
        Tue, 20 Jun 2023 04:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687258952; x=1689850952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xe+NKftJfawlrJMf9TpUjPPNTPzcBJ+qa20yCQQD74I=;
        b=G1aC9NtB14txFc6tVPEcteYgDqPAwE1jLH/zYLAXyMLS7oGaEJGO1z24gJjoqYsyoU
         FK3LhR1PWkeeLB5aZRTDtNzKOSBB9DH1Q353HUNwW8fNjcUqXbQrKW4qGMzQTvtp7Vyj
         zLA/xUmBpGDKYBN6e6xR4E9k8+65GNrF/KJ+wMMMLilDw3fl+PXqbST4e2DFYUxCSpLd
         efsu2VTLvzIt644An22VzxtAZlRjo+jpqOs83fVOc0y1mv0jdBp8kR2UNLRyJ2Bhsp2o
         UaaU2CUi9TkGc0Sp7D8+9pF1iC3LxlMBeID7HsBlZAp8rq6Z7XpLVGlren7te4T0UnkK
         TssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687258952; x=1689850952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xe+NKftJfawlrJMf9TpUjPPNTPzcBJ+qa20yCQQD74I=;
        b=MxeDPMzKw1djH5h0SBADeNv7KN3QF6FQMsyNRiAkp3yvKcggsflNp+FAFYvm5+6CVo
         mT30oq5PZLmCVtfS+tfsYsp8sT4Q8DQyYv/tCAj6ivrfqu9oyh1veWPGlM2KYuXuLHC/
         P6ThxAQWTtEGnNxtTe25e4JRgwqCad6/okRiinMaoSk/C3Gocp7xX5UA+h/lVvSBw/Cy
         sCSYNfPQQK2NsNWRpp1/PEVu7jUoE/V8+28O7CxRf6aW44+Kh8IA9nV5aHT8CdYI6XKn
         vtjYAu2bJsZWUiBzdOjYsbJpKlP1Nv//zBVDTrzj28kT5Jb91s3DpUFOLHqySKqNVsQF
         QiOA==
X-Gm-Message-State: AC+VfDwMOgFyTVTAqzFQbUf+zkznH9bDmwqem91CsA1oiHjFBXPAkfIu
        XeoahW1cK/jkp7hIRedXYQI=
X-Google-Smtp-Source: ACHHUZ7qq/tLESOKfJvQtQPEnPMdLZh0oA2AtQBpdmFHaguouOntU6aeLR6rV0aCxFRtkb3kGTunig==
X-Received: by 2002:a7b:cb93:0:b0:3f9:b0aa:ae7a with SMTP id m19-20020a7bcb93000000b003f9b0aaae7amr3567290wmi.15.1687258950624;
        Tue, 20 Jun 2023 04:02:30 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id e14-20020adfef0e000000b0030c2e3c7fb3sm1711879wro.101.2023.06.20.04.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:02:29 -0700 (PDT)
Date:   Tue, 20 Jun 2023 12:02:28 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <f28eadbc-f40e-4286-bf7e-af0ac360617e@lucifer.local>
References: <20230531220807.2048037-1-joel@joelfernandes.org>
 <20230531220807.2048037-2-joel@joelfernandes.org>
 <f2f751ca-217e-4177-bb7f-1c9cd71e103e@lucifer.local>
 <b87df265-7e58-5907-e215-953630a87155@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b87df265-7e58-5907-e215-953630a87155@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 19, 2023 at 11:55:08AM -0400, Joel Fernandes wrote:
> Hi Lorenzo,
> Thanks for the review! I replied below:
>
> On 6/17/23 18:49, Lorenzo Stoakes wrote:
> > On Wed, May 31, 2023 at 10:08:01PM +0000, Joel Fernandes (Google) wrote:
> >> Recently, we see reports [1] of a warning that triggers due to
> >> move_page_tables() doing a downward and overlapping move on a
> >> mutually-aligned offset within a PMD. By mutual alignment, I
> >> mean the source and destination addresses of the mremap are at
> >> the same offset within a PMD.
> >>
> >> This mutual alignment along with the fact that the move is downward is
> >> sufficient to cause a warning related to having an allocated PMD that
> >> does not have PTEs in it.
> >>
> >> This warning will only trigger when there is mutual alignment in the
> >> move operation. A solution, as suggested by Linus Torvalds [2], is to
> >> initiate the copy process at the PMD level whenever such alignment is
> >> present. Implementing this approach will not only prevent the warning
> >> from being triggered, but it will also optimize the operation as this
> >> method should enhance the speed of the copy process whenever there's a
>
> [...]
>
> >> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> >> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >> ---
> >>   mm/mremap.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 61 insertions(+)
> >>
> >> diff --git a/mm/mremap.c b/mm/mremap.c
> >> index 411a85682b58..bf355e4d6bd4 100644
> >> --- a/mm/mremap.c
> >> +++ b/mm/mremap.c
> >> @@ -478,6 +478,51 @@ static bool move_pgt_entry(enum pgt_entry entry, struct
> >>   	return moved;
> >>   }
> >>
> >> +/*
> >> + * A helper to check if a previous mapping exists. Required for
> >> + * move_page_tables() and realign_addr() to determine if a previous mapping
> >> + * exists before we can do realignment optimizations.
> >> + */
> >> +static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
> >> +			       unsigned long mask)
> >> +{
> >> +	unsigned long addr_masked = addr_to_align & mask;
> >> +	struct vm_area_struct *prev = NULL, *cur = NULL;
> >> +
> >> +	/*
> >> +	 * If @addr_to_align of either source or destination is not the beginning
> >> +	 * of the corresponding VMA, we can't align down or we will destroy part
> >> +	 * of the current mapping.
> >> +	 */
> >> +	if (vma->vm_start != addr_to_align)
> >> +		return false;
> >
> > See below, I think we can eliminate this check.
> >
> >> +
> >> +	/*
> >> +	 * Find the VMA before @vma to see if it subsumes the masked address.
> >> +	 * The mmap write lock is held here so the lookup is safe.
> >> +	 */
> >> +	cur = find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
> >> +	if (WARN_ON_ONCE(cur != vma))
> >> +		return false;
> >> +
> >> +	return !prev || prev->vm_end <= addr_masked;
> >
> > This is a bit clunky, and I don't think we need the WARN_ON_ONCE() check if
> > we're under the mmap_lock.
> >
> > How about something like:-
> >
> > return find_vma_intersection(vma->mm, addr_masked, vma->vm_start) == NULL;
> >
> > Which explicitly asserts that the range in [addr_masked, vma->vm_start) is
> > empty.
> >
> > But actually, we should be able to go further and replace the previous
> > check with:-
> >
> > return find_vma_intersection(vma->mm, addr_masked, addr_to_align) == NULL;
> >
> > Which will fail if addr_to_align is offset within the VMA.
>
> Your suggestion would mean that we do a full VMA search starting from the
> root. That would not be a nice thing if say we've 1000s of VMAs?
>
> Actually Liam told me to use find_vma_prev() because given a VMA, the maple
> tree would not have to work that hard for the common case to find the
> previous VMA. Per conversing with him, there is a chance we may have to go
> one step above in the tree if we hit the edge of a node, but that's not
> supposed to be the common case. In previous code, the previous VMA could
> just be obtained using the "previous VMA" pointer, however that pointer has
> been remove since the maple tree changes and given a VMA, going to the
> previous one using the maple tree is just as fast (as I'm told).

As far as I can tell, find_vma_prev() already does a walk? I mean this is
equivalent to find_vma() only retrieving the previous VMA right? I defer to
Liam, but I'm not sure this would be that much more involved? Perhaps he
can comment.

An alternative is to create an iterator and use vma_prev(). I find it
extremely clunky that we search for a VMA we already possess (and it's
previous one) while not needing the the former.

I'm not hugely familiar with the maple tree (perhaps Liam can comment) but
I suspect that'd be more performant if that's the concern. Either way I
would be surprised if this is the correct approach.

>
> Considering this, I would keep the code as-is and perhaps you/we could
> consider the replacement with another API in a subsequent patch as it does
> the job for this patch.

See above. I don't think this kind of comment is helpful in code
review. Your disagreement above suffices, I've responded to it and of
course if there is no other way this is fine.

But I'd be surprised, and re-looking up a VMA we already have is just
horrid. It's not really a nitpick, it's a code quality issue in my view.

In any case, let's please try to avoid 'if you are bothered, write a follow
up patch' style responses. If you disagree with something just say so, it's
fine! :)

>
> >> +			 unsigned long *new_addr, struct vm_area_struct *new_vma,
> >> +			 unsigned long mask)
> >> +{
> >> +	bool mutually_aligned = (*old_addr & ~mask) == (*new_addr & ~mask);
> >> +
> >> +	if ((*old_addr & ~mask) && mutually_aligned
> >
> > I may be misunderstanding something here, but doesn't the first condition
> > here disallow for offset into PMD == 0? Why?
>
> Because in such a situation, the alignment is already done and there's
> nothing to align. The patch wants to align down to the PMD and we would not
> want to waste CPU cycles if there's nothing to do.

OK, makes sense. It'd be useful to have a comment to this effect.

>
> >> +	    && can_align_down(old_vma, *old_addr, mask)
> >> +	    && can_align_down(new_vma, *new_addr, mask)) {
> >> +		*old_addr = *old_addr & mask;
> >> +		*new_addr = *new_addr & mask;
> >> +	}
> >> +}
> >> +
> >>   unsigned long move_page_tables(struct vm_area_struct *vma,
> >>   		unsigned long old_addr, struct vm_area_struct *new_vma,
> >>   		unsigned long new_addr, unsigned long len,
> >> @@ -493,6 +538,15 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >>
> >>   	old_end = old_addr + len;
> >>
> >> +	/*
> >> +	 * If possible, realign addresses to PMD boundary for faster copy.
> >> +	 * Don't align for intra-VMA moves as we may destroy existing mappings.
> >> +	 */
> >> +	if ((vma != new_vma)
> >
> > Nit but these parens aren't needed.
>
> Sure, I can drop the parens.

Thanks.

>
> > Also if we're deferring the decision as
> > to whether we realign to this function, why are we doing this check here
> > and not here?
>
> Hmm, well the function name is realign_addr() so I kept some of the initial
> checks outside of it where we should "obviously" not realign. I could do
> what you're suggesting and change it to try_realign_addr() or something. And
> move those checks in there. That would be a bit better.

Thanks.

>
> > It feels like it'd be neater to keep all the conditions (including the
> > length one) together in one place.
> >
> >
> >> +		&& (len >= PMD_SIZE - (old_addr & ~PMD_MASK))) {
>
> Well, yeah maybe. I'll look into it, thanks.

I mean it's not a huge big deal, but reading your code having a bunch of
conditions in two different places is a little hard to parse and jarring.

>
> > You don't mention this condition in the above comment (if we have this
> > altogether as part of the realign function could comment separately there)
>
> Ok, sounds good -- I will add a comment with some of the explanation above.
>
> > - so we only go ahead and do this optimisation if the length of the remap
> > is such that the entire of old_addr -> end of its PMD (and thus the same
> > for new_addr) is copied?
>
> Yes, correct. And in the future that could also be optimized (if say there
> is no subsequent mapping, so we can copy the tail PMD as well, however one
> step at a time and all that.)
>

OK cool makes sense.

> > I may be missing something/being naive here, but can't we just do a similar
> > check to the one done for space _below_ the VMA to see if [end, (end of
> > PMD)) is equally empty?
>
> We can, but the warning that was triggering does not really need that to be
> silenced. I am happy to do that in a later patch if needed, or you can. ;-)
> But I'd like to keep the risk low since this was itself hard enough to get
> right.

(see above about 'later patch' comments...)

Sure, this is not a big deal.

>
> >> +		realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK);
> >> +	}
> >> +
> >>   	if (is_vm_hugetlb_page(vma))
> >>   		return move_hugetlb_page_tables(vma, new_vma, old_addr,
> >>   						new_addr, len);
> >> @@ -565,6 +619,13 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >>
> >>   	mmu_notifier_invalidate_range_end(&range);
> >>
> >> +	/*
> >> +	 * Prevent negative return values when {old,new}_addr was realigned
> >> +	 * but we broke out of the above loop for the first PMD itself.
> >> +	 */
> >> +	if (len + old_addr < old_end)
> >> +		return 0;
> >> +
> >
> > I find this a little iffy, I mean I see that if you align [old,new]_addr to
> > PMD, then from then on in you're relying on the fact that the loop is just
> > going from old_addr (now aligned) -> old_end and thus has the correct
> > length.
> >
> > Can't we just fix this issue by correcting len? If you take my review above
> > which checks len in [maybe_]realign_addr(), you could take that as a
> > pointer and equally update that.
> >
> > Then you can drop this check.
>
> The drawback of adjusting len is it changes what move_page_tables() users
> were previously expecting.
>
> I think we should look at the return value of move_page_tables() as well,
> not just len independently.
>
> len is what the user requested.
>
> "len + old_addr - old_end" is how much was actually copied and is the return value.
>
> If everything was copied, old_addr == old_end and len is unchanged.

Ah yeah I see, sorry I missed the fact we're returning a value, that does
complicate things...

If we retain the hugetlb logic, then we could work around the issue with
that instance of len by storing the 'actual length' of the range in
a new var actual_len and passing that.

If we choose to instead just not do this for hugetlb (I wonder if the
hugetlb handling code actually does the equivalent of this since surely
these pages have to be handled a PMD at a time?) then we can drop the whole
actual_len idea [see below on response to hugetlb thing].

>
> The users of move_page_tables(), like move_vma() should not care whether we
> copied a full PMD or not. In fact telling them anything like may cause
> problems with the interpretation of the return value I think.
>
> They asked us to copy len, did we copy it? hell yeah.
>
> Note that after the first loop iteration's PMD copy, old_addr is now at the
> PMD boundary and the functionality of this function is not changed with this
> patch. We end up doing a PMD-copy just like we used to without this patch.
> So this patch does not really change anything from before.
>
> The following are the cases:
>
> 1. If we realign and copy, yes we copied a PMD, but really it was to satisfy
> the requested length. In this situation, "len + old_addr - old_end"  is
> accurate and just like before. We copied whatever the user requested. Yes we
> copied a little more, but who cares? We copied into a mapping that does not
> exist anyway. It may be absurd for us to return a len that is greater than
> the requested len IMO.
>
> 2. If there are no errors (example first PMD copy did not fail), "len +
> old_addr - old_end" is identical to what it was without this patch -- as it
> should be. That's true whether we realigned or not.
>
> 3. If we realigned and the first PMD copy failed (unlikely error) -- that's
> where there's a problem. We would end up returning a negative value. That's
> what Linus found and suggested to correct. Because (old_addr - old_end) will
> be greater than len in such a situation, however unlikely.
>

Right. Yeah that is thorny, sorry I did miss the degree of the complexity
with that... ugh ye gods. Probably then this has to be retained.

I was thinking we could use min(actual_len + old_addr - old_end, len), but
then we'd over-report what was 'copied' (actually not copied) because
that'd include the address range spanned by the empty PTE entries up to the
start of the PMD entry.

> >>   	return len + old_addr - old_end;	/* how much done */
> >>   }
> > Also I am concerned in the hugetlb case -> len is passed to
> > move_hugetlb_page_tables() which is now strictly incorrect, I wonder if
> > this could cause an issue?
> >
> > Correcting len seems the neat way of addressing this.
>
> That's a good point. I am wondering if we can just change that from:
>
> 	if (is_vm_hugetlb_page(vma))
> 		return move_hugetlb_page_tables(vma, new_vma, old_addr,
> 				new_addr, len);
>
> to:
> 	if (is_vm_hugetlb_page(vma))
> 		return move_hugetlb_page_tables(vma, new_vma, old_addr,
> 				new_addr, old_addr - new_addr);
>
> Or, another option is to turn it off for hugetlb by just moving:
>
> 	if (len >= PMD_SIZE - (old_addr & ~PMD_MASK))
> 		realign_addr(...);
>
> to after:
>
> 	if (is_vm_hugetlb_page(vma))
> 		return move_hugetlb_page_tables(...);
>
> thanks,

I think the actual_len solution should sort this right? If not maybe better
to be conservative and disable for the hugetlb case (I'm not sure if this
would help given you'd need to be PMD aligned anyway right?), so not to
hold up the series.

If we do decide not to include hugetlb (the endless 'special case' for so
much code...) in this then we can drop the actual_len idea altogether.

(Yes I realise it's ironic I'm suggesting deferring to a later patch here
but there you go ;)

>
>  - Joel
>
