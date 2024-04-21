Return-Path: <linux-kselftest+bounces-8579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599BD8ABE23
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 03:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F4D280D6F
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 01:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8CC335BC;
	Sun, 21 Apr 2024 01:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Qaoirv+1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF729CE7
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Apr 2024 01:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713661518; cv=none; b=AmgRNgZ/0oAXJGPtGwibIog8RzbIbAj73N3eOeNQQ0PVbxCbNIUrLoPhTy6qavfn6e570f6myywjxNpY7iFkB3P07fnSPcscYkxu9oEwazBmQ/Nha8QpRVKJ37II7/CUt8ikzAdKCRS/8obd/+VRrFGKyihMDM3DW6I2yD28UfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713661518; c=relaxed/simple;
	bh=SMnAf1KoXdr3XQZFYlKGicPpJwlvTYKEN0qx5DZFIIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cn73JOcsrHNSV3h6nLGWTH96IKayIyjq+Sow0Msodi79uQjIogl988I13ml/NDVLKEerhyGmdZnRH+rTwROQwPefCCTttS5OfwhN5M3Tadk1vPo7HUgY4jB2h63phjIgPRHQLNJOBIr4uexcEvc1C9NFemqGOPtLcDCFDXvWq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Qaoirv+1; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ea2375d8d0so2762469a34.0
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Apr 2024 18:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713661516; x=1714266316; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C51oJZVlVAvKgqHOYlTKvkb9Lst4yR5a6EpKYVrVIWQ=;
        b=Qaoirv+1wECDb8LbgNRUMlkffenbr5bcw/XxpYNq3yBQRgOwpwWnrFu6YXqhZqLN3F
         skS+CfGWi0owMjvpkL/APN5senqzc97QZt+eRFTKgBT8WxohT9gvLnSSsEmgwKqsUkA/
         8mCRFF3mEvfn00e1yY34NxBeJ3tP6/oVfqkf/veWcrJlctOhrYYRhxKNe/Nvx+xNYmCp
         uPLf477Z2dxboqzizYwfOE0lS3N4Oz/tWwA86eKTMpSDebefAl6JCGdrhaq7HXF7qfA+
         YnWYzfWDyIloMwya8ynd5JWLCDTL9TA17MEhDWw/Gui0nPhyaz3A7zqYAwhd03oy8Hqj
         ZCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713661516; x=1714266316;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C51oJZVlVAvKgqHOYlTKvkb9Lst4yR5a6EpKYVrVIWQ=;
        b=ltevZdJgRz2yr/HF4NbsUt+7FjqOFlCgcEJCfdfQeaeoOINhEhI0F+EP4VEFG0nQRt
         Kl9NiHS0jszHiqk2+t5+5MaOZuayXRqXSxJV/cUHbeQYf03t7u4Jsq5DQf9lU9DBidqu
         WVz3/07x92bBZymVmPOTlXp+Xs1cVaCS9j6gmXA81x7pnYwVH3Y4YMjy+OoHlPbBzQkS
         pqWqe1TYDxS/khQw3+3R/W3MfaBG2L5I6+V4EGAjh49LCkzqP6c4zORLq+6K62dUUW8Y
         aOnGRG3RYR/sWuvoojgCdcTYUsYgsnnP35ba/fDbRDTBErRGwpxlNtdDLHDWhDRvqf4X
         uVYA==
X-Forwarded-Encrypted: i=1; AJvYcCVuSkmP2Tx9Coz7rZrPkPtQ+1r1KrJDy6zxyrwbtnfIK9nDrgWZ3EVghQ20s+XVBZ+udUG1hjemsUodUjzJUAkPRRIshzyLMeC+jr1PyVdX
X-Gm-Message-State: AOJu0Yy00VYAsiIFE3tQPnYx+gVZyNU7XvJrb3KerRCRdOfOlJD2KpSS
	n+St7MMdAxDL2e01ebkIJqv1+yvF4TdXxOgv2Zick6/FyFR3xDMcodWQBY8ggW4=
X-Google-Smtp-Source: AGHT+IENYknI+Zklhvw1/6eWC1GH0JmKeh/I0kIxdoG8bvXxlMe6ywbK9ABjZzu5BfvNmYbkvyzc5Q==
X-Received: by 2002:a9d:6454:0:b0:6eb:8435:6d with SMTP id m20-20020a9d6454000000b006eb8435006dmr6447023otl.16.1713661516086;
        Sat, 20 Apr 2024 18:05:16 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d6-20020a63d646000000b005dc8702f0a9sm5249627pgj.1.2024.04.20.18.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 18:05:15 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Sat, 20 Apr 2024 18:04:47 -0700
Subject: [PATCH v3 15/17] riscv: hwprobe: Document thead vendor extensions
 and xtheadvector extension
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-dev-charlie-support_thead_vector_6_9-v3-15-67cff4271d1d@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713661481; l=1205;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=SMnAf1KoXdr3XQZFYlKGicPpJwlvTYKEN0qx5DZFIIk=;
 b=Sr+Ck23MK6b5fBCWQnfAjC3XDtevTk9/L5rpG6sRcM1JIsKOpPpV6wfWEpjZQrv34owaXjk+c
 T8zyReFWWSJDaCUDm2n9ubLbo5SiTO69cKWy2i/xPXXXBX1kkoWi79W
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Document support for thead vendor extensions using the key
RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 and xtheadvector extension using the key
RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index b2bcc9eed9aa..b2bb305140aa 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -210,3 +210,13 @@ The following keys are defined:
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
+
+* :c:macro:`RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0`: A bitmask containing the
+  thead vendor extensions that are compatible with the
+  :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`: base system behavior.
+
+  * T-HEAD
+
+    * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR`: The xtheadvector vendor
+        extension is supported in the T-Head ISA extensions spec starting from
+	commit a18c801634 ("Add T-Head VECTOR vendor extension. ").

-- 
2.44.0


