Return-Path: <linux-kselftest+bounces-25067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BD6A1AF40
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 05:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F06E16D36F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 04:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BC31D88C4;
	Fri, 24 Jan 2025 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VRwZSVXO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2BC1D63C9
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737691265; cv=none; b=jJlgrgkMEPhoabJgFCbVIyuHdYmw34a493jUQo84zcLBogc0dWIC+92kgCgjZspNRTLhXyu7fXqFgemHDue/7FBc2gVXzjqCJektIFXg77/4frIpSQlsW+rsOGAL88dmpqBo+3G9anWn8qWj2TOzMNPBX7UeNO+SzriPB60BHMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737691265; c=relaxed/simple;
	bh=G+K9MvSpAIpwDwMmunI0YSdJnqQJGTJZcC3ONEVxX60=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sjuj7YWfJGJV1s7Q+L1BIjhUEkfoYmUyEPaPMzFb0tioGm9ytRCXuLdiHYRIE7HiLDILXh04gfIm601hUYwVXnNBmp0GVFcbDaHVLWcWlyrG6obZthuYCkAsLI7oVAJC+SzFEVSyQowatE8M4vSsqgatD2sbB1MplxTP4KiOf0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VRwZSVXO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216426b0865so26952155ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 20:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737691263; x=1738296063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+lHU8O3OzxopxeMRFW7AZqN84liiT6mDTuuIRoGMNs=;
        b=VRwZSVXOhTD2P4yJYnfWOX55FTyD+UgYkwpt7B3k1j4K28tpvuxAW2u73V/X8VbzoM
         +I2v0tnJVVWgvYokh1mzGuPJ+pxtHDONQDaJdDLeLy1pbjvra0u1WxfcVOAZ/SHG5fME
         DVk+tO8D5KWKJH55uAPk1YeTxEXuI8SrKzxggelsisEhPrSd9qKkUOw/hzT3cHCuw3ZW
         iOo0/hKtg1hAipzplBu1OdcZ2VxIeS8gPbCUL2zjENcLNoEPdnjJ6QftpP1pRDFm9ZRC
         HLjhVGlW20atzF9jHdZ6QKijprPSefUtf47WLZlUlr8P37Al/+6M0BAdO0lABD4ToqW7
         7Lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737691263; x=1738296063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+lHU8O3OzxopxeMRFW7AZqN84liiT6mDTuuIRoGMNs=;
        b=Iz2JogIBwIcsEdBDEz5q6+DVy/bm0GwjPVj0PH8OYnusd/rXYDogAtxDhdVz1/JK7s
         BHUZ+bnAi/ZbNNPAEKQZOS/iLaWIxHg+kOaIB3XJTNatrFTU+AitBV4kDLvSn8VWp1F/
         V33PYH9qMVoYnTGoFotItnq0TAaBvjh3gcLIsZF/WHPbnbpGpwmM2kTbGd9hfWscoOPA
         GQ2ZqZucnQmxg6gHLgMp0Stw/Oobl0mFCDp0ML0pesLWbVwwOv4dCF1hAyEabpJiCIHz
         6p4nG2WhiqySAe4T0l6PFNyN09dSUpUEdFx2e6MIJzPa7il1zogdm5R/9JMuhuRIOtt2
         uvFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI9yCbm86+Nb3kwgGKMsqv9S8xZXWJ3NXqUMiD6TZ63VpUEAtGsSCBxeHudQayKaBcI+MKWs2rtOpUadvMZmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAnObNdA+Cvz9+J+ig854q8e84fghU1b71RxkZuwLjeF3IetcQ
	uAPFZNWlTtC18J2ru0m7LRDjEwqmsaZZhehpgX2YOvVGOJrnodctTBsLBfLfutI=
X-Gm-Gg: ASbGnct8cogLNN5kCoZrsIZ4k7qrOG1i4C5Rs192T18H935ujDhkuJIEOE0rXqRFqwy
	J85lBvTTAaIAl4Qp10Ns8JFEb+aMkWXL59whjJJlFESli55b7IwBOHcJ4bNjlsGuaZmYkde/bhv
	C6vXE18a/RahIwG/gg1F/AMImkgaFXhMXvPVIY2h880kZMOMnBgZ4oydlO5I0FHs4ixD/OauV1l
	FQqum6/V4eSitvOdfCt5PJ4eF1ol/NMA7WEJWbBT0mbC3pNWlVfInVorlB/pac/XmGvYmTT9MK7
	hgRo4mD8B9jUPgKYN0yKt9Eenp2RZv2e918bUxLxudz2a5L67w==
X-Google-Smtp-Source: AGHT+IHEVuIwXoOL2BRMckKQdUn6rThK8+gCeYIzAbtbkLa2fGtpENXBcF3NVF3avHHuHE184wgyUA==
X-Received: by 2002:a17:903:8cb:b0:21a:874e:8adf with SMTP id d9443c01a7336-21c355dc4eemr425518995ad.45.1737691263230;
        Thu, 23 Jan 2025 20:01:03 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([2408:8406:78d1:bf49:24c4:f518:9b3b:36de])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141d67sm6758915ad.153.2025.01.23.20.00.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Jan 2025 20:01:02 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: ajones@ventanamicro.com,
	alexghiti@rivosinc.com,
	andybnac@gmail.com,
	aou@eecs.berkeley.edu,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	conor.dooley@microchip.com,
	conor@kernel.org,
	corbet@lwn.net,
	cuiyunhui@bytedance.com,
	evan@rivosinc.com,
	jesse@rivosinc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	samuel.holland@sifive.com,
	shuah@kernel.org
Subject: [PATCH v6 1/3] RISC-V: Enable cbo.clean/flush in usermode
Date: Fri, 24 Jan 2025 11:59:57 +0800
Message-Id: <20250124035959.45499-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250124035959.45499-1-cuiyunhui@bytedance.com>
References: <20250124035959.45499-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling cbo.clean and cbo.flush in user mode makes it more
convenient to manage the cache state and achieve better performance.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/cpufeature.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c0916ed318c2..60d180b98f52 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -30,6 +30,7 @@
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
 static bool any_cpu_has_zicboz;
+static bool any_cpu_has_zicbom;
 
 unsigned long elf_hwcap __read_mostly;
 
@@ -87,6 +88,8 @@ static int riscv_ext_zicbom_validate(const struct riscv_isa_ext_data *data,
 		pr_err("Zicbom disabled as cbom-block-size present, but is not a power-of-2\n");
 		return -EINVAL;
 	}
+
+	any_cpu_has_zicbom = true;
 	return 0;
 }
 
@@ -944,6 +947,11 @@ void __init riscv_user_isa_enable(void)
 		current->thread.envcfg |= ENVCFG_CBZE;
 	else if (any_cpu_has_zicboz)
 		pr_warn("Zicboz disabled as it is unavailable on some harts\n");
+
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOM))
+		current->thread.envcfg |= ENVCFG_CBCFE;
+	else if (any_cpu_has_zicbom)
+		pr_warn("Zicbom disabled as it is unavailable on some harts\n");
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
-- 
2.39.2


