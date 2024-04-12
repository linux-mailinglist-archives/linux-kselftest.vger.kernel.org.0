Return-Path: <linux-kselftest+bounces-7771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DB28A2709
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 08:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C4E6B26D99
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 06:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AD64F207;
	Fri, 12 Apr 2024 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="T6mEywgM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE0A4DA09
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 06:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712904560; cv=none; b=JOaRv/eHArG//cn74oQFLIXLYojUxBdvbMDQTtr1M/UHRIZ6NcBp5Wk26uKSK7sfdt5SIvplbqKmblWHhejMdlZeaJqcOp/fiHFsptk5E2tscXSTJzVwaUC20nZsLKceP2lFtVQKZObnTY7127Dqhs1veFxWXG0P8HX+89uHiWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712904560; c=relaxed/simple;
	bh=4kg39cClkC8x9nK7s2kgeE3UTAu5MUCMaWqLDwoHBuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E4aMby3NBA0U584di3RQwa94LBKfFk1GQxZ5xi9xAUqSygzQCsydyf9XdaB7+mBtFxUySoCR3UirE2mckbqX6HMFwWS46W4EVoTm6M7BcBsjS80SipAEns0h6o1PzkWLyWzv9hF/xhcNNfTMY+x7FzSKbuBdhm4uMosWWX7X3Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=T6mEywgM; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso401594a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 23:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712904557; x=1713509357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OG/1LVtmS5PJqTGfRsDdfy/GBt6FFfLWIvrVveL3MDU=;
        b=T6mEywgMnqmipc3jlErY99viE/7x3DDGdcrDDmqgDkWQmFNxof4LYqUK1aW3anoG5b
         yLBa59+ikPqOQWPXrqj5qglZG5Jp7S1DsiAKGBhRKXSaBYWj/FRfRqY9IZWnPx6/Uhqk
         JECG197q5KPmF5HMtC2IbwbqDwshVJKgt788fAwZjunBC6RrZy/dK8IA81pguwSlIa4K
         e+GBwIO6mEHKZ5hXvI/HA2EOAKJYKH5gXuayhi+cFDpJY5EFS5rOZZsI64Ud5xLYX0Y9
         UQrn+1fOld5ayWY+YffzgcGhakKI1EKcbvAM+PcoI9f5yN0RQ9yhTc5zKieDBmdWk5oS
         G28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712904557; x=1713509357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OG/1LVtmS5PJqTGfRsDdfy/GBt6FFfLWIvrVveL3MDU=;
        b=ZEkcworblwkH3+qMr8W3jNnlZg0o4AipwRudZe6yB84o0TJRJHhCDZ5dluS3ql+1+R
         IeMX3l8Dlhe5Su90vUPLYq6cU3yJZnVIKc7w4zp+zhwD3gXpg7NDz2N2eoEViFIvCgat
         mytCEQsi447C4p12L7sigV0ZsSQ04DWv510StoY2PLCaLaDv51vhFVPPZYut0fPYgwTD
         q+CSEplXM97ry3SF/ZoBaTgAZTW0Rbf4Tp0jdRgjp/vSJpBKdj3FkyXLZHTnk84Bpt0r
         juAEQUxTpzqvePvIKFiLjCIHSByk1qVCTe/N90wn4v27W6PCdA1ruJJJze1mtqeje336
         tAYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMWIJWgZm5WVc7EgoeG0RnkrMAUROUiiJWX9jaYwQ/N5rWQN5H6T6T5wlS1Rz1PN/7HWXmEJTMLU1sTaQHswFHUmGptJYaZqM6uOyTg5lT
X-Gm-Message-State: AOJu0YxuVxBa9FM3TKa0uaWSxZcssO+T4RLUeUHC17rLB9eAfJ9o7JuK
	mT7EngbjDFE/q+VqcyDBDlRhftt1QpoKOU4DWzvFMXR5ZLYc5fZwXVzvppvSWPw=
X-Google-Smtp-Source: AGHT+IFZRErvycpHhYv8nDAOA0AKK9dvDMskucFNFf/LNGcE2rSUEQs2FrZTO0yAgsH3aEtNLPJo3w==
X-Received: by 2002:a05:6a20:3d85:b0:1a7:4962:6fad with SMTP id s5-20020a056a203d8500b001a749626fadmr2551948pzi.10.1712904557446;
        Thu, 11 Apr 2024 23:49:17 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902b10800b001e107222eb5sm2258818plr.191.2024.04.11.23.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 23:49:17 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 12 Apr 2024 14:49:00 +0800
Subject: [PATCH v4 4/9] riscv: cpufeature: add zve32[xf] and zve64[xfd] isa
 detection
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240412-zve-detection-v4-4-e0c45bb6b253@sifive.com>
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

Multiple Vector subextensions are added. Also, the patch takes care of
the dependencies of Vector subextensions by macro expansions. So, if
some "embedded" platform only reports "zve64f" on the ISA string, the
parser is able to expand it to zve32x zve32f zve64x and zve64f.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
Changelog v3:
 - renumber RISCV_ISA_EXT_ZVE* to rebase on top of 6.9
 - alphabetically sort added extensions (Clément)
Changelog v2:
 - remove the extension itself from its isa_exts[] list (Clément)
 - use riscv_zve64d_exts for v's extension list (Samuel)
---
 arch/riscv/include/asm/hwcap.h |  5 +++++
 arch/riscv/kernel/cpufeature.c | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

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
index f6f3ece60d69..38d09de518b1 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -188,6 +188,35 @@ static const unsigned int riscv_zvbb_exts[] = {
 	RISCV_ISA_EXT_ZVKB
 };
 
+#define RISCV_ISA_EXT_ZVE32F_IMPLY_LIST	\
+	RISCV_ISA_EXT_ZVE32X,
+
+#define RISCV_ISA_EXT_ZVE64F_IMPLY_LIST	\
+	RISCV_ISA_EXT_ZVE64X,		\
+	RISCV_ISA_EXT_ZVE32F,		\
+	RISCV_ISA_EXT_ZVE32F_IMPLY_LIST
+
+#define RISCV_ISA_EXT_ZVE64D_IMPLY_LIST	\
+	RISCV_ISA_EXT_ZVE64F,		\
+	RISCV_ISA_EXT_ZVE64F_IMPLY_LIST
+
+static const unsigned int riscv_zve32f_exts[] = {
+	RISCV_ISA_EXT_ZVE32F_IMPLY_LIST
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
+static const unsigned int riscv_zve64x_exts[] = {
+	RISCV_ISA_EXT_ZVE32X,
+	RISCV_ISA_EXT_ZVE64X
+};
+
 /*
  * While the [ms]envcfg CSRs were not defined until version 1.12 of the RISC-V
  * privileged ISA, the existence of the CSRs is implied by any extension which
@@ -245,7 +274,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(d, RISCV_ISA_EXT_d),
 	__RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_q),
 	__RISCV_ISA_EXT_DATA(c, RISCV_ISA_EXT_c),
-	__RISCV_ISA_EXT_DATA(v, RISCV_ISA_EXT_v),
+	__RISCV_ISA_EXT_SUPERSET(v, RISCV_ISA_EXT_v, riscv_zve64d_exts),
 	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
 	__RISCV_ISA_EXT_SUPERSET(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_SUPERSET(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts),
@@ -280,6 +309,11 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
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


