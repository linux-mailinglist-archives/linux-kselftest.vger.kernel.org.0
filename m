Return-Path: <linux-kselftest+bounces-23595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EF09F7E69
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2F377A38BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6543F22759E;
	Thu, 19 Dec 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWg1mcg9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF31226199;
	Thu, 19 Dec 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623429; cv=none; b=kuqjIRxIsb24FMBQZ1OWrLp68dMoTsrP9w2FmjAjw+jhxB97srYqnjrGzziDYNtAZujMgSySEkXCqHmKabdPKA25kvXFXzkwTfIlcn3nTw3CxFdGUvMfmlcVTkJWSQsd0VoYFtKrqK9D/0pm2NXWa2/G3xN6OuVhbEWU28RTKBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623429; c=relaxed/simple;
	bh=tCCojsjaNMqopdUO1fLBb6qOmphgPi2i/lnsTh4xe1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lzNSXyu/0qzWF1IfnBr2Q2Yi4yeYTnHqAOJGWqMf9VA6Hus4cczk/DGKYUVBNM5uNLVEG3dQFWRW0gT5lEhZRO9zuiqARnWR5Lr0R6ByhC/L156MWMmmbWG23vaH9TBGLIW2wjNCCxnOPhkmNNJEZSdOaORoMDRCPM6xj5itOxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWg1mcg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B06C4CED7;
	Thu, 19 Dec 2024 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734623428;
	bh=tCCojsjaNMqopdUO1fLBb6qOmphgPi2i/lnsTh4xe1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DWg1mcg9JfTUVSCN2nxu+ykM2LFZoGmgXdXkz4Y5P37JKH+T7fuvkDazpO4z+6zfK
	 D9UqoCgmT9GsZXdvwuU7TxJHPh57zp63LJOtIbWFWPhPLQYq0++WU1BkXWFl+bQbsf
	 M6l5fE+fk0xWwaf0RaU2ghUIbrsshg5/irTmrYiZftqx8W7T4FECo2b4j78vab007/
	 1bW2UV6GI7R4vu1qW7kVEw5CUs3+i+dU4DvT1sx8hEUkLdJ53JtxaksKxqbxF9UUWC
	 LFYGDWT9yaYxw0zDrvHdvZPFshdeIAKQ0x9WSjaK2dZuGbUeEAYUh6RrjC7fWEPmbg
	 A83LsrVAcIr2A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 19 Dec 2024 16:46:42 +0100
Subject: [PATCH bpf-next/net v2 3/7] bpf: Register mptcp common kfunc set
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-3-ae244d3cdbbc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2433; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=sUSvut3vAWGTd7i08U/NUT9KFz0M0hzmtEUkxiYGJ1U=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnZECuHZx5LJSpxvnqSR8Mkx6mESAhE8zGDz2Wu
 eQzysLkZO2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2RArgAKCRD2t4JPQmmg
 c0+BEACEVLXWQTZqAD0ywm+lu6iZsZIdj3CZiINaslFKdItlJQlZxgu4tZDaGlvQI28kpZqSTxg
 D20dOjG6Au5BnDlKlGSmVDHYHhXEpYXBeBt/w/WTSE1Mrxtaabg/eke5J1DKwDBY+oFTC9OU5Ql
 1/rGxjgql0EgVAA4xqTERZcLqC5vsHI79cXj+YqKNXUzSSbw/S66coapbxsaY8BgvPeTy5v9t26
 Mynl8/xl4J4pNhbIb+SPH+6H+cwk1V2hxbjW6/dU+2wrTXdqHHotPBZcPLhqXhAD19MZ180Jyj2
 DRdIQsY4gWI/OpVGFvvRBhm3C6QWQKQEarE2eG2iGoVANTDogT5vvJ33tec30u8meeQUtp2tvpJ
 SDgNJLY3eWwvtmnUO+7herkIzZmzynNv4c4I5sPuriNDID7ZKDOqkEF0ZtpqICjRJ9nDKJmQH+l
 /LLf8tJZ3wCihOnx1AbDHfPIr9WuYpIRmUirjDqgyGUyAGCi0PmnmpQt9Oi23Nb+6zijWczAmYO
 pU0iKf7JKl1NhMqtddGr9JB9Nb/da73ium7YwgWOdOLxz2z3Xl35dOhtmW9KrMYbiiQBr2B99F+
 G46M37OwMBDWe669wsLaqSiXRucQvD6mCBesfGcWTDvrfkTaYGFIdrZBtQAgZCcaYUJ18RT/U23
 687S6Yq+c6KwXrQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

MPTCP helper mptcp_sk() is used to convert struct sock to mptcp_sock.
Helpers mptcp_subflow_ctx() and mptcp_subflow_tcp_sock() are used to
convert between struct mptcp_subflow_context and sock. They all will
be used in MPTCP BPF programs too.

This patch defines corresponding wrappers of them, and put the
wrappers into mptcp common kfunc set and register the set with the
flag BPF_PROG_TYPE_UNSPEC to let them accessible to all types of BPF
programs.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v2:
   - Thanks to the two new previous patches, bpf_mptcp_sk() and
     bpf_mptcp_subflow_tcp_sock() are no longer needed.
   - bpf_mptcp_subflow_ctx(): make sure the socket is an MPTCP subflow,
     and add KF_RET_NULL (Martin).
   - Restrict this kfunc to BPF_PROG_TYPE_CGROUP_SOCKOPT for the moment.
---
 net/mptcp/bpf.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 988b22a06331ac293b36f3c6f9bc29ff0f6db048..c5bfd84c16c43230d9d8e1fd8ff781a767e647b5 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -35,8 +35,37 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
 	.set   = &bpf_mptcp_fmodret_ids,
 };
 
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc static struct mptcp_subflow_context *
+bpf_mptcp_subflow_ctx(const struct sock *sk)
+{
+	if (sk && sk_fullsock(sk) &&
+	    sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
+		return mptcp_subflow_ctx(sk);
+
+	return NULL;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
+BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
+	.owner	= THIS_MODULE,
+	.set	= &bpf_mptcp_common_kfunc_ids,
+};
+
 static int __init bpf_mptcp_kfunc_init(void)
 {
-	return register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
+	int ret;
+
+	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
+					       &bpf_mptcp_common_kfunc_set);
+
+	return ret;
 }
 late_initcall(bpf_mptcp_kfunc_init);

-- 
2.47.1


