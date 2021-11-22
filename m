Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545AB458A3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Nov 2021 08:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhKVIBB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Nov 2021 03:01:01 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57590 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhKVIBB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Nov 2021 03:01:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 037AF1FD26;
        Mon, 22 Nov 2021 07:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637567874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZF5xXw9zNtBvqTaQuY36tdMOnR4DggMupqhddvnpPwA=;
        b=j6MkAuEHQYeK27pRuiuOjdstrnD3FzxHB5fBr3D2eMDWzgD71JKthyC+Id+HR0mtkH98Wp
        jZFJh88Wps0ZAe5yxKAB6c6daZlbv+q+4pjayCarknveqWdr2iLeGLdI1hQS2cCjbGdAf6
        BRsxMuVVinoRSkWTQVsFzIJMckdfoAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637567874;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZF5xXw9zNtBvqTaQuY36tdMOnR4DggMupqhddvnpPwA=;
        b=ng6ohqnlMGGOjaM4BN4G2ohohxv11hIUZaZGSEkNt9sR2ZXEQc3PnkuS98/0ANrMX6sD3E
        ysZcBrk1kY86PSBw==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DC895A3B84;
        Mon, 22 Nov 2021 07:57:53 +0000 (UTC)
Date:   Mon, 22 Nov 2021 08:57:53 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     jikos@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] livepatch: Allow user to specify functions to search
 for on a stack
In-Reply-To: <20211119182005.t3p5iyxyibzktrbj@treble>
Message-ID: <alpine.LSU.2.21.2111220853010.5064@pobox.suse.cz>
References: <20211119090327.12811-1-mbenes@suse.cz> <20211119090327.12811-3-mbenes@suse.cz> <20211119182005.t3p5iyxyibzktrbj@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 19 Nov 2021, Josh Poimboeuf wrote:

> Thanks for doing this!  And at peterz-esque speed no less :-)
> 
> On Fri, Nov 19, 2021 at 10:03:26AM +0100, Miroslav Benes wrote:
> > livepatch's consistency model requires that no live patched function
> > must be found on any task's stack during a transition process after a
> > live patch is applied. It is achieved by walking through stacks of all
> > blocked tasks.
> > 
> > The user might also want to define more functions to search for without
> > them being patched at all. It may either help with preparing a live
> > patch, which would otherwise require additional touches to achieve the
> > consistency
> 
> Do we have any examples of this situation we can add to the commit log?

I do not have anything at hand. Joe, do you remember the case you 
mentioned previously about adding a nop to a function?
 
> > or it can be used to overcome deficiencies the stack
> > checking inherently has. For example, GCC may optimize a function so
> > that a part of it is moved to a different section and the function would
> > jump to it. This child function would not be found on a stack in this
> > case, but it may be important to search for it so that, again, the
> > consistency is achieved.
> > 
> > Allow the user to specify such functions on klp_object level.
> > 
> > Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> > ---
> >  include/linux/livepatch.h     | 11 +++++++++++
> >  kernel/livepatch/core.c       | 16 ++++++++++++++++
> >  kernel/livepatch/transition.c | 21 ++++++++++++++++-----
> >  3 files changed, 43 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> > index 2614247a9781..89df578af8c3 100644
> > --- a/include/linux/livepatch.h
> > +++ b/include/linux/livepatch.h
> > @@ -106,9 +106,11 @@ struct klp_callbacks {
> >   * struct klp_object - kernel object structure for live patching
> >   * @name:	module name (or NULL for vmlinux)
> >   * @funcs:	function entries for functions to be patched in the object
> > + * @funcs_stack:	function entries for functions to be stack checked
> 
> So there are two arrays/lists of 'klp_func', and two implied meanings of
> what a 'klp_func' is and how it's initialized.
> 
> Might it be simpler and more explicit to just add a new external field
> to 'klp_func' and continue to have a single 'funcs' array?  Similar to
> what we already do with the special-casing of 'nop', except it would be
> an external field, e.g. 'no_patch' or 'stack_only'.
> 
> Then instead of all the extra klp_for_each_func_stack_static()
> incantations, and the special cases in higher-level callers like
> klp_init_object() and klp_init_patch_early(), the lower-level functions
> like klp_init_func() and klp_init_func_early() can check the field to
> determine which initializations need to be made.  Which is kind of nice
> IMO as it pushes that detail down more where it belongs.  And makes the
> different types of 'klp_func' more explicit.

I thought about doing this for a moment but then I was worried there would 
be many places which would require special-casing, so I tried to keep it 
separate. But yes, it would be cleaner, so definitely worth trying for v2.

Thanks

Miroslav
