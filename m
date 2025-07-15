Return-Path: <linux-kselftest+bounces-37366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D40B06332
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 17:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371CE1AA275F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 15:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7839224337B;
	Tue, 15 Jul 2025 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQyysHlf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA0F2AD2D;
	Tue, 15 Jul 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594076; cv=none; b=IblhCEzSUrtD9EjWoc6KKH6HoCxRdOLyPEDqfQmjVg34OGhtLuUt3ScBN5bTo8KRGZaIEdy71/KY5ULoFfM+Uy33kOz465wAk6nEPIYheuJfxKo2nrTWM152Q4h6aFrEvHp5BlwyPuXXmhcBjJECHCFq++VPdgf9CK6LpZSyIiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594076; c=relaxed/simple;
	bh=nsrtnQIEqo/9toTmS791NZyWW4l5LXFWwuQd8lEs75E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inTCba7cGEQCYzEvKgmtUcrHredoscvCtiMJpRPsMmOHZqclCGSEG0c7YC6M16/FHpX2zgOahtlKZ8I8rb5W65pGS7/Q7HfYiDO4jz4Ya2FwhUJgXjPrYwIjwdq/TNvtBjTkxXhKoYC4f1OHfIC6et5sE4m1beD7VNzqtU5WZrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQyysHlf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-455b00283a5so24871995e9.0;
        Tue, 15 Jul 2025 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752594073; x=1753198873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vP/jid/lwTMuSUYEVvS3TKkMNboILXns6WgZgd7cJYQ=;
        b=TQyysHlfyd+MY/H0hig/TyBlHx85Z2r6n4J9g1EVlFNLwO6AOSBVqUwJ/N/Va/upUt
         sxrbl/SHsF0Ukk+3eGyyKqIOaCr6wqqIpJwjFyc3ZPVXOKa6to/BW9HfvyggA8xqmvip
         BEUNwlYPr7BE9RZx1w4+PfCDypLVv6qLw1rjvetQf4F6e0n7JsZwBV9qJKhXH4V6YQyf
         eWqmmVdLlFqGr2Bv9A+W4t8o5cp4ghzfO1Nla1TvpL00ZEOAlF5+z5fx4cOk8mdRLi3D
         s7oglV6m6nODrtrIcZoMgn1OSdhlAASP6KyhdZExfOqugZiJMm5r2DKBCmnTS0cV8H5b
         mHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594073; x=1753198873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vP/jid/lwTMuSUYEVvS3TKkMNboILXns6WgZgd7cJYQ=;
        b=QtzJuVx0SJSHPlUAocN3izv0MNCmWA4qH/0U7iv7KhpvSQ5QvulACbiHHAwv+e2jWR
         x0ZDdEwnjzXWS6IIUVZvu3lJOLoCFLz1tAyMU1nHmEmpRnqJRMswQW2Lgl3nhDp+VVnn
         xMpOgA98iO/uvBR8x1TNJQ9vVK1/htaAMR6NQKuMeZ/H29KStrOm9J4raViFOq6gTrTD
         LafYKqKaxeuTMC3TgJMpqkcfmRaea8rVd68in4GVXV6W7Dezx4BAQ5AJd9TPTrqRNcOO
         JTMMPPS8AfSwK+YINsYiFgSQUFFieqV0NbB1tszuqUxgXYoUv07KRUd9JXNaE46YUpUZ
         oW6w==
X-Forwarded-Encrypted: i=1; AJvYcCVvMoPGcGC2Ccrf8vYF+6mGrORoJsMb6HaAhLwY6CFYVOhoo+thyBjd+lQY6pjtW0p55fM=@vger.kernel.org, AJvYcCW//1SbJXfe3KZEHAz1kG+QwR5N3ml4JyzrDS7x9qRbVbU+JoCTvCQK7vbYIdYLbRDNEOrk2TkmfxqmrbCW@vger.kernel.org, AJvYcCWWNZZjqHVnPZSE/m29e+FmqfvYr9JGVDFR/jG8o0vPOHwoi6ZEsD0dKaHwkKtzmI17mvOwXTnxfbDKREVDgum1@vger.kernel.org
X-Gm-Message-State: AOJu0YyR0x1AqT9J2+2+CqkVAt3hbTcQ/WQS8s6gRXomIKQbVpRBr82g
	RoQp24ourFLnCzZtmeco0K5Q853hXGKtV4IlMduQKBglRX4M6+mSXgFE1njvmofHScOavjj3Khd
	pLqE8Iw6Lz7wr0cuggxn6xPlBBsILMuM=
X-Gm-Gg: ASbGncsVM02FPFnkFJu85MNZ6gF5mFsJVrfJB5qvSTud1/yb8vaxI1JAqLnMGUcjEPT
	9ZL7d39rjKgqVxaKVlu/u6oNwgopGjKs9VbXknJj6qJLEkN/C+6E7csBBDEw9FOzI2nDgye7id/
	WWXbloOuNi2mLwses9/+oo261VIY3cUzRA+mC9AtgRJel3f8tU7UgTZjtaXhNQchqatRyhjtJVC
	JeMClFsaOtlMONS7MejMtc=
X-Google-Smtp-Source: AGHT+IHUe55CPlfoXQFNA46EX3tD2L+zAmA4ABcayvzkZKklLjj2akBlQVEyroKE2ImpxzjeHZRCNGen3/yjsDKdInE=
X-Received: by 2002:adf:edd0:0:b0:3a5:2cb5:6429 with SMTP id
 ffacd0b85a97d-3b5f18d96camr13102332f8f.43.1752594072711; Tue, 15 Jul 2025
 08:41:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-arm64_relax_jit_comp-v1-0-3850fe189092@bootlin.com>
 <20250709-arm64_relax_jit_comp-v1-1-3850fe189092@bootlin.com>
 <aHZYcY_9JtK8so3C@willie-the-truck> <DBCONB7XHN7E.2UQMMG6RICMFY@bootlin.com> <aHZmOVpcoyTvGY1u@willie-the-truck>
In-Reply-To: <aHZmOVpcoyTvGY1u@willie-the-truck>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 15 Jul 2025 08:40:59 -0700
X-Gm-Features: Ac12FXzvpz_ddy7GAzzzXQfSfZjOu2uIdytRA66-cTwOPYu3QFq5bNb__jBKM6M
Message-ID: <CAADnVQK=x7p6zjvNbv0iqOfE73DM3j0nGSGrFX+pVExLMkJb=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf, arm64: remove structs on stack constraint
To: Will Deacon <will@kernel.org>
Cc: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 7:31=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Jul 15, 2025 at 04:02:25PM +0200, Alexis Lothor=C3=A9 wrote:
> > On Tue Jul 15, 2025 at 3:32 PM CEST, Will Deacon wrote:
> > > On Wed, Jul 09, 2025 at 10:36:55AM +0200, Alexis Lothor=C3=A9 (eBPF F=
oundation) wrote:
> > >> While introducing support for 9+ arguments for tracing programs on
> > >> ARM64, commit 9014cf56f13d ("bpf, arm64: Support up to 12 function
> > >> arguments") has also introduced a constraint preventing BPF trampoli=
nes
> > >> from being generated if the target function consumes a struct argume=
nt
> > >> passed on stack, because of uncertainties around the exact struct
> > >> location: if the struct has been marked as packed or with a custom
> > >> alignment, this info is not reflected in BTF data, and so generated
> > >> tracing trampolines could read the target function arguments at wron=
g
> > >> offsets.
> > >>
> > >> This issue is not specific to ARM64: there has been an attempt (see =
[1])
> > >> to bring the same constraint to other architectures JIT compilers. B=
ut
> > >> discussions following this attempt led to the move of this constrain=
t
> > >> out of the kernel (see [2]): instead of preventing the kernel from
> > >> generating trampolines for those functions consuming structs on stac=
k,
> > >> it is simpler to just make sure that those functions with uncertain
> > >> struct arguments location are not encoded in BTF information, and so
> > >> that one can not even attempt to attach a tracing program to such
> > >> function. The task is then deferred to pahole (see [3]).
> > >>
> > >> Now that the constraint is handled by pahole, remove it from the arm=
64
> > >> JIT compiler to keep it simple.
> > >>
> > >> [1] https://lore.kernel.org/bpf/20250613-deny_trampoline_structs_on_=
stack-v1-0-5be9211768c3@bootlin.com/
> > >> [2] https://lore.kernel.org/bpf/CAADnVQ+sj9XhscN9PdmTzjVa7Eif21noAUH=
3y1K6x5bWcL-5pg@mail.gmail.com/
> > >> [3] https://lore.kernel.org/bpf/20250707-btf_skip_structs_on_stack-v=
3-0-29569e086c12@bootlin.com/
> > >>
> > >> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore=
@bootlin.com>
> > >> ---
> > >>  arch/arm64/net/bpf_jit_comp.c | 5 -----
> > >>  1 file changed, 5 deletions(-)
> > >
> > > This is a question born more out of ignorance that insight, but how d=
o
> > > we ensure that the version of pahole being used is sufficiently
> > > up-to-date that the in-kernel check is not required?
> >
> > Based on earlier discussions, I am not convinced it is worth maintainin=
g
> > the check depending on the pahole version used in BTF. Other architectu=
res
> > exposing a JIT compiler don't have the in-kernel check and so are alrea=
dy
> > exposed to this very specific case, but discussions around my attempt t=
o
> > enforce the check on other JIT comp showed that the rarity of this case=
 do
> > not justify protecting it on kernel side (see [1]).
>
> I can understand why doing this in pahole rather than in each individual
> JIT is preferable, but I don't think there's any harm leaving the
> existing two line check in arm64 as long as older versions of pahole
> might be used, is there? I wouldn't say that removing it really
> simplifies the JIT compiler when you consider the rest of the
> implementation.
>
> Of course, once the kernel requires a version of pahole recent enough
> to contain [3], we should drop the check in the JIT compiler as the
> one in pahole looks like it's more selective about the functions it
> rejects.

I frankly don't see the point in adding and maintaining such checks
and code in the kernel for hypothetical cases that are not present
in the kernel and highly unlikely ever be.
The arm64 jit check was added out of abundance of caution.
There was way too much "caution".

