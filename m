Return-Path: <linux-kselftest+bounces-31577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5498AA9B543
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 19:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4881B67EBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 17:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC2928F509;
	Thu, 24 Apr 2025 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gKbkbaRd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1900F28E5EE
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745516036; cv=none; b=mAl8xUQ75vDCdv6lxEkXC5tOHB6AByoVyFzptCx0csi5c6K4eIO76Q8OH/t6CX1FvPSlaSjQ13kQXtKH9tATUV8uOgFPEOcyGPN54qj0Z/alQ+Y3u+Mjev+iCOTRqSYMfyKLCoXAHuRkAboQuznn90hfcE9DIMIpBPzqLYMMYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745516036; c=relaxed/simple;
	bh=Hvkg2vuWcLH+loCVg3KfVBlKpSfZ+GMWX4LieYFjwwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNUsd4ra+iKvLJ8GmnAOO9gph9m3zCollWkutebbaFlxvbUwhHgJhB8SQw6qfWkvHI/VleVLbrNCB+KMDhzceU1RN157JQGNkU8R+09dtgAjaAiLA7+JwjZDEEYsGyPvCeq6JNTJHX4zxAo4k1bfw1FqVqHoYWoNAGhET9vGLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gKbkbaRd; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22c336fcdaaso16654075ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745516034; x=1746120834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvf5XOciI2RxholK/olnAUr6RSsyRw+cO5ZQm+/Dg/Y=;
        b=gKbkbaRdJYoVwsyPc3EomBxUmPD6s2gSEj8UW55j1mMS/jZ9Akw/CBTGI3I/tmi8c8
         QRUe1lirj8vIgl15mVPVE2tf7SI0WbtfYAJXfwbt01Trm1oRIyXdX/aaQRQ4wBguaf3m
         PjML0brUMIJj2+XlNO5u8gUO0FiB5vYmxNNCxvZWQvczN/TePt2/+MG+8pHVBX1148Tf
         EC8ho4ME1cz6M4BfdnPgSPZ4YFq7WTPuGm6p9GwgAYRdV0ABS21SpRY19liNIKeitbXR
         Pqy2OXZ5JwdhycOf8ZpGDvPLTKAdp5uGj5lOBBYf066LLebU4TVHGdsIjGSz65cs6UtR
         mJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745516034; x=1746120834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvf5XOciI2RxholK/olnAUr6RSsyRw+cO5ZQm+/Dg/Y=;
        b=dpgudicp2IRoizBam8pLHv5bboh/osrc9eyvT5ylXN+OIsPOfmnhdqZgqvu1lltI/g
         rg9vzU1vB5wb0YNBe0y1O5iBxGsVnS1EU/dO2kQOO3jItgSXfdgwwfIO2z61gCa1QFl7
         L4wF6YN/ACu82X3zdyx5T0K5Qar8Cd5Qu5N6bwknpmGqyyTf72iSF77g3lSaqCrZmEV1
         OCI0aCV46Hq8f+hmnfPm0XXghsAIIu9Zd49SHOUgUYoVduY2ReQ0/N1U8w9itGG8x4iG
         e5Oy1SwipJf6KUhePBe2DKDCHsCYJn1D61zLuh/PV3RYmDtFWjQunswI8lyoNF34XSvp
         QcYg==
X-Forwarded-Encrypted: i=1; AJvYcCVQvgYTq1GOqFxJFhiOahKK39JlYXrtXf2QdYowHwCNlEZ33GsZWMahhSPEUb2w+pBgEZvM9ZKiaYB3srmAwdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+GwSOdJpcDmEVC7Qbt7V0xmXtYM77ENqtUoUzi6Hgx6oBSeIY
	xVdhyQlDosvKmzdKmrgYKPlqqlivxv3iUV9BvANr0a9u8zSanqziqBjyO56Iw/M=
X-Gm-Gg: ASbGnct9vjGwHoLGS+KlBkhM0tweR2HiyjLN90oVwYCBuqOtWqkA1HqdMNkKqzZQiQn
	+ZxreWFbZgKUZpO4xseXdFFy6laDZ2YMB6f7pbzAtvcq7lBDxR16eD2NY6VPdVAskqiMkQLul4F
	Ia1UOOY4LH33pL69flDthViWY9Xp18J2/XivyiatwES5G+cYwJ4wr6TQfvgN+reNZwPIJ78MRZw
	0TZYpJ8VGHqcJno8iSNinHcp5FRLP2LPH/+rRQ3MUpnicZnudg2zoWSj+xtbyH9C3VJU5v6Jb+/
	H+3NUJRaDyrb10/wztBdG6ir7I+kdsvWZzsB4hDiRw==
X-Google-Smtp-Source: AGHT+IHaM8bzJfRRvw0MkUxc3QW2tm+twyY3rgnrMs/7xPlJBt/0WAycPUEFxVys/K0zq71dkmTO4g==
X-Received: by 2002:a17:902:d489:b0:22d:b243:2fee with SMTP id d9443c01a7336-22dbd415915mr4178995ad.13.1745516034428;
        Thu, 24 Apr 2025 10:33:54 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5100c4esm16270255ad.173.2025.04.24.10.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:33:53 -0700 (PDT)
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
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v6 02/14] riscv: sbi: remove useless parenthesis
Date: Thu, 24 Apr 2025 19:31:49 +0200
Message-ID: <20250424173204.1948385-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424173204.1948385-1-cleger@rivosinc.com>
References: <20250424173204.1948385-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A few parenthesis in check for SBI version/extension were useless,
remove them.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/sbi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 1989b8cade1b..1d44c35305a9 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -609,7 +609,7 @@ void __init sbi_init(void)
 		} else {
 			__sbi_rfence	= __sbi_rfence_v01;
 		}
-		if ((sbi_spec_version >= sbi_mk_version(0, 3)) &&
+		if (sbi_spec_version >= sbi_mk_version(0, 3) &&
 		    sbi_probe_extension(SBI_EXT_SRST)) {
 			pr_info("SBI SRST extension detected\n");
 			pm_power_off = sbi_srst_power_off;
@@ -617,8 +617,8 @@ void __init sbi_init(void)
 			sbi_srst_reboot_nb.priority = 192;
 			register_restart_handler(&sbi_srst_reboot_nb);
 		}
-		if ((sbi_spec_version >= sbi_mk_version(2, 0)) &&
-		    (sbi_probe_extension(SBI_EXT_DBCN) > 0)) {
+		if (sbi_spec_version >= sbi_mk_version(2, 0) &&
+		    sbi_probe_extension(SBI_EXT_DBCN) > 0) {
 			pr_info("SBI DBCN extension detected\n");
 			sbi_debug_console_available = true;
 		}
-- 
2.49.0


