Return-Path: <linux-kselftest+bounces-43752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033CABFB8E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 13:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C075419A57BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 11:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF8B32B9A2;
	Wed, 22 Oct 2025 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2x9nB+t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625BB32C931;
	Wed, 22 Oct 2025 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131431; cv=none; b=ONvcgxrQd+xI2rj9G66LLmuhDY0627ZZ+U5smMWOlxFtZrw5qKr6tcyDn9ilTfdkO8/j+vyxZ3IyzCOkhEj2tfFs4F43TaGAaxZXey/Raz8kps0S4P3ajWLOA8wFg0sxZYc/ZJMAOKsNAw41jbvbBVFb6rUr++kF4ssQ7zXsXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131431; c=relaxed/simple;
	bh=giaDzXJ7amEHAt5NKhtODhVh96Dnm7DoUD4EN0sU/+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KRJ4WSuK3Z35Zjq95oEuYzPF2koQd64jAF34rF/ElVIA2tPRXO9ci6TFCH2HFbMl+yxLbsaTxHt3gKwqFnqOMMz8W52VINrAxyjyJZu7ffV/XU0sMJJQtlBE0saV7vx7HTuVSZqhJChL1dacL4QFdxdUU7NwTajcZzRs8dcrfPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2x9nB+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5DAC4CEE7;
	Wed, 22 Oct 2025 11:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761131431;
	bh=giaDzXJ7amEHAt5NKhtODhVh96Dnm7DoUD4EN0sU/+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=s2x9nB+tMQXedvK2A3nU6LG3ZS3Zwaf9Lhc69LHbXA+sz0XqRD7W4846RILATPcdL
	 c3hd2gGd8XGhz9pEkHOdzPHaE9y1VKHC3hsyj/NKDzCKfYGeHmyHgsViixRFSkWUm0
	 4/1IXFJoFaYn2P4KYwsVZD3tRdhBwmB7xY3ygFeCAtjtSa0zwMojKW9Q+Iz+ti5i7e
	 PHSpqW5McRd/l/pjinSq86xSNDSh2jBCs8INTzgAb+pLYdKfMnwrvQGgmKlGrWQxFe
	 WziF4GRnncev9IXdlEYaov3ZEyGsXh4rEJdtv9JtlYHWierxqAyqU8hVUN3evQPcWr
	 hDn8Ya6YwT4Mg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  brauner@kernel.org,  corbet@lwn.net,
  graf@amazon.com,  jgg@ziepe.ca,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  masahiroy@kernel.org,  ojeda@kernel.org,  pratyush@kernel.org,
  rdunlap@infradead.org,  rppt@kernel.org,  tj@kernel.org
Subject: Re: [PATCHv7 4/7] kho: add interfaces to unpreserve folios and page
 ranges
In-Reply-To: <20251022005719.3670224-5-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Tue, 21 Oct 2025 20:57:16 -0400")
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
	<20251022005719.3670224-5-pasha.tatashin@soleen.com>
Date: Wed, 22 Oct 2025 13:10:27 +0200
Message-ID: <mafs0ecqvfazg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 21 2025, Pasha Tatashin wrote:

> Allow users of KHO to cancel the previous preservation by adding the
> necessary interfaces to unpreserve folio and pages.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/kexec_handover.h | 12 +++++
>  kernel/kexec_handover.c        | 85 ++++++++++++++++++++++++++++------
>  2 files changed, 84 insertions(+), 13 deletions(-)
>
[...]
>  
> +/**
> + * kho_unpreserve_pages - unpreserve contiguous pages.
> + * @page: first page in the list.
> + * @nr_pages: number of pages.
> + *
> + * Instructs KHO to unpreserve @nr_pages contigious  pages starting from @page.

s/contigious/contiguous. Also drop the extra space after it.

> + * This call must exactly match a granularity at which memory was originally
> + * preserved by kho_preserve_pages, call with the same @page and
> + * @nr_pages). Unpreserving arbitrary sub-ranges of larger preserved blocks is

Stray closing parenthesis here. Perhaps a rewording to: "This must be
called with the same @page and @nr_pages as the corresponding
kho_preserve_pages() call. Unpreserving arbitrary..."

Other than this,

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

> + * not supported.
> + *
> + * Return: 0 on success, error code on failure
> + */
> +int kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
> +{
> +	struct kho_mem_track *track = &kho_out.track;
> +	const unsigned long start_pfn = page_to_pfn(page);
> +	const unsigned long end_pfn = start_pfn + nr_pages;
> +
> +	if (kho_out.finalized)
> +		return -EBUSY;
> +
> +	__kho_unpreserve(track, start_pfn, end_pfn);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(kho_unpreserve_pages);
> +
>  struct kho_vmalloc_hdr {
>  	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
>  };

-- 
Regards,
Pratyush Yadav

