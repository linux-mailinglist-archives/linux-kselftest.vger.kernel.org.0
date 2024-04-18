Return-Path: <linux-kselftest+bounces-8317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 525F88A9A0F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 14:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1AD81F21BD3
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C9A16078F;
	Thu, 18 Apr 2024 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SFqAV6eu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2938C15FA8C
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444240; cv=none; b=SwXoN5pW3oqn2YkDwXk+Vd/E1nDhj/1IhfxQB0F5ZUzlE4S+9G3F7nx2IPLaAamaOtT8AdpWYfZKmWzEBPQ1Hd8RRA4VnlHUzlyLxBWpT7aNUdJD6LxLw6X4HblkMeUH+OBkhO5suN4Gr2d2c163EUQVg94URwToP6RCqcmF3iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444240; c=relaxed/simple;
	bh=I+l+JkVVH9yyH4nAg3oBjtzyRDSG/5kxRFfJnm0mGaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=prWZcTJNwIHTmEgDYX5YBVFlMUE7qMbnrzpyUq8pToLkiVJSXpBBgeejlLyEHTrtDJ8iwa9vfnYAbqAZ6Vt6pggFe6iqN5hVeB0h7/JhVvAmTQkdMn4Ne42PXB46H02UmsqKUPBt2skgde+7CJl402uk9xyWOP1VJxLitH8qcI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SFqAV6eu; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d9f829d398so1957641fa.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 05:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713444237; x=1714049037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqinG7vx90NXqlB3cCAWzb6LZzjfwkXKYqGSSxQF2QU=;
        b=SFqAV6euphnHbeuqYe1KEqDKSPsC1135ph1AH0o0FVXjt1EJJYyQsmpjhEK7D4Xbvg
         RoNqIZarqw+FTLtg0itCZS0c2UyG0cYv86n5Mo8IR5Xmh06IHaVwiAe4gSUmBXC5fzJh
         d6el6IuvBHDCJ8H+U1Y3IE53r+v0twX4+taSZKUGgA0Fe9xbY9B/MEA/maF4Wve5p9FP
         HIiZJsHsfpHauOkLRpuM+3tL/gNiyihBtyOvdnFab0Q1ASLkF/t+Iv2UzY68BQA7Zvdm
         +MnG+SuM735QaV3PkNN+U7n8Gb86Ow2yIPKKDnrtCOSFNNByNDR6b2cu85Bden/X+DNC
         v92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444237; x=1714049037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqinG7vx90NXqlB3cCAWzb6LZzjfwkXKYqGSSxQF2QU=;
        b=wkDVVmGTLh8KnWDSj/wc0y0IZLXplZ+h6MOEOgnkgArdmheXHKinhhkxF4idlhp8tZ
         SqQn2XZWKEtMG69G7T5nFz1EgDWmoqGAtO8HKdXfxN+Seubo1druBlrUeaDqKuABcdGx
         wbIHHe6eQ2WKlxVDQeeFFYXlK+4nlo+9mHWVYiul7XoIKG//+iLCCOyt6VNUJZprGC+i
         LTcoMQcGYvK+UCw99zVwpPwUoRCupakWQlCoE+YvgOSFluVqInvvIh4Q+4/1GWOQa/le
         5C07gDI53FST1NVwm84e5efP2puQGKENLKMNP5AKp/Uu3GNQ0HcRMbZi61QQZSvErb8p
         pl9g==
X-Forwarded-Encrypted: i=1; AJvYcCUTqdQwK+7/t4Et2yNAUccRCA/RASt6GCXQB8lGMAqMcxWdfW3Smmfl7kGBO2JTJ/6+ZCCIC1hih14iX3gcwgiFOibgAgJY4cSSku1pzExe
X-Gm-Message-State: AOJu0YzE6DoIKjiZnlocRtNEf32xgSlc7w0UYSB5kUmmKjRa4D2mXQBr
	8MJwJJ5MUPNUpyFqdevODO/fHhpzgr48XRK9W30C1vBIIxpZrrGI2sX6tVVakZ8=
X-Google-Smtp-Source: AGHT+IFXBu2QshCmevcqDNI9qC29EYmJ3ZQBbQK0N8BE6U3hHj6+0OsosVqzAbOLR3+7A5/jwaHB/w==
X-Received: by 2002:a2e:8387:0:b0:2d6:c59e:37c0 with SMTP id x7-20020a2e8387000000b002d6c59e37c0mr1507578ljg.2.1713444237161;
        Thu, 18 Apr 2024 05:43:57 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7b64:4d1d:16d8:e38b])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05600c3d9200b00418d5b16fa2sm3373412wmb.30.2024.04.18.05.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:43:56 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 03/12] dt-bindings: riscv: add Zc* extension rules implied by C extension
Date: Thu, 18 Apr 2024 14:42:26 +0200
Message-ID: <20240418124300.1387978-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418124300.1387978-1-cleger@rivosinc.com>
References: <20240418124300.1387978-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As stated by Zc* spec:

"As C defines the same instructions as Zca, Zcf and Zcd, the rule is that:
 - C always implies Zca
 - C+F implies Zcf (RV32 only)
 - C+D implies Zcd"

Add additionnal validation rules to enforce this in dts.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 .../devicetree/bindings/riscv/cpus.yaml       |  8 +++--
 .../devicetree/bindings/riscv/extensions.yaml | 34 +++++++++++++++++++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d87dd50f1a4b..c4e2c65437b1 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -168,7 +168,7 @@ examples:
                 i-cache-size = <16384>;
                 reg = <0>;
                 riscv,isa-base = "rv64i";
-                riscv,isa-extensions = "i", "m", "a", "c";
+                riscv,isa-extensions = "i", "m", "a", "c", "zca";
 
                 cpu_intc0: interrupt-controller {
                         #interrupt-cells = <1>;
@@ -194,7 +194,8 @@ examples:
                 reg = <1>;
                 tlb-split;
                 riscv,isa-base = "rv64i";
-                riscv,isa-extensions = "i", "m", "a", "f", "d", "c";
+                riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zca",
+                                       "zcd";
 
                 cpu_intc1: interrupt-controller {
                         #interrupt-cells = <1>;
@@ -215,7 +216,8 @@ examples:
                 compatible = "riscv";
                 mmu-type = "riscv,sv48";
                 riscv,isa-base = "rv64i";
-                riscv,isa-extensions = "i", "m", "a", "f", "d", "c";
+                riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zca",
+                                       "zcd";
 
                 interrupt-controller {
                         #interrupt-cells = <1>;
diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index db7daf22b863..0172cbaa13ca 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -549,6 +549,23 @@ properties:
                 const: zca
             - contains:
                 const: f
+      # C extension implies Zca
+      - if:
+          contains:
+            const: c
+        then:
+          contains:
+            const: zca
+      # C extension implies Zcd if d
+      - if:
+          allOf:
+            - contains:
+                const: c
+            - contains:
+                const: d
+        then:
+          contains:
+            const: zcd
 
 allOf:
   # Zcf extension does not exists on rv64
@@ -566,6 +583,23 @@ allOf:
           not:
             contains:
               const: zcf
+  # C extension implies Zcf if f on rv32 only
+  - if:
+      properties:
+        riscv,isa-extensions:
+          allOf:
+            - contains:
+                const: c
+            - contains:
+                const: f
+        riscv,isa-base:
+          contains:
+            const: rv32i
+    then:
+      properties:
+        riscv,isa-extensions:
+          contains:
+            const: zcf
 
 additionalProperties: true
 ...
-- 
2.43.0


