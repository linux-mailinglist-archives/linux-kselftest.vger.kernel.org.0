Return-Path: <linux-kselftest+bounces-10914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7587D8D4ADA
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 13:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D01B1B21D76
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 11:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006D9176182;
	Thu, 30 May 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="FpZS537T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D97174EC3;
	Thu, 30 May 2024 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068478; cv=none; b=SBJZZkblDM0t/6FV93OLDAY98SR1WSNRp16ClpITDXg9XaCooN6T9IjoGdi9dhNrTl0CYGsUUo7bxAjjY9ITPaUhMvgqzjqe093TspzUnaiNst2TSV55rD+JrJwogbNhlCEfkGMbWKseLyZT7syC34znoNjFh6kxmA5gub0bpDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068478; c=relaxed/simple;
	bh=QKCYv/9pkeewZS0wdLDjidR9iHNKpRPbnM/6kemvOTo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WxXhFvMtMjgVSzLpEp6TKhWoHVAJaB06pdJAhbGEJ9zqqfLQNc2QwR9nX3j4IXcpoKixFqCttojsYf0cuLYJ5q0pjYELEFSiIuRWNcpk8vpMWVlrtLF1h0L2vk7igPSIdiTnqmxZxx2fLTzJtXhfIIhQcLUB0wtBuPdqBk22Csk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=FpZS537T; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1717068464;
	bh=QKCYv/9pkeewZS0wdLDjidR9iHNKpRPbnM/6kemvOTo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FpZS537T3yPjs0iXwLB6GlRYL0cdPMhC1/wShIU0j7i47Zz9Tq4aKnr7A8nrfwGme
	 9lzOUhjVJGLOLZqyiXFOMnX8rKmDEv+3qt3eMOkee7hOiQVhkl2PN7zQ51r+NWqHBV
	 R1iDpMCyTvvksWQ0oQYf3mlL90Er9AtaOI0Fdkps=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 998376770C;
	Thu, 30 May 2024 07:27:34 -0400 (EDT)
Message-ID: <19dd3ba543ee3796afd4ee75daea199f56f32bcb.camel@xry111.site>
Subject: Re: [PATCH 2/6] loongarch: defconfig: drop RT_GROUP_SCHED=y
From: Xi Ruoyao <xry111@xry111.site>
To: Celeste Liu <coelacanthushex@gmail.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>, Anup Patel <anup@brainfault.org>, Guo
 Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>,  Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>,  =?ISO-8859-1?Q?Th=E9o?= Lebrun
 <theo.lebrun@bootlin.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, Sven Joachim
 <svenjoac@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Russell King <linux@armlinux.org.uk>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Tony
 Lindgren <tony@atomide.com>,  Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, 
 Mykola Lysenko <mykolal@fb.com>, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
  linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lennart Poettering <lennart@poettering.net>, 
 Icenowy Zheng
	 <uwu@icenowy.me>
Date: Thu, 30 May 2024 19:27:32 +0800
In-Reply-To: <20240530111947.549474-10-CoelacanthusHex@gmail.com>
References: <20240530111947.549474-8-CoelacanthusHex@gmail.com>
	 <20240530111947.549474-10-CoelacanthusHex@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-30 at 19:19 +0800, Celeste Liu wrote:
> For cgroup v1, if turned on, and there's any cgroup in the "cpu" hierarch=
y it
> needs an RT budget assigned, otherwise the processes in it will not be ab=
le to
> get RT at all. The problem with RT group scheduling is that it requires t=
he
> budget assigned but there's no way we could assign a default budget, sinc=
e the
> values to assign are both upper and lower time limits, are absolute, and =
need to
> be sum up to < 1 for each individal cgroup. That means we cannot really c=
ome up
> with values that would work by default in the general case.[1]
>=20
> For cgroup v2, it's almost unusable as well. If it turned on, the cpu con=
troller
> can only be enabled when all RT processes are in the root cgroup. But it =
will
> lose the benefits of cgroup v2 if all RT process were placed in the same =
cgroup.
>=20
> Red Hat, Gentoo, Arch Linux and Debian all disable it. systemd also doesn=
't
> support it.[2]
>=20
> [1]: https://bugzilla.redhat.com/show_bug.cgi?id=3D1229700
> [2]: https://github.com/systemd/systemd/issues/13781#issuecomment-5491643=
83
>=20
> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>

As a distro maintainer who had once been bitten by this option:

Reviewed-by: Xi Ruoyao <xry111@xry111.site>

> ---
> =C2=A0arch/loongarch/configs/loongson3_defconfig | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/=
configs/loongson3_defconfig
> index b4252c357c8e..4d93adb3f1a2 100644
> --- a/arch/loongarch/configs/loongson3_defconfig
> +++ b/arch/loongarch/configs/loongson3_defconfig
> @@ -23,7 +23,6 @@ CONFIG_NUMA_BALANCING=3Dy
> =C2=A0CONFIG_MEMCG=3Dy
> =C2=A0CONFIG_BLK_CGROUP=3Dy
> =C2=A0CONFIG_CFS_BANDWIDTH=3Dy
> -CONFIG_RT_GROUP_SCHED=3Dy
> =C2=A0CONFIG_CGROUP_PIDS=3Dy
> =C2=A0CONFIG_CGROUP_RDMA=3Dy
> =C2=A0CONFIG_CGROUP_FREEZER=3Dy

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

