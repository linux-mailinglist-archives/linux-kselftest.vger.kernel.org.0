Return-Path: <linux-kselftest+bounces-22070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767B39C964D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 00:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3674628353A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 23:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D591D1B6D00;
	Thu, 14 Nov 2024 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gK7LXqKv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ACE1B3925;
	Thu, 14 Nov 2024 23:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627749; cv=fail; b=LW5p9obRcHI3C+rVKU4XjxdgqtZqPsEXYZYDyjGXyFuMhS0BK/mH3MEiAVG3CifpYXKYo5uaUVQsgd0KTfb7iaCDtmkQhJkxHZ6aavyGZxJyxLm8yOvOJUx4IvcjnQFnMN9slnTEwUYjz0/UJMQgPbdoT0ZMbjNF5RC8HWscu9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627749; c=relaxed/simple;
	bh=JxXiwp1T9t5DyrSe2QVnxgOa15S3GGkuwtgl5AD8S4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNdonuH1tHVJNHt95n/R8J+Qy/d04ZzkqmpF+zM7xFLThIhmaxj+GgIB+hdwyT0rTFiTOn8bIvUIsDZkgdCxbCluGQR9mhxaJYzSqEaHutVuQw0BbQrT05BBsEfHQkezw4eFMzCp5glQ7XrkRiEttWuN3RF9zef9O9+WRzLlUXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gK7LXqKv; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIQU1dmDr2N2O7C1mGjq5Ff78+dR+aReVypmZtXRB24+8+4yjFzmzVxPXRLSQktVyBzgkr9SUoj75W2Akx9r0/yoYYS8bhuXE6DijEccii7CUWRbavQuiN1ln3uU9J0+5+RERqXcHJZAoIRa2d/TlES0C6plj9KS8IVoKw/z3EDasi/15uZn6HlG16OK/68utmx379Lb11bY3vpb4rXzT8zbHTa9/FaiaSHLo4vW13h6NQ80ZpyTvpMnnQQFwYLtWtnd4PE6zCQlGxH23r7nJOPXvNk3pQDIKo/fg816rEj5wCaJC8es2ax/TlLnFJyOqNBwE/1jYCC5glu7YIQsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcX6524Vd90dXMBxt5PBGO2qq+B1vS4K6h21naGTWCg=;
 b=NSevn5UesPZ0742IXSXk2MqZW29nf1SPULMLReZjiqe/Ycwe5GdBmAypX2Z+JcMHoDEE6Z+pSvth2jlTyl0PJJMwrazBUOGJlRmXTc16JZRZ0mme3FRhPLKo3nLSSeNVq75qpRQjHA/zUpYL69qQ1bFXjDinfVYvyN6VwBjx515UeS2JPyoqb5eXqvJYC6OWMwt7gbmb8IrydF0e481k7h0JYD9QNduGod0Oj/ozSq9MKSUHZUVjGzZhpNoZmlevtcCVb3N82D7ilRUhvy0ZuFzstVXmr5gPYNnUPh/MESYiHkSRqeujs1rMxMzlyiYeRqjdl/sNUFshhHEW76JsZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcX6524Vd90dXMBxt5PBGO2qq+B1vS4K6h21naGTWCg=;
 b=gK7LXqKv6+q9bBpxQB1g2rPRDFQP2ioTyyQX7FHmGxzCX2extVPhU4ilileZPVfzvZI6jOHoqneBAiOu15lfnvOGWbabNGIprp+WxETQRfXyKTWCdNI6RBmyJTjtXkjUQrB0t+eDofdTJ1JVWhJHpfZYbjeZvv4a9BSBH6Sk0XQ=
Received: from BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::14)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 23:42:17 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::88) by BY1P220CA0001.outlook.office365.com
 (2603:10b6:a03:59d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Thu, 14 Nov 2024 23:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 23:42:16 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 17:42:15 -0600
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sos-linux-ext-patches@mailman-svr.amd.com>, <pratikrajesh.sampat@amd.com>
Subject: [PATCH v4 5/8] KVM: selftests: Add library support for interacting with SNP
Date: Thu, 14 Nov 2024 17:41:01 -0600
Message-ID: <20241114234104.128532-6-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
References: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|SJ2PR12MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: ae54cf24-0710-4786-e562-08dd0505f952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DSRc7zDnkl22EmNC2/WKfi1Vur0cTmOCp2ZmKXD09BTe9thCr7dO5KR5xdqe?=
 =?us-ascii?Q?bS00wNPspYXbnxiVsRC/iqJ1e4H7IVUQUSRkRAB8ojHyBaM16WsbSxALd7EF?=
 =?us-ascii?Q?ImKu6Kxh1+LwUF10QnbxMXaE4P2oUESnJ6ghaPzbucsoe08E4B/0m1Be5e/E?=
 =?us-ascii?Q?JlJWbfcrE6bH/Oocvds8oPfepRRRCRw55LkVhyuMp97HQMm7uYNfAj2ncrVS?=
 =?us-ascii?Q?ABGlIx2II0TbjltP7atjTaY325Zzeb++GtpqUjPCD1tqTIvrT6FjKcI3Xbdt?=
 =?us-ascii?Q?0L+1bUxbvBhlLv+V//43dmTSfIrC1qH8qh4vqgy7PF5G4p+V96Gzl6jANcos?=
 =?us-ascii?Q?V5FXyUGpB8Ep6GxQz9328sVGQ6/nTYl2Qh+N1yVZ6RtoNaQa7fweZzKZpYrL?=
 =?us-ascii?Q?4rHIkWQOyxcUYJuY3UcgGytjOPshxiiWS7FvAcbP378VHEtKz0QkAh/8LXb/?=
 =?us-ascii?Q?y7vqor7VzcfxIOyO+CObOC+q4fH6YJh9cG975LBnoONO4tP0Gk4rfyCbFJ7a?=
 =?us-ascii?Q?XLjB9E7Im2f5nUxLZaTHxe6WJGA+3nrxgUror5pTIIJFSJOim0uMEeKsQiuc?=
 =?us-ascii?Q?R250YsCoJVxvhVkXOibWiNh1uE3eE/A97zyBpDTUjnAT3COZv4ojalm6YxYz?=
 =?us-ascii?Q?C1OisqAa0Pp+U1RdnZJyhJJd+FcG/TjhIhiQ5srZEFg5qlJNSbpOHQb1FRBM?=
 =?us-ascii?Q?hdI2qLycCWNpDVsBcVm6Clup3bS1gORN/NPCSHk51rF38znzjdQOk7Mncl01?=
 =?us-ascii?Q?mKWeSG6pnpcnW3+uurI7inxbLunxKIXJuHwxvVNpx7rBEo0DFUdvpNA5bFJk?=
 =?us-ascii?Q?MyNw0hL7g/wOA2bPAfO4W+bfnYPE2MVaj+ehYerQB9SOG2bgQqBjcTI4c3s/?=
 =?us-ascii?Q?x5s9znwW3Er/f0NTkT4R9FZxvsjjUobqzZ9sxj+q7l4j/a5GtdZcpsWdreSu?=
 =?us-ascii?Q?7steysW9/c+9xTYUQGXL/rmfbA0XuVg3pGqgy/fw4RrfM/W6B56u8q+U3UiX?=
 =?us-ascii?Q?X/1pBFrHl1l/OtdHZViAvjQNFw0qUwTE6NVULK2a5EX2y3C3vhEqmlf68zjL?=
 =?us-ascii?Q?SgTTGu+alm33SsBGcbti6QGuoa+G2N0RD2rpILqoOLeWeluoL7ZQA/EJ3Bgf?=
 =?us-ascii?Q?VUWXuf7suvBiDbknw9KtlLu68pxQokFhXHE4KYpuY/xC9xlFaf4PymPEi1vf?=
 =?us-ascii?Q?BM9FXNHCeBHByXCq1CnoZmfk6jL+B6r12q8ktJmu0vxszrl/mS/wDYJbZO6t?=
 =?us-ascii?Q?JCRp/J/JagzlET7H4hbGUTHYbYW1JzkrSmxZS6SEYynYv4Vyy26XwirsLN7x?=
 =?us-ascii?Q?KgBrV/ZE27JICxTR3F0ff0QvIHuDQVxtQ1pcLhRA3mI2h9OEZNHGY1NECsRX?=
 =?us-ascii?Q?/NnMdoz5uqsYUb6MvU9OIVYPezqOK9S8/9XI0dzRs2MQz6C2rQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 23:42:16.9600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae54cf24-0710-4786-e562-08dd0505f952
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990

Extend the SEV library to include support for SNP ioctl() wrappers,
which aid in launching and interacting with a SEV-SNP guest.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 .../selftests/kvm/include/x86_64/sev.h        | 49 ++++++++++-
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 81 ++++++++++++++++++-
 2 files changed, 125 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
index faed91435963..19454b0e10a6 100644
--- a/tools/testing/selftests/kvm/include/x86_64/sev.h
+++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
@@ -22,9 +22,20 @@ enum sev_guest_state {
 	SEV_GUEST_STATE_RUNNING,
 };
 
+/* Minimum firmware version required for the SEV-SNP support */
+#define SNP_MIN_API_MAJOR	1
+#define SNP_MIN_API_MINOR	51
+
 #define SEV_POLICY_NO_DBG	(1UL << 0)
 #define SEV_POLICY_ES		(1UL << 2)
 
+#define SNP_POLICY_SMT		(1ULL << 16)
+#define SNP_POLICY_RSVD_MBO	(1ULL << 17)
+#define SNP_POLICY_DBG		(1ULL << 19)
+
+#define SNP_FW_VER_MINOR(min)	((uint8_t)(min) << 0)
+#define SNP_FW_VER_MAJOR(maj)	((uint8_t)(maj) << 8)
+
 #define GHCB_MSR_TERM_REQ	0x100
 
 #define VMGEXIT()		{ __asm__ __volatile__("rep; vmmcall"); }
@@ -36,13 +47,35 @@ bool is_sev_snp_vm(struct kvm_vm *vm);
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
 void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
 void sev_vm_launch_finish(struct kvm_vm *vm);
+void snp_vm_launch_start(struct kvm_vm *vm, uint64_t policy);
+void snp_vm_launch_update(struct kvm_vm *vm);
+void snp_vm_launch_finish(struct kvm_vm *vm);
 
 struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 					   struct kvm_vcpu **cpu);
-void vm_sev_launch(struct kvm_vm *vm, uint32_t policy, uint8_t *measurement);
+void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement);
 
 kvm_static_assert(SEV_RET_SUCCESS == 0);
 
+/*
+ * A SEV-SNP VM requires the policy default bit to always be set.
+ * The SMT policy bit is also required to be set based on SMT being
+ * available and active on the system.
+ */
+static inline u64 snp_default_policy(void)
+{
+	bool smt_active = false;
+	FILE *f;
+
+	f = fopen("/sys/devices/system/cpu/smt/active", "r");
+	if (f) {
+		smt_active = fgetc(f) - '0';
+		fclose(f);
+	}
+
+	return SNP_POLICY_RSVD_MBO | (smt_active ? SNP_POLICY_SMT : 0);
+}
+
 /*
  * The KVM_MEMORY_ENCRYPT_OP uAPI is utter garbage and takes an "unsigned long"
  * instead of a proper struct.  The size of the parameter is embedded in the
@@ -76,6 +109,7 @@ kvm_static_assert(SEV_RET_SUCCESS == 0);
 
 void sev_vm_init(struct kvm_vm *vm);
 void sev_es_vm_init(struct kvm_vm *vm);
+void snp_vm_init(struct kvm_vm *vm);
 
 static inline void sev_register_encrypted_memory(struct kvm_vm *vm,
 						 struct userspace_mem_region *region)
@@ -99,4 +133,17 @@ static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
 	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_DATA, &update_data);
 }
 
+static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
+					  uint64_t hva, uint64_t size, uint8_t type)
+{
+	struct kvm_sev_snp_launch_update update_data = {
+		.uaddr = hva,
+		.gfn_start = gpa >> PAGE_SHIFT,
+		.len = size,
+		.type = type,
+	};
+
+	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
+}
+
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
index d6e7a422b69d..40b90d3a5769 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -31,7 +31,8 @@ bool is_sev_vm(struct kvm_vm *vm)
  * and find the first range, but that's correct because the condition
  * expression would cause us to quit the loop.
  */
-static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)
+static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region,
+			   uint8_t page_type)
 {
 	const struct sparsebit *protected_phy_pages = region->protected_phy_pages;
 	const vm_paddr_t gpa_base = region->region.guest_phys_addr;
@@ -41,16 +42,39 @@ static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *regio
 	if (!sparsebit_any_set(protected_phy_pages))
 		return;
 
-	sev_register_encrypted_memory(vm, region);
+	if (!is_sev_snp_vm(vm))
+		sev_register_encrypted_memory(vm, region);
 
 	sparsebit_for_each_set_range(protected_phy_pages, i, j) {
 		const uint64_t size = (j - i + 1) * vm->page_size;
 		const uint64_t offset = (i - lowest_page_in_region) * vm->page_size;
 
+		if (is_sev_snp_vm(vm)) {
+			snp_launch_update_data(vm, gpa_base + offset,
+					       (uint64_t)addr_gpa2hva(vm, gpa_base + offset),
+					       size, page_type);
+			continue;
+		}
+
 		sev_launch_update_data(vm, gpa_base + offset, size);
 	}
 }
 
+static void privatize_region(struct kvm_vm *vm, struct userspace_mem_region *region)
+{
+	const struct sparsebit *protected_phy_pages = region->protected_phy_pages;
+	const vm_paddr_t gpa_base = region->region.guest_phys_addr;
+	const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
+	sparsebit_idx_t i, j;
+
+	sparsebit_for_each_set_range(protected_phy_pages, i, j) {
+		const uint64_t size = (j - i + 1) * vm->page_size;
+		const uint64_t offset = (i - lowest_page_in_region) * vm->page_size;
+
+		vm_mem_set_private(vm, gpa_base + offset, size);
+	}
+}
+
 void sev_vm_init(struct kvm_vm *vm)
 {
 	if (vm->type == KVM_X86_DEFAULT_VM) {
@@ -77,6 +101,14 @@ void sev_es_vm_init(struct kvm_vm *vm)
 	}
 }
 
+void snp_vm_init(struct kvm_vm *vm)
+{
+	struct kvm_sev_init init = { 0 };
+
+	assert(vm->type == KVM_X86_SNP_VM);
+	vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
+}
+
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
 {
 	struct kvm_sev_launch_start launch_start = {
@@ -93,7 +125,7 @@ void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
 	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_LAUNCH_UPDATE);
 
 	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node)
-		encrypt_region(vm, region);
+		encrypt_region(vm, region, 0);
 
 	if (policy & SEV_POLICY_ES)
 		vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
@@ -129,6 +161,35 @@ void sev_vm_launch_finish(struct kvm_vm *vm)
 	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_RUNNING);
 }
 
+void snp_vm_launch_start(struct kvm_vm *vm, uint64_t policy)
+{
+	struct kvm_sev_snp_launch_start launch_start = {
+		.policy = policy,
+	};
+
+	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_START, &launch_start);
+}
+
+void snp_vm_launch_update(struct kvm_vm *vm)
+{
+	struct userspace_mem_region *region;
+	int ctr;
+
+	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
+		privatize_region(vm, region);
+		encrypt_region(vm, region, KVM_SEV_SNP_PAGE_TYPE_NORMAL);
+	}
+
+	vm->arch.is_pt_protected = true;
+}
+
+void snp_vm_launch_finish(struct kvm_vm *vm)
+{
+	struct kvm_sev_snp_launch_finish launch_finish = { 0 };
+
+	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_FINISH, &launch_finish);
+}
+
 struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 					   struct kvm_vcpu **cpu)
 {
@@ -145,8 +206,20 @@ struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 	return vm;
 }
 
-void vm_sev_launch(struct kvm_vm *vm, uint32_t policy, uint8_t *measurement)
+void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement)
 {
+	if (is_sev_snp_vm(vm)) {
+		vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
+
+		snp_vm_launch_start(vm, policy);
+
+		snp_vm_launch_update(vm);
+
+		snp_vm_launch_finish(vm);
+
+		return;
+	}
+
 	sev_vm_launch(vm, policy);
 
 	if (!measurement)
-- 
2.43.0


