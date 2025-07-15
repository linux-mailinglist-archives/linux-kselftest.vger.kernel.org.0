Return-Path: <linux-kselftest+bounces-37360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D676B060DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 16:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58DE01C469C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 14:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BDD20B1F5;
	Tue, 15 Jul 2025 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ohr1ZKGW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A27202C26;
	Tue, 15 Jul 2025 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588152; cv=none; b=E6qcE+Ism+mnEYMBujfUj+v9J92EquZwHsPzOTReaQabthTYw+f+MVPy5nw7wBrB+Rcm8/PqGH1VEII9ZhGEBufxDYhf/CYB+Td2kKJL2RKVJN4N+kFAhk3Cnftzvn8x7lp+l4Bhb1mQDIkNchsiMTfJrTHiXfkSGwI9p7eCIo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588152; c=relaxed/simple;
	bh=f1cM/7QBDfw3ynfq4r+6ueDeeE07SE1ymM7fUCG61e8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=cupIq9B73cRD6F27RCZzvMUBSnnSlu0i9EcnPA+Ri9/gF2U1BX7loR1YESiLJj0Nf1MTUiZOy3NGUK0LKbculTChDX/Tc/44q82yR7zmKczvhjnadZsyXSwanQ4L3SVFn1MXsm62QGCngyWPL8h8gSJyy6wVnkRu3VvL4GTOvWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ohr1ZKGW; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF5C544410;
	Tue, 15 Jul 2025 14:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752588148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lk6YS19eH8sl7JMJlZ3DJG1FxHGmkLhzKUSEcTA4E0g=;
	b=Ohr1ZKGWHYKUPNEXEl46hgF6TQ3LZlc0hvDeytv/gT65N3h3Ab2tGCfHDWFG0rZz9yZqcM
	GeL8Updmc8eobyHblIB4FjLPJkh//fBMg7qA1m4K32fYwSReVsY2y81/wiZTdu4IEJXkYz
	zSmzVGy95jlzloW57DqpLucelajOCmeo7S73g3Qd52RWyebVQm8ePQ40ydBOj543bJ1jsz
	WV+jFc5hfOTso61Gv43Tj+0wS9vuMz00NzuZV7vR9oA0I9Ad2rqTX8IH8unDKS5QE1PrVY
	PJ/cc3RFGuMXGLVv0ZZWlpKA8DWtDzXVpG+fzBROwdoApgROYpb37MK7a5IbWg==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 16:02:25 +0200
Message-Id: <DBCONB7XHN7E.2UQMMG6RICMFY@bootlin.com>
To: "Will Deacon" <will@kernel.org>
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
 <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250709-arm64_relax_jit_comp-v1-0-3850fe189092@bootlin.com>
 <20250709-arm64_relax_jit_comp-v1-1-3850fe189092@bootlin.com>
 <aHZYcY_9JtK8so3C@willie-the-truck>
In-Reply-To: <aHZYcY_9JtK8so3C@willie-the-truck>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehhedtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffvufevhffofhgjsehtqhertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepuefhhfejhffftedthfeukeeiueekffffjeefkeeujeetleekfedtvdegieehvdegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdeipdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghus
 ehlihhnuhigrdguvghvpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvh
X-GND-Sasl: alexis.lothore@bootlin.com

On Tue Jul 15, 2025 at 3:32 PM CEST, Will Deacon wrote:
> On Wed, Jul 09, 2025 at 10:36:55AM +0200, Alexis Lothor=C3=A9 (eBPF Found=
ation) wrote:
>> While introducing support for 9+ arguments for tracing programs on
>> ARM64, commit 9014cf56f13d ("bpf, arm64: Support up to 12 function
>> arguments") has also introduced a constraint preventing BPF trampolines
>> from being generated if the target function consumes a struct argument
>> passed on stack, because of uncertainties around the exact struct
>> location: if the struct has been marked as packed or with a custom
>> alignment, this info is not reflected in BTF data, and so generated
>> tracing trampolines could read the target function arguments at wrong
>> offsets.
>>=20
>> This issue is not specific to ARM64: there has been an attempt (see [1])
>> to bring the same constraint to other architectures JIT compilers. But
>> discussions following this attempt led to the move of this constraint
>> out of the kernel (see [2]): instead of preventing the kernel from
>> generating trampolines for those functions consuming structs on stack,
>> it is simpler to just make sure that those functions with uncertain
>> struct arguments location are not encoded in BTF information, and so
>> that one can not even attempt to attach a tracing program to such
>> function. The task is then deferred to pahole (see [3]).
>>=20
>> Now that the constraint is handled by pahole, remove it from the arm64
>> JIT compiler to keep it simple.
>>=20
>> [1] https://lore.kernel.org/bpf/20250613-deny_trampoline_structs_on_stac=
k-v1-0-5be9211768c3@bootlin.com/
>> [2] https://lore.kernel.org/bpf/CAADnVQ+sj9XhscN9PdmTzjVa7Eif21noAUH3y1K=
6x5bWcL-5pg@mail.gmail.com/
>> [3] https://lore.kernel.org/bpf/20250707-btf_skip_structs_on_stack-v3-0-=
29569e086c12@bootlin.com/
>>=20
>> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boo=
tlin.com>
>> ---
>>  arch/arm64/net/bpf_jit_comp.c | 5 -----
>>  1 file changed, 5 deletions(-)
>
> This is a question born more out of ignorance that insight, but how do
> we ensure that the version of pahole being used is sufficiently
> up-to-date that the in-kernel check is not required?

Based on earlier discussions, I am not convinced it is worth maintaining
the check depending on the pahole version used in BTF. Other architectures
exposing a JIT compiler don't have the in-kernel check and so are already
exposed to this very specific case, but discussions around my attempt to
enforce the check on other JIT comp showed that the rarity of this case do
not justify protecting it on kernel side (see [1]).

Alexis

[1] https://lore.kernel.org/bpf/CAADnVQ+sj9XhscN9PdmTzjVa7Eif21noAUH3y1K6x5=
bWcL-5pg@mail.gmail.com/


--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


