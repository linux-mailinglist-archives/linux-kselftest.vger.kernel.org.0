Return-Path: <linux-kselftest+bounces-33051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FA1AB8067
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 10:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881581BA7E93
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 08:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CDA2882D4;
	Thu, 15 May 2025 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BOEqXedG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712CC289E2B
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297431; cv=none; b=MlEUa0OVArL1LrY7Xt/AqhGmsEPFQo18uVOO0JpTw/vKzH5o0xgq4Fu1d8eYbK9Dv2nfXa90iEGYzimgVKvai8UaNI7+VLxqswXPenUrH5F9vqqSsBXCUWIuumWd0VAcNq8cI6yWDkYEvS8XSDpd/zsMk00mw3f3MJ0EJ65Kw2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297431; c=relaxed/simple;
	bh=a4HmXbZsUXBGVxOtLEuaSzvGsxTBPYeLxEetHvR5itM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k744xtMKUkpMFXY1XkdP8Zg9plWjPmoW4qpBCjSAhwREb4IiTpNUMF+Mqd2VH6QmEsjdV88RR9bM2NI35tOECQZgiEAbtMgtJkWPk+JeIIW5H/t4paWPeqEukwR7siHImrP/RnYs68fL0dDAAAMDdiWJGvuzzPD8+edjKCgPRK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BOEqXedG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-442ccf0e1b3so7911575e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 01:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747297425; x=1747902225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GthJpHk7CYaw8f95HNVaUdqkaGIjKWsbIYnr+62Txtw=;
        b=BOEqXedGgKBrqtt6+QDX0qKChGPFjJzR+fX1Qb9EUvVY9PCc//lb/ltgncyEroOSYA
         nB/N39aWg32Y37VSFupzZmcxqHQa4zY1Eg6EIytHx4/tLuNIGmdX7WADYd/dQoCcWtq4
         jq9vDYIo69Bag2XuHEnT/mWx9N1VVWZATJA00yjmChuW+LZwb8rfoGtqdfhqI58p9UBE
         tDYTrkZmreUzchxg8HGqp2DobGihtsB+Z4F5WWkZsx2mPa6b+sYZyyrvDM1TiN1dxiR8
         gCr3PBV0m/zpkqHZTS2vmnKeFy6wYD6FN7jrq5OOYS2Ecbh6mIjg1VCXLgs91x/IfXVo
         /8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747297425; x=1747902225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GthJpHk7CYaw8f95HNVaUdqkaGIjKWsbIYnr+62Txtw=;
        b=bPFY7dWxs1N7+5f8HozQ3Wti5GUmW2A1dNZVYs/IhKU9NlXs1VQZJwjIIhlTDK4oMG
         2DAnjtBCfc7SDqWKIsM4jGci9jCbfMcZ8rG2W0e/F6uD5tM9o1m2XHMS+mlhXAWvBDs3
         1rqL89rC4CnarcCb3hIVfud3iUC9XWQQToa5lZzLv8scMapSqQ03tSs8ZpLJnHEbUzIs
         SQBbPHe5kFd12G+Dkvts73OhBpduUlzWCJQ4Miv8vCAjsusajup7oRIvYdhovG1pP6KB
         UgwXvBNrYPyeYHAbys2Imu05JyutJ4F/SS5Sp3xWDa+jepHNAmJe36abV4X0iizdCE/A
         u15A==
X-Forwarded-Encrypted: i=1; AJvYcCUq9FA6qzeZILWmQV17H267sw7Y971cMiW5FOi5igtptDOu3mSvydFfEpjwqswU0zMUqMU3QG/+M/fYIyHdG/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnFc7U4afLmCgSpqPlXrs32iySJtLnYbXrc5zKLixdC5wpCZug
	eqPa7NlmrXTYY5FLFH9IUXd0T0BfHBDZPi9ZqCwZ64Jxqs38jQB08v3gD5KXW9s=
X-Gm-Gg: ASbGncs7zFnuBYdsFJoO5mHOCQxcoGH2DIKy1bAerEPwtT3OEV/tqUxg5C7rMfEIDvN
	hrIBDGtZ0giOOR1tIM9GGJgOietQFtIF2JeH6gNaLJqukoUmb1w8sQPvleUFRlmXet7NSbC/NzX
	t22B9jRF26DuWqS8hFMZO5KrvEb12xIU+qxDztF5U7lQgSWyNOCRT9V7uewOackH5prn247AdBl
	KEpcNQi98y2FPuS2YjRSzZQUXY9gTOOt0dUIJFmsGtxPBO36AivCfibA8/03ibVBH6HwoIqxex7
	tiJvh3BatoxT23+Vh30BfuyKosX9tzZdXdFTICZkvIGE7Ks3jF4=
X-Google-Smtp-Source: AGHT+IH7x3YD3rfJ1K3d7RT3c2JHqxBPnyHoNq9PzYlNLe+gbgjdmPJmhvvDoyxbPRh62T/5hHxcIw==
X-Received: by 2002:a05:600c:c09:b0:43d:82c:2b23 with SMTP id 5b1f17b1804b1-442f2168c29mr50336365e9.23.1747297424728;
        Thu, 15 May 2025 01:23:44 -0700 (PDT)
Received: from carbon-x1.. ([91.197.138.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f395166fsm59310785e9.18.2025.05.15.01.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 01:23:44 -0700 (PDT)
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
	Deepak Gupta <debug@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v7 01/14] riscv: sbi: add Firmware Feature (FWFT) SBI extensions definitions
Date: Thu, 15 May 2025 10:22:02 +0200
Message-ID: <20250515082217.433227-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515082217.433227-1-cleger@rivosinc.com>
References: <20250515082217.433227-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Firmware Features extension (FWFT) was added as part of the SBI 3.0
specification. Add SBI definitions to use this extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 3d250824178b..bb077d0c912f 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -35,6 +35,7 @@ enum sbi_ext_id {
 	SBI_EXT_DBCN = 0x4442434E,
 	SBI_EXT_STA = 0x535441,
 	SBI_EXT_NACL = 0x4E41434C,
+	SBI_EXT_FWFT = 0x46574654,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -402,6 +403,33 @@ enum sbi_ext_nacl_feature {
 #define SBI_NACL_SHMEM_SRET_X(__i)		((__riscv_xlen / 8) * (__i))
 #define SBI_NACL_SHMEM_SRET_X_LAST		31
 
+/* SBI function IDs for FW feature extension */
+#define SBI_EXT_FWFT_SET		0x0
+#define SBI_EXT_FWFT_GET		0x1
+
+enum sbi_fwft_feature_t {
+	SBI_FWFT_MISALIGNED_EXC_DELEG		= 0x0,
+	SBI_FWFT_LANDING_PAD			= 0x1,
+	SBI_FWFT_SHADOW_STACK			= 0x2,
+	SBI_FWFT_DOUBLE_TRAP			= 0x3,
+	SBI_FWFT_PTE_AD_HW_UPDATING		= 0x4,
+	SBI_FWFT_POINTER_MASKING_PMLEN		= 0x5,
+	SBI_FWFT_LOCAL_RESERVED_START		= 0x6,
+	SBI_FWFT_LOCAL_RESERVED_END		= 0x3fffffff,
+	SBI_FWFT_LOCAL_PLATFORM_START		= 0x40000000,
+	SBI_FWFT_LOCAL_PLATFORM_END		= 0x7fffffff,
+
+	SBI_FWFT_GLOBAL_RESERVED_START		= 0x80000000,
+	SBI_FWFT_GLOBAL_RESERVED_END		= 0xbfffffff,
+	SBI_FWFT_GLOBAL_PLATFORM_START		= 0xc0000000,
+	SBI_FWFT_GLOBAL_PLATFORM_END		= 0xffffffff,
+};
+
+#define SBI_FWFT_PLATFORM_FEATURE_BIT		BIT(30)
+#define SBI_FWFT_GLOBAL_FEATURE_BIT		BIT(31)
+
+#define SBI_FWFT_SET_FLAG_LOCK			BIT(0)
+
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
@@ -419,6 +447,11 @@ enum sbi_ext_nacl_feature {
 #define SBI_ERR_ALREADY_STARTED -7
 #define SBI_ERR_ALREADY_STOPPED -8
 #define SBI_ERR_NO_SHMEM	-9
+#define SBI_ERR_INVALID_STATE	-10
+#define SBI_ERR_BAD_RANGE	-11
+#define SBI_ERR_TIMEOUT		-12
+#define SBI_ERR_IO		-13
+#define SBI_ERR_DENIED_LOCKED	-14
 
 extern unsigned long sbi_spec_version;
 struct sbiret {
-- 
2.49.0


