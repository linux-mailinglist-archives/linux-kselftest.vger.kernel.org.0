Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C77475ABE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 15:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237519AbhLOOhb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Dec 2021 09:37:31 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39990 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhLOOhb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Dec 2021 09:37:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A83BE1F3A3;
        Wed, 15 Dec 2021 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639579049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AqBRO/NIE3ZileUsayjziVQapZwhk+Tq0b/E/cvn/ng=;
        b=PY8PJ53frcTOAtDVC1yD5gzsDepo7ctC0J5IDL/nsb08PurypnC2bMah8Rkl6q5KeAI0mL
        utuh2KouFWhVWypn7Rb+N9ADIlw2jpdloFRrJi4LkqItzi5SDQn5y0PzdLntZEqPX8tDX3
        nWqsErkr57JurBNRKpx0xN+AnHDWEGc=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 84C6BA3B81;
        Wed, 15 Dec 2021 14:37:29 +0000 (UTC)
Date:   Wed, 15 Dec 2021 15:37:26 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, jikos@kernel.org,
        joe.lawrence@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] livepatch: Allow user to specify functions to
 search for on a stack
Message-ID: <Ybn9piT9Z83SKaCK@alley>
References: <20211210124449.21537-1-mbenes@suse.cz>
 <20211210124449.21537-2-mbenes@suse.cz>
 <20211213190008.r4rjeytfz5ycbstb@treble>
 <alpine.LSU.2.21.2112140857570.20187@pobox.suse.cz>
 <YbiNsVfoCPCJmOKj@alley>
 <Ybi6252hKwUM4KrP@alley>
 <20211214234836.3x3clp45ut6gtol6@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214234836.3x3clp45ut6gtol6@treble>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue 2021-12-14 15:48:36, Josh Poimboeuf wrote:
> On Tue, Dec 14, 2021 at 04:40:11PM +0100, Petr Mladek wrote:
> > > > > Hm, what does this mean for the unpatching case?  What if the new
> > > > > function's .cold child is on the stack when we're trying to unpatch?
> > > > 
> > > > Good question. I did not realize it worked both ways. Of course it does.
> > > > 
> > > > > Would it make sense to allow the user specify a 'new_func' for
> > > > > stack_only, which is a func to check on the stack when unpatching?  Then
> > > > > new_func could point to the new .cold child.  And then
> > > > > klp_check_stack_func() wouldn't need a special case.
> > > 
> > > I am confused. My understanding is that .cold child is explicitly
> > > livepatched to the new .cold child like it is done in the selftest:
> > > 
> > > static struct klp_func funcs_stack_only[] = {
> > > 	{
> > > 		.old_name = "child_function",
> > > 		.new_func = livepatch_child_function,
> > > 	}, {
> > > 
> > > We should not need anything special to check it on stack.
> > > We only need to make sure that we check all .stack_only functions of
> > > the to-be-disabled livepatch.
> > 
> > We have discussed this with Miroslav and it seems to be even more
> > complicated. My current understanding is that we actually have
> > three functions involved:
> > 
> >   parent_func()
> >     call child_func()
> >       jmp child_func.cold
> > 
> > We livepatch child_func() that uses jmp and need not be on stack.
> > This is why we want to check parent_func() on stack.
> > For this, we define something like:
> > 
> > static struct klp_func funcs[] = {
> > 	{
> > 		.old_name = "child_func",
> > 		.new_func = livepatch_child_func,   // livepatched func
> > 	},
> > 	{
> > 		.old_name = "parent_func",
> > 		.stack_only = true,		    // stack only
> > 	},
> 
> Hm, this is different than how I understand it.
> 
> In the past I referred to the "parent" as the function which jumps to
> the cold ("child") function.  So maybe we're getting confused by
> different terminology.  But here I'll go with the naming from your
> example.

I think that I was primary confused by the selftest where "child"
function is livepatched and "parent" is defined as stack_only.

Miroslav told me yesterday that the function that jumps into
the .cold child needs to get livepatched. It makes sense
because .cold child does not have well defined functionality.
It depends on the compiler what code is put there.
Hence I added one more level...

> If parent_func() is stack_only, that could create some false positive
> scenarios where patching stalls unnecessarily.

Yes, it won't be optimal.


> Also, wouldn't all of child_func()'s callers have to be made
> stack_only?

Well, we already do this when handling compiler optimizations,
for example, inlining.


> How would you definitively find all the callers?

Good question. The best solution would be to get support from
the compiler like we already get for another optimizations.

We always have these problems how to find functions that need
special handling for livepatching.


> Instead I was thinking child_func.cold() should be stack_only.
> 
> e.g.:
> 
> static struct klp_func funcs[] = {
> 	{
> 		.old_name = "child_func",
> 		.new_func = livepatch_child_func,
> 	},
> 	{
> 		.old_name = "child_func.cold",
> 		.new_name = "livepatch_child_func.cold",
> 		.stack_only = true,
> 	},
> 
> Any reason why that wouldn't work?

Yes, it should work in the given example. I am just curious how this
would work in practice:


  1. The compiler might optimize the new code another way and there
     need not be 1:1 relation.

     We might need another set of stack_only functions checked when
     the livepatch is enabled. And another set of functions checked
     when the livepatch gets disabled.


  2. The names of "child_func.cold" functions are generated by
     the compiler. I mean that the names are "strange" ;-)

     It is likely easier with the kPatch approach that creates glue
     around already compiled symbols. It is more tricky when preparing
     the livepatch from sources. Well, it is doable.


BTW: livepatch_child_func.cold function must be checked on the stack
     also when the livepatch is replaced by another livepatch.

     I mean that we need to check two sets of stack only functions
     when replacing one livepatch with another one:

	+ "new_name" functions from to-be-replaced livepatch (like when disabling)
	+ "old_name" functions from new livepatch (like when enabling)


Note that I do not have any strong opinion about any approach at the
moment. I primary want to be sure that I understand the problem correctly :-)

Best Regards,
Petr
