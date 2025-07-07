Return-Path: <linux-kselftest+bounces-36667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DF0AFAB7E
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 08:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4B7189D8D6
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 06:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB3E276024;
	Mon,  7 Jul 2025 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f97oRUec"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7203321C19E
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Jul 2025 06:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751868772; cv=none; b=rb4kO/zZBzKAiveg52g3sMf65eEgoC/bX1I3Ga3BsS4ULxPiQcimE1g5CzSW007xMcS9uUGE/Eqv7HvzLm6iFCIqitXF/79hjk9uD3giQ2joDr3XGRFj4c1Idnsp6OIN3c5LvvGzryB7spAw351Jqb6NHpT9F8BXwgfSWRjbpLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751868772; c=relaxed/simple;
	bh=b1NCztmUuHT7YB6Ei49PdtUDXfM+d5EAuJX4T6h80RE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XFv5S3LV0IesSsAVBesCWI0x+2gtIx/kNYvtw8afcmdSkV3pZb5NHwrol6GUcajAUwjoT/hCBJM+oA0Hzew4DpuaXKMSNC8yZBXQZVCZFppZGuEstxpggS68atsrF/PReZuyZphxZfr71VCGJ400pD/WVpaCLAhO5rIUQs3kHX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f97oRUec; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e7387d4a336so2090706276.2
        for <linux-kselftest@vger.kernel.org>; Sun, 06 Jul 2025 23:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751868769; x=1752473569; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k47dZt0Crs1sORHhdpWLtZdwuIrz1qyGCHW6wK+Mmyw=;
        b=f97oRUecOZhbnBM/m4NQtu8hTVAW0EhR3/uVGcGQi8SgrgSPDIfEZebTXn/piqsZmi
         W/36VkfZqN2gA1ZYCiMGMbt/KWEnYV0kzVVKLSoUJk572Vzc2BezwpEAPN2uGpQ4MZqV
         zoPhARtnPgiAJDT1U5W1z770zn9FRMU0jtgQSVi0qGE8LbF4vuTrnCRMUCaSDC19LufJ
         Vhc627cZ0H9Tmj6jJPTA3N4qmV8i5OE1vP6p84MPTGE9SoAtyY/121RrDfQhS6UFvRuh
         naf8fjcuK04PaHzXJRvDVN9Bu23R6jGh1hNrF3f3fwz6qZg2LaBCZl+VD96VYRYOCUb3
         2X5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751868769; x=1752473569;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k47dZt0Crs1sORHhdpWLtZdwuIrz1qyGCHW6wK+Mmyw=;
        b=tynxXlOq8a3zlXVwm4CXGsz9rDF8AZzULMX18SQCPaFqeVOZ/A7CplTBCx9yH9iPA3
         YOfzHiTCvAAZ7ljbNgVzLMdxYp1dSsWE2Q5+j1SVzX0M/s6MX9ZLUzoMFxxivF1non4t
         /OeWIN0Ks5epu0U+AHgn2putqn7r5vOsN9gQwGp/4G1HFf9ovugN201wpNG7bueJ/HRI
         YingOnTjlrSqZG1xElSLuaYsv0FtFEyHABuhN2otyiY3E4aiof1Q3ter0v9dKUbYG6fN
         TIjJdsFUZPvzQbeZby1mTvvNgKZ1mPEwCSCk1DHdV45U/w1EqW0LszodyfLAy5Cvfy6m
         fFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgzIiqBIwJ709jLmUKsA34mVms2k2QTkLLh2cgTKuqmZiRAznIf6bxnbORzGKignnfjJhgCyiCvw6L3JRbAkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMhbQKw83hpN8Q6C24X4KV9U9W0sbbUjy3vFIPLqI071YWXxyN
	z0fy5+EjzgtIogPdI6Du6PkHqFbVn6bs+F6mhk6VZ4+e6VPjSqqIjB4Zm3tIQPknfw==
X-Gm-Gg: ASbGnctTzz7ggnxSRbkPzcNA0OkDEEOnvoyZFjiUgG6H63oNPl12mLOe3VHJjNjULvL
	SxldyJRUA/u9ar8DENF1Y9Kwuxc604QfXSvjmvi69glD9tKd3H3AZQfg8NNoevwvtXyr3KNY9yM
	dX3nCJEesJtXLoSTVIHDk4EMhzTr4TaXVEr5npEXkWbKazDpIOeD+B9OCFlEL0+LB2G+mY/SxfO
	nOmWjKvsAsSA7w7i5AMxjWyXxpJqUhnxvqYgde/f1QPh6XditG2et6e98Szk25xLi76/UeNUBJ7
	wwYDtXOrHtTnUM8OIKA2GUj1f4wRp5wID1QBCxec2w49pMO2ujcc6jStyA2QpAPGo+9bQchATdJ
	tNMkQgv4NzIUCImtshycatDc63K5FQQuUI9YhLFcM2FmxNOw=
X-Google-Smtp-Source: AGHT+IF9uQB3C/Tk35uzYdwuZvbuiSoulQvT3LDcgrKfi8L4w4dnTGxlaUN4ZI/H1HoNYSPT7Y5GKw==
X-Received: by 2002:a05:6902:18c7:b0:e82:1c60:4f7d with SMTP id 3f1490d57ef6-e8b3cd8d184mr7723935276.39.1751868768837;
        Sun, 06 Jul 2025 23:12:48 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c440860sm2451588276.30.2025.07.06.23.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 23:12:47 -0700 (PDT)
Date: Sun, 6 Jul 2025 23:12:35 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
    "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
    Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
    Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, 
    linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/10] mm/mremap: permit mremap() move of multiple VMAs
In-Reply-To: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
Message-ID: <4a4344b5-ff68-d57f-de7a-68a091bcb092@google.com>
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 7 Jul 2025, Lorenzo Stoakes wrote:

> Historically we've made it a uAPI requirement that mremap() may only
> operate on a single VMA at a time.
> 
> For instances where VMAs need to be resized, this makes sense, as it
> becomes very difficult to determine what a user actually wants should they
> indicate a desire to expand or shrink the size of multiple VMAs (truncate?
> Adjust sizes individually? Some other strategy?).
> 
> However, in instances where a user is moving VMAs, it is restrictive to
> disallow this.
> 
> This is especially the case when anonymous mapping remap may or may not be
> mergeable depending on whether VMAs have or have not been faulted due to
> anon_vma assignment and folio index alignment with vma->vm_pgoff.
> 
> Often this can result in surprising impact where a moved region is faulted,
> then moved back and a user fails to observe a merge from otherwise
> compatible, adjacent VMAs.
> 
> This change allows such cases to work without the user having to be
> cognizant of whether a prior mremap() move or other VMA operations has
> resulted in VMA fragmentation.
> 
> In order to do this, this series performs a large amount of refactoring,
> most pertinently - grouping sanity checks together, separately those that
> check input parameters and those relating to VMAs.
> 
> we also simplify the post-mmap lock drop processing for uffd and mlock()'d
> VMAs.
> 
> With this done, we can then fairly straightforwardly implement this
> functionality.
> 
> This works exclusively for mremap() invocations which specify
> MREMAP_FIXED. It is not compatible with VMAs which use userfaultfd, as the
> notification of the userland fault handler would require us to drop the
> mmap lock.
> 
> The input and output addresses ranges must not overlap. We carefully
> account for moves which would result in VMA merges or would otherwise
> result in VMA iterator invalidation.

Applause!

No way shall I review this, but each time I've seen an mremap series
from Lorenzo go by, I've wanted to say "but wouldn't it be better to...";
but it felt too impertinent to prod you in a direction I'd never dare
take myself (and quite likely that you had already tried, but found it
fundamentally impossible).

Thank you, yes, this is a very welcome step forward.

Hugh

