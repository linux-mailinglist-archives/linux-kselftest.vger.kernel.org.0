Return-Path: <linux-kselftest+bounces-13111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E72925342
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 07:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F252286A27
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 05:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47032136660;
	Wed,  3 Jul 2024 05:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZD6LEGZ6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6401311B5
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Jul 2024 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719986225; cv=none; b=Z/dF3JyPLdMVn21ShwaCEZX5J0WTf5W8rwt7g9qmi3xYIBOBSVqSx3B1F3W22sOA7zPsx5a4Mmd++6L3aYwgz7aJKvSr+HSNvdFXq7uWJEKEGpEuID/SewYy84ZI3pI5KPeWcHrx45u9Qc8fH5l9ggCJC6eSaOLbaMG049+28Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719986225; c=relaxed/simple;
	bh=I9BB6+DSsEot7edtm0hreUvYP0RvytEdbSv790C0uE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S002mQKsHBnl87F+nDhPdSMTyOLWCbCrwDLBZtb6LmLv5rEMG8x4l1MccUomlYkgJLsxo1WhHyvB2ZKd7QPXK7vWbkepkUgw/1wZVnEtxHGVHdO7hrMsgMB24A6sw/6KiX+yIDISx6dVYsQ8YxicZ1ucfssEFd7kXmxnZf3znRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZD6LEGZ6; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70aaab1cb72so3395966b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jul 2024 22:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719986222; x=1720591022; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0g1DxVy9Ij2OMsYu7oTE9l+cI+PV2f969LKgw+PL+a8=;
        b=ZD6LEGZ6LowXMLtfTIo6WxK1atddI23NXXMMTCiYBq41g/l3wCss8RKG8x7u9s86t9
         82cQ/pQjQEmgtYoc8LWAQ+4Rp1RHA0bT79jTqxw5qQ0/ikt8qKA+WWOLZE3qZfD+YHie
         HqjTIvrH1gTlX5X4+aL2eAl50cbkzV1elP4ZJRvOLUg9K4/+f8c0ihb5wFU2atAfIQ/A
         nPKvwHhz7z1feZq7BkvKZH2MluR3xv1iPJSK/qFeolErr7RVvI7YgwQhBR6eXr1pcRCY
         zXqbF+axKvG3iNvtDOLhyL0Xjz9E08l+WVnSV5FbLVcqzumrqyo6WC2n/+n1wD899aER
         LujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719986222; x=1720591022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0g1DxVy9Ij2OMsYu7oTE9l+cI+PV2f969LKgw+PL+a8=;
        b=O++6icf01mj4Rhar0Bn2ZiZWHMffULkFYRPj2r0waHXqwpqMswcUUbjuPsd7P+6dJ+
         wN+HjVzDfC8rM9EEUeG2YTPwP/mdSnHlOMgvuMWlA00atZDp6E2KEbGNP7/TlTYsejUI
         15UsI+X5XThy/NTN3EB8wJqc7Xx+XK5hs4xjiIPtomI3aGWAqUBCXSsgi3MOmHRqMO74
         cUyVzzH7pKoVl9nPIrZCfjZrFOT9Yrjv5NTtnSbK1hBZb5dsTrS2vTLFyEqBEXB9BurI
         Sqw8WODIDQNdu16yJPZ9MG8ydR5w7r8+2AOK5X5lU0wlYN/1SyS9m25W/HN12lf2Zz0U
         VdRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa1eagVzY1MR3TyWNGo9t54cN65rIU7CrurH1r/pljl/g3+pTTAQi4qeQGdO+jNS1RGDGZ1CBT8IyNo9640WoT/V4PZQRbn58LASf0C4Vr
X-Gm-Message-State: AOJu0YwjCJX6Q5HixfTwc3t4BQy4wis8cLXyDe1tEzfxEFgBKh8PHh5G
	0QeqA25F0CfAeHvjhy8CA3vZ+zEIxbhZWfdExUYtZoP9P/1Xziz/vvEfoRj1rAQ=
X-Google-Smtp-Source: AGHT+IFz2hW7EMifawOpqM4AiD3kcAclIq6iiztRCK1L3Y4b6IKCzpZ5P6BWyV3Fbxcd9CTq6SCKYA==
X-Received: by 2002:a05:6a00:21ce:b0:706:6af8:e08a with SMTP id d2e1a72fcca58-70aaad2acc7mr15442207b3a.2.1719986222055;
        Tue, 02 Jul 2024 22:57:02 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a89fc9sm9514103b3a.212.2024.07.02.22.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 22:57:01 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 02 Jul 2024 22:56:23 -0700
Subject: [PATCH v4 03/13] riscv: dts: allwinner: Add xtheadvector to the
 D1/D1s devicetree
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-xtheadvector-v4-3-2bad6820db11@rivosinc.com>
References: <20240702-xtheadvector-v4-0-2bad6820db11@rivosinc.com>
In-Reply-To: <20240702-xtheadvector-v4-0-2bad6820db11@rivosinc.com>
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
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719986213; l=960;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=I9BB6+DSsEot7edtm0hreUvYP0RvytEdbSv790C0uE4=;
 b=H8CrljGzUjIOOabCLiAC2ZNGpp0HazfmCxEDWU83VroeOYA6cw7Q1KvMeHXN76EX2cHtVbITP
 JsrlM5MIuFpBDrF5FfDU16a3EB1Ky1H5hrSQoekvqfQ6XWHptRHd8+b
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The D1/D1s SoCs support xtheadvector so it can be included in the
devicetree. Also include vlenb for the cpu.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
index 64c3c2e6cbe0..6367112e614a 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
@@ -27,7 +27,8 @@ cpu0: cpu@0 {
 			riscv,isa = "rv64imafdc";
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
-					       "zifencei", "zihpm";
+					       "zifencei", "zihpm", "xtheadvector";
+			thead,vlenb = <128>;
 			#cooling-cells = <2>;
 
 			cpu0_intc: interrupt-controller {

-- 
2.44.0


