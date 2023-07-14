Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57272754087
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 19:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbjGNRg4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 13:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjGNRg4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 13:36:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFE1113;
        Fri, 14 Jul 2023 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689356213; x=1720892213;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N3GIVmXVmvIriVtEgYDor+CSARM+RBOdwDMfFMeA18g=;
  b=AVUy+jDjVVdYPJJbd9CnlG5GbfZWyDY/ef6FI2CtnTYu6X8WDCxsOvXV
   Eo4ibFaL8tz98eZnh6LHAnuqbH0OrSfjwdKcT3aVFpWiXq0XXYQeypsI+
   44+Js+odPlW7jPWSlAg+jWyn8zKfhW37XAQ3Xag3KKQwhZP0LP7i+T9o7
   yhTFRH21XYfCpLrVqDx+Bizu4hZ4Nnf3JBxfsDvevg5rKMiGCfkYyR5gJ
   v2KjMvOeGs0MRw8oNL6q3PAtkEvIL1rvDTbt4XVZDojmVsrDTCqYBAqJE
   ZFuiUFoOWIRHwPuLOa2qKL4FMrP43rt4zWfBvkMerRdZCU9n+mrmI0sOP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="429297571"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="429297571"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 10:36:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="812533570"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="812533570"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2023 10:36:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 10:36:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 10:36:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 10:36:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amB1ltwTm+n587Juqfp/OFWS/9QAeFv+PeI/IazJhzPwR81ys5OX/Uf6nSHhXC0QwYyAwmdF547xcJO391glvc+p4VcAmzRVbTnCGPuJgDZn+PhL9bVyFHJOGiX4WCCkKdNyoBOBSqvHjBpne1Vjy5niekt+yxWtl1QYY+DzNs9O6zhe3LQsbmAFcNn0qbYgEbG2BCWyTJ0+x2Bx4/pDrta0UaYMCBlRt8oehR9aLqqJlonTuM7s2/uNZL9R1xHY3ks+KFhqsXSXVxYnxt0HxU5uBvM2EdrGlfjJusd7Kaus+BS03VSLjgnlDzzsvELiH15nEvFVvOlkzstyOuUe5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0Q9xSAIeKsP+lMR2l+H0Dgkqt1a1JRkT2ceje9TiKM=;
 b=Vj6tegefhtoFYXlHYT7D+AgxgC2wQnYJbBXtEisXF+r5tOFfRbc3Ggxr1ttJEbLrBKfN7YezrCstS41SVfmgjU91PuwqsU8L3LgoBc1hJqXpib9dDsYqvnt0nZe47tcCcMyffojcmB4E4l+sd1nLaKChVVX/PFDyYo+aZGZVHox6czAyr61Mg/+CuJJIiKeXJAgxK8Khd9c0EESquvLjaeSf5CfngD4+Hn6eGqmYRqXs0p9gtvw6EZnb5vd5hFj7hFPSS2uG2NdG7mE5V8JNXB+PN/al8abQepd+/RF6BxueLjyJwyBsPRmqKL/6O0V+oqPHYflQl5upj7I3L7PJaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7191.namprd11.prod.outlook.com (2603:10b6:8:139::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 17:36:45 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 17:36:43 +0000
Message-ID: <83d7536a-fadd-7c73-9d0e-5fe80e162759@intel.com>
Date:   Fri, 14 Jul 2023 10:36:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 06/19] selftests/resctrl: Move resctrl FS mount/umount
 to higher level
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-7-ilpo.jarvinen@linux.intel.com>
 <59fd7956-caf8-03de-10a5-f37036219134@intel.com>
 <07faf1f-cde-9d3c-1f15-bbe494466abf@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <07faf1f-cde-9d3c-1f15-bbe494466abf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:303:2b::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: df74340a-2c6b-4370-2087-08db8490e3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HgXAq+S9roW9f5m/NsU7z72V6nY3W6pslZw2Rg+/YDbJntlqBuyX/49mq6Sa9ltLoqWvfX/WGPA2ZM+9+DOUab2t8D4Viarj3fsweai6GylowJp1oVU1FnnHRiIAW+5TwdNiQhiQ4at3L28Qfm6CLnFKeuBinHhCMiUwWQH/UVlvNFLkyjyBZvljGODdf9GWdzRCXUxnB83hbxbm894Hdgw4L4ePOk6Zc1xSJj2C4IHAtStJIhdbkbG12G6TfLxkuU/hHWj579t/0hxzakeOEDvbL5Jm3xOOWPtCh9eGWpiDrRL3NPzImgNaEZ/dFP8YN5OqVBGCHTs6tsm9m/Z6oMk4m0VdwTH8RTFmAFe10yvD/rLOght0kxgIhmMe47cuN5LQkW0VWHtGnrpLxwWSq73n4MmOvyDwX/lSQb1Krqflq6efaC0/h+a1gBpdpdHueIYgh/VQIySxKVj3C2y8nJchRSgisLIIDs29A5+q9p55XyeRxYsCj7CzFnzNqp+pGjGKWz5w2382x0YihFMOA6tU/tt3397E5PsuAv/3r8q4rJGnKb2vAiuwxw6VUGe+Q/+F5wJuPia35OoYSNVCmAuBjdqqRmPKUqtQVwFGtQvXaK5jHD2MMCY4mixs4MvvdoQ77uEmflM5Bhyoo7cAVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(86362001)(31696002)(2906002)(31686004)(66574015)(44832011)(83380400001)(8676002)(8936002)(316002)(2616005)(41300700001)(5660300002)(38100700002)(54906003)(66476007)(36756003)(66556008)(4326008)(66946007)(6916009)(186003)(53546011)(26005)(6512007)(6506007)(82960400001)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkJoNUtTQnlNOStQcUhlRTkzeDVpNlhtcGZnbWdEWmF0bU0xSmtsUXh5STAr?=
 =?utf-8?B?bXl2bld2clFSSitaUTlyOXh3WlI3QytEeHZ6dVRKbDMwL2xURTdFSzRwanZk?=
 =?utf-8?B?Z0s1amloWWZhRjBHUEJsK2ZESUdxNXZ6STc3aVJzM2lMZFFuTzVyT3FqTFhY?=
 =?utf-8?B?UjBsVDZ1WUhZZUhPWHd4Q2hxeDdmN1FCYjNIR0tvMzZlWkRpdDZaK2E5aHV4?=
 =?utf-8?B?ZWlQWDh1QzNralJNWW5DQ2YzV0tHdDVPUjNmWW1ma0R6cXFtWUdFVUU4bWYy?=
 =?utf-8?B?cER3cU9uVnc2TkpiN1doTGdhTzE2QUtYNkpPdGxGekJWTDdoY3U5QmhmbjI3?=
 =?utf-8?B?NEtlcWwvL01TdTdzcEViYVliMlJaN20zZHNEZWdoOFh6ZjI1K2QyK3Z6UUlB?=
 =?utf-8?B?UytESGJsVzBHYXhzZVhWaEZkTGpQRGJpNFkxN3VUdThNT203RjUwZlA2YlEy?=
 =?utf-8?B?K2dyZjVHR0hwQzRtU2Z3RzlPdkl4OUpzS0l6QUVpZHNTVlVUTm1LSm1qWWVp?=
 =?utf-8?B?bGxucm5GNUdCcDVuTUZDRFBEMnpleXpKaHVBbVhUdWN3amVWRE9iVTFmdUV2?=
 =?utf-8?B?bGdKZ3JkQkUzTTBWUTZOaTZGM3hOTjFNVlR2V2xIRW1JUDJPWmc1RFlrL2hD?=
 =?utf-8?B?ZmJUNmVNcGlBaWNuWGRqV011ZTRWc1cxcnVKVEtNcjBIQTB2VXZlOXgyaVg5?=
 =?utf-8?B?WVhFUmNzVVRTQ3o4cDl6bkJNaUt1dkltVi9Xem5nM2MrcnF3cythdEkwWDNZ?=
 =?utf-8?B?MFV6cXdkQVNsQ1hHUUZIdTlSem5Fcy9HVGFERjFoaDlMZ1ZEaWIvY0tVZG9I?=
 =?utf-8?B?a0dYTWVVb2xsbkxqNWVCck9DRUxVaW1BZmtzbTBLNWpERU9UMFViem5xdFV4?=
 =?utf-8?B?WnFOdHlCcnJsSmplZFg2dlBqUC91cXY3RHBKcUJIbDJmQmtEUFI1aW1PM1p3?=
 =?utf-8?B?dDR6K1VlYXBwbmY3TFV3bFkreWRrWVZnVVM5MUVuMm9DeUk5Y2Qvd3d5QW83?=
 =?utf-8?B?ais4Mk9LMEhpUG8xc2hOOCtYWGdhNlRqbi9iczNDbEZzNWlmYng4T1lESXJz?=
 =?utf-8?B?MzR6bXQ3OCtmdlBRWmExNVZGYS9TcStqZW9nSVB1elhpZW92MzZQWnR1ZUpZ?=
 =?utf-8?B?cWR1cFNabzVETXRNUDZ6aDQxUmZSMkJ6alhBczFJQXFkZCtvbXFVYWVDSGxL?=
 =?utf-8?B?a3k0N05UYVAxY3F1VTJhaTlDS3NSYWw1Ujl0SW5jMEYwZytvZWNZRmFqZUJy?=
 =?utf-8?B?VTlWNTU0NEM2UHZNeHZvY3NsbU1TNGR5SjVveXhtNklJNjhLOUNkOUwzQnFC?=
 =?utf-8?B?ZTR5T05YNmxFZm5lWE1jNm9JeksxSU9hSTVlUEJ1YTQ3MGpiVHpUd0VBNGNn?=
 =?utf-8?B?OHBDZDQrVVgxcWpyb29BL3hPVVlOMytMclFIRm1kb0FaL2Q0ZmQ2Y1MvVW8v?=
 =?utf-8?B?YU9SSSt2d2F2cmsxbzc2SlFrd3hoRW5HMkY3Q3AzcWxVYnB2WktueE1zNmZN?=
 =?utf-8?B?SG1XK1dXcTdkeTdnTjV0Q0kvckNxNWE2c3NicGpvTGhQSmU3T2p1ZW9QUFBp?=
 =?utf-8?B?YWo4czU5MTVGclBib0U0MDJ6TGQyRnljaUZCb0k5Z0pmeVRyNXVIeTI3a2Mr?=
 =?utf-8?B?SmY3T0tuWER1SnFCaHpxU0RhZlVHdUZ0aG1aczdFTjhLNjVCeGFUWWxhVk5w?=
 =?utf-8?B?MWl1UlJ1VWhpYkNyYU50SVozZ3Q4RWVzdE5FTXFTU0hsSW5UVVJHdUZEOEhp?=
 =?utf-8?B?UHZyeE05RFNHdG1FdzFjTlZwNEtDRFBLdGxyZkV2ZEJFT01FOTg3bk5RbG0y?=
 =?utf-8?B?OFVwN3BBemxsZzZhVEtCNjF3WjdWbXpJaEJxN2VaaHJkd2RZZGdHamQ5d2pQ?=
 =?utf-8?B?M0NiSXRzRDBYQlBDVDBMdURRSXc3Y084cXJQeHRrMVZ3Uk1weU9rUmhONXkz?=
 =?utf-8?B?UjNJSVI3c3VXZFR1K3gvVlEyL2ZnVGlYK00zSVBWU3pzT0F0cFpaNk5WaElL?=
 =?utf-8?B?WHk1elVRNE44UnhKVm5IZHFmcG0reEJLcGMwdERUUE1OTDJvdTV1R3gxZFBG?=
 =?utf-8?B?L3UwU3ptNCtMbXJyUDVIZ3IzWmo2KzBtTHAxNmZwR1pud012cE5uclp5VnZr?=
 =?utf-8?B?UjdCOGV0ZU9jYk45K1cyd2ZDcERiUEMrNWFLcDduZDlrcXhscXhuL3JuNGNs?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df74340a-2c6b-4370-2087-08db8490e3ee
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 17:36:43.8496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ka6XyYvXEM+PfjMmgmqik1XSB1iIARGGQeRwf/mbJUrqIoZNo33ODDMEKOKgQT8ORA/mIZL2Kxe4lvglxi4uNTzL2BzeaJ+LbCOrlUbMwc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7191
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/14/2023 4:31 AM, Ilpo Järvinen wrote:
> On Thu, 13 Jul 2023, Reinette Chatre wrote:
> 
>> Hi Ilpo,
>>
>> On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
>>> A few places currently lack umounting resctrl FS on error paths:
>>>   - cmt_resctrl_val() has multiple error paths with direct return.
>>>   - cat_perf_miss_val() has multiple error paths with direct return.
>>> In addition, validate_resctrl_feature_request() is called by
>>> run_mbm_test() and run_mba_test(). Neither MBA nor MBM test tries to
>>> umount resctrl FS.
>>>
>>> Each and every test does require resctrl FS to be present already for
>>> feature check. Thus, it makes sense to just mount it on higher level in
>>> resctrl_tests.c and properly pair it with umount.
>>>
>>> Move resctrl FS (re)mount/unmount into each test function in
>>> resctrl_tests.c. Make feature validation to simply check that resctrl
>>> FS is mounted.
>>>
>>> Fixes: 91db4fd9019a ("selftests/resctrl: Remove duplicate codes that clear each test result file")
>>
>> Could you please elaborate how this commit is the culprit?
> 
> Of course it isn't. I'm pretty sure I had some idea when that was added 
> but it was before the patches were rearranged/modified, maybe I 
> incorrectly thought that the cleanup functions do umount (but they don't).
> 
> I'll changed it to these:
> Fixes: f1dd71982d19 ("selftests/resctrl: Skip the test if requested resctrl feature is not supported")
> Fixes: 01fee6b4d1f9 ("selftests/resctrl: Add MBA test")
> Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
> Fixes: 790bf585b0ee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
> Fixes: 78941183d1b1 ("selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest")
> 
> ...however, I was also considering dropping Fixes completely because 
> main() has the final umount() at the end so no lingering resctrl FS after 
> tests, and inter-test issues are hard to track due to how complicated the 
> code is so I'm not entirely sure if there are real issues under any 
> combination of tests and all the mounting/unmounting going on).
> 

Indeed. The problem statement is that some places lack
unmounting resctrl FS on error paths. This may create impression
that there are scenarios where resctrl is left mounted on failure.
As you indicate this is not the case. I agree that the "Fixes" tag
can be dropped with this categorized as code refactor instead.

Reinette
