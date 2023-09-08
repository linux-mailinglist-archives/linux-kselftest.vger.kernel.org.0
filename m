Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A76C798385
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 09:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242635AbjIHHtC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 03:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbjIHHtC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 03:49:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA241BEE;
        Fri,  8 Sep 2023 00:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4j3MFY4tU7S3cQy8jq5UPnQtM9p85IKe/mN130QzfE+OxP9oFj9LoNTWjBf2gqY4kc6p0KnoQzRfwhWjRDuI5mQvgsShroZQug1NidE4IpVkwFn6BZxrYWXyL7AeY3JCVv+Y3O11nRwjTgcHwd1f+BpTsELuNoLibammizgkDELg/pcXhG0/qwofJHZU57JOinbTtOyJePos0P+5AEZV8b5gmsJpGUY1sM56+5ymfkNEjqXdHh0Zx09vhwsy6R3TJFGy8lU1X41r/OvwdQplCwr+nsFXH6RTWmsTZJ+uXkHSHx4bNFHlS7VOd4vCUN0qxy8ts0AblRH+a3pQ89/VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g494rm/WucGNct/HgYJq9c6LXzNLWaO7uYjU96lfJiI=;
 b=RuaJ2UBJjsIFWG5fdD7kr6xO8c1/yJLIl4QoiLKi+t5JqmUq/1j+S0LG+37IxsWUEx2VwRiwG/2a0UsgNqMvKT0TCCoRn+wwa4YrI2ec9n4tyiXOlfhQ9/uL4u5GwD+jkzJ3JQhhN5MlyaSMbmRUI9KAOvWb6uKigE5t463woD06QS2x8N7AKf3KbIPPUhIwEhoeNvbJqb6oq32/qSrj4l48tV2cAcsnk+hJ8Mqhky9yPpUkSqoijinUa2sqX/DNtEdxk6bVpmgURJvddTYXsIbkH9AoijtJX5uiIaQG0NvD96Xh151iEsXzH6nq8nXUAhFGsNxgN/hc9iW4t5sOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g494rm/WucGNct/HgYJq9c6LXzNLWaO7uYjU96lfJiI=;
 b=AqYwoHBTFLFEnBemvtiFlqaKnEtvqi2d8dmrKOOiylWswGpWTanWd11VwgZ28Zuzf01YXQfJ+5LExjOHmfj2NEBX8KPo6AmFsId6wV1I/VFwMFhQxeMxe8xM00cHSjf+zxmU7u8KXZPCY4RN+prP634FPPBK2IX0Fsa/06LlO2M=
Received: from DS7PR03CA0226.namprd03.prod.outlook.com (2603:10b6:5:3ba::21)
 by PH0PR12MB5435.namprd12.prod.outlook.com (2603:10b6:510:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 07:48:09 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:5:3ba:cafe::14) by DS7PR03CA0226.outlook.office365.com
 (2603:10b6:5:3ba::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Fri, 8 Sep 2023 07:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.1 via Frontend Transport; Fri, 8 Sep 2023 07:48:09 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 02:48:03 -0500
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
        Borislav Petkov <bp@alien8.de>, Meng Li <li.meng@amd.com>,
        Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH V6 7/7] Documentation: introduce amd-pstate preferrd core mode kernel command line options
Date:   Fri, 8 Sep 2023 15:46:53 +0800
Message-ID: <20230908074653.2799055-8-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908074653.2799055-1-li.meng@amd.com>
References: <20230908074653.2799055-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|PH0PR12MB5435:EE_
X-MS-Office365-Filtering-Correlation-Id: e04172fd-a9ab-4435-c1e4-08dbb03ff1fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0jVADhLQjqe90W9dnezUoOC6VMTq+KOUfnpuAPElrKWGkA8gtovtqj0Iv7HQz4CyXljwzy5wLuaM55Z2sPjm7Cq8p/6l9/pzo2Rm/WiVD/hQwHFzcX6aybkBAMw/03V+bOkThQTplkap6WjOATHCAVuTWBZYrnUSx4zni3EKHFMfqYrgryi7RaH5GJx6xGVgDjB3E3YxQWBbvB1oufxCGUmChLB+W84bGtqkzaqsOUdbhd7nZ1uGcbeDlOodTBYTuDIK5+A7AslL4+jT4ysCml1T4f7KsOT73hLATEGuGgzFUOwD46QQtclCj/0p4nnZpEk3NGMz01FEK8iFNokplqZvdonLpQodYPEsftiEzlrd1uBc5BN93OzS8AtbLaALW5jSUBuSsQNsAm65YMDQTGB4PTiWyusXohqo9CYopQ0yoKZUYb5D8OUBalDMI/I11Jf2c3/pHLBuNplnOA4QkdT4mXQkSh+PC8+6mdVQQqWncuIyzmw7g9QvJy3JE3T5NarAjM9LnnLya03+ulGerVj6rVCobGG8ZbXISC6eVwp51AoUEdEtlDEjjwXUJ0OYPi91Oik9xZ3KxbIf761meR3jSTQ9Ne8j+4i1t6KaBmbq+0y6QQuZB1KGPWarr4PC/iNqbemllKtJ4WM96mLJMVg9VR3xCShL2ZUpJXcwvRXQdi0w0hb3nUGKEYkbl69pmCCbOphX9vUVbjNhV4lmiwJmPdL1ARLHlcjezYxeFDNcrZnmJ/FHAV/+htZwmjP/M3gANR0lT1/rbhSRLl9WiPaf2ikciMj1P8qW2BQE6wz1REcKsigODwZOJuM6lXw
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(1800799009)(451199024)(186009)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(47076005)(36756003)(82740400003)(83380400001)(81166007)(356005)(2906002)(36860700001)(40480700001)(110136005)(54906003)(70586007)(70206006)(6636002)(316002)(6666004)(7696005)(86362001)(478600001)(2616005)(1076003)(16526019)(26005)(426003)(336012)(8936002)(4326008)(8676002)(5660300002)(41300700001)(36900700001)(14943795004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 07:48:09.0821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e04172fd-a9ab-4435-c1e4-08dbb03ff1fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5435
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

amd-pstate driver support enable/disable preferred core.
Default enabled on platforms supporting amd-pstate preferred core.
Disable amd-pstate preferred core with
"amd_prefcore=disable" added to the kernel command line.

Signed-off-by: Meng Li <li.meng@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a0f0ef..e35b795aa8aa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -363,6 +363,11 @@
 			  selects a performance level in this range and appropriate
 			  to the current workload.
 
+	amd_prefcore=
+			[X86]
+			disable
+			  Disable amd-pstate preferred core.
+
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
-- 
2.34.1

