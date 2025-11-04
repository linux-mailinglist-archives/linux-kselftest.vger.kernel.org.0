Return-Path: <linux-kselftest+bounces-44698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FEFC30239
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 10:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD95F1881255
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 08:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080892951A7;
	Tue,  4 Nov 2025 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PCKNJxul";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AYbRVmwT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE424290D;
	Tue,  4 Nov 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246722; cv=none; b=hWula8g9a4gxAp1FRzygDXtJjvgYSU45Wdeb/nCCxSayik1LBAlov+KpCZjfXSbClaZ949OQ/KcPxb8jvCEf2WT71kh1syFh4yC9Ji4KqwoOQjqU3anq3D52Ucli5lbzmphq2mLqddyw+l/mY4S9XFHwMnwKJXXqAkV54BvfeB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246722; c=relaxed/simple;
	bh=mQ+pL67AT04YF45u9EUzsf1ZKb6p3yTfcs+Jl3Ya/3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOHQz8qL2u4JyVX2ZNclCgvLqLGQlZ5hCElngJ0Z2G1Qo3go8aVfTyuzM4isIZR2gqgto2jADz6Eyo+7xgZdc1sAVRa+I580Sc6bphzY7d7bxMYPKjH2WZkUKFsXA1D18ozm+BAr38EUagi4+MtGQYw2vZv1XBWkqO87e7z64lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PCKNJxul; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AYbRVmwT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 4 Nov 2025 09:58:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762246719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0LvKOhhmgkPbAnJv9RUevotOR4DI1Uoh5ENCeo7njA=;
	b=PCKNJxulpg/PvsGYBz8V1FU4pIkAMexataoGH0wB1Wq12nZZHH8f2DwldZBJQaarAJVsP8
	yusjtIDWmV+OdYsTjKunNaFJcWiiyhHX6oDRiKaBNw6mbt6vWYMefNn74zwVvtcQNanAb/
	sFKjzpbAdgHOKh9I1DfB1uxqKlG9OH5OjQWRzQk9ok7MeccZ7XACWEaO4CMbje+8IR5FNE
	ksy6MxBeFin8cOh8nSGbd7sgJ1u4+BFBLgtkTy0AC0nIyqKnVIQCZ0PrgpFKDWnHjNm1K5
	thTLlUN+ZyklfklQSZjodwcMM1QHkniqB323QaFPf3lG/gDXH1KQ8B2yVTGLvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762246719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0LvKOhhmgkPbAnJv9RUevotOR4DI1Uoh5ENCeo7njA=;
	b=AYbRVmwTnBF9DHCl3zSORA5EBbeymIDmU5LN0MCGPkSaFq3DfisSLGnmVmNwMSYywgJ4+e
	uTDyt4qZNgxw5dDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
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
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, Shannon Nelson <sln@onemain.com>, linux-kernel@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4 23/35] vdso/datastore: Map pages through struct page
Message-ID: <20251104095555-ed009488-3aa8-43c5-b39f-066f04dee5a3@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
 <20251014-vdso-sparc64-generic-2-v4-23-e0607bf49dea@linutronix.de>
 <aQjJNmwniQwwjeBR@finisterre.sirena.org.uk>
 <CGME20251104084442eucas1p2af1bd88393f4d6a532df1cd41f32a287@eucas1p2.samsung.com>
 <e7f05748-a11c-47eb-b1fa-cdc9dc6d05e0@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7f05748-a11c-47eb-b1fa-cdc9dc6d05e0@samsung.com>

Hi Marek,

On Tue, Nov 04, 2025 at 09:44:38AM +0100, Marek Szyprowski wrote:
> On 03.11.2025 16:24, Mark Brown wrote:
> > On Tue, Oct 14, 2025 at 08:49:09AM +0200, Thomas Weißschuh wrote:
> >
> >> An upcoming change will allocate the datapages dynamically instead of as
> >> part of the kernel image. Such pages can only be mapped through
> >> 'struct page' and not through PFNs.
> > I'm seeing some boot failures on some arm64 platforms in -next which are
> > bisecting to this patch in -next.  Unfortunately the diagnostics aren't
> > super useful, we seem to just stop making progress in userspace with no
> > obvious output.  One sample log from the FVP is:

(...)

> Then I've tested it on ARM64bit (RaspberrryPi3b+ board) and got the 
> following panic on 6a011a228293 ("vdso/datastore: Map pages through 
> struct page") commit:
> 
> VFS: Mounted root (ext4 filesystem) on device 179:3. Trying to move old 
> root to /initrd ... okay devtmpfs: mounted Freeing unused kernel memory: 
> 12672K Run /sbin/init as init process Unable to handle kernel paging 
> request at virtual address ffffffffc20b5d48 Mem abort info: ESR = 
> 0x0000000096000006 EC = 0x25: DABT (current EL), IL = 32 bits SET = 0, 
> FnV = 0 EA = 0, S1PTW = 0 FSC = 0x06: level 2 translation fault Data 
> abort info: ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000 CM = 0, WnR = 
> 0, TnD = 0, TagAccess = 0 GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0 
> swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000000230b000 
> [ffffffffc20b5d48] pgd=0000000000000000, p4d=0000000003618403, 
> pud=0000000003619403, pmd=0000000000000000 Internal error: Oops: 
> 0000000096000006 [#1] SMP Modules linked in: CPU: 2 UID: 0 PID: 1 Comm: 
> init Tainted: G W 6.18.0-rc1+ #16136 PREEMPT Tainted: [W]=WARN Hardware 
> name: Raspberry Pi 3 Model B (DT) pstate: 80000005 (Nzcv daif -PAN -UAO 
> -TCO -DIT -SSBS BTYPE=--) pc : vvar_fault+0x7c/0x17c lr : 
> vvar_fault+0x24/0x17c ... Call trace: vvar_fault+0x7c/0x17c (P) 
> special_mapping_fault+0x24/0xd0 __do_fault+0x3c/0x238 
> __handle_mm_fault+0xaa0/0x19e0 handle_mm_fault+0xcc/0x384 
> do_page_fault+0x1a0/0x720 do_translation_fault+0x60/0x6c 
> do_mem_abort+0x44/0x94 el0_da+0x54/0x230 el0t_64_sync_handler+0xd0/0xe4 
> el0t_64_sync+0x198/0x19c Code: f2d83fe0 8b010063 d34cfc63 8b031803 
> (f9400461) ---[ end trace 0000000000000000 ]--- Kernel panic - not 
> syncing: Attempted to kill init! exitcode=0x0000000b SMP: stopping 
> secondary CPUs Kernel Offset: disabled CPU features: 
> 0x000000,00180000,40004000,0400421b Memory Limit: none ---[ end Kernel 
> panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> 
> Reverting "clocksource: Remove ARCH_CLOCKSOURCE_DATA", "vdso/datastore: 
> Allocate data pages dynamically" and "vdso/datastore: Map pages through 
> struct page" on top of linux-next fixes booting on all tested boards.

Thanks for the report. I have a Raspberry Pi 3 Model B V1.2 here and will try
to reproduce the issue with it.
Can you send me your kernel configuration?
Which line is vvar_fault+0x7c/0x17c?


Thomas

