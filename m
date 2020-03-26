Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5A8719437E
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 16:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgCZPtD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Mar 2020 11:49:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41804 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgCZPtD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Mar 2020 11:49:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id t16so2279385plr.8
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Mar 2020 08:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=CIj6uXerr1Bjb0No+AaAcQiVw4/PjRgv7EYhzjSEUFs=;
        b=BetrDoKQPL5EtKYZrCev/W1cHjZMqXDYNRIK7vNtM9gCZoB5XtTxlVvqbXS9e5mq53
         v4dZm5gchHWofNbVNtjXzxXGjXRLddq7Rqn6vZbJ39HdpzcXjKKzmNe2IM0XpIE5+yiE
         D+AJJcj/I3Wh4iO62z+TVFbvsB8HPeXnsNU+4K4Wx434Xj20rGg99cGYw+8tDgUn405d
         IYGpXx8nd+8WYpKK74ZnSlbEmgRyYTKqT8yrZamt5pg5fGSQsQiEW59ntFRHGoXyXQ5t
         sjsCp7KfZeKPq2yzvCr4qbL/CAUzndUo14Cuvi99sOwgiC3u0fmyuLTlGoDTzGv9ITYY
         rXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=CIj6uXerr1Bjb0No+AaAcQiVw4/PjRgv7EYhzjSEUFs=;
        b=r7axklVI3YbJ1WP5CBhhgkr3nGNHO4kQpJ6ygLMJ8yue2Abj7E5LBLP1GQFPMd8dn4
         tnw1twXZPbImqOqknIoKBEw2mEyxR4VQY0pcvfmrIam6vE86xLY/P89h4BOOGHqCNSs1
         u6N33tE8Ywe7HdIvu7dRcOjJ462J7qhkQcOT0xjZYRlYQaGH/en27adBLOkwMDryu27v
         uj6fddwOvZioTuowVaEHf+9Us1gjGbQptPgno0J3SzuhlQ7RdEvgOUfAyGZl1Mjfi5O1
         tH9UofduvKyMUKgGMtWLRxNVwi1BR/BNqDCn3YWvmyv0IN0ZZuw4+DO7v11VEBhrpkdG
         2lzw==
X-Gm-Message-State: ANhLgQ0cCJ81P0U3JXIKydN6u3P1W78iIxClGyqRuBeC/fND1jlBvENv
        wYWJk96ol50gmSkpeLq+8CO8Aw==
X-Google-Smtp-Source: ADFU+vv6CM0uIviqaGjR6KbfVffVGjgvfToavSM9QvLevnGh6yieBo9fkbjo0sz+sB7J+Be5WT3XNQ==
X-Received: by 2002:a17:902:207:: with SMTP id 7mr8969012plc.216.1585237741274;
        Thu, 26 Mar 2020 08:49:01 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id l59sm5887357pjb.2.2020.03.26.08.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 08:49:00 -0700 (PDT)
Date:   Thu, 26 Mar 2020 08:49:00 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Mar 2020 08:48:58 PDT (-0700)
Subject:     Re: [PATCH V2 3/3] rseq/selftests: Add support for riscv
In-Reply-To: <1583733592-22873-4-git-send-email-vincent.chen@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        mathieu.desnoyers@efficios.com, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, vincent.chen@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     vincent.chen@sifive.com
Message-ID: <mhng-e1457171-db30-49be-9e98-298f4d1453ed@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 08 Mar 2020 22:59:52 PDT (-0700), vincent.chen@sifive.com wrote:
> Add support for risc-v in the rseq selftests, which covers both
> 64-bit and 32-bit ISA with little endian mode.
>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> ---
>  tools/testing/selftests/rseq/param_test.c |  23 ++
>  tools/testing/selftests/rseq/rseq-riscv.h | 622 ++++++++++++++++++++++++++++++
>  tools/testing/selftests/rseq/rseq.h       |   2 +
>  3 files changed, 647 insertions(+)
>  create mode 100644 tools/testing/selftests/rseq/rseq-riscv.h

There are a ton of checkpatch errors in here.

>
> diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
> index e8a657a5f48a..4032dfaa3af2 100644
> --- a/tools/testing/selftests/rseq/param_test.c
> +++ b/tools/testing/selftests/rseq/param_test.c
> @@ -205,6 +205,29 @@ unsigned int yield_mod_cnt, nr_abort;
>  	"addiu " INJECT_ASM_REG ", -1\n\t" \
>  	"bnez " INJECT_ASM_REG ", 222b\n\t" \
>  	"333:\n\t"
> +#elif defined(__riscv)
> +
> +#define RSEQ_INJECT_INPUT \
> +	, [loop_cnt_1]"m"(loop_cnt[1]) \
> +	, [loop_cnt_2]"m"(loop_cnt[2]) \
> +	, [loop_cnt_3]"m"(loop_cnt[3]) \
> +	, [loop_cnt_4]"m"(loop_cnt[4]) \
> +	, [loop_cnt_5]"m"(loop_cnt[5]) \
> +	, [loop_cnt_6]"m"(loop_cnt[6])
> +
> +#define INJECT_ASM_REG	"t1"
> +
> +#define RSEQ_INJECT_CLOBBER \
> +	, INJECT_ASM_REG
> +
> +#define RSEQ_INJECT_ASM(n)					\
> +	"lw " INJECT_ASM_REG ", %[loop_cnt_" #n "]\n\t"		\
> +	"beqz " INJECT_ASM_REG ", 333f\n\t"			\
> +	"222:\n\t"						\
> +	"addi  " INJECT_ASM_REG "," INJECT_ASM_REG ", -1\n\t"	\
> +	"bnez " INJECT_ASM_REG ", 222b\n\t"			\
> +	"333:\n\t"
> +
>
>  #else
>  #error unsupported target
> diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/selftests/rseq/rseq-riscv.h
> new file mode 100644
> index 000000000000..56b47db4a9a4
> --- /dev/null
> +++ b/tools/testing/selftests/rseq/rseq-riscv.h
> @@ -0,0 +1,622 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +/*
> + * Select the instruction "csrw mhartid, x0" as the RSEQ_SIG. Unlike
> + * other architecture, the ebreak instruction has no immediate field for
> + * distinguishing purposes. Hence, ebreak is not suitable as RSEQ_SIG.
> + * "csrw mhartid, x0" can also satisfy the RSEQ requirement because it
> + * is an uncommon instruction and will raise an illegal instruction
> + * exception when executed in all modes.
> + */
> +
> +#if __ORDER_LITTLE_ENDIAN__ == 1234
> +#define RSEQ_SIG   0xf1401073  /* csrr mhartid, x0 */
> +#else
> +#error "Currently, RSEQ only supports Little-Endian version"
> +#endif
> +
> +#if __riscv_xlen == 64
> +#define __REG_SEL(a, b)	a
> +#elif __riscv_xlen == 32
> +#define __REG_SEL(a, b)	b
> +#endif
> +
> +#define REG_L	__REG_SEL("ld ", "lw ")
> +#define REG_S	__REG_SEL("sd ", "sw ")
> +
> +#define RISCV_FENCE(p, s) \
> +	__asm__ __volatile__ ("fence " #p "," #s : : : "memory")
> +#define rseq_smp_mb()	RISCV_FENCE(rw, rw)
> +#define rseq_smp_rmb()	RISCV_FENCE(r, r)
> +#define rseq_smp_wmb()	RISCV_FENCE(w, w)
> +#define RSEQ_ASM_TMP_REG_1	"t6"
> +#define RSEQ_ASM_TMP_REG_2	"t5"
> +#define RSEQ_ASM_TMP_REG_3	"t4"
> +#define RSEQ_ASM_TMP_REG_4	"t3"
> +
> +#define rseq_smp_load_acquire(p)					\
> +__extension__ ({							\
> +	__typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);			\
> +	RISCV_FENCE(r, rw)						\
> +	____p1;								\
> +})
> +
> +#define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_rmb()
> +
> +#define rseq_smp_store_release(p, v)					\
> +do {									\
> +	RISCV_FENCE(rw, w);						\
> +	RSEQ_WRITE_ONCE(*p, v);						\
> +} while (0)
> +
> +
> +#ifdef RSEQ_SKIP_FASTPATH
> +#include "rseq-skip.h"
> +#else /* !RSEQ_SKIP_FASTPATH */
> +
> +#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,	\
> +				post_commit_offset, abort_ip)		\
> +	".pushsection	__rseq_cs, \"aw\"\n"				\
> +	".balign	32\n"						\
> +	__rseq_str(label) ":\n"						\
> +	".long	" __rseq_str(version) ", " __rseq_str(flags) "\n"	\
> +	".quad	" __rseq_str(start_ip) ", "				\
> +			  __rseq_str(post_commit_offset) ", "		\
> +			  __rseq_str(abort_ip) "\n"			\
> +	".popsection\n\t"						\
> +	".pushsection __rseq_cs_ptr_array, \"aw\"\n"			\
> +	".quad " __rseq_str(label) "b\n"				\
> +	".popsection\n"
> +
> +#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip) \
> +	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,		 \
> +				(post_commit_ip - start_ip), abort_ip)
> +
> +
> +/*
> + * Exit points of a rseq critical section consist of all instructions outside
> + * of the critical section where a critical section can either branch to or
> + * reach through the normal course of its execution. The abort IP and the
> + * post-commit IP are already part of the __rseq_cs section and should not be
> + * explicitly defined as additional exit points. Knowing all exit points is
> + * useful to assist debuggers stepping over the critical section.
> + */
> +#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)			\
> +	".pushsection __rseq_exit_point_array, \"aw\"\n"		\
> +	".quad " __rseq_str(start_ip) ", " __rseq_str(exit_ip) "\n"	\
> +	".popsection\n"
> +
> +#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
> +	RSEQ_INJECT_ASM(1)						\
> +	"la	"RSEQ_ASM_TMP_REG_1 ", " __rseq_str(cs_label) "\n"	\
> +	REG_S	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(rseq_cs) "]\n"	\
> +	__rseq_str(label) ":\n"
> +
> +#define RSEQ_ASM_DEFINE_ABORT(label, abort_label)			\
> +	"j	222f\n"							\
> +	".balign	4\n"						\
> +	".long "	__rseq_str(RSEQ_SIG) "\n"			\
> +	__rseq_str(label) ":\n"						\
> +	"j	%l[" __rseq_str(abort_label) "]\n"			\
> +	"222:\n"
> +
> +#define RSEQ_ASM_OP_STORE(value, var)					\
> +	REG_S	"%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n"
> +
> +#define RSEQ_ASM_OP_CMPEQ(var, expect, label)				\
> +	REG_L	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"		\
> +	"bne	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
> +		  __rseq_str(label) "\n"
> +
> +#define RSEQ_ASM_OP_CMPEQ32(var, expect, label)				\
> +	"lw	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"	\
> +	"bne	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
> +		  __rseq_str(label) "\n"
> +
> +#define RSEQ_ASM_OP_CMPNE(var, expect, label)				\
> +	REG_L	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"		\
> +	"beq	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
> +		  __rseq_str(label) "\n"
> +
> +#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
> +	RSEQ_INJECT_ASM(2)						\
> +	RSEQ_ASM_OP_CMPEQ32(current_cpu_id, cpu_id, label)
> +
> +#define RSEQ_ASM_OP_R_LOAD(var)						\
> +	REG_L	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"
> +
> +#define RSEQ_ASM_OP_R_STORE(var)					\
> +	REG_S	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"
> +
> +#define RSEQ_ASM_OP_R_LOAD_OFF(offset)					\
> +	"add	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(offset) "], "	\
> +		 RSEQ_ASM_TMP_REG_1 "\n"				\
> +	REG_L	RSEQ_ASM_TMP_REG_1 ", (" RSEQ_ASM_TMP_REG_1 ")\n"
> +
> +#define RSEQ_ASM_OP_R_ADD(count)					\
> +	"add	"RSEQ_ASM_TMP_REG_1 ", " RSEQ_ASM_TMP_REG_1		\
> +		", %[" __rseq_str(count) "]\n"
> +
> +#define RSEQ_ASM_OP_FINAL_STORE(value, var, post_commit_label)		\
> +	RSEQ_ASM_OP_STORE(value, var)					\
> +	__rseq_str(post_commit_label) ":\n"
> +
> +#define RSEQ_ASM_OP_FINAL_STORE_RELEASE(value, var, post_commit_label)	\
> +	"fence	rw, w\n"						\
> +	RSEQ_ASM_OP_STORE(value, var)					\
> +	__rseq_str(post_commit_label) ":\n"
> +
> +#define RSEQ_ASM_OP_R_FINAL_STORE(var, post_commit_label)		\
> +	REG_S	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"		\
> +	__rseq_str(post_commit_label) ":\n"
> +
> +#define RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)				\
> +	"beqz	%[" __rseq_str(len) "], 333f\n"				\
> +	"mv	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(len) "]\n"	\
> +	"mv	" RSEQ_ASM_TMP_REG_2 ", %[" __rseq_str(src) "]\n"	\
> +	"mv	" RSEQ_ASM_TMP_REG_3 ", %[" __rseq_str(dst) "]\n"	\
> +	"222:\n"							\
> +	"lb	" RSEQ_ASM_TMP_REG_4 ", 0(" RSEQ_ASM_TMP_REG_2 ")\n"	\
> +	"sb	" RSEQ_ASM_TMP_REG_4 ", 0(" RSEQ_ASM_TMP_REG_3 ")\n"	\
> +	"addi	" RSEQ_ASM_TMP_REG_1 ", " RSEQ_ASM_TMP_REG_1 ", -1\n"	\
> +	"addi	" RSEQ_ASM_TMP_REG_2 ", " RSEQ_ASM_TMP_REG_2 ", 1\n"	\
> +	"addi	" RSEQ_ASM_TMP_REG_3 ", " RSEQ_ASM_TMP_REG_3 ", 1\n"	\
> +	"bnez	" RSEQ_ASM_TMP_REG_1 ", 222b\n"				\
> +	"333:\n"
> +
> +static inline __attribute__((always_inline))
> +int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
> +{
> +	RSEQ_INJECT_C(9)
> +
> +	__asm__ __volatile__ goto (
> +		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
> +#endif
> +		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
> +		RSEQ_INJECT_ASM(3)
> +		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
> +		RSEQ_INJECT_ASM(4)
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
> +		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
> +#endif
> +		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
> +		RSEQ_INJECT_ASM(5)
> +		RSEQ_ASM_DEFINE_ABORT(4, abort)
> +		: /* gcc asm goto does not allow outputs */
> +		: [cpu_id]		"r" (cpu),
> +		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
> +		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
> +		  [v]			"m" (*v),
> +		  [expect]		"r" (expect),
> +		  [newv]		"r" (newv)
> +		  RSEQ_INJECT_INPUT
> +		: "memory", RSEQ_ASM_TMP_REG_1
> +		: abort, cmpfail
> +#ifdef RSEQ_COMPARE_TWICE
> +		  , error1, error2
> +#endif
> +	);
> +
> +	return 0;
> +abort:
> +	RSEQ_INJECT_FAILED
> +	return -1;
> +cmpfail:
> +	return 1;
> +#ifdef RSEQ_COMPARE_TWICE
> +error1:
> +	rseq_bug("cpu_id comparison failed");
> +error2:
> +	rseq_bug("expected value comparison failed");
> +#endif
> +}
> +
> +static inline __attribute__((always_inline))
> +int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
> +			       off_t voffp, intptr_t *load, int cpu)
> +{
> +	RSEQ_INJECT_C(9)
> +
> +	__asm__ __volatile__ goto (
> +		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
> +#endif
> +		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
> +		RSEQ_INJECT_ASM(3)
> +		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[cmpfail])
> +		RSEQ_INJECT_ASM(4)
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
> +		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[error2])
> +#endif
> +		RSEQ_ASM_OP_R_LOAD(v)
> +		RSEQ_ASM_OP_R_STORE(load)
> +		RSEQ_ASM_OP_R_LOAD_OFF(voffp)
> +		RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
> +		RSEQ_INJECT_ASM(5)
> +		RSEQ_ASM_DEFINE_ABORT(4, abort)
> +		: /* gcc asm goto does not allow outputs */
> +		: [cpu_id]		"r" (cpu),
> +		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
> +		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
> +		  [v]			"m" (*v),
> +		  [expectnot]		"r" (expectnot),
> +		  [load]		"m" (*load),
> +		  [voffp]		"r" (voffp)
> +		  RSEQ_INJECT_INPUT
> +		: "memory", RSEQ_ASM_TMP_REG_1
> +		: abort, cmpfail
> +#ifdef RSEQ_COMPARE_TWICE
> +		  , error1, error2
> +#endif
> +	);
> +	return 0;
> +abort:
> +	RSEQ_INJECT_FAILED
> +	return -1;
> +cmpfail:
> +	return 1;
> +#ifdef RSEQ_COMPARE_TWICE
> +error1:
> +	rseq_bug("cpu_id comparison failed");
> +error2:
> +	rseq_bug("expected value comparison failed");
> +#endif
> +}
> +
> +static inline __attribute__((always_inline))
> +int rseq_addv(intptr_t *v, intptr_t count, int cpu)
> +{
> +	RSEQ_INJECT_C(9)
> +
> +	__asm__ __volatile__ goto (
> +		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
> +#endif
> +		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
> +		RSEQ_INJECT_ASM(3)
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
> +#endif
> +		RSEQ_ASM_OP_R_LOAD(v)
> +		RSEQ_ASM_OP_R_ADD(count)
> +		RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
> +		RSEQ_INJECT_ASM(4)
> +		RSEQ_ASM_DEFINE_ABORT(4, abort)
> +		: /* gcc asm goto does not allow outputs */
> +		: [cpu_id]		"r" (cpu),
> +		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
> +		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
> +		  [v]			"m" (*v),
> +		  [count]		"r" (count)
> +		  RSEQ_INJECT_INPUT
> +		: "memory", RSEQ_ASM_TMP_REG_1
> +		: abort
> +#ifdef RSEQ_COMPARE_TWICE
> +		  , error1
> +#endif
> +	);
> +	return 0;
> +abort:
> +	RSEQ_INJECT_FAILED
> +	return -1;
> +#ifdef RSEQ_COMPARE_TWICE
> +error1:
> +	rseq_bug("cpu_id comparison failed");
> +#endif
> +}
> +
> +static inline __attribute__((always_inline))
> +int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
> +				 intptr_t *v2, intptr_t newv2,
> +				 intptr_t newv, int cpu)
> +{
> +	RSEQ_INJECT_C(9)
> +
> +	__asm__ __volatile__ goto (
> +		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
> +#endif
> +		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
> +		RSEQ_INJECT_ASM(3)
> +		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
> +		RSEQ_INJECT_ASM(4)
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
> +		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
> +#endif
> +		RSEQ_ASM_OP_STORE(newv2, v2)
> +		RSEQ_INJECT_ASM(5)
> +		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
> +		RSEQ_INJECT_ASM(6)
> +		RSEQ_ASM_DEFINE_ABORT(4, abort)
> +		: /* gcc asm goto does not allow outputs */
> +		: [cpu_id]		"r" (cpu),
> +		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
> +		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
> +		  [expect]		"r" (expect),
> +		  [v]			"m" (*v),
> +		  [newv]		"r" (newv),
> +		  [v2]			"m" (*v2),
> +		  [newv2]		"r" (newv2)
> +		  RSEQ_INJECT_INPUT
> +		: "memory", RSEQ_ASM_TMP_REG_1
> +		: abort, cmpfail
> +#ifdef RSEQ_COMPARE_TWICE
> +		  , error1, error2
> +#endif
> +	);
> +
> +	return 0;
> +abort:
> +	RSEQ_INJECT_FAILED
> +	return -1;
> +cmpfail:
> +	return 1;
> +#ifdef RSEQ_COMPARE_TWICE
> +error1:
> +	rseq_bug("cpu_id comparison failed");
> +error2:
> +	rseq_bug("expected value comparison failed");
> +#endif
> +}
> +
> +static inline __attribute__((always_inline))
> +int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
> +					 intptr_t *v2, intptr_t newv2,
> +					 intptr_t newv, int cpu)
> +{
> +	RSEQ_INJECT_C(9)
> +
> +	__asm__ __volatile__ goto (
> +		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
> +#endif
> +		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
> +		RSEQ_INJECT_ASM(3)
> +		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
> +		RSEQ_INJECT_ASM(4)
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
> +		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
> +#endif
> +		RSEQ_ASM_OP_STORE(newv2, v2)
> +		RSEQ_INJECT_ASM(5)
> +		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
> +		RSEQ_INJECT_ASM(6)
> +		RSEQ_ASM_DEFINE_ABORT(4, abort)
> +		: /* gcc asm goto does not allow outputs */
> +		: [cpu_id]		"r" (cpu),
> +		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
> +		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
> +		  [expect]		"r" (expect),
> +		  [v]			"m" (*v),
> +		  [newv]		"r" (newv),
> +		  [v2]			"m" (*v2),
> +		  [newv2]		"r" (newv2)
> +		  RSEQ_INJECT_INPUT
> +		: "memory", RSEQ_ASM_TMP_REG_1
> +		: abort, cmpfail
> +#ifdef RSEQ_COMPARE_TWICE
> +		  , error1, error2
> +#endif
> +	);
> +
> +	return 0;
> +abort:
> +	RSEQ_INJECT_FAILED
> +	return -1;
> +cmpfail:
> +	return 1;
> +#ifdef RSEQ_COMPARE_TWICE
> +error1:
> +	rseq_bug("cpu_id comparison failed");
> +error2:
> +	rseq_bug("expected value comparison failed");
> +#endif
> +}
> +
> +static inline __attribute__((always_inline))
> +int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
> +			      intptr_t *v2, intptr_t expect2,
> +			      intptr_t newv, int cpu)
> +{
> +	RSEQ_INJECT_C(9)
> +
> +	__asm__ __volatile__ goto (
> +		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error3])
> +#endif
> +		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
> +		RSEQ_INJECT_ASM(3)
> +		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
> +		RSEQ_INJECT_ASM(4)
> +		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[cmpfail])
> +		RSEQ_INJECT_ASM(5)
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
> +		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
> +		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[error3])
> +#endif
> +		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
> +		RSEQ_INJECT_ASM(6)
> +		RSEQ_ASM_DEFINE_ABORT(4, abort)
> +		: /* gcc asm goto does not allow outputs */
> +		: [cpu_id]		"r" (cpu),
> +		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
> +		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
> +		  [v]			"m" (*v),
> +		  [expect]		"r" (expect),
> +		  [v2]			"m" (*v2),
> +		  [expect2]		"r" (expect2),
> +		  [newv]		"r" (newv)
> +		  RSEQ_INJECT_INPUT
> +		: "memory", RSEQ_ASM_TMP_REG_1
> +		: abort, cmpfail
> +#ifdef RSEQ_COMPARE_TWICE
> +		  , error1, error2, error3
> +#endif
> +	);
> +
> +	return 0;
> +abort:
> +	RSEQ_INJECT_FAILED
> +	return -1;
> +cmpfail:
> +	return 1;
> +#ifdef RSEQ_COMPARE_TWICE
> +error1:
> +	rseq_bug("cpu_id comparison failed");
> +error2:
> +	rseq_bug("expected value comparison failed");
> +error3:
> +	rseq_bug("2nd expected value comparison failed");
> +#endif
> +}
> +
> +static inline __attribute__((always_inline))
> +int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
> +				 void *dst, void *src, size_t len,
> +				 intptr_t newv, int cpu)
> +{
> +	RSEQ_INJECT_C(9)
> +	__asm__ __volatile__ goto (
> +		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
> +#endif
> +		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
> +		RSEQ_INJECT_ASM(3)
> +		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
> +		RSEQ_INJECT_ASM(4)
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
> +		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
> +#endif
> +		RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
> +		RSEQ_INJECT_ASM(5)
> +		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
> +		RSEQ_INJECT_ASM(6)
> +		RSEQ_ASM_DEFINE_ABORT(4, abort)
> +		: /* gcc asm goto does not allow outputs */
> +		: [cpu_id]		"r" (cpu),
> +		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
> +		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
> +		  [expect]		"r" (expect),
> +		  [v]			"m" (*v),
> +		  [newv]		"r" (newv),
> +		  [dst]			"r" (dst),
> +		  [src]			"r" (src),
> +		  [len]			"r" (len)
> +		  RSEQ_INJECT_INPUT
> +		: "memory", RSEQ_ASM_TMP_REG_1, RSEQ_ASM_TMP_REG_2,
> +		  RSEQ_ASM_TMP_REG_3, RSEQ_ASM_TMP_REG_4
> +		: abort, cmpfail
> +#ifdef RSEQ_COMPARE_TWICE
> +		  , error1, error2
> +#endif
> +	);
> +
> +	return 0;
> +abort:
> +	RSEQ_INJECT_FAILED
> +	return -1;
> +cmpfail:
> +	return 1;
> +#ifdef RSEQ_COMPARE_TWICE
> +error1:
> +	rseq_bug("cpu_id comparison failed");
> +error2:
> +	rseq_bug("expected value comparison failed");
> +#endif
> +}
> +
> +static inline __attribute__((always_inline))
> +int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
> +					 void *dst, void *src, size_t len,
> +					 intptr_t newv, int cpu)
> +{
> +	RSEQ_INJECT_C(9)
> +
> +	__asm__ __volatile__ goto (
> +		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
> +		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
> +#endif
> +		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
> +		RSEQ_INJECT_ASM(3)
> +		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
> +		RSEQ_INJECT_ASM(4)
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
> +		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
> +#endif
> +		RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
> +		RSEQ_INJECT_ASM(5)
> +		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
> +		RSEQ_INJECT_ASM(6)
> +		RSEQ_ASM_DEFINE_ABORT(4, abort)
> +		: /* gcc asm goto does not allow outputs */
> +		: [cpu_id]		"r" (cpu),
> +		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
> +		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
> +		  [expect]		"r" (expect),
> +		  [v]			"m" (*v),
> +		  [newv]		"r" (newv),
> +		  [dst]			"r" (dst),
> +		  [src]			"r" (src),
> +		  [len]			"r" (len)
> +		  RSEQ_INJECT_INPUT
> +		: "memory", RSEQ_ASM_TMP_REG_1, RSEQ_ASM_TMP_REG_2,
> +		  RSEQ_ASM_TMP_REG_3, RSEQ_ASM_TMP_REG_4
> +		: abort, cmpfail
> +#ifdef RSEQ_COMPARE_TWICE
> +		  , error1, error2
> +#endif
> +	);
> +
> +	return 0;
> +abort:
> +	RSEQ_INJECT_FAILED
> +	return -1;
> +cmpfail:
> +	return 1;
> +#ifdef RSEQ_COMPARE_TWICE
> +error1:
> +	rseq_bug("cpu_id comparison failed");
> +error2:
> +	rseq_bug("expected value comparison failed");
> +#endif
> +}
> +
> +#endif /* !RSEQ_SKIP_FASTPATH */
> diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
> index 3f63eb362b92..72efb6d3d84e 100644
> --- a/tools/testing/selftests/rseq/rseq.h
> +++ b/tools/testing/selftests/rseq/rseq.h
> @@ -79,6 +79,8 @@ extern int __rseq_handled;
>  #include <rseq-mips.h>
>  #elif defined(__s390__)
>  #include <rseq-s390.h>
> +#elif defined(__riscv)
> +#include <rseq-riscv.h>
>  #else
>  #error unsupported target
>  #endif
