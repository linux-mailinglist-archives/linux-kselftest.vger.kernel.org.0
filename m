Return-Path: <linux-kselftest+bounces-36046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 520D2AEC750
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 15:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2684A1246
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 13:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9E5245025;
	Sat, 28 Jun 2025 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="At7s5wva"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5EF1A23BE;
	Sat, 28 Jun 2025 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751115992; cv=none; b=N9DhqFu6OXBKYWmRKmfcY0PgRuBfOfonlXIJY3unuzQsJvsF3+IZMLpzoz3AGPjhRtA4anh6bp8HGjTsQcNXm0TeYI/KNEzQeiqtAU+07LmjQb4kLr6xDMwM3Gvh8pHCSQEVnslR8+QnKA+vEZoWxtgyX5Z+elUCdbplkjNp+RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751115992; c=relaxed/simple;
	bh=aUVG3prtEM2rOF1bfAlJuX4gXP3Jq80Zv5Fpc285sAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVhTdImtkwfNUXlzHA5Az9CjZHLQ77fcZpg0g6HDWAZ0UBocQX/5lNNQ55V3KJoUztzz85AADBQzUtWbMphJgQEsoAttL3CYX18DaprYNdrgcrUyIegY3IEE+0wHL2rJgGRs5gnzMRQ/DtMVbEjIBAvSk6rpz7YSXK6Y4HcwX68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=At7s5wva; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1751115987; bh=NflfzwOiGknZ0XJf4MjQoVhBfoQz9txDYStNDD42xe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=At7s5wvaOlWTnKRb1mBW+Xdwhq+s775ZjVh/xl+tApyL0D3OV/zg9wA2hJkbpMMDR
	 Qn4caiFU37C4uJLHv4lwd1491J49FTsOU7E2rQs7wbvWIj8W/JXn+s2wCX2qG6tzNW
	 kpiHQqGb/dVS6J+6ikEMuWLBzlbFvP87IO9xmhUSCAg2YfMHBVZtcCrF8jPLTiB1fS
	 X0/jNchN3yF4sw9lZaeIBAWdA8i2vSX+uv+z98Qh0a2C2VzB0Pev2CrRicckCA/u+6
	 9lONav1uICg0YCl434ds2PzRaP+FITpy0tq9kUOvDqID1lkNDb+OiDur4yromg3npz
	 dx2YoJZDXX5+Q==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bTt3R4G5Kz8t53;
	Sat, 28 Jun 2025 15:06:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3601:f400:3a2b:2f7e:18b0:5ef9
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3601:f400:3a2b:2f7e:18b0:5ef9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18cPy3NMRd8IsnH/BHB5syLv8uatFMQrjA=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bTt3N2vcRz8sjP;
	Sat, 28 Jun 2025 15:06:24 +0200 (CEST)
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
Subject: [PATCH bpf-next 2/3] bpf: Fix aux usage after do_check_insn()
Date: Sat, 28 Jun 2025 14:59:26 +0200
Message-ID: <20250628125927.763088-3-luis.gerhorst@fau.de>
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
index 3b24055117bc..9d066e4b8248 100644
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


