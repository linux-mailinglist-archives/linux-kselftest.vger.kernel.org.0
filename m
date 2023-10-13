Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2D87C7BD3
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 04:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjJMC6s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 22:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjJMC6o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 22:58:44 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98759106;
        Thu, 12 Oct 2023 19:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQ4aIgv5xjFOzYEgnXZAD0r0MYPW+J3yqx3VfYl4AFvhj+BphpWCxWvju2J1n8XaLb4nze5G/NKIdRng3FKOIAKZcKi07TNPk3OAorYmh6B4Vk+s9ZT8KOMpMX+aehEKrsD79859dv8FLM/4s34vu1BNKgBUWCEYGKZXvffzaXdr1km0z8m1E1u+Q7r8EQzta6IsatdDu8bzjno196KAP2BU5dpsamWI7UB83aGNvk+DS/Fu5YJ2oDoV3oP7hC/MdulqAw/YloI+WOoDD3ACVS5K3RvFG2p9sjLPoBt3JQR/oENIhiB4XfSaS4u1UNhnbk55UNiiVxxpqUggk+vrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+Hf7usC0hQZ6XEfTNBCV+zk7l8w2H29ZawyubckUuM=;
 b=awi6crvUDHi5lCnxvmsCrw3o0YXLzdkHTr1GHc/Cg0BVfzZuH7ApVASXiwY2H24DAnzBkgZhSlEHiD/SJfVI/R7p2/40ps0Lmgw/KIUrJ4KGonDGsAMm8FYhqIYUgl0cxKRQaoEMGglSfHuLgrmn3ZrJERbmtM4H0D81VVJvvRLULvwRaSy/6IkEi9xmaQTEnVHGQ+aTrv/tWsLeZ81EkHShCPE2YBKHfAK5nLyA8WdraFKD88ut1OBHynw0YLJ01BNuHz3naA6XDcXOd47B973lm+iFM1Mo4Rc12yxJ2PlTA8SDEWXzyFT1SL1AsHHTCQhSMYzydBtOJTOedanUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+Hf7usC0hQZ6XEfTNBCV+zk7l8w2H29ZawyubckUuM=;
 b=ar66tvz8yQpzJ2SvToZu5xvt/jl0E1iMpuHSENQDa/C1/WVLiaD0cipfk16j/6/8HGcnYcJtKTb8dBw0cxriOxAWobQz3khJJ+xIE3ZKFg8z/FnM/nshfClQXC9G9ERegecVWCEbexU7jIyIk7eT4wGx0TeUj/R/JAw+13suAwA=
Received: from MW2PR16CA0037.namprd16.prod.outlook.com (2603:10b6:907:1::14)
 by SA3PR12MB9200.namprd12.prod.outlook.com (2603:10b6:806:39c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 02:58:32 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::7d) by MW2PR16CA0037.outlook.office365.com
 (2603:10b6:907:1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Fri, 13 Oct 2023 02:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 02:58:31 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 21:58:26 -0500
From:   Meng Li <li.meng@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <linux-acpi@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        "Nathan Fontenot" <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        "Perry Yuan" <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "Oleksandr Natalenko" <oleksandr@natalenko.name>,
        Meng Li <li.meng@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH V9 6/7] Documentation: amd-pstate: introduce amd-pstate preferred core
Date:   Fri, 13 Oct 2023 10:57:40 +0800
Message-ID: <20231013025741.3332520-7-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013025741.3332520-1-li.meng@amd.com>
References: <20231013025741.3332520-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|SA3PR12MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6e18d7-1a6a-4a95-1cfe-08dbcb9848cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xR/H6tdRKlYC+o8RIteZu8eyT6eWOC/HMcD4lQu868QLeJu9TqjNO5+UYHMlKtI4M2jWNxNtt79nIIsaGTT/6d0fRrxqPE4P1F/5oebDWLyaVeGu9ohP4OuRnVcm8xIgFsIPZqbACefC4Ba9uVmwngpsjXexxLkjTJEf+bKVeDy/yJNEGP3PX73PpZt6FbBjoHV38CDqykSdUeSujN7szzRCqSj9CUXlGlyFoOtHkfDo1+SEbNWgDJfRwKCWtaulL3hwsWrHX6GQ7aWRkeg+cOc+eF7A7itGC9pAWLfUuHN+NT3rITACr/gOfzCQZlQW2yLU6x7H65PUz36lNtXB6EUF1K/NZVQhfhfxT46Y3Rp+Ztj4EcVd8XX8KbnIfRmKVJqNiKfP+lOVC8A7ecoWOOmjCFtIOVEDRp8iERiypy5WfACrfk7DQSLFx29IZIsH8TGSTHvGWhI6ztIOtIQf5lEeaDGmoJU/NJT5QOEDxj/7naN1+z0bs3QK2FHwtJnpGZ0fVd3M0UIeDNVFbo7+TqpHiFGdiIkQMzut1SWR9KkZR+SdFA5qZPOFpQ8+41wbNxpxKSt0eID94kBmzFRjQEtAklEHt8bz4TyfHLKGbSUq2iAUVm/Q9lI0PfBwI7vCThc9/WUm3ZMZDbgif5EtcwmiagrC6QUpN614vi/1vCqeofUZoJhpEl8NebGFHrCdA1Nj1/1j+8RExPnXkE7GcIa6boFzIjt36CS7VpITuTEPwb4j+hUPLsXa30L5FAuoBylduCU7TsRSAeQr3NcufA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(64100799003)(36840700001)(40470700004)(46966006)(4326008)(8936002)(8676002)(54906003)(70586007)(6666004)(70206006)(6636002)(316002)(7696005)(5660300002)(26005)(2616005)(478600001)(16526019)(336012)(426003)(1076003)(41300700001)(110136005)(40460700003)(47076005)(83380400001)(36860700001)(40480700001)(82740400003)(81166007)(2906002)(356005)(7416002)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 02:58:31.8076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6e18d7-1a6a-4a95-1cfe-08dbcb9848cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9200
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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

