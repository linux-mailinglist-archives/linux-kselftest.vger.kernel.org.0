Return-Path: <linux-kselftest+bounces-14610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F11944825
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 11:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA241F29A9E
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 09:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88D61A01DF;
	Thu,  1 Aug 2024 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Djddsdsp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A003518CC02;
	Thu,  1 Aug 2024 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504122; cv=none; b=QEf342O4AqBA7csNIVsxq4RjLj/ae+J0RHFWIx8jeWOTHvs7FPxGEHpG+BYcAB2C1rOGC41SxIcDyGSbYOndun9XBdsCXKT8yBvl7BVfupjkQoRYIVVoxnRkU/ZWN4LfH/lhzeDbS9d/nktaJXcB3s7blZvf0R9hAFiOkQnGPtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504122; c=relaxed/simple;
	bh=bOHazO1XNo3FPxooGFmMDZ+MXhbTOZyFzvhcpFLZfJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2MC+Vo/bYZ9ugA4taPkcNnsbuPNoOrCVqJBaKCm/Gd9WNX3C9r5+jeArKznfop5909+CVe9UDc9lV4bNmAAdyfnFmyprht2qLbMRy06jK5QA7RWVSpI5dOwD3OKLDiBrsuzrpR0HRCQn23grqx1PtjPVO6DOinMPD7Vs6uOx3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Djddsdsp; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B27E1C0006;
	Thu,  1 Aug 2024 09:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722504112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4HCIO0dVyT6eaJvZvPYVXNvArOemmorRP26fyTuZAA=;
	b=DjddsdspWYB0DChHguhWDTHeyQaFSDfUlb8h4Ci/d1q+/Gv2Ka9NUEZj7pj6Wh+NPIeg2G
	ehGXEQ8YB5iC4OZZ9fLdhEhx8R6jd3J2kVv4kLxf21Yd33bH6k0z3Z+NvZPcKEMtwR7Fma
	GLfrWAOAEoVvWQsqNennXuIuu48U2wA6/K/7HPsYHvvQ7dRdnsTkeawBqn4Fo89nXAqtAQ
	Zh5BHyS9GQVG8YbKqJCyI39y5iCQOC3S47bqftkBZjbh4LLAJRd8pjZ4rhUBcFcAMAuqvb
	1ri/Z7XDBeHTwM/pDbG9NE/j3xpEYL9KUBlY5k5VnjDrpgSNNRbrbnvoaTE4vA==
Message-ID: <40683bcd-14df-40b6-9110-ce5c61e543af@bootlin.com>
Date: Thu, 1 Aug 2024 11:21:11 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: convert test_cgroup_storage
 to test_progs
To: Alan Maguire <alan.maguire@oracle.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240731-convert_cgroup_tests-v1-0-14cbc51b6947@bootlin.com>
 <20240731-convert_cgroup_tests-v1-2-14cbc51b6947@bootlin.com>
 <295cb8d1-89cc-4528-b255-f7d815f20a24@oracle.com>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <295cb8d1-89cc-4528-b255-f7d815f20a24@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 8/1/24 10:27, Alan Maguire wrote:
> On 31/07/2024 11:38, Alexis Lothoré (eBPF Foundation) wrote:
>> test_cgroup_storage is currently a standalone program which is not run
>> when executing test_progs.
>>
>> Convert it to the test_progs framework so it can be automatically executed
>> in CI. The conversion led to the following changes:
>> - converted the raw bpf program in the userspace test file into a dedicated
>>   test program in progs/ dir
>> - reduced the scope of cgroup_storage test: the content from this test
>>   overlaps with some other tests already present in test_progs, most
>>   notably netcnt and cgroup_storage_multi*. Those tests already check
>>   extensively local storage, per-cpu local storage, cgroups interaction,
>>   etc. So the new test only keep the part testing that the program return
>>   code (based on map content) properly leads to packet being passed or
>>   dropped.
>>
>> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> 
> Two small things below, but
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

[...]

>> +#define PING_CMD "ping localhost -c 1 -W 1 -q"
> 
> other tests seem to redirect ping stdout output to /dev/null ; might be
> worth doing that too.

That's in fact performed automatically by SYS_NOFAIL :)

#define SYS_NOFAIL(fmt, ...)						\
	({								\
		char cmd[1024];						\
		int n;							\
		n = snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);	\
		if (n < sizeof(cmd) && sizeof(cmd) - n >= sizeof(ALL_TO_DEV_NULL)) \
			strcat(cmd, ALL_TO_DEV_NULL);			\
		system(cmd);						\
	})

[...]

>> +{
>> +	__u64 *counter;
>> +
>> +	counter = bpf_get_local_storage(&cgroup_storage, 0);
> 
> don't we need a NULL check for counter here? Or does the verifier know
> bpf_get_local_storage never fails?

Good question. Since the verifier accepted the prog during my tests, I indeed
assume that the returned pointer is always valid. Amongst all calls to this
function in progs involved in selftests, I found only one performing a check
before using the value (lsm_cgroup.c). So I guess it is fine ?

Thanks for the review !

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


