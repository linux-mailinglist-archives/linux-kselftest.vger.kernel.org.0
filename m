Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FA2476D2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 10:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbhLPJPO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 04:15:14 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44052 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbhLPJPN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 04:15:13 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1D8491F45C;
        Thu, 16 Dec 2021 09:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639646112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iCJETPFpLo2gcZMngHj4lclPO1rxr+YH1Y2lzIAxUxo=;
        b=bqDupYBuHiSglmKWfbAuI53QPCMraLxGb66kuE5EVlQU2lFuTUqxpEe89/3qBWfqHque3Z
        QrhYmBqNl9XnX7PrVil/DaEIimUWbNS6Okmnl7QRH0dJ2Kcx8p0vxd1czrgjaZezd9b3bF
        vYjNcORZO1A73HjCIKnL0EHpt+HC2C0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639646112;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iCJETPFpLo2gcZMngHj4lclPO1rxr+YH1Y2lzIAxUxo=;
        b=qvFUb4hBEpa5h3nlZb+lT0W9Vomy99O/PPTUryk/C8Ns1oM1lxgcFLP+CMHTnZYekcKqB8
        TNkWaAHs6EpXLZDw==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7C9E4A3B8C;
        Thu, 16 Dec 2021 09:15:07 +0000 (UTC)
Date:   Thu, 16 Dec 2021 10:15:11 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Petr Mladek <pmladek@suse.com>, jikos@kernel.org,
        joe.lawrence@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] livepatch: Allow user to specify functions to
 search for on a stack
In-Reply-To: <20211215184707.e3iagidkvnpx2fb4@treble>
Message-ID: <alpine.LSU.2.21.2112161002340.7559@pobox.suse.cz>
References: <20211210124449.21537-1-mbenes@suse.cz> <20211210124449.21537-2-mbenes@suse.cz> <20211213190008.r4rjeytfz5ycbstb@treble> <alpine.LSU.2.21.2112140857570.20187@pobox.suse.cz> <YbiNsVfoCPCJmOKj@alley> <Ybi6252hKwUM4KrP@alley> <20211214234836.3x3clp45ut6gtol6@treble>
 <Ybn9piT9Z83SKaCK@alley> <20211215184707.e3iagidkvnpx2fb4@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 15 Dec 2021, Josh Poimboeuf wrote:

> On Wed, Dec 15, 2021 at 03:37:26PM +0100, Petr Mladek wrote:
> > > Hm, this is different than how I understand it.
> > > 
> > > In the past I referred to the "parent" as the function which jumps to
> > > the cold ("child") function.  So maybe we're getting confused by
> > > different terminology.  But here I'll go with the naming from your
> > > example.
> > 
> > I think that I was primary confused by the selftest where "child"
> > function is livepatched and "parent" is defined as stack_only.
> 
> Ah, I guess I didn't look too closely at the selftest.

The selftest really does not help in understanding the problem. It is 
artificial just for the purpose of testing the API.

And as the discussion shows, there may be different scenarios in which the 
stack_only entries could be used. That does not help either.

Anyway...
 
> > > Instead I was thinking child_func.cold() should be stack_only.
> > > 
> > > e.g.:
> > > 
> > > static struct klp_func funcs[] = {
> > > 	{
> > > 		.old_name = "child_func",
> > > 		.new_func = livepatch_child_func,
> > > 	},
> > > 	{
> > > 		.old_name = "child_func.cold",
> > > 		.new_name = "livepatch_child_func.cold",
> > > 		.stack_only = true,
> > > 	},
> > > 
> > > Any reason why that wouldn't work?
> > 
> > Yes, it should work in the given example. I am just curious how this
> > would work in practice:
> > 
> > 
> >   1. The compiler might optimize the new code another way and there
> >      need not be 1:1 relation.
> >
> >      We might need another set of stack_only functions checked when
> >      the livepatch is enabled. And another set of functions checked
> >      when the livepatch gets disabled.
> 
> Regardless I'm thinking the above approach should be flexible enough.

Agreed. I think it is the best idea so far.
 
> If the patched child_func no longer has .cold, set 'new_name' to NULL in
> the stack_only entry.
> 
> If the original child_func doesn't have .cold, but patched child_func
> does, set 'old_name' to NULL in the stack_only entry.
> 
> If there were ever more than one of such "sub-functions" (which I
> believe currently doesn't happen), the author could create multiple
> stack_only entries.

All makes sense.

> >   2. The names of "child_func.cold" functions are generated by
> >      the compiler. I mean that the names are "strange" ;-)
> > 
> >      It is likely easier with the kPatch approach that creates glue
> >      around already compiled symbols. It is more tricky when preparing
> >      the livepatch from sources. Well, it is doable.
> 
> kpatch-build has checks for symbols with ".cold" substring.  I'm
> thinking it would be easy enough for you to do something similar since
> you're already checking for other compiler optimizations.

Yes, it should not be a problem.

> > BTW: livepatch_child_func.cold function must be checked on the stack
> >      also when the livepatch is replaced by another livepatch.
> > 
> >      I mean that we need to check two sets of stack only functions
> >      when replacing one livepatch with another one:
> > 
> > 	+ "new_name" functions from to-be-replaced livepatch (like when disabling)
> > 	+ "old_name" functions from new livepatch (like when enabling)
> 
> Urgh, this is starting to give me a headache.

Haha, it is always like this, isn't it? We come up with something which 
seems to be quite simple at the beginning and then all these different 
live patching features start to re-appear :D. I admit that it has already 
given me headaches.

> Could we put the cold funcs in a klp_ops func_stack to make this work
> automatically?

Maybe. It would definitely be nice to solve it for "almost free" somehow.

> Alternatively we could link the .cold functions to their non-cold
> counterparts somehow.  So when checking a function's stack, also check
> it's linked counterpart.  It could even be part of the original
> function's klp_func struct somehow, rather than having a dedicated
> klp_func struct for the stack_only thing.

On the other hand, we would lose an opportunity to have a solution also 
for non .cold cases. As Joe mentioned, he had to introduce artificial nops 
to functions just to have them in a final live patch. But yes, maybe it 
will end up as a too ambitious goal.

> Or we could just give up trying to abstract this entirely, and go back
> to Peter's suggestion to just always look for a ".cold" version of every
> function in klp_check_stack_func() :-)

No, not yet.

> I dunno...

I will prepare v3 and we will see then.

> > Note that I do not have any strong opinion about any approach at the
> > moment. I primary want to be sure that I understand the problem correctly :-)
> 
> Same here.

Thanks for the discussion. It definitely helps. I cannot say I 
understand the problem completely but it definitely helps :)

Miroslav
