Return-Path: <linux-kselftest+bounces-31819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C473A9FAB4
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 22:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B39189949B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 20:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC5A1DE2DC;
	Mon, 28 Apr 2025 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aKaQLhaI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF55D26ACD;
	Mon, 28 Apr 2025 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745872887; cv=none; b=rC1zcXEIdRfw8tVUjfJFV5oWlDu2cF6a2Gs+v9cDYHmdo1zqXsJeg17nER9gAo0Brx0H1wpeF9hpAsiAE9Wcb+op9nKhebGXCcy2uh5b+pIJp2rJDBPYbVtILdCMsTk7Nm42LwQ5byp6YKRA91vUjepC6EC4xOT/9SbXZoo4EE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745872887; c=relaxed/simple;
	bh=VZuoH/BIy2GmMf+g7ruDVxRX6lVlZmL2+nfgqE32ly8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cIgk2xy5bQFEe++SsuVasMCiZEuUGlRdbcgn1EE/7mxjR/znj44YNENDklmT6o9S451vrkE1p6/vSIj1d4HxNrQi/EwWYpk//vPcwqOgMjQoc/HBxisjWscr9qWmOnZbUAPsJ5nZj9MS+TtTBBIQL9ONykukO0GaOC+1S/ABRfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aKaQLhaI; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B548438B9;
	Mon, 28 Apr 2025 20:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745872876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4S5NohzcZt8hjZWHfp8WHteVctUQSoPl0lKofU3tDA=;
	b=aKaQLhaISwSMkAlavm0KAhgbL2bv1f7sjgQSBKhWkB3EbQh+EF8u7bEF4eAVxMVarACoFw
	xFdlkcS3HVdC9Xqk7e/Bby0QzpfLuppbosJROUureXUuEzaXySDxfm2SC7blF/WcjwaFY5
	4JWfDaNu9g1yK3AOxPq5ZbYZazSAng+4Dn9TCwM7YhGabMo+iT/zE0Og4JCTK+lFypYNqP
	sWvVj0apUgJpkdZgbzLKpMw+yFUXoFw1wfNEDwuGlmGBiWoxUBjno0DyVJ7ENZ8cQt8QyH
	I63KthotL9d/f85B4/Da4IaFzVzGAcdpqvc5CiQj5Ryvcmx8qCOlftgukfq+ZA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Apr 2025 22:41:13 +0200
Message-Id: <D9IKA5K8PFAO.21V0PXVU6VPF1@bootlin.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>, "Xu Kuohai"
 <xukuohai@huaweicloud.com>, "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Mykola Lysenko" <mykolal@fb.com>, "Shuah
 Khan" <shuah@kernel.org>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Florent Revest"
 <revest@chromium.org>, "Bastien Curutchet" <bastien.curutchet@bootlin.com>,
 <ebpf@linuxfoundation.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH RFC bpf-next 3/4] bpf/selftests: add tests to validate
 proper arguments alignment on ARM64
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
 <20250411-many_args_arm64-v1-3-0a32fe72339e@bootlin.com>
 <3a16fae0346d4f733fb1a67ae6420d8bf935dbd8.camel@gmail.com>
 <D9I6TQN2I6B1.QC4FFHEWAURZ@bootlin.com> <m21ptcmdnw.fsf@gmail.com>
In-Reply-To: <m21ptcmdnw.fsf@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieduleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffvddufffhieffheetfffggeeugedtieduheeilefguddvheegvdeuffeuveeltdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvledprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvn
 hgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvh
X-GND-Sasl: alexis.lothore@bootlin.com

On Mon Apr 28, 2025 at 6:52 PM CEST, Eduard Zingerman wrote:
> Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> writes:
>
> [...]
>
>>> The function listened to is defined as accepting 'struct bpf_testmod_st=
ruct_arg_7',
>>> at the same time this function uses 'struct bpf_testmod_struct_arg_5'.
>>
>> That's not an accidental mistake, those are in fact the same definition.
>> bpf_testmod_struct_arg_7 is the kernel side definition in bpf_testmod.c:
>>
>> struct bpf_testmod_struct_arg_7 {
>> 	__int128 a;
>> };
>>
>> and struct bpf_testmode_struct_arg_5 is the one defined in the bpf test
>> program:
>>
>> struct bpf_testmod_struct_arg_5 {
>> 	__int128 a;
>> };
>
> Apologies, but I'm still confused:
> - I apply this series on top of:
>   224ee86639f5 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/=
bpf after rc4")
>
> - line 12 of tracing_struct_many_args.c has the following definition:
>
>   struct bpf_testmod_struct_arg_5 {
>          char a;
>          short b;
>          int c;
>          long d;
>   };
>
> - line 135 of the same file has the following definition:
>
>    SEC("fentry/bpf_testmod_test_struct_arg_11")
>    int BPF_PROG2(test_struct_many_args_9, struct bpf_testmod_struct_arg_5=
, a,
>                  struct bpf_testmod_struct_arg_5, b,
>                  struct bpf_testmod_struct_arg_5, c,
>                  struct bpf_testmod_struct_arg_5, d, int, e,
>                  struct bpf_testmod_struct_arg_5, f)
>
> - line 70 of tools/testing/selftests/bpf/test_kmods/bpf_testmod.c:
>
>    struct bpf_testmod_struct_arg_7 {
>          __int128 a;
>    };
>
> - line 152 of the same file:
>
>   noinline int bpf_testmod_test_struct_arg_11(struct bpf_testmod_struct_a=
rg_7 a,
>                                               struct bpf_testmod_struct_a=
rg_7 b,
>                                               struct bpf_testmod_struct_a=
rg_7 c,
>                                               struct bpf_testmod_struct_a=
rg_7 d,
>                                               short e,
>                                               struct bpf_testmod_struct_a=
rg_7 f)
>
> Do I use a wrong base to apply the series?

Argh, no, no, you are right, I checked again and I made some confusions
between progs/tracing_struct.c and progs/tracing_struct_many_args.c. I
initially did most of the work in tracing_struct.c, and eventually moved
the code to tracing_struct_many_args.c before sending my series, but I
apparently forgot to move bpf_testmod_struct_arg_5 declaration in
tracing_struct_many_args.c (and so, to rename it, since this name is
already used in there). As a consequence the bpf program is actually using
the wrong struct layout. So thanks for insisting and spotting this issue !

I fixed my mess locally in order to re-run the gdb analysis mentioned in my
previous mail, and the bug seems to be the same (unexpected t11:f: actual
35 !=3D expected 43), with the same layout issue on the bpf context passed =
on
the stack ("lucky" mistake ?). However, thinking more about this, I feel
like there is still something that I have missed:

0xffffc900001dbce8:     38      0       0       0       0       0       0  =
     0
0xffffc900001dbcf0:     0       0       0       0       0       0       0  =
     0
0xffffc900001dbcf8:     39      0       0       0       0       0       0  =
     0
0xffffc900001dbd00:     0       0       0       0       0       0       0  =
     0
0xffffc900001dbd08:     40      0       0       0       0       0       0  =
     0
0xffffc900001dbd10:     0       0       0       0       0       0       0  =
     0
0xffffc900001dbd18:     41      0       0       0       0       0       0  =
     0
0xffffc900001dbd20:     0       0       0       0       0       0       0  =
     0
0xffffffffc04016a6:     42      0       0       0       0       0       0  =
     0
0xffffc900001dbd30:     35      0       0       0       0       0       0  =
     0
0xffffc900001dbd38:     43      0       0       0       0       0       0  =
     0
0xffffc900001dbd40:     37      0       0       0       0       0       0  =
     0

If things really behaved correctly, f would not have the correct value but
would still be handled as a 16 bytes value, so the test would not fail with
"actual 35 !=3D 43", but something like "actual
27254487904906932132179118915584 !=3D 43" (43 << 64 | 35) I guess. I still
need to sort this out.

Alexis
--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


