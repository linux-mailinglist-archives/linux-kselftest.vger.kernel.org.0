Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC947568C0
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 18:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjGQQMC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 12:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjGQQL6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 12:11:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727BEFC;
        Mon, 17 Jul 2023 09:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689610317; x=1721146317;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d2jWS5kQD0GIcScA905EP+tql1djaCqMqI+9W3mgHGQ=;
  b=YVTgR3Xoj75a0oaniuqKGHvyheKktmNvr8ig5PQLWHKQl0VVRvVfJJ+V
   3WL86HJth65AdSaoWyKZpWubqOYpjVEwnImwHzFEqQo0nykex+PQoN+Zi
   w/JgGK2vioOIu1E997o4a2Mdp3AgKYbmT8MFCe2jI8ZgYE0rDM1VdoBzX
   lX4ttmL0sijrVe2i/hnEu7iOudiB4DHVGCknW4x4SYdoznGt/s9kRxHve
   pm62XsppjX7T5wAR+pEXrZAsQ04UHxhh0ekrMhK/Rjg0B1LO1mXrNsEEN
   +27qDuCn6vTGVjp8MdYWF33br8qamDWdmad1SHUKPJ/Qm3Ki1BeK6ilem
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="363435407"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="363435407"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 09:09:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="673574145"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="673574145"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 17 Jul 2023 09:09:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 09:09:24 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 09:09:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 09:09:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 09:09:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZc/AapBrGTjT+Ljv8fVlOw7JXsXab0+Gh04FSDcV/JeciBFaIqhc3WYPayLv8WphAuq8qgJc8jGfoX7gLTPWRawf3Q7IEQpRudyvy9Ox3CKyTqFst8mBxyNl35TiplVA2Xo/kGHHm0vuytGvMCa7TsdR/GpmuRlGeMkf3pz5hir3rQc/Y9W6sxxViEBNKaBdcm0vHwlfm0wdcn4m/8KdmYDF63zHUJOrnJNLs03y5x6Q9CMPDfOsuIT7LV608s0MtpI+iHCxjS8Bk0dH0dM1pTORN/0xKVwUQlIYpPRThC2NF2rdG0EzRl3Wn1e+mZ3OXB0VLlahUSpQ4eVhQB3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkAuXP8KqN7yu0tZaLnWPvne4Llsjndv6lnqOjjj34c=;
 b=lWXYUOi7bJA/5MkFKQ/Pur5DMD41sETOqIw5NTjJuNz4T5KyHagwZDzyDcYQTlOMyAczNWMbyx3HHR1H+pLhIIKLCnE/T2SBoF7FS2e9mXMGymMeIxWrU5UX6qUwPTj8c4kIi7azYu1AzRguN6/KWRpVoFHsgd66PDMb2RkuNCYtDfnRlpCS6F3BxnqWAe39wlW7BllxNKVVPaD1505kdT0aqWo5uIPzV6WjiDl6Ppbx7zhed8QnjvfphTSaE8P2dAncTaZA8owvnL16hRGFf5m3usmuk4/8EMHnbt5ctnLIylIvW4dGH1pYii9Y+FIUn3b+0KKb0pp1RLuJX59hnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB7153.namprd11.prod.outlook.com (2603:10b6:a03:48d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 16:09:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 16:09:21 +0000
Message-ID: <bc32013a-9f72-6a67-29ed-9a300ea1131e@intel.com>
Date:   Mon, 17 Jul 2023 09:09:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 04/19] selftests/resctrl: Close perf value read fd on
 errors
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-5-ilpo.jarvinen@linux.intel.com>
 <a4fa6303-4637-815a-e0fa-57f33babfb10@intel.com>
 <c14286ec-807c-8613-a4cc-d8ac733a87a1@linux.intel.com>
 <4531fca1-2f3b-0c08-351b-f8e06c5f9f5c@intel.com>
 <8b904781-c5d-8164-b8dc-903d412330fd@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <8b904781-c5d-8164-b8dc-903d412330fd@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:303:85::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: a85fdfec-ec4d-4123-a130-08db86e02df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qt0XF+TJge7jN0Hm3sCHSw2VcjxyfLpMxmMEEXsEokidrMhyTbhiA/wIPF0GU7qIH2CdK90I+Y2LEFS9OqBC+NM1asVrNLHTGj84pEIMxntjCdGApBduQ0AQ0CNyCW08M1OEo63kkjt0ZK2YJ+5lZtB6mZGkOdMDTE4F+jRUAf67UM1RSuxxoVUbPGbEZVE5dIiZ/pPDkZCHRcx/RRhyBOiQHc4gVJ+O/liPItKd1cWasSTyH8FxryPQSrdQrPBZAGFR9R/hR8EJSsGuVk9VhRKzS8KP+171mabbeZhQS1u/+nfOovdXy1Poh+eMEyUJvLuU4E5QD8NfWm42mbpR0LwcnqnhtxdQ9+UVjUPHQbuClhswexadLZd91ibdyTKNGpHQCg4eVIRYSWIP5ZzVxt934SzJMRTPIRr7X0E0iwq32z0IAPmGSoTMyEAd5TtgO8lQse35+vWSYBznGoxBTd8t5H2H7RRkrdbIN9hxt9UZB5f7rum6i5bfXmOStmxboS4pQmAwVB+fqJrNaVZ5N09wpu9OUy7OUbtZSr6Peyy3v6i4f4PF5H043H7mWpdtOlY7WkFkateCyPbGuz9KTAIGudwS+x0T0fuezpSIeTmvMYnWpESNKz+txr0428IY4gmLo950vx3hSnI3s0vswg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(31686004)(6486002)(54906003)(6666004)(478600001)(2616005)(31696002)(86362001)(4744005)(2906002)(44832011)(26005)(186003)(6506007)(53546011)(6512007)(38100700002)(82960400001)(6916009)(66476007)(66946007)(66556008)(41300700001)(4326008)(316002)(8676002)(5660300002)(36756003)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDMyUFZySGczRmx3eHVQbmMvVEJyOUZSaUgybU9KYXlkNkNQMXRzTkkrRDQz?=
 =?utf-8?B?MWp3TnRIVHJvR0RNTE42NlEwMXQ1cFZBKzZvWmVuM2RXTjZaTk4xc011Yis1?=
 =?utf-8?B?bWNzS2lZZE83TWpGYUQvNnNOc0pMZmhicmR5NmJCcEJyZk1lOHYvODA5ZVov?=
 =?utf-8?B?SE9Da1FEOVJSVXFmWFdSYk5udDBLbXNhS2VXbVRWa09QOWdXY2J5TlgwNDNh?=
 =?utf-8?B?a093bkF3NHdtblVVVHUvK0UzQUZmbzcrUnE2S0w0ZjNxR0pqMFQxYjhZZUUr?=
 =?utf-8?B?aDVEK2g3ZTBjS0wvaDY3YVZiMTJ2YzdkRHBGaWVIVlFRTSs3ME4vcTZzVHox?=
 =?utf-8?B?dG05QUVocmRKbFJMS2RjZG9IU0xUZlpzWmVYOTVwOVBCR3hlVk8rRVNvbUov?=
 =?utf-8?B?OUZleW8wSS91NHpJcTVwNjEvUjVSM0c3dVFtWU15NlE4TUNKTjZnMlFyLy9y?=
 =?utf-8?B?MlY3K2FhemR5UUI3OHlGODdqQzg0UmpBQUMxQjlDMXNVZS9yZXRDRG5uRWdT?=
 =?utf-8?B?S09wMmlUMlJmTStkd20xcFF0NGpyUHlXbHN4RFNJZkFmUmtJMm9jR0xWUU1U?=
 =?utf-8?B?Vk5Cc2JxRy8xSWJWbkExc21tbENwbnMxTUJ0aDVUS3Y4VjU4c2ljU0RmaVds?=
 =?utf-8?B?Z1RTUUsyZFBFVzRhVmIvSHhUUFIvTWRSbFFqd1FEQm1tMEc2ZVNDQWVpUFZt?=
 =?utf-8?B?dTBuWjcxN3lPTE44bVJVSmRGTFJFeTRzTFRDa1RPMzlWdzkrdSswUXJKanRq?=
 =?utf-8?B?VjVHcXhTYTNrdHppQzJFQktEUnlHVk5NY0JTSTBva2N0SEtpaW5Kb3g5U0Fu?=
 =?utf-8?B?bjljZEZYMUg0YnNFNnpnMUJxTVBiWkRobWZWeDFCRzBPb0Z6aTVMblNzT09W?=
 =?utf-8?B?bUIvQ2E3YWVLTG84NVZ3TjVVUmtyUE1OSmU4S2tjOGR3cTVzQjBkSE1LWVlQ?=
 =?utf-8?B?S0ZtYnZtWFRGT0UvblRmd0NRMFRqV3FsWXBVZmhhOHBqU3RUUFg4R0NUVk5X?=
 =?utf-8?B?R1VpU3FtQ1pQaG1wTHhLNWw4VHBPVUhLeFdLd0JKK3Bzd1lUSDM1WGdURHFD?=
 =?utf-8?B?cXVaeVRkTklsNVdzSFNpejN5cVE1eWZXRmVjVy9HamlrSTBsUHVLcktyT1l0?=
 =?utf-8?B?MWp3VFREbE85aGxSaFJlSW5sczdGNVo5NTkrajJWQ2VZeHRibElaeHd3bzUx?=
 =?utf-8?B?Y3NrNEZCOENMUjJleE5xTUwycms0K0QvODd3ajZIMDd5YkF6NEZUdTRHaElM?=
 =?utf-8?B?dWF0dFg3dU5sNStubE1oeEc4cFhkS1pWOTk4WVc4cXpqRE9aTVI4OXo3ZWxv?=
 =?utf-8?B?VE1vKzMySFhjbGU5NVlWYTFVY2FzZkt1dWVhUW5RQmhEZkpodVVxN2RFQktX?=
 =?utf-8?B?WnhTcTI1T2QvZjlwODV6djBMZHovMVFKSC9RRkJFYXlySjhTcUE0UFE5MjZC?=
 =?utf-8?B?WjUzMG9jemQwUU5seFN1WitZR3lMd1pjd0pmN0NGbDRodE0yanpvU3RHRXVU?=
 =?utf-8?B?OVZTd0hvQXE4Zlc2em1ONmQrK2N3V2dVWExDS3dZRVd2dmlLTkJZbVY3OHpQ?=
 =?utf-8?B?TkdvdlYxMnhqWWlvc3lXTjQ0SDh6SXdVRDNWRVozQUN4RG9lVkRRa0dhMjlk?=
 =?utf-8?B?a1h3VEtlQ3RlUHBBek5CUTh5REZQcGRvcVE1SEJ4WHB6dFJTcWU4NmpqMkxC?=
 =?utf-8?B?V0xpOU1YVDNMM3hmUGZ3SllXYUtrbU1pdTVvOVprVXMrQTNqajJBdEpYT0ts?=
 =?utf-8?B?TUVyN0Jna3N3WDFKQTVHZDlrOVZycUY5WHN1QzdnYUNQZmhCMm5QdGFIcmxi?=
 =?utf-8?B?VXhHTnEzaXVzVk5Nekg2U2wxQmlJV3VYK3dDcDlmRFdyeUlUcWhlS3FIeGpr?=
 =?utf-8?B?clN3QW9hUUlRS2tsN2xDTXdCYWx0MC80RGpMREQ2UlJLbVJQcVQrNXRtU25I?=
 =?utf-8?B?UHo1ajZKc1Rvdm1ocVJidENGM2hsaEs0cWRvQXRqT2ZYVE5aamlpcWw5dDZO?=
 =?utf-8?B?NzU5NTFTQlA3ZHp2RTJuT1Mxbmk2RFhGVjEyNVhSc0JwZ2sxanlKbXRacDU1?=
 =?utf-8?B?M0hVYVVuc0RxbXpNQ1AvR1JRYWowRTdUTm55Z3JMckFpNzEvVW5JcjAxeWw3?=
 =?utf-8?B?WnhvQUd4ZkQ4VDB0dTZ5RGVZOWVJSVB0QjNHQURmWllxRmpwZTZpMEVVVldJ?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a85fdfec-ec4d-4123-a130-08db86e02df6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 16:09:20.6722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sFWOD7FiqoSLtxMZ2BTeT8FhDbOwKNOH31u1wMCJh9tDH16mJzCz/qxRc+IlQqWbubMJqkjT7JUbYs2dk7qcc2HxQdGQU6LthXj/yc5LeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7153
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/17/2023 6:05 AM, Ilpo Järvinen wrote:
> On Fri, 14 Jul 2023, Reinette Chatre wrote:
>> * add check in get_llc_perf() that it does not attempt ioctl()
>>   on "fd_lm == -1" (later addition would be error checking of
>>   the ioctl())
> 
> The other two things suggested seem unnecessary and I've not implemented 
> them, I don't thinkg fd_lm can be -1 at ioctl(). Given this code is going 
> to be replaced soonish, putting any extra "safety" effort into it now 
> seems waste of time.

Yes, this suggestion was indeed to make the code more robust. I
certainly do not want to waste your time. Please keep in mind 
when you respond that I do not have insight into the reworks
you are still planning. 

Reinette
 
