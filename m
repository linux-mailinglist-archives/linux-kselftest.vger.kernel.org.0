Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99D778B986
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 22:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjH1U0s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 16:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjH1U0o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 16:26:44 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80EAF9
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 13:26:40 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34b0f3b792dso13672055ab.3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 13:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693254400; x=1693859200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GdS5U3zAZC1OpDhYKXHHzRAYVsQHuMtwD7yrhm4gv74=;
        b=KMraxVfGuS98aLRGVM4TJJO4fib8huPrdCiceopE0W7CyIMgd1A32MB5ehYm+3xloP
         OGMbQNmR2zPKHhuYVGMHm3x2TCLlFpPMDBIxEXZ2WujuyYB/61GSSViRCJqFH03qaW72
         8YXQ1NQxemTFe7uQKp9atnC6u4WfRI2Mup9Ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693254400; x=1693859200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdS5U3zAZC1OpDhYKXHHzRAYVsQHuMtwD7yrhm4gv74=;
        b=GpDJWr3+BNG1EM7eNEB8DF+CkPdYqvVI3kIBtYAsQD29/3RCjiD9m4K01S7DyUOLK2
         Lkz36pskkA8DfSMUhGYQDVsdwhIDUtrE/rp8K9LUg2f7dCelkBKLt5HylHxgJzgi6gDV
         3WKuEtVz7u/ulOkD9yY/s4DFf950EfyRSOs1mUSjpmaKN4zzpZy0jG6RKZGVZcOkLJX4
         opBwG6pKi5j6f5kMFwGwbdSobiUDEb24Yg9iqcJYVFMwDCrfralGGx25LOXcFeOK1r2l
         IXjz7mN6Jt5NpZ4M7BZcjaB8yKf8S+wWE6nJ3JTzOcZZUu72At/D5ko+aAmXiQWP1O9M
         MTjA==
X-Gm-Message-State: AOJu0YyGjeKqEN15XFthxd9lDfBSIXkAfyyQrTHSHnHXPtrRSG4YJXo5
        kcBCOkYajLywXbvKnzUIPjEcOw==
X-Google-Smtp-Source: AGHT+IGRLCtFYkksB6W0I4qT0QxymU8BO3DUqCwvOEFrU8Ok9D94zjEg8TO2rLD8je6BGtvYtCaOKQ==
X-Received: by 2002:a92:d7c7:0:b0:34a:c618:b904 with SMTP id g7-20020a92d7c7000000b0034ac618b904mr18628179ilq.22.1693254400046;
        Mon, 28 Aug 2023 13:26:40 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id f11-20020a056638118b00b0042b3042ccd8sm2666957jas.13.2023.08.28.13.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 13:26:39 -0700 (PDT)
Date:   Mon, 28 Aug 2023 20:26:38 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
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
Message-ID: <20230828202638.GA1646335@google.com>
References: <20230822015501.791637-1-joel@joelfernandes.org>
 <20230822015501.791637-3-joel@joelfernandes.org>
 <46196ba1-c54d-4c1d-954f-a0006602af99@lucifer.local>
 <20230828183240.GA1621761@google.com>
 <8891681e-532c-4d7b-bc28-b4ad3e017331@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8891681e-532c-4d7b-bc28-b4ad3e017331@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 28, 2023 at 08:00:18PM +0100, Lorenzo Stoakes wrote:
> On Mon, Aug 28, 2023 at 06:32:40PM +0000, Joel Fernandes wrote:
> > On Sun, Aug 27, 2023 at 10:21:14AM +0100, Lorenzo Stoakes wrote:
> > [..]
> > > >
> > > >  /*
> > > >   * Flags used by change_protection().  For now we make it a bitmap so
> > > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > > index 035fbf542a8f..06baa13bd2c8 100644
> > > > --- a/mm/mremap.c
> > > > +++ b/mm/mremap.c
> > > > @@ -490,12 +490,13 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
> > > >  }
> > > >
> > > >  /*
> > > > - * A helper to check if a previous mapping exists. Required for
> > > > - * move_page_tables() and realign_addr() to determine if a previous mapping
> > > > - * exists before we can do realignment optimizations.
> > > > + * A helper to check if aligning down is OK. The aligned address should fall
> > > > + * on *no mapping*. For the stack moving down, that's a special move within
> > > > + * the VMA that is created to span the source and destination of the move,
> > > > + * so we make an exception for it.
> > > >   */
> > > >  static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
> > > > -			       unsigned long mask)
> > > > +			    unsigned long mask, bool for_stack)
> > > >  {
> > > >  	unsigned long addr_masked = addr_to_align & mask;
> > > >
> > > > @@ -504,7 +505,7 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
> > > >  	 * of the corresponding VMA, we can't align down or we will destroy part
> > > >  	 * of the current mapping.
> > > >  	 */
> > > > -	if (vma->vm_start != addr_to_align)
> > > > +	if (!for_stack && vma->vm_start != addr_to_align)
> > > >  		return false;
> > >
> > > I'm a little confused by this exception, is it very specifically for the
> > > shift_arg_pages() case where can assume we are safe to just discard the
> > > lower portion of the stack?
> > >
> > > Wouldn't the find_vma_intersection() line below fail in this case? I may be
> > > missing something here :)
> >
> > I think you are right. In v4, this was not an issue as we did this:
> >
> >
> > +	if (!for_stack && vma->vm_start != addr_to_align)
> > +		return false;
> > +
> > +	cur = find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
> > +	if (WARN_ON_ONCE(cur != vma))
> > +		return false;
> >
> > Which essentially means this patch is a NOOP in v5 for the stack case.
> 
> >
> > So what we really want is the VMA previous to @vma and whether than subsumes
> > the masked address.
> >
> > Should I just change it back to the v4 version then as above for both patch 1
> > and 2 and carry your review tags?
> 
> You will not be surprised to hear that I'd rather not :) I think if we did
> revert to that approach it'd need rework anyway, so I'd ask for a respin w/o
> tag if we were to go down that road.
> 
> HOWEVER let's first clarify what we want to check.
> 
> My understand (please correct me if mistaken) is that there are two
> acceptable cases:-
> 
> 1. !for_stack
> 
>  addr_masked         addr_to_align
>  |                   |
>  v                   v
>  .                   |-----|
>  . <-must be empty-> | vma |
>  .                   |-----|
> 
> 2. for_stack
> 
>       addr_masked         addr_to_align
>       |                   |
>       v                   v
>  |----.-------------------.-----|
>  |    .        vma        .     |
>  |----.-------------------.-----|
> 
> Meaning that there are only two cases that we should care about:-
> 
> 1. !for_stack: addr_to_align == vma->vm_start and no other VMA exists
>    between this and addr_masked
> 
> 2. for_stack: addr_masked is in the same VMA as addr_to_align.
> 
> In this case, the check can surely be:-
> 
> return find_vma_intersection(vma->vm_mm, addr_masked, addr_to_align) ==
> 	(for_stack ? vma : NULL);
> 
> (maybe would be less ugly to actually assign the intersection value to a
> local var and check that)

For completness: Lorenzo made some valid points on IRC and we'll do this
patch (2/7) like this for v6 after sufficient testing.

static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
                              unsigned long mask, bool for_stack)
{
       unsigned long addr_masked = addr_to_align & mask;
       /*
        * If @addr_to_align of either source or destination is not the beginning
        * of the corresponding VMA, we can't align down or we will destroy part
        * of the current mapping for cases other than the stack.
        */
       if (!for_stack && vma->vm_start != addr_to_align)
	       return false;

       /* In the stack case we explicitly permit in-VMA alignment. */
       if (for_stack && addr_masked >= vma->vm_start)
	       return true;

       /*
        * Make sure the realignment doesn't cause the address to fall on an
        * existing mapping.
        */
       return find_vma_intersection(vma->vm_mm, addr_masked, vma->vm_start) == NULL;
}

Thanks Lorenzo for the suggestion!

> >
> > This is also hard to test as it requires triggering the execve stack move
> > case. Though it is not a bug (as it is essentially a NOOP), it still would be
> > nice to test it. This is complicated by also the fact that mremap(2) itself
> > does not allow overlapping moves. I could try to hardcode the unfavorable
> > situation as I have done in the past to force that mremap warning.
> 
> I find this exception a bit confusing, why are we so adamant on performing
> the optimisation in this case when it makes the code uglier and is rather
> hard to understand? Does it really matter that much?

Let me know if you still felt it made the code uglier, but it looks like just
one more if() condition. And who knows may be in the future we want to do
such overlapping moves for other cases? ;)

> I wonder whether it wouldn't be better to just drop that (unless you really
> felt strongly about it) for the patch set and then perhaps address it in a
> follow up?
> This may entirely be a product of my simply not entirely understanding this
> case so do forgive the probing, I just want to make sure we handle it
> correctly!

It was just to avoid that false-positive warning where we can align down the
stack move to avoid warnings about zero'd PMDs. We could certainly do it in
this series or as a follow-up but since we came up with the above snippet, I
will keep it in this series for now and hopefully you are ok with that.

thanks,

 - Joel

