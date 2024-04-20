Return-Path: <linux-kselftest+bounces-8502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7C98AB7D6
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11801C210CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE0614A605;
	Fri, 19 Apr 2024 23:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xieOb0ar"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302CF14A0BB
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 23:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570499; cv=none; b=n+u6xCJT6O+hvmx8imXhtdg9u8t2SQl8XSq1iXAqAVrMryxqJfE2kNvnkRG+aQb7hBxp+pNtqTCoWEMTB13GhH9Fa24wD2DQQ5XO2PcZPGacE5qoPIlpm5FZoBW3g4iTQNWXo9Xp5lQ1Xd6RkfhMcWhBrqQWdzMDOlZEGQbSK8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570499; c=relaxed/simple;
	bh=RcVsdOTpWmQDe3QFQB057eZKtxuHNPDvA9mLhc2A9Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nME/cDSYN/b55LpPZmmjrAQ6PnD5fwvwzyaRXaszJkrhe0ztfkZCz32Y4BbMJzAHEh1kIk43Oq73n48/43hu9Fq3swVaXPiEN5xJ85GtU6MLkitiPpfbjFKm43ad4LWc1OxX6bY7GSEJ/7RkR4TJG0KgLreEigg0nL7rBFVADQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xieOb0ar; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3ca4fe4cfso20508795ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 16:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570497; x=1714175297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBWeKaYtpXhvKjSg+whNN/rWnhjngNSIx7A/W77I8WQ=;
        b=xieOb0arWyTG6+lGAyk1WTWhj2l1/GFbZH7Huk6wYnGLBf5LhRPwPuLqsp9/ZLWPsQ
         2cQLfz4jhYs78kXeUcV2vwWpezXV/60OzetILkrzht4FVMF3tVuJyaVloLDHi0wezCqd
         hlnJXhcQGmJEufHKM2q5RXrLtTBC2vQFj0rt0mC+sVe622QINRKtCecqYcQ+JdUxT4wz
         2MLZNjGevgKvQGo/BYw/hM5TN86wHibK5fONtXmYF65HWOAR37WSrKsoJHxkacLILBkG
         bYGXJkJ4t1q5X9jHBqwyievOUhyWki/Oy29nKBMuUfiUueWGiZgax+eijpA/e9IrD0Ga
         9Y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570497; x=1714175297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBWeKaYtpXhvKjSg+whNN/rWnhjngNSIx7A/W77I8WQ=;
        b=UHUpyZ7r82zz6hU8C/T+NYlEbk7m1ChBjRlu6ds3Pg5ancYUAdfVEKY4cNi3JcYC+C
         5ndg+CMwMJ4qdFpVkdd/UahgqLD3r0V6UAuRxxKHbsC7sRP0viHrnRthaawPUBwopRJm
         hpjODE/GwptyyXgxVa0NWqecfIWb+0PqBBMBV21vkZquYXh2ke1wQMhMEXrDe1U1ChIN
         GwybNpi5OJxH1luPglrewGFuvEn1jtg0FVvUKSTZe547ZMImnI5a618TgR3zoieHefH9
         XTi2UO8tGikXASfbqVt1zBOa2KMxZUzY4DwTb/Uuba+Z0K4jf9tNtZOjAcy2gVTUpVTJ
         WrbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKvRBw6JNFKilUH3uGTCFIlpfinq3UvIW92ICYxWUY+185Zb2H8U53fK6661S67CdaFlU5z0tHg6rkpKKR/BxywDviOICa7PlijA5BSomh
X-Gm-Message-State: AOJu0YwUmeyU0RUK6OgbnFGbO1xuW/wwZAg1dMAqkmS9WKnag/92UOVA
	ptNTvPVYiQSIEdoNlAKSk1YP7UbofCPLyyCwDEK50+PeTHORRKsp4dr/vCqOcdk=
X-Google-Smtp-Source: AGHT+IE2mHqGqaemrrX/cDzhjt11McUd9BYci2ip5fvQwZrUnUGPNDdVb8jlSh60g/yN+PhfEpHNag==
X-Received: by 2002:a17:902:da89:b0:1e4:2d13:cf68 with SMTP id j9-20020a170902da8900b001e42d13cf68mr5056407plx.17.1713570497604;
        Fri, 19 Apr 2024 16:48:17 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:48:17 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	samuel.holland@sifive.com,
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
Subject: [PATCH v8 18/24] KVM: riscv: selftests: Add helper functions for extension checks
Date: Sat, 20 Apr 2024 08:17:34 -0700
Message-Id: <20240420151741.962500-19-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420151741.962500-1-atishp@rivosinc.com>
References: <20240420151741.962500-1-atishp@rivosinc.com>
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


