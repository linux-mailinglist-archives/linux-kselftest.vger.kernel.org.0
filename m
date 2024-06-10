Return-Path: <linux-kselftest+bounces-11612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B577902BF3
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 00:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F739B21FDB
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 22:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2515E152789;
	Mon, 10 Jun 2024 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XouSOeRT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C2915250D
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060212; cv=none; b=dfecByTsSVPOldavsVg6RMKc/yg4PJhRMVwrf8Xp54VBlICxSSO9D2H2kk4L29GoGjHMaKBVlnihtGNawUauHs+5QCUKUQ7I604eDlWcv1ASCQugZP0QF+pOY2rdqqqf3Iay7uJRKLqwmJan4xtHjovzfZZjwnaYK5PhY0WvRXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060212; c=relaxed/simple;
	bh=FmiYt7nDWXyQO4kxiIrIwAfbDlksD7XmLdehRC0fezg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kY3R9AqYjzCbfN97yz7PM1fvQHgsoQneuYgOCLVSDTegfOwxEsZIcdVtxYshxfajIWkFNvHV2r05PVzXKymwCt5MNe8gTWTEjCs0M5xRbI3HOs2kTGGv4Daki+Qp+mh50rvhG0bb9aVYVbMy4eJwWzzSZZOGPwnrYFipbhniMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XouSOeRT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f44b441b08so3156775ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 15:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718060210; x=1718665010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0+4Y1+kZj7kzyDByjbiS4FxJ2LwioSPa5gPvRUttq4=;
        b=XouSOeRTB62Y+M/C3QAB/+UP6XbiI2M0s6wdzp5uQey/FvbcC5WMSCvnwmkoM6MAoM
         BsLaLEDW2Y8p8Igx/oPmycoAfzio6fcT/OZp7RZrXOWvfhlwkbzCuslZESqmJd9HeiEO
         zJaUFLDyf1/xIIBg5CHBPycCI7f6VJW8RO4VDDYvcByYG7H9tERhMDQ5fpS6+/fVpZLJ
         3REWSIPhboHQWsVP5O5osto0/mpwEmQQKjOWBGvYsR7s9KPt4ZgmkuD92FuGtpQH1tck
         bjj98h2kg3jhM7L7aWVXLuF9k+VSDQTRDe7Qsz9Da1BNuO5MTMrgrkHbZDcb/x5cCRVn
         b5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060210; x=1718665010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0+4Y1+kZj7kzyDByjbiS4FxJ2LwioSPa5gPvRUttq4=;
        b=UmT2F5isZdL3wbzSE7wNJV8kYN2T3fz+t+c5tPJEEq0WzXPsgASHCMWOmk24FtvN/4
         3mV+7vpHRD7dEIQ8aat6Jj8qiuRqQQUJha0v8qKY6hdSHFsMXGiCkCEBxM7iyhkKHosY
         ya4K2r784G3lCQKAJiZZHE1t76+bOYu2RTm/+QXUafPPOB6kubOADNjAqoMUPJk2vNo1
         eXc3EPBhedpMYKW1fL7MSSNDfv0TT9+BPF9fw9PR/hrT+O+n+KjrXKwnLuNco/iR87KC
         aO+jKzEv6Yv2iV7yuBL2eo0vIRpvdgixLOlNTgjpE192PE8dvlGskMTO//Swqm+3r7Hq
         f45g==
X-Forwarded-Encrypted: i=1; AJvYcCXEf5wmD1B9VaoVo0TEsm3o1q2h4K+28dc4HNMMCAjqUrHkhw6Jq0FsqqGUsNpbXa6xpOFDSG8rdwvUs37NFsZW3ckx539WUc22UgUGu9VE
X-Gm-Message-State: AOJu0YztkIZTHrPSV6t2fnlmgU3j1m9SqLt13OGESe+uhRo5ZbFAb5F5
	9lf5HO0Ve8U2HGvbx1dkQXcJMsFqX7ErEFrm4q3KppCYykYSxp3mYNEqNbMhNmU=
X-Google-Smtp-Source: AGHT+IHY9zRTc7DxB+cvmi8dhG7Q4tdFTL7Ge2pLkU2+1yqUqlGWPw0UVlqVpdnEA5wKCip5t2vlNw==
X-Received: by 2002:a17:902:c40e:b0:1f2:f090:b2c1 with SMTP id d9443c01a7336-1f6d02c05c3mr118292465ad.14.1718060210095;
        Mon, 10 Jun 2024 15:56:50 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71b597072sm18355865ad.99.2024.06.10.15.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:56:49 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 10 Jun 2024 15:56:39 -0700
Subject: [PATCH v2 02/13] dt-bindings: cpus: add a thead vlen register
 length property
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-xtheadvector-v2-2-97a48613ad64@rivosinc.com>
References: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com>
In-Reply-To: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718060203; l=1855;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=FmiYt7nDWXyQO4kxiIrIwAfbDlksD7XmLdehRC0fezg=;
 b=j6worq4qjVrGWSrMLs8ZptH5pEOv7EhqwLLriJxX4IvyZ6q4PNQkoLqbTB+1gPxHp/ucFxW7p
 LqxKtRcAfNJBzenwMB/6ovUljV8lB8Tsp26Tv9p3U5IVmx1duDVW6tB
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Add a property analogous to the vlenb CSR so that software can detect
the vector length of each CPU prior to it being brought online.
Currently software has to assume that the vector length read from the
boot CPU applies to all possible CPUs. On T-Head CPUs implementing
pre-ratification vector, reading the th.vlenb CSR may produce an illegal
instruction trap, so this property is required on such systems.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
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


