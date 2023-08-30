Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A91B78D173
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 02:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbjH3Axp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 20:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241506AbjH3AxY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 20:53:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF87CDB;
        Tue, 29 Aug 2023 17:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693356800; x=1724892800;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xZlZWhX1C6EBDaBTfvS1jA9nujJwaZRDckmRh75M3t4=;
  b=iSAV518Zt6St5a9hsB+LXWXqnSTzlJBw7ncIsRljnfwJMwNLIv2GZs34
   YbuqEBk94yVjneUGp637wTsKqcGzXvjOw2rYcKnGeCP/a25muduCiwkqK
   dsm8sZJQ+91qxbmi7RKaiqysJwQPg6R4ENr5JQN9G1QMeOxfTMOSaS+yn
   6SGg7+JgBOFvsI0HHh6Wp8mHXtJ1YJWyeM9y02BvLY7CmsJ8IlAqzwSzd
   CDgGSfRKhbkGg+1Uu442zkcDgHCk9K0VL/i0si9rekqeegIeJYJB1TdxZ
   wPuXOyp/RAdooAOV/NDZiNtg5vUVdl6sqUz9vcCxcwHJ9YMJSMyqjLgdG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="360517190"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="360517190"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 17:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="808902117"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="808902117"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2023 17:53:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 17:53:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 17:53:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 17:53:14 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 17:53:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpDVHc6YGf05zUJPPxh8Xdoc8ku2ij1yMWH5o0u9gBQiO7XAixWZOumPIRCTm/2PIqGAwJTys/rq8bG+TElg6Osbb8L+eMce1vOMjHBT6z9N/9OH74HJDi0TLZl9JExe+JeW9WiMDbtYuYkBmL/OHZMFI0IgUpJMpjPBtwHmhKu+FjRsj4c0RKsVh9ZUr+zV6OvuACq7XmkvwgWEHgn9mU0v6zXkaE2EekUKqg6jeGtxgxHWg75cERqiEj5xyO3IIaLuLiEv0V11PqeQHQ7VsSuf6Ru1Fs1GagPiZlulYQ94h6UCaHYNzw70h4rqFnW/DrzYGyW9jPpQNySx7q6Kzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnVsO16MEuIlSzSJxFY4goCmQbNOBgoLxd6OUiJXuLo=;
 b=WkH2pa4/nB/s8kaMr99atkdvP2HWgTfLmEmQDweIgVSWCkWZMLI7poSiIieUVx99mbYfQhFVVPP3cewRDkKhPWRfiPFku+EXT3PEHhDalN89M0x2CIn+hwK04ZDim3nmO2QP3zu91tKAKnHNIB77C/7NggzA6hJRP27KcreDlqsWMBxFZmmpB1CigTYOzSRYcUzYLaIsRJ4tLYaGByKtYN+JRbjmqVosiTmOg7ctZORziOJNOxQI8d1uHI4vNj4xZ5kbLB4HfrjzVvtXz0B29ibAIv/fRK1BWhvei9pi/KyBK5+HfoA3bs8S1iqzuCSfXOfSEXCqLrRmAJHb5J7alg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB8224.namprd11.prod.outlook.com (2603:10b6:208:44f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 00:53:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 00:53:10 +0000
Message-ID: <4001d608-c31f-42db-f90f-bcfbc1b95ec0@intel.com>
Date:   Tue, 29 Aug 2023 17:53:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/7] selftests/resctrl: Correct benchmark command help
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230823131556.27617-1-ilpo.jarvinen@linux.intel.com>
 <20230823131556.27617-3-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230823131556.27617-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWH0EPF00056D0D.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: d37ae1db-556e-4d8a-cb8e-08dba8f37b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNq4TrkM47CFtFZ2S5fz9hXY4cevS/7hlbTkiFjtsrc7hKDsGkbGZMAz0c/fCyI3+wIQeLvQnadXZsNeTTssrIlf7dKrHlE4oGSRSj5X4QjJoylSuWvdg/jKcvsvMbfnyovPc90TU7fCw8rPJywZaJLU/1mkPZZy6HbDUYe05s2jI88F5laWIWKpEmgGi8rt6DvoDKS4Icf3lgzyKIv9zk8kX8ZVB5gJH299SMjxhM8tsI5UKSvolyd9r73tw5al0CdaAxLmNgQNh4rIzlV28vtbes4fcbyAmMphKTg5rNY/qAn+1LHFlBL7cGOYGxZ03ar/yZNd82JbQA7q0BFcB7nA4hEYCsnRp0+5af3rU+BjhkJjPGv4p3X6aSam0Kyw8FZdHi6duyaWVve7l5EIrAHh/1Lbe3gy5UqgifJS3MN0HA5RlNPQwybbGXzCnkJDlXkGcgp1QiwnK3+SnQSBhOMBA+XTeYi1gKrL45C9tUFMblfIm/SZgjP3K2AbLikosdn8bDbz01R3lFBGK0oC5+KgIMUyLaqwxQAPNo2xNWOfb2qlmSYzFrduKQtoyuMW3k1Z06JeRAACyafqXSij1E0PZZzAU2PgSZ/tAQImV6GrOc8viUJ+JIcyb604uHSy6NW6x1CR/VGcTdVIb3lh8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(186009)(451199024)(1800799009)(2616005)(6486002)(6512007)(86362001)(82960400001)(6666004)(38100700002)(6506007)(110136005)(53546011)(31696002)(478600001)(83380400001)(26005)(66946007)(36756003)(4326008)(8676002)(8936002)(5660300002)(44832011)(6636002)(316002)(66556008)(54906003)(66476007)(41300700001)(4744005)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmZ2aDk2RVJsdS9Jb2o1YmQ5R0tMcGxZU3FvdDV0UHl2YWFObXM0SWl1QzN2?=
 =?utf-8?B?cFlrMjBMSlBuNkJmSE84ZWxTWkZOa0tqNDhSaGNWRUJoWHFPTW51d2ZLR3Zq?=
 =?utf-8?B?ZktDbmg0UkdNUno4TFBwZkg2MWRpOXAwRTRYbXJWN2Z1OThSeTdkVTBQbzBx?=
 =?utf-8?B?MzVYc0FhMnJFa0VPek03VkVCbkpKcEZIVTdWbHZoTXdLVi9zbDZJWDJXWHdG?=
 =?utf-8?B?TElUUFlDdEpTV2NHK2FKVURmMDAvUXZzaURGNmxieFJvZVZlTHRvTnBqT3dZ?=
 =?utf-8?B?bHg5eEpRbk5rVnBBdHpzeW5RcTB5VW84VHd0UldyazhacjFNSEdKOGw5UlRL?=
 =?utf-8?B?bkRwOEhzaERBanBTcGZtaTZZV2dMcTU0ZCtBWG1wcUcrYzJsUnpFVWlVMVpN?=
 =?utf-8?B?d2dFa1lsdjhyMUdSY2pTcForUUdHNlpCR2t5NnljMndEd0NGem5PTm1ua0ha?=
 =?utf-8?B?K3hZTmZXSmsySVNkVXRDelR0cGlMUjZsQXZjbVlkZytCWmprUm9SNW8zUERn?=
 =?utf-8?B?TXlCRXhBcmVoVEEydksrTzQrc1VycHdnOHVwNnk3YzA1YTRzTG9xZnV3UStQ?=
 =?utf-8?B?cWVzKzBKankzWWFLM2JIV3lUYzZ5MmRuNHg4Z21MWktrYWcxOWJqT3EwaTBZ?=
 =?utf-8?B?aEVzVHVSQlUzV3JwREVTUlBHYm4wUXRiY2FTZjhxSFE2ZGlGb1pQNENoQkl6?=
 =?utf-8?B?enVocHRjRm8vdHR3VFdiWnZPK0pVMzN3OE4xOVc3amxYNUlMVUEwOUtRUy9D?=
 =?utf-8?B?cHp5ZHAwNlZBNFMyTFgvTHhpUWVwc25tUWZJdkVPcnpMR2hlejJheTV1VDkw?=
 =?utf-8?B?MFk4NjNxVW56enNubmE4UXZnUHFhbUVXcmNoZ1o1N0ludDNnSmVnLytIeHVM?=
 =?utf-8?B?U2dSNWVGNDVMRXBreWdRR2xxelkxS3M0M2JsZjhqVVhqSy9hZmZqOHc2SC9L?=
 =?utf-8?B?N2YveHl5eEJ4SlIyZkhNcE1xZlhtZFFDcFI2WHlGckRMci9RUmFIL0g5eDlI?=
 =?utf-8?B?OGFxWEQyYWxjSHpDMlFiYUx5Ukx4Z0xqR3hFV1lhT2EyMVlYRVRFL0cxUTlv?=
 =?utf-8?B?SlB3RVl0b25CV3pKM0Z1cXFwMFVaWi9NOHFESVozMEErcjlJMTJhQ0J3aXZa?=
 =?utf-8?B?eElaaE1qNEpUWWowUjNFZkJ2SS9rZHNtc1NPNzBVV1hkWGxGRGNITkVtVHA0?=
 =?utf-8?B?blBLZ2NFOFhHRk1MbHpGajZmdTVFSVp2R1VXblR0NEY0dnJHTUxPcmxaU3BG?=
 =?utf-8?B?aWs5ckJUQXM1ZSsyaWVndzBzMmNROElRdWlOdFV1SHlTckVvZXloL3dJY2xX?=
 =?utf-8?B?cmhQbStJSDlXU3RLN3VPS3AvcnVGWTMwM2tydG9iN05lWEZoTmRnSWdUcFZG?=
 =?utf-8?B?UnJIYTJhTG9STXYrNlF6aSsvNURPTUhBOGZEOUNzTjVDTEsxSDB4M3UxbkN6?=
 =?utf-8?B?UXJwSm1nbjFZalVlbUdFdVBtSzVUaExTNEhwZm5Mcm1ITE9rY0V0RW9jZDRh?=
 =?utf-8?B?UWwyZDBGUjVCemxQMDJleXBNdnpCaHlkREVGU0NoNVI4SlB4SXM5b0w4dnVO?=
 =?utf-8?B?VVBkbnVLa0hXUE5qNzV0L0xRNmZKSC9qYkh2ZWdaK2V1T1RBakdCampiV2ZJ?=
 =?utf-8?B?QW5uRUJVejZOMEdtdUhpaXhrcFI3UkRTa1YxbGw2OUJwM3FsaTF1Z2lCLy96?=
 =?utf-8?B?V0ovRThzblN6ckR0VDRlSTJYdkovTjZwZW9EVHZ1amZQd3Qxd0Y3Y0ozbGkv?=
 =?utf-8?B?dE9uNTUrb01zUjU4dlF6RXJFNENHcXplSGp3NnFaOXdtTmRoQnZ4OEh3WVNE?=
 =?utf-8?B?d2tyWDVPMko5NlhpU1lZeTJtZlNJc0w1Zlg1SmdldFczQWVTNmw5MWh0bHNt?=
 =?utf-8?B?TVlxQlRXbXdETHpCN2JZdGVVVjRtMHlieFZGOTRvTEpwZ0ZYa3RqQVdRUjh1?=
 =?utf-8?B?bXMwcW9tQ0RRQ1kvRmZveGNnS01Md0dtdTNLRmNJK2ExWHFFUEdzZkZueTh0?=
 =?utf-8?B?VXhBQkh2UTN6SEVzdWRjUFBvcEkxOG9vaHZpcjhxc2tPbitTRjN6STQraE5X?=
 =?utf-8?B?eDhiZm5JS2V2TVJQRGhrVHhWZUtjSlQrZkxGaUpIMUFoQlFFbVdIcGxSQk5P?=
 =?utf-8?B?K2pJS2drbUQ3R1oxSkgwZ3hSVmZJTnEyc3hvYXV5UFo4djZJNmVTQXhQNkVa?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d37ae1db-556e-4d8a-cb8e-08dba8f37b93
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 00:53:10.8782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HCtTkbRxOT+Wt5ec2v40Gjqzg6sxam/HW1KkvztbuzsAwUAUbuFkMDz1Bol426nRk4fa+hR7zc6PIkFHxbR/qG7ekyJHBaunzZ2wGtrQTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8224
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 8/23/2023 6:15 AM, Ilpo Järvinen wrote:
> Benchmark command must be the last argument because it consumes all the
> remaining arguments but help misleadingly shows it as the first
> argument. The benchmark command is also shown in quotes but it does not
> match with the code.
> 
> Correct -b argument place in the help message and remove the quotes.
> Tweak also how the options are presented by using ... notation.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
