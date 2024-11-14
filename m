Return-Path: <linux-kselftest+bounces-21984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA599C808F
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 03:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4746D1F22913
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 02:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63301F4721;
	Thu, 14 Nov 2024 02:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IQBhE2dP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D60C1F26E7
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550903; cv=none; b=hwwkqpwY/4LZMvLseg60k+M1MkaujxoVi7TMpAiUaU0hIBobymCCOMpq+IOrRkNL6xfWwNA7998KRBTAAGSy8e69wJ8xGlZSA3HH0gMv4oRyJ6Lz97O/hJ/ncEoW1ZJGxsPcGnIh3qlsCZpDlQoxD3W2wSLOnInybmbya1ZczV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550903; c=relaxed/simple;
	bh=IMTX7wFhmekwgv/999KdfyiiLXG/oySqov1HnDb4bQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ewxFyXAZiI8ENHWOzvkFDpmqq0ma/1KmnPEUtWpcTrmjzwHD5mQj8hNCIs+u2cmjxZF5rQ0Hr57b9wE3ywgL7QrtHch0MvGOzsFPytYHQ/GHZCgnAP3oRGXyedEhnnUrgrmt41TSO+bmJi+QxwmBpyvvy6oBHcjrwGkMww8gus4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IQBhE2dP; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7f43259d220so43424a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 18:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731550901; x=1732155701; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQpI8oGqjRXIuyayOmjB5gj8CivKUFDc1b3b4GOPe04=;
        b=IQBhE2dPnsDYaL6MfESaCWTAwmIAjuZanHnxoGvjJndrwaCMavJTRTUahEfsr+swv5
         vxmeVXUBMKTtsOMLuDe45J2UJyou3H6PxlFx6+HoaVyKWkUuEvaD5R/8mQHf1hlh8sXZ
         rplBa72vzedm48naxm5y2MuXWFwMVio5C8odWt0/VWQ1w70ZL5PvQiCsbzsygIgM+TSe
         l/GELHxdJX2qZyc458V9E4QAtnaSElQjBIkP7+FkPeYZ0ers2tDGvbxnNVIL+cLeLxkj
         76VmrAjOBpj+Z1xTXSSpaGcpYbvs2Cf0wSnOnwIxP9LvXRrkWoF72UAoigt92kmyCCWQ
         8FIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731550901; x=1732155701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQpI8oGqjRXIuyayOmjB5gj8CivKUFDc1b3b4GOPe04=;
        b=lg1PZGy2tVeundXTaZMzv5WTW6x1WnQmgVI2kXxE5jsv+wazhPMs7Owl1iD9VsU0W2
         O9Rg3DaTbTrHleQBDR9eJ9R4qR3L5K7euO0SR+nsM0OxgTTFUsz+TfSgTVHVXO0uCFX4
         NxYncsoBf4R1XvX4km30vZzJXtbZ1bAllI2RpMO43FbMQnp5kmvj4CRVfIaNOaX5Uzi8
         K3/ghPIDBpF21T1BRjxcqwJP79+JpZSBfV1qBbKg0kzI+8IX/tKRm5N9e6UdGUxYb2Bt
         CMWG29fjl7LhNRQzIOGj8XnTVvIqoNZ8gPCS+mSbGLoOb/dmCM47kq9PGXJ6T47f1ucn
         6YMw==
X-Forwarded-Encrypted: i=1; AJvYcCWS4yNcEgX5+jmEizWDndROigMnZKUnI4VoN7SvuMnQppuwXfulW6Tm9WZB9tKqGqrwhBoM0Jt/ztUhdi8B9vY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRyidQ/MWZYeKb1QffK/0SDzCGHtcH0QR013XzZj8BMRXj7KhT
	YcsuwF+2FSk1Bso2uFSLi7TzhIu5Zdyokpwy25SGNz+FQPsDzkpPQunvVcTghZo=
X-Google-Smtp-Source: AGHT+IEM2CwPcQXZI9Svh2lf00ZEMQVXQk/g3+Zk7IWvLJ5CiFC3TFdqne+Wd+DhOUNFtdaQbE3POw==
X-Received: by 2002:a05:6a21:3295:b0:1db:e96f:4472 with SMTP id adf61e73a8af0-1dc834ee4dbmr976723637.31.1731550901476;
        Wed, 13 Nov 2024 18:21:41 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c499c9sm406875ad.68.2024.11.13.18.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 18:21:40 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 13 Nov 2024 18:21:12 -0800
Subject: [PATCH v11 06/14] RISC-V: define the elements of the VCSR vector
 CSR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-xtheadvector-v11-6-236c22791ef9@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=930; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=GYVIK5RN7sAF5cs9O4ZRqugq2IlOeAFQOiBXIJ04b3Q=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7pp3AJzT7WHn63qdp6dndHrs0En8vb97OtuXCqsvdP6r
 0j+7vHoKGVhEONgkBVTZOG51sDceke/7Kho2QSYOaxMIEMYuDgFYCINbQz/o2480XpS7OUifLCp
 VKZ23ebvYhodtS/i8rfx5NjZXwj9wfC/yEt7fm4vbxqzwDOdW5wqW05yuUfemLBRw2F22zvNB1s
 4AA==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

From: Heiko Stuebner <heiko@sntech.de>

The VCSR CSR contains two elements VXRM[2:1] and VXSAT[0].

Define constants for those to access the elements in a readable way.

Acked-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index fe5d4eb9adea..db1d26dfaef9 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -314,6 +314,10 @@
 #define CSR_STIMECMP		0x14D
 #define CSR_STIMECMPH		0x15D
 
+#define VCSR_VXRM_MASK			3
+#define VCSR_VXRM_SHIFT			1
+#define VCSR_VXSAT_MASK			1
+
 /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
 #define CSR_SISELECT		0x150
 #define CSR_SIREG		0x151

-- 
2.34.1


