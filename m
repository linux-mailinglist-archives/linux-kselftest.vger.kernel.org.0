Return-Path: <linux-kselftest+bounces-9403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BB68BB2C4
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 20:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F07B22223
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 18:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C75415956C;
	Fri,  3 May 2024 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Dl14eVK5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABDF159219
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760332; cv=none; b=g17WCDG5NxA2LkMzQU70Xbjf1/EEhHAW7rSxaJTjGdklY2Tod13GsxhNRCCnykGyh9yqzTU/afhRSNCBBbp0lZEy3jQYopNXFmdEe+8Dw4p8052ligl6kz5y6iqjrY6gsrS9YAxQZXJX6fxrhg960bUmJw1NTYGQQF5W0YNipDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760332; c=relaxed/simple;
	bh=eg5f+2eUdPorsjTg1AXnvbZp1Gz8QKwXU/sn4bArQ/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tw+vrEE5HtmQVl9M+cdf2kBtuJN3yI0yMnnHtbSWyWKvCH0Hf8bupFvluFOSpjeIckAA+q40iC06STYlIWlD5oLBaQEoY4UICx731UhntE8lU2OA/7YVV+vUeYIx5/Qtw1YRzZcBIt/WhpqCsiqaLdtOt7P4orEF8Qwf295mtJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Dl14eVK5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f44bcbaae7so1989b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 11:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714760330; x=1715365130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xb9tww82u8GPwb/D9ZGp2c9YRfA1MZ53TtnEydxWwQE=;
        b=Dl14eVK5AOK/YGsz54ifFptcjgJkFJBSUGLdx03++zyRnNlH4V6sQ/qMuyKzhdTVXI
         nr/0nIWfEVsMcV9v5EJYYyk/xkNrMkXilCv5WlyDma9/qil4dQGfNkfKJ8XdujI/vYcv
         0HljhaIYlrebrF9FGWNGmYGEKc2sMqM3bYQFM95uxe/jf+Nq7jJvu1Us3q/sS+vyCpVr
         +vfT0wDDym3MLUstGZLqkBhXsCUmpFLTMeHK6LU8fd8UuYh39GUuuhG+49DlN5FkaQM/
         9jSasoahDRPyqm7fwIjN4o8vTvZB0Ft2mLJLN+N4YA60Jlhcv/y+qwKETkcCoSqMkDgV
         ibmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714760330; x=1715365130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xb9tww82u8GPwb/D9ZGp2c9YRfA1MZ53TtnEydxWwQE=;
        b=VVnogBVnJytaPXIdCXvhBnovWmfafmBzXpRvVGwWS46HftarEETHvEaajbPc1X6Wna
         4c+0V47YnmtmGO0uDNdD41Bj17LjgjBeeIWLxMaS0jm2kXuFIYCf3vpAixTmv7SoW6nT
         uiI3N7ZlWKOcguMrKZd+0h/Wtuef8C4MwA+EhrlVVBHWc3N7OTEbKrE//I2AyVlPqiPM
         8arCwbgRpqCBaCJy5wqVpeMYtlN8mmvGbAB79T8Vz+NYIlinsQJXvKMJ2UBDLdRqccxh
         5/eGNpJbW+56gQQFfYo3cfqMaDKTn941BCBJlqE8KchfWUhL2k5/8KaAGapL7y8TLaaw
         0uyw==
X-Forwarded-Encrypted: i=1; AJvYcCV7VQzuAsO5/LdHAxkvBdiu0FMn5zkHYmWr7ViZsmisa6Unia/rWK2vR+Q9lq5vvn1zefDwU3tS8ULKTYPENB393hR3sb74fntU2CsDiJLU
X-Gm-Message-State: AOJu0Yxoobv5XJUrZAfyJXEZR+M7QSvW5jCmtu3Engaw/miST4J0aGo1
	VOt5qX711cJyLCbl9T05rRh1FqoamYRPqpNdCOD3zmt9vP77IXGulHVRhbC0vLs=
X-Google-Smtp-Source: AGHT+IFy7bjwb5Tc2k3ELswk0ckQlxflBBtAMpFeTTm74dAZvij2X2R0LCw+XDzJCWrMJUDPuSACWA==
X-Received: by 2002:a05:6a20:f393:b0:1a7:4b40:96db with SMTP id qr19-20020a056a20f39300b001a74b4096dbmr3340804pzb.10.1714760330034;
        Fri, 03 May 2024 11:18:50 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id fu6-20020a056a00610600b006f3f5d3595fsm3355421pfb.80.2024.05.03.11.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:18:49 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 03 May 2024 11:18:19 -0700
Subject: [PATCH v6 04/17] riscv: dts: allwinner: Add xtheadvector to the
 D1/D1s devicetree
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-dev-charlie-support_thead_vector_6_9-v6-4-cb7624e65d82@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714760318; l=904;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=eg5f+2eUdPorsjTg1AXnvbZp1Gz8QKwXU/sn4bArQ/o=;
 b=6g1xI1qEsC25DUPbbFpRsxXutxb45Sm732q6PItZvN9xNDcps0BAvC/bY1rPUIPcJI36yR/lz
 CNxoaMn0OIdCbC6bJdMpDz6ehBx1GiDP/MZbJJlSKdQjCj7lyJtPXxb
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The D1/D1s SoCs support xtheadvector so it can be included in the
devicetree. Also include vlenb for the cpu.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
index 64c3c2e6cbe0..50c9f4ec8a7f 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
@@ -27,7 +27,8 @@ cpu0: cpu@0 {
 			riscv,isa = "rv64imafdc";
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
-					       "zifencei", "zihpm";
+					       "zifencei", "zihpm", "xtheadvector";
+			riscv,vlenb = <128>;
 			#cooling-cells = <2>;
 
 			cpu0_intc: interrupt-controller {

-- 
2.44.0


