Return-Path: <linux-kselftest+bounces-27199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880D4A3FC7E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 18:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A8FC7AD49F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 16:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7CB21CC59;
	Fri, 21 Feb 2025 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TYK6ehXe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAC9216E00;
	Fri, 21 Feb 2025 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157113; cv=none; b=ef4VpgHRlOuvSFsVp5vXFgxz6k1r1hQfYxWB8XREfvlWlb3oeCEj9z+6LQgfjZqEctjPg//xaCo4E1pE9FCDEfgMJHmUlQzfGj9E0opRcRY2+/CsOs0XvGaoMJBxiINq+wqydZ3dsf8bweobkV8TQJaY9shhGREIa4AUkgG/318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157113; c=relaxed/simple;
	bh=a9YmoQJudTCJXJbygeI13L8U1BuxiSVyIGvEwomsDj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=brmDyP2OsG9bvVv+BgmHeAmyXEoO5hsDowVWMKlNIJGRD1Xgm1+3F1pQXnXFE63e+2Kj3Z+aXtjt2fqCcHN5VkY2uouXyh47sEa1MYbDqIS8c+y/2JnL9tJj5QdHuZnXkb5vPENRal4SdrD14eChR51dcfbzBf0YVC0RuFNOtMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TYK6ehXe; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E21244327;
	Fri, 21 Feb 2025 16:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740157103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E0vFszfjLRPUBsYWT5+eUQORh5cGIC4pgSuTijYp52A=;
	b=TYK6ehXeLbHK0RIEExHccJKgNtcaYsy53jurbwoa4CiaZqXiOv96PkqPPed+4qwAYpjAuO
	r2uhzLSM4bH6moFmPA2saexW4KimCSKoGMXa9hpqk9Lgf5vynKkwJwe3tADJjZxFz6tw78
	C4mULaELttNGUC0aQyQMG+PLkRTKcfHJ5svUbmhyVud1is/g4ZRumQwGBlgx/nFDAV4vNj
	FF95HbqmPoG0cegOhkGupJZXzmmqlu7u2D5MQijyFopXD3na0bVoFWlOXhgGaeD4Qnn4n9
	Yo27SAheJ0IDMmb/mJk47MKUbAybOUZu16HVxvGmS4ku/9b7Z/Ibw8yYp7Ji1g==
Message-ID: <b41cb993-3cdf-4cfb-a131-14c1a66c8824@bootlin.com>
Date: Fri, 21 Feb 2025 17:58:18 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] arm64, bpf: Add 12-argument support for bpf
 trampoline
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay12@gmail.com>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Florent Revest <revest@chromium.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20240705125336.46820-1-puranjay@kernel.org>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240705125336.46820-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeduuedugeevveelledtudegleethfffuedtgffhlefgudektdeuheegkeekudehfeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplgfkrfggieemvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhegnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopehpuhhrrghnjhgrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehio
 hhgvggrrhgsohigrdhnvghtpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhigrdguvghv
X-GND-Sasl: alexis.lothore@bootlin.com

Hello everyone,

On 7/5/24 14:53, Puranjay Mohan wrote:
> The arm64 bpf JIT currently supports attaching the trampoline to
> functions with <= 8 arguments. This is because up to 8 arguments can be
> passed in registers r0-r7. If there are more than 8 arguments then the
> 9th and later arguments are passed on the stack, with SP pointing to the
> first stacked argument. See aapcs64[1] for more details.
> 
> If the 8th argument is a structure of size > 8B, then it is passed fully
> on stack and r7 is not used for passing any argument. If there is a 9th
> argument, it will be passed on the stack, even though r7 is available.
> 
> Add the support of storing and restoring arguments passed on the stack
> to the arm64 bpf trampoline. This will allow attaching the trampoline to
> functions that take up to 12 arguments.
> 
> [1] https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#parameter-passing
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

[...]

+cc Xu Kuohai + cc Florent Revest, who are involved in [0]

We at Bootlin are currently working on improving eBPF selftests coverage and
aligning ARM64 support with other platforms. For this second topic, one
remaining point is the support for 12 arguments in bpf trampolines. It looks
like a big part of the work has been done and submitted through two different
versions, the first one from Xu ([0]), and this one from Puranjay ([1]). There
is still some rework needed in both versions to properly handle some alignment
constraints.

@Puranjay @Xu are you (or anyone else) actively working on those series (I kind
of understand that you both agreed that Puranjay was continuing this work) ? If
so, if there a way to assist you on this topic ? If not, can we take and revive
your work to try to handle the missing points and make this feature integrated ?

Thanks,

Alexis

[0] https://lore.kernel.org/bpf/20230917150752.69612-1-xukuohai@huaweicloud.com/
[1] https://lore.kernel.org/bpf/20240705125336.46820-1-puranjay@kernel.org/

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

