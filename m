Return-Path: <linux-kselftest+bounces-8700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CEF8AE69F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 14:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3F928243F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 12:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4349B135419;
	Tue, 23 Apr 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="d9Tw8K0V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A10134721
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876230; cv=none; b=bsjExVaEuLXHpZj8K3fhjoiBqaIORPJ3wkvZGAe7t8ODQ3IEcu8HaW5pk3fO++SXFLfp+kV12H+rMWLEeCVY42V+sxRZu1Fr9vd1aJHj19sYLVut+U0iIvuf0JvuQe8QUsBlK2pLyhyEJ6k9a4N2hkbjXsOC8h4dupcJgNqpjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876230; c=relaxed/simple;
	bh=bVEuZKlZZ0yffOCE7tYaM0ZOFAKNB5aKfkAz8DnA8Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAzRiw8bUHD7z7Hm2gs+/4G3dtT2cOG9MVp71S9StvYNOxM/YKeY2KjQTZWJRU4RHEOpB9Y27AIjvf8gl+KJjhg0rUb2kRNdOhGr/Fctshsmtn65RLJ1xJNayup80DTKGAvoSrqIzETFOsuWop3KaDXTQ6IW5P6mzQJfltbdL0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=d9Tw8K0V; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-347c6d6fc02so875581f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 05:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713876226; x=1714481026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKUXibPhUwjjSXA/KBDdbbKS1P63ijLLovqIt9fNrZc=;
        b=d9Tw8K0Vm1Xg8H6jF0AxCo6MtOsQKuyYoneohG/kxAQOFBKiGRYBYFf4ms4EQ9jsAQ
         7bvt/Je2ooFjuIk9GDXVjreymut8b7A2NC543Sp3yk9zXVCESrmjNm/lakjHL083clFP
         5APQ/7VVEENmIVBkdkFu1hMkyLM7dw8luJ5qwFclyMyMNBqp2kOCHI60rCjfjlyyY/La
         Ks+ZOt5L6TZ/3yFq3O2taGMZ32ihwjuria+Dy+f7KDjNZY7pc/tSUZu2px9/epA16Jiv
         TKsyjEbc/t5gL1QSM3AjuxJfujI5sxG9YCHcHQR1v45RISqqvhXgSwPIWbmw5DhzaMm+
         WvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713876226; x=1714481026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKUXibPhUwjjSXA/KBDdbbKS1P63ijLLovqIt9fNrZc=;
        b=txQWLKwoFK2y6ewmVicQg3/kBBAR/198YMuU3xdQ9+N4TF+V+aBHuDHK1hbzOO2Plc
         CM2pqjy/8Juz6p7PsCmqCkDkLwAjAZkYY81BPoJBMAVV65ZRkTOpPEf17v+iiqra3HYD
         M0rDxXdIES+k6pWee15RkASG9Cws2eorfPa0635/RvWjBfWOJTei4dh2YIIJZPPDaU6G
         usyDA/L8WZHadzrD06Vd9L0Flr4j2wgzsVKeaeHCybPaeX1QEevH6bHtAxbOp7EIImS+
         iqOZKU7hMlFjkB6IrE3DRkeymBIYSvRoo3h7NmafHcYtEg3/YOUkGvPHs4uLRpkMcPOF
         aHiw==
X-Forwarded-Encrypted: i=1; AJvYcCXrbbqkmWPRICSWy8KIb2qYhn5tCbxBOQ7uIGrGG47peivGDBMp4wt3Wi1Vw/YPebhX0/RJojtGeNmVM2GTPHTJZtHbr+b0OCokGpy33heR
X-Gm-Message-State: AOJu0Yx/+d4bYGGvMh/Cz4c+0+yHKk8Sr2O9nVVKC4hL8b+Yr4UFgBwR
	3eYVi6okKpX5cIRLciO9ou0fKdfrKJwuO1EFcgLD6w+mhdjUUbITX6dRHR0grPM=
X-Google-Smtp-Source: AGHT+IFUqPmuRaat/0SXEHHyjTSjZr+ZQTV3TzzwWrI3rXhXB0F+LGSeuZbKVhACNb/TBD8FDVBF0w==
X-Received: by 2002:a05:600c:3b8a:b0:419:f241:6336 with SMTP id n10-20020a05600c3b8a00b00419f2416336mr6604350wms.1.1713876226513;
        Tue, 23 Apr 2024 05:43:46 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:71cb:1f75:7053:849c])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b00418a386c059sm19975709wmo.42.2024.04.23.05.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 05:43:46 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 05/11] RISC-V: KVM: Allow Zca, Zcf, Zcd and Zcb extensions for Guest/VM
Date: Tue, 23 Apr 2024 14:43:19 +0200
Message-ID: <20240423124326.2532796-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423124326.2532796-1-cleger@rivosinc.com>
References: <20240423124326.2532796-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend the KVM ISA extension ONE_REG interface to allow KVM user space
to detect and enable Zca, Zcf, Zcd and Zcb extensions for Guest/VM.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/uapi/asm/kvm.h | 4 ++++
 arch/riscv/kvm/vcpu_onereg.c      | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 35a12aa1953e..57db3fea679f 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -168,6 +168,10 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZTSO,
 	KVM_RISCV_ISA_EXT_ZACAS,
 	KVM_RISCV_ISA_EXT_ZIMOP,
+	KVM_RISCV_ISA_EXT_ZCA,
+	KVM_RISCV_ISA_EXT_ZCB,
+	KVM_RISCV_ISA_EXT_ZCD,
+	KVM_RISCV_ISA_EXT_ZCF,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 12436f6f0d20..a2747a6dbdb6 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -48,6 +48,10 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZBKC),
 	KVM_ISA_EXT_ARR(ZBKX),
 	KVM_ISA_EXT_ARR(ZBS),
+	KVM_ISA_EXT_ARR(ZCA),
+	KVM_ISA_EXT_ARR(ZCB),
+	KVM_ISA_EXT_ARR(ZCD),
+	KVM_ISA_EXT_ARR(ZCF),
 	KVM_ISA_EXT_ARR(ZFA),
 	KVM_ISA_EXT_ARR(ZFH),
 	KVM_ISA_EXT_ARR(ZFHMIN),
@@ -128,6 +132,10 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_ZBKC:
 	case KVM_RISCV_ISA_EXT_ZBKX:
 	case KVM_RISCV_ISA_EXT_ZBS:
+	case KVM_RISCV_ISA_EXT_ZCA:
+	case KVM_RISCV_ISA_EXT_ZCB:
+	case KVM_RISCV_ISA_EXT_ZCD:
+	case KVM_RISCV_ISA_EXT_ZCF:
 	case KVM_RISCV_ISA_EXT_ZFA:
 	case KVM_RISCV_ISA_EXT_ZFH:
 	case KVM_RISCV_ISA_EXT_ZFHMIN:
-- 
2.43.0


