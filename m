Return-Path: <linux-kselftest+bounces-42097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF96B944F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA95E3A5443
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F9330DD00;
	Tue, 23 Sep 2025 05:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FwlswyHa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017A425B662;
	Tue, 23 Sep 2025 05:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604307; cv=fail; b=nX8bpDw05qP9Xqkm2vyEW2E3tQYw/11wXGtCq+JvQkIRHPEQiGM+SlY1hOEKpqmsB0ofhM1s6Yct5e556WGTHrCJ7UT5s1meT59C/Cx7ZT0XcK93W/C9wDgzwtdkQ33EAlYaHvNWm7mUo31+7/a8bAcRKMEbkijhNTzbxIRdpI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604307; c=relaxed/simple;
	bh=sS5jnhrsiMb8BAR+slcncBvAAMoj3BspB1cX3+6Iceg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElYqBi5DvSMRLpyk0zUj94UBzyH23No1uATlq9yYUYgxc0BIZX2UC+5qz+sNPWfAykhR6hWzgm2Ckcb0nByCyovh4IUIxw0jd8sAyzJ/PwJGrbD0jZIIhXMmetCxkPZ42lhYuvUnEMAYeEgJybB4McGxo5KB57nG5d/nyXyQYTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FwlswyHa; arc=fail smtp.client-ip=52.101.43.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVerA3/gZwZUA4rEbabskMwOvw3+2P3ZVLDSf1RTtON2bgDyFyPiGhnmpGBGTn2DaEdVqIUq9Oc1ShpseIHCs88ODu+Y/bwkcWszNFAwsD40PCTZxnz83xliWy09S/b8AfgBVxy5YiHAHmzDAwwIfEZ1zDQStAJUmSZGftXPMBGnECVI58ZOk7aFlRiDiMyz5CmCm1VvlouEBJ+PBbopOlwabmij+7OXmS0BauAlHfPWBgkzCiLclt1a4H8dNn83O0DGtpWLjLxn+BS7+Vt4BP5NHrqgNaNGvku5k6mFDeelZW2SqBrmGL2EblHcJBt52sfhqkV9LBdM3Zg+L04/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1OsI9zC9mdPwpdjgzCA99MeG8COE6wT/Meuk/USSvE=;
 b=UyfbGWztMvBhj6zD/CN/LA1NMccGK31muQlVlLH0wSwzaohqO5KWSh+hOfQ2+b2DNfQjugkIxzBU7+0Ag9kmrgKX9s/31SX3iJlMG96NWAym7CIgGQ4RG/FyxUjLeBUdEUaLf7ZwlZMyyd6t7kakEujx37mA2ksbtpTV9vQX/fFxJAv9lVPNDY+6Q0QY/dYxVHMqSUC95LTuQ9mf9q6jff+iFlKFP5bxUv0bEdE3A7lHtmPsFelmNtRyw8cIktLbGVpZMfV+OzfgFu+h8A8dk/A1PlACfib5ZvYgk1eN91EvF6xZHeMXLmLMxKkomXbfTP4Ca00ii/woUwXFl8zO8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1OsI9zC9mdPwpdjgzCA99MeG8COE6wT/Meuk/USSvE=;
 b=FwlswyHa+wU4qL4J9LOAVGbU6oDKAIejvTtWKFuCtiITBU/yU0wWU4uzfEJ4K7ZeHg/GbBcx1a+C3G0ekvslEkJJxmHRN6/FbAPMvw+qFBpqrbKlKoPyQsIoFwwQ92agNnaGbT21qRBXoz1GvNUAo9ESYVB6ZyyhyI0mZU7X9A4=
Received: from CH2PR07CA0041.namprd07.prod.outlook.com (2603:10b6:610:5b::15)
 by BN3PR12MB9572.namprd12.prod.outlook.com (2603:10b6:408:2ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 05:11:41 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::cc) by CH2PR07CA0041.outlook.office365.com
 (2603:10b6:610:5b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Tue,
 23 Sep 2025 05:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:11:41 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:11:36 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 06/35] Add ability for SEV-ES guests to use ucalls via GHCB
Date: Tue, 23 Sep 2025 10:39:13 +0530
Message-ID: <20250923050942.206116-7-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|BN3PR12MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e94c18-0c73-4005-cf2c-08ddfa5fae9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BdjzPLfL6z/XaGeaiG41HdczOZyFVK1M72Nq06ZconbnaYCw/8NWbmQOaFI1?=
 =?us-ascii?Q?O1XxfN16xeKW6EgVVn5t0XFCLow4HXM5UeLstg5OQyxSMpXjvzsDk2THtV42?=
 =?us-ascii?Q?92O6WN+8uMierXCtFXouglonbl8H1WbSLSGph64thsRuLf4x5hJjHt+t4SrY?=
 =?us-ascii?Q?0KARlyOHefrE4Xrfsc8LpatM1NyuD3W6pQFN67Ee7Np8COslcBzoqYbrOmbw?=
 =?us-ascii?Q?sUviNe2G4Xpt/lqSKnfafIQjmLVFnzc467Zt9nLW+dAWXEHxhPkIluncj2cA?=
 =?us-ascii?Q?CniNwCfKO5v6ddq0T1uycN+H+61A2qwC8r3ZZlCEKH4W9ZIvwA62XoZin37k?=
 =?us-ascii?Q?7/kRiRT/Fk+Fz6ywVW71oOPHqooGu8YzqDIQm7P4mX/kv+EifAyERPr/9NTu?=
 =?us-ascii?Q?w1XDOjekYuwyc/0Sg770yYy8z7c5+4krrGf7TjLcDTA5fBLDwl6fZ9H3vNCk?=
 =?us-ascii?Q?R52qUTJkwk4KixQbXwou/sCt3dtnA9p6se6OitJ3wiVQq6S/HSZRx90PvYTq?=
 =?us-ascii?Q?5pMnqxgQYUzTymm0zE04HCR0/VO2LHlPB6d4ENcIAf0J0CFq5CKcvXHWRMEn?=
 =?us-ascii?Q?nGxN4g6hGBF+Re84qYnrpPk+cg7pdvIbqvkeGOVM4s4xAyPzZsqb4qZ64QVn?=
 =?us-ascii?Q?A6czYSPQJKWHr1N2jBlUX9TE+IckIyK538ubBH+ae98SykDJvr+Ts5QlezK8?=
 =?us-ascii?Q?C4MzMXI9hvm9qOSIMXXeFZFqy/0r7e6s7PKsJJdKzKDEtT7ddBSYkvjM8YJ9?=
 =?us-ascii?Q?ZxkzwPk8s/wu163cqrlrUVHc9AE62PXuLlYB3mz7vYoiezYM/rE+ybbgPsf3?=
 =?us-ascii?Q?Mr5+YBiOlcGodViW34C0jt9uPk9J7D+3VSs5aZyWb8lr8nN3F2RoHJks5ju+?=
 =?us-ascii?Q?8mI341rHcC2RgUgMuvhKcp1DkyZepow+ERZMZTbWLoR2wKpJdTqnUXoqSwpd?=
 =?us-ascii?Q?TuFIHpxsOM4peJOxjtXIkXUqQWQApUfuQAX0DdcqR3Nn8WzTXC5P455IYrIk?=
 =?us-ascii?Q?2JDg5fyzjtRUFP/6+H3/sE1YkKML7bbfsPCsJ5EiRpRdWCUPgken4fZc8mP3?=
 =?us-ascii?Q?9PqDOFPxwJ30zplux7wM3MzFCTkzF/jjcNMa13xWNyJC5a0COc8sgH+5Ld9L?=
 =?us-ascii?Q?5BeKPzI6YfxfSMujuNFIvYAdU7dBoDvt0opcYJiy12Az8GyN1HmLvCEkRFrP?=
 =?us-ascii?Q?x1iP2y+fTSslqhn24RnKDOrHMzVrlmSgmQVm+H8p9AJ1cpl8dLfpjRnz9Rb9?=
 =?us-ascii?Q?m75iNLcn+OZ8ad5DAZCcxsk/S961Zto/qkxeEXEjTQNpZKZaJaHMI8Iat1aI?=
 =?us-ascii?Q?6AgZtMrWw1d75kOl/i7d5cHnRs02LKNRWx6NNPq2gX+TBMRHR5xrdydXbK2q?=
 =?us-ascii?Q?0pNdMs5vY5iiYAKs9FFPdVFNdLAImcXE89O/0PNNrxoTwbJran5L6w5NRn3T?=
 =?us-ascii?Q?igQ8kM8kM8u+xVHojLQwL2BRTXNy2aSo+mpbrLIHjXiEA82YpyUJziw+AhlL?=
 =?us-ascii?Q?MK1VLvvPMSjR6UIP5nbv65/O70ovva/FDkuM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:11:41.4276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e94c18-0c73-4005-cf2c-08ddfa5fae9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9572

From: Peter Gonda <pgonda@google.com>

Modifies ucall handling for SEV-ES VMs. Instead of using an out
instruction and storing the ucall pointer in RDI, SEV-ES guests use a
outsb VMGEXIT to move the ucall pointer as the data. Allows for SEV-ES
to use ucalls instead of relying the SEV-ES MSR based termination protocol.

Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/include/x86/sev.h |  2 +
 tools/testing/selftests/kvm/lib/x86/sev.c     | 98 +++++++++++++++++--
 tools/testing/selftests/kvm/lib/x86/ucall.c   | 18 ++++
 .../selftests/kvm/x86/sev_smoke_test.c        | 27 +----
 4 files changed, 113 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index 2c1bd27345f4..a4fbea0d3562 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -163,4 +163,6 @@ static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
 	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
 }
 
+void sev_es_ucall_port_write(uint32_t port, uint64_t data);
+
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index c400faa9cc5f..de36a6c93839 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -7,11 +7,18 @@
 #include "svm.h"
 #include "svm_util.h"
 
+#define IOIO_TYPE_STR (1 << 2)
+#define IOIO_SEG_DS (1 << 11 | 1 << 10)
+#define IOIO_DATA_8 (1 << 4)
+#define IOIO_REP (1 << 3)
+
+#define SW_EXIT_CODE_IOIO 0x7b
+
 struct ghcb_entry {
 	struct ghcb ghcb;
 
 	/* Guest physical address of this GHCB. */
-	void *gpa;
+	uint64_t gpa;
 
 	/* Host virtual address of this struct. */
 	struct ghcb_entry *hva;
@@ -35,25 +42,35 @@ void ghcb_init(struct kvm_vm *vm)
 	struct ghcb_entry *entry;
 	vm_vaddr_t vaddr;
 	int i;
+	size_t sz = align_up(sizeof(struct ghcb_header), vm_guest_mode_params[vm->mode].page_size);
 
-	vaddr = vm_vaddr_alloc_shared(vm, sizeof(*hdr), KVM_UTIL_MIN_VADDR,
+	vaddr = vm_vaddr_alloc_shared(vm, sz, KVM_UTIL_MIN_VADDR,
 				      MEM_REGION_DATA);
 	hdr = (struct ghcb_header *)addr_gva2hva(vm, vaddr);
-	memset(hdr, 0, sizeof(*hdr));
+	memset(hdr, 0, sz);
 
 	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
 		entry = &hdr->ghcbs[i];
 		entry->hva = entry;
-		entry->gpa = (void *)addr_hva2gpa(vm, &entry->ghcb);
+		entry->gpa = (uint64_t)addr_hva2gpa(vm, &entry->ghcb);
 	}
 
+	if (is_sev_snp_vm(vm))
+		vm_mem_set_shared(vm, addr_hva2gpa(vm, hdr), sz);
+
 	write_guest_global(vm, ghcb_pool, (struct ghcb_header *)vaddr);
 }
 
+static void sev_es_terminate(void)
+{
+	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
+}
+
 static struct ghcb_entry *ghcb_alloc(void)
 {
 	return &ghcb_pool->ghcbs[0];
 	struct ghcb_entry *entry;
+	struct ghcb *ghcb;
 	int i;
 
 	if (!ghcb_pool)
@@ -62,12 +79,18 @@ static struct ghcb_entry *ghcb_alloc(void)
 	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
 		if (!test_and_set_bit(i, ghcb_pool->in_use)) {
 			entry = &ghcb_pool->ghcbs[i];
-			memset(&entry->ghcb, 0, sizeof(entry->ghcb));
+			ghcb = &entry->ghcb;
+
+			memset(&ghcb, 0, sizeof(*ghcb));
+			ghcb->ghcb_usage = 0;
+			ghcb->protocol_version = 1;
+
 			return entry;
 		}
 	}
 
 ucall_failed:
+	sev_es_terminate();
 	return NULL;
 }
 
@@ -162,9 +185,6 @@ void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
 	struct kvm_sev_guest_status status;
 	int ctr;
 
-	if (is_sev_es_vm(vm))
-		ghcb_init(vm);
-
 	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_START, &launch_start);
 
 	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
@@ -254,6 +274,9 @@ struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 
 void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement)
 {
+	if (is_sev_es_vm(vm))
+		ghcb_init(vm);
+
 	if (is_sev_snp_vm(vm)) {
 		vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, BIT(KVM_HC_MAP_GPA_RANGE));
 
@@ -275,3 +298,62 @@ void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement)
 
 	sev_vm_launch_finish(vm);
 }
+
+static uint64_t setup_exitinfo1_portio(uint32_t port)
+{
+	uint64_t exitinfo1 = 0;
+
+	exitinfo1 |= IOIO_TYPE_STR;
+	exitinfo1 |= ((port & 0xffff) << 16);
+	exitinfo1 |= IOIO_SEG_DS;
+	exitinfo1 |= IOIO_DATA_8;
+	exitinfo1 |= IOIO_REP;
+
+	return exitinfo1;
+}
+
+#define GHCB_MSR_REG_GPA_REQ		0x012
+#define GHCB_MSR_REG_GPA_REQ_VAL(v)			\
+        /* GHCBData[63:12] */				\
+        (((u64)((v) & GENMASK_ULL(51, 0)) << 12) |	\
+        /* GHCBData[11:0] */				\
+        GHCB_MSR_REG_GPA_REQ)
+
+static void register_ghcb_page(uint64_t ghcb_gpa)
+{
+	if (is_sev_snp_enabled()) {
+		wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_REG_GPA_REQ_VAL(ghcb_gpa >> 12));
+		vmgexit();
+	}
+}
+
+static void do_vmg_exit(uint64_t ghcb_gpa)
+{
+	wrmsr(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
+	vmgexit();
+}
+
+void sev_es_ucall_port_write(uint32_t port, uint64_t data)
+{
+	struct ghcb_entry *entry;
+	struct ghcb *ghcb;
+	const uint64_t exitinfo1 = setup_exitinfo1_portio(port);
+
+	entry = ghcb_alloc();
+	ghcb = &entry->ghcb;
+
+	register_ghcb_page(entry->gpa);
+
+	ghcb_set_sw_exit_code(ghcb, SW_EXIT_CODE_IOIO);
+	ghcb_set_sw_exit_info_1(ghcb, exitinfo1);
+	ghcb_set_sw_exit_info_2(ghcb, sizeof(data));
+
+	// Setup the SW Stratch buffer pointer.
+	ghcb_set_sw_scratch(ghcb,
+			    entry->gpa + offsetof(struct ghcb, shared_buffer));
+	memcpy(&ghcb->shared_buffer, &data, sizeof(data));
+
+	do_vmg_exit(entry->gpa);
+
+	ghcb_free(entry);
+}
diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/selftests/kvm/lib/x86/ucall.c
index 1265cecc7dd1..711e58a3a356 100644
--- a/tools/testing/selftests/kvm/lib/x86/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2018, Red Hat, Inc.
  */
 #include "kvm_util.h"
+#include "processor.h"
+#include "sev.h"
 
 #define UCALL_PIO_PORT ((uint16_t)0x1000)
 
@@ -21,6 +23,11 @@ void ucall_arch_do_ucall(vm_vaddr_t uc)
 #define HORRIFIC_L2_UCALL_CLOBBER_HACK	\
 	"rcx", "rsi", "r8", "r9", "r10", "r11"
 
+	if (is_sev_es_enabled()) {
+		sev_es_ucall_port_write(UCALL_PIO_PORT, uc);
+		return;
+	}
+
 	asm volatile("push %%rbp\n\t"
 		     "push %%r15\n\t"
 		     "push %%r14\n\t"
@@ -48,8 +55,19 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 
 	if (run->exit_reason == KVM_EXIT_IO && run->io.port == UCALL_PIO_PORT) {
 		struct kvm_regs regs;
+		uint64_t addr;
+
+		if (is_sev_es_vm(vcpu->vm)) {
+			TEST_ASSERT(
+				run->io.count == 8 && run->io.size == 1,
+				"SEV-ES ucall exit requires 8 byte string out\n");
+
+			addr = *(uint64_t *)((uint8_t *)(run) + run->io.data_offset);
+			return (void *)addr;
+		}
 
 		vcpu_regs_get(vcpu, &regs);
+
 		return (void *)regs.rdi;
 	}
 	return NULL;
diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 3316427eee46..d3670b21261b 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -20,8 +20,7 @@ static void guest_snp_code(void)
 {
 	GUEST_ASSERT(is_sev_snp_enabled());
 
-	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
-	vmgexit();
+	GUEST_DONE();
 }
 
 static void guest_sev_es_code(void)
@@ -29,12 +28,7 @@ static void guest_sev_es_code(void)
 	/* TODO: Check CPUID after GHCB-based hypercall support is added. */
 	GUEST_ASSERT(is_sev_es_enabled());
 
-	/*
-	 * TODO: Add GHCB and ucall support for SEV-ES guests.  For now, simply
-	 * force "termination" to signal "done" via the GHCB MSR protocol.
-	 */
-	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
-	vmgexit();
+	GUEST_DONE();
 }
 
 static void guest_sev_code(void)
@@ -103,12 +97,7 @@ static void test_sync_vmsa(uint32_t type, uint64_t policy)
 
 	vcpu_run(vcpu);
 
-	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT,
-		    "Wanted SYSTEM_EVENT, got %s",
-		    exit_reason_str(vcpu->run->exit_reason));
-	TEST_ASSERT_EQ(vcpu->run->system_event.type, KVM_SYSTEM_EVENT_SEV_TERM);
-	TEST_ASSERT_EQ(vcpu->run->system_event.ndata, 1);
-	TEST_ASSERT_EQ(vcpu->run->system_event.data[0], GHCB_MSR_TERM_REQ);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 
 	compare_xsave((u8 *)&xsave, (u8 *)hva);
 
@@ -129,16 +118,6 @@ static void test_sev(void *guest_code, uint32_t type, uint64_t policy)
 	for (;;) {
 		vcpu_run(vcpu);
 
-		if (is_sev_es_vm(vm)) {
-			TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT,
-				    "Wanted SYSTEM_EVENT, got %s",
-				    exit_reason_str(vcpu->run->exit_reason));
-			TEST_ASSERT_EQ(vcpu->run->system_event.type, KVM_SYSTEM_EVENT_SEV_TERM);
-			TEST_ASSERT_EQ(vcpu->run->system_event.ndata, 1);
-			TEST_ASSERT_EQ(vcpu->run->system_event.data[0], GHCB_MSR_TERM_REQ);
-			break;
-		}
-
 		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_SYNC:
 			continue;
-- 
2.34.1


