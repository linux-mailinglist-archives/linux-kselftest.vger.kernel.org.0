Return-Path: <linux-kselftest+bounces-33230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3085DABA5EF
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 00:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694991B635C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 22:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FE023372C;
	Fri, 16 May 2025 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ww0iUgyp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F46B232386
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747434889; cv=none; b=Zv0cDQHofvyeDi1zQE52ELTV3vawb7KZlrgBV33CXCg82660FcxyvaCqADgDvfkLxOfh2eR60Q2177LL5TJGb8AqE5JO8tBUgn/biaH99u9i+pGKkGSUwqZ0fivYu1SiX1TvsvmOWEIuOS6uJyTM1mscqjgpX7GhPOgyFyCgWW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747434889; c=relaxed/simple;
	bh=1Q/aHYWlKWrydy3cLVK8Qq4aGK0NaMxdS1gS1zbr5ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIsLtMuh25DVV9neEXGvj0STS039cfsIM67ImrxXixRx5NlYqICtMJwR1E9chv9IrTNn4UCSY09jrau8hldu5fvYsqByBZc6IdS/IYs8Uw5EOit1HINUgOs9NpRg4Xs4FWQ0wn3kdocXZb4xHLUi/5anWVWAeNvN6dr49L7Qx90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ww0iUgyp; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <60092fac-2c8a-4076-9130-8c3e41cba040@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747434875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=15iMtyH1jixdvcvcU/HjXnbNttGRzvlXzQGL31LvRTI=;
	b=ww0iUgypAP2aPjYj7IgpdYQ3MYIXgkzo3/tL/pdsSxrOAZUMx8ADEaxfUHAJDsUi0ImibX
	A3IJHLuRO/48ajbOlSc499S4gwRPQAv80IwrVt/vh2c3Tp0/RR62DKrbkbi+MSt3p/Cdfa
	rtF6oWO7RaRlCJkA+z3d/iFxYMKycxc=
Date: Fri, 16 May 2025 15:34:26 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net v3 2/5] bpf: Add mptcp_subflow bpf_iter
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
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
 linux-kselftest@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250320-bpf-next-net-mptcp-bpf_iter-subflows-v3-0-9abd22c2a7fd@kernel.org>
 <20250320-bpf-next-net-mptcp-bpf_iter-subflows-v3-2-9abd22c2a7fd@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250320-bpf-next-net-mptcp-bpf_iter-subflows-v3-2-9abd22c2a7fd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/20/25 10:48 AM, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> It's necessary to traverse all subflows on the conn_list of an MPTCP
> socket and then call kfunc to modify the fields of each subflow. In
> kernel space, mptcp_for_each_subflow() helper is used for this:
> 
> 	mptcp_for_each_subflow(msk, subflow)
> 		kfunc(subflow);
> 
> But in the MPTCP BPF program, this has not yet been implemented. As
> Martin suggested recently, this conn_list walking + modify-by-kfunc
> usage fits the bpf_iter use case.
> 
> So this patch adds a new bpf_iter type named "mptcp_subflow" to do
> this and implements its helpers bpf_iter_mptcp_subflow_new()/_next()/
> _destroy(). And register these bpf_iter mptcp_subflow into mptcp
> common kfunc set. Then bpf_for_each() for mptcp_subflow can be used
> in BPF program like this:
> 
> 	bpf_for_each(mptcp_subflow, subflow, msk)
> 		kfunc(subflow);
> 
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>   - v2:
>     - Add BUILD_BUG_ON() checks, similar to the ones done with other
>       bpf_iter_(...) helpers.
>     - Replace msk_owned_by_me() by sock_owned_by_user_nocheck() and
>       !spin_is_locked() (Martin).
>   - v3:
>     - Switch parameter from 'struct mptcp_sock' to 'struct sock' (Martin)
>     - Remove unneeded !msk check (Martin)
>     - Remove locks checks, add msk_owned_by_me for lockdep (Martin)
>     - The following note and 2 questions have been added below.
> 
> This new bpf_iter will be used by our future BPF packet schedulers and
> path managers. To see how we are going to use them, please check our
> export branch [1], especially these two commits:
> 
>   - "bpf: Add mptcp packet scheduler struct_ops": introduce a new
>     struct_ops.
>   - "selftests/bpf: Add bpf_burst scheduler & test": new test showing
>     how the new struct_ops and bpf_iter are being used.
> 
> [1] https://github.com/multipath-tcp/mptcp_net-next/commits/export
> 
> @BPF maintainers: we would like to allow this new mptcp_subflow bpf_iter
> to be used with struct_ops, but only with the two new ones we are going
> to introduce that are specific to MPTCP, and with not others struct_ops
> (TCP CC, sched_ext, etc.). We are not sure how to do that. By chance, do
> you have examples or doc you could point to us to have this restriction
> in place, please?

The bpf_qdisc.c has done that. Take a look at the "bpf_qdisc_kfunc_filter()".

It is in net-next and bpf-next/net.

> 
> Also, for one of the two future MPTCP struct_ops, not all callbacks
> should be allowed to use this new bpf_iter, because they are called from
> different contexts. How can we ensure such callbacks from a struct_ops
> cannot call mptcp_subflow bpf_iter without adding new dedicated checks
> looking if some locks are held for all callbacks? We understood that
> they wanted to have something similar with sched_ext, but we are not
> sure if this code is ready nor if it is going to be accepted.

Same. Take a look at "bpf_qdisc_kfunc_filter()".


