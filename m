Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427FE6367A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 18:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbiKWRu0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Nov 2022 12:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239240AbiKWRuI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Nov 2022 12:50:08 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6BAC67D3;
        Wed, 23 Nov 2022 09:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669225804; x=1700761804;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1PiYzprH6SE0atMcGa8tSGQCGJpIxkpvKyTP8pOUHZ4=;
  b=H3joh4T/RHGEVu/9zGqYN7elzNO3aZTuicafZRFBKjBH+S7Qn8pA/3VM
   D668dSPsBV5HB2CtiZlHOEECw9wXa344fWQs543Ckv1PvrtapZFanYw8n
   +s6Qoe09I98HPGTEa7+EyoNUjdprb7aY5kYRh5r3gVCU0iQIJsDFnsObi
   el9rHexsT56EIDnTV6vse/xuf+5bn/sEqv6sVAL2x9yyWSEeAXQzlbP0f
   X0PvsDpU/kztgX+LKRnK8i97WIEvhCb5eUU0TvSias84Nik3C2B5Fpq7a
   fdZIxmfU7VJFdvLTtJTrM+k1BSC9Lg3IJEmMd5T5q+SBoYCud1I8pdvOJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="311761119"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="311761119"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 09:50:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="674803680"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="674803680"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 23 Nov 2022 09:50:00 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 09:50:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 09:50:00 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 09:49:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbbnLVJMZ9kqmMUb32Zf/IgscpsP6t8UYBElMdUD+MUSXF0HC6GHlhWtrwyvVf37ZCFT7wooPrcz/emvTom78+wlyIFnxCc66OLBlyzdch1JaRXc7VPDEV4tTjRxVjiiv7GuUQunX9xMiMIMHOq49Sd09ZTHLBG8EnURr1PXMJ+mzk9/dhyobPcTt5LolCDi/JOKygsqneeekrzZ4x4edY1CmnqpoxyFf72MHMhxAnawbHe9ET/rTgNCbMvOTIOTCHJpwPSHW1ZqpAu7U7hJzxWrlOoGHVe7KUgGI/LwfpEjKqDT7Z+3d2aaGMn5Dxu3dk6J900fhh0xJLpcUL3Ueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqASWZDMtDgqoMPjhz7wdZb7JbxTBw+PCQbk9sjI4k4=;
 b=U4lzEgd1J0yIQBwA+g4dDafX606OZwdEefl6JPUcG4GsXxNUFVTcMTzOIrSzi90+ZYz4fgSeLrcoV/YKaaBv1lEsFsYyUbC49sn34nfhURI6ZITSgYCcx30suPTh7IRjIQI34sYQZUe0iN01zSdTOLYFfSnOJv4SXjwlr1NBwVtd75wyM81h6GBO6KDLFeAYahNA3WWyp+JclfJdBaUxIP6s/e8VLxM+KpfRldKt471XmycMr9D2Ni17C4JMslRnMH2kSDEJiHEh6eaV0PQzOhEk23lbd+EPsOt8ppVqoHhwyE2/OQ1yulzUBsE+F0HI126d7+4Npysmd9WAWxG3AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA2PR11MB4859.namprd11.prod.outlook.com (2603:10b6:806:f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Wed, 23 Nov
 2022 17:49:58 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a%12]) with mapi id 15.20.5834.015; Wed, 23 Nov
 2022 17:49:58 +0000
Message-ID: <11f731b3-b157-11a0-6af7-79c6b4215cdb@intel.com>
Date:   Wed, 23 Nov 2022 09:49:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v4 5/5] selftests/resctrl: Remove duplicate codes that
 clear each test result file
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20221117010541.1014481-1-tan.shaopeng@jp.fujitsu.com>
 <20221117010541.1014481-6-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221117010541.1014481-6-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::26) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA2PR11MB4859:EE_
X-MS-Office365-Filtering-Correlation-Id: 554766cd-ca37-496d-090b-08dacd7b2342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AeTtCUK2Xnz5DQqQa6tCXJIrG+iPGkymGXUJBAc2zGeiSwkHzNYWg36IiuaOkb/b0GFYxXkAdEIzJG0jpDMwedbdtVfdtoN8sMTRdKjIydc45JEAosi1ad7fjSz84hOvOEnYWF7Uer1AzP4C1XNGzzpie/RKWvDQusiFYt8GheXsd0/9BNDtflRr/zWaSyr8ZcdsEp6EGW/YgG4kIbYHNgwfIcCtVpwUlc5wTuEiN3jM338LfL+X7ATVCTt8JI3VNd+Ayq+Ss4rCn/m+qYfLqlO34I+YOUk+BHVfMWPcDGQjCx8J8CKepbyQ1U+I+nXNNzOfKZuSpYlQffTV+vtbfD9Z0wujWkWoCLpQXGCrRYwjGo23HHmHJcjJbFa+/sHag9mgjzTjHWSkmwg37tcDfefy+bd/EDc+bLwKfJtyObxeDMTFPnxBl5B2YlIDB9biT0oBMJarwYPohOToZXMVW41KWWEjbLDxltHeVQuqGb1E5iPuz5F2E5ixEo6Uk2CTgaCpWSl3frG5uT2QKcHXuuKbCdKXsn0+qINbAZhhFgAaZZLDQjtpo+q/IY3l15Q0vgvjPxnMdjMYEWXQ+8TX0gxPMwR5GK8XV9FDowEENPTa0nncM4zoEwHf7xwYKuOwPAbiy6lXIIPWr1wQ5JPfUTPlx/vk+DTxXEWy40UcqCtyn/gDuUF1i3Q72unFYcluGb0nQfDGPGQ1Shm0EDnaXwfh0ubO+TvgQkAjv+VhRno=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(31686004)(36756003)(82960400001)(31696002)(86362001)(5660300002)(44832011)(2906002)(4744005)(38100700002)(110136005)(316002)(2616005)(6486002)(186003)(478600001)(8676002)(66556008)(66476007)(41300700001)(4326008)(8936002)(26005)(66946007)(53546011)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WElEOCswM1BHbWhoaGV2MkJsZGZqeWY5UFdZMDlGN3BUTjlkN2lKN2d4WEZ3?=
 =?utf-8?B?OTcwVmNJaDYwbE1zblorTE1vclBtRXdHY0grSngzZDFvRHVqbzFZZXFJT3Nn?=
 =?utf-8?B?TVpGQk8rajRLbllPNUwwRnkxQVNMRnRnMUZ1L1pWZWcvYk9HTU1qQ0lNUjRF?=
 =?utf-8?B?T3c1dXVGaFBVZXBkQUxsckNkT1FQRnBNTSt0bDBIOWgrZXNOb28vMkUydWEy?=
 =?utf-8?B?Q2RrNjU0REE2TU50TDRYOER0UnBGL3p5SFlvbmREcU9ENmdEaGEzeERueFgx?=
 =?utf-8?B?ZDZjQlNGYnFrZGc2SjVCRGdEbWVkMkc5MTFUUHJ3VHg2R2lidUdpWmp0UFBM?=
 =?utf-8?B?SUQwY0Q1OWVWbkgxTmN1V25KUVlKTzhHWitiajBHeFdNSXVHTWp5MDNJTGEv?=
 =?utf-8?B?eGg5cmRwUklmN3RVOTVxcUs0dzNKdVB1QjdoWmZPVlZjSUhKQy9RL3V0RXFr?=
 =?utf-8?B?Y0wreTVNak1YeDM2NCtGU0xQMm1ITlpQdEtDTE5CZUlLakU1UTZZWkJDMkt5?=
 =?utf-8?B?SXJUZVFUN2w3aDNIc1ZrOXI0YUZZUk1rU29LT0FsUloxVWNYcVdoQVVaNlho?=
 =?utf-8?B?NWNEY25LdndlQ3NURyt3SXJDcTF5S2dZZmk2S0lsOEhzZFJoMHJTaWx5dEJ1?=
 =?utf-8?B?b1JneVI3TFUwRUpSQWo4M0RMYmVYaEVhVVVJcGJoYlpHUm12czBLUWZ3K3k3?=
 =?utf-8?B?TFdJZGpNbEd3NFVxOE9pWHQwSklmMjMvNjI3NktEMmU0d3F3YjhoM1AyWU1k?=
 =?utf-8?B?Rzkwc2hGeDlodVhrb2lpZ3VWb1h1VFVBQ3hTcU1wVzNGTWsybnZVRVV5eEpH?=
 =?utf-8?B?Zmp3dW44bCtxczhCVXczTk54VnNFL290RThyL1VnT25PVlR2Ryt2OExBZWFv?=
 =?utf-8?B?UmhwVlkwTUp5T01KYlJiUHp3UkRCckRJcENxSWtuNCtWdndkZjE1eXdENEt4?=
 =?utf-8?B?VnRZNjJBSzZCWndWTG9iMG1sVlNwM3JvN2tpOEx4clQ5VDBJK0JCUFlCTEFm?=
 =?utf-8?B?MFZXaWhIdUpKcnRqTnpVOE04WmFrcERwL3VUYlV3VHJ5dzZKOXpvbWFoTGZk?=
 =?utf-8?B?ajRCano2UGNobHAxTHlidFZSMjFiTWg0TFI2N3N4Znk4Ty9ENHBsaStFOVdq?=
 =?utf-8?B?VXNqaFkyVVFpNWFyRTJ2bVlkSUxJYlIxcHlzWGRMKzR6bk9PRmlGT0NKWmw5?=
 =?utf-8?B?WlRwTldSNk5VNlZNTVhxZytYV3Z3MzJoUXdQRVR5QmcvRjJocjVLdWRSTEJl?=
 =?utf-8?B?V3YyQ3J1bEtTNkZoU3NtbStuSVpFa05Sa1RuTnI4endmelNudit4MTRya1Nw?=
 =?utf-8?B?bFhGcTZZZDJLU0xkcXlzNkt4Q09oYkhuZlZwMmlhNUNSTnUzV21rQmh2MVZl?=
 =?utf-8?B?M2Zmc3o2aUpMeC94KzlvZ0g2MVRaL1dMYnZDbWpVQlozQzYrSzNIekpYNUtB?=
 =?utf-8?B?dENqazRXRXhuNFZzMXZwQkwxaVdQRC8zVXNyZUV2SE5rdXBETXRqa1ZISjdt?=
 =?utf-8?B?ZnNUc29CaGdNN0EyZjlPQXYwUmRhNGhiNzZjamRJcTNZbGJlSmp0Z2NTVktp?=
 =?utf-8?B?MzM0N0RXMURRUExxejJGVFRFVnQrQUpZWndJSndpaFJLTXlYam5ZTnBLYURa?=
 =?utf-8?B?bEVaNXEzOUJsaDdKcFFHUkZyMWZWY3pZMHJOeXVONWpBQjU3V2E4aUs3ODZQ?=
 =?utf-8?B?YXBrL254aWNlYU1zVHRicW5WWUV5Q1FnWnFGOFZTak9NYkRJQnJZOTBaTE9p?=
 =?utf-8?B?OWV0RW93bjAwYm1HSlVtZ3ZpUjVXR1NwbVp2TVlkakx2UFVuOHNVSkphQkY4?=
 =?utf-8?B?emdWVXNWaHJDaHlUL20vZjRQR0MzUG80Tjg0ZzQwYjEvOXhJOGw0UHFoRXVU?=
 =?utf-8?B?YVcvSGFQa2xwZGpkbDE1ZE5UdjFaNDFYSEpYclhpL0xmTEtXNy9xM0RkM2h5?=
 =?utf-8?B?WERFQ0I5UzR2Y3hlZThTaElQYUlPQ1laNWNoaHFVakk3T3o4S2hZUXg2RmF3?=
 =?utf-8?B?TnF6d21WaEs0TXFMTXdBeUlJNjB6aUptRkRNWmY0M29RWGpCaVo2a3VYM3Jp?=
 =?utf-8?B?VmRySTJVVXA4VFpvSCs4c1IzWE9rMXZrYUJTQ1AwTHQ3TGFCSElITlVkNmFk?=
 =?utf-8?B?WmVqL2Z1UDhUeHdRamc1bFJLNytIa1NpZ2tXV0V4UGVSVDg0RFFCMFkxUjc5?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 554766cd-ca37-496d-090b-08dacd7b2342
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 17:49:58.3798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77lSyVS0YTrWzC3C15PcLkwTsxMUSrBUdQQqO8ImxH9StHGGEZspmoyGpPwntAx+OC0ankX/Kz4KV5PyUFXIjf0LCKFqePptk40H78R/iss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4859
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 11/16/2022 5:05 PM, Shaopeng Tan wrote:
> Before exiting each test function(run_cmt/cat/mbm/mba_test()),
> test results("ok","not ok") are printed by ksft_test_result() and then
> temporary result files are cleaned by function
> cmt/cat/mbm/mba_test_cleanup().
> However, before running ksft_test_result(),
> function cmt/cat/mbm/mba_test_cleanup()
> has been run in each test function as follows:
>   cmt_resctrl_val()
>   cat_perf_miss_val()
>   mba_schemata_change()
>   mbm_bw_change()
> 
> Remove duplicate codes that clear each test result file,
> while ensuring cleanup properly even when errors occur in each test.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

Thank you very much.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
