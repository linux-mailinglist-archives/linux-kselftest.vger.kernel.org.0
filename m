Return-Path: <linux-kselftest+bounces-38697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C4EB21455
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 20:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FCA3E5285
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0356C2E1744;
	Mon, 11 Aug 2025 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIB+1+Md"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C806D2E11C3;
	Mon, 11 Aug 2025 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936895; cv=none; b=pQMaEGham8hYawJXv7WKKX0iJWDTqWfUMEbkgaP5OdsaRQIp73/i7RIqS6fgOzoE/Nu2QhcWOsWJ1pqA1X1ttov4lijnU5aU8AeLYPAyzgSn2jZqwx761lU/n9e630RQC6C2AcMUsorzol92cEWcK6XttSEnxnrPoQv6b838O4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936895; c=relaxed/simple;
	bh=uMhACYcWihYuwB7DWQQsjF40f0GjfQBRPtdS9pPrNeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFeSMaLGdeax5o7lf4KCTaJQso163hDL56JCgP/p755bvuYdABCEqgnKje3mak60SktFag6BxM2Ef1o5uDVfyOvdZR9V9SqW0h3zjtGzb+9+mc0jc8e4wqoYc9jNwYZ6ZlNSwXNWIskf8iwo8TMRdu0TYFPEUsSqPLM6DOSJOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIB+1+Md; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF66C4CEF6;
	Mon, 11 Aug 2025 18:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754936895;
	bh=uMhACYcWihYuwB7DWQQsjF40f0GjfQBRPtdS9pPrNeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qIB+1+MddbonxE/igP3HJeFr7AvgrTxjLhdEVgQq2CkqC/DE3GUTj206WglR1Jlqh
	 ZjhMPL1XRo2sl6+T/B1K0wH4t2RibOIzvepC/MXJaqxxY6AnacPPZM/2u+fDD+AzKD
	 7Cu4/aQSv/kEpAgAkwF8p+D9NDg2qxc5/LV6nloN/onxoYL7F6Wv1fBqJE3PVPODmn
	 IM9njFgS8u3Yk205hVcsSLyq4J/SxkQwuLK8pnEeANdcuqa88ved3QIhHCApiCdvtP
	 P5yr0+AUCo8l7McqZ0vl4YBDo509giQElBglRbTDBquOr99cUVrNbEcKGwAjPSzZY9
	 VcykrMVVhJYnw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 2/3] lib/crc: crc_kunit: Test CRC computation in interrupt contexts
Date: Mon, 11 Aug 2025 11:26:30 -0700
Message-ID: <20250811182631.376302-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811182631.376302-1-ebiggers@kernel.org>
References: <20250811182631.376302-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that if CRCs are computed in task, softirq, and hardirq context
concurrently, then all results are as expected.  Implement this using
kunit_run_irq_test() which is also used by the lib/crypto/ tests.

As with the corresponding lib/crypto/ tests, the purpose of this is to
test fallback code paths and to exercise edge cases in the
architecture's support for in-kernel FPU/SIMD/vector.

Remove the code from crc_test() that sometimes disabled interrupts, as
that was just an incomplete attempt to achieve similar test coverage.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crc/tests/crc_kunit.c | 62 +++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/lib/crc/tests/crc_kunit.c b/lib/crc/tests/crc_kunit.c
index f08d985d8860e..9a450e25ac811 100644
--- a/lib/crc/tests/crc_kunit.c
+++ b/lib/crc/tests/crc_kunit.c
@@ -4,10 +4,11 @@
  *
  * Copyright 2024 Google LLC
  *
  * Author: Eric Biggers <ebiggers@google.com>
  */
+#include <kunit/run-in-irq-context.h>
 #include <kunit/test.h>
 #include <linux/crc7.h>
 #include <linux/crc16.h>
 #include <linux/crc-t10dif.h>
 #include <linux/crc32.h>
@@ -139,19 +140,66 @@ static size_t generate_random_length(size_t max_length)
 		break;
 	}
 	return len % (max_length + 1);
 }
 
+#define IRQ_TEST_DATA_LEN 512
+#define IRQ_TEST_NUM_BUFFERS 3 /* matches max concurrency level */
+
+struct crc_irq_test_state {
+	const struct crc_variant *v;
+	u64 initial_crc;
+	u64 expected_crcs[IRQ_TEST_NUM_BUFFERS];
+	atomic_t seqno;
+};
+
+/*
+ * Compute the CRC of one of the test messages and verify that it matches the
+ * expected CRC from @state->expected_crcs.  To increase the chance of detecting
+ * problems, cycle through multiple messages.
+ */
+static bool crc_irq_test_func(void *state_)
+{
+	struct crc_irq_test_state *state = state_;
+	const struct crc_variant *v = state->v;
+	u32 i = (u32)atomic_inc_return(&state->seqno) % IRQ_TEST_NUM_BUFFERS;
+	u64 actual_crc = v->func(state->initial_crc,
+				 &test_buffer[i * IRQ_TEST_DATA_LEN],
+				 IRQ_TEST_DATA_LEN);
+
+	return actual_crc == state->expected_crcs[i];
+}
+
+/*
+ * Test that if CRCs are computed in task, softirq, and hardirq context
+ * concurrently, then all results are as expected.
+ */
+static void crc_interrupt_context_test(struct kunit *test,
+				       const struct crc_variant *v)
+{
+	struct crc_irq_test_state state = {
+		.v = v,
+		.initial_crc = generate_random_initial_crc(v),
+	};
+
+	for (int i = 0; i < IRQ_TEST_NUM_BUFFERS; i++) {
+		state.expected_crcs[i] = crc_ref(
+			v, state.initial_crc,
+			&test_buffer[i * IRQ_TEST_DATA_LEN], IRQ_TEST_DATA_LEN);
+	}
+
+	kunit_run_irq_test(test, crc_irq_test_func, 100000, &state);
+}
+
 /* Test that v->func gives the same CRCs as a reference implementation. */
 static void crc_test(struct kunit *test, const struct crc_variant *v)
 {
 	size_t i;
 
 	for (i = 0; i < CRC_KUNIT_NUM_TEST_ITERS; i++) {
 		u64 init_crc, expected_crc, actual_crc;
 		size_t len, offset;
-		bool nosimd;
 
 		init_crc = generate_random_initial_crc(v);
 		len = generate_random_length(CRC_KUNIT_MAX_LEN);
 
 		/* Generate a random offset. */
@@ -166,26 +214,22 @@ static void crc_test(struct kunit *test, const struct crc_variant *v)
 
 		if (rand32() % 8 == 0)
 			/* Refresh the data occasionally. */
 			prandom_bytes_state(&rng, &test_buffer[offset], len);
 
-		nosimd = rand32() % 8 == 0;
-
 		/*
 		 * Compute the CRC, and verify that it equals the CRC computed
 		 * by a simple bit-at-a-time reference implementation.
 		 */
 		expected_crc = crc_ref(v, init_crc, &test_buffer[offset], len);
-		if (nosimd)
-			local_irq_disable();
 		actual_crc = v->func(init_crc, &test_buffer[offset], len);
-		if (nosimd)
-			local_irq_enable();
 		KUNIT_EXPECT_EQ_MSG(test, expected_crc, actual_crc,
-				    "Wrong result with len=%zu offset=%zu nosimd=%d",
-				    len, offset, nosimd);
+				    "Wrong result with len=%zu offset=%zu",
+				    len, offset);
 	}
+
+	crc_interrupt_context_test(test, v);
 }
 
 static __always_inline void
 crc_benchmark(struct kunit *test,
 	      u64 (*crc_func)(u64 crc, const u8 *p, size_t len))
-- 
2.50.1


