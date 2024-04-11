Return-Path: <linux-kselftest+bounces-7625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0118A0469
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 02:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42122872A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 00:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AEBECF;
	Thu, 11 Apr 2024 00:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Td/SAsbT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5AE12E5D
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794102; cv=none; b=qU7ioSBA8/zX0DCSQBwe4pSWErFih7eMzjNhInRBjdiVdKA1DMyrqylD6XFcwAQWHCUjpyUEwavFPjbAJmBp8JiHiJBpe3hMjJNG3fOEQph4GvlRdcdiyg8AkvZNbt8pR16i4BynYsZP0wU5UTdAuHj6nhei14qDtYVhIO9e88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794102; c=relaxed/simple;
	bh=Gs/9X2hzactn0W0hn5UFwracoeJp45KmCczLf6NHuME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tStJkwdvUTiCVBDHc17p9qhKnIVcQMkHp2Jrjv6blr56mCGGOQI8lWyI3+k0UIp1pQCrR8R9qUoMNi0yM+YGdYcC7cKntNXKkqpSyFzQ51BkN+JC6wQOtnpPBgShv+bFywzkT/hN35Nfq0VkcM3xCQrjei1NvFuL1xRQnEsQnag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Td/SAsbT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e3e84a302eso31084685ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 17:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794100; x=1713398900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0lXa0RA4+kQWkomLRJk1QW7kf666EFgaJ2j58l79bA=;
        b=Td/SAsbTdUUi7LSLzUm3R6cAmFJfWxmMB58IhUc5B3zxnxECnKg0l8sce7BrafFyhC
         0r0hrXE6AT4rm+f6ZPMf3T8wWNHwmMGalNvb5HSX2huvk0pvfDMZZTv8AlsWd6gbHTBa
         uMqCoi/5QnSHnYUVX4Vqbznj82fbBTqc+ow/jrsid03rRBP5tWZ45MHuEw7fdmu3m8bT
         Io6Bu0kdN4huTeuOMsRkFb3MkJ4mZfssiGoAhzNZhx/hsjo6hd7+t307zaVNgIBdtsYA
         kNNu54AD40zjpIXw1xfUKCP+TqQ4CjcQMcLLo/nyKwcELD90QRoycgUlopnmco34A+y6
         pi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794100; x=1713398900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0lXa0RA4+kQWkomLRJk1QW7kf666EFgaJ2j58l79bA=;
        b=At4w/CTnvwx81NIwVYBTWeab71dseCA3rSzW+mY9dxxn/uzm/J/BnYCmRGRrNlRiK6
         //VElgSo2PEGueVvSPrQWhbtUaFnRb1+2Kjo9XVX5IE5JlOEiV/NLClbtc2PtIBRxK/i
         jfJluYcmP8EHhT3ozGCMvLzeMLQjg9ax2axbPmtbMbNGWTanL/90/zUPoBa3gYzzKLGi
         hDH1GQW+sRa/810bRrr7TodbZyVep3vT5W0pGHJeGu2dnuyww5zBEr17OxhZb8X/2G2d
         ZJs1WuBL7IXvegDNjv9R13jzHtZVQbHNpyYlNtgQhMRFleqF/LpX1NJEDWsXACUZrYnO
         M28Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxtrvTiuP4Kf16RNgZh9igvo2eBgJIRMm6BOuD/2WrCrGXsFImsFPXQxfzwLZIDMeewW2AZhUwFeDjBKaEv3/O+fDKb6S33GhD7sRbH6pL
X-Gm-Message-State: AOJu0Yy6JENwPC+6I4HoSbGf3vdydY3+iRBJslofMlE4du5oQD/XnfJ1
	X30YZO+qaxOWsw0XvykDjgQ0Sa3Xnbwth3b+EAwS5Ao3lwnwT4bZU5KZYTy82sI=
X-Google-Smtp-Source: AGHT+IG4zwixXE+Dj2Z6xxpk3Mi1/VNCBH2ZloMZOp3yafHfcqNRvPGneczPVceqD8IMMcr1Pkob/w==
X-Received: by 2002:a17:902:e886:b0:1e0:11a4:30e0 with SMTP id w6-20020a170902e88600b001e011a430e0mr5583510plg.19.1712794100294;
        Wed, 10 Apr 2024 17:08:20 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:19 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Atish Patra <atishp@atishpatra.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
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
Subject: [PATCH v6 05/24] RISC-V: Add SBI PMU snapshot definitions
Date: Wed, 10 Apr 2024 17:07:33 -0700
Message-Id: <20240411000752.955910-6-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411000752.955910-1-atishp@rivosinc.com>
References: <20240411000752.955910-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SBI PMU Snapshot function optimizes the number of traps to
higher privilege mode by leveraging a shared memory between the S/VS-mode
and the M/HS mode. Add the definitions for that extension and new error
codes.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 4afa2cd01bae..9aada4b9f7b5 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -132,6 +132,7 @@ enum sbi_ext_pmu_fid {
 	SBI_EXT_PMU_COUNTER_STOP,
 	SBI_EXT_PMU_COUNTER_FW_READ,
 	SBI_EXT_PMU_COUNTER_FW_READ_HI,
+	SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
 };
 
 union sbi_pmu_ctr_info {
@@ -148,6 +149,13 @@ union sbi_pmu_ctr_info {
 	};
 };
 
+/* Data structure to contain the pmu snapshot data */
+struct riscv_pmu_snapshot_data {
+	u64 ctr_overflow_mask;
+	u64 ctr_values[64];
+	u64 reserved[447];
+};
+
 #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
 #define RISCV_PMU_RAW_EVENT_IDX 0x20000
 
@@ -244,9 +252,11 @@ enum sbi_pmu_ctr_type {
 
 /* Flags defined for counter start function */
 #define SBI_PMU_START_FLAG_SET_INIT_VALUE BIT(0)
+#define SBI_PMU_START_FLAG_INIT_SNAPSHOT BIT(1)
 
 /* Flags defined for counter stop function */
 #define SBI_PMU_STOP_FLAG_RESET BIT(0)
+#define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
 
 enum sbi_ext_dbcn_fid {
 	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
@@ -285,6 +295,7 @@ struct sbi_sta_struct {
 #define SBI_ERR_ALREADY_AVAILABLE -6
 #define SBI_ERR_ALREADY_STARTED -7
 #define SBI_ERR_ALREADY_STOPPED -8
+#define SBI_ERR_NO_SHMEM	-9
 
 extern unsigned long sbi_spec_version;
 struct sbiret {
-- 
2.34.1


