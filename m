Return-Path: <linux-kselftest+bounces-33319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1ADABBA91
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 12:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C38318897E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 10:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8318026D4F4;
	Mon, 19 May 2025 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtiKLDyW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D9D26D4F1;
	Mon, 19 May 2025 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649111; cv=none; b=eEp1tAQFihCEL5Vx/u2+F2QjqZbD8agOwo03goYaxBIR3Ex82COWVXpfvNS7edZQsyRGZNJJ39FFh7YsXJ77Dmk5wVK50FJu8Yc2aPbSodPU2fsS2Yo8oM1GEytLx7VDo+pl/ZPyy80OvbrQhL4UWnKZ/zNo3z06SVfzU9I4JZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649111; c=relaxed/simple;
	bh=NnHPE8Kkttup7df0ErYomOxo2k+cDQyScxpnffIlkHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TdBI58EKdgsdfPLUp5UIG3vVSN5+4v55hwjRV1miSTdpQsvg7WYugql1STCRbSinj3iGGrqHcjfchw9RkOR87WBHcX2zsHgFiQyI1mptSjx6+YTVpzdJNIHeDF+sv4My4nNzq2QceturRqQqqLq7lVdAnMxyn/exAHVmHfzxMao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtiKLDyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17438C4CEE4;
	Mon, 19 May 2025 10:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747649110;
	bh=NnHPE8Kkttup7df0ErYomOxo2k+cDQyScxpnffIlkHc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mtiKLDyWwQx1nZCE01RaR95qKKy9KBFW1a8Oi6H/wDa9EXlI0tRwUBZb1vZC9U1bZ
	 gZohj+PaORznr4OiHAUla//zNzqdMB8w2siJpWCawOndYF3Md6b99JcFGjArd0oYJy
	 NOn72e9gST9P3pJj92hAudWAXnokXZIGZ3eoHbnpcQOIVBWDIsLDMGfzG3X5bLXSyZ
	 QOMr1m0XVjILFGuEG5vYfpGrnHEozITtL7xXFPEoHExHewHcSoc5zedUy5x9d1qmmY
	 5y0KLNxnDajjWiJLCpEfaOAoqyCECoHS+JISSV1rlX+Xeb1xHV1YCvK3AKGbJeO5C2
	 18EwQt4Mb1TPw==
Message-ID: <1621611c-8cf1-4281-986f-cfd8cc0e70f0@kernel.org>
Date: Mon, 19 May 2025 12:04:55 +0200
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
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <98348a02-9f8b-4648-8abe-e6b802ae9a63@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Martin,

On 17/05/2025 00:48, Martin KaFai Lau wrote:
> On 3/20/25 10:48 AM, Matthieu Baerts (NGI0) wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> This patch adds a "cgroup/getsockopt" program "iters_subflow" to test the
>> newly added mptcp_subflow bpf_iter.
>>
>> Export mptcp_subflow helpers bpf_iter_mptcp_subflow_new/_next/_destroy
>> and other helpers into bpf_experimental.h.
>>
>> Use bpf_for_each() to walk the subflow list of an msk. From there,
>> future MPTCP-specific kfunc can be called in the loop. Because they are
>> not there yet, this test doesn't do anything very "useful" for the
>> moment, but it focuses on validating the 'bpf_iter' part and the basic
>> MPTCP kfunc. That's why it simply adds all subflow ids to local variable
>> local_ids to make sure all subflows have been seen, then invoke
>> mptcp_subflow_tcp_sock() in the loop to pick the subflow context.
>>
>> Out of the loop, use bpf_mptcp_subflow_ctx() to get the subflow context
>> of the picked subflow context and do some verifications. Finally, assign
>> local_ids to global variable ids so that the application can obtain this
>> value.
>>
>> A related subtest called test_iters_subflow is added to load and verify
>> the newly added mptcp_subflow type bpf_iter example in test_mptcp. The
>> endpoint_init() helper is used to add 3 new subflow endpoints. Then one
>> byte of message is sent to trigger the creation of new subflows.
>> getsockopt() is invoked once the subflows have been created to trigger
>> the "cgroup/getsockopt" test program "iters_subflow". skel->bss->ids is
>> then checked to make sure it equals 10, the sum of each subflow ID: we
>> should have 4 subflows: 1 + 2 + 3 + 4 = 10. If that's the case, the
>> bpf_iter loop did the job as expected.

(...)

>> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c b/
>> tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
>> new file mode 100644
>> index
>> 0000000000000000000000000000000000000000..a1d8f9b20259a9cbdc46d58e0d18157564fa5acd
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
>> @@ -0,0 +1,59 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2024, Kylin Software */
>> +
>> +/* vmlinux.h, bpf_helpers.h and other 'define' */
>> +#include "bpf_tracing_net.h"
>> +#include "mptcp_bpf.h"
>> +
>> +char _license[] SEC("license") = "GPL";
>> +int ids;
>> +
>> +#ifndef TCP_IS_MPTCP
>> +#define TCP_IS_MPTCP        43    /* Is MPTCP being used? */
>> +#endif
>> +
>> +SEC("cgroup/getsockopt")
>> +int iters_subflow(struct bpf_sockopt *ctx)
>> +{
>> +    struct mptcp_subflow_context *subflow;
>> +    struct bpf_sock *sk = ctx->sk;
>> +    struct sock *ssk = NULL;
>> +    struct mptcp_sock *msk;
>> +    int local_ids = 0;
>> +
>> +    if (ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
>> +        return 1;
>> +
>> +    msk = bpf_core_cast(sk, struct mptcp_sock);
>> +    if (!msk || msk->pm.server_side || !msk->pm.subflows)
>> +        return 1;
>> +
>> +    bpf_for_each(mptcp_subflow, subflow, (struct sock *)sk) {
>> +        /* Here MPTCP-specific packet scheduler kfunc can be called:
>> +         * this test is not doing anything really useful, only to
> 
> Lets fold the bpf_iter_mptcp_subflow addition into the future
> "mptcp_sched_ops" set (the github link that you mentioned in patch 2).
> Post them as one set to have a more practical example.

Thank you for this suggestion. We can delay that if needed.

Note that we have two struct_ops in preparation: mptcp_sched_ops and
mptcp_pm_ops. We don't know which one will be ready first. They are both
"blocked" by internal API modifications we would like to do to ease the
maintenance later before "exposing" such API's via BPF. That's why we
suggested to upstream this common part first as it is ready. But we can
of course wait if you prefer.

>> +         * verify the iteration works.
>> +         */
>> +
>> +        local_ids += subflow->subflow_id;
>> +
>> +        /* only to check the following helper works */
>> +        ssk = mptcp_subflow_tcp_sock(subflow);
>> +    }
>> +
>> +    if (!ssk)
>> +        goto out;
>> +
>> +    /* assert: if not OK, something wrong on the kernel side */
>> +    if (ssk->sk_dport != ((struct sock *)msk)->sk_dport)
>> +        goto out;
>> +
>> +    /* only to check the following kfunc works */
>> +    subflow = bpf_mptcp_subflow_ctx(ssk);
> 
> bpf_core_cast should be as good instead of adding a new
> bpf_mptcp_subflow_ctx() kfunc, so patch 1 should not be needed.

OK, indeed, in this series we don't need it. We will need it later to
modify some fields from the "subflow" structure directly. We can do the
modification or drop this test when the new struct_ops will be ready.

>> +    if (!subflow || subflow->token != msk->token)
>> +        goto out;
>> +
>> +    ids = local_ids;
>> +
>> +out:
>> +    return 1;
>> +}
>>
> 
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


