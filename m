Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A418476100
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 19:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343946AbhLOSrO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Dec 2021 13:47:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25575 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343943AbhLOSrN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Dec 2021 13:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639594033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lKY7EwD35q6WS2L2MqJxnfYmiBbs4WYU4qRfF0IbNkc=;
        b=Vp0XOFjz9cK2+YHTlfOzIzGPl+7K8lEBbDAIFrtwmGQahyDY3KMJp4fX37gCG3uxP+1Ljw
        9nz/5meNtz3AtwE/BUudFh6BL5dQpFRLy1U9AhCN4UIDlxzQVoG/pOo2fr0kHAtS/VKxJo
        xZtPHNpctblFynW4Cpqxzjr+VpHBMI8=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-rT85dNE1N4umqGbqyBLE8w-1; Wed, 15 Dec 2021 13:47:12 -0500
X-MC-Unique: rT85dNE1N4umqGbqyBLE8w-1
Received: by mail-ot1-f72.google.com with SMTP id f3-20020a9d6c03000000b0055c9d337de8so10243267otq.13
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Dec 2021 10:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lKY7EwD35q6WS2L2MqJxnfYmiBbs4WYU4qRfF0IbNkc=;
        b=BBOrwF385c5jTr9/mzDBMHCWTh7WftVBK8nqMOBv5IUPk1xcNeuCJ0vYv49pQs3OAQ
         /VAPSfJ0sChwtGoBRu0G8Cn2TMP0YL6kE6OXQHFsCoMAye6Dz37xf60/kW+SbVbinWyP
         uSljkFeEwxKCfZq9iAEcF+cHBJyEwVhiOC9CVO3u/foB3FHRS/CLH/dUNywKriTyvug5
         lWmJN75C7wq/9t0GKNL3shgdcebpBpqbtyOmWp1l/EZvogS4BJjSbhUFM3L0ik2TShLp
         yi4y/x23V3HUQM4QTyaCiTWg19n3ioEVG4CWs3anr34DvkZhw9Q8xj9OjN/Q2aBsQX0b
         3qlA==
X-Gm-Message-State: AOAM530vjdB2bfrLK78V4UambYgHzZVpOvmxdSX+vzWnOLEYgdx5I6Gr
        BeRqK8hmFebpRUnTUWEqAZExxAEG8uwud6bmO0AXnIkL14Cr3ZodrDiUsHpEEI3D+wwhWOXRb00
        zRSkA+15xuI3PKK0pv6woSTRVCNA6
X-Received: by 2002:a05:6830:442a:: with SMTP id q42mr9979383otv.385.1639594030936;
        Wed, 15 Dec 2021 10:47:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7tdoVycqReg+zBeRcXonNSCNGRuHqvtLWZQ7ha4DQnH/9nu6QOECMTd84iAOMu7T+0jBsgg==
X-Received: by 2002:a05:6830:442a:: with SMTP id q42mr9979356otv.385.1639594030598;
        Wed, 15 Dec 2021 10:47:10 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id l6sm565290otu.12.2021.12.15.10.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 10:47:10 -0800 (PST)
Date:   Wed, 15 Dec 2021 10:47:07 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, jikos@kernel.org,
        joe.lawrence@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] livepatch: Allow user to specify functions to
 search for on a stack
Message-ID: <20211215184707.e3iagidkvnpx2fb4@treble>
References: <20211210124449.21537-1-mbenes@suse.cz>
 <20211210124449.21537-2-mbenes@suse.cz>
 <20211213190008.r4rjeytfz5ycbstb@treble>
 <alpine.LSU.2.21.2112140857570.20187@pobox.suse.cz>
 <YbiNsVfoCPCJmOKj@alley>
 <Ybi6252hKwUM4KrP@alley>
 <20211214234836.3x3clp45ut6gtol6@treble>
 <Ybn9piT9Z83SKaCK@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ybn9piT9Z83SKaCK@alley>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 15, 2021 at 03:37:26PM +0100, Petr Mladek wrote:
> > Hm, this is different than how I understand it.
> > 
> > In the past I referred to the "parent" as the function which jumps to
> > the cold ("child") function.  So maybe we're getting confused by
> > different terminology.  But here I'll go with the naming from your
> > example.
> 
> I think that I was primary confused by the selftest where "child"
> function is livepatched and "parent" is defined as stack_only.

Ah, I guess I didn't look too closely at the selftest.

> Miroslav told me yesterday that the function that jumps into
> the .cold child needs to get livepatched. It makes sense
> because .cold child does not have well defined functionality.
> It depends on the compiler what code is put there.
> Hence I added one more level...
> 
> > If parent_func() is stack_only, that could create some false positive
> > scenarios where patching stalls unnecessarily.
> 
> Yes, it won't be optimal.
> 
> 
> > Also, wouldn't all of child_func()'s callers have to be made
> > stack_only?
> 
> Well, we already do this when handling compiler optimizations,
> for example, inlining.
> 
> 
> > How would you definitively find all the callers?
> 
> Good question. The best solution would be to get support from
> the compiler like we already get for another optimizations.
> 
> We always have these problems how to find functions that need
> special handling for livepatching.

But inlining and isra are inherently different from this.  They affect
static functions, which the compiler knows all the callers and is free
to (and does) tweak the ABI.  The compiler (and the patch author)
definitively know all the callers.

If child_func() happens to be a global function, it could be called from
anywhere.  Even from another klp_object.  If there are a lot of callers
across the kernel, there would be a proliferation of corresponding
stack_only funcs.

It could also be called from a function pointer, which levels up the
difficulty.

> > Instead I was thinking child_func.cold() should be stack_only.
> > 
> > e.g.:
> > 
> > static struct klp_func funcs[] = {
> > 	{
> > 		.old_name = "child_func",
> > 		.new_func = livepatch_child_func,
> > 	},
> > 	{
> > 		.old_name = "child_func.cold",
> > 		.new_name = "livepatch_child_func.cold",
> > 		.stack_only = true,
> > 	},
> > 
> > Any reason why that wouldn't work?
> 
> Yes, it should work in the given example. I am just curious how this
> would work in practice:
> 
> 
>   1. The compiler might optimize the new code another way and there
>      need not be 1:1 relation.
>
>      We might need another set of stack_only functions checked when
>      the livepatch is enabled. And another set of functions checked
>      when the livepatch gets disabled.

Regardless I'm thinking the above approach should be flexible enough.

If the patched child_func no longer has .cold, set 'new_name' to NULL in
the stack_only entry.

If the original child_func doesn't have .cold, but patched child_func
does, set 'old_name' to NULL in the stack_only entry.

If there were ever more than one of such "sub-functions" (which I
believe currently doesn't happen), the author could create multiple
stack_only entries.

>   2. The names of "child_func.cold" functions are generated by
>      the compiler. I mean that the names are "strange" ;-)
> 
>      It is likely easier with the kPatch approach that creates glue
>      around already compiled symbols. It is more tricky when preparing
>      the livepatch from sources. Well, it is doable.

kpatch-build has checks for symbols with ".cold" substring.  I'm
thinking it would be easy enough for you to do something similar since
you're already checking for other compiler optimizations.

> BTW: livepatch_child_func.cold function must be checked on the stack
>      also when the livepatch is replaced by another livepatch.
> 
>      I mean that we need to check two sets of stack only functions
>      when replacing one livepatch with another one:
> 
> 	+ "new_name" functions from to-be-replaced livepatch (like when disabling)
> 	+ "old_name" functions from new livepatch (like when enabling)

Urgh, this is starting to give me a headache.

Could we put the cold funcs in a klp_ops func_stack to make this work
automatically?

Alternatively we could link the .cold functions to their non-cold
counterparts somehow.  So when checking a function's stack, also check
it's linked counterpart.  It could even be part of the original
function's klp_func struct somehow, rather than having a dedicated
klp_func struct for the stack_only thing.

Or we could just give up trying to abstract this entirely, and go back
to Peter's suggestion to just always look for a ".cold" version of every
function in klp_check_stack_func() :-)

I dunno...

> Note that I do not have any strong opinion about any approach at the
> moment. I primary want to be sure that I understand the problem correctly :-)

Same here.

-- 
Josh

