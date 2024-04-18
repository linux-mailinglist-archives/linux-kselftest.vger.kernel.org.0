Return-Path: <linux-kselftest+bounces-8321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B255E8A9A23
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 14:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6958F1F217BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 12:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0675A1635BA;
	Thu, 18 Apr 2024 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="orXBAWIl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA74D16132C
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444244; cv=none; b=YnqNbBI3TZ/X6srQThe3/QJU2eea3AVhs+qnMEyNVSt88qlpyIlEStrtONIrpOk5FgkIzTVPOpuLeP4YeKKGcDUic5+zkUW/NFKZvbUQO2opBodop3Z1qN+W/mJL9G/EvuHEfKEQI3XbFxpYHdHeJaThETNblmDI3Vubm/bsS4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444244; c=relaxed/simple;
	bh=2meeqYrGqS6N+9ES03sW/IZ0HWVimfJczOdorGfrJB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gw3TbyUZ4lmgTJFa+SRwhEauAzmJIoD4RycWIX5MX4Zz5KAInUMRu9+QlEOaQFlr9d2ZCukUGbzdxqBSVMLrIlDRlnZCpJG5+D/BpZXEf9RnZoc4iJfwOJ9fzv+qMCp2PCa2jUXctuRu8/X+CfV4FxcMHNXo9/Y7MNWhz22ezHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=orXBAWIl; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2da4e54549fso228141fa.1
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 05:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713444241; x=1714049041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=av0fCRvJ5d6BdL5At0wE/CNS0oRVP43ZLfrJceTJ89w=;
        b=orXBAWIlCbFEPZnXQnevS9f95mR5781Pc2yepFZQDAFvlJNBdvAcLHH8vprt+kGonx
         u/y21dbj5GkzC7GC9zD2/TDSztHegfMNMN2C/DhINA2H23Kk5mfXmCCyvY+gHjagQ+Hx
         oaNLoRtTXs5HQDI1JZgqE/2mtGYT+M2IaaZRjHo1RF13bMsHsiJE5d1wYa2P4OdVwI/A
         7BVKyu+mMSKhRKMcLyd/ObTNE0DshORErxAfHhUT+3WDt27HEN2cxYP1ZMIOX/m2Rzmg
         m50MJceZivYeNEpP/zgsWdA0CNd/KAvsGenYKqMMettqNaLTycWsPrXjixBOhvkaLotl
         ORBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444241; x=1714049041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=av0fCRvJ5d6BdL5At0wE/CNS0oRVP43ZLfrJceTJ89w=;
        b=eMY/wjdVFL36ck7jewIGEAs93vmjqU86XnfFPqLGjYh6ZOcqJuuFS9VSJ/LWXsCifY
         NQNPu3yNzS4IcDUMuSGyNao+sruc8XA16Lw1itImpGpvM9tyOWHNFYaqioZIlTo78iQ/
         p66U5jziIfYpOFOkq/I1V8aochtBWxmMdtCbvoejd8cnBZIOfrHPg5SBWrzB1sNYMvJJ
         +Rzge7PJBnLnr2NEydfjX6c+8zx3Xt7PD9rdBY72jvOTH7hXo3kMdOL9rOOZxavjEvnH
         kH0xbD8P3PfBqoxZBhppK9JdPWnKSKkePVAzRjAOD42g9Lc0ddPwsOCVCNmcMWiJiCyq
         lgoA==
X-Forwarded-Encrypted: i=1; AJvYcCXF6er3g9CwXt+/yDv+/Es8M/0ASTkaMSdFbHmHVTIbstcs4YsOvaJ5YDk71kBjOxlmJBhf8+urjBtMG5cFX5GzNMisBMJq2N4YwYDpPUdK
X-Gm-Message-State: AOJu0Yw6Bn1t+Yt8iTgyzlmdGDr4O99VZM4Qhaq7gtgwqwhctSsgZAPC
	/3gVIw1VGSDzJZhL1bthUVh9yVDaIR3xNrhdecxGKLCP2S4ghY6jSiAmmyq5Dv4=
X-Google-Smtp-Source: AGHT+IHdzMsUCMCexL1xcSXK55gyqNVYHzfsqQON0oQtcwPFlYxqOUNzTjfk86rgRUdr+Vw8mFv+bw==
X-Received: by 2002:a2e:3a19:0:b0:2da:320a:6739 with SMTP id h25-20020a2e3a19000000b002da320a6739mr1487240lja.1.1713444241121;
        Thu, 18 Apr 2024 05:44:01 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7b64:4d1d:16d8:e38b])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05600c3d9200b00418d5b16fa2sm3373412wmb.30.2024.04.18.05.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:44:00 -0700 (PDT)
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
Subject: [PATCH v2 06/12] RISC-V: KVM: Allow Zca, Zcf, Zcd and Zcb extensions for Guest/VM
Date: Thu, 18 Apr 2024 14:42:29 +0200
Message-ID: <20240418124300.1387978-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418124300.1387978-1-cleger@rivosinc.com>
References: <20240418124300.1387978-1-cleger@rivosinc.com>
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


