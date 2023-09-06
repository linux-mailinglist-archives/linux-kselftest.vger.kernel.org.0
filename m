Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106CD793D77
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 15:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjIFNLi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 09:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjIFNLh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 09:11:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA05410C8;
        Wed,  6 Sep 2023 06:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmveC3JiTsrL3E2zg7+0iE+IDR3P2sCXQ+2kp+a/TT0Djc9hRDScHlFUwdS7LQEbty9pHjQnsYLTQSotFAc1lPFTsU7/cGvtheJBpkUEWzeoZOd6dU+7hJNXYowo9LBIGkB2Gowul1O59p43LPkOxZgR9EtLN0YpywftqItYsVdijHqQ3QjDH3G886Nj8DuNvgjd+/ibw7X+K3aWH8H1NardTKLm3NJIDXF71+OXvWMFb3Kc5HwVCFqm7kzN1msP2/jqseCeXzpK8oGtftNjUnkfCLjUjYpaalQa6m/WgxPgdCYkBReXO7U31IVOZ61HB594agG7MorYKWS01Dsl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFugSFc5sErIba6EKUJf92SdRg//N8v85O2Lwop+HYU=;
 b=hXAJ+v92/bLZ7lNPTcWUiUSRokitO1vSBMKtTGkKwPikASWeD2gAgxE1MYe0R1cpCe7nzM2Cvpwfi/3iLGxUr/RqBIH4W2suYadRiufjNZY5xVb0VrovxnR53ayCpPGvdndCf80URI1q0aihA3UQdRCPI1cTEklEmETLlRj9J9BG4PYDBCnQMtl3iMcwlKiYAEln795q17VjWY++nX6N5Je9iveK4Z4BQxmRPx/sHeEXmAfbdt7OOlwg2eE5zXDgwlhCnp/+lv3VbRUrdkL3iSnFnGlwgdPAq7ItCy5D2FDuHe29qEAAeEt96VBti5YGBSNOiQhZkFM/0O6S3mPULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFugSFc5sErIba6EKUJf92SdRg//N8v85O2Lwop+HYU=;
 b=KwREbWS0a/jt04JZP3+C0GFviQEn57b9Ugxi7AOOvrESI0Rt2QS67ecUz+kVrYCVzvdtxFPjh7Tb74zkv3GJ/mvv7GCroizW7XBpiOONFIIL+O/yYa4PRPx4If72zAUjXroo/cy+gqxqzHJnnmWDgUQNWh39jYvo+G5cbnqvKnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 13:11:27 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 13:11:27 +0000
Date:   Wed, 6 Sep 2023 21:11:04 +0800
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
Subject: Re: [PATCH V5 2/7] acpi: cppc: Add get the highest performance cppc
 control
Message-ID: <ZPh6aALLZ9/FTpKX@amd.com>
References: <20230905015116.2268926-1-li.meng@amd.com>
 <20230905015116.2268926-3-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905015116.2268926-3-li.meng@amd.com>
X-ClientProxiedBy: TYCP286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::11) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|MW6PR12MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c940d3-731a-4eb4-4386-08dbaedac6fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SOKwQzPJjatuwPcJZNjMmxfkoGYK7FzJ4FlbBv8SDOn0DARzYuOiDKNqZNI6RIIHv4O99ToLmTNe4NtbD0ATncjKx5AKAGe9bjfN0f3O6BNVMjdd+bwIbodFNvxXaeMcUqRbOzE0jIwrg4M+Si1YjchU8CfBNd2UeoYFa6Qtaxj6avBNe40fgOteu1ltAvvNSLKvIrmU/pJOcX+vuKD6zS8slnfAzFd5W6K4rAMo36Akn9IRyR9sJBi/DtVRgkSsjOky0cCMu4FhV9tuLdNjIqN2B9gWvjtcirv025D6mM3H09CV+ThyK/7odQsyIycs9pxQBhlMx4NWThDVkCVWsuSZFDNkDSnZKKkeBSwT0Ozu8NXf/oCCJW05vgU6TAM1OgXDsvOeD3XgmQ5qeesu2+ZFi+3k8HOw2USjQ3AFNTGrx8ceB50r9lYbg1hLVkhWavzXNY5bRFjNhnvVguaTjeZwFcBd8NU8VZzYNfWaKxT3eed2e+00WjatUNm37nPABQWy1xGoO2lv/Abv6mt+vUnQo2pmW62TK73BU6vFG6g7zeHmf0bQ4Beqj6degTvkT8d8lwT31ZEIUkfFwXVFt+9hqP7/UwLzDJPiQxZFBB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(396003)(366004)(1800799009)(451199024)(186009)(38100700002)(36756003)(86362001)(6512007)(6666004)(6506007)(6486002)(478600001)(2906002)(6862004)(4326008)(5660300002)(8936002)(8676002)(41300700001)(966005)(6636002)(66946007)(37006003)(316002)(54906003)(66556008)(66476007)(26005)(2616005)(15583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WgXRZEgcBruvzsd3FSaDYLJlhlekvKp2blE920br5teUVSQpLVA0xd+EZcBE?=
 =?us-ascii?Q?iC+QI6LgF7gBFyYKh8Ae3Sn/nCVoY9SAIJ9uWn73yaiNlkR/es8vjZPNDJBb?=
 =?us-ascii?Q?WrKFTGvmbYmcHVcE3YfcH5d11EjPlrNuO2XMGaJASnuyuArb01xO59+DwSwY?=
 =?us-ascii?Q?hCgHS5md5/Gt1OJadBc+hVDJ4VQ/LjiiSpCe3lP3ckJGrt6FQpH1SNJz/ueo?=
 =?us-ascii?Q?AitXIX9XBfFMVm6wJm5NTkK6Iy7sDqVKXqes7NvGDyhgS09lby58AMLKUsJY?=
 =?us-ascii?Q?HpGZluqxnTA3k/L9hWTMjf5J5B0SmKfp8ghZf8oYccOWbrBUnJvg8YIPjhak?=
 =?us-ascii?Q?pOk65StzZSSA0udo0OV2pNVJuQ/G2YwH/WDjGciBMgNUkC2xGO9uuXWWTgJv?=
 =?us-ascii?Q?u6bfKbd9ID5W4Q2w1tI1GT095gydFdS2AuJcsH0Tfxfv81yXNzibF23oKrlW?=
 =?us-ascii?Q?aqI2Jx7vJP2sEDuxPnfTLNBjhYbAg0SUB4F6DCZVIGGVTkNdEBGXX0sekm1Z?=
 =?us-ascii?Q?+ElZliVqRt329x5RKx3mJ/7vd1RUZmUFd6HSDF/Uey3GNSBVX8Xw/OYHJLkL?=
 =?us-ascii?Q?CbO3iSd/8T/AQh4De4eKKz/Y+ZvTBVcIL0qM9YrHOvFDFLyNblLamQMmcGky?=
 =?us-ascii?Q?EIsF5ehfy75FQpklzUg/SqIrHWb4C3DIaEtL5hmcIMnNzkA0EYTGgxBqru3R?=
 =?us-ascii?Q?fVGqa2icNyL6WgJZgkcVsURb7l9yxooNr/2tQx3iE3MzhdxMAk5C3tMc6dgV?=
 =?us-ascii?Q?2ryabq0+LvmC4OLsyzdiujdA6FWd1z4qorE3E2ykWlByAcBv3WTWdmsL7FPq?=
 =?us-ascii?Q?QZlLkvEBBRDF332l57HdDHvz3GKozUTx1oABJJloQuNm16l/4gqrII8oMxBz?=
 =?us-ascii?Q?xlX2kpynWecVPFpJJBK6N1hmgL8kl0eVzuqMipPTVjggUBLYaMagbZFFaZwH?=
 =?us-ascii?Q?cyc+91uWtYQnjBOz8Ol2uksWwPX2ICMcqUrB2YYeXvF5bKo7Q/YpS3Bll/H5?=
 =?us-ascii?Q?9K+7L5UrL3RBORTq1SgsuRi9twe6oojyfOhpzMM3IePwZvlscCWEOA6jumU5?=
 =?us-ascii?Q?koryqOsHyUoYmhRjlt8PiMOk6dSuphd4H+JHTZOnVrny9IEDcJ6BcnNP9Y3J?=
 =?us-ascii?Q?Wew+Ntpek1bU6H6Srxei0nZOP47wt5d+SyBbfvfOo7NdxOs9XJaejUE0YrLt?=
 =?us-ascii?Q?amyfa645i1JAD3wy01suWByQKXdO9vjyrRuZRmNXvvPKCIqlxf8JoLDQg4JI?=
 =?us-ascii?Q?kUzM+Rfkrq4QuKAtW8eD7tGqEBTCUrhUCXImNOBVG1KXTEhw47i8Tru5HOiJ?=
 =?us-ascii?Q?YV9wqzbIbFRbrw7SRWGT5emwA31gIvEIaccEzd8uGSy7s1z6t1CKpvSa8DyV?=
 =?us-ascii?Q?BEqQvql3Irvr8be6AASQrmErdynIx9qWE9D/fsQHCouplaQEVzMcEx2tduQ2?=
 =?us-ascii?Q?29evY0AW7olRjYQPbzt0/xmWabQtyPVzI08CUlrxZvr90PT04ymPtaCHt5f9?=
 =?us-ascii?Q?lUzbnLlyGZLUJEA9HeOZDaJBWj8S5l5DkhWZ9YNjD8Z0RTaj9pJ0CQYk9pzm?=
 =?us-ascii?Q?WMXMkp52HCCeyiRfn0xO8IBHcKUHHa7dYnqwm0gV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c940d3-731a-4eb4-4386-08dbaedac6fb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 13:11:26.8989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7PKP8m4O898hE4FNfPg1+TI7lR2KUowY+t/qlFuOGnQU/cYB1n6OtS9yAzxBjRJLKr9DIieDScsDNmPR43YCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 05, 2023 at 09:51:11AM +0800, Meng, Li (Jassmine) wrote:
> Add support for getting the highest performance to the
> generic CPPC driver. This enables downstream drivers
> such as amd-pstate to discover and use these values.
> 
> Please refer to the ACPI_Spec for details on continuous
> performance control of CPPC.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> Link: https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html?highlight=cppc#cpc-continuous-performance-control

Acked-by: Huang Rui <ray.huang@amd.com>

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
