Return-Path: <linux-kselftest+bounces-42170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1747FB98DEA
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 10:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348F6161750
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 08:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9239E28314A;
	Wed, 24 Sep 2025 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="cALgYdvf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3548B2F56;
	Wed, 24 Sep 2025 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702550; cv=none; b=YU1PPhHsPnozJn7NAGdcehiOj5CMrvnXykqrarlTdDmeJZO9N7kLRd+rT+wenTsG6g/O4ZxfAuK0XmCW/nz2c4eIzWcFLXGhzpq5mewL062y8Fse9nH8/ndamNSpNkjS77DXFTrRIPaCNQ1VmHeP/6vQPW4Oiil6suZtf7sgBMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702550; c=relaxed/simple;
	bh=Jfhn3x3I1dOiPLprVbdyNIwQ8Y8jbUeUt6XV1D2TV9U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jT4V+EMibJn4qqN0Cs+wWg+rtSok+Jw4C9NYls/IIl3yzSGMlhDkxiDDUbx37fFjRgDsSL2a3hKSX4p8hgnmvLIpuWHNmjn6QctbwUEUHx0aoM5hVXbNILcsY8MdQf3ekTraLdxYZ/wAoVzoGSIXok/sFIZMliGlL/VZjJ8Kj5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=cALgYdvf; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=fv65kSjXoHh5kZbIWKr7i3/NioyZJdRuwp5qAQi17S0=; t=1758702547;
	x=1759307347; b=cALgYdvfECSSjrEvB+zc3qOGLKJ5wWon14mQ6allAcGR5nJTMn9xRdax3iaC+
	AOr8ypr55an3mN6ltfGOKDsCShSlGTtDT7IDh+pj6xSE2UuzvHIZYeF8cs7T2E1Z65Nuh5QWBy2Vh
	OqdCzCtDAjx6TMnZjOWv/mYq8cUYvaUJasChUPOkVA9Eb2Y+XNNXxo6skPy66ywh+Z/c4RwaOprMq
	uKikHbUbwGtpGdOxwvjtDLt9WOF1syTKS+AWAnvpWm//oYl1oM8cHLa3yc+t9ViedjLYB8XNgc1Tq
	CySEaNx3019GwKk/FWuXKdkXlk+ejOtBCObpyfxn0TL5SFQiSg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1v1Krw-000000002th-3piT; Wed, 24 Sep 2025 10:28:56 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1v1Krw-00000003LPw-2L5t; Wed, 24 Sep 2025 10:28:56 +0200
Message-ID: <ec0894011cb4403f45ad8b30095cc333edc1e5e6.camel@physik.fu-berlin.de>
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
Date: Wed, 24 Sep 2025 10:28:54 +0200
In-Reply-To: <bea9cc5c-7fc6-4c87-ab78-8232b2bee4dc@linutronix.de>
References: 
	<20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
	 <9a122c6cf3e2e0e61a62b0512eb97804acebeee9.camel@physik.fu-berlin.de>
	 <48fd164e-959b-4263-b3c7-cef5771aa40a@linutronix.de>
	 <60a0af09cc1a5de3b33b9606ed07ae91b42c5432.camel@physik.fu-berlin.de>
	 <bea9cc5c-7fc6-4c87-ab78-8232b2bee4dc@linutronix.de>
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

Hi,

On Wed, 2025-09-24 at 10:07 +0200, Thomas Wei=C3=9Fschuh wrote:
> Sep 24, 2025 09:40:47 John Paul Adrian Glaubitz <glaubitz@physik.fu-berli=
n.de>:
>=20
> > Hi Thomas,
> >=20
> > On Sat, 2025-09-20 at 16:37 +0200, Thomas Wei=C3=9Fschuh wrote:
> > > > Could you share a version of the series based on top of 6.17.0-rcN =
for
> > > > testing purposes? I would like to test the series on a Sun Netra 24=
0
> > > > which is based on the UltraSPARC IIIi.
> > >=20
> > > Here is the git branch based on rc4:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/thomas.weissschuh/lin=
ux.git/log/?h=3Db4/vdso-sparc64-generic-2
> > >=20
> > > Does that work for you?
> >=20
> > I'm getting merge conflicts with "vdso/datastore: Allocate data pages d=
ynamically" and
> > "vdso/datapage: Remove inclusion of gettimeofday.h".
> >=20
> > Can these be skipped?
>=20
> No, these are important.
>=20
> What are you trying to merge?
> I can probably give you a merge.

I'm using v6.17-rc7 plus all SPARC fixes in Andreas Larsson's linux-sparc f=
or-next branch:

https://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git/lo=
g/?h=3Dfor-next

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

