Return-Path: <linux-kselftest+bounces-8140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B958A6D91
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 090A0B238E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41852131BB9;
	Tue, 16 Apr 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hk+ckEvn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168DE131BA7;
	Tue, 16 Apr 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276629; cv=none; b=jH+RCiCks36VIeJWM1IhUrKNjrd1eN0Syc2GxPOi/tCzSsx+d9aLM9BKyFdy8UgVNdvFGy4F+wAmO//1JoOHx3VcgykV1sM3kZeHsarssL8MmeytkQzYGGEVLGDgDfh+WEgqCnnZ7DpGrknmBZRvRL4UqqAOcWhJ0ggqJV8CMy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276629; c=relaxed/simple;
	bh=WEX5TCOm7sV2DRInTHa7TcVznbYdnMLXwRscaz2H/Oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Txagp6GduHtyoYQygbHaLjyYVRWcqO+SeLXgYDFjSNzLsTL51HyOh1EY4Uv9QIO8SIsPO+yowWLN4/HZfUqNyV4shaughamRgIBvtAbRMHhOWtFKMRMJLoM3SotJ8uqm/o1Ky9NPiGTchj45Q7yn83e9nLKoa1TQB2VxHGgLy8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hk+ckEvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F467C4AF07;
	Tue, 16 Apr 2024 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276628;
	bh=WEX5TCOm7sV2DRInTHa7TcVznbYdnMLXwRscaz2H/Oo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Hk+ckEvnbXVI+RMSK/PNKe8c/3TZsVsr2KUXQXJinefFa7YdMTfITsTj7QdheBHak
	 e1fO6mybFETfXeYJvVcmI0PkK0i+cLCbgJUZlbVr8gKiJQ9sI7kBccP1Rx6URLi3t3
	 tiSJwHgygjawdX1wWgkXcaT4RGonTipX3JFLDHep8HvbKF2xEfqg10OQuWUgAxv9hc
	 PWHvi2lY3ER56B1YQddu4pahxAk98EaNeiuIjwi6G5/Sce7+DvapCuKhUWX5P1sRCe
	 VAByECc1lAcl9SZ+JL0biBaCtLXjC2c0OYr4zOJmAVl5bxZOHutFapXKsnX+ly/y65
	 6v4thz6NlXBAQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 16 Apr 2024 16:08:21 +0200
Subject: [PATCH bpf-next 08/18] bpf: add support for
 KF_ARG_PTR_TO_WORKQUEUE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-bpf_wq-v1-8-c9e66092f842@kernel.org>
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
In-Reply-To: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713276593; l=6022;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=WEX5TCOm7sV2DRInTHa7TcVznbYdnMLXwRscaz2H/Oo=;
 b=OrTLcEBuZl/n0Yju6qg5Yz+voSFvYO4cMqAy+HLbo7KZyroiTxi24d86kcsD6Qw6llNHH4g1+
 f9BtKCyyzRkCl9C1U0pjE82yE69UPP+pAkc1h0sJnw3/Vy0nbedNV3x
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
 kernel/bpf/verifier.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index deaf2e1ab690..112faf2cd7e9 100644
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
 
@@ -7598,6 +7602,43 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 	return 0;
 }
 
+static int process_wq_func(struct bpf_verifier_env *env, int regno,
+			   struct bpf_kfunc_call_arg_meta *meta)
+{
+	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	bool is_const = tnum_is_const(reg->var_off);
+	struct bpf_map *map = reg->map_ptr;
+	u64 val = reg->var_off.value;
+
+	if (!is_const) {
+		verbose(env,
+			"R%d doesn't have constant offset. bpf_wq has to be at the constant offset\n",
+			regno);
+		return -EINVAL;
+	}
+	if (!map->btf) {
+		verbose(env, "map '%s' has to have BTF in order to use bpf_wq\n",
+			map->name);
+		return -EINVAL;
+	}
+	if (!btf_record_has_field(map->record, BPF_WORKQUEUE)) {
+		verbose(env, "map '%s' has no valid bpf_wq\n", map->name);
+		return -EINVAL;
+	}
+	if (map->record->wq_off != val + reg->off) {
+		verbose(env, "off %lld doesn't point to 'struct bpf_wq' that is at %d\n",
+			val + reg->off, map->record->wq_off);
+		return -EINVAL;
+	}
+	if (meta->map.ptr) {
+		verbose(env, "verifier bug. Two map pointers in a workqueue helper\n");
+		return -EFAULT;
+	}
+	meta->map.uid = reg->map_uid;
+	meta->map.ptr = map;
+	return 0;
+}
+
 static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 			     struct bpf_call_arg_meta *meta)
 {
@@ -10843,6 +10884,7 @@ enum {
 	KF_ARG_LIST_NODE_ID,
 	KF_ARG_RB_ROOT_ID,
 	KF_ARG_RB_NODE_ID,
+	KF_ARG_WORKQUEUE_ID,
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
@@ -10851,6 +10893,7 @@ BTF_ID(struct, bpf_list_head)
 BTF_ID(struct, bpf_list_node)
 BTF_ID(struct, bpf_rb_root)
 BTF_ID(struct, bpf_rb_node)
+BTF_ID(struct, bpf_wq)
 
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
@@ -10894,6 +10937,11 @@ static bool is_kfunc_arg_rbtree_node(const struct btf *btf, const struct btf_par
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
@@ -10963,6 +11011,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_NULL,
 	KF_ARG_PTR_TO_CONST_STR,
 	KF_ARG_PTR_TO_MAP,
+	KF_ARG_PTR_TO_WORKQUEUE,
 };
 
 enum special_kfunc_type {
@@ -11119,6 +11168,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_map(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_MAP;
 
+	if (is_kfunc_arg_wq(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_WORKQUEUE;
+
 	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
@@ -11720,6 +11772,30 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_NULL:
 			continue;
 		case KF_ARG_PTR_TO_MAP:
+			if (meta->map.ptr) {
+				/* Use map_uid (which is unique id of inner map) to reject:
+				 * inner_map1 = bpf_map_lookup_elem(outer_map, key1)
+				 * inner_map2 = bpf_map_lookup_elem(outer_map, key2)
+				 * if (inner_map1 && inner_map2) {
+				 *     timer = bpf_map_lookup_elem(inner_map1);
+				 *     if (timer)
+				 *         // mismatch would have been allowed
+				 *         bpf_timer_init(timer, inner_map2);
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
+			fallthrough;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
@@ -11752,6 +11828,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_CALLBACK:
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 		case KF_ARG_PTR_TO_CONST_STR:
+		case KF_ARG_PTR_TO_WORKQUEUE:
 			/* Trusted by default */
 			break;
 		default:
@@ -12038,6 +12115,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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


