Return-Path: <linux-kselftest+bounces-21700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6257F9C212D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 16:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25EDA281A2A
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A819121F4BF;
	Fri,  8 Nov 2024 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAuz11Lm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FC121B452;
	Fri,  8 Nov 2024 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081177; cv=none; b=DqQcU3ksKdiZYgDN7bMoT0FGbqu6+if/PybSCqvaU4WXng8sckzNdVsujzdYXN4xgsFubT9Xc86PnoYRRWThd+KZDugg5TGc06YjWNPJYIkM4irlIB8vGDANdDs5FWEZUgkOuh1h/J+cMo8P9xDW3TI23hp8VSWbEOPJfoJKfco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081177; c=relaxed/simple;
	bh=RF/R77yecZxwwcV/SQ7kt2sEMgzQozbeyKh2oAd6g0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eBEzRf+MasinqUxz5DE27GAoMuzWhmXgjRGuMq2CyDPOnqRcmCxbw9CAPKBmSfexjZeejkvPGkJgdwJPfkF/dRHOZ6mPPNzMa0SH+KyXwfSWuhkxeSZzz5BESKflYLsNyrAC7O//62i25PglItpE9gEWkPHmH+aeXif+LJEe+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAuz11Lm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C8CC4CED8;
	Fri,  8 Nov 2024 15:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731081177;
	bh=RF/R77yecZxwwcV/SQ7kt2sEMgzQozbeyKh2oAd6g0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kAuz11LmrgIiiq2DyAQGkw9EDrvBnoVrf7/LT+Cev/e3XtRLrB81mDJr3IfIORgRW
	 I/psYJeBkan5oZ4+hfYdQbmpKJzeKddAYq5kae1mjy6R/OTALQcqE0gvAUfWCL7pAT
	 bKU2DlMnF1m0KKzNyKPIcXWl9TpY9pLB2MMwiiuh5LW4E4ZfkA2aEduGd8V+NCYh6z
	 66ND4g7Ym0QFDu5hg+VcTGXq+56bFbR/IhhQMNinYP464LjOHMZFeHIPpF9JR3GU8C
	 7hpc0Dctpe/9A08T2bXVPVnuA2XKTIAZhs+G6yIzPZhnwhHKYBRFyAI0K6AGdYu2R9
	 dtCxfVK9EOL8g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 Nov 2024 16:52:32 +0100
Subject: [PATCH bpf-next/net 3/5] bpf: Acquire and release mptcp socket
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-3-cf16953035c1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Mon90wYreVBu0zG7BWuM4v5dwTWYbUA1gVh0OSEBwMA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnLjPB9y+Z3Spcbu/1rD0z32/UJ9iKr+fZG4QEk
 0AI14lhVoqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZy4zwQAKCRD2t4JPQmmg
 c5HeEAC+0D3ACboydhZuejXcW7ZiBI+jPyP8G7/xeVODm3EGzVZhE9jBIhgBnXmkk8H9UfeLu1S
 /964kUUN8ZftSBqM2fi8Nc8nE07AUdR5BPzh7oaq3YnVfeVtCMn58te7u3piYYlv0Zd3unwdfL7
 NuOf+wOqSNv2V7eplnsyQiltUK9qcGB1StyqYpREAPAW2xmn0nNkpfbS7wp1VlkNqDy+uOboeva
 dNNw3xcyNaFmiHcT6PaOtb6asHZgtVfXwReLwnKS+rAEt+LDScBd11D6NwWr7UcPcwvlDBeDiIm
 ArC9udmdd9gpP4PZGs0nPs5wpJC10O/RrkZzSZemm5eVJfzCw8rnATiscWdPq8KsOAC49E745UM
 j4ghxzaitE6Ccbf7NiJLX6CQDbxAQeGsg5xTYivNWvF1WQ2xuENmv9IYfo/dE3io+slE8wBOcnp
 bq0BRV+Tyjgm0EvHAUp01u9y9XeFQichX/AOzV7NG8E0ASmffXEFIMSXu6zUOoOk66F5/djWpQj
 QV6QDOnAwQ/9kxE78zevW4QFMZx5Z837bZduGnUxZPlhgVbFRkP5RrEMAjhd0nfgBrAGadN+XxT
 gxaDBsMJJsC1lZcancObtjdN0cTF7dWJh74QmwGez+vBYrPh/R7LmZe6E7+bYjJydpvHdAIKYjl
 zmrnclEMWYUuBDQ==
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
index d107c2865e97e6ccffb9e0720dfbbd232b63a3b8..5bd04548e846b4dc120dbc83725a604821fac772 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -90,6 +90,23 @@ bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
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
@@ -99,6 +116,8 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {

-- 
2.45.2


