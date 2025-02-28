Return-Path: <linux-kselftest+bounces-27848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D01FA49586
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30841163EF5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FE3257ACF;
	Fri, 28 Feb 2025 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S2sJlGji"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A34C1DDC34;
	Fri, 28 Feb 2025 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735646; cv=fail; b=NkkklMfyvFnTqPIisUb/axW7r29Y9hdGUJ8VzZiOLggUZlqOSaDmudikRDiZGukGxVKLKlY2BH1X2+M2b8vXlOPSe8i0Bb2Z6B5Hu9KsjZD/C5T/Mj5aItjKn4uLyznZxUpoiZQIqFGstp2aCY13cckFsH4Gj0EaILntJO2h6Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735646; c=relaxed/simple;
	bh=rD4//r3kR549+koh44xW2WmWWkHs6+2jXM1nzwv9uqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6+Afy18OYIQgnwa/VsJ83+Nnu20r/dUyrkiZo7T+H1yxo+AzpJWJqzCVn53+WTRGikS687zn4rxtAu8d/e06Z2ToT1rwS+x6iQeRTwtrlx48kknnxS0AZb6ZtOxx4QgaRLCcX5HDUuz5Dv9oQod3R4B9tnRN7TyAV5KQnGKsu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S2sJlGji; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1FNJDVKyI2t78ZS/d0Dj9t+VYsJzG8zfmbn4YuEPJ/U9mgkMQCI44rPHo7G1jxEvN4en/3u4rTtRCr8kJfuCqUPcS7FuSIJeo7gX+6dqrWS8k1CIALRPQjclhDl9szORAstPPThUZ+VZ4mlDXVjATStlAoiVQtujmTUaxPNOw5ATyMNr/iSMbI5dVhnCQ+liyRUiq4lIh6Ieex7omT4XyeuYksMxf2V8zykANutR2IN2Tck7qdf27Lk18UpNxLdiD5qx60QkcTjhlUDfSzAXxzJiEk3mtBWeOSty0ZcnXl2eHL3FkkG+BNemjodws/rkiSZXl42UpKdJxGqTtdIZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+WjIGEPo/PnZY1jqhkhGZqdkRLYhgXwOVwliXRhFFM=;
 b=rXYJQz9uYj57FX3C4o1b2nUCafJkDxxme7c0+qiK8Q7UEe4nPJd7TIn6NmBd18y5CA/hpRvtURl31B+6gkyrYWUXYLE0zLyX9/sJiTKz6rZwc7/kAPB1ZMG6Xb7pxWtC1CDx9HB31KZpbpq7XzeQzIY9E1cZ4sIuKiff13JAL8X1nK13WD8tza1fQ7QHV2kifI3i49QjbQu54bQ7B/jekfIRjn2PmJ7SECTnbiAldHinLTAyjSPIjoRSpShEqr8McTOyO4ifRzkN8njRSZ2tZvGZViVr9nCjG+VQ0HuFVuD+U94RemOTimPfHZ0Ad4rvpBWHeAapcpBfZ6qdaLXL7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+WjIGEPo/PnZY1jqhkhGZqdkRLYhgXwOVwliXRhFFM=;
 b=S2sJlGjinz84yQUl/wxfwLeeYRhjsQHOOLT7JoQPiSgej2lsxZ40keQYu+e2A7sMoaXXmNcbAPgjDYS4qyo18wOiSvPUu4pOx68qIxo9EOw/UeUoiQSiLsGVnLMpCmPRYmXLCe4qccl3bRSrcGUA1KlYsY9q4I1nQtqZ23YcieY=
Received: from BYAPR05CA0071.namprd05.prod.outlook.com (2603:10b6:a03:74::48)
 by DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 09:40:39 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:74:cafe::15) by BYAPR05CA0071.outlook.office365.com
 (2603:10b6:a03:74::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.9 via Frontend Transport; Fri,
 28 Feb 2025 09:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:40:39 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:39:23 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 06/31] Add ability for SEV-ES guests to use ucalls via GHCB
Date: Fri, 28 Feb 2025 14:59:59 +0530
Message-ID: <20250228093024.114983-7-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: ee25f1d5-5dfe-4e89-bd6b-08dd57dbf5f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8IdC1MhoMLdhn8P0rYSuFQVkKp8EI3zvLcRz9wQ5jCf7Q60QZ8/qQSjbJTPO?=
 =?us-ascii?Q?ralAl4PVu1RDZS36rKzILA0PLRXbxA3T5y9cwnlTwMK6gW8KUecMzhMLmzTC?=
 =?us-ascii?Q?X8XB/62HpKBsT5URm8d4oNgZ2JjdnEYPJj+4vvKzPoKhbHx8e9e93q6PcmzX?=
 =?us-ascii?Q?dBMLg8ACx4YIqtes5jbCJChKdXW+ZIiVOMwy1SCEBjPjFhtah8U/EFXKLnGT?=
 =?us-ascii?Q?50D4MCmiwh8FtBg7T456WFp7bEaEth4BNt6poYf+IuqQfeyvOBJRj0A/q4NR?=
 =?us-ascii?Q?o5feKcs1K/36eIhJARnEYpUdEJrBZzMq9Lk8WKNFAe8NrvMCldg1Zz+0Cf+k?=
 =?us-ascii?Q?BAeWUpuGPin3Z69dvmdw+kAyporHrMumhzQjhm6mBtl00MfGTlNwq+taaL8X?=
 =?us-ascii?Q?zBZgTnZ2YDRnkew4HINdwFDF6e7voP+lPsR2ozXYN7Oj0C/1YA13MDLdHY7R?=
 =?us-ascii?Q?ODimrj0iu/XHrPRTCMBRPXBIQDj3wRybaZ3Jj4AKy0wDuHKtqVyav1wT4KIS?=
 =?us-ascii?Q?1d6zF86SBw/Bu+DDObUYzRVRrHPwb28keF9kN2euoNCnXPj0SXo7pOl16voo?=
 =?us-ascii?Q?CDH7RjFHADwJowwJvuvbBPi69mO8Z09hCXw58JdBIdjOcTlUlS/Jfl1fqAmk?=
 =?us-ascii?Q?Afc4f92wqcSYKXin6VUldo0Vy1rU8+WWP8/heDAdNxvGDcTGifh1DC0RrYWR?=
 =?us-ascii?Q?mTCSSPLb2Q1gR7TwTC/WkBpAMZBPzLDFojXpyq2QkJabBD3DNEzw0G+FRuRO?=
 =?us-ascii?Q?9687LkgLz3g+nRt+I/15TM5adSB7Gx8QCF8MOwPKrzDhzw7q3CcgDnqoJY5I?=
 =?us-ascii?Q?Tqb/pSPms6Z/lVJ3/qVfa4FkepwotjEr+KAEJlwLIld4LEwkk7W4DzNf6CSG?=
 =?us-ascii?Q?I0xxRmzr/lDFx3eetqkCq+eL8S32ANfmWnTG7cxYgckOhCgSWc3sN/xEnWc7?=
 =?us-ascii?Q?NTZY0Fdzuoh6EOXvM1kNS1UFdfhmAzmFVAmSrqgJ1pVETuHW5gfaIyYbxnM2?=
 =?us-ascii?Q?PhtySlb68MCKDgsZb4wmil5I9mCRzGlVIKtvG3TF/cBqzkBE2KyMLJIDSZs+?=
 =?us-ascii?Q?EV+I0I6EzZ4k4EgfnfBe1YcOUYxVMblS1ciH70GDSBiaVK58e90THqV+GMsI?=
 =?us-ascii?Q?MXTLWklOAdfMbvUl04LvcXm/wkqKTUudfkKNWuWFMt2BfvWkzmCJVNmIXVu9?=
 =?us-ascii?Q?3vhgSccMmJu8iALlLJHun1EoWxZaqypkmzDDuVz2ZZQVLbUMcycBar9bgw2E?=
 =?us-ascii?Q?wM8bakH8ihYL2JOE/hUrtPPQ2E0QXjuOzrcOvoDJ9AwO5Z+ca23gs0OCDX8O?=
 =?us-ascii?Q?uabt/TT+FIUEj85ThARoIbnzWgJ1YX47+Zhqub1GOhF8/Afc+S0nxZlkm1SK?=
 =?us-ascii?Q?LYgmF4IPpVzb/wZycsw4h8bAa76vci/01DClz+kCk3fRgjZOZMe5Q4KX/2RT?=
 =?us-ascii?Q?3FXpBpa9mSUzMT7SdZOjbnkL8SI0YEMpQhubNvSdT7y43jDDWyNI0DczpP2w?=
 =?us-ascii?Q?MisGoX217iDFKtY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:40:39.1780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee25f1d5-5dfe-4e89-bd6b-08dd57dbf5f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533

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
index 437e397ddd29..bd6ab3f38679 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -151,4 +151,6 @@ bool is_sev_enabled(void);
 bool is_sev_es_enabled(void);
 bool is_sev_snp_enabled(void);
 
+void sev_es_ucall_port_write(uint32_t port, uint64_t data);
+
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 0c542eae4184..425ec8a3a3c7 100644
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
 
@@ -191,9 +214,6 @@ void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
 	struct kvm_sev_guest_status status;
 	int ctr;
 
-	if (is_sev_es_vm(vm))
-		ghcb_init(vm);
-
 	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_START, &launch_start);
 
 	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
@@ -285,6 +305,9 @@ struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 
 void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement)
 {
+	if (is_sev_es_vm(vm))
+		ghcb_init(vm);
+
 	if (is_sev_snp_vm(vm)) {
 		vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
 
@@ -323,3 +346,62 @@ bool is_sev_snp_enabled(void)
 	return is_sev_es_enabled() &&
 		rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_SNP_ENABLED;
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
+		VMGEXIT();
+	}
+}
+
+static void do_vmg_exit(uint64_t ghcb_gpa)
+{
+	wrmsr(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
+	VMGEXIT();
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
index 29382dcab18c..3834d3664219 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -20,8 +20,7 @@ static void guest_snp_code(void)
 {
 	GUEST_ASSERT(is_sev_snp_enabled());
 
-	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
-	VMGEXIT();
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
-	VMGEXIT();
+	GUEST_DONE();
 }
 
 static void guest_sev_code(void)
@@ -102,12 +96,7 @@ static void __test_sync_vmsa(uint32_t type, uint64_t policy)
 
 	vcpu_run(vcpu);
 
-	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT,
-		    "Wanted SYSTEM_EVENT, got %s",
-		    exit_reason_str(vcpu->run->exit_reason));
-	TEST_ASSERT_EQ(vcpu->run->system_event.type, KVM_SYSTEM_EVENT_SEV_TERM);
-	TEST_ASSERT_EQ(vcpu->run->system_event.ndata, 1);
-	TEST_ASSERT_EQ(vcpu->run->system_event.data[0], GHCB_MSR_TERM_REQ);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 
 	compare_xsave((u8 *)&xsave, (u8 *)hva);
 
@@ -128,16 +117,6 @@ static void __test_sev(void *guest_code, uint32_t type, uint64_t policy)
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


