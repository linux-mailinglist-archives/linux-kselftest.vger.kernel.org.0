Return-Path: <linux-kselftest+bounces-19879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47C89A13F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 22:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122301C225C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 20:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D06219CA7;
	Wed, 16 Oct 2024 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Q+R3q3Yk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29521791C
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110515; cv=none; b=Cgmxkw20aEs3rtyoakxYjUfaTYSAWTk8zUW6+gE4yUhPEiU75l3pIFAUbldwrM2Vwu6uW0qBEVuz+JqDzIj+2MqSmyNcMT8jpqPWOywRkEl0+J5exziS+Nmo6QK9litarEngCXc5XHcdE/L6+v/Sz1RiLClcg6TTIvmjs3B+kfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110515; c=relaxed/simple;
	bh=WEXFA6nYI8AcdN86jF1gE6DwkQveVeLPsBkK9MprTG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYS89JuPSsYL0Uf1vpiuYZClmG6uecd0+lnbbPQb5AfcDdmZiF80yuAxQXv7l6vTh7XHyWlCDBseGAl7T7B9fZmj83i3RNvEo4KDgDWCcUKSM/xqWmM9eX1lgqOtlz3i2dOMCBM8NC2yMEuebJG/1fp/r2RLP8rwgxH5wEG+BpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Q+R3q3Yk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c70abba48so2105935ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 13:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729110513; x=1729715313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8qp+tseh4bMUHTaD+Myf/jjkdJffKFnGUeOTquYIl8=;
        b=Q+R3q3YkcI0xLUvZqfMSx4BKAUF+JWhjv0oCrgpwCH+XYiCJXny7jgXkr7Uo6Lw7Ay
         SmQXdTg0+FWVdiDyh3D8GlGn4V/Ezd8lCml1YJQNL2CWJLVUju2OetR7t5P6LQA4T2Zm
         SMnSfXTl98qKMDR2mhEg4AjVp2bQdQcS9sUdnJrl/yF4APsQo8nMoeJEe0KXbRDnDR1J
         2VfmsnnGFAG+uX+pmSGCR6lHgWBs0bNWDvbchC24v9Zg0q4S/iS4ZCjzF1KytWQ541yT
         A3xuxHZfI5LPDtWt5ZLIpCjDr5Wot+cep3Op0+gyrswV9HA7yCD4/8eId8jFPJ05rTCa
         FXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110513; x=1729715313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8qp+tseh4bMUHTaD+Myf/jjkdJffKFnGUeOTquYIl8=;
        b=huhFwO8qY8Qhsa19pZ/F8HbrO+NNwXDcb4EL+6MEoM6KBZeKQCic0UzrZkw1W+HAWQ
         3P1PSaHGHbmoJvYMjHZU9l3Qckm8oGAIQGEP4Tz4pUJSmliGwG8Gx+D8kWo74LUKFDuw
         JHZIBtd9XdFJK+Y6vI4EK+HxoDOj+fmGgL9JvP1uJ+hg5J8WujdEnHLZigqm6WlZk0js
         2qnxrY7oKomuIgXLhc+bRWyEu7A5hHFPhDU0/ad/mKOsHMeLyGII9bLSg89c5c8D3eXH
         zdOtKVo1Ad+78R3I9Rs6+77m/XigjRnhkadDhd0jubJKQvEyRx7Ylwp9bfhPjXTKbgvd
         utZg==
X-Forwarded-Encrypted: i=1; AJvYcCVQqxNeYYvhvSY336MAsrCrPiqSmgRTZGetqIGxOPxBb31Ccowg+mq8cgbB/HQ7Bs6YovZUC3rrzYnbefCNpgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhoFvjdmARJHDc442xMfpZH8AfDsU07gOMhupsthjoZw1LjCZ4
	fCP1eZLCHrNx8tzrfatuu4mm1iNYeGUL6/DyK0otquTlTrSpjHahJONaBdiUNgc=
X-Google-Smtp-Source: AGHT+IGt9EJhWPb2QUdkiIkAH1GPre203CbDhO3HM7OqUiVLzcm8QmSQg0UHLFTAJE4hx0loBwaHQg==
X-Received: by 2002:a17:90b:617:b0:2e2:991c:d7a6 with SMTP id 98e67ed59e1d1-2e3152eb736mr19638942a91.19.1729110513399;
        Wed, 16 Oct 2024 13:28:33 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08f8f89sm228613a91.38.2024.10.16.13.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:28:32 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-kselftest@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	devicetree@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	kvm-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	Evgenii Stepanov <eugenis@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 09/10] RISC-V: KVM: Allow Smnpm and Ssnpm extensions for guests
Date: Wed, 16 Oct 2024 13:27:50 -0700
Message-ID: <20241016202814.4061541-10-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241016202814.4061541-1-samuel.holland@sifive.com>
References: <20241016202814.4061541-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interface for controlling pointer masking in VS-mode is henvcfg.PMM,
which is part of the Ssnpm extension, even though pointer masking in
HS-mode is provided by the Smnpm extension. As a result, emulating Smnpm
in the guest requires (only) Ssnpm on the host.

The guest configures Smnpm through the SBI Firmware Features extension,
which KVM does not yet implement, so currently the ISA extension has no
visible effect on the guest, and thus it cannot be disabled. Ssnpm is
configured using the senvcfg CSR within the guest, so that extension
cannot be hidden from the guest without intercepting writes to the CSR.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v5:
 - Do not allow Smnpm to be disabled, as suggested by Anup

Changes in v2:
 - New patch for v2

 arch/riscv/include/uapi/asm/kvm.h | 2 ++
 arch/riscv/kvm/vcpu_onereg.c      | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index e97db3296456..4f24201376b1 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -175,6 +175,8 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZCF,
 	KVM_RISCV_ISA_EXT_ZCMOP,
 	KVM_RISCV_ISA_EXT_ZAWRS,
+	KVM_RISCV_ISA_EXT_SMNPM,
+	KVM_RISCV_ISA_EXT_SSNPM,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index b319c4c13c54..5b68490ad9b7 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -34,9 +34,11 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	[KVM_RISCV_ISA_EXT_M] = RISCV_ISA_EXT_m,
 	[KVM_RISCV_ISA_EXT_V] = RISCV_ISA_EXT_v,
 	/* Multi letter extensions (alphabetically sorted) */
+	[KVM_RISCV_ISA_EXT_SMNPM] = RISCV_ISA_EXT_SSNPM,
 	KVM_ISA_EXT_ARR(SMSTATEEN),
 	KVM_ISA_EXT_ARR(SSAIA),
 	KVM_ISA_EXT_ARR(SSCOFPMF),
+	KVM_ISA_EXT_ARR(SSNPM),
 	KVM_ISA_EXT_ARR(SSTC),
 	KVM_ISA_EXT_ARR(SVINVAL),
 	KVM_ISA_EXT_ARR(SVNAPOT),
@@ -127,8 +129,10 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_C:
 	case KVM_RISCV_ISA_EXT_I:
 	case KVM_RISCV_ISA_EXT_M:
+	case KVM_RISCV_ISA_EXT_SMNPM:
 	/* There is not architectural config bit to disable sscofpmf completely */
 	case KVM_RISCV_ISA_EXT_SSCOFPMF:
+	case KVM_RISCV_ISA_EXT_SSNPM:
 	case KVM_RISCV_ISA_EXT_SSTC:
 	case KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_RISCV_ISA_EXT_SVNAPOT:
-- 
2.45.1


