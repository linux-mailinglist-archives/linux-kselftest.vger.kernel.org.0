Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E5A486E26
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jan 2022 00:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245687AbiAFXyZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jan 2022 18:54:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:55729 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245661AbiAFXyZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jan 2022 18:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641513265; x=1673049265;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SpLJdD3WBK8wxpMIy/EJotu/wgBQ2iK+2+A4qX/o3U8=;
  b=Glpp0918pXR2cQkW2lxDb+Csd4LTJsTX362ZKj70t/vIZAMpFjsKhu9S
   H/t6ZjN2lAeFoG3FNDW82/yYTawYn2iuhBJPYF7Fc08lVdlkykx4mkVfy
   nE6/FCmZhTYOU/VcCF/aN/uBnAlAvZ2fNqdfg9c2u5KAv0Zgwlojc2/Zl
   0ViLxPAVR2d8QgmUhq2Ee3Vyu9WFrRRUfHFgm8pog+zC3ErxZg/wwiV3c
   YfWmclV49XExaxv68ashkbjlu7dvTDNWqxsPmjN5RFbrxOADTEpedcTiY
   7jZL0XleizVc2zguENwtbXbf0tJ8kuiVJm/tsnDp3ZIkoS42GV6QsYwTQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229573874"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="229573874"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 15:54:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="763671646"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jan 2022 15:54:24 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 15:54:23 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 15:54:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 6 Jan 2022 15:54:23 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 6 Jan 2022 15:54:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nijM16JYQVuFjQoSFq2JWlZT/NqwCd/zEfhf2PgJHXI+KFNO1CHX9xHk8UkLsMFXpPDFgAqdSp0zt42lbQEjQl8f1P0gpPQ0HNR9UUqpWvGHM2Dp+nmLK/i5vY3lgM/verJ80RPs3GQBGBWvJ4m7J1POPKJQ3Kx3XqXdvtaIYYYCIZPRkVjR8dlq3gG/mhU8u42FpmL1GY9KDIbr//ailpQwJidG+9UyQvY/bUIXTur+exZYD8gZOWWdeeq4rvx2F2X78EEMXKYVENoz+sPR2HtO6o6T/a6EMsO11jp49xlyIi/oDtxDVSGFajYpyazEf0vaKOkESGAt+fD44Yn4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGk6tSwl/aRr/xXkyWjqr7B/O+C8PxFhMYDb6KvS7hY=;
 b=bJqfRXEVMnZa0BxyidDnSsnAmdzSfq0IZgsQ8AFyYOWHdtNyh97AvVgKoDU0Ce3NzL/Wuu+ThyED9CSVrf1oUmorhATglZdbe+/oox1HkIXivC9EoEC5Z+Un/RWaFFoOc9Qn2IU9VtPgoRUW3a7JNO1UEZV35XsfcnmV/XKpyEC3VIIDpUHiJGJsjrONmeq5V7vS9esic9JT2Pr5UOKV5WKIM3Fg+pD0xseBjah+bVt8mdaPbXzJQ2AfM7fIdcrOlZtRs2i/bW/j3PFVJklN5tsCfeyZlPnXOv848JVTNRtqhpcCgXUlaa4uQo6inGIzzdkWXlUiaoQq21F7e5TqmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN7PR11MB2675.namprd11.prod.outlook.com (2603:10b6:406:ab::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 23:54:21 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%6]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 23:54:21 +0000
Message-ID: <b46ca792-d83d-9d07-3a31-876be74c76c4@intel.com>
Date:   Thu, 6 Jan 2022 15:54:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH v2 5/5] selftests/resctrl: Return KSFT_SKIP(4) if
 resctrlfile system is not supported or resctrl is not run as root
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
 <20211213100154.180599-6-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20211213100154.180599-6-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:303:8f::21) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9053b334-b835-482d-e3f5-08d9d16fdbf5
X-MS-TrafficTypeDiagnostic: BN7PR11MB2675:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB2675FF9017BCAE89BFD816CFF84C9@BN7PR11MB2675.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:187;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKQEabf0CMujngXzaMzaezooYo7QB9v+MmUr28put8EcByM6HacUve5xu6buZ7SCYaXJPsdXOahrhJ9djbbtfWtnU3T91dteNrScincUCLDlmJe4eM0tvDl+ih2bxmbS4BmDyF98upGR84UsSLNtkLPvpsuxwdRHkzPxwZ9i/z/PChKuqG57SCVrYDFXkiDBiA+Cog2nowxaCs76ixvjZDnH0jZCkjmcAOkLcwufE4mYbOTTi4YK9dnTRicvdXKoKM4sb6FRnQSRXElOJQxhZfKkHXq/qNGXoRyMgzhdO6Nhh8KrqTl9qOHuP7btDo4WWdnmQhq0hl/Ik79M0C8agrPwQyczjct3ddFT/E0TKwlu8R42gt/9sc+DeditkI2WawSNFfyAK3e7ltb428+LQboE8wn6tijo6zFEd8FcULpH92v3sUFrrjoeLioaQQ7micPespR+BaDK/DWU9lPvvabAH4p+3VU9QRERLfFmdn2W5XMsr3zQbhEIa9sjKPU3RyR36/C5oJBRKEREGyVeIRYeb/gvZEcqgLDA6eCP6Wkpukwfux5Fkx3wdfA5U1bnGIVCeQhlKfnOrobn4R6/Doo5jqH7PEyxGZOcH+dJ2+GbtFPASq6QSz2+0nBQx92ONDjdotz0CmQ6XPol8+8GLd82QXdo+djdWpBbaxnajzQb3vHA6FIICPVG70NJsWeCW1Yy/ORV5Xe8cDBWCOYPM860/l2T47DmaMipLrg8p11BLB8vkR5Q2MvAwesAv9W4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(2906002)(110136005)(6486002)(4326008)(66476007)(66556008)(66946007)(44832011)(38100700002)(316002)(2616005)(6666004)(26005)(186003)(53546011)(6506007)(508600001)(86362001)(82960400001)(83380400001)(8676002)(36756003)(31686004)(31696002)(6512007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm5mdEhadGNVcldtQkJ3VWpXSSs5dlJRRC9DSnV4UFNpUHIyNFFZWGVzUlNw?=
 =?utf-8?B?SnJFaTgyMmozNDdtd1VFUWI5Rnd6VGsyOUlmM2RkQ3dpaGdnZ2pFMExlK05C?=
 =?utf-8?B?Y3dQclpTNmY4VEFSYS9qK1M2VFpnNUlpSTFEVlhSZzR1SXN0dnYxSU8yVG92?=
 =?utf-8?B?akxxMWlsTVorM0poWVExTThrTStwU0RwZmV3ZXdYVUNINnE5TlRPSTkxZmtI?=
 =?utf-8?B?VmxyWGVJK3FhZmM0YzF0dFloUkJQSnY3SUNROGhEZTVDdDFIbTRHbkxjaXZI?=
 =?utf-8?B?RnduU29Rb0ZMOU1Hb0w0RnBUZmkxYWpZSjg1ZWFha0RGQ3B4NUdhN3Q3Zzlo?=
 =?utf-8?B?eEgzYnJmMnU1eDFWZmVGNXRldzdDYko1VENSMlN4QklEVmh4WTJpb1VLTEdi?=
 =?utf-8?B?TWxwNms5SUY0SlpoVkZPbVlmVHIxWFVHcjdOcUFrZiszcHBjUXNIYUtGNjVk?=
 =?utf-8?B?TEh4citzM0doU1gwNmw4bHBVSTdpczVWQW1OWUU5UjY2SE5aMURDaXBDTmZX?=
 =?utf-8?B?WE8wV0xBUlVGckNvRWdUUUdLS3JYS0xFeXNpc2tGYWJVRm5TclhOSzhlSWRT?=
 =?utf-8?B?YWE1Y3FQa0djdVVMdjQ0Q2VWSGc2enIrQ3JoWXY0RmFCUUlmKzY5M3Evaitu?=
 =?utf-8?B?WDM1OStyekhpWmJNK1gzdHREckJWbTNRUkF1V2xGNGcvMWoyQW05ODNvWnZJ?=
 =?utf-8?B?RThmZk95OG1SYXhINGovUEZCemRlWTdPVlZkNXhuMjJ5V0pxSTlSZ2dIOFVa?=
 =?utf-8?B?eUZEVnlnYkl6K1FxVGlhSkpuL285LzZVVStJQUg3S2JUVDlXaEhEOHM0UGlM?=
 =?utf-8?B?alpiVkdqejFPTll5UDI2dlNBVzhLWFpCb0VieExxWEYvdDlDemgrbUpCcmN0?=
 =?utf-8?B?N1dDWk16RXpwazhXN1RhR2FWckFqdFVoV3EyTkZENXNsVlpZSWFxMndjZ3JL?=
 =?utf-8?B?blRhZ2cyaG5rcks1dEpHTXNzNWNrbHJDeVpRUnYwdENlYVRBTVRaNi9weTg3?=
 =?utf-8?B?VVRTeU1xR2Nka0NKUlNaV2RhQ1B1aE14RkV1UFVBRWxLN3dBUnp0MFB5TTdK?=
 =?utf-8?B?ZFFmUXMyWWQvcXBuZTJVZWpRM1NMYU15TkY5S0tDY1QyMHdEckJQNEJCdGNL?=
 =?utf-8?B?Ykl5M3ZBNFZNb0NmUU5uZHJtc1FBY3dTTHBncFhqb3g1Q0c5TG5nbVE5Q3JC?=
 =?utf-8?B?UzhIUXBWSGFnZzJ3eTZqK2hlM3JsS1ZSRUxQeUhjd1BJcU1kcWtqTmJ5RXk5?=
 =?utf-8?B?MXNDS2xsck9lL2U0NmVGb005d1ZZOGZuOTBDa2RNZlRnbEozaklzczJRTjdi?=
 =?utf-8?B?L0EzbTdtamFsbXJnYXBXZDIzTG91ZDFQTW5FNmxKa0J5bzMrcTVseTFpV0Q2?=
 =?utf-8?B?bC9wYUFsZmN4NjNLYURBa1NKTU14TzJrQ2MxREkvM0xseERMeDJFYTRUWjNk?=
 =?utf-8?B?a2g3UlBSckE1akRBUW1idEtRTVE1M3VOZnBQbnRiK0ZnVmZuZU5TNXdWaWt1?=
 =?utf-8?B?b0Yra0hjYUNFRThta3lIeUZmNUFOUGtJalVtN0xLWlpsZ0dqcVY1WjdVUDNG?=
 =?utf-8?B?NDVqclBmZ2gzVFlTelN0TEJhTjlZb2E3dmdmd0FSaThKRFdCdzdDNmtZQXc1?=
 =?utf-8?B?V1BSaW5QSCsvN29CMHlRRHVFUU5WbSthOUZEREE4bnFIdlRoNGlnWTVqZk5I?=
 =?utf-8?B?ejN2QjRSY0ZnMWo5Z2xZajk5MjY0WStHOUNkN3RBTEVYeVJUK0dMaEVkdGVG?=
 =?utf-8?B?c2pEZ2pndEY0QVZnZW1Nd2ltZ1RJMklqY3NCMHlaNHZYTmJqYnBKSzdCY3RB?=
 =?utf-8?B?UlVKRWFuMWFSN044M3BzYzdIYnJQb3JxbmMrWFdINnZwbmNQa2k0THVDZW1v?=
 =?utf-8?B?QjhwNUR1V0VjK0JJTXZIdjR4TFdtbCtWUXpJMm5Ubkp4ZjZ2RGZJNmtlMTRp?=
 =?utf-8?B?OFo4ei80cHRBMDczazhneGpwcTFWVEs3YW5wQjZjMEI1ZktGempmSG1YNHdj?=
 =?utf-8?B?TGgyWHZCYytLa0plNWpsTlBoQlhjc2JPd3d3SlNpRDA5Y1RjUEN5TDl6b25D?=
 =?utf-8?B?L2pGSStoQnl5M2tsak13WkdDV0xPcktOQmhSY1QrVlVNV0F4NVdQbDU0d0Zj?=
 =?utf-8?B?WHN3b2lJaGp6MTZ0VWZjaUUxWTZpNEwxZVBacUlxTDF3OVFZdFVBVFMwVmpi?=
 =?utf-8?B?Ni9wd1BIeWN1S01ocG1WVEJxSkdndy8xQ2c2L2VEMUVlaVprUEI3QjRQd1lU?=
 =?utf-8?Q?BYg14tgb9kY6kk/NbLy+A8Y5ibc/iBp5/gZAcjff7w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9053b334-b835-482d-e3f5-08d9d16fdbf5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 23:54:21.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1kRANZttq92T3dIBbduy4wjQ9bja0zf/+5JVU1ZSODU38+oovyb/Bk+yIjviLETGc8UCKaKMFc6ihupdt01FE+XsTgZkJxIqOScYOzkumU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2675
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

Subject line still with typo. Also, what does "resctrl is not run as root"
mean? Do you mean "resctrl_tests"? The subject line can be made more succinct
while the details are moved to the commit message.

On 12/13/2021 2:01 AM, Shaopeng Tan wrote:
> To unify the return code of resctrl_tests with the return code of
> selftest set, return KSFT_SKIP (4) if resctrl file system is not
> supported or resctrl is not run as root.

Please review the feedback I provided to your first version. I do not
see the explanation of how changing ksft_exit_fail_msg() to 
ksft_exit_skip() accomplishes the goal of unifying the return code.
It surely is not a good use of my time to review patches and have the
feedback ignored.

> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_tests.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 973f09a66e1e..3be0895c492b 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -205,7 +205,7 @@ int main(int argc, char **argv)
>  	 * 2. We execute perf commands
>  	 */
>  	if (geteuid() != 0)
> -		return ksft_exit_fail_msg("Not running as root, abort testing.\n");
> +		return ksft_exit_skip("Not running as root, abort testing.\n");
>  
>  	/* Detect AMD vendor */
>  	detect_amd();
> @@ -235,7 +235,7 @@ int main(int argc, char **argv)
>  	sprintf(bm_type, "fill_buf");
>  
>  	if (!check_resctrlfs_support())
> -		return ksft_exit_fail_msg("resctrl FS does not exist\n");
> +		return ksft_exit_skip("resctrl FS does not exist\n");
>  
>  	filter_dmesg();
>  

Reinette
