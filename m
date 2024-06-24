Return-Path: <linux-kselftest+bounces-12558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 993C6914EEF
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 15:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E99D4B20C0D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 13:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB3A13D8B2;
	Mon, 24 Jun 2024 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dLxlKxsR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E502913A86A
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236551; cv=none; b=bF884rW5j8IvBE8z5hM1veGLY/THGQg1FccgGgWmsFNQj4jFLZLFPVtzD7q99zUp8QPqjffFBRZ374dbeXWJa0DcC3WSP7R8KO2KQTX8LABVRYSX4i4/XOCOuImCjuT4dtYBtZ+7ACPOMp4rJ4WtZcbPf5c5kXSrtPf5yxfB5VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236551; c=relaxed/simple;
	bh=r6zTi3ntQnckhbaoCILig8THR0eF7H4OsBZ/tFJV2LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYtg8/jrw0TAm3DHvx83EqxOeRuOVN1nFBWxgJb1DLbFyl+WwpWhXrQPIsiuzMcjdBrLFEPK/qACxCBsyIJs0zygynyDpIhICuXvl1txMWnYuAxV7nDij4dX+YAw0+tIteSCRZ3CdzodPmtM1T6BYCYUmduZiDKGGJJvlWuOvuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dLxlKxsR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d119fddd9so23175a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 06:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719236548; x=1719841348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSokJ3EUSU5UEr3KWUTcjNsYeeU4+Z4afSCdW2hJwP4=;
        b=dLxlKxsRRhLllSJeV6ERuqr6hJ4cuJQUIORfZVJMg3cgGoR9jXjehVReForcRhPMhi
         C+HgZZ/VSF43axQpUmxjHkc2sucY8TxFQl0gpk92CKYBSR8WOqcPPbCjx9YaghV+jzAB
         oO3+Dea4HTH8yR7j0dylm90OVkjLNxuOFQYLWJc+LoWHjS6mQUlU40eLsswCYlakjRTi
         ua7DUfBkdLk4WK2jtGcqWWsCR8sxATg0w0CrY2vWngZBYxqfU6O0czJMH2kwnUWkBKEx
         0rMlBWlzRk4BL13nDlAfqKpaqNooYigoxhabM2pNAHXX+G5UVb9752AvE3vtnNVg2uWi
         nSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719236548; x=1719841348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSokJ3EUSU5UEr3KWUTcjNsYeeU4+Z4afSCdW2hJwP4=;
        b=aty1VZ1YxxQ/AadEI1mloKe15q4LV7aC7m4GKr65y3Cjo7L7gTZkZ2E4pTAnTJzTQo
         wvOk26dcNeX08br11jNG79sksY15cPCgzNxYLRaAvhYsufPppQ19MZOV4uKWdeH5qA3E
         f2tp5da16dSH6Eov/P9hXo2yZe6Rfx1wco7URzmm9CLdEop0qOuRarKISPeAzW+zJb9H
         3SwEAUOxET8Rau47+leLy4kN129EVUeXDkxqGIYQYN+RdRaO6YwBSlB8xhPHjcAt1OTi
         CORuwCP27zHKCuBD3fjs/PH+gfe++5zuTXze6RMgYIGRaNfX8hjhtCqBJEgQTmJq2Xwk
         ZYag==
X-Forwarded-Encrypted: i=1; AJvYcCXeqPaYSWNXm0r0vTdmrxU9wg4BLdNA/s1gm2FG0yKKNM1y2SDw2h9gjd3/rgPYaEZb7dnjAqftAzNU/D/fV4vVm1GLR1Y8qUJ+qeQfbFcG
X-Gm-Message-State: AOJu0YxH80DRCu9m2xvWoUW2wmyKNyqoKSlwGqup2Mea3rOplEyt4ZvC
	sf5tTVw+8DcEBmsnt6rLgUMccaosKFSA0UlKDewq4DhALwhSxm2YIc31SnDE0Sdg8lrXE+waOjG
	h3U6PZ5SDqyGeR401vG1jbHro3orUHnkmBckw
X-Google-Smtp-Source: AGHT+IExMCduWBbykElPzIUGTue1yZGzK/o9rKdjuJtfSk9r8JrxqxGwDpUAl9nBslWuYssYO2GIZrZdfiaPnqfaNtg=
X-Received: by 2002:a05:6402:524f:b0:57c:d1dd:e645 with SMTP id
 4fb4d7f45d1cf-57d41af61aemr299210a12.5.1719236547427; Mon, 24 Jun 2024
 06:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719234744.git.tanggeliang@kylinos.cn> <7b0b49dff962845b26918fce56cbe4444175db4f.1719234744.git.tanggeliang@kylinos.cn>
In-Reply-To: <7b0b49dff962845b26918fce56cbe4444175db4f.1719234744.git.tanggeliang@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Jun 2024 15:42:12 +0200
Message-ID: <CANn89iKvKAq=tN029infHi2MtQ7GzdedHKB0arfYe3cBawqZLg@mail.gmail.com>
Subject: Re: [PATCH net 2/3] inet: null check for close in inet_release
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
> # ./test_progs -t sockmap_listen
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
> This is because "close" is NULL in that case. This patch adds null
> check for it in inet_release() to fix this error.
>

Please add a Fixes: tag, so that we can fully understand what is going on.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/ipv4/af_inet.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index b24d74616637..8e926018d011 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -434,7 +434,8 @@ int inet_release(struct socket *sock)
>                 if (sock_flag(sk, SOCK_LINGER) &&
>                     !(current->flags & PF_EXITING))
>                         timeout =3D sk->sk_lingertime;
> -               sk->sk_prot->close(sk, timeout);
> +               if (sk->sk_prot && sk->sk_prot->close)

Which one is NULL exactly ?  sk->sk_prot or the ->close pointer ?

Why add all these checks if only one is requested ?

> +                       sk->sk_prot->close(sk, timeout);
>                 sock->sk =3D NULL;
>         }
>         return 0;
> --
> 2.43.0
>

