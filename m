Return-Path: <linux-kselftest+bounces-12728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F4491712A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 21:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185C11C227C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 19:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E8317C9F1;
	Tue, 25 Jun 2024 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiUUEpbu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8373417C7CA;
	Tue, 25 Jun 2024 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719344263; cv=none; b=ockiCg2Kq/xKgnH92l6eSg00YaR2zttvNBwt7vdcWa46xSUtOPDFpHV21zSa/XEzYX5uAYwM0ofJawBliOO0+1BFar1GZbQYJYjLjeKva0H8IkkBmNPCj7FtDGuDCVyf7Oa+aULvd41c6OJQCpFm012X+fyJUtCawG61f/4fP48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719344263; c=relaxed/simple;
	bh=Qd0vNLXHaY8M9RUSjAE8SM2AvwHfmAMJLOPNB2nH9y4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=btpQ/uIdnfjQ4Y6ldr9BOjCuuvBAz2dPxFjWenjPQGM8cyoTd2/4tI9hg7qlEWCBs8IqL9bhz1WUmXYtfGSJQ/YmE4V39NHyzSdJ6D6ueXfFvh7jHm3NQ7/UyiITioB2k8ZDCEqT2pxQ3F1UOXtDcVogty5UNjdtr+Sq7M+gnic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiUUEpbu; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-706683e5249so2746820b3a.2;
        Tue, 25 Jun 2024 12:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719344261; x=1719949061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCnr3FewRta5Yf5iM2Qg025VUaSqFbbQ41pNNx8ZWwI=;
        b=HiUUEpbuZUeDMqdCn0pNK25ONvkbgwa6pMEEcML68nE8XOI0SrzZ+CA2vJIIz99J7e
         8S0vHiO6YfQCz72I1lcd0qy0E+HITl2ObXfue0yOc9VSs9PHn5mEZEQAc+19PvbexyqX
         9L7wJIVXssIHDhW9jo6NBM8F+2th4BDdmMmPHq++PQPp7hdtXviK7QEV6oNyUs3uERLz
         dBfhztiiyiuwtm9r0Cygx7HCm/NzjXihNWW6cywYQ0WjWZRZeq336shTh44EYfGJMUeu
         iOZmXnOjoCMlm++d4A301rw9LOrQWQlr2Bh0eyl02Z3Lj4YOXw6Boy+sn37ZE0Wjmuco
         +yHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719344261; x=1719949061;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OCnr3FewRta5Yf5iM2Qg025VUaSqFbbQ41pNNx8ZWwI=;
        b=mcf+SpmY8vsWf9dI+z3UfWv+zWOCAbe1+cK9fD4c9wUsVVlpy1Ir7biT0nxKZ8ziaq
         q/gBI9U20Km1kj2CiSmQs4bc9fc+gS7jvg6xaUSZIqSWQEXM0noQJ+xAac6/3RB6n/io
         UG3ImgT5eaH6s/vIdWXsEsVJhIgEMQaNaUnz5XFnRWrq/sykEHKQHq8u/1LTpI0CkJFd
         ILhELKNdITYqKvbHJKuy+wHaZ3zXzKTwDwT3aHO9JA6AiIHl87ND7esrlPtKx11UouWd
         97EUzOZwrWT+14GTujsetGkTdpbgoi39TwnAIAr7jI14YM5cU6LeuEvFcPRnaeS2hmwh
         /m5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPAW+GXlf1lK9S4tR4s92b3KcNLRCnJp/vcJ357MXqllAvbMlq2Y/vvKMrKtkhwttUyc2ZmIogVTI51onABayb49iy7bwAbkcPDss6wU3XlXg8MV6vDjEF7jb3Tv8F61HEYdG0tIMjYZjxxRJDNoaBa08SzoczVGtnVd/7
X-Gm-Message-State: AOJu0YzqOBEHJ2UB32GjRIsQGxyYahDsHIrJp599ronKC6+qv0Gq1/SS
	A5VA9fnBnVOclUOhtOLHt9E7JMyNYaOGt8Xfu3CJ3cM+b9Sdg0JN
X-Google-Smtp-Source: AGHT+IG2zR1Tmm0AmkmJX2i38kKfmcO0ouIa2qMOuIAOByTtcpca9rRt/jIwPcBwjk7EBhkKXSdJQw==
X-Received: by 2002:a05:6a21:99a2:b0:1b5:d10b:d1ac with SMTP id adf61e73a8af0-1bcf7eae249mr9409054637.19.1719344260723;
        Tue, 25 Jun 2024 12:37:40 -0700 (PDT)
Received: from localhost ([98.97.39.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e53e0b9asm11233978a91.23.2024.06.25.12.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 12:37:39 -0700 (PDT)
Date: Tue, 25 Jun 2024 12:37:39 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Geliang Tang <geliang@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Mykyta Yatsenko <yatsenko@meta.com>, 
 Miao Xu <miaxu@meta.com>, 
 Yuran Pereira <yuran.pereira@hotmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, 
 Geliang Tang <tanggeliang@kylinos.cn>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <667b1c8325bf1_54242089e@john.notmuch>
In-Reply-To: <CANn89i+ET4U+4viDPq2vZhxeUT90kZz5mdh3XVqQhaAXnbs=rw@mail.gmail.com>
References: <cover.1719302367.git.tanggeliang@kylinos.cn>
 <072709ce77b04dc77523d4e8763c1fb47bf0913d.1719302367.git.tanggeliang@kylinos.cn>
 <CANn89i+ET4U+4viDPq2vZhxeUT90kZz5mdh3XVqQhaAXnbs=rw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] skmsg: null check for sg_page in
 sk_msg_recvmsg
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Tue, Jun 25, 2024 at 10:25=E2=80=AFAM Geliang Tang <geliang@kernel.o=
rg> wrote:
> >
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >
> > Run the following BPF selftests on Loongarch:
> >
> > ./test_progs -t sockmap_basic
> >
> > A Kernel panic occurs:
> >
> > '''
> >  Oops[#1]:
> >  CPU: 22 PID: 2824 Comm: test_progs Tainted: G           OE      6.10=
.0-rc2+ #18
> >  Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS Loongson-UD=
K2018-V4.0.11
> >  pc 9000000004162774 ra 90000000048bf6c0 tp 90001000aa16c000 sp 90001=
000aa16fb90
> >  a0 0000000000000000 a1 0000000000000000 a2 0000000000000000 a3 90001=
000aa16fd70
> >  a4 0000000000000800 a5 0000000000000000 a6 000055557b63aae8 a7 00000=
000000000cf
> >  t0 0000000000000000 t1 0000000000004000 t2 0000000000000048 t3 00000=
00000000000
> >  t4 0000000000000001 t5 0000000000000002 t6 0000000000000001 t7 00000=
00000000002
> >  t8 0000000000000018 u0 9000000004856150 s9 0000000000000000 s0 00000=
00000000000
> >  s1 0000000000000000 s2 90001000aa16fd70 s3 0000000000000000 s4 00000=
00000000000
> >  s5 0000000000004000 s6 900010009284dc00 s7 0000000000000001 s8 90001=
0009284dc00
> >     ra: 90000000048bf6c0 sk_msg_recvmsg+0x120/0x560
> >    ERA: 9000000004162774 copy_page_to_iter+0x74/0x1c0
> >   CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -WE)
> >   PRMD: 0000000c (PPLV0 +PIE +PWE)
> >   EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
> >   ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
> >  ESTAT: 00010000 [PIL] (IS=3D ECode=3D1 EsubCode=3D0)
> >   BADV: 0000000000000040
> >   PRID: 0014c011 (Loongson-64bit, Loongson-3C5000)
> >  Modules linked in: bpf_testmod(OE) xt_CHECKSUM xt_MASQUERADE xt_conn=
track
> >  Process test_progs (pid: 2824, threadinfo=3D0000000000863a31, task=3D=
000000001cba0874)
> >  Stack : 0000000000000001 fffffffffffffffc 0000000000000000 000000000=
0000000
> >          0000000000000018 0000000000000000 0000000000000000 900000000=
48bf6c0
> >          90000000052cd638 90001000aa16fd70 900010008bf51580 900010009=
284f000
> >          90000000049f2b90 900010009284f188 900010009284f178 900010008=
61d4780
> >          9000100084dccd00 0000000000000800 0000000000000007 fffffffff=
ffffff2
> >          000000000453e92f 90000000049aae34 90001000aa16fd60 900010009=
284f000
> >          0000000000000000 0000000000000000 900010008bf51580 900000000=
49f2b90
> >          0000000000000001 0000000000000000 9000100084dc3a10 900010009=
284f1ac
> >          90001000aa16fd40 0000555559953278 0000000000000001 000000000=
0000000
> >          90001000aa16fdc8 9000000005a5a000 90001000861d4780 000000000=
0000800
> >          ...
> >  Call Trace:
> >  [<9000000004162774>] copy_page_to_iter+0x74/0x1c0
> >  [<90000000048bf6c0>] sk_msg_recvmsg+0x120/0x560
> >  [<90000000049f2b90>] tcp_bpf_recvmsg_parser+0x170/0x4e0
> >  [<90000000049aae34>] inet_recvmsg+0x54/0x100
> >  [<900000000481ad5c>] sock_recvmsg+0x7c/0xe0
> >  [<900000000481e1a8>] __sys_recvfrom+0x108/0x1c0
> >  [<900000000481e27c>] sys_recvfrom+0x1c/0x40
> >  [<9000000004c076ec>] do_syscall+0x8c/0xc0
> >  [<9000000003731da4>] handle_syscall+0xc4/0x160
> >
> >  Code: 0010b09b  440125a0  0011df8d <28c10364> 0012b70c  00133305  00=
13b1ac  0010dc84  00151585
> >
> >  ---[ end trace 0000000000000000 ]---
> >  Kernel panic - not syncing: Fatal exception
> >  Kernel relocated by 0x3510000
> >   .text @ 0x9000000003710000
> >   .data @ 0x9000000004d70000
> >   .bss  @ 0x9000000006469400
> >  ---[ end Kernel panic - not syncing: Fatal exception ]---
> > '''
> >
> > This is because "sg_page(sge)" is NULL in that case. This patch adds =
null
> > check for it in sk_msg_recvmsg() to fix this error.
> >
> > Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interfa=
ce")
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/core/skmsg.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > index fd20aae30be2..bafcc1e2eadf 100644
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
> > @@ -432,6 +432,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_pso=
ck *psock, struct msghdr *msg,
> >                         sge =3D sk_msg_elem(msg_rx, i);
> >                         copy =3D sge->length;
> >                         page =3D sg_page(sge);
> > +                       if (!page)
> > +                               goto out;
> >                         if (copied + copy > len)
> >                                 copy =3D len - copied;
> >                         copy =3D copy_page_to_iter(page, sge->offset,=
 copy, iter);
> > --
> > 2.43.0
> >
> =

> This looks pretty much random to me.
> =

> Please find the root cause, instead of desperately trying to fix 'tests=
'.

If this happens then either we put a bad msg_rx on the queue see a few li=
nes
up and we need to sort out why that msg_rx was built. Or we walked off th=
e
end of a scatter gather list and need to see why this test isn't sufficie=
nt?

  } while ((i !=3D msg_rx->sg.end) && !sg_is_last(sge))

is this happening every time you run the command or did you run this for
a long iteration and eventually hit this? I don't see why this would be
specific to your arch though.=

