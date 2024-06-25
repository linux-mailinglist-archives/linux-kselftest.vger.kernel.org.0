Return-Path: <linux-kselftest+bounces-12628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F9A916138
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 10:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFA81C22FB6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 08:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271561494C9;
	Tue, 25 Jun 2024 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxgOmLuj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F165A1494B4;
	Tue, 25 Jun 2024 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304184; cv=none; b=KPXeU/QwPEXPDk8czlDt7bwt7vt2CRckevqroCiZLd9oQquuRN0Op1nBixucwprJncOKYQsefjChpIGzJ/D/WqwQJm220zW7pbgUuOxztKph+5ieorxsFIAX1sOcXCOPu484mRuDiwMLIGKi0KbO1Osrj4HTJWrowGQMH/VEf84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304184; c=relaxed/simple;
	bh=mKmmNq3ZO/ijyhP26QuFk8tmiEVK1nmmiemJh7SmQec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVx2ZL67LrJloU7utkbkOxHc4WgJT9hzrAu2ifC8524jVxt2K2WvC1qkRnfnV/LwvCKAoeL2yJarj4Sqq7ncggoaE8p3e5EOHZSL4LJMPoA69wMRQZWQbuB4QcFAJLXBVe2QLDPrmCsCVC9gELxvWhptZ9awveOgpDVS+XWocak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxgOmLuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C7DC32786;
	Tue, 25 Jun 2024 08:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719304183;
	bh=mKmmNq3ZO/ijyhP26QuFk8tmiEVK1nmmiemJh7SmQec=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pxgOmLujg1MmHoMkhATXUQRXtTZS84miHJsvZl+OItaDxGAafU4qyVO/2XMjuFdX/
	 ZLvf583wZZQvnakoqq6feC6HZvV0PJzyGCYS5g2Ox8vfYHW9sGuT2RYvCOoC9XEewy
	 TsaVObjZ1phg3UiuLBQZfPew0H1iUA/M3gf5lnG3VtFr2bTjBnhnMrG3f6dSSIduAH
	 jZr7IwCdW3tVHhBQrCYZAHtcm675ih5vDXzTafoopl3gV5GGDr2DeFVpJx7W88Br7+
	 M1v+xHWrmgqcQCu3UO6HOa1mijW3QjFKDwGE7i6MqI4n2yBlZdq0qETIT07WR4e40H
	 RDg831mu7QgWg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a724b4f1218so287550366b.2;
        Tue, 25 Jun 2024 01:29:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6dRYe16N8shlcnscZfBJ0EKSUXausfGhwzsMly1oWHVNEFC2VJOdNTDcH79zVpEaOAkCx11aV9RfrkRo+vNkDCeUfpxXoNEaoTMyPlv7bnsbwuU/bu+D44JbDWgG5P/XoQGNEs9+QNMoORkg1MrQyu21RK3JiVBsWC03U
X-Gm-Message-State: AOJu0YxagXTvkFUmukU6vpqcYGws9ITGucygywmKVlO+bvdJf5GHE5yn
	ltC7gW4gBy9alYw2/ud1Z1BlctFY+JfSz585ohVp0qP95wAZOAvG76lKb6FcGPdpf/3ZjbPiRNV
	RhiHiSMe4uTDr0E9saTUXkijpNhs=
X-Google-Smtp-Source: AGHT+IE9aNDiEGwi8jpig5AP06aUULAS82uewuRyRYeIo+yG1ElOUkJaw7gKuAFyWwqavI0X9kdSXzMEgwvKrtTV2ws=
X-Received: by 2002:a17:906:a1b:b0:a6f:b58f:ae3c with SMTP id
 a640c23a62f3a-a7242c9c261mr394471966b.26.1719304182050; Tue, 25 Jun 2024
 01:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719302367.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1719302367.git.tanggeliang@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 25 Jun 2024 16:29:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6=xEKDFS4f5hiOqw-gx1nKiXkQq8Kmr8ZsgQe9A3gbtw@mail.gmail.com>
Message-ID: <CAAhV-H6=xEKDFS4f5hiOqw-gx1nKiXkQq8Kmr8ZsgQe9A3gbtw@mail.gmail.com>
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

On Tue, Jun 25, 2024 at 4:25=E2=80=AFPM Geliang Tang <geliang@kernel.org> w=
rote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> v2:
>  - add patch 2, a new fix for sk_msg_memcopy_from_iter.
>  - update patch 3, only test "sk->sk_prot->close" as Eric suggested.
>  - update patch 4, use "goto err" instead of "return" as Eduard
>    suggested.
>  - add "fixes" tag for patch 1-3.
>  - change subject prefixes as "bpf-next" to trigger BPF CI.
>  - cc Loongarch maintainers too.
>
> BPF selftests seem to have not been fully tested on Loongarch. When I
> ran these tests on Loongarch recently, some errors occur. This patch set
> contains some null-check related fixes for these errors.
Is the root cause that LoongArch lacks bpf trampoline?

Huacai

>
> Geliang Tang (4):
>   skmsg: null check for sg_page in sk_msg_recvmsg
>   skmsg: null check for sg_page in sk_msg_memcopy_from_iter
>   inet: null check for close in inet_release
>   selftests/bpf: Null checks for link in bpf_tcp_ca
>
>  net/core/skmsg.c                                 |  4 ++++
>  net/ipv4/af_inet.c                               |  3 ++-
>  .../selftests/bpf/prog_tests/bpf_tcp_ca.c        | 16 ++++++++++++----
>  3 files changed, 18 insertions(+), 5 deletions(-)
>
> --
> 2.43.0
>

