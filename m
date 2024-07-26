Return-Path: <linux-kselftest+bounces-14264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6112F93CFE1
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 10:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D313282AE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 08:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFBB1779B4;
	Fri, 26 Jul 2024 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Q3/hIAmQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83681179954
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2024 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721983805; cv=none; b=WAIIiKBxTtnTRmhgunBmvO7cs6kx1VQx9GmNygdoUwWgJAsnRdMMYbZv5pzd4RliLm457zL/yh36c3keD20zy52GQt0H9NzLUwMSNvsrFR58l6d1uoqCTz6y6XqRGlHM4KI5Bzz1hUFGQ+GqUELsQqZiJzSjeYQQFQUuRwwWZUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721983805; c=relaxed/simple;
	bh=4H9XgVVG6KE+T4f63WGdvgt8zwDFpGPootH+0VeKvxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Zs1E6H5oZjn8i0vW9UZulPGnFLexwfWv7XdaSKX+bPhS1RlwLszePwOvDTxFB6k0g8mF94wQrPcYeR0Y429/oaDGiqK0mkBU5dkWv9deu4RgbPVUW6TF8t7kkMNWEbgShAT0mZD3TEhZ1SdZvxcQpAZkkr4EQHGRZb/QwSI5Ip8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Q3/hIAmQ; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39728bbf949so6905985ab.3
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2024 01:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721983802; x=1722588602; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bh0dPmnNd790JEXkCnnwPZ9r1VDA3UO+2QohszDGqoo=;
        b=Q3/hIAmQz/zvQzH3s1WqdNS14iCVqdMF8j/tC5PtxrTMQRj5i+FZG8r3opLZ6iKaMY
         InWuFpxE6X1qRNN2x5N4RBPfzkhHnycZtCwQusBeH0F1iBBKMA2kDatZUoTtpDAcwoi1
         PJ5q+Qu/Tto7Q4OCHpctMSbstZezDL/+oXe+muKS1fK8rty58A6heU/Vajxt394BKaZ2
         Kj+TXKTzr/A10TiydzZiVyx6dojtH5CVCmg7jGgRiWgFW/Duq3hKg7OZwMcwM8CdfOEH
         AN4qW3AKY+ccvHa7wlgV74ZpidduLBmETLAC7aZHkcaYHPZ0Aj9/4EXCgUa6q0WQ3j7p
         C8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721983803; x=1722588603;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bh0dPmnNd790JEXkCnnwPZ9r1VDA3UO+2QohszDGqoo=;
        b=eIAflWri9auiCiIi9VlRSWZdmAb5Nxh9Id40NxxlkBFmWo9mWKVZsjduI+Dc5j8pDT
         93G54bW/+z8b28G2DB5rDWjL73p7/CZoTfRgLTM2Zogyc021FJoXir+2olpCKP8zL/uk
         UtFiD1h5fG75X/RAFD/dXCM3/o4uas2aqF2x4nJrEfNipaFEU/nANEPmrSHXXnxbyqGc
         TZXmzQbr8FXqIYPwuHpbTADm8FcWEqPrIFjjufWizrkQeC1dIDP3b1czNNlQlxt9hmcG
         uadEDrVbl0z0+KcATqXMBtRD6URJkzMxSVbDknWzw1AdHapi3+jlrRkXLL9FwnPLVq1y
         cr4A==
X-Forwarded-Encrypted: i=1; AJvYcCX+RWikrhFzyjOIPn1/o4Sseaj46SqlC6O2UhXIuUy6HkIe5bA47LbjrabD0MJBlFwLNgmqtM/SQxur9ZDunZXMkcoW/KOLCAXDQmIjeVbZ
X-Gm-Message-State: AOJu0YzAutd8n/QymguQVa1SEk6dThSXL99qIIw4SS/IvMIKWJTBuDP7
	tXfZWfvJ6DPWy/QKCfqJ5XKC/F+4EBj8HLFALJWAYoJJOZ44zDuPxMpq8YBbu4A=
X-Google-Smtp-Source: AGHT+IEC0sacpJpGdjediwFUkg9JGJyg+dOU1D2hf0SgxjyukSNI0E33M4o24q3PFduqql67IyeZjQ==
X-Received: by 2002:a05:6e02:2162:b0:374:9c67:1df6 with SMTP id e9e14a558f8ab-39a21814055mr55639775ab.22.1721983802742;
        Fri, 26 Jul 2024 01:50:02 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f816db18sm2049645a12.33.2024.07.26.01.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 01:50:02 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v8 5/5] KVM: riscv: selftests: Add Svade and Svadu Extension to get-reg-list test
Date: Fri, 26 Jul 2024 16:49:30 +0800
Message-Id: <20240726084931.28924-6-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240726084931.28924-1-yongxuan.wang@sifive.com>
References: <20240726084931.28924-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Update the get-reg-list test to test the Svade and Svadu Extensions are
available for guest OS.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 8e34f7fa44e9..aac40652e181 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -45,6 +45,8 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSAIA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSCOFPMF:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSTC:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVADE:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVADU:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVNAPOT:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVPBMT:
@@ -418,6 +420,8 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(SSAIA),
 		KVM_ISA_EXT_ARR(SSCOFPMF),
 		KVM_ISA_EXT_ARR(SSTC),
+		KVM_ISA_EXT_ARR(SVADE),
+		KVM_ISA_EXT_ARR(SVADU),
 		KVM_ISA_EXT_ARR(SVINVAL),
 		KVM_ISA_EXT_ARR(SVNAPOT),
 		KVM_ISA_EXT_ARR(SVPBMT),
@@ -949,6 +953,8 @@ KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
 KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
 KVM_ISA_EXT_SIMPLE_CONFIG(sscofpmf, SSCOFPMF);
 KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
+KVM_ISA_EXT_SIMPLE_CONFIG(svade, SVADE);
+KVM_ISA_EXT_SIMPLE_CONFIG(svadu, SVADU);
 KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
 KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
 KVM_ISA_EXT_SIMPLE_CONFIG(svpbmt, SVPBMT);
@@ -1012,6 +1018,8 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_smstateen,
 	&config_sscofpmf,
 	&config_sstc,
+	&config_svade,
+	&config_svadu,
 	&config_svinval,
 	&config_svnapot,
 	&config_svpbmt,
-- 
2.17.1


