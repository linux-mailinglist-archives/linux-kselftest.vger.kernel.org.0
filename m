Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5295A474EBC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 00:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbhLNXsm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 18:48:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238339AbhLNXsl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 18:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639525721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PxegsCUs4iHdn3Ce5+JXTq0Snzm5UCe6ZUE8seqhmhc=;
        b=bFdQ17AOl3VqQ9ouwxhXCtEifTcaJUnHMC/trIFHYZ5rJCbMUv6DoU5cFnkwjjfK3qJkuK
        OM2N+1zXX/+/Jbj3GumuS5Fuaqcm1R4sVcvJLlpPpCQ3uMUkoJGaV69+AflK9IV70eUULa
        O8j+qCBaZE/J3M9QwM1+9BVYeGW+b+g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343--p9bXLsXMjmBD_vfUgIsLw-1; Tue, 14 Dec 2021 18:48:40 -0500
X-MC-Unique: -p9bXLsXMjmBD_vfUgIsLw-1
Received: by mail-qv1-f69.google.com with SMTP id fn12-20020ad45d6c000000b003bd9c921c0eso28703756qvb.21
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 15:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PxegsCUs4iHdn3Ce5+JXTq0Snzm5UCe6ZUE8seqhmhc=;
        b=LvBePivA+lRbM/SsXa09fuPZM2R5vYmfrE1FrpbVgk9KqXO/Th4Wt6uKClV2sXlcVB
         k/aCe8B32qNEZclv08zlN7SjTge9cwnPANBj730Pe3IMQgVURxGjlYzQ6zPBWzdB+ihl
         /s80AzB5qBn6L/fpJmlCSdErrxnfaNinlGy/0Ojd9GQa7oHTVlDXvi+GPMNGncz/st7d
         biQsldcQAJiwxKoF0kHjrPRGnUkEUDjH8ckXltUGZ/2dUsYjibDNlmnpshybZCDjqs0L
         kiEoEh2w0Iu01wrtVju2fRq0skmvUipWY7Jl+TGtUD3RmcwpclPtosX/UW2ZDk+R/ua7
         +TLw==
X-Gm-Message-State: AOAM532fQ2s5q8v5DwrdwUqIlUmXSIbofMLdgEc+PP3ibXM+m1VOWQAy
        8xe82UZy9o/hp5j1u6NZejY6NFHQsLtNjfZt6XDcjd4cXvaM3cbq0W33ra6jmn1V4EsZGBjFzKJ
        eWHN5yz4xtK7ON7vZFVtFDdotnvOZ
X-Received: by 2002:a05:6214:da9:: with SMTP id h9mr8998401qvh.2.1639525719483;
        Tue, 14 Dec 2021 15:48:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6wUDPzah/26+HipUsYD/dw9JK8zhpppqGRr1+2gGylE/gSXGSBN1fnRur80e2G8cVi3I+Xw==
X-Received: by 2002:a05:6214:da9:: with SMTP id h9mr8998389qvh.2.1639525719256;
        Tue, 14 Dec 2021 15:48:39 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id o4sm143059qkh.107.2021.12.14.15.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 15:48:38 -0800 (PST)
Date:   Tue, 14 Dec 2021 15:48:36 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, jikos@kernel.org,
        joe.lawrence@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] livepatch: Allow user to specify functions to
 search for on a stack
Message-ID: <20211214234836.3x3clp45ut6gtol6@treble>
References: <20211210124449.21537-1-mbenes@suse.cz>
 <20211210124449.21537-2-mbenes@suse.cz>
 <20211213190008.r4rjeytfz5ycbstb@treble>
 <alpine.LSU.2.21.2112140857570.20187@pobox.suse.cz>
 <YbiNsVfoCPCJmOKj@alley>
 <Ybi6252hKwUM4KrP@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ybi6252hKwUM4KrP@alley>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 14, 2021 at 04:40:11PM +0100, Petr Mladek wrote:
> > > > Hm, what does this mean for the unpatching case?  What if the new
> > > > function's .cold child is on the stack when we're trying to unpatch?
> > > 
> > > Good question. I did not realize it worked both ways. Of course it does.
> > > 
> > > > Would it make sense to allow the user specify a 'new_func' for
> > > > stack_only, which is a func to check on the stack when unpatching?  Then
> > > > new_func could point to the new .cold child.  And then
> > > > klp_check_stack_func() wouldn't need a special case.
> > 
> > I am confused. My understanding is that .cold child is explicitly
> > livepatched to the new .cold child like it is done in the selftest:
> > 
> > static struct klp_func funcs_stack_only[] = {
> > 	{
> > 		.old_name = "child_function",
> > 		.new_func = livepatch_child_function,
> > 	}, {
> > 
> > We should not need anything special to check it on stack.
> > We only need to make sure that we check all .stack_only functions of
> > the to-be-disabled livepatch.
> 
> We have discussed this with Miroslav and it seems to be even more
> complicated. My current understanding is that we actually have
> three functions involved:
> 
>   parent_func()
>     call child_func()
>       jmp child_func.cold
> 
> We livepatch child_func() that uses jmp and need not be on stack.
> This is why we want to check parent_func() on stack.
> For this, we define something like:
> 
> static struct klp_func funcs[] = {
> 	{
> 		.old_name = "child_func",
> 		.new_func = livepatch_child_func,   // livepatched func
> 	},
> 	{
> 		.old_name = "parent_func",
> 		.stack_only = true,		    // stack only
> 	},

Hm, this is different than how I understand it.

In the past I referred to the "parent" as the function which jumps to
the cold ("child") function.  So maybe we're getting confused by
different terminology.  But here I'll go with the naming from your
example.

If parent_func() is stack_only, that could create some false positive
scenarios where patching stalls unnecessarily.  Also, wouldn't all of
child_func()'s callers have to be made stack_only?  How would you
definitively find all the callers?

Instead I was thinking child_func.cold() should be stack_only.

e.g.:

static struct klp_func funcs[] = {
	{
		.old_name = "child_func",
		.new_func = livepatch_child_func,
	},
	{
		.old_name = "child_func.cold",
		.new_name = "livepatch_child_func.cold",
		.stack_only = true,
	},

Any reason why that wouldn't work?

> This is another argument that we should somehow reuse the nops code
> also for stack_only checks.
> 
> Does it make sense, please? ;-)

Yes, if parent_func() is stack_only.

But if child_func.cold() is stack_only, that doesn't work, because it
doesn't have a fentry hook.

-- 
Josh

