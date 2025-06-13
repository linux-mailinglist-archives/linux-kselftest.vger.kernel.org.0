Return-Path: <linux-kselftest+bounces-34910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5C6AD90AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 17:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365001884B88
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 15:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A569444;
	Fri, 13 Jun 2025 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="e2VHfg+K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB715573F
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827000; cv=none; b=saCFBHCrl9hGq07clHAxM6IU29AVJxVjxEtl5Z7a6iZf01SHlGKP1Cb9Tk22S2XC9m0qV0EvUgyM2P28vQXrkTk4zPDGEfXqIMDfJH3xbkyYSc3WuB2cqChGy/0fjIiHs9YgnI96Qop4FhopmvGaTKMFQnMVGwHlkHsYwaRdprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827000; c=relaxed/simple;
	bh=xgyjLjLzANQIvCfCYeqlnHcrcmxbTm46uzPSV9liWBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Smlv1rjUf6ea221RAzTzgHxDJahi3m0OyR1pfmP/iULxpx576w3w4/ztokWf8BGNNU1VsKwfI/czXG1a4J6ls8LJtyEIrW56lL6xHXS3+p3vub9a7v0zP2o8KNeB1PssDgyJtDBh1DTkLN9vlHTvDVv4uy+J8ujSzr3K1Q/Xhok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=e2VHfg+K; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23508d30142so25560665ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749826998; x=1750431798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ByGbrP/BhXTu/tB+D/uo9uO7b8hyy6jujdxcKOmL7bw=;
        b=e2VHfg+KVMUMAPNvNoRIdyh8jhOYhbqRB8pvb5eafAUuRx3b7hjAlvd88Xfg6QBFkj
         HcAPXox9iitshHSIwEAuVwKtrmSH6Dpb+eKv+fsyyeqUMNaLcShGCTgcfPi6LgOGAruP
         eODZxEpOpThKpoWd9nJXAWhHYZcbOwn+jcC8Yl22W1HP4YlYBDxP2SvW9B2LavkCpAPu
         y5m7hEo72RECtANq5cdvlMRukr7Qzajtse3H7pJXKpnf2xaX9MzphlhM+X2PeunTpt7n
         YFCFYf9mL16UZaDUzXde4hDZM145nzC+H3AgHAoeLfCMVEWVAF2K6MmEdnrVCHAiy0zM
         7v7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749826998; x=1750431798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByGbrP/BhXTu/tB+D/uo9uO7b8hyy6jujdxcKOmL7bw=;
        b=k987DLopiQXIy51+1Is5pZMnG8LPTeIYLoPlt1e4I4+wsK2B46qgRe0Ck2xoPY9ZjE
         Ip7TdYu7LcBuxmcc0MXSWcFZ4PRJIdlM2o2I2D6ANTc4SxteFm5VM2gLHf7dYauoap97
         Jo/iGD4x3srle45ZmIDKVTu7Zb73Z6wyWXeGkvi/W7yrvmny9AP/o0g9uoZHfG6KVrAK
         kNQBpvpM4Ux6TXKz0+EGLOs0Vb2+yGuEVd6rOOB2VOb+7vxkCNgbjMii8Jw8O8VQ+EN8
         63wOt+8ymMKOTzHm1Zy26bYEGnaa43qEac0gzQp7yg4pZLy0BFG6rEdejca1AfKltlFo
         6RSA==
X-Forwarded-Encrypted: i=1; AJvYcCWQSEOd1QzxwqWXzUMJ7naZ2pwXoXFsDsG6DyQYq8pPgwGtnnDIx7I1dFVhEGlJ61rcmM6s/jKXhvNEEEjd1c0=@vger.kernel.org
X-Gm-Message-State: AOJu0YziZ/9yRm47kxT/tLVPOK2s6AIUdNiFJHuofl7qWkfKfSLlBHtX
	YR/lS1NSCI/mUsKh5upMkxZRZpHupQGHlvR1jL9dy1b+04Szv8LIGz7BfbZKZTZEwoM=
X-Gm-Gg: ASbGncv52EvYuRxQmYvvdFm40KXKTrZcc+iohdOZeJko/GHS03Zna1yNpjUcO4pHoIf
	Ifpydp2vzhQ7fidA3bTI1YD7fVhLGp1k9SizTczn8rEIyFCjcxx6FssXlH7bwNztEpq/zoWm8ue
	LfL1xfnBkKczWq4zchhKq9yV4dqYT7X+ELV11vRRGyuTZiBgC19QxnCHQEabJvPlsJ1ET1IPV3h
	IXv8stD6tGIOshfvLeL7ihrerGEW30jHN8pmvplBzzavMHSxZfj9UjoqEyED97EV92ow3Fp5uSe
	ZmaSVWXWSKVrZ315qcyuTlOOmWtQCN1prqgxKUazN18kkIMcs9OtJtLTzG3rn9kwndZ6JCZ2r+E
	IBkIO
X-Google-Smtp-Source: AGHT+IEkVhWzhAXI3tcZMCIrTOwssgtXLWKplMIQXljnP5TEt6Tv6Fn/ix1rs1omTiBAqTROVanQgg==
X-Received: by 2002:a17:903:228b:b0:235:be0:db53 with SMTP id d9443c01a7336-2365de3fc55mr46130975ad.51.1749826998209;
        Fri, 13 Jun 2025 08:03:18 -0700 (PDT)
Received: from jesse-lt.ba.rivosinc.com ([2600:1000:b0a7:aa8d:70e3:1b4a:46b0:77bf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de783a8sm15242055ad.99.2025.06.13.08.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:03:17 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: Atish Patra <atish.patra@linux.dev>,
	Anup Patel <anup@brainfault.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Andrew Jones <andrew.jones@linux.dev>
Subject: [kvm-unit-tests PATCH v2] riscv: Allow SBI_CONSOLE with no uart in device tree
Date: Fri, 13 Jun 2025 08:03:13 -0700
Message-ID: <20250613150313.2042132-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_SBI_CONSOLE is enabled and there is no uart defined in the
device tree kvm-unit-tests fails to start.

Only abort when uart is not found in device tree if SBI_CONSOLE is false

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
 lib/riscv/io.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/lib/riscv/io.c b/lib/riscv/io.c
index fb40adb7..e64e9253 100644
--- a/lib/riscv/io.c
+++ b/lib/riscv/io.c
@@ -30,7 +30,6 @@ static u32 uart0_reg_width = 1;
 static u32 uart0_reg_shift;
 static struct spinlock uart_lock;
 
-#ifndef CONFIG_SBI_CONSOLE
 static u32 uart0_read(u32 num)
 {
 	u32 offset = num << uart0_reg_shift;
@@ -54,7 +53,6 @@ static void uart0_write(u32 num, u32 val)
 	else
 		writel(val, uart0_base + offset);
 }
-#endif
 
 static void uart0_init_fdt(void)
 {
@@ -73,11 +71,16 @@ static void uart0_init_fdt(void)
 				break;
 		}
 
+#ifdef CONFIG_SBI_CONSOLE
+		uart0_base = NULL;
+		return;
+#else
 		if (ret) {
 			printf("%s: Compatible uart not found in the device tree, aborting...\n",
 			       __func__);
 			abort();
 		}
+#endif
 	} else {
 		const fdt32_t *val;
 		int len;
@@ -116,8 +119,8 @@ void io_init(void)
 	}
 }
 
-#ifdef CONFIG_SBI_CONSOLE
-void puts(const char *s)
+void sbi_puts(const char *s);
+void sbi_puts(const char *s)
 {
 	phys_addr_t addr = virt_to_phys((void *)s);
 	unsigned long hi = upper_32_bits(addr);
@@ -127,9 +130,11 @@ void puts(const char *s)
 	sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE, strlen(s), lo, hi, 0, 0, 0);
 	spin_unlock(&uart_lock);
 }
-#else
-void puts(const char *s)
+
+void uart0_puts(const char *s);
+void uart0_puts(const char *s)
 {
+	assert(uart0_base);
 	spin_lock(&uart_lock);
 	while (*s) {
 		while (!(uart0_read(UART_LSR_OFFSET) & UART_LSR_THRE))
@@ -138,7 +143,15 @@ void puts(const char *s)
 	}
 	spin_unlock(&uart_lock);
 }
+
+void puts(const char *s)
+{
+#ifdef CONFIG_SBI_CONSOLE
+	sbi_puts(s);
+#else
+	uart0_puts(s);
 #endif
+}
 
 /*
  * Defining halt to take 'code' as an argument guarantees that it will
-- 
2.43.0


