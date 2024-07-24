Return-Path: <linux-kselftest+bounces-14171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 546CC93B75C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 21:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF45285946
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 19:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8B016F852;
	Wed, 24 Jul 2024 19:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Qxc8KzmC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3860116F82B
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848455; cv=none; b=OMZwhCnUZ42hazgkylwhbMo9vi4OBp+Zwt37ftfySk19aZtLMMXOreZfP/Yj3XCpkbuNkblaM4ho7aK8c1SGLtwZSTngybCg+i/iLQz/Jc2j4NN6PuzjJYerkRTg20kIRtTDEQD+K2U+egy8xhxc25nE8+PDqNCYGKkJgkF9I0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848455; c=relaxed/simple;
	bh=wrX0uryyy89vYlAinvVr2O6QBZz257uuEBuSnzas59I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FlGWXDSrN/iEtiFpDJ/gEYTNhQ1fYPB5vn2j4MLEiZqAc31mIiKHNn85b/wzsjMc0CMrZ26Z2HtvvkoAO3MQt+AvwdDcitmvmQc8G9QkuzmZ2xdkEmr58V2mdxARmZ001hBaF+7fGpNVpoqmpg8Pfsa561JdNGJAOAbFLKM8Vt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Qxc8KzmC; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7928d2abe0aso956548a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 12:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721848454; x=1722453254; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=425S2jEpk/4yk63j4Ow9jwZmOCFjeEcHZbKGmEqnWN8=;
        b=Qxc8KzmCZtYIHMFFvDa91RHgG7AdlNGEdIAJ61kelfSgVsq+t3Pf77KqgX7QiuhQ25
         RFTIojLp8Sho9fNPLXPzpPaXqMf43Ku54u11mpeOwDyzHYUvTOd2iCgQgPBp8Oak5YEr
         ghSBrBfR8+1dHnALxiln9S+UGmnE8uie79PxaOOB/Z6IXWpwz27KBhozsqIOqqLD+DFV
         gRpSXQzW3ewSSNyEs7+UAIS5XeGoAF9KntlSxVIxhZIjXF+FK4hjCIQRz0b8dA8ruJPT
         I02OoMU5mOVwlZQ5Jsu+CzJm5uNIJvGAWqEQuydDR7qoICByxvKivfs/1Cq05A3k8Fip
         +BDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721848454; x=1722453254;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=425S2jEpk/4yk63j4Ow9jwZmOCFjeEcHZbKGmEqnWN8=;
        b=HaFNwQs2JgVRV8ji/mc4ToRuD9eN0VD72YaPLSNI/ziS1g/ns1CZPWezTlGVC4DyQ8
         SPR+/x7IYBXxUo+hSgqjx1N9jGg7op1wQBaT/0DFephng4FeEwNdEYad1O1zlHszk3u6
         5BF1sZMSWShva5rJzHGH6RUCmZLxqhczIWrqsRQSzBvbB48gFOZV6Xj2yQ/00k7XFCFr
         gLUypV/e7IPW6VI01V7naLA99xS/aDMl/fGeoUDiRehZkxPQD4iu0OpzBil0c18Xhq5X
         sYyXwaBFvye446VQdMDI4ZTWwEjZ4aoOzTUqtoNNTMlzwAvX32r3Srg3/8w3Up7tDUi1
         IbOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC4+dMOo6xSmjQLsuY7+8cVOPYLf/at+6qeiJsS6lQ2S0AkX+/Q3rsNssq34N89QVx0gAwgMJnt/shIX/0BO0uQMfWotU28VO5mTT4GuHd
X-Gm-Message-State: AOJu0YwZbRGJNF+8tWHRa0Kykk7gbAIKAz4DqTY4DibYJyv5NoHdE/xS
	WTHq8pnn0XzgcQJOMmYSVyhDxuMi0DcrMqWf5/JDEVVLO2qRh8Mr5T4hOVGxLCo=
X-Google-Smtp-Source: AGHT+IGVQ/7s5Uji8FwnkBAQuZA/qnOTv5FeMuP75J/li0AlUiYDJ2mhYeKo8pOgLH04he5+PNiRJw==
X-Received: by 2002:a17:90a:5d11:b0:2c9:63d3:1f20 with SMTP id 98e67ed59e1d1-2cf21f4adafmr940219a91.18.1721848453700;
        Wed, 24 Jul 2024 12:14:13 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73edecesm2022359a91.32.2024.07.24.12.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 12:14:13 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jul 2024 12:13:57 -0700
Subject: [PATCH v7 06/13] RISC-V: define the elements of the VCSR vector
 CSR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-xtheadvector-v7-6-b741910ada3e@rivosinc.com>
References: <20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com>
In-Reply-To: <20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721848437; l=930;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=0jkC45FH0LUvSVfvCEJuCBZ027fqPbAipPAnc4zFoN4=;
 b=J/NcqcR2Zv8a6Q1N9svQLwZ8l2WXzaUXYG1n5aBRx93oI5TyD5lMzQmTpTt6lA8RjBCPTvqeU
 Ot5+T/1v3eABmYm8fvobV7OXx8xYRPHSVfU1an1UkyUyoh3so89Gi5b
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

From: Heiko Stuebner <heiko@sntech.de>

The VCSR CSR contains two elements VXRM[2:1] and VXSAT[0].

Define constants for those to access the elements in a readable way.

Acked-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 25966995da04..3eeb07d73065 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -300,6 +300,10 @@
 #define CSR_STIMECMP		0x14D
 #define CSR_STIMECMPH		0x15D
 
+#define VCSR_VXRM_MASK			3
+#define VCSR_VXRM_SHIFT			1
+#define VCSR_VXSAT_MASK			1
+
 /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
 #define CSR_SISELECT		0x150
 #define CSR_SIREG		0x151

-- 
2.44.0


