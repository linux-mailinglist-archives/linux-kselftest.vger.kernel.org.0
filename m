Return-Path: <linux-kselftest+bounces-28921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB50A5F18F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D613B3B78
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B886266B5B;
	Thu, 13 Mar 2025 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HvyPucYT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD53E266195;
	Thu, 13 Mar 2025 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863052; cv=none; b=mxpsD/4BF9Wt1d3+0bvbZoEgn5AyjIgric4Si/en1Iyr3mEe64D/2QVlZwQA3ToReIeoT4N6K2dG+Cvr0nIQudC8zcZ8aV8VTSDcGCVmiNPywyzi6rYgumxMK/6TCJUONVgVCk+sl1wZc7daZ5ozfMWXf6/coN7RtnQyLXlSsSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863052; c=relaxed/simple;
	bh=oVy0cVKR3jnRQR9b9LzES7dRLuOGWGub+pL1XJgxRbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKA5nlaRA23TXI8uBD6l17IGPceUg3LC9r4r2v4scL83hTNDynPJBOzYFwmO0wFSwFpTk0vY7hTeKv6TqhTM+4F9Bu0nJRXcpdKP+kM5fMRrTvuHdggpR2EKLJ/fI+/YvEBjztiBqhF6diLPwO0xImlXNABmv5IpnGDGaaMRqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HvyPucYT; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82D6B20580;
	Thu, 13 Mar 2025 10:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741863048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uOITDFtnC2am2jE/8iAJD13cqPTCzjCXOB1nvGVtI4A=;
	b=HvyPucYT83b6tgQG02b7bNj2fOg0O2TSp+HByuTY/T8NsCw8gXsCz/Bd96NpnpIQAY8i3H
	mtb86/ccunJmwMuWwixE40oNzOGzoZnxnORyLrRlQgapDpETNo4ZQhE1PYYm2vs6T2fi0M
	5ihWS/fc7THU+3HPs9jgG8FD+XRbGvjzOFCAxY6IjLKtToduxCvmvmZ31+Aun2KISAe1h2
	wc0h/yZVxJaAwqk+xE4sra8ERUD3BYIGCDytAQpDKjea+NBUymI1wLatMP2EPkm2u6Iy72
	QHs79baxwFpdbpUmA0BBvCF/Kj4qzRE3mdTxMvm1bb70BiT0boEFvPWXEpoS/g==
Message-ID: <b763537b-669e-4027-98fc-64ba39314949@bootlin.com>
Date: Thu, 13 Mar 2025 11:50:45 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] selftests/bpf: Integrate test_xsk.c to test_progs
 framework
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250313-xsk-v1-0-7374729a93b9@bootlin.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <20250313-xsk-v1-0-7374729a93b9@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdejjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegrshhtihgvnhcuvehurhhuthgthhgvthcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhheeggfetffekheevuedvkedvvdeufeegjeevgfelveevveetffevfefgheeijeenucfkphepvdgrtddumegtsgduleemkedvheefmeguuddttdemfhelvgdumeeftgejudemjeeitdgtmedutggsrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekvdehfeemugdutddtmehflegvudemfegtjedumeejiedttgemudgtsggrpdhhvghloheplgfkrfggieemvdgrtddumegtsgduleemkedvheefmeguuddttdemfhelvgdumeeftgejudemjeeitdgtmedutggsrggnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepsghjohhrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrghhnuhhsrdhkrghrlhhsshhonhesi
 hhnthgvlhdrtghomhdprhgtphhtthhopehmrggtihgvjhdrfhhijhgrlhhkohifshhkihesihhnthgvlhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdrlhgvmhhonhesghhmrghilhdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghv
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi all,

On 3/13/25 11:47 AM, Bastien Curutchet (eBPF Foundation) wrote:
> Hi all,
> 
> This patch series continues the work to migrate the script tests into
> prog_tests.
> 
> The test_xsk.sh script tests lots of AF_XDP use cases. The tests it uses
> are defined in xksxceiver.c. As this script is used to test real
> hardware, the goal here is to keep it as is and only integrate the
> tests on veth peers into the test_progs framework.
> Three tests are flaky on s390 so they won't be integrated to test_progs
> yet (I'm currently trying to make them more robust).
> 
> PATCH 1 & 2 fix some small issues xskxceiver.c
> PATCH 3 to 9 rework the xskxceiver to ease the integration in the
> test_progs framework. Two main points are addressed in them :
>   - wrap kselftest calls behind macros to ease their replacement later
>   - handle all errors to release resources instead of calling exit() when
>     any error occurs.
> PATCH 10 extracts test_xsk[.c/.h] from xskxceiver[.c/.h] to make the
> tests available to test_progs
> PATCH 11 enables kselftest de-activation
> PATCH 12 isolates the flaky tests
> PATCH 13 integrate the non-flaky tests to the test_progs framework
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> ---
> Bastien Curutchet (eBPF Foundation) (13):
>        selftests/bpf: test_xsk: Initialize bitmap before use
>        selftests/bpf: test_xsk: Fix memory leaks
>        selftests/bpf: test_xsk: Wrap ksft_*() behind macros
>        selftests/bpf: test_xsk: Add return value to init_iface()
>        selftests/bpf: test_xsk: Don't exit immediately when xsk_attach fails
>        selftests/bpf: test_xsk: Don't exit immediately when gettimeofday fails
>        selftests/bpf: test_xsk: Don't exit immediately when workers fail
>        selftests/bpf: test_xsk: Don't exit immediately if validate_traffic fails
>        selftests/bpf: test_xsk: Don't exit immediately on allocation failures
>        selftests/bpf: test_xsk: Split xskxceiver
>        selftests/bpf: test_xsk: Make kselftest dependency optional
>        selftests/bpf: test_xsk: Isolate flaky tests
>        selftests/bpf: test_xsk: Integrate test_xsk.c to test_progs framework
> 
>   tools/testing/selftests/bpf/Makefile              |   13 +-
>   tools/testing/selftests/bpf/prog_tests/test_xsk.c | 2416 ++++++++++++++++++++
>   tools/testing/selftests/bpf/prog_tests/test_xsk.h |  299 +++
>   tools/testing/selftests/bpf/prog_tests/xsk.c      |  178 ++
>   tools/testing/selftests/bpf/xskxceiver.c          | 2543 +--------------------
>   tools/testing/selftests/bpf/xskxceiver.h          |  153 --
>   6 files changed, 3021 insertions(+), 2581 deletions(-)
> ---
> base-commit: 720c696b16a1b1680f64cac9b3bb9e312a23ac47
> change-id: 20250218-xsk-0cf90e975d14

I realize that I forgot to mention 'bpf-next', sorry about that.
This work is based on the bpf-next_base branch.

Best regards,
Bastien



