Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24E2695088
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 20:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjBMTVa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 14:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjBMTV3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 14:21:29 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE231A4A1;
        Mon, 13 Feb 2023 11:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676316085; x=1707852085;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DOw/8CEpfp3kIxFJQipfx5bHl6QrVJ3bMBC9rA3S9mM=;
  b=ZgxJNzSfPOilILHME85EZNsN5oJtrJ4ouaoQV+FTRLvG+xmxpPCsFPV6
   3n0iLqoFGGvuchVrhBQkyqR9N4R36gNRCfk9kfktdeAheNNIp8M0ZucB0
   Ba5Ka7I1OiJvAg9Oyber6Coq+UgW83GfvegU8rgoLy5gw71B4F6Zfj7mT
   ujxEuibL1wsJrK+IZjGbKYkx8QEeVMfzz/5nHhReD1E4bg65iHwFjk/ZE
   SElm8eJQ79ZNfeySfveWowEbdkJFf+1fgoI7lmTehOYbsJ8btacnc+GGD
   dM67N3Dq5X/udV3hopghE/lUhGIPenzmU4Zqi2HDqn5OgSXOz8xsV9iUb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="395588627"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="395588627"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 11:21:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="670942071"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="670942071"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 13 Feb 2023 11:21:24 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 11:21:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 11:21:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 11:21:23 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 11:21:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4YcSVVroUieKW6vR0TbpkHQFcHWzj/z0VFqkwsgMSN3ZL4gG1qo9qwbuI/DVZ4OL5YL5CWhqFu512kWriIwIfjA/pFWXwoTAS4YjavP5WIyLI1kF0OiT9mbK13xGM9VLjLfRPAWfWXrV/wrKnNAsXxwV+3GT51sXuQToTLZvewXydUXyYZe2ZIEVbgfGwmIzIhzGRcrJ0yTvRE1LR6gDJfkiGve2Q09YGKu98tzPNPbPi0TxznJtpwUVPUo35T7idW2mIJoOkLEPCCwl7TAJFIzW3Sb81pIHRqMce7c7J/AvItb5REKwGHhwU3E8uAqlQqh9BrEVBQgH5bMFSmNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoFdQmBVkSpKfkKm2luxHXSIzuC39S4GySeDrHQslwM=;
 b=AGmfstThlfiaC7KZVxcd90vLsy6JSg7se5SBBq0yrzWTUM+ZDl3QAaTBFfUIKpPe3+4ZI8DfVkQ0QykKB8536kdar/O158MRoi6ycbDdst//xFMRcykj1+H9IU5JfTlKeQWPEzaUSHuTGMSXqAdbxqGB4/nefskdnPAUHejhq4x5vqjE1lDlNK1+DeMQU2u0xQLKYbAUnyDP8i3xSpwBliXRSBh1gNh2XV24jUWsL4WA0zeVFMC3pZQCcU71n9ayuZGhtK0t6aOTLw1N+Uq9r5gUnBo5ho1O9M91xFYfR2y+UrihmMxwC8attwTnYuy4Nm5znP8W0Sk0hC+3ZMQe0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by LV2PR11MB6048.namprd11.prod.outlook.com (2603:10b6:408:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 19:21:21 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6086.024; Mon, 13 Feb
 2023 19:21:21 +0000
Message-ID: <a7f1d984-21b6-0bc8-519d-6d2c5e310381@intel.com>
Date:   Mon, 13 Feb 2023 11:21:19 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH v7 5/6] selftests/resctrl: Commonize the signal handler
 register/unregister for all tests
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230213062428.1721572-1-tan.shaopeng@jp.fujitsu.com>
 <20230213062428.1721572-6-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230213062428.1721572-6-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:334::10) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|LV2PR11MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: 23df9a44-3aec-4238-4390-08db0df77ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UKvFZgf46iPqlp1M8Y74NPl2B0OcNBOjirgsv/7GO4UmeOMwWBJldqyOQGu79ffqRX3mMtGkpxOe/bzRKPeFngGLwEB9RXxLOFfA2O6sYGAW3+StNNRP6K6OB4gm/ZA3wHb5mHqCnF8ZHD2DoAQQg9aTfEdsFq/2pTnPMrK/23/BERJ2XwPG+IskmbEBX9LJhIlAOYXWMLfwnPMQq2DP9ZAhIMDxHUZiqpDX+ADw5OOqMtrFfZ3GK7Aqo9ssjDiypTF5XGaBbdVO6atXFdkWVNAz/zICde10uezdgpymvez2v12zzxm9PYUS0RWad3ghwGIBrC3hADRJ/CWduW33SWwIgrS85XufHrE/FjwNlmqIxEri/GGbrU2TGEJq7GtrAzMMdSWvlv+LtDUWfAT/E7uNeavX9Z4z7n+0qET2yweORm82E65W0pywvTJ8rhl9X/PlPJmcgsBlVdP5BsGkqZtx2hdHoK4mOc9pYgNjLXEMsKyPxOexNpd/6leXelIZTuij9bDCRfUhaKhFH5scuOhLC6wiOmV4qKVSnLCxgHAbrJeVE1zMOw0oUSERnZH/xs0Fjb3X2tx8JUew9QTGMGutQKIWIOWeJXuuWUoHeh2dAeULb+c3Vh/I7TTvL8hHcG7zZyDc5ilrYJ83UbFiw9uZ0V8OAONZ+GLvq3Iv/cTmv5qcD9RpaxAOZ0Nk7Jzf9tMDqT9dxtdgsSLgTKSCuJpqekHTjxrYpJPC/XCcAxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199018)(41300700001)(110136005)(38100700002)(36756003)(5660300002)(8936002)(4744005)(44832011)(478600001)(31696002)(2906002)(82960400001)(6506007)(6512007)(186003)(53546011)(26005)(86362001)(6486002)(2616005)(66476007)(66556008)(66946007)(8676002)(4326008)(83380400001)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0ZTeFZLd2F2c0tCckdkTVQ3dWxGOU5sN0JNc0ttMGFHbDNrVXdoTjRsTXVu?=
 =?utf-8?B?OGNhSlI2SFR5S1N2d3pMbnpOYjJPRXhvazd6TnlCZTdWajV4eVRaU3g1VVZI?=
 =?utf-8?B?VFo1eFVSb1dhekJ4a25JTnFGRW5STXdKSktEdmdSOG5HK01hUXZBeC9CSnZr?=
 =?utf-8?B?VVgrVk8va3JBQkw0MFFkVmpGZ3VnRVRPaXA0TmJzR1FLK3ZSK202ZERvRE1G?=
 =?utf-8?B?bytvU3BNY09lRVNZK1UvQWRCZW4yeWZhejkxakw2YmZBS21XVTVrVldxNmF4?=
 =?utf-8?B?QjRHQzJCQ0VYZ0tFbzNqUzYxV05Kdkx6aXN1V2N6NjVjdzM4Y0t3Zk9RYzFM?=
 =?utf-8?B?d0JDeGxPY0ZKYlhtTTI4eFJmeXkrVDlCZnlmakpuNy81VlZnL0N6MHEyY2Z0?=
 =?utf-8?B?U01rZ0lvWHQ3b3AvaGNLYTg3NkJJbjc0T2hTTWQva29zaGNuTUdOc1pNUGpr?=
 =?utf-8?B?TGZsK2t0a05NSU9tQThDWlZPT2VKTThkVHRkbWVjbUwzVmlrQ3QwYmo0L0VG?=
 =?utf-8?B?Y2FOeDFyaGdOYk85WStWZk9DMGNzTTRIdU0zcUZ2VkErb0RIaE9ldVozeTZh?=
 =?utf-8?B?ZlFpVnFkalF2T24rb3gxMGJVK0YydHdjZGJTM3kyRS9RWmtMbnBJM0loWnQv?=
 =?utf-8?B?QXYvd0hmU1FHdGRvNGdqUkhadHhadjRQTGV1NzBNSFh1eHJ0MThUUStnb3Bj?=
 =?utf-8?B?S3FLK09QV3VUanZVczJ5NW04UlpKaHViWW96ZG5tM3hSSHdoN1liREJ3Q0U1?=
 =?utf-8?B?TWtmNXRwN2JHTFRuaWhNdi9rLy9wckhIc041OGlkUTVjKzVkeEJNNkZTUW1L?=
 =?utf-8?B?MUVEWGxhTXljOEN4WGhHZXp1azBxcmlrb1hGT2dua1BySVFuL3VZVHpKWmJr?=
 =?utf-8?B?SklSVjd2d0MyeFhsVTUvZUw2UzVVOGhXdTB1YVZ0UFRKTUxRcHdSZEJZQngz?=
 =?utf-8?B?UzB0cGxDTlJHNGd1NkxGa0Y4bVprSzh4YUVtNUZRNU0yUUs2aE9uK3ZkdW5Y?=
 =?utf-8?B?REs4ZUFCTUFNcWI4SndpNVJpU1dmWE1DR0ZRdU55K2FvWk9haGpaZ2lUL0N0?=
 =?utf-8?B?dGlaR0dtWFlkc1FSb1FFTGM4dFJnc1BUTjc4Y0ZCODgwcFJ4NG5peUZWUDla?=
 =?utf-8?B?NFRtRzBxOUVoVWU4SkFqdVlHN3dDOEdkU3pEeG5oVkEwc056TzF3WEFzdU9s?=
 =?utf-8?B?V1p2dG5NSm1veHdoU0ZHVnVWSzBPeTl1T3A2elU2cmRXRFRreVIrY0tTSUZP?=
 =?utf-8?B?YkVjWEdHQVN0SFo1eWk3MUZMY0RQVFpWd1B0djg3V3R1QmFHYkx6UTdBTHZU?=
 =?utf-8?B?QkwxQnI1NEFpblgzVVk5d1hvbGFOYk8waVNSaDBPM3RQTEFFWHRwSGpNTzJJ?=
 =?utf-8?B?QWtzcXFGT0VrYThSQ2ZOb3NMY0tVZVJrN3VVNzJ6bVFQb3IzcVdhODFEazVK?=
 =?utf-8?B?NDE2bURuRHJXaHI0M3BYNHhVVHlySG1FcWlmS29XajUzMXpzYnNUQkFMWU1V?=
 =?utf-8?B?cUNEeUx4aU4zSURtMHNmSUFQak9xR216cEQ2YVhLS1ZoTkNBMjJrVzB1ckpJ?=
 =?utf-8?B?OWRtSGszMHM1eXI3NWFWYmxNWGZkdTZ6S2ZCWTBHcUI4bWNWUmFsWkRZQ1dR?=
 =?utf-8?B?M3Vkb0lzYVRJNlMwV1h4SUs5V3hVYkRtWS8vZ1hFREI2SGN6Nm1pRFVGU0M0?=
 =?utf-8?B?NjQvMDB2WisrYkpYS2NyRi9NRnVOWGVRRXJUVUh5ZHZsOEk4U0tDdWhvSlRQ?=
 =?utf-8?B?aDhyK0g2cXorWFZ1YTVrc2JWNG5MUnFYR29WODNEOGU5Z2kyOE4vWkFCV2tC?=
 =?utf-8?B?ejZNTlNhY2xESVlIdVE0eVJ3V2I3dC9TaTF6MW13M081SUlDcUxIWGRxanF2?=
 =?utf-8?B?cUJVcHQ2SGJkOHQ3ZXRyVjV0T052YlpoUmkyRXpZa0U4TVBFVXVYSGJISHRn?=
 =?utf-8?B?QkNaNFhGTjE5SzN2YklOaE50SWk1V3hvTVpNa0IyVkZHSjA4bjdXRFZBRXlr?=
 =?utf-8?B?SnJhdkNTMkE5QW5kcjRPOGZNb3B3cnNLOVplOGVIbzA1djViZERCenNkQ3VV?=
 =?utf-8?B?SlZ0bmtaLzJkOEJJdERmbU9KNHNTYkYyelFHekttUFhRWTd1eXJIbVVlNnlt?=
 =?utf-8?B?Zmxac2RGVU1XS1FJZ2F1Y21Qd3UyaW9LWnY3QXRxVU1xL0FrSHZZYURTVGFP?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23df9a44-3aec-4238-4390-08db0df77ceb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 19:21:20.8964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhYzfd+j8vi16OF+FBFCTxB2ms9/h5FG/LKrBYAJ21uBgiU6NzO8S+eFmWQUfnMSbV8wPIuDF8RPwU1X6rk2b+Jj/9NJSgVdbY1c8dgiTLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6048
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 2/12/2023 10:24 PM, Shaopeng Tan wrote:
> After creating a child process with fork() in CAT test, if a signal such
> as SIGINT is received, the parent process will be terminated immediately,
> and therefor the child process will not be killed and also resctrlfs is
> not unmounted.
> 
> There is a signal handler registered in CMT/MBM/MBA tests, which kills
> child process, unmount resctrlfs, cleanups result files, etc., if a
> signal such as SIGINT is received.
> 
> Commonize the signal handler registered for CMT/MBM/MBA tests and
> reuse it in CAT.
> 
> To reuse the signal handler to kill child process use global bm_pid
> instead of local bm_pid.
> 
> Also, since the MBA/MBA/CMT/CAT are run in order, unregister the signal
> handler at the end of each test so that the signal handler cannot be
> inherited by other tests.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you very much

Reinette
