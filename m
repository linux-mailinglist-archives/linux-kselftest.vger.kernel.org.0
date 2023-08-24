Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9C478651D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 04:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbjHXCOP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 22:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239253AbjHXCNx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 22:13:53 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EED10C7;
        Wed, 23 Aug 2023 19:13:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmx+pzGfRs/sPJiZSOkd8D1Ldiq0cbqc3GuFFczIlPQFdS6iCXoHvjsTm2y6+GHvX0TX11mxASx7Od0KtMaT9oCsr8C7hTHmTCoiFV9mBglkNFOB7oAf20X7qK8cr4UhuwIXvF49dKin+s6kIf6ejKXutLyVE6NMWWRMGdTkwnKoCXFNzs1wmq4iUaTUZKv7JmUBkowUOuE5QrRszFE2NaQ0ZMWEuhb8sCJoa3fTXjeL6SwQlicGfnWSJuvkQx5LF+p9HbYnshzspoFUHpZ7O2xILFGwE15y9DkgEaLWDmBduJYGCGKNhilpw/f6mGIOWPaG3Z0sc8iwGstd6Tt1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5XHJjSCZ5YeTz9FecQcX2Vdwn39+14+sxK11fuW7As=;
 b=DhiaEbu0zPmsuHLstlhpRNPM9HkcqYqA7hRwDrSOE0XEvJ7gRohug9nD7ZvlZ8egsyM9L+VquUPwOubMNG1O2HcMTCy8CI1buviawD7yBAKff4CTZU/xLu5mDTJv0Jh52xJU94oVhjXWBKS00mDgUlDRo9p9b0NS+ob+ht24Nq130fjaIh/xSYyzAoJ3C4n9QBxQHCPNs65RL1s3OCxMnG0wCnGewVrMtofLZRohiuBncdsWGRN96Da34gQop83FP6KBK9ubjskqENICXj/yE3Dct01HSdCFJualIYvmhBAxu1SdXycagdfP3W7W/CIfNlsJ841zL8sQkh/pG6sUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5XHJjSCZ5YeTz9FecQcX2Vdwn39+14+sxK11fuW7As=;
 b=alK/rN4Z6S/YYh/OxILbaDejlCawz3BKiTrlEhNKKIJYpMoCVr438exF7zaPlVjMp+8/2ZKxKHgorXFaS3UtaTE9wVEeMrBBjNv//KvUyGrjc1oTVQra5qFwEo7l/4x758QccnKPTlUhyD5PB7Kn/Su4ahX7S+Z0lC8BSIOQ024=
Received: from CY8PR12CA0043.namprd12.prod.outlook.com (2603:10b6:930:49::25)
 by MW6PR12MB9017.namprd12.prod.outlook.com (2603:10b6:303:23b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Thu, 24 Aug
 2023 02:13:46 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::f) by CY8PR12CA0043.outlook.office365.com
 (2603:10b6:930:49::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 02:13:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 02:13:45 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 21:13:39 -0500
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
Subject: [PATCH V3 0/7] AMD Pstate Preferred Core
Date:   Thu, 24 Aug 2023 10:12:42 +0800
Message-ID: <20230824021249.271946-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|MW6PR12MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: c1512306-96e2-44e0-1a52-08dba447bf22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zyxTLY2SlPAo+TOnRJ0f7/iK2RzAN9E2In5BomEjNQrzClv2rZAxn6MfkqgHADVKWluZhc024hkQFlQFJsTjbobNR8eOs+W0q6FhwZ5YlVwrSRIUkjaQcvnDe4IfJGKVrXpsXOBhu5zDHUq9t6zGtE7c6mRVc202D9gZi553ROOcU9TYTE9q4DdOsZcEuZVjYcj15t1Fgw0RnuHqUHlotQ1V2t8c6k+ZY/b9PX08cDh0AYlYhYzbCYMceECPxWODetM61LF2TGPG3pGDtG63HiwBHBT87ToGXN2q+/v5okCqsYtZ0E5KYXMHIMNBp7SikKgsOZqit9PH+eW1/QmmjCj/Jdkd/XlXVNQPZHAEV7j8PvD3yd13u2jBKdf76PSUaNVjyvQ5t2IeRoNAFnF9PA0jzy4YWhQhpowD/WSK83+cvd3k1qc+E1Y41B4Y2f0kWCeBl69BlF0R99UV80KQYqAKqC2eWkjli8ilNEgD1BPv46IhaVbo6avOPKRstgILNLpCzJLvNQC5VVnHjyS3SQmiuhpASzLqi1yd0qeu5Y/tOqUiinHWsalBd4NUaGBCzx9ctBbot9zQfbsU0hGcFEJaAyH0SHu+FALrPItJWiCKCaaR3bz4a4hXk3p7hX3fySjBqLlFBOjQcbvb3TnPkfARePydCJPHEMJWZccMbKudWkhxvNX5URpFG5N6qaNz1cyWLB3SD3LthSIdPoFNhWkVY4wY37eXW7KGjef+7yoyLxs5A0miZWWEAXUju57gQHfXYF8VzEwKZBxv+3vaNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(2616005)(7696005)(316002)(6636002)(8676002)(8936002)(4326008)(40480700001)(70586007)(110136005)(54906003)(70206006)(41300700001)(1076003)(26005)(16526019)(336012)(426003)(5660300002)(6666004)(478600001)(83380400001)(47076005)(40460700003)(36860700001)(36756003)(86362001)(2906002)(356005)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 02:13:45.8279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1512306-96e2-44e0-1a52-08dba447bf22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9017
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all:

The core frequency is subjected to the process variation in semiconductors.
Not all cores are able to reach the maximum frequency respecting the
infrastructure limits. Consequently, AMD has redefined the concept of
maximum frequency of a part. This means that a fraction of cores can reach
maximum frequency. To find the best process scheduling policy for a given
scenario, OS needs to know the core ordering informed by the platform through
highest performance capability register of the CPPC interface.

Earlier implementations of AMD Pstate Preferred Core only support a static
core ranking and targeted performance. Now it has the ability to dynamically
change the preferred core based on the workload and platform conditions and
accounting for thermals and aging.

AMD Pstate driver utilizes the functions and data structures provided by
the ITMT architecture to enable the scheduler to favor scheduling on cores
which can be get a higher frequency with lower voltage.
We call it AMD Pstate Preferrred Core.

Here sched_set_itmt_core_prio() is called to set priorities and
sched_set_itmt_support() is called to enable ITMT feature.
AMD Pstate driver uses the highest performance value to indicate
the priority of CPU. The higher value has a higher priority.

AMD Pstate driver will provide an initial core ordering at boot time.
It relies on the CPPC interface to communicate the core ranking to the
operating system and scheduler to make sure that OS is choosing the cores
with highest performance firstly for scheduling the process. When AMD Pstate
driver receives a message with the highest performance change, it will
update the core ranking.

Changes form V2->V3:
- x86:
- - Modify kconfig and description.
- cpufreq: amd-pstate: 
- - Add Co-developed-by tag in commit message.
- cpufreq:
- - Modify commit message.
- Documentation: amd-pstate:
- - Modify inappropriate descriptions.

Changes form V1->V2:
- acpi: cppc:
- - Add reference link.
- cpufreq:
- - Moidfy link error.
- cpufreq: amd-pstate: 
- - Init the priorities of all online CPUs
- - Use a single variable to represent the status of Preferred Core.
- Documentation:
- - Default enabled preferred core.
- Documentation: amd-pstate: 
- - Modify inappropriate descriptions.
- - Default enabled preferred core.
- - Use a single variable to represent the status of Preferred Core.

Meng Li (7):
  x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
  acpi: cppc: Add get the highest performance cppc control
  cpufreq: amd-pstate: Enable AMD Pstate Preferred Core Supporting.
  cpufreq: Add a notification message that the highest perf has changed
  cpufreq: amd-pstate: Update AMD Pstate Preferred Core ranking
    dynamically
  Documentation: amd-pstate: introduce AMD Pstate Preferred Core
  Documentation: introduce AMD Pstate Preferrd Core mode kernel command
    line options

 .../admin-guide/kernel-parameters.txt         |   5 +
 Documentation/admin-guide/pm/amd-pstate.rst   |  53 ++++++
 arch/x86/Kconfig                              |   5 +-
 drivers/acpi/cppc_acpi.c                      |  13 ++
 drivers/acpi/processor_driver.c               |   6 +
 drivers/cpufreq/amd-pstate.c                  | 152 ++++++++++++++++--
 drivers/cpufreq/cpufreq.c                     |  13 ++
 include/acpi/cppc_acpi.h                      |   5 +
 include/linux/amd-pstate.h                    |   1 +
 include/linux/cpufreq.h                       |   4 +
 10 files changed, 239 insertions(+), 18 deletions(-)

-- 
2.34.1

