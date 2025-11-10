Return-Path: <linux-kselftest+bounces-45244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF400C487CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 19:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A79C34EC6B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 18:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8DD31328A;
	Mon, 10 Nov 2025 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LRugej1F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA053128C8;
	Mon, 10 Nov 2025 18:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798156; cv=none; b=aM9KvKE9rXBOggovvK+lQuMsdGIM6zzzsAt+6GKf/cZKFM31ah+isJa9DdHurMa5+KKzFSwmrOJlZAuby4OwyNpAXWL7Zry1OXDJpt+7pLOGCkgeT9HeU1e2ZBed5P+jsWG47w35EzXfnRZ9+F3mzGE7cVadnTqcyeSbRT3Ir0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798156; c=relaxed/simple;
	bh=bWAoMwFPwmev6XGzVDuTW34XLemkAhOwCMOC56+kBrc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bqv/fYi+b8LQoYnHfHEFEpJjL7WZFm1+yFxOeVP5fSRg67W+7qf3IVN2bR8dUmfakOREpkAC3oSKZ2dqplx7UCyzjE0NSnAhpKiAxmANR7yctcXIcNd23qr43cx2gcVcoH6eoCNHFKYS3+Nr5UvyMd0ixUkHxBICJMkJdnwH5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LRugej1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1AEC4CEFB;
	Mon, 10 Nov 2025 18:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762798155;
	bh=bWAoMwFPwmev6XGzVDuTW34XLemkAhOwCMOC56+kBrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LRugej1FLuwbwrM2ekd19HYlCC5kDDwkZc4hqKG5Zq/mAwJfACdaVjOR32Gso6WQx
	 kSs5wCP/pPolWGp8z9XhkYNLuFuNkE0gqHq9lZvQ4218k7E5kyuOqOn6NCr7eY3jHd
	 VcroqitUMuCYtCwfrrjMu2BhUa3jCfUAVczRcpno=
Date: Mon, 10 Nov 2025 10:09:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Wake Liu <wakel@google.com>
Cc: David Hildenbrand <david@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Ankit Khushwaha
 <ankitkhushwaha.linux@gmail.com>
Subject: Re: [PATCH] mm/selftests: Fix -Wtautological-compare warning in
 mremap_test.c
Message-Id: <20251110100914.af77cb0a5b4211313dd9f32a@linux-foundation.org>
In-Reply-To: <20251110175155.1314757-1-wakel@google.com>
References: <20251110175155.1314757-1-wakel@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 01:51:55 +0800 Wake Liu <wakel@google.com> wrote:

> The compiler warns about a tautological comparison in mremap_test.c:
> "pointer comparison always evaluates to false [-Wtautological-compare]"
> 
> This occurs when checking for unsigned overflow:
>   if (addr + c.dest_alignment < addr)
> 
> Cast 'addr' to 'unsigned long long' to ensure the comparison is performed
> with a wider type, correctly detecting potential overflow and resolving
> the warning.
> 

Thanks.  I recently merged

https://lore.kernel.org/all/20251108161829.25105-1-ankitkhushwaha.linux@gmail.com/T/#u

there has been some discussion...

> --- a/tools/testing/selftests/mm/mremap_test.c
> +++ b/tools/testing/selftests/mm/mremap_test.c
> @@ -1032,7 +1032,7 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
>  	/* Don't destroy existing mappings unless expected to overlap */
>  	while (!is_remap_region_valid(addr, c.region_size) && !c.overlapping) {
>  		/* Check for unsigned overflow */
> -		if (addr + c.dest_alignment < addr) {
> +		if ((unsigned long long)addr + c.dest_alignment < (unsigned long long)addr) {
>  			ksft_print_msg("Couldn't find a valid region to remap to\n");
>  			ret = -1;
>  			goto clean_up_src;

I wonder if we'd be better off borrowing ideas from
include/linux/overflow.h:check_add_overflow().  Did anyone try
__builtin_add_overflow() here?


