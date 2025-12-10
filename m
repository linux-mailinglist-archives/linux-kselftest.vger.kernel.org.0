Return-Path: <linux-kselftest+bounces-47371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04542CB3E56
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 20:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99B7930456D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 19:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5310C32693E;
	Wed, 10 Dec 2025 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxtSgj4C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lug72cTy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10692EB5C4
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Dec 2025 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765396315; cv=none; b=Yh1eYMbxaHjreYSUaPHL5PZgjjgXSMajw3kvwH0RomrKc1RH9dESSP+JGtPEKZ95/mwwCX46prA4klR/3+8IerBHbuXVQr9zsEnXvFqEcAFr3JRKvvVDxK9J33M24Nu7kHwAbjB7lv1YfGmMLP8xR7lKv+w4Mb2CZs29P1pa1sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765396315; c=relaxed/simple;
	bh=bVuknIZ9II+t7Y3vHavpbYMhqsjqBVWHocKRkXQCVXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvq8gFpuf8u4TkVrHnlto8dcYRDVH2DugP1GwpxHiehAnHximrZzdQWlDx4CwX8JcYnJroFz0rbJ39F08xJaZaCKtTmbRcNIISn+x8WdSbzmBEmiNJqCcvzMAQ/aEhcC25mTs/7KhLQ+Z/1JIUrYJUDgFv+ijyJVBKzUnWKX65Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YxtSgj4C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lug72cTy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765396312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AgTacFvON8EG6QFjOtITInXZzOpTjY+dV5wDUO7hRQw=;
	b=YxtSgj4CT1m5uN4dGJE9OKPqc7UpwI2+6QY4OrektUNtzy/FaVIZJ/g4fsEhtprJHtrS8Z
	BXKR8DA/R6wvCjQPnK+HuVW+ZKRwwQblXXYAOs7cm5yU38gbmZB/iOtrKmrUFzIvTjKLyx
	qS0WxC30StuVtXzkhryQ/VYx+CLsB0Q=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-8isVOFJVPby96SCTExBCHA-1; Wed, 10 Dec 2025 14:51:49 -0500
X-MC-Unique: 8isVOFJVPby96SCTExBCHA-1
X-Mimecast-MFC-AGG-ID: 8isVOFJVPby96SCTExBCHA_1765396309
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b6963d163eso50011985a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Dec 2025 11:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765396309; x=1766001109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AgTacFvON8EG6QFjOtITInXZzOpTjY+dV5wDUO7hRQw=;
        b=Lug72cTyHSz4JnF+dPIBbaIF53LxiOFDCqjNiZCRki8vQyfS9FxC4FB9yWepQK6VtA
         u5axksvxI/a8wmXtrn0dS5dX2Fdns1OraduUhm/0LRrkJNWce4VijolKyavS4GEAYWAS
         fKNDTPTRYJbq7bj36PjYxsPeQmlbFUAgIAlwUaD3H+JhzGsm9GXwsRhkU6HpaVGrf63x
         rjCoLSD1mfMCY1xEr9s1pt9Ns1KnQJ8J3JLMZslekUh6II769xJZvsYHIzIh+RtdeQXM
         45UUdIDyry58D/Jt730lVXq2f3wCCqP/8ZqHCVtgWEGr+35xLuppzOvYWV1zOgQVoqJe
         /nDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765396309; x=1766001109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgTacFvON8EG6QFjOtITInXZzOpTjY+dV5wDUO7hRQw=;
        b=wDWtdQcyuUji7dH0sJQ3GRipL0hllIZTnz43bn+mmoQWbMYFVLsISQOTCJdNn6zSok
         dkimZyMt6h2LS6z2d6eVWP9fYArCfxqPGoFOduqOEPh2+kQiMioBILURoBGMVItxeF72
         8/LgwsEnpdvzXuQXisocLbhRuGq+mXafyjMD5tpNeMsfuq+RVBHlzsUib+kNgsYL6BE7
         LoK4ax/ONJdrf1AkA8lRBjs1pwdx+HJUbg4/iVvBeP946iX8nwlOxHgqPh/h6359EkIj
         h9LlwWZecqIPdVH4R9XDScs3AX8cApEZ+8hEaRG0IMfms6+Y/iKZ1HDFNuvHYe2703kb
         G4fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOK8nJJYznMlkHJCiy1SpCNPoZPtW9ldMDbRH3F4Ma81helmh5lMkBAJRvM8zFDVPGxOMCQzJ+2DcLwntvlmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/GiZpctDMrDoa1TbWVAZUTdnyeDiwP21c452cIWmeHxZ+lmhJ
	hVXKExE7L4EcGFMe9U5l23x0e38s4FMh4dtYXkLJXfzWiadn8gaAjxZeoHL4TZ2X42gP3bSPQTe
	fXAXm+1/PUPZKFTeyc+lsYl28H6QQ33R08iNY8LHZ/LFqfqiVp1z1wpfOKqoa8lfy83tILg==
X-Gm-Gg: ASbGncsk87nL5sQReBO6nexGO5YP9oUTb47w+XHj4CR0IH+n2ahKGbVilUElOak19Ff
	ywtrVZE2P8d6h+wR7f8m/LmnEBAWolWmOhB8DHeqGAVVyWFgRKkkIx9f408yXBFype9XIqo347+
	AE+95ZN9pWoG9QRFVz47tXYmORgtbDRBdeGTMmhmapcxE0P0k2yKSt3+IYqMxFPp7OYx1xbRR4q
	faVdgwtUNzUq8GBPERsrUxWHKrBKTHWDXOOMr1D4sZdEDKiayfNqRv+zLnalf7K5cD8hTNJBG9J
	NQ6nHYODT68rOeatp4Xd9Eh7AkGyw58V/A2UUDL/54K9/FkL016xlC+8ZjXVx13AjXCYaK3r+iW
	nsT8=
X-Received: by 2002:a05:620a:298e:b0:8b2:faa3:4c77 with SMTP id af79cd13be357-8ba38319803mr555738485a.0.1765396308642;
        Wed, 10 Dec 2025 11:51:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8yx8A+CBHx6Z8LCFOIAJuCthOtds6H4ec7oH3JAGsNI6sRNuSA+X8f8s93mX3FffFUDJBGw==
X-Received: by 2002:a05:620a:298e:b0:8b2:faa3:4c77 with SMTP id af79cd13be357-8ba38319803mr555734385a.0.1765396308095;
        Wed, 10 Dec 2025 11:51:48 -0800 (PST)
Received: from x1.local ([142.188.210.156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8886ef16adcsm4356536d6.46.2025.12.10.11.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 11:51:47 -0800 (PST)
Date: Wed, 10 Dec 2025 14:51:46 -0500
From: Peter Xu <peterx@redhat.com>
To: Wake Liu <wakel@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] selftests/mm: Fix thread state check in uffd-unit-tests
Message-ID: <aTnPUmEMwymsWHyV@x1.local>
References: <20251210091408.3781445-1-wakel@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251210091408.3781445-1-wakel@google.com>

On Wed, Dec 10, 2025 at 05:14:08PM +0800, Wake Liu wrote:
> In the thread_state_get() function, the logic to find the thread's state
> character was using `sizeof(header) - 1` to calculate the offset from
> the "State:\t" string.
> 
> The `header` variable is a `const char *` pointer. `sizeof()` on a
> pointer returns the size of the pointer itself, not the length of the
> string literal it points to. This makes the code's behavior dependent
> on the architecture's pointer size.
> 
> This bug was identified on a 32-bit ARM build (`gsi_tv_arm`) for
> Android, running on an ARMv8-based device, compiled with Clang 19.0.1.
> 
> On this 32-bit architecture, `sizeof(char *)` is 4. The expression
> `sizeof(header) - 1` resulted in an incorrect offset of 3, causing the
> test to read the wrong character from `/proc/[tid]/status` and fail.
> 
> On 64-bit architectures, `sizeof(char *)` is 8, so the expression
> coincidentally evaluates to 7, which matches the length of "State:\t".
> This is why the bug likely remained hidden on 64-bit builds.
> 
> To fix this and make the code portable and correct across all
> architectures, this patch replaces `sizeof(header) - 1` with
> `strlen(header)`. The `strlen()` function correctly calculates the
> string's length, ensuring the correct offset is always used.
> 
> Signed-off-by: Wake Liu <wakel@google.com>

Oops, thanks for spotting it.  It was an accident the size of array is 8
here.. What I should have meant was:

	const char header[] = "State:\t";

That should also work with sizeof().  But your fix works, so it's all fine.

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

> ---
>  tools/testing/selftests/mm/uffd-unit-tests.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index f4807242c5b2..6f5e404a446c 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -1317,7 +1317,7 @@ static thread_state thread_state_get(pid_t tid)
>  		p = strstr(tmp, header);
>  		if (p) {
>  			/* For example, "State:\tD (disk sleep)" */
> -			c = *(p + sizeof(header) - 1);
> +			c = *(p + strlen(header));
>  			return c == 'D' ?
>  			    THR_STATE_UNINTERRUPTIBLE : THR_STATE_UNKNOWN;
>  		}
> -- 
> 2.52.0.223.gf5cc29aaa4-goog
> 

-- 
Peter Xu


