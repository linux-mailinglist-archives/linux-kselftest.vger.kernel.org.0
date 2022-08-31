Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA915A8522
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 20:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiHaSLq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 14:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiHaSLO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 14:11:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F79EB851;
        Wed, 31 Aug 2022 11:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661969453; x=1693505453;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H1kiPcFJb9VTWIciFL3vtnmK8MGM25mSI2QG1vOzgJg=;
  b=I7poFhQd6ilIm1OwEfKm91yUzz3NtfMGskBbLKPwP832QSHEqe9ozYWN
   N0fiLIdV10XwD4tFxXzJC8BGnw+qCg8LTWLGfizke+G58M0ShzwJGq2jX
   +KCffHrrcnjJwhagXGXgBAJ1X36R/Tf/TTfXQr7TV1SvCR7QOE1lrP9rw
   7sSuZavPw6gvK3wwhUWgzAuqSfLCXN0s16/FOxSq6fMe3NsmT2AtJRVik
   iDwvU4+GfXS2W6O9GmVBdYwni1v1RARZ9qvuNYh3XS9K3oehNJinC5io/
   B1A9WpHQw6Ml80iEhKP243beAYM+kPLUgfmj6e4G/Jrnxnqp7wwy3tyzf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="381807617"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="381807617"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 11:09:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="754504531"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 31 Aug 2022 11:09:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 11:09:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 11:09:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 31 Aug 2022 11:09:07 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 31 Aug 2022 11:09:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3t/aDzMzHwouI9Tn6WLk5YWNWCQY+/I16uqK+Rf3WpT8g3kkVzFh/D0JTbFgF/PD1Aguihzl3PfHA/rmah1rfxujVYl2ScO4xTmjZYs5zB9rUhLkYeo1tXeF2oyOIpcsSxE4GQvYiR5jMQOlPuIKvN/uZ7wdsvGn6VfKgtG1yiGjGdNHe88pt9JZLV1sfsO/RWLim+uTxfJkHAjBghQ/d52D5vOd+3eKjMZBbK9B3it6+vXQoFU4K1kmQL7+8aonat3bApxBUG14f7VAUNgXWLYL7SgkaEjCEpqF/0P5/mMCfq6RqKOfdvuintweOBKcaBVacX0Tcdf0W+m2oTL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTpAJ489PMDq1+xi4hvjMpFjO+RvMxhV+Dhxw2+ZbzU=;
 b=hYALTQ4VayW8KJU31QVvlTwKy+1IXTXc64WzadMUr2gFJJ5cm2lT6glAVHBOHyTm7Vj0aJ2Y/FP9paD3gSqGCQl3LmnMguOQviX+ywllLwQFThuNTgfX5IQaptqhRaFDnIBO+/vm8sbCTRmhXxdNtvf2qoSnZIWP6o+a6ex1PB4S6D9cm7z0JKa7gjcNQlruh3NOsJ4MXsElV/dViRaaCEiydWCATttb9Tyx9deQbMjcx2wBt6CZqevWEFw7GoT0K0yxluhX4Zxp7LSXjqOBzJ+rzjVMLNu8gGBHXKot8x7UydgChriJJFIfR7mKB4WE8IZ/AEMhNJw46eRp+9S7LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB3146.namprd11.prod.outlook.com (2603:10b6:5:67::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 18:09:04 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 18:09:04 +0000
Message-ID: <7c85f675-db1a-eb5c-2575-759d662a0ecd@intel.com>
Date:   Wed, 31 Aug 2022 11:09:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH 4/6] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <linux-sgx@vger.kernel.org>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-5-jarkko@kernel.org>
 <bd5285dd-d6dd-8a46-fca9-728db5e2f369@intel.com>
 <Yw7HOIfnaO0IcDiX@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yw7HOIfnaO0IcDiX@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:a03:80::44) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6f8099c-bc7d-492e-6d8c-08da8b7be3c7
X-MS-TrafficTypeDiagnostic: DM6PR11MB3146:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0v0vwAarlYM/qwRbRYVpsp7vfUQTZThYFSh/1bpcItUfnO5fv+LG5tvUyPMgUVNHFhQqv+Sm/vYfxWChJ/0LNcyM7IvkWdMQRhm3Fxbh4VjobbcSElqhYJzGa6fwLwSItS8sCMt8k3Osku/TJ5O3lXwgWoVbEIrIf1dmqR58tys8WVeJx29SKYpEPFU/ADiwTjQD+ZevRYF2jDnJyoeSbjneWk2TK8o5x/QIaZmfPw0M76NAP7gYu8S/78QJburyZz9hYBfB6GNRAjf+iz5A/uHuyARHnPAppzj/5wPnvaTElS/xA3y6OZEusGTUa5WwKnxk62PD67CTI2eS9NXIQLkyF4oZpjlO6MlifCUBLU91sJmwcteupIaMJzrVq11BTT3wM0GL2yEzu8L16Aaudz8wqFpRQes/wfKXEVCqY0nxwJA1O1p4XjZH9QxP7tJCfaOq5fGBEddnyC4LmIRVE3TB85wfzaMHJqEHDW0gIK4gZQJ8JZC5E/1Hxt6lWfwQuVLJj2tqmbRrXt0yCkxG6NaaRCwaRhznHcX+AWVCPogVf1LQaeWrZWepMp6mVlHZQLfx5krHjlsY6mbPLP8qMaGfG3o+Y/tud2d9CEgfN8TAIGfaZj3d/KZOkeBtOmjKY2T/9kET+npUIFQjeKzno0287PsGkQXJgtRzvkw/UJigvgMbI3Of+eFsd/DPfWYGKbc0XAAuX1C6WIrCbe7svAJF6NlhTCffh7DuSSylT14vUYdWI10sC3GPHuEOfgKC+aI+DWcZ1Me2QsK0hwKC507b7xNdYErtqh65ayrAvr/380EwlPIYL9edIl5Y0ieeLy/UBY5gtmteP2eF8/9ENA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(366004)(376002)(39860400002)(8936002)(54906003)(41300700001)(6486002)(966005)(38100700002)(6916009)(44832011)(6506007)(31686004)(66946007)(66556008)(4326008)(8676002)(316002)(66476007)(36756003)(5660300002)(26005)(6512007)(2906002)(2616005)(53546011)(186003)(83380400001)(478600001)(86362001)(31696002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUFRUWVNSStod3JsMk42dVhiVGQ4S2owbityWE1pVzJWejBmbGpTS3hmU2Nr?=
 =?utf-8?B?K2dxZ3BIWjZ6NjBSVU53WlpBVjhBNFZWNzQ3LzJuUnRWb2pBck45ZnM2blZR?=
 =?utf-8?B?Yk9yMVRZS3JPM1BRb2FDazFMQkE2eFgvemU2Q0EzOHdnU2FXL0IrN2JIcW9t?=
 =?utf-8?B?LzFYZ2Z5blY1NTJXMjJ6M09HN2ZhVjg1aDM2MmxsMm91SmRhMHAwUTkxZC9w?=
 =?utf-8?B?QUVxM2I0TS9jb01oNTE2eUZtbmRLVEgwNUwwZ1d0ZytzcmZWUEZwUC9vZzU5?=
 =?utf-8?B?QlEvYWtiWTVvaDkweE9rUG5vd2ZRcnlmMGJDandlRmt1SGt1RHNwZk9PdEV5?=
 =?utf-8?B?OGhwS0wvQ2lSa0l1bUZRcnI3c0oxaUtwcHhwbTQrYVptaXY3YkxRamVTVU1j?=
 =?utf-8?B?TEhYMXMvM05TYVlsTDFTanUzWTFvMXB6Q3AzQllVMGw3cjkrN3pPeU9zdFBW?=
 =?utf-8?B?R3pzNFhqUk5JOEpxZDk4RUZvcENSRGE2bzQreHdjcEcwengrRkNRNWx0QUJU?=
 =?utf-8?B?dTY3S21PTHRQNDFUeDVwOTMxSUNxR21DenRkWkl1TDV5Uk9YTUt2OGhKM21y?=
 =?utf-8?B?ODFsN0M4Y3VwWWl1WFZmOE1kanVSKzlnendmOWJTdUl0MkhoWUg5Y2NqTUtH?=
 =?utf-8?B?S3pqaFlXUThSVXpyQXZzd3NGVHlFV3JVaW9ZUlJSK3lSbFRiQnpqeVF3TTZu?=
 =?utf-8?B?cWJRSk1OMyt3WWJZUzN0N1Fkd1plRnlLcGEvd01QeGpXMThQQ3A4TXprTXJZ?=
 =?utf-8?B?cWxhMWFYZy9GSzNCK1I0Q1ZvNWNXT3ZmaXk3SkExQTdKd3JIc0ZKallLRkp3?=
 =?utf-8?B?ZTZGdHZ3alljWXhrdFQyZW9NWUF4cC9HMWI2am5pVk5kV20xUHBLWG1RSENm?=
 =?utf-8?B?ZjEzUTROazhVMEZIVW04dlZLYWZCQlZraExhUDFKSy9pQXRuMUMrNTZWQ3ln?=
 =?utf-8?B?QmM0aU02MW9aMFpQUVBYS2REVXVUZ0JIRTFXNHY0TEY0U2hheVhOUXcvYzU1?=
 =?utf-8?B?MWs1NVZieGVUdmN2MU9BR0hYdm5pUTFZVjZvZHFNbEdlNlhYK3NwKzJKdUlY?=
 =?utf-8?B?d3U0UWNreFVzWWlWemU1S0IxaWxPbzdRNlFqbkFYOWdvdDIxSGpvdWVvbGkw?=
 =?utf-8?B?b29JZnF4MXBrZHJHbEd3QjNxMm9MR25ZUy9RdFA5M3hCSzArQ0Vhanl0MWV5?=
 =?utf-8?B?TkE0alkvZER3ZldER2JPSUQzS01mTmRONUw3Q25hb3V1QWZ2UTBUemxGVnZ3?=
 =?utf-8?B?dStNZU50aEF6RUNCYVlqK1lqdmpVVFJRMk0wRit5d1FSWklBaWNlQU9zSlNt?=
 =?utf-8?B?MVpTMTMybXRiTXRBb3Q3Umh3Q25lUUpETmdBeWt4L3BqRWVreEZlUXV0Q0hp?=
 =?utf-8?B?L1VRekFhTVpRb2NEdU9UWXRXZkd6emM5UWEyaXdKbzRqSndDMFpWaCtORVNu?=
 =?utf-8?B?OTA3SnEwVVZVT3BSL3RVcDdyNnU2QjM4TnNFOCtDQWRwZVlOS3QzdEdKcEVu?=
 =?utf-8?B?cURHUm1MNUlkekc0RjcwWXZkWEkrTStNVEZrWmhkWi9rTHJGaDgxMVA3RE9M?=
 =?utf-8?B?SWFXbmcwYTAvNi9EcnZITTJMcTNDaXJRUStJU3duWUgrSGlzM0U3YjBpUUtE?=
 =?utf-8?B?QUMvNGlsOC8vb3NmS1hBMGNnQklXREdWdXdvdG1ldTFJdElSb21POFIrekZi?=
 =?utf-8?B?VGJJQmVTUzBwc09nVGkvRllQbzhKZDdKMU8zL2JzeG5XazhBYitmVFlhSTNn?=
 =?utf-8?B?TlVsekJsSDE5TW5ISXZEMXgxTGJISWhEL2hHb1kwSFN4YlJ5TTJ2NFl6ejBa?=
 =?utf-8?B?UDZlTk5GWUxsRmlGZEwrNnZ3SjRoWnc3Y0VackRXR3BvYkFkODkxSVpzVjAx?=
 =?utf-8?B?VUFRcmRpeDhpNW44Y2YyMFFFM21IR0NXMCtYY2ZMNm9DNGxWVnpja3REMzUy?=
 =?utf-8?B?ci8xdmN2djh2ZFhZblk4U091YnFRSUdpbmIweXVRK2RqdS9NOXVPbG0rU0lM?=
 =?utf-8?B?OEpRNWRIUSt6SkhycU5LRnJKY0lZamJoRTUySEkvbVVjR3ljdHBucGFkTzRF?=
 =?utf-8?B?OWY3UTMxVEFuVzIxb1c5YnNtZVZlQmQydGNERlEyVTM5a0NYS21FRHNsN3FD?=
 =?utf-8?B?REhkczdjMW5IRERIdHp2bkFNeUZuSW5WOG9GbXRxc3hrSFdpUThCTG9HL2Q5?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f8099c-bc7d-492e-6d8c-08da8b7be3c7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 18:09:04.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShMc2TqLCQCSJqEW65wjvtj5BgjQ509VXUXssb0LWDpBS38QHVXXaYjsRHNYMrIV7GhAdKObYqkv+d+xdtjcI9KNyRbDP9ebvUiS7fbiv9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3146
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 8/30/2022 7:28 PM, Jarkko Sakkinen wrote:
> On Tue, Aug 30, 2022 at 03:55:47PM -0700, Reinette Chatre wrote:
>> On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
>>> From: Vijay Dhanraj <vijay.dhanraj@intel.com>
>>>
>>> Add a new test case which is same as augment_via_eaccept but adds a
>>> larger number of EPC pages to stress test EAUG via EACCEPT.
>>>
>>> Signed-off-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
>>> Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>>> ---
>>> v2:
>>> - Addressed Reinette's feedback:
>>>   https://lore.kernel.org/linux-sgx/24bd8e42-ff4e-0090-d9e1-cd81e4807f21@intel.com/
>>> ---
>>>  tools/testing/selftests/sgx/load.c      |   5 +-
>>>  tools/testing/selftests/sgx/main.c      | 141 +++++++++++++++++++++---
>>>  tools/testing/selftests/sgx/main.h      |   3 +-
>>>  tools/testing/selftests/sgx/sigstruct.c |   2 +-
>>>  4 files changed, 129 insertions(+), 22 deletions(-)
>>
>> There seems to be at least three patches merged into one here:
>> 1) Update SGX selftests to create enclaves with provided size dedicated
>>    to EDMM (this change causes a lot of noise and distracts from the test
>>    addition).
>> 2) The mrenclave_ecreate() fix (which is still incomplete).
>> 3) The actual test addition.
> 
> I would agree on this on a kernel patch but not for kselftest patch. It
> does not really give useful value here. This adds a test and that is a
> good enough granularity in my opinion, unless some major architecture
> work is required as precursory. It is not the case here.

I must say that for many good reasons this goes against one of the
fundamental rules of kernel patches: separate logical changes into
separate patches. This is your domain though so of course the work
within it follows your guidance and I will not pursue it further.

> 
>>> diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
>>> index 94bdeac1cf04..7de1b15c90b1 100644
>>> --- a/tools/testing/selftests/sgx/load.c
>>> +++ b/tools/testing/selftests/sgx/load.c
>>> @@ -171,7 +171,8 @@ uint64_t encl_get_entry(struct encl *encl, const char *symbol)
>>>  	return 0;
>>>  }
>>>  
>>> -bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
>>> +bool encl_load(const char *path, struct encl *encl, unsigned long heap_size,
>>> +			   unsigned long edmm_size)
>>>  {
>>
>> checkpatch.pl informs about alignment issues above and also a few other places.
> 
> Weird. I did run checkpatch through these. Will revisit.

I usually run checkpatch.pl with "--strict".

Reinette
