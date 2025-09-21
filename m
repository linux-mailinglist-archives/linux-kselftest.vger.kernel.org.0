Return-Path: <linux-kselftest+bounces-42008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 956C4B8D528
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 07:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7738A189D888
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 05:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB87B29BDA9;
	Sun, 21 Sep 2025 05:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="TfSXBXHn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1927B3E1;
	Sun, 21 Sep 2025 05:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758431441; cv=none; b=riGjHKyJrzvmwe1Qm6b3xDUaAZDHQSGLMDFu8qdOFS1kt1SBXsSR0RpeO22uHXU40hUiS1Ty23YrphlTRv7hO/Yq9ryEW17ljeefe/sBOswrHRUDRIAQGH3EkcsWDSy0iadxLk9mP3/i4jRdvSeAoVlorGLcbzfySV5BuAdIdS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758431441; c=relaxed/simple;
	bh=w9oZ1uNQV8PhWrk7R2+HhaHhimhUFnbPVXpj77GRNI8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mGwcxW+TdciW/U8kLvuG1c7HsAJVYFcniIUaVufUyoayCpWhN/gBDMmfxEvtJHxdsWm0pQ5eM+4Cbq82JJakp7pIWqLDuq/bcPvrFiF9M4JDrXFAuwjcL0AwYyVunwXGbNxmL3l7c9yvXgeH2a/OGIfSXojPOo+YMN9dDLG+9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=TfSXBXHn; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=NvoDm3rY6iriVEHdymAWHHxK+7OKvhuVhhBYM9dD7Fk=; t=1758431439;
	x=1759036239; b=TfSXBXHnlva/4cZood1ATYlgO/P9Xe/U8IcZnesM0Oa3xsyaeUFw3pHprF8ze
	9SiLK8l2uMm7E2N/El1HrO65XGu7L+BlpJWXdA0nY5wmjH6r/rpFRCp6FGnH2LvokMF4VaBNupViy
	hVXkNXD51/zzm2g+UlgVcbs6XQeWJlL3msaDOzy8p7h0RGARVq8aE80MABwibXT9pl98WBPeh4RzU
	ShwfPmpxKqG17oyiM0BH7EyjSJX5pI4gYj25ROHlOoKKPVYywSH0ilY1qdchRki+yoH26lDYmaZMy
	MbNfFC0qPTPOwwOo9KEYiJkLMR6PMXp4YphQQNja+xkTm5/k0g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1v0CGh-00000000RZV-2NJn; Sun, 21 Sep 2025 07:05:47 +0200
Received: from dynamic-002-245-016-030.2.245.pool.telefonica.de ([2.245.16.30] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1v0CGh-00000002SmM-0yJw; Sun, 21 Sep 2025 07:05:47 +0200
Message-ID: <9198795c08a6c3d448bbcbdfe620ada792af8dd3.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 00/36] sparc64: vdso: Switch to the generic vDSO
 library
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
  Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,  Andreas Larsson
 <andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>, John Stultz
 <jstultz@google.com>,  Stephen Boyd <sboyd@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld"
 <Jason@zx2c4.com>,  Russell King <linux@armlinux.org.uk>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman	 <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy	
 <christophe.leroy@csgroup.eu>, Huacai Chen <chenhuacai@kernel.org>, WANG
 Xuerui	 <kernel@xen0n.name>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev	 <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,  Sven Schnelle
 <svens@linux.ibm.com>, Nagarathnam Muthusamy
 <nagarathnam.muthusamy@oracle.com>, Shannon Nelson	 <sln@onemain.com>,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, Arnd Bergmann	
 <arnd@kernel.org>
Date: Sun, 21 Sep 2025 07:05:44 +0200
In-Reply-To: <48fd164e-959b-4263-b3c7-cef5771aa40a@linutronix.de>
References: 
	<20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
	 <9a122c6cf3e2e0e61a62b0512eb97804acebeee9.camel@physik.fu-berlin.de>
	 <48fd164e-959b-4263-b3c7-cef5771aa40a@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Thomas,

On Sat, 2025-09-20 at 16:37 +0200, Thomas Wei=C3=9Fschuh wrote:
> Sep 20, 2025 15:25:11 John Paul Adrian Glaubitz <glaubitz@physik.fu-berli=
n.de>:
>=20
> > On Wed, 2025-09-17 at 16:00 +0200, Thomas Wei=C3=9Fschuh wrote:
> > > The generic vDSO provides a lot common functionality shared between
> > > different architectures. SPARC is the last architecture not using it,
> > > preventing some necessary code cleanup.
> > >=20
> > > Make use of the generic infrastructure.
> > >=20
> > > Follow-up to and replacement for Arnd's SPARC vDSO removal patches:
> > > https://lore.kernel.org/lkml/20250707144726.4008707-1-arnd@kernel.org=
/
> > >=20
> > > Tested on a Niagara T4 and QEMU.
> > >=20
> > > This has a semantic conflict with my series "vdso: Reject absolute
> > > relocations during build". The last patch of this series expects all =
users
> > > of the generic vDSO library to use the vdsocheck tool.
> > > This is not the case (yet) for SPARC64. I do have the patches for the
> > > integration, the specifics will depend on which series is applied fir=
st.
> > >=20
> > > Based on tip/timers/vdso.
> >=20
> > Could you share a version of the series based on top of 6.17.0-rcN for
> > testing purposes? I would like to test the series on a Sun Netra 240
> > which is based on the UltraSPARC IIIi.
>=20
> Here is the git branch based on rc4:
> https://git.kernel.org/pub/scm/linux/kernel/git/thomas.weissschuh/linux.g=
it/log/?h=3Db4/vdso-sparc64-generic-2
>=20
> Does that work for you?

Thanks, I'll give it a try.

> Thanks for testing!

Of course, I want to make sure the kernel stays working on these machines a=
nd
you're introducing large changes.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

