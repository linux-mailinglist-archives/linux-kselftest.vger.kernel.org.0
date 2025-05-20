Return-Path: <linux-kselftest+bounces-33436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C963AABE6D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 00:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDEB4C671A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 22:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBFE25E455;
	Tue, 20 May 2025 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nqzk9IHX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5447A251798
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747779562; cv=none; b=HRGjrtPX6JXdDdgd9+feQNLV6p/c8G76eGbRzwPDzjkydPkSb2kTkdnQsnuOxg6VO+lRCUhohkg2O/mqHu9WUsweDWM3p8Aq7zIJZ4N+1cSC6YLUPoH39wEPttwqNceaheD0BwBxyNgURl1B1yNhTORpjduAqlekeuGy7poCVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747779562; c=relaxed/simple;
	bh=zZ3dMFhzEwUmlj6GDS4VfT/nsqtJbGAw6nColxOnEpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCqtjfqwz6lt9fOqD1XEFYdWyBHyzhga4tiX/TtJDg7D3Tn8wSOXgUntn1jK7yl/YY1w5IJKTSekSVSJedvrFEryyQLX32TjxBOmrXs/SSLIbgquhTinw56p8gm16Ir9RT3lyYpIG413fsVCx6iYsziWHsfcrN0lakPoljK2WFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nqzk9IHX; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0364f8d2-9aa5-4dc0-b7f6-1c8572932814@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747779546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKb0gnOHlciTS6MFRPmrAwCVe1IGdy183kVWTGpCTUs=;
	b=Nqzk9IHXZ5wcLJAOB7SOOqfQafxl5qrD4y2BeetsNgMI/EXHN5JOjKMaw+0lPa3ketk7gm
	3hABdTtpen4ekkqXZvQUtmchddXoO0jBUh4t9YJgWVvCGxnaUXp+CdXHW9zvLMGOK9d2qq
	ND3cQKueCyAxyY2WH4zTrTHcryUR/qg=
Date: Tue, 20 May 2025 15:18:52 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net v3 4/5] selftests/bpf: Add mptcp_subflow
 bpf_iter subtest
To: Matthieu Baerts <matttbe@kernel.org>
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <1621611c-8cf1-4281-986f-cfd8cc0e70f0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/19/25 3:04 AM, Matthieu Baerts wrote:
>>> +SEC("cgroup/getsockopt")
>>> +int iters_subflow(struct bpf_sockopt *ctx)
>>> +{
>>> +    struct mptcp_subflow_context *subflow;
>>> +    struct bpf_sock *sk = ctx->sk;
>>> +    struct sock *ssk = NULL;
>>> +    struct mptcp_sock *msk;
>>> +    int local_ids = 0;
>>> +
>>> +    if (ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
>>> +        return 1;
>>> +
>>> +    msk = bpf_core_cast(sk, struct mptcp_sock);
>>> +    if (!msk || msk->pm.server_side || !msk->pm.subflows)
>>> +        return 1;
>>> +
>>> +    bpf_for_each(mptcp_subflow, subflow, (struct sock *)sk) {
>>> +        /* Here MPTCP-specific packet scheduler kfunc can be called:
>>> +         * this test is not doing anything really useful, only to
>>
>> Lets fold the bpf_iter_mptcp_subflow addition into the future
>> "mptcp_sched_ops" set (the github link that you mentioned in patch 2).
>> Post them as one set to have a more practical example.
> 
> Thank you for this suggestion. We can delay that if needed.
> 
> Note that we have two struct_ops in preparation: mptcp_sched_ops and
> mptcp_pm_ops. We don't know which one will be ready first. They are both
> "blocked" by internal API modifications we would like to do to ease the
> maintenance later before "exposing" such API's via BPF. That's why we
> suggested to upstream this common part first as it is ready. But we can
> of course wait if you prefer.

This set is useful for discussing the questions you raised in patch 2.

I still don't see it useful to upstream patch 2 alone. The existing 
selftests/bpf/progs/mptcp_subflow.c has already shown a way to do similar 
iteration in SEC("cgroup/getsockopt") without patch 2.

I would prefer to wait for a fuller picture on the main struct_ops use case 
first to ensure that we didn't overlook things. iiuc, improving the iteration in 
SEC("cgroup/getsockopt") is not the main objective.

> 
>>> +         * verify the iteration works.
>>> +         */
>>> +
>>> +        local_ids += subflow->subflow_id;
>>> +
>>> +        /* only to check the following helper works */
>>> +        ssk = mptcp_subflow_tcp_sock(subflow);
>>> +    }
>>> +
>>> +    if (!ssk)
>>> +        goto out;
>>> +
>>> +    /* assert: if not OK, something wrong on the kernel side */
>>> +    if (ssk->sk_dport != ((struct sock *)msk)->sk_dport)
>>> +        goto out;
>>> +
>>> +    /* only to check the following kfunc works */
>>> +    subflow = bpf_mptcp_subflow_ctx(ssk);
>>
>> bpf_core_cast should be as good instead of adding a new
>> bpf_mptcp_subflow_ctx() kfunc, so patch 1 should not be needed.
> 
> OK, indeed, in this series we don't need it. We will need it later to
> modify some fields from the "subflow" structure directly. We can do the

The "ssk" here is not a trusted pointer. Note that in patch 1, the kfunc 
bpf_mptcp_subflow_ctx() does not specify KF_TRUSTED_ARGS. I suspect it should be 
KF_TRUSTED_ARGS based on what you described here.



