Return-Path: <linux-kselftest+bounces-28104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E74A4CED0
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 23:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F191898643
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 22:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64CA23F412;
	Mon,  3 Mar 2025 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rw2Ic0j3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24FE23ED52
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741042396; cv=none; b=KQiwoV3NEl/Ebj/zBzbhPBn0DzTCIm20Dyf8zCgz8mVm0IhxoI6fN3S3oj3diqwCW8VDJ0OWGD75R238YUqReJI40yHGZ5QyJ/PIGJSjsRx9PhA3SzGQ0jAdT6bfkGpxnrvjQaxJldcrnfbwmfiIFd7YiU1xJeBIFdFQwGBcluo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741042396; c=relaxed/simple;
	bh=gBJ6uGpDPU8VQvhfth2yUutlzUR6uu8KN/4t8mgGmWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CtnEZ6yaqpdPSvel071eH7zvyb7qUvQIckGp3DEpvwRCFEiyk0FrAJUxfLXyaaCf8KeqVAGv/ZqX3Qye53G6G+jjWAdGeu2S4SqMFz3j+GcnOPXJ56zyVBEZFz/4d7Pm+Ns4HJG6cNu9vhVh/a+bQSLlU/ZFWnNGDlRPRKBcmYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rw2Ic0j3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2233622fdffso95039265ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 14:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741042394; x=1741647194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5xoxucipI3r87CV5kbgeUb/z0QLUAJbC0b2XlScuLU=;
        b=rw2Ic0j3xtkPH5LOGEOzDrhI//tfDv7NUln4/ovKnCAWLlp2odyXKMBNCkL8tmQr1b
         BijZYi3maGEJae5FyLgl0p7zTT/VBS9tlibysY0nINZf1GjUlGQEyyEyI2VrffrghxUZ
         GofPyfjlVVQ4qC4i0R7VqLCPPX1Bs+k3MqU2aCLrZIjmvWkouO6OqlOzNVAz6wQHkwN1
         Vqu6ZyAZscDwpOjgSrteRa7FMx5x0hWKPKXS8upLHgacv7qgCiD4HWMWtIEJ/yWBENSR
         g4gpcvrLIvL5ZRzP8QlyK1JnvIHPrvK9V2o/aws0n1uNK625KzRv+eUkKEJHyZudS2bK
         GOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741042394; x=1741647194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5xoxucipI3r87CV5kbgeUb/z0QLUAJbC0b2XlScuLU=;
        b=oh7CaJA8ty0GSP2alQQkwcdETKS8p7wtl4kESoW2P8721PDrIj+5Jqy+bU7finuYus
         YMatnDSC9Ow7EPmRwv9UiYm0zwNip3/7kAiQkaAlrYLqmVrTORYJMDiS3L9U71hfNLt1
         ZgGprtzoL4dRLQGaTAgKe6YVAGrtc2a8dhqd36yE5mkBfn0uCTL90nxkSzfCJ+Hhc/9W
         +sM4447gJ84yjcOpobxtygGAt7zdO1DxwvUE/usbe1zbciYKizRBLvJvIUMAx6qlyGBX
         UAbt7otdj3kZxuUdg93KhhIjtYvFeoTFYTWJ+n+ULH2ZvbEWfpUajHYiB1TR9g6BU1iL
         Izww==
X-Forwarded-Encrypted: i=1; AJvYcCV7nylSahq/Lc633o/LtH+zQhNe8vY5oyiXqaXxoYfCedIxsasCui6vBG8dSFUvfMplt9bAUndxYgD65aNXQkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUak6Ow4Sbs7b+Ymgajsl3eLL07EOTVKRUZsFzoIQz3zFa5UXB
	Nsyb2k7otQ9CA5+wXrDyMXbgnDqgnZnZDRsl/a/RParQEooBmN04JZUzmEO8hduXVtFdYqUFuig
	t
X-Gm-Gg: ASbGncvNnOvpFVPAk6asSGPigsIjMpQgj9qv06HP7qr0ps5aBH5inXm1kdaiiwQFRNL
	oasOomYZmoUnWc4fbHEr6Ek8Gza6dFDbnpQON1utj+Ko6MqYVyy8Nyp5jvURfHkNayjgiNycv2a
	ry16B3Aw7WcvSwGoQRff/fVl4ScB0P/f6YJgLdSgieYfgSRs8lcRmvVWyWPc3wTrtMknCJEXyF/
	nV9AD/Q3ngEJEcC9m3cUU9oXqV/1Qw+ihIe9OLxTmd+0WcnYc4Rq/GJUjJyMnnIvViMYOGyjavT
	S4SbEDKXDkjsyV0yLR8pqCJTbrTB/Vh6nMEjc1Xn7bzxkm+LM0WfJY6qaw==
X-Google-Smtp-Source: AGHT+IGy8hMH+W8RZy5SJOGyzi1MeiJvJku2zV+j7M0txVehkixRDHS/MmEvMDbU3gziq5b3wIbZEQ==
X-Received: by 2002:a17:903:230c:b0:21f:78f:c178 with SMTP id d9443c01a7336-22368fa5425mr202955235ad.3.1741042394242;
        Mon, 03 Mar 2025 14:53:14 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003eb4fsm9440601b3a.129.2025.03.03.14.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 14:53:13 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 03 Mar 2025 14:53:07 -0800
Subject: [PATCH v2 2/4] KVM: riscv: selftests: Do not start the counter in
 the overflow handler
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-kvm_pmu_improve-v2-2-41d177e45929@rivosinc.com>
References: <20250303-kvm_pmu_improve-v2-0-41d177e45929@rivosinc.com>
In-Reply-To: <20250303-kvm_pmu_improve-v2-0-41d177e45929@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

There is no need to start the counter in the overflow handler as we
intend to trigger precise number of LCOFI interrupts through these
tests. The overflow irq handler has already stopped the counter. As
a result, the stop call from the test function may return already
stopped error which is fine as well.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
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


