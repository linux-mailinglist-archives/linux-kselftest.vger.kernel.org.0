Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF8A45D829
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Nov 2021 11:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354492AbhKYKZS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Nov 2021 05:25:18 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58636 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354371AbhKYKXQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Nov 2021 05:23:16 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B53131FDF1;
        Thu, 25 Nov 2021 10:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637835604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v8y1Z8l+5H9ro6ZVY0cIqzUQoY7K3Ii5PzPw9rqgiog=;
        b=Oz4Tou4rY7D3CRTHB/8XRcvrxXYWXjXgRs+MlRJv8eam6yROSItADJ8Xv0KmxRytSxyAX0
        3M/6XOhxuq02Y0d8VvAHUHISl6HkqK6+Q3KvUDjtxR1ah8AujLyW3NTaOclufcBtjBIlt2
        BAW9HzDIXIx50FZcDKEYPcm4Y3FKP1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637835604;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v8y1Z8l+5H9ro6ZVY0cIqzUQoY7K3Ii5PzPw9rqgiog=;
        b=vCBayQ62J4CWmGJvUSjxsyVXXq8fnWA4wL4Ins9My+sbokGjinxAFCllutZKr/gM7S+UZQ
        0oze1KIHLc34pWBw==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9D32AA3B83;
        Thu, 25 Nov 2021 10:20:04 +0000 (UTC)
Date:   Thu, 25 Nov 2021 11:20:04 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, jikos@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] livepatch: Allow user to specify functions to search
 for on a stack
In-Reply-To: <YZ9gfPuCTmDmOj9h@alley>
Message-ID: <alpine.LSU.2.21.2111251110130.28836@pobox.suse.cz>
References: <YZ9gfPuCTmDmOj9h@alley>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 25 Nov 2021, Petr Mladek wrote:

> On Mon 2021-11-22 10:53:21, Joe Lawrence wrote:
> > On 11/22/21 2:57 AM, Miroslav Benes wrote:
> > > On Fri, 19 Nov 2021, Josh Poimboeuf wrote:
> > > 
> > >> Thanks for doing this!  And at peterz-esque speed no less :-)
> > >>
> > >> On Fri, Nov 19, 2021 at 10:03:26AM +0100, Miroslav Benes wrote:
> > >>> livepatch's consistency model requires that no live patched function
> > >>> must be found on any task's stack during a transition process after a
> > >>> live patch is applied. It is achieved by walking through stacks of all
> > >>> blocked tasks.
> > >>>
> > >>> The user might also want to define more functions to search for without
> > >>> them being patched at all. It may either help with preparing a live
> > >>> patch, which would otherwise require additional touches to achieve the
> > >>> consistency
> > >>
> > >> Do we have any examples of this situation we can add to the commit log?
> > > 
> > > I do not have anything at hand. Joe, do you remember the case you 
> > > mentioned previously about adding a nop to a function?
> > 
> > Maybe adding a hypothetical scenario to the commit log would suffice?
> 
> I wonder if we could describe a scenario based on the thread about
> .cold code variants, see
> https://lore.kernel.org/all/20211112015003.pefl656m3zmir6ov@treble/
> 
> This feature would allow to safely livepatch already released
> kernels where the unwinder is not able to reliably detect
> a newly discovered problems.

and is described (well, without actually using .cold suffix) a few lines 
below. I'll try to improve the changelog.
 
> > >>> or it can be used to overcome deficiencies the stack
> > >>> checking inherently has. For example, GCC may optimize a function so
> > >>> that a part of it is moved to a different section and the function would
> > >>> jump to it. This child function would not be found on a stack in this
> > >>> case, but it may be important to search for it so that, again, the
> > >>> consistency is achieved.
> > >>>
> > >>> Allow the user to specify such functions on klp_object level.
> > >>>
> > >>> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> > >>> ---
> > >>>  include/linux/livepatch.h     | 11 +++++++++++
> > >>>  kernel/livepatch/core.c       | 16 ++++++++++++++++
> > >>>  kernel/livepatch/transition.c | 21 ++++++++++++++++-----
> > >>>  3 files changed, 43 insertions(+), 5 deletions(-)
> > >>>
> > >>> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> > >>> index 2614247a9781..89df578af8c3 100644
> > >>> --- a/include/linux/livepatch.h
> > >>> +++ b/include/linux/livepatch.h
> > >>> @@ -106,9 +106,11 @@ struct klp_callbacks {
> > >>>   * struct klp_object - kernel object structure for live patching
> > >>>   * @name:	module name (or NULL for vmlinux)
> > >>>   * @funcs:	function entries for functions to be patched in the object
> > >>> + * @funcs_stack:	function entries for functions to be stack checked
> > >>
> > >> So there are two arrays/lists of 'klp_func', and two implied meanings of
> > >> what a 'klp_func' is and how it's initialized.
> > >>
> > >> Might it be simpler and more explicit to just add a new external field
> > >> to 'klp_func' and continue to have a single 'funcs' array?  Similar to
> > >> what we already do with the special-casing of 'nop', except it would be
> > >> an external field, e.g. 'no_patch' or 'stack_only'.
> > 
> > I'll add that the first thing that came to mind when you raised this
> > feature idea in the other thread was to support existing klp_funcs array
> > with NULL new_func's.
> 
> Please, solve this with the extra flag, e.g. .stack_only, as
> already suggested. It will help to distinguish mistakes and
> intentions. Also it will allow to find these symbols by grep.

Indeed, that is what I did for v2. I used new_func being NULL fact even in 
v1, but I do not like it much. Extra flag is definitely more robust.
 
> > I didn't go look to see how invasive it would be,
> > but it will be interesting to see if a single list approach turns out
> > any simpler for v2.
> 
> I am not sure either. But I expect that it will be easier than
> the extra array.

So, extra flag and one array makes certain things (initialization) 
definitely easier. On the other hand, there are suddenly more problems to 
think about (and I haven't solved them yet):

  - I need to make it work with nops functions. Especially if we allow a 
    scenario where there could be klp_object instance with just stack_only 
    functions. Would that be useful? For example, to patch something in a 
    module and add a stack_only for a function in vmlinux.
 
    If yes, then the interaction with nops is not completely 
    straightforward and also some parts of the code would have to be 
    changed (for example how obj->patched flag is handled).

  - klp_func instances are directly mirrored in sysfs. Do we want to keep 
    stack_only functions there too? If not, it makes the whole thing 
    slighly more difficult given how we manage kobjects.

Nothing really difficult to implement if we come up with answers.

Miroslav
