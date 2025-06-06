Return-Path: <linux-kselftest+bounces-34414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4027AACFDAB
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 09:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0C83B173D
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 07:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD86227A462;
	Fri,  6 Jun 2025 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FbcBo+GO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9177FD;
	Fri,  6 Jun 2025 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749195969; cv=none; b=eivzPudLjAH+J1MKnD8/S1ehzccLES+whzAZb6gjUWAyi0+D5mE/gN8AgVAfPxWtiUf7GyQIarifMksYyrwLNIWGLnZTuSk7bNWirPDmclr/7/vKFIT4Ko6lP4yANvDR4v0Y8P8iR14dhVXY+HdjwT94N+rMmAOZQNPUMVIfVtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749195969; c=relaxed/simple;
	bh=IEkQc1BcGqv1X56aDpUHvaulzc1YvNTUmrX5u2YHMKA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mnYLa+95DkpOdHLKhfU0gjbNmOhw+2BH+mn440O7GY6Yy9QxWDLdiIvJeZelH4ERZbbP+qfwkC1mwEM33/xNZNWKsynYEBum80scZZCDrymm62cJfJ9KHSm0PY/soe8VXWgn9Pigty6DVhJO+PxliRV/CRk6v/i63Eg3MOGGoyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FbcBo+GO; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B90F442AE;
	Fri,  6 Jun 2025 07:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749195958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+a4tmR/A6ANRwQiGU6A/fzxxPhMQUHBWtsMGAxzq3M=;
	b=FbcBo+GO49Gf4nun+ACzzLWBd7hkcSEKiitgBAVSvqrZiijkTwKBI0uSbwLisokMQt1oD+
	qDpcmFva4f3cqTdmgZTVwjY61/BXc4vuqQM3UzFLSJA5BHlVsHBzlkMa9vTg4KcETJp+sN
	yJ66JPB2utPtj9hgCyWKd57/wxZ5BfRrnZsHixXZxwynbcCfBEycAPgZefFV2OAm0YTuas
	03uBMg5uX+ZbI/KYG2jwsizN8uEb5UQkZOnTwidlDSIdxRgZlDTKmOukYH8rdpD319jPgf
	pGQzZuy3BZ0YrMvdehF+RGesgL2H5RIPdqFTxOZoAKNvQrWWKZLxSK8NJxAAGQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Jun 2025 09:45:51 +0200
Message-Id: <DAFA7QSTVFQF.3MG5408HBVNT7@bootlin.com>
Cc: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Andrii Nakryiko"
 <andrii.nakryiko@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "KP Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Puranjay
 Mohan" <puranjay@kernel.org>, "Xu Kuohai" <xukuohai@huaweicloud.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon"
 <will@kernel.org>, "Mykola Lysenko" <mykolal@fb.com>, "Shuah Khan"
 <shuah@kernel.org>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Florent Revest"
 <revest@chromium.org>, "Bastien Curutchet" <bastien.curutchet@bootlin.com>,
 <ebpf@linuxfoundation.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "bpf" <bpf@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel"
 <linux-arm-kernel@lists.infradead.org>, "open list:KERNEL SELFTEST
 FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>, <dwarves@vger.kernel.org>
Subject: Re: [Question] attributes encoding in BTF
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
 <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com>
 <CAEf4Bzbn6BdXTOb0dTcsQmOMZpp5=DzGS2hHHQ3+dwcja=gv+w@mail.gmail.com>
 <D98Q8BRNUVS9.11J60C67L1ALR@bootlin.com>
 <CAEf4BzZHMYyGDZ4c4eNXG7Fm=ecxCCbKhKbQTbCjvWmKtdwvBw@mail.gmail.com>
 <D9E9IQQ3QKXM.3UJ17G9CBS1FH@bootlin.com>
 <DADMLIVHMSSO.3AXSI5216WCT6@bootlin.com>
 <9a2ba0ad-b34d-42f8-89a6-d9a44f007bdc@linux.dev>
 <DAEFD2WH7HRV.2SOG9Q00QSEXH@bootlin.com>
 <CAADnVQ+T_s6dAwJ5JKqNqA8tq1P+MdfPvPw0EoY5yOf8PnGT4g@mail.gmail.com>
In-Reply-To: <CAADnVQ+T_s6dAwJ5JKqNqA8tq1P+MdfPvPw0EoY5yOf8PnGT4g@mail.gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelkeehiefhfeehvefhtdegueelkeehffffffeuvdekkeekuddvueeguefgieeukeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdduvddruddthedrudehtddrvdehvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvuddvrddutdehrdduhedtrddvhedvpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfeefpdhrtghpthhtoheprghlvgigvghirdhsthgrrhhovhhoihhtohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepihhhohhrrdhsohhlohgurhgriheslhhinhhugidruggvvhdprhgtphhtthhopegrnhgurhhiihdrnhgrkhhrhihikhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvh
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Alexei,

On Thu Jun 5, 2025 at 6:09 PM CEST, Alexei Starovoitov wrote:
> On Thu, Jun 5, 2025 at 12:35=E2=80=AFAM Alexis Lothor=C3=A9
> <alexis.lothore@bootlin.com> wrote:
>>
>> Hi Ihor,
>>
>> On Wed Jun 4, 2025 at 7:31 PM CEST, Ihor Solodrai wrote:
>> > On 6/4/25 2:02 AM, Alexis Lothor=C3=83=C2=A9 wrote:

[...]

>> Thanks for the details ! I have missed this possibility, as I have been
>> assuming that DWARF info was exposing the needed info. I'll take a look =
at
>> it, but if those attributes can not be represented by DWARF, I'll have t=
o
>> find another way of getting those packing/alignment modifications on dat=
a
>> type (eg: re-use/share btf__align_of from libbpf, as suggested by Andrii=
,
>> but it may not able to cover all cases).
>
> Not sure all the trouble is worth it.
> I feel it's a corner case. Something we don't need to fix.

TBH I don't own any specific use case really needing this handling, so if
it does not feel worth the trouble, I'm fine with not trying to support
this. My effort is rather motivated by the goal of aligning the ARM64
features with other platform, and so of getting rid of
tools/testing/selftests/bpf/DENYLIST.aarch64.

For the record, this effort also showed that the same kind of issue affects
other platforms already supporting many args + structs passed by value ([1]=
)
- structs alignment with specific alignment constraints are not
  specifically handled (eg: a struct with an __int128 as a top-level
  member, leading to a 16 byte alignment requirement)
- packing and custom alignment is not handled

From there, I could do two different things:
1. do nothing, keep ARM64 as-is with the current version which has been
  recently merged: ARM64 then denies attachment to any function trying to
  pass a struct by value on stack. We keep the tracing_struct tests denied
  for ARM64. Other platforms still allow to attach such functions, but may
  be parsing wrongly arguments in those specific cases.
2. add the constraint applied on ARM64 (refusing attachment when structs ar=
e
  passed through stack) to other JIT compilers. Then update the
  tracing_struct test to ensure this specific case is properly denied on
  all platforms to avoid risking reading wrongly arguments passed through
  stack when structs or large types are involved.

I tend to think 2. is better, but let me know if you have a different
opinion here.

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


