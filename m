Return-Path: <linux-kselftest+bounces-39710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F41B321C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 19:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA3EA246CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA8329B8D3;
	Fri, 22 Aug 2025 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="e3EerpOg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0591629AB07
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884854; cv=none; b=dkZHLP6OEXynFHi7uhUSAT0PRegWT6VfpmKZLu9RGAcb2LNru1MtFpyMIT4gB9bfpaOR5vYD/CT9aPnuQsO+nQG9crHw/RnKC71v5WwIVWYAdDIjqH5HgAuTDJRpSQuD8hQckNL8IlGHnUH4kbuzfPKXmbsjQz+1F12Vf/8mmLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884854; c=relaxed/simple;
	bh=X+6QdUGJFZatXPjCaqp4CDf25eqedNjl9QERE4DuDXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6uxq+pPThiz2VVDBUTHdgdIGVJ7vu3rb29NeKd9vIeU4eYgVIBWKR9EWQbHZRLTOEOozNWJ7RWnsbt5sV/tYaF+qM33r5iT6JCu0wpNfuGDgyysLBuJlpi4nBPckr4EjmG4HJcrzKD8fO11NXjAhZcPQRdvWq+O44gli1RULkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=e3EerpOg; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b1099192b0so39199161cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755884852; x=1756489652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=485omdnoiZ8q/zyCXrPmnF91ALfkIJJ0rUsYbVB32HY=;
        b=e3EerpOgTOs0gdxSVrqCa1+zdvvnZR9QCOokmGA4jjPoGX5JVzTbqBN8UFDTxwL5cK
         wu2dNoiw83L79ooas5VO3jhKZZ/rba3+fT8WgZrlRKRxaThc2QDQLQxJo/ysTVj5rWUo
         C9uwdU7LRRlgdNoRbuwxjIjxc+HD2MM2SE7SGCZXMqMkAYgUxTTc1R/93hJ42HTTPj67
         B6vYFtrkkpKTkXt0ICA6uKEBvmK8Qa1iGxnU6OLXs4a37G9iXESh1TKi76PzLEARGfRx
         namfD9IlT++91I93NMvZYw4kinNZGqKxTy1OrKy+5RUKjP1gwhULxuDLhQhPoTezdVJw
         z8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755884852; x=1756489652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=485omdnoiZ8q/zyCXrPmnF91ALfkIJJ0rUsYbVB32HY=;
        b=Wk/2sWCfobVS5xT2t+TYVbB7SnDpxPOb7DSWcvW0axlUY/xrLzYqBFx4x+Vwn6I0fw
         CttMrXK8P0pp3SQC9Uer5ZcrEG+G/UwW+VT91fU9x1oBmkBqUvdvCWILSS1jqUdVvhz+
         ifQErjlGDGs+tXmSp8NOwV764wQoGEr3LDC6uMqAdrJkPG5oAjrndqr8fo7dcBPc/2fr
         Ce5WFA88bQ3qoNVmaHbvGsyvwDdQzg87QdnJsi11WZs8+I7y2qq6bgQLjMv5BQn7UqQx
         WanXlz+O1VJ2fsJktFqeuCU4QDWn5ox1j19+PuQcifZD24PjPtPFGShnzqf873ZvlpKU
         RIOw==
X-Forwarded-Encrypted: i=1; AJvYcCXR3fI/ijzSjrnixSASPbHJdPWUTGqdbWB79oGS40Sgivwy7hGW7v1uojF8RC4R7F17kStD9UhOfLlIxQAyC1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKyV7vGulC0hNvNl08IWyhRPv7nJdV09gia+5jkFi8iufhtSQf
	wQLePjPkvXqLBKMypFU7BhYkmkqnLE8QIFS+kI1nhWe4WyYCg4bySh9F//+0DR4g9ys=
X-Gm-Gg: ASbGncvI/TEpGj5cU7U8DLoBdF/mS850sYa11V6TELJEFx7I0rDrwTVIlBmktJ5SEJr
	fwdhRaZWusOrnP/+XU6/4Xxujc9YAfcei30aVW9j85LLcEwrrNFxuSOgNd6NP1Xc1yWN0+lyb76
	giGQgz5j5NFepNRx8KCXItj02SM4FZucILNchcxrDTn2izykVRgBf4CP72ItAj5bJ9Qoe88ugKC
	SK7xH34Ux8DinHBlnwpBZRjmFKyzsXmYnOBjN1o/OCaA4b9oKLKgKODoBNuQXsa4poY50xl9UqR
	u+wKuoHDdT8QU+vYqILL4AZ2GKJUbYOMZcE+C97R/jy33wHjms/J/8JRBAuZLHW0BV3xIY0NjKf
	uB6dJhw08yJtYUwY7UGniTBk+YnfcDd6vX5KDasshBQyvXOgd/pwAEKwy6DrDmb67okxp0inR7m
	kNHI+YkwTI202/2SSI
X-Google-Smtp-Source: AGHT+IGoenLDbU6hbLQEKjRKYVSKG56q+cISud/2IPoQ+SsuP/D2JDv3vRwFBNiEIIl5J7Ci/Xlcfg==
X-Received: by 2002:a05:622a:1115:b0:4b2:8ac4:f07f with SMTP id d75a77b69052e-4b2aab8c4e6mr52180651cf.81.1755884851684;
        Fri, 22 Aug 2025 10:47:31 -0700 (PDT)
Received: from jesse-lt.jtp-bos.lab (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e6023asm3121361cf.53.2025.08.22.10.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 10:47:31 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang Kan" <kan.liang@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Evan Green <evan@rivosinc.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	Nylon Chen <nylon.chen@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>
Subject: [PATCH 6/8] riscv: ptrace: Add hw breakpoint support
Date: Fri, 22 Aug 2025 10:47:13 -0700
Message-ID: <20250822174715.1269138-7-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822174715.1269138-1-jesse@rivosinc.com>
References: <20250822174715.1269138-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ability to setup hw breakpoints to ptrace. Call defines a new
structure of __riscv_hwdebug_state which will be passed to ptrace.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
RFC -> V1:
 - Add struct __riscv_hwdebug_state for ptrace_hbp_set/get
 - Break out ptrace_hbp_set/get so regset can use them
 - Check for NULL instead of IS_ERR_OR_NULL
 - Move	ptrace_get/sethbpregs above user_regset
V1 -> V2:
 - No change
---
 arch/riscv/include/asm/processor.h   |   4 +
 arch/riscv/include/uapi/asm/ptrace.h |   9 +++
 arch/riscv/kernel/hw_breakpoint.c    |  14 +++-
 arch/riscv/kernel/process.c          |   4 +
 arch/riscv/kernel/ptrace.c           | 110 +++++++++++++++++++++++++++
 5 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 5f56eb9d114a..488d956a951f 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -12,6 +12,7 @@
 
 #include <vdso/processor.h>
 
+#include <asm/hw_breakpoint.h>
 #include <asm/ptrace.h>
 
 #define arch_get_mmap_end(addr, len, flags)			\
@@ -108,6 +109,9 @@ struct thread_struct {
 	struct __riscv_v_ext_state vstate;
 	unsigned long align_ctl;
 	struct __riscv_v_ext_state kernel_vstate;
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	struct perf_event *ptrace_bps[RV_MAX_TRIGGERS];
+#endif
 #ifdef CONFIG_SMP
 	/* Flush the icache on migration */
 	bool force_icache_flush;
diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index a38268b19c3d..20d1aa595cbd 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -14,6 +14,8 @@
 
 #define PTRACE_GETFDPIC_EXEC	0
 #define PTRACE_GETFDPIC_INTERP	1
+#define PTRACE_GETHBPREGS	2
+#define PTRACE_SETHBPREGS	3
 
 /*
  * User-mode register state for core dumps, ptrace, sigcontext
@@ -120,6 +122,13 @@ struct __riscv_v_regset_state {
 	char vreg[];
 };
 
+struct __riscv_hwdebug_state {
+	unsigned long addr;
+	unsigned long type;
+	unsigned long len;
+	unsigned long ctrl;
+} __packed;
+
 /*
  * According to spec: The number of bits in a single vector register,
  * VLEN >= ELEN, which must be a power of 2, and must be no greater than
diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
index f12306247436..f8841941f2ab 100644
--- a/arch/riscv/kernel/hw_breakpoint.c
+++ b/arch/riscv/kernel/hw_breakpoint.c
@@ -715,7 +715,19 @@ void arch_uninstall_hw_breakpoint(struct perf_event *event)
 		pr_warn("%s: Failed to uninstall trigger %d. error: %ld\n", __func__, i, ret.error);
 }
 
-void flush_ptrace_hw_breakpoint(struct task_struct *tsk) { }
+/*
+ * Release the user breakpoints used by ptrace
+ */
+void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+	int i;
+	struct thread_struct *t = &tsk->thread;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		unregister_hw_breakpoint(t->ptrace_bps[i]);
+		t->ptrace_bps[i] = NULL;
+	}
+}
 
 void hw_breakpoint_pmu_read(struct perf_event *bp) { }
 
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 15d8f75902f8..9cf07ecfb523 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -9,6 +9,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/cpu.h>
+#include <linux/hw_breakpoint.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
@@ -164,6 +165,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 
 void flush_thread(void)
 {
+	flush_ptrace_hw_breakpoint(current);
 #ifdef CONFIG_FPU
 	/*
 	 * Reset FPU state and context
@@ -218,6 +220,8 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		set_bit(MM_CONTEXT_LOCK_PMLEN, &p->mm->context.flags);
 
 	memset(&p->thread.s, 0, sizeof(p->thread.s));
+	if (IS_ENABLED(CONFIG_HAVE_HW_BREAKPOINT))
+		memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
 	/* p->thread holds context to be restored by __switch_to() */
 	if (unlikely(args->fn)) {
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index ea67e9fb7a58..e097e6a61910 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -9,11 +9,13 @@
 
 #include <asm/vector.h>
 #include <asm/ptrace.h>
+#include <asm/hw_breakpoint.h>
 #include <asm/syscall.h>
 #include <asm/thread_info.h>
 #include <asm/switch_to.h>
 #include <linux/audit.h>
 #include <linux/compat.h>
+#include <linux/hw_breakpoint.h>
 #include <linux/ptrace.h>
 #include <linux/elf.h>
 #include <linux/regset.h>
@@ -184,6 +186,104 @@ static int tagged_addr_ctrl_set(struct task_struct *target,
 }
 #endif
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+static void ptrace_hbptriggered(struct perf_event *bp,
+				struct perf_sample_data *data,
+				struct pt_regs *regs)
+{
+	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
+	int num = 0;
+
+	force_sig_ptrace_errno_trap(num, (void __user *)bkpt->address);
+}
+
+static int ptrace_hbp_get(struct task_struct *child, unsigned long idx,
+			  struct __riscv_hwdebug_state *state)
+{
+	struct perf_event *bp;
+
+	if (idx >= RV_MAX_TRIGGERS)
+		return -EINVAL;
+
+	bp = child->thread.ptrace_bps[idx];
+
+	if (!bp)
+		return -ENOENT;
+
+	state->addr = bp->attr.bp_addr;
+	state->len = bp->attr.bp_len;
+	state->type = bp->attr.bp_type;
+	state->ctrl = bp->attr.disabled == 1;
+
+	return 0;
+}
+
+static int ptrace_hbp_set(struct task_struct *child, unsigned long idx,
+			  struct __riscv_hwdebug_state *state)
+{
+	struct perf_event *bp;
+	struct perf_event_attr attr;
+
+	if (idx >= RV_MAX_TRIGGERS)
+		return -EINVAL;
+
+	bp = child->thread.ptrace_bps[idx];
+	if (bp)
+		attr = bp->attr;
+	else
+		ptrace_breakpoint_init(&attr);
+
+	attr.bp_addr = state->addr;
+	attr.bp_len = state->len;
+	attr.bp_type = state->type;
+	attr.disabled = state->ctrl == 1;
+
+	if (!bp) {
+		bp = register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL,
+					   child);
+		if (IS_ERR(bp))
+			return PTR_ERR(bp);
+
+		child->thread.ptrace_bps[idx] = bp;
+		return 0;
+	}
+
+	return modify_user_hw_breakpoint(bp, &attr);
+}
+
+/*
+ * idx selects the breakpoint index.
+ * Both PTRACE_GETHBPREGS and PTRACE_SETHBPREGS transfer __riscv_hwdebug_state
+ */
+
+static long ptrace_gethbpregs(struct task_struct *child, unsigned long idx,
+			      unsigned long __user *datap)
+{
+	struct __riscv_hwdebug_state state;
+	long ret;
+
+	ret = ptrace_hbp_get(child, idx, &state);
+	if (ret)
+		return ret;
+	if (copy_to_user(datap, &state, sizeof(state)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long ptrace_sethbpregs(struct task_struct *child, unsigned long idx,
+			      unsigned long __user *datap)
+{
+	struct __riscv_hwdebug_state state;
+
+	if (copy_from_user(&state, datap, sizeof(state)))
+		return -EFAULT;
+
+	return ptrace_hbp_set(child, idx, &state);
+
+}
+#endif
+
 static const struct user_regset riscv_user_regset[] = {
 	[REGSET_X] = {
 		.core_note_type = NT_PRSTATUS,
@@ -340,8 +440,18 @@ long arch_ptrace(struct task_struct *child, long request,
 		 unsigned long addr, unsigned long data)
 {
 	long ret = -EIO;
+	unsigned long __user *datap = (unsigned long __user *) data;
 
 	switch (request) {
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	case PTRACE_GETHBPREGS:
+		ret = ptrace_gethbpregs(child, addr, datap);
+		break;
+
+	case PTRACE_SETHBPREGS:
+		ret = ptrace_sethbpregs(child, addr, datap);
+		break;
+#endif
 	default:
 		ret = ptrace_request(child, request, addr, data);
 		break;
-- 
2.43.0


