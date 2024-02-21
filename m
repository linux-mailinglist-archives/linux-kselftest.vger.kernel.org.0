Return-Path: <linux-kselftest+bounces-5185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25BB85E310
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE89287587
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 16:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7B58289A;
	Wed, 21 Feb 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzgkSWxx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AB38175F;
	Wed, 21 Feb 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532733; cv=none; b=FE3tUlZHFnFFkkTYddBpnSmZpoXdKNp8RB6t+1Bn/AkPmqpfPptW19VfaKpHA0IX9ngHVOp7MIwapL+U5nO8ZoNIQcB6g2qmY7nC4BCZbPWN9CRAdn+ZSmopAV5nBqJDiUsHmq1M/vNSIIyJK2wPmUo9J5PWzn5h00nQxtU95Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532733; c=relaxed/simple;
	bh=Mms2ysexNAwTlu0ixVh3mQvJfR7XVQbK1/6OpHHyNTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QmUlzTYsvtNRf2T2e0GPVJVUWv0CqVf1jPqGYqe1oSEABMFpN6TsnGFUkIoLJ30yg1Lgrc6s2fIHB79n+HWwQ1yVWl/LnxpNm9KherVyhFJ5NydeIsQub+Ih7uGhCETxdUzjXd+m0JivRimMxTN8Rj2mu4rhtBbFWyNNmP/N2M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzgkSWxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AE3C43399;
	Wed, 21 Feb 2024 16:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532732;
	bh=Mms2ysexNAwTlu0ixVh3mQvJfR7XVQbK1/6OpHHyNTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BzgkSWxxL1yVpA3AP40UL1iNJt7dhFRqcnWwkIr9MhcBPn87wDNPRJnBCO/sMFhuO
	 B6DsLTtCrQvFeP2jMEm94SzdbUK6wIM9gu1zajvLf2RkqYsFIAgWwWzGrn7BvwABer
	 hhELTbOnO72g9IDIM8LRdYl+ojzy/l4B7Up77tcxToMoKVxAFmZCv3V1Tf8QdRjWF8
	 Ptc+V8oI0gAnaaWlOL5dr2tuPABx+Sf9U1vYxhRNKCHYmUS8FurcVf1aV2TU8Wbs36
	 x8BV/kfrthAlqGX0OqI5BIFSZ8ilAk5VqLniB0nW6DKV9meDGnDUZVcZnksdc9r+66
	 RHUoEN+lQKB/g==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 21 Feb 2024 17:25:18 +0100
Subject: [PATCH RFC bpf-next v3 02/16] bpf/verifier: introduce
 in_sleepable() helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-hid-bpf-sleepable-v3-2-1fb378ca6301@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708532719; l=3279;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Mms2ysexNAwTlu0ixVh3mQvJfR7XVQbK1/6OpHHyNTk=;
 b=ubFCIPswBRFz/abxhmIcawSwTVPZa0JGnBDjJfGIMEOXWj8HHjtDgLFSPl40V+M9vub1naeZk
 2KcPMrYv1mfB+/yBHNtNvw7/HK9cipJeTmWu+mfNNkZwmPmF3NuzTNN
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

No code change, but it'll allow to have only one place to change
everything when we add in_sleepable in cur_state.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

changes in v2 (compared to the one attaches to v1 0/9):
- dropped the cur_state flag, so it can be put first
---
 kernel/bpf/verifier.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 88e9d2e4c29f..7a4b19bea2ac 100644
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
@@ -10164,7 +10169,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return -EINVAL;
 	}
 
-	if (!env->prog->aux->sleepable && fn->might_sleep) {
+	if (!in_sleepable(env) && fn->might_sleep) {
 		verbose(env, "helper call might sleep in a non-sleepable prog\n");
 		return -EINVAL;
 	}
@@ -10194,7 +10199,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return -EINVAL;
 		}
 
-		if (env->prog->aux->sleepable && is_storage_get_function(func_id))
+		if (in_sleepable(env) && is_storage_get_function(func_id))
 			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
 	}
 
@@ -11535,7 +11540,7 @@ static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
 			return true;
 		fallthrough;
 	default:
-		return env->prog->aux->sleepable;
+		return in_sleepable(env);
 	}
 }
 
@@ -12056,7 +12061,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 
 	sleepable = is_kfunc_sleepable(&meta);
-	if (sleepable && !env->prog->aux->sleepable) {
+	if (sleepable && !in_sleepable(env)) {
 		verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
 		return -EACCES;
 	}
@@ -18193,7 +18198,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				return -E2BIG;
 			}
 
-			if (env->prog->aux->sleepable)
+			if (in_sleepable(env))
 				atomic64_inc(&map->sleepable_refcnt);
 			/* hold the map. If the program is rejected by verifier,
 			 * the map will be released by release_maps() or it
@@ -19669,7 +19674,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		}
 
 		if (is_storage_get_function(insn->imm)) {
-			if (!env->prog->aux->sleepable ||
+			if (!in_sleepable(env) ||
 			    env->insn_aux_data[i + delta].storage_get_func_atomic)
 				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
 			else

-- 
2.43.0


