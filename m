Return-Path: <linux-kselftest+bounces-11529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E18619019F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 06:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFF71F20F41
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 04:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB13028DA0;
	Mon, 10 Jun 2024 04:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Koj25E+/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE14225AF
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 04:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717994749; cv=none; b=Ev+XIPLY8U72VZkKu9DpbXoElpUap1bMTNfARvL3ST37FgRw41fzNUdJEHzu201/Kv557S3jzapbSqrskVMpMVqfeMk/UbJzYstl2l2/ad6j+VOxpNAqNqnT0iiwR5FLnugh2/GUSOgOL/ZmZ4FloldAfpwvAD5OBVWm1XyWiEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717994749; c=relaxed/simple;
	bh=SMA++MELxtndsmlf2ltstvee/EM+yG8MF8KTMj9Ilaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o8hLMcyqS1rT2heaFz+ouyx5f8+XpdxROSnoq2/s5pNHArQWTqxDuc5HYX/WUIcJDnxWGGNrwlU/yy7EVAizyANA45wORI6BkLcRuMjnOdciqq5Ucwc6tvK+WY2waMRw7e0q+9+ANolOQAbTmY4iKuEDMiXw9N7FcC15zU5IoRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Koj25E+/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f6f1677b26so8867315ad.0
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Jun 2024 21:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717994748; x=1718599548; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P240Gh/m4dWtpIWWlN8DjDnG2wL4gQcnQEBhQHOtafc=;
        b=Koj25E+/B50VWoWy3AwSYsiTNVlsXeDom2u/4XTUcQFirUnYLEyNZyjImfQbftc5M3
         5dCtO2gkWWEkSOWLBmRi073Dp3x3V7cWfVJxceRX4X8OUSayYpPTf/LGH8Aor2EhHZmB
         etsBnsfaQub92DfFPdJfsLXVoOYC5CU1oXF8l0PAuxs4JtqDqs2d5Kpcf0iiRaPFYPoK
         VWEJJnICFeVJUknP1jHZq+LYN6GdcDbKH4qsAfAsrltr//TlxJwxoR4f0CgpdAmBJZXZ
         JVOXcGQkyJhcCYVyIAx7c2hw5RLpAW4wvXrrOaQtVETebR6Pn9r4iyMPR7McAr27kdUP
         vEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717994748; x=1718599548;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P240Gh/m4dWtpIWWlN8DjDnG2wL4gQcnQEBhQHOtafc=;
        b=mMOr1FCaYtf4HHSR8XbRZT460Is3XSpMbYjIIxYLNWfXbN/V+qf9fvVhE2n5SNN9Ur
         S0LVU9Mk+RkbMYhKll3GNJoFFp/3cV+0HlqxaM3cpu6MrMW1SK+Av4PnQlp74D62b3Pz
         0KmFw2EMA6UokEEx5Sqsk/R+7awcQwwIrZCdSSAyynkMlgHyTKffm/1PIjjHxA2g09y/
         dYdNJP8iPxRMB2TfH7wp8SAMuU4vdmmhFMOXASLC1V8978/4acVQxJRCZBbnNnotaaYg
         fBZzlREhS7mvOSa8e+4Ktdr89qqIwI4X6s/h+aJHv9PoJxCDy9DXQvqsPMCadhz5gBLI
         ggBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHho15V1Gi7uEv40FLE5ZunP3uO24zcwkfbzQtA+/IHs43/anQCBdYZIOR5V1Xc4bXivAs4eeJmqqOVgdZXyVrMKPkGGJMZ0+3gt5Bu4dV
X-Gm-Message-State: AOJu0Yw7I5YKUiEAGpHBEl8EP7/RUprqarQIOn8rzGITv3tY66AU4x4i
	S9xPi81HCpFrQdIjNZkGfjM/u/uQHfgpAJLfDHGwja0A92uc4lbwOGGGUUNfI/w=
X-Google-Smtp-Source: AGHT+IHHYkPAFs7Wybfe87tVbgyhX6m7aNDjY0QvnrXxzXLixuWmYwWBPXRWWuSdJ8YBrBa1EGWvsA==
X-Received: by 2002:a17:902:db11:b0:1f3:7da:b0f5 with SMTP id d9443c01a7336-1f6d019efbfmr128910115ad.22.1717994747846;
        Sun, 09 Jun 2024 21:45:47 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76ce8asm73124095ad.77.2024.06.09.21.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 21:45:47 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Sun, 09 Jun 2024 21:45:11 -0700
Subject: [PATCH 06/13] RISC-V: define the elements of the VCSR vector CSR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240609-xtheadvector-v1-6-3fe591d7f109@rivosinc.com>
References: <20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com>
In-Reply-To: <20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717994732; l=954;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=rl/YEju2Da4Y30TCSeGgcBJQ4jtog67tmUBEGN9KrFw=;
 b=P25QoGbkxEpsQPOS3fSEe2wHlcp/4ddwgnPBsbhgltAUD65AsllR2lgWJ6YD0KH6hvNU90zge
 uLCtEb1QxJACMtDDLFk1aJU3wAfZckqIcjUQQVTLYFFInUydCNoG4cP
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
index 25966995da04..18e178d83401 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -216,6 +216,11 @@
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


