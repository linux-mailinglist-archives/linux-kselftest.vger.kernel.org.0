Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AB86D19CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 10:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjCaI1h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 04:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjCaI1g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 04:27:36 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9F7B47E;
        Fri, 31 Mar 2023 01:27:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2qZOkpL4S0ASs/Jm+jszKYHcVNqvQ6iIRhiZGnoKZTGnwg4iivNfZbSXh5jKA+RHmdqxwmo7ym5NGr1lxkip9xViHvY6tWf9ryMVi1CaXekZMEej1JRLxZUfPoKMYjyMVpjevhL/kczS2JS8E0S6adV5DLeuNgBFFP4Gzbon0cLZAKo06ddiEbt/Mq7QhLLjL8NyZGAGwGRbQvyVKI72m7vEemLqc6Jmtife7mLOKv6MSRf1klgyB0rTIZfeXsMRxI88bQs92D/0cIf17+1iRnQlQJ9J2k2u4pxG98JW5ecxWLGozal8ILghrqG00qDzXBkSM/wdDK8gHbmATMv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GGFQPPqTdbYTqGzC6KCqE64r6rbLoKauTEbT6dEQtA=;
 b=RguAUPgxvUIMbhQ4knj6QtVnKFTE6kHu84cZ+WKhk4biFvKrqPykDjv0U2VO5bzqeKFdmYPzITWv9UVBquc47ERWh71jjV2YS1D11oROiTLvXLN//Pct+XlsuxWKksTsgmKP8C1yapBR5rDXg9DDd7B1uH0XMOPb7ZlBEE65Wh9EXq/3ktYgmMLknQQYMWvPNDx7YK60sPWF4z1T0sCNhf9Lve82WUvC+Gpnhr6f2xX2xWJ/RlaWTE1VkdS6P2E/jdw97uyICLzoXQJPtksI+MNirMo8XWMYlcZHWxwPVEGtym22DmzXmwaMHudSnImYTrEpq3dEhURu6Ev4zhY+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GGFQPPqTdbYTqGzC6KCqE64r6rbLoKauTEbT6dEQtA=;
 b=5sEoVJYA6VEWeL8J64OcyGOH2et3tXVYwTvasRrmd0ZSQ4QK6WhCNnvFIPDRSXp+fhbhuqz2ium2mAZluzWaNFjq8vscz/2nGKfi+56ht42QW4QmwPv6jUy4sZfDzVEr9BEcUuRk4VdrLdGmYFk6RKkg437RkYs2Mkfbo3l7mzo=
Received: from BLAPR03CA0162.namprd03.prod.outlook.com (2603:10b6:208:32f::22)
 by MW4PR12MB7437.namprd12.prod.outlook.com (2603:10b6:303:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Fri, 31 Mar
 2023 08:27:30 +0000
Received: from BL02EPF000145B9.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::3d) by BLAPR03CA0162.outlook.office365.com
 (2603:10b6:208:32f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Fri, 31 Mar 2023 08:27:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B9.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.35 via Frontend Transport; Fri, 31 Mar 2023 08:27:29 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 03:27:26 -0500
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
Subject: [PATCH V3 0/2] Add speedometer new test cases for amd-pstate-ut
Date:   Fri, 31 Mar 2023 16:26:57 +0800
Message-ID: <20230331082659.1887946-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B9:EE_|MW4PR12MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: b926ed4e-3e6d-4719-ea9d-08db31c1c49e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: upahtV2+RqcrA/KRTZdZ9QQNhFd0sXV4Cd+g12LoE7okj0lMh0dextmr58kQFl7hiW7nb2NdsdJOBQduL+2o/MVUNgI2gGo+AKP+vwOWWRDI76mzStjBzSb61tZ/5Gm1F9RuJalLCib8/UXZgdVKZZS0h/oRlkKqHrOs7qad23IFQlzJ2f1wY/Qi9dXgfRCkWoXAj8YJREL+SvOk4QkzkiDTLljGfo22owoEYQrbFlj9ZBUdzlszHoniWtvvZgif+3Dt9dDVW6yDz99GkZMeDz6d7gMoqgOFZQ5l5CQFOO248DNVf5/OTpcSkumU1T8RaIiXpwTzOG/DC4/h9f1X1u8GCz8Io5uaLnT+APEsqV8xQL51BbEQxrVYye+5bfxpeCYuFWwqDD8ZaBHTvExEt7H8sErI9gvMnTgymCU4PrsKAzpFMVtH6D1pDvsq2BC1BCmho22spiq/K4j6DmlSkCpc4kpS53j7h/iiBrBMCs/VxYq659XWdo+LoPpliWbZnMHRJNITXz3t5vcYSJCE1eEsM+XiN87RGHlSl3cL1I2ZRuxXYcWYuLmXWJp1Pq/HmWXiU+tGzIXcvxEbDJFlo4t7YSX8WkTRU5UCXhX1bVYOxLQ08cNTBVqOklAqF+FkGMLk5ytRy3DGWgf6GlFHPrtI8s69T3F+3vTujUXY/0i7yq7xVNdMvujTxiyXwf1jEfzT8DtZ38NRPLbFLqaDCh5YGZXcDc4jpYF/YZli4/TP0Agq06vI00OphnDYAWH3BIQbrwkq2qo2v//zVZTRmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(7696005)(40480700001)(4326008)(70206006)(36860700001)(40460700003)(41300700001)(110136005)(8676002)(478600001)(316002)(70586007)(82310400005)(186003)(2616005)(5660300002)(83380400001)(47076005)(36756003)(426003)(86362001)(54906003)(336012)(82740400003)(16526019)(2906002)(6666004)(26005)(1076003)(8936002)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 08:27:29.9786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b926ed4e-3e6d-4719-ea9d-08db31c1c49e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all:

Update the patches base on the latest kselftest/next.

Add speedometer.sh trigger the speedometer testing and monitor the cpu
information.

Modify rst document to introduce test steps and results etc.

See patch seriest in below git repo:
V1:https://lore.kernel.org/lkml/20221025100910.1682567-1-li.meng@amd.com/
V2:https://lore.kernel.org/lkml/20221107011127.1818705-1-li.meng@amd.com/

Changes form V1->V2:
- update the patches base on the latest kselftest/next.

Changes from V2->V3:
- selftests: amd-pstate: speedometer
- - modify comments
- Documentation: amd-pstate:
- - modify rst doc, introduce specified test case.

Thanks, 
Jasmine 

Meng Li (2):
  selftests: amd-pstate: Trigger speedometer benchmark and test cpus
  Documentation: amd-pstate: Add speedometer test introduction

 Documentation/admin-guide/pm/amd-pstate.rst   |  88 ++++-
 tools/testing/selftests/amd-pstate/Makefile   |  13 +-
 tools/testing/selftests/amd-pstate/run.sh     |  32 +-
 .../selftests/amd-pstate/selenium_server.sh   |  15 +
 .../selftests/amd-pstate/speedometer.sh       | 348 ++++++++++++++++++
 .../selftests/amd-pstate/speedometer_web.py   | 106 ++++++
 6 files changed, 585 insertions(+), 17 deletions(-)
 create mode 100755 tools/testing/selftests/amd-pstate/selenium_server.sh
 create mode 100755 tools/testing/selftests/amd-pstate/speedometer.sh
 create mode 100755 tools/testing/selftests/amd-pstate/speedometer_web.py

-- 
2.34.1

