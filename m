Return-Path: <linux-kselftest+bounces-8083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFC48A6231
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 06:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90A32855D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 04:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94F86CDAC;
	Tue, 16 Apr 2024 04:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cDeT3Qj3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEA45FBA5
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 04:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713240739; cv=none; b=RUXbXdv/AX9ZX2RZvROL2llwoa50X+nkDR5Q4tEb9+fiQehC7ij0ks4f6yRWsH8oN43qjyCoKrv4lJgtcZZLbzZG2rhvMkuXJD8cF2e4hUo0i6P1TPObn4fF3Q5f9fg0llgUfwkX/QCb2B7yOAFHWHTzbDo4Ab19uGeh8vKmYoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713240739; c=relaxed/simple;
	bh=wcB/ebDhkfkPBVDQxoUt3AjUlhzpSXzz59SF5DkeLyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gnv+L2pqTc9fkXPxswqkDCVdZT+sBvNu6yUm+PyremqSI8COIbtyq9Of9Rk9O9V+XxfOSW74GaLQGAlhKKFX1A9Vb3VfDwLBBZyPhU6aABgOH4poOqxMO0bk+xR6YM+9VpaTSl/ZGclp4ILAvfTZ1kqFHC3V1iJgaS0W2FM9GD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cDeT3Qj3; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-22f746c56a2so1958463fac.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 21:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713240737; x=1713845537; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bC8+jsiLZWKY+UGyCwiSu3stdoXyccUkl5+IF/7wAA4=;
        b=cDeT3Qj3bLx4GNuLOw0ISv28Gn/Fwp611oxVPxfXbuzKX85sYeKKPy+UV2YZN1aORO
         vLbASYQTnJ2o7RvAYZbBTRSLiQjN8N6TFgxRihZtK0w8hg5BthG8d4eBSxPcST9iQGUY
         U2o6JbIqKX836rV1WKRO3H8XPzZTE3fVQpLLSnfT0RC2QgtYxHFiA8e1M0mmxkuZ55pL
         g3XZAZbDpYcx2m8Ert82AvpPVnzp43eDporioWQIYTObP0Jw2nPQK3VRImCVWHFGONpS
         BtPTlKz60PWIvg0mimj3eE1VgAKI/prV99ZsOkKOC9iIjqghxwzLs+AT98OrUddBqRjb
         tbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713240737; x=1713845537;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bC8+jsiLZWKY+UGyCwiSu3stdoXyccUkl5+IF/7wAA4=;
        b=Qc+wEEVvOV3A8eDmbhUbiAgtzVcowEoLlMvpUXo+0QOMWDP8wRyebBrxTtRobowHUP
         kA2aOWMIW3o0D6W1jrCV3N9b8uBajeGw99HcWDgmRPRj3Z6fWgSZ1vvfTit8uTLq1kkT
         3wh70cKqvf9LMJwPfV92I7lxTNvVEUoSRzYq2kmbXawFvPiHdowG4R0HhmCoqXs6Jv10
         uSGF1cc/zrseANB4njUyCllD3QAw5vIp+geCJdl8TQ5EbfPyT+Hd5EqsZY13io/TQekt
         al7772nQAKW/ojqrFYNIEdYyWkctHpHTwqueVh0HcB208QNAuTo24J86od74ngCXi9sy
         zjxw==
X-Forwarded-Encrypted: i=1; AJvYcCWWujvkmM4Lg3VumTGtB0L59RfXG7O4iZd/LYYrz5tBvcFRfJn4SCNoE1xcieUnyfA6VGZg0s484pibEURJcEyl6A6EHi4WPnq9htvu5kU4
X-Gm-Message-State: AOJu0YwUgiahOey9FmqBljKCLS70z2BzG5Yjy3H8Pd1PxTJqwyq6Zze0
	hM1Ghp8wi9BbIACQhO6KYmp2Ik4HOQZtP+J4St6yhReo6kAddPR7YcFmfwH2MQUWtYZwZoWx/Vv
	G
X-Google-Smtp-Source: AGHT+IHkqiMkVjxP3CYqN1RvGEvTVB4gtmkT8yxeTu0gT+YMQ6rgsqh73ctLt3AZ3AdSqqJmE2B/vA==
X-Received: by 2002:a05:6870:b293:b0:22d:f859:2225 with SMTP id c19-20020a056870b29300b0022df8592225mr15026805oao.6.1713240737601;
        Mon, 15 Apr 2024 21:12:17 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id z184-20020a6265c1000000b006ed4c430acesm8383149pfb.40.2024.04.15.21.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 21:12:16 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 15 Apr 2024 21:12:07 -0700
Subject: [PATCH v2 10/17] RISC-V: define the elements of the VCSR vector
 CSR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-dev-charlie-support_thead_vector_6_9-v2-10-c7d68c603268@rivosinc.com>
References: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
In-Reply-To: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>, 
 Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713240719; l=954;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=C7F1c584ODJM4qF9TPT5kMoM8fDlOPYyEMw6010Mea8=;
 b=gL5a3gZt7YmAzdC8JCIo8MXcZ7fbdc6iO361KpgkRlf5taEU4xnmrghYwi1t5py6BJP8PyQO9
 P2I8p9MxL5KDfEXe96mXU4uz3Aeg9WWgIVAt+oJLRgmHkwkJ4xayrK0
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

From: Heiko Stuebner <heiko@sntech.de>

The VCSR CSR contains two elements VXRM[2:1] and VXSAT[0].

Define constants for those to access the elements in a readable way.

Acked-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 2468c55933cd..13bc99c995d1 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -215,6 +215,11 @@
 #define SMSTATEEN0_SSTATEEN0_SHIFT	63
 #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
 
+/* VCSR flags */
+#define VCSR_VXRM_MASK			3
+#define VCSR_VXRM_SHIFT			1
+#define VCSR_VXSAT_MASK			1
+
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00
 #define CSR_TIME		0xc01

-- 
2.44.0


