Return-Path: <linux-kselftest+bounces-24130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527D7A077D5
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 14:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E27D188AA97
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDE221D009;
	Thu,  9 Jan 2025 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GKSXdni7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IoEP+mfT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3026A218AC1;
	Thu,  9 Jan 2025 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736429900; cv=none; b=QRmFInVmx/el5HdhADtiHKMaG1T3jmmi0tnSlKSOTOUsxPj9wfvg4Q/FWiD/HwSbuDl+uTnoCcLytvmgvRvh+GRlb/3ZOP6nbsCOSaSV/WxKn8A2akptcQ9VYXmLp0S7tTDJpoDRkw6LG9964iPkwEEcyGfohMpCfI9QqmWkyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736429900; c=relaxed/simple;
	bh=AZHmwwh8CRT8icPmjCATDVTna0pkZYWbB2d/Row+aCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hp9Ro890T+GH49SoiIgCR2kvjSvx1kIsEkvcuxz9HrSNM8IPxZf03wbf11yFL8wgfe00x36MftQEIZCXsdsxy7qsFalUReoXXi9kgV0W7ckMRpC29nxr9RHqzf4jyzaGuAjS/WHSw/aDQgHfEEvvAl7w3EF+nqKy9gz0rgrlNyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GKSXdni7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IoEP+mfT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 9 Jan 2025 14:38:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736429897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yeg1h4L4S2leQuJ5NqenZ/mXnvUEzhAy5kD3YyfruzI=;
	b=GKSXdni7B5SKJtB5hW+SYciQy2eXLQcZyAdVb5W83RtlF8pOqrIbCDBZdYZQop56ooj9dz
	5K4STQ5AxNvwJsMl9HIbQV1uByE0DAvtpUjTVHLf2QNVSp7PJTyNCkoSSs/4XZn9k71RrH
	6bilAsgVLlxrslGZf/LZXgUCWEaDGkT8IG8WXBsQlKE/U45sCKZswiSwcTDDFryYxKoLnx
	1mz06qD+H85coPUCu8+rvB+ZONWauRuTL7M5IccytIshoIjUeYC5ccP5GsQv1+mre9mdKk
	D2Bz5+AmNq8SXOamoR3WMwEzuAdsQyyS0lGomoA98LkyF9MGIgRnrX4Ftumc4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736429897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yeg1h4L4S2leQuJ5NqenZ/mXnvUEzhAy5kD3YyfruzI=;
	b=IoEP+mfTJlaCnVtZ+eC9e/YsqALqy553SlcS1QP96KYb0ntI7U6wTST0LPACTSmI7SaEFz
	pO8KwmMlrUWrwxDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: David Hildenbrand <david@redhat.com>
Cc: Dev Jain <dev.jain@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH 1/3] selftests/mm: virtual_address_range: Fix error when
 CommitLimit < 1GiB
Message-ID: <20250109142307-ddd2bef6-a691-4cb6-879d-4f377ef41934@linutronix.de>
References: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
 <20250107-virtual_address_range-tests-v1-1-3834a2fb47fe@linutronix.de>
 <5811cf74-d333-4653-ab64-0e981eda7745@arm.com>
 <20250108083855-840c688b-003f-423b-8327-2a10a2b27d58@linutronix.de>
 <05edee1e-04f1-4f19-816f-db03c182a201@redhat.com>
 <20250108165052-c03470bd-6ff7-44c9-87b9-9145456bdea8@linutronix.de>
 <618798d5-71b2-43d6-8f5c-78d911c5dd43@redhat.com>
 <20250109083527-e3c77b5f-14f5-467b-9cee-f71c75b2d654@linutronix.de>
 <4e52d67c-e968-4cf6-9c9b-88646f0d3a23@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e52d67c-e968-4cf6-9c9b-88646f0d3a23@redhat.com>

On Thu, Jan 09, 2025 at 02:05:43PM +0100, David Hildenbrand wrote:
> >
> > That is clear. The issue would be to figure which chunks are valid to
> > unmap. If something critical like the executable file is unmapped,
> > the process crashes. But see below.
> 
> Ah, now I see what you mean. Yes, also the stack etc. will be problematic.
> So IIUC, you want to limit the munmap optimization only to the manually
> mmap()ed parts.

Correct.

> > > > Is it fine to rely on CONFIG_ANON_VMA_NAME?
> > > > That would make it much easier to implement.
> > > 
> > > Can you elaborate how you would do it?
> > 
> > First set the VMA name after mmap():
> > 
> > for (i = 0; i < NR_CHUNKS_LOW; i++) {
> > 	ptr[i] = mmap(NULL, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
> > 		     MAP_NORESERVE | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > 
> > 	if (ptr[i] == MAP_FAILED) {
> > 		if (validate_lower_address_hint())
> > 			ksft_exit_fail_msg("mmap unexpectedly succeeded with hint\n");
> > 		break;
> > 	}
> > 
> > 	validate_addr(ptr[i], 0);
> > 	if (prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, ptr[i], MAP_CHUNK_SIZE, "virtual_address_range"))
> > 		ksft_exit_fail_msg("prctl(PR_SET_VMA_ANON_NAME) failed: %s\n", strerror(errno));
> 
> Likely this would prevent merging of VMAs.
>
> With a 1 GiB chunk size, and NR_CHUNKS_LOW == 128TiB, you'd already require
> 128k VMAs. The default limit is frequently 64k.

They are merged for me, as they all share the same name.

PR_SET_VMA(2const) even mentions merging:

	Note that assigning an attribute to a virtual memory area might
	prevent it from being merged with adjacent virtual memory areas
	due to the difference in that attribute's value.

is_mergeable_vma() has an explicit check using anon_vma_name_eq().

> We could just scan the ptr / hptr array to see if this is a manual mmap area
> or not. If this takes too long, one could sort the arrays by address and
> perform a binary search.
>
> Not the most efficient way of doing it, but maybe good enough for this test?

A naive loop is what I tried first, but it took forever.

> Alternatively, store the pointer in a xarray-like tree instead of two
> arrays. Requires a bit more memory ... and we'd have to find a simple
> implementation we could just reuse in this test. So maybe there is a simpler
> way to get it done.

IMO the prctl() is that simpler way.
The only real drawback is the dependency on CONFIG_ANON_VMA_NAME.
We can add an entry to tools/testing/selftests/mm/config for it.


Thomas

