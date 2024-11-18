Return-Path: <linux-kselftest+bounces-22172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC219D0DCD
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 11:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B571282B34
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 10:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E86192D76;
	Mon, 18 Nov 2024 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSp1LHJX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F714188CC6;
	Mon, 18 Nov 2024 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924576; cv=none; b=QQVjebl/R6nPwImFANgdsRE9Kvk3HUkWcOG+vdDdg13/++6b0MUauFHBRstNHlLcQnRy7o/JvTWUGLem/Ccoqz22L9XeQ8AYz2rM3nPeKzVW8WbKOe+ngXGL4LZvaDNEp3cHDBW1N9YyQU2TiuTxEf4fVVRcEc9TUO5U7Wzn928=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924576; c=relaxed/simple;
	bh=a2hdmi4aOqfEFoMDpXU5Bx+uDwTW5EoxJxpamlSobx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpfe/95PH673AGPc7Hu/aSuECnJeVYcCrX4SqkznRX6TjlKO+MIFfdFCOSzmyE138gobT3WaThgcWC3JPiWiQzkkZk+adyFqnbWO7/rWtLxJBFyj9fD6RPO3F5/4xeLaheDGIqHLhomjlOfByUj6rCuMpaqw1ZUKofhED8gPSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSp1LHJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79284C4CECC;
	Mon, 18 Nov 2024 10:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731924575;
	bh=a2hdmi4aOqfEFoMDpXU5Bx+uDwTW5EoxJxpamlSobx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSp1LHJX14zc8se7ncI9/dVefunWJQK3P9DzI0rzxZXIJTiQrCFKKct+6hFYafkO+
	 dzWAyt3rd1+eG87AZfMlmdfnF6Fg2Dc19TeABJAc7dfnPWq0998afeq0lpISHL6Nq1
	 UII5NYALwfOae/4qMitFs8BLl5d7bjkeWc9S6MM6PvsHT4AfAamtxp/qXe+wnv3a37
	 D6rAzAKy8HgRwoMl4jG7YwmFOJ6QUmOAT1VWQqWZcVnq/dhf5iJsVWdPvhNP0TjNo1
	 z4glpT4VYLHMfPIUCVWOeYgP8UOn3XAIiUqsL/YYcWD5EsINN7F0FCBpmYbDZV1bwS
	 NdpT4HfUOlgmA==
Date: Mon, 18 Nov 2024 18:09:17 +0800
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
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next/net 2/5] bpf: Add mptcp_subflow bpf_iter
Message-ID: <ZzsSTUFwFxATGAqt@t480>
References: <20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-0-cf16953035c1@kernel.org>
 <20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-2-cf16953035c1@kernel.org>
 <668e6f75-bdf3-44f8-a9e8-306fd4a22eb1@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668e6f75-bdf3-44f8-a9e8-306fd4a22eb1@linux.dev>

Hi Martin,

On Mon, Nov 11, 2024 at 04:50:49PM -0800, Martin KaFai Lau wrote:
> On 11/8/24 7:52 AM, Matthieu Baerts (NGI0) wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > It's necessary to traverse all subflows on the conn_list of an MPTCP
> > socket and then call kfunc to modify the fields of each subflow. In
> > kernel space, mptcp_for_each_subflow() helper is used for this:
> > 
> > 	mptcp_for_each_subflow(msk, subflow)
> > 		kfunc(subflow);
> > 
> > But in the MPTCP BPF program, this has not yet been implemented. As
> > Martin suggested recently, this conn_list walking + modify-by-kfunc
> > usage fits the bpf_iter use case.
> > 
> > So this patch adds a new bpf_iter type named "mptcp_subflow" to do
> > this and implements its helpers bpf_iter_mptcp_subflow_new()/_next()/
> > _destroy(). And register these bpf_iter mptcp_subflow into mptcp
> > common kfunc set. Then bpf_for_each() for mptcp_subflow can be used
> > in BPF program like this:
> > 
> > 	bpf_for_each(mptcp_subflow, subflow, msk)
> > 		kfunc(subflow);
> > 
> > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > Reviewed-by: Mat Martineau <martineau@kernel.org>
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > ---
> > Notes:
> > A few versions of this single patch have been previously posted to the
> > BPF mailing list by Geliang, before continuing to the MPTCP mailing list
> > only, with other patches of this series. The version of the whole series
> > has been reset to 1, but here is the ChangeLog for this patch here:
> >   - v2: remove msk->pm.lock in _new() and _destroy() (Martin)
> >         drop DEFINE_BPF_ITER_FUNC, change opaque[3] to opaque[2] (Andrii)
> >   - v3: drop bpf_iter__mptcp_subflow
> >   - v4: if msk is NULL, initialize kit->msk to NULL in _new() and check
> >         it in _next() (Andrii)
> >   - v5: use list_is_last() instead of list_entry_is_head() add
> >         KF_ITER_NEW/NEXT/DESTROY flags add msk_owned_by_me in _new()
> >   - v6: add KF_TRUSTED_ARGS flag (Andrii, Martin)
> > ---
> >   net/mptcp/bpf.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 45 insertions(+)
> > 
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > index 6f96a5927fd371f8ea92cbf96c875edef9272b98..d107c2865e97e6ccffb9e0720dfbbd232b63a3b8 100644
> > --- a/net/mptcp/bpf.c
> > +++ b/net/mptcp/bpf.c
> > @@ -29,6 +29,15 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
> >   	.set   = &bpf_mptcp_fmodret_ids,
> >   };
> > +struct bpf_iter_mptcp_subflow {
> > +	__u64 __opaque[2];
> > +} __aligned(8);
> > +
> > +struct bpf_iter_mptcp_subflow_kern {
> > +	struct mptcp_sock *msk;
> > +	struct list_head *pos;
> > +} __aligned(8);
> > +
> >   __bpf_kfunc_start_defs();
> >   __bpf_kfunc static struct mptcp_sock *bpf_mptcp_sk(struct sock *sk)
> > @@ -48,12 +57,48 @@ bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
> >   	return mptcp_subflow_tcp_sock(subflow);
> >   }
> > +__bpf_kfunc static int
> > +bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
> > +			   struct mptcp_sock *msk)
> > +{
> > +	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
> > +
> > +	kit->msk = msk;
> > +	if (!msk)
> > +		return -EINVAL;
> > +
> > +	msk_owned_by_me(msk);
> 
> I recalled in the earlier revision, a concern had already been brought up
> about needing lock held and using the subflow iter in tracing. This patch
> still has the subflow iter available to tracing [by
> register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC)]. How is it supposed to
> work? Adding msk_owned_by_me(msk) does not help. At best it will give a WARN
> which is not good and then keep going even msk is not locked.

I'll check lockdep_sock_is_held(msk) here in v2, and return NULL if msk
socket is not locked.

> 
> Do you need to use subflow iter in tracing?

No.

> 
> The commit message mentioned it needs to modify the subflow. I don't see how
> this modification could work in a tracing program also. It must be some non
> tracing hooks? What is the plan on this hook? Is it a bpf_struct_ops or
> something else?

We only plan to use it in struct_ops (mptcp bpf path manager [1], and mptcp
packet scheduler [2]) and cgroup sockopt (mptcp setsockopt [3]).

So I'll register this kfunc_set for BPF_PROG_TYPE_STRUCT_OPS and
BPF_PROG_TYPE_CGROUP_SOCKOPT only in v2, not for BPF_PROG_TYPE_UNSPEC.

> 
> If it needs to modify the subflow, does it need to take the lock of the subflow?

We will call the following mptcp_subflow_set_scheduled() kfunc to set the
scheduled field of a subflow:

void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
                                 bool scheduled)
{
        WRITE_ONCE(subflow->scheduled, scheduled);
}

WRITE_ONCE is used here, and no additional lock of the subflow is used.

Thanks,
-Geliang

[1] https://github.com/multipath-tcp/mptcp_net-next/issues/74
[2] https://github.com/multipath-tcp/mptcp_net-next/issues/75
[3] https://github.com/multipath-tcp/mptcp_net-next/issues/484

> 
> > +
> > +	kit->pos = &msk->conn_list;
> > +	return 0;
> > +}
> > +
> > +__bpf_kfunc static struct mptcp_subflow_context *
> > +bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it)
> > +{
> > +	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
> > +
> > +	if (!kit->msk || list_is_last(kit->pos, &kit->msk->conn_list))
> > +		return NULL;
> > +
> > +	kit->pos = kit->pos->next;
> > +	return list_entry(kit->pos, struct mptcp_subflow_context, node);
> > +}
> > +
> > +__bpf_kfunc static void
> > +bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
> > +{
> > +}
> > +
> >   __bpf_kfunc_end_defs();
> >   BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
> >   BTF_ID_FLAGS(func, bpf_mptcp_sk)
> >   BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx)
> >   BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
> > +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
> > +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
> > +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
> >   BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
> >   static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
> > 
> 

