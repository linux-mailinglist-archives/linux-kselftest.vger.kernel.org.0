Return-Path: <linux-kselftest+bounces-9339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A3B8BA64F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 06:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2830B1F21A2C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 04:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4471513C3C9;
	Fri,  3 May 2024 04:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dxDDEAek"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87E413BC17
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714711629; cv=none; b=cbyBU27uDGK6o4gYq/Qe1s/jotMs49p2YkvwdQ9B+lT0kEeJaNQjLzOzoZb/LPEctkxqlGBJfAD3NAAUvV75LGAFg3D/o8sxT2fJzjW12F/71Sj3ZgQVEoJYNpFHpBRWXg1qHcegTxUILOgCev3drt+Fdo9BoZE7a6ozt5sSShI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714711629; c=relaxed/simple;
	bh=hSZDQKNr3tkZT93AWiF+tJx7RzaJfBNyv2pzte748aU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qCgw0hE5P6+f4eFiGhpUznid+/osYH/vSU8Zr6xC4jDjb8qf86N/Y1zkl65ONu52PIazv8DYW5I2LGlZIlz/etM3TNunKWAgI8T6Tp5n0LpKS7baUtPeaoEYyFphoE+Uka4PIzJHgl2jMbUWkFCXSXAwKQuHCu5eVVhIilQc1gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dxDDEAek; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ec4b2400b6so33826805ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2024 21:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714711627; x=1715316427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2nk2JCBk+l9WgkXKFxu/w/itsXmN0i69JJANxOESAA=;
        b=dxDDEAektpJAi68fOu7OGfcJgr5pzgWUdrLc0v/0da2JvGNVFRjJZICqwetDDqztt6
         7B82HASj2knJsUDS4xs7IgOrq2/yMPRHnbmt5HtxjgFAJ8kJ/9dC507VZcC/JvoNNF/I
         C/qidGNo99Wi2tcbXYbI4b6mIURU3WiN2Q8XJ4TJvwIeZVr3CqKjbEWZ+l8emreRNIIR
         HZALnd0z+rMkvBH7mjr1IAFxLdrg3ocCSCVHjwThdkdDEom3XGSq2AuAvcE6lrigAN50
         Hv6DF5pv5Im1SOTEWkrMHCJnOK3yG6UZiIx1FZtzQTx5XW6myrpWbzCCuhTwCX68pafb
         05mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714711627; x=1715316427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2nk2JCBk+l9WgkXKFxu/w/itsXmN0i69JJANxOESAA=;
        b=gqclL+U5yiBkri1bNzdW770RamKrK+zj+OVzeQvmWhba4Pfgim674is/1mzFs16jgv
         /E64WI5hNoRHx/0NK61x4vTedtYwEWoRiwcHC3f7SRK2cDIjWifiy5URaA4I2ENKJ+/C
         SKwXvlnTYwNMLLumg1TF/IOqE0eZnwBzf8yhu4pqy9YgPKKywUZ6dmEYZC4mRJ7Czq5s
         NvDpreW5GU2jvWk/nZg51COAA1sa1Kog4fPwh1ZkJnHAqa2fwHJ5P13JO9R49HYwEmYU
         cu071eNxO6oWR391lPJUIWyAxKy8e8byJ50whCODwDH63Rw0XNvSF1lkTIjBj6PFeQqW
         vDSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWBBW+tdH6KFoVPqEhFwYg4n1OmfpoauEDlehSk3yjPDykbAxnOw41ykmGZg62Itg8lqkmS1trIanxnuaRzBxag0W7sSsJzd6ANq6Y6HCH
X-Gm-Message-State: AOJu0YzTGY+C5PR21fAnp7R+2VpPN3mXaWniaGpwUo6NCZrvxB73zFsP
	YKNharvdmmW4Ay+qe6NpC/ciK2+SEav9x4YJ4FkyIAdX+mhb9VEmmP0nWspdavU=
X-Google-Smtp-Source: AGHT+IGLvfuIAlBMYBUVi+TLiO4QdvrYlPkTzw3LbvYys310NrxKX5klWbfcjGlfYftnOqjktyh3bg==
X-Received: by 2002:a17:903:191:b0:1eb:73c2:6b4a with SMTP id z17-20020a170903019100b001eb73c26b4amr1926925plg.8.1714711627297;
        Thu, 02 May 2024 21:47:07 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b001e2bb03893dsm2240411plh.198.2024.05.02.21.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 21:47:06 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 02 May 2024 21:46:46 -0700
Subject: [PATCH v5 11/17] riscv: csr: Add CSR encodings for
 VCSR_VXRM/VCSR_VXSAT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-dev-charlie-support_thead_vector_6_9-v5-11-d1b5c013a966@rivosinc.com>
References: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
In-Reply-To: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714711602; l=706;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=hSZDQKNr3tkZT93AWiF+tJx7RzaJfBNyv2pzte748aU=;
 b=UFZlFM3RPKRvEq4iil4sCALt5muWs8uugdi45/DJmZsHXC3Ny7LZMEMUZMpO4ymqs1OLTreJo
 XGaQ1FIh62qCFEPNP6HOy8o4Nghcqt7bK10HySuu2pzzpqXLVPmjp7o
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The VXRM vector csr for xtheadvector has an encoding of 0xa and VXSAT
has an encoding of 0x9.

Co-developed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 13bc99c995d1..e5a35efd56e0 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -219,6 +219,8 @@
 #define VCSR_VXRM_MASK			3
 #define VCSR_VXRM_SHIFT			1
 #define VCSR_VXSAT_MASK			1
+#define VCSR_VXSAT			0x9
+#define VCSR_VXRM			0xa
 
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00

-- 
2.44.0


