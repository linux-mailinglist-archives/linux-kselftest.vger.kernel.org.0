Return-Path: <linux-kselftest+bounces-16398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A9A960C44
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 15:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737221F23278
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 13:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09691BFDF3;
	Tue, 27 Aug 2024 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WN+jOqIY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CED51BF331
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765889; cv=none; b=QVa4xVghU7cSpVJpFxCSxqefhbwjqv7ta+7TgSbl9pTUsNCNSJ2QEEeJnUvvmpMilF2xdsE9IEeVO0oT+8dRTC42HVpTHPHpurRXr52V2ej2SY/qHB3yKTYRhMnDFaAuYbtI5dxW8X3wDN3ZWHbSf2XR01HFk8B+QFKSsXzWLqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765889; c=relaxed/simple;
	bh=KcqWeQqUa8mkJeOfvtzcvANvJGASLiCkWsmpYD+EGRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EN9tXBI7Kx8AFpn4hxQbvbYYZLYXmL0rq5A04Ytv5mLlMN2yvi7cY5+L1moPpRsBBNCixhS+LNlq66VDRXHC9KBWofywE7iQORmpMi+Pg0Vd+qeDG5EgPEljAd087vEZZ6io2Q419W/vArdOs5/tWnHZwOLTdGbwSPJy76qo3pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WN+jOqIY; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-534366c194fso4758782e87.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 06:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724765885; x=1725370685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2iF6EOe9nB/FqyvDS/bgCSVkaSQUAYsG2KVhhd5pLs=;
        b=WN+jOqIYp8COajjAzNMIphv5KE2mNmtaeaKQ2C7EMZxft7ZZI+djVJhdwJiv1HjKbE
         ELtri3efkZa13CPXhmew9UDzd4Xaciq42ONkIyCPsL4YD+H02idX6vz5Bknc3frIs0sh
         TyD3RTVsRYupt30K3uVZ9bczwMT03KBiu/sDaacttZkOvp7VsmyVsMznWhUpIBp489B4
         tJVg9P7uBSLog99MM1kwiXfCe1sNqkgkve4zLwNRfGrEP3XONF8H4oBbI1BJsrRBDt/L
         y71WCUYfZVi39a4O6Lse8nFcrrrnMlLMar1zJ9o5fCGLdduhSbcFeykvEku8SNm0nAuB
         HYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724765885; x=1725370685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2iF6EOe9nB/FqyvDS/bgCSVkaSQUAYsG2KVhhd5pLs=;
        b=afuK9C4c4OB0aX7GiWvwjzIpOcn1fCm15NDGBfQRoA+TN7Kyqd0PW2AqR52O2k96Bf
         d0aOncqSQ6QUwRwQ9B3CpZ1b5Tg4zrztaDKXXpREPOHEnD8bq/qx/x9uuKPWyWT+K/Xs
         Djf7Mc7OtnyHREkQKH4Y6xaC7SLcUEm4ow6g4qnA2En8wcl30xx3iEbtf11+C/vTvsA8
         sC3S2KMonBaGZJwuBzzIc2GE/oRGSxIRANz8z4cFTU5gstiZxX5e5kj5qIe3ucQ6fdpy
         bRh6v0OSAkDVeCPG6VB515etmxQtekfcDg5zQfMyEHrWdRPyBQ0x1XTeMktYJHDE+sTG
         HmsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVac2l/2UfJeFoqnJUhDOii4j+B5lEkoczFJbfCd8CL+RsiQ8G4687LsZ6mHJPXhOmdsx6XkDl3j0yJ9OeFdKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfMpmXwWdctv5y2UmzHNooXEG47DokfZtrcr8XDTbZwUKnkZ9h
	rEyr9VeiNPBZ+8iBPQYxUoUIjtcGvXMssa+8Ab2xq2lGxKt4SDUyxSYjPE/s3PqQcp2F1tIIq+A
	Lc9TrHItT5RTxYzHkmJ1jq04XXkhH/7o/vBX4
X-Google-Smtp-Source: AGHT+IEH9Sb1e1tggs++e4MjamlFC86TrEaJmAJigeho7q6h4UoaZpcDU3kKLcNcGzqjx2vD2qXSIgKOFTC4MW3cD3I=
X-Received: by 2002:a05:6512:3d1a:b0:52e:fd84:cec0 with SMTP id
 2adb3069b0e04-5344e4fb7b5mr1973800e87.52.1724765885007; Tue, 27 Aug 2024
 06:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815032614.2747224-1-maskray@google.com> <29c04b2f2b35588824447f4c91d3c89ed3ed8895.camel@xry111.site>
 <f9e2d443-9d20-498a-a2d7-fa2e13fbb3f9@linuxfoundation.org>
In-Reply-To: <f9e2d443-9d20-498a-a2d7-fa2e13fbb3f9@linuxfoundation.org>
From: Fangrui Song <maskray@google.com>
Date: Tue, 27 Aug 2024 22:37:51 +0900
Message-ID: <CAFP8O3JyU6HaHfrRSoSuqvKY3z50mOfwtoAvftFc2PG+2i5pKQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/vDSO: support DT_GNU_HASH
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Xi Ruoyao <xry111@xry111.site>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 10:12=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.=
org> wrote:
>
> On 8/26/24 00:07, Xi Ruoyao wrote:
> > On Wed, 2024-08-14 at 20:26 -0700, Fangrui Song wrote:
> >> glibc added support for DT_GNU_HASH in 2006 and DT_HASH has been
> >> obsoleted for more than one decade in many Linux distributions.
> >>
> >> Many vDSOs support DT_GNU_HASH. This patch adds selftests support.
> >>
> >> Signed-off-by: Fangrui Song <maskray@google.com>
> >> ---
> >
> > Ping.
> >
> > Some context: I'd change LoongArch vDSO to use the toolchain default
> > instead of forcing DT_HASH (note that LoongArch is launched decades
> > after all major distros switched to DT_GNU_HASH), but without the
> > selftest support we'll lose test coverage.
> >
> > And now ARM64 has already lost test coverage after commit 48f6430505c0.
> >
>
> I am seeing several checkpatch errors - please fix them and send me v2.
>
> thanks,
> -- Shuah
>

The applicable change is:

--- i/tools/testing/selftests/vDSO/parse_vdso.c
+++ w/tools/testing/selftests/vDSO/parse_vdso.c
@@ -177,7 +177,7 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
        if (vdso_info.gnu_hash) {
                vdso_info.nbucket =3D vdso_info.gnu_hash[0];
                /* The bucket array is located after the header (4
uint32) and the bloom
-                  filter (size_t array of gnu_hash[2] elements). */
+                * filter (size_t array of gnu_hash[2] elements). */
                vdso_info.bucket =3D vdso_info.gnu_hash + 4 +
                                   sizeof(size_t) / 4 * vdso_info.gnu_hash[=
2];
        } else {


Other checkpatch.pl output is not actionable. `ELF(Sym) *sym` instead
of `ELF(Sym) * sym` has the correct spacing (used in this file and
elsewhere ElfW in the code base).


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

