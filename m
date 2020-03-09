Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F2217D92A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Mar 2020 07:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgCIGAU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Mar 2020 02:00:20 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54054 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIGAS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Mar 2020 02:00:18 -0400
Received: by mail-pj1-f65.google.com with SMTP id l36so1099465pjb.3
        for <linux-kselftest@vger.kernel.org>; Sun, 08 Mar 2020 23:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rUKlGDBMCbAw5MnwP+pnyv3TuPeIXkUOoH2aeMUvFDo=;
        b=N0+qu61LiHJItpKHpbvlqpH47b4Le9mDQkQv4Zq9Ex6eBqQg+KLaWfwq82nJUDHprL
         dhH+futhGtoLxN3ITV5DPBUgugVwSgF3GiXk5eieZmtC0S9G0q1iBER7E1t3/gFi1qjo
         il7gjx5LbyK+7KlYVjkRvXAPPIVeTHdF4+nliapGG+WRP5wFYCLZhldmygZAXNwZm8tr
         oEdMRHqmXhI7tKOlM2V6XhH8Gkzar0zEuuV42GD6UmvpipJe1dKpiv28G76/LwQXvdm9
         eCdnP0oyzqGsb9SEsiVlMjwbSP1g3aVijbAL8tmTKKGAjsJWZWZ//FEpaabcIvqYNNRh
         QasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rUKlGDBMCbAw5MnwP+pnyv3TuPeIXkUOoH2aeMUvFDo=;
        b=kquJhncs5gqScKkQyuaBLtNa5LwHbH56iJpBjtHOodRkvcPfGSW/d10FO7EzpKmZiL
         PYup4PpdWMmhPRYOgDToJTWmWtfPQcnj8P332u+6as7PTypqc7xXQ/lSEiZ8jEHLJ5Mc
         WlhRbxAcBD/RA3LhjPwFWeMEBXo6afjFptfubULHbipvfQzKYbIJELmbEYqWODfetVZI
         VIMn8pDho1x60KLbSG9ae+e2vJ/ZVD22D3z2+d3WeE0zqtouFsq2LpLH9vMpOyveQaz4
         +xhTEKzm7vrcpYpfvB9Irdny8wQQjmlF4RblLmSdI4HuXAa1LtVMfK/PY3CvdGOpH1qM
         FhKw==
X-Gm-Message-State: ANhLgQ3TJto0ujp8RGW9T6e/9DF4OCU2PL8SH789lktZDN3gpar6YiCM
        ZLxRICPr5el8Lapow1BSGwYaQQ==
X-Google-Smtp-Source: ADFU+vuY2yrT8g239iEXinolIIZlAvhytfwdgTU8khCik7LD4KBy8Z5b0yK3T+RCRfeP8l5anVnnUQ==
X-Received: by 2002:a17:90a:9908:: with SMTP id b8mr16712029pjp.93.1583733616703;
        Sun, 08 Mar 2020 23:00:16 -0700 (PDT)
Received: from VincentChen-ThinkPad-T480s.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id nh4sm3033061pjb.39.2020.03.08.23.00.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Mar 2020 23:00:15 -0700 (PDT)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        mathieu.desnoyers@efficios.com
Cc:     linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH V2 3/3] rseq/selftests: Add support for riscv
Date:   Mon,  9 Mar 2020 13:59:52 +0800
Message-Id: <1583733592-22873-4-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583733592-22873-1-git-send-email-vincent.chen@sifive.com>
References: <1583733592-22873-1-git-send-email-vincent.chen@sifive.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add support for risc-v in the rseq selftests, which covers both
64-bit and 32-bit ISA with little endian mode.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 tools/testing/selftests/rseq/param_test.c |  23 ++
 tools/testing/selftests/rseq/rseq-riscv.h | 622 ++++++++++++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h       |   2 +
 3 files changed, 647 insertions(+)
 create mode 100644 tools/testing/selftests/rseq/rseq-riscv.h

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index e8a657a5f48a..4032dfaa3af2 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -205,6 +205,29 @@ unsigned int yield_mod_cnt, nr_abort;
 	"addiu " INJECT_ASM_REG ", -1\n\t" \
 	"bnez " INJECT_ASM_REG ", 222b\n\t" \
 	"333:\n\t"
+#elif defined(__riscv)
+
+#define RSEQ_INJECT_INPUT \
+	, [loop_cnt_1]"m"(loop_cnt[1]) \
+	, [loop_cnt_2]"m"(loop_cnt[2]) \
+	, [loop_cnt_3]"m"(loop_cnt[3]) \
+	, [loop_cnt_4]"m"(loop_cnt[4]) \
+	, [loop_cnt_5]"m"(loop_cnt[5]) \
+	, [loop_cnt_6]"m"(loop_cnt[6])
+
+#define INJECT_ASM_REG	"t1"
+
+#define RSEQ_INJECT_CLOBBER \
+	, INJECT_ASM_REG
+
+#define RSEQ_INJECT_ASM(n)					\
+	"lw " INJECT_ASM_REG ", %[loop_cnt_" #n "]\n\t"		\
+	"beqz " INJECT_ASM_REG ", 333f\n\t"			\
+	"222:\n\t"						\
+	"addi  " INJECT_ASM_REG "," INJECT_ASM_REG ", -1\n\t"	\
+	"bnez " INJECT_ASM_REG ", 222b\n\t"			\
+	"333:\n\t"
+
 
 #else
 #error unsupported target
diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/selftests/rseq/rseq-riscv.h
new file mode 100644
index 000000000000..56b47db4a9a4
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-riscv.h
@@ -0,0 +1,622 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Select the instruction "csrw mhartid, x0" as the RSEQ_SIG. Unlike
+ * other architecture, the ebreak instruction has no immediate field for
+ * distinguishing purposes. Hence, ebreak is not suitable as RSEQ_SIG.
+ * "csrw mhartid, x0" can also satisfy the RSEQ requirement because it
+ * is an uncommon instruction and will raise an illegal instruction
+ * exception when executed in all modes.
+ */
+
+#if __ORDER_LITTLE_ENDIAN__ == 1234
+#define RSEQ_SIG   0xf1401073  /* csrr mhartid, x0 */
+#else
+#error "Currently, RSEQ only supports Little-Endian version"
+#endif
+
+#if __riscv_xlen == 64
+#define __REG_SEL(a, b)	a
+#elif __riscv_xlen == 32
+#define __REG_SEL(a, b)	b
+#endif
+
+#define REG_L	__REG_SEL("ld ", "lw ")
+#define REG_S	__REG_SEL("sd ", "sw ")
+
+#define RISCV_FENCE(p, s) \
+	__asm__ __volatile__ ("fence " #p "," #s : : : "memory")
+#define rseq_smp_mb()	RISCV_FENCE(rw, rw)
+#define rseq_smp_rmb()	RISCV_FENCE(r, r)
+#define rseq_smp_wmb()	RISCV_FENCE(w, w)
+#define RSEQ_ASM_TMP_REG_1	"t6"
+#define RSEQ_ASM_TMP_REG_2	"t5"
+#define RSEQ_ASM_TMP_REG_3	"t4"
+#define RSEQ_ASM_TMP_REG_4	"t3"
+
+#define rseq_smp_load_acquire(p)					\
+__extension__ ({							\
+	__typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);			\
+	RISCV_FENCE(r, rw)						\
+	____p1;								\
+})
+
+#define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_rmb()
+
+#define rseq_smp_store_release(p, v)					\
+do {									\
+	RISCV_FENCE(rw, w);						\
+	RSEQ_WRITE_ONCE(*p, v);						\
+} while (0)
+
+
+#ifdef RSEQ_SKIP_FASTPATH
+#include "rseq-skip.h"
+#else /* !RSEQ_SKIP_FASTPATH */
+
+#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,	\
+				post_commit_offset, abort_ip)		\
+	".pushsection	__rseq_cs, \"aw\"\n"				\
+	".balign	32\n"						\
+	__rseq_str(label) ":\n"						\
+	".long	" __rseq_str(version) ", " __rseq_str(flags) "\n"	\
+	".quad	" __rseq_str(start_ip) ", "				\
+			  __rseq_str(post_commit_offset) ", "		\
+			  __rseq_str(abort_ip) "\n"			\
+	".popsection\n\t"						\
+	".pushsection __rseq_cs_ptr_array, \"aw\"\n"			\
+	".quad " __rseq_str(label) "b\n"				\
+	".popsection\n"
+
+#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip) \
+	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,		 \
+				(post_commit_ip - start_ip), abort_ip)
+
+
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_cs section and should not be
+ * explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)			\
+	".pushsection __rseq_exit_point_array, \"aw\"\n"		\
+	".quad " __rseq_str(start_ip) ", " __rseq_str(exit_ip) "\n"	\
+	".popsection\n"
+
+#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
+	RSEQ_INJECT_ASM(1)						\
+	"la	"RSEQ_ASM_TMP_REG_1 ", " __rseq_str(cs_label) "\n"	\
+	REG_S	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(rseq_cs) "]\n"	\
+	__rseq_str(label) ":\n"
+
+#define RSEQ_ASM_DEFINE_ABORT(label, abort_label)			\
+	"j	222f\n"							\
+	".balign	4\n"						\
+	".long "	__rseq_str(RSEQ_SIG) "\n"			\
+	__rseq_str(label) ":\n"						\
+	"j	%l[" __rseq_str(abort_label) "]\n"			\
+	"222:\n"
+
+#define RSEQ_ASM_OP_STORE(value, var)					\
+	REG_S	"%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n"
+
+#define RSEQ_ASM_OP_CMPEQ(var, expect, label)				\
+	REG_L	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"		\
+	"bne	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
+		  __rseq_str(label) "\n"
+
+#define RSEQ_ASM_OP_CMPEQ32(var, expect, label)				\
+	"lw	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"	\
+	"bne	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
+		  __rseq_str(label) "\n"
+
+#define RSEQ_ASM_OP_CMPNE(var, expect, label)				\
+	REG_L	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"		\
+	"beq	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
+		  __rseq_str(label) "\n"
+
+#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
+	RSEQ_INJECT_ASM(2)						\
+	RSEQ_ASM_OP_CMPEQ32(current_cpu_id, cpu_id, label)
+
+#define RSEQ_ASM_OP_R_LOAD(var)						\
+	REG_L	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"
+
+#define RSEQ_ASM_OP_R_STORE(var)					\
+	REG_S	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"
+
+#define RSEQ_ASM_OP_R_LOAD_OFF(offset)					\
+	"add	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(offset) "], "	\
+		 RSEQ_ASM_TMP_REG_1 "\n"				\
+	REG_L	RSEQ_ASM_TMP_REG_1 ", (" RSEQ_ASM_TMP_REG_1 ")\n"
+
+#define RSEQ_ASM_OP_R_ADD(count)					\
+	"add	"RSEQ_ASM_TMP_REG_1 ", " RSEQ_ASM_TMP_REG_1		\
+		", %[" __rseq_str(count) "]\n"
+
+#define RSEQ_ASM_OP_FINAL_STORE(value, var, post_commit_label)		\
+	RSEQ_ASM_OP_STORE(value, var)					\
+	__rseq_str(post_commit_label) ":\n"
+
+#define RSEQ_ASM_OP_FINAL_STORE_RELEASE(value, var, post_commit_label)	\
+	"fence	rw, w\n"						\
+	RSEQ_ASM_OP_STORE(value, var)					\
+	__rseq_str(post_commit_label) ":\n"
+
+#define RSEQ_ASM_OP_R_FINAL_STORE(var, post_commit_label)		\
+	REG_S	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"		\
+	__rseq_str(post_commit_label) ":\n"
+
+#define RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)				\
+	"beqz	%[" __rseq_str(len) "], 333f\n"				\
+	"mv	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(len) "]\n"	\
+	"mv	" RSEQ_ASM_TMP_REG_2 ", %[" __rseq_str(src) "]\n"	\
+	"mv	" RSEQ_ASM_TMP_REG_3 ", %[" __rseq_str(dst) "]\n"	\
+	"222:\n"							\
+	"lb	" RSEQ_ASM_TMP_REG_4 ", 0(" RSEQ_ASM_TMP_REG_2 ")\n"	\
+	"sb	" RSEQ_ASM_TMP_REG_4 ", 0(" RSEQ_ASM_TMP_REG_3 ")\n"	\
+	"addi	" RSEQ_ASM_TMP_REG_1 ", " RSEQ_ASM_TMP_REG_1 ", -1\n"	\
+	"addi	" RSEQ_ASM_TMP_REG_2 ", " RSEQ_ASM_TMP_REG_2 ", 1\n"	\
+	"addi	" RSEQ_ASM_TMP_REG_3 ", " RSEQ_ASM_TMP_REG_3 ", 1\n"	\
+	"bnez	" RSEQ_ASM_TMP_REG_1 ", 222b\n"				\
+	"333:\n"
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG_1
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
+			       off_t voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[error2])
+#endif
+		RSEQ_ASM_OP_R_LOAD(v)
+		RSEQ_ASM_OP_R_STORE(load)
+		RSEQ_ASM_OP_R_LOAD_OFF(voffp)
+		RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [load]		"m" (*load),
+		  [voffp]		"r" (voffp)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG_1
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_addv(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+#endif
+		RSEQ_ASM_OP_R_LOAD(v)
+		RSEQ_ASM_OP_R_ADD(count)
+		RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [v]			"m" (*v),
+		  [count]		"r" (count)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG_1
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		RSEQ_ASM_OP_STORE(newv2, v2)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [expect]		"r" (expect),
+		  [v]			"m" (*v),
+		  [newv]		"r" (newv),
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG_1
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
+					 intptr_t *v2, intptr_t newv2,
+					 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		RSEQ_ASM_OP_STORE(newv2, v2)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [expect]		"r" (expect),
+		  [v]			"m" (*v),
+		  [newv]		"r" (newv),
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG_1
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error3])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[cmpfail])
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[error3])
+#endif
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG_1
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2, error3
+#endif
+	);
+
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+error3:
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [expect]		"r" (expect),
+		  [v]			"m" (*v),
+		  [newv]		"r" (newv),
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG_1, RSEQ_ASM_TMP_REG_2,
+		  RSEQ_ASM_TMP_REG_3, RSEQ_ASM_TMP_REG_4
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
+					 void *dst, void *src, size_t len,
+					 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [expect]		"r" (expect),
+		  [v]			"m" (*v),
+		  [newv]		"r" (newv),
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG_1, RSEQ_ASM_TMP_REG_2,
+		  RSEQ_ASM_TMP_REG_3, RSEQ_ASM_TMP_REG_4
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 3f63eb362b92..72efb6d3d84e 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -79,6 +79,8 @@ extern int __rseq_handled;
 #include <rseq-mips.h>
 #elif defined(__s390__)
 #include <rseq-s390.h>
+#elif defined(__riscv)
+#include <rseq-riscv.h>
 #else
 #error unsupported target
 #endif
-- 
2.7.4

