Return-Path: <linux-kselftest+bounces-27872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5303AA496B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 11:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6853B8055
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83937266EEB;
	Fri, 28 Feb 2025 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fO81FAu/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E996725CC9A;
	Fri, 28 Feb 2025 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737312; cv=fail; b=aUaBoNYYrngxaw4VQGDMntJ7HRirsegBpgrOKGB7WXurBQc1szkmHSlsHr8cY2IgkYOIGCX7IWVkC0jv59QHHnZoZhpRYeX8vWkbTR0Kf+XU1BKmNNmN3wkE3XmhzIvwf0kfOZy8MkN50oAJ6ujMP8sd7O/mOShfqm4XPY863CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737312; c=relaxed/simple;
	bh=qCET8kJDixzCKqejduyQbgihL2uHRYK8KCZR8lEEkN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEIYPWNuFFpVstcGMdy+CV/jkni3me4dK/lMrxn5gdUzR/e68051T/drDFG7TAN70Ho4rPuV+albFdrWJ/EcNUkt5hskKX5h529wUCCtPoO5swmjanoWP0q1EIdrm67xKZrpmdn8wp5ooB8ZRKjJhI4xVNsQEaLLlzYiMVHk8Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fO81FAu/; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvdV9UmNhHxFB5jxN9R8DzC3yjpI13lP8ARbhWMSb3nJNHgkCisqQ7nqhtWpf9khE+dCT2Ys3I6tCl/S+i9KzfDu5OjJ1BXxxm9Kx9mJI6xNZI5hjvMWxf012QUU5sgEpwMJn5AjBlk0vbIQ/MPH4sux9kJZpWIK9Y/Cn7SY0lDXVDufZNAkNHOJM0E/yCGSWjvenPzWzrf9Fg+8bGqtYb5jx8Xg/TTFJIV6/RiTbFiCH89ba3ESOh4rj7qRB8LNg8Rq6juIRFg4tUC8IZZW6P5vsrE69zUcZync43qjjEvXhI6fmxk7qrdI5BGTUhix3H95pbjKx6nJ9963ulRxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcXUSoh8F7z+vI67WUFYQZWlJfSDxkOGQ54KWZzn95I=;
 b=rhX36ABq79alx6ml4uyb+mHRYYE34FAee5ueoIwdhcitiJYLnNF+IoLDq8P6n61JmEaR6dMD0Oi3N6XSP/pEI9KBqzu9ckHUbaRHMNGbMkopMfDnAwRwgjI2ArzKYtqzaS5CBaRR/e9o13KDZhbCMx99CIjQ/x4KYbkl5/YJMseMUv5TYCu91yzmqMIEoix3S222Fep2MC5zb4bxUslfuS+STX8M07kZewpmRPOf/+LCLJITfl6BcWsw+vl9JRCS6J5Q5cEt5Qdey2stBBh3QIXVd7olKJoV8ypuQWOVNpxRdUWDeJxFffWLlcmmT/2dbnFbvn+HNs50a4YIiWuBZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcXUSoh8F7z+vI67WUFYQZWlJfSDxkOGQ54KWZzn95I=;
 b=fO81FAu/+Oe47p4MoLl0+xuT4dvH0HVhIRsVlrP1Yl2loJO32vw3NGYSwFs3tqb2maMg9uP87MGuVtAcxrXk5e0buuryixnZ0GeTV1OZCxub1ZXf0dAUq4qlCAbOfnc/YVe9pAX7LJaDIsdSdaMsM4Mb5kENm0z32d8OZobWs2M=
Received: from CH3P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::6)
 by SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 10:08:25 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::5) by CH3P221CA0015.outlook.office365.com
 (2603:10b6:610:1e7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 10:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 10:08:24 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 04:07:27 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 30/31] KVM: selftests: Add NMI test for SAVIC guests
Date: Fri, 28 Feb 2025 15:00:23 +0530
Message-ID: <20250228093024.114983-31-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228093024.114983-1-Neeraj.Upadhyay@amd.com>
References: <20250228093024.114983-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a00fa3-5208-4a81-0f0e-08dd57dfd694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wXeqUSGWsDfbjgpVMiqYa0WDJRGzP1buwvj+TnJoV67n8wuBnSiyC5HN8DQ+?=
 =?us-ascii?Q?LHC0Rt/NyEReQt0OPq3jI71+IH0hUGP2tbqp4SgDMrZJbmNxjvGEV6xc/CEV?=
 =?us-ascii?Q?Z+Rap8HQe+vHj6NRfYLiCHnO82LgHY/qQgl0rcujuSJGCJesytIU7qJ+bDTl?=
 =?us-ascii?Q?c2nQHEaxjDNsJIGG0GgAYbjrcAfRowti+tR2djoArjTxo3SJWgdW+ndyqBQu?=
 =?us-ascii?Q?gN6DatTZ3idqrdSVtQ8oNi3tp/UBZPzV1UNKsLFeQvj3DxIYQQoWTsx9BXZG?=
 =?us-ascii?Q?m6uFSnp+sHl1Mn2X7acyDaQOGlGkxmBQ5eCSoMggZnLwt51NAT4+uJOMtY/7?=
 =?us-ascii?Q?iliawFihQstsiglgsoLPgtnAchoFwknPpzKShekOJpro38cmFHeMcWuR3x22?=
 =?us-ascii?Q?12jWpltm9hn6zSt8qwcZ/k1gpZzdKicprCYck84QmtkWm2kpLTMlK4+LYqbf?=
 =?us-ascii?Q?muFH1Y92oDhI3W8hinz/OE2lPAisBeKTHPVWZ9vQZoUewEkhF4T68lWo/aJO?=
 =?us-ascii?Q?zhqepv9m2fvNrg0I99PruwA7MinzL3wEG2c/EBos7bxpMqBqChSKVYfcTa9G?=
 =?us-ascii?Q?recExfynuAfGG6HbudvGC5rb34b/y2124s6iHqdn6x1hZ4i0eTZLBD/LOujZ?=
 =?us-ascii?Q?PHH6RtkcK4NDJNlzkBiBHkD5//xdpc9EHCCH+wV4NdJZZSYzhspnNaTGNKYW?=
 =?us-ascii?Q?/o4kABeUnTE0DvjSk6tnP3wIUEfYgNJLQV9fcHL5p8PV3pIHhDitZP/2dksR?=
 =?us-ascii?Q?gJshVblfMoXUwKXwEJPXwxMcfb6k5gGvcYJj6TvyDDAsDihIeYkkEhgm4hl6?=
 =?us-ascii?Q?mSJz/epRGbDuE7QRcLDWDuhbg2QUdAguF6WhlnuZeksdnKFnWbvNfKnDF4VQ?=
 =?us-ascii?Q?2ofisrYxLGHD7I/QmZ4vKnzhiIadlOA+94fJitQ7PFOkz1EhBn1m65GWHLGE?=
 =?us-ascii?Q?KmJqPpSw3HWvctSgkV+3NabqcB9+4NiWxwa9CoZsP52fjgTJDi6TiUQU0liI?=
 =?us-ascii?Q?lsi/3/dDenMIYQUvwvekScb/o1Jp/PY5zabU44LMrr+J/dDlIUKmuL/q5pV5?=
 =?us-ascii?Q?WKl96VRz8bUancEKCZWDp6RoHgoOm3qxYnOb3yrgzFEo6Q0Bye1qQLUzGaYw?=
 =?us-ascii?Q?nnds6IZVgyxUpKDk7BMrRbuC71YQMpdAOnahpF4oO9HIO13Eq0Y7Isw8Aiux?=
 =?us-ascii?Q?QhcT5n9aYvTVBJN7UYvBp8ix8taON0dmLvG5vOHfeUuqibuGcn75/tfvwXvL?=
 =?us-ascii?Q?L3PeK7vM4XF1OYG5oGsIZl5snXgcmsCJcZ6mBcItLJdS5BVkdDKS+zgEWNHR?=
 =?us-ascii?Q?mPb4WVMK0ixYnlKTODZOmMQLm5/hmb+MqxMICK68ktSy6zHP0FlLIhu+aKuN?=
 =?us-ascii?Q?CZqRaa6brlQPE+HYqqHgojkgSgq1p7mqG2xc/BBcN/HtR4JDE1z4CzGgMRlN?=
 =?us-ascii?Q?Ekf2ESypyD/DmWk5kJDluyAIH4ES2aNM2dN6rvd2M2HgyPwdV/KM+Qv8dNSq?=
 =?us-ascii?Q?ryvEu+VIzB0hMsc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:08:24.4891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a00fa3-5208-4a81-0f0e-08dd57dfd694
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164

Extend SAVIC test with various NMI tests:

- Test NMI injection failure when AllowedNMI is not set
  by guest.
- Test NMI injection when 2 NMIs are pending.
- Test ICR based cross-VCPU NMI for fixed-phys, fixed-logical,
  broadcast-all and broadcast-exclself modes.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../selftests/kvm/include/x86/processor.h     |   5 +
 tools/testing/selftests/kvm/include/x86/sev.h |   1 +
 tools/testing/selftests/kvm/lib/x86/savic.c   |  15 +-
 tools/testing/selftests/kvm/lib/x86/sev.c     |  22 +
 tools/testing/selftests/kvm/x86/savic_test.c  | 388 ++++++++++++++----
 5 files changed, 351 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index f09b18944c47..ebd30c4515e7 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -917,6 +917,11 @@ static inline void vcpu_xcrs_set(struct kvm_vcpu *vcpu, struct kvm_xcrs *xcrs)
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
index 81ee79f63b7f..4e8944ca8440 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -160,4 +160,5 @@ void sev_es_vc_handler(struct ex_regs *regs);
 void sev_es_pv_msr_rw(uint64_t msr, uint64_t *data, bool write);
 void sev_es_pv_mmio_rw(uint32_t *reg_gpa, uint32_t *data, bool write);
 void sev_es_savic_notify_gpa(uint64_t gpa);
+void sev_es_nmi_complete(void);
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/savic.c b/tools/testing/selftests/kvm/lib/x86/savic.c
index ee2d6b66d6ce..f7301ec6d45f 100644
--- a/tools/testing/selftests/kvm/lib/x86/savic.c
+++ b/tools/testing/selftests/kvm/lib/x86/savic.c
@@ -91,13 +91,15 @@ int savic_nr_pages_required(uint64_t page_size)
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
 
@@ -442,15 +444,18 @@ static void savic_handle_icr_write(uint64_t icr_data)
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
index 24a2a29a575b..446f7d7dafda 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -20,6 +20,7 @@
 #define SVM_VMGEXIT_MMIO_READ		   0x80000001
 #define SVM_VMGEXIT_MMIO_WRITE		   0x80000002
 #define SVM_VMGEXIT_SECURE_AVIC	   0x8000001a
+#define SVM_VMGEXIT_NMI_COMPLETE	0x80000003
 
 struct ghcb_entry {
 	struct ghcb ghcb;
@@ -798,3 +799,24 @@ void sev_es_savic_notify_gpa(uint64_t gpa)
 	__GUEST_ASSERT(!ret, "Secure AVIC GPA notification failed, ret: %d", ret);
 	ghcb_free(entry);
 }
+
+void sev_es_nmi_complete(void)
+{
+	struct ghcb_entry *entry;
+        struct ghcb *ghcb;
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
index d677b68aa6c6..277ee18a0cbd 100644
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
@@ -47,6 +47,13 @@ enum savic_test_state {
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
 
 /* APIC reg values written by host. */
@@ -128,18 +135,32 @@ struct test_data_page {
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
@@ -581,9 +602,14 @@ static void _ioapic_level_irq_handler(int vec)
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
@@ -593,7 +619,7 @@ static void ioapic_level_irq1_intr_handler(struct ex_regs *regs)
 
 static void ioapic_level_irq2_intr_handler(struct ex_regs *regs)
 {
-	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+	struct test_data_page *data = get_test_data();
 	int vec;
 
 	vec = IOAPIC_VECTOR_START + IOAPIC_NUM_EDGE_VECTORS + 1;
@@ -603,7 +629,7 @@ static void ioapic_level_irq2_intr_handler(struct ex_regs *regs)
 
 static void ioapic_edge_irq1_intr_handler(struct ex_regs *regs)
 {
-	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+	struct test_data_page *data = get_test_data();
 
 	WRITE_ONCE(data->ioapic_eirq1_count, data->ioapic_eirq1_count + 1);
 	x2apic_write_reg(APIC_EOI, 0x00);
@@ -611,7 +637,7 @@ static void ioapic_edge_irq1_intr_handler(struct ex_regs *regs)
 
 static void ioapic_edge_irq2_intr_handler(struct ex_regs *regs)
 {
-	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+	struct test_data_page *data = get_test_data();
 
 	WRITE_ONCE(data->ioapic_eirq2_count, data->ioapic_eirq2_count + 1);
 	x2apic_write_reg(APIC_EOI, 0x00);
@@ -619,7 +645,7 @@ static void ioapic_edge_irq2_intr_handler(struct ex_regs *regs)
 
 static void ioapic_rtc_gsi_intr_handler(struct ex_regs *regs)
 {
-	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+	struct test_data_page *data = get_test_data();
 
 	WRITE_ONCE(data->ioapic_rtc_gsi_irq_count, data->ioapic_rtc_gsi_irq_count + 1);
 	x2apic_write_reg(APIC_EOI, 0x00);
@@ -627,7 +653,7 @@ static void ioapic_rtc_gsi_intr_handler(struct ex_regs *regs)
 
 static void __savic_ioapic(int count)
 {
-	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+	struct test_data_page *data = get_test_data();
 	int vec = IOAPIC_VECTOR_START;
 
 	__GUEST_ASSERT(READ_ONCE(data->ioapic_eirq1_count) == count,
@@ -726,10 +752,40 @@ static void guest_setup_ioapic(int id)
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
@@ -741,26 +797,26 @@ static void savic_fixed_ipi(bool logical)
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
@@ -769,31 +825,73 @@ static void savic_fixed_ipi(bool logical)
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
@@ -808,10 +906,8 @@ static void savic_send_broadcast(int dsh)
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
@@ -821,17 +917,20 @@ static void savic_send_broadcast(int dsh)
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
@@ -839,60 +938,59 @@ static void savic_send_broadcast(int dsh)
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
@@ -900,7 +998,7 @@ void guest_fixed_logical_ipi_handler(struct ex_regs *regs)
 
 void guest_broadcast_ipi_handler(struct ex_regs *regs)
 {
-	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+	struct test_data_page *data = get_test_data();
 
 	WRITE_ONCE(data->broadcast_ipi_count, data->broadcast_ipi_count + 1);
 	x2apic_write_reg(APIC_EOI, 0x00);
@@ -908,13 +1006,65 @@ void guest_broadcast_ipi_handler(struct ex_regs *regs)
 
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
@@ -928,9 +1078,9 @@ static void ipi_guest_code(int id, unsigned long secondary_entry)
 
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
@@ -947,6 +1097,26 @@ static void ipi_guest_code(int id, unsigned long secondary_entry)
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
@@ -955,9 +1125,11 @@ static void ipi_guest_code(int id, unsigned long secondary_entry)
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
 
@@ -969,6 +1141,9 @@ static void ipi_guest_code(int id, unsigned long secondary_entry)
 
 static void guest_code(int id)
 {
+	struct test_data_page *data;
+	int i;
+
 	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SNP_SECURE_AVIC);
 
 	SAVIC_GUEST_SYNC(RESET, guest_savic_start);
@@ -991,6 +1166,39 @@ static void guest_code(int id)
 
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
 
@@ -1105,6 +1313,12 @@ static void host_send_ioapic_irq(struct kvm_vm *vm, int id)
 	}
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
@@ -1132,6 +1346,11 @@ static void host_test_savic(struct kvm_vm *vm, int id, enum savic_test_state tes
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
@@ -1174,11 +1393,12 @@ static void install_exception_handlers(struct kvm_vm *vm)
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
@@ -1239,9 +1459,9 @@ int main(int argc, char *argv[])
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
@@ -1250,10 +1470,28 @@ int main(int argc, char *argv[])
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


