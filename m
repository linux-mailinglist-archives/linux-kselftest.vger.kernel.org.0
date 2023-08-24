Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B1F786D9D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 13:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjHXLUT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 07:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239369AbjHXLT5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 07:19:57 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA7B10FE;
        Thu, 24 Aug 2023 04:19:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gx58AIUTc2o6zk5y/64PVmIs6X+9biK/T1naH2s9f4JwM5mtlETBeCES6PtlON26JRcNpVeYsc6jRLk2LoahbnjWDoclbeCn95plVB8ms0CnVb9PP9QLF1zdaty3i4RG2o+GbRw+gdIlmL57XKdWGg6t3HQQVCnfg9C9Q7ujlpLzN3YCsT2Td/VRnnbm72vSPjjJ7su2WODA4NfjzV+gv3H95EbWjGT99Rj12HpVUAlaxcgASSltnqcA5rOeR2Cw4fmV7M3yuZQVeAhSNpGtNk7ZNXRpT+3Py7VrjSu+y7gRmqW9eskDIre65DDNMehPobHP8gcDjNsbn/fFMdiUKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZBITAc+CgZ6VIUX/b6hjVcK5HADETNXwnZGZQyduEE=;
 b=dV0QzG6IxkbUfz8Ny1prWAmPVZmh95TSbvPR1x1+uLLfO63xZ9EC3ogcRnPp52tlFoD6mUnOVv9NUmxe2OePddkjRdo5p5MXW5M0QbtSL6aeb5AZbE2V64d4DSoh1zqy9wR/JVBQeEEPHQe8ayiO/QAyfZPAxPmJBYSvsS9OouFCbfwyW1sy84mo4tit0sQpT6Qxd7GKoINrdczNROcXojXqkFzSs/U5XXjtUlJJVOEUh6LWe6mASd+RdiEnRPIyGDIOdIvQ59z5SXY48lNTpdIy+2mei++aph6gJARsqz0GQYJS3+QiYl0WbHAClhvfDyFCN5It0nGMJua0U6iL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZBITAc+CgZ6VIUX/b6hjVcK5HADETNXwnZGZQyduEE=;
 b=Uy6h0EbZECszZ+goZZaxIUVnZFRM4+hvPR+sj3l+3wNmc6nAeUkXBH0C5mA1PYGmmFACfFYBNhG/+hUYPEyLKMzcAt1UdPzrbvl4RNlreDvAHgiM4AoL4nFmZqEM2iAK4Qko2T8b7rBBY+DUXQrhaO7JSvYTPTHkzxybvQ2lfZE=
Received: from CY5PR13CA0059.namprd13.prod.outlook.com (2603:10b6:930:11::20)
 by MW4PR12MB6708.namprd12.prod.outlook.com (2603:10b6:303:1ed::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Thu, 24 Aug
 2023 11:19:51 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:11:cafe::14) by CY5PR13CA0059.outlook.office365.com
 (2603:10b6:930:11::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Thu, 24 Aug 2023 11:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 11:19:50 +0000
Received: from BLR-5CG13462PL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 06:19:45 -0500
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
Date:   Thu, 24 Aug 2023 16:48:42 +0530
Message-ID: <20230824110146.qboasq2jgvczr4do@BLR-5CG13462PL.amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824021249.271946-3-li.meng@amd.com>
References: <20230824021249.271946-1-li.meng@amd.com> <20230824021249.271946-3-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|MW4PR12MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 027b96c0-2bd3-4e9b-86ef-08dba4940878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQZI4xUKmNf79TiubJKsuKdjYEHC6BdYVQEOxUeGlrF12JkBI05lQJbM2j2IQY5eVYcmuG9N7gpK65cYHzd6hrfWTqfTv4psl1y01jVlR2V8xhMM+xjrRfzFcJAYEXA7k4JYBNAVwf5u2Y7ATslV7vi3Ev+MQ9G4/D9HAkcu5P6dNIF7Rgz4JIxyhHzDe9ZYiZhwonl5LglLWNr6KDgeHw0N+9idUWYuz+shxqIm49m979Fzaopn8Vyu6+INfUgdoBFQhCDNOwxtsi3EuBrTdk959ss1KQ1t4S5riKvDze0Fk4/0hsavUZhlMBS2KAbyDlSFqMLwPKV26ESPAktVLh0AIXlofNU4JJZOn+sUcMitli4cXU7qS5uu4fUj6LAZlHyYLC2Vug/tEmNUnPKTefSnFkmDqQ6QF27NFgNoSJ99MikZyOM5C5HbQTkKD2jWC59HCRFLekLlyJ5ExvkpHg2g2FKtvC0xV7sYRnlbF3r6Ht9txZ0VmfJUv8oRwmj5Oyuql3fVcz5VcfOwoUDtP4p7QRKVX2xSnOeBPfzyqyXkU4KPDGylqPOLra6wVrEcOWiYJnyeFQlfLOWV4ArDp13k/mU+RmoRcPzsPziZAo/0Vft0uYn8UeNaDcD+NxE+VfmvH/7TEH/DymYlxc/1iSkujVvu71XDF9iY5XEyHzHDbxEjQW6NPwg6bMBgYbzRJLAF2OhJT/29sTaAiaGGxJg+MFQfP6CHYLBjjRwLylKH06q+OvjrvSRbKY3bxMnyd/YDZuU6Tg9qt+BV0xzvkUQiNzOfMLboURh9fzmoPOM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(82310400011)(1800799009)(451199024)(186009)(40470700004)(46966006)(36840700001)(40460700003)(2906002)(426003)(336012)(356005)(81166007)(86362001)(82740400003)(55016003)(47076005)(40480700001)(36860700001)(8936002)(4326008)(8676002)(6862004)(7696005)(70206006)(70586007)(6666004)(54906003)(316002)(1076003)(5660300002)(44832011)(41300700001)(6636002)(16526019)(966005)(26005)(478600001)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 11:19:50.6195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 027b96c0-2bd3-4e9b-86ef-08dba4940878
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6708
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
