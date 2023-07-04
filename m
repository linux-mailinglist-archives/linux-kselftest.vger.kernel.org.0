Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAA074687B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 06:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGDEuZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 00:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGDEuY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 00:50:24 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41179B3;
        Mon,  3 Jul 2023 21:50:23 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3641Shmq019686;
        Mon, 3 Jul 2023 21:49:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Ma6dJRQUDph+MbpcH9a8U5w7RSp5NCq8wXBbkTGKIn8=;
 b=jZSc1YYRYYARl9xofZajkLEJfcQyjn268Fs4S7RDBq8PxoUdFwGq1d+DEFDHF0g6Tk6i
 FQqDB/51UpKehL1TqmwBSbhB+04XkvJyT3l5QO/sxuhBrLWSwRZccj/LLC2OLFbW/cSY
 pAd+L0rUC1Nng5N5f61G0Gmpztm1Zd6/2GaJxuIocrhcXVqMLJ8UqZ4I+1rUpP/50lBs
 6titEQuUtUAUnsNcbwtYpXjJ41s0Vc3sqkB7DpllQmU+fHMrAp/y49HEx4y34MjvUe9N
 f8rzLs9EulWxdFiwRt/Aaqj/MGUkn+FBwBCEwuzQ8XV0Y8kw6Z49zf/3j7OSMkg6zZ9Y Cg== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rm9sqs66c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 21:49:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cz2byJiH5rDQ0G84+k4875oVpMKa71HRUjqa+vhqyD0ttLloci3vpV+S9kHdo6CyodGeSEAM9eH0eE/HvnC6i9jPmRlHghyoCGAlOALeZh7N0VaAwJzCtf8c67e3190kaId8haJbSxo/h+CHI6CL4noVHgQ1+CaJLR2uA+xdTBkqiIadP6FjzqPOpZDMuRyJYtmP23mHWdjHvGlbRt8zKKURYFF58zhmHzKQOhMADGIdWJfPCjPFGcV29bl/Qo/J4mRu/+Wjiq4wc3ZKxXNMRmzcoyh/blucyYvEY5/SMX/cn/YzHRNAB91Afi2kOayGPtmDq3ACbF22Jj9R5AoA2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ma6dJRQUDph+MbpcH9a8U5w7RSp5NCq8wXBbkTGKIn8=;
 b=k3oxCpX0VBnC65pHz3qlZVzdsMEZqvBHykRKn/s4233pzg3GiSEFbKrSep2nZ31IEc+eiugP93HeK5pZ/iH0BO0I/khp0HOYVmXaRsJO6jrx/h8RbQlYpD3AgqL9FUnjVH5vOOQivLkBgp0EEKqrInBQdaX+/QhrJp5qr/qhHqbcWCSoC/8mSWtJCPm23vMlDSGiGMK4Fsb0tMnrs6aCeYBwDvivQ1Pa4Trtx8EvIvkyGp6RxKn8gmz40EGSHZ3eGwc0ZSm9ivjqSA8mhgWfOdZy+hHLmqQsIDv6AVrh7bGEFW719TN6HbSvJwkeQA9i9+nWREA8/fw2zArgcKegqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW3PR15MB4025.namprd15.prod.outlook.com (2603:10b6:303:46::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 04:49:45 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 04:49:45 +0000
Message-ID: <0ec3be00-1be1-540b-7598-a693c5a92c8a@meta.com>
Date:   Mon, 3 Jul 2023 21:49:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] x86/tsc: Add new BPF helper call bpf_rdtsc
Content-Language: en-US
To:     Tero Kristo <tero.kristo@linux.intel.com>, shuah@kernel.org,
        tglx@linutronix.de, x86@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, mingo@redhat.com
Cc:     ast@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, bpf@vger.kernel.org
References: <20230703105745.1314475-1-tero.kristo@linux.intel.com>
 <20230703105745.1314475-2-tero.kristo@linux.intel.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230703105745.1314475-2-tero.kristo@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW3PR15MB4025:EE_
X-MS-Office365-Filtering-Correlation-Id: 629a18c3-4302-48d5-53a9-08db7c4a1647
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BLRgewOewydTngUv60kw/WL/zXdJLXF7pG1IUj5thXHRKldkQTBKy22TD4hhsMtWBdXKPbTukSg8/yxO1EF2prdarVQyaQ3eOt4SJEeQBCHa4KJZaEUnrUzttGhtJPIgywkewzpUfQ/uS1xV8VL7P/t43hb5tT5VCQ9EDIwVnce1dJtczs5ltMoB/bS2vHDLlM1JKsD6G7m4Nuwx2OkxOEH6y0Nr4Ab3Nh3bbjNRuA3QnvmlX8kRCXDVVxokLXvY5QMDXQTkv1Ht/70IkIWFzu4tHllsAOFZl44k4sPjci5MG+MioUm2jU4eTfnWm122fJM+T3Xeufil8Nj604JUQ80gJe3AE7PUr0btmq+YQYYrPGLArRkpPMwCEQ8fjQfayVe0TytuL2KrYJgRxBfb7kcAcMecRt/K3d/NNyya8EIMKbWOlfVDz2x2HwVRETHVpyUlMqty/h51eausMaPp+2ESNYCyJJ0ZJ3sgmvfmD9NtTYDKyQsUQ1a5W49eJATLmWdpwX4FWC0RivWTmsr2HPBSorbsOhEI26W6adBsXTQz53eONbzcK5PC676uSI1xkvDIWKXGZDAFtxC++MpsFvDQk1nV/p13yWCb4ezs9IemjpLFRRMvv64mubYWgeRhg3LlJ/7QWxry8jubR05iQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(7416002)(31686004)(66556008)(66946007)(66476007)(4326008)(478600001)(316002)(2906002)(36756003)(8676002)(8936002)(5660300002)(41300700001)(86362001)(6486002)(6512007)(31696002)(38100700002)(6666004)(53546011)(6506007)(186003)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWx4eStDNG54RlVndmw0eVl0K09jQm5EOUtvVkUxVk96d2FRSzVOSU9BblJn?=
 =?utf-8?B?WENlekFPWUs2N0wwbVczU0hNMU0rY2pQN2t0WWs4R1J1cmVkOUR5T1BHSzhJ?=
 =?utf-8?B?ODZ5SWFsTmovcGZFTXdlblhQaUcyWWJ0Z09pZEJ5OUhnR0ZYZUFHZEhyMFVJ?=
 =?utf-8?B?c0xZN3JWYlRjdkg0ZTNWb2ZKM2N3K1BzK21yYlZlVVpaWXhDMVdpbi9vYnE1?=
 =?utf-8?B?UlQ5dVhNMktMMkhKTVdNcm5idVYvdkp0VXQvNGx3WGlBRnhkOFB4dDdnSU5p?=
 =?utf-8?B?cmFZK2h6V05SbVlUcXphRlhHMGp1NWN6U05NRjhUQWNMenoybTZqSThob2JX?=
 =?utf-8?B?azRaTkNzaldKNm8xSXJicXJoWEp5QlVOVER1SlNlS0hjMitRVTkxSWVsa3hr?=
 =?utf-8?B?OXJqT01GRXJaM29qYUlWWE1maXVhNWxjdG1hRVhIQVpqVmNkSS9ud2ZFSXhQ?=
 =?utf-8?B?dnB1b09NTHM5K0pkU1Y5Z3E1dWJiNkRPeTZJUkVaMGlpeWpZbGlRY2YwbG92?=
 =?utf-8?B?NXNvWFM0c251SUFwWXFkRGpNK0pRbWJyU0pTdmNzVVRRRC9tL1B3YlIvT1hU?=
 =?utf-8?B?K0R1cFYrWDdCZEx5Z0x2U1o3WjlzZzRERUlYWnJJSThDY0ZUb09GQUxCUU1a?=
 =?utf-8?B?b2RYTlhobjFjUDJPcXR0NWV4MWgweFRBMXRUODBGV2s5c2lTMnNEY1FBd0dw?=
 =?utf-8?B?UjFLbC9VMUdMNGN2MkxabzNXcjF0YUxnanFweWc3cUJ2RnRsTjN4aXV6YlRZ?=
 =?utf-8?B?UE9RMHBnVSs0WkY2R3htdktNQTE4YWt0T1RYRnZJZ2toSi9VVUxKVXAyQ0NS?=
 =?utf-8?B?WU50R0VuSkVuMlNlblBVU1RxVVI2TEcyZEpWSk85Z1M5bXlybGpTbmh6cm52?=
 =?utf-8?B?VzhrS3RGWVpmdnlQREt4VG1DSGRaZGR4ZFZ6TFEwOXBPYkc1WFpIeVBVTTNZ?=
 =?utf-8?B?MzlNK1lWRTNyS3ZrTkVTeDFWYmhRSEFRMmtQbWFDVHkzSHg4MFl6TVRzcExm?=
 =?utf-8?B?NlpycEdZNGRWZ3Z4ODJsUHJ5U2NwQkQxc0FQeUNaaGtRZStRc1ZhRkJXcEl5?=
 =?utf-8?B?WnUwbCs0bWRFOVErUVlIQ1Q3NzFwOXE4aFpDS3NiM3ZqWEs2TnduSnFDMnJk?=
 =?utf-8?B?dEZaZWw1RklLWGNXVURhcWtPd0xnYWlBUkEweFY1dG1Ub2c1UjQ2K1pPQmNq?=
 =?utf-8?B?TkwxQmY1bmlmOHhLRWF4cGhzblplSUpXb21SZjNBOWF4WSs2bk1kaW5PdDIv?=
 =?utf-8?B?TWFSaVo2R04xUWpha2E5ak91dkkxUWJISW9rMGRrb1RreW85T0syM1pISzBY?=
 =?utf-8?B?WmlOb3NoNEVTRUdDY1ZodGlZRDY1b2VtK1EyS0pOQ2JGZjBSeFpsUUV1UHY2?=
 =?utf-8?B?MjVFaHJwQVRaWVF0cDluQVZFcnkxY3BOUGMrdis0REJEa0ROWU14SmhGcnVP?=
 =?utf-8?B?ZlIxd0FJa2dFNkcyaDB5VGJIQVJpTm1QYWdDT2RVaVRLMUZqU3VtZEsyR1hT?=
 =?utf-8?B?ekQvWUcydEYxUGx6Y0tJTDJTTEdRd094d0VZdy9RcjNqb1VWYXVLSnpSY3U3?=
 =?utf-8?B?RXk4bE9ub051dnpIMTNhME9UOGpPcUtYTXRxQmpBYXFTeldaUFcrVk5aV29E?=
 =?utf-8?B?bmg5dE9tTVIrckxYSUp2bk95Q0p4ekdXWWMwWkovYjB2cXFpOUd3RmRQZlIv?=
 =?utf-8?B?cTE5YnNiTjBXclB6aGJ6M2VhZmVielJMelJsMUxobHJtbE5LUDg4TFJNSkM1?=
 =?utf-8?B?b3hLdU9zWVl1dzBhb2dObjNueEUrR2dCSndkQWgyd0NMTldXWTBnUHlwN3hi?=
 =?utf-8?B?MklDRE5aekhhaUdLYnVyRGdxdVBtb2VQbyttak43T0NsclMzUGJ3bWYvMG4x?=
 =?utf-8?B?MmV1Qk1XdVJ4NlUvSEVyQTJ5WjNkV3dvLzJITWgyeEhoUFZhNk14ZHIzTmhD?=
 =?utf-8?B?NlJwaVZ2a0hmYkppZGNHMDVUYVR5a1o3eG8vUnhveXdNMVphZkpPSUxzMWo3?=
 =?utf-8?B?WHJ4Ykl2OGlUcVNxaDQ4eUJQVVZ2ek1LOHFpcm1EOUdzd1ZZdFU2cFMyeFhF?=
 =?utf-8?B?VUdXd2ttUDlNQk1zUUlwRXBvS0wvMFV1REdNeTMydGpZSFZNZml5eVdSK0xY?=
 =?utf-8?B?M1FKM3p4ZXVQVnhOa3hDanBkam1BYVB2akh2d2JzdXBZNXNjVkpHeTlEZGRS?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629a18c3-4302-48d5-53a9-08db7c4a1647
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 04:49:44.8386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCTXXi3XfNXUp6ac7XkV+syW/BoM6iMrUepMImzGOj+PD9wFSoWIpoAlMOoePBUC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4025
X-Proofpoint-GUID: -A6WM4fN3evtt81ulqcosDGiuHLwQsdo
X-Proofpoint-ORIG-GUID: -A6WM4fN3evtt81ulqcosDGiuHLwQsdo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_02,2023-06-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 7/3/23 3:57 AM, Tero Kristo wrote:
> Currently the raw TSC counter can be read within kernel via rdtsc_ordered()
> and friends, and additionally even userspace has access to it via the
> RDTSC assembly instruction. BPF programs on the other hand don't have
> direct access to the TSC counter, but alternatively must go through the
> performance subsystem (bpf_perf_event_read), which only provides relative
> value compared to the start point of the program, and is also much slower
> than the direct read. Add a new BPF helper definition for bpf_rdtsc() which
> can be used for any accurate profiling needs.
> 
> A use-case for the new API is for example wakeup latency tracing via
> eBPF on Intel architecture, where it is extremely beneficial to be able
> to get raw TSC timestamps and compare these directly to the value
> programmed to the MSR_IA32_TSC_DEADLINE register. This way a direct
> latency value from the hardware interrupt to the execution of the
> interrupt handler can be calculated. Having the functionality within
> eBPF also has added benefits of allowing to filter any other relevant
> data like C-state residency values, and also to drop any irrelevant
> data points directly in the kernel context, without passing all the
> data to userspace for post-processing.
> 
> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> ---
>   arch/x86/include/asm/msr.h |  1 +
>   arch/x86/kernel/tsc.c      | 23 +++++++++++++++++++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
> index 65ec1965cd28..3dde673cb563 100644
> --- a/arch/x86/include/asm/msr.h
> +++ b/arch/x86/include/asm/msr.h
> @@ -309,6 +309,7 @@ struct msr *msrs_alloc(void);
>   void msrs_free(struct msr *msrs);
>   int msr_set_bit(u32 msr, u8 bit);
>   int msr_clear_bit(u32 msr, u8 bit);
> +u64 bpf_rdtsc(void);
>   
>   #ifdef CONFIG_SMP
>   int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 344698852146..ded857abef81 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -15,6 +15,8 @@
>   #include <linux/timex.h>
>   #include <linux/static_key.h>
>   #include <linux/static_call.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
>   
>   #include <asm/hpet.h>
>   #include <asm/timer.h>
> @@ -29,6 +31,7 @@
>   #include <asm/intel-family.h>
>   #include <asm/i8259.h>
>   #include <asm/uv/uv.h>
> +#include <asm/tlbflush.h>
>   
>   unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
>   EXPORT_SYMBOL(cpu_khz);
> @@ -1551,6 +1554,24 @@ void __init tsc_early_init(void)
>   	tsc_enable_sched_clock();
>   }
>   
> +u64 bpf_rdtsc(void)

Please see kernel/bpf/helpers.c. For kfunc definition, we should have

__diag_push();
__diag_ignore_all("-Wmissing-prototypes",
                   "Global functions as their definitions will be in 
vmlinux BTF");

_bpf_kfunc u64 bpf_rdtsc(void)
{
	...
}

__diag_pop();


> +{
> +	/* Check if Time Stamp is enabled only in ring 0 */
> +	if (cr4_read_shadow() & X86_CR4_TSD)
> +		return 0;
> +
> +	return rdtsc_ordered();
> +}
> +
> +BTF_SET8_START(tsc_bpf_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_rdtsc)
> +BTF_SET8_END(tsc_bpf_kfunc_ids)
> +
> +static const struct btf_kfunc_id_set tsc_bpf_kfunc_set = {
> +	.owner		= THIS_MODULE,
> +	.set		= &tsc_bpf_kfunc_ids,
> +};
> +
>   void __init tsc_init(void)
>   {
>   	if (!cpu_feature_enabled(X86_FEATURE_TSC)) {
> @@ -1594,6 +1615,8 @@ void __init tsc_init(void)
>   
>   	clocksource_register_khz(&clocksource_tsc_early, tsc_khz);
>   	detect_art();
> +
> +	register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &tsc_bpf_kfunc_set);

register_btf_kfunc_id_set() could fail, maybe you at least wants to
have a warning so bpf prog users may be aware that kfunc bpf_rdtsc()
not really available to bpf programs?

>   }
>   
>   #ifdef CONFIG_SMP
