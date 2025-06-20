Return-Path: <linux-kselftest+bounces-35448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A45AE1F7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 17:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2786A5FFF
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 15:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BF52DCBFC;
	Fri, 20 Jun 2025 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2UMQDN77"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A272D29CF
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434656; cv=none; b=rfLL0JGWaeVQhIF42BeOnzt9wvTIBvBgS/ogFQLjZsTlCig1rgAXCFNYPZ5GNrYrtgnX7Qz55Lx4r0fzkhqrqYwJsMW6k0zuQ/IeylPI4UFTYuYzbtvtLTTMA8S0teDSio44icEbEzcWgr8G5Z6fCmKv6IpshxEWqbpdEa9qoqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434656; c=relaxed/simple;
	bh=gCSRjdYqG3EEUY1fJd8dcZBC+dlFimBQ3bHa5DO8oTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D2jNvrEqg/4OIFCFG0HIleJAEVGyYMc/GXRDLuBxXLSB0EYi1gcrc2TtPSBOXkP3PhJYZDyefiNtyFL4VuN6pZN9JET7D2VLhsdztS5NDobA2jBu/iULowfSXKANZUqI7gSCPX3A/bf+xtm9lqfKwNR87wftFWL0wfX6wNEMAS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2UMQDN77; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6face367320so18780416d6.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1750434653; x=1751039453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lb0bY/htYmIjhjl7e6qeommZ2woeWEYXNTEbvyaBVDI=;
        b=2UMQDN7768OqyERSRvGPilqJ002j+DhWB4IRULjbhRWhMhjCbi9QHyFXcoqr9u8gFy
         2vZ3Bb26eaWQUCblm5KxO1srNyCtNsZqZJ0CF/9Z9I71JywcxTYmPLPFwUu1UccGtLtL
         QYhVpdgMWGEAKkvF//eI09yLlcSN4TouxKyo1fDtU+fXgqIBd23W0HpXN5p6TEZGhg3p
         5mTRDpjeCvWuL4ZKMMWC4VPCKOgOZLYoU9QXYkvOtPar9thvJ9qzYbi5Ae5NcHUMCM1a
         qB2xkdG+r2k9oZco7WR+Vkx97qM6y5BItpXLLhedA3ToL7P2Rdqo9wg8Z2qPJX9AEfIO
         fiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434653; x=1751039453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lb0bY/htYmIjhjl7e6qeommZ2woeWEYXNTEbvyaBVDI=;
        b=amjifesaFiJERDw2c+goZgZ591S3KDRV7ofJZ8KtDetzC2EfJCVBAOdR4hBsIXobMe
         xHCWQ6V5cGPhX0Myd7RVRfNGUveIdzKvnCAUH7+b24FQS13h2YlE0/PoPQlonBTqSZHf
         Jf1KSJfM3U6KRofywiU93ymDOMWfqsElfpwT7Cy+SZQR/qlj0yOxOEQoB1fGGpKQxDyq
         Afc+GFTJc/bZyEaAa2mQ7Dek4UMzoh8e0iAPsA6snAtl/mJlMAz1fFXiZkZijI33yVpL
         2WPGF8UJ3NnP3qY6UH81JLIJ/KYMs/KAejAkIvJRX1eOmNy6vS/NdhEgzxaq8ClSvzQv
         aOZA==
X-Forwarded-Encrypted: i=1; AJvYcCUZDt5URoYFFsf//1oiDxtY+0mAd6hPY9qzD6CFYpKEFBis7zcfn6gCxtFrWzNTB2+dOKcirAMK07HO6Yk/JgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqMhD4JgR5rAmHWVB5lh0KSABZXQsuKk9S8iK/v1puT33KKOiQ
	SNLTntlyZa2AjcPw0gmYcOdfSZrzu9jKc7aZ+p68UMZilh6SFpwu2QyAG6JijM7RVNs=
X-Gm-Gg: ASbGncuVibzjd61sYxrS0CqbWwxS6o+pLjA5wlogn8r++ju7RFTj71B8f+3w1owUZaR
	dm/bQXg0Nt74qxOIBWYfx7AwTHf3gkXHPq89gWHw80l1zbSamB0huStY1KUlS3Wo8WdUImxr+mY
	gPp+0k+r8DX/OgCGEgcNxrgL9p1qaEPe3n/9awlOLJ9d6zZB1xY8Y0GL3bl9sXExexJ5QphYTQd
	4m7EB0sqe4YvkMqqaWV3FqL/5uAAy3w7h1iQqBNk4jdDuqPqgLdbZzpt3qzkNgufActD41lKpjx
	QpzGLct717OSiurxhpUY8bHjwXJty7ugZwAkK/qCOwSYcetRznu/keHaedi3ee62urT7R/Z1wKz
	SsOI9TqKE0llfT94k0kIoHaShmpPNGHP8HB5khfCF6tK6kONeBEg=
X-Google-Smtp-Source: AGHT+IETUJGmBTkpbC46zTXbh4bGWkFtIlbC6e1CPw3xSSEKzKZ4d32RaY3VpeK/E5rx0MhnNTQd5A==
X-Received: by 2002:ad4:5c66:0:b0:6fa:faf9:aabb with SMTP id 6a1803df08f44-6fd0a59692bmr61494516d6.38.1750434652753;
        Fri, 20 Jun 2025 08:50:52 -0700 (PDT)
Received: from jesse-lt.ba.rivosinc.com (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd095c8ccbsm13317606d6.122.2025.06.20.08.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:50:52 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Andrew Jones <andrew.jones@linux.dev>,
	James Raphael Tiovalen <jamestiotio@gmail.com>,
	Sean Christopherson <seanjc@google.com>,
	Cade Richard <cade.richard@gmail.com>
Subject: [kvm-unit-tests PATCH] riscv: lib: sbi_shutdown add exit code.
Date: Fri, 20 Jun 2025 08:50:51 -0700
Message-ID: <20250620155051.68377-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When exiting it may be useful for the sbi implementation to know the
exit code.
Add exit code to sbi_shutdown, and use it in exit().

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
 lib/riscv/asm/sbi.h | 2 +-
 lib/riscv/io.c      | 2 +-
 lib/riscv/sbi.c     | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/riscv/asm/sbi.h b/lib/riscv/asm/sbi.h
index a5738a5c..de11c109 100644
--- a/lib/riscv/asm/sbi.h
+++ b/lib/riscv/asm/sbi.h
@@ -250,7 +250,7 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg3, unsigned long arg4,
 			unsigned long arg5);
 
-void sbi_shutdown(void);
+void sbi_shutdown(unsigned int code);
 struct sbiret sbi_hart_start(unsigned long hartid, unsigned long entry, unsigned long sp);
 struct sbiret sbi_hart_stop(void);
 struct sbiret sbi_hart_get_status(unsigned long hartid);
diff --git a/lib/riscv/io.c b/lib/riscv/io.c
index fb40adb7..02231268 100644
--- a/lib/riscv/io.c
+++ b/lib/riscv/io.c
@@ -150,7 +150,7 @@ void halt(int code);
 void exit(int code)
 {
 	printf("\nEXIT: STATUS=%d\n", ((code) << 1) | 1);
-	sbi_shutdown();
+	sbi_shutdown(code & 1);
 	halt(code);
 	__builtin_unreachable();
 }
diff --git a/lib/riscv/sbi.c b/lib/riscv/sbi.c
index 2959378f..9dd11e9d 100644
--- a/lib/riscv/sbi.c
+++ b/lib/riscv/sbi.c
@@ -107,9 +107,9 @@ struct sbiret sbi_sse_inject(unsigned long event_id, unsigned long hart_id)
 	return sbi_ecall(SBI_EXT_SSE, SBI_EXT_SSE_INJECT, event_id, hart_id, 0, 0, 0, 0);
 }
 
-void sbi_shutdown(void)
+void sbi_shutdown(unsigned int code)
 {
-	sbi_ecall(SBI_EXT_SRST, 0, 0, 0, 0, 0, 0, 0);
+	sbi_ecall(SBI_EXT_SRST, 0, 0, code, 0, 0, 0, 0);
 	puts("SBI shutdown failed!\n");
 }
 
-- 
2.43.0


