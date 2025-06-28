Return-Path: <linux-kselftest+bounces-36057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAFDAEC808
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 16:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A3A97AA72A
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E34B24EA8E;
	Sat, 28 Jun 2025 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="ynTWNJtw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852FA24E016;
	Sat, 28 Jun 2025 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751122665; cv=none; b=MAacog6ViJRxBeQAW4OhGmKc6adK7+W84b1jQ0mgpJL6lHNWt7rNwm1x3+hp7e2mWLmyXFyJtN2A+i/OSFIQhmppHtkRemBdKPvcwq/OFRiH5dpLsyYI5mxtOfRU11CRa9Q5P0ec2vKshK+8tZ0YKqzaou8w8UI+6yKhjZgt3Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751122665; c=relaxed/simple;
	bh=HSi06s+PUGxdJBGY6GFxak4sv815cnWzv1NhWB8k274=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okcejhClzTjC4mUE10AoGcxR+Kzu6JJww1wQzqDXwM7JzqroZ9QYqmUi05DpGHtq3O9A/bAigwYwiufTGodf5TSBeoIjIEGY1MR6E0q5uvaZuw+Ocl6hThEXlallebbKZE9UH5oOdU+teYVtUMuC7SnWzE2hfPbIW+rb2Q0byxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=ynTWNJtw; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1751122661; bh=fBaRk57nz6ElXpESIpcHM6WYYqzGAzZVyIAI++LaDzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=ynTWNJtwzE/kdD8Cgw6335AZ8YpOEyuaH+gya+a7LAKfsbWAHnuDlxLRSIsfhHx6S
	 1B3d0ZfzYsMD0xlZ62gaOj4bCDD+3QkJ9r2NumRQQW3vtZ1Xc7HYsNXrGf0YtUCKst
	 EO9WY2b0GiWixZDHzjppuf+xGrNsPrUvA0otTi46PwpYkjIaGHQ2vOxGtzl7w9Du8k
	 cNaWmZ5CmZW0Xn9f+R7PVGL5rH9xLKYaHn+EpWrktZZK41wR5B/UDur3rMVwnp1uTC
	 LEBtd/tSThOiyvK/zDE1thr4qw/oFO6QyENKO7udEEHNsdAOEq32HLOanlik9W6P6T
	 tUnAT4yMOsrzA==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bTwWn2G2bzPklm;
	Sat, 28 Jun 2025 16:57:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3601:f400:3a2b:2f7e:18b0:5ef9
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3601:f400:3a2b:2f7e:18b0:5ef9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18H9PD/qK7m2EViWUok2doCQe0kVAsTFqg=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bTwWj6gbRzPkB5;
	Sat, 28 Jun 2025 16:57:37 +0200 (CEST)
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
Cc: syzbot+dc27c5fb8388e38d2d37@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v2 2/3] bpf: Fix aux usage after do_check_insn()
Date: Sat, 28 Jun 2025 16:50:15 +0200
Message-ID: <20250628145016.784256-3-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250628145016.784256-1-luis.gerhorst@fau.de>
References: <20250628145016.784256-1-luis.gerhorst@fau.de>
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
prev_aux().

Also change cur_aux(env)->nospec in case do_check_insn() ever manages to
increment insn_idx but still fail.

Change the warning to check the insn class (which prevents it from
triggering for ldimm64, for which nospec_result would not be
problematic) and use verifier_bug_if().

Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
Reported-by: Paul Chaignon <paul.chaignon@gmail.com>
Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Reported-by: syzbot+dc27c5fb8388e38d2d37@syzkaller.appspotmail.com
Link: https://lore.kernel.org/bpf/685b3c1b.050a0220.2303ee.0010.GAE@google.com/
Link: https://lore.kernel.org/bpf/4266fd5de04092aa4971cbef14f1b4b96961f432.camel@gmail.com/
Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
---
 kernel/bpf/verifier.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b33bc37d5372..9d066e4b8248 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11216,6 +11216,11 @@ static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env)
 	return &env->insn_aux_data[env->insn_idx];
 }
 
+static struct bpf_insn_aux_data *prev_aux(const struct bpf_verifier_env *env)
+{
+	return &env->insn_aux_data[env->prev_insn_idx];
+}
+
 static bool loop_flag_is_zero(struct bpf_verifier_env *env)
 {
 	struct bpf_reg_state *regs = cur_regs(env);
@@ -19955,11 +19960,11 @@ static int do_check(struct bpf_verifier_env *env)
 			/* Prevent this speculative path from ever reaching the
 			 * insn that would have been unsafe to execute.
 			 */
-			cur_aux(env)->nospec = true;
+			prev_aux(env)->nospec = true;
 			/* If it was an ADD/SUB insn, potentially remove any
 			 * markings for alu sanitization.
 			 */
-			cur_aux(env)->alu_state = 0;
+			prev_aux(env)->alu_state = 0;
 			goto process_bpf_exit;
 		} else if (err < 0) {
 			return err;
@@ -19968,7 +19973,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 		WARN_ON_ONCE(err);
 
-		if (state->speculative && cur_aux(env)->nospec_result) {
+		if (state->speculative && prev_aux(env)->nospec_result) {
 			/* If we are on a path that performed a jump-op, this
 			 * may skip a nospec patched-in after the jump. This can
 			 * currently never happen because nospec_result is only
@@ -19977,8 +19982,15 @@ static int do_check(struct bpf_verifier_env *env)
 			 * never skip the following insn. Still, add a warning
 			 * to document this in case nospec_result is used
 			 * elsewhere in the future.
+			 *
+			 * All non-branch instructions have a single
+			 * fall-through edge. For these, nospec_result should
+			 * already work.
 			 */
-			WARN_ON_ONCE(env->insn_idx != env->prev_insn_idx + 1);
+			if (verifier_bug_if(BPF_CLASS(insn->code) == BPF_JMP ||
+					    BPF_CLASS(insn->code) == BPF_JMP32, env,
+					    "speculation barrier after jump instruction may not have the desired effect"))
+				return -EFAULT;
 process_bpf_exit:
 			mark_verifier_state_scratched(env);
 			err = update_branch_counts(env, env->cur_state);
-- 
2.49.0


