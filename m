Return-Path: <linux-kselftest+bounces-13112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6134925344
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 07:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBFD01C24E43
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 05:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCB31369A7;
	Wed,  3 Jul 2024 05:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tQLz7QHO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4140135A71
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Jul 2024 05:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719986226; cv=none; b=dX+COc3GArqFuFbljQiP40eh+4VaQG8nU0FocljNsTRt1vHvIG1BgHASeKd5TBvEQQdf+RaF51y8i/Tcx9BJHwvsretbULaGFE316S8EiFdVKQTiuiV0adB9Acuibgv7rAdo16talp6uBDqzPxwHEgs57bvsHiPJiZ70dR3aj2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719986226; c=relaxed/simple;
	bh=3Ih1kxjim7X0oSHyF1qhqVEwvf1yZ56Dfkwzd7GXOXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jaHPgLcPSMu7gZNkSQe6LtvagKm7b9xHHyazC1ZWsrZWZ6FESZx0CH0elwdo72EN48gLkRDbSDiOvLnjYQoT+o8CQQ1uArvoWMgcCioAHeQLyoU1LvGgCkHHeWfzVDaldMk4ppnhbnWQtuaI0Raz5WyCZoZGcItfvwpDYWWm4bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tQLz7QHO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70679845d69so3402663b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jul 2024 22:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719986224; x=1720591024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zfb6qZjz6PuRcPoQJvZ524OiYSURD9EZw8kEFqdIXjU=;
        b=tQLz7QHOJvOBDVzpdKAPUYj6Zr1mpVvgURqbgf8ZXkW05Xj+2k0BN2sqf+RpbndTvQ
         NYupjCi0kLB/WOFuoohFoZOZ8iDt+8SmUvxt81NLU1Xpo7XiD7a7b0zkFGKWHrA/PAFD
         ukKdExpiMf3zYtZkIHR2ZmIcfKZsSjZ6LBAV7OR6UBi58/JnL7s8W4mLbb0q9cuROALz
         yroLGmDEB2kELMEVxAUYltFsNBvLcFm3bX9tkyiw7pw1ONbpjEXkZNLCDTpX08l11y8h
         nRJYcutrvi154/Wt0ehmH5SbnEFy2em1ibxm2mlWCsDSTLJ5+DwED/KmxUnQJy8q+cyB
         nIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719986224; x=1720591024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zfb6qZjz6PuRcPoQJvZ524OiYSURD9EZw8kEFqdIXjU=;
        b=HKeuhB+t64pPt+y+fYxzyVDxT6AkOVXYiaJ9PjWWZby4cC4XjttbG+NdY0sAuZxldJ
         zmQK5tiCSSvoyVFnuFNpVxRDPwvf21p4k/5sHQp/kSw/WWZoEYYpB++qMg6Us7EwDUcJ
         QcXh9QIf1ar9+3Gln0FS39KshNoieXzHVnTOTG+bcfbLwFZs8v41fLtWH1UsTq6Lh/sC
         uYkjrJHbbBFU8nHW2FAYeRnkijt5Bk9AdUzJQOtVM3FFjU9RwQb3h4UlJK/cke1W//Z8
         qFC7EEqq3yjFj1Nl/84MJKbDngF5VE0AvIPFi9qc02LKEwahdSD3KZXQyFZXEJD75hRo
         abbg==
X-Forwarded-Encrypted: i=1; AJvYcCWjBV7acMhznLuNF9lsep/CwrX2ZZCDXHPaO1i88W2wpJLT9f+YjeNmKml2xbIfR/AByh0ftycZBO9WXHOeE+Z4eI7wQTGTbxlPa0UBrhuT
X-Gm-Message-State: AOJu0YzogQVBw3k8iT2DdmYoy1udxXL16kp00IO96eYIpLrP7sJWwaGH
	shyRrEqxIHgm3RC+BQqieipD1zL9t49IhKlVmkP2Le/ZgnGyP/RBh68CjUY+uXo=
X-Google-Smtp-Source: AGHT+IFGEfqZMXTypKW81i4priXNlj+4NmLvKSNU10yQJiwPBD9ZpFQEsTGkiyP38hBQaiQm43k/Fg==
X-Received: by 2002:a05:6a00:9289:b0:705:d755:69b0 with SMTP id d2e1a72fcca58-70aaad2b22amr10175470b3a.6.1719986224000;
        Tue, 02 Jul 2024 22:57:04 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a89fc9sm9514103b3a.212.2024.07.02.22.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 22:57:03 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 02 Jul 2024 22:56:24 -0700
Subject: [PATCH v4 04/13] riscv: Add thead and xtheadvector as a vendor
 extension
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-xtheadvector-v4-4-2bad6820db11@rivosinc.com>
References: <20240702-xtheadvector-v4-0-2bad6820db11@rivosinc.com>
In-Reply-To: <20240702-xtheadvector-v4-0-2bad6820db11@rivosinc.com>
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
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719986213; l=5053;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=3Ih1kxjim7X0oSHyF1qhqVEwvf1yZ56Dfkwzd7GXOXI=;
 b=8Mbe+HO5VkSbH6xoPB3unAlSp0zBv15K+hXKoqSLenbLodgpmHywCUGlIWiPxt8KcY7tdLjJg
 NEP95z8BhNrCtHMV/0WAkdEfnGuQmxvO2i/bnImOmAkhh+WFb5iEGRC
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Add support to the kernel for THead vendor extensions with the target of
the new extension xtheadvector.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig.vendor                        | 13 +++++++++++++
 arch/riscv/include/asm/vendor_extensions/thead.h | 16 ++++++++++++++++
 arch/riscv/kernel/cpufeature.c                   |  1 +
 arch/riscv/kernel/vendor_extensions.c            | 10 ++++++++++
 arch/riscv/kernel/vendor_extensions/Makefile     |  1 +
 arch/riscv/kernel/vendor_extensions/thead.c      | 18 ++++++++++++++++++
 6 files changed, 59 insertions(+)

diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
index 6f1cdd32ed29..9897442bd44f 100644
--- a/arch/riscv/Kconfig.vendor
+++ b/arch/riscv/Kconfig.vendor
@@ -16,4 +16,17 @@ config RISCV_ISA_VENDOR_EXT_ANDES
 	  If you don't know what to do here, say Y.
 endmenu
 
+menu "T-Head"
+config RISCV_ISA_VENDOR_EXT_THEAD
+	bool "T-Head vendor extension support"
+	select RISCV_ISA_VENDOR_EXT
+	default y
+	help
+	  Say N here to disable detection of and support for all T-Head vendor
+	  extensions. Without this option enabled, T-Head vendor extensions will
+	  not be detected at boot and their presence not reported to userspace.
+
+	  If you don't know what to do here, say Y.
+endmenu
+
 endmenu
diff --git a/arch/riscv/include/asm/vendor_extensions/thead.h b/arch/riscv/include/asm/vendor_extensions/thead.h
new file mode 100644
index 000000000000..48421d1553ad
--- /dev/null
+++ b/arch/riscv/include/asm/vendor_extensions/thead.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_H
+#define _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_H
+
+#include <asm/vendor_extensions.h>
+
+#include <linux/types.h>
+
+/*
+ * Extension keys must be strictly less than RISCV_ISA_VENDOR_EXT_MAX.
+ */
+#define RISCV_ISA_VENDOR_EXT_XTHEADVECTOR		0
+
+extern struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead;
+
+#endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index f2c24820700b..2107c59575dd 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -25,6 +25,7 @@
 #include <asm/sbi.h>
 #include <asm/vector.h>
 #include <asm/vendor_extensions.h>
+#include <asm/vendor_extensions/thead.h>
 
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/vendor_extensions.c
index b6c1e7b5d34b..662ba64a8f93 100644
--- a/arch/riscv/kernel/vendor_extensions.c
+++ b/arch/riscv/kernel/vendor_extensions.c
@@ -6,6 +6,7 @@
 #include <asm/vendorid_list.h>
 #include <asm/vendor_extensions.h>
 #include <asm/vendor_extensions/andes.h>
+#include <asm/vendor_extensions/thead.h>
 
 #include <linux/array_size.h>
 #include <linux/types.h>
@@ -14,6 +15,9 @@ struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[] = {
 #ifdef CONFIG_RISCV_ISA_VENDOR_EXT_ANDES
 	&riscv_isa_vendor_ext_list_andes,
 #endif
+#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
+	&riscv_isa_vendor_ext_list_thead,
+#endif
 };
 
 const size_t riscv_isa_vendor_ext_list_size = ARRAY_SIZE(riscv_isa_vendor_ext_list);
@@ -41,6 +45,12 @@ bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsig
 		cpu_bmap = &riscv_isa_vendor_ext_list_andes.per_hart_isa_bitmap[cpu];
 		break;
 	#endif
+	#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
+	case THEAD_VENDOR_ID:
+		bmap = &riscv_isa_vendor_ext_list_thead.all_harts_isa_bitmap;
+		cpu_bmap = &riscv_isa_vendor_ext_list_thead.per_hart_isa_bitmap[cpu];
+		break;
+	#endif
 	default:
 		return false;
 	}
diff --git a/arch/riscv/kernel/vendor_extensions/Makefile b/arch/riscv/kernel/vendor_extensions/Makefile
index 6a61aed944f1..353522cb3bf0 100644
--- a/arch/riscv/kernel/vendor_extensions/Makefile
+++ b/arch/riscv/kernel/vendor_extensions/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_ANDES)	+= andes.o
+obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_THEAD)	+= thead.o
diff --git a/arch/riscv/kernel/vendor_extensions/thead.c b/arch/riscv/kernel/vendor_extensions/thead.c
new file mode 100644
index 000000000000..0934a2086473
--- /dev/null
+++ b/arch/riscv/kernel/vendor_extensions/thead.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <asm/cpufeature.h>
+#include <asm/vendor_extensions.h>
+#include <asm/vendor_extensions/thead.h>
+
+#include <linux/array_size.h>
+#include <linux/types.h>
+
+/* All T-Head vendor extensions supported in Linux */
+const struct riscv_isa_ext_data riscv_isa_vendor_ext_thead[] = {
+	__RISCV_ISA_EXT_DATA(xtheadvector, RISCV_ISA_VENDOR_EXT_XTHEADVECTOR),
+};
+
+struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead = {
+	.ext_data_count = ARRAY_SIZE(riscv_isa_vendor_ext_thead),
+	.ext_data = riscv_isa_vendor_ext_thead,
+};

-- 
2.44.0


