Return-Path: <linux-kselftest+bounces-12629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1490E91614D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 10:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02A128390E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 08:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553D8149C5B;
	Tue, 25 Jun 2024 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUUZp9kY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB82C1494D9
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304310; cv=none; b=q+h4s+rRIK9z5gJTLCqjnxRK8/uGitWrxiKme2Vyz4JK+Rl0jcv2rimbmk+2paKnKM8AlgSElu7XQ9zUaP0Bd+7L+QY1572vcjutk4RBZcGyBPkD4MSbJ+/oy+WPmmKoTH9x7UhWECSFDk99I5JoUZZ/MQtL+JpUIiYjzmWyM4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304310; c=relaxed/simple;
	bh=pI6yLhOyRtdy8oxe0FK9HXZLboabZH126vMqWOQ4Gvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzruvZC+VWHKnRecxhFzzQrztqs6wL4M2GIasWnS6PSSFGh9Dmg02xM/oDfbt9zUBpbd2FUpMfYDVGwfIFISQf3PyyAZZcF/PK9wMv+CoPUmjvtJND6OJEOFoU1hzwidl/pBXYWqyvylT5H4VL/8VwcOVcQetSm4R68Kk0D2Pdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sUUZp9kY; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d16251a07so7664a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719304307; x=1719909107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpHWKWgmumoPz4qi4qRw5mSmRbCSXF9APYjL8k1PWDU=;
        b=sUUZp9kYTNBd0N5a1iQU1Xa3IKxrfXWFJaNU1pWcN/ULfadpVbIvsu4tMLjBl9mOtJ
         oCBO+o4caPibVgKEvh8L4bVhoC9jil2hV7cWJ3/yWOObiHdgHq6Jq/M2/hxBwZxQZITE
         DzzlZvm3PO7mS1NLybrm52aejtSX+4PKLOPMofnH5zpqK1FLtPJcVd6gY7k1nBSSSRrb
         gmSkR+fFNLGVMlVPj1TvHjiCuMPzGizkBKuBowa5XaUlPG2oQucwdI+tHDhREtPrwA8t
         KAMfpt0yqCjDzqEsUlTsgc+3B/nz7W9sVkA+obInNo/MRw0u2zXcDhWxPb7RWFjo11ha
         AuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304307; x=1719909107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpHWKWgmumoPz4qi4qRw5mSmRbCSXF9APYjL8k1PWDU=;
        b=aatBv841W9jOaW2cVZzQuSjBTESkOjrBtG66fi8zjrv+GEEU/WIMDkLF4WBylfKcK6
         op1EwO7N/n5LMLzmfKRfKKok/8C0KsVJERWSPQsB4OwuzRUTE4QFqRxj4Y/iNpnzXEKK
         QEgJgqhUIXBEu8B/Fdi6x5x6AM8hG6A8pi2p5ZgT2qk8JScBFhtVRFzq0EEMfWaWlGxc
         MJTJcgmasNg3RjKY+pSBjBBvjpQjTHsgyluglv5bHNQdebpzWLM5gclCRkj4W4gUNBGx
         AkSyKfhvGvzPZrlUN8tvL4QIdzuOvw9wDg0K5ozur35dGQa2q5W48IARk0iYYvPK9DBe
         s5rw==
X-Forwarded-Encrypted: i=1; AJvYcCW0c3aVIaBPZ3lD/49HlLt+1xlIKF6iZbIdOn2b2iGcek/yO3JFux4+4QIkp4eoGofhz8ThrG9M65rlXDdunfN58N/UbBzh3F7GLzFba7/T
X-Gm-Message-State: AOJu0Yyi8jprQHqD4ieP+yRleQG+8ltiVZF1PZ++dB3La/WvIOKaAllz
	kS9v7ZLt9nkLd6ckfSxS0jCR6Oj7Nipj+bkueD2g5FuCsbxvIsZU5IFtX1OttqFDNvfWy+6iDci
	lyB9D1LBsj1lWvauwp6GEoGrH5VaZqDdWCj+I
X-Google-Smtp-Source: AGHT+IEegJAJuE8jEL5mXWwu48giZeFhMcPkTmCYjs9Rk7y/5KU3i6hknr5+Rr7xyK8x6Q+ZunjqBKyHbUV2GKAs428=
X-Received: by 2002:a05:6402:2682:b0:57c:d45d:7571 with SMTP id
 4fb4d7f45d1cf-57dcde35b18mr159009a12.6.1719304304642; Tue, 25 Jun 2024
 01:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719302367.git.tanggeliang@kylinos.cn> <ad1ecbd205b357f1f73500522a2d495cb6c0cbe1.1719302367.git.tanggeliang@kylinos.cn>
In-Reply-To: <ad1ecbd205b357f1f73500522a2d495cb6c0cbe1.1719302367.git.tanggeliang@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Jun 2024 10:31:33 +0200
Message-ID: <CANn89i+WKB9E5-r0RK0oWj9HdwB8w1EeZB7F1JhD1R5JtQGcyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] inet: null check for close in inet_release
To: Geliang Tang <geliang@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>, Miao Xu <miaxu@meta.com>, 
	Yuran Pereira <yuran.pereira@hotmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 10:25=E2=80=AFAM Geliang Tang <geliang@kernel.org> =
wrote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Run the following BPF selftests on Loongarch:
>
> ./test_progs -t sockmap_listen
>
> A Kernel panic occurs:
>
> '''
>  Oops[#1]:
>  CPU: 49 PID: 233429 Comm: new_name Tainted: G           OE      6.10.0-r=
c2+ #20
>  Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS Loongson-UDK201=
8-V4.0.11
>  pc 0000000000000000 ra 90000000051ea4a0 tp 900030008549c000 sp 900030008=
549fe00
>  a0 9000300152524a00 a1 0000000000000000 a2 900030008549fe38 a3 900030008=
549fe30
>  a4 900030008549fe30 a5 90003000c58c8d80 a6 0000000000000000 a7 000000000=
0000039
>  t0 0000000000000000 t1 90003000c58c8d80 t2 0000000000000001 t3 000000000=
0000000
>  t4 0000000000000001 t5 900000011a1bf580 t6 900000011a3aff60 t7 000000000=
000006b
>  t8 00000fffffffffff u0 0000000000000000 s9 00007fffbbe9e930 s0 900030015=
2524a00
>  s1 90003000c58c8d00 s2 9000000006c81568 s3 0000000000000000 s4 90003000c=
58c8d80
>  s5 00007ffff236a000 s6 00007ffffbc292b0 s7 00007ffffbc29998 s8 00007fffb=
be9f180
>     ra: 90000000051ea4a0 inet_release+0x60/0xc0
>    ERA: 0000000000000000 0x0
>   CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -WE)
>   PRMD: 0000000c (PPLV0 +PIE +PWE)
>   EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
>   ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
>  ESTAT: 00030000 [PIF] (IS=3D ECode=3D3 EsubCode=3D0)
>   BADV: 0000000000000000
>   PRID: 0014c011 (Loongson-64bit, Loongson-3C5000)
>  Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_=
nat_tftp
>  Process new_name (pid: 233429, threadinfo=3D00000000b9196405, task=3D000=
00000c01df45b)
>  Stack : 0000000000000000 90003000c58c8e20 90003000c58c8d00 9000000005059=
60c
>          0000000000000000 9000000101c6ad20 9000300086524540 00000000082e0=
003
>          900030008bf57400 90000000050596bc 900030008bf57400 900000000434a=
cac
>          0000000000000016 00007ffff224e060 00007fffbbe9f180 900030008bf57=
400
>          0000000000000000 9000000004341ce0 00007fffbbe9f180 00007ffff2369=
000
>          900030008549fec0 90000000054476ec 000000000000006b 9000000003f71=
da4
>          000000000000003a 00007ffff22b8a44 00007fffbbe9f8e0 00007fffbbe9e=
680
>          ffffffffffffffda 0000000000000000 0000000000000000 0000000000000=
000
>          00007fffbbe9f288 0000000000000000 0000000000000000 0000000000000=
039
>          84c2431493ceab6e 84c23ceb2827425e 0000000000000007 00007ffff2271=
600
>          ...
>  Call Trace:
>  [<900000000505960c>] __sock_release+0x4c/0xe0
>  [<90000000050596bc>] sock_close+0x1c/0x40
>  [<900000000434acac>] __fput+0xec/0x2e0
>  [<9000000004341ce0>] sys_close+0x40/0xa0
>  [<90000000054476ec>] do_syscall+0x8c/0xc0
>  [<9000000003f71da4>] handle_syscall+0xc4/0x160
>
>  Code: (Bad address in era)
>
>  ---[ end trace 0000000000000000 ]---
>  Kernel panic - not syncing: Fatal exception
>  Kernel relocated by 0x3d50000
>   .text @ 0x9000000003f50000
>   .data @ 0x90000000055b0000
>   .bss  @ 0x9000000006ca9400
>  ---[ end Kernel panic - not syncing: Fatal exception ]---
> '''
>
> This is because "sk->sk_prot->close" pointer is NULL in that case. This
> patch adds null check for it in inet_release() to fix this error.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/ipv4/af_inet.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index b24d74616637..34a719e98c69 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -434,7 +434,8 @@ int inet_release(struct socket *sock)
>                 if (sock_flag(sk, SOCK_LINGER) &&
>                     !(current->flags & PF_EXITING))
>                         timeout =3D sk->sk_lingertime;
> -               sk->sk_prot->close(sk, timeout);
> +               if (sk->sk_prot->close)
> +                       sk->sk_prot->close(sk, timeout);

Can you tell us which inet protocol does not have a ->close pointer ?

I find it hard to believe a day-0 bug only hit Loongarch arch in 2024.

