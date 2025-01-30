Return-Path: <linux-kselftest+bounces-25423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4528A22CCB
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 13:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287561889446
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 12:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4231C07E2;
	Thu, 30 Jan 2025 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAR3DGWc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A411AF0DC;
	Thu, 30 Jan 2025 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738238771; cv=none; b=HE7kcZlnobmQ24xPN1pyNbCgXU4peoLW8kduo8c/Sys2H4vlMyo3m+qak93hxphLtQzsaxxl3HquADp1/Z1MSJwTxrpqNRyLQnJjJ1VAWidNkzh7diR/HNf98EjUukyVXujPWGfzzZjp41qbf8GXmpT0qc9l9FxRHH8hQR8hqpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738238771; c=relaxed/simple;
	bh=xopmZEADxLu17v8s1oec48v9swghvqcukEWRE5i/ArQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rg89ZkYP4ZL6PDEwKg+5i1XdCvDfpA7fRzP22ETPFI93fGKu/ebaaCHbwu8WqIs59oSj9N9n3StZqmifvtg1OdMT1PPu1b3XYK2JDWssBWUdyoi0vULxoqI4Gyeuo23Cjs8Sdxxs5MIITL1sj7cABUvtPe4brdxw68d1CTvWy6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAR3DGWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33C4C4CED2;
	Thu, 30 Jan 2025 12:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738238770;
	bh=xopmZEADxLu17v8s1oec48v9swghvqcukEWRE5i/ArQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mAR3DGWcYda1w4z0OEHonKPUaUDc0dWMf/3YYEXtK61VMN/NDdh1hVPVJF54ImIb1
	 fBhqehjqpuNIDlQOBHjtXaWdqlW0quBcdIUcAEdRGZCN+wqL/b+bJOJQWbIyRJhirr
	 GyWrVb0JimepHfBcJTgTUuKieX/YqXI/8fP8hY8jsthxtlOqQZr8hp/xDISGE0owm0
	 gYGE+ahAYxDoTtKItvF6X3BQEmd4knWu/UJl/DUXleKBH/xvYVzkkLdZlTIYkyik6Z
	 aMwzkD6yE42iXUkpvOEHiEA2T8cB/kSyu05k5dHLcL/Mwp2WUiez14Oo3o2OIxLFtT
	 b3mdKDD/0Nz0Q==
Message-ID: <3b5af48e-4155-4b98-b67b-b75d9fb6285e@kernel.org>
Date: Thu, 30 Jan 2025 13:05:54 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next/net v2 4/7] bpf: Add mptcp_subflow bpf_iter
Content-Language: en-GB
To: Martin KaFai Lau <martin.lau@linux.dev>, Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
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
 linux-kselftest@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>
References: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org>
 <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-4-ae244d3cdbbc@kernel.org>
 <fdf0ddbe-e007-4a5f-bbdf-9a144e8fbe35@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <fdf0ddbe-e007-4a5f-bbdf-9a144e8fbe35@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Martin,

Thank you for your review!

Sorry for the delay here, Geliang started to work on a new version, but
it might take a bit of time as he is currently off for a few days.

On 24/01/2025 01:47, Martin KaFai Lau wrote:
> On 12/19/24 7:46 AM, Matthieu Baerts (NGI0) wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> It's necessary to traverse all subflows on the conn_list of an MPTCP
>> socket and then call kfunc to modify the fields of each subflow. In
>> kernel space, mptcp_for_each_subflow() helper is used for this:
>>
>>     mptcp_for_each_subflow(msk, subflow)
>>         kfunc(subflow);
>>
>> But in the MPTCP BPF program, this has not yet been implemented. As
>> Martin suggested recently, this conn_list walking + modify-by-kfunc
>> usage fits the bpf_iter use case.
>>
>> So this patch adds a new bpf_iter type named "mptcp_subflow" to do
>> this and implements its helpers bpf_iter_mptcp_subflow_new()/_next()/
>> _destroy(). And register these bpf_iter mptcp_subflow into mptcp
>> common kfunc set. Then bpf_for_each() for mptcp_subflow can be used
>> in BPF program like this:
>>
>>     bpf_for_each(mptcp_subflow, subflow, msk)
>>         kfunc(subflow);

(...)

>> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
>> index
>> c5bfd84c16c43230d9d8e1fd8ff781a767e647b5..e39f0e4fb683c1aa31ee075281daee218dac5878 100644
>> --- a/net/mptcp/bpf.c
>> +++ b/net/mptcp/bpf.c

(...)

>> @@ -47,10 +56,54 @@ bpf_mptcp_subflow_ctx(const struct sock *sk)
>>       return NULL;
>>   }
>>   +__bpf_kfunc static int
>> +bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
>> +               struct mptcp_sock *msk)
>> +{
>> +    struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
>> +    struct sock *sk = (struct sock *)msk;
>> +
>> +    BUILD_BUG_ON(sizeof(struct bpf_iter_mptcp_subflow_kern) >
>> +             sizeof(struct bpf_iter_mptcp_subflow));
>> +    BUILD_BUG_ON(__alignof__(struct bpf_iter_mptcp_subflow_kern) !=
>> +             __alignof__(struct bpf_iter_mptcp_subflow));
>> +
>> +    kit->msk = msk;
>> +    if (!msk)
> 
> NULL check is not needed. verifier should have rejected it for
> KF_TRUSTED_ARGS.
> 
>> +        return -EINVAL;
>> +
>> +    if (!sock_owned_by_user_nocheck(sk) &&
>> +        !spin_is_locked(&sk->sk_lock.slock))
> 
> I could have missed something. If it is to catch bug, should it be
> sock_owned_by_me() that has the lockdep splat? For the cg get/setsockopt
> hook here, the lock should have already been held earlier in the kernel.

Good point. Because in this series, the kfunc is currently restricted to
CG [gs]etsockopt hooks, we should use msk_owned_by_me(msk) here.

> This set is only showing the cg sockopt bpf prog but missing the major
> struct_ops piece. It is hard to comment. I assumed the lock situation is
> the same for the struct_ops where the lock will be held before calling
> the struct_ops prog?

I understand it is hard to comment on that point. In the 'struct_ops' we
are designing, the lock will indeed be held before calling the stuct_ops
program. So we will just need to make sure this assumption is correct
for all callbacks of our struct_ops.
Also, if I understood correctly, it is possible to restrict a kfunc to
some specific struct_ops, e.g. not to call this kfunc for the TCP CA
struct_ops. So these checks should indeed not be needed, but I will
double-check that with Geliang.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


