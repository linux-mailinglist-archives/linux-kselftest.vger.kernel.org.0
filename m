Return-Path: <linux-kselftest+bounces-19874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8216A9A13DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 22:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D50BBB228BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 20:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7E1216A19;
	Wed, 16 Oct 2024 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AbzV3i4M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3D6217324
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110506; cv=none; b=ZVN1eWqTTOxtmZ/OdQaAWGnDsXsbbV+Bc975w40/03nBONV380aBpiETUjQG/pWSoqFOX10hQoNBNkfxnCbMzSuV4vxJNIuqntPlrLQgGVgUZNmf8nkJKQRPme9TYqCRxHyJnHrRj6YX251TCrx8Hh3OTq8GQZoa1mGy7URkJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110506; c=relaxed/simple;
	bh=Dc7rEYEgxGD/Cl+SV1SEXcIn3loeLbqoEG/MWrQrS2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naJTodIoF/4v2IwYMvlbDo/LXqndeo2Ux043v67TZlNOdEFPs10C05HJRpCZyr6liecdq6FfM1thJ3BoN1WgToC3Yydlcw3l1Xa1z1x9G/elUKEkjY8m0fJPbmN/UpY4y39g6N6VXcfJ3JS0rlxRGnlu+nkydNGNl+QL+PSZnLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=AbzV3i4M; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e30116efc9so174867a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 13:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729110504; x=1729715304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eo/JV88hOL+S2Nr/0pjLrqapJLfVH6+MO5UxiP8a69U=;
        b=AbzV3i4MlfktMjd1sJSmVBKoozl6LPKiolvV2GSbkycArD8bzLHTyehjPDDrwUl9h5
         /YZdK9IvcyoZROhwD14JsUS5EyVmFs9FuR7bPs6TzxYxd6BC/z7KRNd689xiPp1Gg7C1
         4Mq+knkdnpwE7A8ETliW2P+uab/6Bpb1398NcZGo80Im5ExC9nMR9+yF3w9Gixc+9e/D
         tl3qdJY4oio90dbRa8iQRJsnSWDvrzWOSsenH3ZYyBzWtMPIG2jU2d1baDziMpriOvj6
         hrRb0afADwOnlib9wqebn7r1wID36sft7ArlZvMFDvdKlDD73RHllRAHHSnpbEb3nKrk
         4VPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110504; x=1729715304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eo/JV88hOL+S2Nr/0pjLrqapJLfVH6+MO5UxiP8a69U=;
        b=TNlagnyQXHJjvFCZW82tgcKE4ztx1oOW33B8cThGpppnJNAkz4Sqr9Ntbc/09yu0Ks
         k23G054e+9efiIbMahRuIvd6q1KnbaiwQImxswHug7enM7nWWFRLHm02Rs+IET9Wue4s
         wPrGALK4RFYc3cQS2ekUDPR6A9NwvWvsRdnCSfXTzk89E4bVLsHsjqb2VU4ApaaRykQt
         a/J7SZ0XAoudGlb/lvBUUJ1p5wpO9FOdO6j29jz8QRcljAAMeWTx9NVEzBHOUzbaJNhm
         vljRSl0C+HPVfbB0btF/khsWnvg+AUdk0Sr/x9tqkeXlJS+J0OQrpbryqdSgebTWIYj8
         4CLA==
X-Forwarded-Encrypted: i=1; AJvYcCXTyJDV5l6DOGdr+O+ZU3yDFyzKyAv1Up0JUiUqN9rWJV1hQhDh0P8zIY3TXKZjarThc7YBsKsYW25qH7Rpv0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXc9JbtkGXuMdLct4n9nHMQ6hm43B0MqYj1/rk+2GVrnAovE4v
	wLHw6iSQaw4QLmUVFossp7m8EDt9SFqR5l5bu3u1Un4OFh2G90DhrX3hiWu8sIg=
X-Google-Smtp-Source: AGHT+IEJIDriZqg0yBJTxMeg1P8T+SpmofcxsatsSbAlwqzSvOscPzTniDFKaKdVE7curJ4vos+ZWw==
X-Received: by 2002:a17:90b:881:b0:2e2:a097:bb02 with SMTP id 98e67ed59e1d1-2e3ab7f85a6mr6439669a91.11.1729110504350;
        Wed, 16 Oct 2024 13:28:24 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08f8f89sm228613a91.38.2024.10.16.13.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:28:23 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-kselftest@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	devicetree@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	kvm-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	Evgenii Stepanov <eugenis@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 04/10] riscv: Add support for userspace pointer masking
Date: Wed, 16 Oct 2024 13:27:45 -0700
Message-ID: <20241016202814.4061541-5-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241016202814.4061541-1-samuel.holland@sifive.com>
References: <20241016202814.4061541-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V supports pointer masking with a variable number of tag bits
(which is called "PMLEN" in the specification) and which is configured
at the next higher privilege level.

Wire up the PR_SET_TAGGED_ADDR_CTRL and PR_GET_TAGGED_ADDR_CTRL prctls
so userspace can request a lower bound on the number of tag bits and
determine the actual number of tag bits. As with arm64's
PR_TAGGED_ADDR_ENABLE, the pointer masking configuration is
thread-scoped, inherited on clone() and fork() and cleared on execve().

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v5:
 - Document how PR_[SG]ET_TAGGED_ADDR_CTRL are used on RISC-V

Changes in v4:
 - Switch IS_ENABLED back to #ifdef to fix riscv32 build

Changes in v3:
 - Rename CONFIG_RISCV_ISA_POINTER_MASKING to CONFIG_RISCV_ISA_SUPM,
   since it only controls the userspace part of pointer masking
 - Use IS_ENABLED instead of #ifdef when possible
 - Use an enum for the supported PMLEN values
 - Simplify the logic in set_tagged_addr_ctrl()

Changes in v2:
 - Rebase on riscv/linux.git for-next
 - Add and use the envcfg_update_bits() helper function
 - Inline flush_tagged_addr_state()

 Documentation/arch/riscv/uabi.rst  | 12 ++++
 arch/riscv/Kconfig                 | 11 ++++
 arch/riscv/include/asm/processor.h |  8 +++
 arch/riscv/include/asm/switch_to.h | 11 ++++
 arch/riscv/kernel/process.c        | 91 ++++++++++++++++++++++++++++++
 include/uapi/linux/prctl.h         |  5 +-
 6 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/riscv/uabi.rst b/Documentation/arch/riscv/uabi.rst
index 2b420bab0527..ddb8359a46ed 100644
--- a/Documentation/arch/riscv/uabi.rst
+++ b/Documentation/arch/riscv/uabi.rst
@@ -68,3 +68,15 @@ Misaligned accesses
 Misaligned scalar accesses are supported in userspace, but they may perform
 poorly.  Misaligned vector accesses are only supported if the Zicclsm extension
 is supported.
+
+Pointer masking
+---------------
+
+Support for pointer masking in userspace (the Supm extension) is provided via
+the ``PR_SET_TAGGED_ADDR_CTRL`` and ``PR_GET_TAGGED_ADDR_CTRL`` ``prctl()``
+operations. Pointer masking is disabled by default. To enable it, userspace
+must call ``PR_SET_TAGGED_ADDR_CTRL`` with the ``PR_PMLEN`` field set to the
+number of mask/tag bits needed by the application. ``PR_PMLEN`` is interpreted
+as a lower bound; if the kernel is unable to satisfy the request, the
+``PR_SET_TAGGED_ADDR_CTRL`` operation will fail. The actual number of tag bits
+is returned in ``PR_PMLEN`` by the ``PR_GET_TAGGED_ADDR_CTRL`` operation.
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 22dc5ea4196c..0ef449465378 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -531,6 +531,17 @@ config RISCV_ISA_C
 
 	  If you don't know what to do here, say Y.
 
+config RISCV_ISA_SUPM
+	bool "Supm extension for userspace pointer masking"
+	depends on 64BIT
+	default y
+	help
+	  Add support for pointer masking in userspace (Supm) when the
+	  underlying hardware extension (Smnpm or Ssnpm) is detected at boot.
+
+	  If this option is disabled, userspace will be unable to use
+	  the prctl(PR_{SET,GET}_TAGGED_ADDR_CTRL) API.
+
 config RISCV_ISA_SVNAPOT
 	bool "Svnapot extension support for supervisor mode NAPOT pages"
 	depends on 64BIT && MMU
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index c1a492508835..5f56eb9d114a 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -178,6 +178,14 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
 #define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2)	riscv_set_icache_flush_ctx(arg1, arg2)
 extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread);
 
+#ifdef CONFIG_RISCV_ISA_SUPM
+/* PR_{SET,GET}_TAGGED_ADDR_CTRL prctl */
+long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg);
+long get_tagged_addr_ctrl(struct task_struct *task);
+#define SET_TAGGED_ADDR_CTRL(arg)	set_tagged_addr_ctrl(current, arg)
+#define GET_TAGGED_ADDR_CTRL()		get_tagged_addr_ctrl(current)
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 9685cd85e57c..94e33216b2d9 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -70,6 +70,17 @@ static __always_inline bool has_fpu(void) { return false; }
 #define __switch_to_fpu(__prev, __next) do { } while (0)
 #endif
 
+static inline void envcfg_update_bits(struct task_struct *task,
+				      unsigned long mask, unsigned long val)
+{
+	unsigned long envcfg;
+
+	envcfg = (task->thread.envcfg & ~mask) | val;
+	task->thread.envcfg = envcfg;
+	if (task == current)
+		csr_write(CSR_ENVCFG, envcfg);
+}
+
 static inline void __switch_to_envcfg(struct task_struct *next)
 {
 	asm volatile (ALTERNATIVE("nop", "csrw " __stringify(CSR_ENVCFG) ", %0",
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index e3142d8a6e28..200d2ed64dfe 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/bitfield.h>
 #include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -180,6 +181,10 @@ void flush_thread(void)
 	memset(&current->thread.vstate, 0, sizeof(struct __riscv_v_ext_state));
 	clear_tsk_thread_flag(current, TIF_RISCV_V_DEFER_RESTORE);
 #endif
+#ifdef CONFIG_RISCV_ISA_SUPM
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
+		envcfg_update_bits(current, ENVCFG_PMM, ENVCFG_PMM_PMLEN_0);
+#endif
 }
 
 void arch_release_task_struct(struct task_struct *tsk)
@@ -242,3 +247,89 @@ void __init arch_task_cache_init(void)
 {
 	riscv_v_setup_ctx_cache();
 }
+
+#ifdef CONFIG_RISCV_ISA_SUPM
+enum {
+	PMLEN_0 = 0,
+	PMLEN_7 = 7,
+	PMLEN_16 = 16,
+};
+
+static bool have_user_pmlen_7;
+static bool have_user_pmlen_16;
+
+long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
+{
+	unsigned long valid_mask = PR_PMLEN_MASK;
+	struct thread_info *ti = task_thread_info(task);
+	unsigned long pmm;
+	u8 pmlen;
+
+	if (is_compat_thread(ti))
+		return -EINVAL;
+
+	if (arg & ~valid_mask)
+		return -EINVAL;
+
+	/*
+	 * Prefer the smallest PMLEN that satisfies the user's request,
+	 * in case choosing a larger PMLEN has a performance impact.
+	 */
+	pmlen = FIELD_GET(PR_PMLEN_MASK, arg);
+	if (pmlen == PMLEN_0)
+		pmm = ENVCFG_PMM_PMLEN_0;
+	else if (pmlen <= PMLEN_7 && have_user_pmlen_7)
+		pmm = ENVCFG_PMM_PMLEN_7;
+	else if (pmlen <= PMLEN_16 && have_user_pmlen_16)
+		pmm = ENVCFG_PMM_PMLEN_16;
+	else
+		return -EINVAL;
+
+	envcfg_update_bits(task, ENVCFG_PMM, pmm);
+
+	return 0;
+}
+
+long get_tagged_addr_ctrl(struct task_struct *task)
+{
+	struct thread_info *ti = task_thread_info(task);
+	long ret = 0;
+
+	if (is_compat_thread(ti))
+		return -EINVAL;
+
+	switch (task->thread.envcfg & ENVCFG_PMM) {
+	case ENVCFG_PMM_PMLEN_7:
+		ret = FIELD_PREP(PR_PMLEN_MASK, PMLEN_7);
+		break;
+	case ENVCFG_PMM_PMLEN_16:
+		ret = FIELD_PREP(PR_PMLEN_MASK, PMLEN_16);
+		break;
+	}
+
+	return ret;
+}
+
+static bool try_to_set_pmm(unsigned long value)
+{
+	csr_set(CSR_ENVCFG, value);
+	return (csr_read_clear(CSR_ENVCFG, ENVCFG_PMM) & ENVCFG_PMM) == value;
+}
+
+static int __init tagged_addr_init(void)
+{
+	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
+		return 0;
+
+	/*
+	 * envcfg.PMM is a WARL field. Detect which values are supported.
+	 * Assume the supported PMLEN values are the same on all harts.
+	 */
+	csr_clear(CSR_ENVCFG, ENVCFG_PMM);
+	have_user_pmlen_7 = try_to_set_pmm(ENVCFG_PMM_PMLEN_7);
+	have_user_pmlen_16 = try_to_set_pmm(ENVCFG_PMM_PMLEN_16);
+
+	return 0;
+}
+core_initcall(tagged_addr_init);
+#endif	/* CONFIG_RISCV_ISA_SUPM */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 35791791a879..cefd656ebf43 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -230,7 +230,7 @@ struct prctl_mm_map {
 # define PR_PAC_APDBKEY			(1UL << 3)
 # define PR_PAC_APGAKEY			(1UL << 4)
 
-/* Tagged user address controls for arm64 */
+/* Tagged user address controls for arm64 and RISC-V */
 #define PR_SET_TAGGED_ADDR_CTRL		55
 #define PR_GET_TAGGED_ADDR_CTRL		56
 # define PR_TAGGED_ADDR_ENABLE		(1UL << 0)
@@ -244,6 +244,9 @@ struct prctl_mm_map {
 # define PR_MTE_TAG_MASK		(0xffffUL << PR_MTE_TAG_SHIFT)
 /* Unused; kept only for source compatibility */
 # define PR_MTE_TCF_SHIFT		1
+/* RISC-V pointer masking tag length */
+# define PR_PMLEN_SHIFT			24
+# define PR_PMLEN_MASK			(0x7fUL << PR_PMLEN_SHIFT)
 
 /* Control reclaim behavior when allocating memory */
 #define PR_SET_IO_FLUSHER		57
-- 
2.45.1


