Return-Path: <linux-kselftest+bounces-15377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC2A9527E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 04:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F520B23C6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCBA17BD9;
	Thu, 15 Aug 2024 02:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LVKT8ne8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7687418D645
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Aug 2024 02:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723688447; cv=none; b=lgiF2sCK+PhAh2wU3fhgb8HjknbEedKJT9x+VDdx1SoV4FIVE79L35KbJkQNa1+Sfexiuu0lQhHw9jjQsnMkN2+ztn5xqCXLY8nA+BMDNBkRsjghO8/beNmBtHrnXTsK5EMPpIDQRlAD8S+1lLE/7GpGx5YQ5gINuAqPdTGIv4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723688447; c=relaxed/simple;
	bh=uTYV/i2mmeaFISVM+f5xfq37Kh3MLObLQwPJyC/iYVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/SnE2XrQDU6qNMsW5XPTSp+HroPjRNbuBI41Q+krQezNkiLDgcvX8UhDEw9f/JDPCtbnTD31sXxfdK7sGTuNMxInHgSDF7RFvKCyi5+ELWGqj0bbvQ2IImyXt9aK4LO4d20ae8tH80dtQ7psMn43dNLNsaDJHw3BUf2qw/OVtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LVKT8ne8; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7f47361f-caf8-45f2-9aaf-4a2a49eb525b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723688443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GwUSDDskNaj0YNOeVeXi3Aj4Ia8fnkvghuvgK9Y1tws=;
	b=LVKT8ne8D0WbFggkxd8lnFZcx1hXLDXiH/hdfDesdRDuoJXw94ieyXkng2Orrsxa7oNVRc
	uhjb6KeT6ppuWHb8KX1+9SuWJIwg3P634tMvgkZQOsAcpQDzSEIv5nD8BsGkVa2VGES0+C
	b0ikw78BCTDqfJ3ptTenEQQTBVVQDIo=
Date: Wed, 14 Aug 2024 19:20:31 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 4/4] selftests/bpf: convert
 test_skb_cgroup_id_user to test_progs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
References: <20240813-convert_cgroup_tests-v4-0-a33c03458cf6@bootlin.com>
 <20240813-convert_cgroup_tests-v4-4-a33c03458cf6@bootlin.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240813-convert_cgroup_tests-v4-4-a33c03458cf6@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/13/24 5:45 AM, Alexis Lothoré (eBPF Foundation) wrote:

> +#define DST_ADDR "ff02::1"

[ ... ]

> +static int wait_local_ip(void)
> +{
> +	char *ping_cmd = ping_command(AF_INET6);
> +	int i, err;
> +
> +	for (i = 0; i < WAIT_AUTO_IP_MAX_ATTEMPT; i++) {
> +		err = SYS_NOFAIL("%s -c 1 -W 1 %s%%%s", ping_cmd, DST_ADDR,
> +				 VETH_1);

I tried in my qemu. This loop takes at least 3-4 iteration to get the ping 
through. This test could become flaky if the CI is busy.

I have been always wondering why some of the (non) test_progs has this practice.
I traced a little. I think it has something to do with the "ff02::1" used in the 
test and/or the local link address is not ready. I have not further nailed it 
down but I think it is close enough.

It will be easier to use a nodad configured v6 addr.

I take this chance to use an easier "::1" address for the test here instead of 
ff02::1. This also removed the need to add veth pair and no need to ping first.

Applied with the "::1" changes mentioned above.

Thanks for migrating the tests to test_progs. This is long overdue.




> +		if (!err)
> +			break;
> +	}
> +
> +	return err;
> +}
> +

