Return-Path: <linux-kselftest+bounces-30670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F401AA88074
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 14:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6BD816A3E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 12:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ACA2BEC3B;
	Mon, 14 Apr 2025 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gz+LTD9f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF627C873
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634158; cv=none; b=stPQuYsYO0pXmeyPEzrGPAVKaBlv0XQxw6h9yGkJ/kcCdY3Vmpws5/IM/hpX036QhIFvpMr1BzHF/DZXWShr+dVME5XknUvc2hSeg7FHD2aUCM7R4sm/lIFzM0PWtajpDzLAUxsGGxbwfvPWju2DlH3az1rH6QuV2c0DG8bL4W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634158; c=relaxed/simple;
	bh=zcZ//fDP0qsHY11ukqykT2yYbZXQ9AKkBKS09YdRiG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FjAZzaOg9M+b60n7khvUL+8mFAJMXlGQ+kMHfY9pIaB3ZxL09Vv0xfSZKG/9zyCfaPJjbElLKuSVo1P5qLZBCqTqmZcjpzC84gpKi/TEu13a2fXyjBR7Z4t2EMePraUapHrnkuklYbwpXI+u9zK12sZlsNzM98FcnXbyZPaJ0Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gz+LTD9f; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c266c1389so2875748f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 05:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1744634155; x=1745238955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68pbaLtpMYwVIsLVPcwWXXG5wNjqWZdJ0gKFjaMSW/8=;
        b=gz+LTD9ffwBihBbU+QL6qJJEcdD/1d7sNV/NMoecuHcuYNj0SKC5ofRa/2BBYSGIdZ
         VzawxuL4P4RzaZCH/WeVTG36FuqWM5TSbjS8cjqdKbLYYlDxAPMHx1jqE/DCSzbBVlMf
         kCFVOrshMYuxlIJ43unY4Xb5AChbaJK4u/1sVsbMlKKmW7GF6kekjVC72qJjNHe98yh9
         9QhorOEeusM6JWyatc0otRUGdBAITi1nuqnv3EPPMdXdmoiFtjpIyM9hUoRs0ZVNM4Rj
         6eW9UpIU+bXw81HKctZLsQj86UYmc1t2g1M4lxmXz9NHioAxIb3hJrIjb9lREVCsow3g
         znXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744634155; x=1745238955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68pbaLtpMYwVIsLVPcwWXXG5wNjqWZdJ0gKFjaMSW/8=;
        b=PaoRtSgA9swx1NrqkhEfYtGMo5LusVYdxZQv27DH/DfW2OzEeDdosJBQL26yu/DXmw
         aGQyPjIizwqoHY2t7VmniEJB+QMtHTuPdOTt+nyh7/Ekr6A4iqXpYIHo63UQiXJBHjd4
         b5NsM7Z+JcBRwm42ONvTYxpXw+7l693ToLwxF1hzFqCB+3qW8BzXCXmGI4qkn8jcH5J+
         cjGp/eEckDo3K9ZYnb8Gtca0flJo52QK34TNVR4lxj3MeoqurwlqZhHRheT5gCzQeUDk
         Vu5w5FgXSRDgG0vGhCdtiD6VpBV+7XkSle/68vRaJEBPLm/6f50AEtodJBSrCQ27me7Y
         fM5A==
X-Forwarded-Encrypted: i=1; AJvYcCXLh/lkhoUCCBWEAbkE5tVUNfCnSogCgMaZrvVkpd0LsTcv5SEXcPLhZG27NukXMODNhK3nhLkVM1duMuF2BYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmFP4Eg5YpnhF/qtgksAQLxrXv8s6gTdGiK89kP1Al6Cq6ZcDX
	aJ1g4yOSZfY94ZH0k+xyYF/MCxkSvYNkYhxqZJa4Ktb6RIA3PZpr1z9gCoUf10s=
X-Gm-Gg: ASbGnctJJBLTzpyVsE8XbI2G0uacQfzvoxM6gaZ8I8C2w4upchnCfiUhNHjMB+mYtKX
	Arce+xiufXlRE6cnjQD3vIv10L8PqOu+n34W5WLZhAObIsrcc3wFr++eH/gqFwESbow4P8gA0fm
	3asej042/h3l8F6wdrkuq+VsiYGUpyg27tBuaoxlIzA0ESprpAQT0BmkTAXfuA7W1oTtsoAushc
	F4/ssogiqa9mMs8pdVRvE5gOO9Mf6XetXwji4bxsKkhWPbH6R1zWfJdVH5+FP0IvIkynWCuO0oI
	/kBcyZW8i39yn3Vut1msCdRq8EMJLGBs7LXQznRQ7Q==
X-Google-Smtp-Source: AGHT+IFbK/KsiJbbEgc4z7Wr5HZ2HsrmZowacWDhKFk2K2SS3hDxowzVqH4JTYQk6zOp8F3mGhATxg==
X-Received: by 2002:a05:6000:250c:b0:397:8f09:600 with SMTP id ffacd0b85a97d-39ea51f5717mr9014815f8f.13.1744634154552;
        Mon, 14 Apr 2025 05:35:54 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9780a0sm11003166f8f.50.2025.04.14.05.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 05:35:53 -0700 (PDT)
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
Subject: [PATCH 1/5] riscv: misaligned: factorize trap handling
Date: Mon, 14 Apr 2025 14:34:41 +0200
Message-ID: <20250414123543.1615478-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414123543.1615478-1-cleger@rivosinc.com>
References: <20250414123543.1615478-1-cleger@rivosinc.com>
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
2.49.0


