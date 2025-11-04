Return-Path: <linux-kselftest+bounces-44715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C31C30C76
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 12:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199ED18C2A9C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 11:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010472F39D1;
	Tue,  4 Nov 2025 11:37:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43762F1FF6;
	Tue,  4 Nov 2025 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762256252; cv=none; b=ZWDx2+2arLS9q6XhrMbemvffoVLs9UdDG+qm4xNl0TeDhw9fL8eoq+2IjC6EDI2xw23bfajnVkMSQha+UupUSb0Mr3QEFBPvM7Qpc7MOFXfWK7bR9kF5Wq3FRQky4ixiEsW02u2z1NdxrYoiiOlhWs+dwFPFB/1MiHlLMXJZvhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762256252; c=relaxed/simple;
	bh=EYH/yVHdnb089sbM06R3GlT36iMXXinhgjkzboFZYQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YUYPrcfQS0moD5A4HNsiu65wWKDsKiA025IGjpQYyqUtwI3cCllI5E3lKXoNZgaW8hcJLfqvG20wzMoAit0mHsKah2heXG/fhQMaAclvwbMjPr0P91avmXIj2hV7jYpOF1S4UJSVMovUcmh6M6w7mirghZI637YsRvc/p1UdvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxqdFy5QlpjbQeAA--.1524S3;
	Tue, 04 Nov 2025 19:37:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAx+8Bw5QlpZDImAQ--.57838S3;
	Tue, 04 Nov 2025 19:37:21 +0800 (CST)
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
Subject: [PATCH v2 7/7] KVM: LoongArch: selftests: Add time counter test
Date: Tue,  4 Nov 2025 19:36:59 +0800
Message-Id: <20251104113700.1561752-8-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJAx+8Bw5QlpZDImAQ--.57838S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With time counter test, it is to verify that time count starts from 0
and always grows up then.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 .../selftests/kvm/lib/loongarch/processor.c   |  9 ++++++
 .../selftests/kvm/loongarch/arch_timer.c      | 29 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tools/testing/selftests/kvm/lib/loongarch/processor.c
index 436990258068..ac2ffd076bff 100644
--- a/tools/testing/selftests/kvm/lib/loongarch/processor.c
+++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
@@ -3,6 +3,7 @@
 #include <assert.h>
 #include <linux/compiler.h>
 
+#include <asm/kvm.h>
 #include "kvm_util.h"
 #include "processor.h"
 #include "ucall_common.h"
@@ -256,6 +257,11 @@ static void loongarch_set_csr(struct kvm_vcpu *vcpu, uint64_t id, uint64_t val)
 	__vcpu_set_reg(vcpu, csrid, val);
 }
 
+static void loongarch_set_reg(struct kvm_vcpu *vcpu, uint64_t id, uint64_t val)
+{
+	__vcpu_set_reg(vcpu, id, val);
+}
+
 static void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
 {
 	int width;
@@ -279,6 +285,9 @@ static void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
 	loongarch_set_csr(vcpu, LOONGARCH_CSR_ECFG, 0);
 	loongarch_set_csr(vcpu, LOONGARCH_CSR_TCFG, 0);
 	loongarch_set_csr(vcpu, LOONGARCH_CSR_ASID, 1);
+	/* time count start from 0 */
+	val = 0;
+	loongarch_set_reg(vcpu, KVM_REG_LOONGARCH_COUNTER, val);
 
 	val = 0;
 	width = vm->page_shift - 3;
diff --git a/tools/testing/selftests/kvm/loongarch/arch_timer.c b/tools/testing/selftests/kvm/loongarch/arch_timer.c
index 579132a082cd..f3a25a0163fc 100644
--- a/tools/testing/selftests/kvm/loongarch/arch_timer.c
+++ b/tools/testing/selftests/kvm/loongarch/arch_timer.c
@@ -133,10 +133,39 @@ static void guest_test_emulate_timer(uint32_t cpu)
 	local_irq_enable();
 }
 
+static void guest_time_count_test(uint32_t cpu)
+{
+	uint32_t config_iter;
+	unsigned long start, end, prev, us;
+
+	/* Assuming that test case starts to run in 1 second */
+	start = timer_get_cycles();
+	us = msec_to_cycles(1000);
+	__GUEST_ASSERT(start <= us,
+			"start = 0x%lx, us = 0x%lx.\n",
+			start, us);
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
 
+	/* must run at first */
+	guest_time_count_test(cpu);
 	timer_irq_enable();
 	local_irq_enable();
 	guest_test_oneshot_timer(cpu);
-- 
2.39.3


