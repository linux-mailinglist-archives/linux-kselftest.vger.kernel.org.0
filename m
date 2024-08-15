Return-Path: <linux-kselftest+bounces-15380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1629952847
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 05:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2092D1F21C17
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 03:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F08B2C1A2;
	Thu, 15 Aug 2024 03:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0WBqIejO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E8763B9
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Aug 2024 03:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723692533; cv=none; b=K2qywmioLOphXdCVxcqWOe/4k60E9it3GAmioU3TPkgt6mPSXa8DV39vgBA7/saJOUGgOsYAny1qOlAVO15Hn8afnDe2NDYIY+vQjbqVzMC8qs4Mv55v4EHeKyAVNGP3ulCUNzIQJOn2qPDDaILa4SI/+qEGSoxsmy+QHvuhrPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723692533; c=relaxed/simple;
	bh=pHk2y705314CsPI2YL9Jn7MSA4P7y50mbU8JVEertSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5kbe9TRoj8PVl3iB+I6YX1Dwrl9NgZTeL/jHG+M25a3Ss0Hcw+TiwLjbBaR4YQrUUKYl31zxbi0lWxPY35/xMl61GJ0/TmVljZ5K/Ydd0ryS4L2Wo8NVg3tqJ8wA2N3RBbilV5T70SMkBVKJUUlp/MqUmJ2pbgtR84EGY9sfEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0WBqIejO; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53310adb4c3so56694e87.3
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2024 20:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723692529; x=1724297329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wjx59lWoXbwmdfqWfaPSPqk+zYnJcqiORbyfT+nNPs=;
        b=0WBqIejOVh2XJWAsQSDrUTVgILfj1m4oR9rmkdPEDEFASbj2S7qp5DIvdPelYbrTQz
         zatf8fxRlLrwLh4AAcf7neIelb5Cs/x80qEZwraGAriqLWgxZ/8z080BTYymTbNyA8bz
         rEemlnEeaKQQH1tUFrYAwSplKNW9NVsV0hwg5u4xtZ5E6VqA8iLIWx67zw5E2iX1maIc
         ZnEP8BJyksxsHiFIc5W6UP3pDsOpiXsC2kW/w+XZrEs+8MZl6DNEjbGP7xE+PqSGtAcC
         qFg69jTsDk6zRgsFaBrflx2TwYUHZpbmfeA7wdpTXPr21uHilz6BsLkVWA5J2Qt3bpqC
         9IRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723692529; x=1724297329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wjx59lWoXbwmdfqWfaPSPqk+zYnJcqiORbyfT+nNPs=;
        b=wSJRU9G6wvPs3rhzI8bSh+/4Vnt4yH58zubSCL5mVBjjLpsIn417kuyBFoCZYojJFV
         hd51UCs9oX9rpRJq2P8vPLlh2A4IiAFcDbY1rOWlfIiWaVFQdu6SsRVk4UppNklJ6Wbu
         qYETI4UWPwZzMHt+ggsd7KGiN2G4ZJgLyLmv/dt7QyAy5doGNU8wkLXFMcHUqpz98ieo
         pelvXWBTpdkxeImMFl8cV6GZfgtkXw0n/ANuYHYplRsFivl1mdJD40qFz87DMvcYL0EE
         A0X8aglLoF8kj2p0G8xQhKiR6SQLvgpEnZzXlTvAexXMyhTtanVPt57zxyuWK/fWXwfU
         dRHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTzVyk7jz7oQkoCgkOkDlP4XP6kr/GbiPz8aMWHsweFwv9eb0qQpItB31hipItw4S4mAsDx5ED7cBHcwm9g9PLmT03Tle5GkpFcUZIVEN6
X-Gm-Message-State: AOJu0YzEM4yoX1dmyfA86+2iN/veTFsrGmjlr79F6hyKQfopT5Wh7XHA
	3JkXWqgfmql+iCniWJ3asw0SzRyeHdNG8ROkC0085OpzWrYs2jCXK7GzS7HGfoeePv2XGfGSVrT
	SUXAMpFibeghu8hJy9OwlHWPYwS3MVxEfqA4P
X-Google-Smtp-Source: AGHT+IG+oFQPlgLf1D7mZieVo5I4Z9fny4yaWPInD4rQ6bQmW7z6rkEtgozX1zdXoPSI3L0Cf9iS9LwOrb1z3xYRvdk=
X-Received: by 2002:a05:6512:2216:b0:52e:74f5:d13 with SMTP id
 2adb3069b0e04-532eda81aa2mr2706631e87.30.1723692528957; Wed, 14 Aug 2024
 20:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718173423.1574395-1-maskray@google.com> <a97e6b4232394e837666adbaf7e657900cb7b1a8.camel@xry111.site>
 <CAFP8O3LcEZD2L6KFw-Qh5jGivtifFUzqTM=JceWKU4nJrBaBZg@mail.gmail.com>
In-Reply-To: <CAFP8O3LcEZD2L6KFw-Qh5jGivtifFUzqTM=JceWKU4nJrBaBZg@mail.gmail.com>
From: Fangrui Song <maskray@google.com>
Date: Wed, 14 Aug 2024 20:28:35 -0700
Message-ID: <CAFP8O3JdJ+NA_L4juLMN+C7ZsOws5OXJxxuoD+eq=6oSawkg0w@mail.gmail.com>
Subject: Re: [PATCH] arm64/vdso: Remove --hash-style=sysv
To: Xi Ruoyao <xry111@xry111.site>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 6:23=E2=80=AFPM Fangrui Song <maskray@google.com> w=
rote:
>
> On Wed, Aug 14, 2024 at 12:56=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> w=
rote:
> >
> > On Thu, 2024-07-18 at 10:34 -0700, Fangrui Song wrote:
> > > glibc added support for .gnu.hash in 2006 and .hash has been obsolete=
d
> > > for more than one decade in many Linux distributions.  Using
> > > --hash-style=3Dsysv might imply unaddressed issues and confuse reader=
s.
> > >
> > > Just drop the option and rely on the linker default, which is likely
> > > "both", or "gnu" when the distribution really wants to eliminate sysv
> > > hash overhead.
> > >
> > > Similar to commit 6b7e26547fad ("x86/vdso: Emit a GNU hash").
> > >
> > > Signed-off-by: Fangrui Song <maskray@google.com>
> >
> > Hi Fangrui,
> >
> > If I read tools/testing/selftests/vDSO/parse_vdso.c correctly, it does
> > know DT_GNU_HASH as at now.  Thus after this change the vDSO selftests
> > are skipped with "Couldn't find __vdso_gettimeofday" etc if the distro
> > enables --hash-style=3Dgnu by default.
> >
> > So it seems we need to add DT_GNU_HASH support for parse_vdso.c to keep
> > test coverage.
>
> Hi Xi,
>
> Perhaps the selftests file needs DT_GNU_HASH support like
> https://github.com/abseil/abseil-cpp/commit/1278ee9bd9bd4916181521fac96d6=
fa1100e38e6

Created https://lore.kernel.org/linux-kselftest/20240815032614.2747224-1-ma=
skray@google.com/T/#u
([PATCH] selftests/vDSO: support DT_GNU_HASH)

>
> > > ---
> > >  arch/arm64/kernel/vdso/Makefile   | 2 +-
> > >  arch/arm64/kernel/vdso32/Makefile | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso=
/Makefile
> > > index d63930c82839..d11da6461278 100644
> > > --- a/arch/arm64/kernel/vdso/Makefile
> > > +++ b/arch/arm64/kernel/vdso/Makefile
> > > @@ -21,7 +21,7 @@ btildflags-$(CONFIG_ARM64_BTI_KERNEL) +=3D -z force=
-bti
> > >  # potential future proofing if we end up with internal calls to the =
exported
> > >  # routines, as x86 does (see 6f121e548f83 ("x86, vdso: Reimplement v=
dso.so
> > >  # preparation in build-time C")).
> > > -ldflags-y :=3D -shared -soname=3Dlinux-vdso.so.1 --hash-style=3Dsysv=
       \
> > > +ldflags-y :=3D -shared -soname=3Dlinux-vdso.so.1 \
> > >            -Bsymbolic --build-id=3Dsha1 -n $(btildflags-y)
> > >
> > >  ifdef CONFIG_LD_ORPHAN_WARN
> > > diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vd=
so32/Makefile
> > > index cc4508c604b2..25a2cb6317f3 100644
> > > --- a/arch/arm64/kernel/vdso32/Makefile
> > > +++ b/arch/arm64/kernel/vdso32/Makefile
> > > @@ -98,7 +98,7 @@ VDSO_AFLAGS +=3D -D__ASSEMBLY__
> > >  # From arm vDSO Makefile
> > >  VDSO_LDFLAGS +=3D -Bsymbolic --no-undefined -soname=3Dlinux-vdso.so.=
1
> > >  VDSO_LDFLAGS +=3D -z max-page-size=3D4096 -z common-page-size=3D4096
> > > -VDSO_LDFLAGS +=3D -shared --hash-style=3Dsysv --build-id=3Dsha1
> > > +VDSO_LDFLAGS +=3D -shared --build-id=3Dsha1
> > >  VDSO_LDFLAGS +=3D --orphan-handling=3D$(CONFIG_LD_ORPHAN_WARN_LEVEL)
> > >
> > >
> >
> > --
> > Xi Ruoyao <xry111@xry111.site>
> > School of Aerospace Science and Technology, Xidian University
>
>
>
> --
> =E5=AE=8B=E6=96=B9=E7=9D=BF



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

