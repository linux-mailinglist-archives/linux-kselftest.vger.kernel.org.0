Return-Path: <linux-kselftest+bounces-6290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE35887A10D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 02:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F942821E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 01:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD6FBA33;
	Wed, 13 Mar 2024 01:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gt7CwXCw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5004BB66C
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Mar 2024 01:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710294835; cv=none; b=CHHYBOZmxj6dcDvCYYuipOqveMQXY4BflzhHEYJaQROSWJeBCe+uAzTCuSXn8CQO9R2+KonngYku4F9NDQJHpAVX46u5CAjniH6zRxEUbRMMVvIOVB9QZ3WqdT/G8vZJJ5VA0C7V+6AfZurtKf9LIc3hMTYeJ9zju3pv7owG4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710294835; c=relaxed/simple;
	bh=VJyuvh6XroWcN//l0X/a6mKR6esThbwoEFp9wLz0ITQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqRfqKWZUCoTnK23JbAbyObQy1P9SepP3gZ+BaxflcVY49uttuMk2Pn+GgRbE6fpqNrrGGTBveBfGrG++UVWpy1N5fkC9lsO5QrUz3QTgcjV/aldggxFGMk7LqhfkM/gKaPIQg1DsP+2nwYzNLIXT+gbRqxW219uL0LQKmyG66E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gt7CwXCw; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29c16b324ecso1891911a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Mar 2024 18:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710294833; x=1710899633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7l5GW7Xueu7fYsf7BEOcM5d+RaLSvHptG6HFvYvp5v8=;
        b=gt7CwXCwKszw+Rpmvl/FJkFc2RIYjA9MXMNVpLpoLDVTL7M1paBlGE7/vHrSqYwR/1
         08Fh5L+IpOyjdflRw0bX4nd/c7CRQsztH3KTOMGTzHzo+WPHiZfTj04+/xKzDYb7gbMP
         iI3d3iZnRrzR6tNibiycSDz8htVfmb2eRDP1vC3KsXvGMJY2njLsXxIXt02LQuJ0Bzzs
         NiSLGG7Us+wH7VgETLbztfzvRnMGpUdBsB6w/Aj49RkHbzFkZk7HDE7WiFrvDLxaRYsS
         p/8NHL3XplA/Sgmlopu10PVHmj+1iT6HJTcbEiap1nqMLSt8Op/+NI0SVy6uGln4E3jX
         Y2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710294833; x=1710899633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7l5GW7Xueu7fYsf7BEOcM5d+RaLSvHptG6HFvYvp5v8=;
        b=NGb/lhfv5I4mQZwnfiLFFwdpYztN507+K6GhQ6WXY0fqaAX5fYqlcn59cKeScc9DPQ
         NHg8IdoIWE3EEYn8HgCbdxkwLbFEa3xF63MX1cE1RK5N2Hoz77p9Dw8/aixmFh3APeOB
         RA8kYP3fqJ5m2BsepaMeqjcciqyl0XbKfIWHi/Cl1PEyPS+EqmVn350pKjckP0zn4cC8
         jFUdHSY6h4GJSpfWMaCy4ah5ReNaAt5qdRtgmdyAZ/dCjaFfAAEaqTkbdnwYJ3mwIS9B
         k+Id1Jvy7H9mQVq/uutncIt/dQglAX0JEtYMWZS9bh1+fdH4/A+ZBfLGluxx8i0vQacD
         H6BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiOAQwt1TPbbe9hKfq98mHp98XwyqC0ReuxY3LPt01jKQeLoOLFhTyYZmNsVA4ms0ZhdVzFXAcZUjLs4Lv419HCUetf4ex9J40YbiSIp/K
X-Gm-Message-State: AOJu0YxLqzDQOrJ7iBx2Er+UC3OSHJKJF776J7o7ANSKiKupZXaO+uN0
	Vq8a94nRXRlbaRriyPhlDtk0rUhBROAgjM2mookAtEEX5NjqXDO5SDToXGyyI3lugliOO/4XJQv
	baKt1VvB7VBu3Gg/OQjxFKbPeFhbFE7UcrzFd6w==
X-Google-Smtp-Source: AGHT+IHgGbwSxuf8Mmcf4YK9IOWtZvoBJarSb5lD1Bv4wCl1IDU6oxYJMO4FXlVIEhW8DTCD21/mcpij4jSoKbejNKI=
X-Received: by 2002:a17:90a:e612:b0:29c:1271:219e with SMTP id
 j18-20020a17090ae61200b0029c1271219emr6694584pjy.18.1710294833648; Tue, 12
 Mar 2024 18:53:53 -0700 (PDT)
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
 <CALz3k9icPePb0c4FE67q=u1U0hrePorN9gDpQrKTR_sXbLMfDA@mail.gmail.com> <CAADnVQLwgw8bQ7OHBbqLhcPJ2QpxiGw3fkMFur+2cjZpM_78oA@mail.gmail.com>
In-Reply-To: <CAADnVQLwgw8bQ7OHBbqLhcPJ2QpxiGw3fkMFur+2cjZpM_78oA@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Wed, 13 Mar 2024 09:53:42 +0800
Message-ID: <CALz3k9g9k7fEwdTZVLhrmGoXp8CE47Q+83r-AZDXrzzuR+CjVA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support
 to record and check the accessed args
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Wed, Mar 13, 2024 at 12:42=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 11, 2024 at 7:42=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <dong=
menglong.8@bytedance.com> wrote:
> >
[......]
>
> I see.
> I thought you're sharing the trampoline across attachments.
> (since bpf prog is the same).

That seems to be a good idea, which I hadn't thought before.

> But above approach cannot possibly work with a shared trampoline.
> You need to create individual trampoline for all attachment
> and point them to single bpf prog.
>
> tbh I'm less excited about this feature now, since sharing
> the prog across different attachments is nice, but it won't scale
> to thousands of attachments.
> I assumed that there will be a single trampoline with max(argno)
> across attachments and attach/detach will scale to thousands.
>
> With individual trampoline this will work for up to a hundred
> attachments max.

What does "a hundred attachments max" means? Can't I
trace thousands of kernel functions with a bpf program of
tracing multi-link?

>
> Let's step back.
> What is the exact use case you're trying to solve?
> Not an artificial one as selftest in patch 9, but the real use case?

I have a tool, which is used to diagnose network problems,
and its name is "nettrace". It will trace many kernel functions, whose
function args contain "skb", like this:

./nettrace -p icmp
begin trace...
***************** ffff889be8fbd500,ffff889be8fbcd00 ***************
[1272349.614564] [dev_gro_receive     ] ICMP: 169.254.128.15 ->
172.27.0.6 ping request, seq: 48220
[1272349.614579] [__netif_receive_skb_core] ICMP: 169.254.128.15 ->
172.27.0.6 ping request, seq: 48220
[1272349.614585] [ip_rcv              ] ICMP: 169.254.128.15 ->
172.27.0.6 ping request, seq: 48220
[1272349.614592] [ip_rcv_core         ] ICMP: 169.254.128.15 ->
172.27.0.6 ping request, seq: 48220
[1272349.614599] [skb_clone           ] ICMP: 169.254.128.15 ->
172.27.0.6 ping request, seq: 48220
[1272349.614616] [nf_hook_slow        ] ICMP: 169.254.128.15 ->
172.27.0.6 ping request, seq: 48220
[1272349.614629] [nft_do_chain        ] ICMP: 169.254.128.15 ->
172.27.0.6 ping request, seq: 48220
[1272349.614635] [ip_rcv_finish       ] ICMP: 169.254.128.15 ->
172.27.0.6 ping request, seq: 48220
[1272349.614643] [ip_route_input_slow ] ICMP: 169.254.128.15 ->
172.27.0.6 ping request, seq: 48220
[1272349.614647] [fib_validate_source ] ICMP: 169.254.128.15 ->
172.27.0.6 ping request, seq: 48220
[1272349.614652] [ip_local_deliver    ] ICMP: 169.254.128.15 ->
172.27.0.6 ping request, seq: 48220
[1272349.614658] [nf_hook_slow        ] ICMP: 169.254.128.15 ->
172.27.0.6 ping request, seq: 48220
[1272349.614663] [ip_local_deliver_finish] ICMP: 169.254.128.15 ->
172.27.0.6 ping request, seq: 48220
[1272349.614666] [icmp_rcv            ] ICMP: 169.254.128.15 ->
172.27.0.6 ping request, seq: 48220
[1272349.614671] [icmp_echo           ] ICMP: 169.254.128.15 ->
172.27.0.6 ping request, seq: 48220
[1272349.614675] [icmp_reply          ] ICMP: 169.254.128.15 ->
172.27.0.6 ping request, seq: 48220
[1272349.614715] [consume_skb         ] ICMP: 169.254.128.15 ->
172.27.0.6 ping request, seq: 48220
[1272349.614722] [packet_rcv          ] ICMP: 169.254.128.15 ->
172.27.0.6 ping request, seq: 48220
[1272349.614725] [consume_skb         ] ICMP: 169.254.128.15 ->
172.27.0.6 ping request, seq: 48220

For now, I have to create a bpf program for every kernel
function that I want to trace, which is up to 200.

With this multi-link, I only need to create 5 bpf program,
like this:

int BPF_PROG(trace_skb_1, struct *skb);
int BPF_PROG(trace_skb_2, u64 arg0, struct *skb);
int BPF_PROG(trace_skb_3, u64 arg0, u64 arg1, struct *skb);
int BPF_PROG(trace_skb_4, u64 arg0, u64 arg1, u64 arg2, struct *skb);
int BPF_PROG(trace_skb_5, u64 arg0, u64 arg1, u64 arg2, u64 arg3, struct *s=
kb);

Then, I can attach trace_skb_1 to all the kernel functions that
I want to trace and whose first arg is skb; attach trace_skb_2 to kernel
functions whose 2nd arg is skb, etc.

Or, I can create only one bpf program and store the index
of skb to the attachment cookie, and attach this program to all
the kernel functions that I want to trace.

This is my use case. With the multi-link, now I only have
1 bpf program, 1 bpf link, 200 trampolines, instead of 200
bpf programs, 200 bpf link and 200 trampolines.

The shared trampoline you mentioned seems to be a
wonderful idea, which can make the 200 trampolines
to one. Let me have a look, we create a trampoline and
record the max args count of all the target functions, let's
mark it as arg_count.

During generating the trampoline, we assume that the
function args count is arg_count. During attaching, we
check the consistency of all the target functions, just like
what we do now.

Am I right?

Thanks!
Menglong Dong

