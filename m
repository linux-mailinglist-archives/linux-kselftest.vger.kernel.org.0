Return-Path: <linux-kselftest+bounces-29725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC202A6E7A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 01:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE943B7B22
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 00:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47679151991;
	Tue, 25 Mar 2025 00:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="S+rchpqw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7DB13D89D
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863247; cv=none; b=Jc2GM9iQn7EczlnE0gPPlLaoTMg5xteQNXUFRPfpQazBCs8/K5qFasV3lof6E0SfIRnAZSPppxa+8l/e2y2Q23f2NPS1v0SzSAkw4LFjHmFi82cfQYtglNiXcrUI40D0sJiapIxrhuHdNdAlufRUrVs6TdnPDL376hdBi4Zr/g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863247; c=relaxed/simple;
	bh=QN3DCBPWjckW+ez0UByt9KYuOWBHnXzOgLR953n7h0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jXH8HHOEgiS69RMZ0FjEbICxOu4GUgqiD8p+HRMemt0INXb+aI6iln0LLIveC2kJUh0JW1vqSY4YJamO7vIeqkNA47mSF+IO5ovD9VXIiClVz9Wg5JKLB5v1ybgZOFgxWM9u54vuUxf9REeGqg/99ottCzCfbQS9dfNIJ/5ejMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=S+rchpqw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-225df540edcso116624495ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742863245; x=1743468045; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNqfGek6IDvMlkuJpE58iTKo9lOFsf02qvhKRUoqiBo=;
        b=S+rchpqwX3GqxetPRwgVkbKcIbDUhzD5zp+05pG88hfrAtn05/C3DtLSgJah9XLsow
         Ci/R633dCnYoWbztOXMkM8N/TWkq5eytQbwqYI6Pf5HjLvs0rT/ueQKvNeOZQ9XqAA6/
         2seT/U0G4Tp22BR3jJQ92tYyeGh1tK38P/eG50umCBuwqCpxTToy9Iz0QuKhNIFTl2QL
         JReO3iwL/tUEWXR6LDueJ9h8SrKC3CT44vHfOpO0R2qbEBapXn+nKcSJnO85rBnr0HsZ
         2KYX9ut354DUCTDn4CV0q9+jcy3Y6+HHt9l7rsoN9beUglovm1x+J945Dtk1nZu1M+U/
         IaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742863245; x=1743468045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNqfGek6IDvMlkuJpE58iTKo9lOFsf02qvhKRUoqiBo=;
        b=VL74ZDG5nYrFq7lMYkBeJnAWg9jBnA5Oi9AZ4yQmjNwj4IJSw+30cS4F8GLP6iY2Ag
         yVhhde4vO3Qbcy0rsS+CLpZ+/0orofSf0dbt4ZTOkW6pe93fEpWaDtqC3YR1dah/nXF7
         wfg8OBvJAgDYd20UCKh5ZNsrLKhJIyd5e6fwfWmws3OUi+CMUQ86+K1/H1VB64wD/cmz
         0+pd7wNrwGJn8dFzv5nQ9cQAFPLkmY+bUgXbBjjQRI9w2g6hoSGhPxRc84sM4eK3mNhU
         7xYGuLKETlXw4G9Shp7YxfNgCeGryPj94pVFJ2aTa6Ew1PtW83lBvqFQitPdmP+VNeBc
         sHrw==
X-Forwarded-Encrypted: i=1; AJvYcCXEWTezKJJUXGUa9S/b952tMz3bc0zGRVjweTARzABuTQnvnnQU/R7kZRT8wZ+ywVz1idy/QuWDHSZoq4PwAvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Pmy4MUj0lFhhmsy9SIPRkdStdPxMak1M+ymHX3Wmiz9gEG1S
	WFqUmm/bMHxsaUprqRDQsWsRx+WWtsmKn2aCmQBEQTIJ1+WQnbXGrEN9gFfhZIw=
X-Gm-Gg: ASbGncsIbOKItmRpRjFF+EnVTf+Ig1l7L+io1nskkdXX4EFniD7LHzE/3/01KRyFan9
	qxdreWH74+fdp3L/aILRS/cEXKT/rhCvgCsZfpBgqXKTYSotPKuuD8kafYX87RrEcSl0hDLMC5N
	HFOpXcu4w48WJyLzIiqgjL6yJJQtoRf8bKy/lAqn+v7MqTlXqkTGjvI1cLiN/2qeC46jUt5PNMd
	LVRZC6K8OIo9T1N7wHHZyEDZ3RCvVOLFQT97ydPLeX/+bQpK+kXOHos+arudvxqHE/tXgBEeLW0
	q9wkT/VGflohaNC6MRcRhyQd2oXekBXeyUv/IWXs5Z2vZ4lmXOQ8Xm9Zzg==
X-Google-Smtp-Source: AGHT+IEyY0aS2TVZ43j4wneKeZ/YRErGKGqWBRTFQa7kE7mGVqq6ifmaSYPLNtOafQQXufixCh8D6Q==
X-Received: by 2002:a05:6a00:638d:b0:736:aea8:c9b7 with SMTP id d2e1a72fcca58-7377a08766dmr27319740b3a.2.1742863244847;
        Mon, 24 Mar 2025 17:40:44 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390600a501sm8705513b3a.79.2025.03.24.17.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 17:40:44 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 24 Mar 2025 17:40:30 -0700
Subject: [PATCH 2/3] KVM: riscv: selftests: Decode stval to identify exact
 exception type
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-kvm_selftest_improve-v1-2-583620219d4f@rivosinc.com>
References: <20250324-kvm_selftest_improve-v1-0-583620219d4f@rivosinc.com>
In-Reply-To: <20250324-kvm_selftest_improve-v1-0-583620219d4f@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

Currently, the sbi_pmu_test continues if the exception type is illegal
instruction because access to hpmcounter will generate that. However, we
may get illegal for other reasons as well which should result in test
assertion.

Use the stval to decode the exact type of instructions and which csrs are
being accessed if it is csr access instructions. Assert in all cases
except if it is a csr access instructions that access valid PMU related
registers.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
index 03406de4989d..11bde69b5238 100644
--- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
@@ -128,11 +128,43 @@ static void stop_counter(unsigned long counter, unsigned long stop_flags)
 		       "Unable to stop counter %ld error %ld\n", counter, ret.error);
 }
 
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
 static void guest_illegal_exception_handler(struct ex_regs *regs)
 {
+	unsigned long insn;
+	int opcode, csr_num, funct3;
+
 	__GUEST_ASSERT(regs->cause == EXC_INST_ILLEGAL,
 		       "Unexpected exception handler %lx\n", regs->cause);
 
+	insn = regs->stval;
+	opcode = (insn & INSN_OPCODE_MASK) >> INSN_OPCODE_SHIFT;
+	__GUEST_ASSERT(opcode == INSN_OPCODE_SYSTEM,
+		       "Unexpected instruction with opcode 0x%x insn 0x%lx\n", opcode, insn);
+
+	csr_num = GET_CSR_NUM(insn);
+	funct3 = GET_RM(insn);
+	/* Validate if it is a CSR read/write operation */
+	__GUEST_ASSERT(funct3 <= 7 && (funct3 != 0 || funct3 != 4),
+		       "Unexpected system opcode with funct3 0x%x csr_num 0x%x\n",
+		       funct3, csr_num);
+
+	/* Validate if it is a HPMCOUNTER CSR operation */
+	__GUEST_ASSERT(csr_num == CSR_CYCLE || csr_num <= CSR_HPMCOUNTER31,
+		       "Unexpected csr_num 0x%x\n", csr_num);
+
 	illegal_handler_invoked = true;
 	/* skip the trapping instruction */
 	regs->epc += 4;

-- 
2.43.0


