Return-Path: <linux-kselftest+bounces-1116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47315804A63
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 07:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D381F21467
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 06:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E973312B76;
	Tue,  5 Dec 2023 06:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SOnE5Sjq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBE3CE;
	Mon,  4 Dec 2023 22:39:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANb5qXLGqqVPq95NhlT5hi7nGBtMc83ChGRK9Q+IkZLdKSf8/Cq3lC+rHd/XbCtkbQtLdz1jMb7qHwKJ80dU2i+S7Hj4iuTw0WfoH2xOClxPvXojjJIZReT85Txr38gK3uaTAFK/sxOCKIB7LOOflGue7q7shEfjbaCfbIHbKHw4tQC0RSlZqB39mhdgY96lV4mLoJ6+ESvgygQTCIpO4WHkr56a565lTsK63LX6Se6Weo1odrrYRzWG/GdHkKPbpDa2MOIcf9ur2AfKSFqzp1Owuz3EbboeEQJja6g+jX+ZvhmS/iCHas6fA3rZflSpJk6rfL5tTvp38+KXxRJIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85oIARnE+wv1JlIuF15E0Tk1ufYqSyfbk9En7YmPpPE=;
 b=QHAIEceIwM3w+iagBUhTs6satzuGfgjrd56k9GyLh3mJHr+kVDABTItFiUJyY66YdnZolWKCgR12Bl2gC9iYbBk9OJRP5IQzCkTnI/sKURT6i0Iq0sN7sVOLhD5mZuOEMvvNJpVRWNni8jEXDU0u9aLfvf/V0xl32zSi0UzJhsTP6cw9rdoaSHoXJY7+gNBVmNeVkVlAlhqwxgyfr/MBvqC/G3qCdDg6aTutaGksj6WdMd9Rk0f9lwmOW0N1cutYPQyRzlzRrhoOubkPqQr50U43GFNrQ/e2j5BZv2+EpXPQ7lxYND6FbfkVONcxPsuaxyzEMkCmRobt+2ZvQjht6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85oIARnE+wv1JlIuF15E0Tk1ufYqSyfbk9En7YmPpPE=;
 b=SOnE5SjqmRTWugGUqBjwo9HJ+rlPkdc5v41jXRklVsZT+VLedSgx1S1/4N3WCS/jgCg5ook21aeRZdREuWUrH1qTTfKcckZO5qOJV13p7er/xm4vEBh5ilNSVeyjmKMbrsBK/FEi7MFLfdh+7Czp18nnjoG1JVdzTWHNgVFrcCE=
Received: from CH2PR14CA0021.namprd14.prod.outlook.com (2603:10b6:610:60::31)
 by SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 06:39:10 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::17) by CH2PR14CA0021.outlook.office365.com
 (2603:10b6:610:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Tue, 5 Dec 2023 06:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 06:39:10 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 00:38:48 -0600
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
	<wyes.karny@amd.com>, Perry Yuan <perry.yuan@amd.com>
Subject: [PATCH V12 7/7] Documentation: introduce amd-pstate preferrd core mode kernel command line options
Date: Tue, 5 Dec 2023 14:35:37 +0800
Message-ID: <20231205063537.872834-8-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|SN7PR12MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: e2469d75-a601-4cbe-908b-08dbf55ce368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gcfHcQ99jB6TCLHtAH+cVAiYpTvoDh1DNWnEWTa4V9y04sfvkeZ8YXQlFBjNQIqCE7ntKzdBLYroDUoVjX7D1RjXtok3m/tUboz2z716raOJBTHdIisGuYMlrxbdI15XQ9xTSJm6Tbwe5OfcHm6+QqG1qiMYYLJ1NxvvX+mJS/y7mOThEWjWqp3xjZUxw5Lj6Q9fISEEijGDyY9uhwqgyUw6dYFr7F2/NcbjGFGJFopzd1lFQrlJctANlHie/kqCEgxtLqFN06XaAUyEk7jlxl9zcjRIcWv9/WpFWymBBFnfGEPjWT49V7/Sl7xS1/6kPrpIddkliEOXJlnbyNgtp0CVhHi3no07yPK0ZXGOvM096U8jPBl0FYPSV19ZmLIAFerx5W0GuPungOgIIYaAcSKRnGzv6O1kPApQx9sNHM/dbHUTYIJkrIPCsZa1KvMnlU5j+KD8tzOZBU0aibeay20JxSdWQh3u1dPJ8N0aRiu1bWqO1fLzGTgRGR7edS9C/U8N5ALezmz+Tp5A4WoE4L6zwqEhV9UYQ3uOlPs5X1h9s1RVhnToehq4ZYWdnGgX2+Ay6c/K3RJMxxHLexqYbpDowdH6flK83875OsH07k94LuOyYqpNH1FAC/o+IKA0Ej0k/UVjntzEkLLLgBPHvmNkDJ/95ou+G5dauD9Imo2DU0W/5sVXwnMEwo07XcLTtQLp5zTbBxyMntr5PCedIeRHR8Bic0NrK1FUf2l8LaP3QaveXR085Lm5ofo2N7jqiARvoWApLf2TJfOji8vysdQCNtgqTUmyvY4ageUl3TFGO+UAP+5Wjz+xIbWonaYh
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40460700003)(54906003)(8676002)(86362001)(8936002)(6636002)(316002)(4326008)(478600001)(70586007)(110136005)(70206006)(36756003)(41300700001)(2906002)(5660300002)(7416002)(36860700001)(81166007)(356005)(47076005)(26005)(426003)(2616005)(1076003)(7696005)(82740400003)(83380400001)(16526019)(336012)(6666004)(40480700001)(36900700001)(14943795004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 06:39:10.3196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2469d75-a601-4cbe-908b-08dbf55ce368
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6838

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


