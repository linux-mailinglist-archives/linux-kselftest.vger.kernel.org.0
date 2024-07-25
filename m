Return-Path: <linux-kselftest+bounces-14204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFE693BB90
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 06:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04BC1C23688
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 04:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DD7757F3;
	Thu, 25 Jul 2024 04:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MYU/h2NY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36AA60B96
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 04:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721881012; cv=none; b=aoh2AYeKCJkg3/+oIQzXjW27AyCDB6dAkYz8K+oxy1j4Tq1tKrTb6c6cOTYYK03jFQu9cuJQOvY0F7wNuv1I6tWiqlVvwMcZRRb7cXUMIruQmXD8fWBdJzYtiGv9c4hDwDy5sqeZqTYr4Wucd2kq51MNy37szvQfKFzoOjgE1c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721881012; c=relaxed/simple;
	bh=/awdvkpT37Pcv9l+R6WHhK0Ytr8TrWH5wurC23dujZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vq4Ayz9S9ELKMBu1y2j3/5G+AFBvR4ahSmbco2xeXjTl3PlN0pUR3FW6ZwJCCspgWx4tpopK/2qIVeCaxF3REiEu6lwjC9cPK9DO3ubQRdbJBMN1y5rP6gGiPOkR5bjzzhC+qWDUB5MaZrWID1BOO0ezO6/apkFM/1zysp5SSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MYU/h2NY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd66cddd07so4216535ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 21:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721881010; x=1722485810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7liFIbqG3XLVQtLXjuEuZ9H5FIup228+UAuRj2s502A=;
        b=MYU/h2NYxqbc3KLfgv5MLl8cXZHD/eOCpw5TEsVWH7tUO4Mu48K0Emc+yxxtMsWgk1
         d27vptFSUbgH12vcvwPChwsqhX0o8Z+I1Z1EtSvmN3z1EiVt0Q9y8GDINkoapd+fAwxV
         nk9w+0DFhyzUJbacs1qfDC5bKlzRDDFBdIp14zrH4XLXH9YCmsuQwsYriYEArODK6LHT
         pysbMqW1LuaYWNMnidiCSFkr3nSOFEdSmSScBg3zTU6114GA5UoyiAwDIPcN8RgX2loB
         InLkHJWns9X6uRCaozjsEsRFKfb8Jatmi10DUgAFsuHbzMbNq+4i5itQFBVlUx+CgJVz
         JAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721881010; x=1722485810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7liFIbqG3XLVQtLXjuEuZ9H5FIup228+UAuRj2s502A=;
        b=PsHsRZ6PMzgkE0XWDamC8ir+K2JroVcJNGvrA3cswuJpNFZzVt+XZtQ/P/7FpK0mFt
         jW9NiBgeZRjdDgTday3e2NVX63qDs0fJF2RAS+Io/yg31eE0Abkq0oOx5P9s96G6X0KF
         bRXLFC6TLX8WrnBPE+sjvp3J+0iTiQcsVysS+qadCwUUX8O5n+oWFEMfwm3hZXTviz9t
         8fiZ9Qy2Phv42UC4NWWKAb68nG8hHFia9vl9UMAdvVj2Zs0ZkTQioXy4uG4UgG9sIhgo
         rCXy1dWlyyZkuA604Y1VrgY94QsKiF5jLWbryqBp0oPy3gGzhlj99Tg+To8o7il4xai1
         /jqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTcTa6P0eOe978npsfzlNY5/etA7hXvY/Es3ex5zdMdYpOtKDgmJ25U6ZYwlYeI4AuNNNtoWXkgjEM3DNkH49qFVxdilAYTVOskiD0sxOc
X-Gm-Message-State: AOJu0Yw/RqpQMO2anHE+leQsuhAzi4CwLOry6oN08t9cxcwa6Q3N0dZK
	u2zTWD5mLBY/vmMSkn04xa6Stq1jdmbEGApxD401YRoPNP7H7xyQbo4iuVIPVlM=
X-Google-Smtp-Source: AGHT+IG9p5ieQtAxVwtwRrKMsQ3tH0oS7hdi8tXU1NiTxKTEptmOQ6kEQXaoXkVzZB80bKpXwXAfnQ==
X-Received: by 2002:a17:902:c407:b0:1fa:fc6a:858a with SMTP id d9443c01a7336-1fed384285emr18528395ad.15.1721881009991;
        Wed, 24 Jul 2024 21:16:49 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f2b80bsm3781825ad.205.2024.07.24.21.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:16:49 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jul 2024 21:16:24 -0700
Subject: [PATCH v8 07/13] riscv: csr: Add CSR encodings for
 CSR_VXRM/CSR_VXSAT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-xtheadvector-v8-7-cf043168e137@rivosinc.com>
References: <20240724-xtheadvector-v8-0-cf043168e137@rivosinc.com>
In-Reply-To: <20240724-xtheadvector-v8-0-cf043168e137@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721880993; l=1045;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=/awdvkpT37Pcv9l+R6WHhK0Ytr8TrWH5wurC23dujZY=;
 b=mF9QzvOtJ0E+YvogarHlMEGaWmhoxEtzqz8fpE1XE4GA1FOcmeiBqgyml12mHdPeg4HK29G9Q
 k3wj39Bgwa2AfUMTGV1y098m1KBZgSQ0bod6LyBScyOjBMjAsLalkez
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The VXRM vector csr for xtheadvector has an encoding of 0xa and VXSAT
has an encoding of 0x9.

Co-developed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 3eeb07d73065..c0a60c4ed911 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -300,9 +300,14 @@
 #define CSR_STIMECMP		0x14D
 #define CSR_STIMECMPH		0x15D
 
-#define VCSR_VXRM_MASK			3
-#define VCSR_VXRM_SHIFT			1
-#define VCSR_VXSAT_MASK			1
+/* xtheadvector symbolic CSR names */
+#define CSR_VXSAT		0x9
+#define CSR_VXRM		0xa
+
+/* xtheadvector CSR masks */
+#define CSR_VXRM_MASK		3
+#define CSR_VXRM_SHIFT		1
+#define CSR_VXSAT_MASK		1
 
 /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
 #define CSR_SISELECT		0x150

-- 
2.44.0


