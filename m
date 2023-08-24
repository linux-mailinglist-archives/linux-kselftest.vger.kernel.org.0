Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30131786851
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 09:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbjHXH3g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 03:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240337AbjHXH3F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 03:29:05 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF36010F0;
        Thu, 24 Aug 2023 00:29:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNadpNeBfjv2c4X22gopoiKoluNmBCVXlbJRV3XrS9z//JwhemKfOuSKzlHCzOJGO5XsmsrDU+Z8SeCFn4bPS53m8/KZuBqFQ+rlzCqTNe5gOiB4JJP2GkhmUN9kYqzR+WaDlbZWduAwZgqWe6uSfUvfV3Aa4BIbgaYKilndhOMURVSyDtAptnyY78KFx1vUuETpiisHPtIsREIP9dORT6mEfG5liujvqxoD/maJnXWOhD50TMjblTxMCzZFgVgBHsS+tFdtQKenQ0s8sBuoTbCsWu/V/Yw83VwqXwdbQiGITu2YuzhREoe0yXSLhLxTR4T6a/uHsXcz4KijchaW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZBITAc+CgZ6VIUX/b6hjVcK5HADETNXwnZGZQyduEE=;
 b=Sh2mZ878a5DojpItY0ja4nc+vqgZ2M3dRrHNUf9C2JMM9Guo++vE2Sjc1EDzDPOZUAsrs589xHSR0Hzcc8aZI61lFKC+sKvgIExVI1pkQ9m5+rG9KUZZYUHvSw6riSpte0KvpUZxqVXcd5OXT1HrXe7LS0E20oiT6rNMi9bzLmLMQh7/ZcPNu3i5nMXhCyCNEkeUdYwupUnecFTEgSBV7Ygnjves52gmiDLE/3Cu71lVa4VMfEffhwaK/3JT4MozPkmc6tdwwH4KGrTLNRCpRvZdwRRpiLNiBAyc362ItQaSBlqGiJt2sCE+PtJd1p2IpRKknmkLLjxwF74Ld6K4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZBITAc+CgZ6VIUX/b6hjVcK5HADETNXwnZGZQyduEE=;
 b=YSpFqTQvnfLNkIkWR6YBerrgDRIZmnESZQHD3ekVWLF/ps6KFWbvGfKvugaWNT0zdF5Tubqtcsi/jO2y8dcCheTViPbhGI353ZatlQCEMHtsoJkfJvKqm89TSGZz9V7+roQvGhj9wN2VTACVOgCepQE7CPVDrlp9GHJuqehRd6M=
Received: from DM6PR03CA0062.namprd03.prod.outlook.com (2603:10b6:5:100::39)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 07:28:59 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:100:cafe::a8) by DM6PR03CA0062.outlook.office365.com
 (2603:10b6:5:100::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Thu, 24 Aug 2023 07:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 07:28:58 +0000
Received: from BLR-5CG13462PL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 02:28:53 -0500
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
Subject: Re: [PATCH V3 2/7] acpi: cppc: Add get the highest performance cppc control
Date:   Thu, 24 Aug 2023 12:58:39 +0530
Message-ID: <20230824072644.gysm34qtqq2acw5k@BLR-5CG13462PL.amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824021249.271946-3-li.meng@amd.com>
References: <20230824021249.271946-1-li.meng@amd.com> <20230824021249.271946-3-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: d905b10b-66dd-43aa-7286-08dba473c82a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FgxbFP9Dlq4bSLEYxn1knP/NNHBD6GKmogUF4a5QVpc90DwbLwfjS6NzoGOshcgiKltdJhh0LiQO3AYwMsEpfMRKj4ozVuUwPMPY43tUe2QaDLdx7SfrUH/fNO7nI8/68rGdbCcOxwz5K6CH+9GbA39kSTVLDoG4bBKA0/rZP/e3QAtfP1TMhROCe+Dbi/dtEuBe+qxDJBL+kj9RHx6NBXYCSFjKCJXuKfny2NGJTWv1OYMdpRcc+AoGQrA+sqmAdW5Ii6yllU+bFyavIERjUOWEZMsSZSE7QXc7jmp9ahHYpZF+CIardHgEayWOFmNvCN5K4tlLqxMcHDW3H/dKzKDau3uq1Azh8St0zsU4Os3KUXgarjvzewa2Zb3V6fdyBP9bg2thBCRFB6V5cm0MV/yNeDbGwsKFYyA97JO5zPiEj/20vp5I+yEZEuW7+lfy9aPnk+pDY7aBjYyBLP9zJD+IWGCXLY7eXcEPEjyjb+EHuvQWo3rx1BLmWFm2wpF+zVnC/iM8aysWLsLvhiZ6SwNR331myJBbhZeWwzj9XYW+yLb9FDNh+Z+CopW+uOiNLJkFTGxN9NuD4niSz8JdCTzJplYlXzwR+2h/SaVfR3fdh/bBln0ZZvyw8NjvYuPOqS0qU6USi0cq8Zt0bmdjSeA7CiYy93ACGOQis1pIG8jpJz5jDXTxcYkkHtFWp1Rako2g9IxVN4BT3Nr3+WhKjQxHbEMjHJ+Auiy/9hadNRrTpLgc2zJhmdd2ATnvZgNFgypAyAhBmQbrWCDmuc1u0/Ccgt7YvwRWyUFjSriGagw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(1076003)(40460700003)(5660300002)(4326008)(6862004)(8676002)(8936002)(336012)(426003)(47076005)(44832011)(36860700001)(55016003)(26005)(16526019)(40480700001)(82740400003)(356005)(6666004)(81166007)(70206006)(70586007)(54906003)(6636002)(316002)(478600001)(966005)(41300700001)(2906002)(7696005)(86362001)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 07:28:58.8382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d905b10b-66dd-43aa-7286-08dba473c82a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555
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
> Add support for getting the highest performance to the
> generic CPPC driver. This enables downstream drivers
> such as amd-pstate to discover and use these values.
> 
> Please refer to the ACPI_Spec for details on continuous
> performance control of CPPC.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>

> Link: https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html?highlight=cppc#cpc-continuous-performance-control
> ---
>  drivers/acpi/cppc_acpi.c | 13 +++++++++++++
>  include/acpi/cppc_acpi.h |  5 +++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 7ff269a78c20..ad388a0e8484 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1154,6 +1154,19 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>  	return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
>  }
>  
> +/**
> + * cppc_get_highest_perf - Get the highest performance register value.
> + * @cpunum: CPU from which to get highest performance.
> + * @highest_perf: Return address.
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
> +{
> +	return cppc_get_perf(cpunum, HIGHEST_PERF, highest_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
> +
>  /**
>   * cppc_get_epp_perf - Get the epp register value.
>   * @cpunum: CPU from which to get epp preference value.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 6126c977ece0..c0b69ffe7bdb 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -139,6 +139,7 @@ struct cppc_cpudata {
>  #ifdef CONFIG_ACPI_CPPC_LIB
>  extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
>  extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
> +extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
>  extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
>  extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>  extern int cppc_set_enable(int cpu, bool enable);
> @@ -165,6 +166,10 @@ static inline int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>  {
>  	return -ENOTSUPP;
>  }
> +static inline int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
> +{
> +	return -ENOTSUPP;
> +}
>  static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>  {
>  	return -ENOTSUPP;
> -- 
> 2.34.1
> 
