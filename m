Return-Path: <linux-kselftest+bounces-8924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E09138B3C73
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 18:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1B91F21A5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CF114D71D;
	Fri, 26 Apr 2024 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRDS1As+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3291E869;
	Fri, 26 Apr 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147882; cv=none; b=h4YzmxjCjmOv3ovWhDXakmF0tBE7gz7u2SgufwUYx88jddrNKpTG2O1GuFwEn72/xYy/maHQhXhO6fYYUsrQU0MAGIP7hz04sYp7lPAMNYTKTcr1/DCMGwSduVWSyakMH2uBhDypteyexfQfDd7vzVs9NSYqCASgabAplocEfDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147882; c=relaxed/simple;
	bh=x4xeUpG5pd/P4tk7OOzavHgr12pYHeTfjKOAVfF76r8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MpfGAybMrYyM1iZG8THVq7Zqujvi8PJqKqHn+/Vn9UbzaZ/OLA/pf1r9XlUHtWPCK9aakBmqfpi25ymLuXE2ebSYoTN1ft0gsELo83EWtFLWJxJDLTt4c9pWOcKSXGLlEMcfAI69e5xIEdImjbyB6wCdFLnuci/E2MlA4eukN2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRDS1As+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFF7C113CD;
	Fri, 26 Apr 2024 16:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714147881;
	bh=x4xeUpG5pd/P4tk7OOzavHgr12pYHeTfjKOAVfF76r8=;
	h=From:To:Cc:Subject:Date:From;
	b=mRDS1As+q4l33nzC8WvqurBMt7Gh3F2I9DWGb3xHzs423pWbK620eXNPAjIz7sMCv
	 VfhaO2mWozqnT3FW5GYNvkDbHJig0ObVKEr7iQjziaqsqba+uhAjRv2/Ctb688Siqg
	 d49FnHDhsjNH2L7+3vKTGMl/ozU47gFtfUQVjX9KBLnmUTrzfm32eZDclzo1HJibIN
	 ZXJPhCinsCgQ3vK2s3Rcx93kTAJ0SIJDrAyEoZIzwya1CgpmD9h4bUgvt7kNRXVj4u
	 cJZN0zxO+OmRkewkxUvJVyPqM1CIAwPCmInxJ9zCL9O3CFOQdCBYh6vNZAhxBc6omS
	 vB7cFDUy1kagg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next] bpf, arm64: Add support for lse atomics in bpf_arena
Date: Fri, 26 Apr 2024 16:11:16 +0000
Message-Id: <20240426161116.441-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When LSE atomics are available, BPF atomic instructions are implemented
as single ARM64 atomic instructions, therefore it is easy to enable
these in bpf_arena using the currently available exception handling
setup.

LL_SC atomics use loops and therefore would need more work to enable in
bpf_arena.

Enable LSE atomics based instructions in bpf_arena and use the
bpf_jit_supports_insn() callback to reject atomics in bpf_arena if LSE
atomics are not available.

All atomics and arena_atomics selftests are passing:

  [root@ip-172-31-2-216 bpf]# ./test_progs -a atomics,arena_atomics
  #3/1     arena_atomics/add:OK
  #3/2     arena_atomics/sub:OK
  #3/3     arena_atomics/and:OK
  #3/4     arena_atomics/or:OK
  #3/5     arena_atomics/xor:OK
  #3/6     arena_atomics/cmpxchg:OK
  #3/7     arena_atomics/xchg:OK
  #3       arena_atomics:OK
  #10/1    atomics/add:OK
  #10/2    atomics/sub:OK
  #10/3    atomics/and:OK
  #10/4    atomics/or:OK
  #10/5    atomics/xor:OK
  #10/6    atomics/cmpxchg:OK
  #10/7    atomics/xchg:OK
  #10      atomics:OK
  Summary: 2/14 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c                | 48 ++++++++++++++++----
 tools/testing/selftests/bpf/DENYLIST.aarch64 |  1 -
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 76b91f36c729..53347d4217f4 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -494,20 +494,26 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 static int emit_lse_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 {
 	const u8 code = insn->code;
+	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
 	const u8 dst = bpf2a64[insn->dst_reg];
 	const u8 src = bpf2a64[insn->src_reg];
 	const u8 tmp = bpf2a64[TMP_REG_1];
 	const u8 tmp2 = bpf2a64[TMP_REG_2];
 	const bool isdw = BPF_SIZE(code) == BPF_DW;
+	const bool arena = BPF_MODE(code) == BPF_PROBE_ATOMIC;
 	const s16 off = insn->off;
-	u8 reg;
+	u8 reg = dst;
 
-	if (!off) {
-		reg = dst;
-	} else {
-		emit_a64_mov_i(1, tmp, off, ctx);
-		emit(A64_ADD(1, tmp, tmp, dst), ctx);
-		reg = tmp;
+	if (off || arena) {
+		if (off) {
+			emit_a64_mov_i(1, tmp, off, ctx);
+			emit(A64_ADD(1, tmp, tmp, dst), ctx);
+			reg = tmp;
+		}
+		if (arena) {
+			emit(A64_ADD(1, tmp, reg, arena_vm_base), ctx);
+			reg = tmp;
+		}
 	}
 
 	switch (insn->imm) {
@@ -576,6 +582,12 @@ static int emit_ll_sc_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	u8 reg;
 	s32 jmp_offset;
 
+	if (BPF_MODE(code) == BPF_PROBE_ATOMIC) {
+		/* ll_sc based atomics don't support unsafe pointers yet. */
+		pr_err_once("unknown atomic opcode %02x\n", code);
+		return -EINVAL;
+	}
+
 	if (!off) {
 		reg = dst;
 	} else {
@@ -777,7 +789,8 @@ static int add_exception_handler(const struct bpf_insn *insn,
 
 	if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
 		BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
-			BPF_MODE(insn->code) != BPF_PROBE_MEM32)
+			BPF_MODE(insn->code) != BPF_PROBE_MEM32 &&
+				BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
 		return 0;
 
 	if (!ctx->prog->aux->extable ||
@@ -1474,12 +1487,18 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
 		if (cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
 			ret = emit_lse_atomic(insn, ctx);
 		else
 			ret = emit_ll_sc_atomic(insn, ctx);
 		if (ret)
 			return ret;
+
+		ret = add_exception_handler(insn, ctx, dst);
+		if (ret)
+			return ret;
 		break;
 
 	default:
@@ -2527,6 +2546,19 @@ bool bpf_jit_supports_arena(void)
 	return true;
 }
 
+bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
+{
+	if (!in_arena)
+		return true;
+	switch (insn->code) {
+	case BPF_STX | BPF_ATOMIC | BPF_W:
+	case BPF_STX | BPF_ATOMIC | BPF_DW:
+		if (!cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
+			return false;
+	}
+	return true;
+}
+
 void bpf_jit_free(struct bpf_prog *prog)
 {
 	if (prog->jited) {
diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index cf657fc35619..0445ac38bc07 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -10,4 +10,3 @@ fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_mu
 fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 missed/kprobe_recursion                          # missed_kprobe_recursion__attach unexpected error: -95 (errno 95)
-arena_atomics
-- 
2.40.1


