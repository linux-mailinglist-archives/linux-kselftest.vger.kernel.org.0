Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68AD4746A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 16:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhLNPkQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 10:40:16 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40744 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhLNPkQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 10:40:16 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AD62A1F380;
        Tue, 14 Dec 2021 15:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639496414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ifxz1lKCmE/g43QksZUy3ckSVaIHzxPHQH8Kykd/fAI=;
        b=UMrpR2rdTQIBof6tuadhIyy/y+OkLSkwjwXFRI77YiJRKpXunQjni0wBdIXYde7HDb2TEs
        x6ZlNt20xKcNjESIPAOBvfdBpMJ/wsc12+toeey4yGJxEHiTNTuJDuoJ/0M3uOuigIFb+x
        HtB/jOC95SmoLqKAKxe9wKQQQMfPEp0=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 89AE3A3B8A;
        Tue, 14 Dec 2021 15:40:14 +0000 (UTC)
Date:   Tue, 14 Dec 2021 16:40:11 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, jikos@kernel.org,
        joe.lawrence@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] livepatch: Allow user to specify functions to
 search for on a stack
Message-ID: <Ybi6252hKwUM4KrP@alley>
References: <20211210124449.21537-1-mbenes@suse.cz>
 <20211210124449.21537-2-mbenes@suse.cz>
 <20211213190008.r4rjeytfz5ycbstb@treble>
 <alpine.LSU.2.21.2112140857570.20187@pobox.suse.cz>
 <YbiNsVfoCPCJmOKj@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbiNsVfoCPCJmOKj@alley>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue 2021-12-14 13:27:33, Petr Mladek wrote:
> On Tue 2021-12-14 09:47:59, Miroslav Benes wrote:
> > On Mon, 13 Dec 2021, Josh Poimboeuf wrote:
> > > On Fri, Dec 10, 2021 at 01:44:48PM +0100, Miroslav Benes wrote:
> > > > --- a/kernel/livepatch/transition.c
> > > > +++ b/kernel/livepatch/transition.c
> > > > @@ -200,7 +200,10 @@ static int klp_check_stack_func(struct klp_func *func, unsigned long *entries,
> > > >  	for (i = 0; i < nr_entries; i++) {
> > > >  		address = entries[i];
> > > >  
> > > > -		if (klp_target_state == KLP_UNPATCHED) {
> > > > +		if (func->stack_only) {
> > > > +			func_addr = (unsigned long)func->old_func;
> > > > +			func_size = func->old_size;
> > > > +		} else if (klp_target_state == KLP_UNPATCHED) {
> > > 
> > > Hm, what does this mean for the unpatching case?  What if the new
> > > function's .cold child is on the stack when we're trying to unpatch?
> > 
> > Good question. I did not realize it worked both ways. Of course it does.
> > 
> > > Would it make sense to allow the user specify a 'new_func' for
> > > stack_only, which is a func to check on the stack when unpatching?  Then
> > > new_func could point to the new .cold child.  And then
> > > klp_check_stack_func() wouldn't need a special case.
> 
> I am confused. My understanding is that .cold child is explicitly
> livepatched to the new .cold child like it is done in the selftest:
> 
> static struct klp_func funcs_stack_only[] = {
> 	{
> 		.old_name = "child_function",
> 		.new_func = livepatch_child_function,
> 	}, {
> 
> We should not need anything special to check it on stack.
> We only need to make sure that we check all .stack_only functions of
> the to-be-disabled livepatch.

We have discussed this with Miroslav and it seems to be even more
complicated. My current understanding is that we actually have
three functions involved:

  parent_func()
    call child_func()
      jmp child_func.cold

We livepatch child_func() that uses jmp and need not be on stack.
This is why we want to check parent_func() on stack.
For this, we define something like:

static struct klp_func funcs[] = {
	{
		.old_name = "child_func",
		.new_func = livepatch_child_func,   // livepatched func
	},
	{
		.old_name = "parent_func",
		.stack_only = true,		    // stack only
	},


Now, there might be the same problem with livepatch_child_func.
The call chain would be:

  parent_func()
    call child_func() ---> livepatch_child_func()
      jmp livepatch_child_func.cold


=> We need to check the very same parent_func() also when unpatching.


Note that already do the same for nops:

static struct klp_func *klp_alloc_func_nop(struct klp_func *old_func,
					   struct klp_object *obj)
{
[...]
	klp_init_func_early(obj, func);
	/*
	 * func->new_func is same as func->old_func. These addresses are
	 * set when the object is loaded, see klp_init_object_loaded().
	 */
	func->old_sympos = old_func->old_sympos;
	func->nop = true;
[...]
}

where

static int klp_init_object_loaded(struct klp_patch *patch,
				  struct klp_object *obj)
{
[...]
	if (func->nop)
			func->new_func = func->old_func;
[...]


This is another argument that we should somehow reuse the nops code
also for stack_only checks.

Does it make sense, please? ;-)

Best Regards,
Petr
