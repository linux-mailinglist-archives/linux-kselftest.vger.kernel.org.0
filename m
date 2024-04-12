Return-Path: <linux-kselftest+bounces-7752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C7C8A24DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 06:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F551F23962
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 04:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55264CDF9;
	Fri, 12 Apr 2024 04:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="z7nIr33n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1A24AEE3
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 04:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895114; cv=none; b=mya6fLwkRb0mn4Fau6sDqJnsw5MefUGQFd6lXKAyDk22C3G1IyUqGM4e+ATj+02riC8ZrpVZtqS76DP3xhl6OOblQTCKOzfJFE89Ne3UbQwqQtFIZ//Y9grJjyUwJ0YNokYli1fhobJxvCRRYhBwkfhaj+EkRQ18qKe4Cbi3rYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895114; c=relaxed/simple;
	bh=GIHSCNvBGq9/NXbY8oLLRsk2prCOn2ba2+sGa13S19M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ElmrIy9jARH1TqEcidqocVTOcHqtl2szp9UBhtkvuJWahAh+MXzc1U34S0QG9VwSG2fQFSsDPcAzmfA9o1vONkcKfvG4qLgPJvWO+08OhQdU1vwXLZZZX6voUvH/KoCMGlD+4fK4Y+fFRaTxmhxzixZc3AogHJN5X30JtuhrIqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=z7nIr33n; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso524831b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 21:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712895113; x=1713499913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOUeprLdHOU8cEpU799KylD0peVHBTaWNcK25xy1sNk=;
        b=z7nIr33nwO/QCOdDq/TceZOyaMeegxR1Mm6ufsmlNFrOvRe5G56sg731uE/wQvrdor
         rpuMpJZZ6zxZiWoj+tvCEcm85p5X+sp88QTGnSqzlhoTgxPAcwJNhft7Luv+MRNptKpT
         5zFLKD1nsAHTvn9lIVpqF+3QjoTJkkSZ3QtWXDgnxmeo1LdIRARxVpkEj6Vp9JnUycuX
         CrkBjiNGCQmLGHBLr/D7eiYPLvNZaXhEDjVjPVRTlyGv5ysgo91Gv894lwK1E4yoOaiZ
         YSBrpFRaGTbtHZfw+6KwlMPH1O/SLabMlhv14gsUs0JnbrqCJgV9RrRwsEcG6YzWAF5+
         mo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712895113; x=1713499913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOUeprLdHOU8cEpU799KylD0peVHBTaWNcK25xy1sNk=;
        b=Wo+x/K668uSieDoPJiOed5ADXQUva8wO72Y1HMRmE5vin3znoDPaJCOoIFpuQ+nS02
         FfiNbY/1lkn7E3ft9FgI7forQRKb9P7lIKeFRUj7pH+ZOMI7IzRxWNckCo91y4CGIriv
         6WiwIVTb9Dxgi1BryyZRZ+qQnS51XcrDiAuKCR6yS/Mkjv028z+KPk0LpvOmUs70Habg
         Uy1vWdqzW2JNpdqkQnuKLjZdLTcKvgHgC/UVEKlOZ5illQNmXNKxV+wt7nYkV/A0nT1p
         8PGd2+JJkZ7Ni9rD1Jp1E/pxV20z8REQ/WbhJXgLFFnKrQ6psZcWYB9S2TtQUMOcEg8d
         pkPg==
X-Forwarded-Encrypted: i=1; AJvYcCXDRpfzKfgbNjYwNX2tZMQWfFqRhUilDvWBgCJ1PpH0DMxqWdCW+Sh1WwPF+QF91wyLTaYo6b3tZIb/8AcIAzpLIJxHI/uSIrD57JwqCb3D
X-Gm-Message-State: AOJu0YyXfuJcZgNHU5RayM3Ahpwlmj1bW8c90NNrBRoXj4GGeIbsDSBh
	OXqY4I8VVFqhXJ7dnNBGYgMyilmfH5jbaZMD16xx3tNAyitN8WuO0pz7ZsNsCbs=
X-Google-Smtp-Source: AGHT+IED3p/jhyvepbWDfXS+NkSfJRWurygM2oLU3V1hXND944PsU0f6q05HekJLfNfek/WJfI9eig==
X-Received: by 2002:a05:6a00:2da1:b0:6ed:de30:9e43 with SMTP id fb33-20020a056a002da100b006edde309e43mr1816601pfb.32.1712895112997;
        Thu, 11 Apr 2024 21:11:52 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ka13-20020a056a00938d00b006e57247f4e5sm1949712pfb.8.2024.04.11.21.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 21:11:52 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 11 Apr 2024 21:11:17 -0700
Subject: [PATCH 11/19] riscv: csr: Add CSR encodings for
 VCSR_VXRM/VCSR_VXSAT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-dev-charlie-support_thead_vector_6_9-v1-11-4af9815ec746@rivosinc.com>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712895091; l=655;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=GIHSCNvBGq9/NXbY8oLLRsk2prCOn2ba2+sGa13S19M=;
 b=mAvaWamAnbq08BHcEl80jizwRpsYisWXatxTk+5hgXDH4/1Sk+ipO6fgeViKIstip0OZAfrpK
 PyaZbv+RsurBGMnGF6brQSfUNL2lUdCG9CjDA0Su9bm8BYxy6igksdv
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The VXRM vector csr for xtheadvector has an encoding of 0xa and VXSAT
has an encoding of 0x9.

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


