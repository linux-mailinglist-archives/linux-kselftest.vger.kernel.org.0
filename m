Return-Path: <linux-kselftest+bounces-8947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5168B4122
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 23:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01BD1C215A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 21:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3116C38F97;
	Fri, 26 Apr 2024 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KTtwUxxm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB17E376E9
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714166972; cv=none; b=j6dhPJpxNBNJUmtDxbDTw31pWkjR5GyeB7Nuv/Zp57YK/kfJ6ABBAMT5tW+EqEkmpoc7Ln52Lq/jGMLLA58l15ZBcPZiH3BBZiWGoQkcbFDcDq76TJfa4kf+eFD1Xb5hjnSCY837u2WSUIQQcNPVgQHdUfkAVO8nBulTBk7+5VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714166972; c=relaxed/simple;
	bh=PDP+pfWfSCvmvZn17Dj5qqvNgRLWprJakVgT4fj7WMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JarvVUkQJ13LOACH1tQI9GBSoMuwmo5obgrCYWdr5EeW1t2qRBz7dY8pi9YqcT6abu+tiGBKQAqml2tRlCD1+plO/aHHuQ84Xyui0JCg2id2ZPGA+g+TQzHzr9SH2X4isiRvuUaGtxbwKncFaQmG4OoZUghjnMSQ+zt/PvTzRMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KTtwUxxm; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso1803015a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 14:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714166969; x=1714771769; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VjeHR1eFFL9Gvz01+9XywijwOrTXSU/mr8HqBxiNzQ=;
        b=KTtwUxxmQz9IE/liIuQGlo7lPvuyRKWRUuOZHwC3vXbFzqgecJr5OFIMHJ2s/B/cf1
         YDLhHuIiPChq7jKawNUGUZ0rq3DJP0eKLQlVR/V2qszLA4yW8m5Rw0zbbekxgFJQJxe+
         pz+THgOdTYzOOZls8mqIMIgHzWIEdXEgE0Uj6+uCTOCsTBcqdHQpdfJkFGaKH5K8w3GH
         adXsQ8v4zG21dN5DEIsIpjm1f89J/L3b7wuLH/3mRsOPKVqto43xUpJd4Otu7R4aRvX5
         W3ERG2W2PfAK8qYzNXn6QTxkgZOEBDzXXMacIE/KJLu7I+X6ESkg08ROxncRFqz+Vzn9
         +6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714166969; x=1714771769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VjeHR1eFFL9Gvz01+9XywijwOrTXSU/mr8HqBxiNzQ=;
        b=oo838YaoNbbu4xmbvS9NDt07LG49irG8Z19BBg8XiOxwX3s3azFpl9P7dljM5JJNKD
         GaXadmVkPwVaJXkYIREoqT0LxMs4aPOhlNfEnrG1nlhSxEOeLL13sgWv+4K7e79E+jLb
         E23UtXjZWbVJCusJbblW/LYJHAZsAGItnRE7J7TZby2Sl0g4xIFUa+/asZzuSWwII/ki
         jdsUFeBtxOJ/vluvZ6kYDj4NLy8wC9pFsMTO1GPntHLvi+EpsMFIt+SvdbThg5pV8ENo
         5SVLpZ0g9BJ7fVEfqIqCGqkkof40gyoJBNe4SGhPete0uSdKGmdSshQ+vuwTbMFe+L+j
         FJVw==
X-Forwarded-Encrypted: i=1; AJvYcCWXNRJpKEGbAPG50j8f1Irx+m/XicfCM3SBbdt2oT2e4BM2T5NNxMC7IFv75sa9BbFaUyP/HUk50UtgmJiLjW8pXUW9s4WbZ39skZtztgyv
X-Gm-Message-State: AOJu0Yz0BNnvoHZrCtN9Kp+Z9mLY9l6v7EGoVr613BPm6xulsl/uwhHo
	fDJDx9zt92qltfVreOkzHx67fSyk/5y/+FVxmuu2C6lcebUZIh4G95Oj9oqi9jY=
X-Google-Smtp-Source: AGHT+IG0NLK4iE+eUG4asNWLFKpGGh4C2Wjuei7tv/cQwmtoLplQWM7s+CxqV+3nZNHhGKsZKJXClQ==
X-Received: by 2002:a17:902:f643:b0:1eb:788:b424 with SMTP id m3-20020a170902f64300b001eb0788b424mr3956494plg.43.1714166969118;
        Fri, 26 Apr 2024 14:29:29 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902650300b001ea2838fa5dsm7226720plk.76.2024.04.26.14.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:29:28 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Apr 2024 14:29:16 -0700
Subject: [PATCH v4 02/16] dt-bindings: riscv: cpus: add a vlen register
 length property
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-dev-charlie-support_thead_vector_6_9-v4-2-b692f3c516ec@rivosinc.com>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
In-Reply-To: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714166962; l=1443;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=heJ5mXr7Tx2wdFjG631ibJba5Q6SNbmXVyEpdKm9JEg=;
 b=Sv3NOp+Khbllr8+Jo15OweAuQfWJMGJSmsVQYWIPByneO4usORzy+u5Sxph4lQEGlzWYaUTCa
 Prj7RDB934ICi2CTIsEbZ+WZBC4lg45Tneo8TuIKSKFlCvLf8TPmYRa
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

From: Conor Dooley <conor.dooley@microchip.com>

Add a property analogous to the vlenb CSR so that software can detect
the vector length of each CPU prior to it being brought online.
Currently software has to assume that the vector length read from the
boot CPU applies to all possible CPUs. On T-Head CPUs implementing
pre-ratification vector, reading the th.vlenb CSR may produce an illegal
instruction trap, so this property is required on such systems.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d87dd50f1a4b..edcb6a7d9319 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -94,6 +94,12 @@ properties:
     description:
       The blocksize in bytes for the Zicboz cache operations.
 
+  riscv,vlenb:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      VLEN/8, the vector register length in bytes. This property is required in
+      systems where the vector register length is not identical on all harts.
+
   # RISC-V has multiple properties for cache op block sizes as the sizes
   # differ between individual CBO extensions
   cache-op-block-size: false

-- 
2.44.0


