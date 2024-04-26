Return-Path: <linux-kselftest+bounces-8956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 940328B4152
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 23:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60581C216E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 21:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BACC374FF;
	Fri, 26 Apr 2024 21:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GeIc4BJu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7663770C
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714167434; cv=none; b=jNyrWVlX2Vh8swsfwS8FS5+Ne+91RC9TkUWb3kj9xeCdKTt9NrwI78NurQB2o3uxa1vIb1pvpXVXFjcQY28P0CNDgfWgI7NSHuL6wCQblMP3NYCE2boWaFRJ/XtpBBicl4mmkC/HI8c/39GGE9nT7BerdUgzX3S5J06aO6b3iPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714167434; c=relaxed/simple;
	bh=hSZDQKNr3tkZT93AWiF+tJx7RzaJfBNyv2pzte748aU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ed6n+EjiqHUnsRDGCwKRCBwJTUFhc4+e/YRj0W2U6czhuKkri6yaqhh7krOaGFqts2F6fZ+bAsjA4s4aCixRGwX4yH0FqumDqoGsQ5FAf1/KrpjkejcLTT4ta0SjQkpCG3iQLeTsCjC0GRHrgwrFK8Cv51hzEPjAEF9brM889Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GeIc4BJu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2b137d666so20533915ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 14:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714167432; x=1714772232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2nk2JCBk+l9WgkXKFxu/w/itsXmN0i69JJANxOESAA=;
        b=GeIc4BJup4FtSj9pGD7HEw/CxizOcQwvPiN15K6cKlHV7NIZvPE45/OXJyyLK0RwYW
         tKy5f21BtAbuRZE4AEt4wSUS6Xzfh7C6CzHkfZBRHhQ9VFHV8bBTanSKk91GEvtHWmDP
         Ac8f7Wdt+tBnCM4vndgMw+NCXeMosE2lJKXD4RWJ/OpwBaqdT8bZekFEWQfAGXKoVih9
         qxmzX6TNK9UNSDC0UO2DFzM4E2K6oeuqlVQDKn6D9mlj4OiMwGKggsjpf+gGwleN/EYA
         4liWdBpNB5Xp+dvePjHx3pTuJKId/lX2rpMSqj74yD9lN1oYcJnak3S2leSsdOJuH243
         sjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714167432; x=1714772232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2nk2JCBk+l9WgkXKFxu/w/itsXmN0i69JJANxOESAA=;
        b=vw9o+z0zBreJHgJujKVPcdOm/4A75ZeX43nMB6WtQGYGDPQSsA6D0DwfMtJuQSjubd
         2bsUaktanqs7/afjE8RR3Sj06ousxbUPG8CB0CGj8Y1xo7GEaBrQrt8tuwUMp4Hqkswv
         32qMCMm1VKnlBp6Z9I87Kq1XBueHYSfJhs7+qyCVk5kDfO9wEfnefTbuj29Bd8a9vm1b
         SW0NhmDRNdmDtKU7920CnwOcfrDqMbTgQXSzuFhsw1ZLfpT80YBxyq8L4s6cueRetgMp
         XAP4b3p1aOLd6RMgtfRkLEtPjLOHv2P09vaQAGBKEvwicZg7zrzAEz3w9RrUXPoADGC0
         uK1g==
X-Forwarded-Encrypted: i=1; AJvYcCXrVrmLjl+8ebe+Qz+1IHhVf5HpfMg0dAAY5EmcSlZkio7Es60yZY8SmnbRbhxj8lxZd6AwBZ/j/r8oVzqHnjwaxYhSMwlDs8YUXutSpc7a
X-Gm-Message-State: AOJu0YwQzSKTqK7aQ7tl0QTS17dfYYjwJEm5fpY1H5AmzJGZavQfUpg/
	ItZkkGEbyMGehBxtPdd0KzNgMKIu3waaPFqAKMyj83oyGKuppWurO6PHTQI3bJ8=
X-Google-Smtp-Source: AGHT+IGWJI3Gl0PGwdn7TcVlWGE2rPngkQ66IMWTkljKx0O39R28QRi6ZTG+h6s5DI5TOnMGruv3HQ==
X-Received: by 2002:a17:902:768c:b0:1eb:2fa0:c56f with SMTP id m12-20020a170902768c00b001eb2fa0c56fmr2018706pll.35.1714167432656;
        Fri, 26 Apr 2024 14:37:12 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902760400b001e2936705b4sm15935701pll.243.2024.04.26.14.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:37:10 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Apr 2024 14:37:05 -0700
Subject: [PATCH v4 10/16] riscv: csr: Add CSR encodings for
 VCSR_VXRM/VCSR_VXSAT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-dev-charlie-support_thead_vector_6_9-v4-10-5cf53b5bc492@rivosinc.com>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-5cf53b5bc492@rivosinc.com>
In-Reply-To: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-5cf53b5bc492@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714167425; l=706;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=hSZDQKNr3tkZT93AWiF+tJx7RzaJfBNyv2pzte748aU=;
 b=Lr2jnO/RRrFVYUUrx3W1heVv5x1j/2KK50JOmhJOqBV6IIu6PicoBjuEuMhY9FYIXioM7ltUg
 eYjbnSGCa28Bpn9mbqy9DcPdjt/TDlijUpAGzsTJXxmd0QnM2NpCbxD
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


