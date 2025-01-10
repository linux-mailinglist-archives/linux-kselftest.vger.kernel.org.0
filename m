Return-Path: <linux-kselftest+bounces-24200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69785A08DC9
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 11:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878C13A613B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 10:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB25120B1E7;
	Fri, 10 Jan 2025 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evp6NgPf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3507B20B7F2;
	Fri, 10 Jan 2025 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504601; cv=none; b=CetZhxV0rHNJzIwJn4HBOdJnvk8ypZwL+RyQzWAG6yhxhVCOMpcsFeSx+FZZdG/UhKsWhQrTKWbN1xjtg9FaUGtOEzA7wM7fHJqzxbWKNGtMYxYILcV7MQwT77KCSj0tqagV2NOxdrqdJejZBXz7tTqBGeco3x5sULzkxwFbAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504601; c=relaxed/simple;
	bh=a/72uSPB4ZTJTaM0Bf7SjhoTZ+uD94KV1uVc46scwOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvxZdQyMZxEoy97usobvUE+ip7h1MtJAZwQ+S6ELnU8cBBthnT72ut0Z5zY6CoO7hxvrkv8jHvyrafpMqm8WaGv+JH0ljYDoHGl1fWbwGgCzKVfZOYqGHvgGF97rBl7VJB/jje81aGyuEFTCl+1j8gTrPTLtvU9V0olUtXNBGUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Evp6NgPf; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3862f32a33eso858056f8f.3;
        Fri, 10 Jan 2025 02:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736504596; x=1737109396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5shvG4armb2rxobyXIMn9KuV88hUTyCppJfh8L9ay4=;
        b=Evp6NgPfW2wpYI9u7Cqqaf2X1mTLzQJzsYLCcEonbKDL2gC8uzk0vFCb563yU3iD/0
         HVGmDsrTqwCIXTwb/hXOrV5SmJTb60mICBHBMLzsqxtdVvkYIvTPr4epJCNw8IUZIrxe
         R+iG1KY9oK+VAspr1Hrnvc7o3QPCiiNFG37HxD78QkqsGPZ2U+xQI5MWs29eu/102aZk
         yp/d4PDqsPt7QLkmLK0wRYO3f4r5GgNip+YeQlk4ptRFH06IAAm1pVxzR276OAZRluiN
         BCKyNoRZpod7GGGtTFt13fbqJnQ8zR7YK+Ig4TUZ6cpOMqUCUZM5ScqtIQXXHZalbgxE
         KGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504596; x=1737109396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5shvG4armb2rxobyXIMn9KuV88hUTyCppJfh8L9ay4=;
        b=ViICx2z6YBykmq5EB6JDmplr2ZS+oH6UN1nopJ2msQ5r7M7YjYB9Tw8VvcmqxGRkw4
         CmoKW0Jx1+zPc2ewy8DKdn2PM/B0yZbtuY/hMKAqpJFAd08WXr2ajAOwCIb+LKiugLeC
         vxmhL9+VZ8V1W4f2YXe1gHmTeQFHckeOXA8gsXjgpnThIro41p3P2fnxV9dsPhBGHVIu
         J4TTnINEAdv6k3D2OqFhIVnYCXx42ybiIfle7IFqQWGqDQX+4K/CDoXrvpBCM/Kxqz/p
         i5EN1GfdOEZwSyS1oSkxlHiJIwT2snok9qpcJ/MN2gB7XewJbQXen5PXOhECwtSnjSJM
         FwwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHM5ylQbVsl968K4SLQDrk3+fGI+MmexhtSYZjQij/X4b/ESi0skUzRpLr/bsAVHWtUKg4lZl9TyFb08xAW4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS44C145tfEx7X6c+AQt45P8KZJoI+0/MN5CbfufHgH/iNo4mO
	YnYvuzPfmZaM1bdhahynfvNdpW3OfONoRYrU2CfPZJWvCKt2L2PGhzzXXyr5
X-Gm-Gg: ASbGncsCjUoDv/S5sPi2IC6Eb85SvbgOGF2HahdMRExtJY2P3RJZ5nfzoV59m7o0LAX
	2DL3EX33UftFWnV9VhaYTZnqsF5N/4h7Oz/TblvybljV7qiyAlDS9qGjRbFu/UGWB4QDmyfcR1o
	z67ZNixuE6wqnme7nkp1liMzzuLVQFOCHaH/plwhiThw6N+3ZxdZWt/ekRVkqwxLzc5B9hF1VXO
	9bJ2ZYc4qoHz1UxwWD2xIQHdCb79n8mgoX/sH7o98Vx/tOXPcMYiIiUDMlm6xgdIPU45cyKLpCg
	/9xjDcH7PpGbEmv4h4Jd
X-Google-Smtp-Source: AGHT+IFFepbWjSpQqoRmacy6FSlB5xc5ZNL5tjURGv/3dmKIsvK1wKg1Uay4tINID8i9ofyr3JPhlQ==
X-Received: by 2002:a5d:5886:0:b0:385:f840:e613 with SMTP id ffacd0b85a97d-38a87356509mr9718208f8f.51.1736504595847;
        Fri, 10 Jan 2025 02:23:15 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e37c2esm47484775e9.28.2025.01.10.02.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:23:14 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/3] rseq/selftests: Add support for OpenRISC
Date: Fri, 10 Jan 2025 10:22:45 +0000
Message-ID: <20250110102248.3295944-4-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250110102248.3295944-1-shorne@gmail.com>
References: <20250110102248.3295944-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for OpenRISC in the rseq selftests.  OpenRISC is 32-bit
only.

Tested this with:

    Compiler:  gcc version 14.2.0 (GCC)
    Binutils:  GNU assembler version 2.43.1 (or1k-smh-linux-gnu) using BFD version (GNU Binutils) 2.43.1.20241207
    Linux:     Linux buildroot 6.13.0-rc2-00005-g1fa73dd6c2d3-dirty #213 SMP Sat Dec 28 22:18:39 GMT 2024 openrisc GNU/Linux
    Glibc:     2024-12-13 e4e49583d9 Stafford Horne   or1k: Update libm-test-ulps

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 tools/testing/selftests/rseq/param_test.c     |  24 +
 tools/testing/selftests/rseq/rseq-or1k-bits.h | 412 ++++++++++++++++++
 .../selftests/rseq/rseq-or1k-thread-pointer.h |  13 +
 tools/testing/selftests/rseq/rseq-or1k.h      | 181 ++++++++
 .../selftests/rseq/rseq-thread-pointer.h      |   2 +
 tools/testing/selftests/rseq/rseq.h           |   2 +
 6 files changed, 634 insertions(+)
 create mode 100644 tools/testing/selftests/rseq/rseq-or1k-bits.h
 create mode 100644 tools/testing/selftests/rseq/rseq-or1k-thread-pointer.h
 create mode 100644 tools/testing/selftests/rseq/rseq-or1k.h

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 2f37961240ca..05d03e679e06 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -226,8 +226,32 @@ unsigned int yield_mod_cnt, nr_abort;
 	"addi  " INJECT_ASM_REG "," INJECT_ASM_REG ", -1\n\t"	\
 	"bnez " INJECT_ASM_REG ", 222b\n\t"			\
 	"333:\n\t"
+#elif defined(__or1k__)
 
+#define RSEQ_INJECT_INPUT \
+	, [loop_cnt_1]"m"(loop_cnt[1]) \
+	, [loop_cnt_2]"m"(loop_cnt[2]) \
+	, [loop_cnt_3]"m"(loop_cnt[3]) \
+	, [loop_cnt_4]"m"(loop_cnt[4]) \
+	, [loop_cnt_5]"m"(loop_cnt[5]) \
+	, [loop_cnt_6]"m"(loop_cnt[6])
 
+#define INJECT_ASM_REG	"r31"
+
+#define RSEQ_INJECT_CLOBBER \
+	, INJECT_ASM_REG
+
+#define RSEQ_INJECT_ASM(n)					\
+	"l.lwz   " INJECT_ASM_REG ", %[loop_cnt_" #n "]\n\t"	\
+	"l.sfeqi " INJECT_ASM_REG ", 0\n\t"			\
+	"l.bf 333f\n\t"						\
+	" l.nop\n\t"						\
+	"222:\n\t"						\
+	"l.addi  " INJECT_ASM_REG "," INJECT_ASM_REG ", -1\n\t"	\
+	"l.sfeqi " INJECT_ASM_REG ", 0\n\t"			\
+	"l.bf 222f\n\t"						\
+	" l.nop\n\t"						\
+	"333:\n\t"
 #else
 #error unsupported target
 #endif
diff --git a/tools/testing/selftests/rseq/rseq-or1k-bits.h b/tools/testing/selftests/rseq/rseq-or1k-bits.h
new file mode 100644
index 000000000000..15d0e8200cd1
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-or1k-bits.h
@@ -0,0 +1,412 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+
+#include "rseq-bits-template.h"
+
+#if defined(RSEQ_TEMPLATE_MO_RELAXED) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_storev)(intptr_t *v, intptr_t expect, intptr_t newv,
+				int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
+#endif
+				  RSEQ_ASM_OP_FINAL_STORE(v, newv, 3)
+				  RSEQ_INJECT_ASM(5)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [v]			"m" (*v),
+				    [expect]		"r" (expect),
+				    [newv]		"r" (newv)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2
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
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpnev_storeoffp_load)(intptr_t *v, intptr_t expectnot,
+			       off_t voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPNE(v, expectnot, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPNE(v, expectnot, "%l[error2]")
+#endif
+				  RSEQ_ASM_OP_R_LOAD(v)
+				  RSEQ_ASM_OP_R_STORE(load)
+				  RSEQ_ASM_OP_R_LOAD_OFF(voffp)
+				  RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+				  RSEQ_INJECT_ASM(5)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [v]			"m" (*v),
+				    [expectnot]		"r" (expectnot),
+				    [load]		"m" (*load),
+				    [voffp]		"Ir" (voffp)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2
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
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_addv)(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+#endif
+				  RSEQ_ASM_OP_R_LOAD(v)
+				  RSEQ_ASM_OP_R_ADD(count)
+				  RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+				  RSEQ_INJECT_ASM(4)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [v]			"m" (*v),
+				    [count]		"r" (count)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1
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
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_cmpeqv_storev)(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error3]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+				  RSEQ_ASM_OP_CMPEQ(v2, expect2, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
+				  RSEQ_ASM_OP_CMPEQ(v2, expect2, "%l[error3]")
+#endif
+				  RSEQ_ASM_OP_FINAL_STORE(v, newv, 3)
+				  RSEQ_INJECT_ASM(6)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [v]			"m" (*v),
+				    [expect]		"r" (expect),
+				    [v2]		"m" (*v2),
+				    [expect2]		"r" (expect2),
+				    [newv]		"r" (newv)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2, error3
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
+#define RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+
+/*
+ *   pval = *(ptr+off)
+ *  *pval += inc;
+ */
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_offset_deref_addv)(intptr_t *ptr, off_t off, intptr_t inc,
+				int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+#endif
+				  RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, inc, 3)
+				  RSEQ_INJECT_ASM(4)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [ptr]		"r" (ptr),
+				    [off]		"r" (off),
+				    [inc]		"r" (inc)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1
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
+#endif /* #if defined(RSEQ_TEMPLATE_MO_RELAXED) &&
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+
+#if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trystorev_storev)(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
+#endif
+				  RSEQ_ASM_OP_STORE(v2, newv2)
+				  RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+				  RSEQ_ASM_OP_FINAL_STORE_RELEASE(v, newv, 3)
+#else
+				  RSEQ_ASM_OP_FINAL_STORE(v, newv, 3)
+#endif
+				  RSEQ_INJECT_ASM(6)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [expect]		"r" (expect),
+				    [v]			"m" (*v),
+				    [newv]		"r" (newv),
+				    [v2]		"m" (*v2),
+				    [newv2]		"r" (newv2)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2
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
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
+#endif
+				  RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
+				  RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+				  RSEQ_ASM_OP_FINAL_STORE_RELEASE(v, newv, 3)
+#else
+				  RSEQ_ASM_OP_FINAL_STORE(v, newv, 3)
+#endif
+				  RSEQ_INJECT_ASM(6)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [expect]		"r" (expect),
+				    [v]			"m" (*v),
+				    [newv]		"r" (newv),
+				    [dst]		"r" (dst),
+				    [src]		"r" (src),
+				    [len]		"r" (len)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1, RSEQ_ASM_TMP_REG_2,
+				    RSEQ_ASM_TMP_REG_3, RSEQ_ASM_TMP_REG_4
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2
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
+#endif /* #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) &&
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+
+#include "rseq-bits-reset.h"
diff --git a/tools/testing/selftests/rseq/rseq-or1k-thread-pointer.h b/tools/testing/selftests/rseq/rseq-or1k-thread-pointer.h
new file mode 100644
index 000000000000..cda740f7aff3
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-or1k-thread-pointer.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: LGPL-2.1-only OR MIT */
+#ifndef _RSEQ_OR1K_THREAD_POINTER
+#define _RSEQ_OR1K_THREAD_POINTER
+
+static inline void *rseq_thread_pointer(void)
+{
+	void *__thread_register;
+
+	__asm__ ("l.or %0, r10, r0" : "=r" (__thread_register));
+	return __thread_register;
+}
+
+#endif
diff --git a/tools/testing/selftests/rseq/rseq-or1k.h b/tools/testing/selftests/rseq/rseq-or1k.h
new file mode 100644
index 000000000000..9e78eebdf79a
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-or1k.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+
+/*
+ * Select the instruction "l.nop 0x35" as the RSEQ_SIG.
+ */
+#define RSEQ_SIG   0x15000035
+
+#define rseq_smp_mb()	__asm__ __volatile__ ("l.msync" ::: "memory")
+#define rseq_smp_rmb()	rseq_smp_mb()
+#define rseq_smp_wmb()	rseq_smp_mb()
+#define RSEQ_ASM_TMP_REG_1	"r31"
+#define RSEQ_ASM_TMP_REG_2	"r29"
+#define RSEQ_ASM_TMP_REG_3	"r27"
+#define RSEQ_ASM_TMP_REG_4	"r25"
+
+#define rseq_smp_load_acquire(p)					\
+__extension__ ({							\
+	rseq_unqual_scalar_typeof(*(p)) ____p1 = RSEQ_READ_ONCE(*(p));	\
+	rseq_smp_mb();							\
+	____p1;								\
+})
+
+#define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_rmb()
+
+#define rseq_smp_store_release(p, v)					\
+do {									\
+	rseq_smp_mb();							\
+	RSEQ_WRITE_ONCE(*(p), v);					\
+} while (0)
+
+#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,	\
+				post_commit_offset, abort_ip)		\
+	".pushsection	__rseq_cs, \"aw\"\n"				\
+	".balign	32\n"						\
+	__rseq_str(label) ":\n"						\
+	".long " __rseq_str(version) ", " __rseq_str(flags) "\n"	\
+	".long 0x0, " __rseq_str(start_ip) ", "				\
+		"0x0, " __rseq_str(post_commit_offset) ", "		\
+		"0x0, " __rseq_str(abort_ip) "\n"			\
+	".popsection\n\t"						\
+	".pushsection __rseq_cs_ptr_array, \"aw\"\n"			\
+	".long 0x0, " __rseq_str(label) "b\n"				\
+	".popsection\n"
+
+#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip) \
+	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,		 \
+				((post_commit_ip) - (start_ip)), abort_ip)
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
+	".long 0x0, " __rseq_str(start_ip) ", 0x0, " __rseq_str(exit_ip) "\n"	\
+	".popsection\n"
+
+#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
+	RSEQ_INJECT_ASM(1)						\
+	"l.movhi " RSEQ_ASM_TMP_REG_1 ", hi(" __rseq_str(cs_label) ")\n"\
+	"l.ori   " RSEQ_ASM_TMP_REG_1 ", " RSEQ_ASM_TMP_REG_1		\
+		", lo(" __rseq_str(cs_label) ")\n"\
+	"l.sw  %[" __rseq_str(rseq_cs) "], " RSEQ_ASM_TMP_REG_1 "\n"	\
+	__rseq_str(label) ":\n"
+
+#define RSEQ_ASM_DEFINE_ABORT(label, abort_label)			\
+	"l.j 222f\n"							\
+	" l.nop\n"							\
+	".balign	4\n"						\
+	".long "	__rseq_str(RSEQ_SIG) "\n"			\
+	__rseq_str(label) ":\n"						\
+	"l.j %l[" __rseq_str(abort_label) "]\n"				\
+	" l.nop\n"							\
+	"222:\n"
+
+#define RSEQ_ASM_OP_STORE(var, value)					\
+	"l.sw %[" __rseq_str(var) "], %[" __rseq_str(value) "]\n"
+
+#define RSEQ_ASM_OP_CMPEQ(var, expect, label)				\
+	"l.lwz  " RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"	\
+	"l.sfne " RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "]\n"	\
+	"l.bf   " __rseq_str(label) "\n"				\
+	" l.nop\n"
+
+#define RSEQ_ASM_OP_CMPNE(var, expect, label)				\
+	"l.lwz  " RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"	\
+	"l.sfeq " RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "]\n"	\
+	"l.bf   " __rseq_str(label) "\n"				\
+	" l.nop\n"
+
+#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
+	RSEQ_INJECT_ASM(2)						\
+	RSEQ_ASM_OP_CMPEQ(current_cpu_id, cpu_id, label)
+
+#define RSEQ_ASM_OP_R_LOAD(var)						\
+	"l.lwz " RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"
+
+#define RSEQ_ASM_OP_R_STORE(var)					\
+	"l.sw %[" __rseq_str(var) "], " RSEQ_ASM_TMP_REG_1 "\n"
+
+#define RSEQ_ASM_OP_R_LOAD_OFF(offset)					\
+	"l.lwz " RSEQ_ASM_TMP_REG_1 ", "				\
+		"%[" __rseq_str(offset) "](" RSEQ_ASM_TMP_REG_1 ")\n"
+
+#define RSEQ_ASM_OP_R_ADD(count)					\
+	"l.add " RSEQ_ASM_TMP_REG_1 ", " RSEQ_ASM_TMP_REG_1		\
+		", %[" __rseq_str(count) "]\n"
+
+#define RSEQ_ASM_OP_FINAL_STORE(var, value, post_commit_label)		\
+	RSEQ_ASM_OP_STORE(var, value)					\
+	__rseq_str(post_commit_label) ":\n"
+
+#define RSEQ_ASM_OP_FINAL_STORE_RELEASE(var, value, post_commit_label)	\
+	"l.msync\n"							\
+	RSEQ_ASM_OP_STORE(var, value)					\
+	__rseq_str(post_commit_label) ":\n"
+
+#define RSEQ_ASM_OP_R_FINAL_STORE(var, post_commit_label)		\
+	"l.sw %[" __rseq_str(var) "], " RSEQ_ASM_TMP_REG_1 "\n"		\
+	__rseq_str(post_commit_label) ":\n"
+
+#define RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)				\
+	"l.sfeq	%[" __rseq_str(len) "], r0\n"				\
+	"l.bf 333f\n"							\
+	" l.nop\n"							\
+	"l.ori  " RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(len) "], 0\n"	\
+	"l.ori  " RSEQ_ASM_TMP_REG_2 ", %[" __rseq_str(src) "], 0\n"	\
+	"l.ori  " RSEQ_ASM_TMP_REG_3 ", %[" __rseq_str(dst) "], 0\n"	\
+	"222:\n"							\
+	"l.lbz  " RSEQ_ASM_TMP_REG_4 ", 0(" RSEQ_ASM_TMP_REG_2 ")\n"	\
+	"l.sb   0(" RSEQ_ASM_TMP_REG_3 "), " RSEQ_ASM_TMP_REG_4 "\n"	\
+	"l.addi " RSEQ_ASM_TMP_REG_1 ", " RSEQ_ASM_TMP_REG_1 ", -1\n"	\
+	"l.addi " RSEQ_ASM_TMP_REG_2 ", " RSEQ_ASM_TMP_REG_2 ", 1\n"	\
+	"l.addi " RSEQ_ASM_TMP_REG_3 ", " RSEQ_ASM_TMP_REG_3 ", 1\n"	\
+	"l.sfne " RSEQ_ASM_TMP_REG_1 ", r0\n"				\
+	"l.bf 222b\n"							\
+	" l.nop\n"							\
+	"333:\n"
+
+#define RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, inc, post_commit_label)	\
+	"l.ori  " RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(ptr) "], 0\n"	\
+	RSEQ_ASM_OP_R_ADD(off)						\
+	"l.lwz  " RSEQ_ASM_TMP_REG_1 ", 0(" RSEQ_ASM_TMP_REG_1 ")\n"	\
+	RSEQ_ASM_OP_R_ADD(inc)						\
+	__rseq_str(post_commit_label) ":\n"
+
+/* Per-cpu-id indexing. */
+
+#define RSEQ_TEMPLATE_CPU_ID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-or1k-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-or1k-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_CPU_ID
+
+/* Per-mm-cid indexing. */
+
+#define RSEQ_TEMPLATE_MM_CID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-or1k-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-or1k-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_MM_CID
+
+/* APIs which are not based on cpu ids. */
+
+#define RSEQ_TEMPLATE_CPU_ID_NONE
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-or1k-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+#undef RSEQ_TEMPLATE_CPU_ID_NONE
diff --git a/tools/testing/selftests/rseq/rseq-thread-pointer.h b/tools/testing/selftests/rseq/rseq-thread-pointer.h
index 977c25d758b2..3d5019307a1b 100644
--- a/tools/testing/selftests/rseq/rseq-thread-pointer.h
+++ b/tools/testing/selftests/rseq/rseq-thread-pointer.h
@@ -12,6 +12,8 @@
 #include "rseq-x86-thread-pointer.h"
 #elif defined(__PPC__)
 #include "rseq-ppc-thread-pointer.h"
+#elif defined(__or1k__)
+#include "rseq-or1k-thread-pointer.h"
 #else
 #include "rseq-generic-thread-pointer.h"
 #endif
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 4e217b620e0c..cbf114d5bb8a 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -122,6 +122,8 @@ static inline struct rseq_abi *rseq_get_abi(void)
 #include <rseq-s390.h>
 #elif defined(__riscv)
 #include <rseq-riscv.h>
+#elif defined(__or1k__)
+#include <rseq-or1k.h>
 #else
 #error unsupported target
 #endif
-- 
2.47.0


