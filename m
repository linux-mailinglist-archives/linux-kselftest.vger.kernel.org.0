Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD2B627597
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 06:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbiKNFlW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 00:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbiKNFlV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 00:41:21 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC691659D;
        Sun, 13 Nov 2022 21:41:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyNq4W25DOREWO3lxE0X2nz84oFdyMATR9JQKy3deM2JTFqe7lRY3PKCn59Lm2l6ILgKlh3EoQn0VstUY2gIKhqlS9ECDd+Y7Tniey8EjzIWT2x8rBD9ZJEyHciCXebcnYaxpmtbxYpbp7JWKji7B1LdPzIyIKElm+5gJd4+GW35uEf1GqVspYzgajDwNttKSLzg5rZfzMPMCbXSw4knZjMdql1jC/6E6glSlTG6hVyQf/IGLnxAXTRAcI4ovzltOVavDmiJ8uL6uB2c2L+TcjtZylhlJepgb3OHa6pwMvqaocH6XpnaAzOGV4H6W//uS5Z6CMYI2+0aLomUxu3dzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qg8LHW1a1gmMbxTUjSBPVVzIGSUhuO9nq0XXzrz1gEM=;
 b=AU0feHxOJ9frKbIuwCxYlVHIa2Mkvprdzy7IVF3exVQrH+2Tv/uQm0fuBjIqmy+ynWwYkFMmOxyg02tZFy6GfgSfLDuHFXXMAHFBTg9f4sfsfQZKMX4l+1Wz1ZK046+V5us+XiptIY3A1dugNhQAhmHhzZB4iT/nz4jESjQmW4nTe8dYNUW0Aw2lRhHSow4ScgNnQ2UNkgvS/FRYaj3gvGEnS1+L9QD34E6nyKPOa93zIaoIQc047ycThSj4WwEZvVBdwWuibAMRmA58K4b1vvQAJXQTAS/MZXEGDqKnLeD9/oD22e1qb33ipaqyABaCTFqTx14SHSDYdPWvUgx+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qg8LHW1a1gmMbxTUjSBPVVzIGSUhuO9nq0XXzrz1gEM=;
 b=Qx4M97jU5FqWut60yQLA2ZF9de3sqXOrBqKBTB9/KDVDRBlksWChX9I9Ys+zK+b1FZ/FtQ1MRi9/i/C5XpYnzbrrBgq2cLRsJ/VKTrT0FQfPZaicr2IP18MsfYcyFf+5fQ9Vf61z7KW88yHJ9t4S7bO+ZhB5LqUgYGtM7qQ4Wpc=
Received: from MW4PR03CA0324.namprd03.prod.outlook.com (2603:10b6:303:dd::29)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 05:41:18 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::e4) by MW4PR03CA0324.outlook.office365.com
 (2603:10b6:303:dd::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 05:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 05:41:17 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 13 Nov
 2022 23:41:12 -0600
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
        Meng Li <li.meng@amd.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] cpufreq: amd-pstate: fix spdxcheck warnings for amd-pstate-ut.c
Date:   Mon, 14 Nov 2022 13:40:37 +0800
Message-ID: <20221114054037.2962372-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: a0797486-e112-4274-8325-08dac602d9ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+CFI8mIyfWex1MYNvtHBxhsawkQ8yQNkA1GPZHG3Un8tVhe8ArH5fBGixJAQIuhFFX0FYgnNaOSA69euEhgMi6zEICGqpO8O69UzD4qLTiNM1hfozWrBTzWU9+1Oq7o8xlx7oL67afrbtyXTTkrN6KgnSN6E0QJEc22W1p4aEWdzopBVqBM0bIrZ3JVX8e2Iuk0Sv8vJTewdhMCOR7JSi1HT0F9w4YZQtsugYcIzQyQ/+5t8KsWWoFLsuF5VQchMvg9ZJb1scIYkMqRvXrXCxfAYBjFCWICg+2mzSm3aCMpS26L+1WGhuaMtGHrnUAbWT8uJzdlv1WjBFl2EIG0dEeVhgYlNcOLEOAjXo+fTIkV+x142110Fqtnd/DB1mUaG3c4XQSg2SbegByBWA/tvL6doU6o+BECD7qtk4y3dOxmLX0s7KWcvrneLW0hzyAtQi6h69orIPdnv+Buir6bSdf9b7abnPJeOAqiM4XQ0yVheBCVTSa35Lf+DOivFUUBjir8pr6mfXxhPjmKVOgwm0gPvViXgdyPTNFAIsGiljBGmTW9mA+peYudZcQNiQZXWL80s6mGHAy6QiaZ2r9gGQHcojb8y2jaLtX4Tlr1Co0ZNK3h8j/9QtOzrzFULjyfEtB88CNfROEdcyIlQIf4iYl7BWXpbXhljZv7K0YEAne4nQBwUU3RpU5M+BtvTs4/dDJFynXjNYfMigJY1euowBZaiXmw+qrKmzcnT073B0YofqFDF4xRN7dEMY9ZxRrPC6FMWxJubXQ6MjWBw0tyz56p4oJSHJFcaeMgXR0a/jg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(86362001)(8936002)(82310400005)(40460700003)(36756003)(2616005)(40480700001)(41300700001)(70206006)(70586007)(8676002)(336012)(47076005)(4326008)(426003)(4744005)(5660300002)(16526019)(1076003)(186003)(6666004)(478600001)(26005)(110136005)(54906003)(7696005)(316002)(82740400003)(81166007)(356005)(83380400001)(2906002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 05:41:17.3370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0797486-e112-4274-8325-08dac602d9ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

spdxcheck warnings: (new ones prefixed by >>)
>> drivers/cpufreq/amd-pstate-ut.c: 1:28 Invalid License ID:
GPL-1.0-or-later
   drivers/spi/spi-gxp.c: 1:35 Invalid token: =or-later

Signed-off-by: Meng Li <li.meng@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index e4a5b4d90f83..7f3fe2048981 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-1.0-or-later
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * AMD Processor P-state Frequency Driver Unit Test
  *
-- 
2.34.1

