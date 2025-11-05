Return-Path: <linux-kselftest+bounces-44823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B02C36A6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 17:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98BDE503E16
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 16:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774323314C4;
	Wed,  5 Nov 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DXD+P7YT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uBx1FG07"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE86322DA8;
	Wed,  5 Nov 2025 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359235; cv=none; b=Dmhdi/D+Vh9l7M8FFqDS/6zbZukxIJmFg4V1MOU/s7tnOt/swMVj7c+iZY/ZPhJOOzm+PnktyzISkDvhkK0ALO9M+XtFEZVi2igAOrFJ3uTVWP51yapx9iHSg1reH/zzwnjbb+nnrqhQCPRoMsYgrjDyH6O0wmPNTAUDTrn3Cak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359235; c=relaxed/simple;
	bh=Jji1FxMQE0nQwMRkGHd2vycQQBeWk2wadKdm4pviox8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ME+VpF4znpHJ+vMcPLhjCuhVsgmVTS3Gm5R5jqQhe5RH9qcb4fSQzperEsnpVzVIurTYkytSQgXzcgOYGsOzskjB85533TW9zBf3U2zK8llYT9ypnyPX6ONYRSpxh4PVv174H/Rlrx8YEMQLHdj5wO093Bi1lzXKsl49cLEUozg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DXD+P7YT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uBx1FG07; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Nov 2025 17:13:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762359231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g1kjwvsagYmMzNuZ/CDg1YQEqNnD94LL7vwY0lbT+zs=;
	b=DXD+P7YTv6IEX026kjt1F8YVXgIehfvUAI2O1StYFCuCM36Ax/oj2ROl9Escj22TUSaV4K
	XfImvsPVa/mQ0I7DEHuibSVfWzOlMz3M+KgDJSXVorRx5bGPSFHoqM9FycVPirDojnhUtq
	CbfssrMGHETE2LY0v3CA6uyP4tl9UFs8OzAbl8KW55+3K2/fgA63xL1Sl97z/Vk28JOo6U
	6Mgp/npslthxLyh+pFwUz6WNsceCFuwjKZjnO/eE/Z4H1ieVecgE0St4CC4+WoGo8HhH3T
	8wcbegPnMEc80NKfWlyWW2w+PimxAYcJeifVJHoT6Gus/rczh64e5m+aNhrDRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762359231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g1kjwvsagYmMzNuZ/CDg1YQEqNnD94LL7vwY0lbT+zs=;
	b=uBx1FG075ggbcRA5/Y07q3BLRHNQ+GDoQ7eqUFqWhPI3pyBOqf8No/MhlVY8xo1RqAIQA2
	9qHdPiWxMev3tkDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Shuah Khan <shuah@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Russell King <linux@armlinux.org.uk>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
	Shannon Nelson <sln@onemain.com>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 24/35] vdso/datastore: Allocate data pages dynamically
Message-ID: <20251105170813-070d53d9-aa2a-4cb6-bcda-3bce8c5be9c1@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
 <20251014-vdso-sparc64-generic-2-v4-24-e0607bf49dea@linutronix.de>
 <20251105153426.16228C13-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105153426.16228C13-hca@linux.ibm.com>

On Wed, Nov 05, 2025 at 04:34:26PM +0100, Heiko Carstens wrote:
> On Tue, Oct 14, 2025 at 08:49:10AM +0200, Thomas Weiﬂschuh wrote:
> > Allocating the datapages as part of the kernel image does not work on
> > SPARC. It is also problematic with regards to dcache aliasing as there is
> > no guarantee that the virtual addresses used by the kernel are compatible
> > with those used by userspace.
> > 
> > Allocate the data pages through the page allocator instead.
> > Unused pages in the vDSO VMA are still allocated to keep the virtual
> > addresses aligned.
> > 
> > These pages are used by both the timekeeping, random pool and architecture
> > initialization code. Introduce a new early initialization step, to make
> > sure they are available when needed.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > Tested-by: Andreas Larsson <andreas@gaisler.com>
> > Reviewed-by: Andreas Larsson <andreas@gaisler.com>
> > ---
> >  include/linux/vdso_datastore.h |  6 ++++++
> >  init/main.c                    |  2 ++
> >  lib/vdso/datastore.c           | 44 ++++++++++++++++++++++--------------------
> >  3 files changed, 31 insertions(+), 21 deletions(-)
> 
> ...
> 
> > +void __init vdso_setup_data_pages(void)
> > +{
> > +	unsigned int order = get_order(VDSO_NR_PAGES * PAGE_SIZE);
> > +	struct folio *folio = folio_alloc(GFP_KERNEL, order);
> 
> I'm seeing random hangs on s390 too with our CI, but unfortunately I cannot
> reproduce it manually. But looking at one of the dumps it looks to me like the
> vdso time page contains (more or less) random junk at the end. Or in other
> words, shouldn't this be:
> 
> 	struct folio *folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, order);
> 
> ? At least that is a difference to before as far as I can tell.

Thanks! This perfectly explains all the weird issues. It also does fix
the issue on the affected hardware which Mark kindly let me use.
I'll test it some more and send a fixed series tomorrow.


Thanks again!
Thomas

