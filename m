Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E93277CF1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 17:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbjHOP2k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 11:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237978AbjHOP2T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 11:28:19 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52301980;
        Tue, 15 Aug 2023 08:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlZXXaFCtBZsr5vjyGJC8FfcGNaW++ef++flZbozLo5c1EgKhiM5Ga99aqchbnN4TQaDCjJ2JA0WgrQEYmyOIv0Q5VXs9jj8ldloO1i9mp2vnnUwJGoG2qTqHtpOYvqOzL16Iv2g+NA6CW0s0xh9rS3+YBh+2poIuEvhQCkRfO8meY9vAyzKuX6nN7hLCYGvsPbKHOjGXy9aIdydVCPM5Pgx5SFU4sB6Fy6r8qlVVNnoF88TuZMd+I6H0CEzvbnPsLeO+doKCvC/QcW8Fm/1lwKCjqUBpQz46Bi0QNYNW0Y90pXsxZYfl5J+Fx0AYcj+qvHEqNd7pz9r8+QuDjwjuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cKLpk7eYAD4CbDhU4qAV6JOlznESTQD7cCdk3UzLSo=;
 b=En7u/pM5Yf6yrM4SFHtlTF3s1YbrbwQT46+WF0eZlKWGPbZ+ki6ayyPEkYLt/trKwZA5CbFPAqQSJvUyk9Z69vWp89HFWcRhcbY8bOWN/ocrMkm/RJjmpJIKbCHjc9bzalqdLAabPD2/5TcMb0POsEiR8pFoM2JsDtkYknTtGOiCCHqkRXmlU4gsEqYG0jLQJAB6V6Y3CqUET+O7B1uQ4ouUvmJAgEdPYr62/VljKP41M22QVSvByK4NaBc225Mw9Hjqh9fmcp8Zs/X+/Ch30Jmc1PFxw3MIoy3CQL+lhE4KUjIwoDQbbT19yjzAF15r1Zu1K4mqKvC0kdfPcS57XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cKLpk7eYAD4CbDhU4qAV6JOlznESTQD7cCdk3UzLSo=;
 b=ToUXaR8s/hcoBrC7w68FIKdpwVWYplxkWPGAlRqQV9KBBmuooVowUkeJ5lgAFGlo576yMmR/yLwePvZxZZW7wzE5FYfT4ln6fWdYDeERHqZqahXUsoWtSpIvR4PUHO7QLmOX9S3E+WZX/LcrGLLC+1QebCLyEMHTj/FYSHrQyTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:28:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 15:28:09 +0000
Message-ID: <343e5729-cc88-4ec8-b166-3b33a8ca989e@amd.com>
Date:   Tue, 15 Aug 2023 10:28:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/7] cpufreq: Add a notification message that the
 highest perf has changed
Content-Language: en-US
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
References: <20230815061546.3556083-1-li.meng@amd.com>
 <20230815061546.3556083-5-li.meng@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230815061546.3556083-5-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:806:130::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 8745732b-039f-4ef1-2ea1-08db9da43ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zm3hyflHIm50ZNuZwRXTO/iuLXsJGiJ7BDaL6M45t4hn7nYZDRFKSaRqvVBVbQIdKzurdfX14620RYdoTvcWqJ5uPt+9WHE3umFh6IwXtKq0M9u8C5t5B3CJIq6tgXQ9lABzOzayGxki7fl5lIuyOrgrHyJsAJ/L64GJ/B8Bro8/I8ym49FDWjSsTFd0SvN6jOyYbDuPft3VsGo773p38J99Bs9Htau2hxF8eFdqQZ8ol9YVZZtxXItvUzCZG8M3GEJ2z5YdZtNI7rimz1GnAGn2CNjStFKOtVYEDhNCy1H/lm/U70L7e+vuj2Tcf+HSfzoi8kSd73Bainioj695vh5Yhywni6L1yRP+z+a7LZHc2ry/TVQtwiBEwd0ZL/b9cEaVgdeTvGN8GPvJPEDk/yB+LbZ/5LZNak98ds9SrVbBr91YxNK3OoPO8jou5nuU3lXOZC8QdUZE2HqfT0xifbDkuUaSLehy099I0GxLK9mOQ4xKlGeaobuP3RRw+pz4/UH1WJyFmRRcExpARRBgADvUFDa37acngGc2YYQseuLNfkTorSKsEGznvcq5kAv56lwc5VKTUMyyyHIZWmTLZl4sjfP5RX9bf5ra5yQ2fWFs88AfuzAtqwOui4MND9UeLbwZbUjsRHLjkpCXQH4dcpO21teZy7wIF6yLo6kzmGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(366004)(346002)(1800799009)(186009)(451199024)(2906002)(8936002)(8676002)(44832011)(4326008)(966005)(6486002)(478600001)(110136005)(54906003)(6512007)(83380400001)(6506007)(66476007)(66556008)(5660300002)(41300700001)(6636002)(66946007)(15650500001)(316002)(2616005)(86362001)(31686004)(36756003)(31696002)(6666004)(38100700002)(26005)(53546011)(226483002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2s4OWZac0gyVkFzSG00MkcvUlh3cWs0M3VER3FyZG1ORzNoT2dGOERzR0hW?=
 =?utf-8?B?K3lqUUpsT2pvbG9pd0JQait4UEVDWE5JblVwMHhmTCtsOG9aZ1VMcWZ6ZUdw?=
 =?utf-8?B?WUlIWmpUVUg4TmVxb0Z4YjhpOERkV0FOK044WVJjb0N2bFZua0hEaHBhZW1E?=
 =?utf-8?B?VGc3WjJPbWNCRytwYTBPSkl5WnVvdHZqSjBpQ2NLeDdNQU1xNVBrNWNFZGFp?=
 =?utf-8?B?emNVQ2hOZTlkellBNTVwa1RyWUdzYjdnVW1uRXV4dkU3UUM2YlJrNGx0Wkky?=
 =?utf-8?B?VlZoVXg3M3JNT09VcWgrSTlVRHFxUlpnR085L1JYRnNDeXRmZmhudUZ0cTBI?=
 =?utf-8?B?NFhuZit4TUcwRi9QWDNyck9LODErbGJmemdsQkQ0TTQxamdSMjY4YW1XNm5D?=
 =?utf-8?B?ajFHVzZVcjVDWEpjSHpJWDl4SGk4ekdxRHMxVGZoY1Rnd0oxYVk0SzlEZzlC?=
 =?utf-8?B?cXBHUTZjbUZ3Q3JsM2Q3YlphdmdJb214cUIwL2VDNllBaW5WNWcvMklNTGdJ?=
 =?utf-8?B?NnNqcEZVUy9lQ1BaWjNjVFI1cW5KRU1MRXFhOHg5WWVDcmE1Z1N1MFdxZnNM?=
 =?utf-8?B?c0U0cFNUelh0YW9Xc0RqbTAzNHNKQWF5ZktSaGJSZk1iSHU4ZGdHdm5sYUgx?=
 =?utf-8?B?OWIzN2xISTdPY1Y2ZjduTjZBenFsQ3d0RTV2NlBXb2w4blJTZkk0OHl4TCtN?=
 =?utf-8?B?eldUMGpISXpjOElmb1Q1UkZnU0V5L1NDWVhDRll3ZVBiTk9hd05RbjUwNjNu?=
 =?utf-8?B?OHFOYmJIVTFtdW53WEdjUVl1aTNlaVlWbDJ3eFNiT0NvRloxV0RmVzlVQk9E?=
 =?utf-8?B?VXF3QURjcXhGTG1vdmljYi9Id1RjbXdoSG02Zmc5UXJYMktFNW5PcFI0NXJZ?=
 =?utf-8?B?aE5LUjBCNmlsZlBudFNIUUNJSStQOHI4TGJMak8xbnZDdHVJblV1V0pqR3FM?=
 =?utf-8?B?ODFQM3JZNG4zNnRBU0RiOXBhbXRMQzZTRkkvM1g2aGluZ3hNMVBlS2JRTGh0?=
 =?utf-8?B?bFZiUnRHdm1reGduU0NpOHdOQ1QrTFpJZEdXTWgzU28xYUo2Z1U4Mlc3bmNI?=
 =?utf-8?B?b0NRcnc0Mm5wbHpmS0RQcFk3NDVzemRxMXUxYTdmSFM5NkczNFhaMVRXa0Fo?=
 =?utf-8?B?L0s5bkRrMWQ5RDNnbDVsY1hxRlcyWTNSMGpJLzl3Q1JDOGgrZVVzZkk3MStT?=
 =?utf-8?B?Rys4enBOaWxTY1J3dTVjUUJFMU1BbUpieXdnOG4wMlRBUVJqblNsR0w0K3hp?=
 =?utf-8?B?VWtQdWVjaERvRDBSdCtKQXJrWkticnJBY1A3Q3JiTDROcE91ZkZQTkpxNnFL?=
 =?utf-8?B?WDhUcDRacnZsTjBrMlVSbnNxK2tLaW1NalM5V1JtTWxuMTJzU1NNc2FLdlM2?=
 =?utf-8?B?M3hLQjl3T2hsVFdaNkMyRjN1MVlsK1BLajMzN05OR1JjR05HaXdGY2FtT05l?=
 =?utf-8?B?T2hyN1UxMndJSVFLZVYvWTVYTWczaTFJcFcrKytvdS95Rys5SkFmK3YvdXBr?=
 =?utf-8?B?RkRncnU0cTJPV0VXTG94Ri9lRDFYZStnOWFMNThKc1FLR1VIOW5zRzd1K1Qr?=
 =?utf-8?B?bDY5bjF4bEtuQllWSndxeUcvbjJjUjU5Z1VVQ3pGMUZwQUNMY05aSkxEWUlL?=
 =?utf-8?B?ZGpyVi9wbUhXOUN4Vzd5TlRNZEh0a3JUVldaaDYvYVNjOXc2MmpJcXNnaUlM?=
 =?utf-8?B?dTkrdFpzZjVZUDN0QzhJaUxKQSs0QUdkV1RxR05yVjRmRXdIUnlBZFVYZ1p1?=
 =?utf-8?B?TUpnOFlsaW1QSmRrYkVkaDFuRElIZFZmVndVWFc3cmt5dXZNM0F3UUNmUWNB?=
 =?utf-8?B?WnpKRjB6NGxSb3RzOHN6RHlwRXAxVk9WemFUTmJwc1k3TXQ5dk8xc2NQTU9E?=
 =?utf-8?B?Q2ZDM1VtSVUyaU1JV3RqOXphdGF4YlJ2K2xKOWliSEFKMUhIWU9TU3plOTZU?=
 =?utf-8?B?eHArS0swT0EvWmJHOW53dCt3SUk4V1NXd1VCVDluOUhTeWpQdmg5S21uNTFG?=
 =?utf-8?B?Znl5ZG1NL2hIZ1p6dVJDUjVDMnM4RHN3RVkzRkg0K0c5ZjJDbFBUei9tbHJ3?=
 =?utf-8?B?VmZFd3l2TnBoYmE4ZjBzT1lSN0hZbjlqelRueWdIRTMyd0Y2N1plSHFQZElN?=
 =?utf-8?Q?PXvhIRY9nyyLkA5V668P3YLBj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8745732b-039f-4ef1-2ea1-08db9da43ab9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 15:28:09.1839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8uXzoCzsC7NMc50x+dTr8CS29L+BHJi8FpTvytpJo7mpoqZhxKzJSxcoymUvI0pWqz35D0rJlbtC3kWgsJgs4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/15/2023 01:15, Meng Li wrote:
> Please refer to the ACPI_Spec for details on the highest
> performance and notify events of CPPC.

I would suggest wording this differently. Maybe something like:

ACPI 6.5 section 8.4.6.1.1.1 specifies that Notify event 0x85 can be
emitted to cause the the OSPM to re-evaluate the highest performance
register.  Add support for this event.

> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Link: https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html?highlight=cppc#cpc-continuous-performance-control
> ---
>   drivers/acpi/processor_driver.c |  6 ++++++
>   drivers/cpufreq/cpufreq.c       | 13 +++++++++++++
>   include/linux/cpufreq.h         |  4 ++++
>   3 files changed, 23 insertions(+)
> 
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 4bd16b3f0781..29b2fb68a35d 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -27,6 +27,7 @@
>   #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
>   #define ACPI_PROCESSOR_NOTIFY_POWER	0x81
>   #define ACPI_PROCESSOR_NOTIFY_THROTTLING	0x82
> +#define ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED	0x85
>   
>   MODULE_AUTHOR("Paul Diefenbaugh");
>   MODULE_DESCRIPTION("ACPI Processor Driver");
> @@ -83,6 +84,11 @@ static void acpi_processor_notify(acpi_handle handle, u32 event, void *data)
>   		acpi_bus_generate_netlink_event(device->pnp.device_class,
>   						  dev_name(&device->dev), event, 0);
>   		break;
> +	case ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED:
> +		cpufreq_update_highest_perf(pr->id);
> +		acpi_bus_generate_netlink_event(device->pnp.device_class,
> +						  dev_name(&device->dev), event, 0);
> +		break;
>   	default:
>   		acpi_handle_debug(handle, "Unsupported event [0x%x]\n", event);
>   		break;
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 50bbc969ffe5..842357abfae6 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2675,6 +2675,19 @@ void cpufreq_update_limits(unsigned int cpu)
>   }
>   EXPORT_SYMBOL_GPL(cpufreq_update_limits);
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
>   /*********************************************************************
>    *               BOOST						     *
>    *********************************************************************/
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 172ff51c1b2a..766c83a4fae7 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -231,6 +231,7 @@ int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
>   void refresh_frequency_limits(struct cpufreq_policy *policy);
>   void cpufreq_update_policy(unsigned int cpu);
>   void cpufreq_update_limits(unsigned int cpu);
> +void cpufreq_update_highest_perf(unsigned int cpu);
>   bool have_governor_per_policy(void);
>   bool cpufreq_supports_freq_invariance(void);
>   struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
> @@ -376,6 +377,9 @@ struct cpufreq_driver {
>   	/* Called to update policy limits on firmware notifications. */
>   	void		(*update_limits)(unsigned int cpu);
>   
> +	/* Called to update highest performance on firmware notifications. */
> +	void		(*update_highest_perf)(unsigned int cpu);
> +
>   	/* optional */
>   	int		(*bios_limit)(int cpu, unsigned int *limit);
>   

