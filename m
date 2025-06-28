Return-Path: <linux-kselftest+bounces-36045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B81AEC748
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 15:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC6317C583
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 13:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8421C19DFA2;
	Sat, 28 Jun 2025 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="zFRYrxu0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D032AEF5;
	Sat, 28 Jun 2025 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751115807; cv=none; b=j1fA5jsqUaesFXEn3uOxBUyw8o6YImLHYExu5ql02fLIKtmJ4fRUNrDaRqAibk17kjQ+uKTXZV2NIkXVMY15ehkB7DEXBECD51evsUr159tvOgegTsQ2qK5CP7kBrYZyTk/YWnr9b4eceyzaPux1Zuerjvbcwkv0Oau6eWJfv1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751115807; c=relaxed/simple;
	bh=xyV9PrEkChx8Zuhp0VYoI5m8qmN9njhEZzvsANRN3XQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvZGTFDbHSVHLKbv04rW0UyCVcfvK3tffISxXmW6k1d7ywNggQBbLUXSyIeYONdtlmDxp8Ej3na2YN34YkNV2FyeTfAl164Xt8KbXhUZiHNSWNmHqY2iSir6AIMcSGAPuMgay6ifGcSoVKT1BOQoHH7EYxKwXwxk3NpgbwWUPRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=zFRYrxu0; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1751115796; bh=7NT6u0farQjC6MtkYhEsEhxf1wp4bjNnhfZ4WdJV7e0=;
	h=From:To:Subject:Date:In-Reply-To:References:From:To:CC:Subject;
	b=zFRYrxu0qJD5hDEou0Uvs4DniXrN4mfFHJfY0UvCRJGi+MTjuXuoudNHxQ8RCsDan
	 PAIbdqUrh+Y3/aU6RCzZn4RNKDJxkYvz3asJ5M+c9KkBnN/9nmCXdDUV7Sr0+oHcy+
	 gGJksaBQwlTOJsARnL+9N01yk3oSUO0rh6KAPXoqwyF0P4dOqVfqKE2Lt13IIX591l
	 ef95VNKGPHoeoP11ZX/QrPUh5hNBVEUIaeYdQU1sXc+yOPoeYpIezE8G/1USb0xMAg
	 J8FRGD6QzA7xh7cmnoTcZ08fGKhC1ZVOLh+QEfmaE+hZgnBtCgJ9W/1ggUgJjOo0Zf
	 pki9QidWk273w==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bTszm3Qk0zPkDR;
	Sat, 28 Jun 2025 15:03:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3601:f400:3a2b:2f7e:18b0:5ef9
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3601:f400:3a2b:2f7e:18b0:5ef9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+xrBe4l3F5XgNMbSaI1SfgkghV8rNGL5Y=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bTszj1KjgzPkbn;
	Sat, 28 Jun 2025 15:03:13 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Peilin Ye <yepeilin@google.com>,
	Jiayuan Chen <mrpre@163.com>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Ihor Solodrai <isolodrai@meta.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: [PATCH bpf-next 1/3] bpf: Update env->prev_insn_idx after do_check_insn()
Date: Sat, 28 Jun 2025 14:59:25 +0200
Message-ID: <20250628125927.763088-2-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250628125927.763088-1-luis.gerhorst@fau.de>
References: <20250628125927.763088-1-luis.gerhorst@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To introduce prev_aux(env), env->prev_insn_idx must be up-to-date
directly after do_check_insn(). To achieve this, replace prev_insn_idx
with a tmp variable (to discourage use) and update env->prev_insn_idx
directly after do_check_insn().

A concern would be that some code relied on env->prev_insn_idx still
having the old value between do_check_insn() and the old
update-assignment. However, outside the do_check() function it is only
used through push_jmp_history()/do_check_insn()/is_state_visisted()
which are not called in-between the old and new assignment location.
This can also be seen from the -O0 call graph for push_jmp_history()
[1].

[1] https://sys.cs.fau.de/extern/person/gerhorst/25-06_d69baf_push_jmp_history_O0_callgraph.png

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
---
 kernel/bpf/verifier.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f403524bd215..3b24055117bc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19854,16 +19854,15 @@ static int do_check(struct bpf_verifier_env *env)
 	struct bpf_insn *insns = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
 	bool do_print_state = false;
-	int prev_insn_idx = -1;
 
+	env->prev_insn_idx = -1;
 	for (;;) {
 		struct bpf_insn *insn;
-		int err;
+		int err, tmp;
 
 		/* reset current history entry on each new instruction */
 		env->cur_hist_ent = NULL;
 
-		env->prev_insn_idx = prev_insn_idx;
 		if (env->insn_idx >= insn_cnt) {
 			verbose(env, "invalid insn idx %d insn_cnt %d\n",
 				env->insn_idx, insn_cnt);
@@ -19942,7 +19941,6 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		sanitize_mark_insn_seen(env);
-		prev_insn_idx = env->insn_idx;
 
 		/* Reduce verification complexity by stopping speculative path
 		 * verification when a nospec is encountered.
@@ -19950,7 +19948,9 @@ static int do_check(struct bpf_verifier_env *env)
 		if (state->speculative && cur_aux(env)->nospec)
 			goto process_bpf_exit;
 
+		tmp = env->insn_idx;
 		err = do_check_insn(env, &do_print_state);
+		env->prev_insn_idx = tmp;
 		if (error_recoverable_with_nospec(err) && state->speculative) {
 			/* Prevent this speculative path from ever reaching the
 			 * insn that would have been unsafe to execute.
@@ -19984,7 +19984,7 @@ static int do_check(struct bpf_verifier_env *env)
 			err = update_branch_counts(env, env->cur_state);
 			if (err)
 				return err;
-			err = pop_stack(env, &prev_insn_idx, &env->insn_idx,
+			err = pop_stack(env, &env->prev_insn_idx, &env->insn_idx,
 					pop_log);
 			if (err < 0) {
 				if (err != -ENOENT)
-- 
2.49.0


