Return-Path: <linux-kselftest+bounces-17969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B9D978C2D
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 02:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2390EB2670A
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 00:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70F81FA4;
	Sat, 14 Sep 2024 00:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SdMho9r/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0523BB
	for <linux-kselftest@vger.kernel.org>; Sat, 14 Sep 2024 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726273778; cv=none; b=JfdirDfq/Usdyc3y8cXeuVNNmEsIUiDdcoO2VuPvbnbGIbTZH8TwM5HwBL+J2YCtQxH0JIasYvbymTUXXPR2fYVwS20k6LSEAMdVm+08SaRkZWfJ0sh9lLA2x7EDIbJApwRGqOFIbhIBNcLOLMjdEPvW/G+/9eUBWiOAgEm9/N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726273778; c=relaxed/simple;
	bh=N14vxJmV7LijXqMBkKqxEUgrSANtjfJ1MJyTVLTMdj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0l3lirpBspcOXqf01Yyu6ieAF7wSBBKXf3zl+OlzN7zpbgo7//ZajY3IOhsonMu/iUwhBfk2ECQPaQACwYzDBI1LNcjUW4EoQ1HD4tP3qSmjYq4YpqiJx+xzS9Qt7adXXvaJDj2eBS5HVo/Z0lDD+kcowKcpiSDhV0QmXxbEck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SdMho9r/; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6b678872-5303-4088-b65c-42e166b4d9e5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726273774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Nob2QmDLDqj2rBxmVNmdR9Zxqpeldv1XBqw00D21mA=;
	b=SdMho9r/ZehgPoQkyfQFm5kWUGRX62+fmgg9kW8XRCTP9uztBoGvsbRBLrq/y9jUHR9arP
	W25heYTCF0R3gwaIBkojzne325RDcR4JX/iD7pWi1Cefg2f//XNguzcWx/ZQG+u4uNzATE
	8KQYtc+kvu5eY+ShJqK7FjrQwuB2dOI=
Date: Fri, 13 Sep 2024 17:29:25 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net v6 3/3] selftests/bpf: Add mptcp subflow
 subtest
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Geliang Tang <geliang@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
 Mat Martineau <martineau@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20240911-upstream-bpf-next-20240506-mptcp-subflow-test-v6-0-7872294c466b@kernel.org>
 <20240911-upstream-bpf-next-20240506-mptcp-subflow-test-v6-3-7872294c466b@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240911-upstream-bpf-next-20240506-mptcp-subflow-test-v6-3-7872294c466b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/11/24 8:16 AM, Matthieu Baerts (NGI0) wrote:
> +static void test_subflow(void)
> +{
> +	int cgroup_fd, prog_fd, err;
> +	struct mptcp_subflow *skel;
> +	struct nstoken *nstoken;
> +	struct bpf_link *link;
> +
> +	cgroup_fd = test__join_cgroup("/mptcp_subflow");
> +	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: mptcp_subflow"))
> +		return;
> +
> +	skel = mptcp_subflow__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_load: mptcp_subflow"))
> +		goto close_cgroup;
> +
> +	skel->bss->pid = getpid();
> +
> +	err = mptcp_subflow__attach(skel);

This is not needed.

> +	if (!ASSERT_OK(err, "skel_attach: mptcp_subflow"))
> +		goto skel_destroy;
> +
> +	prog_fd = bpf_program__fd(skel->progs.mptcp_subflow);
> +	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);

Use bpf_program__attach_cgroup here instead since ...

> +	if (!ASSERT_OK(err, "prog_attach"))
> +		goto skel_destroy;
> +
> +	nstoken = create_netns();
> +	if (!ASSERT_OK_PTR(nstoken, "create_netns: mptcp_subflow"))
> +		goto skel_destroy;
> +
> +	if (endpoint_init("subflow") < 0)
> +		goto close_netns;
> +
> +	link = bpf_program__attach_cgroup(skel->progs._getsockopt_subflow,
> +					  cgroup_fd);

... bpf_program__attach_cgroup is used here also.

Instead of declaring a local "link", use the skel->links.{mptcp_subflow, 
_getsockopt_subflow}. Then mptcp_subflow__destroy(skel) will take care of them 
also. e.g. "skel->links._getsockopt_subflow = bpf_program__attach_cgroup(...)"

pw-bot: cr


