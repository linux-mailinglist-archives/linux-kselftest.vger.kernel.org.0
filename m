Return-Path: <linux-kselftest+bounces-8195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 089128A737D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 20:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60601B23019
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 18:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E953713A3E2;
	Tue, 16 Apr 2024 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JsQZ3Vkq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95579139D0E
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293091; cv=none; b=W4qc3CzCGBe6WxwR3eAqPi3ZlypbzPF8P3eemp5RWYGu1XtAADnQDT4RxgLBKbGCu6atp7cf3wSlEpyILGtZY6NbqSelompZFeYTFO3q3sjw7zQMLA5fK96aYnSsCWUokXRqwzDOu4q3G5isV8VeJi1OM7/gnEm5K4IJK1lepmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293091; c=relaxed/simple;
	bh=akgdKSazpCJozBL9deA+0ximAc5a6b6WW9ag1TZQiU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dp4X6AJKrmb/DqfhIdKJmGRbIHhz2i8Hq40lvRXSf7H44wb60AXpKCjXf34Q2EhqPTZgwr6gN09T0Ij5xdIPF0ZoTMmvXD+Sporj1Szcosb+vVJ+Vj3LqK1jk1CO5wD35LNVFMxyDCAWCVkCV4rNiBtZengYkuAxq264kYkRX/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JsQZ3Vkq; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ecf3943040so3838309b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 11:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293090; x=1713897890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkMvEzo278xPIa/MSXztYs2ivQ6wYMeKBg/aNDTTbzU=;
        b=JsQZ3VkqjXvHHU+77Vrv9wwB873ugOsKHttOzF+wr3sLEluFhKMf+o4GXfbxn+hvEx
         U4aXYtndUDdTRS3CrbMtZQ6s4SzWggKnFCcSHZ7kkuri/+m1LjN7XZzB4axAAXPkkhZ7
         GcPj8pzeVJbaJa4NctStgPnUbtR9jZzvpEwjcmm/ppP7py7JsCqqEbZOPxaJESpfGwxg
         7kXV3kyj1SHUVNTuUK+J62cfXyENCxgiQfK1nBXm8f5pZYU+/9juG5Jz0DrVVxwaBkNx
         bUOiZ6vf01iusaX6TEy7L/D2mENYL9UY8+Qd7vL3c88S6kQEGye7BpeXlKnuBxfYTbpg
         UhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293090; x=1713897890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkMvEzo278xPIa/MSXztYs2ivQ6wYMeKBg/aNDTTbzU=;
        b=M/R0QC2c62eYN+/PU2uke8c8JXLFFFrpaBp0yTxm3XXuZ0xRIsTgrGqkoxXpvpLmdv
         eW2gVphYEM4MNTIomHTXihavBdwOrSwjD93h5KuxN4XnZ5YnESj8ajzJrAlC24reUHs8
         dkA9Z0+Zo4dZA1UxXSheDp18oS+5KlGFPAGFcJFgOe63O6Fg/e63Ri5zpZV7Xm/ard82
         zdDlQGLNItvPYNC8NIIVYj0bV+ETwEGQBdizyqIEE1XqYKUwBux9OzUfdRKO/4Yn4hPl
         a0MDO7dsZpQHH8PrIFgIG5p+cYl3ttd6BU0qbdvQyIsd8HjbVtV9rLwiQMDB1NgJrn7S
         tOqg==
X-Forwarded-Encrypted: i=1; AJvYcCWBGkwufWhjcyAzvLxpLwrE5oc0S8tPyOoYQY9E41d9yfT09K7ugN8olNnxModHppSWJQuPeA17WCgkbGWOwS/aNRM2pGmunAT3H1FCOJ7U
X-Gm-Message-State: AOJu0YxwmiUGOkCwNxxNAqvmQleIt3mtS2Hy1fHoAf3A7Dn1LD/3XgNl
	yYqgyZo9YSkQaMjC642zoUw9Oa6E2KWkiuosKHupzWH1Jpy260KJVZoBORqNRWw=
X-Google-Smtp-Source: AGHT+IGM/xMcNq2URIBfBDJhi/NG6PhYcgLXKc1qFGAS/Qi1GtucOy269101P8ESZBPlkDMSrXALyQ==
X-Received: by 2002:a05:6a20:6e22:b0:1a3:3c5f:2ebd with SMTP id go34-20020a056a206e2200b001a33c5f2ebdmr10182304pzb.59.1713293089911;
        Tue, 16 Apr 2024 11:44:49 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:44:49 -0700 (PDT)
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
Subject: [PATCH v7 06/24] RISC-V: KVM: Rename the SBI_STA_SHMEM_DISABLE to a generic name
Date: Tue, 16 Apr 2024 11:44:03 -0700
Message-Id: <20240416184421.3693802-7-atishp@rivosinc.com>
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

SBI_STA_SHMEM_DISABLE is a macro to invoke disable shared memory
commands. As this can be invoked from other SBI extension context
as well, rename it to more generic name as SBI_SHMEM_DISABLE.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
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


