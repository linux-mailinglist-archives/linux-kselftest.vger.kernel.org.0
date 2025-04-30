Return-Path: <linux-kselftest+bounces-32003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDED0AA3F5C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 02:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22B807A5A7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E367C296FDA;
	Wed, 30 Apr 2025 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="euduTIYn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE76296FB2
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 00:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972336; cv=none; b=t4f4lk07pXQqT3fGUGeeDMA840HvdDI/ajQfIWacSTlmBALK8pMlTq0TkMPMisVnvc9noIKg97UrBJdHOOpmLI9TmR453X0ucniDtgItQrbhXbpFjWY2vee+XFfzGI3bhf1ru32eAfUV5B3aCXMntVWNsOg4t7fNYMUEOb/5VQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972336; c=relaxed/simple;
	bh=RSGcjPaduS/Rr2+m7GFeyx12/c/u9qEkw62le7TBEpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WJTRUL7OqLdQ1qGH4xyrwatXe6woADjGl4Y4yM8MtsrPB85X4sDEb7YyNQVTj0jT3NHCv2rrXSGy6SuonxrfCsp5ngtYH908fHYSqJuuNMOO47wjWk1O29pxGeIEAAUldwRXtG0zPxEFYu/wpG0zgdNSDjEq5S9ugNaIg6wYyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=euduTIYn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7369ce5d323so5605163b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 17:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745972334; x=1746577134; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXzfu17kptCXUybkiNKPVF1lS3Ix7IXO5RDr+gMnAkc=;
        b=euduTIYn4ntW8vVL59qEua2EY+MJLQmQv1XK/k/EKxmFtBgVpliBpYna9RIFwLQloZ
         gYYoK4HnDSc2W8u4Yr5DZRI0jFD34uWUVpUBInSufuwDgTuJIhe0Znq0r57uENcbaoQK
         1NMnOxMLkZY/evyIavXI0OaD3iyjFfy6Tn0p+Y29abX+UO3U+8OrSpB82U1e2eS3pl5W
         kaEPMXUqKwB8jM/wZw9E6b9DBHo0GfRIhmq97OPM/wFf7cB0Vlp2BsR8uaDbno71l12p
         LNYa7Jm+35iRkMsAHp686vcZ+YY8WG7ResW6POcRw8uS9s7l25YLcKEsiurZthrvlbNJ
         aPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972334; x=1746577134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXzfu17kptCXUybkiNKPVF1lS3Ix7IXO5RDr+gMnAkc=;
        b=SuvZmD0q31fRsbBM/Ear698mJZmbopXLIenFfpU4Sqxg2w+WzHCWuqcgZcnQWAr4jI
         5jpymhYiRDHoEcdmcTOU5zco6+4S45hnP9GfNI0flqCr+acQoe1eTPAym5WHDsMaZofg
         zMwWmGJAGNbFBfN1Wcwn4hzm2ez8KB27NplckMhi5j1l32wNJIQOtRoVaE4T4K/rhpuf
         7sue/wYIoRarFh62ROJRouxheUwXST7BP54f8IblXS8isS+lIxj//Uzq3ZVerMJo+gRW
         /mxpNLqVKMN4vbFpibW56Cvp2h3LgWPfEXCHLU8WSBqMvO0yMq08rQHXR41FtWFUNTIl
         Bdww==
X-Forwarded-Encrypted: i=1; AJvYcCUoHLyAZfYW/XUU3CezYyhdVXTo5aScAFgmqUd2NBFTDZ+1Yp28vLZjbHv8O6f9SsbWwKQZfmXV87mUYqClgDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyio6i0DGphgJL773rURRLTISVqpb8klOAARMr792IsOF232uQ2
	vUo3KkF12ECRQx9+1KGXQ5wHOtTk75PV/SAh3a3vF24KWIwW1MNdNCMEdIAxHkU=
X-Gm-Gg: ASbGnctOLFbYjIXPHxynidvEGLUs2rrUFUNQDv4qxtXrMmwKu5K+2GM89HoA9SPHw/3
	7uN0TRJnzPzU9+GSdbUyNe12+ge69ONl/p7UGasR5OHQbdJKUa/I6pDQ1sRKszZJN8j3xSfmtx/
	jKCyDpWOtdM0t7jH5jyC3sbsKkgDc9O/3emcp6m5lIyRiuP0vH/UFzwHrpUnQOSgnRFuB9GB1r3
	gYyTRbTYsu6zYVWOKpW6q5QlDh+DwBn4YaaQgApo9LVnRg3XWGfLTxmrYDoxhKVURXlSZ9a+p0D
	4yKk1/bgeO3V7nPCB1i+ekDLpCgFpsBIDFzuG5FTnZ7KqluFDXEosA==
X-Google-Smtp-Source: AGHT+IE5FGxbdrNxcaxfBpPfWj8KR2q9JaLnQXvsvsKUG6zRtpkDcoXAsF7QbIKH9zgJl0KjaYQMgA==
X-Received: by 2002:a05:6a21:6711:b0:1f5:5ed0:4d75 with SMTP id adf61e73a8af0-20a88e1cf7cmr1303250637.31.1745972334596;
        Tue, 29 Apr 2025 17:18:54 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1f68988ca4sm1907790a12.74.2025.04.29.17.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:18:54 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 29 Apr 2025 17:18:46 -0700
Subject: [PATCH v2 2/3] KVM: riscv: selftests: Decode stval to identify
 exact exception type
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-kvm_selftest_improve-v2-2-51713f91e04a@rivosinc.com>
References: <20250429-kvm_selftest_improve-v2-0-51713f91e04a@rivosinc.com>
In-Reply-To: <20250429-kvm_selftest_improve-v2-0-51713f91e04a@rivosinc.com>
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

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../testing/selftests/kvm/include/riscv/processor.h  | 13 +++++++++++++
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c     | 20 ++++++++++++++++++++
 2 files changed, 33 insertions(+)

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
index 6e66833e5941..3c47268df262 100644
--- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
@@ -130,9 +130,29 @@ static void stop_counter(unsigned long counter, unsigned long stop_flags)
 
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
+	__GUEST_ASSERT((csr_num >= CSR_CYCLE && csr_num <= CSR_HPMCOUNTER31) ||
+		       (csr_num >= CSR_CYCLEH && csr_num <= CSR_HPMCOUNTER31H),
+		       "Unexpected csr_num 0x%x\n", csr_num);
+
 	illegal_handler_invoked = true;
 	/* skip the trapping instruction */
 	regs->epc += 4;

-- 
2.43.0


