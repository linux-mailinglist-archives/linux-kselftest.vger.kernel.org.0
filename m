Return-Path: <linux-kselftest+bounces-27849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE259A4958D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F2C1630C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBEA25291D;
	Fri, 28 Feb 2025 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JAt+m8WX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C6D1EBFE0;
	Fri, 28 Feb 2025 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735702; cv=fail; b=Sc+JeiVV7dbdeQ4c1YFdLVbrsVwbXD9H1vGbrFidctT7dCHXhUlGNd/jDHAuVL6AcqeKE/Mti9B58TKqsskL1vbWcQnypwLQUMj/2Lh/tugKhQuoezfT4yrkyofVqksJvlzeHliiIRvDXaROSdlhUVCs9hlFKh0YjwqdOOFOmng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735702; c=relaxed/simple;
	bh=l1GrBEV12A92csOWVniOKLDuy79SOKz7IJYOEKyV/hU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bn2M5VIaanKZ4Rp89/oyrVGnTWxcIjLta2p3LeJBCs10XtObAnqcXRXItkMLAa+/DGkzefAwM9gTvgQAM8S3gPRKrDCHovWa3EUZbunidlHdEvRrKTp4nmGca9J1elDBmQzTGpztSl/Gl41wUFcphMgNMZRN43qnohrl7VUFKGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JAt+m8WX; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTfEp6yWN6G+Sd8jnH37TRwFE2z+bDFxuHYAFFtCGH7Vx0XdYFD2Aydiu4tTypxq0c2KSohjiEpvqmGGZZAlmul6xxeALZ8A7STOzdBEmysCPwS4nFeF12qOUr6pZ7hLAGzbmJMac4xov+0371iFspHHyLp182ITUcBY0EldITbB00yCRlYMgvVJv8ZjCU4WpozE92CXOoV/9gK6pUUelnZSbop5j8JKqevkimmd30ul7kDBzRnM1Kao+3nyS5EzfVAHOtQLgJZRWui3opvaPkf7UuHpRGQwI+tLsp4MGJBrDFlyC9S27Aw/cJk1/FGtGFb3JIlCqf5iDjg0rwlV5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEd0SS0r4OkSqGLl0Eh5JJ+3hY+Wt1rzWTN57dvfdus=;
 b=eQOGQH5Tnk5vpEwRE/XEEggyFO3q6HogqrrkGvzrOWUj1Hlpam1troWbBgkRml7yRKjn64B98xaGPGZRAeaknYtj6DmbsbqhJJNj70lDRmlXv/nksBzuPiF2jUCHDt3zKh8UGU6EEScO6L69iGVK1W5D3oVks+Ad89Vo9NU5g+1PnszDUW3AASYVJU0Ok9qgo3JvwDR7Oppg9reLpgmPi2NmJbzfd8zDzdrWBrTA0g0N/wNKRVCZX6+NLXzae0eCN82A8wI6ImkmGso0TTBHnPksU9JZ3RnmMy5DXq1N7pOjwZFNDkJNc07U4kfD8t1wGCI3polvfkAgw/LGObzj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEd0SS0r4OkSqGLl0Eh5JJ+3hY+Wt1rzWTN57dvfdus=;
 b=JAt+m8WX+r1Myk1th4Eb5zWvCZSk2FxqSksxoBooprlZVmSKknwXJAEUyQbfo1epZYDCm0psHxKmiSoazsVB9A5riqogrZFq0+mX05JubD8I9SXTf5xQVyKriCTJ97VK/2BKjUIaBXSSJhb9nzzXhD+mkynKJQY59fzDXBoug4k=
Received: from DM6PR06CA0080.namprd06.prod.outlook.com (2603:10b6:5:336::13)
 by PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 09:41:35 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::b4) by DM6PR06CA0080.outlook.office365.com
 (2603:10b6:5:336::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.22 via Frontend Transport; Fri,
 28 Feb 2025 09:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:41:35 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:40:38 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 07/31] KVM: selftests: Fix ghcb_entry returned in ghcb_alloc()
Date: Fri, 28 Feb 2025 15:00:00 +0530
Message-ID: <20250228093024.114983-8-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 2195acca-6dad-4f26-b3ae-08dd57dc17b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UeUrh0Yyh2s+i+9Z2EWhbJlLGkeOug/O/m4XG16FngI1Oe93FTRoAeKMXxzp?=
 =?us-ascii?Q?eP7hmikz+8PJEw49BWSeI7t10H8tXPN+j+sDSU+zqFX3VP6+guCyxbx/x96P?=
 =?us-ascii?Q?CWRs9ukmxIQpxR8D85P520gU7B3hHgKYik2JM7hSnUv/TCGPgfjT4debv43r?=
 =?us-ascii?Q?UF2AnzV+XY46MvyrKNw84LCjlegMN3qCr8630fSnkhywNjtJNiUk7nheCkNv?=
 =?us-ascii?Q?ZTDdisQZaBcBTTYepFqXInmt4a5l5gL4NT6IWRENBOqSG6L1NeJMgcDJG1ZY?=
 =?us-ascii?Q?JiOO9H3kaY0X2LEHHmDNzIEIr1Uyow4cH6UfaV2W93jH+Nh770iRoG1B7g+/?=
 =?us-ascii?Q?d8fbxmj0eWfHf/ZxtMOkjMSs2eo0Sk+1++1tZsftl3Td9NHgIL86QyRzsv3s?=
 =?us-ascii?Q?vcm1WtqkyTfvItioZTZ4MtVtdS9xCjkXEtvxWQl0d4ZkhegWyozRW9bM9eZa?=
 =?us-ascii?Q?BoTmCPb+InSR3mk+QWH1wRWQ4DxXq13wKNjW3TTLP8UOHcgiAaNCsaJhjCdh?=
 =?us-ascii?Q?hE567pjAUkmptV7w9ucwMqVxI2Mpt9zUgWqOVuXduoZtXCSEfF5cgT++tIYf?=
 =?us-ascii?Q?4xdJu45kgNsf+fyGS3Uimf0oCCOMkAcLwazK2WvhsCFfnW3o3yGPoyAATKBv?=
 =?us-ascii?Q?aD20ATLxgtFeRxYqHLKObQO20kkNdStJsr4kXmQpK96ce7W2BjHyMEQR/vDN?=
 =?us-ascii?Q?wUJLZKE9r9uD8XiVRJYfFBkFaBnQmsPIXQlNw/JIkNvAkG4u9eSjASiPLWIf?=
 =?us-ascii?Q?weSWynWxLDNW0TQ0VgYuzBWRzetwuwU0NqioocAOh9+8Ud8NectPHWi0t8zd?=
 =?us-ascii?Q?znlzuEJ9pwZXVDgtoD5V/tcsJ1ndufUtBI3gRo+O9893hmBflmOOGRBBnfkv?=
 =?us-ascii?Q?JOeiLFZyjMFlTeKRlrFY6gkQq4VK3AaRuqj07RqMYHxbdbNIhw1FZZ3P14P4?=
 =?us-ascii?Q?A3rEdl19W9nVFvibI4QJgpEwUbr09LYecaQiB5pZK9d8slc+dcL7pffXYaoR?=
 =?us-ascii?Q?33kwJFgOt+FcyRAWp3X0oCFKQxUjX/rmei+L0JVWMPPGJGHLzhL3nO9u7Zfq?=
 =?us-ascii?Q?Y6fZhslZThenOZU7zv1s76OHOEPOcTqmuJj6dU9NbAOHLp9Pmrp8ShTj5Zdi?=
 =?us-ascii?Q?czWVzoWrKiba2FcVVVFsKdHHm11TwozAV+mDE8ua/pbILZG27R3XBRrtq/zo?=
 =?us-ascii?Q?ums2btrmxVT1zsam6Z0wt1CuLYNzvliAwOrcMyCXZY15o0b8jWoSza9mECSR?=
 =?us-ascii?Q?uHd/lDT6GrHA4LS17zW1S1Cie11++xFXIw8EZaHDEsqqi2GaYYX5uMFU4Ome?=
 =?us-ascii?Q?FUoXmaKY/gZ18yT7uLvuZy97mliZMH8vdFdWTencmxd7iKJOCl7F3XjL2lfP?=
 =?us-ascii?Q?MA6KmfCqF6qGpmHMV3gMt04oOiksIIinMRdwaGcTTnWNJMEXUWf6oVP9ellq?=
 =?us-ascii?Q?AaumyVEbhqB08dnIV9TySd1TtY52Dsulpvq8ruXQkKOl8zPYcayWO+8Szmvt?=
 =?us-ascii?Q?jBjXQRLt81+47J4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:41:35.7418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2195acca-6dad-4f26-b3ae-08dd57dc17b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123

Currently, ghcb_alloc() always returns first entry. Fix
it to return an unused entry.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/lib/x86/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 425ec8a3a3c7..228c446072a8 100644
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


