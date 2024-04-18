Return-Path: <linux-kselftest+bounces-8324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654E48A9A33
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 14:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D706FB21E6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 12:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90A4168B1A;
	Thu, 18 Apr 2024 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IzRDUPdq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC99165FC5
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444248; cv=none; b=pTGw0Lm0EVyiPoSsIOU/HyQhyx8MV9wemNRx/hj8aT4CDGR0IBG9Vy5jMbHjx4TyS7buaaeXfHdtHTAdV7Cdxkog3ysPMQf+BDR4i+OSV44PIbU8W3kBkgXVzySSWPYDmPf27vsfuOptZwhemu6mzYrR1+M6B0SM/zrHlsnlTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444248; c=relaxed/simple;
	bh=boke7k+fuPr/buwvZEKJqr5O7FQgiL8dA2Us1JuDFEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cuq5uBXhZRXORjOSpD0T0iSz8v05WZBz3H8etEYlN2JvMOFv5/uew09zTqfKCWfJHhbcTWyIbnipRBEPUcNnmhK05n1f45TSCvNdvVExxSjfNBEdXTWSkrcUB+TVpZpuJpFMWnPeVaBNKANA8C8WYFNlrdO8k91eXcwUdriw5Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IzRDUPdq; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2dac628f081so2210961fa.2
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 05:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713444245; x=1714049045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJJluMz+u6UTg8XM641LtNTBq3D7zPplm+46K1BBT3g=;
        b=IzRDUPdqJ4Vlg87RINfb9CIyPJREmt9Psx3Qd1IrCBHTLQjoYYN55/s9kaLgRafHp+
         mmu3lg3cXMIVebSj3S+5gydCrwz5G5cGLX+gtS+n2lIhpprJYMMGjWeTf6q9joZycq3F
         wA/ewDw30c3CFmaGgc/M6p0jcEWcmvmFKI8oIeFkC0Dqk1ttxA5EJ/ddZR3keeNHgLu0
         LmgFW8GZGMgcqfAOud+b69OSuuxSumW3/NcOJ1D5GoYCqvnWb8tb+AtP6RVybGLiK4uy
         KpKQpU+Ts8SmSOTn87kOjwUPQPw27WDoe6TXoQQGPL9CmO8Mhxv2bbmp0P1FlB6pA3jh
         /pXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444245; x=1714049045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJJluMz+u6UTg8XM641LtNTBq3D7zPplm+46K1BBT3g=;
        b=MupjcNVkSzkYrbTYqOm471lbTu2SySbFcJyrhOZt0pktdGDPGDZCGDKEp3vQCXdWM8
         u+99k+vxG2N9dK1CKXjwAH5QyON1Jz19DxYQ9qGj/a25aQYO5PM44lLOtK4Eh/LX42ER
         ddkJUYiAa24Czse0rQeHmqZB2TpQO1CoYI+4MKruUsljW671QXseLo3YlOxgRADqKYxh
         wsbsj1F8tNQxI3D3VQFiiigEGrWTWN8+GoGQyOrZKR6KZIcq0kYsyfekeLfruEwQw77F
         avOYvv2xdd5F6aHhLG65rjBXF3FjYzEbX8HpxuoiBEwar6BbSpN6Nu28SWlDfVt7mcdO
         pfvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSBJZpFf6uNTSEAZPtiGbBOpdfEfo+wNhEyAnyzphgZ0FEBH/KvY2dYz539Wr4CnnGR3MQnnrO/v8UT6Lt4arlFOOCZk2LJTU9TPS+E82W
X-Gm-Message-State: AOJu0YzdCQkEMQgJOCbXiHhhB+K3oU510I1VWAzQwN6laARkvkITkUJN
	/Ut/UutzWh8vbTEO2+RifU25arD1FR3KUflyaailg+o+TDKsX6sty8KK0o4YMCE=
X-Google-Smtp-Source: AGHT+IEA98F7NhkSpgbqjXTJDAARemLQxPRyTCHu7WNOEPKgiNpZ7WkvoQPUAaqjKtkLyPbtJUVEhQ==
X-Received: by 2002:a2e:9ccf:0:b0:2d9:e54d:8208 with SMTP id g15-20020a2e9ccf000000b002d9e54d8208mr1639216ljj.0.1713444245128;
        Thu, 18 Apr 2024 05:44:05 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7b64:4d1d:16d8:e38b])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05600c3d9200b00418d5b16fa2sm3373412wmb.30.2024.04.18.05.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:44:04 -0700 (PDT)
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
Subject: [PATCH v2 09/12] riscv: add ISA extension parsing for Zcmop
Date: Thu, 18 Apr 2024 14:42:32 +0200
Message-ID: <20240418124300.1387978-10-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418124300.1387978-1-cleger@rivosinc.com>
References: <20240418124300.1387978-1-cleger@rivosinc.com>
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
index 09dee071274d..f1450cd7231e 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -265,6 +265,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zcb, RISCV_ISA_EXT_ZCB),
 	__RISCV_ISA_EXT_DATA(zcd, RISCV_ISA_EXT_ZCD),
 	__RISCV_ISA_EXT_DATA(zcf, RISCV_ISA_EXT_ZCF),
+	__RISCV_ISA_EXT_DATA(zcmop, RISCV_ISA_EXT_ZCMOP),
 	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
 	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
-- 
2.43.0


