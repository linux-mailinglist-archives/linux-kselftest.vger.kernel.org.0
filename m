Return-Path: <linux-kselftest+bounces-34969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F25AAD9840
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 00:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693733BB17A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 22:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4287528D8F5;
	Fri, 13 Jun 2025 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0MMfQ9L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A9223814C;
	Fri, 13 Jun 2025 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749854172; cv=none; b=tbwGRjLunBM+irSwTSWAtqUzhJfvjVlUD9qIkY189vZ/I2P079zW5jaYic7HWs1d+B0xkNxUG4Nfw7a9kjSJ3b7cFZk3xMSzxOAsAEjgtlJHrHNqEvxozu07FAV3CxNP1KuNXbfEDO+yrOMDzmmKxsoCyqHs5k7g1rReKdHUqE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749854172; c=relaxed/simple;
	bh=ZDhN0PQzQ9wgEHlw7OXTzGjuQH3XOnQA5xq1WBIqnek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/sp72YL0BJbPMytT+pI1ho62UuE4i9Do923g1q7FvJW9gbIOPwG/c9mh3nTpUiwCTpkonNtBEyejikBLd+s3vw13gC4LIJF6EB/LpBx6M+wM5q8Nci/vfLJofi7dY2ly5lOR9iS7GRB0kXk6m4rGcY0xobBRVuwM8MfyhqRjWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0MMfQ9L; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so2243830f8f.3;
        Fri, 13 Jun 2025 15:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749854169; x=1750458969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDhN0PQzQ9wgEHlw7OXTzGjuQH3XOnQA5xq1WBIqnek=;
        b=V0MMfQ9LnVFjKTXF/j9wodh39meUoxLTRuYmqR6UlVLco4MCSPFkyZ3TVgdbc03eYA
         3yLlwoGSG8T4HnLNgLKGfhQmKhx/l8jvCN44pZddh1c66IhJH1mpigG5C2Rl2vYo3SkP
         naMo0QZn/e4SHNMPnJmhf8taujDmwIM6EAJU6rMmOH1NsbjUVuf1dexFHDZvksmOrXf6
         T9hBS2h32S+1atZsl91SDUhqF3R93ohXZkld4EjaIxb4gTaTfbLMBK/IoBLUJpRMCGJo
         RL3uZXsh7n7njkZyWbpNqa7Kk/bdp1R655+0koEKH6yziNKQMpoiBKcfha2Apt23VLTA
         FtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749854169; x=1750458969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDhN0PQzQ9wgEHlw7OXTzGjuQH3XOnQA5xq1WBIqnek=;
        b=DP4LeCxipuEqfRH/A2U6e54gykEjP3H8WEMNZ2815004YhU+gJAM75Ep86mc6cwu0U
         sU0lWog3PIuRrhr87ACxCbJu7XbTX2LBbY4voVmOssDG5FOI4w6VINVtXwyTFBv3Kj5v
         68MbKplggEERqahkd5FDqvUvjyjurLaJrkrQs8bI3Ncwcv65x8A8wlSrknk+tjYXzy95
         o6H4I54gLkz2BJRvbBElZpQmog6M9fgU7OD5TfQGoBl8hDmJWCXV8Y1CEp/tCtqTOWE3
         DPpZH0WyhmNp80DpS9/yw/eq2nIAlSc39UAiju6m2uYHUPJGOUjNCtwwxlUAX2OFf5i3
         ee+A==
X-Forwarded-Encrypted: i=1; AJvYcCUoYtPXQA1uonZ073rI2MQTnx7vh8vbs0CZCRSym1QzwDQuv6NwLIXJ0+NeznFNyNSH1+50HKyNLXsQfKs8@vger.kernel.org, AJvYcCVjXZP1T8WApTDB6z5tsMrbFQK12GdZtuo4tF1USUF5uaYuXR2eAKSRCFplpm43sH0Xqz7FFrSh@vger.kernel.org, AJvYcCVvlhQTmGOtxaZxoUYXhwk+c+TEffvp7aCFl3iix3+LUllcrwP/LyWhXfdwAg6fqLDx6b6w1Vo/TNxhbg==@vger.kernel.org, AJvYcCW3aYg3AI9cYfEnKrLIjIa4yyUWU8gi3edaUgLhE+ZyKNzma1VxhqXyt2J6oLyQkokz4pnutWegtkcPiswZSOPV@vger.kernel.org, AJvYcCXujocvSLLDKiMDLrc+W8B812qxkbpNvwDvihIZpAXdUL6+MoYyRv1ApO9qe+KFQ2hLtv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeBjcDMLiKMO1E2tsO4XxqMmBq8cy2hRZqk9/D8n8ENQ6nHbp2
	tMBJ2GlIYAB4j6mYC5V+xcZTAID5mBkkV3ZElSkKV8xouQ8Vg2hXJkZE7sFdIj/9a4cKURft0HI
	nlXc/yCSSeQNS2chc7tmRzkuIoAKmPC0=
X-Gm-Gg: ASbGncvQSz/Iq49Vxr/l0p1voHBV7BElZxSaGoeGsxsXfe4RwBsu5iI/OnOZ9Q1f/Vw
	+OoJABUOAz43h3Ow0Hnutijz3BbX8PzfCduLtMxZupYAeLY3vmEUTY5cqvdMlWD4OZA5JYaf3Bx
	V15Ez1gewM9qaYhaTTbkZatLJ7ukp6Ac/XZSBrNLRVOntN6oWqJOzHP3fSwhqNGe8apV5nJ05y
X-Google-Smtp-Source: AGHT+IGvAZU4d5tXw0nhgWlSwGRKFbuaQhR8GZiHa22TV57O0MRl7T0f9v9YaYzOJredMJW3TgBMxueem5pPB3YsBNg=
X-Received: by 2002:a05:6000:40dd:b0:3a5:2694:d75f with SMTP id
 ffacd0b85a97d-3a572e895fbmr1535518f8f.52.1749854168416; Fri, 13 Jun 2025
 15:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613-deny_trampoline_structs_on_stack-v1-0-5be9211768c3@bootlin.com>
 <20250613-deny_trampoline_structs_on_stack-v1-2-5be9211768c3@bootlin.com>
 <20250613081150.GJ2273038@noisy.programming.kicks-ass.net>
 <DAL9GRMH74F4.2IV0HN0NGU65X@bootlin.com> <20250613083232.GL2273038@noisy.programming.kicks-ass.net>
 <DALA5WYA04OG.1283TZDOVLBPS@bootlin.com>
In-Reply-To: <DALA5WYA04OG.1283TZDOVLBPS@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Jun 2025 15:35:57 -0700
X-Gm-Features: AX0GCFvxnM-s8AungljiWEt_LCtzKmPe0DGMu2VqQrNsxFmjrZ6Pec_NoZEOn-E
Message-ID: <CAADnVQ+sj9XhscN9PdmTzjVa7Eif21noAUH3y1K6x5bWcL-5pg@mail.gmail.com>
Subject: Re: [PATCH bpf 2/7] bpf/x86: prevent trampoline attachment when args
 location on stack is uncertain
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Menglong Dong <imagedong@tencent.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	ppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 1:59=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> On Fri Jun 13, 2025 at 10:32 AM CEST, Peter Zijlstra wrote:
> > On Fri, Jun 13, 2025 at 10:26:37AM +0200, Alexis Lothor=C3=A9 wrote:
> >> Hi Peter,
> >>
> >> On Fri Jun 13, 2025 at 10:11 AM CEST, Peter Zijlstra wrote:
> >> > On Fri, Jun 13, 2025 at 09:37:11AM +0200, Alexis Lothor=C3=A9 (eBPF =
Foundation) wrote:
>
> [...]
>
> >> Maybe my commit wording is not precise enough, but indeed, there's not
> >> doubt about whether the struct value is passed on the stack or through=
 a
> >> register/a pair of registers. The doubt is rather about the struct loc=
ation
> >> when it is passed _by value_ and _on the stack_: the ABI indeed clearl=
y
> >> states that "Structures and unions assume the alignment of their most
> >> strictly aligned component" (p.13), but this rule is "silently broken"=
 when
> >> a struct has an __attribute__((packed)) or and __attribute__((aligned(=
X))),
> >> and AFAICT this case can not be detected at runtime with current BTF i=
nfo.
> >
> > Ah, okay. So it is a failure of BTF. That was indeed not clear.
>
> If I need to respin, I'll rewrite the commit message to include the detai=
ls
> above.

No need to respin. The cover letter is quite detailed already.

But looking at the patch and this thread I think we need to agree
on the long term approach to BTF, since people assume that
it's a more compact dwarf and any missing information
should be added to it.
Like in this case special alignment case and packed attributes
are not expressed in BTF and I believe they should not be.
BTF is not a debug format and not a substitute for dwarf.
There is no goal to express everything possible in C.
It's minimal, because BTF is _practical_ description of
types and data present in the kernel.
I don't think the special case of packing and alignment exists
in the kernel today, so the current format is sufficient.
It doesn't miss anything.
I think we made arm64 JIT unnecessary restrictive and now considering
to make all other JITs restrictive too for hypothetical case
of some future kernel functions.
I feel we're going in the wrong direction.
Instead we should teach pahole to sanitize BTF where functions
are using this fancy alignment and packed structs.
pahole can see it in dwarf and can skip emitting BTF for such
functions. Then the kernel JITs on all architectures won't even
see such cases.

The issue was initially discovered by a selftest:
https://lore.kernel.org/bpf/20250411-many_args_arm64-v1-3-0a32fe72339e@boot=
lin.com/
that attempted to support these two types:
+struct bpf_testmod_struct_arg_4 {
+ __u64 a;
+ __u64 b;
+};
+
+struct bpf_testmod_struct_arg_5 {
+ __int128 a;
+};

The former is present in the kernel. It's more or less sockptr_t,
and people want to access it for observability in tracing.
The latter doesn't exist in the kernel and we cannot represent
it properly in BTF without losing alignment.

So I think we should go back to that series:
https://lore.kernel.org/bpf/20250411-many_args_arm64-v1-0-0a32fe72339e@boot=
lin.com/

remove __int128 selftest, but also teach pahole
to recognize types that cannot be represented in BTF and
don't emit them either into vmlinux or in kernel module
(like in this case it was bpf_testmod.ko)
I think that would be a better path forward aligned
with the long term goal of BTF.

And before people ask... pahole is a trusted component of the build
system. We trust it just as we trust gcc, clang, linker, objtool.

