Return-Path: <linux-kselftest+bounces-11524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B2E9019DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 06:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6D8281F22
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 04:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AED1FC1F;
	Mon, 10 Jun 2024 04:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yO2MlF9C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C3BA53
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 04:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717994739; cv=none; b=qDt9Zv/oWmNlDo5yqMGaYIzZvt8dERR4O0ivib3wIQ2sMssmQ++dyhPMkOeE1YwZmW62eyq9jknIk7qbXzfVIYtbB9qwpL5sTkT4qWfUAoOajwhY36YG/mMahgXNI85oDrk0Ry96SHYEMU8S8FfXwG+Y/y2smqNxNw00Akl4f1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717994739; c=relaxed/simple;
	bh=BFeF/rMqjmAL/T3qO395y21tghoeF4vuGyaBxCV02tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A6SOYe2mizWuO73M5LjfmfWwBMhv59FUmdTmhSvpeIurGM5mS/Ov/7oRuJxH+6pJp/+k3xz0SGYqrVqHOLla+v8oQ1T3145qpEDCi0FhOjMNO/Lavly+QnIWcEHso9eVwu/0lR/JyQfV4yKGPFrKuqzs982p6J6Kg7qHxG9KtcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yO2MlF9C; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70435f4c330so557253b3a.1
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Jun 2024 21:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717994737; x=1718599537; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gP3BTCO/eMabIcPEHZlkkrT/LBtjjbwR/exXvwDsR0=;
        b=yO2MlF9CVgV55C8zLc2mcExV9W4UOBCDf45GzbcMIFmcn/LndIaWn7JKQ50Xu1cWPS
         H1RWv0z0xkqaEVkmf7zUViEIYseL+NM+9pEqyuLHuRCtndnGiC5UxGjqp8SxNxSPIsp6
         ELPODX4pZ06no0YnFaagI4IfZ+TQSWgCNUxORbEHqrhocFIbWbFeBqetx4bojNIVyk5+
         hOdgVF73DeGbmOo/aHTNoJMoBvbUfd37I+NyCXypBoWEPjz+AGF3d6b874taJOEuN5g0
         iSZqT5sP1hWkSf2bH+/EwRun28QeOG5+gdKXa3ePtDNkQXyVbSGNgZOaXY+jXXAjvGkz
         cerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717994737; x=1718599537;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gP3BTCO/eMabIcPEHZlkkrT/LBtjjbwR/exXvwDsR0=;
        b=LQXvi7iR22axKl2gEd4fVfi8YgwEHYCkBkvj9dNKSZefrQ9OSqaCtsK9oq11u5yd/6
         tfkNps3AU/Gkvx3faKZ9PMR8cJ/A9ZJF4i2jKbkYwbmjt5WD/ScefmQjD5nySZf5mjDC
         +kLfvnLe/V8X7XY4D+wcUoCY9UR2T0hE5VsuRmFn+Mi9TGY2nJMZZv1ISiAQv/MzvUGY
         +uBp7pu+r0cdyrndWfw6AbqRFxc/bO9iJeg4tbgS9pIL8q8BIk/yBCX89czW3qQbLow9
         bqMFoFmJOQTZVLA2553C8od1ZQWuoKlrDoFEwnBaQOBEv1onnfyAodu/n+02LLtxRD+P
         kXtw==
X-Forwarded-Encrypted: i=1; AJvYcCWz2T/HPbl9uaiPsjHuni8WGssCaxjrr+I+uTEzYPV3I/fF7CS6XboIIZsjYhAjtnH4N6WKv9ZaWbhcdHjfoWDVQr8fWXr7xmXv5gXnO7sF
X-Gm-Message-State: AOJu0YzE2kbQ8HxdyniFUIhVZs8KrUW12m4NP65mXni4sYnuZDl2rFyx
	ag9QALYaYKIDye+QLYBF5RpfFVyyqEELKEGZBp9cgAJynv1pX2UI/yxUpwMTM6w=
X-Google-Smtp-Source: AGHT+IFWDInJoRdiv7yy4abVtD7rjRBD+5cj0P5U/4ieBFQEcEQDeMGkcWS+bxqhxTSZ6IUNdGy+uA==
X-Received: by 2002:a05:6300:8088:b0:1af:3715:80c8 with SMTP id adf61e73a8af0-1b2f9c72398mr7890004637.46.1717994737211;
        Sun, 09 Jun 2024 21:45:37 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76ce8asm73124095ad.77.2024.06.09.21.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 21:45:36 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Sun, 09 Jun 2024 21:45:06 -0700
Subject: [PATCH 01/13] dt-bindings: riscv: Add xtheadvector ISA extension
 description
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240609-xtheadvector-v1-1-3fe591d7f109@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717994732; l=1767;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=BFeF/rMqjmAL/T3qO395y21tghoeF4vuGyaBxCV02tk=;
 b=IOAoxXefLtnxcb9/gkClYMSBjiej8R99FUDNxVj9T92yij8sj0PIqkxukBdOvfHybExsRN5MX
 8IFqt96IbAOBrlmGCI5VVCTbG5L+9+BjW8yNnuO22FIABU2PMBnuOK/
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The xtheadvector ISA extension is described on the T-Head extension spec
Github page [1] at commit 95358cb2cca9.

Link: https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc [1]

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 468c646247aa..99d2a9e8c52d 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -477,6 +477,10 @@ properties:
             latency, as ratified in commit 56ed795 ("Update
             riscv-crypto-spec-vector.adoc") of riscv-crypto.
 
+        # vendor extensions, each extension sorted alphanumerically under the
+        # vendor they belong to. Vendors are sorted alphanumerically as well.
+
+        # Andes
         - const: xandespmu
           description:
             The Andes Technology performance monitor extension for counter overflow
@@ -484,5 +488,11 @@ properties:
             Registers in the AX45MP datasheet.
             https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
 
+        # T-HEAD
+        - const: xtheadvector
+          description:
+            The T-HEAD specific 0.7.1 vector implementation as written in
+            https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc.
+
 additionalProperties: true
 ...

-- 
2.44.0


