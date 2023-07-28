Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B517663D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 08:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjG1GBo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 02:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjG1GBn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 02:01:43 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0089026B2;
        Thu, 27 Jul 2023 23:01:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwPpoi0mJFzBbAvr/tWkfPfS+K6vmjuUlx+Cw4AIlak3vgil1C7Kn8iOz2KKsId9xhZVwr+1NdezoKEVmI5fN/95Dmt05+Y6wXy7ajPVYfuFcSZD5bR7PQa1EfjQAalZNzjDT6Rtfg+7neRJmhym1pVoNKoXLfpCV1snQOho8myQ54nxhqFJGhgGVSJ0PqCoz9tuvmxwOWTWYqjO1k4UxTF3/enxHIyj776YUHtCJLo7k9GK67P2kEyKgZ2N6s3+xYhWqHNNPVjoqBHwQG6fBjMAAYP28PZblwJgqUkRV4bhWQW3XYDSmbL3bIR+49Zgi6/XNka/YFTnhLuKPjkKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8k5sm2gmo/Nz50bnBBKQQIabGJ3btvovva/VqkeocM=;
 b=cAHZhwD4OSIhKXNQr7atMw2PsmUEB4/UHbvaVJU7KZYWKxYVAZpEIcyzHZnWnMzdTM1eEupXRxG0TRtnvEsMHW5c62DojqFC1DOPHAqiQGHCLBsKneVxSPsh1ufng/ttrIrag428M8wk6Ud8xwnc+2l2LF3MhzIALqQ5DkviRncFVaa0vK/lvQyodBsIR2O649rsE9kAyOsjtdl7cyb3+s7ZTHscrFq5NhHXxWwBZMLNNt9c5Mnjgy2NUOdNwizMbBbTC9g3i+FalscDplHi9dVyMvxkL+rC/xW/H4jY3LRUpWq0cIyICrKl4brSouEUt7M2y04gG34BlJwV2hT4iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8k5sm2gmo/Nz50bnBBKQQIabGJ3btvovva/VqkeocM=;
 b=uETzK9WtggVDmb21tByEbRHr5mtStWQXqS/FUg2NlbknkYm3KxIDcM59T1ByzhoEBZ/9fiWeP0FF8YNlZZtXK5nO1OgJbRgR2ipfOUajXr/YXH89N7OELABTqzQfnyzk+TG7REIq3hq+8QBrOuPfagKpu9BsvkKmxhIoCesPCrQ=
Received: from CY8PR19CA0046.namprd19.prod.outlook.com (2603:10b6:930:6::10)
 by MW4PR12MB7431.namprd12.prod.outlook.com (2603:10b6:303:225::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 28 Jul
 2023 06:01:38 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:6:cafe::c6) by CY8PR19CA0046.outlook.office365.com
 (2603:10b6:930:6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 06:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Fri, 28 Jul 2023 06:01:38 +0000
Received: from BLR-PF38F8CF.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 01:01:33 -0500
From:   Ayush Jain <ayush.jain3@amd.com>
To:     <akpm@linux-foundation.org>, <shuah@kernel.org>,
        <pasha.tatashin@soleen.com>, <zhansayabagdaulet@gmail.com>,
        <tyhicks@linux.microsoft.com>,
        <raghavendra.kodsarathimmappa@amd.com>
CC:     <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Narasimhan.V@amd.com>,
        <Santosh.Shukla@amd.com>, Ayush Jain <ayush.jain3@amd.com>
Subject: [PATCH 1/2] selftests: mm: ksm: Fix incorrect evaluation of parameter
Date:   Fri, 28 Jul 2023 11:31:08 +0530
Message-ID: <20230728060109.4403-1-ayush.jain3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|MW4PR12MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a035107-a299-46bf-7543-08db8f301b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CsVB1NNIwYbkBb8Dzw9odCc5Ni/j6O11QeUb/LPoS4gf4TjNS/u0kFxqcw60C9qZtpi67oT5r0EOQADSYIbopHbRbZm3LsJdy14B0qLvpEx3kjLUgR2rDeBSuFCSJiazgnLzdQrXz3lsooqV6U6CWxk+wOnmId7Yp8MmDCcSlWfpIKDhqFhjugNTnoZGU7X4LDnSV5FmboamZ+Kg5vBDQFMAjDaue77FoqbsV9NX37vjdQySWjEeYKoTHUctTZM5e+LKmb+GvmjU8km6jyM9dcA6+zFAfiCGx+29JHGnR6TbiCDWhIjse9aOBFu0kcKfti1zYYPJUSuVDL+dIuagQ7Na6Tn/1rRAZ3JkXstySNsuvSstgnRHN7/9IXIL/BU/g2uGeSBBKiuLyej0JTqvB8H+dTAU8ElyLUdyoQ0DXxi2sd0bkwhmCGOE5zeSq9Me3j0M+bVYA6/n1u7Stxl4i2g1xzdOBxTHb/ioWKQpB7guwz8FWNqvRZJc9HH9Iso5Jw97VJmjycWHvKDqjRQwusggZXxL7jcZpSZ0zPdPcNrZehHLZ2mIQz5KTmDq211scXAaln5F4rkGAMSJ23MCFpBZOP8xIDajwVP8Yo0sQEfpI6q7PNdGHgW/FpJQwyH6fla97zqdXx9gKt2VyrlZPc2BhxhKKSYX/kLJgFJFJkGr+0PYHMiCxRB54ufbDPQa9N2BedpI9Nw1oJlQrD+VIuB+JtOlrN1CkEk7RkJMQIU9f8AmukfPSAsZhD9dhPvqvIM+NF05lu9sd74DsMdKUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(336012)(1076003)(26005)(186003)(316002)(478600001)(70586007)(16526019)(6636002)(70206006)(4326008)(41300700001)(86362001)(7696005)(8936002)(8676002)(6666004)(54906003)(110136005)(36756003)(5660300002)(426003)(2616005)(2906002)(36860700001)(47076005)(83380400001)(40460700003)(82740400003)(356005)(40480700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 06:01:38.1619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a035107-a299-46bf-7543-08db8f301b53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7431
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A missing break in kms_tests leads to kselftest hang when the
parameter -s is used.
In current code flow because of missing break in -s, -t parses
args spilled from -s and as -t accepts only valid values as 0,1
so any arg in -s >1 or <0, gets in ksm_test failure

This went undetected since, before the addition of option -t,
the next case -M would immediately break out of the switch
statement but that is no longer the case

Add the missing break statement.

----Before----
./ksm_tests -H -s 100
Invalid merge type

----After----
./ksm_tests -H -s 100
Number of normal pages:    0
Number of huge pages:    50
Total size:    100 MiB
Total time:    0.401732682 s
Average speed:  248.922 MiB/s

Fixes: 9e7cb94ca218 ("selftests: vm: add KSM merging time test")

Signed-off-by: Ayush Jain <ayush.jain3@amd.com>
---
 tools/testing/selftests/mm/ksm_tests.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
index 435acebdc325..380b691d3eb9 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -831,6 +831,7 @@ int main(int argc, char *argv[])
 				printf("Size must be greater than 0\n");
 				return KSFT_FAIL;
 			}
+			break;
 		case 't':
 			{
 				int tmp = atoi(optarg);
-- 
2.34.1

