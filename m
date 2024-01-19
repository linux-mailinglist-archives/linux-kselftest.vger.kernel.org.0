Return-Path: <linux-kselftest+bounces-3228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F15083262B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 10:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408FE285BC3
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 09:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A413924B44;
	Fri, 19 Jan 2024 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0vROBerQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C5241EC;
	Fri, 19 Jan 2024 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705655134; cv=fail; b=tDAXa9yYfN/QVVU9L385AhlTsdZy2I7ia4ZdFCkzVMxJzajlZBnbI9U95KfbK2nFD2Wvg5LOQTs2oeQb9exsrRLU6LichvTEgYfy8JKUIM0mBA1JhDM6EPrCR0UUcUQG32WbCBD/QA/gdKBYgmX7w9dJIzqyVEYLaKQ2dtNMBD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705655134; c=relaxed/simple;
	bh=FRUCWSX6j8tUAkHTqWExsfpT7cMYeYO63lAZXzHl0Hk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uy2WFVn+4dWgIRhdV3A1QK84pN+BInqlf922Poy7HZNf0DvF1nTpyunHqT9HmgOm/91X1/LJmkhVTzaUZLu+JiCx7/zGu2Nf6uOtUDFi5v06Icv1lYVPXvmK7jhh4jAjRi8Uj+IuVhGEo43uAK/sbsAZXByHS5fMKiV87dOBKcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0vROBerQ; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEj2OHQxK3EoFvYiucrZhu8ImeSdbNZwjW1YAcWeVmUFsy5S8HNPBdC1y9vqDEDPkf47ht2f68dsiLoaf6/3FgLVImuZzPt50DMxLo9BVmebLVSkRhrm/sKTaRknDlBTdhVbtqZrNBWt83yNCOQ8rW6S4/bBmI1lTkhNB4GivhUpzEmS/Liq4riTsaVx8nK24EE/Iif55pdLCnve0Z1Ws6wKF8kKFhwLvFEHVLDu4Jsy66797v2FFtVWsoleTH0mdp+i1K0CtMleBgjegTn0bn51e3Xlta6PaJ66yiCn6CZ8egY6cHcnwoC1V25wmy1HVI4nh8cTFzcOU0deZ7UODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSqFMTEkCOMZm6HT70MWpGV+zzTDaQ8gVEZFevHfb40=;
 b=b3dgML0KQOKw8GxUTzXBoKqKoRSY/6xLqUcPAJATh8k1TO4WNb4SO40OvEBZQh71f+0/qrnPI0Bvvo4p3yrIuIIa7D4rtk0Mk1BZjP8cOby8j20ZekwKylatSc6LP75FtV0UEWqj4eGIETbr7RiBIfllkPZqlaT31/yK1uu+Ir2kKO7aMUk7c8OA66ZLE+2M914P5aqve0sOt4S1iyUHDchDVRFaaqEv5Lf4PjyY3Ddeq2r6DUBMsXOPWQEUGUL8T2PXb/mtXRaxS5cl29eHSdG1hv8eNjLLFe4D7P741tyFb7DVZCHPl9H/8CV0vI6hFEUeF9LGxTDSalsfUtzOtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSqFMTEkCOMZm6HT70MWpGV+zzTDaQ8gVEZFevHfb40=;
 b=0vROBerQ7JKDRCRzkTtMLw1IoxwViNCcPZNr6fQYqZWDOyf3XOm8abhkLjwlr90hCl4p9IacqXOv//aZtQvu0TvknE0mWXcNB2gK12RDLA97p1v15LDQUo2iLrEx7HTH+3iok6q5x0dEakYQ5JjFQMiNLAgrZGFOxPFr1F5GqBw=
Received: from MW4PR03CA0168.namprd03.prod.outlook.com (2603:10b6:303:8d::23)
 by MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 09:05:30 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:8d:cafe::a6) by MW4PR03CA0168.outlook.office365.com
 (2603:10b6:303:8d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 09:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Fri, 19 Jan 2024 09:05:30 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 03:05:25 -0600
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
Subject: [PATCH V14 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
Date: Fri, 19 Jan 2024 17:04:56 +0800
Message-ID: <20240119090502.3869695-2-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119090502.3869695-1-li.meng@amd.com>
References: <20240119090502.3869695-1-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 171783a8-7a05-4889-8925-08dc18cdc94f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZxVOgjyWi3QceCnr0k5TWyVy+Yxhdif14l9smgfpyGd4lYWx82HG4Gwnxky8s/+hmvn2xoN4S999IUyvd1g8f/8Wnrb5WhU9t9RP8O6raBKFWdsuOLQJ4Czoxmz/x8kBh4cPdKm00tw8IYVXCTDDL678G53mIENZOCyNP/4dZfgcrM4jpc+1zETAso+KF+1KaiNyIKufv1nPov/BlF8eev9rH5bdsEOEN3iEVuuZ9fj3RUH/qHwlHaGBjBBx82el0R2jTOfEIidX2Uaicip1VyLKqRrAmpjUWHIxcTRyOliqXuy1MyBws6E3yLMetuajTzqNHuMKKSkZJHEq1Jb7b1XOOR9UwAeUpDRIl1cWnbt/rEb1SX69SKSCU1mdujEOU4ZY/vbOLQowRRrdIA4KVyI2u8740uvvKVv6m9Wf8gpArmA5ZwPpXHtnFg0eA0ChmhbUfUGJX7qXBJMulof9c0KVM3EmcK2JdGz+Y8yC7O7KY3nAtPp/KAdgPpIq3KCjbgmNVn0KC26jplUkMlT7nn5Nv1v7ypjsWYQJ+Ph2oX7i9tKWlcrWoMhdqwkxokjmcvVd1A6QzC0h8YE3lPBRLuS9EjEinO8gFP3tFPxInflHBXuGHNOMhJr95og6eUZpAXeJxA6nMxqHGIizBiLTW01pDHyxLC1/hFERZA1e6ut5gfpz6i+t2FhEfOEeuVdnuKmqR/WQIhExvCQirbUQE7Ly9cqC4n2059QvNpxlUkVAjTw9g1SBUwmfoepVVKfZOW6qZpbUZrIsOZw0p3GenA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(36840700001)(40470700004)(46966006)(426003)(336012)(4326008)(83380400001)(8676002)(8936002)(7416002)(82740400003)(86362001)(41300700001)(81166007)(356005)(2906002)(36756003)(4744005)(36860700001)(47076005)(5660300002)(40460700003)(40480700001)(54906003)(316002)(6636002)(2616005)(110136005)(70206006)(70586007)(478600001)(7696005)(6666004)(26005)(16526019)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 09:05:30.3156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 171783a8-7a05-4889-8925-08dc18cdc94f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031

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
index 53f2e7797b1d..8dfb08ceb6ec 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1051,8 +1051,9 @@ config SCHED_MC
 
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


