Return-Path: <linux-kselftest+bounces-6495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52846886F2A
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 15:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CD31F24491
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 14:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FADC4F205;
	Fri, 22 Mar 2024 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1luBfHZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78AC4D9FC;
	Fri, 22 Mar 2024 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119405; cv=none; b=ausBj2XWKSZ+6OLDZCU/Wg2EYbCzBsbIkMp4wP1a4LIm1aaEQbtsnGO/ZS8Xn6VTYlVQ1BOTQp3HD1Wd+GO8dlu+2TeqC/dTDYrPM8epf6b4WSb3B9oe5dtSTvGEjNxm7aV+4TGAxEcVt1cBX4cc9UvbugL84Kui/K96nfY+eHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119405; c=relaxed/simple;
	bh=AQM/MOBZQB8kTZ7hImM8LuYMO1/YVcBCsPzNl5BbNas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pfn7jZbW+2+uJe3qVSH8YK/bc0tieYrYNc4Ur3N4Hj9eAEkNgv28d6xuIUQiz/S2BSTSC1cia4wGrFWpz8PpEfWn7ABqju4bUvXN8Oc2wM7JnECJkCewganZV2o/brT5TABd1z141KKVYLhdKNKK/6sLRUASn0TaOD3xFkb1vyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1luBfHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13846C433C7;
	Fri, 22 Mar 2024 14:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711119404;
	bh=AQM/MOBZQB8kTZ7hImM8LuYMO1/YVcBCsPzNl5BbNas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G1luBfHZ9od5gDb8aBwf1ryLkqwrToKwM2BnkM9QUYlvxtolFrHlio0SOPezNsUJ4
	 2gWcv1c66ZXQdxPS5dyIDH/6l93zbl96jby2j0CTNwtiOdOgLniftn9OELTeR5i03/
	 QiALqaDQBWmdV29JJmvxEXkJocLo4QgqMi6X4PBIZbgS7oM1TZWkxi3jBNgS6idukW
	 o7b6NS4RnhsM6A8hcqXjQ1f6Snx2HeGzZe7w5Tz60h3+MxvHR41FyQUxRAXZvNsSV5
	 MXF3VyzKFM1j6V6Lat9aXU22FrICShFSUlZ10JA2xclNuXLM2en3AkeGOxozdvLH/u
	 DRjfNrPUikgfQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 22 Mar 2024 15:56:22 +0100
Subject: [PATCH bpf-next v5 2/6] bpf/verifier: add bpf_timer as a kfunc
 capable type
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-hid-bpf-sleepable-v5-2-179c7b59eaaa@kernel.org>
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
In-Reply-To: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711119393; l=2971;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=AQM/MOBZQB8kTZ7hImM8LuYMO1/YVcBCsPzNl5BbNas=;
 b=mdIx0Y9m0oTOKphQwoHaWo1J1w10dmVcMk1rrA6QvLWZD/2MdXCiLyOZMk0haK5DczelnwIJ8
 7pHY2K0uTf5DzekTHDciOl9I8vMax5owXMXRLKjV4zx4YExqUf2P2W0
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We need to extend the bpf_timer API, but the way forward relies on kfuncs.
So make bpf_timer known for kfuncs from the verifier PoV

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v5:
- also check for the reg offset

changes in v4:
- enforce KF_ARG_PTR_TO_TIMER to be of type PTR_TO_MAP_VALUE

new in v3 (split from v2 02/10)
---
 kernel/bpf/verifier.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 63749ad5ac6b..24a604e26ec7 100644
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
@@ -12021,6 +12034,16 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (ret)
 				return ret;
 			break;
+		case KF_ARG_PTR_TO_TIMER:
+			if (reg->type != PTR_TO_MAP_VALUE) {
+				verbose(env, "arg#%d doesn't point to a map value\n", i);
+				return -EINVAL;
+			}
+			if (reg->off) {
+				verbose(env, "arg#%d offset can not be greater than 0\n", i);
+				return -EINVAL;
+			}
+			break;
 		}
 	}
 

-- 
2.44.0


