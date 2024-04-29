Return-Path: <linux-kselftest+bounces-9038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C9B8B5D15
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 17:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B5BB2260C
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 15:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1A712FF8F;
	Mon, 29 Apr 2024 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fUpvo53l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779C685275
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403202; cv=none; b=u7eB4dygvD/hMvUovCchNpAwlWwEODnellE8YPbaxJ77Axl646laRvuFhXTPFnprs+FiOsh1NC191mu5INF4Po9rXZ5zVDv4jNwUyqqdyL1ziM20Dr8vDEgAeLiI6d10qDHF4DsStsaj1EZs2J0d7s2fVVm4FjDMEBReVlqaPMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403202; c=relaxed/simple;
	bh=bVEuZKlZZ0yffOCE7tYaM0ZOFAKNB5aKfkAz8DnA8Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qj5nD3UwcdEFe+ns3s2L6zbHLElOqw0YewFft2ehII87y1AHGlACfyFEHPQhAuTjKrRepb7NSD1OEU72nWFP+tKtiwkws6Bp4t9NysS9r1M+g4SZfN59pqYzufpL0QbD3ImDHooBiOCHQxl56E1nmOImxAcg6+I+kamD4d1oFWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fUpvo53l; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2dffaf0c6afso291301fa.1
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 08:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714403197; x=1715007997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKUXibPhUwjjSXA/KBDdbbKS1P63ijLLovqIt9fNrZc=;
        b=fUpvo53lbBf4n2bA5Sg7YpH7HFBUTMQ5sv01vh+iiAgUZVxq5BKtHj+7Z0BsXSNBnO
         Ll55fUAgRh6/FpzCn/3iUY4S1bohNESIBNwD+t8fRgtjeWA4MoxbZWIX+0VzUjb28yBU
         1o3N26Ter3YfPz3cq0plSad3gDEdmrratuNskZ55uHmwygcbL2ZPtOtMBMYi5xW5ytni
         /yCXNdfOA7eMA/PVNcb9cRKqF+jzJivF6m84UTR+ckjsPQw3gHBjaBgKs+u6+RYqFzRO
         NjDiE/M5MTgyhiyAb3ybRvTzeW63NaOCFxsCRCj+ZwLRZGbNkxkVn/OUJwwxlcJLTwOE
         +Elg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714403197; x=1715007997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKUXibPhUwjjSXA/KBDdbbKS1P63ijLLovqIt9fNrZc=;
        b=SCXjU3vrOo/4uIzF0gsoEPQsPupwrZ/nKt7pZ3vb04tNIApL9WAru3GVx6ZTdRv6MD
         5VAn+s55mI/JeXLZKg0C9j7tHl72F1ioWrecyVb6y2hxpNra6B4tmAn4M9l0GF5Lw8SC
         hVyLUXsjba1/5vmcqTpuN8HendQ3uNovcMX7/VaibXYGZt2CtS9mCjbxKI3Q9J3sDxKl
         hkyR/JkiUP4KWJEZdmN8AoqSidYiXJvHIxt6nP7JWwfD5YTusq42CtW8Glz+tC7k6Sup
         B+umGQ0L+6ApaGD6a21lC/8Z0GCLRK9UfM41wDTDFTJry1CJzNk5TtvxEmJojyaGkRWz
         2Fpg==
X-Forwarded-Encrypted: i=1; AJvYcCV489psSbF2cCg9hu+3CPTllt6KJOs/zskfDs9niYzBVhl8E/FL++JwLl4ZXmegoDkQg7ZsZq8WygQc3rJhZNvKL3m16E6PW6UTUyhS0iG4
X-Gm-Message-State: AOJu0YxxMCTmmpCu9m22HxYPtrhvyVEVWpBe4/6DC/eUlhqD1XEeLzFv
	iQv72WqHXAWgrj53eLVmHrz/f78qk1Q6D90VS9nSskkTVqOsPPaCnfY3qjELjx8=
X-Google-Smtp-Source: AGHT+IHBeQWCMZrNLW0+ykllLuDLc1Y3CgTNKkl/oAAzYPksrb/JlVrkXxJwQYgzThm7ieqJgwd2hg==
X-Received: by 2002:a2e:910a:0:b0:2dd:60d3:7664 with SMTP id m10-20020a2e910a000000b002dd60d37664mr6737706ljg.5.1714403196813;
        Mon, 29 Apr 2024 08:06:36 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:2fec:d20:2b60:e334])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b00418f99170f2sm39646638wms.32.2024.04.29.08.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:06:36 -0700 (PDT)
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
Subject: [PATCH v4 05/11] RISC-V: KVM: Allow Zca, Zcf, Zcd and Zcb extensions for Guest/VM
Date: Mon, 29 Apr 2024 17:04:58 +0200
Message-ID: <20240429150553.625165-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429150553.625165-1-cleger@rivosinc.com>
References: <20240429150553.625165-1-cleger@rivosinc.com>
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


