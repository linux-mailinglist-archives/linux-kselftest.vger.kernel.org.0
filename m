Return-Path: <linux-kselftest+bounces-32022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A333AA44F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 10:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC6F3B0F2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 08:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05ED218599;
	Wed, 30 Apr 2025 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RBP7+1fs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3CF21423E
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746000998; cv=none; b=eBO2baFL0Nv+VO23+2LblC+0mgQ7ox+F9Klo5+A/JZxhRRigsn/XUTkdgdnCJGv5jXGZLD7XFLEORQvolO8vnBTRyQvbFw811B7WVZsyCP1w4sVBJVghryozVc9rafR2rQGPVRUYi2HrMZjS2wMaAE/G0XMq5/hemL5H00OLUnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746000998; c=relaxed/simple;
	bh=bGusNtEUlaX23wJD2XfALVYCzkrJMuPAiNTlbGcMBJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EoRiRJyLYyM5OnMDLRmEoQV1W0ld8SipVkozKfaKUdLK7JmbLwJLubrEkH3aOa5qOuTLVA2WKSCoC5C7S+KmJN0WQ8dZsdz5Ws5FVVzYRCshf8Y5V0+/E1ab3Z7nC6oLES43bOtm2F5+hIuZ9vrMK1U6TojUlfjHeV0FAFCGzeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RBP7+1fs; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7370a2d1981so5627566b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1746000996; x=1746605796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRFZ5FKZBztRGxrY6vVfDYbRzHdpxr6eQNzNURiD5s8=;
        b=RBP7+1fsgaaEszj/50cmRkgRo9X444NsS4dDL+X4apzaNhk3/dIGOmRe8Ij0JgEfGi
         ikOjlkUBSMjcVILPd4Qh+RxSzNbRD4s5sppoBXNnFZegd9oVurUCFsKgq0J4dKsUZsZa
         rqoYYdvO9J30T9sjOQD13DWdwHs3f4D/Sk/jdSd23RFJ+yD2uRfz5pHyAizzRfay9EVg
         39njVFsQPMt4dgmEPIHyBZUzBiGJpzSngtKjUiLrQZu8Zqtfb3PARx9KRwvp4mgTG9lf
         ge3BNpwPzGWyhbg72aPeRwY1E46DsnYDs+Z7t3+pTHfxlVBemFFSVOJsJLipbUlaFbSx
         gt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746000996; x=1746605796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRFZ5FKZBztRGxrY6vVfDYbRzHdpxr6eQNzNURiD5s8=;
        b=HURnhUMnNvcxkwe9mD5sBWcQgJgvSTYyo/lQyaq4znrd7fjK3CfoWmFZPLI+btN1zp
         2gUD4DhiK/PJsRSFAUVnYNQr8Ji9s3BOHi21UnTaOAAOeOYPyyZ+IHYzjTBCgNKDT2Bl
         MlwNiKFOD95V44wt1dm02eVWynCCRBwG27RxSn9qEIjJ9Ag7djmIaZGSMpQ7zNxEpB79
         KvaaUxAVrFQSTOdDmZejgP/woevd24UsqEVpR1/vVKybCITpJuQmbkpo5ofJhboXlANn
         LcmmNOc3+oeXFjpPOT7inpqms7CekQKaxvitDi3OUt5oHgbRVRHFE2rckkPviaPhl0W7
         ODJw==
X-Forwarded-Encrypted: i=1; AJvYcCXAcNRj944Hl7wohamXYmry+dm5qYtkzyMa+8F12N7RPb/mzLuRgZakdafLagxBrhccIQK35nQDDzmib/DrY+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeB6oJ32oJEOEjBd1e2hi9xTtOPla3BqZ8m/Ki84+e0W6MSco5
	em+jGYRjD5gZUiZkR4riDAEhFILRPLhj75HPXM8FlF2bMFY1DwESAANcCd45+8c=
X-Gm-Gg: ASbGnctGdFV6T75m6G/3SzMvkQAJI5n0jw/9/T7skJhlOdA9nlYe2OJari5zS/Y1eVP
	PGc/go6VjFNUe63OW3fHL/orffuJ8SVlcnpVX6p3FrMHnUPhks4uVb/ZPVsPwD8cXCu1oClvOaR
	/Vq4MtWcvkdBkBG0jCr6FDBip4aUz1Ld78KFp07Oswa6ziomD+ON+kJVDAP19Nejmuv4bYD4e6v
	7h84y0S7NNE777PAryHffrdK4iOraEz7I/ULFdJ8+JsoH+1ptTdyr2zo8vsTpqq9MICvpKGUFVG
	HxbNGqaRWmMqaElg7vh19SZufhU3EalpHVrrIfICthE+2e+dFTI6lJRb5RcZFupq
X-Google-Smtp-Source: AGHT+IGbD1Zl91/g/+st4aTTgt5Bkror5XgxZ0mOSUBOJaMyTd1yJdlz0KXAlGwPjFYFs62/1RdnzA==
X-Received: by 2002:a05:6a00:2e05:b0:732:2484:e0ce with SMTP id d2e1a72fcca58-7403a811cadmr2252321b3a.17.1746000996180;
        Wed, 30 Apr 2025 01:16:36 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a309edsm1073084b3a.91.2025.04.30.01.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:16:35 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 30 Apr 2025 01:16:29 -0700
Subject: [PATCH v3 2/3] KVM: riscv: selftests: Decode stval to identify
 exact exception type
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-kvm_selftest_improve-v3-2-eea270ff080b@rivosinc.com>
References: <20250430-kvm_selftest_improve-v3-0-eea270ff080b@rivosinc.com>
In-Reply-To: <20250430-kvm_selftest_improve-v3-0-eea270ff080b@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

Currently, the sbi_pmu_test continues if the exception type is illegal
instruction because access to hpmcounter will generate that. However
illegal instruction exception may occur due to the other reasons
which should result in test assertion.

Use the stval to decode the exact type of instructions and which csrs are
being accessed if it is csr access instructions. Assert in all cases
except if it is a csr access instructions that access valid PMU related
registers.

Take this opportunity to remove the CSR_CYCLEH reference as the test is
compiled for RV64 only.

Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../testing/selftests/kvm/include/riscv/processor.h  | 13 +++++++++++++
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c     | 20 +++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index 1b5aef87de0f..162f303d9daa 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -11,6 +11,19 @@
 #include <asm/csr.h>
 #include "kvm_util.h"
 
+#define INSN_OPCODE_MASK	0x007c
+#define INSN_OPCODE_SHIFT	2
+#define INSN_OPCODE_SYSTEM	28
+
+#define INSN_MASK_FUNCT3	0x7000
+#define INSN_SHIFT_FUNCT3	12
+
+#define INSN_CSR_MASK		0xfff00000
+#define INSN_CSR_SHIFT		20
+
+#define GET_RM(insn)            (((insn) & INSN_MASK_FUNCT3) >> INSN_SHIFT_FUNCT3)
+#define GET_CSR_NUM(insn)       (((insn) & INSN_CSR_MASK) >> INSN_CSR_SHIFT)
+
 static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t subtype,
 				    uint64_t idx, uint64_t size)
 {
diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
index 6e66833e5941..924a335d2262 100644
--- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
@@ -73,7 +73,6 @@ unsigned long pmu_csr_read_num(int csr_num)
 
 	switch (csr_num) {
 	switchcase_csr_read_32(CSR_CYCLE, ret)
-	switchcase_csr_read_32(CSR_CYCLEH, ret)
 	default :
 		break;
 	}
@@ -130,9 +129,28 @@ static void stop_counter(unsigned long counter, unsigned long stop_flags)
 
 static void guest_illegal_exception_handler(struct pt_regs *regs)
 {
+	unsigned long insn;
+	int opcode, csr_num, funct3;
+
 	__GUEST_ASSERT(regs->cause == EXC_INST_ILLEGAL,
 		       "Unexpected exception handler %lx\n", regs->cause);
 
+	insn = regs->badaddr;
+	opcode = (insn & INSN_OPCODE_MASK) >> INSN_OPCODE_SHIFT;
+	__GUEST_ASSERT(opcode == INSN_OPCODE_SYSTEM,
+		       "Unexpected instruction with opcode 0x%x insn 0x%lx\n", opcode, insn);
+
+	csr_num = GET_CSR_NUM(insn);
+	funct3 = GET_RM(insn);
+	/* Validate if it is a CSR read/write operation */
+	__GUEST_ASSERT(funct3 <= 7 && (funct3 != 0 && funct3 != 4),
+		       "Unexpected system opcode with funct3 0x%x csr_num 0x%x\n",
+		       funct3, csr_num);
+
+	/* Validate if it is a HPMCOUNTER CSR operation */
+	__GUEST_ASSERT((csr_num >= CSR_CYCLE && csr_num <= CSR_HPMCOUNTER31),
+		       "Unexpected csr_num 0x%x\n", csr_num);
+
 	illegal_handler_invoked = true;
 	/* skip the trapping instruction */
 	regs->epc += 4;

-- 
2.43.0


