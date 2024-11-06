Return-Path: <linux-kselftest+bounces-21550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8279BF8D5
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 23:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84092843AE
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 22:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CD31DFE13;
	Wed,  6 Nov 2024 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNPSqa5n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42621D0E23;
	Wed,  6 Nov 2024 22:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730930656; cv=none; b=YR2zAMSXvwGa7AK+RTELIKpCEaUIl188AKQuAIcRitHL10X+r1OJja/fN8gaiOcdgt6TN61If7vNg1dR55G9Upp/JDN/2fHIKUU8cZjEtEnmhhjp7i+Afb+tFsP/zSa7zpI1tI0FHxhUFJY0gcEmfx8oe4+bmqe3SGXmTfNSPnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730930656; c=relaxed/simple;
	bh=XWlE48RqZQ5truz2JBDBGqsYLK+eKE8hxeJQAdnWLKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1BwLn8aNqV2xr1a75WhtL68vMjd0appGTPPxjDMFvlD1gCMpvn1cEynW+ErP16SQki03JY6uObJkB1s7ZpHeFXUkcjm5vil1QHiuHZ39L9BbrWw+6KRPEAQxnnDS6Z/2OzqsGhByItbMFqYL/7K/alsk6171Oqc1lWGy7uhhI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNPSqa5n; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2cc469c62so218563a91.2;
        Wed, 06 Nov 2024 14:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730930653; x=1731535453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfGNi4Eab08D4rDIFJXSfdEQm138IE7MugUyEGUzqSg=;
        b=MNPSqa5n7uio5spmm4M5r4BGlaadv+jD90XL8G1DjwCeWuiS0qzkOWDUplXPKwesf5
         jvplQ5zkvDa+E9GLbAoKGgM6JbxqUKosoVnXp8P2qXINrN8EQzlD0+/FyDIrhk3fBcqt
         z2JQb1Mcgv7y8/uLRa3CX7hS9ABCzRHr7oVTFwnfo8hH34mtKPkQPQRtAQoJTrkHM+Zm
         DZpysl9y453gKuUmcAO7Uzc2tHNNTyqYiw1kmS5/YMzch2VgyLC/2HuyV4dr2Az5GPDc
         eY/Jh46e2icruY4ZhKmK4biU/FHwkO9mFVRWegEXwtHZHGNxuPIO+IfZNDkbjZVh+zSG
         8VtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730930654; x=1731535454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfGNi4Eab08D4rDIFJXSfdEQm138IE7MugUyEGUzqSg=;
        b=B+/VH5MloSnyyrngddiXckFYi65fdLc0RixQhIN6OIIZi5o82GpVej2Pw4hgyan+J1
         cvPy3m9NF/yfShWf6mt4LHp5JF5xraVcDu2l//pf0rgUQnd3csHnetECZsJvJCEt2BP+
         Ry2NrQeoeOO4wall9gel0szWmzQEiOsYLZz8AyRbGwwajaRWC+5gv0vNPF9Ct9eYtiF7
         SrtXL/jlq9eQ7jn9ao3kbREqkzE2RxIer8RW00v6cmLhE/F6fq0jiXObq6o1AkLVQQXH
         xRvZCOPH5eCPYzTDTx+5cTx3DyLZbsZ5C6jKtI/n9X6O1efZHpdb8iAByUIU2NJdcz7y
         uYZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoHb1z2D4FDIxUIYaIaVxIqXzmyCdBbFPFgrPg+Hfk/VJ/AXAeTvwFIo0CCh+/9PLUuMDlyHUUIKXFqpD3EPO2@vger.kernel.org, AJvYcCVrDZfBya1QPXrRxpeXtU/mGaPqJxSwJ8dJpQAxznNgxp78K2lPrbEdKdHVb9iNTV/hNmQ=@vger.kernel.org, AJvYcCWz3A5bKYnqMoM1JiPeZKVbdeZnlJ9/YZjIwvbuMFZqlU0cGbq7dxBiyQcoXk0xktgtXAWWC8cy@vger.kernel.org, AJvYcCX83aeFlDOFJq/pk595YTtyWRGZV9pXYnpQCFa6Cx/I8jN64mlmevYPGTbl6u8og+D3XN/j+XftPYAmudkZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyxiF16u5DZHjizrTwzM9G+bkkHNGWlghx8PNWQB8NcGrSB76XC
	6IObvYVlYKMXcp/GbpzfCA45j6vMCyaDjWOZro2L/fuopoyFjjudmZA6TdR4zCIBZP52vhGzUBZ
	mQJTFeuJWiIIaYrfgaQrgZrST/5I=
X-Google-Smtp-Source: AGHT+IHiIFN3vV3i+lrEACl/mdE0HQWZtzx800XFbju733sBmVhjjP4bbDv2RZKt8j7XpLWja7xZVa0f8ftoFXrmJPw=
X-Received: by 2002:a17:90b:4a49:b0:2e2:b64e:f506 with SMTP id
 98e67ed59e1d1-2e94c2afe78mr30385346a91.13.1730930653594; Wed, 06 Nov 2024
 14:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927131355.350918-1-bjorn@kernel.org> <172835823300.66789.3704854116445399222.git-patchwork-notify@kernel.org>
 <87bjyvpa6h.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87bjyvpa6h.fsf@all.your.base.are.belong.to.us>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Nov 2024 14:04:01 -0800
Message-ID: <CAEf4BzZbq9OwSGi4pdb5_q8YkErfFiQFKYXg3g1rjpdejafx+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Add missing per-arch include path
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	bjorn@rivosinc.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	charlie@rivosinc.com, Andreas Schwab <schwab@suse.de>, Anand Moon <linux.amoon@gmail.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 2:26=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> patchwork-bot+netdevbpf@kernel.org writes:
>
> > Hello:
> >
> > This series was applied to bpf/bpf-next.git (master)
> > by Andrii Nakryiko <andrii@kernel.org>:
> >
> > On Fri, 27 Sep 2024 15:13:52 +0200 you wrote:
> >> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >>
> >> libbpf does not include the per-arch tools include path, e.g.
> >> tools/arch/riscv/include. Some architectures depend those files to
> >> build properly.
> >>
> >> Include tools/arch/$(SUBARCH)/include in the libbpf build.
> >>
> >> [...]
> >
> > Here is the summary with links:
> >   - [bpf-next,1/2] libbpf: Add missing per-arch include path
> >     https://git.kernel.org/bpf/bpf-next/c/710fbca820c7
> >   - [bpf-next,2/2] selftests: bpf: Add missing per-arch include path
> >     https://git.kernel.org/bpf/bpf-next/c/19090f0306f1
>
> Andrii, I just noted that this landed into bpf-next, and not bpf
> (fixes).

Hi Bjorn,

Yes, libbpf and selftests fixes are generally applied through
bpf-next, unless the issue is pretty bad and immediate.

I'm sorry, but unfortunately it's too late now to move those patches
as it's now been more than a month since they landed. For the future,
please let us know ASAP if you think patches were misrouted. I think
we are stuck with the need to do a stable backport for these, sorry.

>
> RISC-V libbpf/perf needs this fix in 6.12 to properly build. Would it be
> possible to have it in the bpf tree, and have it land in 6.12-rc7?
>
> Andreas that has a similar fix [1].
>
>
> Bj=C3=B6rn
>
> [1] https://lore.kernel.org/linux-riscv/mvm5xq44bqh.fsf@suse.de/

