Return-Path: <linux-kselftest+bounces-7057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5948967AA
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 10:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5A41F24EAC
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 08:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD5C8174C;
	Wed,  3 Apr 2024 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kj1jNd4T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5C48004D
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131533; cv=none; b=rb4jJccuylGhw7nRafVHjRxZf3eRnJsFhToKswao0iFcH6Q/OqupzdQgMubBpzTvw2ozl3SmrI2X7hoQWpr9GtmXaTVWSurmmwiHp9PulZh0L8XejldPCYb/eCwnyZHyC5m0q/zmBxDqOCNAWlQs3TWAMB6fI344WQ0zbmi1Pp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131533; c=relaxed/simple;
	bh=es6oj90niK7eIua41w4bb0VuAogviBB5JDOj1DIbVoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h3mD3c5JnHdBfSqR4CrkSHuf5LgbUeTePEqUXXL187IBur9RDt85vutEfpJAQggTUUhO2caozgzhUPnIdmmjxaeMwGDxlz70bT+2rn20SnIEDXz5Ie5z0PPeFxsV2PZ13NKfhxGr8CQC4nzJNfwd4NpTr6vbRUDif0t4O+YPVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kj1jNd4T; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e28856ed7aso8288135ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 01:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131531; x=1712736331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MJsU2/1DVF77yTSQMrmRq+eYVFGn04LSwUVmAHv4W8=;
        b=kj1jNd4T8fIHxcVBo6zc+oA4iL6egZxuQwfHFbT8z3Lqfur2HrQO/pwmBQsivMY8rW
         v2T+XavCkXLQlN1z/o+pjAuh/mRhz6/BQmNZs1SO/T1YyWu3pBcoh0khpDdz/iJmJnVF
         Jml3E+a2iYTsOq3E+xSYwN1y/zHwAnUo6MSpkVkQmX4o0j9FdYjhB5pOnUbR1grpcjaT
         IEEeW1IXghX2DWT/wn5TX8eIp8wAhfi9jq53iL5+4rs8oI0gu0zHkkGRYy2naSN73QrG
         bDtEoGVgdXEEjlIIofYSt7+rRLudeP3zVh77IjZUHNNpwg3GHe6De9D5zbgQ7jlZWRBP
         NLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131531; x=1712736331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MJsU2/1DVF77yTSQMrmRq+eYVFGn04LSwUVmAHv4W8=;
        b=FnScc6KvvVibvWmZ9jji/8pd6ZWIngziVeXky7xZ0bGI/JNjjI+MWyN1E05W8BFjrN
         KfXt6YoxNAGp3SDV/zcYA/YDWGjhQ7Sz+5ndgp+Qxp8gRf18z6FQnsrupTpppgRey+qa
         8vLrhd/kLKn2lCIJwvf+O/nMc88hAxMM4zv+eASpW9up2p4/icZ2QgJWfsrrKI5CtElo
         QGkbDDWaCm36KHKMQ7uNes3urJ2UxOin0Pa1ubaiyB7G6+nGBb0+fRWsi9BT9tT5hotl
         E8P4q7KWVIEqOHmqfEpPXe68gbwDs80E6ZVbicdAO4kCtvQ9rD/pubfckGmTJ1hh3IG2
         8fBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmgnLS65K0u0iRMUcW5EULWKioMcH0Lv4hZNorvXRKrl7hKXf2pRgNirGVYIy5GUIQcv91ZpsI9N/d7X+DJ01MXUqtQ62got8Wd7yjYrV2
X-Gm-Message-State: AOJu0YwoMxPAQJPdDMhp9jEmIbzWugn5GpPJvGhPdB/MBDslxKYqghQP
	U9shgG/Cd7Ts/c+Z4MD6K7zYiWOY4v+PB1cm4+gPqnBGZ7dtnJ4gtqAU6qrBukk=
X-Google-Smtp-Source: AGHT+IE6hcM+iluLyfs2xAMwl4nidxEf2cHLsogRdu+mNxI8DxtzYjnOXL+jL/8fbjTuoDpYxOz/uQ==
X-Received: by 2002:a17:903:244c:b0:1e2:6191:f6ae with SMTP id l12-20020a170903244c00b001e26191f6aemr2389190pls.0.1712131531142;
        Wed, 03 Apr 2024 01:05:31 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:30 -0700 (PDT)
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
Subject: [PATCH v5 09/22] RISC-V: KVM: Rename the SBI_STA_SHMEM_DISABLE to a generic name
Date: Wed,  3 Apr 2024 01:04:38 -0700
Message-Id: <20240403080452.1007601-10-atishp@rivosinc.com>
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

SBI_STA_SHMEM_DISABLE is a macro to invoke disable shared memory
commands. As this can be invoked from other SBI extension context
as well, rename it to more generic name as SBI_SHMEM_DISABLE.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h  | 2 +-
 arch/riscv/kernel/paravirt.c  | 6 +++---
 arch/riscv/kvm/vcpu_sbi_sta.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 9aada4b9f7b5..f31650b10899 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -277,7 +277,7 @@ struct sbi_sta_struct {
 	u8 pad[47];
 } __packed;
 
-#define SBI_STA_SHMEM_DISABLE		-1
+#define SBI_SHMEM_DISABLE		-1
 
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
diff --git a/arch/riscv/kernel/paravirt.c b/arch/riscv/kernel/paravirt.c
index 0d6225fd3194..fa6b0339a65d 100644
--- a/arch/riscv/kernel/paravirt.c
+++ b/arch/riscv/kernel/paravirt.c
@@ -62,7 +62,7 @@ static int sbi_sta_steal_time_set_shmem(unsigned long lo, unsigned long hi,
 	ret = sbi_ecall(SBI_EXT_STA, SBI_EXT_STA_STEAL_TIME_SET_SHMEM,
 			lo, hi, flags, 0, 0, 0);
 	if (ret.error) {
-		if (lo == SBI_STA_SHMEM_DISABLE && hi == SBI_STA_SHMEM_DISABLE)
+		if (lo == SBI_SHMEM_DISABLE && hi == SBI_SHMEM_DISABLE)
 			pr_warn("Failed to disable steal-time shmem");
 		else
 			pr_warn("Failed to set steal-time shmem");
@@ -84,8 +84,8 @@ static int pv_time_cpu_online(unsigned int cpu)
 
 static int pv_time_cpu_down_prepare(unsigned int cpu)
 {
-	return sbi_sta_steal_time_set_shmem(SBI_STA_SHMEM_DISABLE,
-					    SBI_STA_SHMEM_DISABLE, 0);
+	return sbi_sta_steal_time_set_shmem(SBI_SHMEM_DISABLE,
+					    SBI_SHMEM_DISABLE, 0);
 }
 
 static u64 pv_time_steal_clock(int cpu)
diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index d8cf9ca28c61..5f35427114c1 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -93,8 +93,8 @@ static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
 	if (flags != 0)
 		return SBI_ERR_INVALID_PARAM;
 
-	if (shmem_phys_lo == SBI_STA_SHMEM_DISABLE &&
-	    shmem_phys_hi == SBI_STA_SHMEM_DISABLE) {
+	if (shmem_phys_lo == SBI_SHMEM_DISABLE &&
+	    shmem_phys_hi == SBI_SHMEM_DISABLE) {
 		vcpu->arch.sta.shmem = INVALID_GPA;
 		return 0;
 	}
-- 
2.34.1


