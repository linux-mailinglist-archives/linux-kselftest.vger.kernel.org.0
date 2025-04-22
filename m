Return-Path: <linux-kselftest+bounces-31333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 157C5A97293
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 18:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B15168F24
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 16:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD5C293B5E;
	Tue, 22 Apr 2025 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="b5tYUKJZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E23293B5C
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339048; cv=none; b=FkmiXOWlWX98fUNUL8h3GqC/yQJyNGPBk5eOWvJG8kgjZ8egzNTyHD9C7CYSAwmWOxo70/672bSHnuWxxiXjmRMltmKd1O3mQKMMVV609bdkW3aQSvBS/qn02g5sk1/BEz3LnVsWJnc+PXEaO6PfeBhO4R2uXPlywCYdk9UdfzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339048; c=relaxed/simple;
	bh=3c04UkOrUox/J2FZTkrec1ceD/ayEJGwE5Hr0AcuBg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXe+3o6wEfMmIK/GoXV9k4PWAVIYGSjC1QReNNtm/GJW7mjYCcnuRddBQmLlzxBKBeyi98Xy1w2JK9n790E9bf2A0ZrzXPmuZyV2Mz216g9ZS4NPkPJ9Zi42lsgGNRSlmnjjiGPBDlmEtwVaSAimTgEb6ytkUZIB/p40yQJRLwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=b5tYUKJZ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736c277331eso14770b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 09:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745339046; x=1745943846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCsItzx1CW8cAI7eK80VGXHXyDDk8PWaNf7CXRhWciY=;
        b=b5tYUKJZW+Q+l8NimwxxdYqUK1a+y7fImJBjdhs1yiiVfMkZ/QhQ5kfBj+pUABfNGV
         9wQ4hRDc9b2MBOGcTkqeE+rAwQSD9DeWtWg/YFrbDJ7fBz/X/PqOlS2R9WMajqGmp1gd
         7SScYOVJndZv55id4twCSVqOJl093XQVDrXRqz8znaejBBZCE6sXhCEHulIoS5zJO/Uv
         83uO79OFdsVc6nzQ7pu+YcNBswNWY+MsIWfOvuiJgaeftlT9YpjEASLDahOjBqTYPhO+
         F5j1BlBsqpnyMOw2FNyG84amjSs8YVQBzPy5zFzkPVLUQiF/Hbhj+8wstHjskNhdllUV
         P0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745339046; x=1745943846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCsItzx1CW8cAI7eK80VGXHXyDDk8PWaNf7CXRhWciY=;
        b=pzTcJt+47AmhgeEzDKCePnvQQR23zL5/sdMSGnBe/vEjFHc2lprAHJLt2Bea7n1aNj
         LhORkPps4DdJpe9AfV+7vAD/V2hvh9eHid03eBc1tJbaKkoDQqZhWeJyJNY0v28+pIhe
         1xn7Y7OJFwJiVgJ1z2hIFnY+vDvJc4cd4ExtkBCIthIx6X5hqNNytz9U+GfWnxIJoGC2
         hG+zMkS/ovL2ZwIXkbPhFhO2YWeihER5I1ibWhR9DQNnv6ELEP446WPYkIPCvViAX5Gw
         WVVwtDjqaGlERjlwWDMEslSikO8fc3lSjY64oONRzO1MzEyQaiQ0Yr/PfTZsfoWxIB+p
         mP3g==
X-Forwarded-Encrypted: i=1; AJvYcCU1CDkG1looXiKqEOuu7Eh8p4h/SNuWd5nLpkJPA6YqxOKk3e/6P+IjvuTI5Gcc+yHBB2BsnqSlZc8XDE/3hqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhkZ6+7cKpW0HmJkh8W12sTUMQOm/tUhjlDmG8WfpSIpz7j6DP
	AiBya5lDcujBsXmZjpQYDVSXo/ntMxQKhlIXCcgO5Rdoj7fnYuSkfDaFjspSTnA=
X-Gm-Gg: ASbGncucd6szarQld7IM7YCPg9fIg0/aS9oPswc5/4/OTCMfg01l8qUiN0E2tGm0DRC
	h6GmnrtYWr24dRoJh69pT2HJyk9MnKyQ3fSWLS5CQ+hN4mnNkWDNpQ+OuC29WisoQfvtWmVRKAY
	wHJ4phQuFJQjVz0GajcERfZNjATdGwxuqhTsEVV1R7QXX84oZmRzQ2T1P+oETzqRBYBRqyB84is
	SM+Poufh3RLrAovIMsiL3D2qY/bBgQEIfTDzbpeVMxZQrx+rRXItidJBGEuJ4TyOJxdnsgxtNVy
	ASmv27rCJ/9cJ6rfqUprWzlYGwIqaVpbN+duzVG0EIJ50FvHZ26T
X-Google-Smtp-Source: AGHT+IGpp8Vb3J0UHalvNL44o+7PVRW8uyjzoX0zSKYSZndRHv6HkVGApSau1aMm3e/cFnTOOl9eew==
X-Received: by 2002:a05:6a00:6c92:b0:732:56a7:a935 with SMTP id d2e1a72fcca58-73dbe638b2bmr27078656b3a.12.1745339046287;
        Tue, 22 Apr 2025 09:24:06 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e13e1sm8850825b3a.46.2025.04.22.09.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 09:24:05 -0700 (PDT)
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
Subject: [PATCH v2 2/5] riscv: misaligned: enable IRQs while handling misaligned accesses
Date: Tue, 22 Apr 2025 18:23:09 +0200
Message-ID: <20250422162324.956065-3-cleger@rivosinc.com>
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

We can safely reenable IRQs if coming from userspace. This allows to
access user memory that could potentially trigger a page fault.

Fixes: b686ecdeacf6 ("riscv: misaligned: Restrict user access to kernel memory")
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index b1d991c78a23..9c83848797a7 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -220,19 +220,23 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
 {
 	irqentry_state_t state;
 
-	if (user_mode(regs))
+	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
-	else
+		local_irq_enable();
+	} else {
 		state = irqentry_nmi_enter(regs);
+	}
 
 	if (misaligned_handler[type].handler(regs))
 		do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
 			      misaligned_handler[type].type_str);
 
-	if (user_mode(regs))
+	if (user_mode(regs)) {
+		local_irq_disable();
 		irqentry_exit_to_user_mode(regs);
-	else
+	} else {
 		irqentry_nmi_exit(regs, state);
+	}
 }
 
 asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
-- 
2.49.0


