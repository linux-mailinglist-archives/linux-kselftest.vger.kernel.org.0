Return-Path: <linux-kselftest+bounces-33066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCA3AB8197
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 10:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68BC3BF633
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6FC289E33;
	Thu, 15 May 2025 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Y2E3n9FN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8615ECA6B
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299158; cv=none; b=TKbCt1m06J/ANFtsXoBPZSjs1WCX79S9Fm241SdHup+G/MHJwM1RRDlh49vC6z1aB6d9kAsE+Sizklrzpu5ipEmc+WO+hHOr6zVBS145OTSGiBzWfvJr/nPnGGa3zNptIXSX5xteN0GISfXfvKD+jcbIPFLwI7tThGy7VfMsKac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299158; c=relaxed/simple;
	bh=PGXvcUd7AEZN3/JlvOlbni86hFgiQ4HPyrDarRZ8hOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+sTAx3tt4UB4XlwvFbQj4ZiQrldEoAQsbmYPmHc+iyvXW+Zw2P4jTcib98khiUIQaLm1wycqWxcoNMOevqsms/HcXLitks/zEVzsvhyGr94yWPKuGSF7SabhGMhYJ5WtxALUmplxk3AbNW7HxaREzaDlP/MyjPWilz4a+farr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Y2E3n9FN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54fcffd6b9dso722656e87.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 01:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747299153; x=1747903953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhYYFU/0gd4i6u7YSldc/A6P4zLJhDJyiOeiCd5c27I=;
        b=Y2E3n9FNsFwg7KkZ4bjY5QisnRjya4qPfLIxbhOMFFSD+WGUUZEJkk8CwyyaF5UNnc
         bIp8fhD1v5ZuAPTRsItMIcbtMpeHIvyWqRuZZabnU0cpDD9UDtYBRVGA1en98JT83Uk7
         W3goy9sySq3RvFdNodp4Ispux6/5XgG72AqBlcGQ9YsCIhKIYgu2CKr9ZBGYrq2/ncTK
         DEv/ekCuV0TJk6GZwfeXCa5o0HQCxyPEIgCyAQZNqzu6JE80Am6jSa27xIy+qO3vHEqU
         /ZVMR+mJ6Ee8nW8BTad8Vfqe31uApMyut2//U6xYGZJKhumf2Hk0nnKBPykt23bAjkjz
         sOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747299153; x=1747903953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhYYFU/0gd4i6u7YSldc/A6P4zLJhDJyiOeiCd5c27I=;
        b=vD0Kid0Q3raIyUb0wgZ9zGk5ArNnHTOXZ9cI0n4huAlXx501BDMjs2nP8ekImLV9se
         7do7SnNG01nkZCtdoChi8SoIJ+8aWmTAJb34ZSnyEzV3Yy6WdZQ+5FLnY8yWR98KelU9
         NqibTWgoaALVZ0SXwK/ERL96ig4nSk/MqMN+FMcWcAY0JW3if/GIKUkPKk99II1Mvscu
         5NAtW7DS0L6UTeGOp0D1OTr6KeAQRQBBkqq2uUR0NlfSVI+prbwhUeelaSOhP9haOtIa
         RwAUj+XrgIKF/jzE3C7sZMhHDBct3XdDYpcfyfeqMG7Fw26yRt82WlB5gfWQMSBT0jrg
         vwwg==
X-Forwarded-Encrypted: i=1; AJvYcCXyicBCvxfgAJNQ2XNZy9hHkntmX29UI2zflli5n678p2EEFFODu3Q5HIc6rCWbCcXC508mIWAwJj41KMNK6XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwE3edssoLSpa84G/urBjUf1HRFXMaWkO5raRDxYQ4Q3bMJTbZ
	FWCROPVh7Kej7QlM5oV6nNJDqwDuJQl+5HVSSwPpXfFSUytGjHMJEf+ca68f0QaCq6Bq0/X9ZDg
	P
X-Gm-Gg: ASbGnctkZJWvkvXfAd/14y0J2lW+e3UiGPWUMI4ONDx+opteV1lZaAd/DVg+/1/gdQr
	bOMIfi5uoShP9PCBPea2INGWr7g+LinnarYwQcBRdd77IlpGlxK+mpPL5E6DV8W01Cn8yiXHIbw
	8mng0RVjtWFTczse8b+dkwIlHOR11QbCYN7NInSImsttXvjuUwAcCERw0T0PiTjITOdb6BkEoAh
	pXyVSOt+sY+Lp+ajQE39RYP6RW1OLmGX3hOZTOSFDl1ewnq2tyHwpfwBgFIrbZ3gKC/fL3eQfZo
	fjWkge/la67nW0+1aHCjzD3c+aI8hAsbKxpX+yfNZxC3yn+8Gu0=
X-Google-Smtp-Source: AGHT+IGnVdWt5OD2bKCz++KFVpJxcO50pC03iTHgGj6sIJhut7VYuKCl9xAAlL4aqjVD7tiXjB6LOw==
X-Received: by 2002:a05:600c:c0d2:20b0:442:f482:c421 with SMTP id 5b1f17b1804b1-442f482c78emr24654775e9.22.1747297431669;
        Thu, 15 May 2025 01:23:51 -0700 (PDT)
Received: from carbon-x1.. ([91.197.138.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f395166fsm59310785e9.18.2025.05.15.01.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 01:23:50 -0700 (PDT)
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
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v7 06/14] riscv: misaligned: request misaligned exception from SBI
Date: Thu, 15 May 2025 10:22:07 +0200
Message-ID: <20250515082217.433227-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515082217.433227-1-cleger@rivosinc.com>
References: <20250515082217.433227-1-cleger@rivosinc.com>
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


