Return-Path: <linux-kselftest+bounces-14014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 147DE9395E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 00:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A4D1F2257A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 22:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F747FBBD;
	Mon, 22 Jul 2024 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wAIV6Gh6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DF874BEC
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685507; cv=none; b=imorK2scakK+o4V5bSTO3aIb+Skriu2jf+VpX7sn2s/m9E2cA6QUHMUynpXOFEToUVGl16SPXye0wS2njCEr+4e/3T40jugi6y1TGzU4d0wZIclhOuj4Hzvwx9x7aQpmEqynagwhodOiMsn3xAobq2oNkFT3WR6C3C9setatqtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685507; c=relaxed/simple;
	bh=/awdvkpT37Pcv9l+R6WHhK0Ytr8TrWH5wurC23dujZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GMvm52AOFPKDgxmtCe9EjShFy2Wr2LMSZw1UjgXlLJQshNICWzdbQs7wTMlqdK1HNi1FMJN6RxD+oWiAl+P6L53DmT//8gXBMNYm8tXgJhDD/l+A6r+n7/OLnTLnJooivIrsc0L7wtwhvtsoeWCUCkAYrs/AF7qhdoZV7O4pcO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wAIV6Gh6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc5296e214so37088075ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721685506; x=1722290306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7liFIbqG3XLVQtLXjuEuZ9H5FIup228+UAuRj2s502A=;
        b=wAIV6Gh6IyCg6aHC98bxC5muRWXa4ja0gHiWodDHiWRbrAsAohgjDdjhbbvNsAJ84o
         llRESt3buUyOsHyci1PmdnKTexTgTRgPYUcCf/glJvwKRSLH0YMNl8xrgGSYECaS8pC9
         3XHDapoTjPSTyTY3Rop1m+DSJ1IGiqslKR5CtnDYWCSC2Ca3/d8JVfNUWYtv1bpfrXQA
         p+hi2RSPotiTsfX9sz6fq8K+6b/Q22Gy6GhU/EkxC2+bsD0cHKs2b+k0YGnqJ+kwAZOR
         vBXE36B4VwTxixmscGtC0owxfTntrbmeWnt+xMxpAQvMJblCW0iYKwe7OUDxUrsbJc4+
         4Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685506; x=1722290306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7liFIbqG3XLVQtLXjuEuZ9H5FIup228+UAuRj2s502A=;
        b=FLbEj7lGtLsyAWCyGuRR9Oa4wsjnTulygiDcaNZLTh3IyRLlMoC1SD+Mh2UwdCYGCA
         H/tr4KEPFIK8jhQQefevvu0nUybC8jdMfvWpG+RuBFmDfuoIsviKMGiWPvLuHGZN0StO
         U+2VwAhJmg5YDtNcKU/Y5fdikxtwqA83sc/Q+UHjkraOwh0i1V3v2UHRg2IanFtOOpsL
         K3YTksEUVY3eLt3eN3+gkqGeR4/SdLdJ+E563WkHL+WuWdztTGEdH5N2dVxONS3EtqvI
         fbfCMQK043Ua+YP8JKIV/Nx1043ewwSOJEKVLGM5DE3046/ev59aMEGXFhpX0dvmTWlg
         GTrA==
X-Forwarded-Encrypted: i=1; AJvYcCVKRUkzRLp9rbPVXCgzbfVN+NomZWm1HAuJ6DwmbFKr2SnyK2rR5GQeXqu0JPvAa6CoXDSWtYpXiKRgrlSM6+RzZ/3JtydPcYpmgD5TQQtT
X-Gm-Message-State: AOJu0YwL9LS+D8NQLLS+c+f/oUf2N5Lgoo+ileiuRFGtIta92lU9ojcx
	nTLPrtKB3VfuJjOgr41D4MCKBtSpHjxTz1Eq1+8I6kOLO3LU8qjmURl4amb9vsk=
X-Google-Smtp-Source: AGHT+IEhQYp1BZWLj9eFDI4F+59SR/8t3UUInGJ4gX5TJPVL1PbpSo7Q3rXHcGW/E8u/+YVve3sRYQ==
X-Received: by 2002:a17:903:18d:b0:1fd:9fd8:1b2f with SMTP id d9443c01a7336-1fd9fd82008mr51936315ad.8.1721685505924;
        Mon, 22 Jul 2024 14:58:25 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f44f0d4sm59997775ad.219.2024.07.22.14.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 14:58:25 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 22 Jul 2024 14:58:11 -0700
Subject: [PATCH v6 07/13] riscv: csr: Add CSR encodings for
 CSR_VXRM/CSR_VXSAT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-xtheadvector-v6-7-c9af0130fa00@rivosinc.com>
References: <20240722-xtheadvector-v6-0-c9af0130fa00@rivosinc.com>
In-Reply-To: <20240722-xtheadvector-v6-0-c9af0130fa00@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721685488; l=1045;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=/awdvkpT37Pcv9l+R6WHhK0Ytr8TrWH5wurC23dujZY=;
 b=HkA9GryhuoQSbrAEZ95j95Hqi2eIuaKpw8ZKsmN39SZQzbRBNWPE66zVFn20eiWNCV9omY0DH
 m+/5MZAQ7RODwQ/ViRBSsCcS8JUhXwkT+4tZRvwC/Z2ygfj/aiygn8J
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


