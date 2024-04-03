Return-Path: <linux-kselftest+bounces-7065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642828967CF
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 10:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B5D1C2571B
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 08:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C5512CD9A;
	Wed,  3 Apr 2024 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qrZNpmB4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A726EB6E
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131550; cv=none; b=jrgDM+D3jUk/wBgdPTp6dug/oZ6yTeQbE+EdELoAXi0A+dQU6HkykpVvUiK6HIoQtsr7xio+/k5iNqvqEeVZt9Ytyi6NctQSfEAvNsLn1QI2f7+xfcsvFC6/EmauhtK/Wx9GDdTIDfMtwHLotZwe5vhRNc4rPjg4HT1UB7ibPDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131550; c=relaxed/simple;
	bh=evlE8hTl45MyJIsfxvr/2bRxoIA3bwQv3sS8gzvU/GA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E8NuH32OI/9ZzKkq067WaKU8s+k1IBY1TBkO/wt8+AShFVrdMBhMV2xhLx/kraMIsGq2X/Vy/oShoVGGzmOWW/CF+1Ij2xT3yUy9MGeF5nGmAugiMoErnckKiZNrFR2SP68mf/fu2miYoZzkMNGbNqebCW7J5Q1LtIZrnrS9+lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qrZNpmB4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e0878b76f3so5697945ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 01:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131548; x=1712736348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiceCABnvA1jknfstt9FkxftBmpWokdNdmMlEhNsfyg=;
        b=qrZNpmB4r8FVIKopd0jjyxjIxIdnf4x4wviyHS9shXYzJV4XaMpmInQsbIFO0XCMSs
         a94P0h5iGIIKHFlWZf8KtZDQ7MDxG0CWZXXuNBJza2XxApNnP+hdqFwCT5PPtmpZacVH
         xaHpwZdF2wubbvVBI8C3DKvqXGiDebPLtnMnLF87Q1bguL9C+LQoD3A3Jf73cG03/Cii
         ymIS0+W90OiS4SjSwbWIaPAl/fSnaNxDPnc1+fQktlJvDTdFukiNMokDb5FHosJBSHmD
         IH6bQUJ/82pF4J1cLtua3sSMak+Ey9ntxdkVD0kaETrkjaGmUtY0nhukh38YHqeVfUaO
         GOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131548; x=1712736348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiceCABnvA1jknfstt9FkxftBmpWokdNdmMlEhNsfyg=;
        b=pQxucRQREd3GqtaGfSUWiVu3WN1/JC20KjAb49f9I+pmyeVobgQoWLnuyh6s0RfDAt
         4j04VGHn7AQuQ3F+Pb3nPWpP5p8y6WjLO/4LiZvapkMYmlL1xaQVZTtRBUPUeiDENKyu
         xVrdAqqUharGvVP/H1yGidARnmik0ZVcwPNG6tefIpn9vQmQG7yoYzjaZTsdJiMuIX1T
         E98cEz/8cl0YE++4m7Uue/kMy6rN3Rkm/qoyi726M/v8bj0m2rNfXSns4ToiGhuDx+AQ
         pgpkdJi4PlAewqBIo5iNdAbojjm3n/FHPDU3/x8DUk9VnFqlfqnVLDV+vCCM8z+hcS01
         7zNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcvYSojkhB8YpEDl85CiJYaFR8/1LzL33bkWBXfv1ZDc0lqVAOFyrvvA35fPT4PjL+xzRFum90WTWp6A2r79UZAfuPgDDabuf8ghFMAxJM
X-Gm-Message-State: AOJu0YwL1fr/L9skoDaxMDL8Iro9jZzx920a+Ln+iOZayhz2jvmJWlMQ
	D2NdOeCZ7eTTLN5AsJxHpQq+PjxOMBzh7lqMUvfTYd+1tqAK+wb6t3Fi3oEmhW0=
X-Google-Smtp-Source: AGHT+IEPeMI0z43MjvlBXsAsUdkQGTsWnPaqF+QUoQ1JhMqwDtA7d+BW/HuEGoVFyjEvifPOaGIfHg==
X-Received: by 2002:a17:903:181:b0:1e0:e85c:72dc with SMTP id z1-20020a170903018100b001e0e85c72dcmr2464037plg.19.1712131548509;
        Wed, 03 Apr 2024 01:05:48 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:46 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	Andrew Jones <ajones@ventanamicro.com>,
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
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v5 17/22] KVM: riscv: selftests: Add helper functions for extension checks
Date: Wed,  3 Apr 2024 01:04:46 -0700
Message-Id: <20240403080452.1007601-18-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403080452.1007601-1-atishp@rivosinc.com>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
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
index e22848f747c0..6a3e97ead824 100644
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


