Return-Path: <linux-kselftest+bounces-22008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A29809C8464
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 08:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E8A2838CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 07:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3557A1F5839;
	Thu, 14 Nov 2024 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bc4IW6F5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F191F4718;
	Thu, 14 Nov 2024 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571064; cv=none; b=h/fKOAx4CFr11277qHsicxUheS/LYvUJnG8XLtJguFqKEqhfGBDTRap+gmxaDDzUAcYyuXlY4gmEAHuKKKxwWQv30BTT51IWheHbU6Cy1McQU31FwY7f/6sSzyalWdOblStKPcc90W08XT+V+netMIG48Qm5kXxSHKgQdnLSsms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571064; c=relaxed/simple;
	bh=iAEOEoNOWFiIs5/OwjoUTJswC7CgiTryfEWzht/D81M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D2NxDBsK3awcH97G3/oB9S07v0YwKZlgnWGMdr9lFrC8b6V5nrcRxJ1s++xSc10LqJMPOAvnvlDWmc4Mu2TlAFn2u1PiDtaFhPFa5wXV8yGw1LAo+eQMktYaRDAO/vTvWUpDqGlPFZYPIJ8gwerEgzXf7Bt8zm24vQgTJAWd2N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bc4IW6F5; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BBCC2240003;
	Thu, 14 Nov 2024 07:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731571059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uW46j0hoRVyEJ1yAN4knY/aeYLI8Z+zPAW0pDq/7ANw=;
	b=bc4IW6F5O63KcseNnavL4GRs1/uM2CtRpf7gh0cY+vi5s8+SXiAnJ3d159TXwxVaESWHcL
	/SYBYd/usuwPWEZxKpf0ysVv5Swhi7pJm/9avBzz51E9CNVJ7Xx7nHQ+owvXfbFGMC5K7d
	O1Awekt1q3EC04wIQixR0mPk2Jt4CE+AbPCamQAqFF79O539illLI5E4/Rc5E84mr0y26l
	meLAJvMaX4Px0ZU/ITe4xqfVOOyEvLG8Rm8xkuO33iYouEXEU9LBlgb2qPZfS3TzPgIvoh
	dIeChYkrkSDL5mzWOjPEpaabFv+KUST3M1fOlwUJCnEwQEcNskezSuUG2d5SOQ==
Message-ID: <1a1df82b-6008-4be5-8f93-98fccfe7d40a@bootlin.com>
Date: Thu, 14 Nov 2024 08:57:37 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: Re: [PATCH bpf-next 04/10] selftests/bpf: re-split main function into
 dedicated tests
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Petar Penkov <ppenkov@google.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
 <20241113-flow_dissector-v1-4-27c4df0592dc@bootlin.com>
 <ZzTlAmxagJmqNRe7@mini-arch>
Content-Language: en-US
In-Reply-To: <ZzTlAmxagJmqNRe7@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Stanislas, thanks for the reviews !

On 11/13/24 18:42, Stanislav Fomichev wrote:
> On 11/13, Alexis Lothoré (eBPF Foundation) wrote:
>> The flow_dissector runs plenty of tests over diffent kind of packets,
>> grouped into three categories: skb mode, non-skb mode with direct
>> attach, and non-skb with indirect attach.
>>
>> Re-split the main function into dedicated tests. Each test now must have
>> its own setup/teardown, but for the advantage of being able to run them
>> separately.
>>
>> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
>> ---
>>  .../selftests/bpf/prog_tests/flow_dissector.c      | 92 ++++++++++++++--------
>>  1 file changed, 57 insertions(+), 35 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
>> index 6fbe8b6dad561aec02db552caea02517ac1e2109..c5dfff333fe31dd55ac152fe9b107828227c8177 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
>> @@ -549,63 +549,101 @@ static void run_tests_skb_less(int tap_fd, struct bpf_map *keys)
>>  	}
>>  }
>>  
>> -static void test_skb_less_prog_attach(struct bpf_flow *skel, int tap_fd)
> 
> [..]
> 
>> +void serial_test_flow_dissector_skb_less_direct_attach(void)
> 
> Any specific reason you keep these as serial? Seems like one of the benefits
> of splitting them up is to be able to run them in parallel?

I guess there is no reason (I added those while investigating the namespace
exclusivity test issue, and forgot to remove them). I'll remove the serial prefix.

By the way I realize that each of those new tests could likely benefit from
running in an isolated net namespace (especially if they can run in
parallel), I'll add that too in v2.

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

