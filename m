Return-Path: <linux-kselftest+bounces-12226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2B590E994
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 13:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9C71C212C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 11:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383A01420D5;
	Wed, 19 Jun 2024 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="UnDPTc2J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62B413DDCD
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796941; cv=none; b=RC/kRU+BzsuFg5Zf4tLItAJkKGsrgpo6ixZlw/GRLie8GRBqEjqhoJ6tKh9PsKGQJEPrIC1JV5rxC44BGDqAY6kZG/6YCP5zbRr9LCCznM4iQdhdTIXqNMj9vPZgctDSWwRHoJIF/TJrgqeem0fUnQOf23CH5WsUZVaLs5oXDws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796941; c=relaxed/simple;
	bh=O0GJ+2eqmr0UfbblfJBz+Dt7SUgbPKYkR8K2q+eLbzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoiebjLdnCxI08iP/8Wg8JR+1iJ6kT6oEudtOOd6crFBskuoAFr8G7QbXY5PmWCa7NYPuTCLaGsWf30in6fb7qqDPPMl1eJc/oqih1ZI2nWzTDQ5MpXzeRRgS3JS2gxGg92Wxz/1ZpE71YIhGLDH1dADXkPPeseB1zvFZN+u9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=UnDPTc2J; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4210f0bb857so6503575e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 04:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718796937; x=1719401737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMzPOWjwpPL8KAzNp1ENlyw3QUAcLnR8cmiyMor/458=;
        b=UnDPTc2JUkGrKBiEq8nUJbNt80v3Z+siJNsgt/BSK5CcK3hIgdeuMNCwVmxUD/plJp
         riGs2UbbuDplb/5giHA/k/UD+779bY6pJ0viZ0mpTUOlmHuKjZzhLqEjj9RhN950wTd6
         l8Z0l+b+KIL6hjVY8afyNpmhqFZMIxHB4oOp3+E3zUQugMr628RlBV07jmsXOw2/uCQS
         Hp1zLBHq9+kPJM96kJ+m6VaIdIqCOZXQiT9QWYAqnrWb/FAoEJQJbCdBcKwy/kTmojlb
         EMRdUV08Fl18mqhuVgO26Fi2EftvTexrEO3ZYhc82FIPvgRC3tDqvXHuxcmX49zxlkej
         kRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718796937; x=1719401737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMzPOWjwpPL8KAzNp1ENlyw3QUAcLnR8cmiyMor/458=;
        b=SI9O9dFs4RmyAt/sc8YRyPotaf2GNX/Yteo7gQjYiu3pFoxPKLkYHB7TCjAXhwW3dt
         1zj9JPi7fyozxMCG0rCV9yrBnEPKiN4wAQucqQX0IDJME0CMYFYcXZsfGRsA7hUNiKtT
         MJTx9BXF//ZRJB0pYNDyCr1scd8vWfChbf2iu4PdJ4Y/Y0M2WDc3Arelvmj0EzGlWyPA
         ilJEOoX+VZa02pVKizNVgoiK6GbL7790WOiLRiEVHR2/Y7CV966lPN2n+miqVqso+eUN
         8AQQYr73ttVS63ST2dCzkMYXOxQKrgbCP+2IQ0dHQ5oaBBfgmHBo+DAMeZFF+JoFYM3r
         G0pg==
X-Forwarded-Encrypted: i=1; AJvYcCUD57kVUuoNnmtfbGnYA/16FRltKmOiqLmwXlwh2FSEc67Rp4pu1jMTpwnF9+jdcEzwoiBEHiZAml5RG1ZwlmlzsI/49jGak5PZAF4N9H8P
X-Gm-Message-State: AOJu0YxnPMozVQEo/+35fxPMmCVS7Ad56XoiHCbFbL3XLtUtM7tR27fc
	FP+X2ace01AwZEMA97YV1UX02NuS71onFJCnMk2NixLahHj8b3vDBmBtQkQSakQ=
X-Google-Smtp-Source: AGHT+IGvamppuiP+XAy2cUkYTFJObTDgcrliUCH+z77J/E9pGnNdQq0NV24Wvh5pkbEYQQdLEc68iA==
X-Received: by 2002:a05:600c:3b9c:b0:421:de31:76 with SMTP id 5b1f17b1804b1-4247529f031mr15669885e9.3.1718796937115;
        Wed, 19 Jun 2024 04:35:37 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:e67b:7ea9:5658:701a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e9681sm266192075e9.28.2024.06.19.04.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 04:35:36 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v7 02/16] riscv: add ISA extension parsing for Zimop
Date: Wed, 19 Jun 2024 13:35:12 +0200
Message-ID: <20240619113529.676940-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619113529.676940-1-cleger@rivosinc.com>
References: <20240619113529.676940-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add parsing for Zimop ISA extension which was ratified in commit
58220614a5f of the riscv-isa-manual.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index f64d4e98e67c..18859277843a 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -86,6 +86,7 @@
 #define RISCV_ISA_EXT_ZVE64X		77
 #define RISCV_ISA_EXT_ZVE64F		78
 #define RISCV_ISA_EXT_ZVE64D		79
+#define RISCV_ISA_EXT_ZIMOP		80
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1d6e4fda00f8..e5516ba14440 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -290,6 +290,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zihintntl, RISCV_ISA_EXT_ZIHINTNTL),
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
+	__RISCV_ISA_EXT_DATA(zimop, RISCV_ISA_EXT_ZIMOP),
 	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
 	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
 	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
-- 
2.45.2


