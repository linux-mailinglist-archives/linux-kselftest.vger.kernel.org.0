Return-Path: <linux-kselftest+bounces-3520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A34D383B9A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 07:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8EA21C23FE1
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 06:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4098310A28;
	Thu, 25 Jan 2024 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="T5viQhnF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAE512E48
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 06:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164130; cv=none; b=TP3RpRLMfhZtycSLwHzrZLpsk6qJ9enxTBfQWfHW3Gfua0nuSdV0uZ/oN/aiB9f7Nq9a23lgHkhBA/yPstujWKIloKFdoPlaa6gzlMpsOESMUD39VGJx/v/IL+nseIqQ2MQshfM0NJnMIsKBDK3W7BoM8fAyk64O8GrL1kD6uRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164130; c=relaxed/simple;
	bh=5IIzPP0RItrtggjbTzPQCLuAoBzRra5iE382y3BQm5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfQxXqpq3rdQ+gAyfFwccW429ajAfzjo8bPEc2ChwCmjC+R995o09wDNsR7CJzxEIlX9WXoqfXEPHRcnj2x8fX5Qug5gLzbJEjJyG/hGN4x3eUYL8jfuNByECM3RPa3HVyCesnP92UW/LaoAcqpGlA2RSgJ9bBrEhQFfSblHivU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=T5viQhnF; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-290d59df3f0so1967250a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 22:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164127; x=1706768927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAejTXU0ubiQ5glx+ACfMnILZ3BSyMGr/22gR94zPLU=;
        b=T5viQhnFGDyyoxUR2/AZJoMcQq40nvirqempLroRZaSbGb5ZkzBcoaMySPY12FI0xk
         W14m3k2xyaAX+xBHMSVMED42S8yfZsvyGsirKa00j2G4PTybJgoeg02BC83hCnzJawbS
         Z5YvysVsuRaHKr/ckfTMpVfhmMcGr+GmbX6jGgcNWr+ItD6X5+awGKNAOOo9tV3JiMlI
         QSpMO3oht3dXSNxQggTp1C66oqBywbSdTa0r0JmEDFZGfXaw8Q7jYnKbPYlAn2VHHgqu
         RThP6tMKwZW1xnZ1yW6xBuBc/BkuHX1MZVnO9L+f20WxRggy9Q/jLAs0nH3UMnkiPp8b
         fDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164127; x=1706768927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAejTXU0ubiQ5glx+ACfMnILZ3BSyMGr/22gR94zPLU=;
        b=Ncnn6SOGxBaky13/nEulRY6WsLe429zexlM2ujcB4qbGOqkDPXXWYaujejHfdgQj4T
         k8y2PFYBWNLhIqMSKz3x8+0PNhNQQSlrqpZ0TAkbmK8tDFlMphJHGD6GrWvzWgG6b5uw
         EPJTXA50XopwVr0BXLuU2N65CnzIxbpdYRSgIXimLGIWal73/FC1c2EhvWtxp15WvTzs
         P8ym7XXD5Wu5ooFPT8iHBzq0ibSVU2YZJH2i45a6itqJQPZpktOEaHO1wH1jUpfq1xn1
         7FGRYwfUIZI5Yq+/Mm4dhVZopxdFlt4/K2hVZZFnXk99+d4g5dDSocehVKQwo++BVP0w
         WsBQ==
X-Gm-Message-State: AOJu0YwmGlpqD08ZGJuQmMTD4QQBU2onEwARohZUuBHetPl3VUcQi0C9
	bzzs8+zR/T69JF0i+jM/7cuBN17PQtA7RawLi70jJXLjwUPpWsnzHD5pBrt3xh8=
X-Google-Smtp-Source: AGHT+IFqFfG67XTDjoNiouy/3B041dutuvZL3hrVwMOIb2sdzt40BlsHHzBmvSINS1AroXPOL+Y8dw==
X-Received: by 2002:a05:6a20:1447:b0:19a:2e13:667a with SMTP id a7-20020a056a20144700b0019a2e13667amr750598pzi.5.1706164127531;
        Wed, 24 Jan 2024 22:28:47 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:28:47 -0800 (PST)
From: debug@rivosinc.com
To: rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com
Cc: corbet@lwn.net,
	aou@eecs.berkeley.edu,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	waylingii@gmail.com,
	greentime.hu@sifive.com,
	heiko@sntech.de,
	jszhang@kernel.org,
	shikemeng@huaweicloud.com,
	david@redhat.com,
	charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn,
	willy@infradead.org,
	vincent.chen@sifive.com,
	andy.chiu@sifive.com,
	gerg@kernel.org,
	jeeheng.sia@starfivetech.com,
	mason.huo@starfivetech.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	ruscur@russell.cc,
	bgray@linux.ibm.com,
	alx@kernel.org,
	baruch@tkos.co.il,
	zhangqing@loongson.cn,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	joey.gouly@arm.com,
	shr@devkernel.io,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v1 05/28] riscv: zicfiss/zicfilp enumeration
Date: Wed, 24 Jan 2024 22:21:30 -0800
Message-ID: <20240125062739.1339782-6-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125062739.1339782-1-debug@rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Deepak Gupta <debug@rivosinc.com>

This patch adds support for detecting zicfiss and zicfilp. zicfiss and zicfilp
stands for unprivleged integer spec extension for shadow stack and branch
tracking on indirect branches, respectively.

This patch looks for zicfiss and zicfilp in device tree and accordinlgy lights
up bit in cpu feature bitmap. Furthermore this patch adds detection utility
functions to return whether shadow stack or landing pads are supported by
cpu.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h | 18 ++++++++++++++++++
 arch/riscv/include/asm/hwcap.h      |  2 ++
 arch/riscv/include/asm/processor.h  |  1 +
 arch/riscv/kernel/cpufeature.c      |  2 ++
 4 files changed, 23 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index a418c3112cd6..216190731c55 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -133,4 +133,22 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
 }
 
+static inline bool cpu_supports_shadow_stack(void)
+{
+#ifdef CONFIG_RISCV_USER_CFI
+	return riscv_isa_extension_available(NULL, ZICFISS);
+#else
+	return false;
+#endif
+}
+
+static inline bool cpu_supports_indirect_br_lp_instr(void)
+{
+#ifdef CONFIG_RISCV_USER_CFI
+	return riscv_isa_extension_available(NULL, ZICFILP);
+#else
+	return false;
+#endif
+}
+
 #endif
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 06d30526ef3b..918165cfb4fa 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -57,6 +57,8 @@
 #define RISCV_ISA_EXT_ZIHPM		42
 #define RISCV_ISA_EXT_SMSTATEEN		43
 #define RISCV_ISA_EXT_ZICOND		44
+#define RISCV_ISA_EXT_ZICFISS	45
+#define RISCV_ISA_EXT_ZICFILP	46
 
 #define RISCV_ISA_EXT_MAX		64
 
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index f19f861cda54..ee2f51787ff8 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -13,6 +13,7 @@
 #include <vdso/processor.h>
 
 #include <asm/ptrace.h>
+#include <asm/hwcap.h>
 
 #ifdef CONFIG_64BIT
 #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 98623393fd1f..16624bc9a46b 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -185,6 +185,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
+	__RISCV_ISA_EXT_DATA(zicfiss, RISCV_ISA_EXT_ZICFISS),
+	__RISCV_ISA_EXT_DATA(zicfilp, RISCV_ISA_EXT_ZICFILP),
 };
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
-- 
2.43.0


