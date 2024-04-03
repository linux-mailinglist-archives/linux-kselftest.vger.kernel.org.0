Return-Path: <linux-kselftest+bounces-7049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B50896782
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 10:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9186D1C25223
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 08:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C7F6D1BA;
	Wed,  3 Apr 2024 08:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Jh5qO/+J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00C60267
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131515; cv=none; b=asDlEo0Fm+3jhROs7uLqZmwytDmeAxh3RtzJrB39Ewzc6kdSRWqI3n/8aGsNG+yUvmF9Kx1j3mung8iWq+oSLV7JdtbcJInDH2cKgUDmMywswr8xu12XbeHVSPUWqgcjWx0VHUJjU0k7ga8hf60iHom3RHeqt6LxC2qOKtE4MWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131515; c=relaxed/simple;
	bh=QPSBE9QZ9I3ka5tiVYaLmRJclnGfjz8CpXpruGJQvzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKM9siRqBi9b9OlwyGC0ZcP/jgnzas5uhRtM66+vg6RlLBYtXORkv+OYLZmO5cX8AcWQswtuucTznrmM4KTsGssVvu6g3neRrpjOpa/HRf2C4mQ5eV+bcp6qDalA9Uts/dfoMUgterBJdxQjkvKvSuS5wqtG9c5e2QcLoMnGMsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Jh5qO/+J; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0edd0340fso54649595ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 01:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131514; x=1712736314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wk9dPs2pdPMy/ouYyBMSDOPD1OQUOIvovvehkpc98kM=;
        b=Jh5qO/+Jj8wcgB/ufwV8mJL6YrXrofnTLzFgpsa198jYW5k5XiCnnki3noQara2nHb
         WQF1f77pG5O1RY/JA+lZX4FwJ1w8kw/JGKEF0bakvmaZ8dml+I4Xsnp9NohJ6a+VTH2B
         o3kGPlqwG64nEH5r8P1OckbN3reFARfNvvdd+PJPYyCCiEfMWY6977kvtQQZVJpotM2c
         v8Ed4pDzJxrfwfrW1skSjD39oUIDU75+iWOAoH1Sb2eB2G6MBl+yMMALvj3XOLelGyIq
         5oYhbCaGMuIp8kfy7MuENeERQRMWoWOlmJ56aRckrkECIz8ShRgnF2/oCfe/QfKPqe7n
         Hk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131514; x=1712736314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wk9dPs2pdPMy/ouYyBMSDOPD1OQUOIvovvehkpc98kM=;
        b=aTwH86ahs2by0kei9fIreLZC6g+6sqmJTVl8PEyg2aOE0vfdrv+aaAO58RJ9hM2eK2
         ItU9BtRRjF6a2YYuYVS5bDVjP609T3iOIJjZKPRhzXzWRAp+bUAjHNi3sInUlLlc8yqj
         lOPoJMYCHv+rx4mn5Tn0dil6aLWtfl0VpZ4xaCXHV2wC25p9mpxdNImsCiv443KG8GKJ
         Hj21sn711iDs4YdkS4lfVaviyITLd43oHXqvm0QDrZ3cyZ+EBODb+wa2NlC4Yv7H9BL+
         i30KAK4kISs1WUVIDVP3d8zNlg86vOuk+Hsh3r8DYAzAKLuVpkHJgjWhqy7+BiOwJRhe
         fx+w==
X-Forwarded-Encrypted: i=1; AJvYcCUUUgt0kBHg33qJImq54KYL8oUhf/cBHDQkEfYvaWXyb+kyiiL4bK3ZBtuvHhNoZEOdnUqEmBvV9OvJzJg8GPlv2ADPbTvaJEPNZTuDy3zO
X-Gm-Message-State: AOJu0YwbosiA9sKkcVbUae45N+27urAj7/8LZYJWWP6r9QDA7ziUiuDE
	JVDGNvDpqLY8F9B0eUAkUN/mue0tETERiZaIFmD/HWIpQ0bHcOUdMRBfdxLoGzM=
X-Google-Smtp-Source: AGHT+IGJGNXcOyb9YrykwAGNPaYyhw8xhsLdGwuGzUBrwVAzvp1h6eGWJ0tNbKMZggDJyDT4f6wwug==
X-Received: by 2002:a17:903:292:b0:1e2:6240:72e7 with SMTP id j18-20020a170903029200b001e2624072e7mr5865569plr.53.1712131513754;
        Wed, 03 Apr 2024 01:05:13 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:13 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	Andrew Jones <ajones@ventanamicro.com>,
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
Subject: [PATCH v5 01/22] RISC-V: Fix the typo in Scountovf CSR name
Date: Wed,  3 Apr 2024 01:04:30 -0700
Message-Id: <20240403080452.1007601-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403080452.1007601-1-atishp@rivosinc.com>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The counter overflow CSR name is "scountovf" not "sscountovf".

Fix the csr name.

Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
Reviewed-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 2 +-
 drivers/perf/riscv_pmu_sbi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 2468c55933cd..9d1b07932794 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -281,7 +281,7 @@
 #define CSR_HPMCOUNTER30H	0xc9e
 #define CSR_HPMCOUNTER31H	0xc9f
 
-#define CSR_SSCOUNTOVF		0xda0
+#define CSR_SCOUNTOVF		0xda0
 
 #define CSR_SSTATUS		0x100
 #define CSR_SIE			0x104
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 8cbe6e5f9c39..3e44d2fb8bf8 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -27,7 +27,7 @@
 
 #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
 asm volatile(ALTERNATIVE_2(						\
-	"csrr %0, " __stringify(CSR_SSCOUNTOVF),			\
+	"csrr %0, " __stringify(CSR_SCOUNTOVF),				\
 	"csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),		\
 		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
 		CONFIG_ERRATA_THEAD_PMU,				\
-- 
2.34.1


