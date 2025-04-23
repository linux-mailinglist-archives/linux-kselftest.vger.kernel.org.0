Return-Path: <linux-kselftest+bounces-31446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5818EA9986E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 21:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B454A1152
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 19:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22D828D823;
	Wed, 23 Apr 2025 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JyMP61V2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6F22F32;
	Wed, 23 Apr 2025 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745436282; cv=none; b=sudxMfw0imd13WvpIXiCZnIpQKIIOEmRQVt5oeZ3EsxR6nlGHx3uB86DaY3huY5CgfpQ4VC4BxYhMsEU+E3Iu9pfANHXUAqQMrHjhf2WTJm4u0HEsupq7bOlahoGOnCtXAPcLZdHT3pUWbuE8cAn8v6QkxforsvH29qKndp0+Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745436282; c=relaxed/simple;
	bh=VuA5ArutcR/+rBv4LmxZZq5llGuXWDGBdcaQnWcGg3Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ixCa3Y55QzE94dM1thx62xtq2dduLq5np5nXYf4UaXjzfCxVU9tvYMtHXrOwvTQDyKlQNCpZiWALJoacp1EDwft9Sh+dU9krjAZIQe8OJFjhOvRRiDvqCbB8b2NK+vW8zR5TQ8PYiEAjxpUga8HM1iv1qKC70gzXr+uVxAsL1qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JyMP61V2; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 57DE443D43;
	Wed, 23 Apr 2025 19:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745436276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2tDrkkBQe3JKRslIUmoWfOqe7k2mOTW95nGkd+giIA=;
	b=JyMP61V2AwXdhFa/MfRsPknQuX+9zLoQUYtqvFgqLxqliWXnPJH34GipEY9qLDu8f7SOwF
	L8jxLNkDlXpvpCTUahNBDq64T+h8dShffNbUpErWHn1x/hthcTZ5Vhfb+11gcMowNWfteN
	lMtxy7eNihMWGR1cfiyeiBMHdFAh6/Qkp740gcZF/k3F/n5r2A+L97u2Wp7fBZWy0zuMo+
	PYecer6KKZ/ZgNu1gqyVkTs47GKuuYwTdT3yWzZ9AXC833zqNXwOSMWk8F7fOivfSBFC1Q
	gdPEfuqHmDoodf8h5KichaaTG/S7VwJ99WpomEnNl9DoF7NAvN0SmDDj5OvjeA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Apr 2025 21:24:34 +0200
Message-Id: <D9E9IQQ3QKXM.3UJ17G9CBS1FH@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
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
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
 <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com>
 <CAEf4Bzbn6BdXTOb0dTcsQmOMZpp5=DzGS2hHHQ3+dwcja=gv+w@mail.gmail.com>
 <D98Q8BRNUVS9.11J60C67L1ALR@bootlin.com>
 <CAEf4BzZHMYyGDZ4c4eNXG7Fm=ecxCCbKhKbQTbCjvWmKtdwvBw@mail.gmail.com>
In-Reply-To: <CAEf4BzZHMYyGDZ4c4eNXG7Fm=ecxCCbKhKbQTbCjvWmKtdwvBw@mail.gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeejgeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkhffvvefuofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehveevkeelvdejhffhudfhtdevvddvfffgiedtveejiefgveeljeduveetuddtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeftddprhgtphhtthhopegrnhgurhhiihdrnhgrkhhrhihikhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepjhhohhhnr
 dhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Andrii,

On Wed Apr 23, 2025 at 7:15 PM CEST, Andrii Nakryiko wrote:
> On Thu, Apr 17, 2025 at 12:14=E2=80=AFAM Alexis Lothor=C3=A9
> <alexis.lothore@bootlin.com> wrote:
>>
>> Hi Andrii,
>>
>> On Wed Apr 16, 2025 at 11:24 PM CEST, Andrii Nakryiko wrote:
>> > On Fri, Apr 11, 2025 at 1:32=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Foun=
dation)
>> > <alexis.lothore@bootlin.com> wrote:

[...]

>> Indeed I initially checked whether I could return directly some alignmen=
t
>> info from btf, but it then involves the alignment computation in the btf
>> module. Since there could be minor differences between architectures abo=
ut
>> alignment requirements, I though it would be better to in fact keep alig=
nment
>> computation out of the btf module. For example, I see that 128 bits valu=
es
>> are aligned on 16 bytes on ARM64, while being aligned on 8 bytes on S390=
.
>>
>> And since for ARM64, all needed alignments are somehow derived from size
>> (it is either directly size for fundamental types, or alignment of the
>> largest member for structs, which is then size of largest member),
>> returning the size seems to be enough to allow the JIT side to compute
>> alignments.
>
> If you mean the size of "primitive" field and/or array element
> (applied recursively for all embedded structs/unions) then yes, that's
> close enough. But saying just "largest struct member" is wrong,
> because for
>
> struct blah {
>     struct {
>         int whatever[128];
>     } heya;
> };
>
>
> blah.heya has a large size, but alignment is still just 4 bytes.

Indeed, that's another case making my proposal fail :)

> I'd suggest looking at btf__align_of() in libbpf (tools/lib/bpf/btf.c)
> to see how we calculate alignment there. It seems to work decently
> enough. It won't cover any arch-specific extra rules like double
> needing 16-byte alignment (I vaguely remember something like that for
> some architectures, but I might be misremembering), or anything
> similar. It also won't detect (I don't think it's possible without
> DWARF) artificially increased alignment with attribute((aligned(N))).

Thanks for the pointer, I'll take a look at it. The more we discuss this
series, the less member size sounds relevant for what I'm trying to achieve
here.

Following Xu's comments, I have been thinking about how I could detect the
custom alignments and packing on structures, and I was wondering if I could
somehow benefit from __attribute__ encoding in BTF info ([1]). But
following your hint, I also see some btf_is_struct_packed() in
tools/lib/bpf/btf_dump.c that could help. I'll dig this further and see if
I can manage to make something work with all of this.

Thanks,

Alexis

[1] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linu=
x.dev/

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


