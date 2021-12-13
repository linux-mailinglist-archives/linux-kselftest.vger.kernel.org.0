Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7418647348B
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Dec 2021 20:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242064AbhLMTAR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Dec 2021 14:00:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47888 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242067AbhLMTAQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Dec 2021 14:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639422016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bkKzjijiSKbe6MvRJ5MBgBJTRxbp/4nkJ2nAyZ4TKpU=;
        b=hNy9BciCCzGVMlXXzYRRSKrzugCHJfPzeDZ3ToyWjioegH50dBMBf84egmRwY5XldG+7YO
        teZyqLkCVZ2HDWAqCFSuLPpUe6BI/vat+UGYqyoLDATG93hEu12t8c5IIGPd17ZYTQm2B9
        0Jj6HgwZLjgquWhoMguFF6NtPlDpZNk=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-O8zBrFhQONax950cac-0NQ-1; Mon, 13 Dec 2021 14:00:13 -0500
X-MC-Unique: O8zBrFhQONax950cac-0NQ-1
Received: by mail-ot1-f69.google.com with SMTP id h34-20020a9d2f25000000b00579e86a64dfso6711336otb.5
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Dec 2021 11:00:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bkKzjijiSKbe6MvRJ5MBgBJTRxbp/4nkJ2nAyZ4TKpU=;
        b=EXVGu8sJBKQHr/pDZpIVWinH1q/Kd/WMwYBjdp3z11iXmE7ydUaoSZrUKIJdVmLYWB
         OImVXVSzhYhnigN8YrOLBvbxdoxdkoxAjE4Y416fcQHJy7LMyI9Crlkb9JhlmUF4Cxvm
         m0VZipiGjasOacbf9npfOlWWXiHTqebdrnwwexKVMbMOcd8vC1OXjw4iPI5kstC6w01D
         n1T0rxFVsFVrKe7B+9CR3iFDzoVhnLswai9vnPY1gIsuJCrnI2BSmHYdZ6YguZPIOH4l
         wk+VMHk7HsyJ/uRRbm1X0Y7SX1WzpBFQv4Q/MfOpVTTk2FURDTXDJAsjq/VCt8scW89v
         O6SQ==
X-Gm-Message-State: AOAM531XqqdKNH7pY6BcCrbKSn1ki46U1AY4C0xlwPqX18XBKd/RpfUU
        g+Dr5W/DnD92KopELoXwi+ed4niiaXigZoz/uyacPhLlSDZTcMD3Z9UdmiW54f70EeCdhUzoQ91
        5dN8JiBxZp8offQY12ivukiDtgvxi
X-Received: by 2002:a9d:6394:: with SMTP id w20mr366248otk.248.1639422012145;
        Mon, 13 Dec 2021 11:00:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZ0v/QhdUhMfYMxIrjqAvM0c+I02ce8+c4SY8k5nWNB4ZCTvQ7Vjr3daAhkW6A1qp6SJAUlA==
X-Received: by 2002:a9d:6394:: with SMTP id w20mr366227otk.248.1639422011805;
        Mon, 13 Dec 2021 11:00:11 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id n189sm2766729oif.33.2021.12.13.11.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:00:11 -0800 (PST)
Date:   Mon, 13 Dec 2021 11:00:08 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     jikos@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] livepatch: Allow user to specify functions to
 search for on a stack
Message-ID: <20211213190008.r4rjeytfz5ycbstb@treble>
References: <20211210124449.21537-1-mbenes@suse.cz>
 <20211210124449.21537-2-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210124449.21537-2-mbenes@suse.cz>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 10, 2021 at 01:44:48PM +0100, Miroslav Benes wrote:
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -29,6 +29,8 @@
>   * @new_func:	pointer to the patched function code
>   * @old_sympos: a hint indicating which symbol position the old function
>   *		can be found (optional)
> + * @stack_only:	only search for the function (specified by old_name) on any
> + * 		task's stack

This should probably make it clear that it doesn't actually patch the
function.  How about something like:

 * @stack_only:	don't patch old_func; only make sure it's not on the stack


>   * @old_func:	pointer to the function being patched
>   * @kobj:	kobject for sysfs resources
>   * @node:	list node for klp_object func_list
> @@ -66,6 +68,7 @@ struct klp_func {
>  	 * in kallsyms for the given object is used.
>  	 */
>  	unsigned long old_sympos;
> +	bool stack_only;
>  
>  	/* internal */
>  	void *old_func;
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 335d988bd811..62ff4180dc9b 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -89,6 +89,10 @@ static struct klp_func *klp_find_func(struct klp_object *obj,
>  	struct klp_func *func;
>  
>  	klp_for_each_func(obj, func) {
> +		/* Do not create nop klp_func for stack_only function */
> +		if (func->stack_only)
> +			return func;
> +

This has me confused.  Maybe I'm missing something.

First, klp_find_func() is a surprising place for this behavior.

Second, if obj's first func happens to be stack_only, this will short
circuit the rest of the list traversal and will effectively prevent nops
for all the rest of the funcs, even if they're *not* stack_only.

Third, I'm not sure this approach would even make sense.  I was thinking
there are two special cases to consider:

1) If old_func is stack_only, that's effectively the same as !old_func,
   in which case we don't need a nop.

2) If old_func is *not* stack_only, but new_func *is* stack_only, that's
   effectively the same as (old_func && !new_func), in which case we
   *do* want a nop.  Since new_func already exists, we can just convert
   it from stack_only to nop.

Does that make sense?  Or am I missing something?

For example:

--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -536,9 +536,23 @@ static int klp_add_object_nops(struct klp_patch *patch,
 	}
 
 	klp_for_each_func(old_obj, old_func) {
+		if (old_func->stack_only) {
+			/* equivalent to !old_func; no nop needed */
+			continue;
+		}
 		func = klp_find_func(obj, old_func);
-		if (func)
+		if (func) {
+			if (func->stack_only) {
+				/*
+				 * equivalent to (old_func && !new_func);
+				 * convert stack_only to nop:
+				 */
+				func->stack_only = false;
+				func->nop = true;
+			}
+
 			continue;
+		}
 
 		func = klp_alloc_func_nop(old_func, obj);
 		if (!func)


And while we're at it, we may want to rename "{func,obj}" to
"new_{func,obj}" for those functions which have "old_{func,obj}".  It
would help prevent confusion between the two.

>  		if ((strcmp(old_func->old_name, func->old_name) == 0) &&
>  		    (old_func->old_sympos == func->old_sympos)) {
>  			return func;
> @@ -499,6 +503,17 @@ static struct klp_func *klp_alloc_func_nop(struct klp_func *old_func,
>  	return func;
>  }
>  
> +static bool klp_is_object_stack_only(struct klp_object *old_obj)
> +{
> +	struct klp_func *old_func;
> +
> +	klp_for_each_func(old_obj, old_func)
> +		if (!old_func->stack_only)
> +			return false;
> +
> +	return true;
> +}
> +
>  static int klp_add_object_nops(struct klp_patch *patch,
>  			       struct klp_object *old_obj)
>  {
> @@ -508,6 +523,13 @@ static int klp_add_object_nops(struct klp_patch *patch,
>  	obj = klp_find_object(patch, old_obj);
>  
>  	if (!obj) {
> +		/*
> +		 * Do not create nop klp_object for old_obj which contains
> +		 * stack_only functions only.
> +		 */
> +		if (klp_is_object_stack_only(old_obj))
> +			return 0;

This code is already pretty self explanatory and the comment isn't
needed IMO.

> +
>  		obj = klp_alloc_object_dynamic(old_obj->name, patch);
>  		if (!obj)
>  			return -ENOMEM;
> @@ -723,8 +745,9 @@ static int klp_init_func(struct klp_object *obj, struct klp_func *func)
>  	/*
>  	 * NOPs get the address later. The patched module must be loaded,
>  	 * see klp_init_object_loaded().
> +	 * stack_only functions do not get new_func addresses at all.
>  	 */
> -	if (!func->new_func && !func->nop)
> +	if (!func->new_func && !func->nop && !func->stack_only)
>  		return -EINVAL;

Same here, I'm not sure this comment really helps.

>  
>  	if (strlen(func->old_name) >= KSYM_NAME_LEN)
> @@ -804,6 +827,9 @@ static int klp_init_object_loaded(struct klp_patch *patch,
>  		if (func->nop)
>  			func->new_func = func->old_func;
>  
> +		if (func->stack_only)
> +			continue;
> +
>  		ret = kallsyms_lookup_size_offset((unsigned long)func->new_func,
>  						  &func->new_size, NULL);
>  		if (!ret) {
> diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
> index fe316c021d73..221ed691cc7f 100644
> --- a/kernel/livepatch/patch.c
> +++ b/kernel/livepatch/patch.c
> @@ -250,6 +250,9 @@ static void __klp_unpatch_object(struct klp_object *obj, bool nops_only)
>  		if (nops_only && !func->nop)
>  			continue;
>  
> +		if (func->stack_only)
> +			continue;
> +
>  		if (func->patched)
>  			klp_unpatch_func(func);
>  	}
> @@ -273,6 +276,9 @@ int klp_patch_object(struct klp_object *obj)
>  		return -EINVAL;
>  
>  	klp_for_each_func(obj, func) {
> +		if (func->stack_only)
> +			continue;
> +

Instead of these stack_only checks, we might want to add a new
klp_for_each_patchable_func() macro.  It could also be used in
klp_add_object_nops() to filter out old_func->stack_only.

>  		ret = klp_patch_func(func);
>  		if (ret) {
>  			klp_unpatch_object(obj);
> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> index 5683ac0d2566..fa0630fcab1a 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -200,7 +200,10 @@ static int klp_check_stack_func(struct klp_func *func, unsigned long *entries,
>  	for (i = 0; i < nr_entries; i++) {
>  		address = entries[i];
>  
> -		if (klp_target_state == KLP_UNPATCHED) {
> +		if (func->stack_only) {
> +			func_addr = (unsigned long)func->old_func;
> +			func_size = func->old_size;
> +		} else if (klp_target_state == KLP_UNPATCHED) {

Hm, what does this mean for the unpatching case?  What if the new
function's .cold child is on the stack when we're trying to unpatch?

Would it make sense to allow the user specify a 'new_func' for
stack_only, which is a func to check on the stack when unpatching?  Then
new_func could point to the new .cold child.  And then
klp_check_stack_func() wouldn't need a special case.

-- 
Josh

