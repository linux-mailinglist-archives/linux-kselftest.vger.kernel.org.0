Return-Path: <linux-kselftest+bounces-14167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF4793B74B
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 21:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3DE285836
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 19:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD59816CD1F;
	Wed, 24 Jul 2024 19:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IFSxe9v3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E816B74A
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848446; cv=none; b=WjIFQRloC9WpnrHvBY9vF0aOZevKjZ+g0msgTkFP2QlmxbmhbFxej5NRcIEQmxvFwC5hMAjNC0dtwhfhRfZw+imekrM25EU06qmo9uYrTfCeN1bBfa0gEr26LSPqIB5tIcpN4iIbjalPl8UghOVPKn8l0emqbCEXn6EZA34R96w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848446; c=relaxed/simple;
	bh=lK25kSvuXBbjCsm1KOScKY69sa4rMHinL5Ye8aockR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YqkvL5bCxkCXJP2CUCkBxvQskLkxHJdlFdtp0UEBXr58In40xsrg2RZg+QWZ5SIlrzbEfjHwOdELmfnUC4duS56fr/pkxWpnu8Vm2JXM/Dd3YiCO++z59XB2t6fh5r5/dW4lOqT62fAqNN5Y09hcOyAV7AFNpFxNrwO74ai/2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IFSxe9v3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc49c1f3e5so1180605ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 12:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721848445; x=1722453245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RiVgzby/fIL0Kxxx3Y50ysZFHbsEJYdDMqDhTheyzc=;
        b=IFSxe9v3+/6PArjyUwLvnXSN8wZj8P2sC/IKPuvTURlc68UjCOPQbqnynGxDhx22/K
         BNNYW2xpwT5woJZZ4QAsdUc0HJf2GJFnoOak9TN6tG59gPxNeY1FmNcd7twz5FzuSqKG
         xzQ7mGAwwjxaoq4/y0cuD4uGZ+ZLJDGatoOQODVWe5NrFh5EgPh2uJ3RbVTbNtOqNEsL
         owOb6xJr7RWBjPi0SCYvwRzYjqQ48nXn1JrjfZmnUkT6jgY37B4Tq7UXkVQuXIPITKCB
         LJXUJPE0enlTX1538x2K1SaPor2qWENT1GNZ+VMmsHDju7dXd9ChbW6nYMVGPXsk1fUi
         bvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721848445; x=1722453245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RiVgzby/fIL0Kxxx3Y50ysZFHbsEJYdDMqDhTheyzc=;
        b=sAR19zJLBXouZLWf0+Auwz5ky9ztrzgejPzcDsPWQG2CHXbQg+f4dmGYjozi8/3S9x
         fcJqCP6A7shwaFcHTn7YIrpzbrKPzap8y7dMGBJ5bAspZg5/AlZo/lPZQu8j2YfoCryk
         fKgGm6ku/Pwq/WDIizvNR/nLG9QNWpMqYmQ74YibgFkEKF9bVJbA8ZqJP4yuOUp/BrAp
         EVgd9cdFaYsdDinc/09aAyhTAjSTsHfvi07lACJ1HaEcUkvE/mub0Jxfa0tmP0/1h7tB
         LBg45RnM+/hSU39GrnLP7/O1qsjwKe7cqHMCce3h52SxLJkEeQBZG0E/ZxAHYFJxvtL5
         3wUg==
X-Forwarded-Encrypted: i=1; AJvYcCXtJHnb4gUxXcNYXng1ABEbaTrVLntVPe+2Cx6rfQvTpg7rVXTZ44VoP+qMR0YnkWNF0ogzZRO3cRx/4bJ1ePzQU1L5uwzddxXFXME3HOZn
X-Gm-Message-State: AOJu0Yy5w6rAEUxdVpjBrp0z3v5fHd8XJLsM0c9nxzOUpjK/xscZ0T0/
	lstCFlgF9H7Q/6HI1W7+aNglBfULarYlKZBIgXUYET1qHA1tyfZtV3BU1rxCjig=
X-Google-Smtp-Source: AGHT+IFx97Y0cC+HCH9nA4VAxFdhc94zzoHJto1hheIT4Bw8Wii3Iml1nv5bpeIsbUYcqNFP8+VQRA==
X-Received: by 2002:a17:90b:1201:b0:2c9:9530:304a with SMTP id 98e67ed59e1d1-2cf2377043emr528027a91.9.1721848444737;
        Wed, 24 Jul 2024 12:14:04 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73edecesm2022359a91.32.2024.07.24.12.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 12:14:04 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jul 2024 12:13:53 -0700
Subject: [PATCH v7 02/13] dt-bindings: cpus: add a thead vlen register
 length property
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-xtheadvector-v7-2-b741910ada3e@rivosinc.com>
References: <20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com>
In-Reply-To: <20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com>
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
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721848437; l=1911;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=lK25kSvuXBbjCsm1KOScKY69sa4rMHinL5Ye8aockR0=;
 b=CjHZjgnqGNw1RWWuMeXL+h4ZRUcHluI9AgBOflCAqUrmXobpkFE/dlpLH4t3NW1vya+Q6wmXZ
 d8LozeuyiSNDhlJBwI2X3rx31jTWd2nbsaHEp8waveombqcpV2ALPOC
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
index 8edc8261241a..c0cf6cf56749 100644
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
@@ -95,6 +107,13 @@ properties:
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


