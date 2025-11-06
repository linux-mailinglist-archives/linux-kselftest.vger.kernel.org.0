Return-Path: <linux-kselftest+bounces-44965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 718C4C3B44B
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 14:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B25F561BDE
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 13:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CAC330B37;
	Thu,  6 Nov 2025 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7bNYOIq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0AD30101B;
	Thu,  6 Nov 2025 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435719; cv=none; b=BXENPLHd3g5jeyuOjkRjuutl1S7pZDT/xBoBZgw01MFcGTvkTQ7bDYi9wMDiuFRl0AYXSJzLT5OANDa8XD3DHojfSMuh4atgI/R6iBbsomcVbuQaZMEEpp6FLLJYcHXZhoeRw6iN1L5YKXFzKCA11M4AlWRvIce6Ht01xLIl82A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435719; c=relaxed/simple;
	bh=pHx7Ian/X+twZyKuV1qCMvRdBak+Kdv7mBA0LYUw3f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StXMWBbXSOWenm58zUgE7Q2XdT18HzmJQrffJeiHUthA7CclERu/xZIcuM0E/EciJL4khoUOAIEehOsjTl24h1s1BsWIcPD87lx6Tz5pucyKNGs2vVSoMjtrNZ6VURsJLVan+GHf6n+2lGVCMjGMcih+GST91cFjoQrSGdewgQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7bNYOIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FECAC116C6;
	Thu,  6 Nov 2025 13:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762435718;
	bh=pHx7Ian/X+twZyKuV1qCMvRdBak+Kdv7mBA0LYUw3f0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7bNYOIqPwAUgWLm4YhM3ffu/zRMoeKCp1eaXQXhrENpICHRiNCuTEmHlBT96Z0m+
	 F+hbg+7uygvNI5ZgSUDkFkVZN3J4a3XXTZfjnsO0kWxk0cXKGL7xAEkWLHyZA7TURp
	 dYkbgQnJ/WEsW1RozEKGwAAOYPl5T6iYV5aI3ERUNB0+PPe4x5IEzG9qug+JyCr1D1
	 2RTLdw/FwcxrfwHiwlxipFJDFyNVTP7NwxOoHf5HOeKKAJsEn4efEFhjEgriWoqLT6
	 x4ohT4c5UPSiBGo0raXEauWkpqzfT16ujOYEikscoo4VmJ6bzZVvsyjOXRU8pan2yg
	 y70+cTCKx1mbA==
Date: Thu, 6 Nov 2025 13:28:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Nick Alcock <nick.alcock@oracle.com>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Russell King <linux@armlinux.org.uk>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
	Shannon Nelson <sln@onemain.com>, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-s390@vger.kernel.org, Aishwarya.TCV@arm.com,
	Ryan.Roberts@arm.com
Subject: Re: [PATCH v4 23/35] vdso/datastore: Map pages through struct page
Message-ID: <aQyig5TNkw2YJm19@finisterre.sirena.org.uk>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j5CacU2bPsziLjSM"
Content-Disposition: inline
In-Reply-To: <e7f05748-a11c-47eb-b1fa-cdc9dc6d05e0@samsung.com>
X-Cookie: Forty two.


--j5CacU2bPsziLjSM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 09:44:38AM +0100, Marek Szyprowski wrote:
> On 03.11.2025 16:24, Mark Brown wrote:
> > On Tue, Oct 14, 2025 at 08:49:09AM +0200, Thomas Wei=DFschuh wrote:

Copying in Ryan Roberts who's much more likely to have some idea about
memory management stuff for arm64 than I am (I have been poking at this
a bit but not got anywhere notable).  Not deleting context for his
benefit.

Given that this issue is very disruptive to userspace it's causing us to
miss huge amounts of test coverage for -next, would it be possible to
drop these patches until we resolve the issue?

> >> An upcoming change will allocate the datapages dynamically instead of =
as
> >> part of the kernel image. Such pages can only be mapped through
> >> 'struct page' and not through PFNs.

> > I'm seeing some boot failures on some arm64 platforms in -next which are
> > bisecting to this patch in -next.  Unfortunately the diagnostics aren't
> > super useful, we seem to just stop making progress in userspace with no
> > obvious output.  One sample log from the FVP is:

> >     https://lava.sirena.org.uk/scheduler/job/2036229#L1268

> > which isn't super instructive.  Not all platforms seem to be affected,
> > I've seen this on at least the Arm FVP, Orion O6 and Libretech Renegade
> > Elite.  The diagnostics aren't very clear here but given that I'm seeing
> > the same issue and bisect result on multiple platforms it seemed worth
> > mentioning.  Some platforms do seem fine.
> >
> > We do have some other serious breakage affecting arm64 in -next which
> > are making it hard to get a clear picture of which platforms are
> > affected, at least the FVP and O6 are unaffected by those other issues
> > (due to using MTE on platforms that don't have it, those platforms do
> > have MTE).
>=20
> I got almost the same result while bisecting on ARM 32bit Exynos-based=20
> boards, so the issue with this patchset is not fully ARM64 specific. For=
=20
> some reasons it also doesn't affect all systems though. It is even=20
> worse, because it affected only a subset of boards, but different for=20
> each tested commit. The observed failure looks exactly the same:
>=20
> ...
>=20
> [=A0=A0 10.199852] devtmpfs: mounted
> [=A0=A0 10.205013] Freeing unused kernel image (initmem) memory: 1024K
> [=A0=A0 10.210086] Run /sbin/init as init process
>=20
> INIT: version 2.88 booting
>=20
> (no more messages)
>=20
> The only difference is that bisecting on ARM32bit lead me to the next=20
> patch (10d91dac2ea5 ("vdso/datastore: Allocate data pages dynamically")=
=20
> / [PATCH v4 24/35]).
>=20
> Then I've tested it on ARM64bit (RaspberrryPi3b+ board) and got the=20
> following panic on 6a011a228293 ("vdso/datastore: Map pages through=20
> struct page") commit:
>=20
> VFS: Mounted root (ext4 filesystem) on device 179:3. Trying to move old=
=20
> root to /initrd ... okay devtmpfs: mounted Freeing unused kernel memory:=
=20
> 12672K Run /sbin/init as init process Unable to handle kernel paging=20
> request at virtual address ffffffffc20b5d48 Mem abort info: ESR =3D=20
> 0x0000000096000006 EC =3D 0x25: DABT (current EL), IL =3D 32 bits SET =3D=
 0,=20
> FnV =3D 0 EA =3D 0, S1PTW =3D 0 FSC =3D 0x06: level 2 translation fault D=
ata=20
> abort info: ISV =3D 0, ISS =3D 0x00000006, ISS2 =3D 0x00000000 CM =3D 0, =
WnR =3D=20
> 0, TnD =3D 0, TagAccess =3D 0 GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, X=
s =3D 0=20
> swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D000000000230b000=20
> [ffffffffc20b5d48] pgd=3D0000000000000000, p4d=3D0000000003618403,=20
> pud=3D0000000003619403, pmd=3D0000000000000000 Internal error: Oops:=20
> 0000000096000006 [#1] SMP Modules linked in: CPU: 2 UID: 0 PID: 1 Comm:=
=20
> init Tainted: G W 6.18.0-rc1+ #16136 PREEMPT Tainted: [W]=3DWARN Hardware=
=20
> name: Raspberry Pi 3 Model B (DT) pstate: 80000005 (Nzcv daif -PAN -UAO=
=20
> -TCO -DIT -SSBS BTYPE=3D--) pc : vvar_fault+0x7c/0x17c lr :=20
> vvar_fault+0x24/0x17c ... Call trace: vvar_fault+0x7c/0x17c (P)=20
> special_mapping_fault+0x24/0xd0 __do_fault+0x3c/0x238=20
> __handle_mm_fault+0xaa0/0x19e0 handle_mm_fault+0xcc/0x384=20
> do_page_fault+0x1a0/0x720 do_translation_fault+0x60/0x6c=20
> do_mem_abort+0x44/0x94 el0_da+0x54/0x230 el0t_64_sync_handler+0xd0/0xe4=
=20
> el0t_64_sync+0x198/0x19c Code: f2d83fe0 8b010063 d34cfc63 8b031803=20
> (f9400461) ---[ end trace 0000000000000000 ]--- Kernel panic - not=20
> syncing: Attempted to kill init! exitcode=3D0x0000000b SMP: stopping=20
> secondary CPUs Kernel Offset: disabled CPU features:=20
> 0x000000,00180000,40004000,0400421b Memory Limit: none ---[ end Kernel=20
> panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b ]---
>=20
> Reverting "clocksource: Remove ARCH_CLOCKSOURCE_DATA", "vdso/datastore:=
=20
> Allocate data pages dynamically" and "vdso/datastore: Map pages through=
=20
> struct page" on top of linux-next fixes booting on all tested boards.

--j5CacU2bPsziLjSM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkMooIACgkQJNaLcl1U
h9Dw7AgAg9GsCOBRN0q/qDr5G2z91i8kYc7YU3DdBVh5X2Y33e7iAavfRYtIa4CH
9JV1CKNyeqLhro3/zvRfWBzcwiZ/VPI7riN6BjNUieQz5HMu6gXnUzx1yOUdA/yS
fQKuGtBMlBpw9QNDjlWLSqtZVpoh5fbkIDESy9FeX/OoEY8UoPQhE4OOfs0aLZFa
4BoLnWHDTboRHK8i8/C4/0rwfsahUjaBmud4ues9QOd/Ry9S4LUgiKuBEY80Lb/O
vvkKrkg2oJDSrSlTGr2mAvK00J/P+YPOu4AFe6QAd1ws1YiIBwwKbYdFvccYPIDT
BAJJrme8pKXneraMH7ubTVy5zgWD0Q==
=jdSz
-----END PGP SIGNATURE-----

--j5CacU2bPsziLjSM--

