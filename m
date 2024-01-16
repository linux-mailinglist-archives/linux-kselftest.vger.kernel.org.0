Return-Path: <linux-kselftest+bounces-3061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4E282E95B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 07:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474B41C20F57
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 06:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD87DDB9;
	Tue, 16 Jan 2024 06:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AN0gko4u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19F10A33
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jan 2024 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705384899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDh7uLwzJ6mO+1z8fW0iOwTRxFcTnxtzdx+DswE76IM=;
	b=AN0gko4uITMHr73A/Lcta/sm/p1/WX2ASBrP+3Ona1d89Umxen+U0a55/M8bKSZaWJbGpo
	l3oB1KeCGTzWLduV4WdqB6oWtBrgPWbxVRONt8lMUjptemQrJqP9dG96gPKvW+neiktqkH
	NAb3JFF1lpRfnI2TPucK7mmm0dOz/es=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-aoqLJpgHMs-jF1DL4o35Iw-1; Tue,
 16 Jan 2024 01:01:35 -0500
X-MC-Unique: aoqLJpgHMs-jF1DL4o35Iw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CF3A3C025C1;
	Tue, 16 Jan 2024 06:01:34 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 483A12026D6F;
	Tue, 16 Jan 2024 06:01:34 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Eric Auger <eauger@redhat.com>,
	Shaoqin Huang <shahuang@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] KVM: selftests: aarch64: Move pmu helper functions into vpmu.h
Date: Tue, 16 Jan 2024 01:01:20 -0500
Message-Id: <20240116060129.55473-3-shahuang@redhat.com>
In-Reply-To: <20240116060129.55473-1-shahuang@redhat.com>
References: <20240116060129.55473-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Move those pmu helper functions into include/aarch64/vpmu.h, thus
it can be used by other pmu test.

No functional change intended.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
 .../kvm/aarch64/vpmu_counter_access.c         | 118 -----------------
 .../selftests/kvm/include/aarch64/vpmu.h      | 119 ++++++++++++++++++
 2 files changed, 119 insertions(+), 118 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
index 17305408a334..62d6315790ab 100644
--- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
+++ b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
@@ -20,12 +20,6 @@
 #include <perf/arm_pmuv3.h>
 #include <linux/bitfield.h>
 
-/* The max number of the PMU event counters (excluding the cycle counter) */
-#define ARMV8_PMU_MAX_GENERAL_COUNTERS	(ARMV8_PMU_MAX_COUNTERS - 1)
-
-/* The cycle counter bit position that's common among the PMU registers */
-#define ARMV8_PMU_CYCLE_IDX		31
-
 static struct vpmu_vm *vpmu_vm;
 
 struct pmreg_sets {
@@ -35,118 +29,6 @@ struct pmreg_sets {
 
 #define PMREG_SET(set, clr) {.set_reg_id = set, .clr_reg_id = clr}
 
-static uint64_t get_pmcr_n(uint64_t pmcr)
-{
-	return (pmcr >> ARMV8_PMU_PMCR_N_SHIFT) & ARMV8_PMU_PMCR_N_MASK;
-}
-
-static void set_pmcr_n(uint64_t *pmcr, uint64_t pmcr_n)
-{
-	*pmcr = *pmcr & ~(ARMV8_PMU_PMCR_N_MASK << ARMV8_PMU_PMCR_N_SHIFT);
-	*pmcr |= (pmcr_n << ARMV8_PMU_PMCR_N_SHIFT);
-}
-
-static uint64_t get_counters_mask(uint64_t n)
-{
-	uint64_t mask = BIT(ARMV8_PMU_CYCLE_IDX);
-
-	if (n)
-		mask |= GENMASK(n - 1, 0);
-	return mask;
-}
-
-/* Read PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
-static inline unsigned long read_sel_evcntr(int sel)
-{
-	write_sysreg(sel, pmselr_el0);
-	isb();
-	return read_sysreg(pmxevcntr_el0);
-}
-
-/* Write PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
-static inline void write_sel_evcntr(int sel, unsigned long val)
-{
-	write_sysreg(sel, pmselr_el0);
-	isb();
-	write_sysreg(val, pmxevcntr_el0);
-	isb();
-}
-
-/* Read PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
-static inline unsigned long read_sel_evtyper(int sel)
-{
-	write_sysreg(sel, pmselr_el0);
-	isb();
-	return read_sysreg(pmxevtyper_el0);
-}
-
-/* Write PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
-static inline void write_sel_evtyper(int sel, unsigned long val)
-{
-	write_sysreg(sel, pmselr_el0);
-	isb();
-	write_sysreg(val, pmxevtyper_el0);
-	isb();
-}
-
-static inline void enable_counter(int idx)
-{
-	uint64_t v = read_sysreg(pmcntenset_el0);
-
-	write_sysreg(BIT(idx) | v, pmcntenset_el0);
-	isb();
-}
-
-static inline void disable_counter(int idx)
-{
-	uint64_t v = read_sysreg(pmcntenset_el0);
-
-	write_sysreg(BIT(idx) | v, pmcntenclr_el0);
-	isb();
-}
-
-static void pmu_disable_reset(void)
-{
-	uint64_t pmcr = read_sysreg(pmcr_el0);
-
-	/* Reset all counters, disabling them */
-	pmcr &= ~ARMV8_PMU_PMCR_E;
-	write_sysreg(pmcr | ARMV8_PMU_PMCR_P, pmcr_el0);
-	isb();
-}
-
-#define RETURN_READ_PMEVCNTRN(n) \
-	return read_sysreg(pmevcntr##n##_el0)
-static unsigned long read_pmevcntrn(int n)
-{
-	PMEVN_SWITCH(n, RETURN_READ_PMEVCNTRN);
-	return 0;
-}
-
-#define WRITE_PMEVCNTRN(n) \
-	write_sysreg(val, pmevcntr##n##_el0)
-static void write_pmevcntrn(int n, unsigned long val)
-{
-	PMEVN_SWITCH(n, WRITE_PMEVCNTRN);
-	isb();
-}
-
-#define READ_PMEVTYPERN(n) \
-	return read_sysreg(pmevtyper##n##_el0)
-static unsigned long read_pmevtypern(int n)
-{
-	PMEVN_SWITCH(n, READ_PMEVTYPERN);
-	return 0;
-}
-
-#define WRITE_PMEVTYPERN(n) \
-	write_sysreg(val, pmevtyper##n##_el0)
-static void write_pmevtypern(int n, unsigned long val)
-{
-	PMEVN_SWITCH(n, WRITE_PMEVTYPERN);
-	isb();
-}
-
 /*
  * The pmc_accessor structure has pointers to PMEV{CNTR,TYPER}<n>_EL0
  * accessors that test cases will use. Each of the accessors will
diff --git a/tools/testing/selftests/kvm/include/aarch64/vpmu.h b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
index 0a56183644ee..e0cc1ca1c4b7 100644
--- a/tools/testing/selftests/kvm/include/aarch64/vpmu.h
+++ b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
@@ -1,10 +1,17 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #include <kvm_util.h>
+#include <perf/arm_pmuv3.h>
 
 #define GICD_BASE_GPA	0x8000000ULL
 #define GICR_BASE_GPA	0x80A0000ULL
 
+/* The max number of the PMU event counters (excluding the cycle counter) */
+#define ARMV8_PMU_MAX_GENERAL_COUNTERS	(ARMV8_PMU_MAX_COUNTERS - 1)
+
+/* The cycle counter bit position that's common among the PMU registers */
+#define ARMV8_PMU_CYCLE_IDX		31
+
 struct vpmu_vm {
 	struct kvm_vm *vm;
 	struct kvm_vcpu *vcpu;
@@ -14,3 +21,115 @@ struct vpmu_vm {
 struct vpmu_vm *create_vpmu_vm(void *guest_code);
 
 void destroy_vpmu_vm(struct vpmu_vm *vpmu_vm);
+
+static inline uint64_t get_pmcr_n(uint64_t pmcr)
+{
+	return (pmcr >> ARMV8_PMU_PMCR_N_SHIFT) & ARMV8_PMU_PMCR_N_MASK;
+}
+
+static inline void set_pmcr_n(uint64_t *pmcr, uint64_t pmcr_n)
+{
+	*pmcr = *pmcr & ~(ARMV8_PMU_PMCR_N_MASK << ARMV8_PMU_PMCR_N_SHIFT);
+	*pmcr |= (pmcr_n << ARMV8_PMU_PMCR_N_SHIFT);
+}
+
+static inline uint64_t get_counters_mask(uint64_t n)
+{
+	uint64_t mask = BIT(ARMV8_PMU_CYCLE_IDX);
+
+	if (n)
+		mask |= GENMASK(n - 1, 0);
+	return mask;
+}
+
+/* Read PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
+static inline unsigned long read_sel_evcntr(int sel)
+{
+	write_sysreg(sel, pmselr_el0);
+	isb();
+	return read_sysreg(pmxevcntr_el0);
+}
+
+/* Write PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
+static inline void write_sel_evcntr(int sel, unsigned long val)
+{
+	write_sysreg(sel, pmselr_el0);
+	isb();
+	write_sysreg(val, pmxevcntr_el0);
+	isb();
+}
+
+/* Read PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
+static inline unsigned long read_sel_evtyper(int sel)
+{
+	write_sysreg(sel, pmselr_el0);
+	isb();
+	return read_sysreg(pmxevtyper_el0);
+}
+
+/* Write PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
+static inline void write_sel_evtyper(int sel, unsigned long val)
+{
+	write_sysreg(sel, pmselr_el0);
+	isb();
+	write_sysreg(val, pmxevtyper_el0);
+	isb();
+}
+
+static inline void enable_counter(int idx)
+{
+	uint64_t v = read_sysreg(pmcntenset_el0);
+
+	write_sysreg(BIT(idx) | v, pmcntenset_el0);
+	isb();
+}
+
+static inline void disable_counter(int idx)
+{
+	uint64_t v = read_sysreg(pmcntenset_el0);
+
+	write_sysreg(BIT(idx) | v, pmcntenclr_el0);
+	isb();
+}
+
+static inline void pmu_disable_reset(void)
+{
+	uint64_t pmcr = read_sysreg(pmcr_el0);
+
+	/* Reset all counters, disabling them */
+	pmcr &= ~ARMV8_PMU_PMCR_E;
+	write_sysreg(pmcr | ARMV8_PMU_PMCR_P, pmcr_el0);
+	isb();
+}
+
+#define RETURN_READ_PMEVCNTRN(n) \
+	return read_sysreg(pmevcntr##n##_el0)
+static inline unsigned long read_pmevcntrn(int n)
+{
+	PMEVN_SWITCH(n, RETURN_READ_PMEVCNTRN);
+	return 0;
+}
+
+#define WRITE_PMEVCNTRN(n) \
+	write_sysreg(val, pmevcntr##n##_el0)
+static inline void write_pmevcntrn(int n, unsigned long val)
+{
+	PMEVN_SWITCH(n, WRITE_PMEVCNTRN);
+	isb();
+}
+
+#define READ_PMEVTYPERN(n) \
+	return read_sysreg(pmevtyper##n##_el0)
+static inline unsigned long read_pmevtypern(int n)
+{
+	PMEVN_SWITCH(n, READ_PMEVTYPERN);
+	return 0;
+}
+
+#define WRITE_PMEVTYPERN(n) \
+	write_sysreg(val, pmevtyper##n##_el0)
+static inline void write_pmevtypern(int n, unsigned long val)
+{
+	PMEVN_SWITCH(n, WRITE_PMEVTYPERN);
+	isb();
+}
-- 
2.40.1


