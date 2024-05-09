Return-Path: <linux-kselftest+bounces-9801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8F88C12C5
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 18:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CA1283B90
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 16:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7427017109D;
	Thu,  9 May 2024 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TLNZYiA3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4F171088
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272063; cv=none; b=BYZ9712MCRcXroN9e4W2ihfjXau44ulhwsVxnzA5Ty2c1nqrusSZuLRC6blxZE90kmBB16D/ox4jULBykZIqXeWRw1rcxJGHvgWUDd3FOS0t+Cwa8pLMj+1H3+ceW9cf+mq4xNkq67YThyZbuBoFoVAIvpNDGlY6kLbBO9FvOXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272063; c=relaxed/simple;
	bh=knlwHNZwQmzD4oaulGiVep3QJpqnscPRswiG7/j0Dgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bLvIMK4GHab5SaytJepkYvnheqF5+gnebwAQ0XeaOZsNx3Sf+daTWB0I8jfc/PN+bv4v42Qc2ssaUvwWbUvkg6WoGDZwpjIwREjw+rro9B1LFu8ALIC7xaEek+eysleNu06zt8hOIKEZIWrJ+eGqCszCEuqadr19jnKpd7hoiKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TLNZYiA3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ec486198b6so8471485ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715272061; x=1715876861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNkHbY9oNilft+2PQdFQmYDad5FfREv7NAdRkMrTsLg=;
        b=TLNZYiA3a0ybPAS0ODahejZjLGgR9pMJciNoI2O02C2K16sRcIIk/aPgJ3qFowyr+c
         nSBKcxiQ7KDEH83XLlhWmBCt51TfAkiDqiigZgUTK5serA1X+AoOd/hGAbYIUf3n/RvO
         Kn9uy8GDkWhBoubbWr0iHxUqUTnpyRMpo7ZEoS01hFIjsuiA8BzWKzvhKdFtYhPdB3Bc
         ZglhiNeYtC3jB6HpwOg0dIvIGCjCeipL5hwBF7Ifu50Scu7WdtqlZ3H0C2/ioXD7npUF
         THiqsTh1c997d3aWqs0THjB53JjKn5aCt+J9u1fbZd/qDYxrubvfxWoiiVZ1KEGjwqI6
         jyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715272061; x=1715876861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNkHbY9oNilft+2PQdFQmYDad5FfREv7NAdRkMrTsLg=;
        b=YLF2XG/PYUtklNj+JIevE7ltwr+K33AJAUmAkXJCGtWdqiI60R6w6Uj4YEHfAtv3nq
         OTKDbhF1OwxeThdbRPectFDHctuuXe9B2PbMlM/rBzldtyQiMHLuisjbGnTmiBCrPMr4
         9/lSPtIRQsMD3jEEw1rKqB1MTQ0qkFj8TnsmwjjX8DLmtLwtfLVv0sz+sL84PVAbLweA
         v903/bhza8JCy+w4yj20Fnyhi6F01f1X+XaNDv7iGWvztlz44Z34cp6LqqCUxdPWcwdF
         e7MJqQpq823tnA2tYCYWWWtIvjeVoEG5e95qd+wCopenkHT47ZzZVrUoe1mSIz1tPJP0
         XP1w==
X-Forwarded-Encrypted: i=1; AJvYcCVYUOUEL1EkTR1SJTVMgjO/cVDCGRBIPOydKjeevCFv0tiSPkyZz6eWCT2jrJzWEuYgnlSQ4LDBi7kMb9v5F+ueQxyE3wyid04Iu04rr09n
X-Gm-Message-State: AOJu0YwcyHi5D9hBwl8x9UoLRY5KnajcYRBpfgsfljsz0L6mUbtWDCIh
	esMRNhf77bnd9RS2mTX5l0LdQQ57e7ChTdbmIaU92JQ5y5gX0qyHVY7LNJy6W+8=
X-Google-Smtp-Source: AGHT+IGUu1uPaO5nrqJvbHdXDLkvUWrWrbX5e2xStsjIzWenVBJGkFP5i2uTWH7PLE8vnnAsdqvMPA==
X-Received: by 2002:a17:903:110f:b0:1ea:b125:81a2 with SMTP id d9443c01a7336-1ef44161e50mr1676745ad.53.1715272061063;
        Thu, 09 May 2024 09:27:41 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c13805asm16210285ad.264.2024.05.09.09.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 09:27:40 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 10 May 2024 00:26:55 +0800
Subject: [PATCH v5 5/8] riscv: cpufeature: add zve32[xf] and zve64[xfd] isa
 detection
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240510-zve-detection-v5-5-0711bdd26c12@sifive.com>
References: <20240510-zve-detection-v5-0-0711bdd26c12@sifive.com>
In-Reply-To: <20240510-zve-detection-v5-0-0711bdd26c12@sifive.com>
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

Multiple Vector subextensions are added. Also, the patch takes care of
the dependencies of Vector subextensions by macro expansions. So, if
some "embedded" platform only reports "zve64f" on the ISA string, the
parser is able to expand it to zve32x zve32f zve64x and zve64f.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
Changelog v5:
 - Remove ZVE32F_IMPLY_LIST as ZVE32F only implies ZVE32X (Conor)
 - Add a list for V as it the imply list for ZVE64D does not include
   ZVE64D.
Changelog v3:
 - renumber RISCV_ISA_EXT_ZVE* to rebase on top of 6.9
 - alphabetically sort added extensions (Clément)
Changelog v2:
 - remove the extension itself from its isa_exts[] list (Clément)
 - use riscv_zve64d_exts for v's extension list (Samuel)
---
 arch/riscv/include/asm/hwcap.h |  5 +++++
 arch/riscv/kernel/cpufeature.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index e17d0078a651..f64d4e98e67c 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -81,6 +81,11 @@
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
 #define RISCV_ISA_EXT_XANDESPMU		74
+#define RISCV_ISA_EXT_ZVE32X		75
+#define RISCV_ISA_EXT_ZVE32F		76
+#define RISCV_ISA_EXT_ZVE64X		77
+#define RISCV_ISA_EXT_ZVE64F		78
+#define RISCV_ISA_EXT_ZVE64D		79
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 4bfc13209938..ad3e613ee30f 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -188,6 +188,40 @@ static const unsigned int riscv_zvbb_exts[] = {
 	RISCV_ISA_EXT_ZVKB
 };
 
+#define RISCV_ISA_EXT_ZVE64F_IMPLY_LIST	\
+	RISCV_ISA_EXT_ZVE64X,		\
+	RISCV_ISA_EXT_ZVE32F,		\
+	RISCV_ISA_EXT_ZVE32X
+
+#define RISCV_ISA_EXT_ZVE64D_IMPLY_LIST	\
+	RISCV_ISA_EXT_ZVE64F,		\
+	RISCV_ISA_EXT_ZVE64F_IMPLY_LIST
+
+#define RISCV_ISA_EXT_V_IMPLY_LIST	\
+	RISCV_ISA_EXT_ZVE64D,		\
+	RISCV_ISA_EXT_ZVE64D_IMPLY_LIST
+
+static const unsigned int riscv_zve32f_exts[] = {
+	RISCV_ISA_EXT_ZVE32X
+};
+
+static const unsigned int riscv_zve64f_exts[] = {
+	RISCV_ISA_EXT_ZVE64F_IMPLY_LIST
+};
+
+static const unsigned int riscv_zve64d_exts[] = {
+	RISCV_ISA_EXT_ZVE64D_IMPLY_LIST
+};
+
+static const unsigned int riscv_v_exts[] = {
+	RISCV_ISA_EXT_V_IMPLY_LIST
+};
+
+static const unsigned int riscv_zve64x_exts[] = {
+	RISCV_ISA_EXT_ZVE32X,
+	RISCV_ISA_EXT_ZVE64X
+};
+
 /*
  * While the [ms]envcfg CSRs were not defined until version 1.12 of the RISC-V
  * privileged ISA, the existence of the CSRs is implied by any extension which
@@ -245,7 +279,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(d, RISCV_ISA_EXT_d),
 	__RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_q),
 	__RISCV_ISA_EXT_DATA(c, RISCV_ISA_EXT_c),
-	__RISCV_ISA_EXT_DATA(v, RISCV_ISA_EXT_v),
+	__RISCV_ISA_EXT_SUPERSET(v, RISCV_ISA_EXT_v, riscv_v_exts),
 	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
 	__RISCV_ISA_EXT_SUPERSET(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_SUPERSET(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts),
@@ -280,6 +314,11 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(ztso, RISCV_ISA_EXT_ZTSO),
 	__RISCV_ISA_EXT_SUPERSET(zvbb, RISCV_ISA_EXT_ZVBB, riscv_zvbb_exts),
 	__RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
+	__RISCV_ISA_EXT_SUPERSET(zve32f, RISCV_ISA_EXT_ZVE32F, riscv_zve32f_exts),
+	__RISCV_ISA_EXT_DATA(zve32x, RISCV_ISA_EXT_ZVE32X),
+	__RISCV_ISA_EXT_SUPERSET(zve64d, RISCV_ISA_EXT_ZVE64D, riscv_zve64d_exts),
+	__RISCV_ISA_EXT_SUPERSET(zve64f, RISCV_ISA_EXT_ZVE64F, riscv_zve64f_exts),
+	__RISCV_ISA_EXT_SUPERSET(zve64x, RISCV_ISA_EXT_ZVE64X, riscv_zve64x_exts),
 	__RISCV_ISA_EXT_DATA(zvfh, RISCV_ISA_EXT_ZVFH),
 	__RISCV_ISA_EXT_DATA(zvfhmin, RISCV_ISA_EXT_ZVFHMIN),
 	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),

-- 
2.44.0.rc2


