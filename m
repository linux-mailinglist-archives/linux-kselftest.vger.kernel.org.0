Return-Path: <linux-kselftest+bounces-6313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 815B587B7EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 07:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36859285613
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 06:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647E5DDD9;
	Thu, 14 Mar 2024 06:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxAJg3a3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C04D27E;
	Thu, 14 Mar 2024 06:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710397681; cv=none; b=jz/hOO5+UFyK+iNWi4R9EUzxbiLuZ3pQLA+0brzYknFIv8nphiJIYsThX/lohlS8LvbOFFZ0YgDm86k+nMfl7QQoiOW203Y/LodLgPY2BIl2ZUzepPk47qp/qZxznTQzQkrElRp5k8wrs8XNGiEzDZGhJzJzHc23vWVEeFC9uEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710397681; c=relaxed/simple;
	bh=9PJKp5d07U4cqQ+doLFO1wV2FwDX/AFcq+h6mLuajhA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ik5ui+cXHlpMXwDYrvcJ97qBmaoNSjt7Hd8fEEwKAXU3dPJ7RkA5rB4UzfNyZBXNedBca7gAXuP1Sjyr6tNk4kv9nv5m7hCgCFkotRk2IMlGXcCRoc+4GL+lYSvT4Dou1aJ448uNSCLb832JBEc2gP5BkbtPGBduX5t62dJ5NDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxAJg3a3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a44f2d894b7so53194866b.1;
        Wed, 13 Mar 2024 23:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710397676; x=1711002476; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wy48BMq7k7tUA5PbAAKgjU/lgoVJFz6MN9TbVJQFsQM=;
        b=UxAJg3a3Z+yT+HhNZCswgwLcX0lMVw/lOrUNh3ZZdeXorK0fIYY810Ti2siwbJb/x2
         iQKD6YyHgbTXClQ7vpDG1py1frjvjmj1cn9L755waaoc5+8e1OiLbI3ppTDSnVyzjKpj
         8jTK6JH8sxAH0qk0aWU47f2rUK1rZCoGLhtNvPDQMb5kR/DoR7cc3Ca3fbizS30nM90b
         2jL4szJTzoLU7Qo2W3HIFTgGk7HrtUzWjqsdKEflBYzZ/kNVhyxc4ZZEluzHSDhgfSgs
         9FSFHhJZZLB1s8aOrmFe1r4AtqDP1D5hE4hczL4IBB5AHm8ocTyz6QtBe96OFG2UZ2+D
         weyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710397676; x=1711002476;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wy48BMq7k7tUA5PbAAKgjU/lgoVJFz6MN9TbVJQFsQM=;
        b=oGF0xO9MUwF9x7XT86KBHYWcVeGVLRG2nWSS2pk0xJjoXMv8NTsXfViLmm7iRyWe6W
         1nPu28XTXH7TAs/qJuza1nQyw56TniBZzZWHZobBKx5clPXFQbRDo4pa4wAV6vpSGYPw
         aKGEA61xQOYYwh9Bv7h6NS7k+bQ/fi8bnMjNswX/rOWuKSvQoJHkjbvPubV5n7eu1vXH
         7odE5kCNELPQlrryi3wQtvVFtT15EPx/jcNh2/35+lfh1do2knTz6RSqb2dUYphyoOBT
         t+WvlVnPzcY8ahYcZs1oJX+eiDyWf/pyRYDvapi/nQSQO2WLsiYEePXZxSfootmLPgEt
         DaSw==
X-Forwarded-Encrypted: i=1; AJvYcCVS9QQXVZkbh6HjwVVx+tCiamGDoMwR3C50rjNo/jD4UJUvZ+fJAw1LJIMufTZdYRrceaQ2L2LCU71xOmgBkYSt/PXS1JOESxxatfca4/1UsmpB4FuoF3NDZuVUnov++Pjer/QCdKhPNSzfA/Yl+6sQzLisTm3CBDM8wQxBPJdFtcQKh5sxo65DzDftg21gxRVxzaNgsDqxOB5TF5Hl6Y3AkYINPFKceZyEd5p1xHi4OUhlcnhkzVnsmIx262h+5KlV6XGq9q5xeSgsN+RPkfJS/dQjgVI5cIvHnw==
X-Gm-Message-State: AOJu0YyMhHEBNBmHbQxVeZX/yZ4CuzjY5UuYQfXbTfB2fHMvcJlJdMPz
	3Y91Aw1uABMjgnAgA5Da48JScs492pEMjBwonp8f8tw/o6pLukBh
X-Google-Smtp-Source: AGHT+IF0pnR3t8OP32CidAqcEwLWVf5pxREHuVK53gI8rH7KwaQf04P9Mb0+ZaiK2iVNQgj+ScQKXQ==
X-Received: by 2002:a17:906:b899:b0:a3f:5ad2:1ff0 with SMTP id hb25-20020a170906b89900b00a3f5ad21ff0mr391041ejb.46.1710397675813;
        Wed, 13 Mar 2024 23:27:55 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ld8-20020a170906f94800b00a46754900a4sm104587ejb.33.2024.03.13.23.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 23:27:55 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 14 Mar 2024 07:27:52 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: =?utf-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	linux-s390 <linux-s390@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support
 to record and check the accessed args
Message-ID: <ZfKY6E8xhSgzYL1I@krava>
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-2-dongmenglong.8@bytedance.com>
 <CAADnVQKQPS5NcvEouH4JqZ2fKgQAC+LtcwhX9iXYoiEkF_M94Q@mail.gmail.com>
 <CALz3k9i5G5wWi+rtvHPwVLOUAXVMCiU_8QUZs87TEYgR_0wpPA@mail.gmail.com>
 <CAADnVQJ_ZCzMmT1aBsNXEBFfYNSVBdBXmLocjR0PPEWtYQrQFw@mail.gmail.com>
 <CALz3k9icPePb0c4FE67q=u1U0hrePorN9gDpQrKTR_sXbLMfDA@mail.gmail.com>
 <CAADnVQLwgw8bQ7OHBbqLhcPJ2QpxiGw3fkMFur+2cjZpM_78oA@mail.gmail.com>
 <CALz3k9g9k7fEwdTZVLhrmGoXp8CE47Q+83r-AZDXrzzuR+CjVA@mail.gmail.com>
 <CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com>

On Wed, Mar 13, 2024 at 05:25:35PM -0700, Alexei Starovoitov wrote:
> On Tue, Mar 12, 2024 at 6:53 PM 梦龙董 <dongmenglong.8@bytedance.com> wrote:
> >
> > On Wed, Mar 13, 2024 at 12:42 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Mar 11, 2024 at 7:42 PM 梦龙董 <dongmenglong.8@bytedance.com> wrote:
> > > >
> > [......]
> > >
> > > I see.
> > > I thought you're sharing the trampoline across attachments.
> > > (since bpf prog is the same).
> >
> > That seems to be a good idea, which I hadn't thought before.
> >
> > > But above approach cannot possibly work with a shared trampoline.
> > > You need to create individual trampoline for all attachment
> > > and point them to single bpf prog.
> > >
> > > tbh I'm less excited about this feature now, since sharing
> > > the prog across different attachments is nice, but it won't scale
> > > to thousands of attachments.
> > > I assumed that there will be a single trampoline with max(argno)
> > > across attachments and attach/detach will scale to thousands.
> > >
> > > With individual trampoline this will work for up to a hundred
> > > attachments max.
> >
> > What does "a hundred attachments max" means? Can't I
> > trace thousands of kernel functions with a bpf program of
> > tracing multi-link?
> 
> I mean what time does it take to attach one program
> to 100 fentry-s ?
> What is the time for 1k and for 10k ?
> 
> The kprobe multi test attaches to pretty much all funcs in
> /sys/kernel/tracing/available_filter_functions
> and it's fast enough to run in test_progs on every commit in bpf CI.
> See get_syms() in prog_tests/kprobe_multi_test.c
> 
> Can this new multi fentry do that?
> and at what speed?
> The answer will decide how applicable this api is going to be.
> Generating different trampolines for every attach point
> is an approach as well. Pls benchmark it too.
> 
> > >
> > > Let's step back.
> > > What is the exact use case you're trying to solve?
> > > Not an artificial one as selftest in patch 9, but the real use case?
> >
> > I have a tool, which is used to diagnose network problems,
> > and its name is "nettrace". It will trace many kernel functions, whose
> > function args contain "skb", like this:
> >
> > ./nettrace -p icmp
> > begin trace...
> > ***************** ffff889be8fbd500,ffff889be8fbcd00 ***************
> > [1272349.614564] [dev_gro_receive     ] ICMP: 169.254.128.15 ->
> > 172.27.0.6 ping request, seq: 48220
> > [1272349.614579] [__netif_receive_skb_core] ICMP: 169.254.128.15 ->
> > 172.27.0.6 ping request, seq: 48220
> > [1272349.614585] [ip_rcv              ] ICMP: 169.254.128.15 ->
> > 172.27.0.6 ping request, seq: 48220
> > [1272349.614592] [ip_rcv_core         ] ICMP: 169.254.128.15 ->
> > 172.27.0.6 ping request, seq: 48220
> > [1272349.614599] [skb_clone           ] ICMP: 169.254.128.15 ->
> > 172.27.0.6 ping request, seq: 48220
> > [1272349.614616] [nf_hook_slow        ] ICMP: 169.254.128.15 ->
> > 172.27.0.6 ping request, seq: 48220
> > [1272349.614629] [nft_do_chain        ] ICMP: 169.254.128.15 ->
> > 172.27.0.6 ping request, seq: 48220
> > [1272349.614635] [ip_rcv_finish       ] ICMP: 169.254.128.15 ->
> > 172.27.0.6 ping request, seq: 48220
> > [1272349.614643] [ip_route_input_slow ] ICMP: 169.254.128.15 ->
> > 172.27.0.6 ping request, seq: 48220
> > [1272349.614647] [fib_validate_source ] ICMP: 169.254.128.15 ->
> > 172.27.0.6 ping request, seq: 48220
> > [1272349.614652] [ip_local_deliver    ] ICMP: 169.254.128.15 ->
> > 172.27.0.6 ping request, seq: 48220
> > [1272349.614658] [nf_hook_slow        ] ICMP: 169.254.128.15 ->
> > 172.27.0.6 ping request, seq: 48220
> > [1272349.614663] [ip_local_deliver_finish] ICMP: 169.254.128.15 ->
> > 172.27.0.6 ping request, seq: 48220
> > [1272349.614666] [icmp_rcv            ] ICMP: 169.254.128.15 ->
> > 172.27.0.6 ping request, seq: 48220
> > [1272349.614671] [icmp_echo           ] ICMP: 169.254.128.15 ->
> > 172.27.0.6 ping request, seq: 48220
> > [1272349.614675] [icmp_reply          ] ICMP: 169.254.128.15 ->
> > 172.27.0.6 ping request, seq: 48220
> > [1272349.614715] [consume_skb         ] ICMP: 169.254.128.15 ->
> > 172.27.0.6 ping request, seq: 48220
> > [1272349.614722] [packet_rcv          ] ICMP: 169.254.128.15 ->
> > 172.27.0.6 ping request, seq: 48220
> > [1272349.614725] [consume_skb         ] ICMP: 169.254.128.15 ->
> > 172.27.0.6 ping request, seq: 48220
> >
> > For now, I have to create a bpf program for every kernel
> > function that I want to trace, which is up to 200.
> >
> > With this multi-link, I only need to create 5 bpf program,
> > like this:
> >
> > int BPF_PROG(trace_skb_1, struct *skb);
> > int BPF_PROG(trace_skb_2, u64 arg0, struct *skb);
> > int BPF_PROG(trace_skb_3, u64 arg0, u64 arg1, struct *skb);
> > int BPF_PROG(trace_skb_4, u64 arg0, u64 arg1, u64 arg2, struct *skb);
> > int BPF_PROG(trace_skb_5, u64 arg0, u64 arg1, u64 arg2, u64 arg3, struct *skb);
> >
> > Then, I can attach trace_skb_1 to all the kernel functions that
> > I want to trace and whose first arg is skb; attach trace_skb_2 to kernel
> > functions whose 2nd arg is skb, etc.
> >
> > Or, I can create only one bpf program and store the index
> > of skb to the attachment cookie, and attach this program to all
> > the kernel functions that I want to trace.
> >
> > This is my use case. With the multi-link, now I only have
> > 1 bpf program, 1 bpf link, 200 trampolines, instead of 200
> > bpf programs, 200 bpf link and 200 trampolines.
> 
> I see. The use case makes sense to me.
> Andrii's retsnoop is used to do similar thing before kprobe multi was
> introduced.
> 
> > The shared trampoline you mentioned seems to be a
> > wonderful idea, which can make the 200 trampolines
> > to one. Let me have a look, we create a trampoline and
> > record the max args count of all the target functions, let's
> > mark it as arg_count.
> >
> > During generating the trampoline, we assume that the
> > function args count is arg_count. During attaching, we
> > check the consistency of all the target functions, just like
> > what we do now.
> 
> For one trampoline to handle all attach points we might
> need some arch support, but we can start simple.
> Make btf_func_model with MAX_BPF_FUNC_REG_ARGS
> by calling btf_distill_func_proto() with func==NULL.
> And use that to build a trampoline.
> 
> The challenge is how to use minimal number of trampolines
> when bpf_progA is attached for func1, func2, func3
> and bpf_progB is attached to func3, func4, func5.
> We'd still need 3 trampolines:
> for func[12] to call bpf_progA,
> for func3 to call bpf_progA and bpf_progB,
> for func[45] to call bpf_progB.
> 
> Jiri was trying to solve it in the past. His slides from LPC:
> https://lpc.events/event/16/contributions/1350/attachments/1033/1983/plumbers.pdf
> 
> Pls study them and his prior patchsets to avoid stepping on the same rakes.

yep, I refrained from commenting not to take you down the same path
I did, but if you insist.. ;-) 

I managed to forgot almost all of it, but the IIRC the main pain point
was that at some point I had to split existing trampoline which caused
the whole trampolines management and error paths to become a mess

I tried to explain things in [1] changelog and the latest patchset is in [0]

feel free to use/take anything, but I advice strongly against it ;-)
please let me know if I can help

jirka


[0] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=bpf/batch
[1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=bpf/batch&id=52a1d4acdf55df41e99ca2cea51865e6821036ce

