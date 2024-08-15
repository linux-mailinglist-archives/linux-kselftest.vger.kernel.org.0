Return-Path: <linux-kselftest+bounces-15374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0986E95277D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 03:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1E71C2171F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 01:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE27936D;
	Thu, 15 Aug 2024 01:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l+ad4dot"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E273F64A
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Aug 2024 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723685040; cv=none; b=nxM5witp8HacWUDf7pj6fDZP9c/PzzjPLQO7pFVncpzwMtuKZPiivT9VuoBbJDS1GgZwz+K3e6flyfj3rfgcbcXL/SY18+VXhLKMjF5DzsszQ/xGqYBiiq63eDQhaZrzOtSUjbj4ZTYX6sA4cdTHN0XvGqsUfX40LRqm75XQEPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723685040; c=relaxed/simple;
	bh=IPanApsJyaaxjvVuTuWizOqptJ7DXErfoFO3SGXCop0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3cHIBpoa7qOD7ybEgMRH4Rm+etSdLY1CghHhuD2CXO7YXPd+yyTiPkZyORBLrGG7wjSAhWJFiEdqM6DkKg5wvQb3evSJJCrscMNLnDUzCIJalN95AClfJMyyXRvqyAArhamStCkPWMkB9zSyKwiVbhDfJHGJhzVSfMQFkVMywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l+ad4dot; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efbb55d24so721939e87.1
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2024 18:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723685037; x=1724289837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQp22hCpTnstTtw8wIhx12A0v1Bwi4IEODinYcz0rtQ=;
        b=l+ad4dotl4owJTOhjdMSYifWNQVKlIRuh7owDtRHtMwuMh5B+ImRLmBA3b8hRhtZzR
         tfGjz7OHFOsxF0klpHorRNvSai/J+1KFJ+r2gZAIVAbK/tmZvZ4AgzqZOKj0dEA6kFtL
         FpOHWpUUPZGp2ZUh+vw7cNhjXtXwPBDQ9wk1DIEXGS/xEwN5jnzO5Pektgc4jL+4hIdl
         mZX1s2wYmH7jDdCXvPZJUapj9izE4XQQdZcPbDgjeEIBPy5rgkaAS4XucNdweaBCpSZS
         JZ7Fth1njJ2j3kil7VvofbU71bYwmzPmvYPE5GWrl75C4F+sHLJB+cAYUG1+9xali91z
         DK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723685037; x=1724289837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQp22hCpTnstTtw8wIhx12A0v1Bwi4IEODinYcz0rtQ=;
        b=GYAEjdleSkudyWsShmwxuzvqwopzxDojy2+vp+HIR0YGCBD8omYY4VTd0GDFfiUJXx
         ITr+U3JnoVWvvhiZflS1XOzv+p14YMMfxPuDAikqwIqjfouKGecXZuIy5wWZ1/2bV0QK
         qr3A4WZSfJzGDFtO8f8b7F5J9RlUSG9NMSJ450Fz0xlY6eVyk4vYCUohpmV1dLVVrjV8
         DCWLTRCs0K6p4NqBMAFi035EfxiVDA15kR7//lRbBV3zrFq7VbszJn3fvw0sluNIXupA
         Di6YidqZMpGt4hhesWTROO5o4DQWmufM6+Tm9fCv/fOAlqjoRQ8+ykOmAT0yGNjsvB3F
         1ddQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyP+F66xNMoipiWSepGt5Mz9KZiCfEupAj+26IxvTF5lgC5bVlpxN+e0wgiFVo0tnSdV/ZWFYHr57u/2RONMMICU3OF/qvHYE6TqSEH4oG
X-Gm-Message-State: AOJu0YzSVtWZYgikqAmVpFYTCJ4cimr4EvASziukyK4uNKW1pZU8Fy9X
	ejnCNHanvLCWkMuwFrFVbCeIU1acbgbUASZvbPEsni6JSzBuDyzjuLcQ7HtOPW2l6SIEJBqS69d
	qv/6gnOrX0t0B335Sj5s1xCE8uAzrUclSLisK
X-Google-Smtp-Source: AGHT+IFrmbv+IGINyaiTjjFMEcT1EM7N8NhQ+gfP0HDbTjV9qfqTdAooQ6NiqoWk3LCU+4dwnx1K8uEXRcbmhM9BWxg=
X-Received: by 2002:ac2:5695:0:b0:532:fb9e:a175 with SMTP id
 2adb3069b0e04-532fb9ea617mr2873611e87.6.1723685036624; Wed, 14 Aug 2024
 18:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718173423.1574395-1-maskray@google.com> <a97e6b4232394e837666adbaf7e657900cb7b1a8.camel@xry111.site>
In-Reply-To: <a97e6b4232394e837666adbaf7e657900cb7b1a8.camel@xry111.site>
From: Fangrui Song <maskray@google.com>
Date: Wed, 14 Aug 2024 18:23:43 -0700
Message-ID: <CAFP8O3LcEZD2L6KFw-Qh5jGivtifFUzqTM=JceWKU4nJrBaBZg@mail.gmail.com>
Subject: Re: [PATCH] arm64/vdso: Remove --hash-style=sysv
To: Xi Ruoyao <xry111@xry111.site>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 12:56=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wro=
te:
>
> On Thu, 2024-07-18 at 10:34 -0700, Fangrui Song wrote:
> > glibc added support for .gnu.hash in 2006 and .hash has been obsoleted
> > for more than one decade in many Linux distributions.  Using
> > --hash-style=3Dsysv might imply unaddressed issues and confuse readers.
> >
> > Just drop the option and rely on the linker default, which is likely
> > "both", or "gnu" when the distribution really wants to eliminate sysv
> > hash overhead.
> >
> > Similar to commit 6b7e26547fad ("x86/vdso: Emit a GNU hash").
> >
> > Signed-off-by: Fangrui Song <maskray@google.com>
>
> Hi Fangrui,
>
> If I read tools/testing/selftests/vDSO/parse_vdso.c correctly, it does
> know DT_GNU_HASH as at now.  Thus after this change the vDSO selftests
> are skipped with "Couldn't find __vdso_gettimeofday" etc if the distro
> enables --hash-style=3Dgnu by default.
>
> So it seems we need to add DT_GNU_HASH support for parse_vdso.c to keep
> test coverage.

Hi Xi,

Perhaps the selftests file needs DT_GNU_HASH support like
https://github.com/abseil/abseil-cpp/commit/1278ee9bd9bd4916181521fac96d6fa=
1100e38e6


> > ---
> >  arch/arm64/kernel/vdso/Makefile   | 2 +-
> >  arch/arm64/kernel/vdso32/Makefile | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/M=
akefile
> > index d63930c82839..d11da6461278 100644
> > --- a/arch/arm64/kernel/vdso/Makefile
> > +++ b/arch/arm64/kernel/vdso/Makefile
> > @@ -21,7 +21,7 @@ btildflags-$(CONFIG_ARM64_BTI_KERNEL) +=3D -z force-b=
ti
> >  # potential future proofing if we end up with internal calls to the ex=
ported
> >  # routines, as x86 does (see 6f121e548f83 ("x86, vdso: Reimplement vds=
o.so
> >  # preparation in build-time C")).
> > -ldflags-y :=3D -shared -soname=3Dlinux-vdso.so.1 --hash-style=3Dsysv  =
     \
> > +ldflags-y :=3D -shared -soname=3Dlinux-vdso.so.1 \
> >            -Bsymbolic --build-id=3Dsha1 -n $(btildflags-y)
> >
> >  ifdef CONFIG_LD_ORPHAN_WARN
> > diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso=
32/Makefile
> > index cc4508c604b2..25a2cb6317f3 100644
> > --- a/arch/arm64/kernel/vdso32/Makefile
> > +++ b/arch/arm64/kernel/vdso32/Makefile
> > @@ -98,7 +98,7 @@ VDSO_AFLAGS +=3D -D__ASSEMBLY__
> >  # From arm vDSO Makefile
> >  VDSO_LDFLAGS +=3D -Bsymbolic --no-undefined -soname=3Dlinux-vdso.so.1
> >  VDSO_LDFLAGS +=3D -z max-page-size=3D4096 -z common-page-size=3D4096
> > -VDSO_LDFLAGS +=3D -shared --hash-style=3Dsysv --build-id=3Dsha1
> > +VDSO_LDFLAGS +=3D -shared --build-id=3Dsha1
> >  VDSO_LDFLAGS +=3D --orphan-handling=3D$(CONFIG_LD_ORPHAN_WARN_LEVEL)
> >
> >
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

