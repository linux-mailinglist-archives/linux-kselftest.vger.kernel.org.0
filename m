Return-Path: <linux-kselftest+bounces-45287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 333A1C4C7D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 09:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD70F34D751
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0A52F1FD0;
	Tue, 11 Nov 2025 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ymWd3Lnk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PDy55JQ8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59799257846;
	Tue, 11 Nov 2025 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851353; cv=none; b=bcaF5GNUzlhLPFA84DxGS0Mn2tZQW+6DLbtB8SsKKvB1kfWsg5qghrf6qhVuhKZ4z4jzbmS4rU0rxWOWmv910Wd27HjgRdslgAJma8G47ODHBhzb9OZwlMisqGE4zeSBQ49rUAFxSSQrLvNNOzNAcoyxHWaiKpV4lMTk7bekmjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851353; c=relaxed/simple;
	bh=DCCdV1feBxJd8JPs8bCmq9jkjv7iq1tmUdts5DlDJ2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yy4xW1xbhni/Eb/hfF0KPVP2yyAm4xHvPysXNzqFMrVlutCDwT3Y0E+Ds/5C6Tz3w/waVHHIAhuDeJHj5R538fcxJzHKNNGtwt6iJ6l/ojXLmpsWsfl8xTeWiuesHznnGQvTdWje7TeVzSjmbNfN945txCFIXcDFLoKSRJuBcKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ymWd3Lnk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PDy55JQ8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 09:55:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762851350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKTM993Ma21ZOkCemY+4BJTuWewmn2tKdsb5lj2abpk=;
	b=ymWd3LnkEfwtX1k261UdYE5R5/7IpCIN6oMUmih0narZm6Bp8Tw+ikKxAJ98mC+Ki8kPMJ
	dBJpjhxGTVeH7mhIVwraawl+x4rKUcLrgjqLQQNzsEMcCgMEHvECAIV2HVQCLFCkTVlVl8
	O+nqZiC7VSJQgOJQPi13SRfHbDZLHZEY3z1VK0oryukZg4fmRz3ltZctohv5sJoBejwjBp
	LiENYCvrtOf0BCLFlrBMSBeAaFEbp7NDLImGC6soMNidgoVLHUkoF1FvWUavi7dVQADk5V
	c9bVZlXcLAPlv0tkMAeLyrfguAvzyipXRg9zcPQHmJYXL0Pd+CRKopm3fmhPVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762851350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKTM993Ma21ZOkCemY+4BJTuWewmn2tKdsb5lj2abpk=;
	b=PDy55JQ8GnIS/Y2nfebPHMOFIXaZwBf3oeKj/acsXinCUUcGzezaxkS3vc3c9VSFc5YRUL
	LWQUVLlkyb70aeBw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Shuah Khan <shuah@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	Russell King <linux@armlinux.org.uk>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Shannon Nelson <sln@onemain.com>, linux-kernel@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 19/34] random: vDSO: only access vDSO datapage after
 random_init()
Message-ID: <20251110124547-66c465dc-5214-46bf-937f-c8fa381b86f3@linutronix.de>
References: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
 <20251106-vdso-sparc64-generic-2-v5-19-97ff2b6542f7@linutronix.de>
 <aQ6EvdukQytvqK-u@zx2c4.com>
 <20251110094555-353883a9-1950-4cc6-a774-bb0ef5db11c5@linutronix.de>
 <aRHAU7bVAIyaOrpA@zx2c4.com>
 <20251110114550-a3f2afa8-4f86-4048-be5b-2dc4f4ef340d@linutronix.de>
 <aRHPIXATFJAEv-CF@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRHPIXATFJAEv-CF@zx2c4.com>

On Mon, Nov 10, 2025 at 12:40:17PM +0100, Jason A. Donenfeld wrote:
> On Mon, Nov 10, 2025 at 12:24:13PM +0100, Thomas Weißschuh wrote:
> > > > > For example, one clean way of
> > > > > doing that would be to make vdso_k_rng_data always valid by having it
> > > > > initially point to __initdata memory, and then when it's time to
> > > > > initialize the real datapage, memcpy() the __initdata memory to the new
> > > > > specially allocated memory. Then we don't need the complex state
> > > > > tracking that this commit and the prior one introduce.
> > > > 
> > > > Wouldn't that require synchronization between the update path and the memcpy()
> > > > path? Also if the pointer is going to change at some point we'll probably need
> > > > to use READ_ONCE()/WRITE_ONCE(). In general I would be happy about a cleaner
> > > > solution for this but didn't find a great one.
> > > 
> > > This is still before userspace has started, and interrupts are disabled,
> > > so I don't think so?
> > 
> > Interrupts being disabled is a good point. But we are still leaking
> > implementation details from the random code into the vdso datastore.
> 
> It wouldn't. You do this generically with memcpy().

With "implementation details" I meant the fact that it is fine to swap out the
datapage behind its back. And the fact that the memcpy() can not introduce any
races.

> > > Also, you only care about being after
> > > mm_core_init(), right? So move your thing before sched_init() and then
> > > you'll really have nothing to worry about.
> > 
> > The callchains random_init_early() -> crng_reseed()/_credit_init_bits() could
> > still touch the datapage before it is allocated.
> > Adding conditionals to prevent those is essentially what my patch does.
> 
> I think I wasn't very clear in my proposal, because this isn't an issue
> in it.

I interpreted your previous mail as two different proposals:
1) do the memcpy() thing
2) move the page allocation after mm_core_init()

Now it makes more sense.

> Global scope:
> 
> static struct vdso_rng_data placeholder_vdso_k_rng_data __initdata;
> struct vdso_rng_data *vdso_k_rng_data = &placeholder_vdso_k_rng_data;
> 
> Then,
> 
> void __init vdso_setup_data_pages(void)
> {
>     ...
>     vdso_k_rng_data = blabla();
>     ...
>     memcpy(vdso_k_rng_data, &placeholder_vdso_k_rng_data, sizeof(*vdso_k_rng_data);
>     ...
> }
> 
> If vdso_setup_data_pages() is called early enough in init, this is safe
> to do, and then you don't need to muck up the random code with awful
> state machine ordering stuff.

Yes it is safe, but this safety is not obvious in my opinion.
However I'll use your proposal for the next revision.


Thomas

