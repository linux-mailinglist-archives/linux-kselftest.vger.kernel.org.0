Return-Path: <linux-kselftest+bounces-6308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A84DC87B5C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 01:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD162863C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 00:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B7863D;
	Thu, 14 Mar 2024 00:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdqMrdyl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF96C7F;
	Thu, 14 Mar 2024 00:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710375951; cv=none; b=PQOLe92SVYXfkAaiLnguOWR3vHcs1cEv/vmNO0gwkFUR4E3ng7W9Qh7DLBZjicGsZhhCiLJ2FGqiLHu7T79YG9gkS+DGCE6+shhMqx+/ryr7ED1Z11pl1Rt8xfcKG81yGVVt1oqvWzdKwQfcDig4HAg9VjIjQZLg4bl3mCeY6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710375951; c=relaxed/simple;
	bh=9EoMAftd9vY6BGdahDlojvcesrBvYUJgWbCGJaD+H+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1R0a3XYor+KmeTKYIJ4asID37ZsKdtnDnU+j2X5o8Zj6g92KVFmqgyIPthKrxDhJVdIx3xdEPN8XbG+GvLoDC1L0Hfoj2H6i8KHVXSp5FqhllVGo5WVEgHxuH6kXzdp/PnlHgq7fcWC0R898Z/Nsau+5IBOKvsicSn1UgH24mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdqMrdyl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33e8e9a4edaso405846f8f.2;
        Wed, 13 Mar 2024 17:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710375948; x=1710980748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1pXXVSLcJWs+QWrQ+i4P/taCr8L+0F6xiRmk8ycZXY=;
        b=OdqMrdylzqEmk8VEhLX1MaecvtTmKmwYObl/HWkrJz2vxQmpRjFG9i7g8QGYsrvjIS
         3B4axAft8v/tYcF4Gf34OYyjD5HXLwCu/fQk6dDB5SSUTT54DYmdhidhXRF5oA2YXlAt
         bMrhze1VDqGgWJn6bURCARSVFag3rtodXL3MFiBzhrQOnbz2Ct8WRc/U76bVoBpsXL0b
         fUWX1a4am4L1t4shFGn52EjdIYbWHjDksvo3e9tIZtqeVAbxDzo7kbJTYxqazVtuq7VX
         5uJ1R0NgYUNHglDFpt5lMfQs9/yZ+8b6vvpBFAuqLbwiYr7H5NbhKdhb3DkoKBqdlrRo
         H7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710375948; x=1710980748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1pXXVSLcJWs+QWrQ+i4P/taCr8L+0F6xiRmk8ycZXY=;
        b=Gp3B4kqA1uQ7w4ERAzo0xDM1z2drDlO7/W3S6ugQ0teE3UfTsYmFufGLKN0RRBAgXq
         HoJZBYgAy2aVkhXr9IskiPVpkVUmywVqUVAwR3A1FgNe1w3tdLHsFrAheyHAo2dYocSk
         iclK+A4Pfzp/Kcm2q7IL1YvhBSYAoOFnTFoohQ9EKLmXOiIaH0lqzyL3g73lA2DxEFme
         me/8jt86a13+mcB1E1hkOn7lGGRAhAKIozoBvDxriQGDSokksaEBUsxVHkBcdSkfPywR
         rEJyeACyT7zYvfDTHyWuoQievp651My0kbqZDv45WXImnVtb03Hp/gX89DVgxJND75a5
         O1tg==
X-Forwarded-Encrypted: i=1; AJvYcCV+MoOvZgsUoUpQUJPyphFpdDWfJkSqlZfC4RY38bCxBm/0apLstsk9sY/xpTTBkIxVsiNqFrELE7a5mnqpky8QeqEhDrebejlrHmL6VKmoUCUqJT4i0ZJc/SQQ32YQwcVYP/5FE2I298QfePSlXH3NMc+oCSSZBv20cwIPrUG/dwNx4AojkkHcaBpyoHyIR+wpeiDPqqsD3dTH0tBxs/+76XJ0Y44TOwQgPwKbNOXTtHt250J65oGCbLyBj/M/8ghGUS7Scfr6cMx4iUNsJBLOZBQpj2HiJtwoFQ==
X-Gm-Message-State: AOJu0YyPgXjJNakyVxQExxzx0wjcqTVdVdoGKvzlX6EkDqv5JtZqAkzh
	vwywPgHZ1JzJQDp84w3Jci1F+ONBlX8zTWXgVAb6YrfiynGjevvSfUC3BPmhO3apr1Jn+VrwNAf
	QjL+FiG2UxEKVveH8LSBgXj1Fyxs=
X-Google-Smtp-Source: AGHT+IEluUxpksFRvEO4amy8bxc8cXhNS84YSmujwUrBqdFTzudYkIWBqt3bc5Ekgo5hTd/k08iQyCGhQiEqmdJKoSg=
X-Received: by 2002:a5d:438e:0:b0:33e:44da:827 with SMTP id
 i14-20020a5d438e000000b0033e44da0827mr112820wrq.57.1710375947716; Wed, 13 Mar
 2024 17:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-2-dongmenglong.8@bytedance.com> <CAADnVQKQPS5NcvEouH4JqZ2fKgQAC+LtcwhX9iXYoiEkF_M94Q@mail.gmail.com>
 <CALz3k9i5G5wWi+rtvHPwVLOUAXVMCiU_8QUZs87TEYgR_0wpPA@mail.gmail.com>
 <CAADnVQJ_ZCzMmT1aBsNXEBFfYNSVBdBXmLocjR0PPEWtYQrQFw@mail.gmail.com>
 <CALz3k9icPePb0c4FE67q=u1U0hrePorN9gDpQrKTR_sXbLMfDA@mail.gmail.com>
 <CAADnVQLwgw8bQ7OHBbqLhcPJ2QpxiGw3fkMFur+2cjZpM_78oA@mail.gmail.com> <CALz3k9g9k7fEwdTZVLhrmGoXp8CE47Q+83r-AZDXrzzuR+CjVA@mail.gmail.com>
In-Reply-To: <CALz3k9g9k7fEwdTZVLhrmGoXp8CE47Q+83r-AZDXrzzuR+CjVA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 Mar 2024 17:25:35 -0700
Message-ID: <CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support
 to record and check the accessed args
To: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Quentin Monnet <quentin@isovalent.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 6:53=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <dongme=
nglong.8@bytedance.com> wrote:
>
> On Wed, Mar 13, 2024 at 12:42=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Mar 11, 2024 at 7:42=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <do=
ngmenglong.8@bytedance.com> wrote:
> > >
> [......]
> >
> > I see.
> > I thought you're sharing the trampoline across attachments.
> > (since bpf prog is the same).
>
> That seems to be a good idea, which I hadn't thought before.
>
> > But above approach cannot possibly work with a shared trampoline.
> > You need to create individual trampoline for all attachment
> > and point them to single bpf prog.
> >
> > tbh I'm less excited about this feature now, since sharing
> > the prog across different attachments is nice, but it won't scale
> > to thousands of attachments.
> > I assumed that there will be a single trampoline with max(argno)
> > across attachments and attach/detach will scale to thousands.
> >
> > With individual trampoline this will work for up to a hundred
> > attachments max.
>
> What does "a hundred attachments max" means? Can't I
> trace thousands of kernel functions with a bpf program of
> tracing multi-link?

I mean what time does it take to attach one program
to 100 fentry-s ?
What is the time for 1k and for 10k ?

The kprobe multi test attaches to pretty much all funcs in
/sys/kernel/tracing/available_filter_functions
and it's fast enough to run in test_progs on every commit in bpf CI.
See get_syms() in prog_tests/kprobe_multi_test.c

Can this new multi fentry do that?
and at what speed?
The answer will decide how applicable this api is going to be.
Generating different trampolines for every attach point
is an approach as well. Pls benchmark it too.

> >
> > Let's step back.
> > What is the exact use case you're trying to solve?
> > Not an artificial one as selftest in patch 9, but the real use case?
>
> I have a tool, which is used to diagnose network problems,
> and its name is "nettrace". It will trace many kernel functions, whose
> function args contain "skb", like this:
>
> ./nettrace -p icmp
> begin trace...
> ***************** ffff889be8fbd500,ffff889be8fbcd00 ***************
> [1272349.614564] [dev_gro_receive     ] ICMP: 169.254.128.15 ->
> 172.27.0.6 ping request, seq: 48220
> [1272349.614579] [__netif_receive_skb_core] ICMP: 169.254.128.15 ->
> 172.27.0.6 ping request, seq: 48220
> [1272349.614585] [ip_rcv              ] ICMP: 169.254.128.15 ->
> 172.27.0.6 ping request, seq: 48220
> [1272349.614592] [ip_rcv_core         ] ICMP: 169.254.128.15 ->
> 172.27.0.6 ping request, seq: 48220
> [1272349.614599] [skb_clone           ] ICMP: 169.254.128.15 ->
> 172.27.0.6 ping request, seq: 48220
> [1272349.614616] [nf_hook_slow        ] ICMP: 169.254.128.15 ->
> 172.27.0.6 ping request, seq: 48220
> [1272349.614629] [nft_do_chain        ] ICMP: 169.254.128.15 ->
> 172.27.0.6 ping request, seq: 48220
> [1272349.614635] [ip_rcv_finish       ] ICMP: 169.254.128.15 ->
> 172.27.0.6 ping request, seq: 48220
> [1272349.614643] [ip_route_input_slow ] ICMP: 169.254.128.15 ->
> 172.27.0.6 ping request, seq: 48220
> [1272349.614647] [fib_validate_source ] ICMP: 169.254.128.15 ->
> 172.27.0.6 ping request, seq: 48220
> [1272349.614652] [ip_local_deliver    ] ICMP: 169.254.128.15 ->
> 172.27.0.6 ping request, seq: 48220
> [1272349.614658] [nf_hook_slow        ] ICMP: 169.254.128.15 ->
> 172.27.0.6 ping request, seq: 48220
> [1272349.614663] [ip_local_deliver_finish] ICMP: 169.254.128.15 ->
> 172.27.0.6 ping request, seq: 48220
> [1272349.614666] [icmp_rcv            ] ICMP: 169.254.128.15 ->
> 172.27.0.6 ping request, seq: 48220
> [1272349.614671] [icmp_echo           ] ICMP: 169.254.128.15 ->
> 172.27.0.6 ping request, seq: 48220
> [1272349.614675] [icmp_reply          ] ICMP: 169.254.128.15 ->
> 172.27.0.6 ping request, seq: 48220
> [1272349.614715] [consume_skb         ] ICMP: 169.254.128.15 ->
> 172.27.0.6 ping request, seq: 48220
> [1272349.614722] [packet_rcv          ] ICMP: 169.254.128.15 ->
> 172.27.0.6 ping request, seq: 48220
> [1272349.614725] [consume_skb         ] ICMP: 169.254.128.15 ->
> 172.27.0.6 ping request, seq: 48220
>
> For now, I have to create a bpf program for every kernel
> function that I want to trace, which is up to 200.
>
> With this multi-link, I only need to create 5 bpf program,
> like this:
>
> int BPF_PROG(trace_skb_1, struct *skb);
> int BPF_PROG(trace_skb_2, u64 arg0, struct *skb);
> int BPF_PROG(trace_skb_3, u64 arg0, u64 arg1, struct *skb);
> int BPF_PROG(trace_skb_4, u64 arg0, u64 arg1, u64 arg2, struct *skb);
> int BPF_PROG(trace_skb_5, u64 arg0, u64 arg1, u64 arg2, u64 arg3, struct =
*skb);
>
> Then, I can attach trace_skb_1 to all the kernel functions that
> I want to trace and whose first arg is skb; attach trace_skb_2 to kernel
> functions whose 2nd arg is skb, etc.
>
> Or, I can create only one bpf program and store the index
> of skb to the attachment cookie, and attach this program to all
> the kernel functions that I want to trace.
>
> This is my use case. With the multi-link, now I only have
> 1 bpf program, 1 bpf link, 200 trampolines, instead of 200
> bpf programs, 200 bpf link and 200 trampolines.

I see. The use case makes sense to me.
Andrii's retsnoop is used to do similar thing before kprobe multi was
introduced.

> The shared trampoline you mentioned seems to be a
> wonderful idea, which can make the 200 trampolines
> to one. Let me have a look, we create a trampoline and
> record the max args count of all the target functions, let's
> mark it as arg_count.
>
> During generating the trampoline, we assume that the
> function args count is arg_count. During attaching, we
> check the consistency of all the target functions, just like
> what we do now.

For one trampoline to handle all attach points we might
need some arch support, but we can start simple.
Make btf_func_model with MAX_BPF_FUNC_REG_ARGS
by calling btf_distill_func_proto() with func=3D=3DNULL.
And use that to build a trampoline.

The challenge is how to use minimal number of trampolines
when bpf_progA is attached for func1, func2, func3
and bpf_progB is attached to func3, func4, func5.
We'd still need 3 trampolines:
for func[12] to call bpf_progA,
for func3 to call bpf_progA and bpf_progB,
for func[45] to call bpf_progB.

Jiri was trying to solve it in the past. His slides from LPC:
https://lpc.events/event/16/contributions/1350/attachments/1033/1983/plumbe=
rs.pdf

Pls study them and his prior patchsets to avoid stepping on the same rakes.

