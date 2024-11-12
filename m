Return-Path: <linux-kselftest+bounces-21835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66E69C4B50
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 01:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D3DB29D25
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 00:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DDD2022EF;
	Tue, 12 Nov 2024 00:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xu+VijKs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9DC2022F1
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 00:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731372667; cv=none; b=rVFq6/IfgsAAkkJCGsJ5cxYlKZ1cI/+a7bc1y9dH1AW343T96tedDYxIIx00eBEJj2ArzFOAZv6nrDatqTQA4x2SAXucc+OPYKrLf9weRzJnLtsggT3cZp18MsUJwTwR5sgmr8iOnKCQabWmZuUQ/LIed+sIoXeCn2+4YKou0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731372667; c=relaxed/simple;
	bh=uAKm1Q9rSMgb/s8lIoy6s2itwU6TBOZsyRFjUDSDSEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+h9aYICTar5WhpkkcItQXK/OFRJeM7UzV8GNkRkAvziiDaNgMHsIpOnwa26KTE1S8egpQiL4RZtz4bdKPjeUUKQtsn6s9SOSYBo07LTdMy/Tx/YMjRinCddsv6/obFz5tJnBHbyL2ampXBdCwa9ryqJdtc1l987DmoaRlROb08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xu+VijKs; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <668e6f75-bdf3-44f8-a9e8-306fd4a22eb1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731372658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsSPQNZ5iLWASov38WAAf5vQXcJL0Tq9FLpBjWnTTcA=;
	b=Xu+VijKsvEDV9ltfIimmgjDxgefoW9/OYsFf6aTxt5KikhbVHXEFyV467azrh1OV46JcgB
	l4M2MUpmpg4czb3aJkxUizyFzh3vYTsSKwlw6bkJXL1X2cirZqyDw8JeL6BbMrzKancB3p
	tTd0A4p6K3+pT6KDyW/jr5leCLj8mkc=
Date: Mon, 11 Nov 2024 16:50:49 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net 2/5] bpf: Add mptcp_subflow bpf_iter
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Geliang Tang <geliang@kernel.org>
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
References: <20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-0-cf16953035c1@kernel.org>
 <20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-2-cf16953035c1@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-2-cf16953035c1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/8/24 7:52 AM, Matthieu Baerts (NGI0) wrote:
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
> A few versions of this single patch have been previously posted to the
> BPF mailing list by Geliang, before continuing to the MPTCP mailing list
> only, with other patches of this series. The version of the whole series
> has been reset to 1, but here is the ChangeLog for this patch here:
>   - v2: remove msk->pm.lock in _new() and _destroy() (Martin)
>         drop DEFINE_BPF_ITER_FUNC, change opaque[3] to opaque[2] (Andrii)
>   - v3: drop bpf_iter__mptcp_subflow
>   - v4: if msk is NULL, initialize kit->msk to NULL in _new() and check
>         it in _next() (Andrii)
>   - v5: use list_is_last() instead of list_entry_is_head() add
>         KF_ITER_NEW/NEXT/DESTROY flags add msk_owned_by_me in _new()
>   - v6: add KF_TRUSTED_ARGS flag (Andrii, Martin)
> ---
>   net/mptcp/bpf.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 6f96a5927fd371f8ea92cbf96c875edef9272b98..d107c2865e97e6ccffb9e0720dfbbd232b63a3b8 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -29,6 +29,15 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
>   	.set   = &bpf_mptcp_fmodret_ids,
>   };
>   
> +struct bpf_iter_mptcp_subflow {
> +	__u64 __opaque[2];
> +} __aligned(8);
> +
> +struct bpf_iter_mptcp_subflow_kern {
> +	struct mptcp_sock *msk;
> +	struct list_head *pos;
> +} __aligned(8);
> +
>   __bpf_kfunc_start_defs();
>   
>   __bpf_kfunc static struct mptcp_sock *bpf_mptcp_sk(struct sock *sk)
> @@ -48,12 +57,48 @@ bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
>   	return mptcp_subflow_tcp_sock(subflow);
>   }
>   
> +__bpf_kfunc static int
> +bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
> +			   struct mptcp_sock *msk)
> +{
> +	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
> +
> +	kit->msk = msk;
> +	if (!msk)
> +		return -EINVAL;
> +
> +	msk_owned_by_me(msk);

I recalled in the earlier revision, a concern had already been brought up about 
needing lock held and using the subflow iter in tracing. This patch still has 
the subflow iter available to tracing [by 
register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC)]. How is it supposed to work? 
Adding msk_owned_by_me(msk) does not help. At best it will give a WARN which is 
not good and then keep going even msk is not locked.

Do you need to use subflow iter in tracing?

The commit message mentioned it needs to modify the subflow. I don't see how 
this modification could work in a tracing program also. It must be some non 
tracing hooks? What is the plan on this hook? Is it a bpf_struct_ops or 
something else?

If it needs to modify the subflow, does it need to take the lock of the subflow?

> +
> +	kit->pos = &msk->conn_list;
> +	return 0;
> +}
> +
> +__bpf_kfunc static struct mptcp_subflow_context *
> +bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it)
> +{
> +	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
> +
> +	if (!kit->msk || list_is_last(kit->pos, &kit->msk->conn_list))
> +		return NULL;
> +
> +	kit->pos = kit->pos->next;
> +	return list_entry(kit->pos, struct mptcp_subflow_context, node);
> +}
> +
> +__bpf_kfunc static void
> +bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
> +{
> +}
> +
>   __bpf_kfunc_end_defs();
>   
>   BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
>   BTF_ID_FLAGS(func, bpf_mptcp_sk)
>   BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx)
>   BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
> +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
>   BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
>   
>   static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
> 


