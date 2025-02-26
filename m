Return-Path: <linux-kselftest+bounces-27654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D6BA46C57
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 21:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BB03AD237
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 20:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57B72571A3;
	Wed, 26 Feb 2025 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="f5A/MGIS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334F914EC62
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601514; cv=none; b=jFInhXmlv2gBcT5wUZT8vU/Cb7Er3ryTK5pJ7sLyuBgbUxUA9K+/+YhTt3elOqhd2ZuorheCCDqFXHM5VxeiRxi9X69stuEz91BA3BO8FvrmiliVsGAe3SPuBBIOkXcC3e5xYYHozN8t5wldiCcvPLVao5BoLdOKOnJYRN46IY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601514; c=relaxed/simple;
	bh=QBL/O8yP4cmvHwkIXxg+UQn9RcAHq1y3i0H/8OMhFUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HoptCsqPjuY0sJ+/iqifTiU9N/5a9mg8fupChy2U53ks/e+8zQAb8rg4q+H559G7OuPLxXpOsTHO/9q9Ic+j9KhfX6YBO7hl9xDaB3anW8FwFa9ptCr1VpGWQaiM2sZBKC2XXbWzOLQmRwbmZyqu6Z6sYhGnCsGCVPqxbujdEJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=f5A/MGIS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-221206dbd7eso3170045ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 12:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740601512; x=1741206312; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElQVVHGvy1PCJJEf3x7O3Wq4GDtnkpov0IINkskU+dk=;
        b=f5A/MGISzjFSrplNEjJKnl/3POUBYwbI696oW9ISqocm+RF1moBEyuauSmL798Jm2B
         MaIDz2DygXuvQ5sxD+ZRUZZHl9d/hR2lirJHDU0rRb99bRnu/8zoxv0s2B8tAMeHldtO
         R3RYksblxEoXwgRvEEmnjpJmfcgrrM2fHD3r8u9ZI4E3lw4ODDkJf8AjZZA2oasdM6HH
         9cm7j/eWlYrpPviN77cd2OWi8gvte12UeduYszP5VcEsBCN2hGRo4NiO8h4Ff9cbQJ3w
         OC5pUMOpSoypJBBFsQMrB+a+5TcCUcNQjE5s4vMtbb6NjFpHxOT62uYrfI6RHUrHSS+r
         g6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740601512; x=1741206312;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElQVVHGvy1PCJJEf3x7O3Wq4GDtnkpov0IINkskU+dk=;
        b=YoX1zcYXZ0P69XxHRxB+/q8+gfHGAT5KE0H/M9jyvSYIUnuWr0cO18V6p5fPwaMBBq
         /H4wbj+KOSs6ngzrn/KGn/MEhk+nUi0n/qtilLl4QIpH01wpKx10+8ET7xmtsPJf16ke
         3LaZVbHGLA9vGH8tnv9uhTbvmI+ucu/6p1pBsfn8UnYwnLRg92NDvWJSqdpu9g/cdBx3
         PEZQPAAE11jO9j4UNIuJFEyGf0p3SezJDc0/hYxp1mI8f0F5KPQkB0yBhKajasrGxkr+
         PTQUrzOTktrRiN9Km7gSHmTAfkzg8LzJm18fFips/uKYwWp+i80bDfCnPzpvj22btXej
         bHsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOZcc3RmWdudjERvTaWN8BAXwpuMF9IEY8wZm/OUK3iHhUABIyKS/7MAwuKmEJ7B+q8kJ8uuADT5ThzS5z7zA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+i5c+jgI2D3MSUolQSSdcc9b1d4++HdAkf87CpXdbAvSO9hHr
	A0Kl1rmA9Morvh5EuNzE9n9M5LBkXldCXY/ZSeh3z+nyUPGLD38ikO2CDQNOSwPBtZkyI/NjF6d
	S
X-Gm-Gg: ASbGncuLDD+X5bkRnuFCyuFITL3S6Xc6SDLB3EVoHbeG8J9Xb+Drhw73Sp54zGNV2K4
	f8iHQb7wDX77IctbSsOzgErZoLvJbwKvJN9uDygPK2vM7HiQ/ku4gW/01usO1dKF9+JVABYHF8z
	70eeXdW+X6NvYbInZwwR0LgFGkNSZLbeqtKPeY+o60bghG+p627wxTprpeDKd+7lCUohLl0cu0O
	5itnVuMl+D2PR0A7qKAgVuT80k7D8P5iAevCcJ12ujJDkDfYBBMEYwMyk1O08HYVo9UkQpF4HTj
	AnymOn43BuasneuK86MiIUKjWdi2LBf713XZBxw=
X-Google-Smtp-Source: AGHT+IFqbgodjU8bkbuDJlr/kSmLoWQ/SEWprjRdiuzVEUOwMd31NiSuNQgBjPeic2eXnfkR3SMW9w==
X-Received: by 2002:a05:6a00:a1e:b0:732:22e3:7de6 with SMTP id d2e1a72fcca58-7348be4650cmr6595071b3a.17.1740601512524;
        Wed, 26 Feb 2025 12:25:12 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f7de2sm4100963b3a.106.2025.02.26.12.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:25:12 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 26 Feb 2025 12:25:04 -0800
Subject: [PATCH 2/4] KVM: riscv: selftests: Do not start the counter in the
 overflow handler
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-kvm_pmu_improve-v1-2-74c058c2bf6d@rivosinc.com>
References: <20250226-kvm_pmu_improve-v1-0-74c058c2bf6d@rivosinc.com>
In-Reply-To: <20250226-kvm_pmu_improve-v1-0-74c058c2bf6d@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

There is no need to start the counter in the overflow handler as we
intend to trigger precise number of LCOFI interrupts through these
tests. The overflow irq handler has already stopped the counter. As
a result, the stop call from the test function may return already
supported error which is fine as well.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
index f45c0ecc902d..284bc80193bd 100644
--- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
@@ -118,8 +118,8 @@ static void stop_counter(unsigned long counter, unsigned long stop_flags)
 
 	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, counter, 1, stop_flags,
 			0, 0, 0);
-	__GUEST_ASSERT(ret.error == 0, "Unable to stop counter %ld error %ld\n",
-			       counter, ret.error);
+	__GUEST_ASSERT(ret.error == 0 || ret.error == SBI_ERR_ALREADY_STOPPED,
+		       "Unable to stop counter %ld error %ld\n", counter, ret.error);
 }
 
 static void guest_illegal_exception_handler(struct ex_regs *regs)
@@ -137,7 +137,6 @@ static void guest_irq_handler(struct ex_regs *regs)
 	unsigned int irq_num = regs->cause & ~CAUSE_IRQ_FLAG;
 	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
 	unsigned long overflown_mask;
-	unsigned long counter_val = 0;
 
 	/* Validate that we are in the correct irq handler */
 	GUEST_ASSERT_EQ(irq_num, IRQ_PMU_OVF);
@@ -151,10 +150,6 @@ static void guest_irq_handler(struct ex_regs *regs)
 	GUEST_ASSERT(overflown_mask & 0x01);
 
 	WRITE_ONCE(vcpu_shared_irq_count, vcpu_shared_irq_count+1);
-
-	counter_val = READ_ONCE(snapshot_data->ctr_values[0]);
-	/* Now start the counter to mimick the real driver behavior */
-	start_counter(counter_in_use, SBI_PMU_START_FLAG_SET_INIT_VALUE, counter_val);
 }
 
 static unsigned long get_counter_index(unsigned long cbase, unsigned long cmask,

-- 
2.43.0


