Return-Path: <linux-kselftest+bounces-40353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE25B3C78C
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 05:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7475A221D
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 03:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58883258EFF;
	Sat, 30 Aug 2025 03:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jn+8Bxza"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B0C215075
	for <linux-kselftest@vger.kernel.org>; Sat, 30 Aug 2025 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756523395; cv=none; b=ooiaCR5oifMedXRErXfOrpJoQVSXj/PyUXFVqJSzfYyo+OrsMrPXIbaTPOkfcaB5BPiQBwzURwNEMx7hGNONFzvZlBUBn31YA7GUcbGqFmL1wwe0VxrOw0/EiEgUNYpUHSKVHuMTZYNaBSXy4heAuzQnQSr87dPUmviyXJDTKWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756523395; c=relaxed/simple;
	bh=Tp4tGe1T7bM1Qt609fKwvvBO2X7Aa609nyAbj8siVC4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bh2yqHTcUgkla6vVJWlaB7XQaxWwBVsdk/sGPbj9pwaVCAjGxMSzX9aGdCWjKhZ74xBXyTkPWc3I93TqVJnCNBQGnM1dKAFM9dLnergcBpMV3XUPL5UEyDwFe64qJza3GOQSoNvMaJdFrZQbAu8elPND9TOjmlGl63ygqDKW4+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jn+8Bxza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760B9C4CEF0;
	Sat, 30 Aug 2025 03:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756523394;
	bh=Tp4tGe1T7bM1Qt609fKwvvBO2X7Aa609nyAbj8siVC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jn+8BxzapCfSwVMpqOVrLOZ4g/NyDmvoTdeW4qGt57C25b14nnqtxoeXURRwx3aLi
	 syf1X+hLjQeFHHz8CBIS3julLE64HitmPcnC7fcC8W96wgM8Og4XkvNNHpk/0rU5LC
	 XYeyPOqBxn1cqTYKph9J38q7eccnOjgorbo3lvl4=
Date: Fri, 29 Aug 2025 20:09:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: directly add pagesize instead of increase
 until page size
Message-Id: <20250829200953.1757e85542b1126c4881d600@linux-foundation.org>
In-Reply-To: <20250830023102.14981-1-richard.weiyang@gmail.com>
References: <20250830023102.14981-1-richard.weiyang@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Aug 2025 02:31:02 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> The check of is_backed_by_folio() is done on each page.
> 
> Directly move pointer to next page instead of increase one and check if
> it is page size aligned.

Why?

> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -423,9 +423,8 @@ static void split_pte_mapped_thp(void)
>  
>  	/* smap does not show THPs after mremap, use kpageflags instead */
>  	thp_size = 0;
> -	for (i = 0; i < pagesize * 4; i++)
> -		if (i % pagesize == 0 &&
> -		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
> +	for (i = 0; i < pagesize * 4; i += pagesize)
> +		if (is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
>  			thp_size++;

Looks like we're doing more work.  Is there something wrong with the
existing code?


