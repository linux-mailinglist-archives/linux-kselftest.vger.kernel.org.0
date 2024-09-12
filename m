Return-Path: <linux-kselftest+bounces-17868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1119772A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 22:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C7C1C23AF0
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 20:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BF81BFDF6;
	Thu, 12 Sep 2024 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WULTLVTq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724701BE860;
	Thu, 12 Sep 2024 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726172240; cv=none; b=Wbs4BmeTpyVBIFp3D8OJfrg4teQ4uY8c44/v4ZMxC12hdYjx6qCAHCpZLlTOSSMZ7xiv8X0ITya0G8LpPlOBm4QGHD5vkswwIVyH3BuPOhb4Uy3Q8ZAHfsXGrca0QyK0T0kH2V6iGZnkDqMbRv71L4qqN1xmbTx0Xt/C2/LfXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726172240; c=relaxed/simple;
	bh=8a+l0yLQWur4LKXx0doeTxIU/vtMw8YiiyuXqMHBOm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=laDS/M1DBoa02t3/aIzsmBy/Jt62e3TeNcSPNyPCUEUKqZFwjDPU7wHPUCtZl/ta3WyOoyxGG42cbJBVc6aaBaGeqZ9GAbabbhMrKxy5pyNeofZ0Lxb32W+03qw/SGD3WAVCa72QS20TxS2/0l60LWjlC1Q7CpZUattGLGur76s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WULTLVTq; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 882071C0006;
	Thu, 12 Sep 2024 20:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726172235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FHWP2eO7j89fwZAZ2ZAC37i/e8x92BhFYNL0dz2678=;
	b=WULTLVTq388DEtesiWaluvko106Vc8fjvhyDgcRAkDTUIiVTQUDeS7cQsYUzzRQgRINdNH
	aP/VJwKcLnrdxdT5kcepfLfN6O77qjqXgcNWQZApBtwB4PTxD6wA0/mEUVHs5s0VwBfIL+
	E/UFoGRbRqYBZYTCe1INUtZULUN1aQcvpnIi2nRABJLc/u8p8zAF3OrHOC/zI1V4vTMMM8
	YyUtV7IRT55KKuowZHylQ9bNrlL5jR3aCXWDyLn9W3ZZc77a785ZD1tVmRGd8pFvFbXjrW
	j6XWVYAg5bHMbNwzMseRWtT/hDbC79IQ60SA5lPxk+wgpzU12RdIUcfdzNZHqg==
Message-ID: <fb7db9a9-5b9a-4b77-8dc6-f30b839bec27@bootlin.com>
Date: Thu, 12 Sep 2024 22:17:13 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: convert test_xdp_features.sh
 to test_progs
To: Simon Horman <horms@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <20240910-convert_xdp_tests-v2-1-a46367c9d038@bootlin.com>
 <20240911141824.GZ572255@kernel.org>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240911141824.GZ572255@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Simon,

On 9/11/24 16:18, Simon Horman wrote:

[...]

>> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_features.c b/tools/testing/selftests/bpf/prog_tests/xdp_features.c
>> new file mode 100644
>> index 000000000000..bcb36a2d2767
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_features.c
>> @@ -0,0 +1,446 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/**
>> + * Test XDP features
>> + *
>> + * Sets up a veth pair, and for each xdp feature under test:
>> + * - asks the tested interface its xdp capabilities through bpf_xdp_query
>> + * - attach and run some specific programs on both interfaces to check if
>> + *   announced capability is respected
>> + */
> 
> Hi Alexis,
> 
> This is neither a full review nor an issue that needs to block progress.
> But, FWIIW, the comment above is not a Kernel doc, yet starts with '/**'.
> I suggest that it should start with '/*' instead.

ACK. I'll wait for more comments on the series, and add the fix to the
corresponding revision, if any.

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


