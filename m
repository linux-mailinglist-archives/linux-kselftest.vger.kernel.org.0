Return-Path: <linux-kselftest+bounces-6035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F71B8747B0
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 06:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD7F28641B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 05:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10D21BDD5;
	Thu,  7 Mar 2024 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UPuaXK/W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D11B962;
	Thu,  7 Mar 2024 05:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709790409; cv=fail; b=bBR0KtpkKLOjCkTLOE0+s5YNl4chpJE2Q2b4x+W3mmKQ4XjE5NIBm6cEfXDGBpXA7fP/eSrhWu4zODOyZhw7irPp7z3uLIad8N6r7WqBbOMlZI5UukDfcK3h3Qle0ZJc1F6tgfkCfXgsnBaNCNgVJbR9u/h/HBvqyps3goyXBkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709790409; c=relaxed/simple;
	bh=QA1T/a4GDevRSh+Ko2ZJQI8LBEgOmkcE3zNCQLfydS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OavppbzEd+44Y/mfYfWFQGNL10dPn42ijMY7JMad/NcYMwtfant8aRS2acQprTOsx8dMwtRV7mHEk865OGruVHoVWWQo/GIAFsAxh9GWbzHSiU5a9pP3KFOl5OCp1DslV82PDG8cuejfqQnkHJNIK9B2LMgszss8XWfbUnW3pDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UPuaXK/W; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilZ0fPFNtnylnJMMnxK5tRCwvtJ4jPBAfFq63dnMAFUQu/FTwSK5hQ0Asyh0nCXFp0HI4LVPAKgIdd5hOaqBKeJ+PPI67nFfWUXdMi5fxaTRqiRFXi0bc94QR+mv71ATjZ19xIwRlXYRJeZjr79vfHsuh+B0W6sv+fvhUc/Koijk4F19HNXBkehjTfowrTZWHUyuUb10S1zrDPT7KrRjmLcKBe27noTApaRuUfjbkmt4anePtONeDfzefow85Zyq5rjIajpZd2vgnbIigHydpmjjn/SMA6t8CQaPWL9Ldx5dlxynDhkASNtm/Y1Rr7pICzhTwVfHqsxTnS/91BxanQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArxB4ZnbKWp9hGNmxgUN+K+hDiwFOw2zIpWlXT2862E=;
 b=KI4Yz0+RYqGekPePQVm2nozGxZLM9bjSgl0ZXuC/tHowNdgpDH9kGqpCd8Ph89Epup/vHdrlN3SHaxWSmzceZF3zhj+sfcGZN7hJM6BBRuTc76ofWMMC48Z4Ri6SGl19Bi1vvi3KlFafb4gvt4AtQSfL6ZLW5HDcD5/41UVEKz994dZ6Z+fY0SklO/q306nI2x1ZH/LDHlQMgWSYjw2E5Pfd3qKe0GcFgfEJkL+XASkU2GPh6AMNjtfZUtQQrPXI91Zz7znmFIgJHIBlYf7jDt27gO+fIF8pRm7iYxvCrieWCBbsBgcAe/p6MQGJlxMmNaE5YJ/GSh4NOs7BLD3DuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArxB4ZnbKWp9hGNmxgUN+K+hDiwFOw2zIpWlXT2862E=;
 b=UPuaXK/Wscn7fVDdIO/QIeUwF6z/nXm+RAlbEV60uxRnARkIr+mAlDy7CRWoY3g2O2Jn1H1tTqyoljXVRsl2T30ne2u107Wvsr4SWX4MZkTttzHWQt09zzxXC8hm3Gk2fXckJf+1skvfdmRPkZD+0KgoQp2JCU0iPSqTuNs/I9w=
Received: from BL1P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::10)
 by IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 05:46:45 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::6e) by BL1P221CA0023.outlook.office365.com
 (2603:10b6:208:2c5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Thu, 7 Mar 2024 05:46:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 05:46:45 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 23:46:44 -0600
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<bp@alien8.de>, <manali.shukla@amd.com>
Subject: [PATCH v1 1/5] x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
Date: Thu, 7 Mar 2024 05:46:19 +0000
Message-ID: <20240307054623.13632-2-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307054623.13632-1-manali.shukla@amd.com>
References: <20240307054623.13632-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: f07ffec5-71a6-4721-efbe-08dc3e69f985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kA9XVHkAWatWCeIGH6izG8FHWmuQVjSPflK9BZkOCl9EmtN83AGgy4O9yx+BZiC8IGarXB3oLXreTX63uX5WADqccIyDSmfIdOGB/iJaifLgmPPJKwQVV4Dh9PjCC3x9yUgTlVhwZJKaznVOOuSkzK7Y6tjcq319jtPK4qEWSEwppq/7VS/d4tIPsooYTBeXDEx7sz5PwVYuecDLzeBO6lI1MQ+qZ25cjBtZVZ2Xywa9eJuo16RiauQHVi3Xqcd41TYLoILuzpFO8ywfrqt6fmCMEHImfstM5eIV/i1CWGSj3NJk+E5RVrhUt6UCn2FOCc8kCuuZixtE0GN2pi+PRjjFM4Bw2xORLhwk2OLv3zQOTVoDobLwcBsIu1/yuLqVKXVB7R2hN4XH27NARc73z/+vSooXj1KC4lQmYgBv8yiJu0vSkbLTAe6YELH4p6E4GG9/0FP7l2fL62jh90NLET6YVXDgpwIi74M/L2ZkRGMaLZfa4iswibkzFJIgyzub0JUi7qBsNAjyGQPEfGkJATq7vi9/QiU6SexkPv3lzpaqY7BE1JqfSjA4x1/YVcRlYa6CYu08VWGV7jYsVoUoFBV/dYUkUOWNpUDogo//wSSW/YCPCOitaVCBBm6qeeq73ILVBy6f5CctNnbpcB++3Gs+2EctbVvumUccQYHls0cPjaBRO09ijfB6qf9NkzAGaYtueUUnJPVMVppJjZNRgP/dX4YDTJO7kv5YdMKeg2YpJSmpVXavJ5dzTAnPpE1e
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 05:46:45.8091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f07ffec5-71a6-4721-efbe-08dc3e69f985
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613

From: Manali Shukla <Manali.Shukla@amd.com>

The Idle HLT Intercept feature allows for the HLT instruction
execution by a vCPU to be intercepted by the hypervisor only if there
are no pending events (V_INTR and V_NMI) for the vCPU. When the vCPU
is expected to service the pending events (V_INTR and V_NMI), the Idle
HLT intercept won’t trigger. The feature allows the hypervisor to
determine if the vCPU is idle and reduces wasteful VMEXITs.

Presence of the Idle HLT intercept feature for guests is indicated via
CPUID function 0x8000000A_EDX[30].

Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index fdf723b6f6d0..c312b0bfec6a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -379,6 +379,7 @@
 #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* Virtual SPEC_CTRL */
 #define X86_FEATURE_VNMI		(15*32+25) /* Virtual NMI */
 #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* "" SVME addr check */
+#define X86_FEATURE_IDLE_HLT		(15*32+30) /* "" IDLE HLT intercept */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */
 #define X86_FEATURE_AVX512VBMI		(16*32+ 1) /* AVX512 Vector Bit Manipulation instructions*/
-- 
2.34.1


