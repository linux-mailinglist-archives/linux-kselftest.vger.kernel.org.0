Return-Path: <linux-kselftest+bounces-7556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CABC889EE79
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 11:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5875BB22783
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A87815EFB2;
	Wed, 10 Apr 2024 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bk/BFyIa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA46515E811
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740284; cv=none; b=n31a9ZDxTsZRpL6vSHPA7Rh57U+0U4EXYH5Y47wkiTbDYIFuXkuMEwM+ZAWayQGAv0bQylpJvWcyJok6mv6sc7+rE7CVJZACVhTNDHUQ9wy4FUokjoyBSX7v0A+tCZ8qxnz9LzU6EBRfPaQCo+jPykHs7pY0MDQ1SL+5K7+dWEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740284; c=relaxed/simple;
	bh=boke7k+fuPr/buwvZEKJqr5O7FQgiL8dA2Us1JuDFEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=baSRg33LroSfpWo0WWR7jHaaY7MsSlDYNlK0hWy8KVP++ZAb+9skXy9OtLQbG+5D9ETXOI9NgFRPkePsb6TI/QQEZ63bOkV5A1N7XBfD57VISLJwecxMCIndSqtl5bxBDH6UqjnxD4CKDutWBwnf5KmLpwaaj+1Q5LT5wtEZxfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bk/BFyIa; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34560201517so889184f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 02:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712740280; x=1713345080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJJluMz+u6UTg8XM641LtNTBq3D7zPplm+46K1BBT3g=;
        b=bk/BFyIaHE0pO6HUdWxu55HzN+kp9JNMyY4GsAvDSZckF9Ju1VUV1E/Gy8YnCYEGxN
         RtODCTgwrJl55hEnic7oSFMPnfZa3HNezEHnNwlo1s6GiFMYE0xXbeb8FYukfGcaktQr
         +ySTMYqSmB10Ug2q8R7ezjkcpvoiv7lFaXoxby/iW/CJYiU4UXEBTf/FUlDw3mu7C8Kw
         cV4cKjvhFot6ji8EjitDunUEkDY/Hrk+l976EzrrR4ujELGoDCdlI4ughddOWu6b5rZi
         S2EBWzUjnWYrO4UutqLLLsdv3dDgF3SDvpYXfhyUqlLJPkwzAf3y+Uh/tmQ1dXeMJmZ9
         5iNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712740280; x=1713345080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJJluMz+u6UTg8XM641LtNTBq3D7zPplm+46K1BBT3g=;
        b=sxxgEssjoea1svqbfRT5LDpACqjbZvAk1jUBCQlrM30KTEe1SUqQKwZWGQ18OwJRwO
         +0vYQxsA48RdfLSOGHdoYGNn9KG8QZdqnL3SvcLYPkggpPSqxwb+WaVoJw3MQHYm/0Dg
         INAd9uwJXPfQSjPZyHgdZtnbqG/d5/QvrYLDlavlR7eg4Os/2k846B3IcpqzPElellnI
         yws3oSfcqcR1UKzLYE0IWGMdtUP1UBD0E49aoZLW6ELJC4ogkL0eS7XYnNfS1CjF/BOm
         89KFKX1S9QQLcv6k7sXhhKFLMr0ASxTF4IJAWrHkRAWu/5UDuojxfytssHDMURtMUYo3
         aiSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmKSbk+pFdsvuEXzWqsNNsc8wEtIfSnjMJ2Mt8g6ViciNhHWbyPYmlEr7tArtlLWqXJEkgIalnsAo//39UmqDMHTfW/U4g6+QGsqDugAHl
X-Gm-Message-State: AOJu0YwhnRooPFlzlJfZYOQkzXPZ5KoDsXlWQ3eqXd5esxouim6HY/gj
	WXdWXzbbc5pL8sCf/TzaypNCVveIyy0EL4EVB1+YFM4/U2HJU6Uvua3w3wV5Ddo=
X-Google-Smtp-Source: AGHT+IEFPf1rw4WsvUPP4gQ49sbgG/8PoNAGTh7VbYh9f/s9CL9k/Q3vxX6P6qvCn28cWYP3BC7Kuw==
X-Received: by 2002:a5d:5982:0:b0:343:b9e4:ac2a with SMTP id n2-20020a5d5982000000b00343b9e4ac2amr1633081wri.4.1712740280271;
        Wed, 10 Apr 2024 02:11:20 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:d4a6:5856:3e6c:3dff])
        by smtp.gmail.com with ESMTPSA id d6-20020a056000114600b003456c693fa4sm9079086wrx.93.2024.04.10.02.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 02:11:19 -0700 (PDT)
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
Subject: [PATCH 07/10] riscv: add ISA extension parsing for Zcmop
Date: Wed, 10 Apr 2024 11:11:00 +0200
Message-ID: <20240410091106.749233-8-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410091106.749233-1-cleger@rivosinc.com>
References: <20240410091106.749233-1-cleger@rivosinc.com>
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


