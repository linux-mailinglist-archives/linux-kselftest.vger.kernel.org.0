Return-Path: <linux-kselftest+bounces-44432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3857C2122F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 17:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8370188E607
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAE133C530;
	Thu, 30 Oct 2025 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D+quNg75"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7609279329
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841308; cv=none; b=EQeQbnbXucqwYYFNJ8D1KHlaYCh0i1C100U5jXrxocZzGUkR1Zo3B72XKv/RC20i3itna6KiUIyQl/+F3fqaOWKv77KmaHtj0+ckhLU22cH+QodAhgepGHmtjmUAS27P9/R6DmRE+DpkeGPSotKgXXovJFJ7H+NQslpIq2t5i7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841308; c=relaxed/simple;
	bh=kX0cm2UnEiNJ+qzpBPfgy3+r4pATEZSTxmE6WFa7VM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsB/VoRp5Jn9H2fXA9cRRQlepgfgPqPSObTiwHgYeB6OpnxL4Ke3rUBTWMBI3MPhdgWLpW8K64xsmToFs8ubwyEbFScVvXrkrNiUfRL+8xKS/YoHLFLacSNz+TJ15UrwiSJHNuG3HcZZ3UOHpVTC2xfVcbBBadvOCMHFer3vQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D+quNg75; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <efa3540a-1f52-46ca-9f49-e631a5e3e48c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761841294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMFZXp3tx2YPKZtWsOkoNrm9qO50YlAqRAEraxEEN8U=;
	b=D+quNg75KVoxfK+nHvJSuj2ygg7TDLVMhoUvNdsp2A4jI2e8UFgRH8PNkDziKckOgJWo6m
	XCjmHu5mbjBRYXqAEWVnZUdaXYPvszj58fBy+J+k8NbwQ19z9vnwjD4s2+UYBPL6BWxKY5
	O9a8dqI3BXq/QQIFqi9CKuODhqbUuFk=
Date: Thu, 30 Oct 2025 09:21:28 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/4] selftests/bpf: integrate
 test_tc_tunnel.sh tests into test_progs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251027-tc_tunnel-v3-0-505c12019f9d@bootlin.com>
 <20251027-tc_tunnel-v3-3-505c12019f9d@bootlin.com>
 <1ac9d14e-4250-480c-b863-410be78ac6c6@linux.dev>
 <DDVPPGIO5P1F.E3DWINA74BJ6@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <DDVPPGIO5P1F.E3DWINA74BJ6@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/30/25 7:04 AM, Alexis Lothoré wrote:
>>> +	int family = cfg->ipproto == 6 ? AF_INET6 : AF_INET;
>>> +
>>> +	cfg->server_fd = start_reuseport_server(family, SOCK_STREAM,
>>> +						cfg->server_addr, TEST_PORT,
>>> +						TIMEOUT_MS, 1);
>>
>> Why reuseport is needed? Does it have issue in bind() to the same
>> ip/port in the later sub-test?
> 
> Yes, I observed that is I use the bare start_server, I systematically have
> the first test passing, an all the others failing on the server startup
> with errno 98 (Address already in use). I have been assuming that it is due
> to some TIME_WAIT state on the freshly closed socket, but I may be missing
> something ?

Thanks for confirming. You are right. It should be the TIME_WAIT. Using 
SO_REUSEPORT works but become confusing on what the test is trying to do 
by starting only 1 reuseport server. reuseport is usually used with >1 
server listening on the same address. A better thing to do is to always 
setsockopt(SO_REUSEADDR) in start_server_addr for TCP.

