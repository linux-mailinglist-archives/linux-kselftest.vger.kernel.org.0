Return-Path: <linux-kselftest+bounces-21699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988C49C2128
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 16:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD301C20B06
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81DE21C193;
	Fri,  8 Nov 2024 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPWC2ITA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DAC1F1309;
	Fri,  8 Nov 2024 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081171; cv=none; b=YsldXK0y5lubwKrOzXW5vMHySTSmlPtmyhDQxZRtpHaAlp/mtWgWWH+eAlfiuVKRzzfDwtmEvujgSBIwYLinOVzvnDob/cfgxeBl5CIn6PAHzc503BhpXZTWYZ156J29gI3cOxskEQ38H1fs93GXMRUsUmHGIuDZt3u+hjavpD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081171; c=relaxed/simple;
	bh=5YOsiNLttKWq/Ld5/UcsEwz3pOgckJnPsrplRWCy/8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUlflTQcujVrvF0Cp5MwCO7m0T7NJKCNk4Vm4fk6qVDx9AK47l68EpnouUe//kb/h5E/j8b9+MRaspq4je8V3HJmDGuJGOyrYL7AxEI87sRWpgOjHX0LY/pHbDxCBGfP8KqRYlYhzhlb53j7/EbLwbpbof//pzS8eC7WgIGZHdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPWC2ITA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E12C4CECF;
	Fri,  8 Nov 2024 15:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731081171;
	bh=5YOsiNLttKWq/Ld5/UcsEwz3pOgckJnPsrplRWCy/8I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rPWC2ITAror8Lf7cW4cwwjzc0+hKHbNUU5OoXRGWjq4gkn5PS6QcflF53Mn7rFBY1
	 k4PSz+Mhmaj+0OqnhW0eB0kov8s/8jo3tWCysXk/PZuk3LpqMaKoSJHtMxCaE67IhD
	 +xpxtdHeIArCMNdobuQI/iCNVBc7bC3D+OiVBH/cVczFJsoPkxKJ/LoO/JUlUPx5RX
	 eejCXBezecJNxZUGtcEy2etXOe2KHJY/UjwDHAR5VMqV6mBrac3JQbBBXDa9/yPyXH
	 EWA9KG1q/FiqgGEpxBTwldvgtCp5kMEzFT6OguA6JQDhdV8tf+zNl9I69d/XNvJL5r
	 yaabMG3r4LtSw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 Nov 2024 16:52:31 +0100
Subject: [PATCH bpf-next/net 2/5] bpf: Add mptcp_subflow bpf_iter
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-2-cf16953035c1@kernel.org>
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
 Martin KaFai Lau <martin.lau@kernel.org>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4014; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fOkGqZrxlK74TDATl6N8SPLqzPotdmdaTyOO796PIMA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnLjPBQpqi3TslQuEySuqdIlV0AeBwFGoYyH1An
 4OxKAv1vsiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZy4zwQAKCRD2t4JPQmmg
 c5aSEADuM56/WyZWe95dcwS5CL/3VBCSv+tlShGKbXwQX853Citmxfz+8r8m5YketqCZY745akl
 8CSB18sWzc7DW0QqBHD3zT8n9hwPelASdxVfxwuLMuWExvwL9G0tVdGqMSNEJ/NeO+KX+GM/F9x
 npMhMjphvz1cggLIl1c3TpXOAtygR1ScmHapKg7Kv/rzWajCHWAwnU9oY/DxJa/jxKBdjHPjMYU
 GAdbiTPav5MEwkFSrSn0KoGaaV5ksi9XpJA+8tv7ys6CKq3kBG6X8+AkSntMyUQCEe3MdnhJxe/
 Km8n1ukCrqt+R1wijKcXsyydNPL9QAJKy5HJ3cbLi/pnZUCnaO/u/OtFjril8bNRR4LEwCGhyrc
 i0RV764XBJgDLNeNGTj9inPaT/5OpXcTfufSxmVPvD8GwbwnSJ7Rx8MF1apViHKPfWzUtKAoJLz
 vIpGz8CgW6UFFjEd7RuV/9dbARWJNYfGByzwj+f1LnC5HpkVMKrmP4ADs9ZZ5ZOmi/DYyzDzXcZ
 pnEUfQnZKJtjwx4tryCPaDOUkqWOU7Nn3MaJVxMaQ4+9YCie/UWDDQQdSGuL/NN/yey6tdKNdvJ
 t49yAZvD+dCDFpZQZY1UO+qkGvYvL0Ta/e3ccka6tTfkBsJUI5ElW+KwGg06UVS9nU8D/cqwq4g
 XSR/KywZ5cGxW9A==
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
A few versions of this single patch have been previously posted to the
BPF mailing list by Geliang, before continuing to the MPTCP mailing list
only, with other patches of this series. The version of the whole series
has been reset to 1, but here is the ChangeLog for this patch here:
 - v2: remove msk->pm.lock in _new() and _destroy() (Martin)
       drop DEFINE_BPF_ITER_FUNC, change opaque[3] to opaque[2] (Andrii)
 - v3: drop bpf_iter__mptcp_subflow
 - v4: if msk is NULL, initialize kit->msk to NULL in _new() and check
       it in _next() (Andrii)
 - v5: use list_is_last() instead of list_entry_is_head() add
       KF_ITER_NEW/NEXT/DESTROY flags add msk_owned_by_me in _new()
 - v6: add KF_TRUSTED_ARGS flag (Andrii, Martin)
---
 net/mptcp/bpf.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 6f96a5927fd371f8ea92cbf96c875edef9272b98..d107c2865e97e6ccffb9e0720dfbbd232b63a3b8 100644
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
 
 __bpf_kfunc static struct mptcp_sock *bpf_mptcp_sk(struct sock *sk)
@@ -48,12 +57,48 @@ bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 	return mptcp_subflow_tcp_sock(subflow);
 }
 
+__bpf_kfunc static int
+bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
+			   struct mptcp_sock *msk)
+{
+	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
+
+	kit->msk = msk;
+	if (!msk)
+		return -EINVAL;
+
+	msk_owned_by_me(msk);
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
 BTF_ID_FLAGS(func, bpf_mptcp_sk)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {

-- 
2.45.2


