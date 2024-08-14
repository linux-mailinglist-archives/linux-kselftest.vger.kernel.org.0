Return-Path: <linux-kselftest+bounces-15290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEDF95116E
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 03:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DAC1F23D98
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 01:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F01B66F;
	Wed, 14 Aug 2024 01:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="njnjBOSL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9F5AD5A;
	Wed, 14 Aug 2024 01:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723597956; cv=none; b=JG8l9h9ewiX/5ZQBfGsbEsqHUmH64Kk8uuOBLgwpU5OL5QikOuhw6JRlb338zH8oayxSfVuuzVEGtMqAVLHAMwPrBHJ2d1y74P8inTozP4FBwOqpEEow33WKKiEyOLde+g/e7hC6JBu4AIOxqEyNlZPzVjnvOMUELSxnBCYjsyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723597956; c=relaxed/simple;
	bh=Tb69vJqo1ALtu5b0vp82iFIA4z8ojDKaQzyHh2enK58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMjEF8j52xznzhdSJf6B8/bcQBBGv55/kP0LoNAtSiqHkqGG1nlJb7CY27gZp57AbO4PleJ25Eyb/jqgiOo4wPl/Et5UJThWoujVHlIDogvurhZrOaAhDHkr2KieboyhNVywbinfztC2oko0hYFfx0h1Hwcpo+AGaO+1rh+prtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=njnjBOSL; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2136317a-3e95-4993-b2fc-1f3b2c28dbdc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723597952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kg3Yn9psi6orOdw+gE/xX9QBdKXuCDu+XFWCUGqknj0=;
	b=njnjBOSLSz/3Rw6McVXMEy0sMGYmKcFJKusbdJsaEWxfl7gJ4e+43jKEmlW7eCcPz1oGoA
	uEjT+UWCaX550on6UAhXxWkV7BLDagYkyvQmuwkBd8+ux9pW8G0JPdo7yjP01WRPQa99xM
	zaX/Z5nk5jexoKRrPOVGN+kMg0cuHuc=
Date: Tue, 13 Aug 2024 18:12:19 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add mptcp subflow subtest
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Daniel Xu <dxu@dxuuu.xyz>,
 Manu Bretelle <chantra@meta.com>
References: <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-0-2b4ca6994993@kernel.org>
 <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-2-2b4ca6994993@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-2-2b4ca6994993@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/5/24 2:52 AM, Matthieu Baerts (NGI0) wrote:
> +static int endpoint_init(char *flags)
> +{
> +	SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
> +	SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
> +	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
> +	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
> +	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
> +	if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags)) {
> +		printf("'ip mptcp' not supported, skip this test.\n");
> +		test__skip();

It is always a skip now in bpf CI:

#171/3   mptcp/subflow:SKIP

This test is a useful addition for the bpf CI selftest.

It can't catch regression if it is always a skip in bpf CI though.

iproute2 needs to be updated (cc: Daniel Xu and Manu, the outdated iproute2 is 
something that came up multiple times).

Not sure when the iproute2 can be updated. In the mean time, your v3 is pretty 
close to getting pm_nl_ctl compiled. Is there other blocker on this?

> +		goto fail;
> +	}
> +
> +	return 0;
> +fail:
> +	return -1;
> +}
> +
> +static int _ss_search(char *src, char *dst, char *port, char *keyword)
> +{
> +	return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d | grep -q '%s'",
> +			  NS_TEST, src, dst, port, PORT_1, keyword);
> +}
> +
> +static int ss_search(char *src, char *keyword)
> +{
> +	return _ss_search(src, ADDR_1, "dport", keyword);
> +}
> +
> +static void run_subflow(char *new)
> +{
> +	int server_fd, client_fd, err;
> +	char cc[TCP_CA_NAME_MAX];
> +	socklen_t len = sizeof(cc);
> +
> +	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
> +	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
> +		return;
> +
> +	client_fd = connect_to_fd(server_fd, 0);
> +	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
> +		goto fail;
> +
> +	err = getsockopt(server_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
> +	if (!ASSERT_OK(err, "getsockopt(srv_fd, TCP_CONGESTION)"))
> +		goto fail;
> +
> +	send_byte(client_fd);
> +
> +	ASSERT_OK(ss_search(ADDR_1, "fwmark:0x1"), "ss_search fwmark:0x1");
> +	ASSERT_OK(ss_search(ADDR_2, "fwmark:0x2"), "ss_search fwmark:0x2");
> +	ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
> +	ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");

Is there a getsockopt way instead of ss + grep?


