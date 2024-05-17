Return-Path: <linux-kselftest+bounces-10348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB578C8891
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 16:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05451C21BE1
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D946EB7D;
	Fri, 17 May 2024 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hUSWJbkO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4598E6CDAF
	for <linux-kselftest@vger.kernel.org>; Fri, 17 May 2024 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957603; cv=none; b=g8yd0iTVBaztItiSGw/GaNmxbo287RVVUNdjVCcICGG/zMZnG+nGq9kApKeym4DlYicwgXgVDMAlygQkPckSEWgji0HBrMdbPtt9NTCf6lPJ81DyaEBSwRnIojkBBk4dVrs0GtwE7V4PH+k8v+0gC7J134g0OwWARfhG8bEUIDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957603; c=relaxed/simple;
	bh=tISoTGebS4407fh89NkrPP6RNVyQwmfvD5bdgCJ5Fi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W496ARCujclZuS9m/Y3K9zPKfA841Ct2qRC/68iXkh0KBOCwwBvFXRLkB/w9DNc2rRKttegI2cSAbnVH5R3PDngP+0bmUsKP07g/KxZjP9IaBrCqTOfPo2nuUL/Ihtke2A7oynIEzhnVgWCpra1rx6MZYRjo/buzSTFnmy8C2Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hUSWJbkO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4200e4b7bcbso327875e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 May 2024 07:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715957601; x=1716562401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3qT2c8/AbHM1mLG3KaUUQ1VJHCZOCgVEzdfPOCGq3I=;
        b=hUSWJbkOrd8fd3IhzU7WE5nR9568/50kV5q3QkkVBPIQYBsz+2CA7WUF+Ls/2gwjaW
         tXnrRa/507UoPw527EJXfEPNUEWD/PtgLBu2/zP92iaI5R551OGyJw4o1plJ+Kgxia4f
         myKv6L6QkhH7mB7UmzFSuEphZafclCzwRdf8Mfv24YLav0KPj36f0wxmSU8M8PswYYb2
         6Tk88dy9FRujj30XYCBi4CuhFu5T/u+kQOm7IqbPvsUMDn2eV2tdAhixDobk7Jt/j626
         GMSLD8SuOjxCKQEMz917PJ+MrXL4TOn8hjyIppXrwbsBkAfwpD0nPRTUxdNWBYcUnYtv
         v1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715957601; x=1716562401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3qT2c8/AbHM1mLG3KaUUQ1VJHCZOCgVEzdfPOCGq3I=;
        b=jq7guJTeJHV6UXyyNb4OiMjGXLN4EDNCbwk2Vz2+TK/82u3dsVPrAbUrvftZZGm5xS
         Hz9tP8F2Z79+HAZ/ZIMoWwdWNf/VI7naRGtsahSkpIMIm2EzRsb4PPnuU/HovhJu9WbM
         eYhxResipKHRuDuXFbwElhJVJ4AtolvyOg0lYkRjgb48i9P+RviEgs3+oAWinhdwQU3Z
         hfMGfLKl4rdr4z0FzCdrLUtTRloOaq9uhAJjlnE4o/A6bCYzEodrrCXLsvE3uwopV1gt
         iai4COEVPEsVgERGAEFplNTGWCBXpJDqWCTnmCDZDP/e5Ad+zKouO5d6CaI+yMl+D6ct
         BlNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+qq6f77oVi0SeLj5nxqNpkF1fRX2V3D62ugZYTBoVZRyVP+FNYk9ClXqx3PWQEwlWXnVaQ2pSEFNGLChhN5d/9DqkT2aznJIG9j6WX+fe
X-Gm-Message-State: AOJu0YxfvYxvGrs9BmlUjgm+PxA2fCYwfwRDhYNuzHcYCDTJqOhBOM/e
	mVvjtIl6Ompw0RsUp/dcbwY5GoBY966FGVKc25BmYVzkZ/QkHBrbljO/dUfuJ3Q=
X-Google-Smtp-Source: AGHT+IGmFz2dCCSoIGSZgcVXd3L2iIvNLJ1n+dSnLeRekQmogP6yVON/V7TWTOPfu9vhDYg4e13TwQ==
X-Received: by 2002:a05:600c:5116:b0:418:ef65:4b11 with SMTP id 5b1f17b1804b1-41feac59e8amr185538735e9.2.1715957600825;
        Fri, 17 May 2024 07:53:20 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:46f0:3724:aa77:c1f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce9431sm301723695e9.28.2024.05.17.07.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 07:53:20 -0700 (PDT)
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
Subject: [PATCH v5 04/16] RISC-V: KVM: Allow Zimop extension for Guest/VM
Date: Fri, 17 May 2024 16:52:44 +0200
Message-ID: <20240517145302.971019-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240517145302.971019-1-cleger@rivosinc.com>
References: <20240517145302.971019-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend the KVM ISA extension ONE_REG interface to allow KVM user space
to detect and enable Zimop extension for Guest/VM.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu_onereg.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index b1c503c2959c..35a12aa1953e 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -167,6 +167,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZFA,
 	KVM_RISCV_ISA_EXT_ZTSO,
 	KVM_RISCV_ISA_EXT_ZACAS,
+	KVM_RISCV_ISA_EXT_ZIMOP,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index f4a6124d25c9..c6ee763422f2 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -60,6 +60,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZIHINTNTL),
 	KVM_ISA_EXT_ARR(ZIHINTPAUSE),
 	KVM_ISA_EXT_ARR(ZIHPM),
+	KVM_ISA_EXT_ARR(ZIMOP),
 	KVM_ISA_EXT_ARR(ZKND),
 	KVM_ISA_EXT_ARR(ZKNE),
 	KVM_ISA_EXT_ARR(ZKNH),
@@ -137,6 +138,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_ZIHINTNTL:
 	case KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
 	case KVM_RISCV_ISA_EXT_ZIHPM:
+	case KVM_RISCV_ISA_EXT_ZIMOP:
 	case KVM_RISCV_ISA_EXT_ZKND:
 	case KVM_RISCV_ISA_EXT_ZKNE:
 	case KVM_RISCV_ISA_EXT_ZKNH:
-- 
2.43.0


