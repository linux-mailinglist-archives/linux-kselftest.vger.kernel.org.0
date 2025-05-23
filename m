Return-Path: <linux-kselftest+bounces-33640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2D5AC21C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 13:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045921BC36C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 11:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E65422A811;
	Fri, 23 May 2025 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpSIwbb0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590761C8631;
	Fri, 23 May 2025 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747998441; cv=none; b=DZEeVvKmEfl4plKe51kf/iBu1F/+Jwi47JB4GV3PtownUeKo3ZsIFxxdaG3edZjC4b9ctfAxPAKnO3KfwW/pT1ciwuzZ6NIpFK6XMwAAteESSXDwFdClHyKrR1Y0CVEy8YssumZVmk+Y8JXzsNP7u6JEECgC7nvxMvhHugupuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747998441; c=relaxed/simple;
	bh=ZtulG+GqmTItXJpWf8cI/7ZkLZKWayGN42QGW1nDVfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q01qroXWzYAe5BONzS5Cz+HeLATnjNl6yzqLb1vU/th2rv/6pNtxsIrO6ZMFKDVNDmyR4HXGroSF3Ow3N/dFoYLoJI88LAbX+ADCmumRU2yRDFiTnF8deFvcP+tUWcvRADzb4OBiKvF5jHtQ6h5b3O22Y/HkuBBlsg+EUxMEUt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpSIwbb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE0EC4CEE9;
	Fri, 23 May 2025 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747998440;
	bh=ZtulG+GqmTItXJpWf8cI/7ZkLZKWayGN42QGW1nDVfA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qpSIwbb0KUSAPiEXVz6Eu1qPzh45BAEMErfL5Y8cbZjXSvlYLuPIzr/crAGWSKRqh
	 kdmbU0wtTS+rbxvMhiEZlWuEOpIc22PYeg3JoD1dJl2wB7IpL4qrHHB1Dr1AbECQE+
	 KNex+SPzy1+HsM3x37ljDri1pFVk4YU02odvPc5/h2n21fsRt0l9gMxubobFeytHJc
	 i20O8vkEyJaRb559fVGWXDB/5vP1+qn4YCUUH4QtHQPQSBXaeb5w6VZexPGEnMFxK3
	 34RML23GZbgJuJYEXEmehD5UUnwR9b+D2hXu/sY2j+1qum992Mnj20g44WSARuJB28
	 e1ICZQGgx4TDw==
Message-ID: <f9b1d13c-aa20-4680-849c-535ea7c476a6@kernel.org>
Date: Fri, 23 May 2025 13:07:10 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next/net v3 4/5] selftests/bpf: Add mptcp_subflow
 bpf_iter subtest
Content-Language: en-GB, fr-BE
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250320-bpf-next-net-mptcp-bpf_iter-subflows-v3-0-9abd22c2a7fd@kernel.org>
 <20250320-bpf-next-net-mptcp-bpf_iter-subflows-v3-4-9abd22c2a7fd@kernel.org>
 <98348a02-9f8b-4648-8abe-e6b802ae9a63@linux.dev>
 <1621611c-8cf1-4281-986f-cfd8cc0e70f0@kernel.org>
 <0364f8d2-9aa5-4dc0-b7f6-1c8572932814@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0364f8d2-9aa5-4dc0-b7f6-1c8572932814@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Martin,

On 21/05/2025 00:18, Martin KaFai Lau wrote:
> On 5/19/25 3:04 AM, Matthieu Baerts wrote:
>>>> +SEC("cgroup/getsockopt")
>>>> +int iters_subflow(struct bpf_sockopt *ctx)
>>>> +{
>>>> +    struct mptcp_subflow_context *subflow;
>>>> +    struct bpf_sock *sk = ctx->sk;
>>>> +    struct sock *ssk = NULL;
>>>> +    struct mptcp_sock *msk;
>>>> +    int local_ids = 0;
>>>> +
>>>> +    if (ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
>>>> +        return 1;
>>>> +
>>>> +    msk = bpf_core_cast(sk, struct mptcp_sock);
>>>> +    if (!msk || msk->pm.server_side || !msk->pm.subflows)
>>>> +        return 1;
>>>> +
>>>> +    bpf_for_each(mptcp_subflow, subflow, (struct sock *)sk) {
>>>> +        /* Here MPTCP-specific packet scheduler kfunc can be called:
>>>> +         * this test is not doing anything really useful, only to
>>>
>>> Lets fold the bpf_iter_mptcp_subflow addition into the future
>>> "mptcp_sched_ops" set (the github link that you mentioned in patch 2).
>>> Post them as one set to have a more practical example.
>>
>> Thank you for this suggestion. We can delay that if needed.
>>
>> Note that we have two struct_ops in preparation: mptcp_sched_ops and
>> mptcp_pm_ops. We don't know which one will be ready first. They are both
>> "blocked" by internal API modifications we would like to do to ease the
>> maintenance later before "exposing" such API's via BPF. That's why we
>> suggested to upstream this common part first as it is ready. But we can
>> of course wait if you prefer.
> 
> This set is useful for discussing the questions you raised in patch 2.
> 
> I still don't see it useful to upstream patch 2 alone. The existing
> selftests/bpf/progs/mptcp_subflow.c has already shown a way to do
> similar iteration in SEC("cgroup/getsockopt") without patch 2.
> 
> I would prefer to wait for a fuller picture on the main struct_ops use
> case first to ensure that we didn't overlook things. iiuc, improving the
> iteration in SEC("cgroup/getsockopt") is not the main objective.

I understand, that makes sense. When the rest will be ready, we will
upstream patches from this series, except this one ("useless" selftest),
and restricting bpf_iter_mptcp_subflow_* and other new kfuncs to
BPF_PROG_TYPE_STRUCT_OPS only. So not to BPF_PROG_TYPE_CGROUP_SOCKOPT
any more which was only needed for this new test. I don't think this
program type requires access to these new kfunc for useful use-cases.
This can be changed later if required anyway.

>>>> +         * verify the iteration works.
>>>> +         */
>>>> +
>>>> +        local_ids += subflow->subflow_id;
>>>> +
>>>> +        /* only to check the following helper works */
>>>> +        ssk = mptcp_subflow_tcp_sock(subflow);
>>>> +    }
>>>> +
>>>> +    if (!ssk)
>>>> +        goto out;
>>>> +
>>>> +    /* assert: if not OK, something wrong on the kernel side */
>>>> +    if (ssk->sk_dport != ((struct sock *)msk)->sk_dport)
>>>> +        goto out;
>>>> +
>>>> +    /* only to check the following kfunc works */
>>>> +    subflow = bpf_mptcp_subflow_ctx(ssk);
>>>
>>> bpf_core_cast should be as good instead of adding a new
>>> bpf_mptcp_subflow_ctx() kfunc, so patch 1 should not be needed.
>>
>> OK, indeed, in this series we don't need it. We will need it later to
>> modify some fields from the "subflow" structure directly. We can do the
> 
> The "ssk" here is not a trusted pointer. Note that in patch 1, the kfunc
> bpf_mptcp_subflow_ctx() does not specify KF_TRUSTED_ARGS. I suspect it
> should be KF_TRUSTED_ARGS based on what you described here.

Good point, I think this flag is indeed missing.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


