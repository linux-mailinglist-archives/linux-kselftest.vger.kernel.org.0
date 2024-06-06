Return-Path: <linux-kselftest+bounces-11297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5FC8FF0AC
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 17:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51FF21F241B3
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 15:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E58196C7C;
	Thu,  6 Jun 2024 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="LvVi4t/Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E6113BAEB;
	Thu,  6 Jun 2024 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687748; cv=none; b=BpAxkGeWCBGPJ24aHh6iWrsF9N0yJOp0i3xO6Zo/FCWSsjoAgCSDQgMyi35tbBrEXa/wjVItKEXoA+5oVXjNcmmocwIiGSzZmX14cPIcwt4cZK23Wl7lmiPOt5uQsV9D/AW/cfWG+CmYhhP3axxnlTJ2B1cQyHppnSGJ1vFH9tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687748; c=relaxed/simple;
	bh=vblmY0V4eAr6aMQr22rhxQQNFS3uYSQ222eApKlL8vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3VCIvoSGTWlItEAuIvyXutild3nHKIRuQSLW4xHE8nb5+aNUkV/Ek6SDbGddKzQNhROLDz2u18Dy3EN8yBPq0/Ye9prEvgE/1JKc6a/eKMFso1pWzBtP8LNvuJklvYFLRQskGoALhO1z2ZfJkHtrW2/0Rb7AJtqwetKrbCKXUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=LvVi4t/Y; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Vw7XZ2y3hz9sq3;
	Thu,  6 Jun 2024 17:29:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717687742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sHfJnp2lcftRA6X7UnUOG6z9rpZyMvNccJKHK19bpqc=;
	b=LvVi4t/Y+JebtJu90GV9FYjqoscL8pKkggLe38PrTSDSMZo9hdjB+mAopTSegccbb4HViK
	jEdpQvAPqv0A7OTxY4mJHxa6rIxV84WwV0Z0Kz8+c77WOI4b/YjHXJO7pMTyDXgQoObxrb
	kfEUhB4NgDvh5fMKFbExU1LpjV1b87HsQIWbi/wGc/F8Q/gK1zWqx1Cw/sdZSB1vDpgkrs
	JtQ3wmsLWQUAF6MnNzqPV6dHjyyT4gZgacEAUHge2VlAgCRZVCePmiNOfl7FpyTn7hDPAq
	zyUoQots/+9NRT8V/GupLseBbSqcC1xTzeGRznKZtgALr5NyjtIUzAiQCYW01w==
Date: Thu, 6 Jun 2024 15:28:58 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, mcgrof@kernel.org,
	linux-kselftest@vger.kernel.org, Zi Yan <zi.yan@sent.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] selftests/mm: use volatile keyword to not optimize mmap
 read variable
Message-ID: <20240606152858.hmtnmieyesv7o5i3@quentin>
References: <20240606135835.600022-1-kernel@pankajraghav.com>
 <ZmHJMyo37QdtTWee@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmHJMyo37QdtTWee@casper.infradead.org>

On Thu, Jun 06, 2024 at 03:35:31PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 06, 2024 at 01:58:35PM +0000, Pankaj Raghav (Samsung) wrote:
> > +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> > @@ -300,7 +300,7 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
> >  		char **addr)
> >  {
> >  	size_t i;
> > -	int __attribute__((unused)) dummy = 0;
> > +	volatile int __attribute__((unused)) dummy = 0;
> 
> The mistake made by whoever wrote this test was making 'dummy' a stack
> variable.  That lets the compiler figure out that it's unused.  If you
> make it a top-level variable (not static) so the compiler can't tell
> whether it's referenced by a different compilation unit, it can't make
> that deduction.  And you don't need the stupid attibute or volatile on it.

I did cringe a little before adding the volatile keyword. While not a 
fan of global variables, that might be better than all these keywords.

I will send a v2 right away! Thanks.

--
Pankaj

