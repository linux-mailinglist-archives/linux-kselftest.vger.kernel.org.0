Return-Path: <linux-kselftest+bounces-37408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF964B06F21
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 09:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD22503C2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 07:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574B328C5AB;
	Wed, 16 Jul 2025 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hK4Bw9jR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB7D277C96;
	Wed, 16 Jul 2025 07:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651491; cv=none; b=nmSRc6BaRxaMZkDYlDZFw1s025IPTwPDnFXOPz4w1ZbmY8Hfy7pLycBPacihVCb28lSddQs3+3h89f5mj7b77T7LKNdCnYPzbJfA3ogFp9SGoTVxBgcyRc9sg1u9wTcRSnJv9L6PPEo/R3jO64OcsD22BbfPLsFKmWg8KGNrqUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651491; c=relaxed/simple;
	bh=H1UPlPEJREKcCU4RNh+fzA9yvu8XBt8zMrtL+6tBB84=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=h8Pkg86LbYeZHpaNEfr1ddswCQBfTLjUUhJlxi00r7wb43uF6y6FGw9j8Xm6zYtln6w8yhf/A+JVuGT1fYoCwQCGFmgUxomcopxMe7EJEUjUxpKMfk+8C4NEhhM9ZLE0do3EdrMJeBXmV4n4ZHr9rFrVv3pSLi1goBT1OqpOAcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hK4Bw9jR; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 525E1444FC;
	Wed, 16 Jul 2025 07:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752651481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOqyrEbThUNu8kjTdwYn5QaXe7g+9MiXUqx8MLf4IGE=;
	b=hK4Bw9jRab/6Cok5R5487qjPcLp0nbakwx4NSy24zxfV/91Rhu8aVKvFIXXiTcoS6bBLgI
	jhDMkJbcEvaGsA5dojIPFtavKMWASnsdwGoTR7z7RtGCtF6yH8vkG3B4PHp0vNcKO67cqW
	mr97hFp1KdYsxF6YS6IhPSV7YnIMqhruGQCj1p8cREYw1a3c2I3/1GzYzh6W8jWB8Mc5Hr
	kkXUgWKMDSdiOBQqiin/iBNIe91TGzvDQP1voXbxPYBF2rtLgeufyYRIxBhfPsx//1mKuK
	YyGXecYfTJah/5AL2Mhic946zySddzeg4EJPVTbCrWAhj7QDr+hmmFYuNq0qIg==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 09:37:59 +0200
Message-Id: <DBDB3I5H4PW1.39J6V9NEXG2LI@bootlin.com>
Subject: Re: [PATCH 1/2] bpf, arm64: remove structs on stack constraint
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Puranjay Mohan"
 <puranjay@kernel.org>, "Xu Kuohai" <xukuohai@huaweicloud.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Mykola Lysenko" <mykolal@fb.com>,
 "Shuah Khan" <shuah@kernel.org>, <ebpf@linuxfoundation.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 "bpf" <bpf@vger.kernel.org>, "linux-arm-kernel"
 <linux-arm-kernel@lists.infradead.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Will Deacon"
 <will@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250709-arm64_relax_jit_comp-v1-0-3850fe189092@bootlin.com>
 <20250709-arm64_relax_jit_comp-v1-1-3850fe189092@bootlin.com>
 <aHZYcY_9JtK8so3C@willie-the-truck>
 <DBCONB7XHN7E.2UQMMG6RICMFY@bootlin.com>
 <aHZmOVpcoyTvGY1u@willie-the-truck>
 <CAADnVQK=x7p6zjvNbv0iqOfE73DM3j0nGSGrFX+pVExLMkJb=w@mail.gmail.com>
In-Reply-To: <CAADnVQK=x7p6zjvNbv0iqOfE73DM3j0nGSGrFX+pVExLMkJb=w@mail.gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjedufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieekgeelvdekvdevhfdvgfeiffeuieelfffgleeivdelheelvdeiveetfedtiedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtoheprghlvgigvghirdhsthgrrhhovhhoihhtohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesi
 hhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: alexis.lothore@bootlin.com

On Tue Jul 15, 2025 at 5:40 PM CEST, Alexei Starovoitov wrote:
> On Tue, Jul 15, 2025 at 7:31=E2=80=AFAM Will Deacon <will@kernel.org> wro=
te:
>>
>> On Tue, Jul 15, 2025 at 04:02:25PM +0200, Alexis Lothor=C3=A9 wrote:
>> > On Tue Jul 15, 2025 at 3:32 PM CEST, Will Deacon wrote:
>> > > On Wed, Jul 09, 2025 at 10:36:55AM +0200, Alexis Lothor=C3=A9 (eBPF =
Foundation) wrote:
>> > >> While introducing support for 9+ arguments for tracing programs on
>> > >> ARM64, commit 9014cf56f13d ("bpf, arm64: Support up to 12 function
>> > >> arguments") has also introduced a constraint preventing BPF trampol=
ines
>> > >> from being generated if the target function consumes a struct argum=
ent
>> > >> passed on stack, because of uncertainties around the exact struct
>> > >> location: if the struct has been marked as packed or with a custom
>> > >> alignment, this info is not reflected in BTF data, and so generated
>> > >> tracing trampolines could read the target function arguments at wro=
ng
>> > >> offsets.
>> > >>
>> > >> This issue is not specific to ARM64: there has been an attempt (see=
 [1])
>> > >> to bring the same constraint to other architectures JIT compilers. =
But
>> > >> discussions following this attempt led to the move of this constrai=
nt
>> > >> out of the kernel (see [2]): instead of preventing the kernel from
>> > >> generating trampolines for those functions consuming structs on sta=
ck,
>> > >> it is simpler to just make sure that those functions with uncertain
>> > >> struct arguments location are not encoded in BTF information, and s=
o
>> > >> that one can not even attempt to attach a tracing program to such
>> > >> function. The task is then deferred to pahole (see [3]).
>> > >>
>> > >> Now that the constraint is handled by pahole, remove it from the ar=
m64
>> > >> JIT compiler to keep it simple.
>> > >>
>> > >> [1] https://lore.kernel.org/bpf/20250613-deny_trampoline_structs_on=
_stack-v1-0-5be9211768c3@bootlin.com/
>> > >> [2] https://lore.kernel.org/bpf/CAADnVQ+sj9XhscN9PdmTzjVa7Eif21noAU=
H3y1K6x5bWcL-5pg@mail.gmail.com/
>> > >> [3] https://lore.kernel.org/bpf/20250707-btf_skip_structs_on_stack-=
v3-0-29569e086c12@bootlin.com/
>> > >>
>> > >> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothor=
e@bootlin.com>
>> > >> ---
>> > >>  arch/arm64/net/bpf_jit_comp.c | 5 -----
>> > >>  1 file changed, 5 deletions(-)
>> > >
>> > > This is a question born more out of ignorance that insight, but how =
do
>> > > we ensure that the version of pahole being used is sufficiently
>> > > up-to-date that the in-kernel check is not required?
>> >
>> > Based on earlier discussions, I am not convinced it is worth maintaini=
ng
>> > the check depending on the pahole version used in BTF. Other architect=
ures
>> > exposing a JIT compiler don't have the in-kernel check and so are alre=
ady
>> > exposed to this very specific case, but discussions around my attempt =
to
>> > enforce the check on other JIT comp showed that the rarity of this cas=
e do
>> > not justify protecting it on kernel side (see [1]).
>>
>> I can understand why doing this in pahole rather than in each individual
>> JIT is preferable, but I don't think there's any harm leaving the
>> existing two line check in arm64 as long as older versions of pahole
>> might be used, is there? I wouldn't say that removing it really
>> simplifies the JIT compiler when you consider the rest of the
>> implementation.
>>
>> Of course, once the kernel requires a version of pahole recent enough
>> to contain [3], we should drop the check in the JIT compiler as the
>> one in pahole looks like it's more selective about the functions it
>> rejects.
>
> I frankly don't see the point in adding and maintaining such checks
> and code in the kernel for hypothetical cases that are not present
> in the kernel and highly unlikely ever be.
> The arm64 jit check was added out of abundance of caution.
> There was way too much "caution".

To complete Alexei's point: the check currently implemented in ARM64 JIT
comp is filtering _too many_ functions. It prevents attachment to any
function consuming a struct passed by value on the stack. But what we
really want is only about filtering those _when their alignment is
altered_, which is something that can not currently be deduced at runtime
in JIT comps. That's part of the reason why this has been moved to pahole.

I would also add that there is another small drawback about keeping this
check on ARM64 only, while not adding it to other JIT comps: we have to
keep filtering out some tests for ARM64, while the feature set is actually
the same as for the other archs. Sure, this discrepancy could be eliminated
once pahole minimum version in kernel build system contains the needed
development, as Will suggests, but I don't see that hapenning before many
months/years.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


