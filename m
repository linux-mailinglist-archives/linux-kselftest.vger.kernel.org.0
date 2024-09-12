Return-Path: <linux-kselftest+bounces-17783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A436D9760AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 07:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E7F1F2403F
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 05:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C369F18B486;
	Thu, 12 Sep 2024 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1UTbr/Y3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D0F1891D4
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726120551; cv=none; b=iUzCiHjnulN+jBnNP4IWfQmlHvr6kHctJOkMNpG0tMrp0HwhDPSTmlMRY5fMHzVXmpAxyByADBcct+/ZiT/GodER3RgAPloQOcltwQcFmnlueQZZ2st7VuDkzSB6DWB3BtCPHG4t4Z9856Eg54D8jhnGnwtXrLy2Lcg0QRiTGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726120551; c=relaxed/simple;
	bh=g0Gsy+5TQh3RSmd39xewdNDSsmzEd+HtR+40T1Y+noY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q4Ciml7l2e4KFJUCKU+Fhg8MMZaM929e9ZMQsMggP4Q3QlKLMlaKJS00zpfJEq20aVLB+aJD4mCah2CDjXxoYwv9Uii+DkgSXgVGO4TntJiFp8KWjAUAPPJwIyPVZe+bhVw9wymBc4JZSrZNTrR42lRdZ/errQ4viZmfaOZJD2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1UTbr/Y3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fee6435a34so5591655ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Sep 2024 22:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726120549; x=1726725349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8a31h58dvirjjptvxje9y9Mqcx9iPDZwg1ciuyTglV0=;
        b=1UTbr/Y3hs1UDqtntIp9L6nDOdpZ1Kp/pVTR2rOwTpBkjzDghN3wuSPZVLZ8LEap4V
         7LCPI8kTCGzNVzAcJFBYS+MKCtQXMXcoUOXFArx1wXK8Le6xjJpS80fyCKejq3Ubadsn
         p8fHwJL4MqRgvvH2RpBsxNGxq7X8ySTG3L3G7Z9COWE56SVUM0KaFwNaGjfKsXHETsFP
         AG9MmkX/rdJAEqFbimVeoNkS0hilY//LLowHj+5iFZijIDnnpliiEhXGNPXqurRP1kro
         6JQfQ7G1Dl6qQ5zK+LvTG9N0oB3nDDYSk05btCrR/xO5Y6IFbStk6gcaY1ql1Kw9Zild
         dWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726120549; x=1726725349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8a31h58dvirjjptvxje9y9Mqcx9iPDZwg1ciuyTglV0=;
        b=By5zR33RQ/ToPoUkxj8Q3vz0fYcMC/E8bLdTuTv0E4r+MPdB6YaGwmrVD4C9m87eSu
         LW9itnr2AGhf+XIJfqznvJVogU0LOZlYAx6S7inbLx2Y69PXOOcrv85kOFhyVhrOVv6I
         191BMtb2CN3ZZOeu1QKFsqDdxgZOXKuZxlEgF6fgYFzAm3TwiUi8M94f8LawrQ2AW8Tc
         sMczYuABBL77FqHDFWv/TCJ8qxpdl9eDdN+ZqjZNllqwLmZTgKKRxC432xI2ynr5/NLP
         GbgWkeWR5rfOKVFXzgqHQ0x7Q9xkCo8789pPwLYxnVB0WjNy3qfefiou1aY3DJwOp+Hm
         6hGw==
X-Forwarded-Encrypted: i=1; AJvYcCWDUYXcG7qks+HP24FnAmnnUdIgofEKg1Nzr3L1U7LLRBhsxy6Hf9RUr6aC/Ujl9ZwbsQbJaaKGz0o7KH7gEDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJC7SU+Rhl0k81adNS19N1fkIU7HwE5is2CLBCCZ0YFqgsJsLN
	M5Fwz2vl9BcRO5OZNRuab4D5v/MOYX6oCwrgyP96VEjzejGi51CZs9TQRdk7CNc=
X-Google-Smtp-Source: AGHT+IHKCeM+iDzgTZA8iai8wEAdx48qgNifGNBqlmMlN3z+2F0fcjMXoHNP4W4BOCCsUutd/a9kSQ==
X-Received: by 2002:a17:902:d2ca:b0:207:1848:7221 with SMTP id d9443c01a7336-2076e435f13mr19074275ad.53.1726120549289;
        Wed, 11 Sep 2024 22:55:49 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe99b6sm7870465ad.209.2024.09.11.22.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 22:55:48 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 11 Sep 2024 22:55:10 -0700
Subject: [PATCH v10 02/14] dt-bindings: cpus: add a thead vlen register
 length property
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-xtheadvector-v10-2-8d3930091246@rivosinc.com>
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
In-Reply-To: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1911; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=g0Gsy+5TQh3RSmd39xewdNDSsmzEd+HtR+40T1Y+noY=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9qjpqi6xw2/1SybArcG9ZkvPNr7wOuI2MvGzcmpp08lM
 4gsfHalo5SFQYyDQVZMkYXnWgNz6x39sqOiZRNg5rAygQxh4OIUgInck2T4wx8msdT1Y+GCg4JJ
 iw/fOWJy7lHE19wTRd83WVxqDmV9ycrI0K+yobbz0fd2lzOdi1gq/n0TaeVWlxX4l5/FcOe1xYd
 lTAA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

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
2.45.0


