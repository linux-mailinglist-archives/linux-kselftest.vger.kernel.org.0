Return-Path: <linux-kselftest+bounces-24418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF87AA0FEA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 03:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F3918894AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 02:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE95230980;
	Tue, 14 Jan 2025 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="T7jugol4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3846C22FE1D
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821221; cv=none; b=AGU+DWk+aMmGAZgJy8ipMN3LodVq/+1QzQHEUMD5N76fkIWhaIZBsxFT2UZJXdLiHNoCKg/syPRWwGdR6C9G4h5sOtW+t+pyH4cDpUfHXbtNsgflS/7f+k7w1842GIXUOe39eaQjg5OfO7M3WJYJmBSLcmRSM2HpsCu0+pdGUJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821221; c=relaxed/simple;
	bh=G+K9MvSpAIpwDwMmunI0YSdJnqQJGTJZcC3ONEVxX60=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YdrO2aPnykfQsO7LvtIeJkXMbM3UMfWp4SCqA3HJ5yc4+YGTjg2l+xVzd/WStKQWZZ4afrWaGrdvRQEOP6x8D/PZFyaXeeHo2HP5c1y1KRGOzYP8Wyk9rQbjO6STJRbYEaUG7wrmItgJ1TFWrYFHXh+l3FO+FQJMHO4u00/uEE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=T7jugol4; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f4409fc8fdso7428828a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 18:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736821219; x=1737426019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+lHU8O3OzxopxeMRFW7AZqN84liiT6mDTuuIRoGMNs=;
        b=T7jugol4+jHH7M61R0zk8IPHrvXHfAO96tz92v77b2NRhL9Cx3/fm4816wrfPNSTPs
         J7xv8v9cJA60cXwdlx+FEB0VI9HOK/WFB8iL0G3eHqLSxSrFkv2LiCN3ks60oBvsmrwB
         mSNNluRggm0c13zeWvaoED723+QtNG6tVshP6n19xwZ2qH101Z9jGjUU8L2AHaShSLTj
         boEELjt8TmwsE2haWON3Exr5gFI03E/M5XR6WEHgq7U4bbxFq1GsRI7U1UnLx+MR8JBt
         Nbwd6nv9Mf8XSRW5PjK7PM7B2dxGA02wu5/T7+wgvU0AIEA+Um9aoaetAmQ9f9SLwZbf
         x1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736821219; x=1737426019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+lHU8O3OzxopxeMRFW7AZqN84liiT6mDTuuIRoGMNs=;
        b=Rfw2xrZBXbvr7f05Itezm+7FSyaE8FheHJcWxPQweUGpq1o5bNulytZhE67+gnRJ0b
         TXsxEsgqbFHjy3tGEd/GRYwQHSRv07hdOn6kmg9aHPO9d5pLjQ2c1SZrJnZA5B6wk8pY
         hq9uLHV351hwsciOirSl7o0Uf8AN/wl6xwNCqoAi+k24vvhXPJMHMCTybPnGyZ2gW2FV
         +/6mB4f/pFlvaGaZZsQQ60aWnefdQ+PXqEcVlwpHyt5NI9GshmMKbxWAvt1QRiXQj4La
         nvY7jZzZJkWxlz1I2y5b/nQk4ZdQFZU/gyp1D+sUorYnRez0ZuRVEWLPof+aM4yoIN5O
         fxQw==
X-Forwarded-Encrypted: i=1; AJvYcCXhLn9gML+4iRM8yZKTlyKBLtnJHFaSpJKq4hi0RuD8auLK5ZP3HYpK+cZw15aaOzm1vhYxgIATkCgS1OR+xSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxLLVjMKtCPuCa1JekB3JeYkaxBD29CiDVzGR07pC8fia+hXtb
	AOT7WSR2d7ppw9g0AZnI7AsZDeUEqDiExdb6fMfEdd5ssXyGPYlDS2MLQxhHsBk=
X-Gm-Gg: ASbGncsq2bv3UB9YUR7T9ipzWmnWsiIZyN+zpOekL5O070asm+8sy7VG0+SiEoWuVyC
	kP/N6wFTCsCRtozS/N5+SMEZgFrS51amwZqTdIO///1nW2xkiEq0/ptS0pDO2UIK2O3IPU75Ny1
	XjGgHw4b+X7AEi2ozCDxHUHtwOy2o1NZl5cecDD+mKERlTdinyNgBZVcbg4G8iz5t3GFdZ+nQRd
	Yn2dYP/KDhHftL6lV/W4keS+umSiDf2tQWVKeBKaLNq+OA66ZTtVe6kkBELbGPORApd+//CEwpP
	1c5g8sL9V/GQ86w=
X-Google-Smtp-Source: AGHT+IEpY8vThDWOwMPEtXiB5G1hpEHBvYVE1WuJdpEosAMMRWGkN1c3leoGAuLEHJ1SaSfa2zx7OQ==
X-Received: by 2002:a17:90a:d448:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-2f55838d0eamr27670389a91.14.1736821219527;
        Mon, 13 Jan 2025 18:20:19 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f217b38sm58948065ad.145.2025.01.13.18.20.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 18:20:19 -0800 (PST)
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
Subject: [PATCH v4 1/3] RISC-V: Enable cbo.clean/flush in usermode
Date: Tue, 14 Jan 2025 10:19:34 +0800
Message-Id: <20250114021936.17234-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250114021936.17234-1-cuiyunhui@bytedance.com>
References: <20250114021936.17234-1-cuiyunhui@bytedance.com>
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


