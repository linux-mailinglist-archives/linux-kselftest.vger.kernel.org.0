Return-Path: <linux-kselftest+bounces-27844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5324AA49569
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35303BE4C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A05C2566E4;
	Fri, 28 Feb 2025 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P6WvydyI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D12566E9;
	Fri, 28 Feb 2025 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735327; cv=fail; b=LUHpFjCwA/GSVToNEjD5QCQMh2G9BWxRNiTupoQMEOSwN3Pq3xHxFDaI1CyI6e60Fg4WQP5YR0wREqWp/DGFooO20C2A2SHp6wRibcJT6npg8G7Lukz+gIWbBkSxAp+/GRyFjHMIX4HpGwSPNwNP1VMe2+hJOpRgt5H3aXFrilw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735327; c=relaxed/simple;
	bh=mkw6Z+nGXo6t6/FyAF/ekhErovGBtEvbwSXbHXIsa3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKcLLn8TZAgTyjPIcUd3tD1rB6E/in/8kI208h/l1ZOrSBQObdQwvLNd6pF6DRSLsMVuldG9oIsWSqyirIZGAIJfrBAAcMO9LAQLyM/+++06WZwKc7LNB4aeieE/HV8nTudPuN1SWciFDxMzCTjJcOOATNb3sXpmFl+9S42RCVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P6WvydyI; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qt9EOQ4wLjoY7sPY7vjkN50ChzFltOdlG1fs4+X1NP2afxUternXH755hf88PT0tek55yBaPI/LO11A4572YZdAAE+PuXQ4NKG1ecHsu/QSVIV5UuJJRXFfTIqWE3vnCdcu190BtI+Yn3ixBAsc9zoMHKw17AXV43pk8HPWWJRv1HrQMx+tVeQR7HcKzkeq293A6cIEth1wu6V1mD+y7/FONXtuv8s9hXtgJPN12nAD3k6O07jtjrrnem0r2vVAn52ruVFKZNjteuwHNd4XtMy2WQQ8WQ85KMXC3rX8zUEPjFd7W5IxVAojq4TORGG1JCMG5DtjeOLFUoTZ5OTzvbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfD52t+ryIKiGqrGdIY1uLkWAKDW4XSnV+R1JK8tWME=;
 b=cLccWcwnS7ZnmrfaI5JkgcEiGHltGeO606CAew9l79xIl9PALYWJhuhtGEsekSR1WVw37qXwuk9iXOR6uIeLVnUn3bE0wBZcAQzEu43bv7SEJ9ilnuXnjjCC29Guv2nrFuKK242ingxtCYgYPdMwTe7Cvs3BLtIdSW1qlkMa2E3UFmZDmvZEqmplo0JZzX+eMhDFNn1Xs/9qZ7KBcPFkhtn5aFb+cEUvY2YWmWcQAW1ViJF/+z8jAjf18vyN5ua/hCIjXlavxNs0PxA+YqUqIPPtikjtv0XSgWhNh5bekJLMfdbhZemhexYhRMRh+r0p32zC58m/VzIfSDy0OWCHnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfD52t+ryIKiGqrGdIY1uLkWAKDW4XSnV+R1JK8tWME=;
 b=P6WvydyIyJALgwxLk/G/viqaP14qDIlQsBmY5rPqHbpZZNDKjl96zvL3FsWPOLTYDrwxUJQ3dA2GY6oeTkdcuduSfOyCKz3xr2vIso18rAhXyKQMd0FVCyPS7GA85wUhMukSnRSGVKUgYSNR3d1uJeWREaSPsuafjCu2gbAXS8A=
Received: from MW4P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::31)
 by BL3PR12MB6620.namprd12.prod.outlook.com (2603:10b6:208:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 09:35:19 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::cf) by MW4P221CA0026.outlook.office365.com
 (2603:10b6:303:8b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 09:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:35:18 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:33:50 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 02/31] Add arch specific additional guest pages
Date: Fri, 28 Feb 2025 14:59:55 +0530
Message-ID: <20250228093024.114983-3-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|BL3PR12MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d254352-7c80-4bdd-38c8-08dd57db36d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gqM3HNAWsZjohe00e36hDNOdsiL7u8GTObyC5t4sGWcho/4FEBPIYC1oGAp7?=
 =?us-ascii?Q?EvPRljUIdRV0gEv+yh8e6Wc4FZPt30wbZuBHsqBpU7PklLSoREZTTrgaDIaC?=
 =?us-ascii?Q?RdS2LXfeh97rqvr0wYxEqYo5L7pZY/yEVhYAnRqd70svJowteuls62RVbpZk?=
 =?us-ascii?Q?lJFHlIV9lOZlJXGW9JQ9ibZDDoWuvwEaElUNsvas9tG4yVWcrWKvOPx2IHfL?=
 =?us-ascii?Q?Yi1GWR5BMwu+vYq9Rd18xurfuqkD4wfoZ8OCEr5XnrXPc7Ap6tukLzJKXR4e?=
 =?us-ascii?Q?VHyf6w5xFXR9fthED5JLKE6mJNC/PUqXEkyAzpeiNaDRFUOXHSu50EQ5RdlD?=
 =?us-ascii?Q?j6HJSlnvOf+nm9ZlzUNCQGmFXrz7J9Tu/xFs5fn1QB1tGflor0UEAqGrdSRy?=
 =?us-ascii?Q?nA5JL5JQSOXcuwQfeyqxQGW9/o1BHpipQuu5gOgiTeJ50Iq7R60RhuKwtv9V?=
 =?us-ascii?Q?iAI5TDma/8tIJsAQyokwr5U5taBhTmjA3rEHa2l4pJU1x5FlJY6O8kaUmaMl?=
 =?us-ascii?Q?m1XjuPaNozS8wNmRcg5VobVPYdpgHII2ovz9Jzb7Mvx8gReuWP3nZzarFtUw?=
 =?us-ascii?Q?7a7b6Gp7YL3hCGE17L1kWMXbLDVB0t2BMGgRmqHewaDd4fU0YzIziXHRz6fx?=
 =?us-ascii?Q?RSbiIwN619cXl+VpG+kv/+Q23IoanMoZw/9ILq9SbnqBEMHZfAHCHsc62M0g?=
 =?us-ascii?Q?mmBfd7WW9ot8X8TxOXVYRq1/ESlFQkSCdKs/pURYzsNQlZBjjGlaDB5yHl+Y?=
 =?us-ascii?Q?BD+/Uve2zmanwiAjKpkgDMenzhaMJ1p2zBtH/OZwdLFHwDvjTl/0zMyjwIff?=
 =?us-ascii?Q?VcBiyoyCm0c8QVaXFzPoBC9mphftIU8ehoNOOpBp4NM/qIDOJl2hjohvxNlI?=
 =?us-ascii?Q?f1NyRfoQBNbvjOhQtqLl/Lekus7+rTA0or6ulYPxAJggIIyS+0rti1ygcj+5?=
 =?us-ascii?Q?VBjNrm2RATj2obHWMjMJo/B9A3jDA2wwOWPdss9uBXZxD8frFaWm6ta+z0WY?=
 =?us-ascii?Q?ZI2pjuZA/cc59PH1MK9kki31MKAqOdJgWIt+uUkhj9v7uQZ8UMynMhmDUxer?=
 =?us-ascii?Q?g8P0pzhXuczWovp2dpP9AGPOjSf6LwjTQzNtrvZ/7HiqFDtIiH8OJg0txMgD?=
 =?us-ascii?Q?1WcgCdlFq8MzQxwn3kbOL88Oi7g2VBPsXNCF8d9etUa4hT697+O7eq/lA6lE?=
 =?us-ascii?Q?Qyc6ETD7A3XmJL4BV50olI8tCKpO2zBvztqc+LGquPrcqDCSxPva7STOo+wY?=
 =?us-ascii?Q?a89oL/DLMdk7/bIgyQPZGM7xr0oeoD4yp/jHh6BNtHq86rAlKuKv1u5wRDUn?=
 =?us-ascii?Q?5Q79DkgJcEaPKhfuh4wi0gf6c/In3vYqcFtmN7A/D0ZC1YKMeIK08b5o/F+q?=
 =?us-ascii?Q?bxB9qT0PxYHOyXVAPal/xW3p1Yvqls3z+fZc6QgYTp/jiKoDoVj4wpP+PGr3?=
 =?us-ascii?Q?4obvzBfqB13oYgJcuBCMYuDfMIoviETdNqUaFZDcpZhS/ipAyQHaLq+7VvdX?=
 =?us-ascii?Q?XwBJ8VoAjSxUDwY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:35:18.4248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d254352-7c80-4bdd-38c8-08dd57db36d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6620

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
index 4c4e5a847f67..b621a0f1907e 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -254,6 +254,8 @@ int get_kvm_param_integer(const char *param);
 int get_kvm_intel_param_integer(const char *param);
 int get_kvm_amd_param_integer(const char *param);
 
+int kvm_arch_vm_additional_pages_required(struct vm_shape shape,
+                                         uint64_t page_size);
 unsigned int kvm_check_cap(long cap);
 
 static inline bool kvm_has_cap(long cap)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 089488e2eaf6..18a44d8220ef 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -367,11 +367,11 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
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
@@ -403,13 +403,15 @@ static uint64_t vm_nr_pages_required(enum vm_guest_mode mode,
 	/* Account for the number of pages needed by ucall. */
 	nr_pages += ucall_nr_pages_required(page_size);
 
-	return vm_adjust_num_guest_pages(mode, nr_pages);
+	nr_pages += kvm_arch_vm_additional_pages_required(shape, page_size);
+
+	return vm_adjust_num_guest_pages(shape.mode, nr_pages);
 }
 
 struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 			   uint64_t nr_extra_pages)
 {
-	uint64_t nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
+	uint64_t nr_pages = vm_nr_pages_required(shape, nr_runnable_vcpus,
 						 nr_extra_pages);
 	struct userspace_mem_region *slot0;
 	struct kvm_vm *vm;
@@ -2247,6 +2249,12 @@ __weak void kvm_arch_vm_post_create(struct kvm_vm *vm)
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


