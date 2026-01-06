Return-Path: <linux-kselftest+bounces-48285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC954CF8205
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 12:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C30130EBA7B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 11:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD23332ED8;
	Tue,  6 Jan 2026 11:40:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7EC33343F
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699627; cv=none; b=KrVdjA2bCOGemmsd5RVfEltLPXDhWbX42d7P0q3fHMUeyi7es75QUZb9Kzk5XpyGmsVtEApr4hJZ8yNq9AxBWLu20JQCw5Bs6o87tbWa65qfpvW4Wu574YraHHmXO0eoCrgqK9MwI3fG60f8GwkzXw9Y4or+vlgFovV+0I920lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699627; c=relaxed/simple;
	bh=G0g2CLpCcdqCGwrZqCGF94WaR2YyoAzwJ+25Yu8X9Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiyvxhJOJaVLX2uP9kL7RHOtYddn6bFoAyUUricOI4bw7V58HMbNudXmyW4aaFB2WhdgmEtDvRqZMNnNE6rJHX15nhVGBshR59F0kbRIB3bdwHt3Y+n/DkXhZtDi+VXQWS5hjO6ovpbhs6gjRlfB0n6qEh+t68RDsK07G0qDBGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5dd88eef2f3so289394137.3
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 03:40:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699624; x=1768304424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1F1cHPX3DEp9doHApHMoiEWIQ7QEP7KOhwn3H/3X3Kg=;
        b=ebYfkauNofn3io0t+iRwGROaJrnGz1tmpSQTQad58PkL/6swgbNteyOcsjRMxY18cJ
         chaJr1FjKGZy76XhPoaV47b2vMakp+1MOa4EfTW2vcVoLQnlyt56OxKU0HuuRGu63Fpo
         mnc9PiL4oHWruPjl7pE9LSdzRi82ZFmEBz68NmRMng9lqah6/940y9hzyPE5yJxuB8cu
         XyW69Wmkh+c/gE75eue677enfVLCtCCrqxJIp/GwWcz2YBAD/HwFSIf0ymDwxUJcd/yk
         63C0OPuUT2SqkBMHUmr4uzSGr0YmiVw48xcefkep/PPHg8nVeSN9HvcA0HlxsB5qmlSV
         ICZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXI68yT1HZR16lgeQgc/zALB69SrMVegDS9Hxt3K9lTM7GibfMb9OgV17RJKni2ufldB/lcaFupd1dNSuxZyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmDrtgkubmd8nHoZaDwsWnuM7RNtSgYLKSL638j/tD2YiBsf66
	L1S2mHZKEZJ04pNzv61MKJfpgYZpKJ4mzU7UU2UTHL74P1nBr17uw1LiCIyE+cvO
X-Gm-Gg: AY/fxX6GVHenGavmQyxmKsxUf8POK5ojBKZfJkuv8942w1hsVmPxlG5qbK17S1aQIGQ
	qtYqYjZeykUfuuDGDB9Rm0xRFnpfiXgfI54EyGnEXQO7AiXxNrU+0I/nv1bvcjwUFXX5wMw9Pq5
	AMIL6hGHVWpDkQONQ3wUgO6R7KVTn2l8Rt0TQg1+zmdsFo+ceYf3Xy8AR0uEh2sT7Ot2eEErYd9
	Cw+NcyeEbILkKkb/K4cRpshXmGlAaCTcxwHo3mWk2P4RE0NGfvo/rpfl185wlnA3QdGPzimN99D
	q5GNV6aHNIxQ5CsVUdBcmc0sh2BfkqE11BK23IYUUrJ0tOUjD2sxy6qjfVj6oTYFK1Is6fTEfY0
	46dZjBLvY5mF4tutORywxEhb9QZ0eDc8hqu3L/DcmDjPC6sXn182QBnJ0L+fzfneYUzG/L9Q4jc
	a/rHfmc7Cs8ZlHUks5ZNmnEMvnaEdRb818IN1yUKgawdB//d8yMqUS
X-Google-Smtp-Source: AGHT+IG0XdJ42EWphuLxchi+ZQDKNZDxPNLpLe+o7MTaaL+gj/aN0OWzLWtqk5OYKtCrgl9PpKjwwA==
X-Received: by 2002:a05:6102:4410:b0:5e5:66c6:d23e with SMTP id ada2fe7eead31-5ec742d6f04mr645215137.1.1767699624296;
        Tue, 06 Jan 2026 03:40:24 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944124a3386sm565887241.11.2026.01.06.03.40.23
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 03:40:23 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-55999cc2a87so227499e0c.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 03:40:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVoZpsy176W9wsa0c5lB5EStIexNaL2mlT/hXySoOV77VZY8z+KNObtE5sGIJhxddnH1T23p1kc+OQRyQclAPw=@vger.kernel.org
X-Received: by 2002:a05:6122:3390:b0:53c:6d68:1cce with SMTP id
 71dfb90a1353d-56339541a9fmr738108e0c.16.1767699623748; Tue, 06 Jan 2026
 03:40:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104-nolibc-sparc32-fix-v1-1-e341b06cbdb7@weissschuh.net>
In-Reply-To: <20260104-nolibc-sparc32-fix-v1-1-e341b06cbdb7@weissschuh.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Jan 2026 12:40:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUHBm_oiyeUumRc=avp+QCiCLZAfi0BvLwToAM3TumGmQ@mail.gmail.com>
X-Gm-Features: AQt7F2pER9IK-OLAa9pM5omymgCQefED5N7rIhF6C8J3ZOw-FM2VZA21gtABRv8
Message-ID: <CAMuHMdUHBm_oiyeUumRc=avp+QCiCLZAfi0BvLwToAM3TumGmQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/nolibc: fix sparc32 tests with -mcpu=v9
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Sun, 4 Jan 2026 at 23:14, Thomas Wei=C3=9Fschuh <linux@weissschuh.net> w=
rote:
> Since LLVM commit 39e30508a7f6 ("[Driver][Sparc] Default to -mcpu=3Dv9 fo=
r
> 32-bit Linux/sparc64 (#109278)"), clang defaults to -mcpu=3Dv9 for 32-bit
> SPARC builds. -mcpu=3Dv9 generates instructions which are not recognized
> by qemu-sparc and qemu-system-sparc. Instead qemu-sparc32plus and
> qemu-system-sparc64 with a 64-bit kernel and CONFIG_COMPAT are needed.
>
> Rework the test setup so that -mcpu=3Dv9 also works correctly.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Thanks for your patch!

> --- a/tools/testing/selftests/nolibc/Makefile.nolibc
> +++ b/tools/testing/selftests/nolibc/Makefile.nolibc
> @@ -117,7 +117,7 @@ DEFCONFIG_riscv32    =3D rv32_defconfig
>  DEFCONFIG_riscv64    =3D defconfig
>  DEFCONFIG_s390x      =3D defconfig
>  DEFCONFIG_loongarch  =3D defconfig
> -DEFCONFIG_sparc32    =3D sparc32_defconfig
> +DEFCONFIG_sparc32    =3D sparc64_defconfig

How can we test sparc32 using a 64-bit kernel?

>  DEFCONFIG_sparc64    =3D sparc64_defconfig
>  DEFCONFIG_m68k       =3D virt_defconfig
>  DEFCONFIG_sh4        =3D rts7751r2dplus_defconfig
> @@ -155,7 +155,7 @@ QEMU_ARCH_riscv32    =3D riscv32
>  QEMU_ARCH_riscv64    =3D riscv64
>  QEMU_ARCH_s390x      =3D s390x
>  QEMU_ARCH_loongarch  =3D loongarch64
> -QEMU_ARCH_sparc32    =3D sparc
> +QEMU_ARCH_sparc32    =3D sparc64
>  QEMU_ARCH_sparc64    =3D sparc64
>  QEMU_ARCH_m68k       =3D m68k
>  QEMU_ARCH_sh4        =3D sh4
> @@ -164,6 +164,7 @@ QEMU_ARCH            =3D $(QEMU_ARCH_$(XARCH))
>  QEMU_ARCH_USER_ppc64le =3D ppc64le
>  QEMU_ARCH_USER_mipsn32le =3D mipsn32el
>  QEMU_ARCH_USER_mipsn32be =3D mipsn32
> +QEMU_ARCH_USER_sparc32 =3D sparc32plus
>  QEMU_ARCH_USER         =3D $(or $(QEMU_ARCH_USER_$(XARCH)),$(QEMU_ARCH_$=
(XARCH)))
>
>  QEMU_BIOS_DIR =3D /usr/share/edk2/
> @@ -195,7 +196,7 @@ QEMU_ARGS_riscv32    =3D -M virt -append "console=3Dt=
tyS0 panic=3D-1 $(TEST:%=3DNOLIBC_T
>  QEMU_ARGS_riscv64    =3D -M virt -append "console=3DttyS0 panic=3D-1 $(T=
EST:%=3DNOLIBC_TEST=3D%)"
>  QEMU_ARGS_s390x      =3D -M s390-ccw-virtio -append "console=3DttyS0 pan=
ic=3D-1 $(TEST:%=3DNOLIBC_TEST=3D%)"
>  QEMU_ARGS_loongarch  =3D -M virt -append "console=3DttyS0,115200 panic=
=3D-1 $(TEST:%=3DNOLIBC_TEST=3D%)"
> -QEMU_ARGS_sparc32    =3D -M SS-5 -m 256M -append "console=3DttyS0,115200=
 panic=3D-1 $(TEST:%=3DNOLIBC_TEST=3D%)"
> +QEMU_ARGS_sparc32    =3D -M sun4u -append "console=3DttyS0,115200 panic=
=3D-1 $(TEST:%=3DNOLIBC_TEST=3D%)"
>  QEMU_ARGS_sparc64    =3D -M sun4u -append "console=3DttyS0,115200 panic=
=3D-1 $(TEST:%=3DNOLIBC_TEST=3D%)"
>  QEMU_ARGS_m68k       =3D -M virt -append "console=3DttyGF0,115200 panic=
=3D-1 $(TEST:%=3DNOLIBC_TEST=3D%)"
>  QEMU_ARGS_sh4        =3D -M r2d -serial file:/dev/stdout -append "consol=
e=3DttySC1,115200 panic=3D-1 $(TEST:%=3DNOLIBC_TEST=3D%)"

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

