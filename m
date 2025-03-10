Return-Path: <linux-kselftest+bounces-28639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93380A5997F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 16:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817C316EDF9
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 15:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D382422E3F7;
	Mon, 10 Mar 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="phyKIH0L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB1022D4CF
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619644; cv=none; b=V9w4gqeSd7DgSHKNKfQr8knbK7j6yp5TiufBCKHc5TSkrQrBLLt/hcx2k8Ozg7k0XnK8bzciQ+/Pu/JrSwn7tLMryNJVqrJKaz8iD2jqjcYaKu3XG7vZL7GrsZ0w/51pJ5hf1/ZzILPhzEqQzmufV+EWJnS5CsKUX5bZkvPKouA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619644; c=relaxed/simple;
	bh=B4l5ww4xM3ybuxVDnFD7O4s6SCugiqPi0tOYv0B/adg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6N/X8UwZJOgZS6Jdv7x8MxQuTeitRbHJ1N3xUZcqP4E/7jSyGR7e2hzW8XC74uE21hVeU9/s4TTeOiwmCb2EucR3UO6/3pKM2Mffd/ppDMg1TRezYKZaQ/l1udAS0hsEjGU7WxXu9eNjV0HOEL7oFmwn9G0yaKyZbC/j0t4RpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=phyKIH0L; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22398e09e39so79079365ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741619642; x=1742224442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9Vwlc46bZsQyt2QxW9m2l1M9vTOam7Mm6HyDDfLEZk=;
        b=phyKIH0LB85yJ+LguS7wKtU89NW1nV7XXxzNvx9aR+JVuimcTKgh1gW7BD+Qb8tM7P
         kFXzFlnt2iMQJMvrt1wmretsUcNW/Q3G4gIovHKC9kYALAIw7xGZiuFLoTkjgXipYm8E
         whBOyPY8lGh/D/lRk0QpQJAsiOWhpGvxFvpwYsy00ieeJUFDbWxx9gsJgxbI7j++ANhY
         /IzdOnBb+m8CsqYjjuOgIwoYfGdb/9KNs20lvaFsJGK7wYtpSGjFVi5ffjaFDIQ1eoEo
         9Sxqf7E+iOFYsuB8xshlSYOrRX5lms7JPrfx1rNBagNwCLap4PrKxSoxtI+h2CF5jCnl
         wYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619642; x=1742224442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9Vwlc46bZsQyt2QxW9m2l1M9vTOam7Mm6HyDDfLEZk=;
        b=dzT6Saz6C0fbOHw6DWX+i0AaU7EGGPCf9Qg+qxz4Qi2wkOp2TGytA7KiSkdowZfCPv
         HaWoYHkRPMMESd8SyigvprckjgHV6dicnszrtEIw0JJlucMm4TN/bB3W+EaDGlnhCeMP
         JEzzzSaegFyWi9pe0T24/Jp4Be3t/iUt3ja9I6n1tDFIsxgWQE+qWcNQ/Ul3dr+qTn2j
         Rcs1J2sDlnQL6xHaBTlHtnCroKQlorxNueThGHmVAmsauNU24QewJWYzo4t6mNYKFPtf
         ij8Udj961dFBBN3XWqxQaDUkQKDuc1H2vaL5Aq+piGAnt+Ns/qwRiKClX8GmZJbf1X1D
         ra8A==
X-Forwarded-Encrypted: i=1; AJvYcCVooDjB5vZ08RJzMJw2Ejswlk7tyP62wHpL6cG5odJj35TR6Sd0pdgH5QyX2n4WqGGYlrHFBBxGiwogwa6m998=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjdHbn8EUw4VAmxEbamVHDx83gYpU9S5bwyxrcvJv181XCEhfJ
	bw3FbUn77b+55irKl+HYhrp8Wu20wbyJRkUVl2C83kaHVfHYFOghlJJN2FeCXt0=
X-Gm-Gg: ASbGncuMIO+xZDWd87CNcB/dOPEVodHzGV89dzyjD4eGh+E9CwZqpjtDtgNtYUAZ9Ab
	9QG4S6ieUsTlzAyxTi3dUqgWkcfIY4/8nTtM0zOidzAEaYfcdgEJWyNIZM6srivDWis+yDaAQfy
	MQ+2OwQ6snbd+aYXw0aiIdhj14znMJQ5BdOlgQ94pblsMXylGBK4PzOKGTLjS8IE8ulAUVDTDnc
	f2iDFg0FD+9YY4irv3yri2SdY8kxd1czZiCpd0clTqbJzER1brLg5qnatjHSxyproGIZM2smR6t
	CBi8tGKmfy1sN2epKShwC0EeDHNV9Dv176XG1sJc7ZWstA==
X-Google-Smtp-Source: AGHT+IE/Wftdkd3zlZdL/ywUH78DLaDAVcrFF4WfEuA9Q1JYQZM9C8xhDZMPOQ9HkccIr+uMejIbbw==
X-Received: by 2002:a17:903:298b:b0:21f:4649:fd49 with SMTP id d9443c01a7336-22428c221dbmr239345965ad.49.1741619642512;
        Mon, 10 Mar 2025 08:14:02 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm79230515ad.91.2025.03.10.08.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:14:02 -0700 (PDT)
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
Subject: [PATCH v3 09/17] riscv: misaligned: factorize trap handling
Date: Mon, 10 Mar 2025 16:12:16 +0100
Message-ID: <20250310151229.2365992-10-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310151229.2365992-1-cleger@rivosinc.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
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


