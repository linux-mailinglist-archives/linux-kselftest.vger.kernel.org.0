Return-Path: <linux-kselftest+bounces-35024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB321ADA272
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 17:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAACE188E540
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF5027A933;
	Sun, 15 Jun 2025 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA10Xkxz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE6917BCE;
	Sun, 15 Jun 2025 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750002281; cv=none; b=jdinFbuTZpfmAm137QtlK65dtnUYbRcIiwstV2+fPmh6EAWRaR98ae7myZtdFzukjqoQ0R6YElPNwK8b9Kw00gLgtFklZHEXdLf7jBrOGcOowcWTGHDdrMN2rY4y9+PABKfgV/nWeSalud3cgi4B9n5c58EeSwD1yNAeWC/PsV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750002281; c=relaxed/simple;
	bh=pWRdTeTn/1OegzG4ltWn5U5SgZqMCMMLHaPU9vAtyKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibYPepd5YRBXbIcTWpFIMClurkbJao5ZfAm/ZvbziOeH5JlIe4a7azICptpuwFUx9ya0lmmgAcrc6i7Wv78ueSda9gA2kksXbCZi/uMyEeGLp9p5Cu202/BWzN8JKevZuUzKctibGizBuNOE2r0lpPybvSI/cD8+iefcf6g8ma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dA10Xkxz; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a53359dea5so2437508f8f.0;
        Sun, 15 Jun 2025 08:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750002275; x=1750607075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q24V+OwPQTKaIgjR+NjdUiOeSoG4NNmYTDA2NhEIjAI=;
        b=dA10XkxzSI/fHK2luyIGGkG5SXbzX3TwJIiqgInP3v9mHgZxVn12OUeGPFaUBgvJr2
         OyNOGYYh6JofO1+9Sevl/6F/vmn4RetkQG0F88RTgImmPcCMN/EYPyxX2opJN3HMUbhM
         5LFmqqckPGtBtIB/a9bvjEGEAOP90OjrcM0/HeIZk6x/BxxVtZ3XuPJ5pwXGhgl/P1c1
         ofxhNqIN5xBmGOE5LhYHa9z2w1MTyF4o2JX+7ucQVa00wvvMtHOzO/U7lIYESLfBeiAI
         jkuoLniSOEcDjhQgeu7u8dynaKXxf4ovotMb1bzZzTbUycbGmUXv+cQzB/iH686UAK9U
         v95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750002275; x=1750607075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q24V+OwPQTKaIgjR+NjdUiOeSoG4NNmYTDA2NhEIjAI=;
        b=nxOElu68sjHS40dc0nmGHT7fzU4U5wY0Ye5M9KPtsSBAkueENBCVbRhYkr3QDyM6gF
         ADWgUa22R1xAhxvT8Dxk+NFVIycme30ECD52v7BmZeRXLbKSRgpTdr37pFS5q/4/D9Q0
         Iit5KjRBbI3MVvvDK8VbgGbfL3zD2TEA6RTybM41ty7k5T8JfmLMVd2/w3m7DY6CNzXM
         FzMMIbDy4bUV+nJGIe/pQ+NncrCWGxBH4Mjkpd6GD2qVBNxcjwlUFSWiLScvEzfcXrqC
         +0rzSWqiAkhg+Vl52mOaFVkzul+1+6nAVqCZAYjSbGnR2pFWwYuGUf0UYqoM71ts88fN
         DQ9A==
X-Forwarded-Encrypted: i=1; AJvYcCUqF+sH0BVxoSz1a3XFrl7qQL4akjOoZbMWdGX/Ddq4j5LDUoM+PzuQKWayyfGC0T0I2S3OYRZci8r4TxXC9rGK@vger.kernel.org, AJvYcCUqTjPyRE+TK/FFK3GKhL344S/4sVWMkUmxSYAvlD3GSg0MZ475BaEVtqIauLFWyW4zk8M=@vger.kernel.org, AJvYcCVSX+jCxW2UyvH4mz3DNSDOFe2W/GhcncI+1b1LWaI2oRrsbhiomGHFHeomsYOW9tmebjO0rEyrIqZbTn6U@vger.kernel.org, AJvYcCWGDN9btWAiDc5xwf1tmQCFkCnnX8osaIN/5FecQvSrdJslsmQgXNI9Tewfx5/croosdz25RBxj@vger.kernel.org, AJvYcCX51SRTh1eye9qHU7BL16tUYjXHfIqix8+IrbPmtvEoP3Ckq1oEsj3kR+TJ8EDhP1wGsPUzmLrjV1wo4A==@vger.kernel.org, AJvYcCXeNAne4/qEsjvjCFZ9+iR959uOeP2EHJ98nAdoJ4vKuv5ny3y1xdHu4aZY7efxyQnb8Rb2Ujx/vg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0/I+xzvokvfS1a2EgdZAcsURvXoH7dylCRxL9wVaQNd1Ma2Ta
	fOTO0dQQWzGmoUCcXQBAqQQpC5Ut6cF/SMsNcOP98LvmDN1O0lXPFSezanFYHJGM66xmoeg5vBn
	sOjj5cscxFpQ9eTvpJzm3XeDrJsjVYng=
X-Gm-Gg: ASbGncvJxNgTmeazZsqW/ffCmJ/xCW32eyB1/lstN3sq5HKdIZLyIPSRQ4CCtfxiV3w
	TIyBjWD2nhstLSyccafZk/4zCbXzAT7/6k0odhzwp1OGE1NjW9jvPAZRlvDvJSHn9sVP9QlKtZi
	bPthxsaoAp5qYHhtDrv9dEmAW+PM2bj7VgFPWXxtFkRgypmtrbKyGb4A==
X-Google-Smtp-Source: AGHT+IEVMqrf36wFDwIu+Qav+T1hxhMtiOfYIpsqMlJITLohO7pPVX7dQmL5OFhL7NsYv2qBiULo8wqoJRikRf0wek4=
X-Received: by 2002:a05:6000:718:b0:3a5:3b63:58f0 with SMTP id
 ffacd0b85a97d-3a57237178dmr4884718f8f.18.1750002274959; Sun, 15 Jun 2025
 08:44:34 -0700 (PDT)
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
 <DALA5WYA04OG.1283TZDOVLBPS@bootlin.com> <CAADnVQ+sj9XhscN9PdmTzjVa7Eif21noAUH3y1K6x5bWcL-5pg@mail.gmail.com>
 <DAN5THWRO6KS.XXZ00IOTQZH9@bootlin.com>
In-Reply-To: <DAN5THWRO6KS.XXZ00IOTQZH9@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 15 Jun 2025 08:44:23 -0700
X-Gm-Features: AX0GCFum0GptEjJNe1zyPyz2oALA4PaNl_E8ueRtmTM4_c9kw_4GcQiqb2A1p90
Message-ID: <CAADnVQJPQNC5VaybR_GZry5YZhNcJmWSSouuTSsU1XKhDfXYwQ@mail.gmail.com>
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
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, dwarves <dwarves@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 7:00=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> On Sat Jun 14, 2025 at 12:35 AM CEST, Alexei Starovoitov wrote:
> > On Fri, Jun 13, 2025 at 1:59=E2=80=AFAM Alexis Lothor=C3=A9
> > <alexis.lothore@bootlin.com> wrote:
> >>
> >> On Fri Jun 13, 2025 at 10:32 AM CEST, Peter Zijlstra wrote:
> >> > On Fri, Jun 13, 2025 at 10:26:37AM +0200, Alexis Lothor=C3=A9 wrote:
>
> [...]
>
> >> If I need to respin, I'll rewrite the commit message to include the de=
tails
> >> above.
> >
> > No need to respin. The cover letter is quite detailed already.
> >
> > But looking at the patch and this thread I think we need to agree
> > on the long term approach to BTF, since people assume that
> > it's a more compact dwarf and any missing information
> > should be added to it.
> > Like in this case special alignment case and packed attributes
> > are not expressed in BTF and I believe they should not be.
> > BTF is not a debug format and not a substitute for dwarf.
> > There is no goal to express everything possible in C.
> > It's minimal, because BTF is _practical_ description of
> > types and data present in the kernel.
> > I don't think the special case of packing and alignment exists
> > in the kernel today, so the current format is sufficient.
> > It doesn't miss anything.
> > I think we made arm64 JIT unnecessary restrictive and now considering
> > to make all other JITs restrictive too for hypothetical case
> > of some future kernel functions.
> > I feel we're going in the wrong direction.
> > Instead we should teach pahole to sanitize BTF where functions
> > are using this fancy alignment and packed structs.
> > pahole can see it in dwarf and can skip emitting BTF for such
> > functions. Then the kernel JITs on all architectures won't even
> > see such cases.
> >
> > The issue was initially discovered by a selftest:
> > https://lore.kernel.org/bpf/20250411-many_args_arm64-v1-3-0a32fe72339e@=
bootlin.com/
> > that attempted to support these two types:
> > +struct bpf_testmod_struct_arg_4 {
> > + __u64 a;
> > + __u64 b;
> > +};
> > +
> > +struct bpf_testmod_struct_arg_5 {
> > + __int128 a;
> > +};
> >
> > The former is present in the kernel. It's more or less sockptr_t,
> > and people want to access it for observability in tracing.
> > The latter doesn't exist in the kernel and we cannot represent
> > it properly in BTF without losing alignment.
> >
> > So I think we should go back to that series:
> > https://lore.kernel.org/bpf/20250411-many_args_arm64-v1-0-0a32fe72339e@=
bootlin.com/
> >
> > remove __int128 selftest, but also teach pahole
> > to recognize types that cannot be represented in BTF and
> > don't emit them either into vmlinux or in kernel module
> > (like in this case it was bpf_testmod.ko)
> > I think that would be a better path forward aligned
> > with the long term goal of BTF.
> >
> > And before people ask... pahole is a trusted component of the build
> > system. We trust it just as we trust gcc, clang, linker, objtool.
>
> So if I understand correctly your point, it would be better to just move =
out
> those constraints from the JIT compilers, and just not represent those sp=
ecial
> cases in BTF, so that it becomes impossible to hook programs on those fun=
ctions,
> since they are not event present in BTF info.
> And so:
> - cancel this series
> - revert the small ARM64 check about struct passed on stack
> - update pahole to make sure that it does not encode info about this spec=
ific
>   kind of functions.

yes

> I still expect some challenges with this. AFAIU pahole uses DWARF to gene=
rate
> BTF, and discussions in [1] highlighted the fact that the attributes alte=
ring
> the structs alignment are not reliably encoded in DWARF. Maybe pahole can
> "guess" if a struct has been altered, by doing something like
> btf_is_struct_packed in libbpf ? As Andrii mentioned in [2], it may not b=
e
> able to cover all cases, but that could  be a start. If that's indeed the
> desired direction, I can take a further look at this.

so be it. If syzbot was taught to fuzz dwarf I'm sure it would
have exposed hundreds of bugs in the format itself and compilers,
but since such convoluted constructs are not present in the kernel
source code it's not a concern.

