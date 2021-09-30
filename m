Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460BF41E0D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353370AbhI3SSk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:18:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353361AbhI3SSj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:18:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA2B96140F;
        Thu, 30 Sep 2021 18:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025816;
        bh=nPc7T+n1fr+1hpxnV4NU+Odl48SyMLgnFTfFKImP3xE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rgxQRRQ/GJFUhWf7n2oh6JHfuKm5hvesBUiz/ELMbkxu4izpqyLlaiMggyDySbZdP
         /5CE6BRxi5hTzia0BeBCdDLpfmU+PRMEz6ILVfcgjKJCPQ/czp4IDjagWoPF1XnPeg
         vxnuz4QHPRZzmXCFeH87kWTlxBKH4i8+ZQTUKmyrT0E4SvA6U8ugK83EdRbk6RkP3K
         n1sL8QZQq9AC4t5jRtrycKyS6W0n0lOpHUZdSi7vaQ8wXi+JXiViA/mQ+Jdh8Jizvb
         K+c4zcBEQ8t4GgLjoWIxXjsVG3iGsuTWZuXpAbq4tFhFzxhOkTzg8sf7J7N3WPs5Nj
         JWm2B9z1RCehA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 28/38] arm64/sme: Add ptrace support for ZA
Date:   Thu, 30 Sep 2021 19:11:34 +0100
Message-Id: <20210930181144.10029-29-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8277; h=from:subject; bh=nPc7T+n1fr+1hpxnV4NU+Odl48SyMLgnFTfFKImP3xE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3XPd3nwvkI3AhZ//+LMg1IUS1xMP5/FNCy4WW7 vwoFtcaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX91wAKCRAk1otyXVSH0IKaB/ 4/5OTPXdwPwTsQ04zQD7kCzwJ9h9nlSdJCg5/w7NZr+Z4FOehxmncpXmL20cwiIMJy1VlSOqdvy/lU J3eOleOrkFQrW6/F2AyMfyXvtS+5UGWlVYJTTwyVW/5UyfXFkCdyo04gFLyJ3l0NCchUkgyilRMZfH QnGcWgyH5Lxsd2u1QptoPJJCl8eBksIvs/jQEyjZKzxjIpw+635qR/z5jr7vz6uxGSqUpS3OxQDmcG w3CRXp8s4/g8Tz/cYJp2gAND+oaAl4GG47dbS2wR0iKYcv1mzvelml6DomT1xHzPFiaDyRxCjA1Jpu 5vnMaQnKc8zgtG8T8Py/c65HfBvljQ
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The ZA array can be read and written with the NT_ARM_ZA.  Similarly to
our interface for the SVE vector registers the regset consists of a
header with information on the current vector length followed by an
optional register data payload, represented as for signals as a series
of horizontal vectors from 0 to VL/8 in the endianness independent
format used for vectors.

On get if ZA is enabled then register data will be provided, otherwise
it will be omitted.  On set if register data is provided then ZA is
enabled and initialized using the provided data, otherwise it is
disabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/uapi/asm/ptrace.h |  56 +++++++++++
 arch/arm64/kernel/ptrace.c           | 144 +++++++++++++++++++++++++++
 include/uapi/linux/elf.h             |   1 +
 3 files changed, 201 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 522b925a78c1..7fa2f7036aa7 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -268,6 +268,62 @@ struct user_pac_generic_keys {
 	__uint128_t	apgakey;
 };
 
+/* ZA state (NT_ARM_ZA) */
+
+struct user_za_header {
+	__u32 size; /* total meaningful regset content in bytes */
+	__u32 max_size; /* maxmium possible size for this thread */
+	__u16 vl; /* current vector length */
+	__u16 max_vl; /* maximum possible vector length */
+	__u16 flags;
+	__u16 __reserved;
+};
+
+/*
+ * Common ZA_PT_* flags:
+ * These must be kept in sync with prctl interface in <linux/prctl.h>
+ */
+#define ZA_PT_VL_INHERIT		((1 << 17) /* PR_SME_VL_INHERIT */ >> 16)
+#define ZA_PT_VL_ONEXEC			((1 << 18) /* PR_SME_SET_VL_ONEXEC */ >> 16)
+
+
+/*
+ * The remainder of the ZA state follows struct user_za_header.  The
+ * total size of the ZA state (including header) depends on the
+ * metadata in the header:  ZA_PT_SIZE(vq, flags) gives the total size
+ * of the state in bytes, including the header.
+ *
+ * Refer to <asm/sigcontext.h> for details of how to pass the correct
+ * "vq" argument to these macros.
+ */
+
+/* Offset from the start of struct user_za_header to the register data */
+#define ZA_PT_ZA_OFFSET						\
+	((sizeof(struct user_za_header) + (__SVE_VQ_BYTES - 1))	\
+		/ __SVE_VQ_BYTES * __SVE_VQ_BYTES)
+
+/*
+ * The payload starts at offset ZA_PT_ZA_OFFSET, and is of size
+ * ZA_PT_ZA_SIZE(vq, flags).
+ *
+ * The ZA array is stored as a sequence of horizontal vectors ZAV of SVL/8
+ * bytes each, starting from vector 0.
+ *
+ * Additional data might be appended in the future.
+ *
+ * The ZA matrix is represented in memory in an endianness-invariant layout
+ * which differs from the layout used for the FPSIMD V-registers on big-endian
+ * systems: see sigcontext.h for more explanation.
+ */
+
+#define ZA_PT_ZAV_OFFSET(vq, n) \
+	(ZA_PT_ZA_OFFSET + ((vq * __SVE_VQ_BYTES) * n))
+
+#define ZA_PT_ZA_SIZE(vq) ((vq * __SVE_VQ_BYTES) * (vq * __SVE_VQ_BYTES))
+
+#define ZA_PT_SIZE(vq)						\
+	(ZA_PT_ZA_OFFSET + ZA_PT_ZA_SIZE(vq))
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _UAPI__ASM_PTRACE_H */
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 414126ce5897..702765f50a47 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -996,6 +996,141 @@ static int ssve_set(struct task_struct *target,
 			      ARM64_VEC_SME);
 }
 
+static int za_get(struct task_struct *target,
+		  const struct user_regset *regset,
+		  struct membuf to)
+{
+	struct user_za_header header;
+	unsigned int vq;
+	unsigned long start, end;
+
+	if (!system_supports_sme())
+		return -EINVAL;
+
+	/* Header */
+	memset(&header, 0, sizeof(header));
+
+	if (test_tsk_thread_flag(target, TIF_SME_VL_INHERIT))
+		header.flags |= ZA_PT_VL_INHERIT;
+
+	header.vl = task_get_sme_vl(target);
+	vq = sve_vq_from_vl(header.vl);
+	header.max_vl = sme_max_vl();
+	header.max_size = ZA_PT_SIZE(vq);
+
+	/* If ZA is not active there is only the header */
+	if (thread_za_enabled(&target->thread))
+		header.size = ZA_PT_SIZE(vq);
+	else
+		header.size = ZA_PT_ZA_OFFSET;
+
+	membuf_write(&to, &header, sizeof(header));
+
+	BUILD_BUG_ON(ZA_PT_ZA_OFFSET != sizeof(header));
+	end = ZA_PT_ZA_OFFSET;
+;
+	if (target == current)
+		fpsimd_preserve_current_state();
+
+	/* Any register data to include? */
+	if (thread_za_enabled(&target->thread)) {
+		start = end;
+		end = ZA_PT_SIZE(vq);
+		membuf_write(&to, target->thread.za_state, end - start);
+	}
+
+	/* Zero any trailing padding */
+	start = end;
+	end = ALIGN(header.size, SVE_VQ_BYTES);
+	return membuf_zero(&to, end - start);
+}
+
+static int za_set(struct task_struct *target,
+		  const struct user_regset *regset,
+		  unsigned int pos, unsigned int count,
+		  const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+	struct user_za_header header;
+	unsigned int vq;
+	unsigned long start, end;
+
+	if (!system_supports_sme())
+		return -EINVAL;
+
+	/* Header */
+	if (count < sizeof(header))
+		return -EINVAL;
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &header,
+				 0, sizeof(header));
+	if (ret)
+		goto out;
+
+	/*
+	 * All current ZA_PT_* flags are consumed by
+	 * vec_set_vector_length(), which will also validate them for
+	 * us:
+	 */
+	ret = vec_set_vector_length(target, ARM64_VEC_SME, header.vl,
+		((unsigned long)header.flags) << 16);
+	if (ret)
+		goto out;
+
+	/* Actual VL set may be less than the user asked for: */
+	vq = sve_vq_from_vl(task_get_sme_vl(target));
+
+	/* Ensure there is some SVE storage for streaming mode */
+	if (!target->thread.sve_state) {
+		sve_alloc(target);
+		if (!target->thread.sve_state) {
+			clear_thread_flag(TIF_SME);
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	/* Allocate/reinit ZA storage */
+	sme_alloc(target);
+	if (!target->thread.za_state) {
+		ret = -ENOMEM;
+		clear_tsk_thread_flag(target, TIF_SME);
+		goto out;
+	}
+
+	/* If there is no data then disable ZA */
+	if (!count) {
+		target->thread.svcr &= ~SYS_SVCR_EL0_ZA_MASK;
+		goto out;
+	}
+
+	/*
+	 * If setting a different VL from the requested VL and there is
+	 * register data, the data layout will be wrong: don't even
+	 * try to set the registers in this case.
+	 */
+	if (vq != sve_vq_from_vl(header.vl)) {
+		ret = -EIO;
+		goto out;
+	}
+
+	BUILD_BUG_ON(ZA_PT_ZA_OFFSET != sizeof(header));
+	start = ZA_PT_ZA_OFFSET;
+	end = ZA_PT_SIZE(vq);
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 target->thread.za_state,
+				 start, end);
+	if (ret)
+		goto out;
+
+	/* Mark ZA as active and let userspace use it */
+	set_tsk_thread_flag(target, TIF_SME);
+	target->thread.svcr |= SYS_SVCR_EL0_ZA_MASK;
+
+out:
+	fpsimd_flush_task_state(target);
+	return ret;
+}
+
 #endif /* CONFIG_ARM64_SME */
 
 #ifdef CONFIG_ARM64_PTR_AUTH
@@ -1217,6 +1352,7 @@ enum aarch64_regset {
 #endif
 #ifdef CONFIG_ARM64_SVE
 	REGSET_SSVE,
+	REGSET_ZA,
 #endif
 #ifdef CONFIG_ARM64_PTR_AUTH
 	REGSET_PAC_MASK,
@@ -1308,6 +1444,14 @@ static const struct user_regset aarch64_regsets[] = {
 		.regset_get = ssve_get,
 		.set = ssve_set,
 	},
+	[REGSET_ZA] = { /* SME ZA */
+		.core_note_type = NT_ARM_ZA,
+		.n = DIV_ROUND_UP(ZA_PT_ZA_SIZE(SVE_VQ_MAX), SVE_VQ_BYTES),
+		.size = SVE_VQ_BYTES,
+		.align = SVE_VQ_BYTES,
+		.regset_get = za_get,
+		.set = za_set,
+	},
 #endif
 #ifdef CONFIG_ARM64_PTR_AUTH
 	[REGSET_PAC_MASK] = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 61502388683f..7ef574f3256a 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -428,6 +428,7 @@ typedef struct elf64_shdr {
 #define NT_ARM_TAGGED_ADDR_CTRL	0x409	/* arm64 tagged address control (prctl()) */
 #define NT_ARM_PAC_ENABLED_KEYS	0x40a	/* arm64 ptr auth enabled keys (prctl()) */
 #define NT_ARM_SSVE	0x40b		/* ARM Streaming SVE registers */
+#define NT_ARM_ZA	0x40c		/* ARM SME ZA registers */
 #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
 #define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
-- 
2.20.1

