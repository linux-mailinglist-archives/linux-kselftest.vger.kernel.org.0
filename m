Return-Path: <linux-kselftest+bounces-20458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD669ACC50
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 16:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FB52822DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06691C75E4;
	Wed, 23 Oct 2024 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip3noT40"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926161C729E;
	Wed, 23 Oct 2024 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693819; cv=none; b=biOyCWzlABDpLAbZ5Iw09h46iYXerYPRcr7vlUkytS8NFrw7vC8sAwQD887zLfUvCmPpycmnFxdDqaJDCrGdkIEnw2FPOUlzMPVh41WFfBUaEnu44nME3g41Nsx2qCORZWCsMbWo3UEpriYtPgPUhyEkDZLg1Pf10PCAUMjgPkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693819; c=relaxed/simple;
	bh=3x2lGyz2sZ7xm+78YQFYega2vXvxK4C4KhbMMkDecSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeBNT2uY3W2wWCEb/sn6VWmX6lLhqHZCegYLboF49IvB9rzF4s9DOTwCSjXfargsoQ5hHK/+SKOsbQ/8m+NjkCrfUPdI3cclhALDBaxczxWhdbhduXrOq+HrO/eF93mAv62IBbeODMPO7eUeCdrfR5/LvvqDpT9CFDo9umIK6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip3noT40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400B7C4CEE5;
	Wed, 23 Oct 2024 14:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693819;
	bh=3x2lGyz2sZ7xm+78YQFYega2vXvxK4C4KhbMMkDecSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ip3noT4071hlfFAeYCgtZ0OBn8FOpkuPWDt0ixnF6eqOLpf60brujO6TU450KmG0W
	 TL6xyS61V2tV1xXd/I97K9xsAD6R84Oa9jPIFcv3NgB3zQEA1ZSMULnTf9XRbEFlFa
	 LSj5T6yE17dYaxFC2qFjorlu+RNDHyDCGG7to1YXcJ+uHgAIXcbYxpIshjxdUey+td
	 ssR52Ha826XHX+Tvj8Sic0H7jWUXO4GmPHlrhkf1DHhmpY9CSHPVIzo8C5YcqPUZP9
	 62qcD73NLmeN4zMgAY4pWxXgBiKyCxNiB7PuSDFmKgRwVj0qiGSRq3vV9R4jLP/JLW
	 l4GkN8RnnmUyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 03/30] selftests/bpf: Verify that sync_linked_regs preserves subreg_def
Date: Wed, 23 Oct 2024 10:29:28 -0400
Message-ID: <20241023143012.2980728-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143012.2980728-1-sashal@kernel.org>
References: <20241023143012.2980728-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit a41b3828ec056a631ad22413d4560017fed5c3bd ]

This test was added because of a bug in verifier.c:sync_linked_regs(),
upon range propagation it destroyed subreg_def marks for registers.
The test is written in a way to return an upper half of a register
that is affected by range propagation and must have it's subreg_def
preserved. This gives a return value of 0 and leads to undefined
return value if subreg_def mark is not preserved.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20240924210844.1758441-2-eddyz87@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/bpf/progs/verifier_scalar_ids.c | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 13b29a7faa71a..d24d3a36ec144 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -656,4 +656,71 @@ __naked void two_old_ids_one_cur_id(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+/* Note the flag, see verifier.c:opt_subreg_zext_lo32_rnd_hi32() */
+__flag(BPF_F_TEST_RND_HI32)
+__success
+/* This test was added because of a bug in verifier.c:sync_linked_regs(),
+ * upon range propagation it destroyed subreg_def marks for registers.
+ * The subreg_def mark is used to decide whether zero extension instructions
+ * are needed when register is read. When BPF_F_TEST_RND_HI32 is set it
+ * also causes generation of statements to randomize upper halves of
+ * read registers.
+ *
+ * The test is written in a way to return an upper half of a register
+ * that is affected by range propagation and must have it's subreg_def
+ * preserved. This gives a return value of 0 and leads to undefined
+ * return value if subreg_def mark is not preserved.
+ */
+__retval(0)
+/* Check that verifier believes r1/r0 are zero at exit */
+__log_level(2)
+__msg("4: (77) r1 >>= 32                     ; R1_w=0")
+__msg("5: (bf) r0 = r1                       ; R0_w=0 R1_w=0")
+__msg("6: (95) exit")
+__msg("from 3 to 4")
+__msg("4: (77) r1 >>= 32                     ; R1_w=0")
+__msg("5: (bf) r0 = r1                       ; R0_w=0 R1_w=0")
+__msg("6: (95) exit")
+/* Verify that statements to randomize upper half of r1 had not been
+ * generated.
+ */
+__xlated("call unknown")
+__xlated("r0 &= 2147483647")
+__xlated("w1 = w0")
+/* This is how disasm.c prints BPF_ZEXT_REG at the moment, x86 and arm
+ * are the only CI archs that do not need zero extension for subregs.
+ */
+#if !defined(__TARGET_ARCH_x86) && !defined(__TARGET_ARCH_arm64)
+__xlated("w1 = w1")
+#endif
+__xlated("if w0 < 0xa goto pc+0")
+__xlated("r1 >>= 32")
+__xlated("r0 = r1")
+__xlated("exit")
+__naked void linked_regs_and_subreg_def(void)
+{
+	asm volatile (
+	"call %[bpf_ktime_get_ns];"
+	/* make sure r0 is in 32-bit range, otherwise w1 = w0 won't
+	 * assign same IDs to registers.
+	 */
+	"r0 &= 0x7fffffff;"
+	/* link w1 and w0 via ID */
+	"w1 = w0;"
+	/* 'if' statement propagates range info from w0 to w1,
+	 * but should not affect w1->subreg_def property.
+	 */
+	"if w0 < 10 goto +0;"
+	/* r1 is read here, on archs that require subreg zero
+	 * extension this would cause zext patch generation.
+	 */
+	"r1 >>= 32;"
+	"r0 = r1;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


