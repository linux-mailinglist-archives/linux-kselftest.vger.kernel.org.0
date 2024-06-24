Return-Path: <linux-kselftest+bounces-12560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2876914F3C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 15:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59851C21408
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 13:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E0A14199C;
	Mon, 24 Jun 2024 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s7Xg/xEK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70A91411FD
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237285; cv=none; b=owGXEzZjL23Eg+LLD5cFxBkx0CWlSALsjzuLY9tQXSzKDom9rT5Ni+X4+ocjhNPee6kAiFMno6ZArurZKA3dfhkEOxlqbNiPzKNIMJuDWHQYJGul904oFLA+QmfO53KoyxXbH1jqvu1klxTcsnP2xCvCnjtopVJTj0Ht5fWSO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237285; c=relaxed/simple;
	bh=VKXnSDdfvX3k5yhwZ2xBJjyN8qp+i8IZVG9d+dl/O2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nP9s4Aaizlg3VdZJGALyYeqs6zp1TnQZJa8YiOgjx4T9bSmlyn7i+L2etxFIT0PhqHZG2p55n77ipp/Yy0UntxgrBdb+8vttG3d/n+JnQ9gI1m4ahDz2HObyIUONlHQJv2I7tRL/jqSklSyBWpQUQXSL4cWuusGU0RNkpQHZxDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s7Xg/xEK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d16251a07so40331a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 06:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719237282; x=1719842082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sdgf5PNs5g/gEMlXztaP+xUAM2ccHxdMbGVMq60x7E=;
        b=s7Xg/xEKc2DpyQgbc1X5GevbXDL29j3eb1JasAoBD+mf1+8wM9FJMgBeMs2g1qNsvV
         U1zKOudlyoP72LrzW+coMO5mDMafG/m6IS4xjADm5TQx3fmPncdnc1njz7QdBX/MVjyL
         fhSDHfkvdGiOj8ayuP1P3Nm9C9H0EvxfBV018+O/mPE4d1ryxtnBKSn1SuqF/94VOqOY
         oDc21M3fkKQmq0EtUOiziICFnjAHCWMGDrV9qmDsmy2Dq0pq8LXKnXSCQkp4rskQwXK2
         /Pin3WfkQKexOJhNXVJ8M3FPNtkxTUh3kBCwRFy4eFamQvBHceCTqi0N8BjhYWakYrD0
         WFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719237282; x=1719842082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sdgf5PNs5g/gEMlXztaP+xUAM2ccHxdMbGVMq60x7E=;
        b=kzcgWe7Hh6D5XAOTaS+we40/6C6snXUWN9pc+QmcZGgbjBFoeZ96s7KRaF+bDV2Rbp
         gurPdnPlW18gmYvs9w3w5mcD3sHBI6DwYwgubV3wPJB7gGh2cawLytHFdH+Rxu2V6fKh
         8679NznVZ/2P6tKa0bbQtz6v49t0tj3N5wrh9cmwcOazGmACPS8WsRHBGUEkaTHmZVFZ
         Gzs0N0+tEKWe3AnzpCuRsG22+mKKThlirbs41w3E0XUBAydr6SW9PJ0YPPo5qoYSHfs6
         hYbMnL0IdeP1x01H3mPYH925Rs57yBr0LHboY8dSb7pJDPraiUzmqKTNFVE+P+4s5lLw
         Htfw==
X-Forwarded-Encrypted: i=1; AJvYcCWPZ14akD7eoTRBW6ZdH6zlaCG2FHgwGx/+CZB+iI/HWuxlnjCeJjB9OqjlTx2BV4ljJ8zqAvcz66aNMRnZY3w5Rb7JBxBEcEw0VKUFy2qL
X-Gm-Message-State: AOJu0YwN9jvFefrzi2KsYGwKeAhG9bSPXFh1HCCnHVf8wr2OnojDheAc
	Wcd63jkqu4X39qEG+hvB3mPaDh3y5whlAZBEFbwPhzbp5UZ8hbBPPYLg3Mbm0EcimNK0Av6GdM4
	9EmwFK6J8+zCSxEagjff5ravacKltLaYOFwxY
X-Google-Smtp-Source: AGHT+IGwK65MNDlHHqOoICs5Q2AZ0NNrv74rO8TUJcxtn7Er5aJcpRvxJODc9r1ZJl8q/G9KIMwR2Dpnl5qjkeCzLEM=
X-Received: by 2002:a05:6402:50cb:b0:57c:d45d:7571 with SMTP id
 4fb4d7f45d1cf-57d41ce9bd4mr371523a12.6.1719237281770; Mon, 24 Jun 2024
 06:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719234744.git.tanggeliang@kylinos.cn> <3853b0e4846656a31799dbd4ffb7f57c302980de.1719234744.git.tanggeliang@kylinos.cn>
In-Reply-To: <3853b0e4846656a31799dbd4ffb7f57c302980de.1719234744.git.tanggeliang@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Jun 2024 15:54:30 +0200
Message-ID: <CANn89iLhF6XX-j6S1F3VhWFcHwzh=opNuZembdi96zbxocot+Q@mail.gmail.com>
Subject: Re: [PATCH net 1/3] skmsg: null check for page in sk_msg_recvmsg
To: Geliang Tang <geliang@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>, Miao Xu <miaxu@meta.com>, 
	Yuran Pereira <yuran.pereira@hotmail.com>, Geliang Tang <tanggeliang@kylinos.cn>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 3:28=E2=80=AFPM Geliang Tang <geliang@kernel.org> w=
rote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Run the following BPF selftests on loongarch:
>
> # ./test_progs -t sockmap_basic
>
> A Kernel panic occurs:
>
> '''
>  Oops[#1]:
>  CPU: 22 PID: 2824 Comm: test_progs Tainted: G           OE      6.10.0-r=
c2+ #18
>  Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS Loongson-UDK201=
8-V4.0.11
>  pc 9000000004162774 ra 90000000048bf6c0 tp 90001000aa16c000 sp 90001000a=
a16fb90
>  a0 0000000000000000 a1 0000000000000000 a2 0000000000000000 a3 90001000a=
a16fd70
>  a4 0000000000000800 a5 0000000000000000 a6 000055557b63aae8 a7 000000000=
00000cf
>  t0 0000000000000000 t1 0000000000004000 t2 0000000000000048 t3 000000000=
0000000
>  t4 0000000000000001 t5 0000000000000002 t6 0000000000000001 t7 000000000=
0000002
>  t8 0000000000000018 u0 9000000004856150 s9 0000000000000000 s0 000000000=
0000000
>  s1 0000000000000000 s2 90001000aa16fd70 s3 0000000000000000 s4 000000000=
0000000
>  s5 0000000000004000 s6 900010009284dc00 s7 0000000000000001 s8 900010009=
284dc00
>     ra: 90000000048bf6c0 sk_msg_recvmsg+0x120/0x560
>    ERA: 9000000004162774 copy_page_to_iter+0x74/0x1c0
>   CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -WE)
>   PRMD: 0000000c (PPLV0 +PIE +PWE)
>   EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
>   ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
>  ESTAT: 00010000 [PIL] (IS=3D ECode=3D1 EsubCode=3D0)
>   BADV: 0000000000000040
>   PRID: 0014c011 (Loongson-64bit, Loongson-3C5000)
>  Modules linked in: bpf_testmod(OE) xt_CHECKSUM xt_MASQUERADE xt_conntrac=
k
>  Process test_progs (pid: 2824, threadinfo=3D0000000000863a31, task=3D000=
000001cba0874)
>  Stack : 0000000000000001 fffffffffffffffc 0000000000000000 0000000000000=
000
>          0000000000000018 0000000000000000 0000000000000000 90000000048bf=
6c0
>          90000000052cd638 90001000aa16fd70 900010008bf51580 900010009284f=
000
>          90000000049f2b90 900010009284f188 900010009284f178 90001000861d4=
780
>          9000100084dccd00 0000000000000800 0000000000000007 fffffffffffff=
ff2
>          000000000453e92f 90000000049aae34 90001000aa16fd60 900010009284f=
000
>          0000000000000000 0000000000000000 900010008bf51580 90000000049f2=
b90
>          0000000000000001 0000000000000000 9000100084dc3a10 900010009284f=
1ac
>          90001000aa16fd40 0000555559953278 0000000000000001 0000000000000=
000
>          90001000aa16fdc8 9000000005a5a000 90001000861d4780 0000000000000=
800
>          ...
>  Call Trace:
>  [<9000000004162774>] copy_page_to_iter+0x74/0x1c0
>  [<90000000048bf6c0>] sk_msg_recvmsg+0x120/0x560
>  [<90000000049f2b90>] tcp_bpf_recvmsg_parser+0x170/0x4e0
>  [<90000000049aae34>] inet_recvmsg+0x54/0x100
>  [<900000000481ad5c>] sock_recvmsg+0x7c/0xe0
>  [<900000000481e1a8>] __sys_recvfrom+0x108/0x1c0
>  [<900000000481e27c>] sys_recvfrom+0x1c/0x40
>  [<9000000004c076ec>] do_syscall+0x8c/0xc0
>  [<9000000003731da4>] handle_syscall+0xc4/0x160
>
>  Code: 0010b09b  440125a0  0011df8d <28c10364> 0012b70c  00133305  0013b1=
ac  0010dc84  00151585
>
>  ---[ end trace 0000000000000000 ]---
>  Kernel panic - not syncing: Fatal exception
>  Kernel relocated by 0x3510000
>   .text @ 0x9000000003710000
>   .data @ 0x9000000004d70000
>   .bss  @ 0x9000000006469400
>  ---[ end Kernel panic - not syncing: Fatal exception ]---
> '''
>
> This is because "page" is NULL in that case. This patch adds null
> check for it in sk_msg_recvmsg() to fix this error.
>

Why would @page be NULL only for this architecture ?

Please elaborate, and add a Fixes: tag

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/core/skmsg.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index fd20aae30be2..bafcc1e2eadf 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -432,6 +432,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *=
psock, struct msghdr *msg,
>                         sge =3D sk_msg_elem(msg_rx, i);
>                         copy =3D sge->length;
>                         page =3D sg_page(sge);
> +                       if (!page)
> +                               goto out;
>                         if (copied + copy > len)
>                                 copy =3D len - copied;
>                         copy =3D copy_page_to_iter(page, sge->offset, cop=
y, iter);
> --
> 2.43.0
>

