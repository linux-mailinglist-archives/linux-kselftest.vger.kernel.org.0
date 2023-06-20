Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10557376F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 00:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjFTWAI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 18:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjFTWAH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 18:00:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FB0107;
        Tue, 20 Jun 2023 15:00:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3112f5ab0b1so3191060f8f.0;
        Tue, 20 Jun 2023 15:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687298404; x=1689890404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zzT9JowwR4WrNgD4+M6vydnUzUQdWJgu/dR3PcW05zQ=;
        b=Y/NP7+OR5ppHjZromXh4ABh23CjtUmmGZm0UF8X3bB93LEN07hvkvHjDemIdK7EWO9
         PtvJQ4y+VvWoZIifE9BJ0VbH8kv3Y9wp47vQ0gn3orbpBzHrVbpIXKfkFwvn7sGTMv3Z
         WG9/IZaGkr7F0TY00yxemdkqNWQD2acLpE82OuuRoti4Bg87NDA37Ws7FbXwwNZ00GRJ
         ZpJTwK497uxRBeFzHL4CD7IWZS53tJ4BSY0OgMy50JWWi2v97hGV3MKYN20XcXU1VP9u
         9+rbcxzPPi9vWv6+3sNfVHHl3igrMOthEDXBRl73PwG1OyXSavMNqKohMcQjQq7sYaI8
         7Lzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687298404; x=1689890404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzT9JowwR4WrNgD4+M6vydnUzUQdWJgu/dR3PcW05zQ=;
        b=alQ0855OZbpbAuoMNPXEeRhcU4en5ZhD+7DtuUQ8eTzS3222wJUGDsrlI6XHoAro+e
         bOjb6mCwAi5aA4x/I8oYdjKxAWBCP9C1SW0ZX4GhOmdyMR5Kns01QiUyJD1YbHZqGM2+
         +uFnUpCP8NGdP/rPDEDzQjt4/jBYN/D+SE/uqzqGk7dgcyeC/cnKs7WijeT2zk/hR9kf
         cXh91NVQmSesPoKdEwOujVv8+ZBcZeyYttEEBcFBC3MYV9lE15Bdo/5TffvuOR8RPo0K
         CpUi8XXipHmaCUKT4pRh6yhCY42T9PqpjtZg2vFvACEHI49Hgny5wuWFOanvQCefqNru
         o+1Q==
X-Gm-Message-State: AC+VfDz44NAkfDZoLaQajCiHGomBX1Vu8Z92gBtWso8P/AC7gipD/+s/
        rQ++9K99vr5fsFHIe8dK4cY=
X-Google-Smtp-Source: ACHHUZ6IICTm9FTjV1sa6qUnPvWEPwisMhdtmi3Vz/I/iOyMjeVt36OvYAGMcFnUihK7yN/ctscF1Q==
X-Received: by 2002:a5d:644d:0:b0:30e:3d3d:4329 with SMTP id d13-20020a5d644d000000b0030e3d3d4329mr9297009wrw.35.1687298404265;
        Tue, 20 Jun 2023 15:00:04 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id j18-20020adff012000000b0030e56a9ff25sm2850780wro.31.2023.06.20.15.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 15:00:03 -0700 (PDT)
Date:   Tue, 20 Jun 2023 23:00:02 +0100
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
Message-ID: <28e641d6-37ba-44a7-b7a8-76e797fab1f7@lucifer.local>
References: <20230531220807.2048037-1-joel@joelfernandes.org>
 <20230531220807.2048037-2-joel@joelfernandes.org>
 <f2f751ca-217e-4177-bb7f-1c9cd71e103e@lucifer.local>
 <b87df265-7e58-5907-e215-953630a87155@joelfernandes.org>
 <f28eadbc-f40e-4286-bf7e-af0ac360617e@lucifer.local>
 <e81b4534-54ce-466f-0d07-dc530cf137c2@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e81b4534-54ce-466f-0d07-dc530cf137c2@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 20, 2023 at 05:16:57PM -0400, Joel Fernandes wrote:
> Hi Lorenzo,
>
> > As far as I can tell, find_vma_prev() already does a walk? I mean this is
> > equivalent to find_vma() only retrieving the previous VMA right? I defer to
> > Liam, but I'm not sure this would be that much more involved? Perhaps he
> > can comment.
> >
> > An alternative is to create an iterator and use vma_prev(). I find it
> > extremely clunky that we search for a VMA we already possess (and it's
> > previous one) while not needing the the former.
> >
> > I'm not hugely familiar with the maple tree (perhaps Liam can comment) but
> > I suspect that'd be more performant if that's the concern. Either way I
> > would be surprised if this is the correct approach.
>
> I see your point. I am not sure myself, the maple tree functions for both
> APIs are indeed similar. We already have looked up the VMA being aligned
> down. If there is a way to get the previous VMA quickly, given an existing
> VMA, I can incorporate that change.
>
> Ideally, if I had access to the ma_state used for lookup of the VMA being
> aligned down, I could perhaps reuse that somehow. But when I checked, that
> seemed a lot more invasive to pass that state down to these align functions.
>
> But there is a merit to your suggestion itself in the sense it cuts down a
> few more lines of code.

Yeah it's thorny, the maple tree seems to add a separation between the vmi
and vma that didn't exist previously, and you'd have to thread through the
mas or vmi that was used in the first instance or end up having to rewalk
the tree anyway.

I have spesnt too much time staring at v6 code where it was trivial :)

I think given we have to walk the tree either way, we may as well do the
find_vma_intersection() [happy to stand corrected by Liam if this turns out
not to be less efficient but I don't think it is].

>
> > > Considering this, I would keep the code as-is and perhaps you/we could
> > > consider the replacement with another API in a subsequent patch as it does
> > > the job for this patch.
> >
> > See above. I don't think this kind of comment is helpful in code
> > review. Your disagreement above suffices, I've responded to it and of
> > course if there is no other way this is fine.
> >
> > But I'd be surprised, and re-looking up a VMA we already have is just
> > horrid. It's not really a nitpick, it's a code quality issue in my view.
> >
> > In any case, let's please try to avoid 'if you are bothered, write a follow
> > up patch' style responses. If you disagree with something just say so, it's
> > fine! :)
>
> I wasn't disagreeing :) Just saying that the find_vma_prev() suggested in a
> previous conversation with Liam fixes the issue (and has been tested a lot
> in this series, on my side) so I was hoping to stick to that and we could
> iterate more on that in the future.
>
> However, after taking a deeper look at the maple tree, I'd like to give the
> find_vma_intersection() option at least a try (with appropriate attribution
> to you).

Cheers appreciate it, sorry to be a pain and nitpicky but I think if that
works as well it could be quite a nice solution.

>
> Apologies if the response style in my previous email came across badly. That
> wasn't my intent and I will try to improve myself.

No worries, text is a sucky medium and likely I misinterpreted you in any
case. We're having a productive discussion which is what matters! :)

>
> [..]
>
> > > > > +		realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK);
> > > > > +	}
> > > > > +
> > > > >    	if (is_vm_hugetlb_page(vma))
> > > > >    		return move_hugetlb_page_tables(vma, new_vma, old_addr,
> > > > >    						new_addr, len);
> > > > > @@ -565,6 +619,13 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> > > > >
> > > > >    	mmu_notifier_invalidate_range_end(&range);
> > > > >
> > > > > +	/*
> > > > > +	 * Prevent negative return values when {old,new}_addr was realigned
> > > > > +	 * but we broke out of the above loop for the first PMD itself.
> > > > > +	 */
> > > > > +	if (len + old_addr < old_end)
> > > > > +		return 0;
> > > > > +
> > > >
> > > > I find this a little iffy, I mean I see that if you align [old,new]_addr to
> > > > PMD, then from then on in you're relying on the fact that the loop is just
> > > > going from old_addr (now aligned) -> old_end and thus has the correct
> > > > length.
> > > >
> > > > Can't we just fix this issue by correcting len? If you take my review above
> > > > which checks len in [maybe_]realign_addr(), you could take that as a
> > > > pointer and equally update that.
> > > >
> > > > Then you can drop this check.
> > >
> > > The drawback of adjusting len is it changes what move_page_tables() users
> > > were previously expecting.
> > >
> > > I think we should look at the return value of move_page_tables() as well,
> > > not just len independently.
> > >
> > > len is what the user requested.
> > >
> > > "len + old_addr - old_end" is how much was actually copied and is the return value.
> > >
> > > If everything was copied, old_addr == old_end and len is unchanged.
> >
> > Ah yeah I see, sorry I missed the fact we're returning a value, that does
> > complicate things...
> >
> > If we retain the hugetlb logic, then we could work around the issue with
> > that instance of len by storing the 'actual length' of the range in
> > a new var actual_len and passing that.
> >
> > If we choose to instead just not do this for hugetlb (I wonder if the
> > hugetlb handling code actually does the equivalent of this since surely
> > these pages have to be handled a PMD at a time?) then we can drop the whole
> > actual_len idea [see below on response to hugetlb thing].
>
> Thanks. Yes, you are right. We should already b  good with hugetlb handling
> as it does appear that hugetlb_move_page_tables() does copy by
> huge_page_size(h), so the old_addr should already be PMD-aligned for it to
> be able to do that.

Cool, in which case we can drop the actual_len idea as this is really the
only place we'd need it.

>
> [..]
>
> > > > >    	return len + old_addr - old_end;	/* how much done */
> > > > >    }
> > > > Also I am concerned in the hugetlb case -> len is passed to
> > > > move_hugetlb_page_tables() which is now strictly incorrect, I wonder if
> > > > this could cause an issue?
> > > >
> > > > Correcting len seems the neat way of addressing this.
> > >
> > > That's a good point. I am wondering if we can just change that from:
> > >
> > > 	if (is_vm_hugetlb_page(vma))
> > > 		return move_hugetlb_page_tables(vma, new_vma, old_addr,
> > > 				new_addr, len);
> > >
> > > to:
> > > 	if (is_vm_hugetlb_page(vma))
> > > 		return move_hugetlb_page_tables(vma, new_vma, old_addr,
> > > 				new_addr, old_addr - new_addr);
> > >
> > > Or, another option is to turn it off for hugetlb by just moving:
> > >
> > > 	if (len >= PMD_SIZE - (old_addr & ~PMD_MASK))
> > > 		realign_addr(...);
> > >
> > > to after:
> > >
> > > 	if (is_vm_hugetlb_page(vma))
> > > 		return move_hugetlb_page_tables(...);
> > >
> > > thanks,
> >
> > I think the actual_len solution should sort this right? If not maybe better
> > to be conservative and disable for the hugetlb case (I'm not sure if this
> > would help given you'd need to be PMD aligned anyway right?), so not to
> > hold up the series.
> >
> > If we do decide not to include hugetlb (the endless 'special case' for so
> > much code...) in this then we can drop the actual_len idea altogether.
> >
> > (Yes I realise it's ironic I'm suggesting deferring to a later patch here
> > but there you go ;)
>
> ;-). Considering our discussion above that hugetlb mremap addresses should
> always starts at a PMD boundary, maybe I can just add a warning to the if()
> like so to detect any potential?
>
> 	if (is_vm_hugetlb_page(vma)) {
> 		WARN_ON_ONCE(old_addr - old_end != len);
> 		return move_hugetlb_page_tables(vma, new_vma, old_addr,
> 						new_addr, len);
>         }
>

Yeah looks good [ack your follow up that it should be old_end - old_addr],
maybe adding a comment explaining why this is a problem here too.

>
> Thank you so much and I learnt a lot from you and others in -mm community.

No worries, thanks very much for this patch series, this is a nice fixup
for a quite stupid failure we were experiencing before with a neat
solution. Your hard work is appreciated!

>
> - Joel
>
