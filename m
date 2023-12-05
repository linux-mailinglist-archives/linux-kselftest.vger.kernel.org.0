Return-Path: <linux-kselftest+bounces-1115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B47804A5D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 07:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750211C20E19
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 06:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB8D12E4C;
	Tue,  5 Dec 2023 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z0BoXvjK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56D8A4;
	Mon,  4 Dec 2023 22:38:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G90IBLspjdghZPfsyIv2ObUE1Cbhzjun12ZJTDTRFhyORlN6S3J7PFFOVhE2f1/fLyMOdDcms7Cs1WijJ7j8aklb1HtgaF+rfs7M7U8jaPyscDkDlxuVamnG0jcA7glb6lH2sIUNBHHxlE5LX/ifI8IvBd3h5c4i/wxf2PaOKU7tgmSMtdLG+JPBi2qqhGDcqETPrGxux9YUdoYLWW0Q4QCU8DVZpWsZQTs54WHawPG6jABkLPt/HeXUg1fwV70CAFBOKNgUjsA4IUTT0pNpVY0S+GsZPjgJTSvluGoT8fP4QLJN1zE1Bk4+aHiGn/McldYf/wj7WgmmSFF/6M9qPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkcLPe+OdQhX1JrIwqUungjFDn7/6QsByHrqLs7zL9M=;
 b=n94zQtlk2ZHTaEMhmoTVbSJumSaKAkj6FNwpUnoD33MFM92jCUllHhFrEKTJB8BcB0j62KwSzLHDAwfADeEKJqGdWCL0qnFLVqU/Zo/HLcd2bI/f2r4PBVChcyoOXtzHYxHinCjvcUz3WMWH6nnJGXEj76zfpHydVmmmRv+JcigX+R4njQDxd/NSQXcwmyyX14YtWZ2BiD4b3nxs0Uh2shJvkWa/6JnypplvX76dK7b6tJKGjOL0QjmPIfn3RzXEDkrrE0KChdXr0TOX20i+oYIlt79DDoXLPqUy95UlxJU8JpfAY5P6SSJ6yN+r6ppeILJXlxli6vmZ8VQPmaj7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkcLPe+OdQhX1JrIwqUungjFDn7/6QsByHrqLs7zL9M=;
 b=z0BoXvjK8ZLfTEpjkWqAyOLIspFx5KxVp+iVN2sHdi9L9fmmXoW/QNdA1+2YtqWHUyZPaMaSVwvGacNdQ4r/jKayVhyyG07FKOrc5STHtMDyxF3ssgq+gDJ5ybOs3/UmaVwTUsTulYZviqRg1QR1uUcECFWY30ga6AZ3TvGqj2w=
Received: from CH0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::16)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 06:38:48 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::58) by CH0P220CA0024.outlook.office365.com
 (2603:10b6:610:ef::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 06:38:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 06:38:48 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 00:38:42 -0600
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
Subject: [PATCH V12 6/7] Documentation: amd-pstate: introduce amd-pstate preferred core
Date: Tue, 5 Dec 2023 14:35:36 +0800
Message-ID: <20231205063537.872834-7-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: 9393f710-805d-4e63-45c6-08dbf55cd62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cFg2p5jH+GHpyNNroDt23A1+crrHhIDl3tLy3vrewCnkuQ4HBRJrSlPl3eYXLf/4MyDab0KN3h5nERv2EapXHU1MI5MCgcjk7nZGOrB4dTyADcFA3T9qmVjWssgI8aih8RDQ01LMEwjWmeLVuDu3nJCROX8H4mEq/u468yST8TXxeMxS1aDy3tisjXN2vNT+dSKrPaLZvNDDlbv9WfHjxCekPbwGCGTgXz1oBnDfHDXkW8M6RJdi9+4pdDpn/uJXTdpFWTbEiIm7vnnxVNfoI8xU9yww2awco5k7y1yRhqoAwlxkqUq4DM2aN9qu+grjELpptsM5pH9cfLAlbwltXL7+jC4jGHtTQ6f29m5myS6sUJxFrahghzzfhart7r/WPEtVWtsI/B3J2m9A5yDW7piVjYDNKjX/BBuHkA8WwNsEmJ5OM8GHl+nisp7XlOGWWMJ4oQbuyWoS0UZuTCyN7/rzBaoqwRTEtKSwoqddGx7uWRSC8Utvtw6YaYNW4s9HblJFF7rfbi0FhkZcsob41oP3cTqrhmuKjID7hhuTiJdG+Y9WS7RVnsAFMsuBW6czpjXi3nTFvgLXoBHu8FNfBIuEUwjG3Em388PseXeNA6YzcQ/gTCY5+rHWgf0s8lOJJD0WeOSf6DAovkoWXWdqhwWoLH4WIygV6VSgxPeMMPkmgEyR9nXuQZzmft6dCenCDmaJK7k3SJVznFG5wNQVu41msRZTILE5fyeOwdtDFq1dVYzPGRHkE4UfpMQtU45eDmeFocRR8JvjNMT//QqqkA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(7416002)(40480700001)(36860700001)(2906002)(110136005)(316002)(6636002)(54906003)(86362001)(70206006)(70586007)(36756003)(41300700001)(8676002)(8936002)(4326008)(356005)(47076005)(5660300002)(82740400003)(81166007)(83380400001)(478600001)(40460700003)(426003)(16526019)(336012)(26005)(1076003)(7696005)(6666004)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 06:38:48.0541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9393f710-805d-4e63-45c6-08dbf55cd62a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188

Introduce amd-pstate preferred core.

check preferred core state set by the kernel parameter:
$ cat /sys/devices/system/cpu/amd-pstate/prefcore

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 59 ++++++++++++++++++++-
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1cf40f69278c..0b832ff529db 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -300,8 +300,8 @@ platforms. The AMD P-States mechanism is the more performance and energy
 efficiency frequency management method on AMD processors.
 
 
-AMD Pstate Driver Operation Modes
-=================================
+``amd-pstate`` Driver Operation Modes
+======================================
 
 ``amd_pstate`` CPPC has 3 operation modes: autonomous (active) mode,
 non-autonomous (passive) mode and guided autonomous (guided) mode.
@@ -353,6 +353,48 @@ is activated.  In this mode, driver requests minimum and maximum performance
 level and the platform autonomously selects a performance level in this range
 and appropriate to the current workload.
 
+``amd-pstate`` Preferred Core
+=================================
+
+The core frequency is subjected to the process variation in semiconductors.
+Not all cores are able to reach the maximum frequency respecting the
+infrastructure limits. Consequently, AMD has redefined the concept of
+maximum frequency of a part. This means that a fraction of cores can reach
+maximum frequency. To find the best process scheduling policy for a given
+scenario, OS needs to know the core ordering informed by the platform through
+highest performance capability register of the CPPC interface.
+
+``amd-pstate`` preferred core enables the scheduler to prefer scheduling on
+cores that can achieve a higher frequency with lower voltage. The preferred
+core rankings can dynamically change based on the workload, platform conditions,
+thermals and ageing.
+
+The priority metric will be initialized by the ``amd-pstate`` driver. The ``amd-pstate``
+driver will also determine whether or not ``amd-pstate`` preferred core is
+supported by the platform.
+
+``amd-pstate`` driver will provide an initial core ordering when the system boots.
+The platform uses the CPPC interfaces to communicate the core ranking to the
+operating system and scheduler to make sure that OS is choosing the cores
+with highest performance firstly for scheduling the process. When ``amd-pstate``
+driver receives a message with the highest performance change, it will
+update the core ranking and set the cpu's priority.
+
+``amd-pstate`` Preferred Core Switch
+=================================
+Kernel Parameters
+-----------------
+
+``amd-pstate`` peferred core`` has two states: enable and disable.
+Enable/disable states can be chosen by different kernel parameters.
+Default enable ``amd-pstate`` preferred core.
+
+``amd_prefcore=disable``
+
+For systems that support ``amd-pstate`` preferred core, the core rankings will
+always be advertised by the platform. But OS can choose to ignore that via the
+kernel parameter ``amd_prefcore=disable``.
+
 User Space Interface in ``sysfs`` - General
 ===========================================
 
@@ -385,6 +427,19 @@ control its functionality at the system level.  They are located in the
         to the operation mode represented by that string - or to be
         unregistered in the "disable" case.
 
+``prefcore``
+	Preferred core state of the driver: "enabled" or "disabled".
+
+	"enabled"
+		Enable the ``amd-pstate`` preferred core.
+
+	"disabled"
+		Disable the ``amd-pstate`` preferred core
+
+
+        This attribute is read-only to check the state of preferred core set
+        by the kernel parameter.
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1


