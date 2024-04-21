Return-Path: <linux-kselftest+bounces-8567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D888ABDF4
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 03:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA941F22412
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 01:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3808A6FC6;
	Sun, 21 Apr 2024 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RY4mbmPN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F898F58
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Apr 2024 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713661494; cv=none; b=nDv9P+Q0TOZsYQzh+CnTJnV6/SBqLsedGitZwlXUA/8MHuWDjp6evi8a+kpG+4RGAUwsGLv2VRVvatAg8c+o6+hZHTxvbTW7MKFOq3g5qlMeiRB8XJ/YmEPhUXAEvTHgVYQHmlLYRF4GSiitT/5ZT+YdblwkGj8PsLqfPoz4zY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713661494; c=relaxed/simple;
	bh=PDP+pfWfSCvmvZn17Dj5qqvNgRLWprJakVgT4fj7WMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Odhu9voypHXSz+tgsxpQBKBTS8EV3XrVXVxFHPSVKlik962szsJuLo9dd9zilNw09wI6wW4YGRDXul7stJy9J7lI23cnUxd4kHQUvrmh4bHB+Lbp7f2HTGH4wkOaOw5QyX/b2XN9rByBzhw9A/SyqmUrQIXn49O6YQMAiI98+x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RY4mbmPN; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c70ef25e19so1614102b6e.3
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Apr 2024 18:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713661490; x=1714266290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VjeHR1eFFL9Gvz01+9XywijwOrTXSU/mr8HqBxiNzQ=;
        b=RY4mbmPNbxicCOfB9TEmLevjkM8GxiU+3jiyF3jEoMdfunqFIgk9GiRCwOM6OAGTD/
         GIefpl2QPUbVKBpRcr7CmH/3HKvZiLkQV6jVeo5NtBy114SmkUKffc9o7Hc78EMFsTem
         FQySWJNhrQiMu2nSAZrPesFvmlUdzwd229nwbss2l2aiTfLhkqDqewlQTka7ErgIXHdp
         QJxRnKkqH+8pA1RoS0tLHjQ4AhxKSF3noqDbseSKUBrXOjf3+U/ANPZxubg8HX8bQMWJ
         h/hsuNZlNirL3b5MznKZ/23SUv8V7PbgZrFGHIMlRbNPUBGvR9qw05Yg0QGdOwuIjLgr
         JHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713661490; x=1714266290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VjeHR1eFFL9Gvz01+9XywijwOrTXSU/mr8HqBxiNzQ=;
        b=qaLtpUU1BZWT/PWsTe19uXVkNKMAN3+R45c4bdMuc1fhI0iVQYlMbTnIKKCwQB/gdB
         v2z8CIxEZKSITALJ7dWVFjj8W9MEFoLIYwTjBFlKOkpMHl401/MS4B0xRwimupyC+h5b
         TMfuCRcJaXtfbWWlBObAJWW6vP9lzIJ5MeUnH3KHi30b6KLG25T9NX1W4YupYo8Saa/J
         0iOSWAFeRPYRSzsBsgGgCCsNwhIV1V+TZugCA8s9v+aCvqsdwmtQapOv1bZxoqFxscjr
         F/AdJPEPOegLrYVDAXsyA1FmyRWKv/f8ViIqzMVTjqG8zchr8DkqT6MYKehOL0Nh0Jc0
         d0EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkHfz9yWCkNvWGzByf+blQf5J+hpy7PWrPOLSG0GXCT2jL3t2raFQp7gVGbSDpC3FypurrG3kAsmr2tkKtt4uVAC5GP5ptNXX6yIhxctWt
X-Gm-Message-State: AOJu0Yzs2hAvFjTwTnmoJ/dcHiGxU9pds2sfaa176yz78oxQhFyogUma
	ZIqydXHFivoAQduODfowH4Egs/MeF3FfneFF1X3NPYwsoDWKMJxUH7vbvxbGAzI=
X-Google-Smtp-Source: AGHT+IHgwgu86RqEqJ440zaOibq3z3LImfEw+LLCOmkiUs5NeZODsGrPDbBsx/BKGgl/AQfbTefjSQ==
X-Received: by 2002:aca:d08:0:b0:3c7:4eff:f5a6 with SMTP id 8-20020aca0d08000000b003c74efff5a6mr5012320oin.36.1713661490626;
        Sat, 20 Apr 2024 18:04:50 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d6-20020a63d646000000b005dc8702f0a9sm5249627pgj.1.2024.04.20.18.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 18:04:49 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Sat, 20 Apr 2024 18:04:35 -0700
Subject: [PATCH v3 03/17] dt-bindings: riscv: cpus: add a vlen register
 length property
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-dev-charlie-support_thead_vector_6_9-v3-3-67cff4271d1d@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713661481; l=1443;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=heJ5mXr7Tx2wdFjG631ibJba5Q6SNbmXVyEpdKm9JEg=;
 b=YEjxKtbY5d7XiWDTiqBxcSBLOYectVNJpbMqu5/jHCbEbZ5l1wJ+MUDVVz1YIIJGA01BgcnNg
 0HMrxLA6DorDn5h4tdh5RWRkwuoRsB+sKvNkmlQQwt6LlqImE4+EPn2
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


