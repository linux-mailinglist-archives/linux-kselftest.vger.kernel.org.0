Return-Path: <linux-kselftest+bounces-12237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1768190E9CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 13:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11112890DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 11:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127DB153BF0;
	Wed, 19 Jun 2024 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AsvP4cm8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6452815099E
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796959; cv=none; b=r/h+wIkAE9nwz3smzhghF4UYaWrk5QstWj29xKmxQjq7ltjr175lUkHyflQBen+YWxy3jsn5tIdbLNFobgg8WZ62wUP3kHPu5/VJN+HszJQ7ZhOkDnoeBcoAXzfCpEGgE7aIhxDmgZCZXbinp4DOHRyjaosATqheRSigEnMS25A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796959; c=relaxed/simple;
	bh=bq8xuYEPfESVQzVjw8P7O5vmRTT1hfi5KF6LtFr+gvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOA1NHDhzjXygrJBWJThkWCktHkMUbqDplfuchg4BkkA8Pfnq+uj1nKe9RXa6Ux75A+CH4BHUungaKmWbzNuQrgDl0l/xd40TUyHJomQCoMtiqKFcDe2+fO/vw2JM6PkAAyy7jtDOLmUwkbyAbRHJ1nsufa+p9iolusU3z2Kq7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AsvP4cm8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4210f0bb857so6503635e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 04:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718796956; x=1719401756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSqXY8NQ+r1tvQyzaHIZAo9j3jx7qiAIRPgNfgAmyNo=;
        b=AsvP4cm8R8FzXRjnc7jc0uX+ED1cmxkw3dTqUnqYhgsiEmt81aLDiCX1D20HS2NvxJ
         DHh7vbx8HtzrLBsk/XbW6zcSXDydVEe/8T2N+dPdVU/YO1upoflxHSF4t+sscs4wyomU
         lQQXdvQ7qSGfhjeVy10tIzYvTAVo8DCPmxCkvH9EmAJaDijNyYy8M17PccTBSLgezWOd
         rHF5IK8zhgdIxh5fAIUEZlPESOgnQWLSfQjvofAO2Fzf9KdQq02DN6VxYBD5aS+13VC7
         HNlfdnHfZJg09XqXEn0FuVoFpblpfDjUFRFPfJpM9KbI51IQMRLUhMN1onPyycTfBJUC
         bWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718796956; x=1719401756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSqXY8NQ+r1tvQyzaHIZAo9j3jx7qiAIRPgNfgAmyNo=;
        b=UJQw8QIOutRNIUYjLFf6/lXllUC2Drg7VEe4qZWcpoUrRzxH6GDWThJbh2DT/L2XyO
         iH6eiWEY5RIDDejugW+iVFvj/Ukrd9DscUekhW3B4WdBmrWXMybUEQ22JVdyjSCS6bQz
         EZuO53sLz2JOVgw7TCHwxkexd5J8zD4uxaz+fDb5kfE4RIEJbuXeXfI22O+F6lBHbzaz
         1GyjWaC4Y3IsHld2bx+6+/W3WNuSNJELxPGnYP1ZQqilHMdmsTtopklkmYjhhNBOa5H8
         3FXuHEMMHmwnCzSioh1BdN6qrKt/gwl2hk357tVxfWSnkbn5IBqPqZOex/Zao/8ypGnI
         uL1g==
X-Forwarded-Encrypted: i=1; AJvYcCUMXwlsEbbW9YDiYOXhTOHG88cK2KUWP/ldonk2L/t8F3BUXyZJq50cM6VcaSLyCL+2Ays6ZK80fUJ0mCSJuE8nkpPBx4+TbIkKgy1ZkomG
X-Gm-Message-State: AOJu0Yy1zTNwfBrhctkY9JBfiVrQY7fi+N4lhE7npR5RciMtAHHsfjHl
	8cw2to1AKc4EthFKYNQHWMxp5cuWni/aLCF6YkAALYJK2RSE/2F9lCbKCJ78IFI=
X-Google-Smtp-Source: AGHT+IFlfP3NiyvXQKFOTNdljGuXnZt3spfJFUH69VuncHuc4xx9gjHsoS5MasjNknxMee/w3CiUxQ==
X-Received: by 2002:a05:600c:4fc9:b0:421:bb51:d630 with SMTP id 5b1f17b1804b1-424752981b8mr15706485e9.2.1718796955960;
        Wed, 19 Jun 2024 04:35:55 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:e67b:7ea9:5658:701a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e9681sm266192075e9.28.2024.06.19.04.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 04:35:54 -0700 (PDT)
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
	Conor Dooley <conor.dooley@microchip.com>,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v7 13/16] riscv: add ISA extension parsing for Zcmop
Date: Wed, 19 Jun 2024 13:35:23 +0200
Message-ID: <20240619113529.676940-14-cleger@rivosinc.com>
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

Add parsing for Zcmop ISA extension which was ratified in commit
c732a4f39a4c ("Zcmop is ratified/1.0") of the riscv-isa-manual.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b12ae3f2141c..4880324a1b29 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -91,6 +91,7 @@
 #define RISCV_ISA_EXT_ZCB		82
 #define RISCV_ISA_EXT_ZCD		83
 #define RISCV_ISA_EXT_ZCF		84
+#define RISCV_ISA_EXT_ZCMOP		85
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index aa631fe49b7c..ec4bff7a827c 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -354,6 +354,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA_VALIDATE(zcb, RISCV_ISA_EXT_ZCB, riscv_ext_zca_depends),
 	__RISCV_ISA_EXT_DATA_VALIDATE(zcd, RISCV_ISA_EXT_ZCD, riscv_ext_zcd_validate),
 	__RISCV_ISA_EXT_DATA_VALIDATE(zcf, RISCV_ISA_EXT_ZCF, riscv_ext_zcf_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zcmop, RISCV_ISA_EXT_ZCMOP, riscv_ext_zca_depends),
 	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
 	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
-- 
2.45.2


