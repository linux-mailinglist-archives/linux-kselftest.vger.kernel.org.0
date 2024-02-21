Return-Path: <linux-kselftest+bounces-5188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2C485E31D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76628287585
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 16:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE027839FD;
	Wed, 21 Feb 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJdBG51D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7D4823B2;
	Wed, 21 Feb 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532746; cv=none; b=rtL1Q1vLNcX/ocpD7bmeHH5LJSFKWfH6HGPFJHDvH8ZxXjYDC03GD2K3o2qWIUmdmFue0yGWfq8N3AOTv8cs/aHd9t+9wut94oaqOsihv6h9g4fa7Gomyg4B4oXYwwRLlQPRpV1JFjZQR1sbytFK2vja/O+J7MNW2qX4uXE+neI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532746; c=relaxed/simple;
	bh=QnRTVuBH9fYcBUFkZSJeCI484dX0GF8bieROarhOafM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uUNBsg1tOZ/Q6cTVwKRo/KYTnYPRlyt7FreV4b33t2ONVvMYpwfTt7o7StgAhwWckhWGQmzF6h+QH4WOTduNdMsteQdWyBwgPEyAgVB179rboAR6aqqGEizR0B0pLa+Ap4Ama2/vhY08f32O/IKyM7PVzI84srh7pauo5CTu4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJdBG51D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D016C43390;
	Wed, 21 Feb 2024 16:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532746;
	bh=QnRTVuBH9fYcBUFkZSJeCI484dX0GF8bieROarhOafM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lJdBG51DCpUie8ePVFvoGaE3y8zRG2cUteRahz4qVeIZlfbVEu5HDP9OKBJg50YTk
	 JyM6OBtDRsYDeCiEFwb1YTBGxUhfGeQ1CI1Da3D/SWplPThCKrwRb+t1mUjJ3pk2FZ
	 ve4VWW+gNbt3msHgUHwm2wG2KTV7BPa1+7w4j/mumCfcSno4Pcc2mj6oi7Xkmob9A4
	 MnM7qVcnRuPEXxtVVMX21jnElxRcaAzI0vsS6wZpq6+eHOwGpktlo5p/Bhkm2+8lZm
	 tk20tXWSonVppxcmc6MkJvxJaH0syYi6MScTFjf29cBQjY4GH09JZdP8tDq4KLgen0
	 hguBaRW+bo4BQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 21 Feb 2024 17:25:21 +0100
Subject: [PATCH RFC bpf-next v3 05/16] bpf/verifier: add bpf_timer as a
 kfunc capable type
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-hid-bpf-sleepable-v3-5-1fb378ca6301@kernel.org>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
In-Reply-To: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708532719; l=3633;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=QnRTVuBH9fYcBUFkZSJeCI484dX0GF8bieROarhOafM=;
 b=63OFTbVppf+nuiSypXyyhrLP+N831rna1g38d4aUQHOSUnTCmQMddwzJmy4lN5gY4TACu0F9D
 osn2uDFkjmcBslibu4c58TGHphbUDZT9e5lbDXqpJXSsfvr1opd2nj6
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We need to extend the bpf_timer API, but the way forward relies on kfuncs.
So make bpf_timer known for kfuncs from the verifier PoV

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v3 (split from v2 02/10)
---
 kernel/bpf/verifier.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f81c799b2c80..2b11687063ff 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5444,6 +5444,26 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 					return -EACCES;
 				}
 				break;
+			case BPF_TIMER:
+				/* FIXME: kptr does the above, should we use the same? */
+				if (src != ACCESS_DIRECT) {
+					verbose(env, "bpf_timer cannot be accessed indirectly by helper\n");
+					return -EACCES;
+				}
+				if (!tnum_is_const(reg->var_off)) {
+					verbose(env, "bpf_timer access cannot have variable offset\n");
+					return -EACCES;
+				}
+				if (p != off + reg->var_off.value) {
+					verbose(env, "bpf_timer access misaligned expected=%u off=%llu\n",
+						p, off + reg->var_off.value);
+					return -EACCES;
+				}
+				if (size != bpf_size_to_bytes(BPF_DW)) {
+					verbose(env, "bpf_timer access size must be BPF_DW\n");
+					return -EACCES;
+				}
+				break;
 			default:
 				verbose(env, "%s cannot be accessed directly by load/store\n",
 					btf_field_type_name(field->type));
@@ -10789,6 +10809,7 @@ enum {
 	KF_ARG_LIST_NODE_ID,
 	KF_ARG_RB_ROOT_ID,
 	KF_ARG_RB_NODE_ID,
+	KF_ARG_TIMER_ID,
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
@@ -10797,6 +10818,7 @@ BTF_ID(struct, bpf_list_head)
 BTF_ID(struct, bpf_list_node)
 BTF_ID(struct, bpf_rb_root)
 BTF_ID(struct, bpf_rb_node)
+BTF_ID(struct, bpf_timer_kern)
 
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
@@ -10840,6 +10862,12 @@ static bool is_kfunc_arg_rbtree_node(const struct btf *btf, const struct btf_par
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
@@ -10908,6 +10936,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_RB_NODE,
 	KF_ARG_PTR_TO_NULL,
 	KF_ARG_PTR_TO_CONST_STR,
+	KF_ARG_PTR_TO_TIMER,
 };
 
 enum special_kfunc_type {
@@ -11061,6 +11090,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_const_str(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_CONST_STR;
 
+	if (is_kfunc_arg_timer(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_TIMER;
+
 	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
@@ -11693,6 +11725,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_CALLBACK:
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 		case KF_ARG_PTR_TO_CONST_STR:
+		case KF_ARG_PTR_TO_TIMER:
 			/* Trusted by default */
 			break;
 		default:
@@ -11973,6 +12006,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (ret)
 				return ret;
 			break;
+		case KF_ARG_PTR_TO_TIMER:
+			/* FIXME: should we do anything here? */
+			break;
 		}
 	}
 

-- 
2.43.0


