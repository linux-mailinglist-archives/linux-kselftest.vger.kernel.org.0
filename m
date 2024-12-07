Return-Path: <linux-kselftest+bounces-22957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DEC9E7DAF
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Dec 2024 02:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BCE16D0A1
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Dec 2024 01:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B283522C6EB;
	Sat,  7 Dec 2024 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bTFOpAdc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F8F33DF
	for <linux-kselftest@vger.kernel.org>; Sat,  7 Dec 2024 01:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733534390; cv=none; b=Zmm5+LAdlFhM1/wnsw4QRBVmQAky21v8zmCBTS9IR36yMtBljbh8ABVukBZafXu/X+vpdFcX63EUy+m1cPFTennO/pqk+ABYHpeJnw2eRHaSTIdbUU9IEUv4Yt8XSS6AmCgXWv7cMTNyNk8pYNn8IrXvG7qHvu3t2671nWFISXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733534390; c=relaxed/simple;
	bh=ZukOdbFvqasZZ3raYS3UoqCZujhq4RIJwfsY74HV72Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQl+cmkedx3gajF2yj12fUFQeHx5cs84V4CsUZ7v1BDckKjKmEBnxqWegDg2mS00PSKnUDGZGQxJ90tw7EEqGW9DdmOyW1qG9KlZ1Jn8zmt8M5tJo9bQJJAEKiy2kNaVP+F1Pt3U4S27KSENK/uSYrRsMNF6rqFTzs/eU+zRhqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bTFOpAdc; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9c9074c1-a079-42aa-b1c0-a3fd5523e9f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733534385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/uNOUD5sUn4ce0l5tkusY9QEAAd1axiX1bAYXIZx728=;
	b=bTFOpAdc9qgYckcfW/FXYYyH0X8YZcu0ITbbplcG7JaVg2gPW0uslJuCuWpcUgTvZWMqEc
	1eNy5B9s9OltQEWkZ0kgF3FU5RIddwMumVreSENBbJD/1WE490ANBlYlSaVuyMT4Yxk02/
	BDpmAzWqW4LkPK/y8atgPByoS0q9rVY=
Date: Fri, 6 Dec 2024 17:19:35 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Migrate test_xdp_meta.sh into
 xdp_context_test_run.c
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Alexis Lothore <alexis.lothore@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241206-xdp_meta-v1-0-5c150618f6e9@bootlin.com>
 <20241206-xdp_meta-v1-2-5c150618f6e9@bootlin.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241206-xdp_meta-v1-2-5c150618f6e9@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/6/24 12:12 AM, Bastien Curutchet wrote:
> +void test_xdp_context_functional(void)
> +{
> +	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
> +	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
> +	struct bpf_program *tc_prog, *xdp_prog;
> +	struct netns_obj *rx_ns, *tx_ns;
> +	struct test_xdp_meta *skel;
> +	struct nstoken *nstoken;
> +	int rx_ifindex;
> +	int ret;
> +
> +	tx_ns = netns_new(TX_NETNS, false);
> +	if (!ASSERT_OK_PTR(tx_ns, "create tx_ns"))
> +		return;
> +
> +	rx_ns = netns_new(RX_NETNS, false);
> +	if (!ASSERT_OK_PTR(rx_ns, "create rx_ns"))
> +		goto free_txns;
> +
> +	SYS(free_rxns, "ip link add " RX_NAME " netns " RX_NETNS
> +	    " type veth peer name " TX_NAME " netns " TX_NETNS);
> +
> +	nstoken = open_netns(RX_NETNS);

close_netns(nstoken) is needed.

> +	if (!ASSERT_OK_PTR(nstoken, "setns rx_ns"))
> +		goto free_rxns;
> +
> +	SYS(free_rxns, "ip addr add " RX_ADDR "/24 dev " RX_NAME);
> +	SYS(free_rxns, "ip link set dev " RX_NAME " up");
> +
> +	skel = test_xdp_meta__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
> +		goto free_rxns;
> +
> +	rx_ifindex = if_nametoindex(RX_NAME);
> +	if (!ASSERT_GE(rx_ifindex, 0, "if_nametoindex rx"))
> +		goto destroy_skel;
> +
> +	tc_hook.ifindex = rx_ifindex;
> +	ret = bpf_tc_hook_create(&tc_hook);
> +	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
> +		goto destroy_skel;
> +
> +	tc_prog = bpf_object__find_program_by_name(skel->obj, "ing_cls");
> +	if (!ASSERT_OK_PTR(tc_prog, "open ing_cls prog"))
> +		goto destroy_skel;
> +
> +	tc_opts.prog_fd = bpf_program__fd(tc_prog);
> +	ret = bpf_tc_attach(&tc_hook, &tc_opts);
> +	if (!ASSERT_OK(ret, "bpf_tc_attach"))
> +		goto destroy_skel;
> +
> +	xdp_prog = bpf_object__find_program_by_name(skel->obj, "ing_xdp");
> +	if (!ASSERT_OK_PTR(xdp_prog, "open ing_xdp prog"))
> +		goto destroy_skel;
> +
> +	ret = bpf_xdp_attach(rx_ifindex,
> +			     bpf_program__fd(xdp_prog),
> +			     0, NULL);
> +	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
> +		goto destroy_skel;
> +
> +	nstoken = open_netns(TX_NETNS);

Same here.

pw-bot: cr

> +	if (!ASSERT_OK_PTR(nstoken, "setns tx_ns"))
> +		goto destroy_skel;
> +
> +	SYS(destroy_skel, "ip addr add " TX_ADDR "/24 dev " TX_NAME);
> +	SYS(destroy_skel, "ip link set dev " TX_NAME " up");
> +	SYS(destroy_skel, "ping -c 1 " RX_ADDR);
> +
> +destroy_skel:
> +	test_xdp_meta__destroy(skel);
> +free_rxns:
> +	netns_free(rx_ns);
> +free_txns:

nit. test_xdp_meta__destroy, netns_free, and the to-be-added close_netns can 
handle NULL. Init the variables to NULL at the beginning could save a few goto 
labels, probably only one label is needed.

> +	netns_free(tx_ns);
> +}

