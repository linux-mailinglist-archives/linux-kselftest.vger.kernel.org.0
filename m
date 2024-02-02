Return-Path: <linux-kselftest+bounces-3970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CEE84661C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 03:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E4128F433
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 02:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987B6D285;
	Fri,  2 Feb 2024 02:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXnEZmsB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F16E541
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 02:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706842635; cv=none; b=Urjuwi/saLIAkOdxqmLUbNRsPchvFW0KatAcJp+iogPKjm4AHJv8iE5otEAFZOcuBqASF5dP3AtP2jboy/mqo3xACdy91I2EU3cCUZIKC1phZy6serEgPd4z+qhEM4BiAYYxvwovod3UlulbB5wKVuOst9H7wWFUaMw9TGtuYIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706842635; c=relaxed/simple;
	bh=iQcDvsmli+f9WxXmx0d4usQrtbdhWqUXEy9bbPuucN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FRMY04+LeD2IYVCmx5ZjpCftQtG9Qj2oUykRM5LaLGcBABRe66Gkum1eLmBrRBGwHaNKyBKURihKC61XJaDg3AFjC4DP0uuagRYoRwYkkBpn9GQEC2AwlrCJTFc3IZ8IezmKRwSkKUHM33KyGxL9vs9Eo0a4aAwHkav8A8U/i2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXnEZmsB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706842632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d5OPz+OiB9LDOQr03kz0OlVpZZy2UvPoH/gWlYmBKRo=;
	b=WXnEZmsBSZqjmFV90BArFVZsxxY2w74ULurzO0ztPv/PbAtLrh4MFqjwFxdtQ5lBqZI6GY
	zoX9bcpr5TUvPTlAlVbiIIa0RizEO695YBoCRBBXNafKUA/C4R9Go3n4U+VHscq3ZXr6Z1
	OwQCoBDD+r9u8xtflxJDjBljHZgUbPU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-FQN_ide3M-KVpepDpITfNg-1; Thu, 01 Feb 2024 21:57:08 -0500
X-MC-Unique: FQN_ide3M-KVpepDpITfNg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98428835148;
	Fri,  2 Feb 2024 02:57:07 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7BC11C0FDF2;
	Fri,  2 Feb 2024 02:57:07 +0000 (UTC)
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
Subject: [PATCH v4 2/5] KVM: selftests: aarch64: Move pmu helper functions into vpmu.h
Date: Thu,  1 Feb 2024 21:56:51 -0500
Message-Id: <20240202025659.5065-3-shahuang@redhat.com>
In-Reply-To: <20240202025659.5065-1-shahuang@redhat.com>
References: <20240202025659.5065-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Move those pmu helper functions into include/aarch64/vpmu.h, thus
it can be used by other pmu test.

No functional change intended.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
 .../kvm/aarch64/vpmu_counter_access.c         | 117 -----------------
 .../selftests/kvm/include/aarch64/vpmu.h      | 118 ++++++++++++++++++
 2 files changed, 118 insertions(+), 117 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
index bad0fdbe6d34..62d6315790ab 100644
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
@@ -35,117 +29,6 @@ struct pmreg_sets {
 
 #define PMREG_SET(set, clr) {.set_reg_id = set, .clr_reg_id = clr}
 
-static uint64_t get_pmcr_n(uint64_t pmcr)
-{
-	return FIELD_GET(ARMV8_PMU_PMCR_N, pmcr);
-}
-
-static void set_pmcr_n(uint64_t *pmcr, uint64_t pmcr_n)
-{
-	u64p_replace_bits((__u64 *) pmcr, pmcr_n, ARMV8_PMU_PMCR_N);
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
index 0a56183644ee..f78c93a08bff 100644
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
@@ -14,3 +21,114 @@ struct vpmu_vm {
 struct vpmu_vm *create_vpmu_vm(void *guest_code);
 
 void destroy_vpmu_vm(struct vpmu_vm *vpmu_vm);
+
+static inline uint64_t get_pmcr_n(uint64_t pmcr)
+{
+	return FIELD_GET(ARMV8_PMU_PMCR_N, pmcr);
+}
+
+static inline void set_pmcr_n(uint64_t *pmcr, uint64_t pmcr_n)
+{
+	u64p_replace_bits((__u64 *) pmcr, pmcr_n, ARMV8_PMU_PMCR_N);
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


