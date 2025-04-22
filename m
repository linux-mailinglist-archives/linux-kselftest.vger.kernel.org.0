Return-Path: <linux-kselftest+bounces-31332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3116CA97291
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 18:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14843163C8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 16:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1570A293B45;
	Tue, 22 Apr 2025 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JdH93SHe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B0529347F
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339041; cv=none; b=O9Xkw2GkW7iSHY3/x664CgP/isuY9upaqfNTsNRXK8IQwbKpG6Ie+gov9Ka+uidWJ8Gt6+MjYEgrnSt/KNlFSYK6CU8RM9LT62tf/0UNSYk0W3Cnq4ji83wfQtw5prHP38zddRU7EARlg9Yi4IPbd0gs74ryS6v3dtW1C9APM/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339041; c=relaxed/simple;
	bh=V4nZxr4vEp4NslLZ6gP5Cj+UGh59lnUcLVrhxabmvA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ieg+oYA+t+kxgCE9sAZUbo+8I/fMB3BN+SKiU56qszj2NGSleC3WJb9FjASOugUmxDmIShRr3hEvcVPe6AnBK+N/7cLqXmItqrE8/FSpm6doyd4V7yaKKc2gMCulOEis28CrQHQGqUu1Zsx5CoduZ7K1lejYCY0YRkedt0csWGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JdH93SHe; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736e52948ebso6126286b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745339038; x=1745943838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmBbq7nPpmDt102f7nSiOG4D5hySZc1qJkWls9LUQzY=;
        b=JdH93SHel48IZ5OWTDCO0Wi55H+m9vSaDn9fQETtDX9rpGJrDCxLk759iW5FzLWp+K
         zUZc5m/3f4OLMJhdQnhYlUnWMQB3wRFscRinMeOrgus59tlTuFd4lWT5Y4LfzMz3IsGr
         58aXvdQSB4HPLTlAW8/PFnN9t6wiFsx37Egia87TWyYgpIcgqxmZMACUsu+rnt/KyuWQ
         VWOOCfLtklVqVvC3db+OmbICmkaPR5546b0j4Zc0JtI0thm56ODvxxVU85VD7JK0dKqO
         es8fUlzK1D35rNNfJTOVCASrzgPuG55uZGO8rzGCcz16Oo5I9mm1FqIO+bRw4KMHhadK
         wxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745339038; x=1745943838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmBbq7nPpmDt102f7nSiOG4D5hySZc1qJkWls9LUQzY=;
        b=pebWzaNnzSVZq7CEJLtX84lGDDsijBAc1WMi8aw7wUDOdAO2U1Ki2yIrj/Ff/JYvfq
         vXP0PIaLFrV6dt5LIWkHxwXylyhChVD2FFJxZFgF6cuU3zPT0isUYuSOnAdV5JsyTKhq
         F2GLAe7BeDnRUDTgIgrkfnXpT9f+J0ggYFhGnIgfp+B/dL4yYx/j0MwCcp5zSo2BK3vI
         YqLTxHaNanwY7uSpSZ627ojzMFfO1YZtC4qMvo2+Y1zKy+YfyvGbNxgN6RRfATVVHILU
         BlUee9GvncczJnrFC8ZBpUVlOQsm2cI9CKo29+CSxG54XRgSGlLG1iw4J5qA9uq/KB1K
         NNlg==
X-Forwarded-Encrypted: i=1; AJvYcCUrZ5UFjSsj+lH3ZySN3WgFGnJajqiIy/7BR2YjruWrGKFR3M+37F+/8qlRdfe53LeDS19CHMfie+cPMVPbSv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKMVG8q67hyZKB6ZEqIw37VzVnj9xbEa+TMuvAZV75sAUBv0oZ
	aqHIsooV8ed2gtYfTI1dq8A5vTwc1QGBLAOjvMbn0E3F93P6s0yufeGb9DlmnxA=
X-Gm-Gg: ASbGnctpNE2xmjNHI29l+9JCGpmA76coNjacWR96RHTAJyves8Vec8p2fZM8EonFKWc
	feXgZQ/tIRlaSCot94HeiXPyD7InSO9FYLlyjK/Cp8RQAT2PjTmhEiuLBqM3sZxDgeWCsk+zl9t
	RpEpTz7x42PWDqM7JhEVHfsLdLjidQC2vdO2bg8ga/n4lU3gGV+DADYWHPjU8u5TVTvOFKsYt9Z
	CD6q1NYPF55bM12jYQQiPeedl2bLqZnsy4u4FZR7pScy7iU6tCM75KKhBZTNMC3K1vuhyqdnJia
	ytpe+ESTRnWLQW4L7Jv4az3aiuLvycEh8CkE7fbHeA==
X-Google-Smtp-Source: AGHT+IHJ0hD1BX6oP9p44ibBdnegPGhkVm172MRAQDe1UgxH2sSUHeHwPJE2BCcGpoc9ezKvgoF/MA==
X-Received: by 2002:a05:6a20:394e:b0:1f5:8eb1:d5d2 with SMTP id adf61e73a8af0-203cbc5594bmr24479521637.13.1745339038438;
        Tue, 22 Apr 2025 09:23:58 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e13e1sm8850825b3a.46.2025.04.22.09.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 09:23:57 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 1/5] riscv: misaligned: factorize trap handling
Date: Tue, 22 Apr 2025 18:23:08 +0200
Message-ID: <20250422162324.956065-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422162324.956065-1-cleger@rivosinc.com>
References: <20250422162324.956065-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since both load/store and user/kernel should use almost the same path and
that we are going to add some code around that, factorize it.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps.c | 66 +++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 8ff8e8b36524..b1d991c78a23 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -198,47 +198,53 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 DO_ERROR_INFO(do_trap_load_fault,
 	SIGSEGV, SEGV_ACCERR, "load access fault");
 
-asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
+enum misaligned_access_type {
+	MISALIGNED_STORE,
+	MISALIGNED_LOAD,
+};
+static const struct {
+	const char *type_str;
+	int (*handler)(struct pt_regs *regs);
+} misaligned_handler[] = {
+	[MISALIGNED_STORE] = {
+		.type_str = "Oops - store (or AMO) address misaligned",
+		.handler = handle_misaligned_store,
+	},
+	[MISALIGNED_LOAD] = {
+		.type_str = "Oops - load address misaligned",
+		.handler = handle_misaligned_load,
+	},
+};
+
+static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type type)
 {
-	if (user_mode(regs)) {
+	irqentry_state_t state;
+
+	if (user_mode(regs))
 		irqentry_enter_from_user_mode(regs);
+	else
+		state = irqentry_nmi_enter(regs);
 
-		if (handle_misaligned_load(regs))
-			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
-			      "Oops - load address misaligned");
+	if (misaligned_handler[type].handler(regs))
+		do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
+			      misaligned_handler[type].type_str);
 
+	if (user_mode(regs))
 		irqentry_exit_to_user_mode(regs);
-	} else {
-		irqentry_state_t state = irqentry_nmi_enter(regs);
-
-		if (handle_misaligned_load(regs))
-			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
-			      "Oops - load address misaligned");
-
+	else
 		irqentry_nmi_exit(regs, state);
-	}
 }
 
-asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
+asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
 {
-	if (user_mode(regs)) {
-		irqentry_enter_from_user_mode(regs);
-
-		if (handle_misaligned_store(regs))
-			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
-				"Oops - store (or AMO) address misaligned");
-
-		irqentry_exit_to_user_mode(regs);
-	} else {
-		irqentry_state_t state = irqentry_nmi_enter(regs);
-
-		if (handle_misaligned_store(regs))
-			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
-				"Oops - store (or AMO) address misaligned");
+	do_trap_misaligned(regs, MISALIGNED_LOAD);
+}
 
-		irqentry_nmi_exit(regs, state);
-	}
+asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
+{
+	do_trap_misaligned(regs, MISALIGNED_STORE);
 }
+
 DO_ERROR_INFO(do_trap_store_fault,
 	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault");
 DO_ERROR_INFO(do_trap_ecall_s,
-- 
2.49.0


