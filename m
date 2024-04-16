Return-Path: <linux-kselftest+bounces-8076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 862548A6219
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 06:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AEDA1F23B13
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 04:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0DB3BBE0;
	Tue, 16 Apr 2024 04:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YncWKge2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA502CCB4
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 04:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713240729; cv=none; b=SZJdogEZ3RXpIhOAesQk67baTQVZd4orqutZleCDfKCjln6sswotsQWSZvEhimvuGebCC+9YQz+gjwWV8wnELxKRQPY09zw1GkM5njWHYw9OQVMjxQx1i0xG3wpklJRucRlakOMoeTq5lRdqhHDKfdTmx1vm+wfzGk4U4okAVRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713240729; c=relaxed/simple;
	bh=xhhAyhCeh9v1HfzcYB9jMdx24aaf/W++T5TjP1BYwrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lXpfLKBI7RY2ZOITVE0UuBjMMyQkJFMf1SgSQSOY60CM8vVj8X0s2UfIaoPiKf20w3I76L51mHoHTQHMDEYJ7TlKd4bS9mwmORN4aPPHrS8SOEn1+IbbVfogknEPbBRsmAQyUBYZZKIPrDPjnRogC5BeMgUP956zOmWxJf7V7S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YncWKge2; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ed054f282aso2839754b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 21:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713240726; x=1713845526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XjIfhSwfHRsBz5u/Ep3mPORR8rWAcMP+i2i3CrSSnGM=;
        b=YncWKge2pZUFHcofScLdpIr6oDJtIUQY3JDSuYwHX2P8sWyeheFwgUNQ3DncUXZCm2
         uvV0yepYginqxp1N4MZGp8bMh238OgoYhx/zSI7A05WDsqfVT3brnZ3DrbrFBIZ+VaDl
         cc15QPI1vCaPHD+76BT2Qjo/Lf3S7JlUpHoy7noKhyVbMH484nxwSYSmfuy6yBKgp/lk
         rNwxw52mszGetkn7B2d6SMpjrjqL57PPHvJoZKxqtm2TQpTjpbgqZX4IMJIeVCdT0Btk
         wDNVg7ymv/q1kI1D/y/QbiGNterqj1WtmxpUlH7pfRjJbcWwRdou1irJUgu1WvJqVU+u
         leTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713240726; x=1713845526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjIfhSwfHRsBz5u/Ep3mPORR8rWAcMP+i2i3CrSSnGM=;
        b=vJOnY01th2RP1X0acsqlnkdSP4NI/gKAmygKapVWNDmVJPbcStu+KQ1yQDrrvtUGqC
         JSyl3oIWF1JsiDr/yrxOYIbHW4J1TLdrHzjXHXg2xAMteKB3Mxw53iP1fsruuaRBCeC6
         6AOLo6zmZA+8t4czxOlmrRaRjnow9euMucKcuLc5FjBkcNdDnJNMwr7TBXr+gZPGLkz1
         anSxiszs7HI2TgzRa0XzwH8vXD8MGyN5RBfwEKfW2eVn7hm5V1sSzmdewLVS8Wn8mi/p
         fdpeLZ75ljCXhFIUen5ZqAjm7oMl7Jkl7EL5XHCll6j62saLFiGp+SA2/33IZ0sPne2I
         nvhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG3++5EPrSpTsFZe4arXpnCP2kZhfqwsdc3WA525Zf3BSErGoxctyZp9dBk8/ga1ku2UE51qMgAqPOV6jjKxS5eFBC1hmt4ut48vXLosu4
X-Gm-Message-State: AOJu0Yy3K2XuKoHGW8Ti2ImRzfnykk2fo51mdjez8h+ed2zgqTezXwbq
	1aWM0/iLp3Q1rM+/TVTFmlxXcptePaFTB8mfZdogq2/3wK3Ibfu2+rUybaUosgQ=
X-Google-Smtp-Source: AGHT+IHqn1sXVcftAPsCJ2CrFDVdXhwbs04p0T4oizHCkE9P+rU0lpKddKp7fef8NYT2WVJ7agaZUA==
X-Received: by 2002:a05:6a00:1955:b0:6ed:de6f:d72f with SMTP id s21-20020a056a00195500b006edde6fd72fmr13091989pfk.20.1713240726023;
        Mon, 15 Apr 2024 21:12:06 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id z184-20020a6265c1000000b006ed4c430acesm8383149pfb.40.2024.04.15.21.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 21:12:05 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 15 Apr 2024 21:12:00 -0700
Subject: [PATCH v2 03/17] dt-bindings: riscv: Add vendorid
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-dev-charlie-support_thead_vector_6_9-v2-3-c7d68c603268@rivosinc.com>
References: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
In-Reply-To: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713240719; l=1073;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=xhhAyhCeh9v1HfzcYB9jMdx24aaf/W++T5TjP1BYwrM=;
 b=9ADEOjEKpNqNT1uwJT37rRw3/i4KOWKzh4dKPxd8bccq49fjrEN1MfFYxs+5aLex6kyTKifm2
 4sY6qIIN0aoD5yumAyImnKAJ7dRaK2lAGGwoME32kwjE2loQhyDKO9j
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

vendorid are required during DT parsing to determine known hardware
capabilities. This parsing happens before the whole system has booted,
so only the boot hart is online and able to report the value of its
vendorid.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d87dd50f1a4b..030c7697d3b7 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -94,6 +94,11 @@ properties:
     description:
       The blocksize in bytes for the Zicboz cache operations.
 
+  riscv,vendorid:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description:
+      Same value as the mvendorid CSR.
+
   # RISC-V has multiple properties for cache op block sizes as the sizes
   # differ between individual CBO extensions
   cache-op-block-size: false

-- 
2.44.0


