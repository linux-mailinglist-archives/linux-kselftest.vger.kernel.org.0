Return-Path: <linux-kselftest+bounces-44480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 540EEC23242
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 04:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B66D94F008B
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 03:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901D71F4161;
	Fri, 31 Oct 2025 03:16:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AE3335BA;
	Fri, 31 Oct 2025 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761880601; cv=none; b=W6O0buAqD6DH6oDXhlvNFGDT6ubOjw46LiCOJtKM2fFRXA8oq6DyrvEWsWoKJ+FXwkrDBFQEvSa0xuiOTp2YsbnT882JIgmLqdR04vTp6cbLeRTHUfanO8WD3SYH6QAyJI8zsTu3WEMEOGdifGd0eGRJri4Lq+Ov8v3m+YOzt8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761880601; c=relaxed/simple;
	bh=LFoS+WjuY2P2QpPZpWqa96rlu5qRI+G0dqdOY/N2XRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SCb8kgEaEtCjIA42+f38aFPiKPkhlpQ1zPYVfYxfqHguTpYBUUlCzaNcn+NrqvOZoNIQAcc57/m+WMdTZWsVavS45IJUFwdr8EdjZeyYcEbNvYLFjs4Hwv24s73wBUX1YOkbjyP78/8lj3mI9VjHwrrAre338KI4DkeE6QcCe9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxidEVKgRpQ+0cAA--.63112S3;
	Fri, 31 Oct 2025 11:16:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxH8IUKgRpu8keAQ--.47195S2;
	Fri, 31 Oct 2025 11:16:36 +0800 (CST)
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
Subject: [PATCH 5/6] KVM: LoongArch: selftests: Add period mode timer and time counter test
Date: Fri, 31 Oct 2025 11:16:36 +0800
Message-Id: <20251031031636.4020857-1-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJCxH8IUKgRpu8keAQ--.47195S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Period mode timer and time counter test case is added. Timer only need
program once with period mode, its compared tick value will reload when
timer is fired. With time counter, it is always growing up until
overflow with value BIT_ULL(48).

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 .../kvm/include/loongarch/arch_timer.h        |  5 ++
 .../selftests/kvm/loongarch/arch_timer.c      | 49 +++++++++++++++++++
 2 files changed, 54 insertions(+)

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
index 2a2cebcf3885..1be42ef33bf3 100644
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
@@ -67,13 +74,55 @@ static void guest_test_oneshot_timer(uint32_t cpu)
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
+static void guest_time_count_test(uint32_t cpu)
+{
+	uint32_t config_iter;
+	unsigned long start, end, prev, us;
+
+	us = msec_to_cycles(test_args.timer_period_ms);
+	for (config_iter = 0; config_iter < test_args.nr_iter; config_iter++) {
+		start = timer_get_cycles();
+		end = start + us;
+		/* test time count growing up always */
+		while (start < end) {
+			prev = start;
+			start = timer_get_cycles();
+			__GUEST_ASSERT(prev <= start,
+					"prev = 0x%lx, start = 0x%lx.\n",
+					prev, start);
+		}
+	}
+}
+
 static void guest_code(void)
 {
 	uint32_t cpu = guest_get_vcpuid();
 
+	guest_time_count_test(cpu);
 	timer_irq_enable();
 	local_irq_enable();
 	guest_test_oneshot_timer(cpu);
+	guest_test_period_timer(cpu);
 
 	GUEST_DONE();
 }
-- 
2.39.3


