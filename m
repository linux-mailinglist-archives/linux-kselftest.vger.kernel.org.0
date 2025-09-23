Return-Path: <linux-kselftest+bounces-42095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 065BAB944E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1352E143E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239C230DD08;
	Tue, 23 Sep 2025 05:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yJjaw2bn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010019.outbound.protection.outlook.com [52.101.193.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55610272E5A;
	Tue, 23 Sep 2025 05:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604274; cv=fail; b=KiDmW45DGR0fyseReBsbFlu8Vy4YjtX1b+ZSEElwUSjAGQ+OMWxmiA/RPHESXxtM1NzKNc4DnREtl/p3+QBFstVCIOAlMuYPFzy98VcgJ1YqhaiVMzKsiPbkSZdqp/sZ99vPOkyX4HK4o16+yoXg0wvhb4O3SA2KP+cehLQPwC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604274; c=relaxed/simple;
	bh=zoWx+dzcsl07uRqEJCQ74UFYRfIhlfm7gZ7ghM/KUpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjiwdBtRJXtKo0NW6mxeIkWheZZUuLQcEyBT7ky5w/cYNAPucHlBDJLLFWV0sxg9owB4g4aNRpUWq7xFaW/qawIjjRZ3Y+LhGsTGPJ1+1wh5JlVzzOwf3ucfEsn7wbzhat4fk0Zh8PhyPHapuMTar4IrccN8JBsl/zaUBBAe9aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yJjaw2bn; arc=fail smtp.client-ip=52.101.193.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSpg3nIdhSHsm5QcmThIdxf1Q+SrT3o12XOdjBtERxujkYSvCN11pHjvKdFj44vl7bU/yT5iE0kAvkFURz2q1cTUM3Mh9OGh1lt2/eRPfAbFY3xYrPrRDmUrAEXGoT0tdfyij5qVT89T2mTc/1/8LT8EF9Yq/OyvXLVOOOmBUlro2nPKo9g7H5ure3fJ1XG6dm+hSOjYTsTpR5TnkUK8fbL54MoQ30GIGvRAWNvAYuZG90ul3KflNir3Qa/ZsPDMjUVHrKFesJWJXjtiQfMLV8HRxEIHTg5hulK34CpkW0SCtt6QPls/XEsnijGoXD/s1Gl1skgmnr3tA3BZVP5yDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhUV+6Sof0Ablv9xPhrcdJ7bUtp8bnPBp5TFaojMyFY=;
 b=bePYwue86gfq6MWuf8i+t1elI+grHbHLD/RcOrFiyuTs3OhUBSNsJ1CsPDxJAjeOpQIggta0p6kkNT3Vl9JUHap1ssekI9Yn3kWrbO/x6QM90QCqejYcKcCYfPh4G5Uus/PZB7nk05cNxwR9dap7VDXYHMYuzRuHQLZvud9f6v+s6qNWibg0cpJaNp4QwsvZSUww2h9CiGSajiIXOMPnJ9ipHtVDfY3iZazt4L9GpFCW3GiBCkasPDGiW9l1URB004hB/HZ7yJhOQFW4DxcKLnkBGVsP5KogTuy5mdescNnKQ00a6bqyEPCBIQh8A+IISLCo+EZqk0uBTbDgmRvDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhUV+6Sof0Ablv9xPhrcdJ7bUtp8bnPBp5TFaojMyFY=;
 b=yJjaw2bn085VG66R97Vqbp1bVsN/x7iu/Ykt47rRJLyYNKXZ8ABLzSs2taLjEmK/29qKyVIDhYwYSjzSLAsNS7HwDrbKdWD6ZjIGV7F261vcYgO+3Ww+n2QhZyUGMsfXCHvbeLfrMYuOjJ967PjIiGVpdYRQbaXzn8boHh57IB4=
Received: from CH0PR04CA0063.namprd04.prod.outlook.com (2603:10b6:610:74::8)
 by PH7PR12MB9067.namprd12.prod.outlook.com (2603:10b6:510:1f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Tue, 23 Sep
 2025 05:11:06 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::7e) by CH0PR04CA0063.outlook.office365.com
 (2603:10b6:610:74::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:11:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:11:06 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:11:00 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 04/35] Add GHCB allocations and helpers
Date: Tue, 23 Sep 2025 10:39:11 +0530
Message-ID: <20250923050942.206116-5-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|PH7PR12MB9067:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d3987b-fb18-49f9-387d-08ddfa5f9981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5BaiC0iwC4CRXOO04PEy649xtiYswVv8Re2ItNrVEGeRhxAQKQaVi8qMtDiD?=
 =?us-ascii?Q?tVbF+wwxpFUdNdla80pcO8X0NITZiHpzd2xc9/AXdShXwW2xnotE11zz65DZ?=
 =?us-ascii?Q?J0zZUK1x7jvN9I+nu/cTgeC7GFK0beun5FViqSdbYapkDApKVL3xJCPNDzrE?=
 =?us-ascii?Q?WQ1f1DvV6OO8UsAG+RZXBo37i9j4b5U8d1WI2iHZCyKkObPReqYbiGyCngur?=
 =?us-ascii?Q?iZkeW1+sXVciAsLnOgwmbEGooUuWZE0Ll6GFcGSQiW44Q4Dtla5rldiRTte7?=
 =?us-ascii?Q?QK400Ysft3O1xiP1LpIVSpfVnFAQWHQWDtlWT+vL0bKxKSmkxvd2dKtjjoPv?=
 =?us-ascii?Q?hXWTeDXuBcPeec2tMamHq4a+Rv6+Gcg3d9ZzI46JJiXIv+sEHQNSd/xV7WNk?=
 =?us-ascii?Q?zlD3ISyWCEsmFIAfz4EcXgupgLjiVIaB4ecGOVTuEQIJPyZxsGp6T4f+qmFT?=
 =?us-ascii?Q?ukGiE6Ft4GpGY4Mpzz/oihCCmZ9ZfosPJXq11tSBdzoIrJFuyv7da3X+XPjP?=
 =?us-ascii?Q?8myY9zNtINKJ6v8vBjfR931PoWugABoNf3MW9zyHTw/tn77lOFeG/0UEbT1e?=
 =?us-ascii?Q?NrRlekWd0m3sRiyA5tl/1dE4hcuPyAutQH4rbYm5nckyy5662A8loI12DlXZ?=
 =?us-ascii?Q?SI29VkAFeNOlSnp+H4pB0ZSojxiPYR5mhuSqoa1vqik87sHUWKvg19dqEFq8?=
 =?us-ascii?Q?rngFXLHUQIAkUUrfJt0HVi2pHj9JFXQzAfPIMouybbnKXIi+MPYnVmX4un0o?=
 =?us-ascii?Q?RB+reWKtx9P55GQ7OHKfkj43JXRipSQSw14g5/gGMUyZEDK7XjeoDchHqQUx?=
 =?us-ascii?Q?exftjP2teLQODcpCHLTUm7AffKj09NIPP8KYFPvhtzO4PmKQmzGTeFicXNQD?=
 =?us-ascii?Q?we1D473SM2h96epVsVfFbAqjZw0vV1/YsI/xxUlmCkqohKyFa+L8T7+5+2Ep?=
 =?us-ascii?Q?iqD9RjE9pDPXXS1byT2r1JbDVxV86Z20PyY9pPTBKjpNnskL6oC2NQLY1+tZ?=
 =?us-ascii?Q?GxEKmhZSMWhf+sL6MNM/t1DzCH8WcL06w2+6vObK7uVZ7+uNHLny9eYLXNPM?=
 =?us-ascii?Q?OTzTvVhCxtSHzTNSJYxijkNHDnME3msKz8Sofvc3lxPxamObirB7nFFugxmQ?=
 =?us-ascii?Q?2gefgI1jQOj2jedPy1bHQL5YiUQoYMQEX37Viyu9ql+W/p9tm41G+JyOhjCm?=
 =?us-ascii?Q?RYsMGXpw6Ih+ueDZhNegnYiJEXcbAcLb5RmHvZSt5KCVb1wAlyWP1q9VLno9?=
 =?us-ascii?Q?ZzpIoS0DArhy6l00EjafHrQrCsTXs8LS8Bs4RxNRTmuWYccpmtgRWyhBMovD?=
 =?us-ascii?Q?n8nIBSIqmE0f8vfmDGCByDFB03MN04injzPAvkp/MIQZbhoxxwg6Oj4eroil?=
 =?us-ascii?Q?u+bM4SCWDDMwT/rBCHbQnD84pr4plRZ4o9e/7LmAYBBNcubwaS2eGqfgGaqU?=
 =?us-ascii?Q?ZS+f8eNOvZuNBPpHTf1bRTE8nY7HbdvAJSBf82kyO0bfEMddTky5G4Le5O/A?=
 =?us-ascii?Q?1jwSYMs81xwAVgN6WZELqNLCyIOyOKc3TlLN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:11:06.0150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d3987b-fb18-49f9-387d-08ddfa5f9981
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9067

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
 tools/testing/selftests/kvm/include/x86/sev.h |  2 +
 .../testing/selftests/kvm/lib/x86/processor.c |  9 +++
 tools/testing/selftests/kvm/lib/x86/sev.c     | 78 +++++++++++++++++++
 3 files changed, 89 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index 008b4169f5e2..6cda0acd22e4 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -46,6 +46,8 @@ static inline bool is_sev_vm(struct kvm_vm *vm)
 	return is_sev_es_vm(vm) || vm->type == KVM_X86_SEV_VM;
 }
 
+int ghcb_nr_pages_required(uint64_t page_size);
+
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
 void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
 void sev_vm_launch_finish(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index d4c19ac885a9..d72eb96efb7c 100644
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
index c3a9838f4806..c400faa9cc5f 100644
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
 
 /*
  * sparsebit_next_clear() can return 0 if [x, 2**64-1] are all set, and the
@@ -88,7 +162,11 @@ void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
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


