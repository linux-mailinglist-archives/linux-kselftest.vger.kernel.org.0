Return-Path: <linux-kselftest+bounces-37430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1860B077FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 16:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264FE585796
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 14:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB28623496F;
	Wed, 16 Jul 2025 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObQ5d1ku"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F7819D06B;
	Wed, 16 Jul 2025 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676045; cv=none; b=UoQRQF0UGQuEP9CY8Hf5kuLmBcR7PApt1Arpametsd5L1Okj4K4SF3laRzktgoioa1QVVZJlkR4rmIPE78AZQ/zMH2Y+M/wDtpQRpLyPSSfsYfHrmXOKe+bKU0qD2jPEJCBWKB3VzJzIccoT/qs3yrxIubmSrFw73eQRPqIxyfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676045; c=relaxed/simple;
	bh=pXX/f4E5QmwaYwM0EsGzbyC0KiWPu9QhVqmKiUeE7kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMEuF3lk5GfVfJve7ALs4P3g2+tuwkp8FuAkb3MVfyVXZtBKygpT5kvkZh3F4FfTdt0uVZ0SRU3K6mRA1rZra91QU2w0ydz1eX8GkZljZdXb32vIJYo66cPmxjntN5kBerXgD1BF6lRU5AeiQHzuQhX6pE89o7non8sVEN3DXAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObQ5d1ku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E65C4CEE7;
	Wed, 16 Jul 2025 14:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752676045;
	bh=pXX/f4E5QmwaYwM0EsGzbyC0KiWPu9QhVqmKiUeE7kM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ObQ5d1kuqquDnrM3q65qQmCnUmX+4u+L0UdWXPHgHmlj5QmFV7mpBjjKZV4PymYN9
	 k95J/r61gbWZprYfr+b0KzzGHinkKAOgbIRe7ggBfcMB+2jiAj/bD42GSow1nqNCh3
	 BRXrWOorHEpzuIm1UbAFy4+la5Xur+IsHsedkd5aRhsTlL5Gxaa268x7jSQ2AgZV5z
	 8K80mpNVwTMF39taZgJ028ifO7szCycdZNqr6o9boSITWLpMZeuOwB/RwXazYxUyLP
	 BVB1EX7gLqQ0kpmX549rbGFEqZ8GNw4sazPu/vAqtv+d0EbYBT++2o/av0uqo56cTF
	 1Nn6ydezQP7Uw==
Date: Wed, 16 Jul 2025 07:27:24 -0700
From: Kees Cook <kees@kernel.org>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v3 1/6] binder: Fix selftest page indexing
Message-ID: <202507160726.EC296DBFA@keescook>
References: <20250714185321.2417234-1-ynaffit@google.com>
 <20250714185321.2417234-2-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714185321.2417234-2-ynaffit@google.com>

On Mon, Jul 14, 2025 at 11:53:14AM -0700, Tiffany Yang wrote:
> The binder allocator selftest was only checking the last page of buffers
> that ended on a page boundary. Correct the page indexing to account for
> buffers that are not page-aligned.
> 
> Signed-off-by: Tiffany Yang <ynaffit@google.com>
> ---
>  drivers/android/binder_alloc_selftest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
> index c88735c54848..486af3ec3c02 100644
> --- a/drivers/android/binder_alloc_selftest.c
> +++ b/drivers/android/binder_alloc_selftest.c
> @@ -142,12 +142,12 @@ static void binder_selftest_free_buf(struct binder_alloc *alloc,
>  	for (i = 0; i < BUFFER_NUM; i++)
>  		binder_alloc_free_buf(alloc, buffers[seq[i]]);
>  
> -	for (i = 0; i < end / PAGE_SIZE; i++) {
>  		/**
>  		 * Error message on a free page can be false positive
>  		 * if binder shrinker ran during binder_alloc_free_buf
>  		 * calls above.
>  		 */
> +	for (i = 0; i <= (end - 1) / PAGE_SIZE; i++) {

Nit: this comment is now not aligned correctly. Probably the best would
be the leave the "for" line above the comment.

-Kees

>  		if (list_empty(page_to_lru(alloc->pages[i]))) {
>  			pr_err_size_seq(sizes, seq);
>  			pr_err("expect lru but is %s at page index %d\n",
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 

-- 
Kees Cook

