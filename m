Return-Path: <linux-kselftest+bounces-20200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67AE9A5005
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 19:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C2DCB22603
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 17:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF991917C7;
	Sat, 19 Oct 2024 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CH+NZnNY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF68418BB8E;
	Sat, 19 Oct 2024 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729358716; cv=none; b=NGy5EkIjfOFr2UI5TB2YZzqcOPXxIK0cQXJQ3UD3H2vfuznbqMbQzihRSoEjoXnZCBybcN0lNV3IGzoyByk9fkufn9GqgMHLq2jLcpsBzC9DUTXhFheL6l7LmXQ7Zp/86EMOHXjbVuCxikjldCMpmvmSB9UxTTPZWZG64xSAk6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729358716; c=relaxed/simple;
	bh=r4RL8cn9WemWhyivniea2n7ppkgxNY66wDKl84ODVHc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlsJ7WZXLhg3yJ1tWfiu5eupijuBwWgSd/G2tdmTBvcDQZT0Y5i3atWz2l15/xoGqyBVMEtZCSoMStRFi0T3TI+ACyEDtYCLT0anvoHZ0OICExur5R8VCwstXkPx/r/bLF5mp/B0eRTSuFpVYSWa83pGvbmdQrc7Y+u0difhWh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CH+NZnNY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=iaMlZJo+eXwUqDzfRXJziZaxpMoCZLPD8C5d6tjZWFk=; b=CH+NZnNYAQ54NZVIE3umTYEiEX
	NXXB3tS+lMs3eO9Jk0jeaHSb7WH33+WfDeJIgepQ3+vztApPVh1h5XGx4Sre3RMJ5QXLnmBugr+92
	PczbR6Gk7uVQ6y1X7VEHuAZ2UAxytGvs1Rrcjj3w6ogfvdz8TWZtp9T/i8eBaZDExdWAyBTCd8BJG
	SndYZvfGSXXQLKLgd5J/RjCqdHN2mJLZgwQnZ341KCoT6TmYs52/Xl7uGK7U3UX1eh9HfSpW+lUCB
	oC+fzBqeB2F+cmLby/7Exch3rjepy/tdyqqoxAm7dYNw+2id9p0JXnYoSp5og6Zv2PzGt0l77tYbi
	WiZgkH+A==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t2DCK-0000000EUir-3cG9;
	Sat, 19 Oct 2024 17:25:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t2DCI-00000009TKo-3btd;
	Sat, 19 Oct 2024 18:25:02 +0100
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
Subject: [PATCH v6 4/6] KVM: selftests: Add test for PSCI SYSTEM_OFF2
Date: Sat, 19 Oct 2024 18:15:45 +0100
Message-ID: <20241019172459.2241939-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241019172459.2241939-1-dwmw2@infradead.org>
References: <20241019172459.2241939-1-dwmw2@infradead.org>
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
 .../testing/selftests/kvm/aarch64/psci_test.c | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/tools/testing/selftests/kvm/aarch64/psci_test.c b/tools/testing/selftests/kvm/aarch64/psci_test.c
index 61731a950def..1eabbef99dbc 100644
--- a/tools/testing/selftests/kvm/aarch64/psci_test.c
+++ b/tools/testing/selftests/kvm/aarch64/psci_test.c
@@ -54,6 +54,15 @@ static uint64_t psci_system_suspend(uint64_t entry_addr, uint64_t context_id)
 	return res.a0;
 }
 
+static uint64_t psci_system_off2(uint64_t type, uint64_t cookie)
+{
+	struct arm_smccc_res res;
+
+	smccc_hvc(PSCI_1_3_FN64_SYSTEM_OFF2, type, cookie, 0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
 static uint64_t psci_features(uint32_t func_id)
 {
 	struct arm_smccc_res res;
@@ -188,11 +197,95 @@ static void host_test_system_suspend(void)
 	kvm_vm_free(vm);
 }
 
+static void guest_test_system_off2(void)
+{
+	uint64_t ret;
+
+	/* assert that SYSTEM_OFF2 is discoverable */
+	GUEST_ASSERT(psci_features(PSCI_1_3_FN_SYSTEM_OFF2) &
+		     PSCI_1_3_OFF_TYPE_HIBERNATE_OFF);
+	GUEST_ASSERT(psci_features(PSCI_1_3_FN64_SYSTEM_OFF2) &
+		     PSCI_1_3_OFF_TYPE_HIBERNATE_OFF);
+
+	/* With non-zero 'cookie' field, it should fail */
+	ret = psci_system_off2(PSCI_1_3_OFF_TYPE_HIBERNATE_OFF, 1);
+	GUEST_ASSERT(ret == PSCI_RET_INVALID_PARAMS);
+
+	/*
+	 * This would normally never return, so KVM sets the return value
+	 * to PSCI_RET_INTERNAL_FAILURE. The test case *does* return, so
+	 * that it can test both values for HIBERNATE_OFF.
+	 */
+	ret = psci_system_off2(PSCI_1_3_OFF_TYPE_HIBERNATE_OFF, 0);
+	GUEST_ASSERT(ret == PSCI_RET_INTERNAL_FAILURE);
+
+	/*
+	 * Revision F.b of the PSCI v1.3 specification documents zero as an
+	 * alias for HIBERNATE_OFF, since that's the value used in earlier
+	 * revisions of the spec and some implementations in the field.
+	 */
+	ret = psci_system_off2(0, 1);
+	GUEST_ASSERT(ret == PSCI_RET_INVALID_PARAMS);
+
+	ret = psci_system_off2(0, 0);
+	/* Unless this test is extended, the guest never gets here. */
+	GUEST_ASSERT(ret == PSCI_RET_INTERNAL_FAILURE);
+
+	GUEST_DONE();
+}
+
+static void host_test_system_off2(void)
+{
+	struct kvm_vcpu *source, *target;
+	struct kvm_mp_state mps;
+	uint64_t psci_version = 0;
+	int nr_shutdowns = 0;
+	struct kvm_run *run;
+	struct ucall uc;
+
+	setup_vm(guest_test_system_off2, &source, &target);
+
+	vcpu_get_reg(target, KVM_REG_ARM_PSCI_VERSION, &psci_version);
+
+	TEST_ASSERT(psci_version >= PSCI_VERSION(1, 3),
+		    "Unexpected PSCI version %lu.%lu",
+		    PSCI_VERSION_MAJOR(psci_version),
+		    PSCI_VERSION_MINOR(psci_version));
+
+	vcpu_power_off(target);
+	run = source->run;
+
+	enter_guest(source);
+	while (run->exit_reason == KVM_EXIT_SYSTEM_EVENT) {
+		TEST_ASSERT(run->system_event.type == KVM_SYSTEM_EVENT_SHUTDOWN,
+			    "Unhandled system event: %u (expected: %u)",
+			    run->system_event.type, KVM_SYSTEM_EVENT_SHUTDOWN);
+		TEST_ASSERT(run->system_event.ndata >= 1,
+			    "Unexpected amount of system event data: %u (expected, >= 1)",
+			    run->system_event.ndata);
+		TEST_ASSERT(run->system_event.data[0] & KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2,
+			    "PSCI_OFF2 flag not set. Flags %llu (expected %llu)",
+			    run->system_event.data[0], KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2);
+
+		nr_shutdowns++;
+
+		/* Restart the vCPU */
+	        mps.mp_state = KVM_MP_STATE_RUNNABLE;
+		vcpu_mp_state_set(source, &mps);
+
+		enter_guest(source);
+	}
+
+	TEST_ASSERT(get_ucall(source, &uc) == UCALL_DONE, "Guest did not exit cleanly");
+	TEST_ASSERT(nr_shutdowns == 2, "Two shutdown events were expected, but saw %d", nr_shutdowns);
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


