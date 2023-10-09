Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DBD7BD33C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 08:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345181AbjJIGTd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 02:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345177AbjJIGTc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 02:19:32 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD93A4;
        Sun,  8 Oct 2023 23:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/AFXgcJ4NnYcg7QMcarPomnPSqxZ4FD5clZM0O0DKetgZ5FYkFsHXYFy/Llau6+bTwEPf33YobU+ZCDC4UBPr8wbVzfz+4nfEfUQAjhTvJJzjfrNKgDFAx9/DDqDy7JjjEc6Jayze4kfcaG8E0kuGVG99bgKbnrDrZA1xw8o8y5SooTVcdRWGhRuo7AA999snMryjrGPYLGhCiayg64UAXq2gMeWcfiO06M8wuMMjEwGJewkNg1XQ55MZeeeItz3zsJL+BgzrIZp6/0jkowQnxg6nEai2RQLaRWdDt90Vq0AASRGXCMPFNEdTBdsqLuu2okkmtYV+n2AhcdZH9wnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqC8VuNGif3oYAT80V9LQKYxosisrbD1HTPgTXKK40Y=;
 b=JwWXZcS5xvxnzo9qtj79tDmJpfbEmIq9vRmNMkT64h0d0wAAgJO8kuZTAUiy4iSpiRBmKJsbt0qSy5S/qQeKXS8rCgoo2BJl0RAG1UNY/L7XlZ/hKApe+jQrEnjPbsBHic8KJq30mMQwFL9tmlTAoxKbGcDtxSkQMbMLsxYs6h8Sae5i5ENvYKvdJTEJtjMt5yIPfOthCmlMt4wc9knurG8nifW9HLDN2d7r5fNdlAsGcgmGfJAjhiEV1BNF8+A8JoSJumA43RTFWuO2/6jQWdW17H+U2FuHY5e/QvBYGO3bdoacEu+4iHSy7dRE+j9e0kZWl8y+VEg7Pr1Z3tYjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqC8VuNGif3oYAT80V9LQKYxosisrbD1HTPgTXKK40Y=;
 b=goJ+Ojk1rHWhba/CJ30VHV2aFwcw9c3wfAoH2Zlf9RqHzLzhSH6EGlKWFmJQ+KPzknd50FWYgwXR6gNfhx+M199qrmHVQQF0kVL9KBvuwWAGxgSeoW5zM7UaXQ/8nUrF2ZNy5Cmaws75I0aj82AzTiPpYuQLDkuQ6SUNmkJ7TIQ=
Received: from MW2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:907::31) by
 CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 06:19:28 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:907:0:cafe::31) by MW2PR16CA0018.outlook.office365.com
 (2603:10b6:907::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 06:19:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 06:19:28 +0000
Received: from BLR-5CG13462PL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 01:19:22 -0500
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
Subject: Re: [PATCH V8 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
Date:   Mon, 9 Oct 2023 11:49:03 +0530
Message-ID: <20231009060917.ayqb2akceu5jf5qa@BLR-5CG13462PL.amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009024932.2563622-2-li.meng@amd.com>
References: <20231009024932.2563622-1-li.meng@amd.com> <20231009024932.2563622-2-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a12029f-18d4-46b6-db46-08dbc88fb145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUlDFznctJ3dJpSUr24ZXHcuKDMWBgcgNjEabyz0jQ9nisld2ZMGn58A7KdWXv6Hc6XEEarurgP7iorD3S4KxZ9DoCwRCz9VVMhWtiZYi2AEUdj/tLkpmpVtAarLKyc7A86EwEm12MVztpgZqZFCobs3pj7WOslgPogu9ixXL3KyWFtdLT83N/P2mW+h6jajLdBWNs1MRpsSqRMpDkGF2WoahWN+Z6fElr437QourztE9rdN8tsWxW/nvOO0/rqxwCk+Ld0qxnmj7kvRLzUpXRz9lZmIZPRsomnvOkSwEPtrhQCoMTyhFaqN4P2+iwqtMwwZqTFHP8HJsqSv50a4/WZkpti1ALGKetFu0T4QjeZh+5h4UtzjyjFIF7uwPRGA5eT9trZsbgGP0iUwQKTkmHoNFTqWaskfgC0zB/hJmnRVIvCGujE1mQYQQZhrSx1PSp+T3atmLnlC8xYGuEbBhebp9GJ7OOU7lzn/eX67Tq9hhNSRvjkBcpJlJRfgY8ZYx5gOkXHLHAUyVR4CEmw0xAL9JR7bsW07uRcAEohnTSwvaIrLeTWCQPg7oM3e7WN4t6k9fp5FiwfcOJOKkIBM05i2wtPyqRDLyfttPxHBpIgAherFEn7PUoV238+OM+QPQQq09Q9xncg62fRvV2rfLPpAtrHjrBkD0cQr+xg4OPobdmJWRohM8h0kuTo+fnwvfA+oGDOVDR1yAij7j+Xm5kdD1WdkIYJfAIVvRhKG+/hWSlnZ5b+hKt3UIlxUHAsRApCzsmsTczwSPS/KB01xaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(64100799003)(36840700001)(46966006)(40470700004)(55016003)(7696005)(1076003)(478600001)(41300700001)(6666004)(336012)(426003)(47076005)(26005)(16526019)(83380400001)(4744005)(2906002)(44832011)(5660300002)(70586007)(70206006)(54906003)(6636002)(4326008)(6862004)(8676002)(8936002)(316002)(40460700003)(82740400003)(36860700001)(356005)(81166007)(40480700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 06:19:28.1518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a12029f-18d4-46b6-db46-08dbc88fb145
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 09 Oct 10:49, Meng Li wrote:
> amd-pstate driver also uses SCHED_MC_PRIO, so decouple the requirement
> of CPU_SUP_INTEL from the dependencies to allow compilation in kernels
> without Intel CPU support.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  arch/x86/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 66bfabae8814..a2e163acf623 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1054,8 +1054,9 @@ config SCHED_MC
>  
>  config SCHED_MC_PRIO
>  	bool "CPU core priorities scheduler support"
> -	depends on SCHED_MC && CPU_SUP_INTEL
> -	select X86_INTEL_PSTATE
> +	depends on SCHED_MC
> +	select X86_INTEL_PSTATE if CPU_SUP_INTEL
> +	select X86_AMD_PSTATE if CPU_SUP_AMD && ACPI
>  	select CPU_FREQ
>  	default y
>  	help
> -- 
> 2.34.1
> 
