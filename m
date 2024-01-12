Return-Path: <linux-kselftest+bounces-2912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4077C82BD2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 10:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0EC2866BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 09:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D7A5EE84;
	Fri, 12 Jan 2024 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YB8QzDj0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEDA5EE81;
	Fri, 12 Jan 2024 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZa02nFLyeW/DgT2I71fYqdKXlEJzsNLJd4mgugeazRZ3zVZOjnXD1kTeogjiw6EQDCE7XRghqT9os4zJm55om7CYE+L6po6Fc3gs6cNGjlMaWYkvyjrEPOsJmIPIlg6mqbiWhlF8kmP0eGV77xvgtXDBbjna8wi9mefk1oRnVA6BOYHiORkMLdsZRkA1lsObnad+pxuaq9hcGhYh1lqTHRU1RGSXGpl+lAItGfO9rZyIUNse9TToGuv81BFD3pi5E0Nm7kU6m6WtjNjmWPS3Jm36lRx/1tk2yqQkKgDb9r09iCgRzMD/3ZVbQY7Uno/13zIH0yE8/Y1rhcfQi00oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85oIARnE+wv1JlIuF15E0Tk1ufYqSyfbk9En7YmPpPE=;
 b=ZKmPn1+JOvMKeey5pl8ss88kS92W+rF5iUBJyeJesFqbm2QK85jPz9U98qwHfdHxMld9V+fG4yJLRcCn9zTZ6mXNPMFuBJhr3VmNbP4lTLNOwlmOY+dicZLnGnhb4N0OJVRbS86gW90OQUB9A5aLodtjJCCEoDnEknhggfPirMg4XzkgjqJINUKGLSDT5QsGpIv6xGV6KRDJEnL1eWh2ZTCaVcjf3aPh/opljORiXmGoxgLIxWO+PIRRwt8bTrkJn5cFvMh6JiMzeHAtYE4x1jAp09QUaMMkrpiBvd+FxmCqfF6otTTaKNzu9GCmVxa3YTlE4kv0NywBNTKhDAxg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85oIARnE+wv1JlIuF15E0Tk1ufYqSyfbk9En7YmPpPE=;
 b=YB8QzDj0/AGT1lTV9eF/VzdB4DTg7kkmklLGtdogbQeYMYeeBWKZC9jhjS981+DIEZ8MLkO7Fu3tEUgoTeIqq3tSIOgYxjc7yMBHnNiAxdwbrBWeKRG33f67Dzc/1Q+ppPEldL4nwHfzkq63SdG2DFjZ2OKygwvIIW5ejmL5s98=
Received: from DS7PR03CA0268.namprd03.prod.outlook.com (2603:10b6:5:3b3::33)
 by SA1PR12MB9245.namprd12.prod.outlook.com (2603:10b6:806:3a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 12 Jan
 2024 09:26:35 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::3b) by DS7PR03CA0268.outlook.office365.com
 (2603:10b6:5:3b3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21 via Frontend
 Transport; Fri, 12 Jan 2024 09:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Fri, 12 Jan 2024 09:26:35 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 03:26:29 -0600
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
 Natalenko" <oleksandr@natalenko.name>, Meng Li <li.meng@amd.com>, Wyes Karny
	<wyes.karny@amd.com>, Perry Yuan <perry.yuan@amd.com>
Subject: [PATCH V13 7/7] Documentation: introduce amd-pstate preferrd core mode kernel command line options
Date: Fri, 12 Jan 2024 17:25:31 +0800
Message-ID: <20240112092531.789841-8-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SA1PR12MB9245:EE_
X-MS-Office365-Filtering-Correlation-Id: 68211a65-65ac-4446-7a38-08dc13509235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xjTiLomlWVjAOmLvPIrjAEtxebmc8yS19FSntbZAUGFN7TH5TvNeMH4rc3pnUeMD8hdaX3Poko0cU/3NMfmycWxP4yMRqVyNabl1KdAXmojXvWvLBpXhvKx88EQPWvvpoL2wbJUXBTJIZ3k/2lbyIQ7BcnpJ1+tBA/nQCVxmosX0fvtn6cHDbp+sp46gxVLh2Z5x9NBgKFIhUeXVVesTm+EsUXUGveDoc6YLSD402V+Rj8Ttx7CMJvArSUFHMeYJz4Kt5+1YcCrYs0m13Vcennz3X1ZTOuvH8P3wCzYRlQa3qtFVpbdKzv6yPzi7fmU9NgYjfppPtHAUgw7/+S0QdUr7xx4Zq7kpdnrBl56gA4dnB4II8bR1VPIFilFdZXbRrz7lwMmspuN/8QlwvcOrRl8TtVyHJRlduWRVLwfU4l033MgJGhF5BVFq1JtUqYxVnxvGbeIVs3khuds9pLXuLYRWTBYbqV33p+TKC6iqjQRxKDN6EawwVi/UjcuEAQgR+BAH5ID5XQnRYCaaIq5onJKSBGy04VvfrKvjgxzfNeY1b0EbmReadexMvYEWZh9iv2i76D5RSg9bivZ0c/fLdlsM07LazsxhjR3p6sHXZH/Y6TkESvb++FOaCt3NyCgmje/HjWOLjPT6kbQSImLEY1OzhOBNX82ISlu107974OE5mNs1VDooSJExD80/3MrL2g4jV4kulLB9DTOL5tszvYeKQURXa2UxmOcfF/IFmNXYVaTVzDAzpneXPbs1+y2Dt5Dt/IEoJSitvwj+7E89iMWc9LuA1jDjGfkAjCa3KvrnK2sDmS85wrILgys3iO7T
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(7416002)(26005)(5660300002)(2616005)(47076005)(2906002)(1076003)(356005)(4326008)(316002)(6666004)(83380400001)(81166007)(110136005)(82740400003)(36860700001)(8676002)(8936002)(54906003)(6636002)(16526019)(41300700001)(478600001)(70586007)(336012)(7696005)(70206006)(426003)(86362001)(36756003)(40460700003)(40480700001)(36900700001)(14943795004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 09:26:35.0119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68211a65-65ac-4446-7a38-08dc13509235
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9245

amd-pstate driver support enable/disable preferred core.
Default enabled on platforms supporting amd-pstate preferred core.
Disable amd-pstate preferred core with
"amd_prefcore=disable" added to the kernel command line.

Signed-off-by: Meng Li <li.meng@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..cbfa63a87e4a 100644
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


