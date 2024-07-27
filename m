Return-Path: <linux-kselftest+bounces-14294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA8993DDBF
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 10:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3F01C214F8
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 08:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB12429422;
	Sat, 27 Jul 2024 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wa9q5I+T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB68F1D6AA;
	Sat, 27 Jul 2024 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722067323; cv=none; b=G1SnSnEEhPvZAfNOP+BZbPLRckozNbx8EP7SMGNhfIx8Vqovv3tiFAWAUZsR1/uA083yHECFGD8nK486y4LSFjCrfQKa4NGL1VZZL6riD8jHlU30EA8b0GBbBnMt6lkFik2fNbkugwfWLf8fn6wXcI6UGm2GSaZ9+NHlYG7XeZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722067323; c=relaxed/simple;
	bh=mdcJkFB49JmOpnRi+kpVlAJl4fXO5aIGn39/HbtdPsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbbJi3kQhhSkWq88KmWq9vGfgcnLNtpTMRILuXEQQoxfcvyml9LVRbv6gaEBQdRg6HGp7IHnyCKja9WboE2B3OF9/A12Nyd392jsTpkXVI352A3SEgu+g1wLLeNY+A1LYWDP+Xv5SZCMk1YZhU7l/HWm6d+BkhN1fRNirw6q5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wa9q5I+T; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BB31560002;
	Sat, 27 Jul 2024 08:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722067312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6uMBuMchtwex6uGK0qq/OZQ28GDoazXlDxQCkRDqwnI=;
	b=Wa9q5I+TUVQWnSo2LVPkjd8wjlmryMWGo6OD4H0icEnCRgKYjc+3CVmiYq0LSpCOUVjw9G
	hOcTgCV/gN/C8+IkuSQ9qxscIFAKJ9WRNy8HudFxoMh4oIXutEigMH6IeyQceiO4aqgXhK
	Ss9AQi9+5gFKwud+aYUDQw4pF3AmE4iDmpN1HuQl7OQjaJBJeiVMcZXQ2L6rNIcwMjpfiF
	KhqpqFsAI46ZZ8gqZq/bR1O5Yr0RliWoUSqDGLo5V/1HLMR3z52wnyDgKHRvvbwWalDmCD
	C9wYbrjNt6gnwNmhX7tbysS6MkMi8bHozpp2LFjfIH0M/SXH7ghCXQHtA6tUJA==
Message-ID: <62dcbdd6-c648-40a5-8346-3a290d8d0020@bootlin.com>
Date: Sat, 27 Jul 2024 10:01:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] selftests/bpf: convert test_dev_cgroup to test_progs
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240725-convert_dev_cgroup-v1-0-2c8cbd487c44@bootlin.com>
 <ZqQoCNV-VFD7z0UD@mini-arch>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <ZqQoCNV-VFD7z0UD@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 7/27/24 00:49, Stanislav Fomichev wrote:
> On 07/25, Alexis Lothoré (eBPF Foundation) wrote:
>> Hello,
>> this small series aims to integrate test_dev_cgroup in test_progs so it
>> could be run automatically in CI. The new version brings a few differences
>> with the current one:
>> - test now uses directly syscalls instead of wrapping commandline tools
>>   into system() calls
>> - test_progs manipulates /dev/null (eg: redirecting test logs into it), so
>>   disabling access to it in the bpf program confuses the tests. To fix this,
>>   the first commit modifies the bpf program to allow access to char devices
>>   1:3 (/dev/null), and disable access to char devices 1:5 (/dev/zero)
>> - once test is converted, add a small subtest to also check for device type
>>   interpretation (char or block)
>> - paths used in mknod tests are now in /dev instead of /tmp: due to the CI
>>   runner organisation and mountpoints manipulations, trying to create nodes
>>   in /tmp leads to errors unrelated to the test (ie, mknod calls refused by
>>   kernel, not the bpf program). I don't understand exactly the root cause
>>   at the deepest point (all I see in CI is an -ENXIO error on mknod when trying to
>>   create the node in tmp, and I can not make sense out of it neither
>>   replicate it locally), so I would gladly take inputs from anyone more
>>   educated than me about this.
>>

[...]

> Going forward, can you pls use [PATCH bpf-next] as a subject (or bpf when
> targeting bpf tree)? I'm not sure whether patchworks picks up
> plain [PATCH] messages..

Yes, my bad, I realized some time after sending that I may have missed some
proper patch prefix. I have just checked on patchwork and see this series and
the one I have sent before, so I guess there is no need to resend those, but
I'll make sure to apply the relevant prefix for next series.

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


