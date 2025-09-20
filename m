Return-Path: <linux-kselftest+bounces-41999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C54DB8C8D9
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 15:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBF8580D02
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 13:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE84E1F152D;
	Sat, 20 Sep 2025 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="k0NH52mT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89B0188CB1;
	Sat, 20 Sep 2025 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758374725; cv=none; b=guiErapX4C2/2fcNie6idKp9E91Yl94iRtVXNeryBBgo6drhBS944D27w1NZtvhUnbtIlc3HlAofcl5bPkOhhjQ/PeNj1uL9dOakrCphHtDOqW9Vq+mv5jRylz55aeVD4O+/nsnWxqjytNZ1FUT71ACzy5EoDZkUnBIhHdAhvCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758374725; c=relaxed/simple;
	bh=dBrhZ658+q7SnJqsPpJg+tswJRFTHmQ78cNgPBroFd4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qgeVJklCiqGVSzTS8twLx/UVFEtaWhPyEJWdKe+vb4o1Lwp/8SiFFUNN4VjRClxBMDWvBR4S7fQ2XDSG7o9uI722Hp1cM4baOFeiLhb2ZO1mhW4Efy56NGAM37fIzXl6xZgx0uYmZLNCfy23x3yzl+tEhx0ZaKGXFmftid5psbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=k0NH52mT; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=e2U0S+R40JA/8Y/UUs6naRgYG7DrA2GyrAQ3SGnFjZ4=; t=1758374722;
	x=1758979522; b=k0NH52mTUMTMIupoVjCT3GqXZpfkWbQozThKOrJTg54zTgAhkrV0hizGUvB4h
	pqe9g5ahCnKN3L2jlSVVBDohP0pWrs3a5kDGt84MLRG7QkBkexJdM9G6/l6tZgPkjIYloiVAI2RLs
	iMtN1zPVobBec84CCuzNg598Swri9IdKbx8esCLCI4rDiwdrUeL98ZKJ9lUvxD1o0U6V9ilfvG1J2
	RW7BnCLuZc7HxCE0yLokhLxfjtz6CglAPPVptKRd2ughkfmzF57s3pXWZ04Xyt1o5+BQEKgy9VGOG
	tvis7DTydNQ5dTNQ/4FQEJHpxtkl/V8uBxLC3+HiPJHn6i0tTQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uzxa9-00000002Tuo-1mKc; Sat, 20 Sep 2025 15:24:53 +0200
Received: from dynamic-077-011-103-224.77.11.pool.telefonica.de ([77.11.103.224] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uzxa9-00000000uE8-0N7C; Sat, 20 Sep 2025 15:24:53 +0200
Message-ID: <9a122c6cf3e2e0e61a62b0512eb97804acebeee9.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 00/36] sparc64: vdso: Switch to the generic vDSO
 library
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Andy Lutomirski	 <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino	 <vincenzo.frascino@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, "David S. Miller"	 <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Nick Alcock	 <nick.alcock@oracle.com>, John Stultz
 <jstultz@google.com>, Stephen Boyd	 <sboyd@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Catalin Marinas	 <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Theodore Ts'o	 <tytso@mit.edu>, "Jason A. Donenfeld"
 <Jason@zx2c4.com>, Russell King	 <linux@armlinux.org.uk>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy	
 <christophe.leroy@csgroup.eu>, Huacai Chen <chenhuacai@kernel.org>, WANG
 Xuerui	 <kernel@xen0n.name>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev	 <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,  Sven Schnelle
 <svens@linux.ibm.com>, Nagarathnam Muthusamy
 <nagarathnam.muthusamy@oracle.com>, Shannon Nelson	 <sln@onemain.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, Arnd Bergmann
	 <arnd@kernel.org>
Date: Sat, 20 Sep 2025 15:24:51 +0200
In-Reply-To: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
References: 
	<20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
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

On Wed, 2025-09-17 at 16:00 +0200, Thomas Wei=C3=9Fschuh wrote:
> The generic vDSO provides a lot common functionality shared between
> different architectures. SPARC is the last architecture not using it,
> preventing some necessary code cleanup.
>=20
> Make use of the generic infrastructure.
>=20
> Follow-up to and replacement for Arnd's SPARC vDSO removal patches:
> https://lore.kernel.org/lkml/20250707144726.4008707-1-arnd@kernel.org/
>=20
> Tested on a Niagara T4 and QEMU.
>=20
> This has a semantic conflict with my series "vdso: Reject absolute
> relocations during build". The last patch of this series expects all user=
s
> of the generic vDSO library to use the vdsocheck tool.
> This is not the case (yet) for SPARC64. I do have the patches for the
> integration, the specifics will depend on which series is applied first.
>=20
> Based on tip/timers/vdso.

Could you share a version of the series based on top of 6.17.0-rcN for
testing purposes? I would like to test the series on a Sun Netra 240
which is based on the UltraSPARC IIIi.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

