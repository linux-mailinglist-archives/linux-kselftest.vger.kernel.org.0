Return-Path: <linux-kselftest+bounces-16175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7458695D5B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 21:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A411F1C2298C
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 19:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C2E193061;
	Fri, 23 Aug 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LetfqUA8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8602A1922C9;
	Fri, 23 Aug 2024 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439652; cv=none; b=mgftg2gq4rZ3qDxbcRJBXPbGcgIRU/1btK8j5hKmI9mcgq6F91OHsFImbybpnNAw5jgrrnL4LwXV1Isz4I496KT6o+0Pc2CRseD3p1sf7j0X9oDDExsR9B0D0xO185HldgcmKsej7ejEVMrHhXUiwUZEYmAEx8xVCHygplsL41g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439652; c=relaxed/simple;
	bh=bs+/EWjAhs966KMUIhRMp9DxjSO6mOM2w5UU/c1zyqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nzizOklUZ68ygmhyYNroHirw+eU7h9JoVXEUbWikzN5ENqGGRK8/V7sFNDPma0hcNFEgGICmV3qyHv+K9844pOwewla/7fMq1mItLZB71Jx3OazaxbypJburWtJOXQSgkg0E7DtFMh5yY2znb0BHpT1vh17LcyP96SQN+qhIxJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=LetfqUA8; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724439622;
	bh=bs+/EWjAhs966KMUIhRMp9DxjSO6mOM2w5UU/c1zyqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LetfqUA8vTxITbVR+/8Naz3XntQhCRMzTU5f+A9/vXZB7ywf+M4371xDZRebGj6Kw
	 PeoUfKtj/PVsf02ZnkGYqA39WR2uiDlBZLVAHkAaSo/UTlo3ZJ6vSyFothWxukeKcu
	 grGKotQMMvFm28c5m+zsomYFihXJQB82CI9Gb4eNND0klPVPYFvk7Uey2KboF8i3uG
	 fR6rw7RBIlPNCZpHhEDTvwu1oP09tAeB/8c8mCKcZ9klRIobLkPiF3vmfWDOpxSbl6
	 RccVvUBz6dcP4zu4oi29H69u5gSKYSZUy2j0pjJxoxYT8+0V5KvLGIxOo6wtm5R+LR
	 6PIYOmY+gN7Lw==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:b243:804e:3bbd:91c9])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wr8XQ34Cfz1Hhj;
	Fri, 23 Aug 2024 15:00:22 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v1 5/6] selftests/rseq: x86: Implement rseq_load_u32_u32
Date: Fri, 23 Aug 2024 14:59:45 -0400
Message-Id: <20240823185946.418340-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240823185946.418340-1-mathieu.desnoyers@efficios.com>
References: <20240823185946.418340-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow loading a pair of u32 within a rseq critical section. It can be
used in situations where both rseq_abi()->mm_cid and
rseq_abi()->node_id need to be sampled atomically with respect to
preemption, signal delivery and migration.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/rseq/rseq-x86-bits.h | 43 ++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h          | 14 +++++++
 2 files changed, 57 insertions(+)

diff --git a/tools/testing/selftests/rseq/rseq-x86-bits.h b/tools/testing/selftests/rseq/rseq-x86-bits.h
index 8a9431eec467..fdf5ef398393 100644
--- a/tools/testing/selftests/rseq/rseq-x86-bits.h
+++ b/tools/testing/selftests/rseq/rseq-x86-bits.h
@@ -990,4 +990,47 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t
 
 #endif
 
+#if defined(RSEQ_TEMPLATE_CPU_ID_NONE) && defined(RSEQ_TEMPLATE_MO_RELAXED)
+
+#define RSEQ_ARCH_HAS_LOAD_U32_U32
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_load_u32_u32)(uint32_t *dst1, uint32_t *src1,
+		      uint32_t *dst2, uint32_t *src2)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_INJECT_ASM(3)
+		"movl %[src1], %%eax\n\t"
+		"movl %%eax, %[dst1]\n\t"
+		"movl %[src2], %%eax\n\t"
+		"movl %%eax, %[dst2]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [dst1]		"m" (*dst1),
+		  [src1]		"m" (*src1),
+		  [dst2]		"m" (*dst2),
+		  [src2]		"m" (*src2)
+		: "memory", "cc", "rax"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+}
+
+#endif /* defined(RSEQ_TEMPLATE_CPU_ID_NONE) && defined(RSEQ_TEMPLATE_MO_RELAXED) */
+
 #include "rseq-bits-reset.h"
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index d7364ea4d201..b6095c2a5da6 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -381,4 +381,18 @@ int rseq_cmpeqv_trymemcpy_storev(enum rseq_mo rseq_mo, enum rseq_percpu_mode per
 	}
 }
 
+#ifdef RSEQ_ARCH_HAS_LOAD_U32_U32
+
+static inline __attribute__((always_inline))
+int rseq_load_u32_u32(enum rseq_mo rseq_mo,
+		      uint32_t *dst1, uint32_t *src1,
+		      uint32_t *dst2, uint32_t *src2)
+{
+	if (rseq_mo != RSEQ_MO_RELAXED)
+		return -1;
+	return rseq_load_u32_u32_relaxed(dst1, src1, dst2, src2);
+}
+
+#endif
+
 #endif  /* RSEQ_H_ */
-- 
2.39.2


