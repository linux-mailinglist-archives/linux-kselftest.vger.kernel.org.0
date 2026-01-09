Return-Path: <linux-kselftest+bounces-48613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A31D0AFB2
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 16:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FE613076816
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 15:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6493596F0;
	Fri,  9 Jan 2026 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iDNCykDA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C112E7160
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973032; cv=none; b=ooPHJP2w4pyQr2RyCZZ3kIl0bjj0KmY1O8sEcTDBDaDfA6bcQf2q/hTAr9vQ8Mf8/UPGAgjt9MMeXfFr4dAD79o3ojJmVfHzZthyybd7HVzXV8H7EVyCE5PFYUSQQEFprGT7L74fS8IzvO3h+RX+pFhJBUpBXIk4GdRGd40M1fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973032; c=relaxed/simple;
	bh=l/hupaNnVXU7GiVcnweVKH9y/0ngIhXBvVKYebvSiYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDnohQnzT1e3b8JAUJN4nh7dY+hU5qvGqU6xZuv0VDVX/37eMLqUSQpoTU1/2XnF/jawHOzCoEfV9cxOGqSujPNAuoVHF9sgly/Bg0xJDo+EnIfjc+4O6XX4xBEo15fp2kkUWv+7mJGIFQvUlNsQsdvUPmhOZiA1DFltuFB4Qv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iDNCykDA; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767973028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5p/tww7cB1FEKleJGQjJQqwkIHUCww35xYq5j4Io0w=;
	b=iDNCykDAhIo+5NV1zsDlYIlDVQG2Y9ILsjezMyikGMeFitDAluKSyPmX5BAnpxDgfpCB7x
	InHGYYg4tl5591BtQyo4fsiAj0WfmHe2/1uM39GkpD6mb574Hoan28pyxVh7o5SjQnAX00
	gPT7+2uh7ZbcM5UM82XV3Amx0x8ZJYY=
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
Subject: [PATCH bpf-next 1/3] bpf, x64: Call perf_snapshot_branch_stack in trampoline
Date: Fri,  9 Jan 2026 23:34:18 +0800
Message-ID: <20260109153420.32181-2-leon.hwang@linux.dev>
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

When the PMU LBR is running in branch-sensitive mode,
'perf_snapshot_branch_stack()' may capture branch entries from the
trampoline entry up to the call site inside a BPF program. These branch
entries are not useful for analyzing the control flow of the tracee.

To eliminate such noise for tracing programs, the branch snapshot should
be taken as early as possible:

* Call 'perf_snapshot_branch_stack()' at the very beginning of the
  trampoline for fentry programs.
* Call 'perf_snapshot_branch_stack()' immediately after invoking the
  tracee for fexit programs.

With this change, LBR snapshots remain meaningful even when multiple BPF
programs execute before the one requesting LBR data.

In addition, more relevant branch entries can be captured on AMD CPUs,
which provide a 16-entry-deep LBR stack.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 66 +++++++++++++++++++++++++++++++++++++
 include/linux/bpf.h         | 16 ++++++++-
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e3b1c4b1d550..a71a6c675392 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -12,6 +12,7 @@
 #include <linux/bpf.h>
 #include <linux/memory.h>
 #include <linux/sort.h>
+#include <linux/perf_event.h>
 #include <asm/extable.h>
 #include <asm/ftrace.h>
 #include <asm/set_memory.h>
@@ -19,6 +20,7 @@
 #include <asm/text-patching.h>
 #include <asm/unwind.h>
 #include <asm/cfi.h>
+#include "../events/perf_event.h"
 
 static bool all_callee_regs_used[4] = {true, true, true, true};
 
@@ -3137,6 +3139,54 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 	return 0;
 }
 
+DEFINE_PER_CPU(struct bpf_tramp_branch_entries, bpf_branch_snapshot);
+
+static int invoke_branch_snapshot(u8 **pprog, void *image, void *rw_image)
+{
+	struct bpf_tramp_branch_entries __percpu *pptr = &bpf_branch_snapshot;
+	u8 *prog = *pprog;
+
+	/*
+	 * Emit:
+	 *
+	 * struct bpf_tramp_branch_entries *br = this_cpu_ptr(&bpf_branch_snapshot);
+	 * br->cnt = static_call(perf_snapshot_branch_stack)(br->entries, x86_pmu.lbr_nr);
+	 */
+
+	/* mov rbx, &bpf_branch_snapshot */
+	emit_mov_imm64(&prog, BPF_REG_6, (long) pptr >> 32, (u32)(long) pptr);
+#ifdef CONFIG_SMP
+	/* add rbx, gs:[<off>] */
+	EMIT2(0x65, 0x48);
+	EMIT3(0x03, 0x1C, 0x25);
+	EMIT((u32)(unsigned long)&this_cpu_off, 4);
+#endif
+	/* mov esi, x86_pmu.lbr_nr */
+	EMIT1_off32(0xBE, x86_pmu.lbr_nr);
+	/* lea rdi, [rbx + offsetof(struct bpf_tramp_branch_entries, entries)] */
+	EMIT4(0x48, 0x8D, 0x7B, offsetof(struct bpf_tramp_branch_entries, entries));
+	/* call static_call_query(perf_snapshot_branch_stack) */
+	if (emit_rsb_call(&prog, static_call_query(perf_snapshot_branch_stack),
+			  image + (prog - (u8 *)rw_image)))
+		return -EINVAL;
+	/* mov dword ptr [rbx], eax */
+	EMIT2(0x89, 0x03);
+
+	*pprog = prog;
+	return 0;
+}
+
+static bool bpf_prog_copy_branch_snapshot(struct bpf_tramp_links *tl)
+{
+	bool copy = false;
+	int i;
+
+	for (i = 0; i < tl->nr_links; i++)
+		copy = copy || tl->links[i]->link.prog->copy_branch_snapshot;
+
+	return copy;
+}
+
 /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
 #define LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack)	\
 	__LOAD_TCC_PTR(-round_up(stack, 8) - 8)
@@ -3366,6 +3416,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	save_args(m, &prog, regs_off, false, flags);
 
+	if (bpf_prog_copy_branch_snapshot(fentry)) {
+		/* Get branch snapshot asap. */
+		if (invoke_branch_snapshot(&prog, image, rw_image)) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
 		emit_mov_imm64(&prog, BPF_REG_1, (long) im >> 32, (u32) (long) im);
@@ -3422,6 +3480,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		emit_nops(&prog, X86_PATCH_SIZE);
 	}
 
+	if (bpf_prog_copy_branch_snapshot(fexit)) {
+		/* Get branch snapshot asap. */
+		if (invoke_branch_snapshot(&prog, image, rw_image)) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
 	if (fmod_ret->nr_links) {
 		/* From Intel 64 and IA-32 Architectures Optimization
 		 * Reference Manual, 3.4.1.4 Code Alignment, Assembly/Compiler
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5936f8e2996f..16dc21836a06 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -6,6 +6,7 @@
 
 #include <uapi/linux/bpf.h>
 #include <uapi/linux/filter.h>
+#include <uapi/linux/perf_event.h>
 
 #include <crypto/sha2.h>
 #include <linux/workqueue.h>
@@ -1236,6 +1237,18 @@ struct bpf_tramp_links {
 
 struct bpf_tramp_run_ctx;
 
+#ifdef CONFIG_X86_64
+/* Same as MAX_LBR_ENTRIES in arch/x86/events/perf_event.h */
+#define MAX_BRANCH_ENTRIES		32
+
+struct bpf_tramp_branch_entries {
+	int cnt;
+	struct perf_branch_entry entries[MAX_BRANCH_ENTRIES];
+};
+
+DECLARE_PER_CPU(struct bpf_tramp_branch_entries, bpf_branch_snapshot);
+#endif
+
 /* Different use cases for BPF trampoline:
  * 1. replace nop at the function entry (kprobe equivalent)
  *    flags = BPF_TRAMP_F_RESTORE_REGS
@@ -1780,7 +1793,8 @@ struct bpf_prog {
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
 				call_get_func_ip:1, /* Do we call get_func_ip() */
 				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
-				sleepable:1;	/* BPF program is sleepable */
+				sleepable:1,	/* BPF program is sleepable */
+				copy_branch_snapshot:1; /* Copy branch snapshot from prefetched buffer */
 	enum bpf_prog_type	type;		/* Type of BPF program */
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
 	u32			len;		/* Number of filter blocks */
-- 
2.52.0


