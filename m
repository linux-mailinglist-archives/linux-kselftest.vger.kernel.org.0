Return-Path: <linux-kselftest+bounces-42093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C28B944D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CDF13B5F29
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E93230DD00;
	Tue, 23 Sep 2025 05:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zn3UGlvn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9114321ADB7;
	Tue, 23 Sep 2025 05:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604238; cv=fail; b=bi+SnPxnG7dQewxphMDYkFtySWkA6JTD6BdFKLbuZuabqKPf7VQVJct6lhajOWx0uB3vVcd/EvS7abFB/r9Dh07TLQJbnvzgA4LfYEYWfeLOKcbK6sL1nYkUWGVDvFTaXyKonUCwVtwBn7jzQ75M5Wq2EF3u1N1z6LPee+XNZIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604238; c=relaxed/simple;
	bh=oZMmjYLHNuTF7WJbt9PZJKcPOn15sIqngRWndXWj6XM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9vrNCb+gxFQrHwhIzSdwQOAv0o4wXpP8awYfmaNvNu86QEwGKRdRzNALHDWj2DzHWJSZQaVVuviKy/e33goM5aklWat+QRd70JUMYs533J2oTHqPDyDz1BSQhByPyr7Q7g+Mg88Osmq6Y2aLLh2RG9qKTMT+jYbdeFP7OQptEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zn3UGlvn; arc=fail smtp.client-ip=52.101.62.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xh1xSz/Dm2+sYysJJooWgBYDA+dQJDyUUIKMcojLdFjrl28IYKD4NnprAR03QT2tmfhF31WEGKk774ZWIXEh5DWCkDwEsbquMrqYphsPNXDwhasA/xQuFuAU2bVDPFOgaT6Gdxnf1glBbG9zq0h8adra9F+0sw+X4LW3psEPaDOu9p1vu/vAzY2LVkS1sKlGF/4RUv7ss9UqllsiCihWtUZ1VWW2DJ6K5raqWmwu2Ym7TTYehlxizsqpGwKRw6UKBQHTY8eeZftqQuAnOE/B7coR96axNf2ixmIWrcyimhrl5EZCiFLFeB9Fl8fZz1ps0c6Coc7eY3JtKBz/oPUSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWQm7MM0g4gyxYiUW//6l6eGc/FVBp1S8fCKd1LcCYU=;
 b=cWGD7SIayrg2qqpx0Ex1kfLdz0WKqua86pedYbmjXtyV5DZTFqRwzwENvKjfLUquNev2NCKH/B/BtbiuaCuB2NufF0Wr9bh2ismOwPbT19iB7sM1GWdjLSd+glBO+TLmjIBnqQcV3Ag7/Dj3l1k6eSPZrVKCQKN6p7M+IC0DSSEfznfH61tzGMiCWtWfcNWpwq1/9STyKSa04iKyo4KteYwphwCmkyODTwxTBoOix6BpE0QXmjh8BMtlrAc3bGCBCplR5eM4QgtSNKJpPGENglSoGEIN3YvmB9PpejpcY14En5DIxltm84hFuWTevKuU9tqcC5fwfx94kqTxYI7u2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWQm7MM0g4gyxYiUW//6l6eGc/FVBp1S8fCKd1LcCYU=;
 b=Zn3UGlvnO7p2U2xHmrEZoidM3Mp7FJfrVFCuceqaWrNDkW6G/2OfL9gOSF3jpH67BtgJ5/tox0aSl/JaylzUZpv3mxcMOxosqudrvUr4lmGx6axv9KgVW0SqXykLSHT7aZpE7jq7X3XnNbrOvN9LL2wnVYC63HQO6usxyhRuLgQ=
Received: from CH0PR03CA0379.namprd03.prod.outlook.com (2603:10b6:610:119::6)
 by CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 05:10:30 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::dc) by CH0PR03CA0379.outlook.office365.com
 (2603:10b6:610:119::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Tue,
 23 Sep 2025 05:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:10:30 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:10:25 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 02/35] Add arch specific additional guest pages
Date: Tue, 23 Sep 2025 10:39:09 +0530
Message-ID: <20250923050942.206116-3-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|CY5PR12MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 0381224c-6ae7-4e4c-e4b5-08ddfa5f8468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jPPTD3PVEZcSRuY4su3Xn/FwuBI9CQT5eLHWREYK8GNhdT93wihHq8jZCSXs?=
 =?us-ascii?Q?V1IWxvpSTz27yPEpaYmTPDeFC99LY0HsALZJQGAtVTbUwYZHEe/0i/kAugE3?=
 =?us-ascii?Q?zr4J8jQVpphP/cq5V3JP8Njdf3UpdgMbU81kpMkrmUahz0ONTiSnC/tS483G?=
 =?us-ascii?Q?1hSzszQHTJsTdW+vwlKy0qT/ko93/J7XW0inP27EHJUwXsgPX8dDmuX8E9n/?=
 =?us-ascii?Q?EASTrVhqS30VCZiRr/XWG9wxTvRdBFXYzDLjlfGZTNnip6TahE6+VFhe3K0o?=
 =?us-ascii?Q?LbhtazQ77Uj1A6l1C0moNRoO7FFaHb5E083sUrrt/1rgZWTABZC2/2xDL7Kc?=
 =?us-ascii?Q?tu46YPNKTDTaOb1c2Ssnd7D/g1kXmZ/eziamElWZf6OdFncaZzlIgSz78SHa?=
 =?us-ascii?Q?oHX2jM1Qnta+BXowcNsF6u9hhCvWHvWJEHmXIjtUBnqMROJ9Y5LYOLVMABge?=
 =?us-ascii?Q?pUPRRB5dTumDyeqkNlOMM4hvZn6AlHIa/LwUhkOzI815cScZGuy9P9iMAgSV?=
 =?us-ascii?Q?exMKJu4Dd4wuS1V4yHqZCjjkPqtxHzn4Xe4gwAvlGDVkgnw4A6jpm/IUFThV?=
 =?us-ascii?Q?F1IrOq7MrPUIoKIxVBZmpKvjcim5kYVY6GELB3mYH9fphzTp+Ru0+vkFUDpg?=
 =?us-ascii?Q?q+NY3q2NgAFBHThcGha4csEAir2vs3zI1Ue4zl2TaMz7xHZtvvFv+uQAHvC+?=
 =?us-ascii?Q?SISP1/p+3+GzBi9+UyYbe4LJnD4BlffPnZclsa2/eI2jP2OnkbrO6IU3ln9r?=
 =?us-ascii?Q?zEOsEJCrsMbe8gmONJ3QACuwMkaw37qE/Z12NrUhdlhMdssvVPRpdNpvvPJX?=
 =?us-ascii?Q?ePPlvLyjCfiaLPdJK6Fy1uuXuwBlKe+5RNTJr4ZTwA3p2tbereWUfXZp9pZ7?=
 =?us-ascii?Q?FWROx5O4Oda5IAf7KceLd453YizsmdbllUKx/Y0QyW7COTg/wgA5BKQCldLC?=
 =?us-ascii?Q?MUc0qvRbjBfyLckfXpMgrsPo58qv0wD5AXslYkze6HQmxpsD05FTRcHtHLSz?=
 =?us-ascii?Q?OK4j1XiqFaKJ6N6T8SEZqjKzXYkCARllcaC9nSRds1BKL8Jouq8H/caoFAai?=
 =?us-ascii?Q?hZPejrooMQmQIUVdpD9A/ri1S6P+MGtb3fc2obYOLqzGY0ixdI7tD6PEaOeS?=
 =?us-ascii?Q?AhL4e1hSZhFvJ7Y62InK9KxWNwUsOVkyKQKjcdWB7yrG9AUfCp7vk3v73TJ0?=
 =?us-ascii?Q?tblWTRm09rquFswR6ZHkETte69EYczfb2TRMbKCYXjiGT5ZAV8rqnQ75a/Wh?=
 =?us-ascii?Q?0K4iIx72tW0qqPcMAH1W3cBJB6eKci10N5cWzDsmLM1HgU+7JlNuDKiQv6qk?=
 =?us-ascii?Q?NKdXm5qeY68Ea3HV+5A0Cmu3h3X2VD0ci532OZ+kwBjT54MJoHrbqaZkU/O5?=
 =?us-ascii?Q?qboryIZ9VDLBAnPji7tBpf24GhBzyMcIEbRaWmGPTHtbxFUwcAeIxVJOea3W?=
 =?us-ascii?Q?PcZk5pwlOl6iQu3+pv2sWZFSo7XYpi7f7SdyORIB5fbU8R5Fh88+GoSONGgN?=
 =?us-ascii?Q?jZbZ6Z9lOWfzoyKw22dfu3wYn9iYYOi2pjzy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:10:30.6245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0381224c-6ae7-4e4c-e4b5-08ddfa5f8468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6155

From: Peter Gonda <pgonda@google.com>

SEV-ES guests need additional pages allocated for their GHCBs. Add arch
specific function definition with __weak to allow for overriding for X86
specific SEV-ES functionality.

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
 tools/testing/selftests/kvm/include/kvm_util.h |  2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c     | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 23a506d7eca3..1a9764658eb9 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -268,6 +268,8 @@ int get_kvm_param_integer(const char *param);
 int get_kvm_intel_param_integer(const char *param);
 int get_kvm_amd_param_integer(const char *param);
 
+int kvm_arch_vm_additional_pages_required(struct vm_shape shape,
+                                         uint64_t page_size);
 unsigned int kvm_check_cap(long cap);
 
 static inline bool kvm_has_cap(long cap)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index c3f5142b0a54..a3b16793b2fd 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -391,11 +391,11 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 	return vm;
 }
 
-static uint64_t vm_nr_pages_required(enum vm_guest_mode mode,
+static uint64_t vm_nr_pages_required(struct vm_shape shape,
 				     uint32_t nr_runnable_vcpus,
 				     uint64_t extra_mem_pages)
 {
-	uint64_t page_size = vm_guest_mode_params[mode].page_size;
+	uint64_t page_size = vm_guest_mode_params[shape.mode].page_size;
 	uint64_t nr_pages;
 
 	TEST_ASSERT(nr_runnable_vcpus,
@@ -427,7 +427,9 @@ static uint64_t vm_nr_pages_required(enum vm_guest_mode mode,
 	/* Account for the number of pages needed by ucall. */
 	nr_pages += ucall_nr_pages_required(page_size);
 
-	return vm_adjust_num_guest_pages(mode, nr_pages);
+	nr_pages += kvm_arch_vm_additional_pages_required(shape, page_size);
+
+	return vm_adjust_num_guest_pages(shape.mode, nr_pages);
 }
 
 void kvm_set_files_rlimit(uint32_t nr_vcpus)
@@ -474,7 +476,7 @@ static bool is_guest_memfd_required(struct vm_shape shape)
 struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 			   uint64_t nr_extra_pages)
 {
-	uint64_t nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
+	uint64_t nr_pages = vm_nr_pages_required(shape, nr_runnable_vcpus,
 						 nr_extra_pages);
 	struct userspace_mem_region *slot0;
 	struct kvm_vm *vm;
@@ -2334,6 +2336,12 @@ __weak void kvm_arch_vm_post_create(struct kvm_vm *vm)
 {
 }
 
+__weak int kvm_arch_vm_additional_pages_required(struct vm_shape shape,
+						 uint64_t page_size)
+{
+	return 0;
+}
+
 __weak void kvm_selftest_arch_init(void)
 {
 }
-- 
2.34.1


