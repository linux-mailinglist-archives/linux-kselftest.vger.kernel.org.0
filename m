Return-Path: <linux-kselftest+bounces-8702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5648AE6AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 14:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16EFB1C220CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 12:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C084012BEB4;
	Tue, 23 Apr 2024 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mewy2Q5L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2C1369AA
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876233; cv=none; b=BMYPVR7FrRqMbeTBX9sYSTOarHbpuiXPXYL3atUqwAdaoW4olAM8XBUe+jo3ZmdrmkvAjlewcYVWuVEJLKNLJZtrBAniAg67k9temSu9e4kuhqD9F5gUd7qdZadPMFCiIygNUIDhYUQK+wmOJZE8vmmz2TNkenjZDV39E71wGjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876233; c=relaxed/simple;
	bh=3M7rDvhT85TLsBy8W99JYSiy6tBgacGiXMP1xFaO0YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7cd91ywxBzEDS0pRyk86jT6PVVE0OMmnlfrl3vScSX5WIOQEN2Yrd5PGGGMeRK6aouva+fYiChLny02YEWusce/ILg4Fky/RFOJKOdcWwNiqXjK9YeAVQMlyssVzrKgSbDotTSiLyX+X2iowhXZ/SbPyTpRkRmLmCT111MnRD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mewy2Q5L; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-345606e8ac0so669748f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713876230; x=1714481030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPMUP7jTPhU8KtBceS7+PJO2x6890fNpaWNWTvJnT8g=;
        b=mewy2Q5LKVwSxHvV/pHGVupVeXoOZYEShmyCJj7dPyM96q1gZuTnF8N/Xyxa1561rl
         p5HskHtDoLNFlh67U/ufKXTwh/NQCUI07OrXmB+UWAZlNMks2w7S/KSFFV+qD6ENhZtO
         ++iVtCvTSl+W55YYN5Z/q7cmBNiAx8sm4nEbaWx3LBPBf4itaGfu/aC4LZ55YGR1TSg0
         Ence6CtXRHaisZpw4idlOpZa2dRmt9baCLc9A35IjRYC2bfjTXVVSbl6ZCatwPT5UPwx
         TI4tZX27I+E9mViHFNGw1Bo/fZgH3U0iI/elVXAURDIo8AHQ9jwhBZ9kT3hBK66xIBi7
         W68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713876230; x=1714481030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPMUP7jTPhU8KtBceS7+PJO2x6890fNpaWNWTvJnT8g=;
        b=Do5hkGkc1r1DgIXILi5xhzmpaVTKQvac9703SxVRpAdzeRYha+rbL29Hew180v3Yr2
         2k11FRKxmmnWFB4LUUSgCs9U+10NuewuETw5D4j9SbtFlo3jTfA/AokY/FvDe/ZFTSPC
         zB8CdTlQh7J2P6ahgtdestWGsInn5XW82EwxMF5T4rUt7I6SFiHWqJ7lEj9ts8XPMDqI
         gwD3bjRAwvFl260aL/xWA+aSPVYtug4vdcFOan7iLTZcxpJlAd8cMXeoGcQP8aXh7wTc
         aLiqWuf1lrvSmxYoizbIHPGlwyR4bzvbZavQOnDkQgJiA+HjBeGI9HhYsTVMdyVrDtgA
         CP/g==
X-Forwarded-Encrypted: i=1; AJvYcCXZxcoqLIMjDLXTK1wgKUZt4U3e7Sbmsj62EDgjiiKWdMGcyktNKCxInROSxxxb++g8q3V6iklwWW96rzy1ikT5POBQjkyqJMH+9cG2K2qI
X-Gm-Message-State: AOJu0Yw18gKxZ9PUSoJzJ1Mi1/9l74G9yUCaztf6VSptVA5SB47MgpGF
	d1wJawUwebcG7IGt0yjeKLrcZVFu/CLGQBuUWCuMCoor9NCoBP9y2K8Ruf/XotU=
X-Google-Smtp-Source: AGHT+IF4Owb23uP4IaZsltc9oiRU6sq23tH0PC+Yw0dOc5/Ns9UfmjB52gYnOefx2T6o79mISwlW4w==
X-Received: by 2002:a05:600c:1c9c:b0:41a:bc88:b84 with SMTP id k28-20020a05600c1c9c00b0041abc880b84mr1191832wms.1.1713876230241;
        Tue, 23 Apr 2024 05:43:50 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:71cb:1f75:7053:849c])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b00418a386c059sm19975709wmo.42.2024.04.23.05.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 05:43:49 -0700 (PDT)
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 08/11] riscv: add ISA extension parsing for Zcmop
Date: Tue, 23 Apr 2024 14:43:22 +0200
Message-ID: <20240423124326.2532796-9-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423124326.2532796-1-cleger@rivosinc.com>
References: <20240423124326.2532796-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add parsing for Zcmop ISA extension which was ratified in commit
b854a709c00 ("Zcmop is ratified/1.0") of the riscv-isa-manual.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b7551bad341b..cff7660de268 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -86,6 +86,7 @@
 #define RISCV_ISA_EXT_ZCB		77
 #define RISCV_ISA_EXT_ZCD		78
 #define RISCV_ISA_EXT_ZCF		79
+#define RISCV_ISA_EXT_ZCMOP		80
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 24bf3fbc0578..f59c3a5ef9db 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -319,6 +319,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA_VALIDATE(zcb, RISCV_ISA_EXT_ZCB, riscv_ext_zca_depends),
 	__RISCV_ISA_EXT_DATA_VALIDATE(zcd, RISCV_ISA_EXT_ZCD, riscv_ext_zcd_validate),
 	__RISCV_ISA_EXT_DATA_VALIDATE(zcf, RISCV_ISA_EXT_ZCF, riscv_ext_zcf_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zcmop, RISCV_ISA_EXT_ZCMOP, riscv_ext_zca_depends),
 	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
 	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
-- 
2.43.0


