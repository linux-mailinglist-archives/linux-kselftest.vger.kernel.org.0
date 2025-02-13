Return-Path: <linux-kselftest+bounces-26552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0693FA3419E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 15:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3681894C0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 14:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C56823A983;
	Thu, 13 Feb 2025 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GfKwwXD5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WCnF3EQy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567F622154F;
	Thu, 13 Feb 2025 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455557; cv=none; b=os74dzxsgL+q9IptGwOVBGql65tIFLi7nCK/ti1bl29RzKP67urdylTpd+PtgMN9DfmaxBnFaWBoSeP3gESsZjhe61nMYtcOgsmlS7stoSL4EU5WOOcGt9B0O6EFM43MiGOhmu1xLaUNPSIlo9OdjflXLoH2+KejCeG3DQ535TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455557; c=relaxed/simple;
	bh=I6LNEylxPSIfbqDaKm0K3oMHyd+4XgGpyJHNUPVehxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iphHQrgzlcq1xKgtOFzcwJ75qfSFkBwp2p0UxP1AargIjH3e92EEZubEhmGd6Xeb1bBAZR+cG0CWGLZ76FcdAwQ+tmpWon2D13C+9Sm8FcIF6l+LCXUcyhLZc3eOsyEb5nxVM7BmCkR9JkjIVh+nvwgf4iSXUb/r5ckscmXJA6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GfKwwXD5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WCnF3EQy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Feb 2025 15:05:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739455553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/zaMnFuwQFQJ8y2JkYtnDE7Q8Op+lUdDNLA1tvkDmY=;
	b=GfKwwXD5nqy7Bo8a/+2lFiDvFYvRoj4UFv9bqXJJ357JS3KJuGx+ICEETAUwcUW0zpVj1H
	1DqhrALxLjbfQTSet9LXMKvrAD3zvWDUqCZZwQ8HVVZhMcInKq2VHWkKcA4hExpLYIeGCT
	PTODk02UpuqvqRvG6J7F0kiF8rUfgDFn7D8bXwI7J60Ig4K4IPMBF6vSdCUkhhcwrs2J5e
	4dZNP//Cs46dl58MKWJcT2hHn665GmTnBvym5g6aVbAs6cKlQezPhkEfI4oAXU+Stmm/5z
	UJ7a6leqhqHG3zZduTQmGF5aqSg3eeb4DINIOCOY9B8q5dOR1rAgf876cavyLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739455553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/zaMnFuwQFQJ8y2JkYtnDE7Q8Op+lUdDNLA1tvkDmY=;
	b=WCnF3EQy4MHFJ+CYMFHRbiT6iCpy5xDbeSdQFHTLLITz+JtoE55kcuU1Bb29l8UK2wFllu
	JErN314W4C3nu8DQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, Fangrui Song <i@maskray.me>, 
	Xi Ruoyao <xry111@xry111.site>, Shuah Khan <skhan@linuxfoundation.org>, 
	Heiko Carstens <hca@linux.ibm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/vDSO: fix GNU hash table entry size for s390x
Message-ID: <20250213150321-af6be56a-3ad1-4f77-9d0c-c693dbb77b0c@linutronix.de>
References: <20250213-selftests-vdso-s390-gnu-hash-v1-1-ace3bcc940a3@linutronix.de>
 <008b57f5-96d3-4aca-b304-19ced4fa1efd@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <008b57f5-96d3-4aca-b304-19ced4fa1efd@linux.ibm.com>

On Thu, Feb 13, 2025 at 01:47:26PM +0100, Jens Remus wrote:
> On 13.02.2025 10:41, Thomas Weiﬂschuh wrote:
> > Commit 14be4e6f3522 ("selftests: vDSO: fix ELF hash table entry size for s390x")
> > changed the type of the ELF hash table entries to 64bit on s390x.
> > However the *GNU* hash tables entries are always 32bit.
> > The "bucket" pointer is shared between both hash algorithms.
> > On s390x the GNU algorithm assigns and dereferences this 64bit pointer as a
> > 32bit pointer, leading to compiler warnings and runtime crashes.
> 
> Nit: The compiler complains about assignments between incompatible pointer
> types (e.g. "Elf64_Xword *" and "Elf64_Word *").  The size of the pointers
> themselves is not different, as it is usually defined by the architecture
> regardless of the type of data pointed at.  The real issue is that the
> 32-bit GNU hash entries are erroneously accessed as if they were 64-bit
> entries via "bucket" on s390x.

Well, yes of course. It should have been
"pointer to 64bit as a pointer to 32bit"
I'll wait for some more feedback and roll it into v2.
Or I'd be happy if whoever picks it up fixes the wording.

> > Introduce a new dedicated "gnu_bucket" pointer which is used by the GNU hash.
> > 
> > Fixes: e0746bde6f82 ("selftests/vDSO: support DT_GNU_HASH")
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >   tools/testing/selftests/vDSO/parse_vdso.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> Reviewed-by: Jens Remus <jremus@linux.ibm.com>
> 
> Thanks for taking care!

You're welcome.

To be honest I'm a bit concerned that nobody noticed this before.
The test programs segfault instantly.

