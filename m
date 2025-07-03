Return-Path: <linux-kselftest+bounces-36426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8646AF75D8
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 15:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D2C1C8569B
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 13:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAE72E339E;
	Thu,  3 Jul 2025 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BXXym7vD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9F72E62C4
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Jul 2025 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549766; cv=none; b=VvBuLMxvKpi8OVahYqFZp2Z6y1Ud/Cenxmeu0i5LLQ4UMFF11LCpTOJGFxKGnrGzaNYqqcLUtDd3kN5RoSJWVodZWbLvIrCSyKzbrHPKJVTPr/tS2KSYDWCMlTq+IBGPF4DKzcn1UtaBh6+0l2t2D0SqL3ul2uyxyeDhPCEUApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549766; c=relaxed/simple;
	bh=+dsfzHxe0IqbWFfgpaAcazrKyDDLjdeZxVUS3CU2vD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CiE+kyKOl8VYgUCXrGavfDSQIvsYeSZelJrSlubEHkdGMmNUT62/gvpPL8oQRE7WyM1zpSQ2CJjKq9YW3dGaC5x5xlMtuT1kNAvVbrddmjvMCFjEub+xiOszoIjMVX3EwkOrt34+7xKGSG6MCqFLc+2lPTJ8JP3Ix++khAm1p3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BXXym7vD; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fafdd322d3so63657966d6.3
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Jul 2025 06:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1751549762; x=1752154562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AybLdMIaTX7u240+QRHcmMiae8oJPe3j6zxp6xpwSS4=;
        b=BXXym7vDGBzlHPwl9cnp2rbQNM8N7755SktX/GJxNXXv559gOhVTUE99ypNG90td1Z
         nYP2CIxPt2/l5V4RhEEvLrSGI+HT3l45dvLLqHrrefMleg47Qc3K0IEmQ9TAjT8irb9h
         4U8v20noJ4d03M8f+7lYD+dlJ8aewvLA2CeLDGAWcDse2GdZTf373N/L+fS4cHYwyT+Z
         868O5PQCKAdT4B7+2a24qDUTuqs2HLdPLJP0hGDulFhVsWVdorTm0T5/QgHgB4QECYj2
         yM+QSZbXiM47lydQuGOEUa9hPKGCwSYNjSUamW0x+UPWmg6EKsxzuOxZqWpzeOZBN6gZ
         xaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751549762; x=1752154562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AybLdMIaTX7u240+QRHcmMiae8oJPe3j6zxp6xpwSS4=;
        b=JAZc5EPWQz8Vk3fOsNcbQZtk5FcrWpqQRymWV75+eNOEIB0kc8iyZ5HQTF10SFhFa3
         PBqKHe0h7byNnrUXLdLcV8RyeK4DygVZo03pNXn5XL7Ijm7Y6WdXX8yTK0UewpqNxpQT
         V2HA1gvZEYUEXJ8g6LcguKCr+lAUVd0OIRx+FnY5zZ1DtoHwqXrKQhavUZYmf3nWwEzU
         XLbqLQs3c3hj2s7Rxp06iPJ8DIs/25De2OPd+mn+CFXjyo4TO2y9xuLabh/6vnxLipZE
         I70fRlsMdwVHwvKe/b4P6u0r9FwH6aufLeB97SVRSEztCJbWCd8roUfZtQWou1U6IFA8
         TsEA==
X-Forwarded-Encrypted: i=1; AJvYcCWSTx53DTsB5pd2/QHehFCZH/aO6+cSDolroP1iLEZJvBejkeCpFb9q7yFAxDn1CXBgqrUok3gDKFRQE0ucSdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLXwvhdsKP+VCmj9+pZr94uWax1NGB0AEtPr+NR9EwUVXQFTSc
	7Katov9gb/qsH7gn0EyNoyNFcdqDX3gy9+Kkbr80pG2ciMCKxupDyMmFORtdgxxQrR4=
X-Gm-Gg: ASbGncsZPY4VAesD1R8YhwnwT/eQWKNcUzeVbM4Dq9oXS7pQZLSG8IxUhEA8O5gqxMY
	bII1bpJg1I0Pz2ee3VThHULqSJcDxXYGJK/5Lm9vN9qeEf7WtBXKNcWfKzBalABGOiVaUZkeosT
	HfqMBwfIWC/10onVkiBMWj/Z3QqfP/GZxLABYkdpeEIG9I7Kc+acv/m5sqXKlW5asPkv0e/MtLq
	UM8eBJ9oUWUP5mmca+prQblMrtrKimuRRDtOlTia8lqU9Qn4MNI3VKrr/DBKbV86SjUnzr4Xppb
	9NC88bxLhjoRmj1LNQBgh/cjFmSoL9Xm4bEbMCJgVJqMsIn144tuk678NV2rvNCvrvkA+CIOHP0
	=
X-Google-Smtp-Source: AGHT+IGHeqWTScI42ieZ9hlCd88aWLNR5bd/wuHidBIbPxL/tKCuhIsA4xmBVc4nHMWIIMW8e4W9lA==
X-Received: by 2002:a05:6214:5a0c:b0:6f5:106a:270e with SMTP id 6a1803df08f44-702b1c118e8mr103093756d6.44.1751549762212;
        Thu, 03 Jul 2025 06:36:02 -0700 (PDT)
Received: from jesse-lt.ba.rivosinc.com ([96.224.57.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7730af00sm118166016d6.113.2025.07.03.06.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 06:36:01 -0700 (PDT)
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
Subject: [kvm-unit-tests PATCH] riscv: lib: Add sbi-exit-code to configure and environment
Date: Thu,  3 Jul 2025 06:36:00 -0700
Message-ID: <20250703133601.1396848-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add --[enable|disable]-sbi-exit-code to configure script.
With the default value disabled.
Add a check for SBI_PASS_EXIT_CODE in the environment, so that passing
of the test status is configurable from both the
environment and the configure script

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
 configure      | 11 +++++++++++
 lib/riscv/io.c | 12 +++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 20bf5042..7c949bdc 100755
--- a/configure
+++ b/configure
@@ -67,6 +67,7 @@ earlycon=
 console=
 efi=
 efi_direct=
+sbi_exit_code=0
 target_cpu=
 
 # Enable -Werror by default for git repositories only (i.e. developer builds)
@@ -141,6 +142,9 @@ usage() {
 	                           system and run from the UEFI shell. Ignored when efi isn't enabled
 	                           and defaults to enabled when efi is enabled for riscv64.
 	                           (arm64 and riscv64 only)
+	    --[enable|disable]-sbi-exit-code
+	                           Enable or disable sending pass/fail exit code to SBI SRST.
+	                           (disabled by default, riscv only)
 EOF
     exit 1
 }
@@ -236,6 +240,12 @@ while [[ $optno -le $argc ]]; do
 	--disable-efi-direct)
 	    efi_direct=n
 	    ;;
+	--enable-sbi-exit-code)
+	    sbi_exit_code=1
+	    ;;
+	--disable-sbi-exit-code)
+	    sbi_exit_code=0
+	    ;;
 	--enable-werror)
 	    werror=-Werror
 	    ;;
@@ -551,6 +561,7 @@ EOF
 elif [ "$arch" = "riscv32" ] || [ "$arch" = "riscv64" ]; then
     echo "#define CONFIG_UART_EARLY_BASE ${uart_early_addr}" >> lib/config.h
     [ "$console" = "sbi" ] && echo "#define CONFIG_SBI_CONSOLE" >> lib/config.h
+    echo "#define CONFIG_SBI_EXIT_CODE ${sbi_exit_code}" >> lib/config.h
     echo >> lib/config.h
 fi
 echo "#endif" >> lib/config.h
diff --git a/lib/riscv/io.c b/lib/riscv/io.c
index b1163404..0e666009 100644
--- a/lib/riscv/io.c
+++ b/lib/riscv/io.c
@@ -162,8 +162,18 @@ void halt(int code);
 
 void exit(int code)
 {
+	char *s = getenv("SBI_PASS_EXIT_CODE");
+	bool pass_exit = CONFIG_SBI_EXIT_CODE;
+
 	printf("\nEXIT: STATUS=%d\n", ((code) << 1) | 1);
-	sbi_shutdown(code == 0);
+
+	if (s)
+		pass_exit = (*s == '1' || *s == 'y' || *s == 'Y');
+
+	if (pass_exit)
+		sbi_shutdown(code == 0);
+	else
+		sbi_shutdown(true);
 	halt(code);
 	__builtin_unreachable();
 }
-- 
2.43.0


