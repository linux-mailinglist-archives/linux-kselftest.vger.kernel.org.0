Return-Path: <linux-kselftest+bounces-37771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 254D4B0CB42
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 22:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D39816FC35
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 20:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65243239E65;
	Mon, 21 Jul 2025 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q8Bzke5+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518E7238C3D;
	Mon, 21 Jul 2025 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128177; cv=none; b=Tkdd5eFKHEw3XQt8TL+69vssJ86ZONt6BVbFkf8Ia14TBieLlEEuDNRfdXeX+q2cyMl/5MbCsiD3XPflqwUwjokV/vdW45WfcW7owKmf3Vl/bfliNdd6nnre/oPRKpW0xo7D8fd9z/dwczEsVuzNw8OyjKrmVktdCILxCoS3WeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128177; c=relaxed/simple;
	bh=pXoWU9veiwZFqXfcQj4hfPSB156GlcTIOr4f0ulrhNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVM9dZfvX6W9/fLL1pkA3zrrcMey9kHZFK8vuGdRmbx+eSeoUWQlSBADuDostdcXPwitUz1kPP7tsz8+Ch2KeLPjdpLe8E4qNz/tWEXWPvgNde29+zkzMqNKGW1oZdUYQCwGJwqMOHWWUKxpUdOh3Rn3OVJWyKryJQ9wkOGUfQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q8Bzke5+; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 21 Jul 2025 22:02:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753128162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=faRHgN5I3SJaokyooR8tND95TU4Zl2EbUy+q1BeFqEE=;
	b=Q8Bzke5+07H93rEHZBxSdaUZQO1HcSJZZbt3Y31GkjyWATtGLr9GYplTDdMz9XA5tI1+Qt
	Mse4e9n9h6U8ANxFWVdiKbdr9BlxJ8bvJzeTJkJQtiXhOKptSQSGIlERkBNxVvepTZrk0w
	VZSK32PGBIQJoDgradRp6NFwqNeMUhg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Nicolas Schier <nicolas.schier@linux.dev>
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v3 01/13] stackleak: Rename STACKLEAK to KSTACK_ERASE
Message-ID: <20250721-spiked-adamant-hyrax-eea284@lindesnes>
References: <20250717231756.make.423-kees@kernel.org>
 <20250717232519.2984886-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cgD5lPAL2MBjPn/0"
Content-Disposition: inline
In-Reply-To: <20250717232519.2984886-1-kees@kernel.org>
X-Operating-System: Debian GNU/Linux 13.0
X-Migadu-Flow: FLOW_OUT


--cgD5lPAL2MBjPn/0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 04:25:06PM -0700, Kees Cook wrote:
> In preparation for adding Clang sanitizer coverage stack depth tracking
> that can support stack depth callbacks:
>=20
> - Add the new top-level CONFIG_KSTACK_ERASE option which will be
>   implemented either with the stackleak GCC plugin, or with the Clang
>   stack depth callback support.
> - Rename CONFIG_GCC_PLUGIN_STACKLEAK as needed to CONFIG_KSTACK_ERASE,
>   but keep it for anything specific to the GCC plugin itself.
> - Rename all exposed "STACKLEAK" names and files to "KSTACK_ERASE" (named
>   for what it does rather than what it protects against), but leave as
>   many of the internals alone as possible to avoid even more churn.
>=20
> While here, also split "prev_lowest_stack" into CONFIG_KSTACK_ERASE_METRI=
CS,
> since that's the only place it is referenced from.
>=20
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: <x86@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: <linux-doc@vger.kernel.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Cc: <kvmarm@lists.linux.dev>
> Cc: <linux-riscv@lists.infradead.org>
> Cc: <linux-s390@vger.kernel.org>
> Cc: <linux-efi@vger.kernel.org>
> Cc: <linux-hardening@vger.kernel.org>
> Cc: <linux-kbuild@vger.kernel.org>
> Cc: <linux-security-module@vger.kernel.org>
> Cc: <linux-kselftest@vger.kernel.org>
> ---
>  arch/Kconfig                                  |  4 +--
>  arch/arm/Kconfig                              |  2 +-
>  arch/arm64/Kconfig                            |  2 +-
>  arch/riscv/Kconfig                            |  2 +-
>  arch/s390/Kconfig                             |  2 +-
>  arch/x86/Kconfig                              |  2 +-
>  security/Kconfig.hardening                    | 36 ++++++++++---------
>  arch/arm/boot/compressed/Makefile             |  2 +-
>  arch/arm64/kernel/pi/Makefile                 |  2 +-
>  arch/arm64/kvm/hyp/nvhe/Makefile              |  2 +-
>  arch/riscv/kernel/pi/Makefile                 |  2 +-
>  arch/riscv/purgatory/Makefile                 |  2 +-
>  arch/x86/purgatory/Makefile                   |  2 +-

Did you miss arch/loongarch/Kconfig by accident?

$ git grep -Hrne ARCH_STACKLEAK
arch/loongarch/Kconfig:127:     select HAVE_ARCH_STACKLEAK

Kind regards,
Nicolas

--cgD5lPAL2MBjPn/0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmh+nNwACgkQB1IKcBYm
EmlaKg/+Oulyjlzl6ITiwJiV1weZc0KBlop49wW3/ilmJ9U/16ChNrQlv9S6c21O
ytwj5NZ3lgiznFSMFUOkOxA6ctKIXVyGyNPSmJIUJ6Sqk9iHm3zMakHBxpr2uemy
DP6Nb6zORIiNJiTd3lVcdz1XQJRGfHfoMpUoW+GRKqQMtw4NyankD/eCESFv6mKh
T27cet3p0OMQg5S3lM/AD8uuhCxYlLXnD2LJ1XC7z5v9s2QMFnm2FKuEbwwRikgZ
k4V5IQ6fVjZRe7AuIZpAgOC2mWYkumx3EriVPGKNQu7L0MSQfUAjDF83NE4CBwIO
EKdR7rp9ZBpJXIQwG0SNnVDCG/xfryC0LzVorLlZOR65GUHYiONL5Eq+J2QE8zwZ
ugfv15CDaABIA5Rc6VW655EQePy0grJb6wQRpZAQRtsg5HQQfPgWXewm+OetC6sk
1yqSuYqUrmJ0j4usrxCxbZRrRcGzfdDuGAmg4XpUKrEJIZRxfsV5InrSJ+o2nA14
yjqgSeDRliPvyePCLddpnDyye4RgIyNgDQSuYJoivHQryIdrYJE3LIk+EoQdw3dv
c+5c9ea/sNADpeyyA/RAzDrLGAEXAh2qZFu/o71KZIUOwOLp6IjYtZ9MfI54KyhK
0TTlmcFody1uFinctfOk+8zBzO/foM1hkNF9knW0vJmnEV4khOU=
=dSeG
-----END PGP SIGNATURE-----

--cgD5lPAL2MBjPn/0--

