Return-Path: <linux-kselftest+bounces-29511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD6BA6AC68
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 18:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6CF5176C7B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 17:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87080225403;
	Thu, 20 Mar 2025 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5HNY748"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBA71953A1;
	Thu, 20 Mar 2025 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492957; cv=none; b=J/9CLmxQ90ZxqpnM30eWKnovm/lFBnvKiSthMGq9AyEAWM+YRypgoLtG5Ptv0l+IV3M4f0iG41O2prfsOZbumTYe84I4M09zktLmXb+Yf/692srKLDS0m6tbaAiFccXEGBsKW8swOSJ2P0H2gbwtbDshBOGqP+YxhrE3kInGQ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492957; c=relaxed/simple;
	bh=6flwI7DvCamUH28xXreXjo5qZFecF1k66NOszGh1/Jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gsIqzDbXPLG7eNdm80x/3XDZ22betzGAky/Bmf3JPjdsDH8zGO0ZaPm38XXoC6zrhpa0BIMI8D3UIVFEm8GAclpsgQ0ZGzVAN94XvunsA2yVEsdIgHHhpmlTvbr+Ipvp8JaMDJrAuSv9N9O0VspCKzL8YCUn1m3wkJSXPx+R9EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5HNY748; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B7BC4CEE7;
	Thu, 20 Mar 2025 17:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742492957;
	bh=6flwI7DvCamUH28xXreXjo5qZFecF1k66NOszGh1/Jo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g5HNY748Br73T4UeqNiKvFgBw3Cowg0BP7k4byTnA9aMO4hwxH3u2XMg5uU6rjHNB
	 iuR7UL9sb7VUV7YKvNkMXOvAZeVeFaF6oA2L7GMg5lCNNBsKuQllbtBPqlvGFS36/k
	 gZIol5qb3RXsR2cBJMwcT7nxan7++heXmLhASWZV5uyj9JEb9htWvo5Cxz7A3e0J7m
	 FAM2A7nPiePnVerM0A8xhkNdyiJ9IwuK6M728kyVy/tOc91+QnzwErkFiNR5jbtkIf
	 isHdGqzUXKqCpN2+bOH2AjPFoUEE36tLDaCoSm4EJ4IInNNpUwAusSloFsSKcHOEtj
	 hemdJGqF/AUfw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 20 Mar 2025 18:48:40 +0100
Subject: [PATCH bpf-next/net v3 1/5] bpf: Register mptcp common kfunc set
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-bpf-next-net-mptcp-bpf_iter-subflows-v3-1-9abd22c2a7fd@kernel.org>
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
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2433; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6O+8ayya8ZdnKio3ofTp7U6RdhswjA6o7mb2XeKGqAo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn3FUR4uQU9ub712OHYkxXd6lq+kpQTWC9g74cx
 Wh0EHp9w0CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9xVEQAKCRD2t4JPQmmg
 c+cRD/9TsZm/exqwkK3nzZvVg6zHCaZnbD5J4OsSHlBE14CTClAS85IBWpqam2t0/lPH894ruQD
 IJgCx5YN835NLxKhsbC1RYoSycGOy0JBtQdOKTFI0VlYdg/j17zH2WCls6WUX6vV/fcKaxfiSrr
 FjMLTQOa8UTS5D84VZPk2R+nMMSuxIeUOJrt+D+6GEjfetY6vSKJ/dsryKGSNPuRtApJBfi2d8s
 gUBqpNO7nXYCVtANyBWLAcOCCTy5hq6qq8jcMOIqoU4V2zzBK2RG1omcLgqsaAMaVvQziFyyrt8
 RNmBrRbAAoZFWQ58IF9EUXl0hrIECznrKLOCmWURHHURc/LxKIqqQ7220Mgwwmtu83VC6BTX2N7
 6G7BJV3GK5Ll0ZK+T7X0TdigpnlNTVvgZECx+qFN+2bfS8U1P/X/MzrV1Hjc5cKxHu+RrmXnJID
 fGJTWcD6NAR9q1JRhVHNReLitk2yz1vtI0j0r0mHZrzmEUQbrScB1+zneY75tdSgqx3J35usBSO
 gtPiXb9K6KPE7rUTXgqY2CXTFcGnPv+Yt4rPbx5rDXnnsOM8pmhFAqJ+fb34M5XAhb2iHi432fL
 g8Jk7aNSgW7F71OIAriTP30mtRaQLoF6vmBBKBD1goGsvwZklVsgumfi2WBty2kKN2HgwbEHv7F
 FNBQhNKtnjOGdAQ==
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
index 8a16672b94e2384f5263e1432296cbca1236bb30..2e4b8ddf81ab0bb9dc547ea8783b73767d553a18 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -29,8 +29,37 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
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
2.48.1


