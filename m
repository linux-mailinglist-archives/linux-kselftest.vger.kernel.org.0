Return-Path: <linux-kselftest+bounces-8575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03278ABE15
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 03:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0EE1F236D1
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 01:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67241C2B3;
	Sun, 21 Apr 2024 01:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YrgpFBIu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9C21BC4B
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Apr 2024 01:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713661509; cv=none; b=fy4NXdvFzkrruaSuf20VxJfMd6HphdqLk7J4yg/Dd5ickCFvMLWpFO9jSk+O9O80fkDxdMRTTTlvvu1nq3ovQDocgIbc6AIGsJzW8ixe9RF77APOvxr3uk4v7AHl7dYlQ8vkWm+JTELrOMbK/eCHB28zhJxBJevn2oI8odM5MoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713661509; c=relaxed/simple;
	bh=hSZDQKNr3tkZT93AWiF+tJx7RzaJfBNyv2pzte748aU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TvOCXs63GROZFpJVZdcP0alI301bfALGm03ga+1V+f6kM+BSc6aiXTbLYpWboFyXA/3GfUBb+3WiPvt6B6e7MrwuOtvnnac3UX0R8S+/+K775yYbSpT7V2gDc5fd++hzfpQLUGXV2sPYvD38Lrz0CVDriDlxw0VolSGSFD8gBQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YrgpFBIu; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so2502578a12.3
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Apr 2024 18:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713661507; x=1714266307; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2nk2JCBk+l9WgkXKFxu/w/itsXmN0i69JJANxOESAA=;
        b=YrgpFBIuTk3VoLmuZ6zEHHzItuxE0rJ/hh9nJXs4E8wZKOcc214t12PBmwvmBDbOK2
         +x0zQW5aKty7DCJVYVBZqTCy+GuiZzZ7eTzuTQBLcWuzwoh1INkOSchF8AI9jSrMMbau
         4FvFUt9vAj2+EGIDZwvFO2X+BxyS0So4Mga7o6rEXMi0jG4rlty9cpvLXOEuwUmATyf3
         EW7SeddzdZIo5tw897dhgkhq2Uxni8qwwoN70/Lp5HObnCBqKcdF8n35askQKixyGzUG
         CQ6EQ4GzxosmoCfwuIvDGTyd0jou7+oOAzf+yNwZu7+52OWALvMB0ZQl+iQ+6cbbaVDn
         WCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713661507; x=1714266307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2nk2JCBk+l9WgkXKFxu/w/itsXmN0i69JJANxOESAA=;
        b=bSktqx9UVaydH8gKIdgZaI6uUQYuIaaeGU0k9X+IAb1fT0EbmhMS2HDWC8A61vfJyh
         cUqje6Tkmv2eN+QOz6iAD1mzfv9cU4Vpkdl6HGhyF8xfo/FV2cFG+wP7442rN7McOo9P
         lbbRJtKpZpIA1Hp+e/qcAOMLJGfsCAY1LUHFLMiYt4089Xz+AHub/M7O+0Fdm9mYjen8
         eD38G1UarpFzeFXSvWIMK8QZgKD1N8z9T5GFFPUESc5uPNGsMhtNqaXSezCLwWuohrPw
         F8Cpr+PHZCRRobpyioEQbWg81P9W1VdI3MjJom5mEBFPXUZzpSKrMA5JUVOmbsYs4LEf
         VbnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMHAA7IlVYi9HlJGTL4tqoaywQMyTHqfImESoA+ATM5Fm/62HkuBgZPWXDfGSHc5nyy1JkMoy+7cotN2Pps7TvhnP6eMmXvj/buSC9adLC
X-Gm-Message-State: AOJu0Yy8687Z65A8rF/2wkHUDSz9jb3D9BGW038K2GG9PIe/t82czBWT
	k2vcVJSM4YXGHjaW1emoz0TznKpMvK3lKYfnCShdMNlvJHsBAifDfbgiER2jaP8=
X-Google-Smtp-Source: AGHT+IHHK0CmFEjUYa4B6mPQ0N1eaa44TysOKXGCa/Ivklg6CG4klOmrEKVYQ7lcoTnquYAd4o9XZg==
X-Received: by 2002:a05:6a00:3d05:b0:6e6:9552:cf33 with SMTP id lo5-20020a056a003d0500b006e69552cf33mr7165613pfb.31.1713661507603;
        Sat, 20 Apr 2024 18:05:07 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d6-20020a63d646000000b005dc8702f0a9sm5249627pgj.1.2024.04.20.18.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 18:05:06 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Sat, 20 Apr 2024 18:04:43 -0700
Subject: [PATCH v3 11/17] riscv: csr: Add CSR encodings for
 VCSR_VXRM/VCSR_VXSAT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-dev-charlie-support_thead_vector_6_9-v3-11-67cff4271d1d@rivosinc.com>
References: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
In-Reply-To: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713661481; l=706;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=hSZDQKNr3tkZT93AWiF+tJx7RzaJfBNyv2pzte748aU=;
 b=EaRHq+U6nQY6UMNHfwQt7VXjyHg2fLwFPXP1BAl3sVEmRMdMMwXIiKvRomtQPJzmqtJqOUvg2
 jdINbQQjXWJAPYzqwG9jFhZUzK57PzwK7Icxv/QOIMHdsf9Ai2sSDqo
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


