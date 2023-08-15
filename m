Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A25277C7B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 08:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbjHOGT2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 02:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbjHOGSO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 02:18:14 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D193B26B3;
        Mon, 14 Aug 2023 23:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBQZk2YDzZjRbDyMJKJT4alVTnLui+ZvWRHGGDfV4z/cq24+9Vvlqu8DKNXhqGakw3wwfYV7eldMsj/MGyjkdA/zNO+EapB/YyLBV7sJIKX3CMpzyZmihfbZwp+K9pHJ2T8wBXhl6h06jZ3iKd7C3v52HhtLxIepN/aYxyHWzXJ+PE8XRrc5c1VEBWW4XJhojwrpkeNkRa4Mj2gH3MWDT1U+TfWuU8k7PXk5sDP1Uym76YFWtVfV5/W+pUz4ZesWZxPVWpUQ4kPp6wQWwWxTe1HPKBFzMVGkSpLReV1nR4CRgxQFWnuSPksAhi3b4tRtIofsnYl9MDxXREHHB/mLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD5SW4ZMZUACDC28VDgFXSClMzlQYedjVWuE+bSD/4U=;
 b=L2tViCdkb++o2ecI5tti4EEwJt7DwqZJRqOy7U3TkYcydFk+d9fLNEaOgHndxm7WfIaPm4qPJBGNbuZpkkLwfvsubx8UyV7GgLEM6yDpTkwzSbh4d1hNqi8thw1BtnlYZoLDGItFjgaaMCBhp9xDNWMLQor4avloBlF4YtcmiiBdo3eUZYb2oXXSnY9mwQl8N6zA5ZdW75im1dNA9YgI57NnT3bAyZwv+v0jV95vqWibGvrXiELQEOWv39mMgS8w4axHIzEIC96P4g/CihIxQbYoLpNqblF4KCYuwvLk4NXaaqsUuf7+YDT2e2/wKldy1MdE24pn6CrLqCjLdn1tfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD5SW4ZMZUACDC28VDgFXSClMzlQYedjVWuE+bSD/4U=;
 b=lf0/2wmscXW7GiId4MTQzSrNqpus+ndMkN+wupy0PexDhOUgDX1AslumtETI5hVpAzO9ftzfjV4V7dYn8gAV5dSQ9IiPgaiEP1FcSEI5K6qS+aUv+WhA7dCr66CwuwHovIllqaPk13eEc1nZNXxG348uVa0vJGNc9VdbYBFfvrw=
Received: from MW4PR04CA0140.namprd04.prod.outlook.com (2603:10b6:303:84::25)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 06:17:33 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:84:cafe::14) by MW4PR04CA0140.outlook.office365.com
 (2603:10b6:303:84::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 06:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Tue, 15 Aug 2023 06:17:33 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 01:17:27 -0500
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
Subject: [PATCH V2 7/7] Documentation: introduce AMD Pstate Preferrd Core mode kernel command line options
Date:   Tue, 15 Aug 2023 14:15:46 +0800
Message-ID: <20230815061546.3556083-8-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815061546.3556083-1-li.meng@amd.com>
References: <20230815061546.3556083-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: f101cc84-d0a3-46e9-6b01-08db9d574ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RHaqXVRk2Jj3xamC56i2BJ8MPGNKkOw/pPlu50JDEtxRw0XPj5JP3nrhkgS2SH8A0R1OOVYdRQdPYMMDe9qWvUv/de/Yiobayx6/b58H1N//Puzs2sEBiEt4vD/AodOV46OPT7TzAPtsJLQLBxSjHOLqqXgeCw+ZfuawaN5i1XBg4f8rX8It0Sja6RC93anMM9cnnBwYMH/CJgj9g4voR6DzxiR+NdQ3wmksj981KjMGmD7RCnXBR/+vUIMT1YT4NxL6ptC262JoHocrpPdX0LS3gduV51qgvkfvRsKFYkEK/g7OJzGgPYC0rdEHgCkhZ5ei1lZKK3f7YSOnyulpVwI95rr6qgHLrg+P7MXoBd2PR9yhNmxLneShAC/khkeAqXwPj10plY9vAUFE7ive5qLwA+sQrLjz7/zeddr356a3gaFlD1MSadtOCzyebG8r8WtAKxpgFsivKnUGqPwiAiLrvhVHCgBLcjHbrwOW9f4eajC/dQu8OKVcnmPP5brVbZ2CHBWVwg7Ftb2aHGFzjBVq+Fe2ZiCdku84vD6aNUJWq8fD6YawPZCNRTMpQFZNx/UQMnIKN7aRK/F+LQhPfSId40Ham9XAd0d6TiQyrPDgKE9pm2PTUFO9n/Fn5aCKXgdFzlxOk+PYTKg1aMQHlcDTgfb8/O9t6OfuZ5iN/AbtJEbPF4KH1j7G6uN2y5sPvQs8zVtHbDJlRWcmgMsfIzOuT30O6h0vvKB3fA0+sCm5ZbVPWtLve1lFsFGL0PhAXVbTccO7wEK+bl0dXltEkReFyLg8eoPfpVgfCWCvFHbirp/yNdgKVWMUnjCbpF5
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(186006)(1800799006)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(83380400001)(36756003)(426003)(336012)(47076005)(36860700001)(86362001)(40480700001)(41300700001)(478600001)(356005)(81166007)(54906003)(70586007)(6636002)(70206006)(316002)(8676002)(110136005)(5660300002)(4326008)(82740400003)(8936002)(40460700003)(2616005)(1076003)(16526019)(26005)(7696005)(6666004)(2906002)(4744005)(36900700001)(14943795004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:17:33.0931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f101cc84-d0a3-46e9-6b01-08db9d574ffb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

AMD Pstate driver support enable/disable Preferred core.
Default enabled on platforms supporting AMD Preferred Core.
Disable AMD Pstate Preferred Core with
"amd_prefcore=disable" added to the kernel command line.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 23ebe34ff901..4f78067bb8af 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -363,6 +363,11 @@
 			  selects a performance level in this range and appropriate
 			  to the current workload.
 
+	amd_prefcore=
+			[X86]
+			disable
+			  Disable AMD Pstate Preferred Core.
+
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
-- 
2.34.1

