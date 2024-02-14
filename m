Return-Path: <linux-kselftest+bounces-4628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0991854954
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 13:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29061C22A58
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 12:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9E6524C3;
	Wed, 14 Feb 2024 12:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ge47c348"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9628553399
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914297; cv=none; b=hp8UY28TYGKCxF8cVJf033od80Sp+kKblPHq21H3XQwjqHRaVFvDYimAKy4bGN0It/Zwr2Ps5ewFFY4elVrIkLXIHARQpLr+5Td343F/J9yD6dn1DX/HDG53NnS9UGWgfwAGP1YRpT7VVO7iRQfhaCQ/CVPA08GN60Ze3SGBNFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914297; c=relaxed/simple;
	bh=6QZeD1AO6jaMPVgZLUW3lzdEd9llclpipK765KkoodM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vk1hNCEKoIMa8E5/XeUwFRv6y0LxZnWQHNDScr1xS3lsb9fawQbqDa0lFZFrson9S4giPNOAOTMdA2vUJKQ69cl4T6NVuCN6Dv9MjSOFV0yHD53n1VMTDblSznQpSjokUz1JSqGx3UtplgkdwRJhNjf5Ml7z2vqJuPUXbDRwK9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Ge47c348; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d95d67ff45so40396375ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 04:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707914295; x=1708519095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48Kvlzn+su9jY0Vm4vzOkE0bGPI59LwwBJsDVuHcE+Y=;
        b=Ge47c348Q7koa2fKV8W2zDI3ujFKZRqRl284TAZkPedA/xhXiZUqpjlZrsyYPFyZaz
         KA/UG2KZRpK/GbcbD/5IDKjdVUL8X+heHv8iLjj7fol2FFOG+XFLBQgcgKdQPTgWBW2O
         wWlBocPBe7rIQdpmdYrb/vpvy5R1iGf8rhDaZh3B2ZIs0vYVN9eHsNQuXKvYqKqmh5pp
         IiE9xzOSTzei/JRCisGNpzdP74PKKxm8DdTKlXDhgTjecrb3aUPbZPz6MdDVFkHVoDvj
         4e+ezJ5Tr0OQaOWr+JNeH4v2/rt0KtLC8D2xUPPVTSWIVbiAOPImuZGGfhpSFcMB7Jdf
         sqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707914295; x=1708519095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48Kvlzn+su9jY0Vm4vzOkE0bGPI59LwwBJsDVuHcE+Y=;
        b=tgLnbA8mqIn4QmEYyXTf/q5KDaH2qREzMCIProUFScdl4mqLdmnFmraL9T7MLlh8LG
         jd2E9GCftW74GTTzpMH3RcnglKm9c3I70/cidy7Kdqdi/eXKh51BhfXhdi8yaVtjg6ja
         YokCRLCZxd9TAYXrkfBl3hK9eBqtb7L2pxUbLT904LPhfg8gbzLV5SnA6jVtAi8io+b2
         xqqtiRcdrWyVjnbxkVx8+UqYM1qcY3BucbibD3ziQIgMR1L4peCI60Cd8KMj4G2GA7dA
         GbQNSGu29GVig+GXKH/1nxkSZyxHWKe4aCFR5A7UHmbJx4T09Sc7Oo0HhNx+Pzo61jR8
         Uo+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqmawQSdbEo8dqhBXa93HICnNBOac/SurZqfroJ5+CVGs8nZAsYqnLswwnn/9XF6UayAAo69Q+xN+slF/M4TfCa1MEGd+BZ8/1hWz6foJu
X-Gm-Message-State: AOJu0Yx52nsPYVe0ifW8t1lHVbwt0WY8U0bYQVm6+B5t/NPcqK0DAMcD
	wYUABd2yiwt9kODwFqvFqiYiSndW2fRlD4gJJCMcoYar8OxJqEI3BAzGVae1S9w=
X-Google-Smtp-Source: AGHT+IHBBqpiWCuJIjRqRSpJp+W5dWbQ/msDnFRpAixpKjNS/H5nLpSvKlq1jB9lqsMLcmMLqvQUCA==
X-Received: by 2002:a17:902:6945:b0:1da:1d3d:7937 with SMTP id k5-20020a170902694500b001da1d3d7937mr2048287plt.34.1707914294910;
        Wed, 14 Feb 2024 04:38:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVki2Z3WrTpY40NRvm8tEbiYTni2BOP+Vz/m0jnkq1LJ5nIO+BXlYi1+YpL55P6nAAeZ70tS6rcQ9FXBc3LngUk1k5rap6lkZDxjXcts6p25eXLJDfrYH7vS9egyGB4UHfdtL/1enUDxsGQhB+OI80ygbonY7xSQ64wveTP7NsHYgjG5ApUhwmP3Rhzv+qeKdHkfrgeOQHom7tgaE6ui7DbZayXPXniP3TFPS5Uu7E2sjC02J19Jd+MMwctwL9ae1I2h7DIr9BCekEbCMx/1AiUv4xIM/eYG2FTJJPp/HKszsYT8lcYdkaCYxNlCgP7Pq60zX306awYmLYC4LXuI6hvQ/LWXp4r16jEs6NgAfdlLjGPeotzI52MIwUqO5jWp1uTmrPuRVKHejbViJrghAPCZryiembfyb62EeNV7B5Z1eWNyeJDtBjasn0tww==
Received: from anup-ubuntu-vm.localdomain ([171.76.87.178])
        by smtp.gmail.com with ESMTPSA id o20-20020a170902e29400b001d9b749d281sm3041419plc.53.2024.02.14.04.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 04:38:14 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 2/5] RISC-V: KVM: Allow Ztso extension for Guest/VM
Date: Wed, 14 Feb 2024 18:07:54 +0530
Message-Id: <20240214123757.305347-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214123757.305347-1-apatel@ventanamicro.com>
References: <20240214123757.305347-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We extend the KVM ISA extension ONE_REG interface to allow KVM
user space to detect and enable Ztso extension for Guest/VM.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu_onereg.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 7499e88a947c..f8aa9f2ace95 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -166,6 +166,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZVFH,
 	KVM_RISCV_ISA_EXT_ZVFHMIN,
 	KVM_RISCV_ISA_EXT_ZFA,
+	KVM_RISCV_ISA_EXT_ZTSO,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 5f7355e96008..38f5cf286087 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -66,6 +66,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZKSED),
 	KVM_ISA_EXT_ARR(ZKSH),
 	KVM_ISA_EXT_ARR(ZKT),
+	KVM_ISA_EXT_ARR(ZTSO),
 	KVM_ISA_EXT_ARR(ZVBB),
 	KVM_ISA_EXT_ARR(ZVBC),
 	KVM_ISA_EXT_ARR(ZVFH),
@@ -141,6 +142,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_ZKSED:
 	case KVM_RISCV_ISA_EXT_ZKSH:
 	case KVM_RISCV_ISA_EXT_ZKT:
+	case KVM_RISCV_ISA_EXT_ZTSO:
 	case KVM_RISCV_ISA_EXT_ZVBB:
 	case KVM_RISCV_ISA_EXT_ZVBC:
 	case KVM_RISCV_ISA_EXT_ZVFH:
-- 
2.34.1


