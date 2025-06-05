Return-Path: <linux-kselftest+bounces-34359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6812ACEAEB
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 09:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A94177C02
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 07:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D681F4177;
	Thu,  5 Jun 2025 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kj784Nm5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D651A2545;
	Thu,  5 Jun 2025 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749108931; cv=none; b=GXggvh5Y2h94e+Zdl79u6gciivNLpK60n+nXxFA1RIHsq+xBnxuSPrSLdHZa7ExUpd4FlA5MCnmBCquneHk9FFVQj58UZUK9iUmrqitYutgvwneLFSWctobqDT7XHHzAF5lKN4Q4BATXxonCCj3KorbF5x5Q7o+y8b8PX8cqVOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749108931; c=relaxed/simple;
	bh=5Yg2TszODfSWyu/tkAewlOKe9bmGQWD5HRPUFzitAq0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KiJsa4xEGDz2aJLNsv/s54tTTnXmNvA/LuFx4QEm3OynDdd3VjYtDXxkfCF5qUKeJZCpdXdzxJRY/uWBplaFG/n7TbQ1nF4Ewg3UTfGoL3YEULhKxJd+GWqZPnwaE6bGwTzQbck0iP35txm7iTb/dwib6Z1aC6ix5FREBy9IENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kj784Nm5; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5236843935;
	Thu,  5 Jun 2025 07:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749108920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Yg2TszODfSWyu/tkAewlOKe9bmGQWD5HRPUFzitAq0=;
	b=kj784Nm5ZgltuTXJv+pbKGMDA1t5/ru/eck+iLsRHT9bh9dUAeKg1UtiSce3r6Rlkt7NZG
	qIToZTnegQa10FbPzHFs+21XG8fPMSJ9luRmHf0Tcez7mIKtXf9cvIyEX0qlJeupy/3EGv
	MrWDfRryvUUNfeFlQnZP3sB5mO5Z0Q7yCadc1YSb2Q4hFOq0DMbigaRqE5MeN8JAuyOXOS
	tdRwbxKu/TiRONaFFbT1o0xDZe9esDi5hlY10LwDmFTJoQ+xZELZxa87B0WtIdPEUOanPV
	hRLRzekmcstDQk4EaSTKY5DBrLMkgQ6hPQxyzj9+v0rfzvpRPaSdlch0EXpxZg==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Jun 2025 09:35:15 +0200
Message-Id: <DAEFD2WH7HRV.2SOG9Q00QSEXH@bootlin.com>
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
 <linux-stm32@st-md-mailman.stormreply.com>, <dwarves@vger.kernel.org>
Subject: Re: [Question] attributes encoding in BTF
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Andrii Nakryiko"
 <andrii.nakryiko@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
 <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com>
 <CAEf4Bzbn6BdXTOb0dTcsQmOMZpp5=DzGS2hHHQ3+dwcja=gv+w@mail.gmail.com>
 <D98Q8BRNUVS9.11J60C67L1ALR@bootlin.com>
 <CAEf4BzZHMYyGDZ4c4eNXG7Fm=ecxCCbKhKbQTbCjvWmKtdwvBw@mail.gmail.com>
 <D9E9IQQ3QKXM.3UJ17G9CBS1FH@bootlin.com>
 <DADMLIVHMSSO.3AXSI5216WCT6@bootlin.com>
 <9a2ba0ad-b34d-42f8-89a6-d9a44f007bdc@linux.dev>
In-Reply-To: <9a2ba0ad-b34d-42f8-89a6-d9a44f007bdc@linux.dev>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeffedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffvddufffhieffheetfffggeeugedtieduheeilefguddvheegvdeuffeuveeltdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvuddvrddutdehrdduhedtrddvhedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdduvddruddthedrudehtddrvdehvddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefvddprhgtphhtthhopehihhhorhdrshholhhoughrrghisehlihhnuhigrdguvghvpdhrtghpthhtoheprghnughrihhirdhnrghkrhihihhkohesghhmrghilhdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvt
 hdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Ihor,

On Wed Jun 4, 2025 at 7:31 PM CEST, Ihor Solodrai wrote:
> On 6/4/25 2:02 AM, Alexis Lothor=C3=83=C2=A9 wrote:

[...]

>> Could I be missing something obvious ? Or did I misunderstand the actual
>> attribute encoding feature ?
>
> Hi Alexis.
>
> The changes recently landed in pahole and libbpf re attributes had a=20
> very narrow goal: passing through particular attributes for some BPF=20
> kfuncs from the kernel source to vmlinux.h
>
> BTF now has a way of encoding any attribute (as opposed to only bpf=20
> type/decl tags) by setting type/decl tag kind flag [1]. So it is=20
> possible to represent attributes like packed and aligned in BTF.
>
> However, the BTF tags need to be generated by something, in case of=20
> vmlinux by pahole. Pahole generates BTF by parsing DWARF. And, as far as=
=20
> I understand, attributes are not (can not be?) represented in DWARF in a=
=20
> generic way, it really depends on specifics of the attribute.
>
> In order to support packed/aligned, pahole needs to know how to figure=20
> them out from DWARF input and add the tags to BTF. And this does not=20
> happen right now, which is why you don't see anything in bpftool output.
>
> [1]=20
> https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.=
dev/

Thanks for the details ! I have missed this possibility, as I have been
assuming that DWARF info was exposing the needed info. I'll take a look at
it, but if those attributes can not be represented by DWARF, I'll have to
find another way of getting those packing/alignment modifications on data
type (eg: re-use/share btf__align_of from libbpf, as suggested by Andrii,
but it may not able to cover all cases).

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


