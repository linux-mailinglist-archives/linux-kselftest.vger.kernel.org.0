Return-Path: <linux-kselftest+bounces-31631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA358A9C1E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 10:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8866B1702FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 08:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ED81F3FC8;
	Fri, 25 Apr 2025 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XfnHkCqt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A441B6D11;
	Fri, 25 Apr 2025 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745570848; cv=none; b=EGn9mf2wx/LxNPUnFgvirQG8oACvfOfsetUPhfn2yAo++0lMRH8BDoI2sq/eyee+5e+Stli+LpxOAl3hQerZDFCB6sHe7t417EsnhlwVCrGILIRpPqfoE+oOsV6vw1PzOxbGeXRwqakfBeZflqDIoOP6E7vAnyNETzXKgnA2czg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745570848; c=relaxed/simple;
	bh=h26gMhMCs1xS5/I+YRXsVSuot5NCWQyBZrETzDmORVs=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:Mime-Version:
	 References:In-Reply-To; b=LQgRO6pkB7I8rgDnblEdADqdlUXhAwsapOgTV6UbYpaIuiBfnsYJATrr/ICAIo9neyAukzkSCn/fmlmBSfxPx0Jgzw3mWWyyxsLGDX0ak0otcqWXmNAnhj4+AO8XL7mpiANBWtKBflchmCS73Q0OVktkwPzGAq476oSQzkNXJKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XfnHkCqt; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5EBCD432E9;
	Fri, 25 Apr 2025 08:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745570837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F20bZhqAcFtAHBc8oMhq0YvImZee5ACc/cX8f7eyPuQ=;
	b=XfnHkCqteD1vpSoUt3ytJgWvsKgXhBYCY/VDhoaYvcppi7dX9o7N3sJa/QEBclq2bvIvS2
	8oGE2voC8liDallF7KWtiuCZpafMIKHtPveqUr200YcwxdIxaKUnyBy08CUCDvmQumUHcc
	CbJWVkyDn16/vVWwVae39myfJRsgODUT7oziDllNHVJoAv2lqaCmj+GkRmNHrINV4OXf8Z
	vwa9a87Oq0n5Vo79Wk4l45c7L20tIGyTYunrSm9vcX+JBDZe0j1ryGLZ2U4qloUAH6uo6l
	4ZI8oRkKI94MsvFag4FC6XVg/yArVD+aQQcwN0mhCAm1X0/MZAmVhSjN++Bcww==
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Apr 2025 10:47:15 +0200
Message-Id: <D9FL7V8UX9GP.25220KL6CKOY7@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Xu Kuohai" <xukuohai@huaweicloud.com>, "Andrii Nakryiko"
 <andrii.nakryiko@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "KP Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Puranjay
 Mohan" <puranjay@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Mykola Lysenko" <mykolal@fb.com>, "Shuah
 Khan" <shuah@kernel.org>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Florent Revest"
 <revest@chromium.org>, "Bastien Curutchet" <bastien.curutchet@bootlin.com>,
 <ebpf@linuxfoundation.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "bpf" <bpf@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel"
 <linux-arm-kernel@lists.infradead.org>, "open list:KERNEL SELFTEST
 FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH RFC bpf-next 1/4] bpf: add struct largest member size in
 func model
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
 <D98Q8BRNUVS9.11J60C67L1ALR@bootlin.com>
 <CAEf4BzZHMYyGDZ4c4eNXG7Fm=ecxCCbKhKbQTbCjvWmKtdwvBw@mail.gmail.com>
 <D9E9IQQ3QKXM.3UJ17G9CBS1FH@bootlin.com>
 <6b6472c3-0718-4e60-9972-c166d51962a3@huaweicloud.com>
 <D9EWSDXHDGFJ.FIDSHIR1OP80@bootlin.com>
 <CAADnVQJjQLdc_Chvz9v2-huCb9rmi048heK-eEX30AtW10H+-Q@mail.gmail.com>
In-Reply-To: <CAADnVQJjQLdc_Chvz9v2-huCb9rmi048heK-eEX30AtW10H+-Q@mail.gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheduledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtfffkhffvvefuggfgofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeigefgieffvddvvdduuefhvdeivdejtddvfedthefhgefggedtledtueehuddtieenucffohhmrghinheplhhinhhugigsrghsvgdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedupdhrtghpthhtoheprghlvgigvghirdhsthgrrhhovhhoihhtohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgihukhhuohhhrghisehhuhgrfigvihgtlhhouhgurdgtohhmpdhrtghpthhtoheprghnughrihhirdhnrghkrhihihhkohesghhmrghilhdrtghomhdprhgtphhtthhopegrshhts
 ehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghv
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Alexei,

On Fri Apr 25, 2025 at 1:14 AM CEST, Alexei Starovoitov wrote:
> On Thu, Apr 24, 2025 at 6:38=E2=80=AFAM Alexis Lothor=C3=A9
> <alexis.lothore@bootlin.com> wrote:

[...]

>> > With DWARF info, we might not need to detect the structure alignment a=
nymore,
>> > since the DW_AT_location attribute tells us where the structure parame=
ter is
>> > located on the stack, and DW_AT_byte_size gives us the size of the str=
ucture.
>>
>> I am not sure to follow you here, because DWARF info is not accessible
>> from kernel at runtime, right ? Or are you meaning that we could, at bui=
ld
>> time, enrich the BTF info embedded in the kernel thanks to DWARF info ?
>
> Sounds like arm64 has complicated rules for stack alignment and
> stack offset computation for passing 9th+ argument.

AFAICT, arm64 has some specificities for large types, but not that much
compared to x86 for example. If I take a look at System V ABI ([1]), I see
pretty much the same constraints:
- p.18: "Arguments of type __int128 offer the same operations as INTEGERs,
  [...] with the exception that arguments of type __int128 that are stored
  in memory must be aligned on a 16-byte boundary"
- p.13: "Structures and unions assume the alignment of their most strictly
  aligned component"
- the custom packing and alignments attributes will end up having the same
  consequence on both architectures

As I mentioned in my cover letter, the new tests covering those same
alignment constraints for ARM64 break on x86, which makes me think other
archs are also silently ignoring those cases.

> Since your analysis shows:
> "there are about 200 functions accept 9 to 12 arguments, so adding suppor=
t
> for up to 12 function arguments."
> I say, let's keep the existing limitation:
>         if (nregs > 8)
>                 return -ENOTSUPP;
>
> If there is a simple and dumb way to detect that arg9+ are scalars
> with simple stack passing rules, then, sure, let's support those too,
> but fancy packed/align(x)/etc let's ignore.


[1] https://refspecs.linuxbase.org/elf/x86_64-abi-0.99.pdf


--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


