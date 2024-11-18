Return-Path: <linux-kselftest+bounces-22170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112199D0C19
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 10:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47EC282E6C
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 09:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7E7189919;
	Mon, 18 Nov 2024 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKYDEHBX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017D81EB48;
	Mon, 18 Nov 2024 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731923132; cv=none; b=kt1Mt4LjYcziFCfDSQya2wxR/vlVDLTYW7qSpL1lnN+qXCWuR+zbMuyzy65GRFu69XCn2urgXWgu0budQ8NQrbetOT8c1ZeErTjCVCyRplWj24SpRMgriNmQ0F+kW7Y8W4yYNUnZegGv7GkEVfYvo58pkMlKY9IjrbK36YhYU4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731923132; c=relaxed/simple;
	bh=zZ+USi14GEFg5Ab7la/alqdEpDJQDirej+0sPreZ4is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVa3vyykdptN1LG7uV0BJtmb1AI28dFlU1kRnxNsNn5f9SeVCwbHMEsSvgS6bu0VnS48Px1RY4A0zLvH6zH0ikG5FoXFRg5ul5Puq+ZzPYGvP2Tbef1SiX2QhHAEUTcNYf5WjSgrjDFdCyqr+O/8GXWEUiccYkWiMwBTUxmnOAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKYDEHBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B62EC4CECC;
	Mon, 18 Nov 2024 09:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731923131;
	bh=zZ+USi14GEFg5Ab7la/alqdEpDJQDirej+0sPreZ4is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKYDEHBXCQTfzeNrtukRXMu+WuGBS3S3sD3h+S7oxRzGq7t4GQ0/yjc+Wr8M9P/Ex
	 MUPCk3ENFClHNz+eZYEg+0/vMOW0rFN+0Ilayjh8uyJTTSCcvrQXpaNO3Ucblm5dNG
	 ZOoD0yKve1bDMvrLlxuS2qAWEndVEpMEAYKM+oo/0veTY19kFnmCBFndbtwzJ0Z7I1
	 iXkx5qCK/WDgRUGJ17+Y1A3x4G/rtn/8nYi8oNWESE2SOXXOMs50SFLigo9K2wd8y4
	 f1xnyMBtqbnJrIbfSol1cbu/DFPig7F4cxYqhnTSagoYR3J2GKfyRDbg0/yMK7NERG
	 xjHMCtPwo31yg==
Date: Mon, 18 Nov 2024 17:45:18 +0800
From: Geliang Tang <geliang@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev,
	Mat Martineau <martineau@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next/net 1/5] bpf: Register mptcp common kfunc set
Message-ID: <ZzsMrvdnqLd8CVRQ@t480>
References: <20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-0-cf16953035c1@kernel.org>
 <20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-1-cf16953035c1@kernel.org>
 <fe7a61b3-627f-4e60-9bba-28a4d40d1ec8@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe7a61b3-627f-4e60-9bba-28a4d40d1ec8@linux.dev>

Hi Martin,

Thanks for the review.

On Mon, Nov 11, 2024 at 04:25:52PM -0800, Martin KaFai Lau wrote:
> On 11/8/24 7:52 AM, Matthieu Baerts (NGI0) wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > MPTCP helper mptcp_sk() is used to convert struct sock to mptcp_sock.
> > Helpers mptcp_subflow_ctx() and mptcp_subflow_tcp_sock() are used to
> > convert between struct mptcp_subflow_context and sock. They all will
> > be used in MPTCP BPF programs too.
> > 
> > This patch defines corresponding wrappers of them, and put the
> > wrappers into mptcp common kfunc set and register the set with the
> > flag BPF_PROG_TYPE_UNSPEC to let them accessible to all types of BPF
> > programs.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > Reviewed-by: Mat Martineau <martineau@kernel.org>
> > Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > ---
> >   net/mptcp/bpf.c | 40 +++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 39 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > index 8a16672b94e2384f5263e1432296cbca1236bb30..6f96a5927fd371f8ea92cbf96c875edef9272b98 100644
> > --- a/net/mptcp/bpf.c
> > +++ b/net/mptcp/bpf.c
> > @@ -29,8 +29,46 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
> >   	.set   = &bpf_mptcp_fmodret_ids,
> >   };
> > +__bpf_kfunc_start_defs();
> > +
> > +__bpf_kfunc static struct mptcp_sock *bpf_mptcp_sk(struct sock *sk)
> > +{
> > +	return mptcp_sk(sk);
> > +}
> > +
> > +__bpf_kfunc static struct mptcp_subflow_context *
> > +bpf_mptcp_subflow_ctx(const struct sock *sk)
> > +{
> > +	return mptcp_subflow_ctx(sk);
> 
> This returns "struct mptcp_subflow_context *" without checking the sk is a
> mptcp subflow or not...

I checked it in patch 5 in the bpf program. I'll move this check into
bpf_mptcp_subflow_ctx() in v2.

> 
> > +}
> > +
> > +__bpf_kfunc static struct sock *
> > +bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
> > +{
> > +	return mptcp_subflow_tcp_sock(subflow);
> 
> ...and then the "struct mptcp_subflow_context *" can be used by this kfunc
> here. Is it really safe?

I'll add null-check for subflow here too in v2.

> 
> > +}
> > +
> > +__bpf_kfunc_end_defs();
> > +
> > +BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
> > +BTF_ID_FLAGS(func, bpf_mptcp_sk)
> > +BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx)
> > +BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
> 
> All of them has no KF_TRUSTED_ARGS or KF_RCU, so the returned ptr is

KF_TRUSTED_ARGS should be added for bpf_mptcp_sk() indeed, but not for
bpf_mptcp_subflow_ctx() or bpf_mptcp_subflow_tcp_sock(), since the parameters
'subflow' or 'sk' of the latter two functions are not pointers which are
passed as tracepoint or struct_ops callback arguments, but pointers returned
from kfuncs. I'll add KF_RET_NULL flag for all of them.

> supposed to be read-only? Why are they needed and why bpf_rdonly_cast (aka
> the bpf_core_cast in libbpf) cannot be used?

The returned ptrs will pass to kfuncs. If bpf_rdonly_cast() is used here, a
"untrusted_ptr_" error occurs:

# ; msk = bpf_core_cast(sk, struct mptcp_sock); @ mptcp_bpf_iters.c:29
# 9: (18) r2 = 0x3f95                   ; R2_w=16277
# 11: (85) call bpf_rdonly_cast#53914   ; R0_w=untrusted_ptr_mptcp_sock()
# ; if (!msk || msk->pm.server_side || !msk->pm.subflows) @ mptcp_bpf_iters.c:30
# 12: (15) if r0 == 0x0 goto pc+50      ; R0_w=untrusted_ptr_mptcp_sock()
# 13: (71) r1 = *(u8 *)(r0 +2785)       ; R0_w=untrusted_ptr_mptcp_sock() R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
# 14: (56) if w1 != 0x0 goto pc+48      ; R1_w=0
# 15: (71) r1 = *(u8 *)(r0 +2794)       ; R0_w=untrusted_ptr_mptcp_sock() R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
# 16: (16) if w1 == 0x0 goto pc+46      ; R1_w=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
# ; msk = bpf_mptcp_sock_acquire(msk); @ mptcp_bpf_iters.c:33
# 17: (bf) r1 = r0                      ; R0_w=untrusted_ptr_mptcp_sock() R1_w=untrusted_ptr_mptcp_sock()
# 18: (85) call bpf_mptcp_sock_acquire#24762
# arg#0 is untrusted_ptr_ expected ptr_ or socket
# processed 18 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
# -- END PROG LOAD LOG --

And I don't know how to fix it. So I added a new kfunc wrapper
bpf_mptcp_sk() instead.

Please give me some advice, thanks.

-Geliang

> 
> pw-bot: cr
> 
> > +BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
> > +
> > +static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
> > +	.owner	= THIS_MODULE,
> > +	.set	= &bpf_mptcp_common_kfunc_ids,
> > +};
> > +
> >   static int __init bpf_mptcp_kfunc_init(void)
> >   {
> > -	return register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
> > +	int ret;
> > +
> > +	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
> > +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
> > +					       &bpf_mptcp_common_kfunc_set);
> > +
> > +	return ret;
> >   }
> >   late_initcall(bpf_mptcp_kfunc_init);
> > 

