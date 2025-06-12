Return-Path: <linux-kselftest+bounces-34818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82132AD73CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 16:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F631747C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 14:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1990196C7C;
	Thu, 12 Jun 2025 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HQGbMX7H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UdWCYiUn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13401247DEA;
	Thu, 12 Jun 2025 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738466; cv=none; b=iCE0BcWKBaFcMJMUXHQC31txDlL/IvLu/PIcQBzkHijKQPV+Z2lxKy0GfZKHgWdZ681GvuoNOd84YGdsiM6GrG+iXSAKoNPiE725nE7EGFVxPE2kojuVw0QNMja5k0x8onR+5fxqcajkg/BJ6q0aTch9st7Gx4B15/jZhYTWb5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738466; c=relaxed/simple;
	bh=Vc758BeY06sEOUyS5ze/KYna8HJw6VGoT8zRzFVsN6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEvCPdyp1DQHn8DsTdKsJ4kpWs4KF7bdzXB/iZPdmlkmnNhdZQcWkM/NDE/AKRbc4lL7hK2I4+VFKZ7husOuSBRdLfdPRn9TY7y5RaALpr0jrJEX57eOJGPN6T/4Q5y76LZWa5rEI13v27QbAr7KAlipbl+SNS1JqtubT/VAbN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HQGbMX7H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UdWCYiUn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Jun 2025 16:27:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749738462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYuR96f9aCmk+UgAJ+PfZpTvLkyj7cl7/21Uj0F6GOs=;
	b=HQGbMX7H99yjouL/7Jw3HK/BsZtXEemHl8G5TOr2xgFVHCrvS5DWCatTfr4U+N9icRzk9z
	qoeG5qOZ4Si1rZvE9hwIZn1oZy6k8JH3vnRk4Aa0JGQ2cNFODjjvHfQnJnMC7zUGqqKNLQ
	lNS92xdVzSzYIGVawYcBTW8cr9j9yN2G7rSZ1WWdsXe74/OaFdTkeMzMx8VQTxxMzj+vg7
	BXYc/8S3C3ZKHhCqpVkhUWLFuaXC36ZbdoqtcW926YrQBzzpHO9bBRs/1ISoGUA+gHE7dB
	bcxj1iwjRwplkeqwJw1SxUGOTdJNIb2T8NPSzIKukE9XU01B168YkDG8hfHaDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749738462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYuR96f9aCmk+UgAJ+PfZpTvLkyj7cl7/21Uj0F6GOs=;
	b=UdWCYiUn+dfYE0u8mvZRWfU92Kdcx6mPx8AkMkG3DoQQcUrUsiGAHTPFxMsSam2UIhNUD7
	Y6fO3mwQ8GhsStBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Willy Tarreau <w@1wt.eu>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Mark Brown <broonie@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 09/14] selftests: harness: Move teardown conditional
 into test metadata
Message-ID: <20250612162151-1fc97a6c-a1c9-4656-997e-fd02f5f9418b@linutronix.de>
References: <aEh+DNmbZrqg6rHR@nvidia.com>
 <20250610234657.GO543171@nvidia.com>
 <aEkqtfcOJDrxAAcs@nvidia.com>
 <20250611093942-f6c65a06-c72a-4451-aa1e-8cb8de0d69cb@linutronix.de>
 <aEm6tuzy7WK12sMh@nvidia.com>
 <aEn5jmXZbC5hARGv@nvidia.com>
 <aEoUhPYIAizTLADq@nvidia.com>
 <20250611235117.GR543171@nvidia.com>
 <aEp6tGUEFCQz1prh@nvidia.com>
 <20250612135802.GU543171@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612135802.GU543171@nvidia.com>

On Thu, Jun 12, 2025 at 10:58:02AM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 11, 2025 at 11:59:00PM -0700, Nicolin Chen wrote:
> 
> > We can see the 64MB was rounded up to 512MB by ksys_mmap_pgoff()
> > when being passed in to hugetlb_file_setup() at:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/mmap.c?h=v6.16-rc1#n594
> > "		len = ALIGN(len, huge_page_size(hs));  "
> > 
> > By looking at the comments here..:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/hugetlbfs/inode.c#n1521
> > "
> > /*
> >  * Note that size should be aligned to proper hugepage size in caller side,
> >  * otherwise hugetlb_reserve_pages reserves one less hugepages than intended.
> >  */
> > struct file *hugetlb_file_setup(const char *name, size_t size,
> > "
> > 
> > ..I guess this function was supposed to fail the not-a-multiple
> > case as you remarked? But it certainly can't do that, when that
> > size passed in is already hugepage-aligned..
> > 
> > It feels like a kernel bug as you suspect :-/
> 
> Certainly is
>  
> > And I just found one more weird thing...
> > 
> > In iommufd.c selftest code, we have:
> > "static __attribute__((constructor)) void setup_sizes(void)"
> > where it does another pair of posix_memalign/mmap, although this
> > one doesn't flag MAP_HUGETLB and shouldn't impact what is coming
> > to the next...
> 
> This could all just be more weirdness from the above, it doesn't
> really make alot of sense.
> 
> I think change things so the MAP_HUGETLB test all skip if
> HUGEPAGE_SIZE < buffer_size and move on..
> 
> Can't run those tests on ARM64 64k which is unfortunate.. I thought
> there were patches to give that config a 2M huge page size option
> based on the new contiguous page support though? Maybe it was only THPS..

If the assumption is that this is most likely a kernel bug,
shouldn't it be fixed properly rather than worked around?
After all the job of a selftest is to detect bugs to be fixed.

But I wasn't able to follow all of your discussions,
so I may be missing something.

If the test is broken on ARM64 64k in general then I am also wondering how
it didn't fail before my change to the selftest harness.


Thomas

