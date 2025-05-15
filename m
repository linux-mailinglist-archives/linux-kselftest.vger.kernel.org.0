Return-Path: <linux-kselftest+bounces-33056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CD4AB8085
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 10:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9F41B65F4C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 08:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0301F297B85;
	Thu, 15 May 2025 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HGtgdR7N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECE8296D36
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297438; cv=none; b=gRJJRRnmKkSgPBDPn74FjeXo6ZSi24m8l99Lui3TZT+78CtLogTIhptNv6U9c0fGiNRodRm3mxBpT13tlYC1d3rlngW0fdhgAe+akrpr8QAm/uGojGZvZ0TxOxtiq9HUbe7twxk69eNM18hhOdwWxoqtFt6ZNxqX/VqMxrKZNms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297438; c=relaxed/simple;
	bh=gz6VvvjTGk7E1cSwi96lm1FYuCpqd61naCtEyUpjT8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViBroo9jhQUYsZlbAySa5DD7w+EBK0q7xhY9/j0Yz7CGK/bOXCvIDiLZyAe3VZvBdym6fX+qLX4JwIDyWZfBkPhkQBguZ21N8YvFXLE1SzT2UbL1B9jqzCy02V0khBLEhEAmH9lElLAYkOVM+g2Ng+IOjtJ73PFsLXeU6XnftEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HGtgdR7N; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-442ea341570so3956645e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 01:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747297435; x=1747902235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJAkm6pLaRGxiRfDXZi/YHgW/rz4khqaVw2vC12MUOY=;
        b=HGtgdR7N2fze2+HwtHUQlSYc0h6MLpSFAam2Wgs3kHeB+t1Pw7bmegiEWXH201YXmz
         2W7rY/dBuTk6Q+ypIOFetOCBMl/Zkz2nEbIP2wjW2Xm2Hae6LbIBkiVnb2KAW2Du7RXv
         qjldTeZnZcw9995U2hNh98kaHAxF22lmiGAVBsX1Rd9U+iNmqVzNQB+PwfzapWzQPS4u
         /coCS2w/8djBi5IyG1/xAjuu5AzkRsF3B85yWFK5MxZLeHXnWJXcYR6iYhXqnuY5tNLQ
         h9mwKny1ZYXWNL1yBW5VDbQTqrrFloUmFUQTA8Vy/iInX0PA20FARmG0WhepAqlHdx3A
         yJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747297435; x=1747902235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJAkm6pLaRGxiRfDXZi/YHgW/rz4khqaVw2vC12MUOY=;
        b=iGt+FpQWil1MDkkle/hutgsWwEd6ITEXNpItf0UlNfUpJu7aOkmyyMN3vxaDjlOqaf
         EPkm3XTrXZ4aym9tCzo7EavLMqdpzHXzUHCSXuYGsFU8VUFvfC0JOj1Q6kZlD6fffTeH
         0JgW3+M+bW7tMr5gDwrKxkEsQpdK9aZXXPlN1Jq8Li1uy59/D2v78NSAEUsbb7ydMnq2
         iVoWYy/5KFUqfuzno7P+owdZ3uNlq8oh7drgoWVTeTpeKLkWZUm1g/nsAAuzGN2ffGCC
         dnaYfq5aW3oCkjlZLVGIWNGac7WOK+d2I7lcfRkWS/floiV0sqPCF012lKnLSL9pc+mJ
         EvIw==
X-Forwarded-Encrypted: i=1; AJvYcCX39wmze+wlIhyDdXA5DZqRpm/9/XhGu2h4sdofoynupgssH7L2NL4S+yONoby1XjSRDTScKSIv1ibBKG97qk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHTPSBbicAHq/2sZmaBMW4f2AMllvdFSOcss5UMJ5YgU30MRUL
	bvVDwm/e4KEH/TqSt2/ikXUp1bmvdThMVVGU+Qfk7bZAk34M5drry5VWs2TNs6c=
X-Gm-Gg: ASbGnctidHVdI7nlWZAKq1zIngCQ/AcxbzN+bnp+rCWADeV3eFIzsM1KvTVYBRiin8L
	ef/8O1UlZICG53XnM1eHFMnf26g7Q+nGD//nTpe92YATDnhegAENfuKv2k9KbLGgkVX3S0egpox
	drEtUIlkqEECqRGKojK1MErrTBy0RAXKLvepfBmXVxUuVQur6aX6sB9LNJutdIuUSkl7+LY/SZb
	5SpDNadiJj+vqNtUJdCiDTmfyrekNCMb38dtg26hwCbkOpPvP83ft5eM5nIzA73e7woG4gaBYjC
	3lsbBroAQirnw43/TL0ONr+Q0qXi02otA1e/2RpbJLlzY0nhGb0=
X-Google-Smtp-Source: AGHT+IECzWumV9cA1BxSf0fk65MG1v936xTUBe9wcvvYI0imqbHM4JGZ7JFwZqaAyEUGXVqmxzPHUA==
X-Received: by 2002:a05:600c:6612:b0:43d:db5:7b1a with SMTP id 5b1f17b1804b1-442f96e75eamr14059925e9.12.1747297434909;
        Thu, 15 May 2025 01:23:54 -0700 (PDT)
Received: from carbon-x1.. ([91.197.138.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f395166fsm59310785e9.18.2025.05.15.01.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 01:23:53 -0700 (PDT)
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
Subject: [PATCH v7 09/14] riscv: misaligned: move emulated access uniformity check in a function
Date: Thu, 15 May 2025 10:22:10 +0200
Message-ID: <20250515082217.433227-10-cleger@rivosinc.com>
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

Split the code that check for the uniformity of misaligned accesses
performance on all cpus from check_unaligned_access_emulated_all_cpus()
to its own function which will be used for delegation check. No
functional changes intended.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/traps_misaligned.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index e551ba17f557..287ec37021c8 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -647,6 +647,18 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
 }
 #endif
 
+static bool all_cpus_unaligned_scalar_access_emulated(void)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		if (per_cpu(misaligned_access_speed, cpu) !=
+		    RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED)
+			return false;
+
+	return true;
+}
+
 #ifdef CONFIG_RISCV_SCALAR_MISALIGNED
 
 static bool unaligned_ctl __read_mostly;
@@ -685,8 +697,6 @@ static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
 
 bool __init check_unaligned_access_emulated_all_cpus(void)
 {
-	int cpu;
-
 	/*
 	 * We can only support PR_UNALIGN controls if all CPUs have misaligned
 	 * accesses emulated since tasks requesting such control can run on any
@@ -694,10 +704,8 @@ bool __init check_unaligned_access_emulated_all_cpus(void)
 	 */
 	on_each_cpu(check_unaligned_access_emulated, NULL, 1);
 
-	for_each_online_cpu(cpu)
-		if (per_cpu(misaligned_access_speed, cpu)
-		    != RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED)
-			return false;
+	if (!all_cpus_unaligned_scalar_access_emulated())
+		return false;
 
 	unaligned_ctl = true;
 	return true;
-- 
2.49.0


