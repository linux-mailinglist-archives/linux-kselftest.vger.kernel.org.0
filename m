Return-Path: <linux-kselftest+bounces-18419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A48BF98795D
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 20:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856831C218C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 18:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0EA185E64;
	Thu, 26 Sep 2024 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vZsnHbvK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC65B17BEC7;
	Thu, 26 Sep 2024 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376370; cv=none; b=bm7WidiqixGu3fmJa0hdQbmVDorcMo/esM9BTqaC/nEqbrzk7BzUvrcU3PxRYDxPvSTT7CdM4UttfvLtTBo8edwOYhj1gkKYlr09dSNhJXbYWOuS5zsyGZ6G/hTSpwYuGy2g3fHqYcA8BEtKlgvZXKgOeVKRkh3Hhvhebiy+n/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376370; c=relaxed/simple;
	bh=3EkfdgjQgUE1GfOby0MWeb23AptTwvwthdDovIafYX8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhMgjV937rAC9xOYuWRrP+Y7uPXUjIYodpI+ai4hZ+nLc5fWVZpsPqizo9oAF6u+on4WiqHgPlzerFm4TNa4Em5FSivtjSuogSfez4I7IRd7OCGo4m3yf7uoPiv+rdbHVYtKaAkJVWjFlnC9wHczc9L7/kE+RhEJeDSqiFj0/+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vZsnHbvK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=nA0+GsfTkI0J2znRs3s2Rzfk3gzQZLwlmLPI/wAdZW8=; b=vZsnHbvKSyE8nSxUbb2o3jO/Ti
	v76xTlCyKKMs1dODxrUV3Ilz/oW/uLjpZlvcPIAlUQJMZRv/098DrwEyMnOK6BE14+S+nRkyDC6mP
	KUpcFBCA7HzwzmpJZq+HnRUUre7ZdEQ9gPIRtO638sGFs0V8HcraKwuQ61rXDGZKWlXBGnj7RsmBL
	YtmnHXStPdRNEDfTS8VNw828wCyVoZ90Ya/yYgOyIe+8Od4zsS3EtIJ6q3elc4+YQJ8lHqo8LXl3s
	AXO/X7kr1sXaa5ryHkQk87bOsAqeY2YELujlF5iJDZXkwv78zGNgvKQX5AyEk9aveky+CJhLxy3Qd
	TI7ufutQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sttUq-00000007NAB-3JjD;
	Thu, 26 Sep 2024 18:45:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sttUq-00000003Ybc-3sfW;
	Thu, 26 Sep 2024 19:45:48 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Francesco Lavra <francescolavra.fl@gmail.com>,
	Miguel Luis <miguel.luis@oracle.com>
Subject: [PATCH v5 4/5] KVM: selftests: Add test for PSCI SYSTEM_OFF2
Date: Thu, 26 Sep 2024 19:37:59 +0100
Message-ID: <20240926184546.833516-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240926184546.833516-1-dwmw2@infradead.org>
References: <20240926184546.833516-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 .../testing/selftests/kvm/aarch64/psci_test.c | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/kvm/aarch64/psci_test.c b/tools/testing/selftests/kvm/aarch64/psci_test.c
index 61731a950def..b7e37956aecf 100644
--- a/tools/testing/selftests/kvm/aarch64/psci_test.c
+++ b/tools/testing/selftests/kvm/aarch64/psci_test.c
@@ -54,6 +54,15 @@ static uint64_t psci_system_suspend(uint64_t entry_addr, uint64_t context_id)
 	return res.a0;
 }
 
+static uint64_t psci_system_off2(uint64_t type)
+{
+	struct arm_smccc_res res;
+
+	smccc_hvc(PSCI_1_3_FN64_SYSTEM_OFF2, type, 0, 0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
 static uint64_t psci_features(uint32_t func_id)
 {
 	struct arm_smccc_res res;
@@ -188,11 +197,63 @@ static void host_test_system_suspend(void)
 	kvm_vm_free(vm);
 }
 
+static void guest_test_system_off2(void)
+{
+	uint64_t ret;
+
+	/* assert that SYSTEM_OFF2 is discoverable */
+	GUEST_ASSERT(psci_features(PSCI_1_3_FN_SYSTEM_OFF2) &
+		     BIT(PSCI_1_3_HIBERNATE_TYPE_OFF));
+	GUEST_ASSERT(psci_features(PSCI_1_3_FN64_SYSTEM_OFF2) &
+		     BIT(PSCI_1_3_HIBERNATE_TYPE_OFF));
+
+	ret = psci_system_off2(PSCI_1_3_HIBERNATE_TYPE_OFF);
+	GUEST_SYNC(ret);
+}
+
+static void host_test_system_off2(void)
+{
+	struct kvm_vcpu *source, *target;
+	uint64_t psci_version = 0;
+	struct kvm_run *run;
+	struct kvm_vm *vm;
+
+	vm = setup_vm(guest_test_system_off2, &source, &target);
+	vcpu_get_reg(target, KVM_REG_ARM_PSCI_VERSION, &psci_version);
+	TEST_ASSERT(psci_version >= PSCI_VERSION(0, 2),
+		    "Unexpected PSCI version %lu.%lu",
+		    PSCI_VERSION_MAJOR(psci_version),
+		    PSCI_VERSION_MINOR(psci_version));
+
+	if (psci_version < PSCI_VERSION(1,3))
+		goto skip;
+
+	vcpu_power_off(target);
+	run = source->run;
+
+	enter_guest(source);
+
+	TEST_ASSERT_KVM_EXIT_REASON(source, KVM_EXIT_SYSTEM_EVENT);
+	TEST_ASSERT(run->system_event.type == KVM_SYSTEM_EVENT_SHUTDOWN,
+		    "Unhandled system event: %u (expected: %u)",
+		    run->system_event.type, KVM_SYSTEM_EVENT_SHUTDOWN);
+	TEST_ASSERT(run->system_event.ndata >= 1,
+		    "Unexpected amount of system event data: %u (expected, >= 1)",
+		    run->system_event.ndata);
+	TEST_ASSERT(run->system_event.data[0] & KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2,
+		    "PSCI_OFF2 flag not set. Flags %llu (expected %llu)",
+		    run->system_event.data[0], KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2);
+
+ skip:
+	kvm_vm_free(vm);
+}
+
 int main(void)
 {
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_SYSTEM_SUSPEND));
 
 	host_test_cpu_on();
 	host_test_system_suspend();
+	host_test_system_off2();
 	return 0;
 }
-- 
2.44.0


