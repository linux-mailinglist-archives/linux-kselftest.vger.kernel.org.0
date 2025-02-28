Return-Path: <linux-kselftest+bounces-27867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F45BA4967B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 11:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED693B65A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75A725D534;
	Fri, 28 Feb 2025 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VPVcan9n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C76625BAA3;
	Fri, 28 Feb 2025 10:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736960; cv=fail; b=Qj/oLYkoMga4RMTnV73mz0+Rkcvsa9jAd8HpfgA9ynvWdRCWEY0fGdIhisJlaleLsZUjhMMKC71jIdCWpbI1KOmocHs/OC8miJZxZgvreQ+YkgZoYVcB7JzIedtV2d27XGI5PWaRD6VdLUwHJSN1NOIBZbSo9Y1eyFSprz4oERA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736960; c=relaxed/simple;
	bh=wjTJm2vNvpkc0ZwJ+l8CyiYuDNczhAOIvhuXgCsCg2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKjusb4+1YtZlss2NcLtanta9T9ZuPtz3JKLWMmmIaV0QGA9AjrKOPlkyHNCOEzahSZi1aVJhvjm+sTzN1/S4BWmAv/1ePEmE9KZGxdrjOZ9nSYNbmgTfLcusZeL5szsb9PjEK4irbCHd/4NmyyxlyUGgELduQXy0BGjc+D1/Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VPVcan9n; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9VL+00PgsVFz5qoIar5ddnCX1VH4mJlhD/dxs27aU0annJqsIqXL7YbZ3+P2oIoMJUb3l/uwndHnJm/WBJhV9IkYDRtcIOH0q8XDE9bDqK6znGjAHgB1G1OXf0QjugbUkxBsZh9Chqlzc1YWQiDlEoTxF5g14qjjFy5xVzqXIE/SXVXO0NNtLEPdB0i3dNULW12fZ1sg38XtUamfaEF9OMwsYldvwZ1IhmKaDJM17K65UA2n7Y2R3lzH7ZNZRQSANK/kHpRQeC9FlTngxGYZ5YuBvHJr+MHv/92b652Vs4Ki8/WGFjcCStaz2uHCcAaavrEwGKPjufxP9AgibIH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1kceKccxj4kvkEUhwgbjtbI6bLQhfpAC6ZvyHclM/Q=;
 b=GDfwvVeBFKMrdHbzpkg3nhK+1sFx6dvq9Z1v9ogaqpRVXhV2rUTXANavOss6mqnoSeXBhT5r1pk1BU9Gbno/JH5g/mILfBmRCgKamHMZ4hWHeUXPoIZAbvrM6ovcTEuBuz2yBv04A1nmuZJYaB/+rKvn9Dox29Cnd6Cly27yOPxxZa2wxv+E2Qqtnz8AfHypy93GxnEjgSzJqCdP5SOtdNQiuDkdfg18a74iwZ+bjPe/WHGkZTqVhlhqIcq6klarTppB8d+ahVIFDbgQC6+Hd6Ae2PHkTvtbOcWaQEB/m3R0Q8a7FLSe3i8d69gygYBiohy9bSlTgGGQdymW3pGxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1kceKccxj4kvkEUhwgbjtbI6bLQhfpAC6ZvyHclM/Q=;
 b=VPVcan9ntk0AEAp+a4cjO9ZyFm+OSNLg2dczxFXEAtFT8TCACEMxeOnNwz13DYCz1zc4VhsghjCPdywziKubySQ+bKjLW8VavG3H5OWDV+NPn6agtTq6E7UGdaKaLM6mqcYjmCsyw33aQEMh9DuF+r4gL8gK8mlZ3Wm4Hx9BcCY=
Received: from SA9PR13CA0113.namprd13.prod.outlook.com (2603:10b6:806:24::28)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 10:02:32 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::b4) by SA9PR13CA0113.outlook.office365.com
 (2603:10b6:806:24::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.10 via Frontend Transport; Fri,
 28 Feb 2025 10:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 10:02:32 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 04:01:00 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 25/31] KVM: selftests: Add Secure AVIC APIC regs test
Date: Fri, 28 Feb 2025 15:00:18 +0530
Message-ID: <20250228093024.114983-26-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: b15ac66d-8c3a-41fe-eb7b-08dd57df04d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AW/lpnvOd20eqHR+O3QUFdB8qpyg+jzHQzkZb2sBZPS5BCPa7dYQUg6+Uw7J?=
 =?us-ascii?Q?PKWF8brTsuE2A2/eh7NnNePQ06nziFI5umeaxF9M5xINbCYxYHB+WjSKSNLM?=
 =?us-ascii?Q?5zCsZcAVM2Yi8KN3/VTRL2K+5g/OKR0Cj//ZbN+oBtySIkQau0VBm8AmhmE1?=
 =?us-ascii?Q?MURYS3n2WatLYS3z8RDdqgKJGNGY2GxGI6PsbSxsT2WvEZ7iF2s7YK9XxMkk?=
 =?us-ascii?Q?0nWyz+S3oQI2KhqJliZBzBmDVhvcrxRTqobJjoEBoA8D61sw0H9LJcvky8iK?=
 =?us-ascii?Q?3Nx6UUWyCywtybv+5+bmXMDr4e193Nh0NB/KjqiZCF/eVMBb3HNZBnwCQ/Zp?=
 =?us-ascii?Q?OCbtXhC/yTnYlaFy8uzHSiWdehUQ17JsssKI0zfKvOZN27uoSeZ9i/1YkDr3?=
 =?us-ascii?Q?DVy3cR9TyEsA0ucJMMNDZbbftvsg0iryHDl+/Mpl6GrQKREFO8XqO/0+KIG5?=
 =?us-ascii?Q?Ua16s8BSKeKnsjBM00h9eQaef8hdO0v6v7cdmVcjMHQw5uqcqIwkI5Rt4z0f?=
 =?us-ascii?Q?NuOHxObn+q8d6B6CTnsgCw27A5kONthZ1M1fPyioaGPCUG2/w9bw+n3jElpN?=
 =?us-ascii?Q?CdRhiOm6/Hr0natZg4F+SIPP16beqxqt1NimpaHk94nr4X72Al8WZXZgYm+Y?=
 =?us-ascii?Q?gzIczGCQuE7HlFQJcMdiNqPXCNBIWoEgwG7zc0CoL2fefHl9Z+IOG2lSeKLL?=
 =?us-ascii?Q?3tLAschvLiq47gr01z7eZjvtW16BuHuUXU+DRLI+xRL+J03yaaDoob30O2L1?=
 =?us-ascii?Q?DXAPUE8+vhZs6sbXZUMiELnvbbpBb8EwmW1GsSRLUurlaMHjAbtHJ2iM5SWc?=
 =?us-ascii?Q?96YzzobvNKTBPlAfgb+rjneqXBdp+/uDYc86ksvXsvntLVHDOL8rmrupSCcI?=
 =?us-ascii?Q?qcvupI4CrzDx8qnlnK45zIX73ITMUsQBZnlj1ad9l/SGm+4N/OGrhw1vQvy5?=
 =?us-ascii?Q?Qr5tiNRhzZMkJMzu1cArRJmCwvw/5HlCHJbDvGHr7fvVq0dqGLZhLpHfqFY2?=
 =?us-ascii?Q?4gHeb1P3HBbm6gdLnM9dVe4/1zsHNCIuVE2vfGBq3FdUuUq+95viWtr4rhwN?=
 =?us-ascii?Q?p+Dcj+fF4EdVSZXZeS6cHrEBrub8+FKv6nM7AW9cfotHyqj+/5EEBFxHaF2C?=
 =?us-ascii?Q?pW85pBSWrVo5HNbrlucGucV7DKN24hTLGKNa9eJX/ovT9prKqORNKCMUs8QT?=
 =?us-ascii?Q?uzTZgTqeiF783SElDtdzlfWnTpgAlerKiZj0cT9dGbeG5OwKWWaJTeaIBHXF?=
 =?us-ascii?Q?QIex5NZqX5fRfbOECYI+zFWPGJDKT8vEE3cNEfRHTDpl5mQDq5hZ2NaUBPWD?=
 =?us-ascii?Q?YQ31i5L41XtLt3eDpXnFo66zXpHzoPekOGFRc3g6V5erZlLtOD3WKVOPS2Nv?=
 =?us-ascii?Q?7Ddp4CJa3GIdwhFnkU6XXEXXJKwSnk+1YLI1+1gO3kMfNpXudzINwMt8CnVb?=
 =?us-ascii?Q?QxdSxg82nJJDGJ4WZvMvHrgEZ+OLxKSvPhztOFNiQg/zpIIS7g2U7oEARIZk?=
 =?us-ascii?Q?rkWLdORdvn0izHc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:02:32.5797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b15ac66d-8c3a-41fe-eb7b-08dd57df04d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973

Add a APIC regs to verify APIC register updates at various
stages in Secure AVIC guest's APIC enablement. In summary,
do below validations:

- Verify that the initial reset of APIC is xapic.
- Values written by SAVIC guest in xapic mode are propagated
  to host APIC state.
- APIC regs state updates by host are propagated to guest
  in x2apic mode.
- In x2apic mode, APIC regs updates by SAVIC guest are propagated
  to host APIC state.
- Post SAVIC enablement, init guest APIC backing page state is same
  as the host APIC regs state for unaccelerated registers.
- Post SAVIC enablement, APIC updates done by guest are propagated
  to host for unaccelerated APIC registers. For accelerated APIC
  registers, updates are not propagated to host.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/x86/savic.h |   1 +
 tools/testing/selftests/kvm/lib/x86/savic.c   |  13 +-
 tools/testing/selftests/kvm/x86/savic_test.c  | 462 ++++++++++++++++++
 4 files changed, 476 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/x86/savic_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 50bd78e03d9f..51338d1901e0 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -77,6 +77,7 @@ TEST_GEN_PROGS_x86 += x86/pmu_counters_test
 TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
 TEST_GEN_PROGS_x86 += x86/private_mem_conversions_test
 TEST_GEN_PROGS_x86 += x86/private_mem_kvm_exits_test
+TEST_GEN_PROGS_x86 += x86/savic_test
 TEST_GEN_PROGS_x86 += x86/set_boot_cpu_id
 TEST_GEN_PROGS_x86 += x86/set_sregs_test
 TEST_GEN_PROGS_x86 += x86/smaller_maxphyaddr_emulation_test
diff --git a/tools/testing/selftests/kvm/include/x86/savic.h b/tools/testing/selftests/kvm/include/x86/savic.h
index 238d7450ab6e..cb432eb527b3 100644
--- a/tools/testing/selftests/kvm/include/x86/savic.h
+++ b/tools/testing/selftests/kvm/include/x86/savic.h
@@ -17,4 +17,5 @@ uint64_t savic_hv_read_reg(uint32_t reg);
 void savic_enable(void);
 int savic_nr_pages_required(uint64_t page_size);
 void savic_vc_handler(struct ex_regs *regs);
+struct guest_apic_page *get_guest_apic_page(void);
 #endif
diff --git a/tools/testing/selftests/kvm/lib/x86/savic.c b/tools/testing/selftests/kvm/lib/x86/savic.c
index ae48978479bf..d4c9fcf835ad 100644
--- a/tools/testing/selftests/kvm/lib/x86/savic.c
+++ b/tools/testing/selftests/kvm/lib/x86/savic.c
@@ -105,6 +105,11 @@ void set_savic_control_msr(struct guest_apic_page *apic_page, bool enable, bool
 	wrmsr(MSR_AMD64_SECURE_AVIC_CONTROL, val);
 }
 
+struct guest_apic_page *get_guest_apic_page(void)
+{
+	return &apic_page_pool->guest_apic_page[x2apic_read_reg(APIC_ID)];
+}
+
 /*
  * Write APIC reg offset in the guest APIC backing page.
  *
@@ -176,11 +181,17 @@ static void savic_init_backing_page(struct guest_apic_page *apic_page, uint32_t
 	regval = savic_hv_read_reg(APIC_LDR);
 	savic_write_reg(apic_page, APIC_LDR, regval);
 
-	for (i = LVT_THERMAL_MONITOR; i < APIC_MAX_NR_LVT_ENTRIES; i++) {
+	for (i = LVT_TIMER; i < APIC_MAX_NR_LVT_ENTRIES; i++) {
 		regval = savic_hv_read_reg(APIC_LVTx(i));
 		savic_write_reg(apic_page, APIC_LVTx(i), regval);
 	}
 
+	regval = savic_hv_read_reg(APIC_TMICT);
+	savic_write_reg(apic_page, APIC_TMICT, regval);
+
+	regval = savic_hv_read_reg(APIC_TDCR);
+	savic_write_reg(apic_page, APIC_TDCR, regval);
+
 	regval = savic_hv_read_reg(APIC_LVT0);
 	savic_write_reg(apic_page, APIC_LVT0, regval);
 
diff --git a/tools/testing/selftests/kvm/x86/savic_test.c b/tools/testing/selftests/kvm/x86/savic_test.c
new file mode 100644
index 000000000000..ca1d7352bc3e
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/savic_test.c
@@ -0,0 +1,462 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ *  Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *
+ */
+#include <pthread.h>
+
+#include "processor.h"
+#include "apic.h"
+#include "kvm_util.h"
+#include "sev.h"
+#include "test_util.h"
+#include "savic.h"
+
+#define NR_SAVIC_VCPUS	1
+
+static struct kvm_vcpu *vcpus[NR_SAVIC_VCPUS];
+static pthread_t threads[NR_SAVIC_VCPUS];
+
+#define SAVIC_TEST_STATE(STATE) \
+	STATE ## _START, \
+	STATE ## _END
+
+enum savic_test_state {
+	/* Reset state of APIC regs */
+	SAVIC_TEST_STATE(RESET),
+	/* APIC regs state on X2apic enablement */
+	SAVIC_TEST_STATE(X2APIC_ENABLE),
+	/* APIC regs state on Secure AVIC enablement */
+	SAVIC_TEST_STATE(SAVIC_EN),
+};
+
+/* APIC reg values written by host. */
+enum savic_test_host_vals {
+	H_APIC_TASKPRI_VAL = 0x30,
+	H_APIC_LVTT_VAL = APIC_DM_FIXED | 0x30,
+	H_APIC_LVTTHMR_VAL = APIC_DM_FIXED | 0x31,
+	H_APIC_LVTPC_VAL = APIC_DM_FIXED | 0x32,
+	H_APIC_LVT0_VAL = APIC_DM_FIXED | 0x33,
+	H_APIC_LVT1_VAL = APIC_DM_FIXED | 0x34,
+	H_APIC_TMICT_VAL = 0x555555,
+	H_APIC_TDCR_VAL = 0x3,
+};
+
+/* APIC reg values written by guest. */
+enum savic_test_guest_vals {
+	G_APIC_TASKPRI_VAL = 0x40,
+	G_APIC_LVTT_VAL = APIC_DM_FIXED | 0x40,
+	G_APIC_LVTTHMR_VAL = APIC_DM_FIXED | 0x41,
+	G_APIC_LVTPC_VAL = APIC_DM_FIXED | 0x42,
+	G_APIC_LVT0_VAL = APIC_DM_FIXED | 0x43,
+	G_APIC_LVT1_VAL = APIC_DM_FIXED | 0x34,
+	G_APIC_TMICT_VAL = 0xaaaaaa,
+	G_APIC_TDCR_VAL = 0x1,
+};
+
+struct reg_ent {
+	char *regname;
+	uint32_t reg;
+	uint64_t val;
+};
+
+#define CREATE_H_REG_ENTRY(_reg) {\
+	.regname = #_reg, \
+	.reg = _reg, \
+	.val = H_ ## _reg ## _VAL \
+}
+
+#define CREATE_G_REG_ENTRY(_reg) {\
+	.regname = #_reg, \
+	.reg = _reg, \
+	.val = G_ ## _reg ## _VAL \
+}
+
+static struct reg_ent host_apic_regs[] = {
+	CREATE_H_REG_ENTRY(APIC_TASKPRI),
+	CREATE_H_REG_ENTRY(APIC_LVTT),
+	CREATE_H_REG_ENTRY(APIC_LVTTHMR),
+	CREATE_H_REG_ENTRY(APIC_LVTPC),
+	CREATE_H_REG_ENTRY(APIC_LVT0),
+	CREATE_H_REG_ENTRY(APIC_LVT1),
+	CREATE_H_REG_ENTRY(APIC_TMICT),
+	CREATE_H_REG_ENTRY(APIC_TDCR),
+};
+
+static struct reg_ent guest_apic_regs[] = {
+	CREATE_G_REG_ENTRY(APIC_TASKPRI),
+	CREATE_G_REG_ENTRY(APIC_LVTT),
+	CREATE_G_REG_ENTRY(APIC_LVTTHMR),
+	CREATE_G_REG_ENTRY(APIC_LVTPC),
+	CREATE_G_REG_ENTRY(APIC_LVT0),
+	CREATE_G_REG_ENTRY(APIC_LVT1),
+	CREATE_G_REG_ENTRY(APIC_TMICT),
+	CREATE_G_REG_ENTRY(APIC_TDCR),
+};
+
+/* Context which is doing testing of APIC regs values. */
+enum context {
+	CTXT_HOST,
+	CTXT_GUEST,
+};
+
+static struct kvm_lapic_state apic_state[NR_SAVIC_VCPUS];
+
+/*
+ * Write APIC reg from host or guest context.
+ *
+ * @id : vCPU id (required only for host context).
+ * @reg : APIC reg offset.
+ * @ctxt : Context which is doing write operation.
+ * @val : New value to write to the reg.
+ * x2apic : x2apic is enabled.
+ */
+static void write_apic_reg(int id, uint32_t reg, enum context ctxt,
+		uint32_t val, bool x2apic)
+{
+	if (ctxt == CTXT_HOST) {
+		*(uint32_t *)&apic_state[id].regs[reg] = val;
+	} else {
+		if (x2apic)
+			x2apic_write_reg(reg, val);
+		else
+			xapic_write_reg(reg, val);
+	}
+}
+
+/*
+ * Read APIC reg from host or guest context.
+ *
+ * @id : vCPU id (required only for host context).
+ * @reg : APIC reg offset.
+ * @ctxt : Context which is doing read operation.
+ *
+ *
+ * Returns APIC register value.
+ */
+static uint32_t read_apic_reg(int id, uint32_t reg, enum context ctxt, bool x2apic)
+{
+	if (ctxt == CTXT_HOST)
+		return *(uint32_t *)&apic_state[id].regs[reg];
+
+	if (x2apic)
+		return x2apic_read_reg(reg);
+	else
+		return xapic_read_reg(reg);
+}
+
+/*
+ * Set test APIC regs values from host/guest context.
+ *
+ * @id : vCPU ID for which APIC state is set.
+ * @host : Test APIC regs data source values.
+ * @ctxt : Context from which this function is called.
+ * @x2apic : X2apic is enabled.
+ */
+static void set_apic_vals(int id, bool host, enum context ctxt, bool x2apic)
+{
+	struct reg_ent *reg_entries;
+	struct reg_ent ent;
+	int i;
+
+	if (host)
+		reg_entries = host_apic_regs;
+	else
+		reg_entries = guest_apic_regs;
+
+	if (ctxt == CTXT_HOST)
+		memset(&apic_state[id], 0, sizeof(apic_state[i]));
+
+	for (i = 0; i < ARRAY_SIZE(host_apic_regs); i++) {
+		ent = reg_entries[i];
+		write_apic_reg(id, ent.reg, ctxt, ent.val, x2apic);
+	}
+
+	if (ctxt == CTXT_HOST)
+		vcpu_ioctl(vcpus[id], KVM_SET_LAPIC, &apic_state[id]);
+}
+
+#define CTXT_ASSERT(ctxt, reg, exp, val) \
+	do { \
+		if (ctxt == CTXT_HOST) \
+			TEST_ASSERT(exp == val, \
+				"Unexpected %s %s val: 0x%x expected 0x%x\n", \
+				"host", reg, val, exp); \
+		else \
+			__GUEST_ASSERT(exp == val, \
+				"Unexpected %s %s val: 0x%x expected 0x%x\n", \
+				"guest", reg, val, exp); \
+	} while (0)
+
+/*
+ * Test APIC regs values from host/guest context.
+ *
+ * @id : vCPU ID for which values are tested.
+ * @host : Test APIC regs expected values data source.
+ * @ctxt : Context from which this function is called.
+ * @x2apic : X2apic is enabled.
+ * @savic : Secure AVIC is enabled.
+ */
+static void test_apic_vals(int id, bool host, enum context ctxt, bool x2apic,
+		bool savic)
+{
+	uint32_t exp_regval, regval;
+	struct reg_ent *reg_entries;
+	struct reg_ent ent;
+	char *regname;
+	uint32_t reg;
+	int i;
+
+	if (host)
+		reg_entries = host_apic_regs;
+	else
+		reg_entries = guest_apic_regs;
+
+
+	if (ctxt == CTXT_HOST)
+		vcpu_ioctl(vcpus[id], KVM_GET_LAPIC, &apic_state[id]);
+
+	for (i = 0; i < ARRAY_SIZE(host_apic_regs); i++) {
+		ent = reg_entries[i];
+		reg = ent.reg;
+		/* APIC_TASKPRI is accelerated in guest and not synced in host APIC state. */
+		if (savic && reg == APIC_TASKPRI) {
+			if (ctxt == CTXT_GUEST)
+				continue;
+			else
+				ent = host_apic_regs[i];
+		}
+		regname = ent.regname;
+		exp_regval = ent.val;
+		regval = read_apic_reg(id, reg, ctxt, x2apic);
+		CTXT_ASSERT(ctxt, regname, exp_regval, regval);
+	}
+}
+
+#define SAVIC_GUEST_SYNC(sync, func) ({\
+	GUEST_SYNC(sync ## _START); \
+	func(id); \
+	GUEST_SYNC(sync ## _END); \
+})
+
+static void savic_write_apic_regs(struct guest_apic_page *apage)
+{
+	struct reg_ent ent;
+	uint32_t regval;
+	uint32_t reg;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(guest_apic_regs); i++) {
+		ent = guest_apic_regs[i];
+		reg = ent.reg;
+		regval = ent.val;
+		savic_write_reg(apage, reg, regval);
+		if (reg != APIC_TASKPRI)
+			savic_hv_write_reg(reg, regval);
+	}
+}
+
+static void guest_test_and_set_apic_regs(int id, bool x2apic)
+{
+	/*
+	 * On guest entry, APIC reg values read from guest context matches
+	 * the previous values set by host.
+	 */
+	test_apic_vals(id, true, CTXT_GUEST, x2apic, false);
+	set_apic_vals(id, false, CTXT_GUEST, x2apic);
+	test_apic_vals(id, false, CTXT_GUEST, x2apic, false);
+}
+
+static void guest_savic_start(int id)
+{
+	guest_test_and_set_apic_regs(id, false);
+}
+
+static void guest_x2apic_enabled(int id)
+{
+	guest_test_and_set_apic_regs(id, true);
+}
+
+static void guest_savic_enabled(int id)
+{
+	struct guest_apic_page *apage = get_guest_apic_page();
+
+	/* Host values are written to guest backing page */
+	test_apic_vals(id, true, CTXT_GUEST, true, true);
+	/* Update host APIC regs with guest values */
+	savic_write_apic_regs(apage);
+}
+
+static void guest_code(int id)
+{
+	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SNP_SECURE_AVIC);
+
+	SAVIC_GUEST_SYNC(RESET, guest_savic_start);
+
+	x2apic_enable();
+
+	SAVIC_GUEST_SYNC(X2APIC_ENABLE, guest_x2apic_enabled);
+
+	savic_enable();
+
+	SAVIC_GUEST_SYNC(SAVIC_EN, guest_savic_enabled);
+
+	GUEST_DONE();
+}
+
+static void host_reset_s_test_apic_regs(struct kvm_vcpu *vcpu)
+{
+	/* Set and test APIC regs before guest entry. */
+	set_apic_vals(vcpu->id, true, CTXT_HOST, false);
+	test_apic_vals(vcpu->id, true, CTXT_HOST, false, false);
+}
+
+static void host_reset_s(int id)
+{
+	struct kvm_vcpu *vcpu = vcpus[id];
+	uint64_t apic_base;
+
+	apic_base = vcpu_get_msr(vcpu, MSR_IA32_APICBASE);
+	TEST_ASSERT(apic_base & MSR_IA32_APICBASE_ENABLE,
+			"APIC not in ENABLED state at vCPU RESET");
+	TEST_ASSERT(!(apic_base & X2APIC_ENABLE),
+			"APIC not in xAPIC mode at vCPU RESET");
+	host_reset_s_test_apic_regs(vcpu);
+}
+
+static void host_reset_e(int id)
+{
+	/* On guest exit, APIC regs state must match guest values. */
+	test_apic_vals(id, false, CTXT_HOST, false, false);
+	/* Reset the APIC regs to host values. */
+	set_apic_vals(id, true, CTXT_HOST, false);
+}
+
+static void host_x2apic_enabled_s(int id)
+{
+	struct kvm_vcpu *vcpu = vcpus[id];
+	uint64_t apic_base;
+
+	apic_base = vcpu_get_msr(vcpu, MSR_IA32_APICBASE);
+	TEST_ASSERT(apic_base & X2APIC_ENABLE, "APIC not in x2APIC mode");
+
+	/*
+	 * On guest x2apic enablement, previous APIC regs values
+	 * which were set by host are preserved.
+	 */
+	test_apic_vals(id, true, CTXT_HOST, true, false);
+	set_apic_vals(id, true, CTXT_HOST, true);
+	test_apic_vals(id, true, CTXT_HOST, true, false);
+}
+
+static void host_x2apic_enabled_e(int id)
+{
+	/*
+	 * In guest x2apic enabled mode, guest written states are propagated
+	 * to host APIC state.
+	 */
+	test_apic_vals(id, false, CTXT_HOST, true, false);
+	set_apic_vals(id, true, CTXT_HOST, true);
+}
+
+static void host_post_savic_en_start(int id)
+{
+	/* Host APIC regs before SAVIC enablement are not lost. */
+	test_apic_vals(id, true, CTXT_HOST, true, true);
+	set_apic_vals(id, true, CTXT_HOST, true);
+}
+
+static void host_post_savic_en_end(int id)
+{
+	/*
+	 * LVTT and other emulated APIC regs are propagated to host APIC
+	 * state by SAVIC guest.
+	 */
+	test_apic_vals(id, false, CTXT_HOST, true, true);
+}
+
+static void host_test_savic(struct kvm_vm *vm, int id, enum savic_test_state test_state)
+{
+	switch (test_state) {
+	case RESET_START:
+		host_reset_s(id);
+		break;
+	case RESET_END:
+		host_reset_e(id);
+		break;
+	case X2APIC_ENABLE_START:
+		host_x2apic_enabled_s(id);
+		break;
+	case X2APIC_ENABLE_END:
+		host_x2apic_enabled_e(id);
+		break;
+	case SAVIC_EN_START:
+		host_post_savic_en_start(id);
+		break;
+	case SAVIC_EN_END:
+		host_post_savic_en_end(id);
+		break;
+	default:
+		break;
+	}
+}
+
+static void *vcpu_thread(void *arg)
+{
+	struct kvm_vcpu *vcpu = (struct kvm_vcpu *)arg;
+	struct ucall uc;
+
+	fprintf(stderr, "vCPU thread running vCPU %u\n", vcpu->id);
+
+	while (true) {
+		vcpu_run(vcpu);
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			host_test_savic(vcpu->vm, vcpu->id, uc.args[1]);
+			break;
+		case UCALL_DONE:
+			return NULL;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		case UCALL_NONE:
+			continue;
+		default:
+			TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
+		}
+
+	}
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_sev_init args = { .vmsa_features = BIT_ULL(SVM_FEAT_SECURE_AVIC) |
+					BIT_ULL(SVM_FEAT_ALLOWED_SEV_FEATURES_VALID)
+				   };
+	struct kvm_vm *vm;
+	int r;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SNP));
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SECURE_AVIC));
+
+	vm = _vm_sev_create_with_one_vcpu(KVM_X86_SNP_VM, guest_code, &vcpus[0], &args);
+
+	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+
+	vcpu_args_set(vcpus[0], 1, vcpus[0]->id);
+
+	vm_install_exception_handler(vm, 29, sev_es_vc_handler);
+	vm_sev_launch(vm, snp_default_policy(), NULL);
+
+	r = pthread_create(&threads[0], NULL, vcpu_thread, vcpus[0]);
+	TEST_ASSERT(r == 0, "pthread_create failed errno=%d", errno);
+
+	pthread_join(threads[0], NULL);
+
+	kvm_vm_free(vm);
+
+	return 0;
+}
-- 
2.34.1


