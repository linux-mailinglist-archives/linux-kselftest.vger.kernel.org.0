Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAA479432F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 20:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbjIFSgz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 14:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244054AbjIFSgf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 14:36:35 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155251FE2;
        Wed,  6 Sep 2023 11:35:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hr7zHyeSPBA6bet4XLsR7tt2kRtwDugOfDq8o47H7HGbF4p945qvgpSqzH5rsrs8VO6XAVHPNMtXRro01xg8qLzxMpbf4kUnxAHYha8Hti2Jr/ioK/t/DVeUpDNVRmyR3Msw6MDkYCZmBTnKzD63rM4XMJQetGFHIqc0hz/Iixvtu/nmH6ZchrRktm2XtTuHl1+bPy7ja29ob//4JlwUBbhKGt1b90xhNzeYQvHK2IX+3aIS7t0rxYppu5fpNjOcfBfYrm9lWyjvmaA3mUGVJJ4t98PmTsS82KvtsjxKkSrCP+XS+aH3TadMcrxizLK9Zb8TBFSO171qmPVrI8KXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjzXPG0cjcYPAN2UdRZgUYJ47HQ0yBh0e1uXu4DBXd4=;
 b=etw74rEoIDFFIk6HwWJ/WZCeolRyRb/WsDf+NOs6X3XhOjAjsLo84NIGIqAsLtOVwHx0a4+gBH526JrF9XpC9jk5lYa6+aT7cTI24S5+5KID1aEHqnBJewP6o4jelkHsBf5yECyDF6yoYP1/oQ36y03oH8EFKjgjB9bM67/5tnNvG3ducahS3sGaUroH8Si5t8Sm6t3Zw1o/iBkUbodne+q1HyUfPjh28JOpIvRPuRTkxoTtkrWvqbNl0loOMorL+khkXocqD977sc0uSJsACdY6HUnw+heWKBTGvYIwujGAyp0vDiYkKQPSAAGfho2fjXDmGpxjiWR/69BwhDLStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjzXPG0cjcYPAN2UdRZgUYJ47HQ0yBh0e1uXu4DBXd4=;
 b=3ReITXkTmpVJHVu/X/sAuDYx8ZnSJ6E195kCwqrLFSvEXOzds81FmgriR2MjXIesnVzVLK2/VBfiVI0LhHleyp6n835O8CAt/3EgKKotD1BSdVEEFBoaA3AYAeNVGGyHbFGAIWOIqvYZeJKSdLKge0LATpu7Ld9tXSLpHJhBmb0=
Received: from SJ0PR03CA0231.namprd03.prod.outlook.com (2603:10b6:a03:39f::26)
 by BN9PR12MB5177.namprd12.prod.outlook.com (2603:10b6:408:11a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 18:34:55 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::4d) by SJ0PR03CA0231.outlook.office365.com
 (2603:10b6:a03:39f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 18:34:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 18:34:54 +0000
Received: from BLR-5CG13462PL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 13:34:48 -0500
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
Subject: Re: [PATCH V5 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred core supporting.
Date:   Thu, 7 Sep 2023 00:04:32 +0530
Message-ID: <20230906183311.o4tqxlhszpnaxhcf@BLR-5CG13462PL.amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905015116.2268926-4-li.meng@amd.com>
References: <20230905015116.2268926-1-li.meng@amd.com> <20230905015116.2268926-4-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|BN9PR12MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: d7293ca9-a89e-4a5b-e521-08dbaf07f713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mvAPWwfS7P3faMaqz1j53hPJxFUvf6TsVSYdnVrFOVMWOQM7gnNMeoeBz0OL56mUE6g96AH0wpA17isaVXASBdu52ga9evOt9/SXImupec+u1FHmjlHFhcc9qa5JWkEUb+yV/reHoCcgEr1XsRCK23ibH8cwwgU5dYafaD7FjEn6xXICZdtdMt/ksgYG+llOJwW7UoabgvP4ezONeFRDP36LdQassZY2ZT/QniBGEBS8Aq9F4N5X7zch7oDm7yifDXUIYDwWMCbmS4PUqxuCpFwSPWK5H+zUuBoX8ajgyJKW3keT5s54p9XiTEhoTGScSqiAiXdPLUUNqvpxFXrwQHfibkqmqc3d9q+ZUGkpvZoxcUjQ5i8GpjpC0y02pnM4sV/S108qF/TicPqZwUwjfsAIlXsVgNrppuX3wej3BTj+gZKpOIJNZhCw6z28mOK/L8CwcJqTn6qIn56NLpp7r9pbqeRivTkrHAENZOJH+3qzLtL3pISvuWR12bZtaNGDGo6OEo2lU6x1GTWBMXyib26df0sJZvq4epjMrz+ST+YVmET0zncrQ0SjZOtX18oOfYWhDXSUMkt78chSV49KhgFX1nuL4YR9WVCwEP4VzpIif78aBYhRsD7bouFLZ9Zk9e8SrzXOFoJVWfwj8wBl3Bon/UvvQuozZKcXzTOMrD1UkjQ2OKvOYzfQziCuvjlfbyVG6HsFhogU8R3lXH2Nr47eR/QqgeQ6RhOcCmYeu1GM7YE1kGoQC9hey8bQNGaAiyGsV1WgvJoDO2BqzzRP4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(82740400003)(40460700003)(26005)(81166007)(16526019)(356005)(1076003)(7696005)(47076005)(36860700001)(336012)(426003)(55016003)(40480700001)(83380400001)(478600001)(4326008)(6862004)(8676002)(8936002)(44832011)(70586007)(70206006)(5660300002)(54906003)(86362001)(6636002)(316002)(6666004)(2906002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 18:34:54.7183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7293ca9-a89e-4a5b-e521-08dbaf07f713
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5177
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 05 Sep 09:51, Meng Li wrote:
> amd-pstate driver utilizes the functions and data structures
> provided by the ITMT architecture to enable the scheduler to
> favor scheduling on cores which can be get a higher frequency
> with lower voltage. We call it amd-pstate preferrred core.
> 
> Here sched_set_itmt_core_prio() is called to set priorities and
> sched_set_itmt_support() is called to enable ITMT feature.
> amd-pstate driver uses the highest performance value to indicate
> the priority of CPU. The higher value has a higher priority.
> 
> The initial core rankings are set up by amd-pstate when the
> system boots.
> 
> Add device attribute for hardware preferred core. It will check
> if the processor and power firmware support preferred core
> feature.
> 
> Add device attribute for preferred core. Only when hardware
> supports preferred core and user set `enabled` in early parameter,
> it can be set to enabled.
> 
> Add one new early parameter `disable` to allow user to disable
> the preferred core.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Co-developed-by: Perry Yuan <Perry.Yuan@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> Co-developed-by: Meng Li <li.meng@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 131 ++++++++++++++++++++++++++++++-----
>  1 file changed, 115 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9a1e194d5cf8..454eb6e789e7 100644
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
> @@ -65,6 +68,12 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_UNDEFINED;
>  static bool cppc_enabled;
>  
> +/*HW preferred Core featue is supported*/
> +static bool hw_prefcore = true;
> +
> +/*Preferred Core featue is supported*/
> +static bool prefcore = true;
> +
>  /*
>   * AMD Energy Preference Performance (EPP)
>   * The EPP is used in the CCLK DPM controller to drive
> @@ -290,23 +299,21 @@ static inline int amd_pstate_enable(bool enable)
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

As mentioned in the v3, this should be checking hw_prefcore.

For example: Let's consider a cap1 value for a CPU is: e752380d and the
system can go to freq 3.5 GHz. The system supports preferred core but
user added prefcore=disable command line option.

Therefore below will be the perf values after amd_pstate init:

lowest_perf: 13
lowest_nonlinear_perf: 56
nominal_perf: 82
highest_perf: 231

Let's say user selected userspace governor and tries to set frequency
2.8 Ghz. Then des_perf calculation would be as below:

des_perf = 2800000 * 231 / 3500000 = 184

Which is wrong. Because HW only allows des_perf upto 166 (because HW
supports preferred core).

If we restrict highest_perf to 166 in preferred core supported (by HW)
system, even when we disable preferred core from SW, then the des_perf
calculation stays correct.

des_perf = 2800000 * 166 / 3500000 = 132

Therefore when user disables preferred core with prefcore=disable
command line in a preferred core supported system, the highest_perf
should be AMD_PSTATE_PREFCORE_THRESHOLD (166).

>  
>  	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
> @@ -318,17 +325,15 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
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

Same here.

Thanks,
Wyes
>  
>  	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> @@ -676,6 +681,73 @@ static void amd_perf_ctl_reset(unsigned int cpu)
>  	wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);
>  }
>  
> +/*
> + * Set amd-pstate preferred core enable can't be done directly from cpufreq callbacks
> + * due to locking, so queue the work for later.
> + */
> +static void amd_pstste_sched_prefcore_workfn(struct work_struct *work)
> +{
> +	sched_set_itmt_support();
> +}
> +static DECLARE_WORK(sched_prefcore_work, amd_pstste_sched_prefcore_workfn);
> +
> +/*
> + * Get the highest performance register value.
> + * @cpu: CPU from which to get highest performance.
> + * @highest_perf: Return address.
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +static int amd_pstate_get_highest_perf(int cpu, u64 *highest_perf)
> +{
> +	int ret;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		u64 cap1;
> +
> +		ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
> +		if (ret)
> +			return ret;
> +		WRITE_ONCE(*highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
> +	} else {
> +		ret = cppc_get_highest_perf(cpu, highest_perf);
> +	}
> +
> +	return (ret);
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
> +			hw_prefcore = false;
> +			prefcore = false;
> +			return;
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
> @@ -1037,6 +1109,18 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
>  	return ret < 0 ? ret : count;
>  }
>  
> +static ssize_t hw_prefcore_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", hw_prefcore ? "supported" : "unsupported");
> +}
> +
> +static ssize_t prefcore_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", prefcore ? "enabled" : "disabled");
> +}
> +
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>  
> @@ -1044,6 +1128,8 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>  cpufreq_freq_attr_rw(energy_performance_preference);
>  cpufreq_freq_attr_ro(energy_performance_available_preferences);
>  static DEVICE_ATTR_RW(status);
> +static DEVICE_ATTR_RO(hw_prefcore);
> +static DEVICE_ATTR_RO(prefcore);
>  
>  static struct freq_attr *amd_pstate_attr[] = {
>  	&amd_pstate_max_freq,
> @@ -1063,6 +1149,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>  
>  static struct attribute *pstate_global_attributes[] = {
>  	&dev_attr_status.attr,
> +	&dev_attr_prefcore.attr,
>  	NULL
>  };
>  
> @@ -1506,6 +1593,8 @@ static int __init amd_pstate_init(void)
>  		}
>  	}
>  
> +	amd_pstate_init_prefcore();
> +
>  	return ret;
>  
>  global_attr_free:
> @@ -1527,7 +1616,17 @@ static int __init amd_pstate_param(char *str)
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
