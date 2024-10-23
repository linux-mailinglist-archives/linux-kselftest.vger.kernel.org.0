Return-Path: <linux-kselftest+bounces-20460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC9D9ACCB5
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 16:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF74AB2443A
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D291F9A9F;
	Wed, 23 Oct 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFDAq7sb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B907B1F9432;
	Wed, 23 Oct 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693882; cv=none; b=oO0UloA5nqibgOEAqZVAiuTh7hr/bRoYzSsMVj9ma83clFaiU/PyPfuZXgHAS/ZzuZbwXE537ey67zZfFB4qCfnV8DyH8G/NRtjc1AtgmA4L1UvvmOIdK3dDDvJFVxfGHo6zjoNh2/95mc48kFdcbdisAqHM7hby539sL6zaR6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693882; c=relaxed/simple;
	bh=3x2lGyz2sZ7xm+78YQFYega2vXvxK4C4KhbMMkDecSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Is+2vj13fWWOV6GhtQwCeXxvfZ51U9G4oR9x5J2kNwdku7dS9D9qvgJGwnSFzzXtDR46UJ5Ttifm25aLOY2OpqOUwtcm4UR2Yq/p7NUoPiHdAIoMA47TAGrHNwIV75qkh+dPfuydvIzSeR+kSUkEjJwEvakUM+A8XkDfCZSkxRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFDAq7sb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A3DC4CEC6;
	Wed, 23 Oct 2024 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693882;
	bh=3x2lGyz2sZ7xm+78YQFYega2vXvxK4C4KhbMMkDecSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFDAq7sby290l0ZAn+WhrrdX0chSGiaK/borwMG9mZz5v21QuqMsmXQFHXh0/Hls4
	 3f5lOPy21qDMPNcO1QPfWulX+ju/5zQ9TgGg3QFlQKCvFxqBl80xRA7c+b3e3X9Ugo
	 aQs2v8/TTQw5KLwJvYokboDY4n34eepBsLKiV9SiUpx6+aXREdXXhmKj59zL0O+7uw
	 mEBBJgNygkctWBCZanp60hU6a0Ws+Jq7O0kFgSShKsqfaA6CChBb7QnNMKRIh8HGHM
	 wgShWdKDlCRyrgmldyP3m2tTOVzWeoiUQN5vuD2KBZ1hmtSBT4MbDbL92pYCqSoj7n
	 83gM2YbX5G+MQ==
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
Subject: [PATCH AUTOSEL 6.6 03/23] selftests/bpf: Verify that sync_linked_regs preserves subreg_def
Date: Wed, 23 Oct 2024 10:30:47 -0400
Message-ID: <20241023143116.2981369-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143116.2981369-1-sashal@kernel.org>
References: <20241023143116.2981369-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
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


