Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509997BD34D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 08:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345206AbjJIGYN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 02:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345168AbjJIGYL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 02:24:11 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE6FA2;
        Sun,  8 Oct 2023 23:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImejjI24d1Hth2pXWAarnUCstxomRYBYrN131sB/6DfHoZUvbWz9ndjGhS5hq9sMBI7qRbG0Fm8wRtuNhscJHHQNGmzbh1uwiptsykxAasKlLu+l/JPs0IBBUMc70B9NUsmcudgZhymBTc6w3pnjatKUcYmFXMkeA0MoTiLSjNA5mZq6Y1Yc0k+JTCkResNsTMpbP9oio5ad/3bJ3brzl/BAEDnbW2sfDkuKYl4iBz2vDouBgAXwxdgwc62SsqU2QqucDzrxaIwcUH/r1x3JuN9XIW714rCyS4z7mbg5plzM+ruTHSwUMF4CLuGw16gBJIySh3OsMcXzlM/Tbv7fEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aT1Er/rn0mAaHdkWHSlqF0IhSqNQdOXq7TNsL9660rw=;
 b=ELJe4Uh05i1JfJSrsa6+KS89rlj5zfObpvxBwmj4EKhLhZpibYeP7P6wZCqbvQxkp1yLoT4RSoc1sowItUqgR21VTQW1rDEAPI/+QirScFtB1FBevH2p7yVjkMkxvFMdrzgUdiaRkVUkv4F1vO+3VE7V4na8zf9bVSMYwYD+S18ZXTdtzYdmXCABou1wjsz/Vh/EsK7jXEpWqzCvXRHryxkf5uv2FX1gG+st6auocqp0TMiCJIksvwPO0Nx8gbEqJBJWVmlozdbyz+by2e6qTwuly34d8sfPl6nH6Ww+oqoYiK/rxKvZplrMZNUmXwO4ZFWrs1podmXspinlh6B/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aT1Er/rn0mAaHdkWHSlqF0IhSqNQdOXq7TNsL9660rw=;
 b=0iyNXLmh+GmTQ/GuArPOneLnSCWsdIuTGKhKOzdspwcWI3909jSAOuuIKh5XKInKvmWE3A2WmhENmoAImNsTBzViii3RBhyScz4T3rq+MBki6G0PM4tmMXdJfJ/i1Y1rT2CD/4jo9VeDAtQxCwmD9Pb9nRHOdvA5iO35tqcwR/s=
Received: from DS7PR03CA0145.namprd03.prod.outlook.com (2603:10b6:5:3b4::30)
 by MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Mon, 9 Oct
 2023 06:24:07 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::7e) by DS7PR03CA0145.outlook.office365.com
 (2603:10b6:5:3b4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 06:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 06:24:06 +0000
Received: from BLR-5CG13462PL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 01:24:00 -0500
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
Subject: Re: [PATCH V8 6/7] Documentation: amd-pstate: introduce amd-pstate preferred core
Date:   Mon, 9 Oct 2023 11:53:48 +0530
Message-ID: <20231009062310.5zjzg4avv36o4vvg@BLR-5CG13462PL.amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009024932.2563622-7-li.meng@amd.com>
References: <20231009024932.2563622-1-li.meng@amd.com> <20231009024932.2563622-7-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|MW6PR12MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7df083-25cb-4c8a-8d19-08dbc8905712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oy7pof0bm7moXO9vxnHR+xeWKfug2GKBtxfS4Qu6/NOgd2tyaqcpq/OOIV8g1OPgrRYzDz+qMk8rlQ5yoSJJQ+9ZXotXxHim8X2yEpod3gw0uXjMXHGJcLw6aGq/eKYj8C1FyxCg2B3APoWJf91wEWTwhEe+RiIXgjUeTJEESCaJlgcjIi5GPoQeuKxuSVxwuSDqSep8MD47icC+B1P1lRFXvsUmfRETvB/KRUa9C7HLVgGsvgXwi8eGmmRt4s2HzmSAC2lwdKHOQsK3Yi9BBw2/KlsIfFQOUl1AdCBVxQyxS1EXeJlSnYlGUnXMn/g92adXaiTYehsxyVTlZ6gJpJ2QsRm5UzO35MritKBDp41tT9RdJbGbWMGVyCm69dMc5toFgt/RK4mkBqd//NveI1xWUbWhGni01/0hYZCgCG7quiraTwerlSV2A2bHQNvPQNb4/V+vdSPV9vSSUCjlxW8A81Tytv7ceRWHjRcVVDf7lm/cjYXRbcdPILzDnlRDxY+0EJOnmudCv3BdmtpqcDBkDv1tSkm6Qlh+mxCj5xKjmu6aprGrEFevh3q7ux4l4j64UZDPhrvFkfQudE5btGD6R61hAc8LWiw8pX2YbcWhD7E7im+yxTjrXBLlYLfa+ZDpHinXTHtWdGBk3pK+Pec5+QCz0T6xvQhiwdcKd7c/DFOLKo5CjUF/eN8RqRrElCjUXKluSioYNW6kF/FjGvLs9v0OVl4uuCvdm23L9HYaMq35OaTHBtNI0NvaJzcB0+98fD0ysVFGjEG6/dgF4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(6666004)(1076003)(40460700003)(40480700001)(55016003)(86362001)(36860700001)(81166007)(356005)(82740400003)(26005)(16526019)(47076005)(426003)(336012)(83380400001)(2906002)(7696005)(478600001)(8676002)(6862004)(4326008)(8936002)(70586007)(41300700001)(6636002)(316002)(70206006)(5660300002)(44832011)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 06:24:06.3955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7df083-25cb-4c8a-8d19-08dbc8905712
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760
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
> Introduce amd-pstate preferred core.
> 
> check preferred core state set by the kernel parameter:
> $ cat /sys/devices/system/cpu/amd-pstate/prefcore
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 59 ++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 1cf40f69278c..0b832ff529db 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -300,8 +300,8 @@ platforms. The AMD P-States mechanism is the more performance and energy
>  efficiency frequency management method on AMD processors.
>  
>  
> -AMD Pstate Driver Operation Modes
> -=================================
> +``amd-pstate`` Driver Operation Modes
> +======================================
>  
>  ``amd_pstate`` CPPC has 3 operation modes: autonomous (active) mode,
>  non-autonomous (passive) mode and guided autonomous (guided) mode.
> @@ -353,6 +353,48 @@ is activated.  In this mode, driver requests minimum and maximum performance
>  level and the platform autonomously selects a performance level in this range
>  and appropriate to the current workload.
>  
> +``amd-pstate`` Preferred Core
> +=================================
> +
> +The core frequency is subjected to the process variation in semiconductors.
> +Not all cores are able to reach the maximum frequency respecting the
> +infrastructure limits. Consequently, AMD has redefined the concept of
> +maximum frequency of a part. This means that a fraction of cores can reach
> +maximum frequency. To find the best process scheduling policy for a given
> +scenario, OS needs to know the core ordering informed by the platform through
> +highest performance capability register of the CPPC interface.
> +
> +``amd-pstate`` preferred core enables the scheduler to prefer scheduling on
> +cores that can achieve a higher frequency with lower voltage. The preferred
> +core rankings can dynamically change based on the workload, platform conditions,
> +thermals and ageing.
> +
> +The priority metric will be initialized by the ``amd-pstate`` driver. The ``amd-pstate``
> +driver will also determine whether or not ``amd-pstate`` preferred core is
> +supported by the platform.
> +
> +``amd-pstate`` driver will provide an initial core ordering when the system boots.
> +The platform uses the CPPC interfaces to communicate the core ranking to the
> +operating system and scheduler to make sure that OS is choosing the cores
> +with highest performance firstly for scheduling the process. When ``amd-pstate``
> +driver receives a message with the highest performance change, it will
> +update the core ranking and set the cpu's priority.
> +
> +``amd-pstate`` Preferred Core Switch
> +=================================
> +Kernel Parameters
> +-----------------
> +
> +``amd-pstate`` peferred core`` has two states: enable and disable.
> +Enable/disable states can be chosen by different kernel parameters.
> +Default enable ``amd-pstate`` preferred core.
> +
> +``amd_prefcore=disable``
> +
> +For systems that support ``amd-pstate`` preferred core, the core rankings will
> +always be advertised by the platform. But OS can choose to ignore that via the
> +kernel parameter ``amd_prefcore=disable``.
> +
>  User Space Interface in ``sysfs`` - General
>  ===========================================
>  
> @@ -385,6 +427,19 @@ control its functionality at the system level.  They are located in the
>          to the operation mode represented by that string - or to be
>          unregistered in the "disable" case.
>  
> +``prefcore``
> +	Preferred core state of the driver: "enabled" or "disabled".
> +
> +	"enabled"
> +		Enable the ``amd-pstate`` preferred core.
> +
> +	"disabled"
> +		Disable the ``amd-pstate`` preferred core
> +
> +
> +        This attribute is read-only to check the state of preferred core set
> +        by the kernel parameter.
> +
>  ``cpupower`` tool support for ``amd-pstate``
>  ===============================================
>  
> -- 
> 2.34.1
> 
