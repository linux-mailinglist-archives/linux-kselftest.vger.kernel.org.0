Return-Path: <linux-kselftest+bounces-26253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049DAA2FC46
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 22:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2FBC3A2805
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 21:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E51A253F0D;
	Mon, 10 Feb 2025 21:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lMnD5CEG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91802512EA
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 21:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739223377; cv=none; b=g9bRsO0eSWlgUdGeG76nmRxI9BbmSsb/I95C/wimMcygTnInLCnrofLDA9IEA7zlYhrmv7eUmtw7VDte3fteIgTqYPfmJ43UrGY767pZ2u3jp+jVvfMKfgpScjm15f0qb2EUDAw4V2HjXDyORIcmSRj3F6tn+iSAdwiO+mUBBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739223377; c=relaxed/simple;
	bh=B4l5ww4xM3ybuxVDnFD7O4s6SCugiqPi0tOYv0B/adg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aruVUB5SZTMzdeiUHZshsoRqoaFKN8vLH7NAQm1yAJP1d9JQ10Cryug5UklN+MqZAWGqHz+COY0qjnyW67kXNngrLpBZjdERykf2eCrcsA/JgLafDhXGGCG+5jxb7dK5GHG70Y669NqLCfswh3bVJLXAJbHvDBbVcd9D8mrkgoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=lMnD5CEG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43944181e68so16084615e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 13:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739223373; x=1739828173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9Vwlc46bZsQyt2QxW9m2l1M9vTOam7Mm6HyDDfLEZk=;
        b=lMnD5CEGFmwiNpSSMeoO/Ijj/7bK4sm+7xlJhbqHB46ItuSs7YjGvWsRNeqtq+F7gU
         8kazmQuKtzPzM84J2JMdTCIwzHWHPsaloE3AvmZHNnJWFEoXLZThW1k9yI/DOJ4Uktgd
         SGkpLKKsF7mONDnKPyp4LDutV65sFEahCgvWLW4+PebcS780PaGFlyekCr6JPbc1qlGJ
         FfK3ftWt025K7F8L+t44FdUjC9hfnz0F18ep0z3epCdy7VdK62pAmapa1xg4kd+U1yHU
         XVIm6rUw6quQ/Y59o1zqZY0loMfzEPfUj03Rkz1/3XaWNPEE2sLd9KyEg/IFkEiL/EVx
         11Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739223373; x=1739828173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9Vwlc46bZsQyt2QxW9m2l1M9vTOam7Mm6HyDDfLEZk=;
        b=oaiJguq46ZplpKZimhDg6Z+4/PNzPm5n496CFYXwa+zB3JlhXQvjq6KP66ZcalIPCl
         k2aU7hLB5FLr0+b5KQSC/3c2X141GPasV83CQUqAtD7uQCZOqS8hBzbzo6GFu4b8R3hQ
         6cLUOfunFYJfZDF8dTw40/3VsIuALmf6SiK+kO+LJGpLCk2djMwwcvvZPeWGwuQT8u+G
         QmKdGzmPAjJhOvFxMTr+3qeImFkcgTZ2ny+sszaSF3ROTNLNOXcYpCY6Kl+Hhmm1z1lE
         ArccxU4Qy7wwkYAz/nKVuYRhaG6OTLJmEhxGBN9JZlc7pyEx7RDUpDOJV8U7nwnB7maH
         /IuA==
X-Forwarded-Encrypted: i=1; AJvYcCUkon8BtPT0uRrNnFmqgIxaoGvqBIfCf1wliY2B/dW2AQR0tm67IJY/389UOwikY3bbGqrZjRnch6Zw8uzmqTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUuqsBw/W7d1Cnixd9RXoD6YZ6ZG1HZtik1r8XqrzWLvCSxy54
	Y+0MbwTCnNAYhw0ntboJ4vG+2ujITvW6ld9FvFYS4HxKRm8Nqo1+ojW++mSJLGs=
X-Gm-Gg: ASbGncugnTZGCnlDGeAy/JG0cUtqP3FHaJW0gTQ35tQIfdC1xzQHPCKSAvx2wGDikqp
	LJgnHaxGo0G7V0kJEfCKvFcEzrUzsiIj6oZ1t2eL7r0OLpD7sziyUbZY1W+zPk7A2V1Be0Adb7S
	UQuq7GZNGkOyBPF5EyxWmxglA35ymUGc+Bt4x660lCVSYF1Zoa/pFlL2cKdGM9pvXAu1WwyLVZI
	E5C9bfP7tccyk2FnMJLF9ZDjDpSJjmenP33KmX1WWQOjPt/OBHDjHOXOqZycMoQtnFlYIw3gmwG
	3mj67Y8MGreinSgV
X-Google-Smtp-Source: AGHT+IFIy2UHszvgSyStziow4xh4NgDeIiWhARHb24tahmr62iRvzSTuU8RezdSX8BLezNfYx/izdg==
X-Received: by 2002:a05:600c:1da8:b0:431:5c3d:1700 with SMTP id 5b1f17b1804b1-439249a7534mr117351975e9.21.1739223372921;
        Mon, 10 Feb 2025 13:36:12 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394376118esm47541515e9.40.2025.02.10.13.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 13:36:12 -0800 (PST)
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
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 07/15] riscv: misaligned: factorize trap handling
Date: Mon, 10 Feb 2025 22:35:40 +0100
Message-ID: <20250210213549.1867704-8-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250210213549.1867704-1-cleger@rivosinc.com>
References: <20250210213549.1867704-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

misaligned accesses traps are not nmi and should be treated as normal
one using irqentry_enter()/exit(). Since both load/store and user/kernel
should use almost the same path and that we are going to add some code
around that, factorize it.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps.c | 49 ++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 8ff8e8b36524..55d9f3450398 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -198,47 +198,38 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 DO_ERROR_INFO(do_trap_load_fault,
 	SIGSEGV, SEGV_ACCERR, "load access fault");
 
-asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
+enum misaligned_access_type {
+	MISALIGNED_STORE,
+	MISALIGNED_LOAD,
+};
+
+static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type type)
 {
-	if (user_mode(regs)) {
-		irqentry_enter_from_user_mode(regs);
+	irqentry_state_t state = irqentry_enter(regs);
 
+	if (type ==  MISALIGNED_LOAD) {
 		if (handle_misaligned_load(regs))
 			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
-			      "Oops - load address misaligned");
-
-		irqentry_exit_to_user_mode(regs);
+				      "Oops - load address misaligned");
 	} else {
-		irqentry_state_t state = irqentry_nmi_enter(regs);
-
-		if (handle_misaligned_load(regs))
+		if (handle_misaligned_store(regs))
 			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
-			      "Oops - load address misaligned");
-
-		irqentry_nmi_exit(regs, state);
+				      "Oops - store (or AMO) address misaligned");
 	}
+
+	irqentry_exit(regs, state);
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
2.47.2


