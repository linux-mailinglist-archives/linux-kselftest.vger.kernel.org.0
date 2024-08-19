Return-Path: <linux-kselftest+bounces-15648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E96956D23
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 16:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8F91C21F7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 14:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA18116DEA6;
	Mon, 19 Aug 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="u4k2d/0M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4C16DC35;
	Mon, 19 Aug 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077484; cv=none; b=reUYej2XZQbmFJp1qyA2YckhFP2Ag0RLh8xyDgBsUKpukvQTqca9R82Udfj1JBUV7L4F+RFgzS6zCpU2phXMFWszRuW+iFovSv2HfEFr0icbuD8ed2xpyyviJ9v2N3+K0r3Jfh022OVs3Y5m3WZgmIoCrHRKNZKqoY6pbvyKyxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077484; c=relaxed/simple;
	bh=CYMdyg3x/d18fKFLJ4Xma0j0PTuNo6RSgspNychNcv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NmuvYQkLsgK5eTONm50AUtfs/Yk0+SwjIDgdI9E7ehgs0vK7HgUKBA41IFL71czLKperXhy201eOF2I96SuHqLeDYYWKXiguKp4NBfk9wLDm3j8RlWm/gYDooHy6rwKil9BthPUeoT6TVCTsxqa0zxXDdkCIoZdiphnOfUuADdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=u4k2d/0M; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724077480;
	bh=CYMdyg3x/d18fKFLJ4Xma0j0PTuNo6RSgspNychNcv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u4k2d/0MmggWT7xYGW+xGUVk85VqoFIRfL+iIfLM6RhXsV0TywYBPh0wqpMw5/QWA
	 iLMEwtmypD8yDZSe4M4tJonvrOVXRN0zg7nO+Ub4rtAe+3ZKgvB9tA4K7Z+pB62hkJ
	 VZGzNJyOJNtaNoFrY0V9pfqvXlW13fwsZFJ3j7qE/7B8bTNerLX5xLSVRraNggMkWN
	 OiUg1SkbDeTTbK20Jevznx4TCIOkOHBLFLuXl/UaHt08Eu7HfrGAsQj511UEDgQ1AB
	 au2qT9qNtU380fhSWMvONu9IzjZVK/Sdh2Mn8uq6ndV35ccH91KxfQlFMq90H/iRuq
	 RHuIqM4B8HS/g==
Received: from thinkos.internal.efficios.com (109.56.13.38.mobile.3.dk [109.56.13.38])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WnZc64l1Vz1HSP;
	Mon, 19 Aug 2024 10:24:38 -0400 (EDT)
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
Subject: [RFC PATCH 4/5] selftests/rseq: x86: Implement rseq_load_u32_u32
Date: Mon, 19 Aug 2024 16:24:05 +0200
Message-Id: <20240819142406.339084-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240819142406.339084-1-mathieu.desnoyers@efficios.com>
References: <20240819142406.339084-1-mathieu.desnoyers@efficios.com>
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


