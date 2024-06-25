Return-Path: <linux-kselftest+bounces-12632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E00F91621E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 11:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023C21F21375
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B541494C9;
	Tue, 25 Jun 2024 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFogaGaW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4795F1487EF;
	Tue, 25 Jun 2024 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306895; cv=none; b=B9DSyfDrQtccH2J5YBl9SmJxAW/rcH53zyJ45CO4tcQH+lZPy/7Kf5SEEenkjZ4NyntGkgKMS3r7YX/ZP0Dfqmg4WmCrvguR4rEyJr6VIPCYUEOmJYyP7LZAr4L9gH08/nUukCxhTpO8Jl8qEP4ooI6iHVWsPkTsQG+wLgZBMDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306895; c=relaxed/simple;
	bh=K+nlXl7dTQZO6kYcB7cvvUNPw1K7ggy0UaaAYt1aAVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mddn/0UUzQfLgTQqOS48khE2k2x7ehr7Xt9HnLE7ZCZ6WHIDycxSp3l75LamfN4B3eL+lhgJK+L0Bg483j2B34OgDzwXxwZxjwwd7JJvlbN9yFliYV8qkfJ8a5UgyU+h9Tg3IP9R/reAG+dxVhWPdC+1Vu9NrhNI4ZZa9pvrvkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFogaGaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9CCC4AF0A;
	Tue, 25 Jun 2024 09:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719306894;
	bh=K+nlXl7dTQZO6kYcB7cvvUNPw1K7ggy0UaaAYt1aAVk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vFogaGaWm2Mcuxf9jkaEPhc8mt3wnZNPTykrQk9aJRmLgW5BXEU9TJlCdOeNq/V8T
	 H0fxseI8H40zrU9So/3SZoyGuAcC0OfqsaQJv2u18SjuN5UEPrwTw9ZOuV867uMgz2
	 NEo+fJzUn/16e3ZOR1I3LMY2ob6iT8knUF2oukml+PS2/d3xlCLmej5KuabWCVmZUg
	 3lnRU/qmx18/x7bIVlbK/fvWgG4EWpVJz6WF2Gv9Vax51C0uJyDaGx5kiVgXmTMmt8
	 Mr7GNfG9NvqfRCi4YMeCfbD0Sy1lfnjecJOpj6W++8HWQiLIjfwGex6v+8UzzG74EG
	 S5LH2v5z7HjHw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so671937766b.2;
        Tue, 25 Jun 2024 02:14:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlA1rxXFo0kEnMlNLUK8MP3WnHPiA80rpGN8X7i81GIQLA5whQhjRqQTdIcCdX+iB1N1kFrQ8e0XuTEXQl7E5G7F9B8iiDXvRLce2m2NZ87njPpvGraBwq2eTnVzJmGDmx+wvQXF3jnDk2CStQf/3tPXUB52zNwU7s9wRS
X-Gm-Message-State: AOJu0YwFN2q+N931b9E2lMfwk+QWiTf1GcOqkJOVgpj2Z6vOrBePMdG5
	Lq9exZlsa2GHiFQM21ylBYSOnpHvnMUhMG5nULtVcUICPhai2R3VRpBHSJGFQeDhL0bTlXymZDJ
	0zZAxUKAaUmybEPtbxVb9vwPC73A=
X-Google-Smtp-Source: AGHT+IHNqCtF5BzUsAKtHwK5+zo/ZybbxNHxbJjrvFe5SxKrdBham53XzGi/IpCBAJ2Qzpk6BV66r1+KQSKS+EtqlrU=
X-Received: by 2002:a17:907:8e93:b0:a6e:f62d:bd02 with SMTP id
 a640c23a62f3a-a7245c84f2emr444738166b.7.1719306893342; Tue, 25 Jun 2024
 02:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719302367.git.tanggeliang@kylinos.cn> <CAAhV-H6=xEKDFS4f5hiOqw-gx1nKiXkQq8Kmr8ZsgQe9A3gbtw@mail.gmail.com>
 <2319d0d58ccd879ebbc47f368475240bf06870ff.camel@kernel.org>
In-Reply-To: <2319d0d58ccd879ebbc47f368475240bf06870ff.camel@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 25 Jun 2024 17:14:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Ceo9EYAXw=acPX-cfqTQnRb1ht46WWWeSwEsz7M5x9Q@mail.gmail.com>
Message-ID: <CAAhV-H4Ceo9EYAXw=acPX-cfqTQnRb1ht46WWWeSwEsz7M5x9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] Fixes for BPF selftests on Loongarch
To: Geliang Tang <geliang@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>, Miao Xu <miaxu@meta.com>, 
	Yuran Pereira <yuran.pereira@hotmail.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 5:08=E2=80=AFPM Geliang Tang <geliang@kernel.org> w=
rote:
>
> On Tue, 2024-06-25 at 16:29 +0800, Huacai Chen wrote:
> > On Tue, Jun 25, 2024 at 4:25=E2=80=AFPM Geliang Tang <geliang@kernel.or=
g>
> > wrote:
> > >
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > >
> > > v2:
> > >  - add patch 2, a new fix for sk_msg_memcopy_from_iter.
> > >  - update patch 3, only test "sk->sk_prot->close" as Eric
> > > suggested.
> > >  - update patch 4, use "goto err" instead of "return" as Eduard
> > >    suggested.
> > >  - add "fixes" tag for patch 1-3.
> > >  - change subject prefixes as "bpf-next" to trigger BPF CI.
> > >  - cc Loongarch maintainers too.
> > >
> > > BPF selftests seem to have not been fully tested on Loongarch. When
> > > I
> > > ran these tests on Loongarch recently, some errors occur. This
> > > patch set
> > > contains some null-check related fixes for these errors.
> > Is the root cause that LoongArch lacks bpf trampoline?
>
> No. These errors don't seem to be directly related to the lack of BPF
> trampoline. I have indeed got some errors since lacking BPF trampoline,
> which is probably like this:
If so, these errors seem not specific to LoongArch.

Huacai

>
>  test_dctcp:PASS:bpf_dctcp__open_and_load 0 nsec
>  test_dctcp:FAIL:bpf_map__attach_struct_ops unexpected error: -524
>  #29/1    bpf_tcp_ca/dctcp:FAIL
>  test_cubic:PASS:bpf_cubic__open_and_load 0 nsec
>  test_cubic:FAIL:bpf_map__attach_struct_ops unexpected error: -524
>  #29/2    bpf_tcp_ca/cubic:FAIL
>  test_dctcp_fallback:PASS:dctcp_skel 0 nsec
>  test_dctcp_fallback:PASS:bpf_dctcp__load 0 nsec
>  test_dctcp_fallback:FAIL:dctcp link unexpected error: -524
>  #29/4    bpf_tcp_ca/dctcp_fallback:FAIL
>  test_write_sk_pacing:PASS:open_and_load 0 nsec
>  test_write_sk_pacing:FAIL:attach_struct_ops unexpected error: -524
>  #29/6    bpf_tcp_ca/write_sk_pacing:FAIL
>
> Thanks,
> -Geliang
>
> >
> > Huacai
> >
> > >
> > > Geliang Tang (4):
> > >   skmsg: null check for sg_page in sk_msg_recvmsg
> > >   skmsg: null check for sg_page in sk_msg_memcopy_from_iter
> > >   inet: null check for close in inet_release
> > >   selftests/bpf: Null checks for link in bpf_tcp_ca
> > >
> > >  net/core/skmsg.c                                 |  4 ++++
> > >  net/ipv4/af_inet.c                               |  3 ++-
> > >  .../selftests/bpf/prog_tests/bpf_tcp_ca.c        | 16
> > > ++++++++++++----
> > >  3 files changed, 18 insertions(+), 5 deletions(-)
> > >
> > > --
> > > 2.43.0
> > >
>

