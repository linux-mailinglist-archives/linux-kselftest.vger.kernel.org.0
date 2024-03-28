Return-Path: <linux-kselftest+bounces-6760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5B5890222
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 15:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A6F1F27212
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDC412BEAA;
	Thu, 28 Mar 2024 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Uj3GWBEf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63277D07D
	for <linux-kselftest@vger.kernel.org>; Thu, 28 Mar 2024 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636947; cv=none; b=NZFvhJCTiknpQkenUuIoOR5chrrB67MVeFZvD1/qSKUljjGKQZQuWHv8qfaBXYOr+9mHAVIexM6wKOl0Qzv/7L8w8iJ0dQqIhl9XgyenI9IoV6ZKr01UkHM6MpGmQ+hSuFkJf3xGWslKamEpxmbHpsk+oiZT8g6i+yoy1smHymU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636947; c=relaxed/simple;
	bh=Gc8satM/FTCQ1mZJea9kW64b0UoXxa5bHnts8j6XkdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzHmrZCLIfMaj3xEnxfgIA2bcXapm5pNG4mIM0BILQdj6FkonlyQfhVR1E9tSDrMWghBR5PK41fe5e27mkkYtH80wKyIrl90ng3LHQgggiwJ7vYxYilP9ppeCoA/0PdXZ4aXJudFc/82gEG+2PNGQ49KMn5ZutU7UXGfqxNUNkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Uj3GWBEf; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a209b8af12so396967a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Mar 2024 07:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711636945; x=1712241745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOp5govZZQSJRzD95rrhGtQGcUj+k1AZvhk4Bdb7Q3s=;
        b=Uj3GWBEfDEWNV6Q9ppTZHPzRDEPC9fxtMAqn1djsqbVx20F79rNmK5bgA+C8ycXzbU
         oEFFP/gogMOePAlDaU9sVoBoNebgesz3ut+o36ul5HOYBJMd8FDxSpMcBn1jKhPVMvtM
         DOdpDn/ex6muGP4REazyeb/Gp3+Vf6TU9sEauM9bIcCGDUYSn/p3IKSRnP+fMBS21t5i
         /qa1vZpEOYBTcSQHBpW+JtgJaF1zEFiESDT0I/7Bw21YTEoLdZ5ZsbLSsNzml8/LiCyi
         1le6TYrKh/3U7j84SubQtc6js3WFKAVLHZd+ZVJrYF1zJM3z31z5W0BC5+zFqi3Zp6l5
         1w2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711636945; x=1712241745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOp5govZZQSJRzD95rrhGtQGcUj+k1AZvhk4Bdb7Q3s=;
        b=IBfdja4xQWz7t53Ms6Brz7KdfDIG9ec0yHmc89SXhqYeP7OSUlpXHIojWHEhz46cgn
         KxRUT2y3x2BOnb3ZnW4Ne/RarHPKOuy2IJVThzO1TRic6ycnGXgaunztffujbeSA5aRk
         qzjbYWPDqJlqm1TeG0ARMZ7+SJzyRwvgd2YxBMYllVrOHKg+XlD+Mrcp7gB65hZlBPIq
         FyQ/y52r2JupwqwA7SbhIz4X91BqoWF6FrQUH/gdz2nLsIZazfvPPzarXV83bSTsUhwh
         U8LnfBkDBa4ygo0jKwn6l1dubMi8UnaDIUBu5ou4dAWgoJYv2T0IPnURjItMCzm8Bi3u
         foPg==
X-Forwarded-Encrypted: i=1; AJvYcCVnZ5XwtR0bJ4EtJ9Q4daGhzV3OL3JHmbCfqPpEnXFvCmVeaEJbObWQnxiqa1BQtbHKLPxTixwB4xq2X65BLMhssdtypWmLkk4LU50W/yTB
X-Gm-Message-State: AOJu0YynIn+WMuacr/jbAkmNFYCC9ou/hCV86Ti9+0OtJpHYvzB27Ahd
	2f0cDJtTqScRniNte/Ub31UqiJmWK4NIcQCKB6xDFcViE4HwjAVNlW1k0lLaqyORd+HYgkbDpgV
	n/pFB6HbUekOkmpQSwoBa4Z1XShh5YdXdfUEu+w==
X-Google-Smtp-Source: AGHT+IHIvCiL9/viH3Zv87RhUz8r9B/nNMpWCgwAx/ZU6AQHkrpwzseaugUZlw+S2sSjSOL/j/AgVGUngrHrFzkoTBM=
X-Received: by 2002:a17:90a:d481:b0:2a2:88d:19d9 with SMTP id
 s1-20020a17090ad48100b002a2088d19d9mr1331992pju.1.1711636945073; Thu, 28 Mar
 2024 07:42:25 -0700 (PDT)
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
 <CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com> <CALz3k9g-U8ih=ycJPRbyU9x_9cp00fNkU3PGQ6jP0WJ+=uKmqQ@mail.gmail.com>
In-Reply-To: <CALz3k9g-U8ih=ycJPRbyU9x_9cp00fNkU3PGQ6jP0WJ+=uKmqQ@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Thu, 28 Mar 2024 22:43:46 +0800
Message-ID: <CALz3k9jG5Jrqw=BGjt05yMkEF-1u909GbBYrV-02W0dQtm6KQQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support
 to record and check the accessed args
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <jolsa@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
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

On Fri, Mar 15, 2024 at 4:00=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <dongme=
nglong.8@bytedance.com> wrote:
>
> On Thu, Mar 14, 2024 at 8:27=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Mar 12, 2024 at 6:53=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <do=
ngmenglong.8@bytedance.com> wrote:
> [......]
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
>
> I see. Creating plenty of trampolines does take a lot of time,
> and I'll do testing on it.
>

I have done a simple benchmark on creating 1000
trampolines. It is slow, quite slow, which consume up to
60s. We can't do it this way.

Now, I have a bad idea. How about we introduce
a "dynamic trampoline"? The basic logic of it can be:

"""
save regs
bpfs =3D trampoline_lookup_ip(ip)
fentry =3D bpfs->fentries
while fentry:
  fentry(ctx)
  fentry =3D fentry->next

call origin
save return value

fexit =3D bpfs->fexits
while fexit:
  fexit(ctx)
  fexit =3D fexit->next

xxxxxx
"""

And we lookup the "bpfs" by the function ip in a hash map
in trampoline_lookup_ip. The type of "bpfs" is:

struct bpf_array {
  struct bpf_prog *fentries;
 struct bpf_prog *fexits;
  struct bpf_prog *modify_returns;
}

When we need to attach the bpf progA to function A/B/C,
we only need to create the bpf_arrayA, bpf_arrayB, bpf_arrayC
and add the progA to them, and insert them to the hash map
"direct_call_bpfs", and attach the "dynamic trampoline" to
A/B/C. If bpf_arrayA exist, just add progA to the tail of
bpf_arrayA->fentries. When we need to attach progB to
B/C, just add progB to bpf_arrayB->fentries and
bpf_arrayB->fentries.

Compared to the trampoline, extra overhead is introduced
by the hash lookuping.

I have not begun to code yet, and I am not sure the overhead is
acceptable. Considering that we also need to do hash lookup
by the function in kprobe_multi, maybe the overhead is
acceptable?

Thanks!
Menglong Dong

> >
> > > >
> > > > Let's step back.
> [......]
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

