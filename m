Return-Path: <linux-kselftest+bounces-15349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137DE9522E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 21:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B29B2626B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 19:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E2F1BE876;
	Wed, 14 Aug 2024 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="J46Lf0+A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2DF1AED23;
	Wed, 14 Aug 2024 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665366; cv=none; b=VGCMnEfNT6b5Pq8hXDWcDWHibLLah86sQj/OrhaGge4Jn+34UkbMJtxhu+nGn2Xy8VQB8ySjfUsse5Wl2E5ooW3E9BC3VY78Su5O9GlO3+G7F2xlqBwvamoOWtlF2pY/S9sG/sJyqMzB1KIOwg5HuTvCmzmFW1tbZ0oAQv1K4Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665366; c=relaxed/simple;
	bh=ApSc4itxr6DZe/5F4/r7FSCP1lnQDcR2cXMe/D23CZc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ABumLNK2rw6O1Caa4tjVDw+CxefHcK0gnulcP9GHr8Vkg6rKDVFvekimhZbRby56eLnQWKfwKTnVBYB5LqNtdwnGYNQgWd+FON+yFk+ojDx6jXAtEmRp99C23fx59cIOiBpCncbU0uduj03UUk90+/Ovyztr8gVRBes/uhnwB9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=J46Lf0+A; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1723665362;
	bh=ApSc4itxr6DZe/5F4/r7FSCP1lnQDcR2cXMe/D23CZc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=J46Lf0+Ar/pvpjBHrp4fCpTLXKiJaRvgt6aqb8RjY5SEJPxiFvO0422q1gg/k1xtj
	 XhgPSUkE8DNnzuO5KpwGYfdQ/xC1nVOXOZ9k0leW01/lqKp3HjcBYw/ypq+bWrl+9D
	 nZ6mHVvWZqKNPjy6ZRy2THMrGIbhjz8fxujRdNmI=
Received: from [IPv6:240e:358:116e:cd00:dc73:854d:832e:3] (unknown [IPv6:240e:358:116e:cd00:dc73:854d:832e:3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id C262366F26;
	Wed, 14 Aug 2024 15:55:59 -0400 (EDT)
Message-ID: <a97e6b4232394e837666adbaf7e657900cb7b1a8.camel@xry111.site>
Subject: Re: [PATCH] arm64/vdso: Remove --hash-style=sysv
From: Xi Ruoyao <xry111@xry111.site>
To: Fangrui Song <maskray@google.com>, Catalin Marinas
 <catalin.marinas@arm.com>,  Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Thu, 15 Aug 2024 03:55:54 +0800
In-Reply-To: <20240718173423.1574395-1-maskray@google.com>
References: <20240718173423.1574395-1-maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-18 at 10:34 -0700, Fangrui Song wrote:
> glibc added support for .gnu.hash in 2006 and .hash has been obsoleted
> for more than one decade in many Linux distributions.=C2=A0 Using
> --hash-style=3Dsysv might imply unaddressed issues and confuse readers.
>=20
> Just drop the option and rely on the linker default, which is likely
> "both", or "gnu" when the distribution really wants to eliminate sysv
> hash overhead.
>=20
> Similar to commit 6b7e26547fad ("x86/vdso: Emit a GNU hash").
>=20
> Signed-off-by: Fangrui Song <maskray@google.com>

Hi Fangrui,

If I read tools/testing/selftests/vDSO/parse_vdso.c correctly, it does
know DT_GNU_HASH as at now.  Thus after this change the vDSO selftests
are skipped with "Couldn't find __vdso_gettimeofday" etc if the distro
enables --hash-style=3Dgnu by default.

So it seems we need to add DT_GNU_HASH support for parse_vdso.c to keep
test coverage.

> ---
> =C2=A0arch/arm64/kernel/vdso/Makefile=C2=A0=C2=A0 | 2 +-
> =C2=A0arch/arm64/kernel/vdso32/Makefile | 2 +-
> =C2=A02 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Mak=
efile
> index d63930c82839..d11da6461278 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -21,7 +21,7 @@ btildflags-$(CONFIG_ARM64_BTI_KERNEL) +=3D -z force-bti
> =C2=A0# potential future proofing if we end up with internal calls to the=
 exported
> =C2=A0# routines, as x86 does (see 6f121e548f83 ("x86, vdso: Reimplement =
vdso.so
> =C2=A0# preparation in build-time C")).
> -ldflags-y :=3D -shared -soname=3Dlinux-vdso.so.1 --hash-style=3Dsysv	\
> +ldflags-y :=3D -shared -soname=3Dlinux-vdso.so.1 \
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 -Bsymbolic --build-id=3Dsha1 -n $(btildfl=
ags-y)
> =C2=A0
> =C2=A0ifdef CONFIG_LD_ORPHAN_WARN
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32=
/Makefile
> index cc4508c604b2..25a2cb6317f3 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -98,7 +98,7 @@ VDSO_AFLAGS +=3D -D__ASSEMBLY__
> =C2=A0# From arm vDSO Makefile
> =C2=A0VDSO_LDFLAGS +=3D -Bsymbolic --no-undefined -soname=3Dlinux-vdso.so=
.1
> =C2=A0VDSO_LDFLAGS +=3D -z max-page-size=3D4096 -z common-page-size=3D409=
6
> -VDSO_LDFLAGS +=3D -shared --hash-style=3Dsysv --build-id=3Dsha1
> +VDSO_LDFLAGS +=3D -shared --build-id=3Dsha1
> =C2=A0VDSO_LDFLAGS +=3D --orphan-handling=3D$(CONFIG_LD_ORPHAN_WARN_LEVEL=
)
> =C2=A0
> =C2=A0

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

