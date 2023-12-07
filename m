Return-Path: <linux-kselftest+bounces-1381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD4F8092F4
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 22:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B261F2117E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 21:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4D350274;
	Thu,  7 Dec 2023 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mMqNHPvw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4121713
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Dec 2023 13:04:41 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2851a2b30a2so1194966a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Dec 2023 13:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701983081; x=1702587881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P1df2F2aMLldf9qn7FPBt3am2yl+mT6QC0UrRj9+Dnw=;
        b=mMqNHPvw7iYk1AsnxRD4tGF+MQvNu/BlvCKB3YbPFNplnOMXJHTIlMdRE8ZSwguDiv
         DO9FGWz5xZ9WV2NZQM+0M1oDpuz+1OWetjwKhE+P0z+AeG4oDpTpbANzixwVMuQ0pqu+
         k8j9eoVdIar/wh5x0owXpcQIzDwfUIIe5aQ98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983081; x=1702587881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1df2F2aMLldf9qn7FPBt3am2yl+mT6QC0UrRj9+Dnw=;
        b=p2LOCl4uWIzsNxZXOb5pmC22YFrJiPmhScwRmU7OLl64m37NFc4GdRWXh93mQboyPx
         Cg8R7L0VGNyZwj+KgPefb8aBPmlMW+vmxlSTaMnlIq2toj/TjWikymlQAMxFGPPMk0Ag
         Ldkusu9NE4zCqittGB6Fh+S6IeTflb9sowmzNpnim5q1uOy6nqBoUeNnuuwzLoKLbJGC
         JAxlJSOnf56OF8H9wrqroj0o/dyIGUSv1BE+VfIlRpkMHAUnneybYqHYxzsmtoTwDkGf
         FLbzRLBDSfg9W2YKTs6PvJsbEvl5avPtWUDABUM9DVibN82QlX1T/ckVi4HUGq+A7I/k
         diOw==
X-Gm-Message-State: AOJu0YzgjC7zDGvxfRub6tmgv30c2NG2RQ6VZ2LX9xUnhKdQDN1+Vizf
	+KfIklGdO1qZLSczbi/wxBuZyg==
X-Google-Smtp-Source: AGHT+IF4dR+ozEHEoTeZ5KlcYJqBauEZDgcWSu4X4MZ186gCsrYPLTr0XOCn3gkc/RW+9rLwjr8oiw==
X-Received: by 2002:a17:90b:350a:b0:285:b3a8:40ac with SMTP id ls10-20020a17090b350a00b00285b3a840acmr2717736pjb.19.1701983080991;
        Thu, 07 Dec 2023 13:04:40 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sc4-20020a17090b510400b002868d090c27sm354680pjb.25.2023.12.07.13.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:04:40 -0800 (PST)
Date: Thu, 7 Dec 2023 13:04:39 -0800
From: Kees Cook <keescook@chromium.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	linux-kselftest@vger.kernel.org,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	kft-triage@lists.linaro.org, regressions@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Eric Biederman <ebiederm@xmission.com>, linux-next@vger.kernel.org
Subject: Re: [PATCH] maple_tree: Fix mas_prev() state separation code
Message-ID: <202312071302.99D5B1BB76@keescook>
References: <20231207014104.n6vul2ylgqjnsfia@revolve>
 <20231207193319.4025462-1-Liam.Howlett@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207193319.4025462-1-Liam.Howlett@oracle.com>

On Thu, Dec 07, 2023 at 02:33:19PM -0500, Liam R. Howlett wrote:
> mas_prev() was setting the ma_underflow condition when the limit was
> reached and not when the limit was attempting to go lower.  This
> resulted in the incorrect behaviour on subsequent actions.
> 
> This commit fixes the status setting to only set ma_underflow when the
> lower limit is attempted to be decremented, and modifies the testing to
> ensure that's the case.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Is this is related to the report[1] I forwarded? If so, please add these tags
too:

 Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
 Closes: https://lore.kernel.org/all/CA+G9fYs-j2FYZSFSVZj48mgoM9gQd4-7M2mu2Ez3D1DqDdW2bQ@mail.gmail.com/ [1]

Thanks either way!

-Kees

> ---
> 
> Andrew,
> 
> This should be clean to squash into 7f79fdb1d94d7 ("maple_tree: separate
> ma_state node from status.") which is currently in your mm-unstable
> branch.
> 
> Thanks,
> Liam
> 
> 
>  lib/maple_tree.c      | 16 ++++++++++++----
>  lib/test_maple_tree.c |  9 +++++++--
>  2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 89f8d21602774..47f2a7a973852 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4432,6 +4432,9 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
>  		mas->last = mas->index - 1;
>  		mas->index = mas_safe_min(mas, pivots, mas->offset);
>  	} else  {
> +		if (mas->index <= min)
> +			goto underflow;
> +
>  		if (mas_prev_node(mas, min)) {
>  			mas_rewalk(mas, save_point);
>  			goto retry;
> @@ -4452,15 +4455,15 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
>  	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
>  		goto retry;
>  
> -	if (mas->index <= min)
> -		mas->status = ma_underflow;
>  
>  	if (likely(entry))
>  		return entry;
>  
>  	if (!empty) {
> -		if (mas_is_underflow(mas))
> +		if (mas->index <= min) {
> +			mas->status = ma_underflow;
>  			return NULL;
> +		}
>  
>  		goto again;
>  	}
> @@ -4596,7 +4599,7 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
>  		if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
>  			goto retry;
>  
> -		if (pivot >= max) {
> +		if (pivot >= max) { /* Was at the limit, next will extend beyond */
>  			mas->status = ma_overflow;
>  			return NULL;
>  		}
> @@ -4611,6 +4614,11 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
>  		else
>  			mas->last = mas->max;
>  	} else  {
> +		if (mas->last >= max) {
> +			mas->status = ma_overflow;
> +			return NULL;
> +		}
> +
>  		if (mas_next_node(mas, node, max)) {
>  			mas_rewalk(mas, save_point);
>  			goto retry;
> diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> index 15fbeb788f3ac..29185ac5c727f 100644
> --- a/lib/test_maple_tree.c
> +++ b/lib/test_maple_tree.c
> @@ -3294,8 +3294,8 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
>  	MT_BUG_ON(mt, mas.last != 0x1500);
>  	MT_BUG_ON(mt, !mas_is_active(&mas));
>  
> -	/* next:active ->active */
> -	entry = mas_next(&mas, ULONG_MAX);
> +	/* next:active ->active (spanning limit) */
> +	entry = mas_next(&mas, 0x2100);
>  	MT_BUG_ON(mt, entry != ptr2);
>  	MT_BUG_ON(mt, mas.index != 0x2000);
>  	MT_BUG_ON(mt, mas.last != 0x2500);
> @@ -3360,6 +3360,11 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
>  	MT_BUG_ON(mt, entry != ptr);
>  	MT_BUG_ON(mt, mas.index != 0x1000);
>  	MT_BUG_ON(mt, mas.last != 0x1500);
> +	MT_BUG_ON(mt, !mas_is_active(&mas)); /* spanning limit */
> +	entry = mas_prev(&mas, 0x1200); /* underflow */
> +	MT_BUG_ON(mt, entry != NULL);
> +	MT_BUG_ON(mt, mas.index != 0x1000);
> +	MT_BUG_ON(mt, mas.last != 0x1500);
>  	MT_BUG_ON(mt, !mas_is_underflow(&mas));
>  
>  	/* prev:underflow -> underflow (lower limit) spanning end range */
> -- 
> 2.40.1
> 

-- 
Kees Cook

