Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCAC773C8B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjHHQHb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjHHQGN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:06:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21E67287;
        Tue,  8 Aug 2023 08:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwN5bTaoFDpetwlF17hZCTfDNc321VT3PgLK3+yf8jpZNddNVunTfrN6TVwITfQ8QOI7YyA7SH9YSHSQl6b+DNqMaVyRb7/kZ6H+rt0MFfNCpgzWYMPAJXlTxPQ4Ysp51vb195MvtgsijT52Ny/xjZciYgoATPG2p+fQUN/N4UFoFGwKnBcDMRCGqqtTbJY3AczQ612YzXw2fFWpJn8xxlhxChma57lKvOv97P45IuwU0XaHqJ4EP1S/tvhQwoFgK+oq4N0tK+PlrP6J6Kxe3u3KEY1y4AZW6vd6LwMYvIlaaXjRKSdNz9iZV/TGU1eRO390Hkj8ElaRAGdX7xUURg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmkgEJU0eq7w5Xy3TJ1r2mvIyF/MgQ+KxBUUTYzzd3g=;
 b=icm71Njtq5u1q3gu8dKL81eaewCzpx6QKGb51juGAnI9KhuGSluYp2XOpVi9Mo1dDEXO7YLodRO9XWp0Sf25vS2Otc+xMXnsU9pK4r5heiSbL7H8VhCTX6v3PzHWpkJa1tiT4AOf2DLxGcoe/2wdXDK6AQFI07Oleb++IVt9XNdE+o5ogE5hP4a1HR0CRX5cIy+Opsm6Z94Am3E5xngWXwoM9qCscB98S6uZlnpQeLgYbxQnryN1nisJEL4DFXmqI/2JHSOqKCAI8OIbNYrWUaYm1NHOQWSqgWpOUqRViXIz9HNb9Ift7T3katXceNJPWPUaK8LyKLBStM0GvSeZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmkgEJU0eq7w5Xy3TJ1r2mvIyF/MgQ+KxBUUTYzzd3g=;
 b=lm17J08KiNtZ86vk3Q+CieDHXB6dbxrXmXPg0Wqxw63nYaj4JJj1P5KQs09bSX9ijv6YHFupHXtoMITUCDd0XeERyri9R2AdKBOESf4MywNtuywMo27SG5b5DxS1MvPZo8aC5yvQYenfBV0KGm7CWKz7KnZGVyo7wvndRNgWMEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7619.namprd12.prod.outlook.com (2603:10b6:610:14b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 15:28:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 15:28:30 +0000
Message-ID: <5de00005-e8c6-4498-a5f9-e3c2d5b2cad0@amd.com>
Date:   Tue, 8 Aug 2023 10:28:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/6] cpufreq: amd-pstate: Enable AMD Pstate Preferred
 Core Supporting.
To:     Meng Li <li.meng@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-acpi@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>
References: <20230808081001.2215240-1-li.meng@amd.com>
 <20230808081001.2215240-3-li.meng@amd.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230808081001.2215240-3-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e448056-e674-4cbc-2c52-08db98241e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6tU1DjpBaVPW56sBPZHBYYp6EyZqjhxQzTZcW9KiX1099UqjzEw96Ygwo1wJ/ziW3MeF5nFIC42S+NBzlCEmpNNvZyY30QckjZQK65mDzvqmbHYonMzNLmWd4UTvbJf/zp4Amb2WgoEOhKEJPzBbBSW/vSmqcCs3GSqyVTF/km3w/LkJbuhK3bxvTaZWJJqniCmM1xeTjseUhGtpeWpd8Uns9CMruas8POEy5LqHOZ6oH3y3IrZkRgS8T3zj7dRrf2mi5JX2NRKkymJW66ABg2e3w0Rg7FjnJdrZ8BY9mMi6asigUzCzXd7qSi/UTrN2DIqZUAQUn3wPpWIP8dRnfCJ18HB19bIQBxNPepTDe8P8SbvuZipepdQ4znBAVwvaCVHcb+2n+nblE3tbieEe2hBVqPlmkJxHHh+NGfxU8SKSQiBkuWgG7UGrLE2jsn0pIUZ8S0W4XWpm+Zb3JMBh8n6A13XN/YvhuP2+RNd75ypfiXtGg19SrrYGQm7gNGMYVlKorT+iDhhHNZdRDB1t3uXmQPlNK/GF0nwUVe+z9MOTcyxX1e/cAn5411dSvRKF/WjDhRFYuMR6rnu1cVP2uFjjxbeViWS3fY2mXcKaWOPFoJdRdHv9+ZcCFHBnMzyZvA8Eu/oORaxNUd987HNp0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(186006)(1800799003)(8936002)(44832011)(8676002)(5660300002)(6636002)(4326008)(41300700001)(316002)(86362001)(83380400001)(31696002)(2906002)(6486002)(6512007)(6666004)(2616005)(53546011)(26005)(6506007)(36756003)(66476007)(66556008)(66946007)(478600001)(31686004)(110136005)(54906003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE4wZDlEUVRuMkt6OTE0M1hrYnBBbFlyQm9yeUdvZGdTUURweFhIWFYvNGxt?=
 =?utf-8?B?c3RMeUZmWkY3b056QWZPM2RrMjh0eHhNMi9wR3VQYUd6dFFhbEtoeW1hT09X?=
 =?utf-8?B?RU1jYXFvWHNHWDFMOERuMHZCdjdMS2dUR01JTEMzMU5iYnIzNjh1MUJ6UWM0?=
 =?utf-8?B?cHBxWnd6UjNMNU9ZYlVLVmRGbXY0cjdTNy9QL052N3liTHA0eFRhajBoK29t?=
 =?utf-8?B?TmRiVHNNWm41K1hKV3F3blpYblpRM0FxYTB0UjFveWZxaHlIM3lvVkJINk5u?=
 =?utf-8?B?cUxDTWwwbW95VytwQnhJUTFuVVNHTHNNK0o1SUNmck42NWtIbTVRci9yNlZN?=
 =?utf-8?B?T2JiaUNFcFpmblFIZ29lT0NBRWFlV2lRclZYVWNHY0hCQnV4eStoVTY1ODAz?=
 =?utf-8?B?Y2tTUXo4bUN1OWVCbFpTbHNkWXFodEF3SEhSVXd0M3NrR2FERWVLY05CSzJP?=
 =?utf-8?B?dGdieXdWL2hYMzBySUFjMXVOY3dqRHFiWDZybm5XTFAyUDBodTBVbHJJSG42?=
 =?utf-8?B?T0swb2plWWpubnQ4Y09ldUhkcnZVSFJodTdQK3ZKY3piSnAvMEcrOU9zNi9H?=
 =?utf-8?B?K3V1VzdIdThFdVA0WXk3VTlLZWFYQ2VXQ0hlb0N3eEpxQTQ0cE5OQkt0aHZy?=
 =?utf-8?B?dzdtdm1ySGZ1YW9aUFE0NVA4MkRCbkFOSENLZ3JEemxldW5yeHh3NmYxSVdz?=
 =?utf-8?B?bVBheHRZRWZrQ2duT0FnN2djeU96RGVDd05VWXJETjdIc0hTeE1JMjJtU3R0?=
 =?utf-8?B?eGwxbm9hMEdDTS9pOUhCeGEwejhaVmh5ZTd2QjVaZ1I5UmdnSlY5T2NTSjVE?=
 =?utf-8?B?cDhSWTZ6S3lZYUN4anJsTmE0aGpZYlBJK1REWVlyMTU4djNmNGphbEJDVEVX?=
 =?utf-8?B?M0pGbDArQjJOTGI0WkU1amtXNE1RWm9GQzE0Y1lmTkREYldOSS9HV0RFb2Y4?=
 =?utf-8?B?WmdKQ213WGpqOUIra0VleTI2WGFZa0RnblNRbnh0dE1YMi9iUldpUjcvNlpv?=
 =?utf-8?B?cUhONTFUQzF4WnNWbG1oUFpTRU5COEREbmlQS205OEczZk9WVFpVWWp1R0kv?=
 =?utf-8?B?ZjRIekc4WG96dzRIb1R3cG1OeVRYS3JZdEQ5ZHlSdkx4SzU1M3pTUTFlVDNB?=
 =?utf-8?B?bHRoN3dpajAydFBaM1RMNGNXdW56STBvVDRFeEdrRE5qbzVlSzgxSUVXRWhI?=
 =?utf-8?B?cG50T3R4aGFZTFM4RWNxZEFyYS95enR0a3ZQZlI1ekpiUmFDb2Y3dlRxSjVp?=
 =?utf-8?B?Q0dvdTVJMmVMcFkzOHlXTzMxR3dDUzZRL1RpZ0VHQ3ZHc0l6NGlJRjVlbEVu?=
 =?utf-8?B?akpFVHk0Wm9uR3ZGQkdwTFFwNzR6VFprN01mVzFoL1dkejlKQWxmdjJPbFlW?=
 =?utf-8?B?bXo2TGN3K1pZZ0crTHpreGNsVVhWZDhiQ1NHZXdDdjk0ZXhLY1U4cEd2d2Rx?=
 =?utf-8?B?dytzajA4K1lERDJvcDJKWkI2MWwzZGJxKzM4ZmlIWFVuZVh0d1VoelVZVjd0?=
 =?utf-8?B?VXkrcXhib2hsNmljaG9BWVNIcTNFbGN4bUR5bHphWitvNWVxbHhLbytoaFBx?=
 =?utf-8?B?NldUT3kzNDJndzg5TWlvVGJkclBEcHEvNldmeUdvZStJR21KYUtheEllZzB2?=
 =?utf-8?B?VlFrbFArUmRyRzFWWUNwV3VlTTg2TVhxTkcwbFVaZy9qYWE5QXROd0F3bnJW?=
 =?utf-8?B?ZjNKUEYzTno5ai96bzZSQlpzUXk0cjdBSlRJNG1UUXpnajJIT2hla1RWZDJm?=
 =?utf-8?B?ZVRiOUdKVFZ2WHpPanBRd0I5UEVlK2cyRTFUUFM1SjNVb3Z6alFETlNZaTlE?=
 =?utf-8?B?eDlTdjhSa2E2blpFeWxZZVkyRktFWHF2UnFGMEg4WG5pdFNHdEgyVStlODFa?=
 =?utf-8?B?WGQxbHlENmRWaTVwSWZwKzBIblhrZnlTQ3k2ZUJnblhPWTNvd3VRalVqd25H?=
 =?utf-8?B?R3gyZmttdHl5d2RsbmYwRkhLajR3TlJWK0dYZE9KRkpyM1pybmlCVXUwQ09W?=
 =?utf-8?B?U2FoRThNVDEwRUd4VHRxTlVyVDhheGVNU1o0VDA3UUJtMlBSajZFRmpHeGtj?=
 =?utf-8?B?Ym1WZWRnWTM5ZExablFKSFRhK0FCeExGQmc5VE1VVTJKUjNteVovTnJTT3Vl?=
 =?utf-8?Q?sK0M3q4+N1TMMc28VuyEvxNf/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e448056-e674-4cbc-2c52-08db98241e9a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 15:28:30.4925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ds5pfuxI+qYtj71iwfMpscIrRsc45ly1bgHAJ17moZ9vcyrs6me/T7CTLRWZs1DLSgM6RCttcTUleBmzUHyhkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/8/2023 03:09, Meng Li wrote:
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
> Signed-off-by: Meng Li <li.meng@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 149 +++++++++++++++++++++++++++++++----
>   1 file changed, 133 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9a1e194d5cf8..e919b3f4ab18 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -37,6 +37,7 @@
>   #include <linux/uaccess.h>
>   #include <linux/static_call.h>
>   #include <linux/amd-pstate.h>
> +#include <linux/topology.h>
>   
>   #include <acpi/processor.h>
>   #include <acpi/cppc_acpi.h>
> @@ -49,6 +50,8 @@
>   
>   #define AMD_PSTATE_TRANSITION_LATENCY	20000
>   #define AMD_PSTATE_TRANSITION_DELAY	1000
> +#define AMD_PSTATE_PREFCORE_THRESHOLD	166
> +#define AMD_PSTATE_MAX_CPPC_PERF	255
>   
>   /*
>    * TODO: We need more time to fine tune processors with shared memory solution
> @@ -65,6 +68,14 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>   static int cppc_state = AMD_PSTATE_UNDEFINED;
>   static bool cppc_enabled;
>   
> +/*
> + * CPPC Preferred Core feature is supported by power firmware
> + */
> +static bool prefcore_enabled = false;
> +
> +/* Disable AMD Pstate Preferred Core loading */
> +static bool no_prefcore __read_mostly = true;
> +

I feel like it's confusing to have two variables to keep track of here 
when it comes to the state machine and determining if you're enabled or not.

As an alternative can't you just use a single boolean?  You can 
initialize it as:

static bool prefcore = true;

When you process early params you set it to false if it's turned off on 
command line.

If it's enabled by the time you try to set up prefcore then when you 
check if the firmware supports it, if it doesn't you set it to false.

Your sysfs value can always accurately reflect the contents of this 
variable then.

>   /*
>    * AMD Energy Preference Performance (EPP)
>    * The EPP is used in the CCLK DPM controller to drive
> @@ -290,23 +301,21 @@ static inline int amd_pstate_enable(bool enable)
>   static int pstate_init_perf(struct amd_cpudata *cpudata)
>   {
>   	u64 cap1;
> -	u32 highest_perf;
>   
>   	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>   				     &cap1);
>   	if (ret)
>   		return ret;
>   
> -	/*
> -	 * TODO: Introduce AMD specific power feature.
> -	 *
> -	 * CPPC entry doesn't indicate the highest performance in some ASICs.
> +	/* For platforms that do not support the preferred core feature, the
> +	 * highest_pef may be configured with 166 or 255, to avoid max frequency
> +	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
> +	 * the default max perf.
>   	 */
> -	highest_perf = amd_get_highest_perf();
> -	if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
> -		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
> -
> -	WRITE_ONCE(cpudata->highest_perf, highest_perf);
> +	if (!prefcore_enabled)
> +		WRITE_ONCE(cpudata->highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
> +	else
> +		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
>   
>   	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
>   	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
> @@ -318,17 +327,15 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>   static int cppc_init_perf(struct amd_cpudata *cpudata)
>   {
>   	struct cppc_perf_caps cppc_perf;
> -	u32 highest_perf;
>   
>   	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>   	if (ret)
>   		return ret;
>   
> -	highest_perf = amd_get_highest_perf();
> -	if (highest_perf > cppc_perf.highest_perf)
> -		highest_perf = cppc_perf.highest_perf;
> -
> -	WRITE_ONCE(cpudata->highest_perf, highest_perf);
> +	if (!prefcore_enabled)
> +		WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf);
> +	else
> +		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
>   
>   	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
>   	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> @@ -676,6 +683,90 @@ static void amd_perf_ctl_reset(unsigned int cpu)
>   	wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);
>   }
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
> +	if (no_prefcore)
> +		return;
> +
> +	for_each_possible_cpu(cpu) {
> +		ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
> +		if (ret)
> +			break;
> +
> +		sched_set_itmt_core_prio(highest_perf, cpu);
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
> +/*
> + * Check if AMD Pstate Preferred core feature is supported and enabled
> + * 1) no_prefcore is used to enable or disable AMD Pstate Preferred Core
> + * loading when user would like to enable or disable it. Without that,
> + * AMD Pstate Preferred Core will be disabled by default if the processor
> + * and power firmware can support preferred core feature.
> + * 2) prefcore_enabled is used to indicate whether CPPC preferred core is enabled.
> + */
> +static void check_prefcore_supported(int cpu)
> +{
> +	u64 highest_perf;
> +	int ret;
> +
> +	if (no_prefcore)
> +		return;
> +
> +	ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
> +	if (ret)
> +		return;
> +
> +	if(highest_perf < AMD_PSTATE_MAX_CPPC_PERF)
> +		prefcore_enabled = true;
> +}
> +
>   static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   {
>   	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -697,6 +788,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   
>   	cpudata->cpu = policy->cpu;
>   
> +	/* check if CPPC preferred core feature is enabled*/
> +	check_prefcore_supported(policy->cpu);
> +
>   	ret = amd_pstate_init_perf(cpudata);
>   	if (ret)
>   		goto free_cpudata1;
> @@ -1037,6 +1131,12 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
>   	return ret < 0 ? ret : count;
>   }
>   
> +static ssize_t prefcore_state_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", prefcore_enabled ? "enabled" : "disabled");
> +}
> +
>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>   
> @@ -1044,6 +1144,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>   cpufreq_freq_attr_rw(energy_performance_preference);
>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
>   static DEVICE_ATTR_RW(status);
> +static DEVICE_ATTR_RO(prefcore_state);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -1063,6 +1164,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>   
>   static struct attribute *pstate_global_attributes[] = {
>   	&dev_attr_status.attr,
> +	&dev_attr_prefcore_state.attr,
>   	NULL
>   };
>   
> @@ -1114,6 +1216,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   	cpudata->cpu = policy->cpu;
>   	cpudata->epp_policy = 0;
>   
> +	/* check if CPPC preferred core feature is supported*/
> +	check_prefcore_supported(policy->cpu);
> +
>   	ret = amd_pstate_init_perf(cpudata);
>   	if (ret)
>   		goto free_cpudata1;
> @@ -1506,6 +1611,8 @@ static int __init amd_pstate_init(void)
>   		}
>   	}
>   
> +	amd_pstate_init_prefcore();
> +
>   	return ret;
>   
>   global_attr_free:
> @@ -1527,7 +1634,17 @@ static int __init amd_pstate_param(char *str)
>   
>   	return amd_pstate_set_driver(mode_idx);
>   }
> +
> +static int __init amd_prefcore_param(char *str)
> +{
> +	if (!strcmp(str, "enable"))
> +		no_prefcore = false;
> +
> +	return 0;
> +}
> +
>   early_param("amd_pstate", amd_pstate_param);
> +early_param("amd_prefcore", amd_prefcore_param);
>   
>   MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>   MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");

