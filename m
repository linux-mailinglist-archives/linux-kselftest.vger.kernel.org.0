Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057A75A852B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 20:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiHaSNJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 14:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiHaSMr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 14:12:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16718EEC6E;
        Wed, 31 Aug 2022 11:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661969508; x=1693505508;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JZA70Jyel4ec6G9aPGUJAeTjYv6z9cKE1sYtbuWa5NA=;
  b=QxyhDk/V6VPIWfXZYU0HxImg7lcwX1pqUSJ/KCxK/xMfiVlGbabEc8ny
   aHvYLLZHHuWMFzRehDboIS2npiwuFpSm9k9wZJNndK3w5Lf2yyJiWGmmF
   NuNfIi3vANPd0u2AmF3ljAVhJPV91xPK7mNpous8RW3nL5TCu3QyHEduF
   C67BB5pjuaac/VyBCAgX506T17K8L715SAzmss/fjrmk1DwEPs/4U4Dhc
   w3blXJ7heRyt4sIl+L31zqjkF3+LldiBLX7fgJhvOwyJFhBCh8X5DaFvY
   9H1Xq72Tr3pkUZMNuGh3gwvgJikkgwlBXrmmq++jtaq575NFi10fFuF6W
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="321652859"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="321652859"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 11:10:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="563126092"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 31 Aug 2022 11:10:27 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 11:10:25 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 11:10:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 31 Aug 2022 11:10:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 31 Aug 2022 11:10:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMaPDjbKVP5v0KYyy5+EmmZrq7K2dsa2P7p8DOD0rcHvVnKAWEIJS4Cq/VyQ6Jf7NdOgAUInPsY2VkDcYcvlDDbWEpjGfDok8gfza8Ysggl8BODSs3/ipk4QXqyxUvIG9ik5B3YAV2/GNqRqsoq9YOSEVg2aHpzn1KKy0cefhdpvKrmGzfs6zSX6WIa8nfbJYof/eqgEZd9LpsLwfxycAtz6eU9gN1Dypj7UqGTBZry0J4fn3b1E3/OnrmYdyfqvGs6a4iOj3Jg/TQTz2ApSunHgP5eIGIZ7KULzEZKPdNvWdU7szv9IBJndhodlZHU4miBn7bdvNthhjUpuu79Z/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ELEiHf8husP/iSpAgfO6sjrglyVE/FkwEiK/TYDAQM=;
 b=E7M6xKgLvDAhUCtjGeUwI77wJb1PPDqdUKdUKlZVvaJNHg/jF0oWbtpr8IJPBwpgc2yq+d4LkLvSnd812uClrkKJ8ZMRLrt+55PYa4rLsduQ8Agng+hYnTCdPPzQrsaF2M2YDeTIov2ligdPHknAbAkgtzBUh7x2Vb5s4/EQyl43vwdrbe3vXMhGiW5tVs+akU8qPMUhorpR6/xvN12FAF4UQKtQWI3FtaUq5uKFBE7ELOu+OxHf90+3ISFs1DSPi9/ZwtXt3bJHvI0K9HWE9uDWUqZTnu0UzBcX9wRXunGlgZTee1vNUo00bfGnyXTHXl4HNJ1tutitb5c0EpwlfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB3146.namprd11.prod.outlook.com (2603:10b6:5:67::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 18:10:23 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 18:10:23 +0000
Message-ID: <218a5ae1-f74e-36e3-1137-c001d49126bb@intel.com>
Date:   Wed, 31 Aug 2022 11:10:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH 6/6] selftests/sgx: Add a bpftrace script for tracking
 allocation errors
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <linux-sgx@vger.kernel.org>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-7-jarkko@kernel.org>
 <64498c9f-a6e1-6379-ca8e-d751fb239bec@intel.com>
 <Yw7IZWHbHjdjMa/Y@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yw7IZWHbHjdjMa/Y@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0024.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::37) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3c2bcab-35bc-414b-5741-08da8b7c1276
X-MS-TrafficTypeDiagnostic: DM6PR11MB3146:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGW08CsYPaShqRqOIBJd73KFM9Bf8weUQP8kgtEX+fLdj4LN7/ZB67uotBBLHf2Yq/7YwKC1t+L1jrEoZFsS8mbBKTrLGGIMmjF8KdcZMGgcMvUtWb48QgszyybRnBSCyjuhV2zP24JxqVdTuvqOaJubjLfvmCwnj1gRg6EOOYu1HdLKXMAjOQV0qnihsZYYP7KncCAhXqhtOHMYa8bmVqsAfTZkd9nB/rK4YwwDQDWPdu2GnsYB76nB1HvJtWwv94zdWHYINvBSkKzmQTClMr3L2KT0qwgvW1SwtqsQ2HZDFIiJyYfCU5DjEFGzn4IU1H4ZGv+65JY/Vn6kXV2SP8mCCzNyRaThWvBpbA/7dMZlb4q0oMT2j1X52BQNHFoQDK8R9zcNbQ9wi2+FSG1cwbHaEQADG5M3sQomKFc8bYdQ8s8/X2z/BW8DqZo0QEEIL4Trf7TOuKClFbka7Z1KnnvgdkbdDoqBNUjO6Xr2yecxrGACwguB5MSW7OjEnv0FmEylNL+0M44skPdFWOpuC2uIoAA/ZuBl29ddiqxrNJdNaY+0OB9NxcuzsRpzFFl/zroDtarQF0iFcqWcOqO8xiwvryB12t4CD84/GRbtuaT1Ja7WgkouRs9RwdB+Jtyw9G5S9kbu4VkpMsmEfo6b64SVV6uE2YBo1pFyjGj4K67dw8AW57jx5EYcaHiN4pG7NmqMVxnZJkaGG5ip2G1yL/dpr6LTs5n2ZOViQEGB/wy3FOuZ6klkDOZ14OHrpJgf10sX6TC/H2QzqAeSOnYK3NNZKpdyCgsX5oRvBCIEvp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(366004)(376002)(39860400002)(8936002)(54906003)(41300700001)(6486002)(38100700002)(6916009)(44832011)(6506007)(31686004)(66946007)(66556008)(4326008)(8676002)(316002)(66476007)(36756003)(5660300002)(26005)(6512007)(2906002)(2616005)(53546011)(186003)(478600001)(86362001)(31696002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXRETlhlbm9NOUYxS2w4Ny8vTExMZm4xc0tzUExsM3FCOWZVZC9GUnZ4czVP?=
 =?utf-8?B?YldSY3d4dERwN1d1UnQ3Z0MvckVXWWZ5OS9xQUJueVZxd3RGY05xTU1ETU01?=
 =?utf-8?B?dHNQaUE5S2p6WWRya0dSY2ZMRjNadFB6c0t6N1czL1FKYmtjQVpiY3MxQ0FH?=
 =?utf-8?B?Ni9SVFc1OXo5K3FVa1NZZy8yWUJTWkd2R0I1ckVjVEtxMkFnWnpiU3luejd5?=
 =?utf-8?B?N1MwbzVuWlFvOU5ScVlBVGVaVGdGR09XVm1JeEwweE9PUTRKQitPRU05OFJ4?=
 =?utf-8?B?Sjc4cjZSMHNHVFVtc09SMEgvdk5DTmp4RDlIelNML3lLcXA4dGVtUE1VYzBj?=
 =?utf-8?B?UkkzVnRVQkRWdllsRkpHUm1YZUc1UWJpbUdDR1BBOTJlN3F2WE90MEVSMXo3?=
 =?utf-8?B?d245SHJYQzF4N3V3NWo4eW15dnJubnpqR0g3OVlBbDdQdTlnUU9uNk80NVpJ?=
 =?utf-8?B?SUgrTjA1bzdGQ2NacXN4Y1gyY0UrYjh2L0NtUGg2VnRWSG1GdzVKRGoza0hC?=
 =?utf-8?B?RHEyNTBvSXFhTFVuRU9iVjRoUEZHOUQ0dFJ1TVB5NytQMy9GVXR6bEtTZkRY?=
 =?utf-8?B?Zm9CRWJNeXNPeEsxZjAzNFVrSm5EajJoTEY5T2U1ZVNPUzFOTnZWWXMwSFdK?=
 =?utf-8?B?U2NGaHFEWWdVYmh2RTdrb2xObERGRDVkRWI3RWdWYm9iMFBSckVCQXFkZjdh?=
 =?utf-8?B?WW5WUkZidkt6clp0K1ZHZS9HVVB5MEUzdzZMamdvK0ZIejZTc09iUUg1UmVB?=
 =?utf-8?B?cFZTLzFCOGxVMkFoZkM3Y2JzUDBsZmdESHp4b0Q0a3FycWZPOE1hRHhMQTN0?=
 =?utf-8?B?WTF2MXpZQUN3czRPdmFySzVpWi9iMVp3SnYxaWhmNDg5SUpSTlRYOC9GNmFv?=
 =?utf-8?B?NXFtVVhPaE9aNlF4K1d5UHVLTXlBYkZLL3I4cUxVY3Q2OXZkZ0lHZ2tYZmIx?=
 =?utf-8?B?ZDNnNWdad2xocytBNlBTTjRFQkVEV3o0bVhFMThMdlVySnZneW5nYnFkRFl0?=
 =?utf-8?B?R2Ixd3h4dnNlSzhUcmw4VXJoczhzUEkwTDhoS2EvWWxFSS95QXhDVmwzcDJK?=
 =?utf-8?B?K01QakRhNk85cFFwTTczUTM0dzVYNWF0bXc4QmpNd0VzV25kN01ZanA1aUxZ?=
 =?utf-8?B?UjNwVzBrb05kb3pSNTVWMFN3ZHY1ditSY0s3clBpU05BdW15VlZYbm4ySy8x?=
 =?utf-8?B?dDZkVE9YSEREejI4OXlRVUJGZ1pyQnpSd01HNkE3c05WTmdwdCtTQytqTXZE?=
 =?utf-8?B?Y1RkTis4Y3hIcWFGR2NTQmlGRTlkR2JEZnA0SU9Vak9TZXFzOTBvOE44NlJr?=
 =?utf-8?B?YURxdTRqNWp5aVowZGJ0QTNOc1U4aHVwVFpXVkpDdW0zUzRacjVGaEV3RW5X?=
 =?utf-8?B?L3poMjRtN3VZL0tLUlpFSlpMQXBUbW4xcXNvZG1Db0wwQU0vV3c2dXE4R1VD?=
 =?utf-8?B?V2gvcFFyL3NMc3ZvS3JvL3JRSVFOUGVFSXhTeXVONUdSc0pJSSs3OUVpNjVK?=
 =?utf-8?B?cVlYZ1hhMmV0d0pEZEttS2Fmakg3UUlNSlZiR2IzMEdlVGtkM0k1bWFsbU83?=
 =?utf-8?B?Tkl2RVpYeVBGYTlGYkxxL2lqWlZpaVBnUFRuMzhaVmhPNVVRWUFwcWhBVytT?=
 =?utf-8?B?VWVZSHlOTkFrdWRWVDg3Q2t4NnlFdm15R0EwR3d2eWNZM0djUlQ4SmtGa3li?=
 =?utf-8?B?dFlweFd3UjhBQ3EyQkRQTDJ4cEFoR3VRNVQ1SFZ2Ny9mdEU5M0VQRWUvelNO?=
 =?utf-8?B?Vkg0bTJuVXBsWFhwY3NRZ2dLQjdlNmtNaGJMaGZ1RzloSmJXb0QwOUpzTTdR?=
 =?utf-8?B?SFBraERYL2R0R0NVUFkrTWtGdnlDVU1adEkyYUhYb1BwTWRzSm9YQmUrZGt4?=
 =?utf-8?B?SFkyQkxTNG45TFcyaEIxLzZhZEl3R1VzeDJxeVFQTFBjcUpNSERwL0QrdGtk?=
 =?utf-8?B?cTZiRUs1R1dzT2NxNnU2YzFvQWpCQzg5U1o0L084Z2xVKzVrb0VPbDJXMCt3?=
 =?utf-8?B?YkpBb0J6V0diWVBTUG1XTGtKWXpWaHkxMzNyZ3ZtSHU4Qmx4clNGZTVTVlFO?=
 =?utf-8?B?ZDlyckN6dXhqRVR3QWNHRGIyRlBscVZ2Rk1ReUdJbE5OcC9OZ2VpdndVR0NI?=
 =?utf-8?B?MGY2VHpFRVF0U3hTMFg5RmJEelNvSzZEZ0VKZjZhbythTUhRYjVRVzBQVmVm?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c2bcab-35bc-414b-5741-08da8b7c1276
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 18:10:22.9703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sA2/bmdWog/sgLafuGBal+84bdyYyn6UkDBGVNzGILa8b/TYhHnnURf+CX491TD8mrfZYA8pMZblZgByZbLbXmwqum8pJma+VklaLdiBE5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3146
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 8/30/2022 7:33 PM, Jarkko Sakkinen wrote:
> On Tue, Aug 30, 2022 at 03:57:24PM -0700, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>>> ---
>>>  tools/testing/selftests/sgx/alloc-error.bt | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>  create mode 100644 tools/testing/selftests/sgx/alloc-error.bt
>>>
>>> diff --git a/tools/testing/selftests/sgx/alloc-error.bt b/tools/testing/selftests/sgx/alloc-error.bt
>>> new file mode 100644
>>> index 000000000000..9268d50dea29
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/sgx/alloc-error.bt
>>> @@ -0,0 +1,7 @@
>>> +kr:sgx_alloc_epc_page /(uint64)retval >= (uint64)(-4095)/ {
>>> +		 printf("sgx_alloc_epc_page: retval=%d\n", (int64)retval);
>>> +}
>>> +
>>> +kr:sgx_encl_page_alloc /(uint64)retval >= (uint64)(-4095)/ {
>>> +		 printf("sgx_encl_page_alloc: retval=%d\n", (int64)retval);
>>> +}
>>
>>
>> Could there be a snippet of comments in this new file to guide users
>> on how to use this script?
> 
> Do not mean to be rude but I'm not sure what there is to guide but
> I'm open for ideas.

How about something like below in comments as part of the script:

"bpftrace script using kretprobe to trace returns of some key functions
 in support of tracking allocation errors."

This is essentially in the subject line of the patch but that information
will be lost when somebody looks at the script and tries to figure
out what it is.

Reinette
