Return-Path: <linux-kselftest+bounces-2906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6748282BD11
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 10:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53A31F22527
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 09:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60C357865;
	Fri, 12 Jan 2024 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Iaef2Im1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B2356B9A;
	Fri, 12 Jan 2024 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSr0qTE+mGD3l68XQPc/FdFFuao1qLNptcAibk5i0xHjd8BazIWLaHOekL8BkBdx/TnsCuHIzsgZXKXK5+iecciJ5/xgAMQa/Sc4Z7EjyJfNi51So+BLgFd3kIsE/HFULTUGaiHdRmN3OVJaUjpgpjdq3DhgIs2hUA/msd/WvkV73cbYvZbird9uXrPlVI12uU3226Od4E5YH0/WjGDiIRRkBTLOpw3tCaTKCOtQkyELkdXc1kgcQvQoz+gjMINF+uGCqjLwZGCfSLwXxW9yB3qR+o3haeEBUo8gQJXdRIUtQUpXEQKqF+jQRXiz33R7csSzFSsqNNDOG9K9oMcfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlSxPWdyV/EtEqLn7HLp6u5EkidVnG0biRkzCBeMMkc=;
 b=I3W6VZytydGQLT6QlIGoenPF55mGLiZEnWM6wsVzPmQwXaK0A/2u5BA7NiN1E+0h2juLTeYo8s/l25aIPWDNW+9Dws8y0xFJwMH78LpW1Zo855XNRfp1gECMCY9gA0hHYNf1aD2RwRqvkJnpxCc+v1GQyMaSGjof+8Eu9Jhw1iK0CdOduRITqwOgZ5TQY0M95XbUUdN+uvVgCQtT0JsuimEfyDrHKHBRpoSclV2bAFU/GvVpyCFm75is/ZAjTpWzKsI1Vi3MKQJngU82xRWibfoU+/Vrnv3+h2+44d+xLn6HENVVb8LPO0bGDps3FD2rttKITwm75UXTfowv5IbHRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlSxPWdyV/EtEqLn7HLp6u5EkidVnG0biRkzCBeMMkc=;
 b=Iaef2Im17u2sKqHKkUTXth6U6153w3kF4KDTeuUJwxAkzIjjq3woORAFBVhQBbLVMS0jLL9Oi9MbK/eGECTmpI+qbz6TL4sDoB7sGzCrcq2uxA08lijo0lWGhcN14Nw0TlPWf0mC7hSAofrSVv9iAPow2W+Q341dYDNTgf53gbk=
Received: from DM6PR03CA0016.namprd03.prod.outlook.com (2603:10b6:5:40::29) by
 DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.21; Fri, 12 Jan 2024 09:25:56 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::33) by DM6PR03CA0016.outlook.office365.com
 (2603:10b6:5:40::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21 via Frontend
 Transport; Fri, 12 Jan 2024 09:25:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 09:25:56 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 03:25:51 -0600
From: Meng Li <li.meng@amd.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Borislav Petkov
	<bpetkov@amd.com>, Huang Rui <ray.huang@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-acpi@vger.kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>, <linux-kselftest@vger.kernel.org>, "Nathan
 Fontenot" <nathan.fontenot@amd.com>, Deepak Sharma <deepak.sharma@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Shimmer Huang <shimmer.huang@amd.com>, "Perry
 Yuan" <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>, Viresh Kumar
	<viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, "Oleksandr
 Natalenko" <oleksandr@natalenko.name>, Meng Li <li.meng@amd.com>, Perry Yuan
	<perry.yuan@amd.com>
Subject: [PATCH V13 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
Date: Fri, 12 Jan 2024 17:25:25 +0800
Message-ID: <20240112092531.789841-2-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112092531.789841-1-li.meng@amd.com>
References: <20240112092531.789841-1-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|DM6PR12MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: f75cd735-1aa6-43a2-c5b6-08dc13507b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bDODV6dgr+tgI+rOXPYLix7b2ZWEVZ8PEXqb2/v3g2KHtYyNegiVaEcEJz6zdmi+m+Sjddq62L1JekE71zRBKdblVjABAmB5n0AyVKijjlIwj0T2KK5fAS033OBG17ihX400+H5V/AuexXEMqAfikSj8dylXC+a/+idDX1zIA/ecO/nBSOtDsOKAj3ctwFvvujSVfxPP/p28mUh+ksPYQmhhw/I9zXWfo18BwHLdFzhDBkUrx7KIS24v7iWX22zh+lK+lFHx8IA6JsFmLMnmsl4XV7zjwmGaeJM4EkTbQkcnzMIc2vc9sqZ6Ts/TWC70gZ9M4i+HegN1aV0ELLvb6XzHInQ42rgWEbNVdYT50k3xHb1sakHu5FhTQ6YgzKTSJiZfFTF3ZdZ5AWOOGq7UJ9o+dDVR2Z7YmtXbRLoUNw4WUdtZIqw3H+IZmxENZU3I9E8551qxdrC+4RSAXn8JaZOs8d9htr4SXWmEy4rnlk8OzCjfjhsVQtkAoxQ6BX34utXB9ID69wZiRHEohhRrZovkMj/Tdr/rzdoR5lFhcmrtVNqm/4fuM0jfIz/91O5DWIv5Kp1xeYbgg1zZnL3sSPIesn9gOwRnNBR+/d3KvuHyN4HezBmXUVGbW+OvmgT1//Za/roh+jIUPugzPc81fYJWiM2V2FHWJIptpO7L5X2LS/LhDOTk6WkcotrfUQjWb61H8IZPuOP+O6ZORpHYfk284CuvOYtbL3TOXkfmFpwSrKgvaskFVblofOaAELKAYFiz2wQBcAffmgz9/mCWIw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(426003)(16526019)(336012)(86362001)(83380400001)(41300700001)(6666004)(7696005)(478600001)(2616005)(1076003)(26005)(6636002)(47076005)(4326008)(40480700001)(82740400003)(36756003)(70586007)(70206006)(8936002)(8676002)(54906003)(110136005)(316002)(81166007)(40460700003)(7416002)(2906002)(4744005)(356005)(5660300002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 09:25:56.2191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f75cd735-1aa6-43a2-c5b6-08dc13507b13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203

amd-pstate driver also uses SCHED_MC_PRIO, so decouple the requirement
of CPU_SUP_INTEL from the dependencies to allow compilation in kernels
without Intel CPU support.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1566748f16c4..4fd69cd4241a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1054,8 +1054,9 @@ config SCHED_MC
 
 config SCHED_MC_PRIO
 	bool "CPU core priorities scheduler support"
-	depends on SCHED_MC && CPU_SUP_INTEL
-	select X86_INTEL_PSTATE
+	depends on SCHED_MC
+	select X86_INTEL_PSTATE if CPU_SUP_INTEL
+	select X86_AMD_PSTATE if CPU_SUP_AMD && ACPI
 	select CPU_FREQ
 	default y
 	help
-- 
2.34.1


