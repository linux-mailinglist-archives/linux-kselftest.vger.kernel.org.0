Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1B8473E9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 09:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhLNIsB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 03:48:01 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43114 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhLNIsB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 03:48:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D0BBA210EC;
        Tue, 14 Dec 2021 08:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639471679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XFPr1pHXMboRb2c/BebxhRx7JOxpZA9cTCwbWeNBo78=;
        b=kSFl+gnP0LtmGBv6gDDMX8xCX3SUdtZRe3j8GibmivZ2L9D5yUlRXGi+849g3rxtF5Y6pa
        U73YpbwkbpWiQMdIjZEIs5mZHcn1rFr+VWt9KWWKVlI+FPoPCNwjza/yRw7ZXtgqsQtxPG
        PlHtuqRZdt8NFqK2BSEQSc0wjBoZYKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639471679;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XFPr1pHXMboRb2c/BebxhRx7JOxpZA9cTCwbWeNBo78=;
        b=rI0ffrd6X++pFz3Ak0YMIIcliWBtxyqJP018zIST5NvPyni5SlL+aqTFIXQck4ovipWUKn
        LIhmnm5yeU5a4tCg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B1D44A3B81;
        Tue, 14 Dec 2021 08:47:59 +0000 (UTC)
Date:   Tue, 14 Dec 2021 09:47:59 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     jikos@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] livepatch: Allow user to specify functions to
 search for on a stack
In-Reply-To: <20211213190008.r4rjeytfz5ycbstb@treble>
Message-ID: <alpine.LSU.2.21.2112140857570.20187@pobox.suse.cz>
References: <20211210124449.21537-1-mbenes@suse.cz> <20211210124449.21537-2-mbenes@suse.cz> <20211213190008.r4rjeytfz5ycbstb@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 13 Dec 2021, Josh Poimboeuf wrote:

> On Fri, Dec 10, 2021 at 01:44:48PM +0100, Miroslav Benes wrote:
> > --- a/include/linux/livepatch.h
> > +++ b/include/linux/livepatch.h
> > @@ -29,6 +29,8 @@
> >   * @new_func:	pointer to the patched function code
> >   * @old_sympos: a hint indicating which symbol position the old function
> >   *		can be found (optional)
> > + * @stack_only:	only search for the function (specified by old_name) on any
> > + * 		task's stack
> 
> This should probably make it clear that it doesn't actually patch the
> function.  How about something like:
> 
>  * @stack_only:	don't patch old_func; only make sure it's not on the stack

Definitely better, thanks. 
 
> >   * @old_func:	pointer to the function being patched
> >   * @kobj:	kobject for sysfs resources
> >   * @node:	list node for klp_object func_list
> > @@ -66,6 +68,7 @@ struct klp_func {
> >  	 * in kallsyms for the given object is used.
> >  	 */
> >  	unsigned long old_sympos;
> > +	bool stack_only;
> >  
> >  	/* internal */
> >  	void *old_func;
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index 335d988bd811..62ff4180dc9b 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -89,6 +89,10 @@ static struct klp_func *klp_find_func(struct klp_object *obj,
> >  	struct klp_func *func;
> >  
> >  	klp_for_each_func(obj, func) {
> > +		/* Do not create nop klp_func for stack_only function */
> > +		if (func->stack_only)
> > +			return func;
> > +
> 
> This has me confused.  Maybe I'm missing something.
> 
> First, klp_find_func() is a surprising place for this behavior.

You are right, it is not a nice place.
 
> Second, if obj's first func happens to be stack_only, this will short
> circuit the rest of the list traversal and will effectively prevent nops
> for all the rest of the funcs, even if they're *not* stack_only.

Oh, of course.

> Third, I'm not sure this approach would even make sense.  I was thinking
> there are two special cases to consider:
> 
> 1) If old_func is stack_only, that's effectively the same as !old_func,
>    in which case we don't need a nop.

Correct.

> 2) If old_func is *not* stack_only, but new_func *is* stack_only, that's
>    effectively the same as (old_func && !new_func), in which case we
>    *do* want a nop.  Since new_func already exists, we can just convert
>    it from stack_only to nop.

And I somehow missed this case.

> Does that make sense?  Or am I missing something?
> 
> For example:
> 
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -536,9 +536,23 @@ static int klp_add_object_nops(struct klp_patch *patch,
>  	}
>  
>  	klp_for_each_func(old_obj, old_func) {
> +		if (old_func->stack_only) {
> +			/* equivalent to !old_func; no nop needed */
> +			continue;
> +		}

Nicer.

>  		func = klp_find_func(obj, old_func);
> -		if (func)
> +		if (func) {
> +			if (func->stack_only) {
> +				/*
> +				 * equivalent to (old_func && !new_func);
> +				 * convert stack_only to nop:
> +				 */
> +				func->stack_only = false;
> +				func->nop = true;
> +			}
> +
>  			continue;
> +		}
>
>  		func = klp_alloc_func_nop(old_func, obj);
>  		if (!func)

I think that it cannot be that straightforward. We assume that nop 
functions are allocated dynamically elsewhere in the code, so the 
conversion here from a stack_only function to a nop would cause troubles. 
I like the idea though. We would also need to set func->new_func for it 
and there may be some more places to handle, which I am missing now.

If I understood it correctly, Petr elsewhere in the thread proposed to 
ignore nop functions completely. They would be allocated, not used and 
discarded once a replace live patch is applied. I did not like the idea, 
because it seemed hacky. And it would probably suffer from similar issues 
as the above.
 
> And while we're at it, we may want to rename "{func,obj}" to
> "new_{func,obj}" for those functions which have "old_{func,obj}".  It
> would help prevent confusion between the two.

Yes, the naming here does not help.

> >  		if ((strcmp(old_func->old_name, func->old_name) == 0) &&
> >  		    (old_func->old_sympos == func->old_sympos)) {
> >  			return func;
> > @@ -499,6 +503,17 @@ static struct klp_func *klp_alloc_func_nop(struct klp_func *old_func,
> >  	return func;
> >  }
> >  
> > +static bool klp_is_object_stack_only(struct klp_object *old_obj)
> > +{
> > +	struct klp_func *old_func;
> > +
> > +	klp_for_each_func(old_obj, old_func)
> > +		if (!old_func->stack_only)
> > +			return false;
> > +
> > +	return true;
> > +}
> > +
> >  static int klp_add_object_nops(struct klp_patch *patch,
> >  			       struct klp_object *old_obj)
> >  {
> > @@ -508,6 +523,13 @@ static int klp_add_object_nops(struct klp_patch *patch,
> >  	obj = klp_find_object(patch, old_obj);
> >  
> >  	if (!obj) {
> > +		/*
> > +		 * Do not create nop klp_object for old_obj which contains
> > +		 * stack_only functions only.
> > +		 */
> > +		if (klp_is_object_stack_only(old_obj))
> > +			return 0;
> 
> This code is already pretty self explanatory and the comment isn't
> needed IMO.

Ok.

> > +
> >  		obj = klp_alloc_object_dynamic(old_obj->name, patch);
> >  		if (!obj)
> >  			return -ENOMEM;
> > @@ -723,8 +745,9 @@ static int klp_init_func(struct klp_object *obj, struct klp_func *func)
> >  	/*
> >  	 * NOPs get the address later. The patched module must be loaded,
> >  	 * see klp_init_object_loaded().
> > +	 * stack_only functions do not get new_func addresses at all.
> >  	 */
> > -	if (!func->new_func && !func->nop)
> > +	if (!func->new_func && !func->nop && !func->stack_only)
> >  		return -EINVAL;
> 
> Same here, I'm not sure this comment really helps.

Hm, I think the original comment is useful and it would be strange to add 
a new check without extending it. I can remove the hunk, no problem.

> >  
> >  	if (strlen(func->old_name) >= KSYM_NAME_LEN)
> > @@ -804,6 +827,9 @@ static int klp_init_object_loaded(struct klp_patch *patch,
> >  		if (func->nop)
> >  			func->new_func = func->old_func;
> >  
> > +		if (func->stack_only)
> > +			continue;
> > +
> >  		ret = kallsyms_lookup_size_offset((unsigned long)func->new_func,
> >  						  &func->new_size, NULL);
> >  		if (!ret) {
> > diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
> > index fe316c021d73..221ed691cc7f 100644
> > --- a/kernel/livepatch/patch.c
> > +++ b/kernel/livepatch/patch.c
> > @@ -250,6 +250,9 @@ static void __klp_unpatch_object(struct klp_object *obj, bool nops_only)
> >  		if (nops_only && !func->nop)
> >  			continue;
> >  
> > +		if (func->stack_only)
> > +			continue;
> > +
> >  		if (func->patched)
> >  			klp_unpatch_func(func);
> >  	}
> > @@ -273,6 +276,9 @@ int klp_patch_object(struct klp_object *obj)
> >  		return -EINVAL;
> >  
> >  	klp_for_each_func(obj, func) {
> > +		if (func->stack_only)
> > +			continue;
> > +
> 
> Instead of these stack_only checks, we might want to add a new
> klp_for_each_patchable_func() macro.  It could also be used in
> klp_add_object_nops() to filter out old_func->stack_only.

Maybe. On the other hand, I like the explicit check here and there. Will 
consider...
 
> >  		ret = klp_patch_func(func);
> >  		if (ret) {
> >  			klp_unpatch_object(obj);
> > diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> > index 5683ac0d2566..fa0630fcab1a 100644
> > --- a/kernel/livepatch/transition.c
> > +++ b/kernel/livepatch/transition.c
> > @@ -200,7 +200,10 @@ static int klp_check_stack_func(struct klp_func *func, unsigned long *entries,
> >  	for (i = 0; i < nr_entries; i++) {
> >  		address = entries[i];
> >  
> > -		if (klp_target_state == KLP_UNPATCHED) {
> > +		if (func->stack_only) {
> > +			func_addr = (unsigned long)func->old_func;
> > +			func_size = func->old_size;
> > +		} else if (klp_target_state == KLP_UNPATCHED) {
> 
> Hm, what does this mean for the unpatching case?  What if the new
> function's .cold child is on the stack when we're trying to unpatch?

Good question. I did not realize it worked both ways. Of course it does.

> Would it make sense to allow the user specify a 'new_func' for
> stack_only, which is a func to check on the stack when unpatching?  Then
> new_func could point to the new .cold child.  And then
> klp_check_stack_func() wouldn't need a special case.

Maybe. klp_check_stack_func() would still need a special case, no? It 
would just move down to KLP_PATCHED case. Or, the check after 
klp_find_ops() would have to be improved, but I would like the explicit 
check for stack_only better.

Thanks for the review.

Miroslav
