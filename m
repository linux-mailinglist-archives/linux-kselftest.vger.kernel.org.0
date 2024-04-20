Return-Path: <linux-kselftest+bounces-8541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F6D8ABA85
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 11:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAAEE1C2145D
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 09:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFED03FE4E;
	Sat, 20 Apr 2024 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9uKGBph"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42F73CF74;
	Sat, 20 Apr 2024 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604193; cv=none; b=TWapWbAjUn800gAJeVl4TCLZGfFU5TPmcq06mHnga6+J2lWykMA9TIlF/8TuVWZRivSX7loyafF9wBujMjtaazxnjalp39etd2hJe7KOQiGfl4utAoXi6bfO97Ws1lQfdjh4Pj8TbNhZKRKYsS0rKFqQnad2ABPWo5hDwF3n+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604193; c=relaxed/simple;
	bh=gVxcodEcah1s/f89fQjSdKznWKEG7yRfyFRuFCd+7+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qXvvmUJ/22L5eqt6uyoN1e4ekGl+WNZfENdvzRipIpXgKdRI1fHYgTcfSdWsFCSA00OI2k9yMXEuGGtaenVWkOhNfOq4E3Brp/WKFS4lFkaXoZ61c4+ZL6to+KKzKJD0hGUjRegDwVqmKNYRec5atEyYn0kOyCt/lMFY5X08DUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9uKGBph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6A0C4AF0B;
	Sat, 20 Apr 2024 09:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713604193;
	bh=gVxcodEcah1s/f89fQjSdKznWKEG7yRfyFRuFCd+7+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q9uKGBphr0C8WYbAuqlt4v3FSjMLIo8Hi3/V3WUWtxtiRock80kL9gFubJPQuBulf
	 fH0I3MsglT3p0MCbazOq+Yr8r5kmySHCukN6ue/FEZZ5jdjjDBd1j80QbS5yf3F7OS
	 Z9iJZzRB0KhNkBNL2IaCHMCwWsZAcKwOG3jRZLt1fhQ4YOxPo9pqvLVB/7lzKSOver
	 Z3VMerJgf6C41Dzd2JR0BQ2nU/eJxSoAt2+aUaMTJQIvJj2ce3Q6low0s0xn5JKrVP
	 fanHMxgJEQjk+tZN8LVyHQ0cfuYTedVtLO7b65/dMFy9r9aZ6NTebtCLnqVXKm/VOK
	 2EkLVa227EMWA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 20 Apr 2024 11:09:08 +0200
Subject: [PATCH bpf-next v2 08/16] bpf: add support for
 KF_ARG_PTR_TO_WORKQUEUE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-bpf_wq-v2-8-6c986a5a741f@kernel.org>
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
In-Reply-To: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713604159; l=5548;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=gVxcodEcah1s/f89fQjSdKznWKEG7yRfyFRuFCd+7+U=;
 b=qMNtuTltAtmFk7u9P73LeKhlTFoMBAfL7wOJBz2fNuazIegV3sqPq6LtSMXgRITUsIwJG+u9v
 uOxmvCOWpppA3njOQc5EhU8AEBZz6i1U9cLM7eqqr98GUA0fTmR3j2w
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Introduce support for KF_ARG_PTR_TO_WORKQUEUE. The kfuncs will use bpf_wq
as argument and that will be recognized as workqueue argument by verifier.
bpf_wq_kern casting can happen inside kfunc, but using bpf_wq in
argument makes life easier for users who work with non-kern type in BPF
progs.

Duplicate process_timer_func into process_wq_func.
meta argument is only needed to ensure bpf_wq_init's workqueue and map
arguments are coming from the same map (map_uid logic is necessary for
correct inner-map handling), so also amend check_kfunc_args() to
match what helpers functions check is doing.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2:
- clean up already done checks in process_wq_func()
- adjust comment
- gate check_kfunc_args check with map->record->wq_off.
---
 kernel/bpf/verifier.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b95fd63864f1..5ff7b52d9032 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -332,6 +332,10 @@ struct bpf_kfunc_call_arg_meta {
 		u8 spi;
 		u8 frameno;
 	} iter;
+	struct {
+		struct bpf_map *ptr;
+		int uid;
+	} map;
 	u64 mem_size;
 };
 
@@ -7598,6 +7602,23 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 	return 0;
 }
 
+static int process_wq_func(struct bpf_verifier_env *env, int regno,
+			   struct bpf_kfunc_call_arg_meta *meta)
+{
+	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_map *map = reg->map_ptr;
+	u64 val = reg->var_off.value;
+
+	if (map->record->wq_off != val + reg->off) {
+		verbose(env, "off %lld doesn't point to 'struct bpf_wq' that is at %d\n",
+			val + reg->off, map->record->wq_off);
+		return -EINVAL;
+	}
+	meta->map.uid = reg->map_uid;
+	meta->map.ptr = map;
+	return 0;
+}
+
 static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 			     struct bpf_call_arg_meta *meta)
 {
@@ -10843,6 +10864,7 @@ enum {
 	KF_ARG_LIST_NODE_ID,
 	KF_ARG_RB_ROOT_ID,
 	KF_ARG_RB_NODE_ID,
+	KF_ARG_WORKQUEUE_ID,
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
@@ -10851,6 +10873,7 @@ BTF_ID(struct, bpf_list_head)
 BTF_ID(struct, bpf_list_node)
 BTF_ID(struct, bpf_rb_root)
 BTF_ID(struct, bpf_rb_node)
+BTF_ID(struct, bpf_wq)
 
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
@@ -10894,6 +10917,11 @@ static bool is_kfunc_arg_rbtree_node(const struct btf *btf, const struct btf_par
 	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RB_NODE_ID);
 }
 
+static bool is_kfunc_arg_wq(const struct btf *btf, const struct btf_param *arg)
+{
+	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_WORKQUEUE_ID);
+}
+
 static bool is_kfunc_arg_callback(struct bpf_verifier_env *env, const struct btf *btf,
 				  const struct btf_param *arg)
 {
@@ -10963,6 +10991,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_NULL,
 	KF_ARG_PTR_TO_CONST_STR,
 	KF_ARG_PTR_TO_MAP,
+	KF_ARG_PTR_TO_WORKQUEUE,
 };
 
 enum special_kfunc_type {
@@ -11119,6 +11148,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_map(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_MAP;
 
+	if (is_kfunc_arg_wq(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_WORKQUEUE;
+
 	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
@@ -11724,6 +11756,29 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				verbose(env, "pointer in R%d isn't map pointer\n", regno);
 				return -EINVAL;
 			}
+			if (meta->map.ptr && reg->map_ptr->record->wq_off >= 0) {
+				/* Use map_uid (which is unique id of inner map) to reject:
+				 * inner_map1 = bpf_map_lookup_elem(outer_map, key1)
+				 * inner_map2 = bpf_map_lookup_elem(outer_map, key2)
+				 * if (inner_map1 && inner_map2) {
+				 *     wq = bpf_map_lookup_elem(inner_map1);
+				 *     if (wq)
+				 *         // mismatch would have been allowed
+				 *         bpf_wq_init(wq, inner_map2);
+				 * }
+				 *
+				 * Comparing map_ptr is enough to distinguish normal and outer maps.
+				 */
+				if (meta->map.ptr != reg->map_ptr ||
+				    meta->map.uid != reg->map_uid) {
+					verbose(env,
+						"workqueue pointer in R1 map_uid=%d doesn't match map pointer in R2 map_uid=%d\n",
+						meta->map.uid, reg->map_uid);
+					return -EINVAL;
+				}
+			}
+			meta->map.ptr = reg->map_ptr;
+			meta->map.uid = reg->map_uid;
 			fallthrough;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
@@ -11757,6 +11812,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_CALLBACK:
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 		case KF_ARG_PTR_TO_CONST_STR:
+		case KF_ARG_PTR_TO_WORKQUEUE:
 			/* Trusted by default */
 			break;
 		default:
@@ -12043,6 +12099,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (ret)
 				return ret;
 			break;
+		case KF_ARG_PTR_TO_WORKQUEUE:
+			if (reg->type != PTR_TO_MAP_VALUE) {
+				verbose(env, "arg#%d doesn't point to a map value\n", i);
+				return -EINVAL;
+			}
+			ret = process_wq_func(env, regno, meta);
+			if (ret < 0)
+				return ret;
+			break;
 		}
 	}
 

-- 
2.44.0


