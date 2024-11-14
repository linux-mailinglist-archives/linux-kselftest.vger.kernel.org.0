Return-Path: <linux-kselftest+bounces-21989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F20B9C80A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 03:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 885C0B25646
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 02:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9DC1F7563;
	Thu, 14 Nov 2024 02:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jQG/azRQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1536B1F708C
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 02:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550915; cv=none; b=s9NJVY29GiuJ/Od6ufYTk44YwFJsbXLEnGCzDykw7hI3EfGygjhyL7OvdsAx3h8QEmDejX7qmGVZk/m6rl5+F4bAnlmir3r6nXKWeP7063ZwboVq7BWAC3WYO2Gz3YbNDRxMiB7jiWn2TYlKUlJX9smx7btUIzayuZlEBSDKo6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550915; c=relaxed/simple;
	bh=TcqhLbjZS94rab3lMFuoSS5guT4Dq12UlcROgKWQAqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QYVpMvtg9Uv8FAJBl+Q7H5IGbcxci1+q1IMslPeN/1L3MBJrTRrgr0n6xcRvFNh49u8lsbwMC5rDCCJHV5AFrOixakEHj45FPGTAXEAZE7r78SAFacNY4rFUSRSD8IUw9p8xyHPUnW2+qVG+kao15uXXBarMAgPqawjYD56o/vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jQG/azRQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c805a0753so792845ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 18:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731550913; x=1732155713; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqDTg1KZkB7odLaldwlsY3X0o5v8+LahAUJDMrZrWAI=;
        b=jQG/azRQxuZGSRUfuUThkCHrJERMaAGIyzXT1AXg/0VwpsvgVABrQIF90fACZhudVA
         Fu/uYx7TrwbAF0Hx1xVlvoTfp6ghSUJExEJfZiiHj0uq0pgzIgj8Vjj7P9NN7d4WWX50
         8QyF2mOtb0ApUGomgBMfQyR6CwVsAg3ikTR8utcZ/K+Mmdx7ltJ3rMBT0U86/qBahnjS
         vFnQBQKZE5eh5HZxp2NCYKVPLWZ0HWuvs4X2ARZZ/b48voq0wPEE6vy3EOLOqdh1Jd7Z
         5PazF13y37xE8/uCnOT59RInuwFfoyytyXB5s2j9UGTnO72KFpjVncDImGqcsxVjc4Jp
         eeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731550913; x=1732155713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqDTg1KZkB7odLaldwlsY3X0o5v8+LahAUJDMrZrWAI=;
        b=vsR2qicVo3PHHRwEbkJlED63bY+7GpeedZMc5oJ39j7/GluQIzotkBMUiD6GykcQRf
         vQfYK1JSWxOsg6pDEXgMZQUWY2gJ+1336nXJLF2O7btR8SHJ7acZHUQBbHFT7v388gwn
         sraAV01+mLaAWYxSk5etMef2n3eGcZtAujSQQuyfBKMFmrfXiR0ZLRF1g3WbGQUDOvXW
         gW4VKyEusqlL78WE15IFmgzEeaREToddJPJMqhu2q3AeRQ3Yw4j0694ILYvUtEFi42vV
         nUlH/SxYKhbjry3eobvmnOeGWigOq2sbowJeNV28H09rfXyJo5EKGAGw8TftaTKvRkTR
         qNPw==
X-Forwarded-Encrypted: i=1; AJvYcCXJbd4S5Ivzx9F/GvYkKIh/SYCWGpURELuAD6LWGmeU6QkNnUynsyG5qHHiWOT0ZQ0WBq6X+nE7ARrKnxTvKTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8todok+iVvjb2hM1TtENpk/ASBk/QB/g42lBoLh82bRStupy
	QB4Df9LqxL1pztVAe90ZTr9cI4rMDOqMfL7q2E5O+Tut7NPKcd0UmcpPm3DaAC0FnLfomBWpRDW
	V
X-Google-Smtp-Source: AGHT+IFm8P5gQRIsex2aGKwaijclDQhZLDLqCUSJxuaYbddepl2T/jxyWcTLByELALqocZS7LjJ4oA==
X-Received: by 2002:a17:903:110c:b0:211:6b37:7e66 with SMTP id d9443c01a7336-21183d1b72cmr310091305ad.17.1731550913319;
        Wed, 13 Nov 2024 18:21:53 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c499c9sm406875ad.68.2024.11.13.18.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 18:21:52 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 13 Nov 2024 18:21:17 -0800
Subject: [PATCH v11 11/14] riscv: hwprobe: Document thead vendor extensions
 and xtheadvector extension
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-xtheadvector-v11-11-236c22791ef9@rivosinc.com>
References: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
In-Reply-To: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
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
 Jessica Clarke <jrtc27@jrtc27.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Yangyu Chen <cyy@cyyself.name>, Andy Chiu <andybnac@gmail.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=TcqhLbjZS94rab3lMFuoSS5guT4Dq12UlcROgKWQAqk=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7pp3KITMZ+Y2BS2evyNn8SgyPJ1Zmmh9dmf1hKpPhu53
 xi9fl7ZUcrCIMbBICumyMJzrYG59Y5+2VHRsgkwc1iZQIYwcHEKwERW1DL8D7da3SP/YNHbBu/j
 Qr7l2tvN3ObHr/lro6v4JDB066ba64wMW/XWiTLlHKswqle0vF2z/Fx5NIu7nkOZm+EW2cNaHxe
 wAQA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Document support for thead vendor extensions using the key
RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 and xtheadvector extension using
the key RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 955fbcd19ce9..f273ea15a8e8 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -293,3 +293,13 @@ The following keys are defined:
 
   * :c:macro:`RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED`: Misaligned vector accesses are
     not supported at all and will generate a misaligned address fault.
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
2.34.1


