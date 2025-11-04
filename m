Return-Path: <linux-kselftest+bounces-44723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4F8C31F86
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 17:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769D73A8296
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BEC299AB5;
	Tue,  4 Nov 2025 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bCAJkSmI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="izkXgs1O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942101F37D3;
	Tue,  4 Nov 2025 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272213; cv=none; b=KIawa7a76/ynj5NfLQjfTEGt9AbRwYYQDND9GqPxv8u83XiCYoysxU85qalFRfjbyoopT/mq+Tl+RU2irdjkogU0W2+t1wq8c7oGELIchWoK+4s/7ah/UVp8AEQEys51K0VGQWFx30pL08JT9hD5ZSTxxsNLoeCQzJUGPXY8Dyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272213; c=relaxed/simple;
	bh=F+PvDSRGytcfJAVeIous9McWq8sfAt4FarfLeI/b5+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re6av2uVcBmyy7xfqv2wUKMN1wgqMMrZBi0y13Rx4YvpP0Y2oxK9Gi8ckT6rM5Ccc0KyVXaqEJHiq6GQmHqGhilTZ6eetb+AC5KhoC2GVYkhKsyMOZKSCN8GfZIkwVwfQnJjPBo03ZX99gShAwj8cWA0++eJVkvW4kCkgkiuuJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bCAJkSmI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=izkXgs1O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 4 Nov 2025 17:03:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762272209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DVUsxBJLnt/zLZAkRttgBosRsQLZoSsfdLuF7oCasSk=;
	b=bCAJkSmIzBJHojDm0KwmGmGWsC3n03i6WCc33ZaQkkge47R+7l1saAH6blSD0ZcrD6t1+k
	SA4SqaEwkJ+TDe/W1zQ8LTYjWa5RWNLQbAfIZM+Y+AU9p4PAC1jduZobAX0xoB8rwl0Rcf
	M48fxss71NzXcEx0CMI2zKV0ZH5sHbuLnO4VKDpnaH0pQlAdBlWLr8PyNUBpCmRFSLjQX6
	q5H8QxYqM7wyitM/U8xUreRnLtjBS6s3mWTKfzwJz5XToqIIPoSbtgz7MpOkUtm14JG4ei
	ZIAvxu9YICBZcukK1G/oAgbfZ24wqdhKPQwPstAHkfdm8JBXQruiwn1UOMWiFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762272209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DVUsxBJLnt/zLZAkRttgBosRsQLZoSsfdLuF7oCasSk=;
	b=izkXgs1Oks6O1p19fpLoG5rO6SL/s7yAl4p4D5Myex7HUGGkSZYk39IZs7dnxM/choRDJb
	t0IdWzTWBxSakZCw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Shuah Khan <shuah@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Russell King <linux@armlinux.org.uk>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, Shannon Nelson <sln@onemain.com>, linux-kernel@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4 23/35] vdso/datastore: Map pages through struct page
Message-ID: <20251104170215-3600e71c-1573-43aa-ad1d-8d02af9bbbf4@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
 <20251014-vdso-sparc64-generic-2-v4-23-e0607bf49dea@linutronix.de>
 <aQjJNmwniQwwjeBR@finisterre.sirena.org.uk>
 <CGME20251104084442eucas1p2af1bd88393f4d6a532df1cd41f32a287@eucas1p2.samsung.com>
 <e7f05748-a11c-47eb-b1fa-cdc9dc6d05e0@samsung.com>
 <aQn8G9r2OWv_yEQp@finisterre.sirena.org.uk>
 <20251104162009-8cffa62d-e95b-466b-9a27-c51b0f5257cd@linutronix.de>
 <aQogAfbrP9rTPLvI@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQogAfbrP9rTPLvI@finisterre.sirena.org.uk>

On Tue, Nov 04, 2025 at 03:47:13PM +0000, Mark Brown wrote:
> On Tue, Nov 04, 2025 at 04:43:34PM +0100, Thomas Weißschuh wrote:
> > On Tue, Nov 04, 2025 at 01:14:03PM +0000, Mark Brown wrote:
> 
> > > I've now got the results for this specific commit, it looks like every
> > > single arm64 system is failing.  I didn't test any other architectures.
> 
> > Which one do you mean exactly with "this specific commit"?
> 
> > 6a011a228293 ("vdso/datastore: Map pages through struct page")
> > 10d91dac2ea5 ("vdso/datastore: Allocate data pages dynamically")
> 
> The one in the thread being replied to here, the first.

Ack.

> > Any chance I could get remote access to one of your test machines?
> > I don't have access to the exact machines and that should reduce the chance
> > of chasing down dead ends.
> 
> I can let you submit LAVA jobs to my lab (there's an API, a web
> interface for (re)submitting jobs and a CLI tool for shoving jobs in) if
> that works?  That's how my own access to it works unless I go pull
> boards out.  You should be able to resubmit existing jobs, it downloads
> test binaries over HTTP.

Sounds good.


Thomas

