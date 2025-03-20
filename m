Return-Path: <linux-kselftest+bounces-29512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C99BA6AC70
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 18:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55301896F6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 17:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A353B225A4F;
	Thu, 20 Mar 2025 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="splJp5Pa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0321953A1;
	Thu, 20 Mar 2025 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492963; cv=none; b=TL9hDBNg0+TXgFow9UORdH/gY5rJa3ekXa2HLFdlnBgLsV7vGHwN490pIqhLf2UeY7/sXVHlGup76KujSp+CzEplaEihr/zSXAblK1QXHa4LidOdYMOTwFt2O6nvQBQx4mM/YePv7xNQr77rKZkgGj9koBkMhbJOUqnyzJV7QSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492963; c=relaxed/simple;
	bh=1cc0adDbVdiSqg9S/kiA3gu+1IqBLXi9TYVZ+DD3qLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5/XrnyZgglHGkdclPC2gxXZY7poqPsRptN078U/eYuoilN8gdYb80uHjS7qGI2uY1U+2x3J+zEQjdweUiK8rq4PRxCuP+xAdJo1NxepGD7NRwDGY6L60GC9YneS+UvI+SmdRBPItSo6JLNSeHL5cyHnMxnfqtdOaq+rK/dztYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=splJp5Pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917C3C4CEDD;
	Thu, 20 Mar 2025 17:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742492962;
	bh=1cc0adDbVdiSqg9S/kiA3gu+1IqBLXi9TYVZ+DD3qLc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=splJp5Pavz4As57esuE2nTGmJeI+Td8NYqrrNQKzg7woLxXLB2gxBiy3Aq024bkkf
	 grUj2E0iZASXPXx1k3JJfKew8Uf98j+dEa28ixOBXE0O3W7iNh097HdoS9bXqOQmaS
	 a/PVdGOG15uDW1RgXBw4R7C04EKGc2zCLXKIdhm5NZrWY1hUfakyDRx6rnl7jZ+nhn
	 CcbJWC314/ZGErEn3uk1fReL0BfBn+EcXAlurfcb2OUYOn/oB11iDvgm1RcUlF5xpM
	 0m0/0mpfnbDnW4CwfMTwJMzRRu+nIC3J9jqY3yl/GGZknQHPUibEd9ugsKttGlkxbm
	 aEFHEJYspDwTA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 20 Mar 2025 18:48:41 +0100
Subject: [PATCH bpf-next/net v3 2/5] bpf: Add mptcp_subflow bpf_iter
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-bpf-next-net-mptcp-bpf_iter-subflows-v3-2-9abd22c2a7fd@kernel.org>
References: <20250320-bpf-next-net-mptcp-bpf_iter-subflows-v3-0-9abd22c2a7fd@kernel.org>
In-Reply-To: <20250320-bpf-next-net-mptcp-bpf_iter-subflows-v3-0-9abd22c2a7fd@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Martin KaFai Lau <martin.lau@kernel.org>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6083; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HaVnT1EXkTnfm93/AXeT5xqsMSCT7tBCo573W3QfwoA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn3FURTPaeAa3M5SzaQjL0Xgaxf1C+FrpeEmVpJ
 DiUlbuEfDKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9xVEQAKCRD2t4JPQmmg
 c7q+EADDKpgaU+7e1pFYWm20pMovCLIL9ZSPRVdbw7Db799E0bLlts1oGOFMPfnDOYwso9ZJTDX
 WpiO5FUN9/HKdSdCU6B9P5xg/0OhptU/vG9Bnc6CcRsyavKfd2VNxmUv7nzd6L3ffsMT7WlKpGc
 ZpJ7dIg5k5ef06V6snr/pm8FVHZiMDFiyNCdKT+zIsoSqhIKHyjrph3LVqtknJRsPqe5yoShqo3
 2MEl7Z+Ar0s7SiNzXK7QPwloID2lJoP2MzC5fiA/eAEkcyVGke6oUenS5HZjGtBwkL1OhhkfdVb
 J0iOT9ZTtL1xLmepndwQOXd11Exe2lGruaGhnA/8BkV+aMOr4VBnPK392G7SqPfXfyGMpU5IIp/
 v5Up58OH0sa8PUjPb+qqF2zU0J9l5dEJ6YLS9s1hAnCwBgRIXUpfEi4Uk1Kl2xfA2kUanF9hhNH
 ACUukWbrZnb5q8wooiJoWp8k9dWvhVHZyaVQ1NGF/zolVeNlt9vn1rV0Mg0y9cENlMzvGuJ0lX1
 yNuJKiRUpdgew+EpIppaNdHoh/B0jPmVy4cFjofu6rvH9gM+E8ekWGKHkozfyuRvXf0dPufzAVy
 ypzdy6P7T/cV8abPrReL4muA6lq0USkYmbadGB805/7i0Ny4PlXQVi5P9KEzJwxGY2LpkPqiNp8
 jAPBycXKAszhD4A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

It's necessary to traverse all subflows on the conn_list of an MPTCP
socket and then call kfunc to modify the fields of each subflow. In
kernel space, mptcp_for_each_subflow() helper is used for this:

	mptcp_for_each_subflow(msk, subflow)
		kfunc(subflow);

But in the MPTCP BPF program, this has not yet been implemented. As
Martin suggested recently, this conn_list walking + modify-by-kfunc
usage fits the bpf_iter use case.

So this patch adds a new bpf_iter type named "mptcp_subflow" to do
this and implements its helpers bpf_iter_mptcp_subflow_new()/_next()/
_destroy(). And register these bpf_iter mptcp_subflow into mptcp
common kfunc set. Then bpf_for_each() for mptcp_subflow can be used
in BPF program like this:

	bpf_for_each(mptcp_subflow, subflow, msk)
		kfunc(subflow);

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v2:
   - Add BUILD_BUG_ON() checks, similar to the ones done with other
     bpf_iter_(...) helpers.
   - Replace msk_owned_by_me() by sock_owned_by_user_nocheck() and
     !spin_is_locked() (Martin).
 - v3:
   - Switch parameter from 'struct mptcp_sock' to 'struct sock' (Martin)
   - Remove unneeded !msk check (Martin)
   - Remove locks checks, add msk_owned_by_me for lockdep (Martin)
   - The following note and 2 questions have been added below.

This new bpf_iter will be used by our future BPF packet schedulers and
path managers. To see how we are going to use them, please check our
export branch [1], especially these two commits:

 - "bpf: Add mptcp packet scheduler struct_ops": introduce a new
   struct_ops.
 - "selftests/bpf: Add bpf_burst scheduler & test": new test showing
   how the new struct_ops and bpf_iter are being used.

[1] https://github.com/multipath-tcp/mptcp_net-next/commits/export

@BPF maintainers: we would like to allow this new mptcp_subflow bpf_iter
to be used with struct_ops, but only with the two new ones we are going
to introduce that are specific to MPTCP, and with not others struct_ops
(TCP CC, sched_ext, etc.). We are not sure how to do that. By chance, do
you have examples or doc you could point to us to have this restriction
in place, please?

Also, for one of the two future MPTCP struct_ops, not all callbacks
should be allowed to use this new bpf_iter, because they are called from
different contexts. How can we ensure such callbacks from a struct_ops
cannot call mptcp_subflow bpf_iter without adding new dedicated checks
looking if some locks are held for all callbacks? We understood that
they wanted to have something similar with sched_ext, but we are not
sure if this code is ready nor if it is going to be accepted.

---
A few versions of this single patch have been previously posted to the
BPF mailing list by Geliang, before continuing to the MPTCP mailing list
only, with other patches of this series. The version of the whole series
has been reset to 1, but here is the ChangeLog for the previous ones:
 - v2: remove msk->pm.lock in _new() and _destroy() (Martin)
       drop DEFINE_BPF_ITER_FUNC, change opaque[3] to opaque[2] (Andrii)
 - v3: drop bpf_iter__mptcp_subflow
 - v4: if msk is NULL, initialize kit->msk to NULL in _new() and check
       it in _next() (Andrii)
 - v5: use list_is_last() instead of list_entry_is_head() add
       KF_ITER_NEW/NEXT/DESTROY flags add msk_owned_by_me in _new()
 - v6: add KF_TRUSTED_ARGS flag (Andrii, Martin)
---
 net/mptcp/bpf.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 2e4b8ddf81ab0bb9dc547ea8783b73767d553a18..d3b5597eddb915a19eca87d87c31a27dfbdda619 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -29,6 +29,15 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
 	.set   = &bpf_mptcp_fmodret_ids,
 };
 
+struct bpf_iter_mptcp_subflow {
+	__u64 __opaque[2];
+} __aligned(8);
+
+struct bpf_iter_mptcp_subflow_kern {
+	struct mptcp_sock *msk;
+	struct list_head *pos;
+} __aligned(8);
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc static struct mptcp_subflow_context *
@@ -41,10 +50,57 @@ bpf_mptcp_subflow_ctx(const struct sock *sk)
 	return NULL;
 }
 
+__bpf_kfunc static int
+bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
+			   struct sock *sk)
+{
+	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
+	struct mptcp_sock *msk;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_mptcp_subflow_kern) >
+		     sizeof(struct bpf_iter_mptcp_subflow));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_mptcp_subflow_kern) !=
+		     __alignof__(struct bpf_iter_mptcp_subflow));
+
+	if (unlikely(!sk || !sk_fullsock(sk)))
+		return -EINVAL;
+
+	if (sk->sk_protocol != IPPROTO_MPTCP)
+		return -EINVAL;
+
+	msk = mptcp_sk(sk);
+
+	msk_owned_by_me(msk);
+
+	kit->msk = msk;
+	kit->pos = &msk->conn_list;
+	return 0;
+}
+
+__bpf_kfunc static struct mptcp_subflow_context *
+bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it)
+{
+	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
+
+	if (!kit->msk || list_is_last(kit->pos, &kit->msk->conn_list))
+		return NULL;
+
+	kit->pos = kit->pos->next;
+	return list_entry(kit->pos, struct mptcp_subflow_context, node);
+}
+
+__bpf_kfunc static void
+bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
+{
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {

-- 
2.48.1


