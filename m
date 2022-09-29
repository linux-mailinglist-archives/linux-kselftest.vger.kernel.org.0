Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2C45EF8AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 17:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiI2P1q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Sep 2022 11:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbiI2P1p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Sep 2022 11:27:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28011577C1;
        Thu, 29 Sep 2022 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664465263; x=1696001263;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M3dfq425HvPF1qBxu/uvqEGp0DZhqWuDclh2mUmqMfg=;
  b=CbbP0Br7O86ENxo/bCDVGZgHvD+Tt/NnT7m2xgcWXrDWr3U1ALXP8xaj
   zg4Rc71fEq8lkQhKJeG1p49SbFvsBDEswXq93r3sGOHMa5hH9/5DmDghM
   C9STgXfQLUt26MuQsFWW9E/W+5BWZoKgBFtiJEZlGc1TCelWmBX+ZREBm
   75+ZMlyvGBdoQuSx2EKATiT++J8/hencYG2ZEZpFjND11OnvZP9y83xg9
   bSvsuD4/qGZyuL2PZc0VwiuTCy5e2M6dDJG9gTW6yHPyOtnlBEB5fuKRp
   xEpnI2Ye1sqOfDVIJ1f0iqrezWgopYUa96bH0es/XugENJgREezjjBD+J
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="365976378"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="365976378"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 08:27:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="726453980"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="726453980"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 29 Sep 2022 08:27:43 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 08:27:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 29 Sep 2022 08:27:42 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 29 Sep 2022 08:27:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXBTYdSbPTgeY0ob6CXihJEH5Xk2LvOLkxfJasWF+Y68PRjLZKNKpPaTTyrPCFhY8TE2N3EcFQZcPE5A4QKvZaiLAJSux9sFLBjw0dJsgsXcAOEzqJpG/Zh/ku26DBjll8szj/KZ9HNBZmpMXZWQvJlDPtLbtzmsD1+GqBcJJWmhN9XQhGEEP9MSQ9PCna5He66ZZmuoqoAFeAmZVxsqvukOcJZIftMmR819WecnIAB/co778/t9bi29DUalhmlx2RubC3O8Ao2ar+zqp1J9mRdceYNQgmQxzKJ6d+uo6F4hNmx+u6/gKS/r9oQyh1EHghdNw/AyEGfaMBg500ZrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CY1utXS22v02hHD/boH+Ze949RjUZh7gNtVbkJESQc=;
 b=jUm/KS1cT1r5TZ0NMjQgGPqDfhVRcRNvivCXnSo/OzlxLTkYknruIR7p6WLH10cxOxi+Kpu0rEaPlb+h/zYDK5Hi73l1R2ZKLtixUKLAz5Fn+U1tMhQKOkfwysvTFDHwS0FPoyvfYBKCPRmcyv7+IC4psOz3DKCOz96zCA2bpRpjuL9zw94ABPWih7A1GiuWlZ0ZtqtRIt/aZ6o49Aw6SBO4Y5X/tjpiKvMYZZhwMQ3zqvMZNezETZjolvQ6DhWPIjzwaWYk8gBY+qH89q+BhzD8y+8pqT7R5S7ehCVGPQQs8FM7nN+pGMAKrfXyXihJDoONHY4NmL3aqucPrDib4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ0PR11MB4877.namprd11.prod.outlook.com (2603:10b6:a03:2d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Thu, 29 Sep
 2022 15:27:40 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5676.015; Thu, 29 Sep
 2022 15:27:40 +0000
Message-ID: <d28c2b1c-a974-1622-e817-942ff28ade24@intel.com>
Date:   Thu, 29 Sep 2022 08:27:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.0
Subject: Re: [PATCH 1/5] selftests/resctrl: Clear unused initalization code in
 MBM tests
Content-Language: en-US
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
 <20220914015147.3071025-2-tan.shaopeng@jp.fujitsu.com>
 <24cbb6e4-d853-6c7e-cffc-daa7412d1eab@intel.com>
 <TYAPR01MB63300E751096E8F613CC7F398B559@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <580b7e0f-1303-bb27-0f9c-f05f793a30d3@intel.com>
 <TYAPR01MB63302FA7919E8C95B9C56FC08B579@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <TYAPR01MB63302FA7919E8C95B9C56FC08B579@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::17) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ0PR11MB4877:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0d52cd-5749-4ad9-0594-08daa22f25a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nrExgcjkMgLkOo68g+eXeGCyzTdCKRwLo85z/9rzAxIa2zUEJfJdDobVh/9yzP7zABDVsslNmiDTyvx7lUbX8wlcJS2uJjr5yK9oOBFVYuPB+TO+sQlWm7R7408BHHogRuPiZwM4MKAu15hXThnxZKxhCZWZ/bgrmyrxu13y4R6wENAeBkRVRs3h63tnAQpvqc14M3ltMihT74To9usaSejs6hQNUEDYUJGL/WzdqJXgK7r++YmDgXtmQJCBSR7aphTrSFUZpbjMUAgDJDOoTRUpKETVrU4DD+EJg/s6BlxscyjT1wC2hD+FyL6qMPDJaCOOCPXgSJwsn6v1i5+r1v0KKe3uehygQe59TePWwVAj6jxusTWNqybh3mfg9HNnKFZDV7Ztm4ObSsX1ZuGBbx9AzL3zW1pMNLONSknXnE22cB/zH1kJ2enZN+GXqURiC5AWr3CU3rohqbD2hq4PsmK2KnrJoZnxidsIFk6e+mCZanVTiHlTcQQTqVsTuoaLwz0hsbcgGi4IO4EDw8tCbcKtVgjoRW6BbywU+IK0jAJNuU0u4L373IQTfsP8Ep4k3cOx+oxiFEO7+XeP/LGJcFZm+NmRtTkNNnxP6RKKbewJvI7q285jTAWzJaxQ1zxUXDJXDhWKQzS2Vtlki3i0v497HKdhyTyfkqlzozHweqFQt5NEhAgDUZM9SXdx5oOLV3yy5iRtuvaLS71lb4o2o3nkUqLEvXZx7rljW57FN/FOP5/noAfezopRbbIaK+elVuUQlrxk+4Kj8xBzZ2OV6+w9J59Ijp0Dql1gsEkh/h4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199015)(31686004)(44832011)(5660300002)(6506007)(26005)(41300700001)(8676002)(4326008)(38100700002)(82960400001)(6512007)(36756003)(86362001)(31696002)(83380400001)(186003)(2616005)(2906002)(478600001)(6486002)(110136005)(54906003)(53546011)(66476007)(8936002)(316002)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUdCTitPUExyU25BdDFSdGhuQVVYTCtWMTE0R1Y1L1AxSUMraE5TYkV1dVFU?=
 =?utf-8?B?N0h1VXhZNmV0TUl6dVZIeUpjWjMyUmdGUTJUamJydjlSTm1EdUsvaUpqQVpO?=
 =?utf-8?B?MGk4Qm1OL01OZzFFUUpDeHJvYjllbWU5RFdJcTVPVUIzT0dVYzJwb0pad0dG?=
 =?utf-8?B?ZmttUm80Nk1WcWlBVzRLVy83NjZyT0pHLzdyN1BVd2Z5ekdHbUJYV1JndVV6?=
 =?utf-8?B?VEZ1Nk5LYU9OMWd6VlI3OENjZWd5NzBqbTdOT2hldVFvSTNmYXA0RmxVSXVq?=
 =?utf-8?B?SWZpcTBlMGozQnM2TjJxK3huUGFzeVpNdVdJNUpSOTZyMmpOMmUzdEhOZWdY?=
 =?utf-8?B?M25pZkxFZXRmWHFsMFhNL0ZkM2pVNDZ3MjdxSEEzVGtoeFN5cXlZMitxVTF3?=
 =?utf-8?B?REdkYjJyWm16RzVFcUJGMC9aNUFlaytDaU9DcVpJV1g4L0pVVTcyanlTT1Qv?=
 =?utf-8?B?SmVzeVhiaU1kMExJd1JFUG9VWm1HZWZvU1EvdkpvdTBHUTM4cjB5dnFtY1ZZ?=
 =?utf-8?B?dWNHalFLL1lDVGRsRnpDd0g4b21QekJUTWZnV1hEVEJIN2ZISEhUZzlBRE5s?=
 =?utf-8?B?U2ZWaUxaZTRzUm5BS01FS1R1bDdZMi9FZU0rUEZnd3pTcGdZaktYN0xxVk1o?=
 =?utf-8?B?KzZZaC95L3VDVHJPZTNuSzZYb01EVWFFQjcvTmRNalBLQWgrbmdnQ3JKZjBo?=
 =?utf-8?B?TjNFZTN1UWN3SW43SkdITWhWOGRjZFNtNVlFTjdOdFRMaHE1Uyt3RVg5SFFr?=
 =?utf-8?B?Mkx5dHc3elpBazJudUtIM3JxSkxySHBrSmJFRkNhM0Y1cEU4NXBlaFlTWEdn?=
 =?utf-8?B?bTA2TDZGSTV4eG9ZaWtFNGREVm1GT2ltYkdFS2pZV0l5SVhNbC9uTGVCQXd3?=
 =?utf-8?B?YmpJQ252VXA5SUNtMVhwVjhrYnlLYlVwcEQyclNTN3JBdGNkL1ptV2F0YUVU?=
 =?utf-8?B?c0VnYlJObmVuQTNWSnRWZllQNlVSdHpNWFhrTVRPMlFITGxRZHJVcWpYK29l?=
 =?utf-8?B?aWxRbElFZnQ4WUZYYStJWnIyaFpRWUxqYVNDNGdYaWtscDZaZmdtRHUzdW9M?=
 =?utf-8?B?SUJpTGZEQnZuMnowY3Nob3hGTXV6SG51RzlldHFKZ0paOHkweEUxZGt6dXNq?=
 =?utf-8?B?ZXZWbndRZnJXbFVrY0dqWVBtMmRWYk9YN1BFSG1HSG1JYUJrMzVJRDRpWDFM?=
 =?utf-8?B?TU1pMDhHeW95M0FhbVQzR0R4YnQ2a3A3ZkRPalB4UHdNWm96SGI4YSthM2dI?=
 =?utf-8?B?M09YNnBBSmhtb0duSGFYOWxKaHJidTFHLy9vcHZqNXRBVWx6eWxSbWl0WW5k?=
 =?utf-8?B?V2YxK0RIUnRIUHZTbWh0REcvUXdlWmxVK0ZFakhnQnJySzBLZW4xd2xxT2py?=
 =?utf-8?B?UTBiZVVlSllyWkNBMU1waENZZTdwaDJLQTRZZ2tnNi9tN0xMTTBPZFd1UVAx?=
 =?utf-8?B?TndaSDhEYTlya0R4Y2JTelVBUDRwdXBPS3V4VEI0ZDdpMzJMK012WDVycVIw?=
 =?utf-8?B?ZWxaeTZnT05CMnJwRUxGNk1meEI2Nnp4dmhObmRmV0JwQVp0MkhhazdtWUJR?=
 =?utf-8?B?Z0JtS2VKMjRxaWFyd0VhS3Y1UDdIQ0hDWWQvKzZaM3hVcGhOc2FnUkhlMjJW?=
 =?utf-8?B?cFJnZHZPOXVyWHVEQjBOK3BSOUdzWExSVm9KemorZEZlZkxBWDI5K2g1aklO?=
 =?utf-8?B?VE85RFhydkVYVHEyQjlaVEgwZkZ1VmFLbk83VUNIckFsTnZlZkZrazJTYlVz?=
 =?utf-8?B?NTcxMCtIeXo0ZzlxejVYaEhLUkM1K3BCUjA0V2JOQnd6ODlOLzVMR1B4QktZ?=
 =?utf-8?B?SkdmNllJaVR0WHlPQzdGR2Y0U0hvK29XZlRYZ2laMU1ITUgra1pzUXk5bXFj?=
 =?utf-8?B?SmlNdW9pMTNtaGVmN2JKMk5aNkVMSG1LdEVFVEt5U3RxQjFXVUw4bmVUN05r?=
 =?utf-8?B?bENRMmpwcllpU0tIN0FTVDFvVGZ2MTh3R0swQWdJK09HUS9JQ0k5QXNRVk8v?=
 =?utf-8?B?bWVlby9LWmJuVTFxSDRaK3c5SThiZFJxa1FWbW56MEsrTWlMdEYwaG1pZFJF?=
 =?utf-8?B?NGVZQitPbkNPaG81MGNsc2N6a2ZpM0xxbWUraEN1ek8rREdMTGNIWWgxM0t0?=
 =?utf-8?B?MndISXRWQlJQak1rTzYweTRFVkh4bzFqYzBBNFZ6ZFIrSlNEWWVjRkVFQWYy?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0d52cd-5749-4ad9-0594-08daa22f25a5
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 15:27:40.6955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iODnX0pey6lk95Wjk+5Xvgak6ojcj7bf2x5Q+1tkqIbBD1qB9ReMc1oryuvXhQhYwxbeoOjgPgpFlCvMK9jd4ZQJ/21emX0RkNYDLmDKhUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4877
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 9/28/2022 10:28 PM, tan.shaopeng@fujitsu.com wrote:
>> On 9/27/2022 2:01 AM, tan.shaopeng@fujitsu.com wrote:
>>>> On 9/13/2022 6:51 PM, Shaopeng Tan wrote:
>>>>> There is a comment "Set up shemata with 100% allocation on the first run"
>>>>> in function mbm_setup(), but the condition "num_of_runs == 0" will
>>>>> never be met and write_schemata() will never be called to set
>>>>> schemata to 100%.
>>>>
>>>> Thanks for catching this.
>>>>
>>>>>
>>>>> Since umount/mount resctrl file system is run on each resctrl test,
>>>>> at the same time the default schemata will also be set to 100%.
>>>>
>>>> This is the case when a test is run with struct
>>>> resctrl_val_param->mum_resctrlfs == 1, but if the test is run with
>>>> struct resctrl_val_param->mum_resctrlfs == 0 then resctrl filesystem
>>>> will not be remounted.
>>>>
>>>> I do think that this setup function should support both cases.
>>>
>>> In mbm test(mbm_test.c), resctrl_val_param.mum_resctrlfs is set to 1
>>> and never be changed, and umount/mount resctrl file system is always
>> executed.
>>> So it is not necessary to run "if (num_of_runs == 0)".
>>
>> This is true for the current usage. You could also add a warning here ("running
>> test with stale config") if a future test sets mum_resctrlfs - but with all the
>> current output of the selftests a warning may be lost in the noise.
>>
>> I think it would just be simpler to support both cases. Having the tests be more
>> robust is good.
> 
> I understand that mum_resctrlfs should support both cases(0&1).
> 
> However, "num_of_runs++" is executed before "if (num_of_runs == 0)",
> So write_schemata() is never executed regardless of mum_rectrlfs is 0 or 1.
> 
> 97         if (num_of_runs++ >= NUM_OF_RUNS)
> 105         if (num_of_runs == 0)
> 106                 ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
> 
> I will fix this in the next version
> 

Thank you very much.

Reinette
