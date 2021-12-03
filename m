Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B451C467ABA
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 17:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381908AbhLCQFG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 11:05:06 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57264 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381936AbhLCQFF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 11:05:05 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 74C321FD40;
        Fri,  3 Dec 2021 16:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638547300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6kmj6FkNW7pdbamCY/i7YAKxLc+ZwPDjSg5TIPovyCs=;
        b=JGyaEAQ7zADbpOQKGAgbWAtQ0Mh3RjdwjxU8R89zemt0D4dteICmGj99fEn3OFeGnMR8aj
        yc9eQUG79lfYtEBEOtzZRrAl0Y3jWvNe0krnKOxeACFaljCDXk6aTlm34yXtkNuOVQHYN+
        /EIIMJaItTmaoWg7QRPOBIDWicwC7sw=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4B968A3B83;
        Fri,  3 Dec 2021 16:01:40 +0000 (UTC)
Date:   Fri, 3 Dec 2021 17:01:37 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, jikos@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] livepatch: Allow user to specify functions to search
 for on a stack
Message-ID: <Yao/YQlP0kz+lwdN@alley>
References: <YZ9gfPuCTmDmOj9h@alley>
 <alpine.LSU.2.21.2111251110130.28836@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2111251110130.28836@pobox.suse.cz>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 2021-11-25 11:20:04, Miroslav Benes wrote:
> On Thu, 25 Nov 2021, Petr Mladek wrote:
> > On Mon 2021-11-22 10:53:21, Joe Lawrence wrote:
> > > On 11/22/21 2:57 AM, Miroslav Benes wrote:
> > > > On Fri, 19 Nov 2021, Josh Poimboeuf wrote:
> > > >>> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> > > >>> index 2614247a9781..89df578af8c3 100644
> > > >>> --- a/include/linux/livepatch.h
> > > >>> +++ b/include/linux/livepatch.h
> > > >>> @@ -106,9 +106,11 @@ struct klp_callbacks {
> > > >>>   * struct klp_object - kernel object structure for live patching
> > > >>>   * @name:	module name (or NULL for vmlinux)
> > > >>>   * @funcs:	function entries for functions to be patched in the object
> > > >>> + * @funcs_stack:	function entries for functions to be stack checked
> > > >>
> > > >> So there are two arrays/lists of 'klp_func', and two implied meanings of
> > > >> what a 'klp_func' is and how it's initialized.
> > > >>
> > > >> Might it be simpler and more explicit to just add a new external field
> > > >> to 'klp_func' and continue to have a single 'funcs' array?  Similar to
> > > >> what we already do with the special-casing of 'nop', except it would be
> > > >> an external field, e.g. 'no_patch' or 'stack_only'.
> > > 
> > > I'll add that the first thing that came to mind when you raised this
> > > feature idea in the other thread was to support existing klp_funcs array
> > > with NULL new_func's.
> > 
> > Please, solve this with the extra flag, e.g. .stack_only, as
> > already suggested. It will help to distinguish mistakes and
> > intentions. Also it will allow to find these symbols by grep.
> 
> Indeed, that is what I did for v2. I used new_func being NULL fact even in 
> v1, but I do not like it much. Extra flag is definitely more robust.
>  
> > > I didn't go look to see how invasive it would be,
> > > but it will be interesting to see if a single list approach turns out
> > > any simpler for v2.
> > 
> > I am not sure either. But I expect that it will be easier than
> > the extra array.
> 
> So, extra flag and one array makes certain things (initialization) 
> definitely easier. On the other hand, there are suddenly more problems to 
> think about (and I haven't solved them yet):
> 
>   - I need to make it work with nops functions. Especially if we allow a 
>     scenario where there could be klp_object instance with just stack_only 
>     functions. Would that be useful? For example, to patch something in a 
>     module and add a stack_only for a function in vmlinux.

My naive expectation is that the struct klp_func with @stack_only
flag might be handled the same way on most locations, except when:

   + func->new_func is handled
   + ftrace handler is added/removed

Something like:

--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -724,7 +724,7 @@ static int klp_init_func(struct klp_object *obj, struct klp_func *func)
 	 * NOPs get the address later. The patched module must be loaded,
 	 * see klp_init_object_loaded().
 	 */
-	if (!func->new_func && !func->nop)
+	if (!func->new_func && !func->nop && !func->stack_only)
 		return -EINVAL;
 
 	if (strlen(func->old_name) >= KSYM_NAME_LEN)
@@ -801,6 +801,9 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 			return -ENOENT;
 		}
 
+		if (func->stack_only)
+			continue;
+
 		if (func->nop)
 			func->new_func = func->old_func;
 
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -247,6 +247,9 @@ static void __klp_unpatch_object(struct klp_object *obj, bool nops_only)
 	struct klp_func *func;
 
 	klp_for_each_func(obj, func) {
+		if (func->stack_only)
+			continue;
+
 		if (nops_only && !func->nop)
 			continue;
 
@@ -273,6 +276,8 @@ int klp_patch_object(struct klp_object *obj)
 		return -EINVAL;
 
 	klp_for_each_func(obj, func) {
+		if (func->stack_only)
+			continue;
 		ret = klp_patch_func(func);
 		if (ret) {
 			klp_unpatch_object(obj);


>     If yes, then the interaction with nops is not completely 
>     straightforward and also some parts of the code would have to be 
>     changed (for example how obj->patched flag is handled).

I would keep func->patched disabled for @stack_only entries.

But they should not affect obj->patched state. I mean that
obj->patched should be set when the patch is enabled even when
there are only "stack_only" funcs.

It might look a bit unclear. A solution might be to rename the flags:

   + func->patched    ->   func->active   (and set even for @stack_only)
   + obj->patched     ->   obj->active    (same as func)

But I am not sure if it is worth it.


>   - klp_func instances are directly mirrored in sysfs. Do we want to keep 
>     stack_only functions there too? If not, it makes the whole thing 
>     slighly more difficult given how we manage kobjects.

I would keep them in sysfs. It will be easier and it does not harm.

> Nothing really difficult to implement if we come up with answers.

I am sorry for not answering this earlier. I have missed the questions :-(

Best Regards,
Petr
