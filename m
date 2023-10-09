Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE327BD223
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 04:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345068AbjJICvH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Oct 2023 22:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345066AbjJICvB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Oct 2023 22:51:01 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3F1F1;
        Sun,  8 Oct 2023 19:50:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5mjqGb1RzA34vc/x6B2DPqMnn2PKmOFHqlmQVRQj2Sl9YrHzXi3iBei0Xf3d9HqLQ0MIqQJDUZ0lxVf1cxf/+IwHxwtDn6XYOM6aN4qtedMQPw8Au6keDGKgfkbcZuCPXd1rjUzfXu7/iTZcrsPpcLaah9ug+qYSJXmX1cOgamWW85llRPlXGy5uVz/33doIzEqBozTI+6+F8RBv5z/dDmgiwp+Ey83nOyqR79ayaAWveK7O67lKmp3zjGeNfLNiXTnk14KCju85U6tutgPrf/o0mdQz3Kgh29uCMjWuZJ4hxCnXk6uLbF2FvF4qKgWKorBr6abLlwYG6yqQM+sxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OK1yS43YQ3sOBQqS3fVNjmQ7kYIlNFL+i2jNaV7o10=;
 b=NIXqDndpDYCzS2j72swvaNf2ikWHea685cdKkz0GH/zfJ3N0vsflLUh13yM9LolCu0e2Sa2iZBRpBq9662kiVUhMyH3792drkEcytt4rjC42i72tfjr36vbXS6A22QyaY6nNh68UEbMWSZH4C/BVmO7ww6EbpgWZumdd4pyJV6Tq6tw3FAsw9ryVQ9BLrjHvrGl8uxCQHjdm9pPJ/jQsiJa4neHSxqPfQq7GvicuK/2dcgG1E/+9qWPFJGva9ErhZenOKDGFFffS5nZF9W8D/tBQx0S/1y/weWdK7fzik8fVs74m+8nQuYgu0KIAQU5Ez7hLxQ3RAdbfM3NwDUuxxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OK1yS43YQ3sOBQqS3fVNjmQ7kYIlNFL+i2jNaV7o10=;
 b=EPw2AIfzUqUkCMl1TYra8mmwxWgfujDzUNdXjyQLO/CVMmICMaCrAzUcW6c6p6eN3aMal5kO9HhIh7mH7EPiflqk/gvmDylIFcAzJevf82h0JqJQgmt+tSef4nwdLzre2+7lY9r98J1iHm7uM/cdA3f4ZDAwaRinOLzjLTQgqqM=
Received: from MN2PR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:c0::19)
 by PH7PR12MB8828.namprd12.prod.outlook.com (2603:10b6:510:26b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Mon, 9 Oct
 2023 02:50:55 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::86) by MN2PR05CA0006.outlook.office365.com
 (2603:10b6:208:c0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.20 via Frontend
 Transport; Mon, 9 Oct 2023 02:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 02:50:54 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 8 Oct
 2023 21:50:49 -0500
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
        Borislav Petkov <bp@alien8.de>, Meng Li <li.meng@amd.com>
Subject: [PATCH V8 6/7] Documentation: amd-pstate: introduce amd-pstate preferred core
Date:   Mon, 9 Oct 2023 10:49:31 +0800
Message-ID: <20231009024932.2563622-7-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009024932.2563622-1-li.meng@amd.com>
References: <20231009024932.2563622-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|PH7PR12MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c90555f-8308-4450-d7b9-08dbc8728e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQLNwCeq8shFiIlObe6d/oc/ujfldpCD2gXhD7NB4+7/0nEJJ3HCiTTRTl7WGzVOKQdTXNS6xbuUYmoXSv0mY+zAq1/u337ftbIWekPCI9FuTA4mS3PRIgGSK+yIo6o1bnveEfaKdnfS4XxqzQ0QS8mqMzsQhfaFdaDYQ2Q/3TQ8Tep6zWWU+qFwu3ZuR3uIYhWw91+gGwfKmSkLc8kRFzqE57bnOxympBmZMP5sBM8CNl1HuPJLmlsusa5iqCKtPGrvq0x+3pihcBlIxE9RTl4AWHoe+o3MZ/BwHJTZHQkuNuksICsxpuPmJsPrkksD5BCkcmedTybYRTVsz/p2p025d97RRbaJaQFLEcJwkTlp0pbBDBE1qHY3SnVGK7+GKbrKk7eqGtnYrmX5216Y/5Z5ORCknf3HJWGTtO5Kl1KoklBGHK822uJ9ZzvogNKioWNQb5GQQj9Cef8nuFpzlh+Ngx+Eju4ydtXPlO+aww2+lHhjvIPpGWYF0fczKVzuG3menj+il7HY61MslJR4db8CNcyojtL4sQlN2iiYhB9xPQM8HPp5wy8LXWR5RtbkpIHS/Sc5EA7Nzkxq05GCYu1+N9IVxtSY8cB4GeVSAt3OZyRyVmDHtILE2IfA++SCcbxJD5PxyssGQOkrpvaD/4+qjd0Oto7bJs8dIx7bupByTsMMF4nhpp3MLUrEkLHvvGzrE13I/mpkymgqIFgWgKDIuxtuwrfU8ZDFNK4OiH0k29zNLNc1gqwxd7po64Kn519INIAS4zy+1soXjeMUqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(64100799003)(1800799009)(82310400011)(451199024)(186009)(46966006)(40470700004)(36840700001)(2616005)(1076003)(16526019)(426003)(336012)(26005)(54906003)(70586007)(70206006)(110136005)(6636002)(2906002)(83380400001)(40460700003)(86362001)(36756003)(47076005)(36860700001)(7696005)(6666004)(478600001)(5660300002)(8676002)(8936002)(4326008)(316002)(41300700001)(81166007)(40480700001)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 02:50:54.4724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c90555f-8308-4450-d7b9-08dbc8728e76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8828
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

