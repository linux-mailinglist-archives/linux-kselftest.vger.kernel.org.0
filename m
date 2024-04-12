Return-Path: <linux-kselftest+bounces-7773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342E18A2711
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 08:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6951CB21C3B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 06:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56A250294;
	Fri, 12 Apr 2024 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nEBgF2pH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437245027F
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712904567; cv=none; b=EC+ztYHj/z5hmmOw5A+e5aCKrp0kmDjoK0cvyhTpJHMJ0slP8fYFS3UsJmeEsnPH2xcpvFkTP9sAQpJn5Oz6NuIH1ALUL/CNLfpHjmlqHDIHNEB2EQlNpdgF9x79cnzPP2JZp95DoX+1KdLSEB+wtGM/GyyVAs2sTZdi4f6u/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712904567; c=relaxed/simple;
	bh=uubmLa91yNB8dZEdaOLb52luySkhGjATl5lAE4q/Ev4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bEqnAc9QHdiV3XhwMUHJHkYb1EBvg4XwTsgo8zUYqierdGt8LEv18OC1vXPDyZWLNYSwGmfKNaCeQOIlnI1UmEnH96bckJa4Oqyzdt3lu0k+AHt9MRsnGttxzzyszM+moH+VdulbYpBI+ghldUdWnq91YghbP0WzuIRzrR3ltFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=nEBgF2pH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e3c3aa8938so4118485ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 23:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712904565; x=1713509365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHRXW9BfVlGJGTuBqz21x9jZhOCb5ENaxkoeEzRsV8g=;
        b=nEBgF2pHrNkr45efyeSvKYdLGCz3GKODfGup+Zh+NTYazT52en7caMF6boEyOCBqAS
         SLSRWJLdd84V85lKLDnven6M/xgdVXs+M3ZglyK7h6dtKJp/wZVEuEkzl14RhkXYgqPq
         SafyPLamj9SOtTdmlmsNWCwWnmJyPNlVORVs5Z9ZXn6d80wogjtZo6zTYolmDNcDQKf0
         YbPQFvSUcXV0risHfUv1pY2gO6hNqIMHRy8UcvdRioojBX90I5OZN5yKwC+wsRetIcBV
         GQGgjPEnI1/qdXAqpdgbPHiIxYnKjS1IF/AuXda3iu4nZf1D1sptDcbintO+1DJbDeaa
         5NOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712904565; x=1713509365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHRXW9BfVlGJGTuBqz21x9jZhOCb5ENaxkoeEzRsV8g=;
        b=wo3sMHIKVvZfwCw2dKCfZZY90ONbSXvY7VofRGTteci65lwYxTwDX3AftZMHyKPrET
         iyQDjcuXLEZ4H8VU+CmaAwXDCOR/OR3F9b0e2o5smbZroQlMWgQWJtPEjHgHFW529nMV
         ZwrGZSqDkIXcXhYgVLhxBsXE5jnuFGJsUVPC85mDbYpnLGUyaeJg08pVfGHJ3d9IwocL
         sfpDPtQfKbe9POJL+kzFY/mJRS66dE0o9CIiZMVWB9FZT93dYeqZJmYqFMJ2C892HlZL
         k01ZDvVX0naRqozmPqKg0wrsdVypICFPApkJWb3SpOLJoFkDTp4fMW1ZjAP2kzj4ZrxR
         OWEw==
X-Forwarded-Encrypted: i=1; AJvYcCXFPneuTDJ5RU1bbQNFV8gLHKI2MO82oPc6V31bGFPUEB9PYBPCUFDaQuGI8wD1aNydE+0H36g+Xzdj2p0/YPC6IXu9AzylqES2ly1eFZ71
X-Gm-Message-State: AOJu0Yz3nfeFJWOns67EUWrGkU5A/M5GqoRjANWTvTPSFWtJ2UfKdH8p
	AKj/2fDchfi2DDpD5flw1K+nxmCpfY2AKdvoRn+kBTyd4AXfjCeWKBn5VvuUb90=
X-Google-Smtp-Source: AGHT+IF7aPtREGbQgxU3TxWKZAFkNQpbZfw9mJVRZm3GBajMC7PPTHtPXu4zJ9ZgxwJ5Yt7MgcH+hA==
X-Received: by 2002:a17:902:9a09:b0:1e2:7fb2:b08 with SMTP id v9-20020a1709029a0900b001e27fb20b08mr1486377plp.43.1712904564631;
        Thu, 11 Apr 2024 23:49:24 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902b10800b001e107222eb5sm2258818plr.191.2024.04.11.23.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 23:49:24 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 12 Apr 2024 14:49:02 +0800
Subject: [PATCH v4 6/9] riscv: hwprobe: add zve Vector subextensions into
 hwprobe interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240412-zve-detection-v4-6-e0c45bb6b253@sifive.com>
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
In-Reply-To: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>, 
 Andy Chiu <andy.chiu@sifive.com>, Guo Ren <guoren@kernel.org>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, 
 Vincent Chen <vincent.chen@sifive.com>, 
 Greentime Hu <greentime.hu@sifive.com>, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.13-dev-a684c

The following Vector subextensions for "embedded" platforms are added
into RISCV_HWPROBE_KEY_IMA_EXT_0:
 - ZVE32X
 - ZVE32F
 - ZVE64X
 - ZVE64F
 - ZVE64D

Extensions ending with an X indicates that the platform doesn't have a
vector FPU.
Extensions ending with F/D mean that whether single (F) or double (D)
precision vector operation is supported.
The number 32 or 64 follows from ZVE tells the maximum element length.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Clément Léger <cleger@rivosinc.com>
---
Changelog v2:
 - zve* extensions in hwprobe depends on whether kernel supports v, so
   include them after has_vector(). Fix a typo. (Clément)
---
 Documentation/arch/riscv/hwprobe.rst  | 15 +++++++++++++++
 arch/riscv/include/uapi/asm/hwprobe.h |  5 +++++
 arch/riscv/kernel/sys_hwprobe.c       |  5 +++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index b2bcc9eed9aa..d0b02e012e5d 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -188,6 +188,21 @@ The following keys are defined:
        manual starting from commit 95cf1f9 ("Add changes requested by Ved
        during signoff")
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVE32X`: The Vector sub-extension Zve32x is
+    supported, as defined by version 1.0 of the RISC-V Vector extension manual.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVE32F`: The Vector sub-extension Zve32f is
+    supported, as defined by version 1.0 of the RISC-V Vector extension manual.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVE64X`: The Vector sub-extension Zve64x is
+    supported, as defined by version 1.0 of the RISC-V Vector extension manual.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVE64F`: The Vector sub-extension Zve64f is
+    supported, as defined by version 1.0 of the RISC-V Vector extension manual.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVE64D`: The Vector sub-extension Zve64d is
+    supported, as defined by version 1.0 of the RISC-V Vector extension manual.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 9f2a8e3ff204..b9a0876e969f 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -59,6 +59,11 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZTSO		(1ULL << 33)
 #define		RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)
 #define		RISCV_HWPROBE_EXT_ZICOND	(1ULL << 35)
+#define		RISCV_HWPROBE_EXT_ZVE32X	(1ULL << 36)
+#define		RISCV_HWPROBE_EXT_ZVE32F	(1ULL << 37)
+#define		RISCV_HWPROBE_EXT_ZVE64X	(1ULL << 38)
+#define		RISCV_HWPROBE_EXT_ZVE64F	(1ULL << 39)
+#define		RISCV_HWPROBE_EXT_ZVE64D	(1ULL << 40)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 8cae41a502dd..c8219b82fbfc 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -113,6 +113,11 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZICOND);
 
 		if (has_vector()) {
+			EXT_KEY(ZVE32X);
+			EXT_KEY(ZVE32F);
+			EXT_KEY(ZVE64X);
+			EXT_KEY(ZVE64F);
+			EXT_KEY(ZVE64D);
 			EXT_KEY(ZVBB);
 			EXT_KEY(ZVBC);
 			EXT_KEY(ZVKB);

-- 
2.44.0.rc2


