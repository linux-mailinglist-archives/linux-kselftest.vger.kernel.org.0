Return-Path: <linux-kselftest+bounces-7558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE5589EE81
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 11:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C0D1F266BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A04115EFD8;
	Wed, 10 Apr 2024 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JTcczxgp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B538B15ECF9
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740285; cv=none; b=H+YibyBwQSN5qSBWsvzdyfJTbXICw+lbtnwdU7JNbXgks91a6vrqCVK9nEWHSOKQnLXP9EhXg3GLuUAaPYUQs5FEzhsYq06OSyQFWnCH1NIySHeFkgFq9P6inXgDQau7r4tG++FWUkAUmx2gDaKld2a1Y+kV5aDZRlYSIXqD+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740285; c=relaxed/simple;
	bh=EgIgRQR1tXHGs2ASTKg5pKvhyudgCZB4oM0BiuQ65ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUljQipguJcA3CzpmTWas1MH+YbtxbjuhyE23Ka3MosCD1MY10lGbjk9ieD2iRbOtWw7UiBfymAm14gK0lBwieTg05UpMvTC4jZDOT/u9NPMLJ/nHt6cRlPByOxweT2JsydeI6OKoggnmIzVam+TKQvcAXmQmsERMLl/N4VGGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JTcczxgp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34560201517so889196f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 02:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712740282; x=1713345082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdcDTJcebnZeQ1JIaCOE86KIfZmbyqQMd2Sc3N5X9Dw=;
        b=JTcczxgpWMOvdTeVhywOj39LhBREWXAQ3/rmqNc3FFrylu7Mt/h1X7mWWy6Au5snAo
         eD4UHLFCx49LzaEaclUy1w7xoFBdRDJtqSajIftixd201XyoCa0ICMXLbKgXBg8/k9ez
         N0sbJklQyZJZMPNGqk9LQkGBe1L4GYkPF3+s4EgZkSTnXoWqpBGNrB65c5YomTSRVgWS
         K+85rKisXM9wOMHkwdUj71J0PekqcihyKh1PNPWWsU+c1Im5BlNxUQSBvS6va1O8Zsey
         2ieNoPI4ab9jea4PyNQSoFsbgkHFpRXAJeZoC+2QFUa+hRMByZYWrTBxiBQTl83Nmwtn
         2TZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712740282; x=1713345082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdcDTJcebnZeQ1JIaCOE86KIfZmbyqQMd2Sc3N5X9Dw=;
        b=fnsbdMvXrMjrezxOIMMGfbo2oZiPS6SVlXkNI8zrCxx2NIqzL3n8eMUXiT/I+p8QSx
         Jm2W/MYcOpLz0rCXeoKDSsUQWK40GTvJ/8lS9XCid7VWbt4yA1m0+xgyb0VpfPhYO4G1
         aowpqOQzW+KNBaL8EQesVg0LXA8ifoFNkz9bgx264CDq2bQf3NjY3upHw8m23I6wga+/
         NigVAjoi4Mddbcs9D2h6AEQoW6/cETuaaVrAdEfJsn5ups/dIECQiCsFc5ck3unwRisy
         EORfaCk57f/Tp9SpesgLniWiAO7ABSx+1KTA16K2ChbNXSkX5sMRv7IJsKsiCsilHLNf
         GMTw==
X-Forwarded-Encrypted: i=1; AJvYcCW1GW+ARl+1fbs/gikTCW25EuUtq376HwFKn3sOHc88tTyVnUOe9TXPY8IqfTTCgICbf8qAaSMrOBary4OqIYO7R9uOunWHu0z34Um04Kt2
X-Gm-Message-State: AOJu0Yy+UzmTR/tG8UuZiwxTC90YvdjYihluJVZPqBqR9jZTtWIG8pX0
	8tMibG+XWe1SiSKqNjJUokOiRau4qhOjZb2UP1Qre/deo7Mzn3mkFC1AoaFSrZM=
X-Google-Smtp-Source: AGHT+IETJd3wpoMeNtTRaVUSO311GACzKRot3UF4l9zMBdSlUcbEIBpRk/TUHcnQPBv8xEZGevomKg==
X-Received: by 2002:a5d:5982:0:b0:343:b9e4:ac2a with SMTP id n2-20020a5d5982000000b00343b9e4ac2amr1633158wri.4.1712740282238;
        Wed, 10 Apr 2024 02:11:22 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:d4a6:5856:3e6c:3dff])
        by smtp.gmail.com with ESMTPSA id d6-20020a056000114600b003456c693fa4sm9079086wrx.93.2024.04.10.02.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 02:11:21 -0700 (PDT)
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
Subject: [PATCH 09/10] RISC-V: KVM: Allow Zcmop extension for Guest/VM
Date: Wed, 10 Apr 2024 11:11:02 +0200
Message-ID: <20240410091106.749233-10-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410091106.749233-1-cleger@rivosinc.com>
References: <20240410091106.749233-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend the KVM ISA extension ONE_REG interface to allow KVM user space
to detect and enable Zcmop extension for Guest/VM.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu_onereg.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 57db3fea679f..0366389a0bae 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -172,6 +172,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZCB,
 	KVM_RISCV_ISA_EXT_ZCD,
 	KVM_RISCV_ISA_EXT_ZCF,
+	KVM_RISCV_ISA_EXT_ZCMOP,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 7d47fc910bd9..af4fefa189af 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -52,6 +52,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZCB),
 	KVM_ISA_EXT_ARR(ZCD),
 	KVM_ISA_EXT_ARR(ZCF),
+	KVM_ISA_EXT_ARR(ZCMOP),
 	KVM_ISA_EXT_ARR(ZFA),
 	KVM_ISA_EXT_ARR(ZFH),
 	KVM_ISA_EXT_ARR(ZFHMIN),
@@ -136,6 +137,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_ZCB:
 	case KVM_RISCV_ISA_EXT_ZCD:
 	case KVM_RISCV_ISA_EXT_ZCF:
+	case KVM_RISCV_ISA_EXT_ZCMOP:
 	case KVM_RISCV_ISA_EXT_ZFA:
 	case KVM_RISCV_ISA_EXT_ZFH:
 	case KVM_RISCV_ISA_EXT_ZFHMIN:
-- 
2.43.0


