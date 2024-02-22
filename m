Return-Path: <linux-kselftest+bounces-5316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26E48604E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 22:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A02287CE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 21:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D013F12D1F8;
	Thu, 22 Feb 2024 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hQmXQk1j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE373F3F;
	Thu, 22 Feb 2024 21:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637773; cv=fail; b=Lrb7cuf+xKaQyJYKWdR29MlvxDmaZsTOM1JrF9pdncREXnnJsaakicoDzXooa+FMOworU85SbuemZkA/e2Ga2INzQzVEdaiNaID/lzSmAGSuaPNG7at3z7QstnOkh0Qpz6LN6ux+nk2plDgP219z3HzjSxH6W9dDTImxIFJ8PKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637773; c=relaxed/simple;
	bh=WHzPfkLmU1pX8pc7gX5AtwW8b+ThTUf2zFTzDo6yPyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfKuHK9Pg9lqY5R7PtveXK66xtXNm0IZ6aog3u5tvGEq2MqslCBOaKo0CUb/paRen2V0MzSyrUXP4Apl4yyJFRHuIlUg0n1VHoRsO6URP3IaInyufCb0lcvawwmsbU2pGI38cSCFsYZOxsyKUK1OHSW+THRl7yv+HIT3M2Jkh00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hQmXQk1j; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEbCho1h21o+EWvs2XSrvYbNn7kHXL8WEZBbc+zyoJnVweafxE3KFIjn1pWmQQPLwbcc5qGfdXybnlcgOsV+2Yfn6/jnWU/LKXtyc+2DIep9t2iaU98z3vIUf2okkN1bjtOWipjkWmBC0LG48ZdlSytHc00Gyxy0X9BQNPSOR/1A5jiSSjmAAJZ2pyW8yXf0rQnlQE9Hbzr1diXo0nWJyTdHHtKOb6AQ6y0ZG+wLcNCyvqyY+je4sNni9496lZ8w4dCfY25glFggmfjlmwoZQfs4+a/mk3RPMxsC6moX+AxBT14e88YA3FQCqhVOxPBHeOTpjePpYTo3RbzfzLGEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bq0AKnY5EmQ1Ouikp0DFJNwiBV4LxWGqaBTsFCeQnZI=;
 b=SgGctIWDs8fgELyqAPS0i5eTu4Au6bbWMomiV8N6z4xZl+xLs0Y+0AnweIiBaaTM9EgjYfq/JyE68tZXBeIpTckkWysK/AuJiPiP1yalb9NY06lO+Ds9nQtNBZfJ0SQ/r3v2QyvoL1WiLqm3ax8JDhklc6Sh/eb3bGlopFeNFGo2smAVMrGBXVl1oy03xoSF3yenYk2VAIaPXpkkaGYIRIxxnYM2QwkBGX6DmZnbEc7BpvV5x0bnDUxkxJ48VbhAnJWBOjbaN68kUHAN/kVaqZouy0oXc26pE55Ukz6CzLvuDq2QDNzPpBYCPkWe5J7/Gaq25DPMpMc/MRv6IxNTqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bq0AKnY5EmQ1Ouikp0DFJNwiBV4LxWGqaBTsFCeQnZI=;
 b=hQmXQk1jlTU3AxdiiQ0YKtt8ubdLlAWNiloEWaNTsCm6o3wc8+xIDbV6ZPJ2KaPTZcclBmn1SONrnSp9CeZPKd0YA7lwTOCzQH6hJOw5bviGrREE1OjNlCxUwlBCe7/B5K9qgHagAWOIs6FANgtKrT5V9g1O1x/S7MXGuJL9Bxs=
Received: from DM6PR03CA0040.namprd03.prod.outlook.com (2603:10b6:5:100::17)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 21:36:09 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:100:cafe::bf) by DM6PR03CA0040.outlook.office365.com
 (2603:10b6:5:100::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 21:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 21:36:09 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 15:36:08 -0600
From: Babu Moger <babu.moger@amd.com>
To: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <babu.moger@amd.com>,
	<maciej.wieczor-retman@intel.com>, <peternewman@google.com>,
	<eranian@google.com>
Subject: [PATCH 2/4] selftests/resctrl: Pass sysfs controller name of the vendor
Date: Thu, 22 Feb 2024 15:35:46 -0600
Message-ID: <c930171600117d7f32edb665cafb04b9feb5d344.1708637563.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708637563.git.babu.moger@amd.com>
References: <cover.1708637563.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bcf7164-deee-4392-a568-08dc33ee4890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ARcl+T9+XBpQzBKNWJuqDHIokNFVV3rrFIhZpmaV1or+F3BdH8wFIfof+pQbgN14F5CFI/xCondaJQXK1NTya/ebCkHzquMbAxUvowR7bc/7prPAtwLtwndEFn66ETW/nWEZ8xFSRKglFAGJIe+P1zcgSXbUJZCOH7qonlD4PAokwpEwLYUHDnm/npTQg+hrMp0eKfHWjfYEXBzYai5pOZyPEYCzjZAOvssy6UyglqZU/uAQh/RAKb2XOTVR6JzVeY4zfWrSDpm98jEiJhN+gYs5VbbqyIgEhRD6eOLhtWO4oIO3JtbPKBjAjJdNdOKNf46HMNIETpRPc5/rX/l0bynF7mbMKQDsP6Gjc+/+A0vce4z9Q8GddvXkxR4vbRu+l5z+82vtHsEZyAFeFVKsYAuII3ynaUpKTrqChTUkvRFTs0RqkjoPT9qWggbqZpoKBoatL8L2gFtV2wglu5SYBxp8r/u6potdIJFKXgOYtNyxqBiwlQuDisMD+LQv3mmLjrpCOASnzkFWNGw1INBgYq3gj2tffaPlwfuAcc2kMdjonMxlvmfvFAVYWXMNd7wamTWg4y4PqodFd50m28oz1uxtLM7YkQJJsFdH4k0s3LlhEPGD24iAehDA23EDD3Fd//RCESvjdI3G+DYlNT9G2sje1ALwWMHV2gBn8YkzBoU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 21:36:09.1658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcf7164-deee-4392-a568-08dc33ee4890
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625

Detect the vendor and pass the sysfs name for the vendor for searching
the controller information.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 52e23a8076d3..792116d3565f 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -224,14 +224,24 @@ static int get_number_of_mem_ctrls(void)
 {
 	char imc_dir[512], *temp;
 	unsigned int count = 0;
+	int ret, vendor, size;
 	struct dirent *ep;
-	int ret;
+	char *sysfs_name;
 	DIR *dp;
 
+	vendor = get_vendor();
+	if (vendor == ARCH_INTEL) {
+		sysfs_name = UNCORE_IMC;
+		size = sizeof(UNCORE_IMC);
+	} else {
+		perror("Unsupported Vendor!\n");
+		return -1;
+	}
+
 	dp = opendir(DYN_PMU_PATH);
 	if (dp) {
 		while ((ep = readdir(dp))) {
-			temp = strstr(ep->d_name, UNCORE_IMC);
+			temp = strstr(ep->d_name, sysfs_name);
 			if (!temp)
 				continue;
 
@@ -242,7 +252,7 @@ static int get_number_of_mem_ctrls(void)
 			 * well and hence the last underscore character in
 			 * uncore_imc'_' need not be counted.
 			 */
-			temp = temp + sizeof(UNCORE_IMC);
+			temp = temp + size;
 
 			/*
 			 * Some directories under "DYN_PMU_PATH" could have
-- 
2.34.1


