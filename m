Return-Path: <linux-kselftest+bounces-9596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0108BE428
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 15:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C931F229E9
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 13:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41151C8FD0;
	Tue,  7 May 2024 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8cLmKdY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C615F3F6;
	Tue,  7 May 2024 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088006; cv=none; b=Ufky3l0/AIgzcYB+mSV4/AkvqjeFp+YB2d/oAPJc2DulO1ZZfTnc91TXOchDskn7/qTBtBQ8bZPBv5HDcjlBT++oqDSTmXXroLDCYzphKGjZiiit46qHQD7PJeNNyJFX0PLbUPRkon37zMEsWD90U7JOVALZEdb+HNflMrgvUhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088006; c=relaxed/simple;
	bh=ZHkUdCx51hxhBKatmpC3J91gdbyruA1Cb3+7Y+YPx9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T8fsKhVNnC3bJfSpegl20lhUt0KvZWUDeWIuHkbH7/ah+e6nWIP34809oefxHBF1/1K4Oe0zY4cC6JtTNbVPSSaSifVe/T8bHtkY41ly1/BKVKUKyvDTGRqegeBOwDaWLz+GXx3oN0A2LhXkvouVp+WBJf1yaPMEueOMvMcXaZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8cLmKdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1839EC2BBFC;
	Tue,  7 May 2024 13:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715088006;
	bh=ZHkUdCx51hxhBKatmpC3J91gdbyruA1Cb3+7Y+YPx9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j8cLmKdYaZvYjdWwLVoGorZkPFm1X6/PgT/qtThOSMp7ALVVSorihb8MLmuy2JQXB
	 +9/62Vc2fDs5pzUZtFqGDnmw+x6ojwjkdeESRfSctA4tJZKXYpOv46AUSGdUCMZ/+C
	 ZntOZHXuQYX+eSJqoyVEU0B+RyJsgUhBD3vd/PKknL8nl3br4dGK3UzKfswVkoQqZf
	 cAJjggGBDllZ+XgyT9aSvmoyJMX9pjgDg4a55rkkLDbs0U5Mv3wzvRj4qEex3E0SgY
	 iPkzJJ1q86GUZLZuveEQU3qiuC3H3zPI0fkXMcGD5/9x2c0Wfhg9wvuue+/5wwZdna
	 yw3wGCBBKxMHg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 07 May 2024 15:19:34 +0200
Subject: [PATCH RFC bpf-next 6/8] bpf: remove one special case of
 is_bpf_wq_set_callback_impl_kfunc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-bpf_async-v1-6-b4df966096d8@kernel.org>
References: <20240507-bpf_async-v1-0-b4df966096d8@kernel.org>
In-Reply-To: <20240507-bpf_async-v1-0-b4df966096d8@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715087980; l=3721;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=ZHkUdCx51hxhBKatmpC3J91gdbyruA1Cb3+7Y+YPx9g=;
 b=+psPvQ9U0lib8PoOYD0b0ezqcWWXbbmhqvnYoH0EeLMPirxH4lu7bdfYRXp0w/+KFXQGW7eH2
 HfmBtwpdXeaDHz9Ay1pi/ODf7q7KQNcgbeoLKzBinovzJth7XPBrKEf
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

It looks like the generic implementation based on __s_async suffix works
well enough. So let's use it.

Note:
- currently we lose the return value range
- the second argument is not of type PTR_TO_MAP_KEY

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

This is an RFC, and is not meant to be fully reviewed/applied as it is.
I'm posting this to show what I wanted to explain in
https://lore.kernel.org/bpf/mhkzkf4e23uvljtmwizwcxyuyat2tmfxn33xb4t7waafgmsa66@mcrzpj3b6ssx/
---
 kernel/bpf/verifier.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cc4dab81b306..6fba9e2caa83 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -511,7 +511,6 @@ static bool is_dynptr_ref_function(enum bpf_func_id func_id)
 }
 
 static bool is_sync_callback_calling_kfunc(u32 btf_id);
-static bool is_async_callback_calling_kfunc(u32 btf_id);
 static bool is_callback_calling_kfunc(u32 btf_id);
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
 
@@ -544,8 +543,7 @@ static bool is_sync_callback_calling_insn(struct bpf_insn *insn)
 
 static bool is_async_callback_calling_insn(struct bpf_insn *insn)
 {
-	return (bpf_helper_call(insn) && is_async_callback_calling_function(insn->imm)) ||
-	       (bpf_pseudo_kfunc_call(insn) && is_async_callback_calling_kfunc(insn->imm));
+	return bpf_helper_call(insn) && is_async_callback_calling_function(insn->imm);
 }
 
 static bool is_may_goto_insn(struct bpf_insn *insn)
@@ -9560,15 +9558,14 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		return -EFAULT;
 	}
 
-	if (is_async_callback_calling_insn(insn) || (kfunc_meta && kfunc_meta->async_cb.enabled)) {
+	if (kfunc_meta && kfunc_meta->async_cb.enabled) {
 		struct bpf_verifier_state *async_cb;
 
 		/* there is no real recursion here. timer and workqueue callbacks are async */
 		env->subprog_info[subprog].is_async_cb = true;
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
 					 insn_idx, subprog,
-					 (is_bpf_wq_set_callback_impl_kfunc(insn->imm) ||
-					  (kfunc_meta && kfunc_meta->async_cb.sleepable)));
+					 kfunc_meta && kfunc_meta->async_cb.sleepable);
 		if (!async_cb)
 			return -EFAULT;
 		callee = async_cb->frame[0];
@@ -11534,11 +11531,6 @@ static bool is_sync_callback_calling_kfunc(u32 btf_id)
 	return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl];
 }
 
-static bool is_async_callback_calling_kfunc(u32 btf_id)
-{
-	return btf_id == special_kfunc_list[KF_bpf_wq_set_callback_impl];
-}
-
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn)
 {
 	return bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
@@ -11552,8 +11544,7 @@ static bool is_bpf_wq_set_callback_impl_kfunc(u32 btf_id)
 
 static bool is_callback_calling_kfunc(u32 btf_id)
 {
-	return is_sync_callback_calling_kfunc(btf_id) ||
-	       is_async_callback_calling_kfunc(btf_id);
+	return is_sync_callback_calling_kfunc(btf_id);
 }
 
 static bool is_rbtree_lock_required_kfunc(u32 btf_id)
@@ -12465,16 +12456,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
-	if (is_bpf_wq_set_callback_impl_kfunc(meta.func_id)) {
-		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
-					 set_timer_callback_state, &meta);
-		if (err) {
-			verbose(env, "kfunc %s#%d failed callback verification\n",
-				func_name, meta.func_id);
-			return err;
-		}
-	}
-
 	if (meta.async_cb.enabled) {
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
 					 set_generic_callback_state, &meta);

-- 
2.44.0


