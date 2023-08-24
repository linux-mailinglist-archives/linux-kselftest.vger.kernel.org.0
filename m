Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E318A786DA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 13:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbjHXLUv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 07:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241016AbjHXLUj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 07:20:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAE719B3;
        Thu, 24 Aug 2023 04:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djENvFIeAS7ZAjYd8POdv3+llgKRmiD4/uZnEvwz36qJ2QkoYO0i15mU2TcgJExBxaZqbyVifKllLuEkmUyMTXUCO91Tg1CZYk2lbvfeHAGHEK1Aa6u3De6vUJlXoStKGdp2jS4qg3NuYYzo7ZHzOck6aOEh7/QkaOMcaClh53i2N70q8fYAxhyqlBlq/oDhiL0/ozBkQAIm1eZuuIcnpGLqpOF04i8Hbc7Ujn3pXuLOLA7Zr8b6plPa4WwO0X3DjFeQHkawfgxsJzc9sP/BQpg6CmBZPC+zEu2wGXysSZwDmhr32fKvxGRp2egfJ+ckpTQPVbS2l9r96DnMeT3bJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoAWnLxIslz9I4Ck5lbaqVaBG5y98TxGcjF7iBuQYOI=;
 b=Xou+0t4o1x+HR9gcBeqjeh8OG+ZcJXLWtcT1kCjY1aZt7UbiS2hboRbWrKNDDy+kmh5mMxkILln7gX/la+ZzeZVc/YXvF8QgJjzeXy06V9iBK3luP7LF3pZ6hiunKDf273Vlhd+QCm7gR+ah6vXX6h9FtDcJPlOfR8sILLZQgsn7oJLMrVDaX1RCzDClAhFulw+3ciMXwuxKwiJ4hurRQ+UegShXfZGRUh02N6kp2Py/K/kNTGohIMqIsMYDyqhrDxr6sBAqKoDhXhBIkwgmseYkLYbDSkIwTjssdvbTT6N8Tu1rCYvsnGln9Fihd98sRQIuxhCvvU0LAfZhC7kTqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoAWnLxIslz9I4Ck5lbaqVaBG5y98TxGcjF7iBuQYOI=;
 b=gpcQMKDfM2lj1cHAJincr62Fexob+6eqjlMh6I7h7dlaTJhrigB/hzqQE2qt2Frh/QaGxhXsvSnkEdoLABy8oWktFuPty/onCHHjUFM6X93WomtvNjSgvfzgveGOzHiypNbd+PR2Xga6bkQUTK8NL7mNZNppCXKzY7rjXQQCCbg=
Received: from CY5PR19CA0104.namprd19.prod.outlook.com (2603:10b6:930:83::21)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Thu, 24 Aug
 2023 11:20:30 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:83:cafe::9) by CY5PR19CA0104.outlook.office365.com
 (2603:10b6:930:83::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 11:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 11:20:23 +0000
Received: from BLR-5CG13462PL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 06:20:18 -0500
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
Subject: Re: [PATCH V3 4/7] cpufreq: Add a notification message that the highest perf has changed
Date:   Thu, 24 Aug 2023 16:48:43 +0530
Message-ID: <20230824110440.ziat2zlxcvq7ar6z@BLR-5CG13462PL.amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824021249.271946-5-li.meng@amd.com>
References: <20230824021249.271946-1-li.meng@amd.com> <20230824021249.271946-5-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6e4ad6-28d3-4c00-6cac-08dba4941c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3sYQ5VrWRukrGuB31W4aOSizsdE6vYLnpGQqpmb004gdWNSdPHrvRRaI8m7gPQnzRSqTWPH+9jBiYEfIYOpUr4WSUvK9lAEQpcNXn7VcUBGo0S90MIYY3IL4htODCxMJjO9Zp3ZF8+/7RGl3ma0HQ6L5HugHRa9XyfSOuhdiMh+V7TYkqKXWT7z3QfTZHKVddSAM6b4/YnS0N0lOrgYlHomSdPC+oY4XqivVIvyXLQKz4Bk5OeLfRDwdtIfpX/uSrHEkVrY/dcC26RoD2n8CTepsjwFepfxp2DO/muuMmQRJB3eXr5j3bpa1Oj+Y0R0yDKZi4Pu7guaWWC2a9SzQwFTf2U4DTMXRNjsQZw81jO2O8ggsCHd9bWX2MdDslrDf1p0yLk703uTd338cyQV9ZnCohlp62B8AUUm2KEhjnWNfrUEPO8WPaSrEsAzbhX4dUjJ0mYc/TJynRHa3CPV4W1nPtmuwp1oa/4InWBrgIfUWKIfRSwBOOte30Mxfmo+TdJDewc9fd08a4Jmw6rL7ow1QDuicdtOUl/U/2Aq5vLQ4c314KLBu5VkouF1+L0f/cAbsIkO9akYASX2c9lzgXmJtNaN5wbaDgkQiW1NDEZI8/KoazzG8S1lLiKX32kxCW4xx3vs0NkPXEVjDs9vmTQzGZJySrVfGhGmasNnzv2shwT/r21mpw4BfcydWwp+Zwcx593bcwpZU1xRp/T5TrgXNJF0Kmgq3tyEroHGR1IsTAlmKyWVO/CQoC99s9tRL3jJWJIZVCcnrUXrRByHQEB11JpK23sodx1AWhHyyvyM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(1800799009)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(82740400003)(356005)(40460700003)(6666004)(81166007)(7696005)(426003)(336012)(55016003)(1076003)(40480700001)(26005)(16526019)(47076005)(83380400001)(36860700001)(316002)(2906002)(6636002)(41300700001)(15650500001)(54906003)(70586007)(70206006)(44832011)(5660300002)(4326008)(8936002)(6862004)(86362001)(478600001)(966005)(8676002)(226483002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 11:20:23.9373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6e4ad6-28d3-4c00-6cac-08dba4941c54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118
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
> ACPI 6.5 section 8.4.6.1.1.1 specifies that Notify event 0x85 can be
> emmitted to cause the the OSPM to re-evaluate the highest performance
> register. Add support for this event.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Link: https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html?highlight=cppc#cpc-continuous-performance-control
> ---
>  drivers/acpi/processor_driver.c |  6 ++++++
>  drivers/cpufreq/cpufreq.c       | 13 +++++++++++++
>  include/linux/cpufreq.h         |  4 ++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 4bd16b3f0781..29b2fb68a35d 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -27,6 +27,7 @@
>  #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
>  #define ACPI_PROCESSOR_NOTIFY_POWER	0x81
>  #define ACPI_PROCESSOR_NOTIFY_THROTTLING	0x82
> +#define ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED	0x85
>  
>  MODULE_AUTHOR("Paul Diefenbaugh");
>  MODULE_DESCRIPTION("ACPI Processor Driver");
> @@ -83,6 +84,11 @@ static void acpi_processor_notify(acpi_handle handle, u32 event, void *data)
>  		acpi_bus_generate_netlink_event(device->pnp.device_class,
>  						  dev_name(&device->dev), event, 0);
>  		break;
> +	case ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED:
> +		cpufreq_update_highest_perf(pr->id);
> +		acpi_bus_generate_netlink_event(device->pnp.device_class,
> +						  dev_name(&device->dev), event, 0);
> +		break;
>  	default:
>  		acpi_handle_debug(handle, "Unsupported event [0x%x]\n", event);
>  		break;
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 50bbc969ffe5..842357abfae6 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2675,6 +2675,19 @@ void cpufreq_update_limits(unsigned int cpu)
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_update_limits);
>  
> +/**
> + * cpufreq_update_highest_perf - Update highest performance for a given CPU.
> + * @cpu: CPU to update the highest performance for.
> + *
> + * Invoke the driver's ->update_highest_perf callback if present
> + */
> +void cpufreq_update_highest_perf(unsigned int cpu)
> +{
> +	if (cpufreq_driver->update_highest_perf)
> +		cpufreq_driver->update_highest_perf(cpu);
> +}
> +EXPORT_SYMBOL_GPL(cpufreq_update_highest_perf);
> +
>  /*********************************************************************
>   *               BOOST						     *
>   *********************************************************************/
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 9bf94ae08158..58106b3d9183 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -232,6 +232,7 @@ int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
>  void refresh_frequency_limits(struct cpufreq_policy *policy);
>  void cpufreq_update_policy(unsigned int cpu);
>  void cpufreq_update_limits(unsigned int cpu);
> +void cpufreq_update_highest_perf(unsigned int cpu);
>  bool have_governor_per_policy(void);
>  bool cpufreq_supports_freq_invariance(void);
>  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
> @@ -377,6 +378,9 @@ struct cpufreq_driver {
>  	/* Called to update policy limits on firmware notifications. */
>  	void		(*update_limits)(unsigned int cpu);
>  
> +	/* Called to update highest performance on firmware notifications. */
> +	void		(*update_highest_perf)(unsigned int cpu);
> +

Can we use the existing `update_limits` callback?

Thanks,
Wyes
>  	/* optional */
>  	int		(*bios_limit)(int cpu, unsigned int *limit);
>  
> -- 
> 2.34.1
> 
