Return-Path: <linux-kselftest+bounces-35702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFBDAE6F6D
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 21:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EECF16DA99
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 19:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0902E88B6;
	Tue, 24 Jun 2025 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wFwAuPUk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDAA2E88AA
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750793003; cv=none; b=in2IVdumMidaOU5vK3HWUy98EtWHSEu0vEE2i+K/w2Kom7EO49KakOzeKz8Qh/phKOXfBTPt/5x0ODEQzN1p6xt/VP7Kaohv5VRSCfCxOyuLa9dNxPZ5fX/T0y1qH3LfJ6XDbUSkoB0Y7U4O0W4Q3d6NXyopMcH4U8D5Zpa2pNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750793003; c=relaxed/simple;
	bh=9U4gP041/MBbOTyBnMrQj8uf5fyw66YvwyJHfSvr1lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wgh2ioE0UsvBk1+1Cd9oMD6SRaZ6EjYMGDrka9329rL+oH1lbopoOlZad55S+jebD7ReAF0BYOoGRCmC8v1f37ht3SE4dtauHWOWKLCTVbv0roLWden0L+g6gccnSQzd6ilDX/g1DxdafF5fcl54JdotF3Y1dT9bV+LQH1RAv2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wFwAuPUk; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7d094ef02e5so23290285a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 12:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1750792999; x=1751397799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gJEHC7W7QNUQcjlQadx2lMB+Voeeq/w833ndZR1fDN0=;
        b=wFwAuPUk8HCVuLgyNoNigOc9g2ri9HZ4IlRC3RRJjAXIKIvzro3TkOcjY41ntQyvjL
         ETlpSS8w0Jx+uMCCvj/L6+nc2Issld8axDy098cs0vmb2K+jbVbsLfXrbBNy5ryaKzv2
         0lekaJAsgHJKxIJzYSV2b0R4Vnhjn1THa4v61SoJT+Am5nPGZshnsvrKlHiHTkUiWsrx
         3UxCnYifd/NvkYiO52n99/EgYAyo7nb7MostApvMOrgh/Vkrf/o5xq1V4c0abw8KL2DM
         x+J3lB+aq8ObMfTc+R8NN44kxA5+xeIkCTeskrtYlc2FV4uW6PRi/PCsM4o+r/Z9izMp
         Mwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750792999; x=1751397799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJEHC7W7QNUQcjlQadx2lMB+Voeeq/w833ndZR1fDN0=;
        b=k5ylWDl4b0zVUwvYzsOataCW+K/Yl1XMlXoFNe3leKlK67teQieTIRrmllon7oFymu
         zOHiiV+XMWsaB6sZM8/yTNCT/C0U2HkE5KKHNsBB3rTbxgM7kKFTkaI4HonlUkuK8aki
         ybmW8QeVgfKOAZvEB5Ou0Cdb2gcB1sjxre4lU+6slHBnnN8HVCoYA0P4pLi6ccMCSSaK
         IzZGL3r15KwfKzZBvhsyWuwoYHnFVuAYBbbEmqllOQhQgxCKGxO+YL2oZIzMhGW8ToCU
         BYGd72iAllsXOIEHmefl4qsB1PL2OYGo8smjxEuhjdMD56SPwG1RY6T44z2bUmKS6Dqq
         ghHg==
X-Forwarded-Encrypted: i=1; AJvYcCUhMvdRWaMgdWSBEu3BxPl5z+bJ1cP6B5ZtNOEl8Uatqqj2vnS/0DOPBX3ybJeP1nDrzcz9M43SPkOsjNMoSDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8WAMvZq18VMiXOk2RpZaezW6oerfiLnhpUMeJGvqvu8i1qRpi
	RVMJtfb9B3w4rcc/Q8buFsXmPVYaEbLv7xbgmf9lF1k99oVO1/E+0FX6Z9ZXfL2CVEw=
X-Gm-Gg: ASbGncv+O3QWP0O6ub9aW+ZJLNsl796sRoVxf/+X5aOKqOzHYw9X672bltp+YbkZ/59
	2ZOZk3tky8xcivb23dYTB9wJXXtFqgfCq4S10WgwssqZu2b3AKSNrSFrhCUrmiIaOjOLvhCfvU/
	Sm4iKA6hBTVckYB3QP25O7V9Xr6meTdcnXYbzNSkg+59r+jGvKEHJGlY1mFd9t4jZBesLHvoF9Z
	eS12RUU2N2dJvCZiClD8fS5x2UiY4FWeK0/nagTMrY5Fn7YPTMr/bcevi9YLZ4aKc9nGbNu5uGy
	eZMFkEpHVg29Q0wtZt8LTfrw/EWS/1YwLn0RLl+JGQkPwAUMwctWAVdL3IC2urlPfKcfz3NmRiZ
	qrf+IiP0CWoSwrXvRshaDVpRy36RMTjO/0WyKtr40xR7O9HUtRiBpSRHjhY1HVA==
X-Google-Smtp-Source: AGHT+IEpWt8zHh5hqZ66ViGmfWYuDSGLX7ZbSUGK79B47Y9xlyE9QioC0WusRzyQfrYBkVZ91oshfg==
X-Received: by 2002:a05:620a:1708:b0:7d3:a4fa:ee06 with SMTP id af79cd13be357-7d41ec6e85dmr607952985a.29.1750792999362;
        Tue, 24 Jun 2025 12:23:19 -0700 (PDT)
Received: from jesse-lt.ba.rivosinc.com (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99eed41sm534292085a.69.2025.06.24.12.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 12:23:19 -0700 (PDT)
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
Subject: [kvm-unit-tests PATCH v2] riscv: lib: sbi_shutdown add pass/fail exit code.
Date: Tue, 24 Jun 2025 12:23:17 -0700
Message-ID: <20250624192317.278437-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When exiting it may be useful for the sbi implementation to know if
kvm-unit-tests passed or failed.
Add exit code to sbi_shutdown, and use it in exit() to pass
success/failure (0/1) to sbi.

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
index fb40adb7..0bde25d4 100644
--- a/lib/riscv/io.c
+++ b/lib/riscv/io.c
@@ -150,7 +150,7 @@ void halt(int code);
 void exit(int code)
 {
 	printf("\nEXIT: STATUS=%d\n", ((code) << 1) | 1);
-	sbi_shutdown();
+	sbi_shutdown(!!code);
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


