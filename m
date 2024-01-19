Return-Path: <linux-kselftest+bounces-3233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6916C832640
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 10:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E7B285279
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 09:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6205128E04;
	Fri, 19 Jan 2024 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="07Vfl4PE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDF12D02A;
	Fri, 19 Jan 2024 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705655173; cv=fail; b=grth1xvy1VyBUmx+xkieQ/g+KRm5AcUOerNpXPWwdqTPeA1vUZK9ORdXpJwcKbRYh+P0Jt633i+ok7xaX19oMDCHUKV7hdOWcIgiFGrYqZLCyL344uBMFHR3V4oEYCNDpKGDHN+utoUntVPMgcOL4l1plj7V8w9+okSY1AcmuqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705655173; c=relaxed/simple;
	bh=kUv7qB/28v6X/lqkUL2AqREFmuICgZ+LeKvOiWXMblc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMaiNbk8mzhp4r0riO7MLOldlp4nyKFmHRtbw5pY/amohszvw78pfwywexXvJqlc6vWW9TBvGxara9b+IVCV3lTtQkpVo1KDYHzxiHQh1MqD2+9xtWySaIvZ9RfYJs9tmRpTHWVnyYVTqFyiWeOj+YjWINqCXYEZozIoYjgAZos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=07Vfl4PE; arc=fail smtp.client-ip=40.107.95.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECGBh6waJvfwPi2K8kl87rfS3Mn6GAlGddaHCcfozGorMq6BrIdgZc93k3J+T7WgyBGEcwSNWDMGKWtdcbclnGEDVqe1lZqv4D8PdM7nuzi3xN8bgYw4cqcoA7hOr+lh8WP1M9+XYF035AHMZXY/2fcfMXT+JBkiLr3scrmRGHMiErgN8GzEYpXl3Qsu2J8dVwH7vFxyeNBulpR6fnHPAWx1jvfHCFIMTgfyqZZh1qoziJi68EM9PTCg3olEjCQU//Jp+t+/8dyWgonz3dbdaIh+TuYOwvSb+6mXSMNcn3xHBfZK7lcNONE2OjuEKH3sk205tee6bNtQWc1HHQ1jEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeTOmVrv2T5NRcDB2UgLXuMlG+OUScBsFFkfBAXWKc8=;
 b=eK6D12RpsfJQNpVORsUpsHTO1gWmeRag29E/Q6Ad6N1bRUF1vg1D9AblVp7DkM8CprSuZFjXb6LTapBYz3LksnFEDVpa4Vzt/07RbwVfXBh/O2OqeRPTB0MJHSzdzqKEQ27QaO99ITomfqYy/OSncI9fLENJQCrF7mIcaITYc0jMzy3y57zEIDkK77f8zmXAMkujNkomTDExDQ4sCOlgllOl/XHw3eZt0L78XZUAQ2L8KtFnJdWm5WpSaezJP8O5bgyNA4SZF30wdRn8VVG+1fu43zAS7zgf5f5nnzR8o21xSLLYU+d7Z0uP4Q71PtF/1TqYSq8gi3wuLfBZFhYl9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeTOmVrv2T5NRcDB2UgLXuMlG+OUScBsFFkfBAXWKc8=;
 b=07Vfl4PE5ZOzOr4dwm6ggsrsZIlrztPY3/lckej3aKjV0Dla7DFhIMGWFThWTLIlLkV0olsrEXzyqIbkEuJDSkpKHJolI6E5WdwSNAB7mhL+QH38kRULUCWeL6VoU38O/Pins0FvXvODyEGHs66WHvcMe4M3TVzUZshTE2zg7Wk=
Received: from MW4PR04CA0108.namprd04.prod.outlook.com (2603:10b6:303:83::23)
 by IA1PR12MB6627.namprd12.prod.outlook.com (2603:10b6:208:3a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 09:06:07 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::ba) by MW4PR04CA0108.outlook.office365.com
 (2603:10b6:303:83::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 09:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Fri, 19 Jan 2024 09:06:06 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 03:06:00 -0600
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
Subject: [PATCH V14 6/7] Documentation: amd-pstate: introduce amd-pstate preferred core
Date: Fri, 19 Jan 2024 17:05:01 +0800
Message-ID: <20240119090502.3869695-7-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|IA1PR12MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: 23bb918b-1c7c-45f6-c2ee-08dc18cddf17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M59X0qZco7ehCSuwkubWjCw1LAYXCSpqcGmefN5Z81CJMLP6mwXZDH2i2ORCwTJEr7ml6s4uwJaQTaqAPlRLaLadDfDFq233qj++uzodJKNEvFy8wkdzsx3dp6O/9E5XXFoqS+oKz6enDOcQmDY/FYC6TT0/0gSvnycfyiheQUfbCn7N4/gPpaGRpJCOLp8mUPiAeeO5aezE5ZZC3rI5W0b5+wVPsn/6ovczoLi1+nobMAyIMVeScV+bAea6FYBbWAPyzZeL328wnbR83cnpJkvoQzXE5p7Lpg1tawjmTy7x46c2mQE1x+VkNcgN1RlrKjfcloTv6/NgSnzfMwItV+KnpXBChfQNG4h6VwB3s6nRHSXUCr0nhF7B5r4R05zJVSByjBnjQqCb1xRmh0JiiWwzonIfgkmmdND2fisRzIzSMOklHfsQDxEkt39tLnZcF0eq1+zGWMHPJuK1caOTHdKWEKHDyxUwiHzkGusFirjpjlDx6oUc+aBShIKC9XzfdmA/SdMjC49BiFIJvgTAJcDZCiBSROYuba47FfTOmeX9Zv4k7u92ixPGpN/YXLkueB2TZKiKXGkEOdtqzJ2jnP6j8g109rR2OBMljSHL7hsVue4OkCVpfhi0FD9+XK2FHhDf4F+AVVn77z+WB7LInDt3GvJsrtLB+ubGdunO13xty5tj48Ws1/Cj+cZNTopJgdNN/h/ZBhBH79na2/ZhEs98BpFZZr3qclmlfyB8qQLSwFGlu4TxkvdTaxT54divg380EtYgWOjCrXfcOSK2lw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(336012)(426003)(81166007)(82740400003)(86362001)(36756003)(356005)(36860700001)(2906002)(5660300002)(83380400001)(26005)(2616005)(1076003)(16526019)(478600001)(47076005)(7696005)(4326008)(8676002)(8936002)(41300700001)(7416002)(110136005)(316002)(54906003)(6636002)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 09:06:06.8600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bb918b-1c7c-45f6-c2ee-08dc18cddf17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6627

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
index 9eb26014d34b..0a3aa6b8ffd5 100644
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


