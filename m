Return-Path: <linux-kselftest+bounces-16537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D6D962676
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 14:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF3B1C2165E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 12:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F92916D4F3;
	Wed, 28 Aug 2024 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="VGaA/2PX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97F015EFA0;
	Wed, 28 Aug 2024 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846443; cv=none; b=ZKjyWJire2IbehscVmhYyHgClDK4+eFcQdP2jfm3iG8fH+E6MYk6OIA39tCQfrHkgBrJiQnivJAfWuRSPlUofK+vyWop624tsZnz9QrQV31ot7ViYKXDLEWRG0RF6XAmWP1UZYXZvi1ETzxb0o/O8KWL83U7ahdKXm1QZtSu4h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846443; c=relaxed/simple;
	bh=PUtavT1G6dCH1wjOCY7rHYj9sbx2m80rOCs6MQMwaVo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f/TktR9KdPWxWamVZD0NEeVRvyA4X6ogKH4pBdFIC+2PUJRUJ0eZMcaVsQgSfocNdUQg9xTvx31uFTKWWQEwqff4GpftOxo0VLKQz2RORumMYQQlBuQoyjJnudTXvmksvl5WANlli2rKwFwghsVMQjYKvl0rhPJALE8ruyXSfpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=VGaA/2PX; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1724846441;
	bh=PUtavT1G6dCH1wjOCY7rHYj9sbx2m80rOCs6MQMwaVo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VGaA/2PX32LO7zkzQ8+iE6AYRuu+WmYcFZpUm//HZRKAEEbjxwcZvHoMuJRWAqFrR
	 aniF48V3+0oH7NxQ2V/wh0TbMLR+q6e7KXjDxwdy4+7V97OtkChsY0LgvYyUKn1vO+
	 04RKE9UjfoSfaURpwRHT6WUefp9kNXWMap4MW6ig=
Received: from [192.168.124.6] (unknown [113.200.174.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 0232B6656F;
	Wed, 28 Aug 2024 08:00:37 -0400 (EDT)
Message-ID: <ecb34dc47b7c3b6a11fe2a3e132efc6b46e291b4.camel@xry111.site>
Subject: Re: [PATCH v4 3/4] selftests/vDSO: Use KHDR_INCLUDES to locate UAPI
 headers for vdso_test_getrandom
From: Xi Ruoyao <xry111@xry111.site>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, Jinyang He
 <hejinyang@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, Arnd
 Bergmann <arnd@arndb.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Date: Wed, 28 Aug 2024 20:00:35 +0800
In-Reply-To: <Zs8Lo9IM9zO0iwXd@zx2c4.com>
References: <Zs3blfx1inX_FQLR@zx2c4.com>
	 <019268d4-c177-49e7-aab3-b8fa431905ca@cs-soprasteria.com>
	 <Zs3fhiSlXg2aCGa8@zx2c4.com>
	 <e9a2257f1447ce11e1f22e9a3c64d4b18aa428e1.camel@xry111.site>
	 <0730ca3a-e158-44ea-bb9e-1a7716b45360@csgroup.eu>
	 <Zs3qEMQOv5MAipox@zx2c4.com>
	 <0b540679ec8cfccec75aeb3463810924f6ff71e6.camel@xry111.site>
	 <Zs3sVv43djP3W2yc@zx2c4.com>
	 <d1707f9c173f80588c2917f6289c1394802d6229.camel@xry111.site>
	 <CAHmME9rpVOy7wteac6BS9N++rsEELA98QR-LEjWLD8MjSLoJvA@mail.gmail.com>
	 <Zs8Lo9IM9zO0iwXd@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-28 at 13:36 +0200, Jason A. Donenfeld wrote:
> On Tue, Aug 27, 2024 at 05:29:56PM +0200, Jason A. Donenfeld wrote:
> > On Tue, Aug 27, 2024 at 5:29=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> =
wrote:
> > > Or, I can add $(KHDR_INCLUDES) but also keep
> > > -isystem $(top_srcdir)/include/uapi, so "make -C tools/testing/selfte=
sts
> > > TARGETS=3DvDSO" will still (happens to) work on x86 and ppc (without
> > > headers in kernel-tree/usr).
> >=20
> > Oh, the porquenolosdos solution. That sounds good to me.
>=20
>=20
> Does the below work for you?

Yes, it works.

> From 0a769491e0193cdf9728a23d02be5e6be975b513 Mon Sep 17 00:00:00 2001
> From: Xi Ruoyao <xry111@xry111.site>
> Date: Wed, 28 Aug 2024 13:29:57 +0200
> Subject: [PATCH] selftests/vDSO: use KHDR_INCLUDES to locate UAPI headers=
 for
> =C2=A0vdso_test_getrandom
>=20
> Building test_vdso_getrandom currently leads to following issue:
>=20
> =C2=A0=C2=A0=C2=A0 In file included from /home/xry111/git-repos/linux/too=
ls/include/linux/compiler_types.h:36,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from /home/xry111/git-repo=
s/linux/include/uapi/linux/stddef.h:5,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from /home/xry111/git-repo=
s/linux/include/uapi/linux/posix_types.h:5,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from /usr/include/asm/sigc=
ontext.h:12,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from /usr/include/bits/sig=
context.h:30,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from /usr/include/signal.h=
:301,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from vdso_test_getrandom.c=
:14:
> =C2=A0=C2=A0=C2=A0 /home/xry111/git-repos/linux/tools/include/linux/compi=
ler-gcc.h:3:2: error: #error "Please don't include <linux/compiler-gcc.h> d=
irectly, include <linux/compiler.h> instead."
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3 | #error "Please don't inclu=
de <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 ^~~~~
>=20
> It's because the compiler_types.h inclusion in
> include/uapi/linux/stddef.h is expected to be removed by the
> header_install.sh script, as compiler_types.h shouldn't be used from
> user space.
>=20
> Add KHDR_INCLUDES before the existing include/uapi inclusion so that
> usr/include takes precedence if it's populated.
>=20
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> =C2=A0tools/testing/selftests/vDSO/Makefile | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selfte=
sts/vDSO/Makefile
> index d1452c7d6d4f..13a626ef64f7 100644
> --- a/tools/testing/selftests/vDSO/Makefile
> +++ b/tools/testing/selftests/vDSO/Makefile
> @@ -39,6 +39,7 @@ $(OUTPUT)/vdso_test_correctness: LDFLAGS +=3D -ldl
>=20
> =C2=A0$(OUTPUT)/vdso_test_getrandom: parse_vdso.c
> =C2=A0$(OUTPUT)/vdso_test_getrandom: CFLAGS +=3D -isystem $(top_srcdir)/t=
ools/include \
> +					 $(KHDR_INCLUDES) \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 -isystem $(top_srcdir)/include/uapi
>=20
> =C2=A0$(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(ARCH)/vdso/v=
getrandom-chacha.S
> --
> 2.46.0
>=20
>=20

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

