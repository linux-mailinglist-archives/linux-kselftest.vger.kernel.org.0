Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2A778B7BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 21:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjH1TA5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 15:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjH1TA2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 15:00:28 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A80FF;
        Mon, 28 Aug 2023 12:00:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fea0640d7aso33892565e9.0;
        Mon, 28 Aug 2023 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693249221; x=1693854021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nWVaklve78TY8Ndro9SxAEjWhaM4lUPv6QRMiokVKjk=;
        b=A0HvRBvLv+ZUbs5yBJuawXPTe5T27ocbRvkAiVZCtL9aYA7Serw7K8Pd0SmR7bmDIw
         fgARXAfql8f4I5PQg8MvRrYZo0xxBJ34E/J/Bt9KSqsVxTPk4wuBNvpDXIllYAgY684X
         KJI9N1MhnDT37N8B3srSSWc5hWiwSVMBp33f3ghQCN29lJZurGCOorLkfx9KHQ5vjyLT
         LndP90pd3pEMda0uNE8eTHiWiRhLsunQti7oW4gGcaTy5Hue/MWXjRm1o/97zpNTg/aW
         wa1katQl0yOGTcsh/yZnbPC0QCmcZYrlDdyjAShClx5tKzIiGVS4rjyFLSZhkKhHJbId
         Xzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693249221; x=1693854021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWVaklve78TY8Ndro9SxAEjWhaM4lUPv6QRMiokVKjk=;
        b=G3tdaDPZ3qCJKkExbNCfc1otcl4aKT/oOHiv7rPlMdzOWLBo+BkpFsr+tzN97M0cOg
         ngBscEgV0OBKrrjHDB1LTnK9XXN+AeOQnAZ+Ag6svg32AAXX8MepclkrXnmD8TSPxz0M
         kOw0u12NMrPodIZeBNxduPabrcYJSUEJKvCwJJek9gS2q0JnISlHy2BUqyap5P9xLRg6
         oJr14OD1XUKaKRkcY3KxcnhSRQzoaDFTzyCCPWZxiy3HxdK8x79sgCRbfEmxg0o3Lw4r
         qpZmc0HNtuNZoLhrmGkWaQJcpDujkU1wRP2rC03R+2uD/v2KLqvpPtTckM4YKH2vsfR3
         eqjA==
X-Gm-Message-State: AOJu0YxEE8DcNF6nuO0ZRL+UKZKeRZl7Uny0XHukDGBaT6stDfIdIT/S
        MbmYT1zIaSvd11VyZfBG4p4=
X-Google-Smtp-Source: AGHT+IE1B2gPj/pPtcZ4/vI/oz1diEErn2Krz1vr8bos9oo17Wv8vTp0dxrT8KTKied+xZLC+qSgRw==
X-Received: by 2002:a7b:cc8e:0:b0:401:b3a5:ec03 with SMTP id p14-20020a7bcc8e000000b00401b3a5ec03mr8009357wma.1.1693249220534;
        Mon, 28 Aug 2023 12:00:20 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c234a00b003feeb082a9fsm11662696wmq.3.2023.08.28.12.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 12:00:19 -0700 (PDT)
Date:   Mon, 28 Aug 2023 20:00:18 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <8891681e-532c-4d7b-bc28-b4ad3e017331@lucifer.local>
References: <20230822015501.791637-1-joel@joelfernandes.org>
 <20230822015501.791637-3-joel@joelfernandes.org>
 <46196ba1-c54d-4c1d-954f-a0006602af99@lucifer.local>
 <20230828183240.GA1621761@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828183240.GA1621761@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 28, 2023 at 06:32:40PM +0000, Joel Fernandes wrote:
> On Sun, Aug 27, 2023 at 10:21:14AM +0100, Lorenzo Stoakes wrote:
> [..]
> > >
> > >  /*
> > >   * Flags used by change_protection().  For now we make it a bitmap so
> > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > index 035fbf542a8f..06baa13bd2c8 100644
> > > --- a/mm/mremap.c
> > > +++ b/mm/mremap.c
> > > @@ -490,12 +490,13 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
> > >  }
> > >
> > >  /*
> > > - * A helper to check if a previous mapping exists. Required for
> > > - * move_page_tables() and realign_addr() to determine if a previous mapping
> > > - * exists before we can do realignment optimizations.
> > > + * A helper to check if aligning down is OK. The aligned address should fall
> > > + * on *no mapping*. For the stack moving down, that's a special move within
> > > + * the VMA that is created to span the source and destination of the move,
> > > + * so we make an exception for it.
> > >   */
> > >  static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
> > > -			       unsigned long mask)
> > > +			    unsigned long mask, bool for_stack)
> > >  {
> > >  	unsigned long addr_masked = addr_to_align & mask;
> > >
> > > @@ -504,7 +505,7 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
> > >  	 * of the corresponding VMA, we can't align down or we will destroy part
> > >  	 * of the current mapping.
> > >  	 */
> > > -	if (vma->vm_start != addr_to_align)
> > > +	if (!for_stack && vma->vm_start != addr_to_align)
> > >  		return false;
> >
> > I'm a little confused by this exception, is it very specifically for the
> > shift_arg_pages() case where can assume we are safe to just discard the
> > lower portion of the stack?
> >
> > Wouldn't the find_vma_intersection() line below fail in this case? I may be
> > missing something here :)
>
> I think you are right. In v4, this was not an issue as we did this:
>
>
> +	if (!for_stack && vma->vm_start != addr_to_align)
> +		return false;
> +
> +	cur = find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
> +	if (WARN_ON_ONCE(cur != vma))
> +		return false;
>
> Which essentially means this patch is a NOOP in v5 for the stack case.

>
> So what we really want is the VMA previous to @vma and whether than subsumes
> the masked address.
>
> Should I just change it back to the v4 version then as above for both patch 1
> and 2 and carry your review tags?

You will not be surprised to hear that I'd rather not :) I think if we did
revert to that approach it'd need rework anyway, so I'd ask for a respin w/o
tag if we were to go down that road.

HOWEVER let's first clarify what we want to check.

My understand (please correct me if mistaken) is that there are two
acceptable cases:-

1. !for_stack

 addr_masked         addr_to_align
 |                   |
 v                   v
 .                   |-----|
 . <-must be empty-> | vma |
 .                   |-----|

2. for_stack

      addr_masked         addr_to_align
      |                   |
      v                   v
 |----.-------------------.-----|
 |    .        vma        .     |
 |----.-------------------.-----|

Meaning that there are only two cases that we should care about:-

1. !for_stack: addr_to_align == vma->vm_start and no other VMA exists
   between this and addr_masked

2. for_stack: addr_masked is in the same VMA as addr_to_align.

In this case, the check can surely be:-

return find_vma_intersection(vma->vm_mm, addr_masked, addr_to_align) ==
	(for_stack ? vma : NULL);

(maybe would be less ugly to actually assign the intersection value to a
local var and check that)

>
> This is also hard to test as it requires triggering the execve stack move
> case. Though it is not a bug (as it is essentially a NOOP), it still would be
> nice to test it. This is complicated by also the fact that mremap(2) itself
> does not allow overlapping moves. I could try to hardcode the unfavorable
> situation as I have done in the past to force that mremap warning.

I find this exception a bit confusing, why are we so adamant on performing
the optimisation in this case when it makes the code uglier and is rather
hard to understand? Does it really matter that much?

I wonder whether it wouldn't be better to just drop that (unless you really
felt strongly about it) for the patch set and then perhaps address it in a
follow up?

This may entirely be a product of my simply not entirely understanding this
case so do forgive the probing, I just want to make sure we handle it
correctly!

>
> thanks,
>
>  - Joel
>
