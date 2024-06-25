Return-Path: <linux-kselftest+bounces-12630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF5F916166
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 10:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD84F1F24708
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 08:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD20149011;
	Tue, 25 Jun 2024 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c0D8PQP7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E70014A4C5
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304438; cv=none; b=goNtLmN2xMTAcb0cCTBFhz6jFZycwmwAlPX9g5GliZvrajXVtng7IEXwIgZSX3QYl8f5Fp3ofjk56RBadDWZUhmVEf1SaRJFiUPiID5Rs9UcJuJ1omXkYv9I+OKT+76TBxPaq1fPDMGDfwpSnqrXchqfFVJemPKsYYkuwEHQAws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304438; c=relaxed/simple;
	bh=3wSIv4dG+zqD1/sWH1bOTpHCf/y+0gM7r2AidH9sipM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmCx80M6CY/2b/of81iFh7YY9b8NzOYnQmG+endtIb0mDtuTYRu80D4yXxCIkg0ITigZ8RwaUWfNJHoUvxqlqaO3lYHmHTSlUTfqZgQZUy9ykGVWDYKrokIxFi1kVevHMG/ezomvVqLRDCBQEn63CuGrNxt1m0iwkpg0554cOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c0D8PQP7; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d16251a07so7704a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 01:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719304435; x=1719909235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeUYiJnNAb5D0IWuiFx68WloAZOBvRMUqn5S2VhB/V8=;
        b=c0D8PQP7h9bEYpEFjZ4XWKNpxspOyZqGP/5nOUmA9OUv7gIK47wHQB5YQdxwINE/g+
         P9h0ghqnwO1/hmMGEguTjGEM5XZaP12gQjGe4O1zgO/IAp3WtI6jBm6sUE9nYPQ8Kl24
         rn3BD2bNIbPikaSXf6t/bXnQTq5Yw3MttmfB4ZmzIBxeXJSEcee9wHeti7qbanZ87mG1
         QFZvHVZbK/pZqqN+8hno+NfqaclvxaFjEkBk5IhxrzRR9EOfyJ+vdO63MRmMDKMLvEK8
         EdMHXC3nC1kNb4J5reI+LXablWljxe63YhB9sIo+mfzMbZebVj/zJezRvyOIBgfOH76t
         ZbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304435; x=1719909235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeUYiJnNAb5D0IWuiFx68WloAZOBvRMUqn5S2VhB/V8=;
        b=T/OcLttmwfTq14gFDMx2Dfl55flkEuiwuA50jv4/Qc1ELKeXVZw/2CkCYb9ZZWSUMr
         D1yeS4bCjtxytY0gRb2n2rAoB1zatiSUw2ZMU6k7hGHLCSSxtwX8Z7tddtnjhkcNPE7i
         v3/yriZxjjlyA16FhGB/uBWf3a4XYJH3ptXvVBnaPHMrrd4T282LZR9jog5WDU/FCLsV
         r1NkwCFhnHeM9TauczbPJx/5Y4lcRe2osV8/3y/DzaRXokYEpgerfTLgO5n4FD3tuHDk
         uCPI8jac0fKWfOvGxVCtFmhmLO7vQjDsCSOSnUblSyb+IxvGszVN4QFjR/U3P022mMKZ
         5TPw==
X-Forwarded-Encrypted: i=1; AJvYcCWijJ+Jm/dp48soujyHt0YC4uVqdGGLbDHT5NHJCzWHfZS5sWTIyO+fmG4J+IM7Ixhr4dRH6hvgqv0MY4dbTWejeHTMx5d700jj6hfIlAb+
X-Gm-Message-State: AOJu0Yxa9O/0jJQcVVxzZDkWdbyfBVZMSztv7ksv9Or0UW8lUYabTdIw
	G5YQ1G71opFwwyvXJf7ifBzyNvyoBVVRTd1kx/X/R2UWMSDFQZmuc0hRyDPiGHiiTeEx6/bvtit
	3E0fALxwvYqQpioHx0hxqLOxeVSQnN0o+I8yZ
X-Google-Smtp-Source: AGHT+IHbazm8B2Z5muQ/cD5z0DMPkbB5xirFSbtDRpOriuTTZtfF0pXe1CteCRp7NvtfoyI08ExXFytZrzrl2bf9o0Y=
X-Received: by 2002:a05:6402:2682:b0:57c:d45d:7571 with SMTP id
 4fb4d7f45d1cf-57dcde35b18mr159588a12.6.1719304433406; Tue, 25 Jun 2024
 01:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719302367.git.tanggeliang@kylinos.cn> <072709ce77b04dc77523d4e8763c1fb47bf0913d.1719302367.git.tanggeliang@kylinos.cn>
In-Reply-To: <072709ce77b04dc77523d4e8763c1fb47bf0913d.1719302367.git.tanggeliang@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Jun 2024 10:33:42 +0200
Message-ID: <CANn89i+ET4U+4viDPq2vZhxeUT90kZz5mdh3XVqQhaAXnbs=rw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] skmsg: null check for sg_page in sk_msg_recvmsg
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
> ./test_progs -t sockmap_basic
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
> This is because "sg_page(sge)" is NULL in that case. This patch adds null
> check for it in sk_msg_recvmsg() to fix this error.
>
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
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

This looks pretty much random to me.

Please find the root cause, instead of desperately trying to fix 'tests'.

