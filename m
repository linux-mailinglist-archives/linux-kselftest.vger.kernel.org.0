Return-Path: <linux-kselftest+bounces-18198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367B597E0D2
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Sep 2024 12:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C48F1C20A06
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Sep 2024 10:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383D4136328;
	Sun, 22 Sep 2024 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dA4av/9V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DEB273FC;
	Sun, 22 Sep 2024 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726999516; cv=none; b=fQeno6hJrMbG8Yx6BUzd5e286VPdOarlWlfLmKB3kzfLX26UoqaeibNhmOa/QMoNVAi19vdbPX8iP3sQvAfv9nxXZWGn/MbaeykkTsb6pmoR4Cqwzm9XNMhv3Uz/bjVKpy9vBRTRrT9JXWfOG/z59YTj8/8kTD97UTSLaNm/i4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726999516; c=relaxed/simple;
	bh=YnLtsOfTjT9EQgqTzxpvhc1dEV1mk5RAxzYv6QT3UG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bUe14GlKJDhsM5dr85ghT1UVa7manf4dQo1h41GOX35rcrMTcAEl3UB+PlUVNaT/rycxDIODEQlfcOu7fzJtWB2/Kf3DU6ucEREHLZuO0eJ/sck/Jf8lPHUVBrd3oll5oEqTmqjYBp7brYe7er/ev3SqC19NoYl1sUs486NYr6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dA4av/9V; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 10B8F20003;
	Sun, 22 Sep 2024 10:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726999505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jFkKQu0XpPY3Dq9x7D5aT3zWAuzC7LNnMPNJnHsb9us=;
	b=dA4av/9V/GIHM6T9ynpPQ38492Fr3lu6VVV0wKCRvbDcCaP8rNHaN/fV7dCrpCv8dGFxsF
	AB1Q3BKtgMNT81jn8SLcLTnYXpifv+KXhYyiimv25049cNHx4KXD7qFr8zWxsT4T88zHbO
	Zs6/9dAtYnO2QZRT5cqoqxYukKuknNdIwCZETNKfjxmrA1DFwPf+AOYwT7ZrTLMNji2+Zu
	Io+/I6XwOS7t2Kc87SlBiFKj6byykbfy+bklMfrCUVZTkZGcl5UtFEWwJL1/CSPpGwMza2
	Ppbho/ka7lzjzIENcOrl9j3/yLcwEPZkdyt3sz0J9Mxq+XpUXNjlN1Iqx+HACQ==
Message-ID: <464e0ae0-d6e3-4da4-a157-f74260f96275@bootlin.com>
Date: Sun, 22 Sep 2024 12:04:59 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: convert test_xdp_features.sh
 to test_progs
To: Jakub Kicinski <kuba@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
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
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <20240914063828.7bd73c5e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello all, sorry for the slow feedback, I have been off last week.

On 9/14/24 15:38, Jakub Kicinski wrote:
> On Sat, 14 Sep 2024 11:25:47 +0200 Lorenzo Bianconi wrote:
>> On Sep 13, Martin KaFai Lau wrote:
>>> test a physical network device that supports a certain XDP features.
>>>
>>> iiuc, test_xdp_features.sh only uses the veth and veth will also be the only
>>> device tested after moving to prog_tests/xdp_features.c? It is a reasonable
>>> addition to test_progs for an end-to-end xdp test by using veth. However,
>>> test_progs will not be able to test the physical network device.
>>>
>>> Lorenzo, is the xdp_features.c still used for device testing?
>>
>> correct, xdp_features.c is intended to test the real xdp features supported by
>> the NIC under test (DUT), not just the advertised ones (iirc that was a
>> requisite to add xdp kernel feature support). For this reason we need two
>> separated processes running on the tester device and on the DUT (they are
>> usually two different devices). test_xdp_features.sh was just a simple test
>> script used to develop xdp_features.c.
>> What about extending xdp_features.c to integrate it in the CI?

So IIUC Lorenzo's answer, we _need_ to keep the possibility to run this test on
real hardware, and so we _need_ to still be able to run two processes, possibly
on two different machines. If that's so, indeed my rework breaks this. I have
then multiple questions/doubts before being able to rework this:
- the main goal of this rework is to be able to automatically run this test in
CI, and the resulting constraint is that it must integrate in a standalone,
already-existing c program (test_progs). I guess I can preserve the standalone
xdp_features program as it is, and make test_progs just start  it twice (on two
different veths). It would involve the following changes:
  - keep a dedicated build step for this small, standalone xdp_features.c, and
add a "controller" part in test_progs (instead of fully migrating xdp_features
program into test_progs, which  is what the current series revision does)
  - simply make the controller part create the testing network in CI, fork/start
the xdp_features program on both veths, and check return codes.
My main concern is about the possible flakiness of this whole setup (multiple
processes and tcp/udp channels involved), but if keeping the standalone version
is really needed, I can give a try. Does it sound reasonable ?
- one part of my overall goal is to clean up the tools/testing/selftests/bpf
directory from anything that is not tested automatically. What should we do with
the wrapping shell script (test_xdp_features.sh) ? Since test_progs will
automate the test with veths, I guess it is still ok to just remove it ?

> No preference but just to raise awareness - drivers/net's NetDrvEpEnv
> class provides the setup for running tests with an endpoint.
> XDP tests intended for HW would fit there pretty well.

Thanks for the hint. If we want to keep some tooling for real hw xdp features
testing, maybe we could add a small part in tools/testing/selftests/drivers/net
and make it use this NetDrvEpEnv ? Or it is a bigger hint that the whole test
about xdp features could be moved there (and then tested by net kselftests
rather than by ebpf ci specifically) ? @Lorenzo and eBPF tests maintainers, any
opinion ?

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


