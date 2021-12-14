Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F389847427F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 13:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhLNM1f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 07:27:35 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46226 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhLNM1e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 07:27:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 51C711F380;
        Tue, 14 Dec 2021 12:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639484853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/vtCa4X9EeHa4NmqgJD0LocTS511LuBQcnhnaHkSHsI=;
        b=oW1U82IaEHpPuKr7ZgBj8+IrWxS3aWgotHcRHusVg74u6X7IrPUmQHs+Yi5+9I8mTA7Zh2
        d90eB61fVtv3ZUSV5FWk2Bt9LEN/PG7bVVspGdXTxVXqE4T14msKoqEIbDJDY/6xeTCGak
        /JqPq9pxvnVTqg3C6E+ejRtnjFeyP5k=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 31572A3B85;
        Tue, 14 Dec 2021 12:27:33 +0000 (UTC)
Date:   Tue, 14 Dec 2021 13:27:29 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, jikos@kernel.org,
        joe.lawrence@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] livepatch: Allow user to specify functions to
 search for on a stack
Message-ID: <YbiNsVfoCPCJmOKj@alley>
References: <20211210124449.21537-1-mbenes@suse.cz>
 <20211210124449.21537-2-mbenes@suse.cz>
 <20211213190008.r4rjeytfz5ycbstb@treble>
 <alpine.LSU.2.21.2112140857570.20187@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2112140857570.20187@pobox.suse.cz>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue 2021-12-14 09:47:59, Miroslav Benes wrote:
> On Mon, 13 Dec 2021, Josh Poimboeuf wrote:
> > On Fri, Dec 10, 2021 at 01:44:48PM +0100, Miroslav Benes wrote:
> > Second, if obj's first func happens to be stack_only, this will short
> > circuit the rest of the list traversal and will effectively prevent nops
> > for all the rest of the funcs, even if they're *not* stack_only.
> 
> Oh, of course.
> 
> > Third, I'm not sure this approach would even make sense.  I was thinking
> > there are two special cases to consider:
> > 
> > 1) If old_func is stack_only, that's effectively the same as !old_func,
> >    in which case we don't need a nop.
> 
> Correct.
> 
> > 2) If old_func is *not* stack_only, but new_func *is* stack_only, that's
> >    effectively the same as (old_func && !new_func), in which case we
> >    *do* want a nop.  Since new_func already exists, we can just convert
> >    it from stack_only to nop.
> 
> And I somehow missed this case.
> 
> > Does that make sense?  Or am I missing something?
> > 
> > For example:
> > 
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -536,9 +536,23 @@ static int klp_add_object_nops(struct klp_patch *patch,
> >  	}
> >  
> >  	klp_for_each_func(old_obj, old_func) {
> > +		if (old_func->stack_only) {
> > +			/* equivalent to !old_func; no nop needed */
> > +			continue;
> > +		}
> 
> Nicer.
> 
> >  		func = klp_find_func(obj, old_func);
> > -		if (func)
> > +		if (func) {
> > +			if (func->stack_only) {
> > +				/*
> > +				 * equivalent to (old_func && !new_func);
> > +				 * convert stack_only to nop:
> > +				 */
> > +				func->stack_only = false;
> > +				func->nop = true;
> > +			}
> > +
> >  			continue;
> > +		}
> >
> >  		func = klp_alloc_func_nop(old_func, obj);
> >  		if (!func)
> 
> I think that it cannot be that straightforward. We assume that nop 
> functions are allocated dynamically elsewhere in the code, so the 
> conversion here from a stack_only function to a nop would cause troubles. 
> I like the idea though. We would also need to set func->new_func for it 
> and there may be some more places to handle, which I am missing now.

Yup. It is not that easy because nops are dynamically allocated and
are freed after the transition is completed.

Well, stack_only has the same effect as nop from the livepatching POV.
Both are checked on stack and both do not redirect the code. The only
difference is that stack_only struct klp_func is static. It need not
be allocated and need not be freed.


> If I understood it correctly, Petr elsewhere in the thread proposed to 
> ignore nop functions completely. They would be allocated, not used and 
> discarded once a replace live patch is applied. I did not like the idea, 
> because it seemed hacky. And it would probably suffer from similar issues 
> as the above.

This is probably misunderstanding. I proposed to do not register the
ftrace handler for stack_only entries. But it would work only when
there is not already registered ftrace handler from another livepatch.
So, I agree that it is a bad idea.

Better solution seems to handle stack_only entries the same way as
nops except for the allocation/freeing.


> > > --- a/kernel/livepatch/transition.c
> > > +++ b/kernel/livepatch/transition.c
> > > @@ -200,7 +200,10 @@ static int klp_check_stack_func(struct klp_func *func, unsigned long *entries,
> > >  	for (i = 0; i < nr_entries; i++) {
> > >  		address = entries[i];
> > >  
> > > -		if (klp_target_state == KLP_UNPATCHED) {
> > > +		if (func->stack_only) {
> > > +			func_addr = (unsigned long)func->old_func;
> > > +			func_size = func->old_size;
> > > +		} else if (klp_target_state == KLP_UNPATCHED) {
> > 
> > Hm, what does this mean for the unpatching case?  What if the new
> > function's .cold child is on the stack when we're trying to unpatch?
> 
> Good question. I did not realize it worked both ways. Of course it does.
> 
> > Would it make sense to allow the user specify a 'new_func' for
> > stack_only, which is a func to check on the stack when unpatching?  Then
> > new_func could point to the new .cold child.  And then
> > klp_check_stack_func() wouldn't need a special case.

I am confused. My understanding is that .cold child is explicitly
livepatched to the new .cold child like it is done in the selftest:

static struct klp_func funcs_stack_only[] = {
	{
		.old_name = "child_function",
		.new_func = livepatch_child_function,
	}, {

We should not need anything special to check it on stack.
We only need to make sure that we check all .stack_only functions of
the to-be-disabled livepatch.

Best Regards,
Petr
