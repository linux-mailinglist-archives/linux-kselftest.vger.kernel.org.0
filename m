Return-Path: <linux-kselftest+bounces-8485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91688AB78E
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8309D1F217C5
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6398313DB96;
	Fri, 19 Apr 2024 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KTw0WX+0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1216513D899
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570468; cv=none; b=M1CB8O8H1LhBloNejscet66t77DNqQYfRrgceDr3KEhgjde+vqzHuk/DcpjIaKC5yEcY8Aycpfj403TSQqNo2s34Pw/Pi262jLumjj0toLlP1/G1x2LLR15QqMh8lA1jbYx1JQaHAYuQHvsfTIw3RzSdExJ25zz8+rxMLNjtXZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570468; c=relaxed/simple;
	bh=CuOqtFD3uDjWgSKj5f6SchwsQQ87ZPABcb+EozPDHPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfiThjKlkztpnnK3h9F1CRprZYmyYqIK4F2BrNuRU7tLEzos2MaofOIOqUAZKCheiXG+Npq1h3fObliFoLhgKYvRAHY5RwVPEr+az50BXEkmfS8ngVcqAXJgFbTPeCYwP4kEpoTbyleKJBbOUtZHQJyRQqhP5KDGGGSDpNAT0yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KTw0WX+0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed112c64beso2361672b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 16:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570466; x=1714175266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1oS0ksNazYXtVOBgFTjTYlhVVLdg1h0owq7BrHVbdc=;
        b=KTw0WX+0VHeZWm/Yu1P+MpTSE4ZetoAr72TleH3PF3GFV5pOGPC4tVDtfvnR1KrsV4
         BPPz+U5714OJ7tq17iK4t19S9lkSTqufBRjbl8uPjPYkQcA5cRRb+uWqMdo6quN7jabS
         VibQ85hrgFjIct8zX8fvIkzueZYcyVwG/8w2SkLcWCGb+fcPx5HKTKCFqkcx8i3jmcNm
         UZ1jHyCKteLCcIfkB2ZAH/dxv3+g0g/oU8ZJvykb020Lp+kU9fSmv24M4RspVEDnAL3g
         rzNmKHt5JhAXM8npJPp9452ZzVibC9ucVjMuO8BDVwM+bauCmfmv+kQxdn05dvqXtfkv
         vIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570466; x=1714175266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1oS0ksNazYXtVOBgFTjTYlhVVLdg1h0owq7BrHVbdc=;
        b=IBKZeWQqvvL2czsO5lQpzKkxEYOoqIPZ99KxeUdYI6K8yEdJn7UainrZCeC7poLxTr
         s9SfN2+LKKB+AxXoS60vruLbloSzzW61O0hB3MoSbvXNaKBfkBIsTHiNGm+IfBBmHOSN
         6pPKet3C3w2BUqyPP38lltg2WUqpANm59rtBDAnm+A4nvQbMnIeFV6YaPxH7dId2/n1T
         pMr4WSvg+zGiIFEFylHkcarKLUhHUv0L4wB52L0mHrDXVw/JTU0tF42cFv9gan0QkLP+
         Hqtm6rNiC8Ai3ZV9299JVkjSDsz5GhJwtIZ8EhSH91MP8eUxT43BzX5LaKwkKlxTrsi5
         F6nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkJZ646Hftir+21R2Hc2tMXWsETKQy/6/wI0X3Ou7r5an4gPRxfNs26T47eQgTw91ghC7XO9qr1WCkY3mkGc0iK0qbfpn9NXV6z6k0rkcw
X-Gm-Message-State: AOJu0YxYT4WhjXkvnSg6ARx78IHZ+vNz+Hf/L3+KhvE10nUFZ+fCM9bT
	BknGhsg4BJDw4shMVOwhCI+CG+Cw0xdnN8Xr61lkoxPezAPUXmTIjWoPniRQRIg=
X-Google-Smtp-Source: AGHT+IFVCYaBvcy0sMILQIREFkDThLyGOm3uHSxCPt859IORFbCyXjP0cIaU/flxgT2NJkC34c1s7Q==
X-Received: by 2002:a05:6a20:100b:b0:1a9:5e1f:8485 with SMTP id gs11-20020a056a20100b00b001a95e1f8485mr3527584pzc.31.1713570466351;
        Fri, 19 Apr 2024 16:47:46 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:47:45 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	samuel.holland@sifive.com,
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
Subject: [PATCH v8 01/24] RISC-V: Fix the typo in Scountovf CSR name
Date: Sat, 20 Apr 2024 08:17:17 -0700
Message-Id: <20240420151741.962500-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420151741.962500-1-atishp@rivosinc.com>
References: <20240420151741.962500-1-atishp@rivosinc.com>
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
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


