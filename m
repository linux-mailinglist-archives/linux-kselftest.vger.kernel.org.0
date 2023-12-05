Return-Path: <linux-kselftest+bounces-1110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5296804A4B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 07:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616B4281673
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 06:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0167CDF4F;
	Tue,  5 Dec 2023 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sheI7+c7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB55E181;
	Mon,  4 Dec 2023 22:38:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiJ7AnFm95ia8TYf4hdS1yP4Pn2x8gxHU9c62DXBlgCJ88d98mCILgRpXzzHqjamqyJe0MxV64UUhG9KwozUihcE6tTu6nl3d/DK+7rPPgW07qgnxFMIzaTn1P640iZW4gXlmMiI26BU7Ey2OKJmQjwEUCD1ZwSnMp6mWLB1MhpZ9ELqT/Dn7S0m5ejdhtSypcdlyayIsIAbf6GfMR19xqCk7CAGmg9ly8wrc0Gy1XDIEDEWPCRPYRrqA47YrA57QFTKSivvAGWGqFnjnHzi1twxcFO/Vzo4kvSW5KXsrfZHU23D9/zlNGPtw8+OIWWMIodDKt9dPa5VcLx1ls1AbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0K3iglNj3vwJ20tywpL1THaFmailc2x+KGl5whUNK0c=;
 b=f2dudYM8lyEq2CZUE8lnVAGHQLee4nOAvjOF1Hlbk/cPzw1JnyOekFoNZDozNh5oU7VO1/2m4KmKCgmgkYr8y8UKvk0AIrVp5Y3441PsP1DypX2AhfU6jhmhzAC54+P+TT3fjWQwTeTfIk3P2gbSc0MaCPC+oRxS6lrb6GRiCQ+9Y9rUzKNUL1ssHG+8g7TrYwLQJ3UoOPw0CnJO2jDhQ4fEnW2zuGaANPA+/UX6i4vBm4m/cUOYUlCIsA42uoes3MT/o26hpYAWrY7YJ0huNVKnQoANEqEdiiEP2y6iicrWe+R0RVp7bPO42ISs7F/6gVIwmf8Tk/HTGPhLjHxE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K3iglNj3vwJ20tywpL1THaFmailc2x+KGl5whUNK0c=;
 b=sheI7+c7qono7o/yvLv645PWcCgzDl/F9lQUNZITbI710w3D67a7Y1KuOhGrtpdVrZY50h1IdsjfJ/C9QbRkXF2LPdlecbqLjnLfMdrR20+J2oe6XGrvp9wjCtWp9MDrCrJvAHYLrs+Fsd4Zcnt3GHMaTWCnvyttweqL07sVY0Q=
Received: from DM6PR04CA0029.namprd04.prod.outlook.com (2603:10b6:5:334::34)
 by SA1PR12MB8919.namprd12.prod.outlook.com (2603:10b6:806:38e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 06:37:55 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::b3) by DM6PR04CA0029.outlook.office365.com
 (2603:10b6:5:334::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Tue, 5 Dec 2023 06:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 06:37:55 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 00:37:33 -0600
From: Meng Li <li.meng@amd.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Huang Rui
	<ray.huang@amd.com>
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
Subject: [PATCH V12 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
Date: Tue, 5 Dec 2023 14:35:31 +0800
Message-ID: <20231205063537.872834-2-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205063537.872834-1-li.meng@amd.com>
References: <20231205063537.872834-1-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|SA1PR12MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec48524-b0cc-476d-19b6-08dbf55cb6df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+QlshRnKDpcyiMa/ucaHkXbOEsAMGfjSHPwSq71i4xP61Id45mqiRR0zXeTekEh4tqxiphng1SXPaOyOrmfm4bSfobkh31f3MjizDrOarsBDgJtzVzSoRo6EaCuHlmVuO29fP70MQgd+vtAmlPpmVRoAvQ4AfE1yKwwNHI/QdHly6YbcbV8Bqriqx/nY4+7gi5MYTj7r8imOYiQrZ13dnpso4ue/d85DdlJpWbya/YtVWVxUWIJgG4ekn+3nlHstUe3govakgaYyzUuYYhTr/qqJndG3Msht+tDu/wONBb0EMBf7l4qZvaB7YA9XijW/WQBpmbgnshkp9qpFfpM7CkSoL4F+YXsep83uNrBVu7fo9W0PGTq8hC529Ca4TmD4htLNvO+dLR95Q5b9iH4t6j4EQXjvsMdsQu5i2GrfZjbxTxcyAKcqOs6zgsANMaboEKjkHlXR8GBetjSxhiEPwVvhLm+zL5a+9byNOKBAetBOHCOj1RXNMGF5NgIfWtzm6cSQ0INWL47/iP9hCwvpfQMTumtduiPHQYGAaK9EUxPpM58akusxeexQBi5BBoqk6/JPMDF5SlVKniotTK4ie5stBJytgUKB4O9llL23dzwSLnfL9H9v++IbmeSm/B/mGADjddXYDUVr4ExkEm1M/eGJ07EsalkiPkh9AjnYnwps6u7/SOa+4i7R2MCPAtvbcHgV/8C8ctJyWFLQ32NpRN0Kc15eH1YOeFLWvquyYqC38JBorO39+OOJSaVrFUGFvoxShQAP4kYNoIEqIWt0Rw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(82310400011)(1800799012)(64100799003)(186009)(36840700001)(46966006)(40470700004)(81166007)(47076005)(356005)(82740400003)(426003)(83380400001)(40480700001)(26005)(336012)(16526019)(2616005)(7696005)(1076003)(36860700001)(478600001)(40460700003)(70586007)(70206006)(54906003)(6636002)(110136005)(316002)(8936002)(8676002)(4326008)(2906002)(41300700001)(36756003)(86362001)(5660300002)(7416002)(4744005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 06:37:55.5990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec48524-b0cc-476d-19b6-08dbf55cb6df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8919

amd-pstate driver also uses SCHED_MC_PRIO, so decouple the requirement
of CPU_SUP_INTEL from the dependencies to allow compilation in kernels
without Intel CPU support.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
---
 arch/x86/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3762f41bb092..3e57773f946a 100644
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


