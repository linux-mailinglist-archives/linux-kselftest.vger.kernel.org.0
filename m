Return-Path: <linux-kselftest+bounces-8207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785D28A73B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 20:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C74E4B246AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 18:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D81413D8B4;
	Tue, 16 Apr 2024 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="snwywB6x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A13413D29A
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293108; cv=none; b=gUW5Lt8KigLJpQjx0nYJgkUhnOQqAnL1PxaYxWnwj7STChf1aHqjfG6VyvZkbOftqaDwIkXMvgQ2G/Shkw3AmXOnb6svusQN/ycZvVIwlQCuJaENDXs7mAFDMq8z3vV0Dkpx62xGTOWxVqXLZ6EbsvyB+8I3+RGPWJEnVJHAZsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293108; c=relaxed/simple;
	bh=RcVsdOTpWmQDe3QFQB057eZKtxuHNPDvA9mLhc2A9Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uRUN4vpjeW6/CUdBWboAtu0jjjt9OB9SUdqoJdSg3hPxqXSGqM2eI4RT4qfyG9IQRvUFcrTW3hdO2uOBuE1nj730B5SKptjllMYjuppmsPp9/WIe5/LmIUOH582NHNVRGfZo2oS4H5iyUchuEjvDRWZWN4H6ur6MMq/HWFK6FYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=snwywB6x; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a55a3d0b8eso40186a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 11:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293107; x=1713897907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBWeKaYtpXhvKjSg+whNN/rWnhjngNSIx7A/W77I8WQ=;
        b=snwywB6x/3UYo6Sz2k/vaH6cYHfVblxy4eiN9A0CLwoitN8wmbLafPdvyXRVGVeQhk
         Hyz2dcCSctc8pwk6cfhBRob2ORmU1ApcAnc3i7La9eX5UlOKIRvCbxx9dbAVzFYIH18h
         mAWJRhZMYBgsf4EyPk+SFCql4ReGh5bcZ4RhEZwh2ZK4PcknxW5VTi4e21BDzIRluQvv
         84dG0jZLcUonrVg4FSLe524JTsE6/FzHUMsVfKEg/S1VvEE7ue+qSxtBmeWmjd7rtJSi
         x7A4d1rlJPNz+2mIJ0Dn3Rs+PU4U9hra6wjYUjin2gZVBnkPMSb/tDH035uJXu3qMdig
         Okqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293107; x=1713897907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBWeKaYtpXhvKjSg+whNN/rWnhjngNSIx7A/W77I8WQ=;
        b=jhhrhbxHRcDEjxArMDR6WgTKnrvCpUZDIn8M4HeJNL4es/hhYwaYm+bjfPCTl/OrFG
         FXQ6WfRiHY6doRdlYyZGQJo8nq2vUlvu3ETHdZmKAGkDu38AT03PDXUgO5ikrKLi5FCg
         M0sTh7TOwQrQaWDZsq+DWpn5/KkmdZ9Nj8qysKnd333TP627Ceo5elIY9jOpsFPEcLbz
         s8WtPs1B8Fw12DGq93sJ86GK7080cUkDpg7Kh6VytMaVPRSnfIN2H9zVRkhE0e8z1WFU
         GZVYi5giePw3CyWq6nF9VpM63T2FYR20u/OBOrnsKUiTC5Th3EVoBIqlb36rrJh+7OtD
         lFDg==
X-Forwarded-Encrypted: i=1; AJvYcCXh7hz0aj0Y8WBGbrpCdavg53qX8wSLUW+5NyxbQDsjt5M1Hvj05OuVDDk05OZYeBKJ52y2lXlHT3YRcwA66NNit9KXBjTmA0NMfsgi7hNH
X-Gm-Message-State: AOJu0Yxap/f2k325CzXiwCQ69hQaEUDmMyX3CsmgfX5N3WrkA5/knLva
	YBwrXqYONqb1Rl0uC23rbXLp+JylNnTcNQ9VnG/miInL/SgTKe4LHRNsgljtvlc=
X-Google-Smtp-Source: AGHT+IEmOJnsCqKgMiSjK9JvIG/qr/zmtZv2INOC30OQkmamLtid+925iE6tPmkwso7m5t8fIgxSaw==
X-Received: by 2002:a17:90a:bc1:b0:2a1:64a:bb63 with SMTP id x1-20020a17090a0bc100b002a1064abb63mr4135416pjd.2.1713293106909;
        Tue, 16 Apr 2024 11:45:06 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:45:06 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v7 18/24] KVM: riscv: selftests: Add helper functions for extension checks
Date: Tue, 16 Apr 2024 11:44:15 -0700
Message-Id: <20240416184421.3693802-19-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416184421.3693802-1-atishp@rivosinc.com>
References: <20240416184421.3693802-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vcpu_has_ext can check both SBI and ISA extensions when the first
argument is properly converted to SBI/ISA extension IDs. Introduce
two helper functions to make life easier for developers so they
don't have to worry about the conversions.

Replace the current usages as well with new helpers.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/testing/selftests/kvm/include/riscv/processor.h | 10 ++++++++++
 tools/testing/selftests/kvm/riscv/arch_timer.c        |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index 3b9cb39327ff..5f389166338c 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -50,6 +50,16 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t subtype,
 
 bool __vcpu_has_ext(struct kvm_vcpu *vcpu, uint64_t ext);
 
+static inline bool __vcpu_has_isa_ext(struct kvm_vcpu *vcpu, uint64_t isa_ext)
+{
+	return __vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(isa_ext));
+}
+
+static inline bool __vcpu_has_sbi_ext(struct kvm_vcpu *vcpu, uint64_t sbi_ext)
+{
+	return __vcpu_has_ext(vcpu, RISCV_SBI_EXT_REG(sbi_ext));
+}
+
 struct ex_regs {
 	unsigned long ra;
 	unsigned long sp;
diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testing/selftests/kvm/riscv/arch_timer.c
index 0f9cabd99fd4..735b78569021 100644
--- a/tools/testing/selftests/kvm/riscv/arch_timer.c
+++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
@@ -85,7 +85,7 @@ struct kvm_vm *test_vm_create(void)
 	int nr_vcpus = test_args.nr_vcpus;
 
 	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
-	__TEST_REQUIRE(__vcpu_has_ext(vcpus[0], RISCV_ISA_EXT_REG(KVM_RISCV_ISA_EXT_SSTC)),
+	__TEST_REQUIRE(__vcpu_has_isa_ext(vcpus[0], KVM_RISCV_ISA_EXT_SSTC),
 				   "SSTC not available, skipping test\n");
 
 	vm_init_vector_tables(vm);
-- 
2.34.1


