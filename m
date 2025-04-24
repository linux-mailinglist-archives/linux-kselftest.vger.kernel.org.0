Return-Path: <linux-kselftest+bounces-31585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E010A9B565
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 19:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81423923C5B
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 17:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BBC28FFD4;
	Thu, 24 Apr 2025 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VWMZl22y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD7928EA7D
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745516108; cv=none; b=jirQSQZBn/FJhMYLbNZSxxB9XvrmUWYQ/wizJuDttAI3qC1wV9rseOe5KmU2YwpDZ+LCqHYqzVS8X1KwwDPhpzzA6dV/Hv+egE71x8g8BXdSNC890nTOtgpmaD2ywcr/X/5UQZMfg+Ge8aulQ6yfEFSsfeSGsExI/z+dRrY/io0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745516108; c=relaxed/simple;
	bh=dB1Aqp9jw5AsBzdrqtoxtIcKj/5RdGr1pHa5QHly7Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MiI7C4CviVeoNkPtAzUWWll8Mos8ZHDCahjQxA7qRY3Jvvmxbu5H6XhCT8C/RBTvJia2cJJQ3b2zsQkUw/Smo8HJVszg2U10oOAJk+HFAfj6p1BiZknUk1RnlxISm0bUYT6vKLQKLEPa47TLeZE5KtWnqeFHHWAjjKM0JnXWFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VWMZl22y; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22435603572so16293755ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745516106; x=1746120906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNDdi3bVRW98tMUmMa3iEbBTwqmvke8nqAL/FJxM67I=;
        b=VWMZl22yAGOgUd1DSj3FivEtJcHpvktTZq1d8gjDDi85aaMEuKeFdGe3yab70wlMuA
         xeEswMQjfHvl2PhvNrRc6vJ9nZ/ej3M3Qsb2hFxMDsjmrFhFqRXSj+huojn5MbbVqLzB
         YwGdC1Wb0k0XCHkijUEZjdcxQkptmT6MygU7VuFf5mS+U6UIkjO9z7+gRXeIQMh0pIyq
         GOh1Sh/lpDfF8YMEn7KBp2hAglT5IG+kS0YpBtdlfhXbOLFgO/bFDMrrxBT0uo3pJBtm
         ZAON01BhkqCERLz4soRDm6iJhwgjjoGUfVtXUbV5Ug3joh0bEVFgeoaLm2QwY6hImik7
         9MyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745516106; x=1746120906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNDdi3bVRW98tMUmMa3iEbBTwqmvke8nqAL/FJxM67I=;
        b=eocUuctoy662eEMJzorLP3OlkiBUGkY4CuXLI/pQQUdzoWka9BvmUff56Mg5Hiegph
         2SvRmbFmxIftIeIuyitOr+ceZKYwW7bKrT31ub1khochUZxcAvYgla3Ao+RlKcFT5KN/
         8wvbmjmIuUh9hGlhg2T4FcPB01dYxqTn6mY9IrAifde16DEiPXfclD3FuzxoCmAtP9H/
         NE5/Tco5iQ5g3SpdMbXWWGDI/G2herxT5KbjWmEaESkn7Nhen+y6KPL+axX8klagzugB
         aKMxyX07OMs8E4Xo+ip9N2cV+h5gOXrAR0hBNPuQNabxrv3fuQnQj85ergrybSma6eeX
         2yzA==
X-Forwarded-Encrypted: i=1; AJvYcCVF9uXJEQTKIQyJ3QBrTGgxdGYqyf4e7x9ZSGH/CUkdlc+Szmsz2rxuqyHWXIPrjSRdasf9NM/3v7GflPzKuAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSOHjBJloiHirLo6oUwE/fv80u5qkBbbBs5HqmqtXZRCB0lTee
	52Djs2UrlmvIpeRkqtdz2bLxyZJJn0A+cLUsqrHCb5469oyX9seqjCwj+kagmlA=
X-Gm-Gg: ASbGncvNiBbfoSO/cHuldRN8rXZD6JVqh8pVEaHhgKnfXVzJRD1ftvYqAS6idXpdGPZ
	CtS0VTU7rVD/PWLBL7KnWby0zc2KhdMI1hHpX21H4qgNM16tI7DY0xbfj0dAnjeF6dQ/sIJ3681
	RZ6N69iB9FRDtPYLAGkb9u5YnSm9yDkbEPW1cZEwrkO/kSQqbdEzmiCZ4XoxAudbJ1xoRRzfFEw
	Zn/Xu0aeT23NpW3S+kLA6wJG/FqJfEqCf49uVNMded6vTE8/u3Efl0Qv6QQuGBN+PBj0t/vTvZY
	HAoNLcYaKUbr27d3MumR1/I0M3GTR6pCCkmHMTg8GksUQCjeqFg9
X-Google-Smtp-Source: AGHT+IHgoxOdSwMCR3g5IpOqeK6qLMj0uu2JqSy/m/IXPMpoioHfXGrM09vCJDVNOdL1X/GrKu4d3A==
X-Received: by 2002:a17:902:e74b:b0:224:160d:3f54 with SMTP id d9443c01a7336-22dbd469727mr4368305ad.31.1745516106262;
        Thu, 24 Apr 2025 10:35:06 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5100c4esm16270255ad.173.2025.04.24.10.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:35:05 -0700 (PDT)
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
Subject: [PATCH v6 10/14] riscv: misaligned: add a function to check misalign trap delegability
Date: Thu, 24 Apr 2025 19:31:57 +0200
Message-ID: <20250424173204.1948385-11-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424173204.1948385-1-cleger@rivosinc.com>
References: <20250424173204.1948385-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Checking for the delegability of the misaligned access trap is needed
for the KVM FWFT extension implementation. Add a function to get the
delegability of the misaligned trap exception.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/cpufeature.h  |  5 +++++
 arch/riscv/kernel/traps_misaligned.c | 17 +++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index dbe5970d4fe6..3a87f612035c 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -72,12 +72,17 @@ int cpu_online_unaligned_access_init(unsigned int cpu);
 #if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
 void unaligned_emulation_finish(void);
 bool unaligned_ctl_available(void);
+bool misaligned_traps_can_delegate(void);
 DECLARE_PER_CPU(long, misaligned_access_speed);
 #else
 static inline bool unaligned_ctl_available(void)
 {
 	return false;
 }
+static inline bool misaligned_traps_can_delegate(void)
+{
+	return false;
+}
 #endif
 
 bool __init check_vector_unaligned_access_emulated_all_cpus(void);
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 410b2e0e0765..1d3be999220f 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -709,10 +709,10 @@ static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
 }
 #endif
 
-#ifdef CONFIG_RISCV_SBI
-
 static bool misaligned_traps_delegated;
 
+#ifdef CONFIG_RISCV_SBI
+
 static int cpu_online_sbi_unaligned_setup(unsigned int cpu)
 {
 	if (sbi_fwft_set(SBI_FWFT_MISALIGNED_EXC_DELEG, 1, 0) &&
@@ -748,6 +748,7 @@ static int cpu_online_sbi_unaligned_setup(unsigned int cpu __always_unused)
 {
 	return 0;
 }
+
 #endif
 
 int cpu_online_unaligned_access_init(unsigned int cpu)
@@ -760,3 +761,15 @@ int cpu_online_unaligned_access_init(unsigned int cpu)
 
 	return cpu_online_check_unaligned_access_emulated(cpu);
 }
+
+bool misaligned_traps_can_delegate(void)
+{
+	/*
+	 * Either we successfully requested misaligned traps delegation for all
+	 * CPUS or the SBI does not implemented FWFT extension but delegated the
+	 * exception by default.
+	 */
+	return misaligned_traps_delegated ||
+	       all_cpus_unaligned_scalar_access_emulated();
+}
+EXPORT_SYMBOL_GPL(misaligned_traps_can_delegate);
-- 
2.49.0


