Return-Path: <linux-kselftest+bounces-11294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2498FEFAE
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 16:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5F428CD6B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BE4198A3C;
	Thu,  6 Jun 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B4cxWexY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EF713BAEB;
	Thu,  6 Jun 2024 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684539; cv=none; b=k6wAP7ZOPNeKl0AlPds7NyyF3XQiH8LooqeXiyqs/WpN0bkB9knNi/JZd9xrocgpjhmhfP/2qIn7ItQRRsmWo39fgCqEOsnfj0iFmM2NL8IqxqXdMLLyQJlpQvvcqmIjx86aZjpmCxqoVRI2f+JGLtuwJyuk8Jvlj2geW2kF0F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684539; c=relaxed/simple;
	bh=BT2gIZwJSo+mPsjm84uN4o9TRUKDukMweCkYFWP+9bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyZsu6A6vKelXOI/1ynYVpc6fikyH9lPSFw6C8doezAf4gpYchPrGckQTMotEKY6jiY/ZNcH3xcafVi5pCpxRmDmh9vhmPd0XUVL2HmVqLRr3bwYyWE0Up+mz2HBrebEvOYUKPLc0DtcSeYEKnA6tuDpMWK9bYpx2xs1dw3gSQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B4cxWexY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uRrb0Shq20IiSNENDDmGhgfsdkWEm9jjuSCuCC1VoMw=; b=B4cxWexYSYlbRcxFS0XQxf0b5b
	QEa7Y8Fza7o3qa5Dc/k3zY6cZhopQe29udNpbF0A6IuKXyxtpQz2N+X/hm2xyW2jB9qsqUpNmaCnj
	Q6A71cWkdXwUzaVEKwkm9eA+7JX0tmc/RnhCy3uqES3w74tiZcAAMiIN7CEvB4Lbj9wCKcYtHFqVu
	ji/Tt5LvOQ7LQ/oSkeHsPl8o0CeevQ/lrFj6AnljM7/Xdp2ygiFXIQ1BW6PdsaT3gOBIWfFtyTBKi
	2435vzdX1A23Lj/xHJw6diCsUd5RPmbN7etRz1d6GLFj2+lfQNXc46P3LV5uExPEqNuPAKQQ0TE3+
	/jNXdOsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFEDD-00000000658-3ikm;
	Thu, 06 Jun 2024 14:35:31 +0000
Date: Thu, 6 Jun 2024 15:35:31 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, mcgrof@kernel.org,
	linux-kselftest@vger.kernel.org, Zi Yan <zi.yan@sent.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] selftests/mm: use volatile keyword to not optimize mmap
 read variable
Message-ID: <ZmHJMyo37QdtTWee@casper.infradead.org>
References: <20240606135835.600022-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606135835.600022-1-kernel@pankajraghav.com>

On Thu, Jun 06, 2024 at 01:58:35PM +0000, Pankaj Raghav (Samsung) wrote:
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -300,7 +300,7 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
>  		char **addr)
>  {
>  	size_t i;
> -	int __attribute__((unused)) dummy = 0;
> +	volatile int __attribute__((unused)) dummy = 0;

The mistake made by whoever wrote this test was making 'dummy' a stack
variable.  That lets the compiler figure out that it's unused.  If you
make it a top-level variable (not static) so the compiler can't tell
whether it's referenced by a different compilation unit, it can't make
that deduction.  And you don't need the stupid attibute or volatile on it.

