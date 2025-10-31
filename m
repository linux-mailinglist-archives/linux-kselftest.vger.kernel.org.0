Return-Path: <linux-kselftest+bounces-44481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A857C23248
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 04:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29E5F4F0FD3
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 03:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880A9244671;
	Fri, 31 Oct 2025 03:16:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DAF19E7D1;
	Fri, 31 Oct 2025 03:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761880617; cv=none; b=WKzV1M284fxlJ6v+wbc+sGEGku4xcRNT7X1VUGFwX7jW+CEmUT6Vt97D9eXkISThJEitmGjLt0cGHp5S2PEQY4LUh3FQVZPKaK1ZgytbM5hAwJCkBL/5GJrzBoLEVcWt0Az9iJQY0rAHgRjrK07DXKdQ/qrlyAJppjoAz52o2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761880617; c=relaxed/simple;
	bh=OupdCito8KXOWmdl+haqV9nwx66a8x9a5epBhc4k0x8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kPhaZX29NVxOl0nmSIfNLNVDJG0gFmgZ4ny/fM2xzFngB91M9Ml6Zqs7c1phbtwssOQz1DpsKcjAcp9HcI7FQ0luggk4jz2IOBqIR4BXzhKXj5vvK6Ze80wn5iAEqV6ML6znIrePrgqNvs2yh2jnOc8VwIOMlvphCUS7/e+FGfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Dxb_AlKgRpWO0cAA--.63468S3;
	Fri, 31 Oct 2025 11:16:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxjcEkKgRpxMkeAQ--.48052S2;
	Fri, 31 Oct 2025 11:16:52 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH 6/6] KVM: LoongArch: selftests: Add SW emulated timer test
Date: Fri, 31 Oct 2025 11:16:52 +0800
Message-Id: <20251031031652.4020879-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251031031227.4020738-1-maobibo@loongson.cn>
References: <20251031031227.4020738-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxjcEkKgRpxMkeAQ--.48052S2
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
index 1be42ef33bf3..a30dd0414a34 100644
--- a/tools/testing/selftests/kvm/loongarch/arch_timer.c
+++ b/tools/testing/selftests/kvm/loongarch/arch_timer.c
@@ -114,6 +114,45 @@ static void guest_time_count_test(uint32_t cpu)
 	}
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
@@ -123,6 +162,7 @@ static void guest_code(void)
 	local_irq_enable();
 	guest_test_oneshot_timer(cpu);
 	guest_test_period_timer(cpu);
+	guest_test_emulate_timer(cpu);
 
 	GUEST_DONE();
 }
-- 
2.39.3


