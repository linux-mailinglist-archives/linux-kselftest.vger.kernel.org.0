Return-Path: <linux-kselftest+bounces-42125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56609B94639
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B84A3A4DCC
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D4630F545;
	Tue, 23 Sep 2025 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JuC8y9Nc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E227927511F;
	Tue, 23 Sep 2025 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604807; cv=fail; b=bG1J+nFRgvNAVRT4O3NfkjxRkDQUoEXaqD4SX0SAcNVnaml6DbCjVhg4+UW+ZooV8+3yYUfUmWrdGgil/bTZne0RrH14hQYPM/cWhjwgfo2LXB6aLuZRDUIWHxrVfRHcmmUOe3RVwpfQPPfTOrWufv9pvhacSPVett49Ve5vODA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604807; c=relaxed/simple;
	bh=QLvsY+EmIH0Jl3x0PR09pTyahiekPBBHLuHzFzK6Ejk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8RNxxv1NC5GTgjsQW3WCwPwAtprOylZXYPYtzVLrC/HaYIyrz7+fMCMH4w0ThfT5wq7/WOtqzv8gTAgQGdtEI/OUC8kTp9BuLxp59d5XHXS4fLzAUT33q5X4+cCU41oTyeyjjHDXfWA3abAHQ5bTqfAq0CaGD3BvjgChR+wbZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JuC8y9Nc; arc=fail smtp.client-ip=40.93.196.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGToNwgbInbhnv8sULoXjWFh0NmraIrHitdOrPEH+7LiZfQd/J3327YqsZFCo/zskF5HqTfhtpc83qm3ANh1M3Z+hoPet2xKyLJu2FFs5I6LUZSP0pE847od0OAYUO9DAMiX4lpzPAwVeBzy7cfwolr+hKxeHjXKK+Hat3Sq/z362d755IwGH95QnFQPSaOin1phGzm50j4W6k1wv7jRFXQj6teM4bktja3RdhcjU0exRBRiNyduk43a7WgvTiNqVShyhcuDLXI87jVOXnU1x5HGT8/1yL2yV5ALClamSX715Vkwm+1dZFfEcvIHFPJsg0EI0ZwPLK/UP2kc57zXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gktajsV8YqjkU2pYujSNfYFg3o5Y3Jg6Juicd7/KqI=;
 b=RHY1q9ZeLsIBNkbga8GUcQ2en8yIgAcW9zbyVVDYqUvezyMIMaVc3djTzmDKUffohRCajzvdQt11K6BEZByMuYRVroT70Vp4FI7JUKE3EfvfAsIsD0zBseK2WrcAMC5RYZyqD61ou7lYgNa6Dsf5d2IPf0uO0PuyNCwWz1FmbnBwXgYFw6/JkNJcKwoZB6aklXL3xuuDvqhkuZrIzUD6e94sfDBgxGISVFJ7PIRDMv3mKijRF/+jFYTCWxekXvO2f4flN0HvdRmV/ZP/qz1jzgvTYdkc2P1vs2YBdQpRM4ZyMMTKa3Jk/moyDlmE/+onmpd3ip8zgNI3ovQx6k75Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gktajsV8YqjkU2pYujSNfYFg3o5Y3Jg6Juicd7/KqI=;
 b=JuC8y9NcnUa8U0YuK4j5q7/ybI0IqZLzJW2U6KI112NQTZ9oNeyVSNr7JyswZbuGCxgasYmnKpRTME4YbrUQ58Q9RaupCtwfVpRKO9SJpGkrr0qEG7PfGY2iyKRGRx15fvL5cyt7BvuX+9VgwXf3tuqFzM5gedCAeaWWj/KHkrU=
Received: from BY5PR16CA0014.namprd16.prod.outlook.com (2603:10b6:a03:1a0::27)
 by CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 05:20:00 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::55) by BY5PR16CA0014.outlook.office365.com
 (2603:10b6:a03:1a0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:19:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:19:59 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:19:53 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 34/35] KVM: selftests: Add NMI test for SAVIC guests
Date: Tue, 23 Sep 2025 10:39:41 +0530
Message-ID: <20250923050942.206116-35-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923050942.206116-1-Neeraj.Upadhyay@amd.com>
References: <20250923050942.206116-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|CYYPR12MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: c816b3f1-7a26-4a86-c3b2-08ddfa60d7a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0eq0MIbG1ORx7ikfPM/yAmjl37bZtBjt/uHoXbx4jX/iMOX8Y33zNoKaJaWz?=
 =?us-ascii?Q?s8zFFJshG2gr+M0NS7giarGJM8zojulAZGlx3B+MgKqYIke9FVihAt5OSdUc?=
 =?us-ascii?Q?ZzCRKlCJ11YCp2okWAsWoO0ebF9/23IAJpQtfXIuvP/KYWHtp+QLBUznflZU?=
 =?us-ascii?Q?OM5RMKrMP7lxlv1uC/A85Rt5jECTJrZ6/SQ4ff6Q1/sgOoYrZEWKOUR9ibZY?=
 =?us-ascii?Q?hk8CtoOvGU6mRaTP6qzrktudVq1JYdDO8VgH7lsllJkpFq07KlQvyTpwGTA+?=
 =?us-ascii?Q?H4eYfDqZMemaVUJQdyZWA7RfAEzPyFXl3EsOjnVZCobLxO4QyiOLrAyHijf5?=
 =?us-ascii?Q?OnOCYfvsJ6J/P3F1vuIlhclkmqO6h8uLpQtNUGNV9zPWRCg/cCpkkimOblrH?=
 =?us-ascii?Q?pKfk42iFfJlgxuJX1igtL0qbdmas4R9R909Zy/TekVoUWcfN2VIRIX570WWx?=
 =?us-ascii?Q?RJNvrcSjB45U2B3VtsEEkOeMHJ7GO7V5K0oNUPSVEriJcuw5uqynE7IlVGI5?=
 =?us-ascii?Q?Do/kfLUDHzIgSX3mf284kZssyT1KIy4Kv/mfilVL36y/j2j/ZPs1+VejDX9S?=
 =?us-ascii?Q?fbkksrwP1AGlXWiaTS/t8U14/hqeeiZZKIXfcMsTPuUvYVGY7mljjgWfc02v?=
 =?us-ascii?Q?7fC81v8Un15efSF4HKoSN9hM0hbf0+VdCTgE9s6pwKhOfrYsGFgKjS1nl0uQ?=
 =?us-ascii?Q?aPsE+StaxkuUKuvRDAK3hbq6XxEzo7sOXGPgaNdqOdBVHsxm3BA9BzyiSddy?=
 =?us-ascii?Q?pV5OGhSPGEEuIo7fnmY0s8XPTLp0Ovut/pBuM0uNQbZIBOrM/A5bbxMbiB+q?=
 =?us-ascii?Q?AJ77AXDi8OlMo2XJnidLkbfqPqvbxQz3IV4ghvdYtYKTInPeNGAO/PFDXdJ1?=
 =?us-ascii?Q?XUpeJuuL5HLUoqm1ei/EKog5VI2CDvkP8BbrRqL5/kT0/dds7g+GAPeKMZuh?=
 =?us-ascii?Q?JvvJLOEWnTi7RnnABPLm7uiKDR8F4rzX1yzp6B7VQ0rRe5Ekc63ClxwjojAY?=
 =?us-ascii?Q?4ynm/0A8OmNonLhfuk9qKHCBhucQQXXshTvayUJ77a1oWVx/gFbCRQbLcu+c?=
 =?us-ascii?Q?bnXldsMWmEPKQrCkFFNvGa/f0ZM7zkjlZXIac7IOEUdwKZYEYdrlLUyJux03?=
 =?us-ascii?Q?T7oLXgIhi6TPnAsae94vfQOhk4S7gzRO+VJ2ynaJhMvufpDi5+/KIXKQzXkd?=
 =?us-ascii?Q?tKRe9aFONFkS1xGxwBR6R/NqjQX7XKO54P4zTXInw1u7KHhZtxMeXYa5xF4t?=
 =?us-ascii?Q?A8SSNtqiSOSb+Nr+N8GawGTOQIRmbnMoDes4gUQZ5FF4aGMt8hdihDv655je?=
 =?us-ascii?Q?FdErzakx97gYMiocXQWkr1nYHbspiODZg3z3NZYSyPx9hkglQ1NXOslaI30y?=
 =?us-ascii?Q?4DNe6dSZ0Q6ffckVUfqiXjZg9dLSxDmPGP4nWyrXRgnp7fvvUOq+Be1PGDdT?=
 =?us-ascii?Q?Jy/fXGdZF526Y5rADc+zXyxIKmMJC0dQ8Kaxt0Jr02HFOqDpz4nUr9RTs7+r?=
 =?us-ascii?Q?q5J3CUhNI28UfjYgfS2W+CXkTxB4kkwzpgsN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:19:59.6643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c816b3f1-7a26-4a86-c3b2-08ddfa60d7a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8892

Extend the Secure AVIC (SAVIC) selftest to validate the handling of
Non-Maskable Interrupts (NMIs).

In SAVIC mode, NMI delivery requires explicit coordination between the
guest and the hypervisor: the guest must explicitly permit the host to
inject NMIs by setting the AllowedNMI bit in the
MSR_AMD64_SECURE_AVIC_CONTROL. If this bit is clear, host-injected NMIs
are dropped. After handling an NMI, the guest must notify the hypervisor
by issuing a VMGEXIT with a new NMI_COMPLETE exit code. This unblocks
the hardware's NMI-pending state, allowing subsequent NMIs to be
delivered.

ICR-based NMIs : NMIs sent via the Interrupt Command Register (ICR) are
handled by the guest's #VC handler, following the same INCOMPLETE_IPI
exception path as regular IPIs.

Add a comprehensive set of test cases to savic_test.c to validate this
entire flow:

* Verify that a host-injected NMI is correctly dropped when the AllowedNMI
  bit is clear.

* Test that if a second NMI is injected while one is already pending, it
  is correctly blocked by the hardware and delivered only after the guest
  signals completion of the first NMI via the new sev_es_nmi_complete()
  GHCB call.

* Add tests for cross-vCPU NMIs sent via the ICR, covering all destination
  modes (fixed-physical, fixed-logical, broadcast-all, and
  broadcast-excluding-self) to ensure the guest's #VC handler correctly
  routes them.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../selftests/kvm/include/x86/processor.h     |   5 +
 tools/testing/selftests/kvm/include/x86/sev.h |   1 +
 tools/testing/selftests/kvm/lib/x86/savic.c   |  15 +-
 tools/testing/selftests/kvm/lib/x86/sev.c     |  22 +
 tools/testing/selftests/kvm/x86/savic_test.c  | 388 ++++++++++++++----
 5 files changed, 351 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 769c6be41f1b..bdbd353fc683 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -924,6 +924,11 @@ static inline void vcpu_xcrs_set(struct kvm_vcpu *vcpu, struct kvm_xcrs *xcrs)
 	vcpu_ioctl(vcpu, KVM_SET_XCRS, xcrs);
 }
 
+static inline void vcpu_nmi(struct kvm_vcpu *vcpu)
+{
+	vcpu_ioctl(vcpu, KVM_NMI, NULL);
+}
+
 const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
 					       uint32_t function, uint32_t index);
 const struct kvm_cpuid2 *kvm_get_supported_cpuid(void);
diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index 3a95b13fb6c0..3bcbccf771ed 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -172,4 +172,5 @@ void sev_es_vc_handler(struct ex_regs *regs);
 void sev_es_pv_msr_rw(uint64_t msr, uint64_t *data, bool write);
 void sev_es_pv_mmio_rw(uint32_t *reg_gpa, uint32_t *data, bool write);
 void sev_es_savic_notify_gpa(uint64_t gpa);
+void sev_es_nmi_complete(void);
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/savic.c b/tools/testing/selftests/kvm/lib/x86/savic.c
index c941fd3f22df..75cfb85166d8 100644
--- a/tools/testing/selftests/kvm/lib/x86/savic.c
+++ b/tools/testing/selftests/kvm/lib/x86/savic.c
@@ -90,13 +90,15 @@ int savic_nr_pages_required(uint64_t page_size)
  */
 void set_savic_control_msr(struct guest_apic_page *apic_page, bool enable, bool enable_nmi)
 {
-	uint64_t val = apic_page->gpa | BIT_ULL(MSR_AMD64_SECURE_AVIC_EN_BIT);
+	uint64_t val;
 
 	if (!enable) {
 		wrmsr(MSR_AMD64_SECURE_AVIC_CONTROL, 0);
 		return;
 	}
 
+	val = apic_page->gpa | BIT_ULL(MSR_AMD64_SECURE_AVIC_EN_BIT);
+
 	if (enable_nmi)
 		val |= BIT_ULL(MSR_AMD64_SECURE_AVIC_ALLOWED_NMI_BIT);
 
@@ -440,15 +442,18 @@ static void savic_handle_icr_write(uint64_t icr_data)
 	bool logical           = icr_data & APIC_DEST_LOGICAL;
 	bool nmi               = (icr_data & APIC_DM_FIXED_MASK) == APIC_DM_NMI;
 	uint64_t self_icr_data = APIC_DEST_SELF | APIC_INT_ASSERT | vector;
-
-	if (nmi)
-		self_icr_data |= APIC_DM_NMI;
+	struct guest_apic_page *apic_page;
 
 	switch (dsh) {
 	case APIC_DEST_ALLINC:
 		savic_send_ipi_all_but(vector, nmi);
 		savic_hv_write_reg(APIC_ICR, icr_data);
-		x2apic_write_reg(APIC_ICR, self_icr_data);
+		if (nmi) {
+			apic_page = &apic_page_pool->guest_apic_page[x2apic_read_reg(APIC_ID)];
+			savic_write_reg(apic_page, SAVIC_NMI_REQ_OFFSET, 1);
+		} else {
+			x2apic_write_reg(APIC_ICR, self_icr_data);
+		}
 		break;
 	case APIC_DEST_ALLBUT:
 		savic_send_ipi_all_but(vector, nmi);
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 840504f0243c..ad1531cd0a5a 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -20,6 +20,7 @@
 #define SVM_VMGEXIT_MMIO_READ		   0x80000001
 #define SVM_VMGEXIT_MMIO_WRITE		   0x80000002
 #define SVM_VMGEXIT_SECURE_AVIC	   0x8000001a
+#define SVM_VMGEXIT_NMI_COMPLETE	0x80000003
 
 struct ghcb_entry {
 	struct ghcb ghcb;
@@ -750,3 +751,24 @@ void sev_es_savic_notify_gpa(uint64_t gpa)
 	__GUEST_ASSERT(!ret, "Secure AVIC GPA notification failed, ret: %d", ret);
 	ghcb_free(entry);
 }
+
+void sev_es_nmi_complete(void)
+{
+	struct ghcb_entry *entry;
+	struct ghcb *ghcb;
+	int ret;
+
+	entry = ghcb_alloc();
+	ghcb = &entry->ghcb;
+	register_ghcb_page(entry->gpa);
+
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_NMI_COMPLETE);
+	ghcb_set_sw_exit_info_1(ghcb, 0);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+
+	do_vmg_exit(entry->gpa);
+	ret = ghcb->save.sw_exit_info_1 & 0xffffffff;
+	__GUEST_ASSERT(!ret, "NMI completion failed, ret: %d", ret);
+
+	ghcb_free(entry);
+}
diff --git a/tools/testing/selftests/kvm/x86/savic_test.c b/tools/testing/selftests/kvm/x86/savic_test.c
index 4251f3427a32..3efefc1e69f5 100644
--- a/tools/testing/selftests/kvm/x86/savic_test.c
+++ b/tools/testing/selftests/kvm/x86/savic_test.c
@@ -13,8 +13,8 @@
 #include "test_util.h"
 #include "savic.h"
 
-#define NR_SAVIC_VCPUS	2
-#define NUM_ITERATIONS 2000
+#define NR_SAVIC_VCPUS	4
+#define NUM_ITERATIONS 1000
 
 #define IDLE_HLT_INTR_VECTOR     0x30
 #define IOAPIC_VECTOR_START      0x81
@@ -41,6 +41,13 @@ enum savic_test_state {
 	SAVIC_TEST_STATE(SAVIC_IOAPIC),
 	SAVIC_TEST_STATE(SAVIC_IOAPIC2),
 	SAVIC_TEST_STATE(SAVIC_IPI),
+	SAVIC_TEST_STATE(SAVIC_NMI),
+	SAVIC_TEST_STATE(SAVIC_NMI2),
+	SAVIC_TEST_STATE(SAVIC_NMI3),
+	SAVIC_TEST_STATE(SAVIC_ICR_FIXED_PHYS_NMI),
+	SAVIC_TEST_STATE(SAVIC_ICR_FIXED_LOGICAL_NMI),
+	SAVIC_TEST_STATE(SAVIC_ICR_BROADCAST_NMI),
+	SAVIC_TEST_STATE(SAVIC_ICR_BROADCAST_NOSELF_NMI),
 };
 
 /* Data struct shared between host main thread and vCPUs */
@@ -50,18 +57,32 @@ struct test_data_page {
 	uint64_t ioapic_lirq1_count;
 	uint64_t ioapic_lirq2_count;
 	uint64_t ioapic_rtc_gsi_irq_count;
-	uint64_t fixed_ipi_wake_count;
-	uint64_t fixed_ipi_hlt_count;
+	uint64_t fixed_phys_ipi_wake_count;
+	uint64_t fixed_phys_ipi_hlt_count;
 	uint64_t fixed_logical_ipi_hlt_count;
 	uint64_t fixed_logical_ipi_wake_count;
 	uint64_t broadcast_ipi_hlt_count;
 	uint64_t broadcast_ipi_wake_count;
 	uint64_t broadcast_noself_ipi_hlt_count;
 	uint64_t broadcast_noself_ipi_wake_count;
-	uint64_t fixed_ipi_count;
+	uint64_t fixed_phys_ipi_count;
 	uint64_t fixed_logical_ipi_count;
 	uint64_t broadcast_ipi_count;
 	uint64_t broadcast_noself_ipi_count;
+	uint64_t *nmi_count_p;
+	uint64_t nmi_count;
+	uint64_t fixed_phys_nmi_hlt_count;
+	uint64_t fixed_phys_nmi_wake_count;
+	uint64_t fixed_phys_nmi_count;
+	uint64_t fixed_logical_nmi_hlt_count;
+	uint64_t fixed_logical_nmi_wake_count;
+	uint64_t fixed_logical_nmi_count;
+	uint64_t broadcast_nmi_hlt_count;
+	uint64_t broadcast_nmi_wake_count;
+	uint64_t broadcast_nmi_count;
+	uint64_t broadcast_noself_nmi_hlt_count;
+	uint64_t broadcast_noself_nmi_wake_count;
+	uint64_t broadcast_noself_nmi_count;
 };
 
 static struct test_data_page *test_data[NR_SAVIC_VCPUS];
@@ -324,9 +345,14 @@ static void _ioapic_level_irq_handler(int vec)
 		vec);
 }
 
+static inline struct test_data_page *get_test_data(void)
+{
+	return test_data[x2apic_read_reg(APIC_ID)];
+}
+
 static void ioapic_level_irq1_intr_handler(struct ex_regs *regs)
 {
-	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+	struct test_data_page *data = get_test_data();
 	int vec;
 
 	vec = IOAPIC_VECTOR_START + IOAPIC_NUM_EDGE_VECTORS;
@@ -336,7 +362,7 @@ static void ioapic_level_irq1_intr_handler(struct ex_regs *regs)
 
 static void ioapic_level_irq2_intr_handler(struct ex_regs *regs)
 {
-	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+	struct test_data_page *data = get_test_data();
 	int vec;
 
 	vec = IOAPIC_VECTOR_START + IOAPIC_NUM_EDGE_VECTORS + 1;
@@ -346,7 +372,7 @@ static void ioapic_level_irq2_intr_handler(struct ex_regs *regs)
 
 static void ioapic_edge_irq1_intr_handler(struct ex_regs *regs)
 {
-	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+	struct test_data_page *data = get_test_data();
 
 	WRITE_ONCE(data->ioapic_eirq1_count, data->ioapic_eirq1_count + 1);
 	x2apic_write_reg(APIC_EOI, 0x00);
@@ -354,7 +380,7 @@ static void ioapic_edge_irq1_intr_handler(struct ex_regs *regs)
 
 static void ioapic_edge_irq2_intr_handler(struct ex_regs *regs)
 {
-	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+	struct test_data_page *data = get_test_data();
 
 	WRITE_ONCE(data->ioapic_eirq2_count, data->ioapic_eirq2_count + 1);
 	x2apic_write_reg(APIC_EOI, 0x00);
@@ -362,7 +388,7 @@ static void ioapic_edge_irq2_intr_handler(struct ex_regs *regs)
 
 static void ioapic_rtc_gsi_intr_handler(struct ex_regs *regs)
 {
-	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+	struct test_data_page *data = get_test_data();
 
 	WRITE_ONCE(data->ioapic_rtc_gsi_irq_count, data->ioapic_rtc_gsi_irq_count + 1);
 	x2apic_write_reg(APIC_EOI, 0x00);
@@ -370,7 +396,7 @@ static void ioapic_rtc_gsi_intr_handler(struct ex_regs *regs)
 
 static void __savic_ioapic(int count)
 {
-	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+	struct test_data_page *data = get_test_data();
 	int vec = IOAPIC_VECTOR_START;
 
 	__GUEST_ASSERT(READ_ONCE(data->ioapic_eirq1_count) == count,
@@ -469,10 +495,40 @@ static void guest_setup_ioapic(int id)
 	savic_allow_vector(vec);
 }
 
-static void savic_fixed_ipi(bool logical)
+static void set_fixed_counters(
+		struct test_data_page *data,
+		uint64_t **fixed_ipi_p,
+		uint64_t **fixed_ipi_hlt_cnt_p,
+		uint64_t **fixed_ipi_wake_cnt_p,
+		bool logical, bool nmi)
+{
+	if (logical) {
+		*fixed_ipi_p =
+			nmi ? &data->fixed_logical_nmi_count :
+			      &data->fixed_logical_ipi_count;
+		*fixed_ipi_hlt_cnt_p =
+			nmi ? &data->fixed_logical_nmi_hlt_count :
+			      &data->fixed_logical_ipi_hlt_count;
+		*fixed_ipi_wake_cnt_p =
+			nmi ? &data->fixed_logical_nmi_wake_count :
+			      &data->fixed_logical_ipi_wake_count;
+	} else {
+		*fixed_ipi_p =
+			nmi ? &data->fixed_phys_nmi_count :
+			      &data->fixed_phys_ipi_count;
+		*fixed_ipi_hlt_cnt_p =
+			nmi ? &data->fixed_phys_nmi_hlt_count :
+			      &data->fixed_phys_ipi_hlt_count;
+		*fixed_ipi_wake_cnt_p =
+			nmi ? &data->fixed_phys_nmi_wake_count :
+			      &data->fixed_phys_ipi_wake_count;
+	}
+}
+
+static void savic_fixed_ipi(bool logical, bool nmi)
 {
 	uint64_t last_wake_cnt, last_hlt_cnt;
-	uint64_t last_fixed_ipi_cnt;
+	uint64_t last_fixed_phys_ipi_cnt;
 	uint64_t tsc_start;
 	uint64_t *fixed_ipi_p;
 	uint64_t *fixed_ipi_hlt_cnt_p;
@@ -484,26 +540,26 @@ static void savic_fixed_ipi(bool logical)
 		struct test_data_page *data = test_data[i];
 		uint64_t dst_apic_id = i;
 
+		set_fixed_counters(data, &fixed_ipi_p,
+				&fixed_ipi_hlt_cnt_p, &fixed_ipi_wake_cnt_p,
+				logical, nmi);
 		if (logical) {
-			fixed_ipi_p = &data->fixed_logical_ipi_count;
-			fixed_ipi_hlt_cnt_p = &data->fixed_logical_ipi_hlt_count;
-			fixed_ipi_wake_cnt_p = &data->fixed_logical_ipi_wake_count;
 			vec = FIXED_LOGICAL_IPI_VEC | APIC_DEST_LOGICAL;
 			dst_apic_id = 1 << i;
 		} else {
-			fixed_ipi_p = &data->fixed_ipi_count;
-			fixed_ipi_hlt_cnt_p = &data->fixed_ipi_hlt_count;
-			fixed_ipi_wake_cnt_p = &data->fixed_ipi_wake_count;
 			vec = FIXED_IPI_VEC;
 			dst_apic_id = i;
 		}
 
+		if (nmi)
+			vec |= APIC_DM_NMI;
+
 		last_wake_cnt = READ_ONCE(*fixed_ipi_wake_cnt_p);
 		while (!READ_ONCE(*fixed_ipi_hlt_cnt_p))
 			;
 
 		last_hlt_cnt = READ_ONCE(*fixed_ipi_hlt_cnt_p);
-		last_fixed_ipi_cnt = READ_ONCE(*fixed_ipi_p);
+		last_fixed_phys_ipi_cnt = READ_ONCE(*fixed_ipi_p);
 
 		for (j = 0; j < NUM_ITERATIONS; j++) {
 			tsc_start = rdtsc();
@@ -512,31 +568,73 @@ static void savic_fixed_ipi(bool logical)
 			while (rdtsc() - tsc_start < 1000000000) {
 				if (READ_ONCE(*fixed_ipi_wake_cnt_p) != last_wake_cnt &&
 				    READ_ONCE(*fixed_ipi_hlt_cnt_p) != last_hlt_cnt &&
-				    READ_ONCE(*fixed_ipi_p) != last_fixed_ipi_cnt)
+				    READ_ONCE(*fixed_ipi_p) != last_fixed_phys_ipi_cnt)
 					break;
 			}
 
 			__GUEST_ASSERT(READ_ONCE(*fixed_ipi_wake_cnt_p) != last_wake_cnt &&
 				       READ_ONCE(*fixed_ipi_hlt_cnt_p) != last_hlt_cnt &&
-				       READ_ONCE(*fixed_ipi_p) != last_fixed_ipi_cnt,
-				       "wakeup_cnt: %ld last_wake_cnt: %ld hlt_count: %ld last_hlt_cnt: %ld d_ipi_count: %ld last_d_ipi_count: %ld",
+				       READ_ONCE(*fixed_ipi_p) != last_fixed_phys_ipi_cnt,
+				       "%s fixed-%s wake: %ld last_wake: %ld hlt: %ld last_hlt: %ld ipi: %ld last_ipi: %ld",
+				       nmi ? "nmi" : "ipi",
+				       logical ? "logical" : "phys",
 				       READ_ONCE(*fixed_ipi_wake_cnt_p), last_wake_cnt,
 				       READ_ONCE(*fixed_ipi_hlt_cnt_p), last_hlt_cnt,
-				       READ_ONCE(*fixed_ipi_p), last_fixed_ipi_cnt);
+				       READ_ONCE(*fixed_ipi_p), last_fixed_phys_ipi_cnt);
 
 			last_wake_cnt = READ_ONCE(*fixed_ipi_wake_cnt_p);
 			last_hlt_cnt = READ_ONCE(*fixed_ipi_hlt_cnt_p);
-			last_fixed_ipi_cnt = READ_ONCE(*fixed_ipi_p);
+			last_fixed_phys_ipi_cnt = READ_ONCE(*fixed_ipi_p);
 		}
 	}
 }
 
-static void savic_send_broadcast(int dsh)
+static uint64_t *get_broadcast_ipi_counter(struct test_data_page *data,
+		int dsh, bool nmi)
+{
+	if (dsh == APIC_DEST_ALLINC)
+		return nmi ?
+			&data->broadcast_nmi_count :
+			&data->broadcast_ipi_count;
+	else
+		return nmi ?
+			&data->broadcast_noself_nmi_count :
+			&data->broadcast_noself_ipi_count;
+}
+
+
+static uint64_t *get_broadcast_hlt_counter(struct test_data_page *data,
+		int dsh, bool nmi)
+{
+	if (dsh == APIC_DEST_ALLINC)
+		return nmi ?
+			&data->broadcast_nmi_hlt_count :
+			&data->broadcast_ipi_hlt_count;
+	else
+		return nmi ?
+			&data->broadcast_noself_nmi_hlt_count :
+			&data->broadcast_noself_ipi_hlt_count;
+}
+
+static uint64_t *get_broadcast_wake_counter(struct test_data_page *data,
+		int dsh, bool nmi)
+{
+	if (dsh == APIC_DEST_ALLINC)
+		return nmi ?
+			&data->broadcast_nmi_wake_count :
+			&data->broadcast_ipi_wake_count;
+	else
+		return nmi ?
+			&data->broadcast_noself_nmi_wake_count :
+			&data->broadcast_noself_ipi_wake_count;
+}
+
+static void savic_send_broadcast(int dsh, bool nmi)
 {
 	uint64_t last_wake_cnt[NR_SAVIC_VCPUS], last_hlt_cnt[NR_SAVIC_VCPUS];
 	uint64_t last_ipi_cnt[NR_SAVIC_VCPUS];
 	uint64_t tsc_start;
-	uint64_t *broadcast_ipi_p;
+	uint64_t *broadcast_ipi_cnt_p;
 	uint64_t *broadcast_ipi_hlt_cnt_p;
 	uint64_t *broadcast_ipi_wake_cnt_p;
 	struct test_data_page *data;
@@ -551,10 +649,8 @@ static void savic_send_broadcast(int dsh)
 	for (i = 1; i < NR_SAVIC_VCPUS; i++) {
 		data = test_data[i];
 
-		if (dsh == APIC_DEST_ALLINC)
-			broadcast_ipi_hlt_cnt_p = &data->broadcast_ipi_hlt_count;
-		else
-			broadcast_ipi_hlt_cnt_p = &data->broadcast_noself_ipi_hlt_count;
+		broadcast_ipi_hlt_cnt_p = get_broadcast_hlt_counter(
+				data, dsh, nmi);
 
 		while (!READ_ONCE(*broadcast_ipi_hlt_cnt_p))
 			;
@@ -564,17 +660,20 @@ static void savic_send_broadcast(int dsh)
 		for (i = 1; i < NR_SAVIC_VCPUS; i++) {
 			data = test_data[i];
 
-			if (dsh == APIC_DEST_ALLINC) {
-				last_hlt_cnt[i] = READ_ONCE(data->broadcast_ipi_hlt_count);
-				last_ipi_cnt[i] = READ_ONCE(data->broadcast_ipi_count);
-				last_wake_cnt[i] = READ_ONCE(data->broadcast_ipi_wake_count);
-			} else {
-				last_hlt_cnt[i] = READ_ONCE(data->broadcast_noself_ipi_hlt_count);
-				last_ipi_cnt[i] = READ_ONCE(data->broadcast_noself_ipi_count);
-				last_wake_cnt[i] = READ_ONCE(data->broadcast_noself_ipi_wake_count);
-			}
+			broadcast_ipi_cnt_p = get_broadcast_ipi_counter(
+				data, dsh, nmi);
+			broadcast_ipi_hlt_cnt_p = get_broadcast_hlt_counter(
+				data, dsh, nmi);
+			broadcast_ipi_wake_cnt_p = get_broadcast_wake_counter(
+				data, dsh, nmi);
+			last_ipi_cnt[i] = *broadcast_ipi_cnt_p;
+			last_hlt_cnt[i] = *broadcast_ipi_hlt_cnt_p;
+			last_wake_cnt[i] = *broadcast_ipi_wake_cnt_p;
 		}
 
+		if (nmi)
+			vec |= APIC_DM_NMI;
+
 		x2apic_write_reg(APIC_ICR, APIC_INT_ASSERT | dsh | vec);
 
 		tsc_start = rdtsc();
@@ -582,60 +681,59 @@ static void savic_send_broadcast(int dsh)
 		for (i = 1; i < NR_SAVIC_VCPUS; i++) {
 			data = test_data[i];
 
-			if (dsh == APIC_DEST_ALLINC) {
-				broadcast_ipi_p = &data->broadcast_ipi_count;
-				broadcast_ipi_hlt_cnt_p = &data->broadcast_ipi_hlt_count;
-				broadcast_ipi_wake_cnt_p = &data->broadcast_ipi_wake_count;
-			} else {
-				broadcast_ipi_p = &data->broadcast_noself_ipi_count;
-				broadcast_ipi_hlt_cnt_p = &data->broadcast_noself_ipi_hlt_count;
-				broadcast_ipi_wake_cnt_p = &data->broadcast_noself_ipi_wake_count;
-			}
+			broadcast_ipi_cnt_p = get_broadcast_ipi_counter(
+				data, dsh, nmi);
+			broadcast_ipi_hlt_cnt_p = get_broadcast_hlt_counter(
+				data, dsh, nmi);
+			broadcast_ipi_wake_cnt_p = get_broadcast_wake_counter(
+				data, dsh, nmi);
 
 			while (rdtsc() - tsc_start < 1000000000) {
 				if (READ_ONCE(*broadcast_ipi_wake_cnt_p) != last_wake_cnt[i] &&
 				    READ_ONCE(*broadcast_ipi_hlt_cnt_p) != last_hlt_cnt[i] &&
-				    READ_ONCE(*broadcast_ipi_p) != last_ipi_cnt[i])
+				    READ_ONCE(*broadcast_ipi_cnt_p) != last_ipi_cnt[i])
 					break;
 			}
 
 			__GUEST_ASSERT(READ_ONCE(*broadcast_ipi_wake_cnt_p) != last_wake_cnt[i] &&
 				       READ_ONCE(*broadcast_ipi_hlt_cnt_p) != last_hlt_cnt[i] &&
-				       READ_ONCE(*broadcast_ipi_p) != last_ipi_cnt[i],
-				       "wakeup_cnt: %ld last_wake_cnt: %ld hlt_count: %ld last_hlt_cnt: %ld b_ipi_count: %ld last_b_ipi_count: %ld",
+				       READ_ONCE(*broadcast_ipi_cnt_p) != last_ipi_cnt[i],
+				       "%s broadcast-%s wake: %ld last_wake: %ld hlt: %ld last_hlt: %ld ipi: %ld last_ipi: %ld",
+				       nmi ? "nmi" : "ipi",
+				       dsh == APIC_DEST_ALLINC ? "all" : "excl-self",
 				       READ_ONCE(*broadcast_ipi_wake_cnt_p), last_wake_cnt[i],
 				       READ_ONCE(*broadcast_ipi_hlt_cnt_p), last_hlt_cnt[i],
-				       READ_ONCE(*broadcast_ipi_p), last_ipi_cnt[i]);
+				       READ_ONCE(*broadcast_ipi_cnt_p), last_ipi_cnt[i]);
 
 			last_wake_cnt[i] = READ_ONCE(*broadcast_ipi_wake_cnt_p);
 			last_hlt_cnt[i] = READ_ONCE(*broadcast_ipi_hlt_cnt_p);
-			last_ipi_cnt[i] = READ_ONCE(*broadcast_ipi_p);
+			last_ipi_cnt[i] = READ_ONCE(*broadcast_ipi_cnt_p);
 		}
 	}
 }
 
 void savic_ipi(int id)
 {
-	savic_fixed_ipi(false);
-	savic_fixed_ipi(true);
+	savic_fixed_ipi(false, false);
+	savic_fixed_ipi(true, false);
 
 	asm volatile("sti;":::"memory");
 	x2apic_write_reg(APIC_TASKPRI, 0);
-	savic_send_broadcast(APIC_DEST_ALLINC);
-	savic_send_broadcast(APIC_DEST_ALLBUT);
+	savic_send_broadcast(APIC_DEST_ALLINC, false);
+	savic_send_broadcast(APIC_DEST_ALLBUT, false);
 }
 
-void guest_fixed_ipi_handler(struct ex_regs *regs)
+void guest_fixed_phys_ipi_handler(struct ex_regs *regs)
 {
-	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+	struct test_data_page *data = get_test_data();
 
-	WRITE_ONCE(data->fixed_ipi_count, data->fixed_ipi_count + 1);
+	WRITE_ONCE(data->fixed_phys_ipi_count, data->fixed_phys_ipi_count + 1);
 	x2apic_write_reg(APIC_EOI, 0x00);
 }
 
 void guest_fixed_logical_ipi_handler(struct ex_regs *regs)
 {
-	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+	struct test_data_page *data = get_test_data();
 
 	WRITE_ONCE(data->fixed_logical_ipi_count, data->fixed_logical_ipi_count + 1);
 	x2apic_write_reg(APIC_EOI, 0x00);
@@ -643,7 +741,7 @@ void guest_fixed_logical_ipi_handler(struct ex_regs *regs)
 
 void guest_broadcast_ipi_handler(struct ex_regs *regs)
 {
-	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+	struct test_data_page *data = get_test_data();
 
 	WRITE_ONCE(data->broadcast_ipi_count, data->broadcast_ipi_count + 1);
 	x2apic_write_reg(APIC_EOI, 0x00);
@@ -651,13 +749,65 @@ void guest_broadcast_ipi_handler(struct ex_regs *regs)
 
 void guest_broadcast_noself_ipi_handler(struct ex_regs *regs)
 {
-	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+	struct test_data_page *data = get_test_data();
 
 	WRITE_ONCE(data->broadcast_noself_ipi_count, data->broadcast_noself_ipi_count + 1);
 	x2apic_write_reg(APIC_EOI, 0x00);
 }
 
-static void ipi_guest_code(int id, unsigned long secondary_entry)
+static void savic_nmi(int id)
+{
+	struct test_data_page *data = get_test_data();
+
+	__GUEST_ASSERT(!data->nmi_count, "Invalid NMI count: %ld\n", data->nmi_count);
+	set_savic_control_msr(get_guest_apic_page(), true, true);
+}
+
+static void savic_nmi2(int id)
+{
+	struct test_data_page *data = get_test_data();
+
+	__GUEST_ASSERT(data->nmi_count == 2, "Invalid NMI count: %ld\n", data->nmi_count);
+}
+
+static void savic_nmi3(int id)
+{
+	struct test_data_page *data = get_test_data();
+
+	__GUEST_ASSERT(data->nmi_count == 4, "Invalid NMI count: %ld\n", data->nmi_count);
+}
+
+static void savic_icr_fixed_phys(int id)
+{
+	savic_fixed_ipi(false, true);
+}
+
+static void savic_icr_fixed_logical(int id)
+{
+	savic_fixed_ipi(true, true);
+}
+
+static void savic_icr_bcast(int id)
+{
+	savic_send_broadcast(APIC_DEST_ALLINC, true);
+}
+
+static void savic_icr_bcast_noself(int id)
+{
+	savic_send_broadcast(APIC_DEST_ALLBUT, true);
+}
+
+static void guest_nmi_handler(struct ex_regs *regs)
+{
+	struct test_data_page *data = get_test_data();
+
+	WRITE_ONCE(*data->nmi_count_p, *data->nmi_count_p + 1);
+	/* Skip NMI completed notification for ICR based NMI. */
+	if (data->nmi_count_p == &data->nmi_count)
+		sev_es_nmi_complete();
+}
+
+static void ipi_guest_code(int id)
 {
 	struct test_data_page *data;
 	uint64_t *ipi_count_p, *hlt_count_p, *wake_count_p;
@@ -671,9 +821,9 @@ static void ipi_guest_code(int id, unsigned long secondary_entry)
 
 	uint64_t *ipi_count_types[][3] = {
 		{
-			&data->fixed_ipi_hlt_count,
-			&data->fixed_ipi_count,
-			&data->fixed_ipi_wake_count
+			&data->fixed_phys_ipi_hlt_count,
+			&data->fixed_phys_ipi_count,
+			&data->fixed_phys_ipi_wake_count
 		},
 		{
 			&data->fixed_logical_ipi_hlt_count,
@@ -690,6 +840,26 @@ static void ipi_guest_code(int id, unsigned long secondary_entry)
 			&data->broadcast_noself_ipi_count,
 			&data->broadcast_noself_ipi_wake_count
 		},
+		{
+			&data->fixed_phys_nmi_hlt_count,
+			&data->fixed_phys_nmi_count,
+			&data->fixed_phys_nmi_wake_count
+		},
+		{
+			&data->fixed_logical_nmi_hlt_count,
+			&data->fixed_logical_nmi_count,
+			&data->fixed_logical_nmi_wake_count
+		},
+		{
+			&data->broadcast_nmi_hlt_count,
+			&data->broadcast_nmi_count,
+			&data->broadcast_nmi_wake_count
+		},
+		{
+			&data->broadcast_noself_nmi_hlt_count,
+			&data->broadcast_noself_nmi_count,
+			&data->broadcast_noself_nmi_wake_count
+		},
 	};
 
 	for (i = 0; i < ARRAY_SIZE(ipi_count_types); i++) {
@@ -698,9 +868,11 @@ static void ipi_guest_code(int id, unsigned long secondary_entry)
 		wake_count_p = ipi_count_types[i][2];
 
 		while (READ_ONCE(*ipi_count_p) != NUM_ITERATIONS) {
-			asm volatile("cli");
+			if (i < 4)
+				asm volatile("cli");
 			WRITE_ONCE(*hlt_count_p, *hlt_count_p + 1);
-			asm volatile("sti; hlt" : : : "memory");
+			if (i < 4)
+				asm volatile("sti; hlt" : : : "memory");
 			WRITE_ONCE(*wake_count_p, *wake_count_p + 1);
 		}
 
@@ -712,6 +884,9 @@ static void ipi_guest_code(int id, unsigned long secondary_entry)
 
 static void guest_code(int id)
 {
+	struct test_data_page *data;
+	int i;
+
 	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SNP_SECURE_AVIC);
 
 	x2apic_enable();
@@ -728,6 +903,39 @@ static void guest_code(int id)
 
 	SAVIC_GUEST_SYNC(SAVIC_IPI, savic_ipi);
 
+	/* Disable host NMI injection in control MSR. */
+	set_savic_control_msr(get_guest_apic_page(), true, false);
+
+	data = test_data[id];
+	data->nmi_count_p = &data->nmi_count;
+	SAVIC_GUEST_SYNC(SAVIC_NMI, savic_nmi);
+	SAVIC_GUEST_SYNC(SAVIC_NMI2, savic_nmi2);
+	SAVIC_GUEST_SYNC(SAVIC_NMI3, savic_nmi3);
+
+	for (i = 0; i < NR_SAVIC_VCPUS; i++) {
+		data = test_data[i];
+		data->nmi_count_p = &data->fixed_phys_nmi_count;
+	}
+	SAVIC_GUEST_SYNC(SAVIC_ICR_FIXED_PHYS_NMI, savic_icr_fixed_phys);
+
+	for (i = 0; i < NR_SAVIC_VCPUS; i++) {
+		data = test_data[i];
+		data->nmi_count_p = &data->fixed_logical_nmi_count;
+	}
+	SAVIC_GUEST_SYNC(SAVIC_ICR_FIXED_LOGICAL_NMI, savic_icr_fixed_logical);
+
+	for (i = 0; i < NR_SAVIC_VCPUS; i++) {
+		data = test_data[i];
+		data->nmi_count_p = &data->broadcast_nmi_count;
+	}
+	SAVIC_GUEST_SYNC(SAVIC_ICR_BROADCAST_NMI, savic_icr_bcast);
+
+	for (i = 0; i < NR_SAVIC_VCPUS; i++) {
+		data = test_data[i];
+		data->nmi_count_p = &data->broadcast_noself_nmi_count;
+	}
+	SAVIC_GUEST_SYNC(SAVIC_ICR_BROADCAST_NOSELF_NMI, savic_icr_bcast_noself);
+
 	GUEST_DONE();
 }
 
@@ -745,6 +953,12 @@ static void host_send_ioapic_irq(struct kvm_vm *vm, int id)
 	kvm_irq_line_status(vm, RTC_GSI, 0);
 }
 
+static void host_send_nmi(int id)
+{
+	vcpu_nmi(vcpus[id]);
+	vcpu_nmi(vcpus[id]);
+}
+
 static void host_test_savic(struct kvm_vm *vm, int id, enum savic_test_state test_state)
 {
 	switch (test_state) {
@@ -754,6 +968,11 @@ static void host_test_savic(struct kvm_vm *vm, int id, enum savic_test_state tes
 	case SAVIC_IOAPIC2_START:
 		host_send_ioapic_irq(vm, id);
 		break;
+	case SAVIC_NMI_START:
+	case SAVIC_NMI2_START:
+	case SAVIC_NMI3_START:
+		host_send_nmi(id);
+		break;
 	default:
 		break;
 	}
@@ -796,11 +1015,12 @@ static void install_exception_handlers(struct kvm_vm *vm)
 	vm_install_exception_handler(vm, IOAPIC_VECTOR_START + 2, ioapic_level_irq1_intr_handler);
 	vm_install_exception_handler(vm, IOAPIC_VECTOR_START + 3, ioapic_level_irq2_intr_handler);
 	vm_install_exception_handler(vm, RTC_GSI_IRQ, ioapic_rtc_gsi_intr_handler);
-	vm_install_exception_handler(vm, FIXED_IPI_VEC, guest_fixed_ipi_handler);
+	vm_install_exception_handler(vm, FIXED_IPI_VEC, guest_fixed_phys_ipi_handler);
 	vm_install_exception_handler(vm, FIXED_LOGICAL_IPI_VEC, guest_fixed_logical_ipi_handler);
 	vm_install_exception_handler(vm, BROADCAST_ALL_IPI_VEC, guest_broadcast_ipi_handler);
 	vm_install_exception_handler(vm, BROADCAST_NOSELF_IPI_VEC,
 			guest_broadcast_noself_ipi_handler);
+	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
 }
 
 int main(int argc, char *argv[])
@@ -861,9 +1081,9 @@ int main(int argc, char *argv[])
 		fprintf(stderr, "VCPU %d ioapic level irq1 count: %ld level irq2 count: %ld\n", i, shared_state->ioapic_lirq1_count, shared_state->ioapic_lirq2_count);
 		fprintf(stderr, "VCPU %d ioapic RTC GSI irq1 count: %ld\n", i, shared_state->ioapic_rtc_gsi_irq_count);
 		fprintf(stderr, "vCPU %d fixed IPI counts wake: %ld hlt: %ld num-IPI: %ld\n",
-			i, shared_state->fixed_ipi_wake_count,
-			shared_state->fixed_ipi_hlt_count,
-			shared_state->fixed_ipi_count);
+			i, shared_state->fixed_phys_ipi_wake_count,
+			shared_state->fixed_phys_ipi_hlt_count,
+			shared_state->fixed_phys_ipi_count);
 		fprintf(stderr, "vCPU %d fixed-logical IPI counts wake: %ld hlt: %ld num-IPI: %ld\n",
 			i, shared_state->fixed_logical_ipi_wake_count,
 			shared_state->fixed_logical_ipi_hlt_count,
@@ -872,10 +1092,28 @@ int main(int argc, char *argv[])
 			i, shared_state->broadcast_ipi_wake_count,
 			shared_state->broadcast_ipi_hlt_count,
 			shared_state->broadcast_ipi_count);
-		fprintf(stderr, "vCPU %d broadcast exluding self IPI counts wake: %ld hlt: %ld num-IPI: %ld\n",
+		fprintf(stderr, "vCPU %d broadcast excluding self IPI counts wake: %ld hlt: %ld num-IPI: %ld\n",
 			i, shared_state->broadcast_noself_ipi_wake_count,
 			shared_state->broadcast_noself_ipi_hlt_count,
 			shared_state->broadcast_noself_ipi_count);
+		fprintf(stderr, "vCPU %d nmi count: %ld\n",
+			i, shared_state->nmi_count);
+		fprintf(stderr, "vCPU %d nmi fixed IPI counts wake: %ld hlt: %ld num-IPI: %ld\n",
+			i, shared_state->fixed_phys_nmi_wake_count,
+			shared_state->fixed_phys_nmi_hlt_count,
+			shared_state->fixed_phys_nmi_count);
+		fprintf(stderr, "vCPU %d nmi fixed-logical IPI counts wake: %ld hlt: %ld num-IPI: %ld\n",
+			i, shared_state->fixed_logical_nmi_wake_count,
+			shared_state->fixed_logical_nmi_hlt_count,
+			shared_state->fixed_logical_nmi_count);
+		fprintf(stderr, "vCPU %d nmi broadcast IPI counts wake: %ld hlt: %ld num-IPI: %ld\n",
+			i, shared_state->broadcast_nmi_wake_count,
+			shared_state->broadcast_nmi_hlt_count,
+			shared_state->broadcast_nmi_count);
+		fprintf(stderr, "vCPU %d nmi broadcast excluding self IPI counts wake: %ld hlt: %ld num-IPI: %ld\n",
+			i, shared_state->broadcast_noself_nmi_wake_count,
+			shared_state->broadcast_noself_nmi_hlt_count,
+			shared_state->broadcast_noself_nmi_count);
 	}
 
 	kvm_vm_free(vm);
-- 
2.34.1


