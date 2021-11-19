Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67123457649
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 19:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhKSSXN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 13:23:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234009AbhKSSXN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 13:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637346010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XdcrdYD9xvWbUGPWMX7bjgUSsVwyTNyxmOGq1Ztij9c=;
        b=FyAomhjH5ldOJMkSaTpEyTMhVD/D1+NFS8wsfcgF3SQzcfXOdSv706gidDcuIDa6lYt0+/
        TvCbDXxr+ou3F6ShbYRMUHG7b/+G4s2q76lDwwuzMdDBnocJwzm9ZlK8M2dMVD0UH4Js0B
        2eta2e4bJA5L7a4qH6MoM7w8cFqjBLE=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388--cADU0ByPOS1Lz0VP2C6cg-1; Fri, 19 Nov 2021 13:20:09 -0500
X-MC-Unique: -cADU0ByPOS1Lz0VP2C6cg-1
Received: by mail-oo1-f71.google.com with SMTP id c7-20020a4ae247000000b002b8be729ccdso6649946oot.13
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 10:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XdcrdYD9xvWbUGPWMX7bjgUSsVwyTNyxmOGq1Ztij9c=;
        b=jJOiZMiqzD+FnMaWSXt8dwn5vOw84PwOWYFq2X5FqqLo29k+aNlbI/o58qKjLUeEnE
         injRJaRnO7/VQ6eAMgkrMAixyBv2kN20+D35oiMhf7fDzwhWr9giNhC25pTCPf29pCgi
         eWcDTsoMTZ6hlrq9iqANJY6wSeP0KjnYYImzxJ2ReIlsuKZ08WKHiYRppF+Qzz/Ge/Kx
         CHgaaO32dalsgLitRsp2spHxl4uP+OcxVaFVNPibYJneGhSIj4W3wEDx8LLG92wPCwFR
         W1T3FPsfvhoUfXVh/Tj0lZZaCqtPq3FTBvwyMGiRSi8FHwCZFoz34QZTEtdsI2lrAQqh
         DwDQ==
X-Gm-Message-State: AOAM5328iRY1E7j8vVDvN4YD4826skdrlLtUsyu4ZZ2x9lf1z64waq51
        aL1AKpdUZ6OH4UaTrL9QRphmHiqQqaiFC57KMjNVDVQSebJNIEn5ciokmtadnl9kfhZL+qMYTqv
        RuZIdUK3TIWJxGlIv6gXR0Oa/aLsZ
X-Received: by 2002:a9d:6ac7:: with SMTP id m7mr6494042otq.306.1637346008895;
        Fri, 19 Nov 2021 10:20:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXWrvXCyVmmPw41zaXwMQvDoNIZwprsge5LSnVZv3n13O9g0G8kwLR62belVexqxGn1q5CKg==
X-Received: by 2002:a9d:6ac7:: with SMTP id m7mr6494000otq.306.1637346008634;
        Fri, 19 Nov 2021 10:20:08 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id l27sm118214ota.26.2021.11.19.10.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 10:20:08 -0800 (PST)
Date:   Fri, 19 Nov 2021 10:20:05 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     jikos@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] livepatch: Allow user to specify functions to search
 for on a stack
Message-ID: <20211119182005.t3p5iyxyibzktrbj@treble>
References: <20211119090327.12811-1-mbenes@suse.cz>
 <20211119090327.12811-3-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211119090327.12811-3-mbenes@suse.cz>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks for doing this!  And at peterz-esque speed no less :-)

On Fri, Nov 19, 2021 at 10:03:26AM +0100, Miroslav Benes wrote:
> livepatch's consistency model requires that no live patched function
> must be found on any task's stack during a transition process after a
> live patch is applied. It is achieved by walking through stacks of all
> blocked tasks.
> 
> The user might also want to define more functions to search for without
> them being patched at all. It may either help with preparing a live
> patch, which would otherwise require additional touches to achieve the
> consistency

Do we have any examples of this situation we can add to the commit log?

> or it can be used to overcome deficiencies the stack
> checking inherently has. For example, GCC may optimize a function so
> that a part of it is moved to a different section and the function would
> jump to it. This child function would not be found on a stack in this
> case, but it may be important to search for it so that, again, the
> consistency is achieved.
> 
> Allow the user to specify such functions on klp_object level.
> 
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> ---
>  include/linux/livepatch.h     | 11 +++++++++++
>  kernel/livepatch/core.c       | 16 ++++++++++++++++
>  kernel/livepatch/transition.c | 21 ++++++++++++++++-----
>  3 files changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index 2614247a9781..89df578af8c3 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -106,9 +106,11 @@ struct klp_callbacks {
>   * struct klp_object - kernel object structure for live patching
>   * @name:	module name (or NULL for vmlinux)
>   * @funcs:	function entries for functions to be patched in the object
> + * @funcs_stack:	function entries for functions to be stack checked

So there are two arrays/lists of 'klp_func', and two implied meanings of
what a 'klp_func' is and how it's initialized.

Might it be simpler and more explicit to just add a new external field
to 'klp_func' and continue to have a single 'funcs' array?  Similar to
what we already do with the special-casing of 'nop', except it would be
an external field, e.g. 'no_patch' or 'stack_only'.

Then instead of all the extra klp_for_each_func_stack_static()
incantations, and the special cases in higher-level callers like
klp_init_object() and klp_init_patch_early(), the lower-level functions
like klp_init_func() and klp_init_func_early() can check the field to
determine which initializations need to be made.  Which is kind of nice
IMO as it pushes that detail down more where it belongs.  And makes the
different types of 'klp_func' more explicit.

-- 
Josh

