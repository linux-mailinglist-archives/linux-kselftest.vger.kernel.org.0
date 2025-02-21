Return-Path: <linux-kselftest+bounces-27229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEB5A4019D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 22:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B15188FA82
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 21:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EB7253B58;
	Fri, 21 Feb 2025 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zF/9tXdF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91D4253F2C;
	Fri, 21 Feb 2025 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171807; cv=fail; b=jabf8dP5m8iSBV3EXNJia9+Kec0KmUY1jO5rGIRvgR0ERSyq04iXuYqmS754NkhsY4HY4xNlSDxXNYI2iWBiRdMpRNQH4sn3yBCnIlxwMHD9jb6X0m6K7TGPJGlZrMyNnfIDBLV5jHHBfQMXOynKPpWvA1WN41DyVLAjXvk/VKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171807; c=relaxed/simple;
	bh=LlmjOTmb72wI+vr1JpTIOaU46ZLxDTHGtYfc/Bc6UlI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qkc4ktg8Qio+RLaih3xNkzq6dN7eUxp62Z7rvp9kJlgJzMomkYiaJEQ21odDq7qGrIh/yIQbn7DSjW51wYNjg1frtY8N98kos108QaEYqqjzSGpyYkqLQqx2GLsyQHhQye1RcM6djNRpWdJ6ms8fDFzI1Hn3H32Gm8DYuxfPFmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zF/9tXdF; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByDLhJcTYcArn7fVSWGxSOkYC9njzIciVRIpPDJl4Y9fB1EaDC1oCk4UZ3d1Hb7igSqVPycA99hR1fpoBCfz0ToUf66Ec/+UwaYIqqwIHK0IgYauCk8M0UIgB6wxb0PSm8KXwgwNhM/KJ0IfJqoooLDv5uDGsoPcZuTJXBJYvudYAL9xMaqa5MCzu010SmNT/5K+rRs30GrBErB52xKg+4cp5YnmfttZZka45VrkHWleHd3KsJMCg7gYTCVZ9Ek8hdMarpesVacurueIx5x/3Ctg2ARG7Hg0OUZckW6Ta5MmmPEDWtaOLWaQx5zfU4Y00HScAmExdMioYHBKXo1Glg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kk7O7rhB0qVXJqicRah8m1LCrb+2Mq19YudIWYPJZQk=;
 b=KQpDJWs12g5gni0DsFK7lGQ+LeOqMO2ak5SSrqJtxEuyWZ9o7cSJGah+lyrWXgwgtw/d+0WPqbKdYAtpmHLX618zLXSimx40uSn8sw7gDzcfa7TzxXOOlNngmU0pWL2bt9orJCnF0X8kQzQN4bCoAxc/mPjzQ0fyrSiT2yI9xJg79j3RErlQZYvTF2j+qm4hrGkh87tZiym3cRVqlfQgYN87/29P/Sa38gPDO4WZlUkeJ1Yu5wYmAzVYKULKNFVZ/mVJmObn4lntQy0CUSPbMAPsI0EjdO9VNnesrDSVUrGnZW7MkNJRiffcDiWmAdnBjvD4yjwa59mACUYEc20hoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk7O7rhB0qVXJqicRah8m1LCrb+2Mq19YudIWYPJZQk=;
 b=zF/9tXdFA+9Z9uc7YZgcE9d+Q9XGCBNDY77/cdKeWLm53iltEqQnak688Kh9hX6FO+hvbVkmI0nBH75uI+oZlSe8P+KekqD5E1KeAZVrM7+HRzRCMxUeHM04uWnFdBNrSr8SjFAxwNb7jUvPYRnl4lMq0IVOK/D2feHho9S/xPc=
Received: from BN9PR03CA0865.namprd03.prod.outlook.com (2603:10b6:408:13d::30)
 by PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 21:03:21 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::5e) by BN9PR03CA0865.outlook.office365.com
 (2603:10b6:408:13d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 21:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 21:03:20 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 15:03:18 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v7 05/10] KVM: selftests: Replace assert() with TEST_ASSERT_EQ()
Date: Fri, 21 Feb 2025 15:01:55 -0600
Message-ID: <20250221210200.244405-6-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221210200.244405-1-prsampat@amd.com>
References: <20250221210200.244405-1-prsampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|PH7PR12MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: d39ba906-f35e-4ef1-36e5-08dd52bb2c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nMq2bxl3KRSm6WxFD1z6FVDT2nt0s5QhrY6GM8iQXZW9+sP6oACDoyZNRBbZ?=
 =?us-ascii?Q?YYwhLknA71JNWIoRP/s1Vy+xAc6zUdfc+UC4bIYeWSrQ0nQdiuRGuR0DoHp/?=
 =?us-ascii?Q?Hbc0A+BHt1kMzuhNu96Dp2eMGZeofvbb25vxN5DGP9aaak5brs9DHd6iC17e?=
 =?us-ascii?Q?og9X6DMwACNsqsQ0+v/nWJmHpDBNT6Ux+lI8d6AVbbRYwpkd7BEv21lFipgj?=
 =?us-ascii?Q?ylppTXGuc8NnNGPTXkioC2fN8mUOIbepZxHjwT7ediG6z8adqIVPCfw49mNi?=
 =?us-ascii?Q?yDPRl9z17EwuAkVjYFZVJlSm8DQlrdQXfk5wTNt1QvhzBSGkE1sGfAhThYgu?=
 =?us-ascii?Q?RG7WgBFVvq+EBH9ve/ZQn5eaPwDZx7JRAB3wnnRotvyfdF4Y8XuAaqLN0lih?=
 =?us-ascii?Q?veCecLimlNvJCPhKxVlUGRgOgb0SxEd4kaVBZkEOq88T+AUiDbMPZN9e+U68?=
 =?us-ascii?Q?cyaJA2BM/EZOX1lBMLWCXtxU6FxE8o6SE/WbmlmV7ZzsRz135jJNiFrxwTl7?=
 =?us-ascii?Q?j8i/bNzF5VOtpkeUEH7JNwpHCwnnmKMsnVRwZg7x0325pMIZ0XxVW8tafjfX?=
 =?us-ascii?Q?CBHjz3uFz3uzZKOqI8trTYSApM55iqrWS9lgmtlB2yE48xVHxa6y63j4GOBQ?=
 =?us-ascii?Q?Bfrgvah7Pqr+R6AUQyeaOAgEbatctLsordo8Czsse/zUAXT6osYWq3Pqevfg?=
 =?us-ascii?Q?e8QmZ+wWofll9sWqO2lMXDTYqdBe3oWJI6plImfioZZB4LLkU/D5WQMLxuDo?=
 =?us-ascii?Q?V6UxZycUgGPM2E8sy3+4l0aZCt4/RvQ05W6d26SbVg/NoRTgrcnfervCFwAY?=
 =?us-ascii?Q?ZKg/0+V9q6pfIOaBYHXBeqsvpGWpLVB6eAeYUJWi191iwjbaV/r0781jVrmC?=
 =?us-ascii?Q?e0PN4KXIvG0MHuILONe+Lkj8vz8fT+sDvnbfIdRu1S6TrDysVM8nay0Kcz34?=
 =?us-ascii?Q?BL0ZMQs+8UxUJKQKbrS3aC5+XEOi4QpmrevzB4kGRkX6ih65h9/77e0b6SgG?=
 =?us-ascii?Q?+Z8QJd4okj6/q0P27RiXleCuTlSI/rh6CZxbBu2L1LWpif2dG8sPrCiOQBu+?=
 =?us-ascii?Q?F4vYFkRufh90EuA9DyVKH5YV7hKy5nqj0UpGSX/vSugudxuJYMz01hB66ka0?=
 =?us-ascii?Q?P7a9o+lYNVO+WGl8PcDmqGOpGl7lxncVEkCl2n67fujLqXlshqNgt9B3aDCq?=
 =?us-ascii?Q?0giXawzgHyL/ZJ5P1+SOiRUn4AmFOryge1p0HJn6PcOMRkCOtAbq92ievKip?=
 =?us-ascii?Q?9yQNRjZ04jiGk/IVXb2sw1sauvCLJuvBlba3ZP3iofx8PWvmTZryPc2kwKNS?=
 =?us-ascii?Q?CCxRfTc6jwIOu1tC9X2bgcPjgkyAY5ffLNQrTeL3tyc1tTRhTERDkjsWCAwg?=
 =?us-ascii?Q?xMZCh3Zqtdi71x4/eGwDNglZi9FIN2SmurIvEemjgmN6Pl/mseKxUcSGBiV7?=
 =?us-ascii?Q?kz9r2Mw/3fxUo0M6MwWjpujULZ4EHZndVXRRhDE/swLpT3GhXkbdBi8BzFNC?=
 =?us-ascii?Q?1r2GRafhtDJYiq8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:03:20.7253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d39ba906-f35e-4ef1-36e5-08dd52bb2c0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9174

For SEV tests, assert() failures on VM type or fd do not provide
sufficient error reporting. Replace assert() with TEST_ASSERT_EQ() to
obtain more detailed information on the assertion condition failure,
including the call stack.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v6..v7:

* New - Replace older instances of assert with TEST_ASSERT for richer
  error reporing
---
 tools/testing/selftests/kvm/lib/x86/sev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index e9535ee20b7f..60d7a03dc1c2 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -37,12 +37,12 @@ static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *regio
 void sev_vm_init(struct kvm_vm *vm)
 {
 	if (vm->type == KVM_X86_DEFAULT_VM) {
-		assert(vm->arch.sev_fd == -1);
+		TEST_ASSERT_EQ(vm->arch.sev_fd, -1);
 		vm->arch.sev_fd = open_sev_dev_path_or_exit();
 		vm_sev_ioctl(vm, KVM_SEV_INIT, NULL);
 	} else {
 		struct kvm_sev_init init = { 0 };
-		assert(vm->type == KVM_X86_SEV_VM);
+		TEST_ASSERT_EQ(vm->type, KVM_X86_SEV_VM);
 		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
 	}
 }
@@ -50,12 +50,12 @@ void sev_vm_init(struct kvm_vm *vm)
 void sev_es_vm_init(struct kvm_vm *vm)
 {
 	if (vm->type == KVM_X86_DEFAULT_VM) {
-		assert(vm->arch.sev_fd == -1);
+		TEST_ASSERT_EQ(vm->arch.sev_fd, -1);
 		vm->arch.sev_fd = open_sev_dev_path_or_exit();
 		vm_sev_ioctl(vm, KVM_SEV_ES_INIT, NULL);
 	} else {
 		struct kvm_sev_init init = { 0 };
-		assert(vm->type == KVM_X86_SEV_ES_VM);
+		TEST_ASSERT_EQ(vm->type, KVM_X86_SEV_ES_VM);
 		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
 	}
 }
-- 
2.43.0


