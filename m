Return-Path: <linux-kselftest+bounces-32252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C55AA7D15
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 01:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F523AC5E8
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 23:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E9526989A;
	Fri,  2 May 2025 23:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vsWayHO0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28568266F05
	for <linux-kselftest@vger.kernel.org>; Fri,  2 May 2025 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746228689; cv=none; b=kdwEcCdZr26DH+tEIHU98wv50BdjohtXvmldL6uKhiaCmGcTiqMDRR7tQyDGJcWUY3YBxn552V+IPbNL8A1kHyPojafkzhxyenowMoD8tdNbbLDDnw8tFbA1TLQAczZiApR+Cb37LHiGsCGMFTsktwgoKpe5+b+yImPWsvUk2F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746228689; c=relaxed/simple;
	bh=jQexnjOya22ysgOQudOcRfuyX2ffnh58PKctRMnRFxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g5bfZ+1q50VO5d7UoHsWsobqUtAtsgcFHQLddOgsXk/OGjP1WUPeSKAW9P4VbGdQUbOWTwyY0UqYA/zX/n6B7NBxl+jYCDYuYNCmtv1wLG9600jTMNbZt3FhjFI7uHOYUNWMmRaNBf5cAFAzN+UyF6WrTfB0B1RAlstzi7mZspY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vsWayHO0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-227a8cdd241so33326975ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 May 2025 16:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1746228686; x=1746833486; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzG5aBj4uT4Cxy0Ye5VbMroQI6g4J7udAW2U71MrLVg=;
        b=vsWayHO0RMxWu005RtM1GrceuyFfOFcioIWKf55kyc4cPVzbPsW0cWnaE0KMlV7qRP
         PdT0j08L3p5UqFxkSMSqGfnNb4uv3JGq+vQVHRxMANtFnEDxKIXu6kKNuD5Pxg3580/L
         Q2EcZqyKisSg1wz4HpBsTdXn/SPwx6YvkxjTEXH3r64VKraYPZVxvAE8ofNI5I9GmkIW
         xqIcxufFmHdB6H+a8SEo6+U6h6OisNRWKG8WkvsSW+1KM71Xq3QXQwsRyudSP/rc+PD/
         GdT/PlrzgphRi/DqV545UU8us+GGF1LBAy5Q62DLoYLnvI63/qoeIR3/4yDa0x/d/B/U
         lYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746228686; x=1746833486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzG5aBj4uT4Cxy0Ye5VbMroQI6g4J7udAW2U71MrLVg=;
        b=dFCzo1y4tVUMYUfAeupDpRnoonK+PFse4e8fhF86eRuk7J/Dke/5rj4K9HMdTyd9HQ
         5LlrQ+04YWCSQmGN9244nMculD8Wr0fP41zMyL44dHkNHTSuP5Oc22q6TUtGcmMHaPPJ
         G1Q4LjW0yYM95PLX2AIRsU41NK3guS5Y3s4V4mTV8lDvi6X91/Gu2FxVTHTUwmEaXGKc
         W7qmSP4umuMJt9WXUxPow6ohTKI0Sh3OegwWEbd+x4VGxgdFqH3NZor9RtqkZw6yvLc4
         1LxKdLdxPI33GzZMSjgTizhrZ7C1oG/hZOzejjZ5f31f6UMVp5MBbcXTOzYaaPlHZGqQ
         vrYw==
X-Forwarded-Encrypted: i=1; AJvYcCUhl0LtSrMhQdjFGoulZxoWlSK7jBXoNcXPwqYYHXQWrp/vF9+aCG0BPLVp2Ex8JhzX2BIy5+X9YEyeEDDhAZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgYRcSmM8GRK41lQcvBXy1boAy0R7blWbyykl1Cbr3GLcuVqwP
	bcqbtPybTvd13O9ooTb1Uq2zRJAINmwYjhtdMEIp6vIrvEe5I+dcHNLiKhO2SeQ=
X-Gm-Gg: ASbGncswSriH6ku2bwTFPZ5PHRCMZTBtYDrAh+MGirJz88dOfFZkPOc4XaBESByhpP+
	qUncc8990srvI9iOTK5Jyr1GVytzDqu5Weti98mic5TJIhDd5wHoRKNSXX3Z+4YvxISaB0tJA3v
	gNVd2BKAdiBWK1bz1Yxsk5OOS1jkWUIjxyWnzGLyQlKdLnBfgx+mv1tu+DV/Mb4p1tOEI69CrrI
	B72fJ7tG975hbkkdqbQQPIIjhPogznhzh1t1pQhlbxD6VRSEdrF7nNc76dOMiyhyAs0yvapDHqH
	avBCM6cGvt3DqaMHlC/OEXByG9C0YOqRuAbfcs2I1AyQFmBN1uAgRMQJFtQrLw==
X-Google-Smtp-Source: AGHT+IF32JcuU/UOpoww4jQ7Vp+ZM8BNKMHRFkoqxGXs1BOMEDJfAXLOyJDQfQMNdHJqaOQDtkiE4Q==
X-Received: by 2002:a17:902:ea10:b0:215:9642:4d7a with SMTP id d9443c01a7336-22e18ac8366mr15406295ad.0.1746228686087;
        Fri, 02 May 2025 16:31:26 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228ff2sm13367055ad.180.2025.05.02.16.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:31:25 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 02 May 2025 16:30:46 -0700
Subject: [PATCH v15 15/27] riscv/traps: Introduce software check exception
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-v5_user_cfi_series-v15-15-914966471885@rivosinc.com>
References: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
In-Reply-To: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

zicfiss / zicfilp introduces a new exception to priv isa `software check
exception` with cause code = 18. This patch implements software check
exception.

Additionally it implements a cfi violation handler which checks for code
in xtval. If xtval=2, it means that sw check exception happened because of
an indirect branch not landing on 4 byte aligned PC or not landing on
`lpad` instruction or label value embedded in `lpad` not matching label
value setup in `x7`. If xtval=3, it means that sw check exception happened
because of mismatch between link register (x1 or x5) and top of shadow
stack (on execution of `sspopchk`).

In case of cfi violation, SIGSEGV is raised with code=SEGV_CPERR.
SEGV_CPERR was introduced by x86 shadow stack patches.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/asm-prototypes.h |  1 +
 arch/riscv/include/asm/entry-common.h   |  2 ++
 arch/riscv/kernel/entry.S               |  3 +++
 arch/riscv/kernel/traps.c               | 43 +++++++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+)

diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
index cd627ec289f1..5a27cefd7805 100644
--- a/arch/riscv/include/asm/asm-prototypes.h
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -51,6 +51,7 @@ DECLARE_DO_ERROR_INFO(do_trap_ecall_u);
 DECLARE_DO_ERROR_INFO(do_trap_ecall_s);
 DECLARE_DO_ERROR_INFO(do_trap_ecall_m);
 DECLARE_DO_ERROR_INFO(do_trap_break);
+DECLARE_DO_ERROR_INFO(do_trap_software_check);
 
 asmlinkage void handle_bad_stack(struct pt_regs *regs);
 asmlinkage void do_page_fault(struct pt_regs *regs);
diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
index b28ccc6cdeea..34ed149af5d1 100644
--- a/arch/riscv/include/asm/entry-common.h
+++ b/arch/riscv/include/asm/entry-common.h
@@ -40,4 +40,6 @@ static inline int handle_misaligned_store(struct pt_regs *regs)
 }
 #endif
 
+bool handle_user_cfi_violation(struct pt_regs *regs);
+
 #endif /* _ASM_RISCV_ENTRY_COMMON_H */
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 978115567bca..8d25837a9384 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -474,6 +474,9 @@ SYM_DATA_START_LOCAL(excp_vect_table)
 	RISCV_PTR do_page_fault   /* load page fault */
 	RISCV_PTR do_trap_unknown
 	RISCV_PTR do_page_fault   /* store page fault */
+	RISCV_PTR do_trap_unknown /* cause=16 */
+	RISCV_PTR do_trap_unknown /* cause=17 */
+	RISCV_PTR do_trap_software_check /* cause=18 is sw check exception */
 SYM_DATA_END_LABEL(excp_vect_table, SYM_L_LOCAL, excp_vect_table_end)
 
 #ifndef CONFIG_MMU
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 8ff8e8b36524..3f7709f4595a 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -354,6 +354,49 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 }
 
+#define CFI_TVAL_FCFI_CODE	2
+#define CFI_TVAL_BCFI_CODE	3
+/* handle cfi violations */
+bool handle_user_cfi_violation(struct pt_regs *regs)
+{
+	bool ret = false;
+	unsigned long tval = csr_read(CSR_TVAL);
+
+	if ((tval == CFI_TVAL_FCFI_CODE && cpu_supports_indirect_br_lp_instr()) ||
+	    (tval == CFI_TVAL_BCFI_CODE && cpu_supports_shadow_stack())) {
+		do_trap_error(regs, SIGSEGV, SEGV_CPERR, regs->epc,
+			      "Oops - control flow violation");
+		ret = true;
+	}
+
+	return ret;
+}
+
+/*
+ * software check exception is defined with risc-v cfi spec. Software check
+ * exception is raised when:-
+ * a) An indirect branch doesn't land on 4 byte aligned PC or `lpad`
+ *    instruction or `label` value programmed in `lpad` instr doesn't
+ *    match with value setup in `x7`. reported code in `xtval` is 2.
+ * b) `sspopchk` instruction finds a mismatch between top of shadow stack (ssp)
+ *    and x1/x5. reported code in `xtval` is 3.
+ */
+asmlinkage __visible __trap_section void do_trap_software_check(struct pt_regs *regs)
+{
+	if (user_mode(regs)) {
+		irqentry_enter_from_user_mode(regs);
+
+		/* not a cfi violation, then merge into flow of unknown trap handler */
+		if (!handle_user_cfi_violation(regs))
+			do_trap_unknown(regs);
+
+		irqentry_exit_to_user_mode(regs);
+	} else {
+		/* sw check exception coming from kernel is a bug in kernel */
+		die(regs, "Kernel BUG");
+	}
+}
+
 #ifdef CONFIG_MMU
 asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 {

-- 
2.43.0


