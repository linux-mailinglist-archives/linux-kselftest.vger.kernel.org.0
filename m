Return-Path: <linux-kselftest+bounces-18334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 902499850A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 03:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A677282F44
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 01:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D191474CC;
	Wed, 25 Sep 2024 01:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UYpEefUu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB7A7E796
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 01:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727228248; cv=none; b=JU9sKjRonM9fRwcxHG57tsz8nOriEC25vP1E25f28w9X/mxiuZYQtZ0va8edL1A5fielRZSg9c0gPCpYiG5AOzikyB49JJO1ngqXoPsLk1OnquxAguq0eVfwz87tvoeHrxbB76xa6jGnGj26ZAJ0t52ld850lkNGHS5WyeIInyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727228248; c=relaxed/simple;
	bh=BZaHkkXLrZxyKUJQEi/+1D/Onl/0da0dOYn7LMLZgB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCEfLvyc4I6aqA4Glm5Z55R2m3Yd+pPQVuEJtY1i5ewfF31CGBJaD8/RIJnjS7R7f+T/z/XN5OVPtufibrNasI9lrnWkvasYFpj8ponynVL/QgKDf32JnOOcUzLlSOYdbSRRDYaajBDlv5jIvcVR0kvVsXuPdJPC1TzEtClP/PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UYpEefUu; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <366e4392-bd00-4120-8585-a71b3952e365@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727228244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsjzIUFUK2eSpfDDLWyGCwHbfrqw1/UK8ZIA6jybj/4=;
	b=UYpEefUuJW30uWju94YCQi3A40EhvjHsRfoMjMSDZDRQW5/zV8jX5JjXb+nHtydgqfruoZ
	MwQu0M8xXbEJNqG7PshiFej0SbGoKfjHhWZV1kC7x9eGCeb6af6v5KDg8SxwdT1doRqsWl
	ByO9R8im93b1xPnNnIC8TY8+/h+BObI=
Date: Tue, 24 Sep 2024 18:37:06 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] selftests/bpf: convert test_xdp_features.sh
 to test_progs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Jakub Kicinski <kuba@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <20240910-convert_xdp_tests-v2-1-a46367c9d038@bootlin.com>
 <64df8d41-6cfb-45a9-8337-5cc04daedb60@linux.dev> <ZuVWmxoqXFI3qvVI@lore-desk>
 <20240914063828.7bd73c5e@kernel.org>
 <464e0ae0-d6e3-4da4-a157-f74260f96275@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <464e0ae0-d6e3-4da4-a157-f74260f96275@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/22/24 12:04 PM, Alexis Lothoré wrote:
> Hello all, sorry for the slow feedback, I have been off last week.
> 
> On 9/14/24 15:38, Jakub Kicinski wrote:
>> On Sat, 14 Sep 2024 11:25:47 +0200 Lorenzo Bianconi wrote:
>>> On Sep 13, Martin KaFai Lau wrote:
>>>> test a physical network device that supports a certain XDP features.
>>>>
>>>> iiuc, test_xdp_features.sh only uses the veth and veth will also be the only
>>>> device tested after moving to prog_tests/xdp_features.c? It is a reasonable
>>>> addition to test_progs for an end-to-end xdp test by using veth. However,
>>>> test_progs will not be able to test the physical network device.
>>>>
>>>> Lorenzo, is the xdp_features.c still used for device testing?
>>>
>>> correct, xdp_features.c is intended to test the real xdp features supported by
>>> the NIC under test (DUT), not just the advertised ones (iirc that was a
>>> requisite to add xdp kernel feature support). For this reason we need two
>>> separated processes running on the tester device and on the DUT (they are
>>> usually two different devices). test_xdp_features.sh was just a simple test
>>> script used to develop xdp_features.c.
>>> What about extending xdp_features.c to integrate it in the CI?
> 
> So IIUC Lorenzo's answer, we _need_ to keep the possibility to run this test on
> real hardware, and so we _need_ to still be able to run two processes, possibly
> on two different machines. If that's so, indeed my rework breaks this. I have
> then multiple questions/doubts before being able to rework this:
> - the main goal of this rework is to be able to automatically run this test in
> CI, and the resulting constraint is that it must integrate in a standalone,
> already-existing c program (test_progs). I guess I can preserve the standalone
> xdp_features program as it is, and make test_progs just start  it twice (on two
> different veths). It would involve the following changes:
>    - keep a dedicated build step for this small, standalone xdp_features.c, and
> add a "controller" part in test_progs (instead of fully migrating xdp_features
> program into test_progs, which  is what the current series revision does)
>    - simply make the controller part create the testing network in CI, fork/start
> the xdp_features program on both veths, and check return codes.
> My main concern is about the possible flakiness of this whole setup (multiple

The test could be simpler if it does not need to run in two separate machines.

Also, there are bpf_prog_test_run_opts() style tests that provide a device 
agnostic way to test the xdp helpers/features which should have covered most of 
the cases exercised in progs/xdp_features.c?

I am not sure which case in xdp_features.c does not have existing coverage in 
test_progs. From a quick look, it seems only BPF_MAP_TYPE_CPUMAP is missing 
(please check)? If that is the case, it may be more straight forward to add this 
one test case to the test_progs. Check if it can borrow a similar setup from 
prog_tests/test_xdp_veth.c, and then leave xdp_features.* as-is.

There are other .sh tests that could better use the test_progs migration. In 
particular the ones without existing test coverage. For non XDP related, 
test_tcp_check_syncookie.sh, test_flow_dissector.sh, and test_tc_edt.sh should 
be the good ones.

For XDP, test_xdp_meta.sh should be useful also. You may also want to check the 
test_xdp_redirect_*.sh.

> processes and tcp/udp channels involved), but if keeping the standalone version
> is really needed, I can give a try. Does it sound reasonable ?
> - one part of my overall goal is to clean up the tools/testing/selftests/bpf
> directory from anything that is not tested automatically. What should we do with
> the wrapping shell script (test_xdp_features.sh) ? Since test_progs will
> automate the test with veths, I guess it is still ok to just remove it ?
> 
>> No preference but just to raise awareness - drivers/net's NetDrvEpEnv
>> class provides the setup for running tests with an endpoint.
>> XDP tests intended for HW would fit there pretty well.
> 
> Thanks for the hint. If we want to keep some tooling for real hw xdp features
> testing, maybe we could add a small part in tools/testing/selftests/drivers/net
> and make it use this NetDrvEpEnv ? Or it is a bigger hint that the whole test
> about xdp features could be moved there (and then tested by net kselftests
> rather than by ebpf ci specifically) ? @Lorenzo and eBPF tests maintainers, any
> opinion ?
> 
> Thanks,
> 
> Alexis
> 


