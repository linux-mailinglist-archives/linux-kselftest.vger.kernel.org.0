Return-Path: <linux-kselftest+bounces-13110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF8092533C
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 07:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F951F24F1F
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 05:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EED12FB16;
	Wed,  3 Jul 2024 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ySogNkMH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA006130488
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Jul 2024 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719986222; cv=none; b=I18E9ySm9tcR3Xfd3NaqNfdQzpY2NrRE4YYytEr4L0RUlxK4akIgt+0mYVgYJTegVAhObozbjzRXaT/fJrII9psuh7hYHqWcFQ9T9041uOJHYu5Frw8jM3bTjPPpyTtMLGDBkgXCKziMt/vCF/8Lua5tKy53SS+koLYv0XPGpqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719986222; c=relaxed/simple;
	bh=t0lKihrW53hhAaTgt1IOAxGTxDQ1PTzmyeVPgG0X6VA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ROxq/VXJza+3PeUz1izS/hcyv9P8YGk6vLbiZfbdz/tyDF+cHiUlQibQYRLLWmd/OxB+jDoWv1HUx5/Fr3tIstKJzch34yRRTyQypv3T60CpQ4RZsU6UrjtJftFAB32WSawjcfacwpvPwWiNMYpnvm2LhYDv3sz0ilwVlBc1mKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ySogNkMH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-706738c209bso3041482b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jul 2024 22:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719986220; x=1720591020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvb4pMcEXXX1e5OzNfenqDPpdltXx8EJmOCnYZEkYzU=;
        b=ySogNkMH2teJvGWeuH//UpWfocS/t8Q3F866DJZefl2k0tZBwKu31FM5GsBIwqcRSb
         vO3NFZMyh2KS/InWFJFlD71zgGhmS1ZFaYYDf/y8+Iu8+u0fvxXYpNM2taQHYxLCjAVU
         3MO8pmtiBrmw/Gt+oBNlU8kisQ8Hl+qmXZVvVync4a3PHbQxGnI/de/fvR6cd7/D9NJC
         vyxfG1aEeu6QdlGjhmnbp6QTe8p81VI9Gk2QcxqiBgLhnZCKUebpr3dh4G7kONpIoVhy
         M1qMH24MKIlyQh2bzvSJe1CO5lgB9H9KsDpERKgI/xyae9wt5TaeD9dYpFGdvhrXF3Zo
         Jgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719986220; x=1720591020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvb4pMcEXXX1e5OzNfenqDPpdltXx8EJmOCnYZEkYzU=;
        b=JsL8S8pTS2bSR1IO9D+VQZF6HELA+kD8CicoUqnHvPsPXuS8/MTdo6NzqMRf9wUNpt
         jWrkwQtt6w5pgvsdHvZM+VYEA8sIxwz2yPh+8ngOBxADv7x5/Ifxbhjqut4C1nVqrDYz
         4cWRV6p7vY9nVG2pRY/Oeuzwcs2gH432JOS3tW8DTKWqH6H2M1sxXoyTyNYhSi8kxq/t
         JGYRuxeyv8u0maAnSYWfdk1GBzTDyPJdXl/jF//AwL9F3oVfk2O45B0eD8xmYyZ2TBZD
         sW5ICHiR1ihfhWnx+se9b6F7wg3RPuRDYGn2BZNers+KiKggN/IdW7KpQBPp30iQEtoj
         NOMA==
X-Forwarded-Encrypted: i=1; AJvYcCU9eaB7JemvAcopVC8lJWj5LIuBRSjg9YpUmdI7/PKNgkoZ0oTdfTeWjNGJ903K/MF5ZyMdyQqiSfO0IPOrCObA1kejRjznMuIeE9lkNZ/e
X-Gm-Message-State: AOJu0Yz6R5H4fBUgoiq7xd0k7bgrcDeiEGTWoiSa8cZ8vZBJnUZc2Cx0
	uE5R0G9S7Mvt4al/vKte3ML3CwCpEykvEAj6g42Mvg0gTdp1ZAGjhmxbj0cBD+o=
X-Google-Smtp-Source: AGHT+IHLVcP+5wCJ2jwS/CgMPoNMxQPrRJSB9/pQwha3z8vJTHncXe0AeYe1DVxk7ScihGO5viYKrw==
X-Received: by 2002:a05:6a00:2182:b0:704:2f65:49a0 with SMTP id d2e1a72fcca58-70aaad29ae4mr9792181b3a.5.1719986220111;
        Tue, 02 Jul 2024 22:57:00 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a89fc9sm9514103b3a.212.2024.07.02.22.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 22:56:59 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 02 Jul 2024 22:56:22 -0700
Subject: [PATCH v4 02/13] dt-bindings: cpus: add a thead vlen register
 length property
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-xtheadvector-v4-2-2bad6820db11@rivosinc.com>
References: <20240702-xtheadvector-v4-0-2bad6820db11@rivosinc.com>
In-Reply-To: <20240702-xtheadvector-v4-0-2bad6820db11@rivosinc.com>
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
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719986213; l=1911;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=t0lKihrW53hhAaTgt1IOAxGTxDQ1PTzmyeVPgG0X6VA=;
 b=F9natkpNQeWQ0v/3ry0X4JGFFC5bIc/Zo5uS4eTscrupHmc6YgR2ogYd/qmhlUPN7U2yO4UGh
 F7phnYCGJPvAFwA0cHczIEScc249KA14Dra3bP4QwloPgtx3Y+Q/a3e
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Add a property analogous to the vlenb CSR so that software can detect
the vector length of each CPU prior to it being brought online.
Currently software has to assume that the vector length read from the
boot CPU applies to all possible CPUs. On T-Head CPUs implementing
pre-ratification vector, reading the th.vlenb CSR may produce an illegal
instruction trap, so this property is required on such systems.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d87dd50f1a4b..a6bbbf658977 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -26,6 +26,18 @@ description: |
 allOf:
   - $ref: /schemas/cpu.yaml#
   - $ref: extensions.yaml
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - thead,c906
+                - thead,c910
+                - thead,c920
+    then:
+      properties:
+        thead,vlenb: false
 
 properties:
   compatible:
@@ -94,6 +106,13 @@ properties:
     description:
       The blocksize in bytes for the Zicboz cache operations.
 
+  thead,vlenb:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      VLEN/8, the vector register length in bytes. This property is required on
+      thead systems where the vector register length is not identical on all harts, or
+      the vlenb CSR is not available.
+
   # RISC-V has multiple properties for cache op block sizes as the sizes
   # differ between individual CBO extensions
   cache-op-block-size: false

-- 
2.44.0


