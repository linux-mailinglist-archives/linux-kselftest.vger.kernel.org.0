Return-Path: <linux-kselftest+bounces-49211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B312ED38925
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 23:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B00CE3033F86
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 22:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E483731076B;
	Fri, 16 Jan 2026 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jl6fwD5X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1BF30F552
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602048; cv=pass; b=JoOOv2ervLRNZmdT9h5nKcmEo9QdqGy16jWGhuCKiwcKw8YdBtB+t2BdUYQRlrd+Mz2KNWgMrIOGl/UcJotubZCRQyZnkYrdoeAw2M7WNc3scbjMquX8otJoHuEI4WgpYJA6xfJX9eUZsnL/SAK3Uykj4/uTkTBUtWmjHQvgl9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602048; c=relaxed/simple;
	bh=o5En9a8wP5By67GXNTiNQjIPnUWaBuLHMV9zVL0xjhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chEwJbHmkT1okyAj6shs50yBLUAEpCWXmp8kZsUnZ3IXrUG4xKdMG85deVkWsuiZ8RfI5wUiw4TYIUHSTIw1GqJMQ3mWoQbjXWOHncPbjRJgFqJvzd+iYelSTmbB1SfV9IOuDPen1sDyQnhM8j5ctE0sCmpl78kDZm4v+30D+Bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jl6fwD5X; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-bc0d7255434so994912a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 14:20:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768602047; cv=none;
        d=google.com; s=arc-20240605;
        b=ITT0aVtRksszEsAFb7d/s07ld1uLhOOELy4FoPswxSgL8IDuhw9+hXDsebLJnw6VyT
         zrSNLYj4QrmWKW064ECPFLGOwv1v4WOksUZa+Jf4ysVp6BHpOc/FsGEVvkYGJ4yV66aH
         lI6aNW75KPp5TKaoJqq+7BadDbVXfdOoZEgPJ8jteKKE4kC/AdUN6Le2l0GGOz1zt78h
         Pjty1cL+B+LQnrlEWZTjXTKr19KzjCAzr9JW1ZapCD+CwLg4EJq5UQm7ssMYlohQP4xY
         HvdYKy1WrWQ6azF/+i1WzvIiuxuMHIzXBfh5a93Mpzso5t3BT55ZMGYewhWBdOP8sCkg
         Quhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o5En9a8wP5By67GXNTiNQjIPnUWaBuLHMV9zVL0xjhM=;
        fh=qbOZE1PzxQqDrERrhBvyg9uLZUJ8I69VPBb1e38aLJQ=;
        b=GrM/dWWx4HZs1HfaJ/fcIgCBOkmTB5DJWA3PdQ7LcWB8otcGkaaeL9rMvl4bf1ThXq
         ZM0Sui+9PZNvOO/8fCkEdnWS1KhkIMeJgrs0vzsqJZaqpmDvPxWpFZOVDUHEiucgICAg
         bfd8r0amM69XZI2q8WU1xTpn7wsP6BcXNS4lPj0PLTWL41pC8iJaIIBbFscpM/cRfZWe
         13EcP5R0VUn6dkbo+DjRIFCLlzbHxz3+QZDltx2ws09AkOqnLwaVEeicLD5ylSlC1dvU
         V+XBatYFaRsMmgnWIvrDcESkEtfTAa2fHKZJC1JS+IYM+Xn2eGNnRDjhaxJpf1ZcsmOf
         P3Gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768602047; x=1769206847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5En9a8wP5By67GXNTiNQjIPnUWaBuLHMV9zVL0xjhM=;
        b=jl6fwD5XuK8nNz0w8naADUnEY83g5YEz8a/AJMTNwsu+p/9darZgynRx3h0TTCIPkU
         fQx5WKc/uQ9iHsZ2qE0eLzF4K6sHagBAuuYCAaJ4bPvgacdNyLKMwj7FuUh+UvvebEsB
         ujlvGefiQ16jpeIIsompuWkHE7czowuBkO+1XE8cmmFURBz1Jmhw+8ifaVXBzAMXjIEt
         svjgdadT9xkGnr25ipuogSTgwFcAdgyPf0ucI3nyrMQmpbNDj/BqDdZMj6YZDAXsxRWU
         9lgtgKxFEtEY9PBkgyhT3AHgvXFp3hrVdvONvtAw4w9uPXrpQQrNyYu6CTevJhN9i459
         5UBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602047; x=1769206847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o5En9a8wP5By67GXNTiNQjIPnUWaBuLHMV9zVL0xjhM=;
        b=a/HwBpILImd6KbUkNSoM7GZ1Fe+YvmLKwW2yVYY1eZcr4IccxXsK8xw8sRemlhbPJU
         o/KfMYk9EHNryZLQ4JYbYx1F8IHW52nufv72Mqc7LhiPCOkfZPOnikOuyOwD5o2yP+RY
         ONKLLbnZ4EtQNygwXPeGiUQB9rrGtdMW2YL1vmTRAqiojDAT69gZH+tzAYTwKfWsFKIW
         +0zHjUJcrTXsJJMpZlRKiYMETDRpCB+hMZ1/jQ0OE2W6iYg0h2NvQSHZnMrMqDernb5c
         RRMy7xropy/752zNkR6clddHB/I1X8qBxKPfxGwZ1fKYEfg/0bXV3HmQjXw/nhbmmW+R
         E3IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzQfSyzP8HqBs1aNBkpyoZPgLYACGvQHlzlfA9J+T8ZghLM75W7C90SILgOHZDtKfhnzF0gpzSvNAWJWJqxk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiss12P91Ek1pFAM3HcqDY+U41B0Wh1s2ngjG4u2+u/c9hNpBp
	0DTFRj7Ni2G9C2BIxWkG3gZew0UH4ms6UVo0XQm8KkuSexgwoBUwNPrzxBecDF07LjzEOiKpMSV
	zmCaBNjPgYGQAJ2IzYCPAHM9MdQHI86E=
X-Gm-Gg: AY/fxX4COeKSYO62iIyLNbqXuw9sS8Td1KbazWopg9CyW70IyzTLU37BynC5BK1suVx
	YyCzat+lPM84OYpazdb5A3DbWeKt7yBLphNVwgUNVUuueArvlmOe5aaH3c9rOnRtvMfTc2GSZSc
	lCx3fJJIFflL6W4Mb5RE5tUB3GQJw3EkcELB5lomDURymJepJRhAC0cOiOMpwAQHRfYJFl2UF8M
	wXKhvABGBmJM7t+CoBDNiHDH0jTp6VQ1YF5U0L9s2yP7jeLQ+Tce4XDWXQa32U5xdHQg43vZm3c
	PtWloLltliil2Kv9QFD3oQ==
X-Received: by 2002:a17:903:3888:b0:295:c2e7:7199 with SMTP id
 d9443c01a7336-2a7175a63fdmr36859055ad.29.1768602046673; Fri, 16 Jan 2026
 14:20:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-bpftool-tests-v1-0-cfab1cc9beaf@bootlin.com>
 <CAEf4BzYvZsjSpsDHXAuZ9G3=r4e27+c_LDpSUampw-fTfKA2=g@mail.gmail.com> <DFPUQZ5PNXKA.12KADC78HCRQ5@bootlin.com>
In-Reply-To: <DFPUQZ5PNXKA.12KADC78HCRQ5@bootlin.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jan 2026 14:20:33 -0800
X-Gm-Features: AZwV_Qj7HA8GkrLxttMYt-BAKc2j92CUeTQrxpfNtW9oL8TZwLQvAQc9j6gMlZ8
Message-ID: <CAEf4BzbT-7iRezzNRQPvQpRDA3BmkesCSijT4mPXuWb2ua=9ag@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: add a new runner for bpftool tests
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 11:57=E2=80=AFPM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> Hi Andrii,
>
> On Thu Jan 15, 2026 at 6:58 PM CET, Andrii Nakryiko wrote:
> > On Wed, Jan 14, 2026 at 12:59=E2=80=AFAM Alexis Lothor=C3=A9 (eBPF Foun=
dation)
> > <alexis.lothore@bootlin.com> wrote:
> >>
> >> Hello,
> >> this series is part of the larger effort aiming to convert all
> >> standalone tests to the CI runners so that they are properly executed =
on
> >> patches submission.
> >>
> >> Some of those tests are validating bpftool behavior(test_bpftool_map.s=
h,
> >> test_bpftool_metadata.sh, test_bpftool_synctypes.py, test_bpftool.py..=
.)
> >> and so they do not integrate well in test_progs. This series proposes =
to
> >
> > Can you elaborate why they do not integrate well? In my mind,
> > test_progs should be the only runner into which we invest effort
> > (parallel tests, all the different filtering, etc; why would we have
> > to reimplement subsets of this). The fact that we have test_maps and
> > test_verifier is historical and if we had enough time we'd merge all
> > of them into test_progs.
> >
> > What exactly in test_progs would prevent us from implementing bpftool
> > test runner?
>
> I don't think there is any strong technical blocker preventing from
> integrating those tests directly into test_progs. That's rather about
> the fact that test_progs tests depends (almost) exclusively on
> libbpf/skeletons. Those bpftool tests rather need to directly execute

There are actually plenty of test in test_progs that do networking
setups, calling system() to launch various binaries, etc. So it never
was purely for libbpf/skeletons/whatnot.

So yeah, I think bpftool testing should still be implemented as one
(or many) test_progs tests (and maybe subtests), utilizing
test_progs's generic multi-process testing setup, filtering,
reporting, etc infrastructure. No need to add extra runners.

> bpftool and parse its stdout output, so I thought that it made sense to
> have a dedicated runner for this. If I'm wrong and so if those tests
> should rather be moved in the test_progs runner (eg to avoid duplicating
> the runner features), I'm fine with it. Any additional opinion on this
> is welcome.
>
> Thanks,
>
> Alexis
> --
> Alexis Lothor=C3=A9, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

