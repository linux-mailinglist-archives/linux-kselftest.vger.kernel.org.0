Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C12786D98
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 13:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjHXLTq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 07:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjHXLTU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 07:19:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1556110F3;
        Thu, 24 Aug 2023 04:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaTBwfXVKBz+2Wc3YYFbqm8JEjC92JAZDQ83F775Pb4UBKezMRy+V+cbHV79pl6kprl3q1Obrdb/O7b2bgadwllkn73KFRanGaR2zvRUvYPmZ5cHDfuDXhxxS+4C84jbM1aKA030U3cKRkTCm2ybTSfwgMgSUl27BvzbRkg7LqxmwzNPtWKFIwIxsi2vaYclB+x3qbW4YJiyj+viVi//INoC2zfPg5pWGub457gV4oJZdPiv0vouToSH9ahi8AMTP/UUHZmrBYXXjRpLC8r5kCnFobOI6qRgEHL+upMGDedVFoUmWcsd5yYxrhUcmMoKm5PD3eLdBTVzyXCFaTMklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5tKlm0n2eSgG+wMWjeSh0PQlUEtQOmZ7IwgmtijtaM=;
 b=X2RL82ci1s+oMf5Psf3mbbdexabAv5CImbUPgYJ3BnSvH4VIGdWCjf8mIeEza7Okjfr1b+HpyOAhDZ3svRXko9J5QZ1/tUDXCFdsYIplgVV80uIgGS4kY82FQPPPf6O1cbMqgUDFse2mOdFgV8Dkodt6kMckbBB8Gqy/mxd2uH+UIGc4nr/GeAqJUC3mnSFmYvCjNAGfr2VfE9PaBjdS0L1VScc44c5bOsGEbh6jKtToLLw0YhrBBOVwC4bcMiH+hKnylqfmuaUmMGZ/5TbqONuo2ycjFnCQv9gAlBLoBRuY8QDlVCwCn9DaMAv8gUnATXCiEKahKkksupjnshDJWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5tKlm0n2eSgG+wMWjeSh0PQlUEtQOmZ7IwgmtijtaM=;
 b=parsDJkUs4c6ojtYr9Nq0I+f16AbLGhRScQV9V2nKHHpOiOSuO76BDV7qmAhjVyAFM3AZOFKQO6XRyCGu/9yh7ojz06JAa/fKmY3DWeC4XHjh0YftviaMwANj0Rg7I0VlUSu+8zFAHltTw4ABnNMkjZtVZ5w00lf/SCGsv9uPYc=
Received: from CY5PR19CA0086.namprd19.prod.outlook.com (2603:10b6:930:83::11)
 by DM6PR12MB5517.namprd12.prod.outlook.com (2603:10b6:5:1be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 11:19:15 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:83:cafe::ff) by CY5PR19CA0086.outlook.office365.com
 (2603:10b6:930:83::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 11:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 11:19:15 +0000
Received: from BLR-5CG13462PL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 06:19:06 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     Meng Li <li.meng@amd.com>
CC:     Wyes Karny <wyes.karny@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V3 7/7] Documentation: introduce AMD Pstate Preferrd Core mode kernel command line options
Date:   Thu, 24 Aug 2023 16:48:41 +0530
Message-ID: <20230824105935.qr2pbt4utegulug5@BLR-5CG13462PL.amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824021249.271946-8-li.meng@amd.com>
References: <20230824021249.271946-1-li.meng@amd.com> <20230824021249.271946-8-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|DM6PR12MB5517:EE_
X-MS-Office365-Filtering-Correlation-Id: 19766e3c-92c7-4ee7-fa83-08dba493f378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zncRFqrpzVwu3NlfR///Gmi1h/V2Lqf0APxCfJJlGEVKH6F0oDCZ4Ol7xyXDdSuiItKcdTBIIQ8OeokJoP/ZekjE05hnBGo98o9ZNrh5Svy4PmF5KhCp/ADTERViZ8Sq8QBrhecQXpqOtMpjcKfdt5GnyxNIXmxXLtiBjQqrxm3ROK7XOt1dZhuKY93uLfplNgkMzNiCO9IU3Vne0SDl+Kw1Qu5te+GwZRg0Qc3RFVlpUDLpTKVUUjyqXNNC9dKNrUXnHJ3TW8OtKB1zU655HQPX/FyV+GReN0GZBzlafDI2C8hvGcx/agVyhouJsZDDdeh8uHqJcBDCYZqkyeh0kpDYGbqunMmuB0RIg7adMooWS1As7O4ujF/IPbE/9b+oCC9rP0+Kma1k9oM0X6Nuy/2PI/vL2arwqB3lbCZ4oIadu+9GkeNoEUVX/FRqOPPXVOvKfIvlbMqC0ONdwDSNzV7CyoKJkIs2D0u8me89jPx4iexvi+JFCPq2voz33QjW83/Ly0b1nW27xAPgMmDOFewv8vr+BhBB8j9OcvJv0dC/Pv4DGXmEJfOLzzSWxfNr54gRzJ/+uReBMAXlBrXTvZHCWKmy1AbHsOo8rWr83Hdd6CylMu8yogRXB/I+C08cx09KsGrjAYW6rx4imLhTYMTjWjz0iJEWJCYoESYXSOKwG7E3xxtlR81CzdvfBn7LzuKaJSeUlKPkFwhJG2SwbGZAl0R4Hfw1r3r2TVbQK/G3rYIj0OjIdI5coL9D3ZQ1yupGyy7vos1P13Bn1t1pZQGG5NJgOLd91Isc+KbOqfP8JVzmhzjC2+0QziOvOgJL
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(1800799009)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(8936002)(4326008)(6862004)(8676002)(83380400001)(5660300002)(1076003)(336012)(426003)(36860700001)(47076005)(44832011)(16526019)(40480700001)(26005)(55016003)(82740400003)(6666004)(81166007)(70206006)(70586007)(54906003)(6636002)(316002)(478600001)(356005)(41300700001)(2906002)(86362001)(7696005)(36900700001)(14943795004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 11:19:15.3121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19766e3c-92c7-4ee7-fa83-08dba493f378
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 24 Aug 10:12, Meng Li wrote:
> AMD Pstate driver support enable/disable Preferred core.
> Default enabled on platforms supporting AMD Preferred Core.
> Disable AMD Pstate Preferred Core with
> "amd_prefcore=disable" added to the kernel command line.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 23ebe34ff901..4f78067bb8af 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -363,6 +363,11 @@
>  			  selects a performance level in this range and appropriate
>  			  to the current workload.
>  
> +	amd_prefcore=
> +			[X86]
> +			disable
> +			  Disable AMD Pstate Preferred Core.
> +
>  	amijoy.map=	[HW,JOY] Amiga joystick support
>  			Map of devices attached to JOY0DAT and JOY1DAT
>  			Format: <a>,<b>
> -- 
> 2.34.1
> 
