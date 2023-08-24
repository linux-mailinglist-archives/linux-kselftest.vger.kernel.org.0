Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18D4786DBE
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 13:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbjHXLW7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 07:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241001AbjHXLWi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 07:22:38 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB0810FA;
        Thu, 24 Aug 2023 04:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ip6PdcikMcGmLDuLFA3qOtY1v1kJ8s4FkONk7HtfuFYVAAN3b3q1KH1G15mp8E2eAYT6EvP3dwtDhzhFz9Tq1BOkqa8aKg345ipEcOB6GgpHa9sy9OsI73+jehV0nyfFyVCBrdzgUyup4az+rd9QOrwMZ0rp/UmngyN7vLKdoiBeq5q6GABvVae4k960m6gO/H5SENpLb2TgHVc8uYYvi7U3f/avB3x9jfvCPub0MaG7rOzmI85AfAv6b1SJZ1zFLzroulRfkw784jC2j8VI3zWwsEfTO8PajAw6XdxCgLYDPFs51aeCSWkjbSg1BJe96iET7MjBmPPr+5txVFHtGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZbgXjDmAjOGB6JTrkqx1k8EpvD7Zwqvs7W6MQ2XHs4=;
 b=XGzDGTsPA/pbygET+jx+l/ImH4LhDhbrvUQfWfO4nE9qsUjLX4nFPla3iMS14a8k0Y1lWm07QoUlAWC6NbVJ7WtVJXLWJLj4QOhoqFDvV8r930ZoXmsE7N5f/5kjVgCYOwoQLnrY6RbeairM5YnIp56/WAwAT/OoWXU8l2a0WTGKKuhUCjHRfDdT7J7AM20eR08u03GXiS2UQJ0503PSJd1NR2M4AkB422xnvD4wV9gtG2HiyLgjDwitG6BvPIYHkxNhEGCcFEwvx08uju5LgaeMDUgrxEeUEwJdNOARwwIzLgBOAMHCPh5kIdS4fvt4ib7htx2BcdROdNA9mdaBCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZbgXjDmAjOGB6JTrkqx1k8EpvD7Zwqvs7W6MQ2XHs4=;
 b=3hPAspD9LRdploPi/YPEVVZJ3FNQ7NYPfnpmpGf+XOooMc77k1g2V+c6Du7E4kAoZzM3q/LUV1ptqgkbsHinrHo8s8L9yMCNKcYO+FN1uqvE4JALXS0QqCAm6CbdWmaH4vuoKMOX98pp0WVa2H3g/+GAKF8VfsCtJTHsp4il6t8=
Received: from PH7PR10CA0020.namprd10.prod.outlook.com (2603:10b6:510:23d::18)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Thu, 24 Aug
 2023 11:22:33 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::15) by PH7PR10CA0020.outlook.office365.com
 (2603:10b6:510:23d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 11:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 11:22:32 +0000
Received: from BLR-5CG13462PL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 06:22:26 -0500
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
Subject: Re: [PATCH V3 6/7] Documentation: amd-pstate: introduce AMD Pstate Preferred Core
Date:   Thu, 24 Aug 2023 16:48:45 +0530
Message-ID: <20230824111319.vyyaxnlpw6wxkni6@BLR-5CG13462PL.amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824021249.271946-7-li.meng@amd.com>
References: <20230824021249.271946-1-li.meng@amd.com> <20230824021249.271946-7-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: c46e0839-e542-4f64-f50e-08dba494691a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQNAlOiHTa/7kdFAzLXpfEBinZdXerO9nI34r88QxFH796mjeZA/SA/khzrnooXEXmm/a5rEUdXMRI1z7Sl8tImnyx8eEuRv9yPhUvhFVPvCqGEaW588tklzYUXOCBo226Z01pZIQOSH9nwyXzKfFbNfvhm/nvtzLew9JdD5VywzGdzMC+bh9+vdPlEx0puZZ9MMJJGth3WpYir7RH11zys7OsCyPKmoj2ASzx8x0L3mDwLsqXWGB+9QUYa2mCruzKYXUiq3np86t7OGMmX6NuHZhdGlJR9yla59na7hFY1ov8B5KKXyB+vNLgZV+hnkFd5PzhcRFtWHQO0tYoYdRUa6vXRN5R6A+YK8rNscQ19IbdLcYi829lnHUQckM7QrJPdgqu10JIOxIHCkRd0aYxLP9Vf+nCF3DQnRPdcQjng+l3EBuRGIYkIR4uvCj3gL4Ar3FbR4yVJSiSJBHvYT//iQ+hkC9iso4OBNKl8Eud+VdRrsLimpJcb54WjspBoaXppQA/iMftBgMuLPwqm6A27uzZ+/OziqYH+2yx+vnNfmUB9Ht7aqx9ONh5zkARWSQfkAKPcM7W6itzx4rk4RarUOwsJYdVL+T4DrWrLhiQGHhbxR8jMV5AHidBSbUSVQVU38xAxH78/nd9FTZBmh7F2E9fVCgJmN06jM5Ue3KmZ0kpdquMHmL+3K+DcyGWGKFc8I2/gsfDxKViKaEEFa/TtWVHXjjpmrpBaoi2MSO/l2HsHMaj90kjhgtdvrMudzq0zVce/7bQnERYOu7k1Ptw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(40470700004)(83380400001)(40480700001)(426003)(336012)(2906002)(40460700003)(47076005)(36860700001)(55016003)(6636002)(7696005)(316002)(54906003)(6666004)(70206006)(70586007)(478600001)(86362001)(81166007)(44832011)(82740400003)(1076003)(356005)(5660300002)(26005)(16526019)(8676002)(41300700001)(8936002)(6862004)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 11:22:32.7921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c46e0839-e542-4f64-f50e-08dba494691a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
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
> Introduce AMD Pstate Preferred Core.
> 
> check preferred core state:
> $ cat /sys/devices/system/cpu/amd-pstate/prefcore
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 53 +++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 1cf40f69278c..2369b58a3521 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -353,6 +353,47 @@ is activated.  In this mode, driver requests minimum and maximum performance
>  level and the platform autonomously selects a performance level in this range
>  and appropriate to the current workload.
>  
> +AMD Pstate Preferred Core
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

---------------------------->8----------------------------------
> +``AMD Pstate Preferred Core`` enable the scheduler to favor scheduling on cores
> +can be get a higher frequency with lower voltage under preferred core.
> +And it has the ability to dynamically change the preferred core based on the
> +workload and platform conditions and accounting for thermals and aging.

Can we reword this like below:

``AMD Pstate Preferred Core`` enables the scheduler to prefer scheduling
on cores that can achieve a higher frequency with lower voltage.  The
preferred core rankings can dynamically change based on the workload,
platform conditions, thermals and ageing.

> +
> +The priority metric will be initialized by the AMD Pstate driver. The AMD Pstate
> +driver will also determine whether or not ``AMD Pstate Preferred Core`` is
> +supported by the platform.
> +
> +AMD Pstate driver will provide an initial core ordering when the system boots.
> +The platform uses the CPPC interfaces to communicate the core ranking to the
> +operating system and scheduler to make sure that OS is choosing the cores
> +with highest performance firstly for scheduling the process. When AMD Pstate
> +driver receives a message with the highest performance change, it will
> +update the core ranking and set the cpu's priority.
> +
> +AMD Preferred Core Switch
> +=================================
> +Kernel Parameters
> +-----------------
> +

----------------------------->8------------------------------
> +``AMD Pstate Preferred Core`` has two states: enable and disable.
> +Enable/disable states can be chosen by different kernel parameters.
> +Default enable ``AMD Pstate Preferred Core``.
> +
> +``amd_prefcore=disable``
> +
> +``AMD Pstate Preferred Core`` will be enabled if the underlying platform
> +supports it. It can be disabled by kernerl parameter: ``amd_prefcore=disable``.

Can we re-word this like below:

``amd_prefcore=disable``

For systems that support ``AMD Pstate Preferred Core``, the core
rankings will always be advertised by the platform. But OS can choose to
ignore that via the kernel parameter ``amd_prefcore=disable``.


Thanks,
Wyes
> +
>  User Space Interface in ``sysfs`` - General
>  ===========================================
>  
> @@ -385,6 +426,18 @@ control its functionality at the system level.  They are located in the
>          to the operation mode represented by that string - or to be
>          unregistered in the "disable" case.
>  
> +``prefcore``
> +	Preferred Core state of the driver: "enabled" or "disabled".
> +
> +	"enabled"
> +		Enable the AMD Preferred Core.
> +
> +	"disabled"
> +		Disable the AMD Preferred Core
> +
> +
> +        This attribute is read-only to check the state of Preferred Core.
> +
>  ``cpupower`` tool support for ``amd-pstate``
>  ===============================================
>  
> -- 
> 2.34.1
> 
