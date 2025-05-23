Return-Path: <linux-kselftest+bounces-33630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D322AC20E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 12:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AED8A4416A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 10:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8A6231850;
	Fri, 23 May 2025 10:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KaZKUn7R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E6222A4FC
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747995708; cv=none; b=i180hh+qhlP8+t1i98U2RnU4ef/55mpEmOGYrckCa/BAL9qvUh+qsuCzlewbCz0SSgCTe7q+RdPz30h6zdsER/vrGz1t+5/7DcVc64TACiRY+UyXEeW4KQPaVPFAHv41qHj2TfVn9xFcrGW4CUBKaaWQGx4XvL1Wa6Uj14VEk38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747995708; c=relaxed/simple;
	bh=PGXvcUd7AEZN3/JlvOlbni86hFgiQ4HPyrDarRZ8hOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COX6QuvtVHFAX3JBcQjI1SEM9F0SaZk+wT3B5S8lgTzowrfOeWMJTWjoS0m5CKUjhM8Xqc7xI+ZELW7Pk2cHpUmYxVHWsu6tuZQ5GHSSx853ccV+pOBvy1d+wkCnz8ZrB0QeTzzzouXJxwXZKIfmJxe5oTTVvFEeyts4U0wv6Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KaZKUn7R; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736c277331eso598384b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 03:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747995706; x=1748600506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhYYFU/0gd4i6u7YSldc/A6P4zLJhDJyiOeiCd5c27I=;
        b=KaZKUn7RY3tdYAiwbVIrEK8W2fTuTdemUqM7TuzU79jZe9CV9rzaAoIGZ5y/vxkQC7
         4TxVYW/QDZrBRJNDBoK88pfkolWEGAzmrU09B4sJs7I9O4Dz0yiiqO+3tYbYXGxpsI1G
         rXjZey7C5JZmjQsjaX5xPn7gGEC2KXYgTYvWMOkZ2q93VMoteu5yAl+XT3yeWAp2sccj
         QHPrrBqAxVEAVr5B8cd7ZlEfih1j9LHqnQLxkkZTGBeazGoCKsBKV86x3b3qb35nVezP
         WTSy9n3N96OsvKpqOgj4OsrM+CgE2VJOf/xGWT44Fbz6F6OGADwFOxYbRJVGkIOKP8iR
         8/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747995706; x=1748600506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhYYFU/0gd4i6u7YSldc/A6P4zLJhDJyiOeiCd5c27I=;
        b=kIMgjGxj1fRmqVXR2oLFQ4R/tA3pBiHZ/u5JYHKYi0+dnT60JW7xyBV/1j86mNLHNy
         tnMFFtOS7ZmGwK2yOSHJAfMlyHyq5QU1DGH7WFcNpvlA6HxFtyhcYowI+fMf/fVWdmua
         t/iWG01mEQ22lDnZc4QTj6ewlGwrNVjqxD3KC+j9m1kOOtNdrqs8IhamR39zx0M3JOZu
         yQrJQHkm15kWbIFY0F+1iwf+MLUZZ3dWxm17NMhBTtJm9Ol9A7BacqgT3GqOSeFnvVm0
         CvB/lD+VSJJkLndrEOpLgoWQHMTPgeqNwcIGlU67ZVbR61akrV3cbP40B6t2ILOcbNBb
         pPtw==
X-Forwarded-Encrypted: i=1; AJvYcCWB24+H47GWAj1XkGl/8bcglGXoiOiKBH7Eou2bWoCAx56BHwC2jKPH4GND6eZpmRIs5l0oXQA3Qr4blJHymGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0HYoMwz6zq0tzwtuSBew5Mp0kQrMcRF2s8cO8YQQqkhdpBjWr
	E6XPuSU+9wYLz/YvAKnBm33jqW5WJNEzvYN90SvUJ+EoX1R/kv6PGeBzC1Z17KHWCxQ=
X-Gm-Gg: ASbGncuWj1oJ+f45saNdYL7CXzKg8w48NonVd8kRqG83mgDnB6WMDZZZpiQUJC+Awfe
	Jd27ApjnU6XViNkP+G11qYLKmaCmkdxms52+wZKAXi7Gme3Rt82WrivUlppvoeN3+k5YiNzUCUb
	vziubaxsDMD3PR5ZeMwg9X2GICSZT40eCUO0Z+fEVwpyQUqlbH/BoLBYQn9sR/uvkfSvgs0eIsG
	3lF84esWQNQPiEKwW+CDbMv14ISEOi37LlzRcb6KvMkG7VQiXQDF2kQ8xSP4Cc8Go0HNjlowuqo
	np/SbXmOuLLr6YBkUk9hO+J0C1eJ7DpB9ci94Z1EQ0dPSA/BliM6
X-Google-Smtp-Source: AGHT+IEW5zIvgGrf4J2JPU+RfVPEVNYeolq5lDuRr8EIG1ZwFlPwY4rwwgkEvYtvbmxBwdf6M7Mlkg==
X-Received: by 2002:a05:6a21:a342:b0:201:8a06:6e3b with SMTP id adf61e73a8af0-21877a7d9a8mr5649742637.9.1747995705993;
        Fri, 23 May 2025 03:21:45 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829ce8sm12466688b3a.118.2025.05.23.03.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:21:45 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v8 06/14] riscv: misaligned: request misaligned exception from SBI
Date: Fri, 23 May 2025 12:19:23 +0200
Message-ID: <20250523101932.1594077-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523101932.1594077-1-cleger@rivosinc.com>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that the kernel can handle misaligned accesses in S-mode, request
misaligned access exception delegation from SBI. This uses the FWFT SBI
extension defined in SBI version 3.0.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/cpufeature.h        |  3 +-
 arch/riscv/kernel/traps_misaligned.c       | 71 +++++++++++++++++++++-
 arch/riscv/kernel/unaligned_access_speed.c |  8 ++-
 3 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index f56b409361fb..dbe5970d4fe6 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -67,8 +67,9 @@ void __init riscv_user_isa_enable(void);
 	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), _validate)
 
 bool __init check_unaligned_access_emulated_all_cpus(void);
+void unaligned_access_init(void);
+int cpu_online_unaligned_access_init(unsigned int cpu);
 #if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
-void check_unaligned_access_emulated(struct work_struct *work __always_unused);
 void unaligned_emulation_finish(void);
 bool unaligned_ctl_available(void);
 DECLARE_PER_CPU(long, misaligned_access_speed);
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 77c788660223..592b1a28e897 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -16,6 +16,7 @@
 #include <asm/entry-common.h>
 #include <asm/hwprobe.h>
 #include <asm/cpufeature.h>
+#include <asm/sbi.h>
 #include <asm/vector.h>
 
 #define INSN_MATCH_LB			0x3
@@ -646,7 +647,7 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
 
 static bool unaligned_ctl __read_mostly;
 
-void check_unaligned_access_emulated(struct work_struct *work __always_unused)
+static void check_unaligned_access_emulated(struct work_struct *work __always_unused)
 {
 	int cpu = smp_processor_id();
 	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
@@ -657,6 +658,13 @@ void check_unaligned_access_emulated(struct work_struct *work __always_unused)
 	__asm__ __volatile__ (
 		"       "REG_L" %[tmp], 1(%[ptr])\n"
 		: [tmp] "=r" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
+}
+
+static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
+{
+	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
+
+	check_unaligned_access_emulated(NULL);
 
 	/*
 	 * If unaligned_ctl is already set, this means that we detected that all
@@ -665,9 +673,10 @@ void check_unaligned_access_emulated(struct work_struct *work __always_unused)
 	 */
 	if (unlikely(unaligned_ctl && (*mas_ptr != RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED))) {
 		pr_crit("CPU misaligned accesses non homogeneous (expected all emulated)\n");
-		while (true)
-			cpu_relax();
+		return -EINVAL;
 	}
+
+	return 0;
 }
 
 bool __init check_unaligned_access_emulated_all_cpus(void)
@@ -699,4 +708,60 @@ bool __init check_unaligned_access_emulated_all_cpus(void)
 {
 	return false;
 }
+static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
+{
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_RISCV_SBI
+
+static bool misaligned_traps_delegated;
+
+static int cpu_online_sbi_unaligned_setup(unsigned int cpu)
+{
+	if (sbi_fwft_set(SBI_FWFT_MISALIGNED_EXC_DELEG, 1, 0) &&
+	    misaligned_traps_delegated) {
+		pr_crit("Misaligned trap delegation non homogeneous (expected delegated)");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void __init unaligned_access_init(void)
+{
+	int ret;
+
+	ret = sbi_fwft_set_online_cpus(SBI_FWFT_MISALIGNED_EXC_DELEG, 1, 0);
+	if (ret)
+		return;
+
+	misaligned_traps_delegated = true;
+	pr_info("SBI misaligned access exception delegation ok\n");
+	/*
+	 * Note that we don't have to take any specific action here, if
+	 * the delegation is successful, then
+	 * check_unaligned_access_emulated() will verify that indeed the
+	 * platform traps on misaligned accesses.
+	 */
+}
+#else
+void __init unaligned_access_init(void) {}
+
+static int cpu_online_sbi_unaligned_setup(unsigned int cpu __always_unused)
+{
+	return 0;
+}
 #endif
+
+int cpu_online_unaligned_access_init(unsigned int cpu)
+{
+	int ret;
+
+	ret = cpu_online_sbi_unaligned_setup(cpu);
+	if (ret)
+		return ret;
+
+	return cpu_online_check_unaligned_access_emulated(cpu);
+}
diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index b8ba13819d05..ae2068425fbc 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -236,6 +236,11 @@ arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
 
 static int riscv_online_cpu(unsigned int cpu)
 {
+	int ret = cpu_online_unaligned_access_init(cpu);
+
+	if (ret)
+		return ret;
+
 	/* We are already set since the last check */
 	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN) {
 		goto exit;
@@ -248,7 +253,6 @@ static int riscv_online_cpu(unsigned int cpu)
 	{
 		static struct page *buf;
 
-		check_unaligned_access_emulated(NULL);
 		buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
 		if (!buf) {
 			pr_warn("Allocation failure, not measuring misaligned performance\n");
@@ -439,6 +443,8 @@ static int __init check_unaligned_access_all_cpus(void)
 {
 	int cpu;
 
+	unaligned_access_init();
+
 	if (unaligned_scalar_speed_param != RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN) {
 		pr_info("scalar unaligned access speed set to '%s' (%lu) by command line\n",
 			speed_str[unaligned_scalar_speed_param], unaligned_scalar_speed_param);
-- 
2.49.0


