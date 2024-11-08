Return-Path: <linux-kselftest+bounces-21698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 585FA9C2124
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 16:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8072B24412
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6DC21C166;
	Fri,  8 Nov 2024 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWwvA8UO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0001F4FA2;
	Fri,  8 Nov 2024 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081165; cv=none; b=Nb1asgvwJIeMpGPKcCwdYyz5M+lu0KSwWknD/ew4BEPf/uJPYHnJiSeTsQd5Ty43Maf8ohg5lbAQRa9kNyMMwAJho++xC3dCQsRGmk+pJxIsKuRrSOi7gg5XcTKCtvlUFgryaEB1wtID3qdROVnIys+gUYNt3T6EcgrWKZ9w17s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081165; c=relaxed/simple;
	bh=mEh3XOTc68kzTvDwmnzBDb0cxXxbTbSlC8szo/9HBcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=slFUfzK64l+OSUia+izyBrKb666hY4S/4Wm3z1idU050JgUaLiJMWsz4rW/QbgO5L6pjIiQdIyMfC4Bx0+T9Ka/JsNzzDNoupQHEX19jjzPIaxcSqO8C+yNGraeO5rCH+w9FHg9Pk35lxSHPHh3yfo3baTqb2E/jT/Tu9s7pFrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWwvA8UO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F7FC4CED3;
	Fri,  8 Nov 2024 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731081165;
	bh=mEh3XOTc68kzTvDwmnzBDb0cxXxbTbSlC8szo/9HBcg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SWwvA8UO7DxE00k1YGaRjIRy/N480ZLqK18obWph/YSfxbFxpunP0lJqSKb1aK6nL
	 iPQVmf3w5Mm0GbEqrQdtlfDtM72MV7pJn4rPivGOnv4TOOZ2gHGcS2bU78WOu10hnI
	 J1/juZWmLYWfetTfjj6EyOgXnQINJlOIlv+5AqKQH60hD7WhyDrBSmt5VXOi6O3bMa
	 SUtdK64WWTnTikaH0N3o9tZTlaIMwSbsqkzkBllSkrzlMQdohSWwzRcqRMr5HHgoxg
	 sxuIWD0E5XmXhfdkj2iV+EXfdibOnUJbdC5t4/V7kEAJtLWajr2BWovBm+hql3SQUK
	 suTtQkU731ZXw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 Nov 2024 16:52:30 +0100
Subject: [PATCH bpf-next/net 1/5] bpf: Register mptcp common kfunc set
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-1-cf16953035c1@kernel.org>
References: <20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-0-cf16953035c1@kernel.org>
In-Reply-To: <20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-0-cf16953035c1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2337; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ZfmGoCnxT5aCkK7T9o4SzLEnGMSc8lW3wKNOypvXmZ8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnLjPBdvjTYmNfnwSvvfe62/88Iy13zBc79tYV2
 lOK6NX2RsqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZy4zwQAKCRD2t4JPQmmg
 c0uzD/4mUXion0365sHlcGOAjQIz97cRKrhmfCCtmxBuu4910qPVeApn2gexVT09LOiL3EAqXHX
 1BGSQlbeMggnt4NaP+FIxt9RnNJq912YuG1W3g3C5BIzDdW+qfuZnLDCGS/rCO3W8wIdTMrNb0y
 JrcdMPvHWxIdxmfckqDpDFcA62x6nGyohazv0BuZiLoR1hqjlNUwiSV1HW0pk83ia/NqFcH0qRk
 f3vB2WqTJIGRTE3uEq7v7Rm2wSB9YIFBrszTOgNo4ot2rBmURT9417dknZqf0JNNxdGii96IuQI
 8j1dw/jURE1vjzMXet8108YzpnxZ0MW0EdIqHQW5A5i9n/nYfbsynIp4dAxOHc0JaDbkQyLuwPo
 NO1I9nTVHJbIlYuLULp7dKLf5TiCgC2PFvdipuVNdSgspgSJMeBUKHf9zs62BG1xVLdTn/cerxP
 d/MIDbaByut5OuejOySkLZKiP7fL+J4mFPiSVOc7WLoPn8tuq6zK55+mb8ThUbLVzaCxB9IyN1T
 FuFCOEPvBzfyS+RJejFnE1UieijNtonPyQ16V48PiO1CZ0kim8D2PNi3vUXlAsWKhafnKFz7y9C
 Ec6I5gKXUMOjq3LPRiub8rpcXaTPIygCTQCYblNGGgZwSVk4M/2hVPfV7daAKAQWM8wQ3ESnlFM
 FCBLIbybQCO2IpQ==
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
 net/mptcp/bpf.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 8a16672b94e2384f5263e1432296cbca1236bb30..6f96a5927fd371f8ea92cbf96c875edef9272b98 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -29,8 +29,46 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
 	.set   = &bpf_mptcp_fmodret_ids,
 };
 
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc static struct mptcp_sock *bpf_mptcp_sk(struct sock *sk)
+{
+	return mptcp_sk(sk);
+}
+
+__bpf_kfunc static struct mptcp_subflow_context *
+bpf_mptcp_subflow_ctx(const struct sock *sk)
+{
+	return mptcp_subflow_ctx(sk);
+}
+
+__bpf_kfunc static struct sock *
+bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
+{
+	return mptcp_subflow_tcp_sock(subflow);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_mptcp_sk)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
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
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					       &bpf_mptcp_common_kfunc_set);
+
+	return ret;
 }
 late_initcall(bpf_mptcp_kfunc_init);

-- 
2.45.2


