Return-Path: <linux-kselftest+bounces-23596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54B99F7E6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B3F57A1E6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A13227BB3;
	Thu, 19 Dec 2024 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak6lNNq6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D397F226535;
	Thu, 19 Dec 2024 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623435; cv=none; b=NCXMfNeCALL288cpJdEeg3ApGN9rkxzWql/YRtTppCFXo8MMTL/kE5o9keIv1dXfgjkdvBICTcpwe3b6HzUyN/86kjFU6ZOpZEr3psY8obZ3w8HQtgEXa484vKPm/rYsuhAt2dUJhLv7Pxr0pN8q1pojrzGkQESgam7NchA7VL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623435; c=relaxed/simple;
	bh=YbNEkDatxwQX2bJepzpJ+SkdjZp9ZYabi3reVfSA1Ug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FeWN+fXbfQaa148xxvVtJ5sZYR2wTKxGMyufMKPiandy9KoAdsMRyu5lFU13SK/rT3kcjnHGOCzDT5LsdI9N88r4y1tjWOUClX9Q1niyXNOHBhNen/QYaLyIvIX9Fl/BwpYRV7Lt24aVLtZD8SP2m0ydX6ZR8Ci8HgtHXYCwRoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ak6lNNq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1798CC4CEE0;
	Thu, 19 Dec 2024 15:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734623434;
	bh=YbNEkDatxwQX2bJepzpJ+SkdjZp9ZYabi3reVfSA1Ug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ak6lNNq6QnT8JRtbOgd7CFUtE6vfNe/cai/M9fSubIGDkZdJpgnrAixaEhlwMyl5J
	 2yVF1cjYqsRNwUlwzpg70DEzFVXeN0O4en0bphFsG6BY8Rb9W5Xr40ulI+VcfgXquK
	 aRJnc3IKA35eSR/dArHsilvORiiGEuNlhuaZvj25/QfY1bEfzp5Selut6psPOVteBR
	 TmYepnKHW31fbWYRdrrZRTvz+5Eg3AVQzNkZdp0tu/5AVVDxMSlAIX3ICfILIaWBe7
	 lj84r16brhr4WgMh+n7REzd8c9y5QUIRoANEfQJem9eSQEmmtdDKbw82ubwpHFl90E
	 X5BVzxDsddvqg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 19 Dec 2024 16:46:43 +0100
Subject: [PATCH bpf-next/net v2 4/7] bpf: Add mptcp_subflow bpf_iter
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-4-ae244d3cdbbc@kernel.org>
References: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org>
In-Reply-To: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4448; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=v0+LtDuhV9sdYgRZ0UMX9vl5kYAb+yNIudzVYxf80CM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnZECuVCGNdAdOhL0Zly6Gubt2PHoYSSeHM9+3a
 39IWNQTX5eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2RArgAKCRD2t4JPQmmg
 c2vyEADOLPeU0SdqV8H5tOQeYhtW06IxLD7L/XaIWc7tF1nZoq0C0+WR9++r64dM6UfvR3vTjj8
 L7LmzecqerXziCBTz6KRn4OkA8uuLlkPg+iMuhpSxX/nQLz2Rz/qSZ7NJZjAVKhPoxu1crpA1Y6
 236Jd1SKx3kAgsccmmLx0uJ1lxst9l8h+VbCWJwWtuJbd/wuRjmIrDr4tRD6GgYksXUdyGEc563
 lACoEKyf9L/dk6hJK006wFnPhgEo4KhgD9FunSkN9hUE0oLA06cIBXCsWHpjD7WD8MmXr2Crf6A
 4STOYn1kje55T/HOeCF8DX6Jsag67VMziBbJ5P5W/fB/1xa6ZUIoDfX7O1/BXYOVnNFJi+7xJnw
 SAdTwrdD+R/jd9JQhHtwp7W0Bq7SRBBHTa8uOJs/L56P6abkXphMr22r3CrohW8eVtffObZ+Ouw
 o9G86640CqcU067yzk5kVULULMm9tTjXBFWKzv/ExvnnXZYFh7lDvPHYGtPZ08sU6CC88lU1Fiq
 ezMoRirmTSbKt9BIIvnfG3fHe3wDAEJhf/EYcdGN/gwxGb9MFHbeAG5AhE1lTD8dzK3+S3gOXxo
 Q3cqdwICni1efEUNCAu26RDVoHG0bjjXUJ9OEKKrJXCDSWknHUl2DavKW45dPC64uIC+0JkziXe
 cMK0LyW2/cOblmQ==
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
 net/mptcp/bpf.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index c5bfd84c16c43230d9d8e1fd8ff781a767e647b5..e39f0e4fb683c1aa31ee075281daee218dac5878 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -35,6 +35,15 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
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
@@ -47,10 +56,54 @@ bpf_mptcp_subflow_ctx(const struct sock *sk)
 	return NULL;
 }
 
+__bpf_kfunc static int
+bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
+			   struct mptcp_sock *msk)
+{
+	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
+	struct sock *sk = (struct sock *)msk;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_mptcp_subflow_kern) >
+		     sizeof(struct bpf_iter_mptcp_subflow));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_mptcp_subflow_kern) !=
+		     __alignof__(struct bpf_iter_mptcp_subflow));
+
+	kit->msk = msk;
+	if (!msk)
+		return -EINVAL;
+
+	if (!sock_owned_by_user_nocheck(sk) &&
+	    !spin_is_locked(&sk->sk_lock.slock))
+		return -EINVAL;
+
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
2.47.1


