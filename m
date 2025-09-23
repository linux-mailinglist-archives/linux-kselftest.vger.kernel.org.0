Return-Path: <linux-kselftest+bounces-42098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B48B94503
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949D516509A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F3030E836;
	Tue, 23 Sep 2025 05:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lQ/WdCUk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA38530DED5;
	Tue, 23 Sep 2025 05:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604323; cv=fail; b=NDdylelKkKe6ZkoOhNtmF7a2Z0oc+LW5U9NvkuJf+qjAASf+Q6JurcltrewYk1BfjBYajnXIsBR8qnNB3Vg9XG5sD1MtkrzPtftuc+E4ggf1a7hyaO2UPLzbvRqFXsP9TH/0H1TTtxlWyhzrFJY3rJ3azS4R0/xjt1ltbgu/8bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604323; c=relaxed/simple;
	bh=C1Khm0C3bR1DE+moHfVnUrfokMrMB1fYJLnHVxLuBrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9/Hl8zSoZibxnqokQ5euiE2NrJnG+7oPY0ygOwiOS80ZuAEBiA1F+9iFUru7WNYd9ScJQcQN4oiYqZ/8vsyZqoBS1Rka+CBktO4Dkju+0dI80sBEdAERqhJeNPH+jOX/BeMmL1u97mi/aA+XN/tgIv0SuhNtSAv4Lv8HcCBgC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lQ/WdCUk; arc=fail smtp.client-ip=52.101.46.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7Eb3VNhsxnDjP5IjSmSJCbzdWulB2bZWO+nT3Ndh3nSeEnlzh6oJS9C2QN92e6mwU3mpSthzJJAuf3jPCxekvK7MLkz/xQiAfjCFEpjh0W8F91qhLzxJDh1LkIDNVJSXnTu2+ltI2HFQzwBstq3PtYehDWEnl02wEFAVmLRDLC7v68VYvNCB5hsJmSsrRTVpyWvuSSmsldA7xiWEhdDBU0pgkOUJPP7GWLS1O0tdMv+TN3fWx52HZe4iIT0+DWCHAMTcrUCbDfT3kvP3KvloPtJtIV5wBZKAjCo0Wyjh+nEvmVFwA/QkLSW/rggXHcRizuECqQQHVZ3vYktMqB7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpFWPMuftoxWXqI51yHcFjtR93PwDYTYiBSZGhlGlI0=;
 b=tjrrFdiujWRxjtKCDquiJZ+hmrQYZcEuP1cCcFEaJ27kgcQHt7g1mb9qMnYeDG1s/Wysx80cgEDQ0vsWes0F0Kx7nOtSQtiCuIjTFIa7qQMfixdgpYyib+R67hyeHTTqqQIJZvQuTt3EhBTDK8FNtBDdp5+KTzvZjvcD2XtkCLaC/3zVS459nTdZFjP9gM6dCH50sNDsL4aQqEGI0E40M4Y1ukRl8cBz2hJDdMkMDiSI5myN/k8JbGD66PteN/qSh9h0pFrnGRc19Gev5Gy1afwdQlufoujpEPtq3PgfnLYJ7y+qLDT6oIle1yhINOgyUPatBr8QUUVJVNg4TiDFTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpFWPMuftoxWXqI51yHcFjtR93PwDYTYiBSZGhlGlI0=;
 b=lQ/WdCUkseM/npe0SB3ABAlKP3bplYrgVWmWREX0lNB2Mltir3ZnxZIz/TYMDsXYW/nR776UhUGY/oQTLNL/Ht6XlFzLwASMPCv0nG2hmZObTOamfuF8tuufcc8NNfpBtbYGj0Ij8/M64JTEVFXoOZ15jdNNTok+KY7tvTAyxxA=
Received: from CH2PR12CA0025.namprd12.prod.outlook.com (2603:10b6:610:57::35)
 by LV5PR12MB9753.namprd12.prod.outlook.com (2603:10b6:408:2b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 05:11:59 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::38) by CH2PR12CA0025.outlook.office365.com
 (2603:10b6:610:57::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:11:59 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:11:54 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 07/35] KVM: selftests: Return an unused GHCB from the pool
Date: Tue, 23 Sep 2025 10:39:14 +0530
Message-ID: <20250923050942.206116-8-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|LV5PR12MB9753:EE_
X-MS-Office365-Filtering-Correlation-Id: eba7be5b-7e4f-4cff-c5de-08ddfa5fb930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GBev2MwGhsZavlmLGSCSdIFUsgq4RhV2GsBqlke6dUBJ2SKaosM/utbY3WeD?=
 =?us-ascii?Q?9MIBqubOqzXHoKsFzhvAqOr9Gwpm0QAT4Kz3Ic7EAlYcys0tyyKId9w3RsHz?=
 =?us-ascii?Q?RF/qsTpr0gdDP60M2Z0b99yvSY29Zx2+io4S9bJD/VFpUONlYXy5gyVmuv2u?=
 =?us-ascii?Q?5j21DQRMwoMN947ZjLbCDlM2LFjNtu7RmmyDb9vp4KC/bRpJ1BydJFnPIEvB?=
 =?us-ascii?Q?5fjXLyyxKjNQyNtU20OSQnMfr6kFrpnCp43pfJ/irl/14v9m8Yg+P05oJ2fq?=
 =?us-ascii?Q?ZxVXzR52JVA4z+IfimQUDcv98ZjovyVizntRodkAzdp+cct4Z/VCzNcLu/ko?=
 =?us-ascii?Q?AA69I0QaozntiG9PoljmMfvi9gAN3O0eYRKnI6H0aEEVFLWmI8k8WTFeUH2g?=
 =?us-ascii?Q?5NHPKuEVgkkiIqAEJZ+neknvNPDdiAMfqNHNj6lQXs9tTbtb6HadxH2R2XrH?=
 =?us-ascii?Q?izRDyH29wN9AuAeK3SK3CjQ12VJ1MhUJz/0SwtnqyjN1LTv5QuHNtNJUkFHo?=
 =?us-ascii?Q?xCeBdbGujJJXm/1XCSUH22gnQYQi9yDDzADDpTmmcOgoLuxeDAQg7R2VRvYk?=
 =?us-ascii?Q?8WSigHuWNAO5WzVVyLBlZlBpgK3X+8iU/fCU/zbixc0b1QXle4z4ODWRnER8?=
 =?us-ascii?Q?tFJSiT0vHiGCpa8/Wrd3rEjFUu5vc1tlWyPUjFL3TajqxQEYZd9JnDFUWuxj?=
 =?us-ascii?Q?P2UnSkRXzJgSKZVMKtfSnRWPAzQIFJzf0Ff/SEDHp2Lx3HH3ydEl8ww1zfdi?=
 =?us-ascii?Q?OMrYbSMlVSjQf9eGAoUk6a5dp1ZHSVo11sE64T/Laa8+vhEaCiF3yX+Sy9qL?=
 =?us-ascii?Q?2aCrXf/VGThoFLVcsrOxE18xH42pTe7rKgicy8NSP6cR/giINVrjhEcMgOUv?=
 =?us-ascii?Q?W1+u4OEtSChEUB3hpTZaAk0hLyylF6rtggJuZm6Q9mjgBC5YDJOENFwBJjnY?=
 =?us-ascii?Q?t0OFkABb7XZsDTEBeU6pnNQQvyyg4lIZhzEfo4wSNV+J+l3bnIIoz5MD+nLi?=
 =?us-ascii?Q?RIXAgfahHEDNKHrBpX284hE/1FZ/URSjUBu/i9ARZZyDGaiGz2Wlm/KzGka6?=
 =?us-ascii?Q?zTQE1ZiSIDiBXn7Y7aX7rs56e/YPSIBeleLQUwMJhjSq+zQEYsj7OMM7sxec?=
 =?us-ascii?Q?qZRG1yF/jdB74Mn5tiIG4zzuVenTxQaRh80z5cxIXS1Gt479SpOVapwBsXXS?=
 =?us-ascii?Q?CEDcqAhQzRlQTpq8Hee+gtAk6y3idlyuPS/fclvHwGkqDZ/+Y4bVAJoW7nPp?=
 =?us-ascii?Q?ds5XwIEgqy3Pii2kIi4ctFv4oq7OumIT9jKI9ZWmRIkeaEBd4wtA4iztlk5q?=
 =?us-ascii?Q?7nswyI7EdcrdnvLL0x4/oTMkslMAard2D264x2MRD7zm81HI58taO4NSqKQT?=
 =?us-ascii?Q?YDkLb0r6fmxd2UdrpkWwpfSVcY8m4WN7BceU+JHp02FFBg4vpBD8duHr9aRE?=
 =?us-ascii?Q?c713c4+bPJnmsm1/cfCv6tPfUtqJ9NcBHnDHmbzu7mKCg307x/19l+wBEU1c?=
 =?us-ascii?Q?OvSgjccjzPv73i90VHjbCGWsL4IvbZYfwgeN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:11:59.1753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eba7be5b-7e4f-4cff-c5de-08ddfa5fb930
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9753

The ghcb_alloc() function in the SEV selftest library always returned
the first GHCB from the pool, regardless of whether it was already in
use. In a multi-vCPU test, this causes all vCPUs to share and corrupt
the same GHCB, leading to unpredictable test failures.

Modify ghcb_alloc() to iterate through the pool and return the first
entry that is not currently marked as in_use. Mark the selected entry
as in use before returning it to prevent other vCPUs from allocating it.

Additionally, correct a minor bug in the memset call which was
incorrectly taking the address of the ghcb pointer instead of using
the pointer value itself.

This ensures that each vCPU in a test gets its own unique GHCB, allowing
multi-threaded SEV-ES tests to run correctly.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/lib/x86/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index de36a6c93839..3090a6518066 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -68,7 +68,6 @@ static void sev_es_terminate(void)
 
 static struct ghcb_entry *ghcb_alloc(void)
 {
-	return &ghcb_pool->ghcbs[0];
 	struct ghcb_entry *entry;
 	struct ghcb *ghcb;
 	int i;
@@ -81,7 +80,7 @@ static struct ghcb_entry *ghcb_alloc(void)
 			entry = &ghcb_pool->ghcbs[i];
 			ghcb = &entry->ghcb;
 
-			memset(&ghcb, 0, sizeof(*ghcb));
+			memset(ghcb, 0, sizeof(*ghcb));
 			ghcb->ghcb_usage = 0;
 			ghcb->protocol_version = 1;
 
-- 
2.34.1


