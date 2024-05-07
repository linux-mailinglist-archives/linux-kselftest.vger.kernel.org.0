Return-Path: <linux-kselftest+bounces-9598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 991428BE431
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 15:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA5B1C23196
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 13:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A331CB309;
	Tue,  7 May 2024 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd4Oiq2g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AC21CB304;
	Tue,  7 May 2024 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088014; cv=none; b=jpD2WEGmhd8Ucr1QP5HTb+jJswEcrLLju/xPp+6O8YY74Dt/CClRdxtY2+8jiCFKjFRPIE5hgVKVN+R7NLOU4k4JWF7LKpNIFEnmzyTH0D1MfUNB3ZWT+J+Hie3wYMvvk7V2B4LS77kwIqE4E0MdJGGlULZtIdUGRQoi4QQHs+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088014; c=relaxed/simple;
	bh=xqxP5tviAL2S96IuIPgdlhvR3scECTl5ZJSxLsbtWpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qWNtSjdgCG/a3FYdCrGzSHNON0mM3Nb/y1BH3SxMybcOtaHybphatCgnNvpypzEKEgkNhGVxJeIQD7rJ8AbtZ6qw7EOzT9sEEMnsJ6Azr0mgad7ETaIIAge8fZ+8rsPnRs25IhI06aHgxfA0l9EANGkw0oq+TWtAleLjnvfsPjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gd4Oiq2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9D3C4DDE7;
	Tue,  7 May 2024 13:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715088013;
	bh=xqxP5tviAL2S96IuIPgdlhvR3scECTl5ZJSxLsbtWpE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gd4Oiq2gEdgU1xGUmMmSAo2Ok46t/iK3YslvSMCr1C8RAhH7YNv7NP5q/cKDFNCli
	 vtBGyNL1bMnsbMz2JVDcctY3aDWQq/FmHWsw1K88IV8ITMv6MtE1MJ3pFWU4yvItaf
	 BwwhfsZzg1sA76I4bnzpQGw3HjWmkpZ8pUwQ9P3SA9QfbhoXfOm24631lAwLGzDRdR
	 UPscs38LStKDElMYm0Ze3gz7IUva3/sMFooxIwcSIKxo+qsGbxffEv4jyTWSsTOgae
	 ENsvws/vunKkdMSsTnGyMpja8gceb9WxHOTmq5vKXTP5FHJn/Cf8MhtruG8VHWn50W
	 mB+BeOuEeokQQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 07 May 2024 15:19:36 +0200
Subject: [PATCH RFC bpf-next 8/8] bpf: rely on __aux suffix for
 bpf_wq_set_callback_impl
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-bpf_async-v1-8-b4df966096d8@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715087980; l=3513;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=xqxP5tviAL2S96IuIPgdlhvR3scECTl5ZJSxLsbtWpE=;
 b=gLKwDN8r6bRspBt809EY3fwZaVCUxwSCKzAOrVkEzq+C8Ab8+unf1PTiflvMQqRSlCcJAZyt9
 XIcu3gAUTtSBKFD4QWf7tuSKVgxC+E6WpF36p1+A7nM8EvjE/Pq1B+E
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

And then cleanup the verifier about the special cases about this kfunc.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

This is an RFC, and is not meant to be fully reviewed/applied as it is.
I'm posting this to show what I wanted to explain in
https://lore.kernel.org/bpf/mhkzkf4e23uvljtmwizwcxyuyat2tmfxn33xb4t7waafgmsa66@mcrzpj3b6ssx/
---
 kernel/bpf/helpers.c  |  4 ++--
 kernel/bpf/verifier.c | 17 -----------------
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 97628bcbd507..03524fa5feef 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2725,9 +2725,9 @@ typedef int (*wq_callback_fn_t)(struct bpf_map *map, int *key, struct bpf_wq *wq
 __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
 					 wq_callback_fn_t callback_fn__s_async,
 					 unsigned int flags,
-					 void *aux__ign)
+					 void *prog__aux)
 {
-	struct bpf_prog_aux *aux = (struct bpf_prog_aux *)aux__ign;
+	struct bpf_prog_aux *aux = (struct bpf_prog_aux *)prog__aux;
 	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;
 
 	if (flags)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 33b108db0025..829a234832d9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -514,8 +514,6 @@ static bool is_sync_callback_calling_kfunc(u32 btf_id);
 static bool is_callback_calling_kfunc(u32 btf_id);
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
 
-static bool is_bpf_wq_set_callback_impl_kfunc(u32 btf_id);
-
 static bool is_sync_callback_calling_function(enum bpf_func_id func_id)
 {
 	return func_id == BPF_FUNC_for_each_map_elem ||
@@ -11134,7 +11132,6 @@ enum special_kfunc_type {
 	KF_bpf_percpu_obj_new_impl,
 	KF_bpf_percpu_obj_drop_impl,
 	KF_bpf_throw,
-	KF_bpf_wq_set_callback_impl,
 	KF_bpf_preempt_disable,
 	KF_bpf_preempt_enable,
 	KF_bpf_iter_css_task_new,
@@ -11161,7 +11158,6 @@ BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_throw)
-BTF_ID(func, bpf_wq_set_callback_impl)
 #ifdef CONFIG_CGROUPS
 BTF_ID(func, bpf_iter_css_task_new)
 #endif
@@ -11190,7 +11186,6 @@ BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_throw)
-BTF_ID(func, bpf_wq_set_callback_impl)
 BTF_ID(func, bpf_preempt_disable)
 BTF_ID(func, bpf_preempt_enable)
 #ifdef CONFIG_CGROUPS
@@ -11542,11 +11537,6 @@ static bool is_bpf_throw_kfunc(struct bpf_insn *insn)
 	       insn->imm == special_kfunc_list[KF_bpf_throw];
 }
 
-static bool is_bpf_wq_set_callback_impl_kfunc(u32 btf_id)
-{
-	return btf_id == special_kfunc_list[KF_bpf_wq_set_callback_impl];
-}
-
 static bool is_callback_calling_kfunc(u32 btf_id)
 {
 	return is_sync_callback_calling_kfunc(btf_id);
@@ -19949,13 +19939,6 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
-	} else if (is_bpf_wq_set_callback_impl_kfunc(desc->func_id)) {
-		struct bpf_insn ld_addrs[2] = { BPF_LD_IMM64(BPF_REG_4, (long)env->prog->aux) };
-
-		insn_buf[0] = ld_addrs[0];
-		insn_buf[1] = ld_addrs[1];
-		insn_buf[2] = *insn;
-		*cnt = 3;
 	} else {
 		struct bpf_kfunc_call_arg_meta meta;
 		struct bpf_insn kfunc_insn = *insn;

-- 
2.44.0


