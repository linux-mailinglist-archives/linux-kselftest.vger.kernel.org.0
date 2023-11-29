Return-Path: <linux-kselftest+bounces-799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4DF7FCF6F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 07:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68054281DD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 06:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DF06FDE;
	Wed, 29 Nov 2023 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GezVJ/Gp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A59819A6;
	Tue, 28 Nov 2023 22:55:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFRUALwiKwsQjXnkIA1bJ+7CfXKO36yyZikhTIGf1cxnxs7csiqmgmxcHSLfBJwOrR97jTW11CnClMKyDBe/4e+Fi3xROIcMXzHS5JN+kpU+B+xInrrf0CAe5hmT3LP5fhZQwLf6EHa09LslDPbxNL9Ngc7tzuL/FeRjgiiR1PNj6ewwM7JlC6F7m9cWIF+VPaa8lm0O7SJWtSerD8Gs+axuLZtTR+i59t+hNixSOdNESulJVa7Z69QX/FpGjALQFsI5qfYcLpFs502UzASRSQQ+NQRL6cUcKKZWS9UmE4h0cwkcE/h3whyvk2hzlGjz8vS0lwjW1GIwD6YAjPEJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vm9yAnna9PbPXFuDczUjxmJIYrtHj0wuHxiF61/ySC8=;
 b=lgaxxDATQm+iGZAxN8PtVK6Mqdk/ZqBDSwXgWVrYyt8/XwA3fT677DVYrCLP5+Oul3I4++cWGzEa48NQh/Bdz3lS6VdtiYjMiCfe+RwzOGmLfq8Bg74KSc2r+Hfvx+SAIM7nAnCMlHxnigY/FdXEO/SfskCDIjbe0cUXbP078BGk2qMykll/CWaWjpo2V/yDWWcFiie/YiqRjMK4twMze19165vq2eM/jD4jw2n/AL4947yv5b3/Jy5S8uyyQVDuweSJaI0ZFnb4yFsv5h4jDdJPKgZJKNZ9+bWGNPr1BlSlkr6UVGs3AfPWbId98Eu93qZ88o/wU/mJ6+twaRwvkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm9yAnna9PbPXFuDczUjxmJIYrtHj0wuHxiF61/ySC8=;
 b=GezVJ/GpoaZ0NqaXuoFYec6nWXct2Taq4kIZ/YTVAtNv8qZlXZoCYIPplruv0Lyo+dlRfgCBWSlFdyuU929iDnYHsHRJJ/W0ygaJqE7SJm6LtrOxmbt8fI6zaN+6dpwSEQhsXQTGxRB4vCT2LIqXipcR0KLJAkPJWXvFVBrEUSw=
Received: from PR3P192CA0001.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::6) by
 BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 06:55:12 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10a6:102:56:cafe::55) by PR3P192CA0001.outlook.office365.com
 (2603:10a6:102:56::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Wed, 29 Nov 2023 06:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 06:55:11 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 00:55:00 -0600
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
 Natalenko" <oleksandr@natalenko.name>, Meng Li <li.meng@amd.com>
Subject: [PATCH V11 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
Date: Wed, 29 Nov 2023 14:54:31 +0800
Message-ID: <20231129065437.290183-2-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129065437.290183-1-li.meng@amd.com>
References: <20231129065437.290183-1-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|BN9PR12MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: a814af3d-e684-4175-6eac-08dbf0a821b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0Ez1XdVJnJBY0/eqf258nMB7qvjDo7N/jPdCsn5tMsI6QLeGz0nA4bfuTKH3WS8/GYJjzFKwFAtNp1tMmWrTBvOdAhCUsRtrv3VZISCa14ZRaEnnGQuPquF5NvDl9iyKlD0T0WL0kyvxnDfjP2rAJYEUSzf/6X2V4nqqw4Ynr/h4+Gh2pU9ssgQxSQuC44OmcEIN3YdxoG+sar7to/BN3BZNFvahRgOsN2BZ8Emx4WWz1b2KoXYIPJB6maFS7ZMVivLeEHDl2DdZ/lwa8loJec/R7U50/ceTX4o2GnY3tyjZFA9nInnQlqUF3zFsPuVoR2NX1aHdddyiom2KJOY/UceaNzXRxxU+r2yxtzc0FZgkxSiRgj62XqCfVTTanMe0GzyLdnzIT1Mu4sPACpuedygZqOeeTQQz2TgYFGevSMnUTp9zyf/0EbyUNT1eVFX+Z5wR7+slFiVX7w1ABDrnD4VJu36PMCjebOmLiIS9eeeUUUls2mJfYFPlBRk9Cq02Gz68kBCFvQgO6Ns9GXDN2azH+Kt/n1bRbnDC7e1oI3yfFN/gk1yzQQNWKsFqYPtpO32Tfy6x6VNr2qZaHx4c1E4ICa/wUngh783AAPgONE8BrUTpDPHLnUVCAQKV9k/6k3rKJ/Wd9XVagEl4kIw93YMymjkOmjQJKKmeBZR8idZCia61GQnVn4mVKoWonRZU6UdsOXv5qyyvQh9ohIB8qCM2ROVwiQiugPsicr5tSyF5h96Jt25u1eaGFvGLC/tqJ9YPeIXRMqCQg8Xl3ieuCA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(6666004)(8676002)(8936002)(4326008)(7696005)(316002)(54906003)(110136005)(70586007)(70206006)(6636002)(478600001)(40460700003)(81166007)(47076005)(356005)(4744005)(36756003)(41300700001)(1076003)(86362001)(26005)(36860700001)(16526019)(2906002)(2616005)(40480700001)(5660300002)(83380400001)(426003)(7416002)(82740400003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 06:55:11.3142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a814af3d-e684-4175-6eac-08dbf0a821b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179

amd-pstate driver also uses SCHED_MC_PRIO, so decouple the requirement
of CPU_SUP_INTEL from the dependencies to allow compilation in kernels
without Intel CPU support.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
---
 arch/x86/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ad478a2b49e2..77b1af90f7a2 100644
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


