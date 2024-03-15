Return-Path: <linux-kselftest+bounces-6340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FE387C986
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 09:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D7C3B2210C
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 08:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62D315AE0;
	Fri, 15 Mar 2024 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="E7E+Z+Ct"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F514A81
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Mar 2024 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710489669; cv=none; b=pyj+Emq1bDYvW5SaTHp4kzPKtnHophGyFPdplSLdqYyi6+g9Xkopq8kRaCp0JdNxO2AtMERO/cmPopEige7u7tx459MtJxENmtSas/Tb0pBwTHcn8H402NYdhGseV5pLay57R5RG7hkpf0ZTwoDyyY0IYUFHD8OAw8EC/7qEWwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710489669; c=relaxed/simple;
	bh=p0en/GCOfhc21UxAgSvgpjSxEaCkV+SmFKeaU1UDvXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8W0fnjXDa4OC2lKa9BybSq+FiWzqnjdgSLuCfPHMUi45IrO6QeTs5LGN8LKuwMVYaegLUpzNAUlukEOtamZCWhtbHiJb2GH/VKiSFln4ydjW9W4Y31nkNRE3z3IsiOWhJYnnCWYMj5Jf1FXU0My7QqmaZ6BLJIGYrWIVesIDLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=E7E+Z+Ct; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so1187546a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Mar 2024 01:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710489667; x=1711094467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0en/GCOfhc21UxAgSvgpjSxEaCkV+SmFKeaU1UDvXQ=;
        b=E7E+Z+CtWt8kqiIjYWVQjEQ5fj1jos1mIKKRspBALWmE5bpg83ESZX6Bn5hJBz/CmZ
         BeKAAir5/rFWNesxtwFWK3Tnr4Z6qZlWzPhhZ+rIubFMtMI34lAx+ZgY0GQ3VNMgN/Cz
         uUQnfNLDzXZfCF0vDa991O2bU8qGj7BgLVY2O33qRMVT4T6b4AM8SJwLVqqfXb8Y135U
         4J//tHDM2+xPpMs3PW0OVcpu6s7/9R1Z7RKt6G+SdFeJcklUqICdg9FgGcgKCFZAEXEI
         Tq25GM5Oyuk4eiAn2mh0YG9+mIj52I4qrzB+oPAKwBmu3R4t9GEa2Y9aKBvlNL2Idzkz
         jvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710489667; x=1711094467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0en/GCOfhc21UxAgSvgpjSxEaCkV+SmFKeaU1UDvXQ=;
        b=iCt7cAzMfmBq4V0XfgG1SvOy+CVJHuMQllSZZPpxodWxpAU7WGY4Zmc3GRTj8xZUaK
         NSj8n6yjTGeV/zBs+7QVNs0fxyMCIyvkyAoKyO5J9BIzJjDJMoPVbAJnGAEUdBrS4IOE
         hVwp9mg4SLx1Wlj2z2aNCkhDpEYHdUv+t2ngmA5Dw2Hji2PVTgT6/Z6iBH29iqVSpySu
         kQC7WsNiuyKpk0IvB8cHKGx/KdoJcu7DPy1PAY9bXX40upL3Hk89IeNWTkVfwgDfzchC
         /EpOgXWeADKYqtXG68LpAC4IS0n+fAbh7HHudRUo0iDTGS9h7zPRhHJd/xnp6vfrzRLr
         G9IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT5rMzp1MQFjyTrD75Bv4apvhb2EgrhdGqebL8oJQVFauERe1kL7wdZ7IJxffBiRX5KQ8yJVSLUj6XFdnXEZHpOaHyL/KwQqgxP9tfRXcQ
X-Gm-Message-State: AOJu0Yw6mHNWw4m3W6/Fs9H35sumGuAuS8+vQ1vkZwswBTj5vWdcNNm8
	be3rEYCp+8Hg9MP1oipt838G1vuue04jTYuHIkTV4XXOh+xvAU8Y9sbqBb1pADMla9RIyF8h/e3
	XY1tpSx4SBMMrWYnKqUiNqW9LI1lgot6xnFtJ7A==
X-Google-Smtp-Source: AGHT+IEpM9Mqa5iEhQbTXQByuieojUsSQiVC/HtuI16NWpRWnCf8v9wukRY0tmuiax6xN5WzRfxP5Mr9rKAT0G28iSY=
X-Received: by 2002:a17:90a:dc0b:b0:29d:fe1c:79e7 with SMTP id
 i11-20020a17090adc0b00b0029dfe1c79e7mr271232pjv.45.1710489666842; Fri, 15 Mar
 2024 01:01:06 -0700 (PDT)
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
 <CALz3k9g9k7fEwdTZVLhrmGoXp8CE47Q+83r-AZDXrzzuR+CjVA@mail.gmail.com> <CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com>
In-Reply-To: <CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Fri, 15 Mar 2024 16:00:55 +0800
Message-ID: <CALz3k9g-U8ih=ycJPRbyU9x_9cp00fNkU3PGQ6jP0WJ+=uKmqQ@mail.gmail.com>
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

On Thu, Mar 14, 2024 at 8:27=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Mar 12, 2024 at 6:53=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <dong=
menglong.8@bytedance.com> wrote:
[......]
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

I see. Creating plenty of trampolines does take a lot of time,
and I'll do testing on it.

>
> > >
> > > Let's step back.
[......]
>
> For one trampoline to handle all attach points we might
> need some arch support, but we can start simple.
> Make btf_func_model with MAX_BPF_FUNC_REG_ARGS
> by calling btf_distill_func_proto() with func=3D=3DNULL.
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
> https://lpc.events/event/16/contributions/1350/attachments/1033/1983/plum=
bers.pdf
>
> Pls study them and his prior patchsets to avoid stepping on the same rake=
s.

