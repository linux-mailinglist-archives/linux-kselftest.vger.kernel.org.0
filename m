Return-Path: <linux-kselftest+bounces-3234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E330832646
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 10:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED3B8B23EDF
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 09:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC40422073;
	Fri, 19 Jan 2024 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="twRq39oL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC21E89E;
	Fri, 19 Jan 2024 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705655194; cv=fail; b=dbb+NPxnfbqY9VQs6wxvHHBvr21xwMwW0Cwbj6EaiTQW408Fuj/ySJalnt8rMuMVuGai+QTTVoBf9SfTVC7IqYHnNkb2uAg38E2qfSeqilKz5ATWTcoiUoQYwCo3HSp84Mq93WIddoMzN1/vZAdlJc07C5TVh3IZ9dodNdp87os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705655194; c=relaxed/simple;
	bh=IZvjB7EN/4zNzdRQnCVGIQg4s42HWrXioCam/fK1DV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+cnZsxV8ut6SERmUrRjiLN36YOJQ2hUhHfKAB3SXqMq4UP1bxJvObX2UBl68lV+BWOdgFIA0aztEhJ4Bu/xkpOIv7H6a1/7bMh0T5+oW75xvXbFyQp0OtXzgK/bnivR3AhuUDpbYP/1T4h0AQkzOR3Ne7M3vAxSs+q10kESc3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=twRq39oL; arc=fail smtp.client-ip=40.107.212.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sfv7KOTQVQu5ozwi+Y8rHXbFDrRI2huujN6erunpMzUIOCyX8Xy3i/At2KNtoERysJdy13CfMlGO/RGe5yCV1CCRKJxLFjhJkJ20ZPFCGcPGniMqgv7+kf6Q4qmJQnW7hNTqB7bKBgjRSpZUVCKvMzLkEWa1uaJNKFwWTXw03jgb21sbfx3ZoMaqZZJwDFRnjt7/GZMPCcxAzsH7gfPzPxXdIxqFfCvPADkP9VJbUD2vI27LEfsAJpts07xXigowEFH/w3+Il/VTLqMro6UXXI/WMd809Gee24sWEWKw5EaTU3E8JIHZ6IE2sHG7VxyT8HXZPSker52uvOGxILQC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=No7NU21ife6RzGvHBvQIbHlZ1whS1mUgP/ZoECpCgPo=;
 b=i5qE0PIl79fP8x4sNn2gv4ZfiRx2Dp8tjK+JMj1+KHaHd1ISj5FvesQnV8wnUP6BrXMldQrwirRPlb/ZmtGXQSKUJBGGWR/8fzLMIbx0TlzyZ91r1qr0HNn+Sic+g7gR/0dOX91y6Svozn/7cvpg1FVqmTE00NTBWCnOeSeOcocg6Wf4dtK/jL/HLhXxlieYDGO6Nl8nO3TI6nvTu76hROBT0CTHjmwX65U3EQ3KwXpydTRaAM5dFbbjDW9Msg6Ni01OAnmulbOldQXyEmUjP2I6reQyIh458n+N74HkkXiCl4Vk5EC5qLJdPwDhtoxHx23QwC4v/3ItAKNPtWinmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=No7NU21ife6RzGvHBvQIbHlZ1whS1mUgP/ZoECpCgPo=;
 b=twRq39oLD9T+KXqC2KD9tc+L9d5xeUiiDowEhvI7QYaKurL3Sjrc9hxSxvCVWHLeHiDCpcAhaqBwVrRQZayJwOztOKSNv4y0trSn4rxB8RD1BkmIciZdgusOjbs5560TaRqeH5/UDMaNC00FbVtnuDCGKXhTFdomKYe3ZoK6qAc=
Received: from MW4PR04CA0347.namprd04.prod.outlook.com (2603:10b6:303:8a::22)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 09:06:27 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:8a:cafe::9e) by MW4PR04CA0347.outlook.office365.com
 (2603:10b6:303:8a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 09:06:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Fri, 19 Jan 2024 09:06:27 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 03:06:05 -0600
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
Subject: [PATCH V14 7/7] Documentation: introduce amd-pstate preferrd core mode kernel command line options
Date: Fri, 19 Jan 2024 17:05:02 +0800
Message-ID: <20240119090502.3869695-8-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: dec0e504-d57d-44fe-70cc-08dc18cdeb1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0bZ+9mItUCQsNnwz4qvbMAxIfbok0qoYXtBj7Y0za9vLm/GBNuehQDT7vo81xDRw442MhHPk8E2wHcphTRG6Cwm++vgFKPBHQi6ikhBF9DW18n5/A7ajvnIy4wqY89fNzOisqXuYbnJ2DfrqSziJZJqPlk12aJAIH2wGl5+WbqOQ7Odgzn1fOZq1N+VqKdKsMfqUvaEvqTyP3GZ+1drEaDdrX63ghmr9Uo6diNLorxI3/6WUK+1Cg1LuKRoNHkE8upZpLcSYSASQVg1TDf61IqUzmNnuB/q/eBwI1UkDFPxHTGSfSI/IFexyc7TdcxCf0s8dAgBpZYgU9jLtDIc8J4Cq6ANfw/c6GltVzGXuY6JXOmWz1UuOQeHLtAiapXXiLnrOtOsrjpxAM0Z4ugYg6lQS0Ce1RH7CLKVAFwspSri9GY9HRZ1v0BF8kA9Z4oZBZyYRaik+ZFgdHQ8XnaeHIKu3QTSOj877t7XMI61xOekS5e/meqmiVOEi+j3Wjn6W+MiUs93gBfRlQCb8v2gbxOZ4nUoVOeBN5kxkPvhzzLQ5WQMtenXOppiHoL3AHCUj83ouTMw4n8CAX/2ZljRT2s6EEdeprIhdj5IFb6Oaj5f0cSSDlcC/EUku2jICYFBGARPuN52PUYoFCzkQqBWHWCXX2f/ij8oZkbR2/8V5ASIuZZfJA0EiwLDAM5K9jGneVwjCQBxuvVkkgbCz5sKQn/NBrOAH78mJOWVZwrn1+jdHbr6TphcVqzXqN5NKpCv1rz8XJT79LntqvIVlmc1MUh0Zwf7dm3DbKTAZiw0M0HznKk5lpCXctAjv9T4J+J0x
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(26005)(16526019)(478600001)(81166007)(1076003)(426003)(336012)(40480700001)(40460700003)(356005)(7696005)(2616005)(6666004)(316002)(70586007)(70206006)(54906003)(83380400001)(110136005)(6636002)(86362001)(5660300002)(41300700001)(4326008)(7416002)(8936002)(8676002)(82740400003)(47076005)(2906002)(36860700001)(36756003)(36900700001)(14943795004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 09:06:27.0167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dec0e504-d57d-44fe-70cc-08dc18cdeb1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250

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
index e0891ac76ab3..88b29efc474f 100644
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


