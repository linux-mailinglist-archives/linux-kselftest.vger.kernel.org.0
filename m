Return-Path: <linux-kselftest+bounces-25058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98F9A1AE39
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 02:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0229516CC9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 01:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C2D1D47B4;
	Fri, 24 Jan 2025 01:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GZLwMxLm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B8113AC1
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 01:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737682735; cv=none; b=ixhcO6YL5MreakJ6rgpnKQjAVP2jZ0r8T02gYRW6SUw9Hqg4ZsjI5Q9CUbzTLRyAsYZQ2FcYQFNNRu+yrD7gwc7laS4eMDwT2n4JW0Bx3F/bxdtm7z5FSBoayrilJsaqwnfAyUy1n1tdccdxutoYkkDHT2lSFIaGbyj5BPnbptA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737682735; c=relaxed/simple;
	bh=/wnClBcqy9IKrjwNnBUNENWd6mxPJwtoFNxLjAZn4HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fhlg1NS/Q4Nd8+JdQlfZyDdVNvDK2QpHBMDm4QpTKyuxOQlTc/Z0Vh2uJOWq+P86FoT5L5ES8puPwtvfNs8gi4xAN6gr8h/XDB7gaURfMD/HIimWjsys6gN9lkBYTh8LRuLJZIM3dCrALdhziKVEKqVW+hz4bFGtdcApjpG7ESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GZLwMxLm; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5313b129-72b1-4fdc-954e-e2d0a141a99c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737682716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PuF0gN9ro6NkSKhiCAGItV5HEn3Pklvs68VtZ/vAjKU=;
	b=GZLwMxLmr8EUv1bZOB3dBcC2uVrOJkEOAmHOSVAvZGDxaYihXg/9LaTZYs7L2/4RAi9oWH
	CJR8XbBtTezqOkGblOibRHvE8+oHFz4F/eNaGUfNaYCSmlclyM85kMsQn6n39UtVxPHpA1
	X27+LG2jxP+LfNFH8lOpcz2J5ZQSzm4=
Date: Thu, 23 Jan 2025 17:38:28 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net v2 7/7] selftests/bpf: Add mptcp_subflow
 bpf_iter subtest
To: Geliang Tang <geliang@kernel.org>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev,
 Mat Martineau <martineau@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org>
 <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-7-ae244d3cdbbc@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-7-ae244d3cdbbc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/19/24 7:46 AM, Matthieu Baerts (NGI0) wrote:
> +SEC("cgroup/getsockopt")
> +int iters_subflow(struct bpf_sockopt *ctx)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct bpf_sock *sk = ctx->sk;
> +	struct sock *ssk = NULL;
> +	struct mptcp_sock *msk;
> +	int local_ids = 0;
> +
> +	if (ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
> +		return 1;
> +
> +	msk = bpf_skc_to_mptcp_sock(sk);
> +	if (!msk || msk->pm.server_side || !msk->pm.subflows)
> +		return 1;
> +
> +	msk = bpf_mptcp_sock_acquire(msk);
> +	if (!msk)
> +		return 1;
> +	bpf_for_each(mptcp_subflow, subflow, msk) {
> +		/* Here MPTCP-specific packet scheduler kfunc can be called:
> +		 * this test is not doing anything really useful, only to
> +		 * verify the iteration works.
> +		 */
> +
> +		local_ids += subflow->subflow_id;
> +
> +		/* only to check the following kfunc works */
> +		ssk = mptcp_subflow_tcp_sock(subflow);

It is good to have test cases to exercise the new iter and kfunc. Thanks.

However, it seems not useful to show how it will be used in the future 
packet/subflow scheduler. iiuc, the core piece is in bpf_struct_ops. Without it, 
it is hard to comment. Any RFC patches ready to be posted?

> +	}
> +
> +	if (!ssk)
> +		goto out;
> +
> +	/* assert: if not OK, something wrong on the kernel side */
> +	if (ssk->sk_dport != ((struct sock *)msk)->sk_dport)
> +		goto out;
> +
> +	/* only to check the following kfunc works */
> +	subflow = bpf_mptcp_subflow_ctx(ssk);
> +	if (!subflow || subflow->token != msk->token)
> +		goto out;
> +
> +	ids = local_ids;
> +
> +out:
> +	bpf_mptcp_sock_release(msk);
> +	return 1;
> +}


