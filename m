Return-Path: <linux-kselftest+bounces-30671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BD6A88077
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 14:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799A73AB8A8
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 12:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B41A2BEC56;
	Mon, 14 Apr 2025 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FzZt6HVT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E402BD5AB
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634159; cv=none; b=neNRt4j70R8zYKlzWg/HriHwgX5rpL/oMSOvpsrrrdxADiwcVy6hjvNpGrzVBAcsEDC7g1xaUEcvc9R2uI+gA/SUdhfGxsjBwblQaF5W/J/T3gWcbgPXdGIw7on0qtOFgfMvoJj/GS/Dd0Zxj20a7L1xELWDB5+PmPUhsxoCHYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634159; c=relaxed/simple;
	bh=Sp08vMMklIHnRXWMXpzERONvQrNfVAASIS5bX53L948=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4U65pFG5/xtkM/JsqtxRSkqVSlxbSS3V3JY9vRr1Ub7c1clTC0hZb8NTklXQTST+UPJo5F74KMj9DP8gcFxo/TbOShGa+3MYb3eKPcgfFKnyRePaSGR1WUagN1Ouopeji/umOmljWLHYOFxfXPl/mp4xg3+0XZiXuzxNH+sJ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FzZt6HVT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c2688619bso2739844f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 05:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1744634156; x=1745238956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zt8QGDo/J4nI2rhGhXp0zTShJlIWRjHlpTKLd9eSTsQ=;
        b=FzZt6HVTFVHmqOkKFUzAtgCfzHisltnKBQ3oyK+RvCjQ3tT+iRmAMpTESsgti0x+FH
         FKKoI/Ng/MCpQpNrqTqA7Pg9atMN84VW4qfu+jIZ9civ0PAZH6FgFt9PPD1NeqbesIa8
         hRI3L1HAuiMD5n/SKLeWv5dqkG3Hs9FsWTIPQVVKzyKzstoH+3aN0k7CyETqxu4VG/h3
         02JkM1AFVgfjHAW8rX3VtIXICQcSDMCEWq1cz+mAZtWAaJ42Tb0tZjvRDDdR58yPjdYy
         WL3Gc7NWO2HuAlY+Y2PKb4WXKCLPI1lazlMv5okMP+EZMnDZWrlwTKBNVMmls6TP35HZ
         BkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744634156; x=1745238956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zt8QGDo/J4nI2rhGhXp0zTShJlIWRjHlpTKLd9eSTsQ=;
        b=AFYjsEyBxUPVy+vG9ZTuaoz/r+NRTcpSTRHRXSa47MN08Wben4qC+zjbZfT37XnId4
         uFFEL0f862inmuVXJBXnCC9FG42szzntDS9z2juV1RtMzDTmWjgzvelJX6hK6DCRC7aI
         XLZegL5A4fIgOIJ21K4/XHTzr07v4orjLc8pY4CEfyf70YTJVqIFIIGal1/BUE8Bm4/R
         dvVlUfNqPkme2yh6FWjOr1cUpWWM0RsvEbQ56Rd+7yfJ4PLtP3/gQ8gJPJdiR1ozud3s
         C4q6BCFidjJSP3zSEdwXAaDQyMn4UfGAayXyjNRd1IjNfNVeJq0ea68C0QVJfoRVRVO7
         XUSw==
X-Forwarded-Encrypted: i=1; AJvYcCVTkaUnET8t/WVq6Pjj3EIoMSJRYcCj9dSkmnw2IKa8XTE4p29zIgXG8viOsTl0iDB2kQTi+IRY0MnoU5n4FOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI1uPxsKnR3UQ+Ihv/pNMZxf3o13SMwJyZVXpJ1W9n13S8r11D
	LxiUWHr1Uk+HbTT4/u2o+VOwMs/Dk8yp6ATOyqk+zxrHGbs0459Ddqs2JobcLj4=
X-Gm-Gg: ASbGnctBB/5R9gghzv7lryXplBptzkEYGuX9O+kxMURIqBYK1i3aRMJxHnn/ZkzkYaK
	Qz2rxQo6ptSbv2VKVRZ4nHX4+rUy4mFnsNrB8HSz+u6oo8eMT4yBkvaUtgagngoB8aC1IApmnw5
	0I700s4WZdny2UsmgMSvOSEAtPxh1gxvWZ70Im4EV9u5dOdKS/EO2iFBxSYZ6y9M2CnVEBh8ik8
	V+/wuXwQk5w/FPrmfkAZzfPpL6XpUwTJIVDIJXOhSY531U3xNPVLpacPS5eyOiKcNXXeKPML/nE
	M17IBVCKm9vOcy4A7zD2alLvyL/ac8RAeru52oC3EQ==
X-Google-Smtp-Source: AGHT+IGzY8okLdys0tOKhwvB5BGgGvxVyHB5y3oW1MGsgoMkAqQECk7mk6Y/4ZzNlCEdPu9BMIDa/w==
X-Received: by 2002:a05:6000:40dd:b0:391:13ef:1b1b with SMTP id ffacd0b85a97d-39eaaea8457mr8319959f8f.30.1744634155589;
        Mon, 14 Apr 2025 05:35:55 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9780a0sm11003166f8f.50.2025.04.14.05.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 05:35:54 -0700 (PDT)
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
Subject: [PATCH 2/5] riscv: misaligned: enable IRQs while handling misaligned accesses
Date: Mon, 14 Apr 2025 14:34:42 +0200
Message-ID: <20250414123543.1615478-3-cleger@rivosinc.com>
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

We can safely reenable IRQs if they were enabled in the previous
context. This allows to access user memory that could potentially
trigger a page fault.

Fixes: b686ecdeacf6 ("riscv: misaligned: Restrict user access to kernel memory")
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 55d9f3450398..3eecc2addc41 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -206,6 +206,11 @@ enum misaligned_access_type {
 static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type type)
 {
 	irqentry_state_t state = irqentry_enter(regs);
+	bool enable_irqs = !regs_irqs_disabled(regs);
+
+	/* Enable interrupts if they were enabled in the interrupted context. */
+	if (enable_irqs)
+		local_irq_enable();
 
 	if (type ==  MISALIGNED_LOAD) {
 		if (handle_misaligned_load(regs))
@@ -217,6 +222,9 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
 				      "Oops - store (or AMO) address misaligned");
 	}
 
+	if (enable_irqs)
+		local_irq_disable();
+
 	irqentry_exit(regs, state);
 }
 
-- 
2.49.0


