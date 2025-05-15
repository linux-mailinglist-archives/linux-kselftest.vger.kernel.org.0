Return-Path: <linux-kselftest+bounces-33054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CADC5AB8079
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 10:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386373ABE0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 08:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F4B296719;
	Thu, 15 May 2025 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="EK2gjO+q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204032918FF
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297436; cv=none; b=MLJDMmXqp3mDk/W2NYYpymYgI13vyJvOFn2rj1VRoFlvJLqGERyLc5cUAEOqPi3byYQHMVBw9IdZm7wzoLsrP5gQ9EYiXwAiivLK03OzS2GQ3a6euFahuAOkPLW+yQVzzmwMYkNrVGyYHDrFlJcGm0pjvIwhGI8Rw/zOET7SOZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297436; c=relaxed/simple;
	bh=MaIrwOKv+YVVxdhE/r+zc5gTHYqZ311Osy8lrbnqATY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dr5hFGBUr4JslCMo/nZJ47Dxwdwrtd5UeEI7T1Ooj4gCJ5x/yTmKJq6N4CoQgLVPfuCLa80VOwn09SI8QUNMU6rAn/+7qgOH1GhQXAt8O5Ri2N5cfQ0fdIFk+/asg8HjSjsVLmkgzYgbK3VW263j3jCRv1qBzfwIolUJG7JIfe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=EK2gjO+q; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a1f5d2d91eso342264f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 01:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747297432; x=1747902232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iF+NUUhZJ5jxYVuPSRzuPMezDiacMrJKv4fNDBdRi4=;
        b=EK2gjO+qaczb3fcaIgJO9UwDj16ed11AoFoahsgYGSPGpoJxK0u2vB27BUMRSN917a
         0B5x7CJ8QdSumLxLUOTSRaFuqNO5CWt4HlZ5VZAAaDOKaRpeDBTUnL+7yAJMqZMcJdoH
         oDGxc6BXbBveVJKLIm6TqRJkghM+L1gdw2MWUHdd+0QUEeoIn+i/9hXBzk19TBCqhkeT
         WsWF8g+oxOKFAW0zm51XIPYIKPO6g1G45oXunHjqgbNa4y3eRMIe+3VKWV236oTzoolM
         +5MTxDqZqTAckpT1HMobwyef1NClMUw0Qv5xrSYhWXVYaJfFIBfCy9gmDz5JAcH/a9zB
         moNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747297432; x=1747902232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iF+NUUhZJ5jxYVuPSRzuPMezDiacMrJKv4fNDBdRi4=;
        b=SILdF7kW43nKQO86TnyKLr74Z2BfGrbNyk4FujxeeeyauiTr4UzVQIfMhaY5+q2R1A
         y2Hl4xwsIxY0RHRpX2EWR4OATVWO9GNKJFGBneBl7KOKKEMezdhEn/dQK+mA1/qAoo5o
         ihOvZG05qibxF9nJmR7BPSnly5ug3lqs2HidQ4rc7k1lshjf+fqkXhOi+YobyIxurNXq
         uV2SPUdcNWy09B0XD2XpOKOWotf/qahxNRZbzIS5BJJcR+g0KA6ZJI+LpZzwF+8hsOT0
         xjswBri8mRREL+b9ARJdodEpZwESVTBnOarHm35mr6dPd/C8O7FaUxlEQaGkQAmY5PnL
         L6pw==
X-Forwarded-Encrypted: i=1; AJvYcCWH/W0vY9vL6hlYEGxcxEo3Vj1bFXzrOFNRewwPCC4/KQH219TIpV/lQWTYPXoRvCycs/B8shkbTE3amA0dVzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV7kEDOImXQ4WAQRRh44/8HL1ZqgjG+F1xtS9izEKkhLJhWlnW
	1N07lAtNuoPZ+8C/ddcShgX9RZvXUcJzEcEV6FZJ9ygjb1pvARTjwMEuj5gzPEQ=
X-Gm-Gg: ASbGncuy6n40pmTxR8KOxuvnYrI48/xdfoEua8ShyqYJoejMWBnA/2B+ZONhTYPYWhq
	osB3nhimvORWZPB1jKn/9rrzYIZqN/CfJtwaxwzFnjp/Lj9SE+1znSSL4kM71AdnwlIqirCVXGy
	qlACuMYM04ZQC45EEpfkbN2XEXeA/9zNAkIu3xgki63cxTjm6+8n6+zlxcK6XMrke87R0DyjMs2
	w89dScPvkPJct2JypvAR82ZNzvAjrvgIvYBhheAdXvNG0nVvAzG7oJJ6llBp4xqN1JF6Ug0NSHm
	nmF7CAkSFx/o2h4CJZphzxVhhU3GwXeC2quyn4yQb8SWFbdpYzuxFNUKD096Ag==
X-Google-Smtp-Source: AGHT+IG/sxfuxXzoVLJQzgwnpP2BoJhjD/oKnctxBNP0O5v4fRD4OfvNOZerKN94X8y7ctt3mQZ17w==
X-Received: by 2002:a5d:5f8e:0:b0:3a1:f535:e9be with SMTP id ffacd0b85a97d-3a349694ac7mr5405960f8f.7.1747297432412;
        Thu, 15 May 2025 01:23:52 -0700 (PDT)
Received: from carbon-x1.. ([91.197.138.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f395166fsm59310785e9.18.2025.05.15.01.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 01:23:51 -0700 (PDT)
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
Subject: [PATCH v7 07/14] riscv: misaligned: use on_each_cpu() for scalar misaligned access probing
Date: Thu, 15 May 2025 10:22:08 +0200
Message-ID: <20250515082217.433227-8-cleger@rivosinc.com>
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

schedule_on_each_cpu() was used without any good reason while documented
as very slow. This call was in the boot path, so better use
on_each_cpu() for scalar misaligned checking. Vector misaligned check
still needs to use schedule_on_each_cpu() since it requires irqs to be
enabled but that's less of a problem since this code is ran in a kthread.
Add a comment to explicit that.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/traps_misaligned.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 592b1a28e897..34b4a4e9dfca 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -627,6 +627,10 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
 {
 	int cpu;
 
+	/*
+	 * While being documented as very slow, schedule_on_each_cpu() is used since
+	 * kernel_vector_begin() expects irqs to be enabled or it will panic()
+	 */
 	schedule_on_each_cpu(check_vector_unaligned_access_emulated);
 
 	for_each_online_cpu(cpu)
@@ -647,7 +651,7 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
 
 static bool unaligned_ctl __read_mostly;
 
-static void check_unaligned_access_emulated(struct work_struct *work __always_unused)
+static void check_unaligned_access_emulated(void *arg __always_unused)
 {
 	int cpu = smp_processor_id();
 	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
@@ -688,7 +692,7 @@ bool __init check_unaligned_access_emulated_all_cpus(void)
 	 * accesses emulated since tasks requesting such control can run on any
 	 * CPU.
 	 */
-	schedule_on_each_cpu(check_unaligned_access_emulated);
+	on_each_cpu(check_unaligned_access_emulated, NULL, 1);
 
 	for_each_online_cpu(cpu)
 		if (per_cpu(misaligned_access_speed, cpu)
-- 
2.49.0


