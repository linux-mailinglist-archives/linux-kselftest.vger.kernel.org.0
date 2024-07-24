Return-Path: <linux-kselftest+bounces-14173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B86193B766
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 21:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A891C21537
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 19:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92948171670;
	Wed, 24 Jul 2024 19:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PgI2DQF+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D647C17164A
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848461; cv=none; b=XPPAPGj8Rod3rpK1wnr5S9KxMnSIXY8t7JxKQ269+5KP/G8EjFXuHo5IuVw0QIv6qv7kOj88oVHjtZ952/vSYdS2ZrhZAJOA5s4BUTsb4PxIPcvEdKRfbQN55ntXzMToIha3+rOpElXfhSI/vzu2NsuIucCpl7XBO/damKUWqeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848461; c=relaxed/simple;
	bh=L3aaRS2j1B7ly0GhgM86XDS3MRCOslmFg/ArzwGxzO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DEp8jc43A5EVGdIXR8gSuGv/5uaunHYwPgRaxrNKR70oKnTDuW1VzBr/NioNbn1B/sI3rtJ48VaZeAMccLKm2scyOoAnyNHC7ZAqTE5D+gU16lrLdnrDdIQaTyXgfE8YjSQVjL0N0wI8aVInJFMTLMtt50ciKZmRY9lWfCJT5sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PgI2DQF+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso105555a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 12:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721848458; x=1722453258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhITSSlteAMwmsPUv9TpJ8KEJQbK1ok0BXYvmwnIXKY=;
        b=PgI2DQF+HMBwBW+mI3AqoAvYMx5Z+oD4fdBzDzkpdM60ELWH2dr6XGuH0X8dq8pVie
         coqSSJDffp/qKQJd7dfQn5QpREPCNR1FhqiKhert5ezHb0pOAwtj+Oj5aUmlB5ExdNSk
         OCG+oaXimnjBcSjkOvX0p5bC2YKe3td7EM2YIhUn8vCfKwB2cFPo2UgzDoz3c44+/pKN
         Xo0mD1pHVNuxfav3Q8QvNDymFd2TxShAv1QCrpT4I10B4tJlfxrg8lIDxZc36WuWnlDB
         gDLkC1Bc6UUODKfEdt5IUFj22lMIgd9iDOvD1zc3uRzRD851Le7T4Azs8WZp1xHdLORQ
         tMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721848458; x=1722453258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhITSSlteAMwmsPUv9TpJ8KEJQbK1ok0BXYvmwnIXKY=;
        b=BS2Lmp4HtJRSPMIEyPtPeWONvwMXPlsS7FIjwnw7jtCMTCz2/f6BBfbrpZcY8Up5YR
         dwRIKA75cup+oY99zy8EWY3o8UKcIKlYVGQcLp6fA7XRQZ+qycw6BnNncXR98e23cPrT
         vSkPSIYlBYNgtvDLQJrL/+wf0AIb8RBvP1eaCo+V96x56jNEyIa7XW7RgHi5oYxYnLqQ
         dDmt6iS+0S7an/9+J6qRG1z+k5k9yTkdT3ItoFECU0Y0XW96XwXxFLTAcGt3GJGhHEK4
         SqVzq+Q+aBaHXva/RA7vG2xZq9G2ZK7ABdGTi9mFkiLHT1fEtHnhmZynOoMPlGPzrJvb
         VpCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv0kBVNXgTH6+vt3Jed43pUte39wi8d8Tf/orWIMqIkfSKYeRks7V06vnywwIn5VyN4OntvvWyQSkpRrxz1LH1Z6Rch+bl9EFRgRNoj20f
X-Gm-Message-State: AOJu0Yw9Qkgzbji5QfIPUPCo5vUURE8lU6VpPYRXv4jBx4rr3Lrf22xK
	nZ1riyZ6uiTxO1U9RezWdEMZFoqSZHInXJl4BzXFVo6uf3+0ZjN551NGh1DmR0A=
X-Google-Smtp-Source: AGHT+IHLgTiDpT0TMNqD3LFvvYBX3c1KdokyNuKeNMfxvuG27WJVcwSBAHwFUVZPvOemuokht7oTaQ==
X-Received: by 2002:a17:90a:e7d1:b0:2cb:4f14:2a70 with SMTP id 98e67ed59e1d1-2cf238ccd81mr501393a91.30.1721848458166;
        Wed, 24 Jul 2024 12:14:18 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73edecesm2022359a91.32.2024.07.24.12.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 12:14:17 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jul 2024 12:13:59 -0700
Subject: [PATCH v7 08/13] riscv: Add xtheadvector instruction definitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-xtheadvector-v7-8-b741910ada3e@rivosinc.com>
References: <20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com>
In-Reply-To: <20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com>
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
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721848437; l=1957;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=L3aaRS2j1B7ly0GhgM86XDS3MRCOslmFg/ArzwGxzO0=;
 b=3LgSk8+xNOEkZSklUaLgaL0zXyg2NuVF6QG/VGVzyxO0+a7OwCZfLqM9BaJCg9XbiSiB+JCPx
 JnjuUUBisCLD2JPnzki/otPZkOgTMX9XCCpSt9dVrgF2YyvXZb/x1MR
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

xtheadvector uses different encodings than standard vector for
vsetvli and vector loads/stores. Write the instruction formats to be
used in assembly code.

Co-developed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
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


