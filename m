Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E0D75673B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 17:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjGQPMV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 11:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGQPMU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 11:12:20 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBC6F9;
        Mon, 17 Jul 2023 08:12:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyLPZ4K5ewp5jwRncvmglPTSYy4nbdAFbdQO4dgfM7l6Ssva1eSWUtZN+rX+33kyceCQzxj/KGuhGyLa+7j505fvkFbfWleUo92uo/kQRyXpJE5h/IJgpGs1C6g/sKTHXgjuamCZN9DoMXgrAXGBzPuRv7d7DBt+v62tpqBIAOFeaQeoq8KGbPL3m/Zl2vnxPOAAPfGh2KCpS6t36vY341WYwGwk7CzToAx6MVI7IBxkClhBjJrkLQASgWnaOOCu8pn/XZ2XwtKDHsQIYLgJuszbeV/xDQigyqqsGKgSL3GsTGxHWUFe4xgntgmQlGQrQSkNOG9+I5jw796bGta06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orrmkGYlJkFYtXbIwzLNCfB8YCCoOSNd7H/Ukj5E1PA=;
 b=X17valy+IKr1Sxd7peofz3TIr+p2FSMGua4EfmOl9LKONCpB0OXmWl7wtlWUkFij0jlMie0qecXZCHxGrVxm/9awN0D0SrhBtXWwapkPY21RtOTKpR8wvHuFl4WGan78POXxKWCSovMJW3QvQTbFRcckH1Z50AXPYnrSJ1f0TwtaIWvS4LU8/7Y/FaXcXFMsnj1HlkKaZA5jErM2PsUYvEEmDqpWrcGD74A65SSBLULl1QCo5KAqgEWYq3vDZp3Oho7tuFIFtEO6tI/+Z8fC1ZZUvVkrI2Uk2E5+OfxirteyvPZjoy/hR3qzQpk4JCQaSGbrSnfEq9QPVqYyYXGkVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orrmkGYlJkFYtXbIwzLNCfB8YCCoOSNd7H/Ukj5E1PA=;
 b=t8qvhB54mBJ+QZ+eamyr6850mLC/URjY8xpGDHEFX46nK+GZRAHNr3xFsXnyKFFg9yQ8Xymctl4CVDT9uS4xoim3dv+0pdyemq/X4xrU0Te+PIIfz1DgbFAUDrgl+6mhtmVRVD+6+67iSBh+LoM5hylyGrZouZVEwWzpP64Uky4=
Received: from DM6PR13CA0025.namprd13.prod.outlook.com (2603:10b6:5:bc::38) by
 DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 15:12:16 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::70) by DM6PR13CA0025.outlook.office365.com
 (2603:10b6:5:bc::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Mon, 17 Jul 2023 15:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 15:12:15 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 10:12:11 -0500
From:   Babu Moger <babu.moger@amd.com>
To:     <ilpo.jarvinen@linux.intel.com>
CC:     <fenghua.yu@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        <maciej.wieczor-retman@intel.com>, <reinette.chatre@intel.com>,
        <shuah@kernel.org>, <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v5 00/19] selftests/resctrl: Fixes and cleanups
Date:   Mon, 17 Jul 2023 10:11:47 -0500
Message-ID: <20230717151147.317263-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
References: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT024:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b32bf5-dd17-4ad0-4009-08db86d834a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aiHp8mucU9JvoBbIy6vg+sFWiSiLdY8lEv+QJCF95UOpUmV165bQRsqt1NHSrH1V/f5JmF8bjTRlPIFwobCqITrHYioUhLS4ZPe0PHTBdMuIMEefe4dIisOU6lYivLdVZvjkFK68dplO4SxIaifdRvbDSISv4UHp4ti7iU+GjZtyJ4SA6UOnwJwaj6TkCTQhhHqxcwdW7/D670W4EvOs0R/C/5eQbbyO5WdMwzIkaG2+GWnttNL5eZ/CzogutQ+48Fkpb5bhjqcH2/AcfKo3qKHHHK5EDHO5CYYwLM47tQ0wExhoXBeDA//EJY0ssottvGeH4V1PimGkcoP8/LldCJSQwYEKaiok2TDgqSjmWwfMYKjXPTwWtrNR9hiYGgPPo7AI3Hr94fTXiKaTXEmRgvqZy4Yilwx6C4AAoWF2LIgaF5Oql4Jh5LyriHgkU5/GUxeiKFVcUYUewtKRIfXGgyywMUJEu1F7Gu1dtqUSYWDonlqTSuxOgfnHmZilxMIr/s5u4UChbgvlshucNvLSvx3lcPSGAHf8As8Qkf4YKhu6BX1SWeIXG7ValVeH9CmGiK4hLJ1nnoAJQy4Z0Kmk8teryOZ/9W9c8pBqdNs334Lu1N7tZjoTlLOZt2Hrspg2pcF/6+YLnjXIzo64mjsNE2zC1Lzr57DODvCnAY8gnAYSgE+wOWIq1fNYh6pbEwfv3V2/t98bL40OR8pmARWiOI0fR9rNzHj9dxL/O47aGjhDmPyaLVp5QZW2Whh6l3yN5Sg4HqOTUVYNbWhMDc559g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(54906003)(478600001)(6666004)(7696005)(1076003)(336012)(186003)(36756003)(26005)(2616005)(316002)(82740400003)(16526019)(2906002)(70586007)(41300700001)(44832011)(6916009)(70206006)(4326008)(5660300002)(8676002)(8936002)(81166007)(356005)(86362001)(558084003)(426003)(36860700001)(47076005)(83380400001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:12:15.3182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b32bf5-dd17-4ad0-4009-08db86d834a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo, Thanks for the patches. I did a quick test on AMD machine.
There are no failures. They look good.

Some of the MBA tests are skipped for AMD. I will take that up later.

Tested-by: Babu Moger <babu.moger@amd.com>
