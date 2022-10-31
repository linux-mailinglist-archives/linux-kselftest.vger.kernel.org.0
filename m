Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426A86131E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Oct 2022 09:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJaItz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Oct 2022 04:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJaItz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Oct 2022 04:49:55 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D153965C2;
        Mon, 31 Oct 2022 01:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8MThUB7V6+abojPq8xOkceN1hif3cJfFCE8S8w1MNndahwYnR4ajJwJyd3pJX8/lBHOwQBmkzBDti5/Zo3UbH4Ig5Zh5Lmf3TJujpfez9C//ii8bSYn4eTxlvyw+jZ/GgwazHUMdzXw9cswmj463z10nddtfoR59xdiJPjXrTevBa9Ah2J8fDSPV7uO59X1gnO7tyYsGcyx0scyQfXLhjU/faNZHVZAZ58nA4cod4MDICzDenGDyfIOoNucwo5oUweW6V7ySJ+4olHe5YqxWeBJ9bxX0kVvtbIoG55fNmeOActEUv032LuzBJzGg8+hkhmKK8dzEZQIcuVaW9FACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOh1Hfr151hWESQAiOoIZIyy6xegKHTRKjuSbXcOhQ0=;
 b=RaCCC0Tr6qOPVJfcSZdMr99eRkNt1yb6k8EByaGe2ySQkUaS0gqKqSS2ir/Cq872oY9cf5luwPjAGUUXKxKsEIGVoxmwdiGNzm3zdHFsM0wUbmt06x78fBpdIs/d6aY1CJzGIN52DfOL2QJ/yiRf1+bJhUMbZ/Um4RRh/c+z2wbPpAYcZ83p6PMIga3P7bgor5Vi+6SBQTZMYMImALIxQLfnrF6smJs0crHR/nlLUeGY5dPEknNmhjMrj1sHLKlxmwvlRqJN8rXlA/F/lYO1jYXwuiqUtJpMfnowKosa7lNi+9WjKpfEmJOW1TFHOPannWALsmgdGtQAYI8EHkVSZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOh1Hfr151hWESQAiOoIZIyy6xegKHTRKjuSbXcOhQ0=;
 b=nefi7uoZHuR78B9t55bO8DmqvWizcM8IwnXE+V+4H70EAg7YKiHeUXewJm7iv72nJ4wx/tWh/Eu4Ff+bhNIiIzduOIeHh7Dh5uCVXHSfLm7AVsz7+92fvAEL5e8HpAT+LrPTGtK1KsszuSjvdzjH9har6WDlMLg1zArao9tQuHQ=
Received: from CY5PR19CA0129.namprd19.prod.outlook.com (2603:10b6:930:64::27)
 by CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 08:49:50 +0000
Received: from CY4PEPF0000B8EF.namprd05.prod.outlook.com
 (2603:10b6:930:64:cafe::5b) by CY5PR19CA0129.outlook.office365.com
 (2603:10b6:930:64::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Mon, 31 Oct 2022 08:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EF.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.17 via Frontend Transport; Mon, 31 Oct 2022 08:49:49 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 03:49:38 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>,
        <linux-kselftest@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        "Perry Yuan" <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH V5 0/5] Add tbench/gitsource new test cases for amd-pstate-ut
Date:   Mon, 31 Oct 2022 16:49:19 +0800
Message-ID: <20221031084924.1742169-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EF:EE_|CY8PR12MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: c6288f55-8959-4063-b03c-08dabb1cdee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SqWY2B816qi7FU8lnhYWrxtAsR3zmMa7/GMY1qvtGQWFdh/g88RQZXfSYJWAFPjelnfoYkK6IYFjBscoz+IHEPi1kCiuvBRv2/7mEsuzDszA+rliJHaCWVgCm3Cv9w+kk3i9LpRopLbtQBZO0YRD3s4JblrKY8R9eakUevz8W9rdftMd6S4AscLmeCNNiH95CLHUg7M6zaVBE42my1ZoXHynrPupE3xhijN3ro92BSQojd9sIht5LZYKHM9ZJRazNQfriMWpCAyXfcPiaKxDym75Wj6XMI5iDDrUxPILFpXgbXRF7FjxOLaK1INGZr4xK0VNH5KscJplUiv+QybJbkQpSu1S6+zfG0Bb47aVOzO9xq8AT7MeF0B+9XohL2o6RHbDeHrw4ZN1bzOsYZ4wfFSmx1OdZVQi23AjOUIpnGsqgVDfTI3yePdgBbQ68zC6RMMfJIxztsfUSUaxKjYXryZHAafHuYKRRM+qj2MLw/2GiVjqSjNEWzS3TU+Mvex4SJVM3cZ7856rWWXZvu5IN8n5kxLjaduTqzr2sttF4Tp+SrmZg9ytueuPGAbMr+vxI1XTvhyIiH7I1ATsPkWkANb4CBIqgIRmmT6HiuqN7xOsi6Qp1eCINuwI6RhWynVuCMO95cpGYY4LTnK1VVUdxtJuQwWn3+UnNYN9HDf6iC/+lByb8AHbBXZh3tx7r4gKe+4p9TcS3ix7lXyuAHFaTon/95T7bNL9baRJHowtsTYgLbsS1Ql5NyQOiigh8M7yHJMpYB64oGESabYz7reULHXFg8dJmo3xa53APHMyzDo4PTMLC4bqzLYx9h87vzwd+/6jCiXmJN5ocR77GQKlssDgUb7iRi8iD/Y+XMfy7CrL6cQLft4qEdWMpk5WVamy
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(2616005)(5660300002)(336012)(16526019)(186003)(426003)(2906002)(47076005)(1076003)(26005)(41300700001)(81166007)(8936002)(82310400005)(40460700003)(356005)(40480700001)(86362001)(36756003)(82740400003)(36860700001)(316002)(83380400001)(6666004)(54906003)(8676002)(4326008)(7696005)(478600001)(70586007)(70206006)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 08:49:49.8259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6288f55-8959-4063-b03c-08dabb1cdee4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all:

First, rename amd-pstate-ut.sh to basic.sh as a basic test, mainly for
AMD P-State kernel drivers. The purpose of this modification is to
facilitate the subsequent addition of gitsource, tbench and other tests.

Second, split basic.sh into run.sh and basic.sh.
The modification makes basic.sh more pure, just for test basic kernel
functions. The file of run.sh mainly contains functions such as test
entry, parameter check, prerequisite and log clearing etc.

Third, add tbench.sh trigger the tbench testing and monitor the cpu.

Fourth, add gitsource.sh trigger the gitsource testing and monitor the cpu
information.

Finally, modify rst document to introduce test steps and results etc.

See patch series in below git repo:
V1:https://lore.kernel.org/lkml/20220706073622.672135-1-li.meng@amd.com/
V2:https://lore.kernel.org/lkml/20220804054414.1510764-1-li.meng@amd.com/
V3:https://lore.kernel.org/lkml/20220914061105.1982477-1-li.meng@amd.com/
V4:https://lore.kernel.org/lkml/20221024013356.1639489-1-li.meng@amd.com/

Changes from V1->V2:
- selftests: amd-pstate: basic
- - delete main.sh and merge funtions into run.sh
- selftests: amd-pstate: tbench
- - modify ppw to performance per watt for tbench.
- - add comments for performance per watt for tbench.
- - add comparative test on acpi-cpufreq for tbench.
- - calculate drop between amd-pstate and acpi-cpufreq etc.
- - plot images about perfrmance,energy and ppw for tbench.
- selftests: amd-pstate: gitsource
- - modify ppw to performance per watt for gitsource.
- - add comments for performance per watt for gitsource.
- - add comparative test on acpi-cpufreq for gitsource.
- - calculate drop between amd-pstate and acpi-cpufreq etc.
- - plot images about perfrmance,energy and ppw for gitsource.
- Documentation: amd-pstate:
- - modify rst doc, introduce comparative test etc.

Changes from V2->V3:
- selftests: amd-pstate:
- - reduce print logs for governor.
- - add a check to see if tbench and the perf tools are already installed.
- - install tbench package from apt or yum.
- - correct spelling errors from comprison to comparison.

Changes from V3->V4:
- selftests: amd-pstate:
- - modify cover letter and commit logs.
- Documentation: amd-pstate:
- - modify some format questions.

Changes from V4->V5:
- selftests: amd-pstate:
- - rename amd-pstate-ut.sh to basic.sh.
- - split basic.sh into run.sh and basic.sh.
- - modify tbench.sh to prompt to install tbench.
- - modify commit messages and description informations of shell files.
- Documentation: amd-pstate:
- - correct spell errors.

Thanks, 
Jasmine 

Meng Li (5):
  selftests: amd-pstate: Rename amd-pstate-ut.sh to basic.sh.
  selftests: amd-pstate: Split basic.sh into run.sh and basic.sh.
  selftests: amd-pstate: Trigger tbench benchmark and test cpus
  selftests: amd-pstate: Trigger gitsource benchmark and test cpus
  Documentation: amd-pstate: Add tbench and gitsource test introduction

 Documentation/admin-guide/pm/amd-pstate.rst   | 194 ++++++++-
 tools/testing/selftests/amd-pstate/Makefile   |  11 +-
 .../selftests/amd-pstate/amd-pstate-ut.sh     |  56 ---
 tools/testing/selftests/amd-pstate/basic.sh   |  38 ++
 .../testing/selftests/amd-pstate/gitsource.sh | 354 ++++++++++++++++
 tools/testing/selftests/amd-pstate/run.sh     | 387 ++++++++++++++++++
 tools/testing/selftests/amd-pstate/tbench.sh  | 339 +++++++++++++++
 7 files changed, 1302 insertions(+), 77 deletions(-)
 delete mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
 create mode 100755 tools/testing/selftests/amd-pstate/basic.sh
 create mode 100755 tools/testing/selftests/amd-pstate/gitsource.sh
 create mode 100755 tools/testing/selftests/amd-pstate/run.sh
 create mode 100755 tools/testing/selftests/amd-pstate/tbench.sh

-- 
2.34.1

