Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA13793E31
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 15:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbjIFN6K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 09:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjIFN6J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 09:58:09 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0F910E2;
        Wed,  6 Sep 2023 06:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzByvSj0l3Ymz8AFdbQRiyVelCo7wxAHO9NnVIFlZ8A8a6nICQUlke3OvQiXway4+qI9K6x6WkmXJND3JB93nLNM0UIm7OvCvZSgNF5meGnma5Qcm+MCNOyh0h2VUzOm71dBHtsLS7oKZLvlXTPcSrdw9UQWsWBUg1Q27f5Rt2xOR2Nns0I2xpibj274aOnh8S2kaWpfkqPSqkkbwl70iSH8MvP2CUOV6HseY5sDBOUn6aApujnNnzmmYC6PCJaoWCsjW+6XOKGnO2ij+qBjER9KE3SyFCSUMO2xNoxijxD98yvWEyHqwnkPWSZtP91KWPo3Y4/WF3ISeAoZy/dl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tn6AZdkfg+SH4F5UTEcjZRxe0/V/Mbx7YVsfiUeamW4=;
 b=oA8N+PekcMTHQ4hcix1U2OI4XLv6Ew1T0bdLXc9NauOy7mXKqK714Lgd+qqiZs8UgRS8r/6ytG05Ux3iiI7By8uWwE7R88Yl//qmWHqvXzhoZIv9ctR28NLyibgTQJi6oLD1CShl38dH/HI5XhHqRrkLtnNqoZFkXtkMrq0R7ehthMRsDAZszLIzFnhyi0qyiKjg3uEZHnScv8Dgquf+6MeRSAQhQByr6kQwsdO+e7yZjNG46V6xc8u4js5MeSHvGhBN5Hp36DCjrB4WorW2rTa8bV4m2qkDQE9izL14FVO2Bnwul/DcQoeLU8rsWqgO0WOsJsJgHwQTjoGq2uTsTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn6AZdkfg+SH4F5UTEcjZRxe0/V/Mbx7YVsfiUeamW4=;
 b=cX8nuEFPiO6uaRnTNaQCQE8aQniLRgNX/8o9wSMBGRvu28C59wwOJhuS6w33HD8CMd3ZoEogqpHs03IVvGLGLWVt8TYL7n5Az8bVnW0BM3FxyRLsPUOxZO5ex69psJwRV6JcMp6MQryGx2r6E1tYm2sgYHCPZt3BgUmcdeoyaQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by MW4PR12MB7263.namprd12.prod.outlook.com (2603:10b6:303:226::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27; Wed, 6 Sep
 2023 13:58:02 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 13:58:01 +0000
Date:   Wed, 6 Sep 2023 21:57:35 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "Karny, Wyes" <Wyes.Karny@amd.com>
Subject: Re: [PATCH V5 5/7] cpufreq: amd-pstate: Update amd-pstate preferred
 core ranking dynamically
Message-ID: <ZPiFT1OUTOnH1s7U@amd.com>
References: <20230905015116.2268926-1-li.meng@amd.com>
 <20230905015116.2268926-6-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905015116.2268926-6-li.meng@amd.com>
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|MW4PR12MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: e53f7e88-c009-4db2-5d89-08dbaee148ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oY62Orz8yzXYQ4hvmOEcwERLH2oOTtzPPb/FcirLCJyAFLdYd+xfvfft2BAm/WlrfXJNcndtr9RHhZIqb0STtMavBZNl9W9Gj0n+mGuTYgJb9H7k59IwsMF/kTy6cv5DJQxM+zqY2Rn1kduvjHyRUXNr2wc4QzzjdmBNV+H5xsIgk3y8baVLQL1YWaDOxeew7kYfcvB75EsZ1mlVk74m+NRvsJfY58+rMb0IZkCk1t5FmB7UxEpDVlGp+OIT97BbLYRy+369caqYHg3rL8hSu/dRk3b1J3PCuVRet8WKyv4aUnSbOb9Oa+Cz+i8m2WUWpKmMVOh2bmJZypmMHGbimaDkqMknpGmRaFUW0zR+NaPJn1I4KqJ7cDJGANFjs3r4XhN5zpdpiNqrBNApNam+8BF6sKzePIJblcXjADla+iiOyfBj0v4rjuYqT3w5KgjZeVSuR9s+M3wlngSwv5dMgOtg+55OuDP/ZAlUcQ8Sz2SBif+rD1EbVnhrwUzzaOIGGEoSPFyBIdnMBYm4zG0Tfv8SaVnA+pSFnu6ihgLzl+cGNljL/tM1nEnyJUdm1BLr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199024)(1800799009)(186009)(8676002)(4326008)(8936002)(6862004)(66556008)(37006003)(86362001)(66946007)(54906003)(66476007)(6486002)(6506007)(478600001)(6666004)(6512007)(26005)(41300700001)(83380400001)(66899024)(36756003)(316002)(6636002)(38100700002)(5660300002)(15650500001)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9PgotbajCVRvwb/BC4iJ8LA7M/oLfFo4SKyuJK40VR9psgpaqyxWoQfg/qha?=
 =?us-ascii?Q?C652144Fnua8KbTRrH1cyzZcwGFsGP37ZsWrSbpWliWQv8d5mklBNNXx8MFH?=
 =?us-ascii?Q?6E7ahcVdwPj1y5Z3qTVw9I1UhhYPZOof2cO/EbZUewtZ6+U8XdaBWsC0eTIa?=
 =?us-ascii?Q?6k2G63sMJbttQaPK6mZwU8S5eDacvGcWuP3O8GuWa4zJLxEUTBuqZ6U1ATXo?=
 =?us-ascii?Q?Z8AEaHEE9D+OPyJkrHMrIlSgWmVY4EkjrwbCp9C2DvbBnkjO/OTBrH2FAJsA?=
 =?us-ascii?Q?Rpx5EuatT753wDSES7oyr0TWqNqwPmIus6DSPIAKYp4VKCXfYPhYBcTxKimB?=
 =?us-ascii?Q?6P0jRxgVX3j5lFqJzfSMmHsbUTq+SHgi+HBesY554cazIi8U8lqnVx+tU2Ek?=
 =?us-ascii?Q?iBFZHpfQcl6ecHUUEIqFpArHpOWyGYs6n20zDe5I8umPjo2TnWKEknJXrexN?=
 =?us-ascii?Q?6dSGKoe9Amw2r6B9H4GgD5Fb8v2kMDfv1O6Yf9OxnASMk+kPtlkLrLsNLcPj?=
 =?us-ascii?Q?q7cjl0OQOokVQKl22WKRWU5XAypwud/CVgDg9L576qxELYNLq6ztXwUJkkxm?=
 =?us-ascii?Q?w7Bif8JDskev/aWLobsX/qzdLLXemyZCgzMmUInHM/OaAZyTK9jIHVw82T+L?=
 =?us-ascii?Q?9SxCScqGFtR4+9ior58Ek89tQ8bEqO5sy/ob7iDSsHdf5vinIB2tPKJBPCHY?=
 =?us-ascii?Q?gb+lo5J1eZEJ95iqBWbKyZSPmGWw1oJOZWkBLKGYfEDwJvcuX7V4R4UKEjPr?=
 =?us-ascii?Q?e2GGNBgtxezadWcrFOHw1YbS88h1q8gXAyAq2X9t5zKCPdIJN1NAtm6p69vu?=
 =?us-ascii?Q?+z2xxAnU8IVZYY9RBg8DCoMdU7Vzi1AyMiEJ0FdZl5XT9Wv2wwW7ejjCRkYF?=
 =?us-ascii?Q?AK5U/YS0GWxK89v/dB+SsoaU3C13PvHDCJ7DiUKAjLjbkI4JhXSerVKbQKrq?=
 =?us-ascii?Q?i5P8Bk4LJqg2GpltCK4uZR1QoZRs8fP0QM2DKn9VrrGt/Dg8UxCDCvpDDlq5?=
 =?us-ascii?Q?jOFjHgAiGGUwT7Igp/KVdumFhtbnSxWdBwpDGrYmEKxQEjmUfsxd8XM6K3df?=
 =?us-ascii?Q?suIqivUFkqZJEmLetMTTnjYCgBjSIu+NSMxWpbbxPFxlptigDYC6PiRl8uKK?=
 =?us-ascii?Q?njSFmtfHaSXHVg88Wklc2V9dKgE1Yym5tnvBbfx2+UtRuxvRyBPMRSzf2XcK?=
 =?us-ascii?Q?Bru3KI6Ek30e2mazRcqNs9jIEzBUJj44z3yxTW68zUxs9vRhDqsBk8AprgrI?=
 =?us-ascii?Q?dhzRMtGE5Lr+fGB51xo3+UtX0sQQKKFEsdfu/t+Y1sUvBbgxRu/NxJj+W0GS?=
 =?us-ascii?Q?ePKndNbL2oab7NTCZS2PJSFhaA+BEF6XDa+0NvEIG4oGAZeM6m1jZPJ2FxLb?=
 =?us-ascii?Q?rlIWQ3cfBofZNACV/CMHE13EOxYkF8qX1DGwrt974VUsFDraf2gLFEZ/v1IL?=
 =?us-ascii?Q?9pFpIQfs7DYEXXkh6+n24TKUthky2AVyAL6QY5ibh8A9xIkVShdx6cKyiLJd?=
 =?us-ascii?Q?Y9wY40ci3WfVFHYkucWymjT+FUj4aQ3zGK7Uba2W3ZWXnjN8FoYTBtmk4wNL?=
 =?us-ascii?Q?J2QutwMPI7GCxtJz6QeJsJSOG3mQX0EQNerNq/zM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53f7e88-c009-4db2-5d89-08dbaee148ea
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 13:58:01.8813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dd3BNjZ8M+O4haFi8hXyRsND9ChyYELTViXVE6mmYqsLm2EWDqYAgJ6fpRUaE8VmKEFP346J0LgmzP8HSUacw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 05, 2023 at 09:51:14AM +0800, Meng, Li (Jassmine) wrote:
> Preferred core rankings can be changed dynamically by the
> platform based on the workload and platform conditions and
> accounting for thermals and aging.
> When this occurs, cpu priority need to be set.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 36 ++++++++++++++++++++++++++++++++++--
>  include/linux/amd-pstate.h   | 11 +++++++++++
>  2 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 454eb6e789e7..8c19e1d50d29 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -318,6 +318,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>  	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
> +	WRITE_ONCE(cpudata->cppc_highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
>  
>  	return 0;
>  }
> @@ -339,6 +340,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
>  		   cppc_perf.lowest_nonlinear_perf);
>  	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
> +	WRITE_ONCE(cpudata->cppc_highest_perf, cppc_perf.highest_perf);
>  
>  	if (cppc_state == AMD_PSTATE_ACTIVE)
>  		return 0;
> @@ -545,7 +547,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  	if (target_perf < capacity)
>  		des_perf = DIV_ROUND_UP(cap_perf * target_perf, capacity);
>  
> -	min_perf = READ_ONCE(cpudata->highest_perf);
> +	min_perf = READ_ONCE(cpudata->lowest_perf);
>  	if (_min_perf < capacity)
>  		min_perf = DIV_ROUND_UP(cap_perf * _min_perf, capacity);
>  
> @@ -748,6 +750,34 @@ static void amd_pstate_init_prefcore(void)
>  	schedule_work(&sched_prefcore_work);
>  }
>  
> +static void amd_pstate_update_highest_perf(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy;
> +	struct amd_cpudata *cpudata;
> +	u32 prev_high = 0, cur_high = 0;
> +	u64 highest_perf;
> +	int ret;
> +
> +	if (!prefcore)
> +		return;
> +
> +	ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
> +	if (ret)
> +		return;
> +
> +	policy = cpufreq_cpu_get(cpu);
> +	cpudata = policy->driver_data;
> +	cur_high = highest_perf;
> +	prev_high = READ_ONCE(cpudata->cppc_highest_perf);
> +
> +	if (prev_high != cur_high) {
> +		WRITE_ONCE(cpudata->cppc_highest_perf, cur_high);
> +		sched_set_itmt_core_prio(cur_high, cpu);
> +	}
> +
> +	cpufreq_cpu_put(policy);
> +}
> +
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  {
>  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -912,7 +942,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>  	u32 perf;
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
> -	perf = READ_ONCE(cpudata->highest_perf);
> +	perf = READ_ONCE(cpudata->cppc_highest_perf);
>  
>  	return sysfs_emit(buf, "%u\n", perf);
>  }
> @@ -1479,6 +1509,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.suspend	= amd_pstate_cpu_suspend,
>  	.resume		= amd_pstate_cpu_resume,
>  	.set_boost	= amd_pstate_set_boost,
> +	.update_highest_perf	= amd_pstate_update_highest_perf,
>  	.name		= "amd-pstate",
>  	.attr		= amd_pstate_attr,
>  };
> @@ -1493,6 +1524,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.online		= amd_pstate_epp_cpu_online,
>  	.suspend	= amd_pstate_epp_suspend,
>  	.resume		= amd_pstate_epp_resume,
> +	.update_highest_perf	= amd_pstate_update_highest_perf,
>  	.name		= "amd-pstate-epp",
>  	.attr		= amd_pstate_epp_attr,
>  };
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 446394f84606..2159fd5693fe 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -31,6 +31,11 @@ struct amd_aperf_mperf {
>  	u64 mperf;
>  	u64 tsc;
>  };
> +	/* For platforms that do not support the preferred core feature, the
> +	 * highest_pef may be configured with 166 or 255, to avoid max frequency
> +	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
> +	 * the default max perf.
> +	 */

This seems a duplicate commments?

Thanks,
Ray

>  
>  /**
>   * struct amd_cpudata - private CPU data for AMD P-State
> @@ -39,11 +44,16 @@ struct amd_aperf_mperf {
>   * @cppc_req_cached: cached performance request hints
>   * @highest_perf: the maximum performance an individual processor may reach,
>   *		  assuming ideal conditions
> + *		  For platforms that do not support the preferred core feature, the
> + *		  highest_pef may be configured with 166 or 255, to avoid max frequency
> + *		  calculated wrongly. we take the fixed value as the highest_perf.
>   * @nominal_perf: the maximum sustained performance level of the processor,
>   *		  assuming ideal operating conditions
>   * @lowest_nonlinear_perf: the lowest performance level at which nonlinear power
>   *			   savings are achieved
>   * @lowest_perf: the absolute lowest performance level of the processor
> + * @cppc_highest_perf: the maximum performance an individual processor may reach,
> + *		  assuming ideal conditions
>   * @max_freq: the frequency that mapped to highest_perf
>   * @min_freq: the frequency that mapped to lowest_perf
>   * @nominal_freq: the frequency that mapped to nominal_perf
> @@ -70,6 +80,7 @@ struct amd_cpudata {
>  	u32	nominal_perf;
>  	u32	lowest_nonlinear_perf;
>  	u32	lowest_perf;
> +	u32     cppc_highest_perf;
>  
>  	u32	max_freq;
>  	u32	min_freq;
> -- 
> 2.34.1
> 
