Return-Path: <linux-kselftest+bounces-34880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D15CAD8591
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 10:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E8D1896E33
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 08:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9FE279DD9;
	Fri, 13 Jun 2025 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BnJGbMk/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCF9279DCA;
	Fri, 13 Jun 2025 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749803209; cv=none; b=bPC7d23Qz0eHuBJ1QECQA2lKlBLyPloN2PkqZmbRwxT5Swzgy4aJhDIwpofWFCV+9oZvN84q2v1ycdyi9l+d5o7ndYlzqWe961pK/QLDRV8/PyU5afT/j6o06dTejq95umD0iycTHnn9WGQipCiVqDxQ6QL7mIWU9eN0jqyyfyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749803209; c=relaxed/simple;
	bh=oy7cnpuIfUbxnBIHzSxSzs3wF3pN160eEFEtn1XrHHA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PGjcvFLqwwHFY7Wvxpv8rNgBQzvR8EAtgx5Io/C9T2cNTKGlVikOWVQLHWaMdS/YQae6FUbnv+rHqNJDYeOE8Po+TweENGgpLf2UyhS4a8mgqfgFC6xhoFkxQRGZmwUm5ttDGSOg8lGTiKLVbRct9KUf3LQexZKVe53Ol82WLNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BnJGbMk/; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B142A41C06;
	Fri, 13 Jun 2025 08:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749803203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oy7cnpuIfUbxnBIHzSxSzs3wF3pN160eEFEtn1XrHHA=;
	b=BnJGbMk/e7fYDOccAaKbhkPl6Zkb+CJk54xIzM7oGJ/68LdgKmC814rIU32t6tdn2RLttv
	x15WZiOubSuud24F243NbAQNPG2k3Dui7U5bdWbzo6Lo7AjeJ+KSplTU5N9Z/cTjXj0Rr9
	AtxWE42xFJSR7fqyJtvD37GTtg2rovAwTR+VAfdN1C4ZXMlk7rhOwNdTxFQnBalxqPz9tm
	e/OD8ENjC+yzoBhzLvEBBNcwIj7ZN9YK2gi89xBilq+iVetQOvwYaFKA3l+J6erZ08hSMo
	zVQuK+p9cI9MOofvRUYJC5RnI8Wf/o3bDNy4BjM6rT5BKMfG/sqEM22GLR1tVQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Jun 2025 10:26:37 +0200
Message-Id: <DAL9GRMH74F4.2IV0HN0NGU65X@bootlin.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, "David Ahern" <dsahern@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Menglong Dong"
 <imagedong@tencent.com>, =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?=
 <bjorn@kernel.org>, "Pu Lehui" <pulehui@huawei.com>, "Puranjay Mohan"
 <puranjay@kernel.org>, "Paul Walmsley" <paul.walmsley@sifive.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Ilya Leoshkevich" <iii@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
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
 <bastien.curutchet@bootlin.com>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
 <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH bpf 2/7] bpf/x86: prevent trampoline attachment when
 args location on stack is uncertain
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Peter Zijlstra" <peterz@infradead.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250613-deny_trampoline_structs_on_stack-v1-0-5be9211768c3@bootlin.com> <20250613-deny_trampoline_structs_on_stack-v1-2-5be9211768c3@bootlin.com> <20250613081150.GJ2273038@noisy.programming.kicks-ass.net>
In-Reply-To: <20250613081150.GJ2273038@noisy.programming.kicks-ass.net>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujeegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdfftdejhefhieelvefhgeffvddulefhfeegleegkefgffejgeffjeeigfdtveeinecuffhomhgrihhnpehlihhnuhigsggrshgvrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeehkedprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrnhgurhhiihesk
 hgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvh
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Peter,

On Fri Jun 13, 2025 at 10:11 AM CEST, Peter Zijlstra wrote:
> On Fri, Jun 13, 2025 at 09:37:11AM +0200, Alexis Lothor=C3=A9 (eBPF Found=
ation) wrote:
>> When the target function receives more arguments than available
>> registers, the additional arguments are passed on stack, and so the
>> generated trampoline needs to read those to prepare the bpf context,
>> but also to prepare the target function stack when it is in charge of
>> calling it. This works well for scalar types, but if the value is a
>> struct, we can not know for sure the exact struct location, as it may
>> have been packed or manually aligned to a greater value.
>
> https://refspecs.linuxbase.org/elf/x86_64-abi-0.99.pdf
>
> Has fairly clear rules on how arguments are encoded. Broadly speaking
> for the kernel, if the structure exceeds 2 registers in size, it is
> passed as a reference, otherwise it is passed as two registers.

Maybe my commit wording is not precise enough, but indeed, there's not
doubt about whether the struct value is passed on the stack or through a
register/a pair of registers. The doubt is rather about the struct location
when it is passed _by value_ and _on the stack_: the ABI indeed clearly
states that "Structures and unions assume the alignment of their most
strictly aligned component" (p.13), but this rule is "silently broken" when
a struct has an __attribute__((packed)) or and __attribute__((aligned(X))),
and AFAICT this case can not be detected at runtime with current BTF info.

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


