Return-Path: <linux-kselftest+bounces-6348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06EB87CEDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 15:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8354283CDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 14:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3DE3B79E;
	Fri, 15 Mar 2024 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeT/ujXO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7423C68A;
	Fri, 15 Mar 2024 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512986; cv=none; b=LlyPjjYoWAXjfxRfjk/f+R7RT19ReUPRzwMYuRJZzqPQxCJAAy7lha2LAK03sznshR7wEWYTquU6c1qV2nxIMuEXrbPbXqeeELqS2cx4K7CRJpq6H3RnmEl1rUeFCdvDD6ZDyxV/XbfYx+xeqi0Ud8hGgpvsYINcLz4dzyo9M3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512986; c=relaxed/simple;
	bh=4PSR833wK54GZMHK7oT0FJLSGU3g6RHprWT+gjzjz4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WXrt9Z52irwG1CZxD1VQ9P6bKFpSvP0quhFf4+3z0h66qtNPruigiuXPmbF5thhvWuGp4FTG8DCFZjx2etFafc+cffNH3xebW5dlmhZAO9r4DBDiKpII+JhAfYkZJIW0xzKV0p+S4ej2/Uc97kZ8yKCjeNbyxiNjJ8U6+LKVn3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeT/ujXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD7DC433C7;
	Fri, 15 Mar 2024 14:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710512985;
	bh=4PSR833wK54GZMHK7oT0FJLSGU3g6RHprWT+gjzjz4I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oeT/ujXOzMWZS0hGAflCnWfXFC4EXS6R2Ft/UU7yNwScE1pgAFMs9L86FwB0FhRvg
	 BN4hNZhPxiypHob04e5o03ZOo76Xqh4WUYODrdw76dXX7wPKV43liuIOoF+djtGqYz
	 a0m6dsdUk0RNoT4UIcbQPAfaC/ftuOnFayjnQExxnW0aiJcdS0Td/W5bCw2TvMyMgQ
	 q7pSMnfQ4pnhbK2OV7VgL9nBRg8fzbt05SG0SJo/MemK8o9vIPzhtP3WlPFu6SmJcC
	 qC54PP5ioc5y8zKQ9egFLMq/pCPwVr0nOzUSs5cn6/vOdMILfpx379ddUB3ynOM7xl
	 i+IYMwGJRMaFg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 15 Mar 2024 15:29:26 +0100
Subject: [PATCH bpf-next v4 2/6] bpf/verifier: add bpf_timer as a kfunc
 capable type
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-hid-bpf-sleepable-v4-2-5658f2540564@kernel.org>
References: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
In-Reply-To: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710512973; l=2798;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=4PSR833wK54GZMHK7oT0FJLSGU3g6RHprWT+gjzjz4I=;
 b=EUQIDqnCUQ4IzyqEY6pGPvT9gQP7IGI3pAKO+L6ei9K4rfJTvDWADgaqn0NuOvlLe445PUhwe
 GIKavhQXNO/BYatc0dBS/6XHpG/caDvqWDyqhZd2P28n0ZwVc1WbjEB
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We need to extend the bpf_timer API, but the way forward relies on kfuncs.
So make bpf_timer known for kfuncs from the verifier PoV

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v4:
- enforce KF_ARG_PTR_TO_TIMER to be of type PTR_TO_MAP_VALUE

new in v3 (split from v2 02/10)
---
 kernel/bpf/verifier.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 63749ad5ac6b..1483ebc0ee73 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10826,6 +10826,7 @@ enum {
 	KF_ARG_LIST_NODE_ID,
 	KF_ARG_RB_ROOT_ID,
 	KF_ARG_RB_NODE_ID,
+	KF_ARG_TIMER_ID,
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
@@ -10834,6 +10835,7 @@ BTF_ID(struct, bpf_list_head)
 BTF_ID(struct, bpf_list_node)
 BTF_ID(struct, bpf_rb_root)
 BTF_ID(struct, bpf_rb_node)
+BTF_ID(struct, bpf_timer_kern)
 
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
@@ -10877,6 +10879,12 @@ static bool is_kfunc_arg_rbtree_node(const struct btf *btf, const struct btf_par
 	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RB_NODE_ID);
 }
 
+static bool is_kfunc_arg_timer(const struct btf *btf, const struct btf_param *arg)
+{
+	bool ret = __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_TIMER_ID);
+	return ret;
+}
+
 static bool is_kfunc_arg_callback(struct bpf_verifier_env *env, const struct btf *btf,
 				  const struct btf_param *arg)
 {
@@ -10946,6 +10954,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_NULL,
 	KF_ARG_PTR_TO_CONST_STR,
 	KF_ARG_PTR_TO_MAP,
+	KF_ARG_PTR_TO_TIMER,
 };
 
 enum special_kfunc_type {
@@ -11102,6 +11111,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_map(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_MAP;
 
+	if (is_kfunc_arg_timer(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_TIMER;
+
 	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
@@ -11735,6 +11747,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_CALLBACK:
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 		case KF_ARG_PTR_TO_CONST_STR:
+		case KF_ARG_PTR_TO_TIMER:
 			/* Trusted by default */
 			break;
 		default:
@@ -12021,6 +12034,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (ret)
 				return ret;
 			break;
+		case KF_ARG_PTR_TO_TIMER:
+			if (reg->type != PTR_TO_MAP_VALUE) {
+				verbose(env, "arg#%d doesn't point to a map value\n", i);
+				return -EINVAL;
+			}
+			break;
 		}
 	}
 

-- 
2.44.0


