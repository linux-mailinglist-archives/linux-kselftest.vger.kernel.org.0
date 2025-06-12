Return-Path: <linux-kselftest+bounces-34845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA422AD7BF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 22:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEFC1883DA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 20:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC2F2D8DCF;
	Thu, 12 Jun 2025 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qEGx63M6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E476E2D5421
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749758872; cv=none; b=h/Efva8X24g99wAljwAxah+S+OgHIBCbuSC4f0FMyXcduod/iIjONPmgl8qBJSpqt3X4kufDT2WbTDIG/C3SaWBPxk1W1dqR7oeaeijv/+ALk7kc1/QCFnoqwiWYIzflP7SW/R1MdcsxLSlaMpIPseFs6Gcsqd0H8KN93BQYgNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749758872; c=relaxed/simple;
	bh=iPEc9DkrZZuh714L6ptuO/yh0w91HvXRRS3jkxQRWVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=npXlbboTrx3nTi/aG4StfEe9iWHZ3WZ6qcUtMOSDBjn/CAPt4kDrEpnGtWplZrKX/OZHIYOvb8ybq3dMLuLbGm6LjS358O0oGX+wUmMcHR1GQwevTr1Gee3BSDoiPrxJQGeZ3KrCIi75EB2CGBVJkHX17co8765ig+ZoQ6tZf1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qEGx63M6; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fad4e6d949so8655016d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 13:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749758869; x=1750363669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IoCF2baTBMbN485tov+kTyy1ox66YTUHGdu6p7Q2Pjs=;
        b=qEGx63M6eKVYD7vdnPmhIM0dyB8Nqn0lOVJUbqvqkXNW1O7/Ionzv/XYElOTNqaxT/
         ++imTjmxiIm5lCiGGLjlkH+qg3PoXf8rwe4EJlAg5fOCdEWHxkXMRd9ynZpOfQqA0n9x
         bFjCF5NMWF6IbXHzef3v11MB+fQlzii2v4ZsTRBV8XYx9GIxC0AKmgPK+A+a6NdbuPcv
         WvFCZhpn7cMwTjoeXxdGr6KJubaZLWk4JlDs3x1nQjnErxgRTiPCcuH4aOHjPraUua7t
         OOC2eQq5MnYLQ0pbnULMnWEMnLDm8J/F2vB373m88EPkitvbl/q3mqe5oZPzY9DnmlOs
         vnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749758869; x=1750363669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IoCF2baTBMbN485tov+kTyy1ox66YTUHGdu6p7Q2Pjs=;
        b=to3jK0vFTgy63+LfNSHMc+JNSZpU+Fpc7tcsrS3d//Vr1DREX0R/jOPKQyMH+7mk98
         0iFd90ifjXBmcPMzRHyfyEMGtiEwXGh29fCPHuuUt9cRfIHqdnfDBjCcU+pBMywZtjle
         wU4SqO0x+PkZeTyLcWkhPWqqFUe5S4GRuZx51GYVNgj3aSANwN1Jw/Mak8teGpvAzStT
         RP/2JHBmrpIha/qcpgywCsrPy/2/MbqQFxXbImrUv5K5+gOo534XS4FPFfPwuFuMMEWo
         eIf+/L56TLTbsI+2qSySxdPbFGXGsA8eCmYLwAzvUQHDbo76dH1ADo3xBW8z2wNRghvH
         HSfA==
X-Forwarded-Encrypted: i=1; AJvYcCXVzLnu8/iDifJ94cxcRrpM0N7B6DdazLaAIAiu/09lt+X3UVlsAL8ZalWLG6QT4Y9RYMoCJgbcE5gQFy9/wSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7+idkZQEmhq9iRsH5TnPxGVtm2VwTVAeeTg96VsrcxpDZ2WUb
	A7rVdVqDMbS9Pv3IHEZY0BFeZAmps0H+ZhZYvrOi+bQnoC/yfmuITsffk9xqOM/WN+M8c2e5JJM
	AqeIc
X-Gm-Gg: ASbGncsKgoysj13toSO44g8/AObP1ILRKC/IQyZzzVfQF0mfsMhaQm391ntgQtx6ayN
	pLyyheujL79jVb6GhIeR24IOgzFbp8Lg0Zf1sDTyekLxkLS1/wBPw0K5plqQd6MULqHEOxJGh/Z
	VRvw/LTPtr7dLbGXX9OVOf/DXRXWRSUuBKiFFjZSRthZ354NCPHyzL6r/fqhJBfDsbGNAeQa+Rc
	Z0pAvMKnI7CpxxFqQuu9Im00wYYhNFskbY8t5x+yW+bha6OV5HOK8VTu4F47C3ddrdBJfy4Emno
	Gl2PD7r/hFnvId2THqMHSXuy5fJ8Y4QpciiUZ9EJCyEjFWyIjJ3qqiUplMcRMHdKqUZ5UIC8y76
	vrUvKtq/AQSjac75Ts/q2kfWb/8rxyWF22gkKL6OgHbc=
X-Google-Smtp-Source: AGHT+IF7ZOtN55FB9YsoHYExZAH41WMoG3UxkGYtgNp99PihSoVpgb/lhT7vGhmzKBFUsNoGNC5TcQ==
X-Received: by 2002:a05:6214:2a48:b0:6fa:ce87:230c with SMTP id 6a1803df08f44-6fb3e67aeffmr2776616d6.25.1749758868792;
        Thu, 12 Jun 2025 13:07:48 -0700 (PDT)
Received: from jesse-lt.jtp-bos.lab (pool-108-26-224-24.bstnma.fios.verizon.net. [108.26.224.24])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c895f2sm13496096d6.116.2025.06.12.13.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 13:07:48 -0700 (PDT)
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
Subject: [kvm-unit-tests PATCH 1/2] riscv: Allow SBI_CONSOLE with no uart in device tree
Date: Thu, 12 Jun 2025 13:07:47 -0700
Message-ID: <20250612200747.683635-1-jesse@rivosinc.com>
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

Only check if uart exists in device tree if SBI_CONSOLE is false.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
 lib/riscv/io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/riscv/io.c b/lib/riscv/io.c
index fb40adb7..96a3c048 100644
--- a/lib/riscv/io.c
+++ b/lib/riscv/io.c
@@ -104,6 +104,7 @@ static void uart0_init_acpi(void)
 
 void io_init(void)
 {
+#ifndef CONFIG_SBI_CONSOLE
 	if (dt_available())
 		uart0_init_fdt();
 	else
@@ -114,6 +115,7 @@ void io_init(void)
 		       "Found uart at %p, but early base is %p.\n",
 		       uart0_base, UART_EARLY_BASE);
 	}
+#endif
 }
 
 #ifdef CONFIG_SBI_CONSOLE
-- 
2.43.0


