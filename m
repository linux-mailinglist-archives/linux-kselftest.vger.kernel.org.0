Return-Path: <linux-kselftest+bounces-36642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E25DAFA156
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 21:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20795603CA
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 19:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8069C21638A;
	Sat,  5 Jul 2025 19:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="hMRgpz9W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC42920EB;
	Sat,  5 Jul 2025 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751742861; cv=none; b=HrGp+JP66vrLUk97nWCVT/5vMVGuZGZasqqyFPaC564rsugglltdk2GcxXQ3QFQmNNQvG5WClJbyLf08aNlD25J1/WftwnCbjXv4RvO50Y9M+11blWKkZ3D1aVVsa6yUj9nSn262K0D+RmkwNB3qA/mCY6m45zB/NZ7wE5HbKSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751742861; c=relaxed/simple;
	bh=f/t8Y0biBNILt1TcPfRdwae49BloYJMPhwZYBhlCws0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8MtlJ7WyXQsHVwge25l5Bkmxm47E6hHiqzLwYn2BMpP+P6D8m1mPo+JqJKLLNvgmXI91u+vIXgjzUdxuwgAMIJgHgNMk0mRcHlG/HFeBMKdMTaiTRivM3jcTwnoraLw5RAvoi4cB1893NVx+lLIGdn3XFvYgHCcIZwsPbLQAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=hMRgpz9W; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1751742851; bh=tGc9qEYISS2QKrzN5rOm8FTQvpFY/de4X5tDeezVhOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=hMRgpz9W8Jyph8G/QOm/h7mP4GNA3UXfYPwEOP+ey1mwqvJD8kP0FqmW4rwXYTkP5
	 1/ZkHo35TvTY8nMSFLndJ7MabeDz0fPfe4N6wSfnE6Cy4Of1Yt/qtbEhciT3rMYTKv
	 gYCcHWnh56NJXtfboV2X8yn5g4TMiaqiulW2tJOLFC9SY4AthBlF++3CzkRx8jbA1K
	 8/YkidhOzJk22qeEgFdec5naanqBgK0c69k1kNe0DLs12PST/ADjT/tXDHgb+iZubk
	 A/c4Uok+6uIX/lxc/aVzlZnOrF8y1ci7wzfudYJnTLkRAr+8n27ORXvitP+MutgUr4
	 klRMGjS/dQXlg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bZKtW0pdSzPjsp;
	Sat,  5 Jul 2025 21:14:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:362a:3200:5d43:2d8a:dc0e:5715
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:362a:3200:5d43:2d8a:dc0e:5715])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/w9J2NDsL0lKKfz7kNTzxFY1SqXcjrFp8=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bZKtR6ZVFzPjy4;
	Sat,  5 Jul 2025 21:14:07 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peilin Ye <yepeilin@google.com>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Viktor Malik <vmalik@redhat.com>,
	Ihor Solodrai <isolodrai@meta.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Chaignon <paul.chaignon@gmail.com>
Cc: syzbot+dc27c5fb8388e38d2d37@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v3 1/2] bpf: Fix aux usage after do_check_insn()
Date: Sat,  5 Jul 2025 21:09:07 +0200
Message-ID: <20250705190908.1756862-2-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250705190908.1756862-1-luis.gerhorst@fau.de>
References: <20250705190908.1756862-1-luis.gerhorst@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We must terminate the speculative analysis if the just-analyzed insn had
nospec_result set. Using cur_aux() here is wrong because insn_idx might
have been incremented by do_check_insn(). Therefore, introduce and use
insn_aux variable.

Also change cur_aux(env)->nospec in case do_check_insn() ever manages to
increment insn_idx but still fail.

Change the warning to check the insn class (which prevents it from
triggering for ldimm64, for which nospec_result would not be
problematic) and use verifier_bug_if().

In line with Eduard's suggestion, do not introduce prev_aux() because
that requires one to understand that after do_check_insn() call what was
current became previous. This would at-least require a comment.

Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
Reported-by: Paul Chaignon <paul.chaignon@gmail.com>
Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Reported-by: syzbot+dc27c5fb8388e38d2d37@syzkaller.appspotmail.com
Link: https://lore.kernel.org/bpf/685b3c1b.050a0220.2303ee.0010.GAE@google.com/
Link: https://lore.kernel.org/bpf/4266fd5de04092aa4971cbef14f1b4b96961f432.camel@gmail.com/
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
---
 kernel/bpf/verifier.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0f6cc2275695..96c737b41c3f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19923,6 +19923,7 @@ static int do_check(struct bpf_verifier_env *env)
 
 	for (;;) {
 		struct bpf_insn *insn;
+		struct bpf_insn_aux_data *insn_aux;
 		int err;
 
 		/* reset current history entry on each new instruction */
@@ -19936,6 +19937,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		insn = &insns[env->insn_idx];
+		insn_aux = &env->insn_aux_data[env->insn_idx];
 
 		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
 			verbose(env,
@@ -20012,7 +20014,7 @@ static int do_check(struct bpf_verifier_env *env)
 		/* Reduce verification complexity by stopping speculative path
 		 * verification when a nospec is encountered.
 		 */
-		if (state->speculative && cur_aux(env)->nospec)
+		if (state->speculative && insn_aux->nospec)
 			goto process_bpf_exit;
 
 		err = do_check_insn(env, &do_print_state);
@@ -20020,11 +20022,11 @@ static int do_check(struct bpf_verifier_env *env)
 			/* Prevent this speculative path from ever reaching the
 			 * insn that would have been unsafe to execute.
 			 */
-			cur_aux(env)->nospec = true;
+			insn_aux->nospec = true;
 			/* If it was an ADD/SUB insn, potentially remove any
 			 * markings for alu sanitization.
 			 */
-			cur_aux(env)->alu_state = 0;
+			insn_aux->alu_state = 0;
 			goto process_bpf_exit;
 		} else if (err < 0) {
 			return err;
@@ -20033,7 +20035,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 		WARN_ON_ONCE(err);
 
-		if (state->speculative && cur_aux(env)->nospec_result) {
+		if (state->speculative && insn_aux->nospec_result) {
 			/* If we are on a path that performed a jump-op, this
 			 * may skip a nospec patched-in after the jump. This can
 			 * currently never happen because nospec_result is only
@@ -20042,8 +20044,15 @@ static int do_check(struct bpf_verifier_env *env)
 			 * never skip the following insn. Still, add a warning
 			 * to document this in case nospec_result is used
 			 * elsewhere in the future.
+			 *
+			 * All non-branch instructions have a single
+			 * fall-through edge. For these, nospec_result should
+			 * already work.
 			 */
-			WARN_ON_ONCE(env->insn_idx != prev_insn_idx + 1);
+			if (verifier_bug_if(BPF_CLASS(insn->code) == BPF_JMP ||
+					    BPF_CLASS(insn->code) == BPF_JMP32, env,
+					    "speculation barrier after jump instruction may not have the desired effect"))
+				return -EFAULT;
 process_bpf_exit:
 			mark_verifier_state_scratched(env);
 			err = update_branch_counts(env, env->cur_state);
-- 
2.49.0


