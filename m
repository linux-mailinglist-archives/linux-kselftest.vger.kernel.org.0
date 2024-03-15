Return-Path: <linux-kselftest+bounces-6341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFD287C9C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 09:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DA928127E
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 08:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24A415E81;
	Fri, 15 Mar 2024 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BnLnF6jp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595511758B
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Mar 2024 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490646; cv=none; b=KX14aTLnGs2VkvOyPFo2FhnL7SFIPdam9gOm50xDHE5B8JLTXBU6YDDmP/h5E5u67AmARhfcA3yJLCCqg79Kxr69yAvAeqqbeAHb8BlzkE0Pk1x/tbPWpF6fpfWoAAHnta4LqE9neAZFhhO/r+7h39ZzSRCqcev1qyCux0LbZ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490646; c=relaxed/simple;
	bh=3Veip/OxCnGKCQ+Abe6TiS3hdoh9knWDIAqJQrDZQBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsF2Sb6AsfKNccWpWnUok1kE4B+lImG0Q42XnUwlrP5TaONYFv1hHQpMMTXmF6TAJlfLnEL/suX43do5+qb08ok/Qyzr/0wn008rVMC+1JDKYrmTjmnZu5aMPvKycJcLPg63U0ow4AaPSa8CAroa/TwHLi4LtzV15bpyjwG8vlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BnLnF6jp; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so2088399a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Mar 2024 01:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710490644; x=1711095444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ux+mgvQeyHLipAJjQDCARUR07kgvWhujuDpfd9PKvNE=;
        b=BnLnF6jpTf0M3GTFjcSWetvSvIQOQ369PIgwF3aG0VASfibFMiCxnhy8vtyqhOsjyx
         4iCua5b7xLUAUwDsGjXK/pp/XgXWUnBG6c/CKGhyio9pC/GzFGLP2/VFJWSe+yw6/QC2
         SLs4tMFzW1MrA6ts1TTFeTkDa7eHXNIoux2jcNUZcTWqGHBe6mTwr32HfYOFkkZcXOe2
         z2RVX0Hq5om3SYzgJ9iR3RM98+/Fv0UMU7l6EP5buU4YPD8LDhyAIISras9vEeQp4wfc
         3SPkE0rovMXGjiRmz7PzUbWxW1Z1HmnSlwKnklK6x/rX5v3TAVv47PoG9ldtlB1sAHTd
         tnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710490644; x=1711095444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ux+mgvQeyHLipAJjQDCARUR07kgvWhujuDpfd9PKvNE=;
        b=p+/mS+SeQrZ4dxEuPhQmXz03kP5dqKFCK2bdoHicpV6e/1V5BegTWR22V7H85GFkdK
         qxt4PJOaCiyetVBsZbXXjeo2mWPkVYHiQAFkF/23ZbfJUhEEnen8Tq10+JUhwvSaL9cw
         Gw/uANgLavV+8vGcZ1qY8THPBjuyRxYpIIiUdCLE82aJegE6Ag+/6OzLIH7AArNIlYmb
         Cgc7HyGBZYANLpWXz1f72OVyfB9vbLAfbiosOOH3yhNBhcCpCL1YjzeWDLhFEgf0Savw
         +DmrBr0ZdXgNDeoXJJfJv8pnzNPqiGy3tiunT4FeHmfHOS9YN1zfd/G6LYYnP5Up9pzB
         kbfA==
X-Forwarded-Encrypted: i=1; AJvYcCWRu38OPuRcfkFppz/qIwlCJ4rx2vXBH3jrhGPpeJA8IfKcZsTuFcZZgWbgw917qCSWrmwGEpvt1itIeMceQ3Wkdi9ebZDtmTuMVEfx06xX
X-Gm-Message-State: AOJu0YzaqIVvclj+8kh04EaJm37I/L9Ezvstv5y1G99wMErcjQegD+jI
	iU7FauYuSsCGwibEQsOYheWMemxC3iPzgmxaHBC61UaXItMAq7C8iwx1f14383rR99r72v8HnPT
	LeNH3EDmOhyRcNwyvqZdcfCF8s2xI067TYhj8kQ==
X-Google-Smtp-Source: AGHT+IH6WVj2QW6HVMnPZetJyxE6GBO3ARfmDCsMA75RFQoJ7vWKBd9vtLcWlAX1Fz+oArSrbQ03zFV2IWXrG37YkmE=
X-Received: by 2002:a17:90a:fa18:b0:29c:735:a758 with SMTP id
 cm24-20020a17090afa1800b0029c0735a758mr6401475pjb.19.1710490643623; Fri, 15
 Mar 2024 01:17:23 -0700 (PDT)
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
 <CAADnVQLwgw8bQ7OHBbqLhcPJ2QpxiGw3fkMFur+2cjZpM_78oA@mail.gmail.com>
 <CALz3k9g9k7fEwdTZVLhrmGoXp8CE47Q+83r-AZDXrzzuR+CjVA@mail.gmail.com>
 <CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com> <ZfKY6E8xhSgzYL1I@krava>
In-Reply-To: <ZfKY6E8xhSgzYL1I@krava>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Fri, 15 Mar 2024 16:17:12 +0800
Message-ID: <CALz3k9jM0eqgw1=RKQPFpn8nk4MZRadEC3ge0kRutfvN2WVbwg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support
 to record and check the accessed args
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
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

On Thu, Mar 14, 2024 at 2:29=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Mar 13, 2024 at 05:25:35PM -0700, Alexei Starovoitov wrote:
> > On Tue, Mar 12, 2024 at 6:53=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <do=
ngmenglong.8@bytedance.com> wrote:
> > >
> > > On Wed, Mar 13, 2024 at 12:42=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Mar 11, 2024 at 7:42=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3=
 <dongmenglong.8@bytedance.com> wrote:
> > > > >
> > > [......]
> > > >
> > > > I see.
> > > > I thought you're sharing the trampoline across attachments.
> > > > (since bpf prog is the same).
> > >
> > > That seems to be a good idea, which I hadn't thought before.
> > >
> > > > But above approach cannot possibly work with a shared trampoline.
> > > > You need to create individual trampoline for all attachment
> > > > and point them to single bpf prog.
> > > >
> > > > tbh I'm less excited about this feature now, since sharing
> > > > the prog across different attachments is nice, but it won't scale
> > > > to thousands of attachments.
> > > > I assumed that there will be a single trampoline with max(argno)
> > > > across attachments and attach/detach will scale to thousands.
> > > >
> > > > With individual trampoline this will work for up to a hundred
> > > > attachments max.
> > >
> > > What does "a hundred attachments max" means? Can't I
> > > trace thousands of kernel functions with a bpf program of
> > > tracing multi-link?
> >
> > I mean what time does it take to attach one program
> > to 100 fentry-s ?
> > What is the time for 1k and for 10k ?
> >
> > The kprobe multi test attaches to pretty much all funcs in
> > /sys/kernel/tracing/available_filter_functions
> > and it's fast enough to run in test_progs on every commit in bpf CI.
> > See get_syms() in prog_tests/kprobe_multi_test.c
> >
> > Can this new multi fentry do that?
> > and at what speed?
> > The answer will decide how applicable this api is going to be.
> > Generating different trampolines for every attach point
> > is an approach as well. Pls benchmark it too.
> >
> > > >
> > > > Let's step back.
> > > > What is the exact use case you're trying to solve?
> > > > Not an artificial one as selftest in patch 9, but the real use case=
?
> > >
> > > I have a tool, which is used to diagnose network problems,
> > > and its name is "nettrace". It will trace many kernel functions, whos=
e
> > > function args contain "skb", like this:
> > >
> > > ./nettrace -p icmp
> > > begin trace...
> > > ***************** ffff889be8fbd500,ffff889be8fbcd00 ***************
> > > [1272349.614564] [dev_gro_receive     ] ICMP: 169.254.128.15 ->
> > > 172.27.0.6 ping request, seq: 48220
> > > [1272349.614579] [__netif_receive_skb_core] ICMP: 169.254.128.15 ->
> > > 172.27.0.6 ping request, seq: 48220
> > > [1272349.614585] [ip_rcv              ] ICMP: 169.254.128.15 ->
> > > 172.27.0.6 ping request, seq: 48220
> > > [1272349.614592] [ip_rcv_core         ] ICMP: 169.254.128.15 ->
> > > 172.27.0.6 ping request, seq: 48220
> > > [1272349.614599] [skb_clone           ] ICMP: 169.254.128.15 ->
> > > 172.27.0.6 ping request, seq: 48220
> > > [1272349.614616] [nf_hook_slow        ] ICMP: 169.254.128.15 ->
> > > 172.27.0.6 ping request, seq: 48220
> > > [1272349.614629] [nft_do_chain        ] ICMP: 169.254.128.15 ->
> > > 172.27.0.6 ping request, seq: 48220
> > > [1272349.614635] [ip_rcv_finish       ] ICMP: 169.254.128.15 ->
> > > 172.27.0.6 ping request, seq: 48220
> > > [1272349.614643] [ip_route_input_slow ] ICMP: 169.254.128.15 ->
> > > 172.27.0.6 ping request, seq: 48220
> > > [1272349.614647] [fib_validate_source ] ICMP: 169.254.128.15 ->
> > > 172.27.0.6 ping request, seq: 48220
> > > [1272349.614652] [ip_local_deliver    ] ICMP: 169.254.128.15 ->
> > > 172.27.0.6 ping request, seq: 48220
> > > [1272349.614658] [nf_hook_slow        ] ICMP: 169.254.128.15 ->
> > > 172.27.0.6 ping request, seq: 48220
> > > [1272349.614663] [ip_local_deliver_finish] ICMP: 169.254.128.15 ->
> > > 172.27.0.6 ping request, seq: 48220
> > > [1272349.614666] [icmp_rcv            ] ICMP: 169.254.128.15 ->
> > > 172.27.0.6 ping request, seq: 48220
> > > [1272349.614671] [icmp_echo           ] ICMP: 169.254.128.15 ->
> > > 172.27.0.6 ping request, seq: 48220
> > > [1272349.614675] [icmp_reply          ] ICMP: 169.254.128.15 ->
> > > 172.27.0.6 ping request, seq: 48220
> > > [1272349.614715] [consume_skb         ] ICMP: 169.254.128.15 ->
> > > 172.27.0.6 ping request, seq: 48220
> > > [1272349.614722] [packet_rcv          ] ICMP: 169.254.128.15 ->
> > > 172.27.0.6 ping request, seq: 48220
> > > [1272349.614725] [consume_skb         ] ICMP: 169.254.128.15 ->
> > > 172.27.0.6 ping request, seq: 48220
> > >
> > > For now, I have to create a bpf program for every kernel
> > > function that I want to trace, which is up to 200.
> > >
> > > With this multi-link, I only need to create 5 bpf program,
> > > like this:
> > >
> > > int BPF_PROG(trace_skb_1, struct *skb);
> > > int BPF_PROG(trace_skb_2, u64 arg0, struct *skb);
> > > int BPF_PROG(trace_skb_3, u64 arg0, u64 arg1, struct *skb);
> > > int BPF_PROG(trace_skb_4, u64 arg0, u64 arg1, u64 arg2, struct *skb);
> > > int BPF_PROG(trace_skb_5, u64 arg0, u64 arg1, u64 arg2, u64 arg3, str=
uct *skb);
> > >
> > > Then, I can attach trace_skb_1 to all the kernel functions that
> > > I want to trace and whose first arg is skb; attach trace_skb_2 to ker=
nel
> > > functions whose 2nd arg is skb, etc.
> > >
> > > Or, I can create only one bpf program and store the index
> > > of skb to the attachment cookie, and attach this program to all
> > > the kernel functions that I want to trace.
> > >
> > > This is my use case. With the multi-link, now I only have
> > > 1 bpf program, 1 bpf link, 200 trampolines, instead of 200
> > > bpf programs, 200 bpf link and 200 trampolines.
> >
> > I see. The use case makes sense to me.
> > Andrii's retsnoop is used to do similar thing before kprobe multi was
> > introduced.
> >
> > > The shared trampoline you mentioned seems to be a
> > > wonderful idea, which can make the 200 trampolines
> > > to one. Let me have a look, we create a trampoline and
> > > record the max args count of all the target functions, let's
> > > mark it as arg_count.
> > >
> > > During generating the trampoline, we assume that the
> > > function args count is arg_count. During attaching, we
> > > check the consistency of all the target functions, just like
> > > what we do now.
> >
> > For one trampoline to handle all attach points we might
> > need some arch support, but we can start simple.
> > Make btf_func_model with MAX_BPF_FUNC_REG_ARGS
> > by calling btf_distill_func_proto() with func=3D=3DNULL.
> > And use that to build a trampoline.
> >
> > The challenge is how to use minimal number of trampolines
> > when bpf_progA is attached for func1, func2, func3
> > and bpf_progB is attached to func3, func4, func5.
> > We'd still need 3 trampolines:
> > for func[12] to call bpf_progA,
> > for func3 to call bpf_progA and bpf_progB,
> > for func[45] to call bpf_progB.
> >
> > Jiri was trying to solve it in the past. His slides from LPC:
> > https://lpc.events/event/16/contributions/1350/attachments/1033/1983/pl=
umbers.pdf
> >
> > Pls study them and his prior patchsets to avoid stepping on the same ra=
kes.
>
> yep, I refrained from commenting not to take you down the same path
> I did, but if you insist.. ;-)
>
> I managed to forgot almost all of it, but the IIRC the main pain point
> was that at some point I had to split existing trampoline which caused
> the whole trampolines management and error paths to become a mess
>
> I tried to explain things in [1] changelog and the latest patchset is in =
[0]
>
> feel free to use/take anything, but I advice strongly against it ;-)
> please let me know if I can help

I have to say that I have not gone far enough to encounter
this problem, and I didn't dig enough to be aware of the
complexity.

I suspect that I can't overcome this challenge. The only thing that
I thought when I hear about the "shared trampoline" is to fallback
and not use the shared trampoline for the kernel functions who
already have a trampoline.

Anyway, let's have a try on it, based on your research.

Thanks!
Menglong Dong

>
> jirka
>
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=
=3Dbpf/batch
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit=
/?h=3Dbpf/batch&id=3D52a1d4acdf55df41e99ca2cea51865e6821036ce

