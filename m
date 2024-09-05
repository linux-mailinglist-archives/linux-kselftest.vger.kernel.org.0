Return-Path: <linux-kselftest+bounces-17225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A70E96D8E8
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 14:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558BD28C63B
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 12:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D6F19B5B2;
	Thu,  5 Sep 2024 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z8HMb3HE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476AF83CC1;
	Thu,  5 Sep 2024 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540095; cv=fail; b=iLcbg6IqarDhqxnBKbEdbi5A6EBzJptZ8OKaGZ5ZCuEXrRCT2yw1mvg8kDimB0hKHqZyym7+fiJT/AV25T51dFwEGrlO7rFW8m9e/sPUKQhp0niJh3f8oP+jAVwljPylvx3oHbJT2oTx7RbGApe6c3KVzAYR1euCK4rRlcv5T24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540095; c=relaxed/simple;
	bh=dC9tnz2IdAFGQInPzaxUu/I5kUmTyuAB+nlWbHbLoeg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqXRb+37MH5j3A9/VPTTXWhQ7eN1g7dpjRFxZ48UQsRhHv8417aGb6zhkAmZxBNXllGGt0sz8MKpxjDGKZwuXLfEanbY3+32AALQn4CQkWbEpsZYZM4PDwAx5fHQqG0aDJIOIK0sOxh2RohNiZhFkMNTdu+c2LvHtiQpkfwFndk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z8HMb3HE; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxxmMx0/g8Xqqh1wyEg/uFZN/nE3pYOnZaJ9XXq/+/j6p6GaBNqFxiE/pGSokO5oGEJxFLIU7/mHeRFqDBFE8yPW0m96LDm5yez3SVE4ux4s3XcSxZeK0b371uFaqFgTsDQChzntyRo49jJK2GGKTnVhn2c4kezotIz8oPh4JBkaPM055kWCzsYC+0V2caevwYbeyW71EslH3aekB+MnzpDbdzD3FlbvVa/8+C8cSvvYVXFthBu+viU4ByQQs9iuD33ZOBXh7vsbSjYBnDd+v35LXTQUOxjZ3CqYKMTaIqnjcnJvszE2IGzxGjtp7rRTcOo/iJEhcqJi2/yXaTcTLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADOqkBzoG4K6tOReSMxTsvfzlRSPxgSJ3xv1/w9nEiI=;
 b=KdRIYFx8dkc8/7eqlPnVTFfagd7u0OlRnA1CwceK+rvXlCDtKjijrmjKoqIqwxkl0OFS2cfigomaqKX93NE3s/dx754PqUdNpyzuBQ6E8Mv//hF9uYkCuvUvaUNwy6PaHudrbZFS94VuPANE/aULC/4KcGZBQEIqzA5BY0VC3n156GlAfewpk8V0tQ7Nf0pD6EDHymfDcCrwbjeztbD1CGKfYYDv9eAz9dJK9i5diNzCt+EfhV0lgtkIOMqt1VzXs9XV6w0QZgy0ffE9EgpDu5ikk+A3VQJDNiRDD4ito9HQ8xqsS0gSagCyZnppzBKntXEInzqkYbuuYLBvr0rFMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADOqkBzoG4K6tOReSMxTsvfzlRSPxgSJ3xv1/w9nEiI=;
 b=z8HMb3HEbk0JGWnJ3SG9PQxs0CBQJnhnDgsYFKT6Xzmt5LRi8YgpVYiNpmZy6wLyUcrNyRnvOqRTta3WS5wGmCrsQL8u7k9m2EnFfwa3oaNNf3hEoHxswNPvCQjHUxzcye88wqp6A4znrqo9KeTpmGQ1fCXm6elf5bYpfV+5dFc=
Received: from CH2PR11CA0024.namprd11.prod.outlook.com (2603:10b6:610:54::34)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 12:41:27 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::fa) by CH2PR11CA0024.outlook.office365.com
 (2603:10b6:610:54::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 12:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 12:41:25 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 07:41:24 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/9] KVM: selftests: Decouple SEV ioctls from asserts
Date: Thu, 5 Sep 2024 07:40:59 -0500
Message-ID: <20240905124107.6954-2-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
References: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0a5ae8-dbd9-49a8-82fd-08dccda80e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?we9isSSCIqXgpp1XP0pBl/4dWlmn2OxMOy/rhTtTSAhmmc+d0aGvkHQpKlt7?=
 =?us-ascii?Q?ilusa1OgSwzCse95LdSNzIEQjSC2I1nMQ5wWX5a6KUXstt1gW2QZMw1KdCxo?=
 =?us-ascii?Q?STvs7rUcQSJ7dpkhqQ8wLf2T7uu3KJ8XopL7BQEgonPjA60RAWt4AcKueYKF?=
 =?us-ascii?Q?c98DJO0kCz/b3dJcmFbT03U83DIqZpcaXCDLcQ9DzAodQxxYYCFqJ+812t7r?=
 =?us-ascii?Q?3BuJkyChAAEaY70UyexevotntlGhg/L8gHUBtoYeehWZMJ7jd54wXPhslUbg?=
 =?us-ascii?Q?8U6/SIEJNg7SbZnNUSl6KMCT/vLMlh156P23qMdnVgE63LztW4hlUu0XoZrw?=
 =?us-ascii?Q?RRuqbCgLgSJt2HflRc89voDEJqBoMi8TAqrdJxJHQ7cRbtG4BY/dOmviEPdI?=
 =?us-ascii?Q?TK1XdSq3m2pFdklY0eJxieUdOT3NiYUzQ/06/Mlh+1+JeZWA811DOj7cd/hu?=
 =?us-ascii?Q?dnLBRtUeXtfTl2CyEIMxiN2kTZ7sMVJ4JZ5ixgkEjSzda+Okr0motXcasG95?=
 =?us-ascii?Q?VFDGBOKw+FbrHax0jLIqU8E0ro4sDbVM6aVjh/vJuUE4CV3i4KIJ5aMmqWET?=
 =?us-ascii?Q?c/MclvWF1DKMW8Bn7Qx5ZtrLdhvDo5JZ+QAKuSwaOAqx4QxPDrTtgwCagfR2?=
 =?us-ascii?Q?tDVucDnP9JdEs/0utGl0qJB2EAN06V1dnyBnc0HzJIm23/lYhv1Y38N0VGeM?=
 =?us-ascii?Q?9Pt6Cl9AQZY/gbf/7auUs8H3G3w9tCauTp2A9nl7B5rdjRvbi3DM9Msgsps8?=
 =?us-ascii?Q?S78wO8cytPeSXIWJyL7ibYDhYWR7azkzD6MJRDqkK2JYSFTdfgwDGjzOM3bS?=
 =?us-ascii?Q?Ih+8p8gzUNppD3Q2sVsUfmCkmjYZUCfMyudJNdKV52+E1vXOycT3kOd18uM0?=
 =?us-ascii?Q?ngPKB5zwiXrOrP6CMm7rui5I20sDnQ+7zf2hozZTbi3fiDnl3TYZxk/1Y/tA?=
 =?us-ascii?Q?FefR2goXIMrhUO3rKu4XdfJB9WnUoyXGwaJFvRhbL5zzHdW6mObvnWJenf5o?=
 =?us-ascii?Q?D7pwl9oNNI1mLAts/mKdY6HVVfUQIRPmAXrVpegeQ8JFpdwPaeluvpUTlGkT?=
 =?us-ascii?Q?6LrzVWAvgvAvP2f29gj6hMgwjLkmcCxB0J1alt9dYrknZCQ/xdI+A5pH1x5H?=
 =?us-ascii?Q?yVEm6GyonCyzzLn/XhENhkAd9IDnlUhnx0b5+TFYyTgzCrPDNppQeRlVQHhl?=
 =?us-ascii?Q?iDm5fTvLPHdLtAND/3vpv5SUQ4c+pwNqJqtnMRt4gMYxm3d95C99PYRhBCrS?=
 =?us-ascii?Q?hynE4nmgdiR5HBiOuq3It+uuu2xY/qVhjoGOxmRhRlwH600ZL3OD+GgtT3NM?=
 =?us-ascii?Q?X+wDrMWxoebBkHH3t5mQOTbA4T2YzNr6kctF6KcG0ttSXjuXQjWY1DnfDq2T?=
 =?us-ascii?Q?WpwYjl29Yvh9Nn+kuCd//Venyv0fSbiXyMqLK7KKXezV/WpuFudZmJ6MHlj7?=
 =?us-ascii?Q?GbBpM422py8ocq+fz11hgHp3juNVXfA3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:41:25.8669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0a5ae8-dbd9-49a8-82fd-08dccda80e69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088

Add variants of sev, sev-es launch path that return the status of the
ioctl call instead of asserting for success. This enables both positive
and negative testing of the path.

No functional impact intended.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
Tested-by: Peter Gonda <pgonda@google.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
---
 .../selftests/kvm/include/x86_64/sev.h        | 22 +++++-
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 78 +++++++++++++++----
 2 files changed, 80 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
index 82c11c81a956..3998152cc081 100644
--- a/tools/testing/selftests/kvm/include/x86_64/sev.h
+++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
@@ -27,6 +27,12 @@ enum sev_guest_state {
 
 #define GHCB_MSR_TERM_REQ	0x100
 
+/* Variants of the SEV launch path that do not assert the ioctl status */
+int __sev_vm_launch_start(struct kvm_vm *vm, uint32_t policy);
+int __sev_vm_launch_update(struct kvm_vm *vm, uint32_t policy);
+int __sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
+int __sev_vm_launch_finish(struct kvm_vm *vm);
+
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
 void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
 void sev_vm_launch_finish(struct kvm_vm *vm);
@@ -82,15 +88,23 @@ static inline void sev_register_encrypted_memory(struct kvm_vm *vm,
 	vm_ioctl(vm, KVM_MEMORY_ENCRYPT_REG_REGION, &range);
 }
 
-static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
-					  uint64_t size)
+static inline int __sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
+					   uint64_t hva, uint64_t size)
 {
 	struct kvm_sev_launch_update_data update_data = {
-		.uaddr = (unsigned long)addr_gpa2hva(vm, gpa),
+		.uaddr = hva,
 		.len = size,
 	};
 
-	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_DATA, &update_data);
+	return __vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_DATA, &update_data);
+}
+
+static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
+					  uint64_t hva, uint64_t size)
+{
+	int ret = __sev_launch_update_data(vm, gpa, hva, size);
+
+	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_LAUNCH_UPDATE_DATA, ret, vm);
 }
 
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
index e9535ee20b7f..125a72246e09 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -14,15 +14,16 @@
  * and find the first range, but that's correct because the condition
  * expression would cause us to quit the loop.
  */
-static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)
+static int encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)
 {
 	const struct sparsebit *protected_phy_pages = region->protected_phy_pages;
 	const vm_paddr_t gpa_base = region->region.guest_phys_addr;
 	const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
 	sparsebit_idx_t i, j;
+	int ret;
 
 	if (!sparsebit_any_set(protected_phy_pages))
-		return;
+		return 0;
 
 	sev_register_encrypted_memory(vm, region);
 
@@ -30,8 +31,15 @@ static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *regio
 		const uint64_t size = (j - i + 1) * vm->page_size;
 		const uint64_t offset = (i - lowest_page_in_region) * vm->page_size;
 
-		sev_launch_update_data(vm, gpa_base + offset, size);
+		ret = __sev_launch_update_data(vm, gpa_base + offset,
+					       (uint64_t)addr_gpa2hva(vm, gpa_base + offset),
+					       size);
+		if (ret)
+			return ret;
+
 	}
+
+	return 0;
 }
 
 void sev_vm_init(struct kvm_vm *vm)
@@ -60,38 +68,74 @@ void sev_es_vm_init(struct kvm_vm *vm)
 	}
 }
 
-void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
+int __sev_vm_launch_start(struct kvm_vm *vm, uint32_t policy)
 {
 	struct kvm_sev_launch_start launch_start = {
 		.policy = policy,
 	};
+
+	return __vm_sev_ioctl(vm, KVM_SEV_LAUNCH_START, &launch_start);
+}
+
+int __sev_vm_launch_update(struct kvm_vm *vm, uint32_t policy)
+{
 	struct userspace_mem_region *region;
-	struct kvm_sev_guest_status status;
 	int ctr;
 
-	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_START, &launch_start);
-	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
+	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
+		int ret = encrypt_region(vm, region);
 
-	TEST_ASSERT_EQ(status.policy, policy);
-	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_LAUNCH_UPDATE);
-
-	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node)
-		encrypt_region(vm, region);
+		if (ret)
+			return ret;
+	}
 
 	if (policy & SEV_POLICY_ES)
 		vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
 
 	vm->arch.is_pt_protected = true;
+
+	return 0;
 }
 
-void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement)
+int __sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement)
 {
 	struct kvm_sev_launch_measure launch_measure;
-	struct kvm_sev_guest_status guest_status;
 
 	launch_measure.len = 256;
 	launch_measure.uaddr = (__u64)measurement;
-	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_MEASURE, &launch_measure);
+
+	return __vm_sev_ioctl(vm, KVM_SEV_LAUNCH_MEASURE, &launch_measure);
+}
+
+int __sev_vm_launch_finish(struct kvm_vm *vm)
+{
+	return __vm_sev_ioctl(vm, KVM_SEV_LAUNCH_FINISH, NULL);
+}
+
+void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
+{
+	struct kvm_sev_guest_status status;
+	int ret;
+
+	ret = __sev_vm_launch_start(vm, policy);
+	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_LAUNCH_START, ret, vm);
+
+	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
+
+	TEST_ASSERT_EQ(status.policy, policy);
+	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_LAUNCH_UPDATE);
+
+	ret = __sev_vm_launch_update(vm, policy);
+	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_LAUNCH_UPDATE_DATA, ret, vm);
+}
+
+void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement)
+{
+	struct kvm_sev_guest_status guest_status;
+	int ret;
+
+	ret = __sev_vm_launch_measure(vm, measurement);
+	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_LAUNCH_MEASURE, ret, vm);
 
 	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &guest_status);
 	TEST_ASSERT_EQ(guest_status.state, SEV_GUEST_STATE_LAUNCH_SECRET);
@@ -100,13 +144,15 @@ void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement)
 void sev_vm_launch_finish(struct kvm_vm *vm)
 {
 	struct kvm_sev_guest_status status;
+	int ret;
 
 	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
 	TEST_ASSERT(status.state == SEV_GUEST_STATE_LAUNCH_UPDATE ||
 		    status.state == SEV_GUEST_STATE_LAUNCH_SECRET,
 		    "Unexpected guest state: %d", status.state);
 
-	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_FINISH, NULL);
+	ret = __sev_vm_launch_finish(vm);
+	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_LAUNCH_FINISH, ret, vm);
 
 	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
 	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_RUNNING);
-- 
2.34.1


