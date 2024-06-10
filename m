Return-Path: <linux-kselftest+bounces-11619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD663902C0F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 00:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC542847A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 22:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDD5155A35;
	Mon, 10 Jun 2024 22:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="d+si2Ipa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E163E1553B4
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060226; cv=none; b=cFq/bMVnKzf/WQfNagvR2DQbGfsSInED7w7zPsjA17wOBgx7JcZjwSd7a/XXWDvE/YmZc/TOD79klkEX8OcEKRRWXs6mPywzHUla7jdKShDFtUYfHmmlJMEjxfVZKpTUTsvOjayJ8bQiJ1m8uc7+Xyy4LVPBaOVZiEFbf3pkG50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060226; c=relaxed/simple;
	bh=fwxPC9e5acCJKXfvxD0QuLfngnuG8uQUjT/zUUS4iJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P9hXw/Zum6phNPEe68W6Mpp74ENs+dZBw5EUT1qRq5I89cYqhXca31y/GEHsltpY962EiJl615GlMUgr7wV7p1eKTYVoXEvrcId4XQYy2YsuG+SrofM2ntOZs+49Kf7CD25byQE6NgiXzpAJG2awA/aVpqU0ysUVj6Y/pDzwm/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=d+si2Ipa; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6819d785528so3351894a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 15:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718060223; x=1718665023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLBLJWgoI5ONq0p19OcZNiSMS9NNG1Jn9M7ZhOPyPpg=;
        b=d+si2Ipas+Q/Bp+L2AInGHcsjKkQRKU2xt7/d0F3g5hNaJFz58HK06UmXp6XnGoUSy
         BYLNi5lRPPHj0PRg9fkdkCym9zQvkXg+FLF1EftgpW+iuMfHrqVDz4H4GsVfZZZmHi8x
         sxpOneSj8+PFIPUFL7TCV8Rg1px8PGVd3Cq7gbBp1vY3vqo5l9twHkVfugeRaQe4uqG2
         LYJZDU3oXI0PpA2dSZXNLpMaczzerjorawsf9DOQoBgDLoTO+puabqiUUNJjQIH+h+Xz
         2U5qfdB+n4Z6SczmrLGG8n2D31wHfPGhqVJHrCPY1C4U0IkIfFugnyiWo57xpfOHr5M8
         7hpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060223; x=1718665023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLBLJWgoI5ONq0p19OcZNiSMS9NNG1Jn9M7ZhOPyPpg=;
        b=V2PPfsyKW3lBFkDiQx8XADjR+eHq5FOhOjGVpkvUcFfdlZC0tWCoxuXbn8qPq7u7sC
         7OWa7H95R/AyF/Cr+xx8hQ3LCj1hrdSYU1tbTmAqjP9MlxMI+1Q0ipziDsTTlC0QZnrh
         7YL4mXQHvCzTev0B/L9UCtMYBd6D+kpOWRTpoz2zy28zEN61yey85nut095q+J3nlG0R
         X+Rww/bKcg7N2OYTFurn3lyL0SfN0Y/lPLf8NasPp+FLBK9yWU68LftdD0m1h0VVrOiW
         Ym0cv7BAnVpt2FOeUW4yjS+Lsl/AYixYkxnJUqu9iHI2Iw+wTEhEU1/ASpTL4W868TQg
         EPyg==
X-Forwarded-Encrypted: i=1; AJvYcCU6KoS3lE46H0jpbqd/s4liG5Lv8umnnftg68lX5Yv+qWYdhoJd+1DHyV4Jcm7/QWxaWuanCucdBJhd45GHneU7HBp4yGhbg0Yj+QyKTCek
X-Gm-Message-State: AOJu0YwcILkZkhnL/I7JcHe87j476SRVUOieVLXWph5iA7ETqazyMwiz
	hsyN22UEETPpMxov9xN/p6B8imhAU3jlJfg97jf2A2Sn7amZT5oUWtuWeQ2p5ic=
X-Google-Smtp-Source: AGHT+IGHP7Vn33T88cszM3LUffrozHG8DR1S+p11RV/y6ZETDFy2B2rN4r/73rgcpPV6ku2suByO7A==
X-Received: by 2002:a05:6a21:c8d:b0:1a9:c33f:224f with SMTP id adf61e73a8af0-1b2f97ef803mr9893327637.16.1718060223275;
        Mon, 10 Jun 2024 15:57:03 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71b597072sm18355865ad.99.2024.06.10.15.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:57:02 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 10 Jun 2024 15:56:45 -0700
Subject: [PATCH v2 08/13] riscv: Add xtheadvector instruction definitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-xtheadvector-v2-8-97a48613ad64@rivosinc.com>
References: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com>
In-Reply-To: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718060203; l=1908;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=fwxPC9e5acCJKXfvxD0QuLfngnuG8uQUjT/zUUS4iJ0=;
 b=prEpfyGoBPWgsGun1GkTQvqnn5XECHC920TL4iWb0IdoZGHgiwe8GZmlR5k5bfufL4prNo4Pk
 Kac3ZHNhlVMCZwS9+a5dArAuNrVV5GZdxwe+lZ/EDeQS9Z6r2kmFfIF
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

xtheadvector uses different encodings than standard vector for
vsetvli and vector loads/stores. Write the instruction formats to be
used in assembly code.

Co-developed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/vendor_extensions/thead.h | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/include/asm/vendor_extensions/thead.h b/arch/riscv/include/asm/vendor_extensions/thead.h
index 48421d1553ad..27a253a20ab8 100644
--- a/arch/riscv/include/asm/vendor_extensions/thead.h
+++ b/arch/riscv/include/asm/vendor_extensions/thead.h
@@ -13,4 +13,30 @@
 
 extern struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead;
 
+/* Extension specific helpers */
+
+/*
+ * Vector 0.7.1 as used for example on T-Head Xuantie cores, uses an older
+ * encoding for vsetvli (ta, ma vs. d1), so provide an instruction for
+ * vsetvli	t4, x0, e8, m8, d1
+ */
+#define THEAD_VSETVLI_T4X0E8M8D1	".long	0x00307ed7\n\t"
+#define THEAD_VSETVLI_X0X0E8M8D1	".long	0x00307057\n\t"
+
+/*
+ * While in theory, the vector-0.7.1 vsb.v and vlb.v result in the same
+ * encoding as the standard vse8.v and vle8.v, compilers seem to optimize
+ * the call resulting in a different encoding and then using a value for
+ * the "mop" field that is not part of vector-0.7.1
+ * So encode specific variants for vstate_save and _restore.
+ */
+#define THEAD_VSB_V_V0T0		".long	0x02028027\n\t"
+#define THEAD_VSB_V_V8T0		".long	0x02028427\n\t"
+#define THEAD_VSB_V_V16T0		".long	0x02028827\n\t"
+#define THEAD_VSB_V_V24T0		".long	0x02028c27\n\t"
+#define THEAD_VLB_V_V0T0		".long	0x012028007\n\t"
+#define THEAD_VLB_V_V8T0		".long	0x012028407\n\t"
+#define THEAD_VLB_V_V16T0		".long	0x012028807\n\t"
+#define THEAD_VLB_V_V24T0		".long	0x012028c07\n\t"
+
 #endif

-- 
2.44.0


