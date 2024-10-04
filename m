Return-Path: <linux-kselftest+bounces-19006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC95698FD0F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 07:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1521BB223D4
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 05:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B075C126C1C;
	Fri,  4 Oct 2024 05:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wMaeVq/2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC4A4E1CA;
	Fri,  4 Oct 2024 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728020050; cv=fail; b=jRSVqIp9z7Pqt6tJxkuuse8cQeLX+OCnwxwTGQLIxJrBRwk/AH4hNqhPG+Ry0O0XTNUFGfFSe/q/iZIibAhZ6ps9HDrw+eAAvzK6Nb7z0argBQcQUOeys6qf3gcNhiWFebDpaJBTfD7g6uEfn4jo6WLlJdkDouFbsvtoTehSg9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728020050; c=relaxed/simple;
	bh=OswI/hEF8eFzEhj0t5ju8ib/RdAClRd9j48wGTeArCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMds6wZX6lgR6Q7FdKa69eqaq7oPKGe9qrjujaFCS/LDSNlrtTrYdYa3lyzHOc2N+AxhPBIaVtVZrDUmJAjnRmLKCFTW8xmq3FUiuU42TU1U94onzZgm8lNC/BE3C1tigvn78lL3WEeDEvGvRvLCoHIZM5QAarcHUJowO/VlNtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wMaeVq/2; arc=fail smtp.client-ip=40.107.100.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbzEGMnVgea45/LmXbRG5W74Ldvmvr9Q57iyjtnIdd1waa5gG7rTfDtuVFBXBVeOuiq1Ubl9zT4zfcR1wPq+/cRyzbsmi4MDbjJEu8lZr4RBPStV+CLikWUp0Ui2gzZlsJnEFNphuOuWMlnAWtpOjQjiIXCzR4hwLugYIWUXPMnYieUVchnlr6UXsps4mGqsVtJa35gT/zkzNpteazSVhSVZPQT1B6T9TxUJ2X1hWh6gjN+EOVYLgWSJA3DoAVZ2SsbA7sIbtZmNqCUmskoXk9qW6maU8olYE4x0VgU3Wx6dkfTVeiJlMo6bRCUYU79UjanEbGPz7qKsVYuJXjo16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/Lm0mCfn1GVpAXQ4WMcHLi7/LD9RQcYLhewAIPAPX8=;
 b=PJdtjtqc3QcyzaG8RG8M1oe8K34/va8xAoDiBm6OtEQXWxB6UCHLoi9czlX4V2iaDuYnE0AyDTKH5H0x+dpxPoA/wYaMnmt8gl8i3shY2E2cAZsl1iQBclMIuN/TrqlwbarpQr3/DEhsB6P4xP+iDhBxphI/jJRIW0/4l8/koKCg0cXTdmyDa+xQhk91WU0ILEBtw2VToKesqEAbEAtF3E26n/wxA6GQikslkyRNm1tjAFXxSFr5GV8OQ/Mot83WgZTTf8Dm+8T4D7PbPM799UZ1nPeMSqR1A6/phjqc0A/Exv+kzaHnQGgLluaeHkcY/ZlDSE83igEhbqk8sKRZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/Lm0mCfn1GVpAXQ4WMcHLi7/LD9RQcYLhewAIPAPX8=;
 b=wMaeVq/2yjjlnCnQsl3SKPLBALxvBrpr+xlvyoAqT2xAMsRnWNE2klMyp8tBwU2gBauKth5i6PqLucWBPlAe+a9O659a1wuU8T6pYcLoG9/LS3ToAQMEredccY579cU3wJ2XWk6c7ZU2vHDeIGozrH/kpLEA8Y7whGXnofbOUP0=
Received: from BN8PR04CA0019.namprd04.prod.outlook.com (2603:10b6:408:70::32)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 05:34:05 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::d0) by BN8PR04CA0019.outlook.office365.com
 (2603:10b6:408:70::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Fri, 4 Oct 2024 05:34:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 05:34:04 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 00:34:01 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [PATCH v3 3/4] KVM: X86: Add documentation about behavioral difference for KVM_EXIT_BUS_LOCK
Date: Fri, 4 Oct 2024 05:33:40 +0000
Message-ID: <20241004053341.5726-4-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004053341.5726-1-manali.shukla@amd.com>
References: <20241004053341.5726-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: 55aa22ec-0f07-402f-56ea-08dce4362918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KnEruY5VZxr5iDAFpeo4PNrKKFtllSI4EjZ7mIaDUMfwhdcwj1IwSpftrG2L?=
 =?us-ascii?Q?B8gwdotMizJqrtZA3LesiVH9YOMVzdCCwYMui+qyTBx6WxmFkt55MK/nkC2o?=
 =?us-ascii?Q?jaFL1imXlagiivCn5clYycgGmf7+gExcHLZnljZHZDONpMACTAKGey6je5i5?=
 =?us-ascii?Q?kg6/CQzjEClOiNnrxUBybbkmIDhZHkYmngy8bf1lsO0anvTT1npoI8vFxy9Q?=
 =?us-ascii?Q?HGC/BGraThmpFQsR8Yu9cojQ1ItKOUG8AoWkkNUfYORyzu4WLB8BTTyhxJAR?=
 =?us-ascii?Q?/nwW3JDoBxcug+MqBFH1VfnrbaIOiAO6ONTf6n3nDDZBQDe8h32xrNM9oy2W?=
 =?us-ascii?Q?C2vwWtYadF12gJ1WSFS8xETEEIoKoLtCImpzLOi+EfupE+I8JrRzYujWgP/L?=
 =?us-ascii?Q?PIImEXFJyMJLe9AkLpD/ZbG85vrW0WgghSR+FspGMOD3FPHE2mjSd2VJDvUz?=
 =?us-ascii?Q?ZRcuWa0VU0pgsdJL4ww/+rmeIdvi36WBSzfFttbWGC7kA/SaSVRcFLFXuT2p?=
 =?us-ascii?Q?cTL7Jk9DemYS5Z40/v2LFSJrWnB7U35Cjy/+mQMQfkZ8EczoKwHHQper9+AH?=
 =?us-ascii?Q?DXNBKX5afGNM152lzzCQN/wLi1jEBNWd71PKIlioGkURbnRdiidCQEVwn2kQ?=
 =?us-ascii?Q?Xh/Wj2o634keaBBf85Z4dizYGuKtl+vLLbDVRlFM4ocyh+aXWjGuGqNfIZys?=
 =?us-ascii?Q?EJmdp3s7k7PTiv6+iEjkP++VjxdpvlmSDhPPQN/G4XaYrCJNZh6gR+fo3G1c?=
 =?us-ascii?Q?UBxRGnu4HHrQnHxrIOtQwI/AaCmun2o7W8DqWi1BQTz9q5SmMTywPZQKKISC?=
 =?us-ascii?Q?ARWCFNWDbiNozZVq5Xp2ATZ10I7ugEDlORqgJZL5tLbrVpdneUlm3Ik1ZXH2?=
 =?us-ascii?Q?TG2RotC1tLcQ2u0q48Vw6qI25awE0HJU452cBYnBC2ztmnwOfWk4cZLgLb6Z?=
 =?us-ascii?Q?IUGVafs5YSvMLcEm+8cAonHMtcHvXlWf4cLjAMTjjHF/EDitqP5CUN2mNbJ9?=
 =?us-ascii?Q?AX+PYoQCk8rr6sYM9NeNJ/Z24lO59YdE7vRzNMlM7+l5NCpYJlCQmVkET6Mv?=
 =?us-ascii?Q?IpfgMaCTJ1UJwp44KiKcIeyQ18jIEsR9tGb8p6nRUczSvuJ/KFIb51DqBOQQ?=
 =?us-ascii?Q?4BduJuKnBW7Ynrj0/umEwuM8EODlFvUIDghxtbeqz67oSVbxRNXcpoLGaKpK?=
 =?us-ascii?Q?/WKUwD5ByuN/OY+A2uxa2/20lkFoYkRs0nlVcDaDuOHKq7cu1zY7LA6mWvQ/?=
 =?us-ascii?Q?OoNgYPOuAQZ55UB4vnWgpEneUSzMCZa1vMRQhe0P3yGVDzy8kuc1u5wu9w3Z?=
 =?us-ascii?Q?nTK5Aby4r1hnEZI3umomy6DBaGB3gy71sgzdleI2l0ua1kD8Mw0UZ+6jaWPG?=
 =?us-ascii?Q?CgJhgEzEAa0Z60Fb8CKwR/FqW+Qu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 05:34:04.7970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55aa22ec-0f07-402f-56ea-08dce4362918
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051

Add a note about behavioral difference for KVM_EXIT_X86_BUS_LOCK
between AMD CPUs and Intel CPUs in KVM_CAP_X86_BUS_LOCK_EXIT
capability documentation.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 Documentation/virt/kvm/api.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e32471977d0a..49465323dc62 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7884,6 +7884,10 @@ Note! Detected bus locks may be coincident with other exits to userspace, i.e.
 KVM_RUN_X86_BUS_LOCK should be checked regardless of the primary exit reason if
 userspace wants to take action on all detected bus locks.
 
+Note! On AMD CPUs, the bus lock exit to user space occurs with RIP pointing at
+the offending instruction. In contrast, on Intel CPUs, the RIP points to the
+instruction right after the guilty one after the bus lock exit to user space.
+
 7.23 KVM_CAP_PPC_DAWR1
 ----------------------
 
-- 
2.34.1


