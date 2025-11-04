Return-Path: <linux-kselftest+bounces-44712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0712C30C49
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 12:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C3618C1803
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 11:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8692EA17D;
	Tue,  4 Nov 2025 11:37:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832342E8E00;
	Tue,  4 Nov 2025 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762256245; cv=none; b=CqQF92+jXRETUDB8AvI1DFP5UcUDILCB9QipCO1AaIo3F0LoqV+82aZH8U5l7LcbdQTQILUMyjhYzMqzlnv3IEuQDwEyXR8XXRS4sqOr3Ch3hthW5ggyouhPElUet/FrsWlQHhlB1gzaqtoJ0gaPgkDP1IZHkSIiAun1Zb6Yqvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762256245; c=relaxed/simple;
	bh=edbj2W3W9sG89u/NiKy0Vr7p5pOwZjU4SCA7YpuQaJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BlD0yv4j8gWGc5ng/yGGThw8ZvGFiDBfS8d96vQifVRltRhfCjS/DNw9tzNszGAptEsC5SwiH3MwGDuslqqEE70evWh/QPTlwHjoK2dv45b9iBAKspIo9Cm2eoWGR/eL31b4YOVpZUzIUGE0mh9oUF1UoYUrz0ohZ1ua8Fpxong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Axjr9t5Qlpf7QeAA--.64813S3;
	Tue, 04 Nov 2025 19:37:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxM+Rr5QlpWDImAQ--.51821S3;
	Tue, 04 Nov 2025 19:37:17 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 5/7] KVM: LoongArch: selftests: Add period mode timer test
Date: Tue,  4 Nov 2025 19:36:57 +0800
Message-Id: <20251104113700.1561752-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251104113700.1561752-1-maobibo@loongson.cn>
References: <20251104113700.1561752-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxM+Rr5QlpWDImAQ--.51821S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Period mode timer is added. Timer only need program once with period
mode, its compared tick value will reload when timer is fired.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 .../kvm/include/loongarch/arch_timer.h        |  5 ++++
 .../selftests/kvm/loongarch/arch_timer.c      | 28 +++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/loongarch/arch_timer.h b/tools/testing/selftests/kvm/include/loongarch/arch_timer.h
index 94b1cba2744d..b6399e748f72 100644
--- a/tools/testing/selftests/kvm/include/loongarch/arch_timer.h
+++ b/tools/testing/selftests/kvm/include/loongarch/arch_timer.h
@@ -36,6 +36,11 @@ static inline void timer_set_next_cmp_ms(unsigned int msec, bool period)
 	csr_write(val, LOONGARCH_CSR_TCFG);
 }
 
+static inline void disable_timer(void)
+{
+	csr_write(0, LOONGARCH_CSR_TCFG);
+}
+
 static inline unsigned long timer_get_val(void)
 {
 	return csr_read(LOONGARCH_CSR_TVAL);
diff --git a/tools/testing/selftests/kvm/loongarch/arch_timer.c b/tools/testing/selftests/kvm/loongarch/arch_timer.c
index 2a2cebcf3885..a4a39f24bb7e 100644
--- a/tools/testing/selftests/kvm/loongarch/arch_timer.c
+++ b/tools/testing/selftests/kvm/loongarch/arch_timer.c
@@ -23,6 +23,13 @@ static void guest_irq_handler(struct ex_regs *regs)
 	GUEST_ASSERT_EQ(intid, 1);
 
 	cfg = timer_get_cfg();
+	if (cfg & CSR_TCFG_PERIOD) {
+		WRITE_ONCE(shared_data->nr_iter, shared_data->nr_iter - 1);
+		if (shared_data->nr_iter == 0)
+			disable_timer();
+		csr_write(CSR_TINTCLR_TI, LOONGARCH_CSR_TINTCLR);
+		return;
+	}
 
 	/*
 	 * On physical machine, value of LOONGARCH_CSR_TVAL is BIT_ULL(48) - 1
@@ -67,6 +74,26 @@ static void guest_test_oneshot_timer(uint32_t cpu)
 	}
 }
 
+static void guest_test_period_timer(uint32_t cpu)
+{
+	uint32_t irq_iter;
+	uint64_t us;
+	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
+
+	shared_data->nr_iter = test_args.nr_iter;
+	shared_data->xcnt = timer_get_cycles();
+	us = msecs_to_usecs(test_args.timer_period_ms) + test_args.timer_err_margin_us;
+	timer_set_next_cmp_ms(test_args.timer_period_ms, true);
+	/* Setup a timeout for the interrupt to arrive */
+	udelay(us * test_args.nr_iter);
+	irq_iter = READ_ONCE(shared_data->nr_iter);
+	__GUEST_ASSERT(irq_iter == 0,
+			"irq_iter = 0x%x.\n"
+			"  Guest period timer interrupt was not triggered within the specified\n"
+			"  interval, try to increase the error margin by [-e] option.\n",
+			irq_iter);
+}
+
 static void guest_code(void)
 {
 	uint32_t cpu = guest_get_vcpuid();
@@ -74,6 +101,7 @@ static void guest_code(void)
 	timer_irq_enable();
 	local_irq_enable();
 	guest_test_oneshot_timer(cpu);
+	guest_test_period_timer(cpu);
 
 	GUEST_DONE();
 }
-- 
2.39.3


