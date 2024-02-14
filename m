Return-Path: <linux-kselftest+bounces-4659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C6D854FC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 18:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415F428551B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 17:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309BA84A37;
	Wed, 14 Feb 2024 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QC12kdg4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005358405C;
	Wed, 14 Feb 2024 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931145; cv=none; b=dSRUj3zt1xxvCCiKewZ6coO/IaLts2iB7nzKY4VEcZCnIesYWaFF5G781+g0Fyb3JknyprhVHpRAfoROSQtDYZ/S7yS8Snp6/4pBH0D8ccd1o4tnmaW2d54d3X8LFFIGv2kKJDFUPAPqWGy+C/c6kedXaeqwcbvLaVDUraL665Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931145; c=relaxed/simple;
	bh=ZuS+7v5Dfl5IafHw0MgYCYKa9AW++myTFw0GViRRpYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AO2OJJ+ZogPCs4yRP6c+vyzwdUcu6l1w4wKITYa9+GqlF1sbiw8HZx12wP6mdAiMAkXsOe6/Z07QZipNTFNuJw8eLTmFpC6xiLoYl9EMlrMmyPtoe7denNng0pVNIG2Ws8YV2TxdBSymiLNSPvYErUAG6BZHT5ocr+MjmXAXXKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QC12kdg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74061C43601;
	Wed, 14 Feb 2024 17:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707931144;
	bh=ZuS+7v5Dfl5IafHw0MgYCYKa9AW++myTFw0GViRRpYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QC12kdg4Aib5AcPh49e2/LK8jJLkgUAruYKDOwNQaopd+pga/EDbxFgh3ojIhfczu
	 HXg6GquX+hye+mvEnKHqn1lMPHgJUrbdk7h3TSO3+RVznexX/Wwj7SuYd2FKyGeFLM
	 sRgVVFHhveH5Tr2z1J//ugH1iSil5213Fyh16blTxF0YnL1yjNTganARWQjG2HPPmq
	 xklI4xCwY80G7dw1cjP2FWdDRIPKtbiZ0zmRFhtQrUJgNcCKbn8H95/F7TDXil2YDf
	 p98Qxk3Oe4tF1Mju5PRRQr192/xJ6xEO0M+LjhkLpxJ9uNcYEGx93PaJtXQvMq1Veq
	 SXQqZxyh5u7+A==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 14 Feb 2024 18:18:30 +0100
Subject: [PATCH RFC bpf-next v2 01/10] bpf/verifier: introduce
 in_sleepable() helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-hid-bpf-sleepable-v2-1-5756b054724d@kernel.org>
References: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
In-Reply-To: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707931135; l=3259;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=ZuS+7v5Dfl5IafHw0MgYCYKa9AW++myTFw0GViRRpYM=;
 b=37Ow3DoMrOPm0yj/WYnsJcZ0R+oyH5zub8WYF+eRcYwPZ/8PMJA2pgnCX/cG5KdlJnzEDvfZi
 cd3R+/0JvARDrWnnyoK+ZqKtuRsCmOHN5BmrAb/Ol6jjgL5wMgD7s2q
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

No code change, but it'll allow to have only one place to change
everything when we add in_sleepable in cur_state.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2 (compared to the one attaches to v1 0/9):
- dropped the cur_state flag, so it can be put first
---
 kernel/bpf/verifier.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 64fa188d00ad..7831adba9abf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5255,6 +5255,11 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	return -EINVAL;
 }
 
+static bool in_sleepable(struct bpf_verifier_env *env)
+{
+	return env->prog->aux->sleepable;
+}
+
 /* The non-sleepable programs and sleepable programs with explicit bpf_rcu_read_lock()
  * can dereference RCU protected pointers and result is PTR_TRUSTED.
  */
@@ -5262,7 +5267,7 @@ static bool in_rcu_cs(struct bpf_verifier_env *env)
 {
 	return env->cur_state->active_rcu_lock ||
 	       env->cur_state->active_lock.ptr ||
-	       !env->prog->aux->sleepable;
+	       !in_sleepable(env);
 }
 
 /* Once GCC supports btf_type_tag the following mechanism will be replaced with tag check */
@@ -10149,7 +10154,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return -EINVAL;
 	}
 
-	if (!env->prog->aux->sleepable && fn->might_sleep) {
+	if (!in_sleepable(env) && fn->might_sleep) {
 		verbose(env, "helper call might sleep in a non-sleepable prog\n");
 		return -EINVAL;
 	}
@@ -10179,7 +10184,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return -EINVAL;
 		}
 
-		if (env->prog->aux->sleepable && is_storage_get_function(func_id))
+		if (in_sleepable(env) && is_storage_get_function(func_id))
 			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
 	}
 
@@ -11538,7 +11543,7 @@ static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
 			return true;
 		fallthrough;
 	default:
-		return env->prog->aux->sleepable;
+		return in_sleepable(env);
 	}
 }
 
@@ -12059,7 +12064,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 
 	sleepable = is_kfunc_sleepable(&meta);
-	if (sleepable && !env->prog->aux->sleepable) {
+	if (sleepable && !in_sleepable(env)) {
 		verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
 		return -EACCES;
 	}
@@ -18197,7 +18202,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				return -E2BIG;
 			}
 
-			if (env->prog->aux->sleepable)
+			if (in_sleepable(env))
 				atomic64_inc(&map->sleepable_refcnt);
 			/* hold the map. If the program is rejected by verifier,
 			 * the map will be released by release_maps() or it
@@ -19673,7 +19678,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		}
 
 		if (is_storage_get_function(insn->imm)) {
-			if (!env->prog->aux->sleepable ||
+			if (!in_sleepable(env) ||
 			    env->insn_aux_data[i + delta].storage_get_func_atomic)
 				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
 			else

-- 
2.43.0


