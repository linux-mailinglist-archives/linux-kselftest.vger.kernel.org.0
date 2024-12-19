Return-Path: <linux-kselftest+bounces-23597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FE79F7E74
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0D3188F092
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 15:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28CB22616E;
	Thu, 19 Dec 2024 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVFAE+lX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F14E226163;
	Thu, 19 Dec 2024 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623440; cv=none; b=CoSxb77/uEoxmUzcze0LvbXJbQd7Q8YutBIY1pcyLoXtWU6WbBrKG9n0+HBWLSBDyaAucdFblH7HnYqs80rxGCMGxaIE7oaA4Nfb8Ok5jKN7mJOKNh41n7haS0wa9k9uVWyvGoJ2AKrqWN1CD69LBNpgGaF4T6R5XQ7wrH4FDT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623440; c=relaxed/simple;
	bh=885bqhsxwSrHf3hr8m6L9FjjSKd1BhbPypgPwXzqfg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P7I8FuFT1N+MViGXmGoBPTeZZIufWYAcRjcldgDcCA+saZ3rrOjtfTe4vO0ibEV0yvnopKQS6U5UIVCpa96p5NdOYxl8rDlejgZ6MWAZTwZMI9EP3lFO/+aOS4gBR0/P8i8NlR1kqFlDTfv0hbqrQSmCnpht20vo8681gLPxhSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVFAE+lX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC76AC4CEDF;
	Thu, 19 Dec 2024 15:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734623439;
	bh=885bqhsxwSrHf3hr8m6L9FjjSKd1BhbPypgPwXzqfg8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KVFAE+lXFnFxPEFWLHM+mL3Pvb9Xon/BYJlxo8SafbWo/85IE4LEf23aHFO6iTwWI
	 6D6bqdS0H3tNG5iV0PRSncl8lmjwN0RRZJVMcOlkcjXZBlY+dRqzqM1GvQ2pl2Jd0V
	 evcoKLZ2VLZOSvMuwySFKoP4uUTsJLTNv5uDJIkTLBuXgYkedSXp5UFK4bp9TEP40/
	 StOtotULv+PzCCQN9TXFDh/DpSvHOwY8alETHmTXBi0aYo5wCvFJUEXdK8335flivI
	 L+GubkLyR0tPXPjRsm94bAdgCJUhekMFXkrBOpOCbSofChv5Eyh758ZHdF6X/mmcvJ
	 rG7Y3TNvN/3YQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 19 Dec 2024 16:46:44 +0100
Subject: [PATCH bpf-next/net v2 5/7] bpf: Acquire and release mptcp socket
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-5-ae244d3cdbbc@kernel.org>
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
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2002; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=EEPXf9FaRn8aAdYNTiDw9/bU62ypSH7UW8zt9P0k814=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnZECul4EIMgu1Vz0B45o5ZDIdsPYVVKHIytZiV
 YxQHcjGFRGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2RArgAKCRD2t4JPQmmg
 c2vYD/9Tkzh/OtVbJRSiXvaFURaoVlPR5w+InOLbWk5p7hT/2LxKXT2zYMBRJJyLZ84nY9r1V52
 VNJOLrvkHk5vXVSt7tOrtNEQkHaDqX0hAD0kaTKVBZ2SxppKMM5paua8k9RpTitKsUstr6QAIDZ
 fLR2c54vJZKB5TkBRrgIx5oU24Q5DILIhs+OMEquzAXc7Z3WnXqteWXcncQWi+DJ6pXt7bWFiL1
 oIYPt2Vr16n2zWLjFGa1mXY8PS46JKit2eb8MhnEhArjOeWEDMPd9k5wXZqq5cOA76vsIR/onkC
 NX5HzPf7Iea3//EdMMatk6FwWXR214MPucoMsRXuO6BP5/vgs49XpCgQ2OPWAp4xy0CnJUjiZl4
 kKWsbAnYCOoDRyvxqahvXm7DqzUJXUzt2mhLwX17cQBjINFguwgC3bYcWjUVfjLDBTPA4O0wNGB
 8Jk07Em0QulHSciKNhZe3tExisppCOn+oLhZSX7nDQpvJC3d/4bUX1X4VLGJ9gRTbGT0G9dO8G8
 2KSst0LVmUYzylMYsXLlaBZdHdd0xhiqKe4/rjTOzofLscNQ9hFw3fEjMqfYk4XkgUYYKhZLGx1
 bwO9AE/dq2wseAkDiDTUnJOAG+FgO9eiigVeOpi1KmzVqGRBmNazNAYp8GTzqgqlxtsgH7nD6PK
 s9DCj4hYOaaWFxg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The KF_TRUSTED_ARGS flag is used for bpf_iter_mptcp_subflow_new, it
indicates that the all pointer arguments are valid. It's necessary to
add a KF_ACQUIRE helper to get valid "msk".

This patch adds bpf_mptcp_sock_acquire() and bpf_mptcp_sock_release()
helpers for this. Increase sk->sk_refcnt in _acquire() and decrease it
in _release(). Register them with KF_ACQUIRE flag and KF_RELEASE flag.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/bpf.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index e39f0e4fb683c1aa31ee075281daee218dac5878..d50bd1ea7f6d0ff1abff32deef9a98b98ee8f42c 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -97,6 +97,23 @@ bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
 {
 }
 
+__bpf_kfunc static struct
+mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk)
+{
+	struct sock *sk = (struct sock *)msk;
+
+	if (sk && refcount_inc_not_zero(&sk->sk_refcnt))
+		return msk;
+	return NULL;
+}
+
+__bpf_kfunc static void bpf_mptcp_sock_release(struct mptcp_sock *msk)
+{
+	struct sock *sk = (struct sock *)msk;
+
+	WARN_ON_ONCE(!sk || !refcount_dec_not_one(&sk->sk_refcnt));
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
@@ -104,6 +121,8 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {

-- 
2.47.1


