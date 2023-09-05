Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDD279280C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 18:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbjIEQHR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 12:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245149AbjIEBw1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 21:52:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC48CC5;
        Mon,  4 Sep 2023 18:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOJqaabI1TNuI3jIbpNxVXwWT/iVdJtPzkkL8A2F+hMIu0E08sPF68s7srdpyQAgIscURrs7aHE23olnYTVBJ8GJcx/jfMhEcr00zUZx+upmTooetaEBCJFHjNGJ+6jLAm2SlmiBmXn7WgMgLEBgRPEeqZUAhLjrn7WayDVJfI2+z06qpaiSizIAxo6empN2prm1SKDLL5OCt6JuJJ6jZTHcLLVYwc+wtifxICsEP2wtaDpdxkkLtI5N7vV1myKhD+Hwgw/PUl7JMSIACh55EofrQ9NgUeDs8ysCF0JhFlTkC4zT2H/kaKXmojxlnmcPtyfC/It9KOjs6A9pDlGerw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k806WqW+2azCUUAWHat1FO47DTtuctO5wUBOpKQwBFE=;
 b=iWOY66CMqZ2wHQnDcN6GuvCBKiTyJ1LKt1rYS5W5QYxtEPegqjlDv8m3cgKGCgHSSHK5Mv3vdFPkfqZKTgWxeda2ppn1UdCDBbw1N47lG+/t6Nwi8BAjQUk0ctifcuW42BFd4KZodBMfKmadW5HWhnfHYCoxYsS8zRVHrMBIXY1JWYVfMYCkQkTeFhysNIsbVGqieQfOy0CgpmHFxxJYhpXngRt8X6x8tmp+ghd/pO9/W/O3dNTRjpLxcPN0uc6l77LoSRtgdcNlPFSt+Yg7h2Y/UJEicp9GvhkD6OTtVeS8GBy6zOO6j5AcNc/4q1JlKei6OGdVo7fhPMH/teCIjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k806WqW+2azCUUAWHat1FO47DTtuctO5wUBOpKQwBFE=;
 b=PsDIogYJYtZ3pVT53lkmBqLZ2wQ6Kt2IXn5s2eBewNcmweCC6WSTRIWkrb+T33hfbDKXC0JSE0499Ooxlf6fP3suigl4J26iPj/ibyLCBdS564QnlqFs4AfEktyJY3CogPjjrxOHp96VB88euPJQN5LCZL6TMZJeA+9zX4Evl7A=
Received: from DS7PR03CA0182.namprd03.prod.outlook.com (2603:10b6:5:3b6::7) by
 MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Tue, 5 Sep
 2023 01:52:20 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::e1) by DS7PR03CA0182.outlook.office365.com
 (2603:10b6:5:3b6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 01:52:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 01:52:20 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 20:52:15 -0500
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
Subject: [PATCH V5 7/7] Documentation: introduce amd-pstate preferrd core mode kernel command line options
Date:   Tue, 5 Sep 2023 09:51:16 +0800
Message-ID: <20230905015116.2268926-8-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905015116.2268926-1-li.meng@amd.com>
References: <20230905015116.2268926-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: c2be2836-8fdc-442d-ce9e-08dbadb2be0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YiyulUUoQ7RHhNG7+ugLgXuNHeKPOt3OyOSEI52gBPv8vdifE4UsVlKgHa+Vaund+FSQTijxRVm6rvPKS1U5vo96kVXVjP/4nyYdd2Bl98djbo7+4bUxjXwDfsDB688gPVFeBvH99GvdzkZANX0aZ1ez5pqudwgPALDmxPQAqemkz2V8A0c/RDTd0NBRsLWFAu5E7JozTpbXiR82eHFFolYDCIhYAqgNp+Yqc/OvofbZGYE7DaMsLBmUP6yjTI/8fcesycE8eCt/pFlnp5ZtF47YhmE/1aXEEVNVvnsLR/EUxlF2rKn9DDbKkbrhvSvCaDO1zBfSi9u6vtbXqJIQZpJtYGIXTICBM1/9Eeutg9rSGcxEqSFYvA1sDkZ2vpcfkBTYwdDbSFs78L8hMlX1OllRBflfNVWZlFFRQmg5xThkf2b0FawdjXzHWZVVHv5lQlRIjp+ZZKici/a78q//FBdPjgSOm9E9CxdkPtN/uLB7cUjBGxPBiMYwyL3FnS0fFDXZ5aGyZxxkZ9i5YKtbnOuQKUiwuBsO837Kw7ewfKRCeqHDzzw6ioDaGvysXwu4H5yghJKiA5oJj4fLYi6EwSFKMPbMC5olPUp/+lqY8iCDD7Bjjj3gsBck453t4yx27KP2QrDxCR+aMoIPgI6zRlOajMmieqFGhdiZMPuqUOVXaH38YJ1ADAtyjQTNoRqctYSBxV1OqonjTVtAC0WM7r3WWdMUu0e73AtRtxI5fI/vI4kH0Ogyi3r5sN5cxFssu7e/3lUI6zTflrepqBEoPLE/y9UyM2PEwjlZVnzmNdWA3aVB+Qa/WWIBWjV7U7GJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(186009)(451199024)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(54906003)(86362001)(316002)(110136005)(6636002)(2906002)(36756003)(70206006)(70586007)(40480700001)(8936002)(5660300002)(8676002)(4326008)(41300700001)(40460700003)(36860700001)(2616005)(426003)(83380400001)(16526019)(336012)(1076003)(47076005)(26005)(478600001)(81166007)(356005)(82740400003)(7696005)(36900700001)(14943795004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 01:52:20.6454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2be2836-8fdc-442d-ce9e-08dbadb2be0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
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
index 0c38a8af95ce..3145782b3c00 100644
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

