Return-Path: <linux-kselftest+bounces-31761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9193DA9ED9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 12:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC5A17BD2E
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 10:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F74725EFBE;
	Mon, 28 Apr 2025 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n0pN73mO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9D91F8676;
	Mon, 28 Apr 2025 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745834921; cv=none; b=eXOe09/YZwxaMT7jqNoqA2a8HuJNNXWj412KeAFchTJiuIeViPUEo7Fko+KwWoENMha5EXS7nUsx5k4YQnewXNcB7cVpU1akowdf2/G/OeehmtJkuIyRl2n/g394b9iX/TUvNDi8DhZ0qs/2r7NBWsJw8BVttn2inmTP+/MxNvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745834921; c=relaxed/simple;
	bh=lr6pQ3NIoD+lRzXdXbL+Byvxr/QgEuEyFJ7ZHAW6OTs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jms9nBwEZzPieZAPkh3n64RSgnr7wChsfNDNKrecn09TWpw+dxTYxyid5jHfGNGUszXp6WOtRM+u9YlHJUhY8xkxrIGcsZNTAiGbzSiPJibiCjZgT9rIKihloNPvXaOsM+5lfXOTuu66alj3FijMv5h0Pke6rkLVvVomnwuNGWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n0pN73mO; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0378941E0D;
	Mon, 28 Apr 2025 10:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745834916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EyLLSu+6S+6dxer7LO6vuNlydixelSCtlsd/r01CLYw=;
	b=n0pN73mOyqcHetOyty577p3pErAzkt7nOjTmTs7YgE7Q0kFnEUjpP51kQxEZbEasxxXrt7
	JLvkjuOt0AXoXFzIgQigzMagk7hFGPyQUdle3Zb9jKfyz12z4ip3NeyasSIldXmsRciGHI
	DAPPFmRMZw65TNO0ONyFX1B9VOWdBPbWVfFQRxq7GDgZTyiOu6KiIQmtgUPrBgjq25ltX4
	fXs7Qr6/wadKGI1e/wzLtxDQu6R/a1PPKI1hnCq8qK3a+JQ9bdUmnQfv6UUGKYpoRgrzG2
	3kbgk9SijtBUMuGij0XV/jKboUCdiajElMI6QPih9raiz1GLhgDuUXF1++0s5Q==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Apr 2025 12:08:32 +0200
Message-Id: <D9I6TQN2I6B1.QC4FFHEWAURZ@bootlin.com>
Cc: "Bastien Curutchet" <bastien.curutchet@bootlin.com>,
 <ebpf@linuxfoundation.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH RFC bpf-next 3/4] bpf/selftests: add tests to validate
 proper arguments alignment on ARM64
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Puranjay Mohan"
 <puranjay@kernel.org>, "Xu Kuohai" <xukuohai@huaweicloud.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Mykola Lysenko" <mykolal@fb.com>, "Shuah Khan" <shuah@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Florent Revest" <revest@chromium.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
 <20250411-many_args_arm64-v1-3-0a32fe72339e@bootlin.com>
 <3a16fae0346d4f733fb1a67ae6420d8bf935dbd8.camel@gmail.com>
In-Reply-To: <3a16fae0346d4f733fb1a67ae6420d8bf935dbd8.camel@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedtieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelkeehiefhfeehvefhtdegueelkeehffffffeuvdekkeekuddvueeguefgieeukeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdelpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnv
 ghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhigrdguvghv
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Eduard,

On Mon Apr 28, 2025 at 9:01 AM CEST, Eduard Zingerman wrote:
> On Fri, 2025-04-11 at 22:32 +0200, Alexis Lothor=C3=A9 (eBPF Foundation) =
wrote:
>> When dealing with large types (>8 bytes), ARM64 trampolines need to take
>> extra care about the arguments alignment to respect the calling
>> convention set by AAPCS64.
>>=20
>> Add two tests ensuring that the BPF trampoline arranges arguments with
>> the relevant layout. The two new tests involve almost the same
>> arguments, except that the second one requires a more specific alignment
>> to be set by the trampoline when preparing arguments before calling the
>> the target function.
>>=20
>> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boo=
tlin.com>
>> ---
>
> [...]
>
>> +SEC("fentry/bpf_testmod_test_struct_arg_11")
>> +int BPF_PROG2(test_struct_many_args_9, struct bpf_testmod_struct_arg_5,=
 a,
>> +	      struct bpf_testmod_struct_arg_5, b,
>> +	      struct bpf_testmod_struct_arg_5, c,
>> +	      struct bpf_testmod_struct_arg_5, d, int, e,
>> +	      struct bpf_testmod_struct_arg_5, f)
>
> Hello Alexis,
>
> I'm trying to double check the error you've seen for x86.

Thanks for taking a look at this.

> I see that tracing_struct/struct_many_args fails with assertion:
> "test_struct_many_args:FAIL:t11:f unexpected t11:f: actual 35 !=3D expect=
ed 43".
> Could you please help me understand this test?

Sure. When we attach fentry/fexit programs to a kernel function,  a small
trampoline is generated to handle the attached programs execution. This
trampoline has to:
1. properly read and aggregate the functions arguments into a bpf tracing
context. Those arguments comes from registers, and possibly from the stack
if not all function arguments fit in registers
2. if the trampoline is in charge of calling the target function (that's
the case for example when we have both a fentry and a fexit programs
attached), it must prepare the arguments for the target function, by
filling again the registers, and possibly pushing the additional arguments
on the stack at the relevant offset.

This test is about validating the first point: ensuring that the trampoline
has correctly read the initial arguments from the target function and
forwarded them to the fentry program. So the actual test triggers the
targeted function, it triggers the attached fentry program which record the
values passed by the trampoline in t11_a, t11_b, etc, and then the
test checks back that those "spied" values are the one that it has actually
passed when executing the target function.

> The function listened to is defined as accepting 'struct bpf_testmod_stru=
ct_arg_7',
> at the same time this function uses 'struct bpf_testmod_struct_arg_5'.

That's not an accidental mistake, those are in fact the same definition.
bpf_testmod_struct_arg_7 is the kernel side definition in bpf_testmod.c:

struct bpf_testmod_struct_arg_7 {
	__int128 a;
};

and struct bpf_testmode_struct_arg_5 is the one defined in the bpf test
program:

struct bpf_testmod_struct_arg_5 {
	__int128 a;
};

I agree while being correct, this is confusing :/ I have kind of blindly
applied the logic I have observed in here for declaring test structs, and
so declared it twice (in kernel part and in bpf part), just incrementing
the index of the last defined structure. But I guess it could benefit from
some index syncing, or better, some refactoring to properly share those
declarations. I'll think about it for a new rev.

> Nevertheless, the assertion persists even with correct types.

So I digged a bit further to better share my observations here. This is the
function stack when entering the trampoline after having triggered the
target function execution:

(gdb) x/64b $rbp+0x18
0xffffc9000015fd60:     41      0       0       0       0       0       0  =
     0
0xffffc9000015fd68:     0       0       0       0       0       0       0  =
     0
0xffffc9000015fd70:     42      0       0       0       0       0       0  =
     0
0xffffc9000015fd78:     35      0       0       0       0       0       0  =
     0
0xffffc9000015fd80:     43      0       0       0       0       0       0  =
     0
0xffffc9000015fd88:     0       0       0       0       0       0       0  =
     0

We see the arguments that did not fit in registers, so d, e and f.

This is the ebpf context generated by the trampoline for the fentry
program, from the content of the stack above + the registers:

(gdb) x/128b $rbp-60
0xffffc9000015fce8:     38      0       0       0       0       0       0  =
     0
0xffffc9000015fcf0:     0       0       0       0       0       0       0  =
     0
0xffffc9000015fcf8:     39      0       0       0       0       0       0  =
     0
0xffffc9000015fd00:     0       0       0       0       0       0       0  =
     0
0xffffc9000015fd08:     40      0       0       0       0       0       0  =
     0
0xffffc9000015fd10:     0       0       0       0       0       0       0  =
     0
0xffffc9000015fd18:     41      0       0       0       0       0       0  =
     0
0xffffc9000015fd20:     0       0       0       0       0       0       0  =
     0
0xffffc9000015fd28:     42      0       0       0       0       0       0  =
     0
0xffffc9000015fd30:     35      0       0       0       0       0       0  =
     0
0xffffc9000015fd38:     43      0       0       0       0       0       0  =
     0
0xffffc9000015fd40:     37      0       0       0       0       0       0  =
     0

So IIUC, this is wrong because the "e" variable in the bpf program being
an int (and about to receive value 42), it occupies only 1 "tracing context
8-byte slot", so the value 43 (representing the content for variable f),
should be right after it, at 0xffffc9000015fd30. What we have instead is a
hole, very likely because we copied silently the alignment from the
original function call (and I guess this 35 value is a remnant from the
previous test, which uses values from 27 to 37)

Regardless of this issue, based on discussion from last week, I think I'll
go for the implementation suggested by Alexei: handling the nominal cases,
and detecting and blocking the non trivial cases (eg: structs passed on
stack). It sounds reasonable as there seems to be no exisiting kernel
function currently able to trigger those very specific cases, so it could
be added later if this changes.

Alexis
--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


