Return-Path: <linux-kselftest+bounces-17962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A9C978B59
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 00:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554BF1C21FAE
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 22:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479B81714B3;
	Fri, 13 Sep 2024 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ipe4Y36K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE775155CBF;
	Fri, 13 Sep 2024 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726266137; cv=none; b=F5u/FHItA5VpsaSGjT69Ebm67h8Vs1Pq17KwwrM6KqCe4nLzEktn3pWoEzs1gMpzLdfMiAM/wdtWhSDvCqID28x9wJec00lCna6/S5fhVsCcRVqML16PJOBuV/rsO+XrPUUbWnNYpoHu63LOrWbLyc7Rkl7cwqiLQ6LOy9iDTOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726266137; c=relaxed/simple;
	bh=noINtl05AnaxJlcXICJMnSxhMo7Uk9YziGSVWFEaipM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3tCv4PwTfY3Gn7hpk8E9a5qJMd+4yyR4LehDfUZ9qrgrYrkPSCpZBI+ozzLu6VwGXKF3S2/vUIZHPUSf/4zT6pwOQiAwloaZF8ItSS0J7rxLVtzriLPyWaloF2Vda3NEB+Bi/+xSFiuh5AjIP3pE62rf/db6LKRcC6TlB5eKZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ipe4Y36K; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <64df8d41-6cfb-45a9-8337-5cc04daedb60@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726266132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0lJW6sFmgfQQpTvoEzsidtuTQ8v36dUp7qyMxSEEoMA=;
	b=Ipe4Y36KeC6qdSlEa543Oe3Du9WAH1bd5CHRxuYmbfWRpIaWERYvP/5C7ZKYFZtdElvPEc
	+SybDb6EldcjA07CfYPcmJBZEI7HD5BhS3gMTwuwPpNIC8KVZuBW9mr01RYPF9y1654kSB
	KcZnbwN5qstImFdrMcUgKn9WvyKi3xI=
Date: Fri, 13 Sep 2024 15:22:00 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] selftests/bpf: convert test_xdp_features.sh
 to test_progs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <20240910-convert_xdp_tests-v2-1-a46367c9d038@bootlin.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240910-convert_xdp_tests-v2-1-a46367c9d038@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/10/24 11:10 AM, Alexis Lothoré (eBPF Foundation) wrote:
> test_xdp_features.sh is a shell script allowing to test that xdp features
> advertised by an interface are indeed delivered. The test works by starting
> two instance of the same program, both attaching specific xdp programs to
> each side of a veth link, and then make those programs manage packets and
> collect stats to check whether tested XDP feature is indeed delivered or
> not. However this test is not integrated in test_progs framework and so can
> not run automatically in CI.
> 
> Rewrite test_xdp_features to integrate it in test_progs so it can run
> automatically in CI. The main changes brought by the rewrite are the
> following:
> - instead of running to separated processes (each one managing either the
>    tester veth or the DUT vet), run a single process
> - slightly change testing direction (v0 is the tester in local namespace,
>    v1 is the Device Under Test in remote namespace)
> - group all tests previously managed by test_xdp_features as subtests (one
>    per tested XDP feature). As a consequence, run only once some steps
>    instead of once per subtest (eg: starting/stopping the udp server). On
>    the contrary, make sure that each subtest properly cleans up its state
>    (ie detach xdp programs, reset test stats, etc)
> - since there is now a single process, get rid of the "control" tcp channel
>    used to configure DUT. Configuring the DUT now only consists in switching
>    to DUT network namespace and run the relevant commands
> - since there is no more control channel, get rid of TLVs, keep only the
>    CMD_ECHO packet type, and set it as a magic
> - simplify network setup: use only ipv6 instead of both ipv4 and ipv6,
>    force static neighbours instead of waiting for autoconfiguration, do not
>    force gro (fetch xdp features only once xdp programs are loaded instead)
> 
> The existing XDP programs are reused, with some minor changes:
> - tester and dut stats maps are converted to global variables for easier
>    usage
> - programs do not use TLV struct anymore but the magic replacing the echo
>    command
> - avoid to accidentally make tests pass: drop packets instead of forwarding
>    them to userspace when they do not match the expected payload
> - make sure to perform host <-> network endianness conversion on constants
>    rather than packet parts
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> Changes in v2:
> - fix endianness management in userspace packet parsing (call htonl on
>    constant rather than packet part)
> 
> The xdp_features rewrite has been tested in a x86_64 qemu environment on my
> machine and in CI. In my environment, the test takes a bit less than 2s to
> execute.
> 
>    # ./test_progs -a xdp_features
>    #561/1   xdp_features/XDP_PASS:OK
>    #561/2   xdp_features/XDP_DROP:OK
>    #561/3   xdp_features/XDP_ABORTED:OK
>    #561/4   xdp_features/XDP_TX:OK
>    #561/5   xdp_features/XDP_REDIRECT:OK
>    #561/6   xdp_features/XDP_NDO_XMIT:OK
>    #561     xdp_features:OK
>    Summary: 1/6 PASSED, 0 SKIPPED, 0 FAILED
> ---
>   tools/testing/selftests/bpf/.gitignore             |   1 -
>   tools/testing/selftests/bpf/Makefile               |  10 +-
>   .../selftests/bpf/prog_tests/xdp_features.c        | 446 +++++++++++++
>   tools/testing/selftests/bpf/progs/xdp_features.c   |  49 +-
>   tools/testing/selftests/bpf/test_xdp_features.sh   | 107 ---
>   tools/testing/selftests/bpf/xdp_features.c         | 718 ---------------------

 From the initial commit message of xdp_features.c, its primary usage is to test 
a physical network device that supports a certain XDP features.

iiuc, test_xdp_features.sh only uses the veth and veth will also be the only 
device tested after moving to prog_tests/xdp_features.c? It is a reasonable 
addition to test_progs for an end-to-end xdp test by using veth. However, 
test_progs will not be able to test the physical network device.

Lorenzo, is the xdp_features.c still used for device testing?


