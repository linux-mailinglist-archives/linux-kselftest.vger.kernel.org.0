Return-Path: <linux-kselftest+bounces-26642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE0BA35A11
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 10:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4714B1882343
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 09:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EAF22DFB1;
	Fri, 14 Feb 2025 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Xl071xm4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3BC151983;
	Fri, 14 Feb 2025 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524764; cv=none; b=gcQfCGdKTsrL8c22Y5Q7MKn82O1t+AHrxOEyPa4bcBHyBk8gPuoWb5nHpPrW3y43J5DTwMHku7+94ykxkkmHw5MdDZgldkBzsO3MSy4E1AEIson4xIuRR2HWXHkum+TVxwRl7n+vTWNVhW0uKssROWPAUtork7Lq2gYyA2lIjgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524764; c=relaxed/simple;
	bh=wCiyGuzsv0qzNUZNGK2dP+8gN6WNl5hPvC4Wka3d4VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQRehj6alhlAtoBbq5rvpMLDk9SwHpRsijC5vulDlMjyQ28JLb8FI+MPzAyf/JeTUCDsZ8NECz3xDclr9JJBrtA4JHWqqHBK3d4IfgaYo6vZJafLI2yOUPL5pHQ9PpdpWEs6CUGTP+MRPFTGLjHqMgRJ7jIU7CPpZNpzHnLju9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Xl071xm4; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=SZIFN
	LYoju6FGXz8RR91JXoF2TdJdvV5yUujWlpr1Fg=; b=Xl071xm4OJr6vkc25sQqj
	x9O1UQJ6637H4MtVj10rBCUOezj+VIM3Xu+I9cBwC/JOG5Lz573UW3OmCCTQyWd+
	SVd0QvX1aIgc03FjEHXh2egfy8+M2ZPHuJYZOjID7kpmeKkrZq/pSh5bLsrJ7Gv0
	nQSakaE7F+DDnBf2TIRrcM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3N0RjCq9nqR1PMA--.3071S3;
	Fri, 14 Feb 2025 17:18:31 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	Jiayuan Chen <mrpre@163.com>,
	syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v3 1/3] bpf: Fix array bounds error with may_goto
Date: Fri, 14 Feb 2025 17:18:21 +0800
Message-ID: <20250214091823.46042-2-mrpre@163.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250214091823.46042-1-mrpre@163.com>
References: <20250214091823.46042-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3N0RjCq9nqR1PMA--.3071S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1xZFyxKr4rJw4rAF45trb_yoW5ZFWfpF
	s8KFW3Cr48Ja1I93sxAFWxur45Jrs5ta17GanrJ340qF4jqFWkuF15KFyrXryaqrn7Ka1r
	uF1j9r9xtw1Uu3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEcTmxUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwfzp2evCS8bhQAAss

may_goto uses an additional 8 bytes on the stack, which causes the
interpreters[] array to go out of bounds when calculating index by
stack_size.

1. If a BPF program is rewritten, re-evaluate the stack size. For non-JIT
cases, reject loading directly.

2. For non-JIT cases, calculating interpreters[idx] may still cause
out-of-bounds array access, and just warn about it.

3. For jit_requested cases, the execution of bpf_func also needs to be
warned. So move the definition of function __bpf_prog_ret0_warn out of
the macro definition CONFIG_BPF_JIT_ALWAYS_ON.

Reported-by: syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/0000000000000f823606139faa5d@google.com/
Fixes: 011832b97b311 ("bpf: Introduce may_goto instruction")
Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 kernel/bpf/core.c     | 19 +++++++++++++++----
 kernel/bpf/verifier.c |  7 +++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index da729cbbaeb9..a0200fbbace9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2290,17 +2290,18 @@ void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
 	insn->code = BPF_JMP | BPF_CALL_ARGS;
 }
 #endif
-#else
+#endif
+
 static unsigned int __bpf_prog_ret0_warn(const void *ctx,
 					 const struct bpf_insn *insn)
 {
 	/* If this handler ever gets executed, then BPF_JIT_ALWAYS_ON
-	 * is not working properly, so warn about it!
+	 * is not working properly, or interpreter is being used when
+	 * prog->jit_requested is not 0, so warn about it!
 	 */
 	WARN_ON_ONCE(1);
 	return 0;
 }
-#endif
 
 bool bpf_prog_map_compatible(struct bpf_map *map,
 			     const struct bpf_prog *fp)
@@ -2380,8 +2381,18 @@ static void bpf_prog_select_func(struct bpf_prog *fp)
 {
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	u32 stack_depth = max_t(u32, fp->aux->stack_depth, 1);
+	u32 idx = (round_up(stack_depth, 32) / 32) - 1;
 
-	fp->bpf_func = interpreters[(round_up(stack_depth, 32) / 32) - 1];
+	/* may_goto may cause stack size > 512, leading to idx out-of-bounds.
+	 * But for non-JITed programs, we don't need bpf_func, so no bounds
+	 * check needed.
+	 */
+	if (!fp->jit_requested &&
+	    !WARN_ON_ONCE(idx >= ARRAY_SIZE(interpreters))) {
+		fp->bpf_func = interpreters[idx];
+	} else {
+		fp->bpf_func = __bpf_prog_ret0_warn;
+	}
 #else
 	fp->bpf_func = __bpf_prog_ret0_warn;
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..fcd302904ba0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21882,6 +21882,13 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
 			subprogs[cur_subprog].stack_depth += stack_depth_extra;
 			subprogs[cur_subprog].stack_extra = stack_depth_extra;
+
+			stack_depth = subprogs[cur_subprog].stack_depth;
+			if (stack_depth > MAX_BPF_STACK && !prog->jit_requested) {
+				verbose(env, "stack size %d(extra %d) is too large\n",
+					stack_depth, stack_depth_extra);
+				return -EINVAL;
+			}
 			cur_subprog++;
 			stack_depth = subprogs[cur_subprog].stack_depth;
 			stack_depth_extra = 0;
-- 
2.47.1


