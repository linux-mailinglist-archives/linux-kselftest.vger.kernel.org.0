Return-Path: <linux-kselftest+bounces-30673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CD0A8807C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 14:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 806BC7A8EE8
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 12:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C4E2BF3DE;
	Mon, 14 Apr 2025 12:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="z4X6OvGU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9352BE7B1
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634160; cv=none; b=H07rkMV3JvQnPGE8tEYCnEJE7FZOLFJFqrsPsm28lFdcppduRLklBevUDf8lCegi4FUvzRYgDwZQVAfCsMhVS6marDUi2rYdIZ/pD7E598zCJnmV+MiV/YvPdDzMHuKp1K9cEslRpVS9aPLZ0LwbjAgyoowYONfsPhPBfcjGKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634160; c=relaxed/simple;
	bh=uE/sTnOURFYBjUxUXNJbjUtsh/EN4ig5lh4+0R1IcfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ek2DTtPsEgaMn/h6/bNbWqfaLTTWPczUMbk/6AMAaCC4twiodeGKSTWJsqfZsgRoQC4d75GLoZM2b43r51KMeb9sCZ9UUbKgRRdm12ihyFUwiWRxyhmCw++6M151UT1ZLhFu2gpwjRXHGNpEtVc9IFI0iPdLHyMRp+IK3Y7NvIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=z4X6OvGU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so36485795e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 05:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1744634157; x=1745238957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlJaR0rGQ7lkkTNY4tt/hV6uETrC0h2zoS/Msh9pgDk=;
        b=z4X6OvGUdN1cUflf6/Cn8Gv+xMdMma0fXjBuK+FUWi3F8arvmHSjcPGLay8D41N1cu
         /AIezttiM55vD9QwRFdoUUpOaVQBLWGYA+GrloTCLFQFitO80uoL7DEZHbi0CZRP+tYY
         5SELWDswpYMhUm2g5wHtYc0fLlCE8WX14As0H1iA5S3rI7E+jT5ZVr3oCod2O22OA7AH
         Pk9sIsSPkWVkTt93dkiRjAYarXGbXUQrr0t7z8wAprSazdHcIDLFZofonLiXNHVpWABM
         /e8nTKnwlGF6xwIWDoKoE7aKnov26Nfabf/rNhpUiARtscsPx1pvu3Xhjd3JCuU8y+CJ
         g0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744634157; x=1745238957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlJaR0rGQ7lkkTNY4tt/hV6uETrC0h2zoS/Msh9pgDk=;
        b=i121BCV06QWyzC871M3/2LxRiWmJjxlTxfjpxpjUsGakWSw/NAruR1c9M3WIk6TKfv
         RrRyMOb91PxDDgs7kE3GQO49emNj4MnJhH8KVMYqYP8qjTj9e+EWANbtttHLYEBOaCXn
         PUaY/61gpXYGvNowp7yY/igx0XxCN3Q+qL+eSR09aEh9chVwgkkcnK96/F81sbb+UM39
         0OHwWSe86xxXA+rhKAN+BPPAH3SU0RUzjXuhW2LxwuKQKatMRRsbFuO/qeGogx3vf8lG
         SbZ8f6QnvI3oDmdrxaIRXubGHMMaDhDBJGC/oTfXDZhtvRAnB0ia1Afjnw+WL4iMpm5Q
         5o1w==
X-Forwarded-Encrypted: i=1; AJvYcCX3jtntMyLvVMupJMpO2v7VYtFq+HCEtqJTLi3GlyZD3gP7tB93T/XJEw73oLK8xNnkWuipOFt49rok98DLgL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YziB+ub8j/BfHI4Hnap6oM9mxXkGM0ik9NN8uAzPmmPRVBRGKWG
	Fgp5Ljm5m5YmnwSZBXlDp4gsCNvivYljiyJpX5Sy9OpHxu3WCyprQpyfK2skrXE=
X-Gm-Gg: ASbGncvVDh1fLN5PXOSy6CWcW0NktElHiWWqGMNemUUZs00fw3Wz7sFKSKLRrUJXW/U
	JSf8CrYYIY0XcJcFiRj5dNa8X8Qhu8HgIVwc6nHMXSqwYP+bRNH2ntbot8OTI7wyN3GXVdpv55Y
	jBHRZeSnecuhac0SNdp3JYCndETQJMq90dxVVo/KdWi8EqkfE8Z+lLOEGFLYUnfq1jsEFU2aD5l
	ieP//4UBO2IuqyyUdYBqTH+/De4cDGYBoLrfC1AlDCfxDmHSmCzy3T/q3SCzCW+/oqDUaaIbCD9
	G+aL1Wc0dTJC2IPFFx6Lb17xqQDifu4etFTzC8ZFHw==
X-Google-Smtp-Source: AGHT+IHgz33xrXrH2J/Kburuf5TLKxLzowtKebRllfEO38l1vRVBBETy1O1EuzOqnIGPlOtR1iyBng==
X-Received: by 2002:a05:600c:450a:b0:43b:ca8c:fca3 with SMTP id 5b1f17b1804b1-43f396e001dmr101919085e9.11.1744634156654;
        Mon, 14 Apr 2025 05:35:56 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9780a0sm11003166f8f.50.2025.04.14.05.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 05:35:55 -0700 (PDT)
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
Subject: [PATCH 3/5] riscv: misaligned: use get_user() instead of __get_user()
Date: Mon, 14 Apr 2025 14:34:43 +0200
Message-ID: <20250414123543.1615478-4-cleger@rivosinc.com>
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

Now that we can safely handle user memory accesses while in the
misaligned access handlers, use get_user() instead of __get_user() to
have user memory access checks.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps_misaligned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 4354c87c0376..97c674d7d34f 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -268,7 +268,7 @@ static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
 	int __ret;					\
 							\
 	if (user_mode(regs)) {				\
-		__ret = __get_user(insn, (type __user *) insn_addr); \
+		__ret = get_user(insn, (type __user *) insn_addr); \
 	} else {					\
 		insn = *(type *)insn_addr;		\
 		__ret = 0;				\
-- 
2.49.0


