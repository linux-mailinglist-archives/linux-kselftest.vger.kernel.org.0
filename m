Return-Path: <linux-kselftest+bounces-27846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8717BA4956C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031591894E4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA86257441;
	Fri, 28 Feb 2025 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gnpKrWRY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184C2586EF;
	Fri, 28 Feb 2025 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735503; cv=fail; b=nhRUnR4ElmLF7KYVD+TvzajFyvjRXdfSUCijSXLAqAclsJ1uREHSy76TGOAnyvwRruI0hHS8V4TKxlx4j1L+Z5wAHeq3/sdJwGUyuq9udFfg/3yfP24xK81gdcL6ytRAyBXvrjfNE7yrikYt/GAOYO6T5zA+HGw9gnBgeHs6eEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735503; c=relaxed/simple;
	bh=pLzQM4jreC0X2dOc75ntyYTKhAm+aGuQuhgqqigtUyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7TYxBkNdhMm0HmGTlipId1pU2cwZz1WFU+oq6wa5Pglc65rT0tT40z5NaunYNx++ydQcwEinKgZRwbUIvDglDmc0yxw4mjAmOKusy1sIU8OOSppQ4QcbYYPMuqJjPHZz77qDolDGmtNUydLKzJlJzreMWqtGM/X/0N/qKZGYcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gnpKrWRY; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNBK9RcMz/iBaF8qJbaMeYGW5ysmIydGWNmRMwUuw+gpNXJ66Zfomn2OZmcG5zlSSEHBIyBNh161zqDVOskkiGF30991OaCLcJmnBLEqHZ6fCoRpsl5Gv1TipJ6/dHXrMkyljjlJkFyWbqiTypIRsmgijwu+Slfn02fHqoEfmePbZ9abCVDRTf9cBPCnWY38wWIftSVM9WGab5+bG9jjqJuDZVXsfZeUGugh6Sxr2SQlMVj1E9WZbZS57teCnOkwnjL6GjbcefTeVYhzDWYQWtRcKw4FtQeQaBY3BoBiygj5NpNJ2XeTtPro3iRAAy/tMDbNN2WhJAPyhJQCLwFUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctmMtKul0Dga03a9Knk+S3EosofRdtWbdyN0YdjwB1Y=;
 b=CRCoxTmorKYcuXQ9zwOlopSNA9QqI2yK+8c5DytJIu86x/E4fzGq1KHzdXHxw49XDONcjXko7zjZTcn58B7XJwIaUl3v2bUrmTecWF6Qe4JSyNQFcaF1FtnAkiQnXoGDwQE32dcCkfq1eBxyoevTtoRCrpO2g/cLfgQ187p4GAPpiyJcQ5JC+9MB8XmCX6XDlcHdsKzXyG3oHDHjYCkD9yYfnIcxzOIEuwUwE6Kmz8UGE0ErmWkyLSMxzCkHxLN7ZKopDsP51LAIUQtt/CGtnjn+2lS9IZ3h6MH6kWlK+wEyn4BpG8k1O0Dbb9jUjtpit6CXlPhxL8vz1bHiRIc53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctmMtKul0Dga03a9Knk+S3EosofRdtWbdyN0YdjwB1Y=;
 b=gnpKrWRYQXKotzOHbzLbdKIB3xBxlg8wHn0/xk6Ua+i54jnexeV5pvRh+aSKXn5WRKCoCFduLoObfwtyXRZxISQS/zr4nqvhFQja4RiaOJcxWEC2MQID5bRbSy1ODu8dIPm+t6g6w2XS3aTz+ulCdgRbwAM3XAF1NmLeTXaiUEg=
Received: from MW4PR04CA0226.namprd04.prod.outlook.com (2603:10b6:303:87::21)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 09:38:17 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::de) by MW4PR04CA0226.outlook.office365.com
 (2603:10b6:303:87::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 09:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:38:16 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:36:10 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 04/31] Add GHCB allocations and helpers
Date: Fri, 28 Feb 2025 14:59:57 +0530
Message-ID: <20250228093024.114983-5-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: f1554f4a-c9a6-45f0-f093-08dd57dba13e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NpuZGPHqNzFgVhvblVuaavkC3w88oN9FJDIlZZ9we+RFKm3vITXr8BVJ6tU2?=
 =?us-ascii?Q?LtEJJ4j0zSdqkE3vpLVPs0cw5KUP9MEq1PcnvL1emqieZnhJ7SRlxm3yFO5d?=
 =?us-ascii?Q?YIL+4JtwjbiF/xq/y0qdIRRWUWh7+jiHj5Jt+PI7TCFXo6/Eff+UsltZKzP3?=
 =?us-ascii?Q?+67xI40Jt72uUpojQJfeEbXrANOVcYGRPEsY7J9FDecibwq06DPueEn3xYNj?=
 =?us-ascii?Q?OdhvIjIqWky4qCczqNF/g1NapqYqF/zzTIwHbQjN2pF2YJWVhC46FSUJJIQq?=
 =?us-ascii?Q?At84KtHDat59wYKNl1sz0k9g+IfAPg1wzvGIQl/wQNt09/kHvorKtzhoH2Mm?=
 =?us-ascii?Q?fcyRddpT+0njk2ydd2o8HppmogS64JB3DNV7pBx82LJWI8BzOp0GE17p6PgX?=
 =?us-ascii?Q?Vy3cWmPJ9r0vYzEn0RGBdkSONKZULPeKCa4rNMOdEMjK5HGRt6oaGr8IKzju?=
 =?us-ascii?Q?R954VzKDwNhnLc0sEHwPdA+Tp2SNJ6p4UlLan0A9nBOz1ZG1UO/RlBeXbaok?=
 =?us-ascii?Q?8/wGJ3zmDXpu5t3a67RwaS7Tf1dU06f2GY4kS7jZy1ovlc8H/+gWzxgDrgB9?=
 =?us-ascii?Q?QN5LpSpY8u6Ne8Z9+oatIrlqdIK8AuWuSwgZdYQwYjZlUc7/dl1OWpxx+S5C?=
 =?us-ascii?Q?HdYN7sIyzKPtzi3yJV1PZn59X/nQaVt8mmHJAuf/q54p0kFN3cTCovBbORc7?=
 =?us-ascii?Q?sCk5K477quu3RqnhUUq7Gab3SWtgWVzRWGnwAhu06WZfIdNca39frBA4pLFU?=
 =?us-ascii?Q?usvQgI7304JKpmtQTJaFPnUhaZVrrrMJfVkcySJw2+ORCOYAvzrvE67MW/9R?=
 =?us-ascii?Q?fez32vD04hVPmUq7tloN8BSX+TDB7j1MM7LyCD1Gqp0ZKLAF16GqXBbLPC1q?=
 =?us-ascii?Q?PuZNvqPk4Iohd5cTeGAVmWh3PzatEQUabBkffq8sRLvk9UXyOlFCzSCfz1XN?=
 =?us-ascii?Q?XRDl0rvgReFE8jszujyBU6/cjC0DlIA2dp70CSUZvJfYSj2jt2o5w0TeQaW2?=
 =?us-ascii?Q?888wPMncFEXO8UctMRjIdQZ1WJS3fZjd2iN6zTDO3LE50utP26lXfMvixopq?=
 =?us-ascii?Q?BedNqRtoml7mRywm0/IXkh6Xe5CBtDBFlcHkQfu2/qtMeuiaR5dB+eXfVEjo?=
 =?us-ascii?Q?Ekf1UyF0c6sgmOHoi0Boc2GXzigDIfSiXCfbDq96gSouk1V+Ft95KSzn1/k6?=
 =?us-ascii?Q?2KThHyH3m8VCW54W41rk+VmayRAf8E5JBKZbwht+HLS14IOtbPS6+LNyrAmE?=
 =?us-ascii?Q?pSXB4noHhILKM/IlgqyvbCDdHYefRI0e25V40qifp7b9vRj9KeIue/Ydpavr?=
 =?us-ascii?Q?tkXho+YDlqIZ3RQOLMPktJrMAWVA3aKTr11QGDum5OZpYzQ1CkNH6WvRhNMA?=
 =?us-ascii?Q?g5+h9ec8tPMTlAXeRDAHV8vVPmFU5nFmsN2fPF/2oXJtvj1ON7qnJxhbcabz?=
 =?us-ascii?Q?USy++PgEuCGr/r0FTyhhDFWp42EjGmixLJUZLr1Zce0FxPgqjLoUmJNHpJFv?=
 =?us-ascii?Q?RcndbNj3JAhhKLg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:38:16.9158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1554f4a-c9a6-45f0-f093-08dd57dba13e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134

From: Peter Gonda <pgonda@google.com>

Add GHCB management functionality similar to the ucall management.
Allows for selftest vCPUs to acquire GHCBs for their usage.

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
 tools/testing/selftests/kvm/include/x86/sev.h |  1 +
 .../testing/selftests/kvm/lib/x86/processor.c |  9 +++
 tools/testing/selftests/kvm/lib/x86/sev.c     | 78 +++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index fd5d5261e10e..0b4411847cbf 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -43,6 +43,7 @@ enum sev_guest_state {
 bool is_sev_vm(struct kvm_vm *vm);
 bool is_sev_es_vm(struct kvm_vm *vm);
 bool is_sev_snp_vm(struct kvm_vm *vm);
+int ghcb_nr_pages_required(uint64_t page_size);
 
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
 void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index a92dc1dad085..7129dfb652c4 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -651,6 +651,15 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
 	sync_global_to_guest(vm, guest_tsc_khz);
 }
 
+int kvm_arch_vm_additional_pages_required(struct vm_shape shape, uint64_t page_size)
+{
+	if (shape.type == KVM_X86_SEV_ES_VM ||
+	    shape.type == KVM_X86_SNP_VM)
+		return  ghcb_nr_pages_required(page_size);
+
+	return 0;
+}
+
 void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
 {
 	struct kvm_regs regs;
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 17d493e9907a..dd7ccf0324c5 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -3,6 +3,80 @@
 #include <stdbool.h>
 
 #include "sev.h"
+#include "linux/bitmap.h"
+#include "svm.h"
+#include "svm_util.h"
+
+struct ghcb_entry {
+	struct ghcb ghcb;
+
+	/* Guest physical address of this GHCB. */
+	void *gpa;
+
+	/* Host virtual address of this struct. */
+	struct ghcb_entry *hva;
+};
+
+struct ghcb_header {
+	struct ghcb_entry ghcbs[KVM_MAX_VCPUS];
+	DECLARE_BITMAP(in_use, KVM_MAX_VCPUS);
+};
+
+static struct ghcb_header *ghcb_pool;
+
+int ghcb_nr_pages_required(uint64_t page_size)
+{
+	return align_up(sizeof(struct ghcb_header), page_size) / page_size;
+}
+
+void ghcb_init(struct kvm_vm *vm)
+{
+	struct ghcb_header *hdr;
+	struct ghcb_entry *entry;
+	vm_vaddr_t vaddr;
+	int i;
+
+	vaddr = vm_vaddr_alloc_shared(vm, sizeof(*hdr), KVM_UTIL_MIN_VADDR,
+				      MEM_REGION_DATA);
+	hdr = (struct ghcb_header *)addr_gva2hva(vm, vaddr);
+	memset(hdr, 0, sizeof(*hdr));
+
+	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
+		entry = &hdr->ghcbs[i];
+		entry->hva = entry;
+		entry->gpa = (void *)addr_hva2gpa(vm, &entry->ghcb);
+	}
+
+	write_guest_global(vm, ghcb_pool, (struct ghcb_header *)vaddr);
+}
+
+static struct ghcb_entry *ghcb_alloc(void)
+{
+	return &ghcb_pool->ghcbs[0];
+	struct ghcb_entry *entry;
+	int i;
+
+	if (!ghcb_pool)
+		goto ucall_failed;
+
+	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
+		if (!test_and_set_bit(i, ghcb_pool->in_use)) {
+			entry = &ghcb_pool->ghcbs[i];
+			memset(&entry->ghcb, 0, sizeof(entry->ghcb));
+			return entry;
+		}
+	}
+
+ucall_failed:
+	return NULL;
+}
+
+static void ghcb_free(struct ghcb_entry *entry)
+{
+	/* Beware, here be pointer arithmetic.  */
+	clear_bit(entry - ghcb_pool->ghcbs, ghcb_pool->in_use);
+}
+
 
 bool is_sev_snp_vm(struct kvm_vm *vm)
 {
@@ -117,7 +191,11 @@ void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
 	struct kvm_sev_guest_status status;
 	int ctr;
 
+	if (is_sev_es_vm(vm))
+		ghcb_init(vm);
+
 	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_START, &launch_start);
+
 	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
 
 	TEST_ASSERT_EQ(status.policy, policy);
-- 
2.34.1


