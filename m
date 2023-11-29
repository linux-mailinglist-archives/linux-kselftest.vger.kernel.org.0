Return-Path: <linux-kselftest+bounces-805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AB87FCF79
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 07:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569751C20D4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 06:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5B6101F0;
	Wed, 29 Nov 2023 06:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h8FVn1gD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB722106;
	Tue, 28 Nov 2023 22:55:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7ErRTO/sW5GqWbtJGh1hrZwg5IvSVRpKNxlEVxZ77wllrf2QqhayEN/m9qYlTkgzFqIB4KwYOMbl8uzsGf+XfEyo1GlXUGwmdF6wM3WtJsM+fr0NlWAVai8l6xvOL7g9V9vzn0uQYk8veSIFCK9Ochmb6QvwAPtzahGAEIa6yK8Nfw9Zv4hBVC2EnnD7hmXNb8p50eMj7nZPm6oOza/bvcqwiu6SShNiftUZnV17A9MrWYtVURi2855aMBEWd05gzixnymqV5Bp4ic9TGcq/GESGaYRbNzhIJ+TREF7jv0zXa9LV9LrBHS47zzLgldkg4B3Q2KR/gX9FYoIPQqluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKc1dIPsjE9yGYtF4kKEBsXDZo1NDaqtRaV3fani9k4=;
 b=D6ydXa8dvTdJcUiI5Iis5HEslGuBUgb8e79BJid87aLuauOl6QBRBBmel28D3I0j8bvH0jaqqHHOhNEkfGunfq5TluEFZhf9Fr/GiE62D5BERUA4xj6eipquoMn1ZVSVLqirim6C8DZx7bwzk+Dqop979A1tBK4opifRULK4xGX3sIYAmUo4tno33De4i1qojU/E41tjEmdeAcD+8DJ6t67Y3ED4u1t4p7yG8Z/qXlpf+sRzotvqhEfccx4mEKWXFNXCiU4X/yb+MS+I5NFGbXFZtT3QsjPTQHkxoXcyKNVu/XYJ8i44tDywFCIrqRbAY8w/f8ALEGT0HGVbxPgAHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKc1dIPsjE9yGYtF4kKEBsXDZo1NDaqtRaV3fani9k4=;
 b=h8FVn1gD7J/aYM1TTtvx+NdHO01BChCiIcde0v99jjGc7dkjv8k4x07S7vPIgxERc5n6xHGz4/w3FJUfYyElDHo1e3iggqqDfjxa48hooCPL6AsaFnd5GUPlKX0uLSwSQ1oBLytwt5pGdPK367j20CWOfzUE6lX1a24LcAuL0ao=
Received: from PR3P192CA0020.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::25)
 by PH7PR12MB7162.namprd12.prod.outlook.com (2603:10b6:510:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 06:55:41 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10a6:102:56:cafe::36) by PR3P192CA0020.outlook.office365.com
 (2603:10a6:102:56::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28 via Frontend
 Transport; Wed, 29 Nov 2023 06:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 06:55:40 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 00:55:33 -0600
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
 Natalenko" <oleksandr@natalenko.name>, Meng Li <li.meng@amd.com>, Wyes Karny
	<wyes.karny@amd.com>
Subject: [PATCH V11 7/7] Documentation: introduce amd-pstate preferrd core mode kernel command line options
Date: Wed, 29 Nov 2023 14:54:37 +0800
Message-ID: <20231129065437.290183-8-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|PH7PR12MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 083529a5-eb54-4c17-065c-08dbf0a832e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Kpz4ZUufly4qa3LqPwBfJ5kZFMYUwC6MA1wONlLmUFanJzPOhSSSzZfoxs4eeuPc672yrUaD8L/Xf2Xe2Tp/ctuNapU8BnAgNEDrcUu5Kz8CekY3gyEwysJfR3qTQf6+DX8JkPnW7ucQzV97vLW95WOniLmECzvXBSUmODNYQJygQqCQNHMoKDAXr8QI3yM/mfK75vOKG3/GiU6oSh1b5/7jO46mdrRGQmlLClUvJRB5DXupo8LWWvVdrlZln+fmnA4ceMmI3mWlJxu0JECFx22Y0KRI1KhV3gDFE3Hb0639eK7ERTBCJCRsOFjbSs0ifgpkmPMpusJFd0LkzJ+0MnxDbDyEWdI7EjBvbZr5r6Dd9rNRScnBcjROV+1GSOn3L2Wyq/rI5uMZkLNWi48+YME+wr+kAlYqrnbZ9g96v+HczPutoAmQzL4m24HpIIWMTMGmmZLt8kQ8eynbE0ylkANq3PhIgFGDemTACXrUCRfZJeXhfWwVtsZv8E919oMgpDqvM2vzW+MP7mH6xTQUp/U6BxUdUGSaJJsBrErW2rk+C2YMo0lbcAHOtqkYWbTYH52t+iLePMEBnarmnFCm+xRH0y0gx2jGnHgXaNeC73NLDKM4bwOlifxn/C5b5qMT/ZeY3df6KhcFTItMx5mcvshxYv21i04SLgwvBrRfKuAyqcYLvJ36gYc3CVgE8qgIkc7EMqQgVu9fuleF6LMmM6xC6WHE0hDGhUGW3FAqQCok52zQPWb2BMIx5WY/wQ3IWNp9BM2rGeSN8s1fHaujtL4rNLJHI3pg9xn/CVP9j3imGvrk2LwVK211OkBysV7f
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(40480700001)(41300700001)(2906002)(40460700003)(7416002)(86362001)(5660300002)(356005)(81166007)(83380400001)(70586007)(6636002)(70206006)(8936002)(4326008)(8676002)(336012)(110136005)(54906003)(16526019)(7696005)(82740400003)(2616005)(316002)(1076003)(26005)(36756003)(426003)(478600001)(47076005)(36860700001)(36900700001)(14943795004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 06:55:40.1408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 083529a5-eb54-4c17-065c-08dbf0a832e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7162

amd-pstate driver support enable/disable preferred core.
Default enabled on platforms supporting amd-pstate preferred core.
Disable amd-pstate preferred core with
"amd_prefcore=disable" added to the kernel command line.

Signed-off-by: Meng Li <li.meng@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 758bb25ea3e6..008bdfd63c22 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -363,6 +363,11 @@
 			  selects a performance level in this range and appropriate
 			  to the current workload.
 
+	amd_prefcore=
+			[X86]
+			disable
+			  Disable amd-pstate preferred core.
+
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
-- 
2.34.1


