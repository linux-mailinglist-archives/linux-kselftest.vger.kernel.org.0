Return-Path: <linux-kselftest+bounces-48614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D372D0AFC7
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 16:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90B703012775
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 15:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB384325720;
	Fri,  9 Jan 2026 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Al1nrBrE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC0A2C21E6;
	Fri,  9 Jan 2026 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973045; cv=none; b=rn+Cbm61nuqfwprn5emtk/5G2aTGdVqEn+K5FtLZtVapKTTVRX4uALpCsAAIgXux3kK8k2W5BP+t7XJDoKO1bqw2shDl9h2Dif8fV8VW5l+KZTXD2jRrfTaLHNZz8RQtEXzJM4EMM/Q0cmv9zzybUoqdYl9cPnNAj69pN9sqH38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973045; c=relaxed/simple;
	bh=rqfMJJtPdBcZvpTr2g0yJoZkcjlR+c5YphY+4gxnujQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C81phBAOIoc9T3k5Yr8IAQASWqlshYjGbeTwg8D4crpEROe5JU0Qf+i0He+/e1IDzsclrvxGGwCu+EAYhuAsXA9ClT5/W/1BrUBGwuZ1Z2aqbKScbIi+ZTrS/upTnnzB9AzHxxaY9w5GP57RRGdIPi1Os7ue/8LGAbYPytw/XAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Al1nrBrE; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767973041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/YV8q+S59t939howf4hH6znlW4fUA9Hm9Vtbx1c9V4=;
	b=Al1nrBrEqSSCF0Hol59g8tD1ncBex/8y1ucgdOTpLFHLlsuQsRHlpMGoipWVGqrqSX1D+P
	Bs2ZNYEAbLCCgBd3Bu42U+3AiOhDBhIczdYyXgj8wg3PlsgdOimHKATvI1usKQ6s+Tp0EH
	xw6N+eHAdFR45dq3p//DS/o3S/0iSVM=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
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
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 2/3] bpf: Introduce BPF_BRANCH_SNAPSHOT_F_COPY flag for bpf_get_branch_snapshot helper
Date: Fri,  9 Jan 2026 23:34:19 +0800
Message-ID: <20260109153420.32181-3-leon.hwang@linux.dev>
In-Reply-To: <20260109153420.32181-1-leon.hwang@linux.dev>
References: <20260109153420.32181-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce BPF_BRANCH_SNAPSHOT_F_COPY flag for tracing programs to copy
branch entries from *bpf_branch_snapshot*.

Instead of introducing a new kfunc, extend bpf_get_branch_snapshot
helper to add the BPF_BRANCH_SNAPSHOT_F_COPY flag support.

Therefore, when BPF_BRANCH_SNAPSHOT_F_COPY is specified:

* Check the *flags* value in verifier's 'check_helper_call()'.
* Skip inlining 'bpf_get_branch_snapshot()' helper in verifier's
  'do_misc_fixups()'.
* 'memcpy()' branch entries in the 'bpf_get_branch_snapshot()' helper.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h          |  4 ++++
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 30 ++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c     | 17 ++++++++++++++---
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 16dc21836a06..71ce225e5160 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1249,6 +1249,10 @@ struct bpf_tramp_branch_entries {
 DECLARE_PER_CPU(struct bpf_tramp_branch_entries, bpf_branch_snapshot);
 #endif

+enum {
+	BPF_BRANCH_SNAPSHOT_F_COPY	= 1,	/* Copy branch snapshot from bpf_branch_snapshot. */
+};
+
 /* Different use cases for BPF trampoline:
  * 1. replace nop at the function entry (kprobe equivalent)
  *    flags = BPF_TRAMP_F_RESTORE_REGS
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 130bcbd66f60..c60a145e0466 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -561,6 +561,7 @@ struct bpf_insn_aux_data {
 	bool non_sleepable; /* helper/kfunc may be called from non-sleepable context */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
+	bool copy_branch_snapshot; /* BPF_BRANCH_SNAPSHOT_F_COPY for bpf_get_branch_snapshot helper */
 	u8 alu_state; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
 	 * pattern for a bpf_fastcall call.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53635ea2e41b..0a537f9c2f8c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11772,6 +11772,33 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
 					 set_user_ringbuf_callback_state);
 		break;
+	case BPF_FUNC_get_branch_snapshot:
+	{
+		u64 flags;
+
+		if (!is_reg_const(&regs[BPF_REG_3], false)) {
+			verbose(env, "Flags in bpf_get_branch_snapshot helper must be const.\n");
+			return -EINVAL;
+		}
+		flags = reg_const_value(&regs[BPF_REG_3], false);
+		if (flags & ~BPF_BRANCH_SNAPSHOT_F_COPY) {
+			verbose(env, "Invalid flags in bpf_get_branch_snapshot helper.\n");
+			return -EINVAL;
+		}
+
+		if (flags & BPF_BRANCH_SNAPSHOT_F_COPY) {
+			if (env->prog->type != BPF_PROG_TYPE_TRACING ||
+			    (env->prog->expected_attach_type != BPF_TRACE_FENTRY &&
+			     env->prog->expected_attach_type != BPF_TRACE_FEXIT)) {
+				verbose(env, "Only fentry and fexit programs support BPF_BRANCH_SNAPSHOT_F_COPY.\n");
+				return -EINVAL;
+			}
+
+			env->insn_aux_data[insn_idx].copy_branch_snapshot = true;
+			env->prog->copy_branch_snapshot = true;
+		}
+		break;
+	}
 	}

 	if (err)
@@ -23370,6 +23397,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			 */
 			BUILD_BUG_ON(br_entry_size != 24);

+			if (env->insn_aux_data[i + delta].copy_branch_snapshot)
+				goto patch_call_imm;
+
 			/* if (unlikely(flags)) return -EINVAL */
 			insn_buf[0] = BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 0, 7);

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6e076485bf70..e9e1698cf608 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1172,10 +1172,20 @@ BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
 	static const u32 br_entry_size = sizeof(struct perf_branch_entry);
 	u32 entry_cnt = size / br_entry_size;

-	entry_cnt = static_call(perf_snapshot_branch_stack)(buf, entry_cnt);
-
-	if (unlikely(flags))
+	if (likely(!flags)) {
+		entry_cnt = static_call(perf_snapshot_branch_stack)(buf, entry_cnt);
+#ifdef CONFIG_X86_64
+	} else if (flags & BPF_BRANCH_SNAPSHOT_F_COPY) {
+		struct bpf_tramp_branch_entries *br;
+
+		br = this_cpu_ptr(&bpf_branch_snapshot);
+		entry_cnt = min_t(u32, entry_cnt, br->cnt);
+		if (entry_cnt)
+			memcpy(buf, (void *) br->entries, entry_cnt * br_entry_size);
+#endif
+	} else {
 		return -EINVAL;
+	}

 	if (!entry_cnt)
 		return -ENOENT;
@@ -1189,6 +1199,7 @@ const struct bpf_func_proto bpf_get_branch_snapshot_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_ANYTHING,
 };

 BPF_CALL_3(get_func_arg, void *, ctx, u32, n, u64 *, value)
--
2.52.0


