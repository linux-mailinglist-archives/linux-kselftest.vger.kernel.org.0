Return-Path: <linux-kselftest+bounces-26547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA6AA34001
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 14:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0611696FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26D823F420;
	Thu, 13 Feb 2025 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fdO3sUcK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8D723F41B;
	Thu, 13 Feb 2025 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452398; cv=none; b=Ix6ECWOSMw2onKjJCRPnoZe/buW60HlWRFkoddCklEuUAEqmfAyt8ifHTVpi8vgBNSFh9Q0uSSrhmhsper3p+6uvN22SWzgPLMv3zX3bpCAuLvXXmaE+S0vVO8fWaAUj1gyA22m7+KKEeQ0ieQTkOUydBt2kDm4t6q7FalbcI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452398; c=relaxed/simple;
	bh=r3XU+DGNm90//yQ3AsPpyzLkR4el0EYOuVM2HcyiGqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/tmuvfjDdjrGLFF1+Ufj9pmSpIClXTH8akNZKevZNgfT5mnfPm7s605DyorkoDTbe8LDcNEAGVx7TRde8NX/Yyt9QkuPC9eBbGZmmoWyAnVmjJIhO/9qS4mubG1O+DJhjM2isphKFzjJFXtBYRDV+CAy83bSAXb/OAyiA8sIc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fdO3sUcK; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=Y8v0K
	eZhBbmue/Fp6RVZC0XefbCMdD2hVwAYwi82vIs=; b=fdO3sUcK513OgSwKNnR2j
	jsWMj61Xbz2HrHNbl9wrginTWGW1+sY/9mtrkQnWtOjTfPiClP/sAtBIther7Hyd
	jnOachWQEbodwy+XLIpBsPyx8a+0lFvVzdksOuAIRham6z2iFwhMpsbAMsYNWsYR
	rlrvlmfeRILrpuNi+aUPzo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3N8qv761nJPMJMA--.27324S3;
	Thu, 13 Feb 2025 21:12:19 +0800 (CST)
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
Subject: [PATCH bpf-next v2 1/3] bpf: Fix array bounds error with may_goto
Date: Thu, 13 Feb 2025 21:12:12 +0800
Message-ID: <20250213131214.164982-2-mrpre@163.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250213131214.164982-1-mrpre@163.com>
References: <20250213131214.164982-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3N8qv761nJPMJMA--.27324S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1xZFyxKr4DAFy5GFy8Krg_yoW5tFyxpF
	4DKFy7Cr48ta1Ik3sxCF4xurW5Jrs5tw17GanrJ348Ja1jqr4kCr15KFyrXryaqrn7Kw4r
	ZF1j9rnxtay7u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEcTmxUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWxzyp2et6WvVuwAAs0

may_goto uses an additional 8 bytes on the stack, which causes the
interpreters[] array to go out of bounds when calculating index by
stack_size.

1. If a BPF program is rewritten, re-evaluate the stack size. For non-JIT
cases, reject loading directly.

2. For non-JIT cases, calculating interpreters[idx] may still cause
out-of-bounds array access, and just warn about it.

3. For jit_requested cases, the execution of bpf_func also needs to be
warned. So Move the definition of function __bpf_prog_ret0_warn out of
the macro definition CONFIG_BPF_JIT_ALWAYS_ON

Reported-by: syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/0000000000000f823606139faa5d@google.com/
Fixes: 011832b97b311 ("bpf: Introduce may_goto instruction")
Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 kernel/bpf/core.c     | 18 ++++++++++++++----
 kernel/bpf/verifier.c |  7 +++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index da729cbbaeb9..59291261f825 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2269,6 +2269,9 @@ EVAL6(PROG_NAME_LIST, 32, 64, 96, 128, 160, 192)
 EVAL6(PROG_NAME_LIST, 224, 256, 288, 320, 352, 384)
 EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
 };
+
+#define MAX_INTERPRETERS_CALLBACK (sizeof(interpreters) / sizeof(*interpreters))
+
 #undef PROG_NAME_LIST
 #define PROG_NAME_LIST(stack_size) PROG_NAME_ARGS(stack_size),
 static __maybe_unused
@@ -2290,17 +2293,18 @@ void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
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
@@ -2380,8 +2384,14 @@ static void bpf_prog_select_func(struct bpf_prog *fp)
 {
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	u32 stack_depth = max_t(u32, fp->aux->stack_depth, 1);
+	u32 idx = (round_up(stack_depth, 32) / 32) - 1;
 
-	fp->bpf_func = interpreters[(round_up(stack_depth, 32) / 32) - 1];
+	if (!fp->jit_requested) {
+		WARN_ON_ONCE(idx >= MAX_INTERPRETERS_CALLBACK);
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


