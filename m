Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA537867CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 08:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbjHXGu2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 02:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240229AbjHXGtg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 02:49:36 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5143E1715;
        Wed, 23 Aug 2023 23:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsLzmL2dLKw06+WwDT//9rsAeILKzMhndVF1SuaqTlMW2ga3VzwOEwud1aHBxbQABU66IUvmXqbyyAIFoMGpfCAwPW/GzY9neWcb9DAQFeFCMlDbN07OM5xWvmix3JGoyIGuy/1pvcWvxclLRclEAeJNy7opClkGgVJzwaBjjciVOG7FYIv8LjiobOFYCYhHSjBnERggwlthCFvZpsgbhRgTTE3Mnz5rhEkcJI5PavnWan+Ln1Zxq5Py3nhopWk1cqc7dNBOhJ1cR2rrwxW5jddbGN817+6ve1CTyPFqpOm6JvnexLKn9MqZlZ8ChI4UNn3pY9agpZMWyh5Z1nrSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkvZ7Aus9UdC+9U4HKt1FoTbDVBLBotbYnnZdUhCSR8=;
 b=ITaKS3+Kelm4rH6QE6Evb/Z5LGOiYInSEn75yhK3oMoX6p+bSLDBwMY4ikwGyCNZoFNjPwtrFyJlMsm5UX802haBPZMuhygY/3k/AfR846g6CnU+xjvs6NjXWALbMtPL4Uw3rSZjO7BeSUc4Q35sq7aDOS11MnBkx74r94hp7TNhiekW+hV5nbbCbmXEKhTieni3wMY5Ag6HuZqtJ5XdLRcUFKvAEe1liFkISDKS4pjeL+N5C02G8Cy6gebEnR8NRZakWNvF+IfA1RqHyp6hoNFh7LMYr+bfhVZYFQLQU8PD8AijrgldbvMnaVDQVIh7MEvzqAubMVRzbEvBAlV7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkvZ7Aus9UdC+9U4HKt1FoTbDVBLBotbYnnZdUhCSR8=;
 b=PEWX4adr73dv5Qyt6oTzJFaLz8vRsjH5wQLTZm/eWBh6yrAwY2H0JRUEMpfX2zZp+3SZr4+X+fVLAzUoBA40Rbo4F3HLMREkFXEp3SOOlbrgQ5cQgBdpRAPS+kqjLFbeqRz6bC4JpZDcM+yvzLSSdlBi6+kD9dCg2m+UpDaa0fQ=
Received: from SA0PR11CA0163.namprd11.prod.outlook.com (2603:10b6:806:1bb::18)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 06:49:12 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:1bb:cafe::69) by SA0PR11CA0163.outlook.office365.com
 (2603:10b6:806:1bb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Thu, 24 Aug 2023 06:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 06:49:12 +0000
Received: from BLR-5CG13462PL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 01:49:02 -0500
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
Subject: Re: [PATCH V3 3/7] cpufreq: amd-pstate: Enable AMD Pstate Preferred Core Supporting.
Date:   Thu, 24 Aug 2023 12:18:22 +0530
Message-ID: <20230824063803.ryqf6uet3yhxiiak@BLR-5CG13462PL.amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824021249.271946-4-li.meng@amd.com>
References: <20230824021249.271946-1-li.meng@amd.com> <20230824021249.271946-4-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e74f0d-9e56-4e8c-ebbf-08dba46e39a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zy1zhXP3j+lm0SUSQgpaaIv+0+eQm6yWdrCmCwWvsD38/qN2DQnIA+9bAWOBOdgJyrTDGoaL5KgkFrMOd6SyCgWyc2z9kmd4yKrexFuzG1U7jADmi2fqMbFnOh+BCFqxUDP6ShFVuWkFbRTxt3Yxu1zuMtP8U5/tdskxVGLOLIayqIZJLvCAlJFGbDshlIG1gJrxdogH3Y3grtzrD2cwFJ1NdjLJKLhs2wKOGU54Kj7C2qOrBRHqu//6x0jJgDxslr9zQCNX8p3yrA/iRpwnx8Ali6LhiC7n/uSkT2AUN3vSbWOuNaaHRSiQBBhsRhkJ6wWrUeap+XXumewxNB9mzJrUctelfqRlNfqlSgc8CjohKS/ZDX82BuSScUWodmr+EncfzmC0WhPm/CTab2nKE2DBpSINt1CB3f1ufwsaQCKb62bJEs6ofoyyDctQ+EdmsDCskq7kU7RH4hj+8TN34d6w/KIh/qYgG88jtFVNrfaieQzBwmWUSVsKTJAi0M2HRu5xraXpwwTf5/DKLcGmfQIi0SH+aD/i6B3Fx3UbS6b74pfIjL3f9VNxIjsiG68s6PHyk+BVB3Ye1FE6AoV0XJ3J9y+VeZRuG4hHj3f61WHluSJHbgxEjroqNlKZGUR8rVy2dyH0Fvo+xS91w7+yVAS9puyAQI9gl6YRaj2V5st3X3W6AcOI09wNWo8WOVm7OhgD4jbSgAOVvVV+8DetniDTFDDHD7mc2gz/+sbZLBMPsqS3vh1i/bAMexkMfGfwsIwvfq70qQyWV5ejoiS8JA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(186009)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(8936002)(4326008)(6862004)(8676002)(83380400001)(5660300002)(1076003)(426003)(336012)(36860700001)(47076005)(44832011)(40480700001)(16526019)(26005)(55016003)(82740400003)(6666004)(81166007)(70206006)(70586007)(54906003)(6636002)(316002)(478600001)(356005)(41300700001)(2906002)(86362001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 06:49:12.2899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e74f0d-9e56-4e8c-ebbf-08dba46e39a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Meng Li,

On 24 Aug 10:12, Meng Li wrote:
> AMD Pstate driver utilizes the functions and data structures
> provided by the ITMT architecture to enable the scheduler to
> favor scheduling on cores which can be get a higher frequency
> with lower voltage. We call it AMD Pstate Preferrred Core.
> 
> Here sched_set_itmt_core_prio() is called to set priorities and
> sched_set_itmt_support() is called to enable ITMT feature.
> AMD Pstate driver uses the highest performance value to indicate
> the priority of CPU. The higher value has a higher priority.
> 
> The initial core rankings are set up by AMD Pstate when the
> system boots.
> 
> Add device attribute for preferred core states.
> 
> Add one new early parameter `enable` to allow user to
> enable the preferred core if the processor and power
> firmware can support preferred core feature.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Co-developed-by: Perry Yuan <Perry.Yuan@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> Co-developed-by: Meng Li <li.meng@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 120 ++++++++++++++++++++++++++++++-----
>  1 file changed, 104 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9a1e194d5cf8..d02305675f66 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -37,6 +37,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/static_call.h>
>  #include <linux/amd-pstate.h>
> +#include <linux/topology.h>
>  
>  #include <acpi/processor.h>
>  #include <acpi/cppc_acpi.h>
> @@ -49,6 +50,8 @@
>  
>  #define AMD_PSTATE_TRANSITION_LATENCY	20000
>  #define AMD_PSTATE_TRANSITION_DELAY	1000
> +#define AMD_PSTATE_PREFCORE_THRESHOLD	166
> +#define AMD_PSTATE_MAX_CPPC_PERF	255
>  
>  /*
>   * TODO: We need more time to fine tune processors with shared memory solution
> @@ -65,6 +68,9 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_UNDEFINED;
>  static bool cppc_enabled;
>  
> +/*Preferred Core featue is supported*/
> +static bool prefcore = true;
> +
>  /*
>   * AMD Energy Preference Performance (EPP)
>   * The EPP is used in the CCLK DPM controller to drive
> @@ -290,23 +296,21 @@ static inline int amd_pstate_enable(bool enable)
>  static int pstate_init_perf(struct amd_cpudata *cpudata)
>  {
>  	u64 cap1;
> -	u32 highest_perf;
>  
>  	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>  				     &cap1);
>  	if (ret)
>  		return ret;
>  
> -	/*
> -	 * TODO: Introduce AMD specific power feature.
> -	 *
> -	 * CPPC entry doesn't indicate the highest performance in some ASICs.
> +	/* For platforms that do not support the preferred core feature, the
> +	 * highest_pef may be configured with 166 or 255, to avoid max frequency
> +	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
> +	 * the default max perf.
>  	 */
> -	highest_perf = amd_get_highest_perf();
> -	if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
> -		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
> -
> -	WRITE_ONCE(cpudata->highest_perf, highest_perf);
> +	if (prefcore)
> +		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
> +	else
> +		WRITE_ONCE(cpudata->highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));

Can we disable `preferred core` in HW? If not then when we disable
`preferred core` in software (via the cmd line param you have created),
HW still gives core ranking through highest perf register/MSR. So, we
have to filter the core ranking info form the highest perf register/MSR
and set cpudata->highest_perf accordingly. IMO we should have two
variables, one which indicated HW support and other one which indicates SW
overwrite. In this function we should be checking only HW support.

>  
>  	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
> @@ -318,17 +322,15 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>  static int cppc_init_perf(struct amd_cpudata *cpudata)
>  {
>  	struct cppc_perf_caps cppc_perf;
> -	u32 highest_perf;
>  
>  	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
>  		return ret;
>  
> -	highest_perf = amd_get_highest_perf();
> -	if (highest_perf > cppc_perf.highest_perf)
> -		highest_perf = cppc_perf.highest_perf;
> -
> -	WRITE_ONCE(cpudata->highest_perf, highest_perf);
> +	if (prefcore)
> +		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
> +	else
> +		WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf);

Here also we should be checking only HW support.

>  
>  	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> @@ -676,6 +678,72 @@ static void amd_perf_ctl_reset(unsigned int cpu)
>  	wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);
>  }
>  
> +/*
> + * Set AMD Pstate Preferred Core enable can't be done directly from cpufreq callbacks
> + * due to locking, so queue the work for later.
> + */
> +static void amd_pstste_sched_prefcore_workfn(struct work_struct *work)
> +{
> +	sched_set_itmt_support();
> +}
> +static DECLARE_WORK(sched_prefcore_work, amd_pstste_sched_prefcore_workfn);
> +
> +/**
> + * Get the highest performance register value.
> + * @cpu: CPU from which to get highest performance.
> + * @highest_perf: Return address.
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +static int amd_pstate_get_highest_perf(int cpu, u64 *highest_perf)
> +{
> +       int ret;
> +
> +       if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +               u64 cap1;
> +
> +               ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
> +               if (ret)
> +                       return ret;
> +               WRITE_ONCE(*highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
> +       } else {
> +               ret = cppc_get_highest_perf(cpu, highest_perf);
> +       }
> +
> +       return (ret);
> +}
> +
> +static void amd_pstate_init_prefcore(void)
> +{
> +	int cpu, ret;
> +	u64 highest_perf;
> +
> +	if (!prefcore)
> +		return;
> +
> +	for_each_online_cpu(cpu) {
> +		ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
> +		if (ret)
> +			break;
> +
> +		sched_set_itmt_core_prio(highest_perf, cpu);
> +
> +		/* check if CPPC preferred core feature is enabled*/
> +		if (highest_perf == AMD_PSTATE_MAX_CPPC_PERF) {
> +			prefcore = false;
> +			return;

255 is a valid core ranking right?

Thanks & Regards,
Wyes

> +		}
> +	}
> +
> +	/*
> +	 * This code can be run during CPU online under the
> +	 * CPU hotplug locks, so sched_set_amd_prefcore_support()
> +	 * cannot be called from here.  Queue up a work item
> +	 * to invoke it.
> +	 */
> +	schedule_work(&sched_prefcore_work);
> +}
> +
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  {
>  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -1037,6 +1105,12 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
>  	return ret < 0 ? ret : count;
>  }
>  
> +static ssize_t prefcore_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", prefcore ? "enabled" : "disabled");
> +}
> +
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>  
> @@ -1044,6 +1118,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>  cpufreq_freq_attr_rw(energy_performance_preference);
>  cpufreq_freq_attr_ro(energy_performance_available_preferences);
>  static DEVICE_ATTR_RW(status);
> +static DEVICE_ATTR_RO(prefcore);
>  
>  static struct freq_attr *amd_pstate_attr[] = {
>  	&amd_pstate_max_freq,
> @@ -1063,6 +1138,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>  
>  static struct attribute *pstate_global_attributes[] = {
>  	&dev_attr_status.attr,
> +	&dev_attr_prefcore.attr,
>  	NULL
>  };
>  
> @@ -1506,6 +1582,8 @@ static int __init amd_pstate_init(void)
>  		}
>  	}
>  
> +	amd_pstate_init_prefcore();
> +
>  	return ret;
>  
>  global_attr_free:
> @@ -1527,7 +1605,17 @@ static int __init amd_pstate_param(char *str)
>  
>  	return amd_pstate_set_driver(mode_idx);
>  }
> +
> +static int __init amd_prefcore_param(char *str)
> +{
> +	if (!strcmp(str, "disable"))
> +		prefcore = false;
> +
> +	return 0;
> +}
> +
>  early_param("amd_pstate", amd_pstate_param);
> +early_param("amd_prefcore", amd_prefcore_param);
>  
>  MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>  MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
> -- 
> 2.34.1
> 
