Return-Path: <linux-kselftest+bounces-804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC647FCF7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 07:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1D828175A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 06:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D276101DF;
	Wed, 29 Nov 2023 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2SMkVkmr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D165F1FC2;
	Tue, 28 Nov 2023 22:55:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tr90/W/b2BvIDv4QvwfjmAm3Mja3ckdsSkjDFx8swRqWOG59scQueTNN6xpJHB+ohv92IEwSd4Mqx4Jq8AR5JWaJAUw6hoqxYkk968Wj5HT+JFjumeyf5XEs4Vxd7X3F93nsgMMkv0m9XO3V4erdb9mHzXD21GM8zoGjZ0FdvnpIH7jCavY7nrogvyBDmfRN3QJ0O3fmT3pEezeEPiTjN234fxTb2NU5T+1RATMOVpcVBo4Iq2G68fzCcOEC9ad/aZFM2fnFIr/D8jkE+BBmfXZXaG/X40muoHH2DIOtjuOD5lYKRnymhYAi6A+j1CKkjnuym9HwNDYE3VF3BWHCzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+Hf7usC0hQZ6XEfTNBCV+zk7l8w2H29ZawyubckUuM=;
 b=UwN5DkSFmq6lzuw7s4dL1b/zNOy4ATfxK5ZVwR8Fu9UKbczFOn7dLI35uFrWKoZdE55jpCoqu/0DzaUM3zfA7SaKw2lZEwM9x8oTIUqv+y/ll7KBNXsXKp+OAfy7QByv5c8TYeFxaTNiubSyhToQwbW0u5SEwmU+ZZkQNHci/LniM0ohZDgcDXqX4QtnXvNiTsToWtnBrn78J4ItQyJjL0QgDPXdY5eIpElBvdisTVMlMy4E+NCKWnieyInWEOYyY1GtPLUzu6FH/2wyEdR78uPbdOmTdp2b87dmvFqzUcCamBb5qHranV+1uht/k3G/QMpxfItfdYmRfiWF4dtRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+Hf7usC0hQZ6XEfTNBCV+zk7l8w2H29ZawyubckUuM=;
 b=2SMkVkmrmJBFXTgzlciwQLzt5IqL/fvaKljIdtp00K1AQdBocudDIhFPFiVadvSppS9mXuu3OOsBda9BMOkSlWRfkEFcreZg+Y+dmjeWcSU+7bdj7MdEAFEvnbk0aEC1Jmqh8Gk+ci2QdbJ32jqGC2tk64elY6AqIXm9+fb7ipo=
Received: from PR3P192CA0026.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::31)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 06:55:37 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10a6:102:56:cafe::d) by PR3P192CA0026.outlook.office365.com
 (2603:10a6:102:56::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 06:55:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 06:55:35 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 00:55:26 -0600
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
Subject: [PATCH V11 6/7] Documentation: amd-pstate: introduce amd-pstate preferred core
Date: Wed, 29 Nov 2023 14:54:36 +0800
Message-ID: <20231129065437.290183-7-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|MW3PR12MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ab6f56-5cce-4a4a-740e-08dbf0a83048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7tnB0OY9rNwM0Q+mBvebVVe8vxOAmCoUEdGvMUKlWEdUETBO386/4nz/wgpbjfohSIvHi/Z+NrohCOWP5QR7daS6NoFdRaAWlvgGRnqaznEMOZHhKRAhJeg6OFDEPyAmli6bCIT50t5GbEkgXulRg8aD6hL/EtpZeobl6uFIJH1QbFtIEGanMggBDIsszO6b2QMEuDKfCtJNgx4zKeIvC21M0nhcfZYTkhFmtHkoiXsmaw+sM3sYy0pD9N6vIHHy5byUcUvlCtvI9vRPQEyG2+2aWK5mOR0DuCGplvGG8cl2CIbkoJWUQTXAHe4XAWjpDOv75uPUwtt4rvLhaTIEsmLtefUsYke97HSdSYZ5toV22QGSH7PSqNm9QRsloxUy8j/eG4RX74WfD2IqTi79/LB7e3n8l/af3ZbC7YFaLuBbggSbVP1GutduXWPax8mHV/bf/ErnzT/1VaYPi2lK/r0fiSHXJJsCTsWVgoi2qk6s7I79dG2K4UNseA7/bgi9lDZLDSc9hnQfCiXdreiU/Uz494HHG+ov+epWYBG9+w5968i9Wc0/2YMjs/CgSMr4oteaxZulezavITm2tcNjjNw72OTWhXz1PYnAQ0Hi9kP0ziCp2H5r+SwboaJUKfw7cw5IECRbE8w+j8yTNcTF/+IX5kiliyKMzf8gdR5h9kwhnfB3l5X7r1VFdKJEl/4Yb3TO2seiK123rEolXmQTjmMjK8xCks2Dh7mmYPTVu9aiYYJzLK1Us5hErB+8H8tD8gj5rmahS5LDDfjLOkauxQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(40460700003)(316002)(6636002)(70206006)(110136005)(70586007)(54906003)(336012)(36756003)(16526019)(6666004)(426003)(26005)(1076003)(2616005)(478600001)(82740400003)(83380400001)(356005)(81166007)(86362001)(36860700001)(7696005)(47076005)(40480700001)(5660300002)(7416002)(2906002)(8936002)(41300700001)(4326008)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 06:55:35.7658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ab6f56-5cce-4a4a-740e-08dbf0a83048
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459

Introduce amd-pstate preferred core.

check preferred core state set by the kernel parameter:
$ cat /sys/devices/system/cpu/amd-pstate/prefcore

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
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


