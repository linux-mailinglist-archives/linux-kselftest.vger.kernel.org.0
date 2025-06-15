Return-Path: <linux-kselftest+bounces-35023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2D1ADA1FF
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 16:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B2718908A0
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 14:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FCC26AA82;
	Sun, 15 Jun 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A7TiUfOZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A33A1BA;
	Sun, 15 Jun 2025 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749996050; cv=none; b=RwXPbOBOndyo1bOT6Gx6Rdrd/Lx5lxwb1DQCae+A7KIqa/deBIrfw6HEn/10iYuN5YQZE4I1aa+UNdRmxr9puVh8RGMJEctZbTOazfhxYPlchC3NVpyuNXJ+kqy3pQUdTHcpCjuTa22DcT2MpsCPQXJZF0wBxilpXmIpOLKn46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749996050; c=relaxed/simple;
	bh=tzBgEfNbszZFjneQrhgK2sYcgixJ885U9DAEQALxusE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kSzcFHteaYoeGMavDklN0+PjIXX1jeftU40ZsklZ7btepxqWgq13OV/JUahTXFq2asRrWbRLMXxCsLFTj8U5ZdC7cfNN/GKiLKQdguoj0heH0eYSSjGoW6yWz5b8CAoBl/BNvszvnlcS4mqHfMD1BU7jruJMFZUDDs1CR+GiQPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A7TiUfOZ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7A6B205B1;
	Sun, 15 Jun 2025 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749996037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YxXS5lj0DrF49L/g0V9R5FkVyXH9S7gR1QjB4hu3uuE=;
	b=A7TiUfOZSoNCNlpd3feyEIMq7JweNSA26Ki+asH1Rd/WvFZi6wU8mGFvLOiyagoFjwL8JL
	xo9M58/kDnjnSORKMzRqxzrCLgPAGB8Bu5MzN3EMIYoY6aN+6oHKGrYFTIO3qN/Pw67h/B
	IMc2jyqqF5WnGXYgwIPTBVuwK7QfL9I9ZUJ6sI7veC8g4rtStWZ/IVP4WS757EaSs2cq3B
	2xNCG4rBNC84HJC/1B3ddFVbvd1E5riocXBoJdq4moXdkt4MuVYmrwo0+OjTp/wdmH6h4R
	eSQhByt4F2xarijNXWHhMAAbmtcVLzvls0lGIxnTZz73uWzR5oqhqzM6rTospw==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Jun 2025 16:00:30 +0200
Message-Id: <DAN5THWRO6KS.XXZ00IOTQZH9@bootlin.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, "David Ahern"
 <dsahern@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar"
 <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "X86 ML" <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Menglong Dong" <imagedong@tencent.com>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, "Pu Lehui"
 <pulehui@huawei.com>, "Puranjay Mohan" <puranjay@kernel.org>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Ilya Leoshkevich" <iii@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>, "Hari
 Bathini" <hbathini@linux.ibm.com>, "Christophe Leroy"
 <christophe.leroy@csgroup.eu>, "Naveen N Rao" <naveen@kernel.org>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman"
 <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>, "Mykola
 Lysenko" <mykolal@fb.com>, "Shuah Khan" <shuah@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, <ebpf@linuxfoundation.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Network Development"
 <netdev@vger.kernel.org>, "bpf" <bpf@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?=
 <bjorn@rivosinc.com>, "linux-riscv" <linux-riscv@lists.infradead.org>,
 "linux-s390" <linux-s390@vger.kernel.org>, "ppc-dev"
 <linuxppc-dev@lists.ozlabs.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel"
 <linux-arm-kernel@lists.infradead.org>, "dwarves" <dwarves@vger.kernel.org>
Subject: Re: [PATCH bpf 2/7] bpf/x86: prevent trampoline attachment when
 args location on stack is uncertain
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250613-deny_trampoline_structs_on_stack-v1-0-5be9211768c3@bootlin.com> <20250613-deny_trampoline_structs_on_stack-v1-2-5be9211768c3@bootlin.com> <20250613081150.GJ2273038@noisy.programming.kicks-ass.net> <DAL9GRMH74F4.2IV0HN0NGU65X@bootlin.com> <20250613083232.GL2273038@noisy.programming.kicks-ass.net> <DALA5WYA04OG.1283TZDOVLBPS@bootlin.com> <CAADnVQ+sj9XhscN9PdmTzjVa7Eif21noAUH3y1K6x5bWcL-5pg@mail.gmail.com>
In-Reply-To: <CAADnVQ+sj9XhscN9PdmTzjVa7Eif21noAUH3y1K6x5bWcL-5pg@mail.gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvfeekkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepteekleehffevvedvudfhueelffeugfdtveefvdfguefgffehtdekleetheelleffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemsgehvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmegshegvpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepiedtpdhrtghpthhtoheprghlvgigvghirdhsthgrrhhovhhoihhtohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgso
 higrdhnvghtpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: alexis.lothore@bootlin.com

On Sat Jun 14, 2025 at 12:35 AM CEST, Alexei Starovoitov wrote:
> On Fri, Jun 13, 2025 at 1:59=E2=80=AFAM Alexis Lothor=C3=A9
> <alexis.lothore@bootlin.com> wrote:
>>
>> On Fri Jun 13, 2025 at 10:32 AM CEST, Peter Zijlstra wrote:
>> > On Fri, Jun 13, 2025 at 10:26:37AM +0200, Alexis Lothor=C3=A9 wrote:

[...]

>> If I need to respin, I'll rewrite the commit message to include the deta=
ils
>> above.
>
> No need to respin. The cover letter is quite detailed already.
>
> But looking at the patch and this thread I think we need to agree
> on the long term approach to BTF, since people assume that
> it's a more compact dwarf and any missing information
> should be added to it.
> Like in this case special alignment case and packed attributes
> are not expressed in BTF and I believe they should not be.
> BTF is not a debug format and not a substitute for dwarf.
> There is no goal to express everything possible in C.
> It's minimal, because BTF is _practical_ description of
> types and data present in the kernel.
> I don't think the special case of packing and alignment exists
> in the kernel today, so the current format is sufficient.
> It doesn't miss anything.
> I think we made arm64 JIT unnecessary restrictive and now considering
> to make all other JITs restrictive too for hypothetical case
> of some future kernel functions.
> I feel we're going in the wrong direction.
> Instead we should teach pahole to sanitize BTF where functions
> are using this fancy alignment and packed structs.
> pahole can see it in dwarf and can skip emitting BTF for such
> functions. Then the kernel JITs on all architectures won't even
> see such cases.
>
> The issue was initially discovered by a selftest:
> https://lore.kernel.org/bpf/20250411-many_args_arm64-v1-3-0a32fe72339e@bo=
otlin.com/
> that attempted to support these two types:
> +struct bpf_testmod_struct_arg_4 {
> + __u64 a;
> + __u64 b;
> +};
> +
> +struct bpf_testmod_struct_arg_5 {
> + __int128 a;
> +};
>
> The former is present in the kernel. It's more or less sockptr_t,
> and people want to access it for observability in tracing.
> The latter doesn't exist in the kernel and we cannot represent
> it properly in BTF without losing alignment.
>
> So I think we should go back to that series:
> https://lore.kernel.org/bpf/20250411-many_args_arm64-v1-0-0a32fe72339e@bo=
otlin.com/
>
> remove __int128 selftest, but also teach pahole
> to recognize types that cannot be represented in BTF and
> don't emit them either into vmlinux or in kernel module
> (like in this case it was bpf_testmod.ko)
> I think that would be a better path forward aligned
> with the long term goal of BTF.
>
> And before people ask... pahole is a trusted component of the build
> system. We trust it just as we trust gcc, clang, linker, objtool.

So if I understand correctly your point, it would be better to just move ou=
t
those constraints from the JIT compilers, and just not represent those spec=
ial
cases in BTF, so that it becomes impossible to hook programs on those funct=
ions,
since they are not event present in BTF info.
And so:
- cancel this series
- revert the small ARM64 check about struct passed on stack
- update pahole to make sure that it does not encode info about this specif=
ic
  kind of functions.

I still expect some challenges with this. AFAIU pahole uses DWARF to genera=
te
BTF, and discussions in [1] highlighted the fact that the attributes alteri=
ng
the structs alignment are not reliably encoded in DWARF. Maybe pahole can
"guess" if a struct has been altered, by doing something like
btf_is_struct_packed in libbpf ? As Andrii mentioned in [2], it may not be
able to cover all cases, but that could  be a start. If that's indeed the
desired direction, I can take a further look at this.

+ CC dwarves ML

Alexis

[1] https://lore.kernel.org/bpf/9a2ba0ad-b34d-42f8-89a6-d9a44f007bdc@linux.=
dev/
[2] https://lore.kernel.org/bpf/CAEf4BzZHMYyGDZ4c4eNXG7Fm=3DecxCCbKhKbQTbCj=
vWmKtdwvBw@mail.gmail.com/


