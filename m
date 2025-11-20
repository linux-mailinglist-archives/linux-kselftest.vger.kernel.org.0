Return-Path: <linux-kselftest+bounces-46071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5EFC7278E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 08:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 7E8D22C706
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 07:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A199F3090D2;
	Thu, 20 Nov 2025 06:58:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E43D3074B2;
	Thu, 20 Nov 2025 06:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763621915; cv=none; b=cj1W/aDk61RGpcZD+vW7/hKcRfPXBnkQ4hpitoYQQzo9TIoiDZ0QeMzlwyZjcwb/xiR0AlRdKG0xtVnS6YMcbTH+MEWylgCh0qFAHMTJlBMzpusfJVzFRvtYziFD0WOFV/NC9Dbv2UbKaLdVgpuAKoA/Qxa+0XkVDGWvYYIv/FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763621915; c=relaxed/simple;
	bh=p+KMt1TLy15eZk16ICKi5cOb+za9KmA9NZgpKgv6oI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jlxhyaOtSX0E8Caydaa/MXsnI9PbnqPm9Ql9oVnB4n2pF6CC1HDao2HGxIM4xIvqLtsQHyZv1qPhKjnyRYOvA0tyMEZ8uQSVBYs2HpUk/jYuxyMHF/Hh0qqLw7R+GCg0Oza8TIcodMrCTxoADOcLSnFeoLY8TZE6HJVxmzR8qlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cx778PvB5pDf8lAA--.14120S3;
	Thu, 20 Nov 2025 14:58:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxicD3ux5pSkU5AQ--.5850S7;
	Thu, 20 Nov 2025 14:58:23 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 5/6] KVM: LoongArch: selftests: Add SW emulated timer test
Date: Thu, 20 Nov 2025 14:57:57 +0800
Message-Id: <20251120065758.3064368-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251120065758.3064368-1-maobibo@loongson.cn>
References: <20251120065758.3064368-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxicD3ux5pSkU5AQ--.5850S7
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

This test case setup one-shot timer and execute idle instruction
immediately to indicate giving up CPU, hypervisor will emulate
SW hrtimer and wakeup vCPU when SW hrtimer is fired.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 .../selftests/kvm/loongarch/arch_timer.c      | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/kvm/loongarch/arch_timer.c b/tools/testing/selftests/kvm/loongarch/arch_timer.c
index a8b7ff05faf6..ff6c141f0e2b 100644
--- a/tools/testing/selftests/kvm/loongarch/arch_timer.c
+++ b/tools/testing/selftests/kvm/loongarch/arch_timer.c
@@ -93,6 +93,45 @@ static void guest_test_period_timer(uint32_t cpu)
 			irq_iter);
 }
 
+static void do_idle(void)
+{
+	unsigned int intid;
+	unsigned long estat;
+
+	__asm__ __volatile__("idle 0" : : : "memory");
+
+	estat = csr_read(LOONGARCH_CSR_ESTAT);
+	intid = !!(estat & BIT(INT_TI));
+
+	/* Make sure pending timer IRQ arrived */
+	GUEST_ASSERT_EQ(intid, 1);
+	csr_write(CSR_TINTCLR_TI, LOONGARCH_CSR_TINTCLR);
+}
+
+static void guest_test_emulate_timer(uint32_t cpu)
+{
+	uint32_t config_iter;
+	uint64_t xcnt_diff_us, us;
+	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
+
+	local_irq_disable();
+	shared_data->nr_iter = 0;
+	us = msecs_to_usecs(test_args.timer_period_ms);
+	for (config_iter = 0; config_iter < test_args.nr_iter; config_iter++) {
+		shared_data->xcnt = timer_get_cycles();
+
+		/* Setup the next interrupt */
+		timer_set_next_cmp_ms(test_args.timer_period_ms, false);
+		do_idle();
+
+		xcnt_diff_us = cycles_to_usec(timer_get_cycles() - shared_data->xcnt);
+		__GUEST_ASSERT(xcnt_diff_us >= us,
+				"xcnt_diff_us = 0x%lx, us = 0x%lx.\n",
+				xcnt_diff_us, us);
+	}
+	local_irq_enable();
+}
+
 static void guest_code(void)
 {
 	uint32_t cpu = guest_get_vcpuid();
@@ -101,6 +140,7 @@ static void guest_code(void)
 	local_irq_enable();
 	guest_test_oneshot_timer(cpu);
 	guest_test_period_timer(cpu);
+	guest_test_emulate_timer(cpu);
 
 	GUEST_DONE();
 }
-- 
2.39.3


