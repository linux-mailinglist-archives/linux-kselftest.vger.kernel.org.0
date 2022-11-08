Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40D0621A08
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 18:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiKHRH2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 12:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiKHRH0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 12:07:26 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E539920F76;
        Tue,  8 Nov 2022 09:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667927245; x=1699463245;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mixqlnxU3eCPpbydVuGe2UfYW89cA2jKyxFLKhdB7jY=;
  b=jip+VFI5BXs+83IaDB+WUeOHEuvzUiuMzsraq9iBN6AhrIiH4fCca/h1
   KmwyQP7+bOhsDl6xkWryIQBIOgAQXwZXxQImY+vfMbswM/k9d8Wc6jSM6
   qrMvMNhechULQ4PbKkEMA6G7DvbNkN9muuLFsABonf0qSd9wEzVq4KYUo
   /wXSB3twsodVHDb5ZoX63hppcoc6Zdmaj7wcX6wyzJSgbZSPCoKL91C5p
   wJ8hOz8Al9fHSroU9XhUCZKraUXBXFBUrI1syfL5bsp/B27XI8fVbaaUg
   uR0SlFRn3lyHLXLMtmiyf4L3Y8PFzGIF/Lzvd+qkKEWM/hbfKBhdjaOKJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="311909145"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="311909145"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 09:07:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="669623129"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="669623129"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 08 Nov 2022 09:07:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 09:07:08 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 09:07:08 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 09:07:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYAZFXEL9p/FoUjfiS5AKZvrO3VxwLCH+0QY6Kvnn4LctbLYvSlncYOFe5TSNR7gJa7dsG9WZCMyJCfP7bAHpkgK1K495EFQfX/WaegRERFR75Tr4eNfdsyh0JTHJObIcL2s03P26wj7rg+ipDj9tYeEh74DlthybOHFRVJQ7ov/LXDbWUkJHzMjr29xInoDe27MP8JmFHlAOc1m55757whXtp5RJo/o0fhkxckws2OAp5Tk9pT+KJUuoyQJHcRnoPPoqp1i65cKvXDz4TPJCNTjTmihliKJDN7wShYkzxLBhzlheWdkpFL01f1Sa9FpikOPCzGhqCnRNbOwlCMm5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rpsCFAPSNfjmys4UNrRhak95nYX9JziBePuQrvduTc=;
 b=oF1e1Rs2gy40+XHRY5qqPDpaYB/F2kz5MSVhv8SZk0LRTbvSwuB/SahthABRiutC/sHctFZGkdosTAABkmVAxl+SaOpeSvIU1h7sZujEPwx+SG6sB6/UYpOI1iLY10w9HaTA3zK3JjlV5co/0jpMh03ECIsvZcDTZXDhD/wi294BNyjbr3Bw86psFdNpcD+1crVu3ZLKDS/f01wu5tiH8D3ZK8masrOTNTvsuCeU0HLikHDu5bZPZougbM9xdaVVkTdl56BkjLthLZkGaCaeHtg/GtOQCHxcqLXu20rKrj8EZz3mq2sP1d5LhbK9x6d1DVC3uSJA4TQ8woLLA11FgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ1PR11MB6275.namprd11.prod.outlook.com (2603:10b6:a03:456::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 17:07:06 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 17:07:06 +0000
Message-ID: <0e8d382f-7cf9-7987-548e-2ff8e2f10e92@intel.com>
Date:   Tue, 8 Nov 2022 09:07:03 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v3 5/5] selftests/resctrl: Remove duplicate codes that
 clear each test result file
Content-Language: en-US
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com>
 <20221101094341.3383073-6-tan.shaopeng@jp.fujitsu.com>
 <afa849bf-e89b-0c48-6bf2-f7ca58940567@intel.com>
 <TYAPR01MB6330156C8B4F7A35290F44788B3F9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <TYAPR01MB6330156C8B4F7A35290F44788B3F9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::6) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ1PR11MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 8844b219-16f8-4e01-235a-08dac1abaa2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fydFK4ZyT5szFJIy64UE0meB4oS1rIOA3DWxTdndKpWM/oJnoAouqKYuYv9Yt5lMd5eJSiDYvSt2cmdPd8PoDPs9cSY+coXnSszUgDScKa3kWNwguJntf8TorJdz/tQzTouqjbw4N1FLIFzh7EIVLU/tSNYAUy8mTIv3mQHP+tZB3Ryk5XuX9sAjVf2DAMc48y+cIeUN996NWm+ts5CxzxEwS/hr6TjFzu5YX0UfUyiscJYc835qbZo4Nk+lawM7KME3lAtoFAs6KV78R3XQ62Yb+7bvYRuHtK8wta7f5/SoUOshONJW2JYJtNRBuw799rPy0u6TwDY3CanmtZalO5HQaBC+VFa4LUefCu0gdgr5dSG9VmUsHu+nfeUoQwDgPFP68HAgQNQ5IEMyp6Ym/sLoPIG4i622eF45tpxXUXHlrytu62+suBBEPSTn5mHk1XJYcefHnvyH5n2GihwuePsUoL3HibjU4b1IrYi5dwcZFxQwH4Jldr81N1mdtFQZ4h2VRk9pNtlLEhWUJnBsJTNv6u7WOO7SpRH4yatmV6L5s6TjuSZ+1ofr9IZZPc7YLqGzxDKy2bZQYmM3OK+znFpQbc7xC2Ayo/3m7mfOZH7ofwg7MaPoJKRnXoY/D8YthTThLkw1cY7Z1JJJ2L9+9X1Rp6R23WuBgw4BG0VV2hjYEP6RuJ9C7ZuLEqR8BHz46288QtG235vEgD6MRMYGPtHVya3TdaNJWa8tSnqOnBwqvaSNHYLuIkvgSfKdBKn04bSaSJEREwNvRTJ6q1qExb0G6fuo0cnYVZpd216ahrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199015)(83380400001)(26005)(6512007)(6506007)(2616005)(38100700002)(82960400001)(53546011)(186003)(44832011)(2906002)(5660300002)(6486002)(110136005)(6666004)(8936002)(4326008)(478600001)(8676002)(41300700001)(54906003)(316002)(66476007)(66556008)(66946007)(31686004)(86362001)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDErL1RaSHlacFdpbjRFSStTUEQya3p0c0xXRlFOK21YMEc4N3REbkhOY2VX?=
 =?utf-8?B?WG5TWHRvQkpac01HSWdIT2phNWx3UExieXk3UEJxUG1NWUYyaGdNdHhiTkxW?=
 =?utf-8?B?YWhCSy8xcXdnb3lvT3VYK0lST2RaTHlja2xZc09PVU12bVFFVnhNVlNKL1By?=
 =?utf-8?B?QU13N2dieW9iUmx4bkozM1RUQ3VSSk1ZaUtFV3c5Y2JOZEp0M3Fldi9HY2I1?=
 =?utf-8?B?dTJrYXY4T0pWN1VsbWJxdkZreXVxakNRTC9OOEJaYWdneUVIYk9ieURmdHpq?=
 =?utf-8?B?K1E5NHhsd0ZjczRiUS95Q2VZMmZlT25WZkxmTFlHZW1MVmlhakw3dE1BQzJr?=
 =?utf-8?B?MkM0YVAxYjJaWHZFTXF3ZktnSTNhcnVmR0M1NTcrbjVJTmNCMHlIWFMyK0hF?=
 =?utf-8?B?UFpMY016R0JqUkNyd1VJdGM0MzNHc29QeVdHd2pvbXp3T2pJblUvbXVHcE13?=
 =?utf-8?B?ZUxGczVqYUp3Z090dS9ZUHlicGp6NzNnLysvbVAzQkM5amFZOWpMMmdoZTVQ?=
 =?utf-8?B?VUhMQ2d1UVpxNlhXMlM1YVEyWXo1VFljSXZnV1gzSk5WbUYrVkVFZFRUSTNT?=
 =?utf-8?B?d1luUWtFbHdOSXBDMWcvOHJ2R2R2eUQ0WHkzNEp4aUNHbkRzUGJGdG5WNE5v?=
 =?utf-8?B?Tit3SGNmTzlpZSt1V0pZekVkYWlzTnAvZWdRQnM3cVdHVjUyMlFVcEY1TU41?=
 =?utf-8?B?NHdwZkU0SGVWK3NnM240dFBybGdxOVNieU9ha0FibkFLZlIwS1BFYU5jUUQw?=
 =?utf-8?B?aC80UjBQN3p3c3YybHQyOEdjZVE3SlZuWUpaamVKSFRGVUpwNVR1QmJLZnli?=
 =?utf-8?B?d04zN2VEbEl2bGYyTEsreUtkRElxenl2WXpMS05WTFVQVVBSQVhmVXRYSWcx?=
 =?utf-8?B?aFZOakEvRlFSZnBKbG5nME9BWGdvZDF3bVNra2tKeGMvQUxYckVpb0wrNko2?=
 =?utf-8?B?WnBYdDV6L0F0V2RYYWVJalRybGtlNlJDTmZGdlJqRGVDMWhMcjNESnVBYW9z?=
 =?utf-8?B?R0ZYcUdpRzQ4VFdhTC93VkZJcmFGQ0c1bWJFY05QcmE4aUdYbUkxZUR0eUx3?=
 =?utf-8?B?ZmU2NXJVTGVwMTViMGZ2UW9ST3plc1dpZzB3VWtwVVZCVk8wN1pGWTFHNUhr?=
 =?utf-8?B?UzdqUGI2RFg3NHBSY3V2eStqalY4b3RmK2NtOHQwV0lTVEtha3ViQzlhSmZq?=
 =?utf-8?B?WnNKYWpkMW9xcGFMUkM2LzJ5eWh1Z1lQcURZa1BNa2VrcTAyVTRMeUhsdC9h?=
 =?utf-8?B?eVdvZWY5b1FkN1Bvblo4VEhOS052K0dZUStOc1Vud3VhTEQ5M01GcTBWMmVH?=
 =?utf-8?B?U1E1SWtCSGNYb2hwdTZnZlFoZWVCdTBqOFBBMVQzTlduRmJzUzJQdHR5bDF3?=
 =?utf-8?B?UEwvYUVYNHVSeGNGaTc5a2ZnajBQRVk5MUM1OUFHWEdmaVpETU9EVGF5MkFQ?=
 =?utf-8?B?SWtHOWFJNGpyOGJpTXJ0RDdmbHRmS1hDbjRrLzRMV3ZRd3YrM3JSRUVwcVAx?=
 =?utf-8?B?VFk2ZGNteWZ5RHBhYWhLWjZUWlpST09Yb081VklYNjZUY2FPM05Wa2xrcGxD?=
 =?utf-8?B?eUhVejJMWEFFZE5xYng2aTF3Tk1aTFd3eHh6S0VVUVpDV0dNMHhxZ05WTHFM?=
 =?utf-8?B?RXdCU1hLbkNlQkIzb2tmTjMwdVdIWXI3NmM2aEQ1YWFhbzYyS0lRN2VuYU5a?=
 =?utf-8?B?ak9yRko0K2tEYzZRS2pQTTNPRXFVNVNmTDRQdCt2WUJvWFNjcG1Mc2pMSit3?=
 =?utf-8?B?MTB6S25wMTdiMURjM3RQc1V4SVZpZ3NQSjFCWTRMYjduNEtpblVPRkdsNmtQ?=
 =?utf-8?B?cjRlZkNNazJhNGMweHB2dVVxOXdaa1lWeWNsZ0VhUmQ3YjNpMUZsV0Z4VmZs?=
 =?utf-8?B?NVlCdHVZY0hEMVRCaXdJQUt1YmlEQURmb0ZucUpGLzNhUTNIclY4UzhVTFp1?=
 =?utf-8?B?NnQ4THdTNy9kMklvNndIMlVjWVpHQ2x5V3ZJTTFPdGxnOUMweXlncEEzVGRJ?=
 =?utf-8?B?SEVPUUdWRzk5azVmZjVYTW4wczlCSlpFTVF0bzFoTmdkS0FQa3RtSXJIcXFa?=
 =?utf-8?B?L3hta0U2MThGYS9uOGl6c3pRcm9VdzZtMW43L3dXM3lxS3lkZVY1TEZUNEJQ?=
 =?utf-8?B?RjNYdHNxNjNWcGFpOUo2ODdGd0FsdlRJR2s5bVhVeWFjNDJuWCtSa0FVMHBC?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8844b219-16f8-4e01-235a-08dac1abaa2e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 17:07:06.6940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhuWR496ci7JqoMXJVzpg8oHih7VeisItsytVHpLUamMVvsAVzvASZ11iLxPPXW7+Z3a1lEYAqNXge/uzXgnTm6Z1OWgo5gIbpXPr5iPiy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6275
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 11/8/2022 12:32 AM, Shaopeng Tan (Fujitsu) wrote:
> Hi Shuah and Reinette,
> 
>> On 11/1/2022 2:43 AM, Shaopeng Tan wrote:
>>> Before exiting each test function(run_cmt/cat/mbm/mba_test()),
>>> test results("ok","not ok") are printed by ksft_test_result() and then
>>> temporary result files are cleaned by function
>>> cmt/cat/mbm/mba_test_cleanup().
>>> However, before running ksft_test_result(), function
>>> cmt/cat/mbm/mba_test_cleanup() has been run in each test function as
>>> follows:
>>>    cmt_resctrl_val()
>>>    cat_perf_miss_val()
>>>    mba_schemata_change()
>>>    mbm_bw_change()
>>>
>>> Remove duplicate codes that clear each test result file.
>>
>> This isn't making much sense to me. Please include test report before and after
>> this change in the change log.
> 
> With or without this patch, there is no effect on the result message.
> These functions were executed twice, in brief, it runs as follows:
>  - cmt/cat/mbm/mba_test_cleanup()
>  - ksft_test_result()
>  - cmt/cat/mbm/mba_test_cleanup()
> So, I deleted once. 
> 
>> From what I can tell this still seem to suffer from the problem where the test
>> files may not be cleaned. With the removal of mbm_test_cleanup() the cleanup
>> is now expected to be done in mbm_bw_change().
>>
>> Note that:
>>
>> mbm_bw_change()
>> {
>> 	...
>>
>> 	ret = resctrl_val(benchmark_cmd, &param);
>> 	if (ret)
>> 		return ret;
>>
>> 	/* Test results stored in file */
>>
>> 	ret = check_results(span);
>> 	if (ret)
>> 		return ret; <== Return without cleaning test result file
>>
>> 	mbm_test_cleanup(); <== Test result file cleaned only when test
>> passed.
>>
>> 	return 0;
>> }
> 
> I intend to avoid this problem through the following codes.
> 
> mbm_bw_change()
> {
>         ret = resctrl_val(benchmark_cmd, &param);
>         if (ret)
> -               return ret;
> +               goto out;
> 
>         ret = check_results(span);
>         if (ret)
> -               return ret;
> +               goto out;
> 
> +out:
>         mbm_test_cleanup();
> 
> -       return 0;
> +       return ret;
> }
> 

Yes, even though file removal may now encounter ENOENT this
does seem the most robust route and the possible error is ok
since mbm_test_cleanup() does not check the return code.
Could you please replicate this pattern to the other functions
(mba_schemata_change() and cmt_resctrl_val()) also?

Reinette
