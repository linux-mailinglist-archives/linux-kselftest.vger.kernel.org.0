Return-Path: <linux-kselftest+bounces-31557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE8DA9AF77
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 15:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56C61B80BFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 13:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE5227F73B;
	Thu, 24 Apr 2025 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gI9Qi8iA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23D71A2381;
	Thu, 24 Apr 2025 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501929; cv=none; b=uNB7Iv45XPxbUi0tP2WPuSVsG4c0c5hDArU5VJtejSy93//XWmq0LBiQXKrxgQYuWc/+ZezISI0VUx8G+KDlrwGBiUUhDbvpFHfmvRsVHbApEcnBt//Q1q55xzpBYNFFJelr9sbnuWfgBUZ/BwQ1m8vkEq79CjGsVU3WOjNi/k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501929; c=relaxed/simple;
	bh=JT9l/+e3r1Y05jUzOsZqr8YD8XUbFvoCajdKIzKQ9jU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LVEy96ewaPV/JUlOihiskUl8xsnVeCAq8gFeFt9LeYq2vFmxePVbZ5hYbH1bYby6q25PSfpugM5MEC+U+1fj50mvWN3oGwPhP46YCMyNL9mh4NRWRrvaqWh7PV3uywxcT5ePDixWSZqGjp8/1WvIsD/o0MUZSzgOI1OTRAwG+fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gI9Qi8iA; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DD20543A18;
	Thu, 24 Apr 2025 13:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745501918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JT9l/+e3r1Y05jUzOsZqr8YD8XUbFvoCajdKIzKQ9jU=;
	b=gI9Qi8iAoHo/gBxh9R+vG0T3VpMLo5YARKDaRzoVfMvD3Kkj1HD5Uvt33GjFv5WHHyIurg
	ECYtVZKxvk99eb/wdY73MvgT6BzLddjF5SjDB51Tw5uNtdrI33XtLLs80gHarB744Bkjc8
	DWrmSkphdd1Al/1SSUT7QCcJtagYi/1cUE7+PJ4EEaJDPM57AcgG2SDDwq8/AKzS/+FWLy
	kwRznWKkWuxRt2VhPK65YLXmKWOid1ZPnDfDQYQF93h6yR1YeZIAcY73oWHtOV17t61Y2q
	E2lW9ycVZgB6kUDduFAin8Sbas/RVeP+GBA5ls/GR2BGECqPv+IEs2bEhMpV2A==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Apr 2025 15:38:35 +0200
Message-Id: <D9EWSDXHDGFJ.FIDSHIR1OP80@bootlin.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Puranjay Mohan"
 <puranjay@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Mykola Lysenko" <mykolal@fb.com>, "Shuah Khan"
 <shuah@kernel.org>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Florent Revest"
 <revest@chromium.org>, "Bastien Curutchet" <bastien.curutchet@bootlin.com>,
 <ebpf@linuxfoundation.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH RFC bpf-next 1/4] bpf: add struct largest member size in
 func model
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, "Andrii Nakryiko"
 <andrii.nakryiko@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
 <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com>
 <CAEf4Bzbn6BdXTOb0dTcsQmOMZpp5=DzGS2hHHQ3+dwcja=gv+w@mail.gmail.com>
 <D98Q8BRNUVS9.11J60C67L1ALR@bootlin.com>
 <CAEf4BzZHMYyGDZ4c4eNXG7Fm=ecxCCbKhKbQTbCjvWmKtdwvBw@mail.gmail.com>
 <D9E9IQQ3QKXM.3UJ17G9CBS1FH@bootlin.com>
 <6b6472c3-0718-4e60-9972-c166d51962a3@huaweicloud.com>
In-Reply-To: <6b6472c3-0718-4e60-9972-c166d51962a3@huaweicloud.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeelieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelkeehiefhfeehvefhtdegueelkeehffffffeuvdekkeekuddvueeguefgieeukeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedtpdhrtghpthhtohepgihukhhuohhhrghisehhuhgrfigvihgtlhhouhgurdgtohhmpdhrtghpthhtoheprghnughrihhirdhnrghkrhihihhkohesghhmrghilhdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehjohhhn
 hdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Xu,

On Thu Apr 24, 2025 at 2:00 PM CEST, Xu Kuohai wrote:
> On 4/24/2025 3:24 AM, Alexis Lothor=C3=A9 wrote:
>> Hi Andrii,
>>=20
>> On Wed Apr 23, 2025 at 7:15 PM CEST, Andrii Nakryiko wrote:
>>> On Thu, Apr 17, 2025 at 12:14=E2=80=AFAM Alexis Lothor=C3=A9
>>> <alexis.lothore@bootlin.com> wrote:
>>>>
>>>> Hi Andrii,
>>>>
>>>> On Wed Apr 16, 2025 at 11:24 PM CEST, Andrii Nakryiko wrote:
>>>>> On Fri, Apr 11, 2025 at 1:32=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Fou=
ndation)
>>>>> <alexis.lothore@bootlin.com> wrote:

[...]

>> Thanks for the pointer, I'll take a look at it. The more we discuss this
>> series, the less member size sounds relevant for what I'm trying to achi=
eve
>> here.
>>=20
>> Following Xu's comments, I have been thinking about how I could detect t=
he
>> custom alignments and packing on structures, and I was wondering if I co=
uld
>> somehow benefit from __attribute__ encoding in BTF info ([1]). But
>> following your hint, I also see some btf_is_struct_packed() in
>> tools/lib/bpf/btf_dump.c that could help. I'll dig this further and see =
if
>> I can manage to make something work with all of this.
>>
>
> With DWARF info, we might not need to detect the structure alignment anym=
ore,
> since the DW_AT_location attribute tells us where the structure parameter=
 is
> located on the stack, and DW_AT_byte_size gives us the size of the struct=
ure.

I am not sure to follow you here, because DWARF info is not accessible
from kernel at runtime, right ? Or are you meaning that we could, at build
time, enrich the BTF info embedded in the kernel thanks to DWARF info ?

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


