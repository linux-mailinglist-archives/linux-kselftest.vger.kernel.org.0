Return-Path: <linux-kselftest+bounces-24327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E73A0B267
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 10:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7DD1676EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839FF23979E;
	Mon, 13 Jan 2025 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mcaohpNQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k+8qHVUq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60154237A24;
	Mon, 13 Jan 2025 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736759371; cv=none; b=Hc8ukjoxGR9s2VCR4gyqgYofs8HuiL5EcFZTo5Ht5OUftZzl2Umoi8JyHDRa+SeCLpWqGWtA+7EBaPIY3wCBXoYZZLuGPQRs83dI6so97JukfCF0k5HWdU1bTv3o4rOmLWj/5XFWHQiC9MML2HY4i+M4x7NUKdwuXKObfCC8Lbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736759371; c=relaxed/simple;
	bh=1fM1Az5QRn4ri1PSilPTe5LZp1jm/BOHCoYc5LvH38I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVVUri+Eg3quTUZjH89AQ/gQHEPkjCP8sxi7NeaJdOM30DekKlkd6j3K/T41R2soTQg+q+t046h5qUKBUquu88C+L3e7eAJNGkSEtb/qf+Ud2nhlkmhyrGCIAH2bzuP/dTDY9jRA5SGBqus9lSinyWKLgtjZ7Dn0Kf/JPvCQv64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mcaohpNQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k+8qHVUq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 13 Jan 2025 10:09:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736759367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iaLJCE3hZZaKYg76kr4H+6YhZeYEIBWjz6gvokJ8d2w=;
	b=mcaohpNQiMTCqKmmAsznrkto+jkaQNMg/3nkJ+6jZwFcZHMMOApc4jrv+kZUrAPmG9hvsU
	bfH377Lks/ZZ3sBmXDF0UR1SY5XI9YE2aI5k/kEb6W4TYt1VbQ+37gSXi5msPhM4c5EfcN
	X3eIB85RO23IIcoaFQupU8hiYHfWe7jlmqaJgRLM/nmlDGUfrIcu+OF06ZQ1hVjzpUgVzm
	TluqBiWyfFTAVDotMghElkSQdcOBCuIbEdJLHt0160+MkyLIYG+SZ7AluSej2p39EbQ3iQ
	6UPbfqLifwvb+pjjilzujLFjJakXLEt15qJIwurWWULwoj92fZeHM9nKRQx1RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736759367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iaLJCE3hZZaKYg76kr4H+6YhZeYEIBWjz6gvokJ8d2w=;
	b=k+8qHVUq/yui+wPfgv7TJls0yz4ZNoWIiI0adnkZkh3awxwDlnU8ITZCt9jh7Tcd+JEkUz
	uz5RWe1Ro5KsXKDA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 3/3] selftests/mm: virtual_address_range: Avoid
 reading VVAR mappings
Message-ID: <20250113095211-bde77070-8be1-4393-898e-22eff532189b@linutronix.de>
References: <20250110-virtual_address_range-tests-v2-0-262a2bf3c3d0@linutronix.de>
 <20250110-virtual_address_range-tests-v2-3-262a2bf3c3d0@linutronix.de>
 <9243dd8e-3f03-4ed5-bdcf-95c947c57849@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9243dd8e-3f03-4ed5-bdcf-95c947c57849@redhat.com>

On Fri, Jan 10, 2025 at 04:41:03PM +0100, David Hildenbrand wrote:
> On 10.01.25 14:05, Thomas Weiﬂschuh wrote:
> > The virtual_address_range selftest reads from the start of each mapping
> > listed in /proc/self/maps.
> > However not all mappings are valid to be arbitrarily accessed.
> > For example the vvar data used for virtual clocks on x86 [vvar_vclock]
> > can only be accessed if 1) the kernel configuration enables virtual
> > clocks and 2) the hypervisor provided the data for it.
> > Only the VDSO itself has the necessary information to know this.
> > Since commit e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapping")
> > the virtual clock data was split out into its own mapping, leading
> > to EFAULT from read() during the validation.
> > 
> > Skip the various vvar mappings in virtual_address_range to avoid the issue.
> > 
> > Fixes: e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapping")
> > Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202412271148.2656e485-lkp@intel.com
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >   tools/testing/selftests/mm/virtual_address_range.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> > index 4fc1c21a5e218eaec4d059b75c31a21dd4e8a215..993990aba56fc986c42084ffa91973558aa07e87 100644
> > --- a/tools/testing/selftests/mm/virtual_address_range.c
> > +++ b/tools/testing/selftests/mm/virtual_address_range.c
> > @@ -152,6 +152,10 @@ static int validate_complete_va_space(void)
> >   		if (prot[0] != 'r')
> >   			continue;
> > +		/* Only the VDSO can know if a VVAR mapping is really readable */
> > +		if (vma_name && !strncmp(vma_name, "[vvar", 5))
> > +			continue;
> 
> I'm wondering if there is a more generic way ... but likely not when staring
> at /proc/self/maps.
> 
> /proc/self/smaps would indicate this as
> 
> VM_IO: "io"
> VM_DONTDUMP: "dd"
> VM_PFNMAP: "pf"
> 
> Especially checking for VM_IO sounds reasonable ...

Agreed.

Can we instead rely on madvise(MADV_DOFORK) returning EINVAL iff VM_IO?
That would remove the need for custom parsing and the dependency on
CONFIG_PROC_PAGE_MONITOR.


Thomas

