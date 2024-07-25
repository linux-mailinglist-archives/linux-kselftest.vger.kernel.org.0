Return-Path: <linux-kselftest+bounces-14198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B33E93BB78
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 06:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2326C284450
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 04:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ED31CD11;
	Thu, 25 Jul 2024 04:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wcizV7ej"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17441EAC0
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 04:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721881000; cv=none; b=QcvnpdLz01OTcpE9FL82HC0DVEkgMmcshgbT4GEBENYmnFln1EWHLRAgH3GOPCVWTaFlTY8P3zasrggiZH9X9zscXiB1dJLx18l925XbAOPWosvUiCtwifoRaoPe2CUpMZ3o55fEJiA6jvRx/6n1ZALambDglkRGPdsZoNJbTIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721881000; c=relaxed/simple;
	bh=ZzH0VgSdYutk/uKY2omj651o9v+E5HP1BijtgXJzAp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IYNCDe340BahZ4FFePeNMt4ezF33jPLn1iLF7q81kaV/0bkrjQ8eGSYbZ8ZVuQyPCOnjXlljIXoHorxuh2eEtR8Ve0IAB/Sn9pzvrBkyl9PZpmRSd9FAKEn0qG8FcBFLUdjMhlBRlgE3NC9yzI2eesnKptdqM8ztvC121h9dnU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wcizV7ej; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc56fd4de1so3681995ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 21:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721880997; x=1722485797; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWtR9ZjYZiSKNZtqnpkUxp+qNZzbKrCzo+6HVfyCbsc=;
        b=wcizV7ejFGdOZcg81jAqZQksyk8bCATs9pdWMVWTjz/XXJBm4Sybv9BL3E3weElgp7
         2cO29U4D7crsVoYoRH5tCkkjUV6WMDZC7dYOfoa6Jn18p2+fVlG8nQyE1D0IHwbFHS+F
         1FLpH7jgxya95jhglXvWaLaNkArwH/0S6Eb9CKlv57pJuXy+yxp1WXYXpK9ZNIKO8V4b
         0U2yasLm331AWwLGkTr0DnUr2Kh83I/EcQBTagg3aL9VF3O+DcGlNJwAEtZwKOEaciaM
         3nmiV9QsV2lbI7+W3YbTc3rtbPDZyHiwVR4tKYX/D1XuJWnxO8x0noCfI5qjhfkDumtH
         QjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721880997; x=1722485797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWtR9ZjYZiSKNZtqnpkUxp+qNZzbKrCzo+6HVfyCbsc=;
        b=G3qS8EwyyhjoWnueUQ8qTWNhQbc9dDVO0mceIQTw7Xmgiew9dtn59pp69uyLzWmV8r
         NLw7BCnEWQlwffGcc3VtMm6+4dRmZ2ye4uWnPIYT0qY0NOkbi3Pn9+WYfSttdtcnfwEA
         WvUZAjGaRcoxhBsoK2UrCrFTVGt9R8oyOPoKZJoEQ22Quxnf80oLQcl7CuZ1uIgKLe9A
         fG93c8/cJ0VzVTaUn0CoByGcxqTX5j6aY5wAE7Z8BcsbWEDie1smJEsQuo7mJ0zkchT5
         M4Hpc2QkuOZ3ixyXXxnGLOsjENhcKUi4y3TCRGDv1Ibij2sb8A3rQfWvTMTcEmpXqWci
         biNg==
X-Forwarded-Encrypted: i=1; AJvYcCX+EC1zV82CBjdhmLmJBX7XIWgxOKe8H2OG3qqAwwbYhLuStklauR9DhN/NWZSID36U8SjPUmuMm73C0bwOL+9I9Ob364hVvPhJMvmMn7QS
X-Gm-Message-State: AOJu0YxOB3WjCEaMaoYQnm1VJnPGS2GJbAX3JD/3DiM96cE2tA61Jx5x
	/b4UMSC1MSL5eRbq3GkPIhYl3h4zYc3VO/M7DxBEtcQEWNR5WSlknDSvJAFZckc=
X-Google-Smtp-Source: AGHT+IHmvAI6Lep3+L+mKA+XJ6/VVS15lPSV2gXaJChB8H2XYNeKkgK+h5Qmr039zy2zDD7IhrItxA==
X-Received: by 2002:a17:903:2308:b0:1fb:9b91:d7d9 with SMTP id d9443c01a7336-1fed2854b27mr28870745ad.26.1721880997435;
        Wed, 24 Jul 2024 21:16:37 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f2b80bsm3781825ad.205.2024.07.24.21.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:16:36 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jul 2024 21:16:18 -0700
Subject: [PATCH v8 01/13] dt-bindings: riscv: Add xtheadvector ISA
 extension description
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-xtheadvector-v8-1-cf043168e137@rivosinc.com>
References: <20240724-xtheadvector-v8-0-cf043168e137@rivosinc.com>
In-Reply-To: <20240724-xtheadvector-v8-0-cf043168e137@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721880992; l=1788;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=ZzH0VgSdYutk/uKY2omj651o9v+E5HP1BijtgXJzAp0=;
 b=1I8Xg3/phceAD3Z3MPvasZ4C+zAtCdGw1Jhx6djj1GpdJCKExpkFIElu4U3Bar1KmQK6zz0fs
 H3tRahcXl4fAVPHfGejeNs1S+lB2PB2wyAthiWw+z2v42ttNPMIORxN
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
index a06dbc6b4928..1a3d01aedde6 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -556,6 +556,10 @@ properties:
             latency, as ratified in commit 56ed795 ("Update
             riscv-crypto-spec-vector.adoc") of riscv-crypto.
 
+        # vendor extensions, each extension sorted alphanumerically under the
+        # vendor they belong to. Vendors are sorted alphanumerically as well.
+
+        # Andes
         - const: xandespmu
           description:
             The Andes Technology performance monitor extension for counter overflow
@@ -563,6 +567,12 @@ properties:
             Registers in the AX45MP datasheet.
             https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
 
+        # T-HEAD
+        - const: xtheadvector
+          description:
+            The T-HEAD specific 0.7.1 vector implementation as written in
+            https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc.
+
     allOf:
       # Zcb depends on Zca
       - if:

-- 
2.44.0


