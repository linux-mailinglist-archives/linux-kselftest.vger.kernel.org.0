Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A75792670
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 18:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbjIEQHj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 12:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbjIEBv7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 21:51:59 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031AFCC6;
        Mon,  4 Sep 2023 18:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcMOxI2wtT2peNARo880iecfLKwYOe5aIYf7EiG/BqXikSpCssIsRP3WjBIxYBPnmzYD8dOjPu4Z0/dt9EcrkrmdxKwbj9LFzdR+qt5QMCIUgi/JHOzLLHi72nnxNTS8PQ+jgQmdX9DqM29fH0MuAoTcKrsbpyy93ae5pxn+reYRPuOeFbVdpVpCO4za6FvOgGMq2fsUMCWRDl2MfH5vmnuIYRa+Iz0Otf04mdmFkcy0L6twVEL1NR7t2OQYKiJW5yOYQqx2gdJb011+DWi6YIIwsjgBbW+nmxkqCRbTt49mzAEW7vb0yI5rVbKHFLcn/KgzaY/Y56AmeoB1IIheYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXcj0zXoBF7oX59mcc+xBH+1Y6SfXN3CExtZsfEoyao=;
 b=D8cnPhCOKMkDHyf0djGjfzPXKd5prAx2UoRPTjZH6O18WATWxobw2V0LyW6Z4xKYCzLWQuwARJupy/KGB5OrG9bGgtTN+4gDJZmTeBZvWLpreiiuJdNeUqNeZ/m4MrlLslRWMHCfvQbn1AUkxgIgMhg7Nsl0AqV2B35wukw7irTVOn4/lqU5rEnJVfEaRSj21jlh1P0upW0toP+TRGHFhv2keixNsOOszTK9Deox2pjJKJlOCJcjwlzIjKeoG98S8qEhoneku2xqbCF5QL5AIfYQrLocG9uuB65jrHZ5qAUme8pvdyXMaHCF0osltg4yGVEqJlhoD7Dp7iCmZD7Zsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXcj0zXoBF7oX59mcc+xBH+1Y6SfXN3CExtZsfEoyao=;
 b=5AHOJ/C8TdmHAanRRgb50SNp/DQXLU2jAaKSE4V+RruO7P4exjPW0AxIMUBb0sjsfQYKJsxwAuhpC8h75aEO/GUN4f4dQujKSpYqd/u9M3E2U48AjL5oam25Mx87Y7/Dw0aIWsnc3yD/iSUSU7AwbAfr/B0ZFn9BOw6pjS7naV4=
Received: from CY5PR22CA0104.namprd22.prod.outlook.com (2603:10b6:930:65::23)
 by SA1PR12MB8920.namprd12.prod.outlook.com (2603:10b6:806:38e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27; Tue, 5 Sep
 2023 01:51:53 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:65:cafe::7f) by CY5PR22CA0104.outlook.office365.com
 (2603:10b6:930:65::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 01:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 01:51:52 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 20:51:47 -0500
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
Subject: [PATCH V5 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
Date:   Tue, 5 Sep 2023 09:51:10 +0800
Message-ID: <20230905015116.2268926-2-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SA1PR12MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed5a466-f882-4d28-9fba-08dbadb2ad5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KTou4DNBhntR5WcuTC+lzzZfUcVSSZMO9eWSO6YIPnp0+YhpDuA717FUl4BZD/shS2pivnsZIw54upHEGICNmtp93IBPMys9Efpwk2Lv+QbkoV6fgy08t+15JtDEcD2E0yJWpc3o3LTsWTqaqukIlhcGOfzQqbro909BwtKfas8rZZmOJnDJQgSOr5ugKQfX+V7KpW5HfznEzGm+R/fK5d1H4VDP7o3xAs44kY5PVJNMjWFg4greX/wn46Ltxx7kzWy2roQuHxV+3CHIC5OE8Wm7IO1f2JsADBorqvGn2GyjtzHJcsQGtQIzvJKbzA1zsiL4IGVAyZrEn9CZRfkuDng/rH1FacyzrkkEMHgSWxAXArVGm8ABgF1AusM/MDdUwMwCP4BlHnmUy140EVJ64w9rk9/WQMh3fXKFG59TEsMdVHefe4bNSBfPxMAr0+BFTy3J1pQO1m0eVIY+gvQRaxqGS6JTsBtsg/IpL6/xB89eC4XmTs+EGeXHrdI12cSo1BeqiXzSnhCwppINZnqD1rMCC49IbRh62KDSvNNoZu8v4OSqekO43p79Bet8JFY1oGH+xWzghPs1KVbD8UbVM7dgSzlSW0uvvwwYC33NDiqrxWZeuraia0ODMKnqlvAFsKPbfUdXNlF251JMkVmJxmQWt2IqEEkLgcroP74s5zl/SfxlDjMc8Hu3Is5dYZ4oQZ3Bsc78xB/CJ4UeCKUYWx8Jwj5UMxgWHLMUQvfiOCKl+Mlnf3LlhMQIEcYoZT9LTPStm0puYqlCN0eQeAq8XA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(82310400011)(186009)(451199024)(1800799009)(46966006)(40470700004)(36840700001)(356005)(7696005)(6666004)(83380400001)(478600001)(4744005)(336012)(426003)(26005)(16526019)(6636002)(70206006)(41300700001)(1076003)(316002)(54906003)(70586007)(8936002)(110136005)(2906002)(4326008)(5660300002)(8676002)(2616005)(36756003)(40480700001)(47076005)(36860700001)(86362001)(40460700003)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 01:51:52.5716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed5a466-f882-4d28-9fba-08dbadb2ad5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8920
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

amd-pstate driver also uses SCHED_MC_PRIO, so decouple the requirement
of CPU_SUP_INTEL from the dependencies to allow compilation in kernels
without Intel CPU support.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 arch/x86/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8d9e4b362572..887421b5ee8f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1052,8 +1052,9 @@ config SCHED_MC
 
 config SCHED_MC_PRIO
 	bool "CPU core priorities scheduler support"
-	depends on SCHED_MC && CPU_SUP_INTEL
-	select X86_INTEL_PSTATE
+	depends on SCHED_MC
+	select X86_INTEL_PSTATE if CPU_SUP_INTEL
+	select X86_AMD_PSTATE if CPU_SUP_AMD
 	select CPU_FREQ
 	default y
 	help
-- 
2.34.1

