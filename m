Return-Path: <linux-kselftest+bounces-6862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C48758915E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 10:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517D41F220D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 09:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619F469E0A;
	Fri, 29 Mar 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iL5W1W8H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E74969DEA
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704484; cv=none; b=OvbSLfe+KUUxHFv9/NSXv5u/4v2FQxtpeeohdo7cX9Ign+LZnI9ivIYMLIFJgL+P772xXGO6boZQBVt6OiVrR73A5WX4JN6/7CpGP48sgeBN4pd07ym/Zg/C/2SKlD64+q5Dw7zX0V1dTqHPAVvp677QPareKXwSPCFQF3ytYh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704484; c=relaxed/simple;
	bh=CV2JPbXziG2CSHm4cLDaE9gjUQ7JZv4SP9wDAVQhAuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lS3345jt8pVg81FaEU+5i+sW+psYqdX5qdbW4OWAK85MOF2pZYNtYYo75B5ew86KaCzOEzT/cR0gWl7Tq0Qqpez5tJRbv5dvpQCZrQjWBfuvwaz2d8Ze6q+ER+Y0mN1N6WqedcXtMn+xpqxpC3MIcldmYUuIEXN5jKTbW4MZ7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=iL5W1W8H; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ea9a60f7f5so1560543b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 02:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711704482; x=1712309282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2BJOQ9wxa5k0Z60PWQjy0KWSd8OFBHkeE+vEvJtEEk=;
        b=iL5W1W8HpY43VjvnsAI/T5ubmyHaDFyhfwCn57dVpP3KsB+wrajKxQcvQu57nPaCTl
         Cuvdx/UTbJOi1AP5K1mly0Euj8cs29yYogB+ZN7zfxAuPH7cA8rp4AFY7PSAlhP/9coK
         IIzzzCIe09J2K2ttTc1qfBhTgF8QSyc2wo5YodyHv28EEt/IWyx7SE0Fl5TsF1IamAKT
         D8t20Zr7U0+g4xg7FoVhKO9UCSqI5Ndcj/uLafNogFMaYN+FrO6CVXPBg9pai2tLw76h
         FbuW1mbHK/7cq5507pkpKAOEUhgu7nofzn6oxg8s9PpErUVhxZJESRwGsQU0vRqlGMVs
         LU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704482; x=1712309282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2BJOQ9wxa5k0Z60PWQjy0KWSd8OFBHkeE+vEvJtEEk=;
        b=Dq0vWUw8AgkH9XfNLX6/vlba7Y4SJkFrBlfbX24UL0MUFOOOJIa6xuwDf/U/JoDP8Y
         DbS8FwDCdbxXZHQ+H7rXjlJpdHmwlhnqcEdTlXfxlqLsseHkdRe3/hLRjNLZpEsbLGdd
         LsfFKLpsRx3Mn3imnqGtGlwyjlD3CMFmS0TXQEX4GMKKPjs8i+7IgOQEuhtO6WpmikkT
         OwIvIHkJw3shCoBI1MUb1b7m76BlX10By2OFZ90lOTITDK/Fztb7aN8kM8Z/bK2tyMo1
         ims7BRIVoSUyi7Ywj8mwgV7QQKiP9dqXVMuLyOFzCpy5zDn1q4wfXOmsJ0fSrjPEdtQU
         NR/A==
X-Forwarded-Encrypted: i=1; AJvYcCXQd6oFDHRWWsSkowgPK2U4nwmnH9g3aB2hCOBbjsDF2SOuyNc8w+IVV6nQ8FzsGsCnp6NNzYY/k/UjgV0v3WuNjumT8tSaEcH1Z9DZKyHt
X-Gm-Message-State: AOJu0YzwImqiDW9G+zN+x9bTUwBpmWNuIr464sGMVH9vUlpzeubic42A
	qY6YF8k0iyhqFQ9OLvKhHlbep9dDqgvd3H0da5zE7tWlR8QKw+pQltiwPI4FTgM=
X-Google-Smtp-Source: AGHT+IF+IG00xBHcuGEuM8FjBpouIXGd2i1O2spwYlcOfF/yskdrf4gmePYkFHJj5HCFiJOPwSSmXA==
X-Received: by 2002:a05:6a20:89a4:b0:1a3:ae18:f1e4 with SMTP id h36-20020a056a2089a400b001a3ae18f1e4mr1227195pzg.34.1711704481705;
        Fri, 29 Mar 2024 02:28:01 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id cv17-20020a17090afd1100b002a02f8d350fsm2628830pjb.53.2024.03.29.02.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:28:01 -0700 (PDT)
From: Max Hsu <max.hsu@sifive.com>
Date: Fri, 29 Mar 2024 17:26:22 +0800
Subject: [PATCH RFC 06/11] riscv: suspend: add Smstateen CSRs save/restore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-dev-maxh-lin-452-6-9-v1-6-1534f93b94a7@sifive.com>
References: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
In-Reply-To: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 Max Hsu <max.hsu@sifive.com>
X-Mailer: b4 0.13.0

From Smstateen extension: the values of the [h/s]stateen CSRs will
be lost when entering a non-retentive idle state.
Therefore, these CSRs values need to be restored to ensure that
the corresponding functionality remains enabled.

Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 arch/riscv/include/asm/suspend.h |  6 ++++++
 arch/riscv/kernel/suspend.c      | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
index 4718096fa5e3..2ecace073869 100644
--- a/arch/riscv/include/asm/suspend.h
+++ b/arch/riscv/include/asm/suspend.h
@@ -17,6 +17,12 @@ struct suspend_context {
 	unsigned long envcfg;
 	unsigned long tvec;
 	unsigned long ie;
+#if __riscv_xlen < 64
+	unsigned long hstateen0h;
+#endif
+	unsigned long hstateen0;
+	unsigned long sstateen0;
+
 #ifdef CONFIG_MMU
 	unsigned long satp;
 #endif
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index 8a327b485b90..a086da222872 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -19,6 +19,15 @@ void suspend_save_csrs(struct suspend_context *context)
 		context->envcfg = csr_read(CSR_ENVCFG);
 	context->tvec = csr_read(CSR_TVEC);
 	context->ie = csr_read(CSR_IE);
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN)) {
+		if (riscv_has_extension_unlikely(RISCV_ISA_EXT_h)) {
+#if __riscv_xlen < 64
+			context->hstateen0h = csr_read(CSR_HSTATEEN0H);
+#endif
+			context->hstateen0 = csr_read(CSR_HSTATEEN0);
+		}
+		context->sstateen0 = csr_read(CSR_SSTATEEN0);
+	}
 
 	/*
 	 * No need to save/restore IP CSR (i.e. MIP or SIP) because:
@@ -42,6 +51,15 @@ void suspend_restore_csrs(struct suspend_context *context)
 		csr_write(CSR_ENVCFG, context->envcfg);
 	csr_write(CSR_TVEC, context->tvec);
 	csr_write(CSR_IE, context->ie);
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN)) {
+		if (riscv_has_extension_unlikely(RISCV_ISA_EXT_h)) {
+#if __riscv_xlen < 64
+			csr_write(CSR_HSTATEEN0H, context->hstateen0h);
+#endif
+			csr_write(CSR_HSTATEEN0, context->hstateen0);
+		}
+		csr_write(CSR_SSTATEEN0, context->sstateen0);
+	}
 
 #ifdef CONFIG_MMU
 	csr_write(CSR_SATP, context->satp);

-- 
2.43.2


