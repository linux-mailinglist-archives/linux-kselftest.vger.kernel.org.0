Return-Path: <linux-kselftest+bounces-31037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92770A914D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 09:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488D04459A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 07:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7861218845;
	Thu, 17 Apr 2025 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YEhNjld6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA271DDA0C;
	Thu, 17 Apr 2025 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874067; cv=none; b=Oa6pRsWtwa+eObRL1X3N0J4LaouTTQtd3Wj6Uta7gqBYpcWW+zKcDSdFsHCE7OAJAcgnlRTBw+aHrQCUurJDVGwNjUGTFJJT8Ez9nL5ujqIjlRw9L0sf2JpNJKZEuuh8oaWYwNF+EE4O63J9n6ouN9HKrpIsgIF+fBtc08dLsIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874067; c=relaxed/simple;
	bh=YYgBl4XslUIPANcfaH0UDI8ZQnEJjTNt9jHQJbKWOHU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=lm0PeDGs3hwBWWjopQ6frs0a5Uc7DFPgwZ1UJ0jtwTbpA2uwmHFVuMixmKHvBUC8hv10I6y5ZodCSw9QGiS6BsfWFMF2mGwDa9xLEP50Y1BDezmCq3aV7w7Q0vjhHEtwYSj3yU2VcVMKrj3GTxlbfUvfUICREAfPSQKEQn01EXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YEhNjld6; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4313F439D4;
	Thu, 17 Apr 2025 07:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744874062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYgBl4XslUIPANcfaH0UDI8ZQnEJjTNt9jHQJbKWOHU=;
	b=YEhNjld6ymNJqLjNHhBzpSnN7oxSp7ezkwtyyDXqHLLiBD8JhNvqejYTXoBMtvZDkSP9do
	k/g8vZ3fmZQuP3/3LiwBWp9ucZU5wxsKptb6ID4sRXNlXlDzNCdwKBE4ud8E4tGTCxlp8L
	r8mhLATCbpRcjr3kWeU0PDea0TtRrFjiETGwKZZLdbapYValXtnWGRLPuXGOGxpyB6ZoN+
	ox0SjwLvBXBPurAx36kStx7furqEBRLvFub9fqKWABp708RJsO3lOioWNEgT0zqj7dQbbR
	7wM7fZzmaeCPebZvlE5TDNCHnvG32PEWeTnAiwHpspnGjirRTX/je3h/ohWATw==
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Apr 2025 09:14:16 +0200
Message-Id: <D98Q8BRNUVS9.11J60C67L1ALR@bootlin.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Puranjay Mohan"
 <puranjay@kernel.org>, "Xu Kuohai" <xukuohai@huaweicloud.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Mykola Lysenko" <mykolal@fb.com>, "Shuah Khan" <shuah@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Florent Revest" <revest@chromium.org>,
 "Bastien Curutchet" <bastien.curutchet@bootlin.com>,
 <ebpf@linuxfoundation.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH RFC bpf-next 1/4] bpf: add struct largest member size in
 func model
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
 <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com>
 <CAEf4Bzbn6BdXTOb0dTcsQmOMZpp5=DzGS2hHHQ3+dwcja=gv+w@mail.gmail.com>
In-Reply-To: <CAEf4Bzbn6BdXTOb0dTcsQmOMZpp5=DzGS2hHHQ3+dwcja=gv+w@mail.gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdekieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtfffkvefuhffvggfgofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedvhfdvjeektefggfdvhfejveehleeugfeiieelgfffheeggefhvddvudefiedtfeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedtpdhrtghpthhtoheprghnughrihhirdhnrghkrhihihhkohesghhmrghilhdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgur
 hhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Andrii,

On Wed Apr 16, 2025 at 11:24 PM CEST, Andrii Nakryiko wrote:
> On Fri, Apr 11, 2025 at 1:32=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Foundat=
ion)
> <alexis.lothore@bootlin.com> wrote:
>>
>> In order to properly JIT the trampolines needed to attach BPF programs
>> to functions, some architectures like ARM64 need to know about the
>> alignment needed for the function arguments. Such alignment can
>> generally be deduced from the argument size, but that's not completely
>> true for composite types. In the specific case of ARM64, the AAPCS64 ABI
>> defines that a composite type which needs to be passed through stack
>> must be aligned on the maximum between 8 and the largest alignment
>> constraint of its first-level members. So the JIT compiler needs more
>> information about the arguments to make sure to generate code that
>> respects those alignment constraints.
>>
>> For struct arguments, add information about the size of the largest
>> first-level member in the struct btf_func_model to allow the JIT
>> compiler to guess the needed alignment. The information is quite
>
> I might be missing something, but how can the *size* of the field be
> used to calculate that argument's *alignment*? i.e., I don't
> understand why arg_largest_member_size needs to be calculated instead
> of arg_largest_member_alignment...

Indeed I initially checked whether I could return directly some alignment
info from btf, but it then involves the alignment computation in the btf
module. Since there could be minor differences between architectures about
alignment requirements, I though it would be better to in fact keep alignme=
nt
computation out of the btf module. For example, I see that 128 bits values
are aligned on 16 bytes on ARM64, while being aligned on 8 bytes on S390.=
=20

And since for ARM64, all needed alignments are somehow derived from size
(it is either directly size for fundamental types, or alignment of the
largest member for structs, which is then size of largest member),
returning the size seems to be enough to allow the JIT side to compute
alignments.

>> specific, but it allows to keep arch-specific concerns (ie: guessing the
>> final needed alignment for an argument) isolated in each JIT compiler.
>
> couldn't all this information be calculated in the JIT compiler (if
> JIT needs that) from BTF?

From what I understand, the JIT compiler does not have access to BTF info,
only a substract from it, arranged in a struct btf_func_model ? This
struct btf_func_model already has size info for standard types, but for
structs we need some additional info about the members, hence this
arg_largest_member_alignment addition in btf_func_model.

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


