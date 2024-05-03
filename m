Return-Path: <linux-kselftest+bounces-9410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A04D78BB2E2
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 20:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560552812B0
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 18:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA92F15AAD4;
	Fri,  3 May 2024 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jJHqYC8a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF0215B0E0
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760347; cv=none; b=aHnku74yAsVymOUzlPzrpBHoyTgegaAzQvKqY484dOEVA+JuW+z3QlMnNhLHxETCTGN7TdHFBcjWi5LOVnLcGlXB16woLyDx4iXRvXDWe5PtuFgh8JQNBFvvhvgqTLPxTHd+NWQBW6DTaZKttfZF2i7R79iRR62LtiKxICS/m6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760347; c=relaxed/simple;
	bh=hSZDQKNr3tkZT93AWiF+tJx7RzaJfBNyv2pzte748aU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GqcDJ5jHkXTrXjzN/zy/iYXy6PgarCsqlxJH8iDisjB83OT7ksEmDPPE6VHg1tPDot/u4WixKJJfulcX3/9MuryIJcrNCCVbXo8ec4+BbLg8EYorSBoUe/UOb56/UGVf/SoRxid3ajlABYV9gs45dxfXIlVBhEZSYxMtt0YBFHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jJHqYC8a; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so5768279a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 11:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714760345; x=1715365145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2nk2JCBk+l9WgkXKFxu/w/itsXmN0i69JJANxOESAA=;
        b=jJHqYC8a8Z/aHHaypGbwngXomZM2eHlfWN5ZY3muD3nWxOm0ziJpnnS2jFoDIKszv4
         NLiYGc4gQ72S5559ZdKicICBefVzQcoYs9Iz4ugOK0n7AxahjqSQkLBu30+X4si45Z0p
         FdsMEetj6W/ooZ4LnHDFsiu6cUEJ0n65Ze6CzcLqvYJmkfcEFQ9rBX0m5EjDd+p7ri2B
         ZYgnjwPGKj4fP2gDN1O2k5eGVT+8La8FLvr8fbNfiraXnZUN4rkvYTUPD5Q3AvMx43GJ
         niql8G2aKgba9G3DTvugtf5540vjVcGsTxB1JAtn9j3O5kX3k1ostdROJocC3HH7az1e
         FL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714760345; x=1715365145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2nk2JCBk+l9WgkXKFxu/w/itsXmN0i69JJANxOESAA=;
        b=fn457HSgS7S0ldV7mqNH25mAKiFrZC0A48LwaIQYlWVKhn1/34HKyfbua3ewuY8i46
         7SOzVUvlEVRdYHj6tjyMBmWZCU0mkvcyCGOpu1OBmDyMYrUsUQkhN9STfJ7gNUH4MZQC
         uGw/DzLK0W2B/QcsoTbtLmYvuanHlh9mu8+39aB4I5NOVexoBl/xznAMdY4n45HomFwV
         m6UqeiG5gEYUCkheyz5wKMcsjBtbIKYUcFfPDtwVLL4EocEbsCqsJ8lNtPoq20bLscKQ
         NWujAk1JF0jL9kiisoc1No0N+rJ74gStereNHeWvaBbfRUpthtpI8qZllIaqx7qkHeg1
         ceoA==
X-Forwarded-Encrypted: i=1; AJvYcCXynjh/1RiU3dd07QRl9r2rPvtfahlAQJoYCivBwxXQMaBvRzzM5mzxCWrqNHyqQW01LakbZRTGO4UKYTmTkl9xGo+DhEFCqAGWbIc568GW
X-Gm-Message-State: AOJu0YyAJzKLwPZnn2zrhGbGPisbbkbmnHHGX3fVNeFIjQ+Yc6pg4xKR
	lL0T5ykFoYKTYjy+omGiGRHdE8HN3K1YSJ7hcQQKtcUUebyHm2WzHsJhJwXlW9E=
X-Google-Smtp-Source: AGHT+IEECXDZSf9I/4Q4n/a/t5WUm0gDjrNDmbYOkTcO7Anz+US34Ny/ZTMIDCzrSKUNOSSeVGrVKQ==
X-Received: by 2002:a05:6a21:4847:b0:1af:41d1:7334 with SMTP id au7-20020a056a21484700b001af41d17334mr3513429pzc.27.1714760345646;
        Fri, 03 May 2024 11:19:05 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id fu6-20020a056a00610600b006f3f5d3595fsm3355421pfb.80.2024.05.03.11.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:19:05 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 03 May 2024 11:18:26 -0700
Subject: [PATCH v6 11/17] riscv: csr: Add CSR encodings for
 VCSR_VXRM/VCSR_VXSAT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-dev-charlie-support_thead_vector_6_9-v6-11-cb7624e65d82@rivosinc.com>
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
In-Reply-To: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714760319; l=706;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=hSZDQKNr3tkZT93AWiF+tJx7RzaJfBNyv2pzte748aU=;
 b=jO0upAGaW4yuaVS+QlmhSO1SYHS4tq4RK3E0NqLTsJFEwtmVkVPPV6aSesGjkRDdJkKI3AOlD
 MqQ3qvdB+I6CCD8RbUq5POKhniZRS/torEK3drvyLlOJzCwBIrIBFcL
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The VXRM vector csr for xtheadvector has an encoding of 0xa and VXSAT
has an encoding of 0x9.

Co-developed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 13bc99c995d1..e5a35efd56e0 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -219,6 +219,8 @@
 #define VCSR_VXRM_MASK			3
 #define VCSR_VXRM_SHIFT			1
 #define VCSR_VXSAT_MASK			1
+#define VCSR_VXSAT			0x9
+#define VCSR_VXRM			0xa
 
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00

-- 
2.44.0


