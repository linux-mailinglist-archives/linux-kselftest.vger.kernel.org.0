Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8F05A712F
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiH3W4A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiH3Wzz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:55:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B69077E8E;
        Tue, 30 Aug 2022 15:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661900153; x=1693436153;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RSXyZfvz/Cq4SsMyB306rCbtB7hvX2lWXNIsL/Gz31Q=;
  b=YbOlbmtN8pktUKnPswSrHv6P+2qn+uz97Y1QokxoQxrBiEI5wcAQG6tW
   EVe4BgOI86OJVsH2r9kIGmLW/N/3rKk2id+n57IDFgv6XSOE7Z6OYvzsD
   5/VAOhRyIQ0UGa8SQH9qIFPG3WkNYhChAWArt/QtFazIUrbkSrw+s3jZp
   pJw8IB4OXI4SCdeJjn9Mr/eFAGtLpyd8HFJMGoRJ1LLovmN6csEqVBJo3
   nLAoaCD3VedrW+peUTVkGdwt6ggHHk//xoB6mqWx4Qdlj4FRInA4rme81
   sPKdwajLSRktmlZpmRSz+gOzDwSb3vrV3sNSIuT5Oql+gdrgolgds99Od
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="357041852"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="357041852"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 15:55:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="562839000"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 15:55:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 15:55:52 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 15:55:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 30 Aug 2022 15:55:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 30 Aug 2022 15:55:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flLvHk4vZvl+qo0GrogMiQ8gfZAB9ivnAn6qzkfUbWx+GheYm3KNHArGYish4gQB3zN62SQo6+GxASwGY1LIYp4UYO/GkKT/QVwL2Ge/gXePF/p6n6BcGqCAjzCLLjUbbVR8Kwzm0atWqdFW2VFxhQV09Pl1/GfXTlSBxtSujUGBDhHHX2dx7wNob2F7nhg1DXXnbyNI4aehM3BcoqgbZEQqE0tz9dSy4eJrpBPzSbnJ143A0Cdsl4XCHa9vqOY2V1zbMAPmCR3+hyk/Jznw3PraQ5apG3ihOaSLPrtCVA0ho2ydvk0UUPcWUcFlxerZpLrHYhQ6x+S5sKrCKzbHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HUKO8nF+hkMqLM5WirO0J8T5GPYMOm+SWh8hhwwlD4=;
 b=SEWHsZqsj/jZCX86u5p2yDU1WQ4lw0QE+9O4J7MByKYcOctSJHNxwfpui5q2hLJ1x96o918MaqbYTKCh8J3+AKpGMUsAT/4xPyri/yffgLv7HGDiboqM9KteObmcN4wfjkyLStzt/3gL+wnLspuzdK9mClxaPQMKySy5crM7nWEKetdCVlIQ3amm53N77rEPclDekKNQNnvaAy0saFmoqA4FFMH6IWSrAXK1kLwD2Wb+HA3d5HkiUspIbiT+164cJ7fGzitJpEYViRbevg0CMbscadmcput/VYzyeRmVNXGLTchzsQ8K+dff9zNDIVeyo7m8foaShq6WeB2YNHDzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH7PR11MB6523.namprd11.prod.outlook.com (2603:10b6:510:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 22:55:49 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 22:55:49 +0000
Message-ID: <bd5285dd-d6dd-8a46-fca9-728db5e2f369@intel.com>
Date:   Tue, 30 Aug 2022 15:55:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH 4/6] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Shuah Khan" <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-5-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220830031206.13449-5-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:303:83::32) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e3afc89-e92a-46ec-0379-08da8adac851
X-MS-TrafficTypeDiagnostic: PH7PR11MB6523:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5JQDqOy8it5Ng5n26c1mKn4ddxNBtBD6UPRAmwi7eKyHaT5gtUVGVpnc7Sl1ZGOcwxzp4nREKiZYFg4I4Qag0kUozYPm0Zln3smxSUeAO/1rJtuiWGsb0ZO5/wZ6A9qUaaxApHOecm/rBV5oXRKsj0NGr4DACi2kIurZLase6p3Um7a8lMfvNfgjOEaiyaenh6FVDBWrQCfDMKx4H2c0/zDNFf0YZSHglQduh+1KVetLEE0eQ6RrP9HRIhVXH3LEAntSFSoH34OI49dPFhKKlgSL+a5YLPo7RF+S0sEX11wYGmOYgZ6RRDC/3OAlU0Mb5MCVmMHNtW/NKKVPJ+uXlbi9YGtFMoLR1w0eCjPROakgZ5VOeGy6i9KevjtvmzbR8F+sFkCaWBtxSuoaTM8iNLIAm24+Ivd3s3tYe0haGzGkYdx8rEDqqzWiRvJkN19G6GCRJqCxqTru+VkPfo+Ci7oceE/WFON3vjptSONVbI0bsgTIAbAPjs1sAtB7n3z09IXdZJm6P1ObE7pp2d8spqdyh/LOiPWyD3cUL7JXtxO+D7WGBNe0mCbeIN5B03MpOx2XLa1sV7QiWAQgLZiMnurHahRYMrYtzCzCe+zxt6cdzDmYYoG3wzgKTxLRoVcRCYmqd8QzmCH7jFqTK0juacmfZlH+1GspLk18qNkkubHaZdX+5YlnHEGzTTunK4tRtwM6+woxZAIMgBoFuknIUhkqBYUZyojsF6pQTcytVeGsy9wELjwPUgxTOzusQQZnusoI6zACEx90D9h4ZgXgzzRO333kHlnU7GyeWYyMH/hn5Nn6lw3M3YBh1K9vl22QgNKffVWGVaxJUoPHlTakXhqN6VWhP34VXnOTbIyTNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(346002)(39860400002)(136003)(316002)(54906003)(86362001)(4326008)(45080400002)(31686004)(66556008)(6486002)(8676002)(966005)(66476007)(31696002)(66946007)(478600001)(82960400001)(36756003)(5660300002)(41300700001)(8936002)(2616005)(44832011)(6506007)(2906002)(53546011)(38100700002)(83380400001)(26005)(186003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEZSY0syelVDbFd4Rnd3OGVSVzZvUFUvMW5VUTIxQ0xacmdNZGFVdDl1czMz?=
 =?utf-8?B?U2NiRnNoUEppU3dWb3BCK3RYVGFuak1oOXdnZU53OGFwY0FMRzJieXRtekkr?=
 =?utf-8?B?eWd3WmRWZSs2bXpSQzhRNFIwT2lrc3lpQ2NuOXc4TDlnMjliQUFpTUZpcWJH?=
 =?utf-8?B?THdWSnZaQ1V6UnR4Z3hSdU1PRnZIZktNWGFtMnJWdGNxY3JSK3dveHp5eG00?=
 =?utf-8?B?RDB6MW5BVUJQaUN5T0o2Y3ozYUswUk5tQ2NYcUl6ZVBRZVZweE9IaXhUOEJq?=
 =?utf-8?B?UEpremJvYm44ci9SMitpWjBDdnZGSGQ4aUVWdFhkVDF3eUdINWFFN3NJSVBx?=
 =?utf-8?B?M3cxd1ptanN5TVZ0YXZkdGE1TitIWEtDVkZhRUhiZGpSSkZzNkNEcmh3ZDlL?=
 =?utf-8?B?YVBOZmZRMmlzR0hhNGxhL1VtVWpFaktld2JlM2xINm5nVTM1RjB0U0p3d2N1?=
 =?utf-8?B?V3dMS1J6OG9xY3BzUlljR1FtdXdQcy9sYkxiLzVUL0JMaFEwclhFdXVNb1Qy?=
 =?utf-8?B?aHpONkRiLytUWTQ3eVZRaWlOS3hTdnlIRlV1QnhvTEIxNUxHSHNIUGNqSUlt?=
 =?utf-8?B?MXQ1aWdKc3U0M1JLMGJ1dXUrNy9GS0N4RVBPM2RmazVnOTJBMjhISnZyTSt2?=
 =?utf-8?B?RUwwbm0wM25tQTlIc0IrendZR2swOW1MT1MyWEZROU5qb0ZqQS83UkQ1NllF?=
 =?utf-8?B?OURFUXBKMFBTSGw1NGU4SjMvdTM3Ky9FbXRYa0ZrU1JVbytwS0JxTnZ2V3do?=
 =?utf-8?B?V2ZkTy84K01BSFhuR3MzOGFRSHhKSHBMT2d2YitrZEtJNlFrNkN0WFY5STlr?=
 =?utf-8?B?UythSmE0VERMdEd1b2hnUjlpK2NpYXZSU2lpQ1o2Nzd5NWdlMXc0WWc0SkpG?=
 =?utf-8?B?QkhvQXh5L3RpSmwrcFNMN3AyWENzSmtGcFB2TGFGUjAxQ0x6N3J0MDBweFpi?=
 =?utf-8?B?THg5UG42MDdieHJqN1ZQb0FWNXVjQ09wTjgzMFlOYjJNNVQ4bUJnQXdKT3Nt?=
 =?utf-8?B?d2JxUkhPZno0VEcxOEVNNGdHWTlwaHNjZklGQ2pMemZCUmRCTW56MW1qMFN4?=
 =?utf-8?B?ajFoQVFNWVFyT2tUTS9wdjVDQ2pGQndMeTJURk5JOGJnNE1GbEpwaU9GYWdx?=
 =?utf-8?B?OXJRTVlyUTh5SEtHVkI5UFJsQ05aMXRmSXZWYnJjb2Z1M0h6VDlubGJROXJB?=
 =?utf-8?B?QTJoRjBoVDJNeGNtaFh4VGNQaThZaWJDLzRwenlKcWFCQlBjNFdJY0VxcGxo?=
 =?utf-8?B?WW5XenlzTThEN2FlUkhEamxJbWt1MzE5MDYyVnR0TlhNYTFVZHd6S1ZqN0gy?=
 =?utf-8?B?QTkrSGtxcWhBMmk0dXUrZ0ZUOGlNR0hwZHB3SDJpeUw0U2ExejhLcUNGcHpM?=
 =?utf-8?B?a2lLaTFZb3NTblFDQTdVbjAxcUVXWFpvQXppYXBabmJQYmZtVDc5aHRlMmdn?=
 =?utf-8?B?OHphVnc3Wlk3ZWkwSW5iOGxHUTRLWjNTV1hYaDdpZzhmU0tjSmF3Ujgxcm5p?=
 =?utf-8?B?VHNPMytpU0IwUnppT3RhMVFhQmdtemVUUWtBdndqN2VLTXhpc1A0cHR3Q2xt?=
 =?utf-8?B?R2NoNng2ODFqZklzeHpDcFptMkVaTFZ4emJndUlNcHVVRnlBV2FOSU9Tdmo5?=
 =?utf-8?B?clZnMno2c014cUkrSTQrS1A5TDM4bk1zN0xFRWJWMytmZ0JETWFEdG5oVVZF?=
 =?utf-8?B?RkJSQWN6aUNpdkNpRldmTk4zNG5UU1FWUUJabmQ5TTFyaTRJa0dSUTRhTVlX?=
 =?utf-8?B?aXpxeGxnSHVKc04xNi8wL21naVBhK3AzbWV1bjZqVkM4N2prWm5mOERRdkov?=
 =?utf-8?B?NTg4RXJpSWJhUE1TRDdYaFB3dlVBelpvZDJlMkhqUU00eldIRGNrNHh3UExU?=
 =?utf-8?B?eVJqSy9lclpRUEtWNjNIbi9HRDEwVlMxL0FRcmg4QnMvRmYxS3FPL2JtMVkw?=
 =?utf-8?B?VmhKcUV4a0JSdnE4K0FMMDVTaFdsdHJ1M2NpcG5wYVZoMkFrTVdFU1B6Nlo4?=
 =?utf-8?B?VG1XZnF3cTJUUkNtcmZTRS9RdGw5dzA4UkVObDYyV3lBMi9GQVduNXVzak8r?=
 =?utf-8?B?TzBFYm5XUGcvVnFIN2srZEx2cDhWRWVvUDl5eXJiU1VZb0NmeVl0VG5jTlNT?=
 =?utf-8?B?N3BMTlBGUEViTFBtTDUvOUpDYmhOZm1SbCtwajA1Y0lCVTJrUzR3QkxpSkpY?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3afc89-e92a-46ec-0379-08da8adac851
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 22:55:49.5852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRD9JOZGBNCBMVIXhM/dO+2tqXCxAKV6MLPKjWbfjV4xK1/9+nPcmHHUDDEvAps0VK3H7ewzBkxhkrHaQqWhhSq2+o30COjf0Bplc2THbrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6523
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

Hi Vijay and Jarkko,

On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> From: Vijay Dhanraj <vijay.dhanraj@intel.com>
> 
> Add a new test case which is same as augment_via_eaccept but adds a
> larger number of EPC pages to stress test EAUG via EACCEPT.
> 
> Signed-off-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
> Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v2:
> - Addressed Reinette's feedback:
>   https://lore.kernel.org/linux-sgx/24bd8e42-ff4e-0090-d9e1-cd81e4807f21@intel.com/
> ---
>  tools/testing/selftests/sgx/load.c      |   5 +-
>  tools/testing/selftests/sgx/main.c      | 141 +++++++++++++++++++++---
>  tools/testing/selftests/sgx/main.h      |   3 +-
>  tools/testing/selftests/sgx/sigstruct.c |   2 +-
>  4 files changed, 129 insertions(+), 22 deletions(-)

There seems to be at least three patches merged into one here:
1) Update SGX selftests to create enclaves with provided size dedicated
   to EDMM (this change causes a lot of noise and distracts from the test
   addition).
2) The mrenclave_ecreate() fix (which is still incomplete).
3) The actual test addition.


> diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
> index 94bdeac1cf04..7de1b15c90b1 100644
> --- a/tools/testing/selftests/sgx/load.c
> +++ b/tools/testing/selftests/sgx/load.c
> @@ -171,7 +171,8 @@ uint64_t encl_get_entry(struct encl *encl, const char *symbol)
>  	return 0;
>  }
>  
> -bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
> +bool encl_load(const char *path, struct encl *encl, unsigned long heap_size,
> +			   unsigned long edmm_size)
>  {

checkpatch.pl informs about alignment issues above and also a few other places.

>  	const char device_path[] = "/dev/sgx_enclave";
>  	struct encl_segment *seg;
> @@ -300,7 +301,7 @@ bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
>  
>  	encl->src_size = encl->segment_tbl[j].offset + encl->segment_tbl[j].size;
>  
> -	for (encl->encl_size = 4096; encl->encl_size < encl->src_size; )
> +	for (encl->encl_size = 4096; encl->encl_size < encl->src_size + edmm_size;)
>  		encl->encl_size <<= 1;
>  
>  	return true;
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> index 9820b3809c69..867e98502120 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -21,8 +21,15 @@
>  #include "../kselftest_harness.h"
>  #include "main.h"
>  
> +/*
> + * The size was chosen based on a bug report:
> + * https://lore.kernel.org/linux-sgx/DM8PR11MB55912A7F47A84EC9913A6352F6999@DM8PR11MB5591.namprd11.prod.outlook.com/
> + */
> +static const unsigned long EDMM_SIZE_LONG = 8L * 1024L * 1024L * 1024L; // 8 GB
> +static const unsigned long TIMEOUT_LONG = 900; /* seconds */

It is interesting that in this small snippet there are three different
comment styles (multi-line comment preceding code, tail comment using /**/,
and tail comment using //) :)

>  static const uint64_t MAGIC = 0x1122334455667788ULL;
>  static const uint64_t MAGIC2 = 0x8877665544332211ULL;
> +

Addition of empty line here.

>  vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
>  
>  /*
> @@ -173,7 +180,8 @@ FIXTURE(enclave) {
>  };
>  
>  static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
> -			    struct __test_metadata *_metadata)
> +			    struct __test_metadata *_metadata,
> +			    unsigned long edmm_size)
>  {
>  	Elf64_Sym *sgx_enter_enclave_sym = NULL;
>  	struct vdso_symtab symtab;
> @@ -183,7 +191,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
>  	unsigned int i;
>  	void *addr;
>  
> -	if (!encl_load("test_encl.elf", encl, heap_size)) {
> +	if (!encl_load("test_encl.elf", encl, heap_size, edmm_size)) {
>  		encl_delete(encl);
>  		TH_LOG("Failed to load the test enclave.");
>  		return false;
> @@ -284,7 +292,7 @@ TEST_F(enclave, unclobbered_vdso)
>  	struct encl_op_get_from_buf get_op;
>  	struct encl_op_put_to_buf put_op;
>  
> -	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
> +	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata, 0));
>  
>  	memset(&self->run, 0, sizeof(self->run));
>  	self->run.tcs = self->encl.encl_base;
> @@ -357,7 +365,7 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
>  
>  	total_mem = get_total_epc_mem();
>  	ASSERT_NE(total_mem, 0);
> -	ASSERT_TRUE(setup_test_encl(total_mem, &self->encl, _metadata));
> +	ASSERT_TRUE(setup_test_encl(total_mem, &self->encl, _metadata, 0));
>  

The support for EDMM size and all the call site changes could be moved to a separate
patch to make the changes easier to parse.


...

> @@ -1210,6 +1218,103 @@ TEST_F(enclave, augment_via_eaccept)
>  	munmap(addr, PAGE_SIZE);
>  }
>  
> +/*
> + * Test for the addition of large number of pages to an initialized enclave via
> + * a pre-emptive run of EACCEPT on every page to be added.
> + */
> +TEST_F_TIMEOUT(enclave, augment_via_eaccept_long, TIMEOUT_LONG)
> +{
> +	struct encl_op_get_from_addr get_addr_op;
> +	struct encl_op_put_to_addr put_addr_op;
> +	struct encl_op_eaccept eaccept_op;
> +	size_t total_size = 0;
> +	unsigned long i;
> +	void *addr;
> +
> +	if (!sgx2_supported())
> +		SKIP(return, "SGX2 not supported");
> +
> +	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata,
> +				    EDMM_SIZE_LONG));
> +
> +	memset(&self->run, 0, sizeof(self->run));
> +	self->run.tcs = self->encl.encl_base;
> +
> +	for (i = 0; i < self->encl.nr_segments; i++) {
> +		struct encl_segment *seg = &self->encl.segment_tbl[i];
> +
> +		total_size += seg->size;
> +	}
> +
> +	/*
> +	 * mmap() every page at end of existing enclave to be used for
> +	 * EDMM.
> +	 */
> +	addr = mmap((void *)self->encl.encl_base + total_size, EDMM_SIZE_LONG,
> +			PROT_READ | PROT_WRITE | PROT_EXEC, MAP_SHARED | MAP_FIXED,
> +			self->encl.fd, 0);
> +	EXPECT_NE(addr, MAP_FAILED);
> +
> +	self->run.exception_vector = 0;
> +	self->run.exception_error_code = 0;
> +	self->run.exception_addr = 0;
> +
> +	/*
> +	 * Run EACCEPT on new page to trigger the #PF->EAUG->EACCEPT(again
> +	 * without a #PF). All should be transparent to userspace.
> +	 */

s/on new page/on every page/ ?

> +	eaccept_op.flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_REG | SGX_SECINFO_PENDING;
> +	eaccept_op.ret = 0;
> +	eaccept_op.header.type = ENCL_OP_EACCEPT;
> +
> +	for (i = 0; i < EDMM_SIZE_LONG; i += 4096) {
> +		eaccept_op.epc_addr = (uint64_t)(addr + i);
> +
> +		EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
> +		if (self->run.exception_vector == 14 &&
> +			self->run.exception_error_code == 4 &&
> +			self->run.exception_addr == self->encl.encl_base) {
> +			munmap(addr, EDMM_SIZE_LONG);
> +			SKIP(return, "Kernel does not support adding pages to initialized enclave");
> +		}
> +
> +		EXPECT_EQ(self->run.exception_vector, 0);
> +		EXPECT_EQ(self->run.exception_error_code, 0);
> +		EXPECT_EQ(self->run.exception_addr, 0);
> +		ASSERT_EQ(eaccept_op.ret, 0);
> +		ASSERT_EQ(self->run.function, EEXIT);
> +	}
> +

I see that you removed all comments here after the discussion about what
comment would be appropriate. This may be ok but it does seem awkward that
there are two parts to this section and the second part still has a comment
while the first does not. How about the comment I provided in
https://lore.kernel.org/linux-sgx/69a5e350-ded9-30c9-dc41-d08c01dd05dc@intel.com/ :

/*
 * Pool of pages were successfully added to enclave. Perform sanity
 * check on first page of the pool only to ensure data can be written
 * to and read from a dynamically added enclave page.
 */

> +	put_addr_op.value = MAGIC;
> +	put_addr_op.addr = (unsigned long)addr;
> +	put_addr_op.header.type = ENCL_OP_PUT_TO_ADDRESS;
> +
> +	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
> +
> +	EXPECT_EEXIT(&self->run);
> +	EXPECT_EQ(self->run.exception_vector, 0);
> +	EXPECT_EQ(self->run.exception_error_code, 0);
> +	EXPECT_EQ(self->run.exception_addr, 0);
> +
> +	/*
> +	 * Read memory from newly added page that was just written to,
> +	 * confirming that data previously written (MAGIC) is present.
> +	 */
> +	get_addr_op.value = 0;
> +	get_addr_op.addr = (unsigned long)addr;
> +	get_addr_op.header.type = ENCL_OP_GET_FROM_ADDRESS;
> +
> +	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
> +
> +	EXPECT_EQ(get_addr_op.value, MAGIC);
> +	EXPECT_EEXIT(&self->run);
> +	EXPECT_EQ(self->run.exception_vector, 0);
> +	EXPECT_EQ(self->run.exception_error_code, 0);
> +	EXPECT_EQ(self->run.exception_addr, 0);
> +
> +	munmap(addr, EDMM_SIZE_LONG);
> +}
> +
>  /*
>   * SGX2 page type modification test in two phases:
>   * Phase 1:

...

> diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
> index a07896a46364..decd767434d5 100644
> --- a/tools/testing/selftests/sgx/sigstruct.c
> +++ b/tools/testing/selftests/sgx/sigstruct.c
> @@ -349,7 +349,7 @@ bool encl_measure(struct encl *encl)
>  	if (!ctx)
>  		goto err;
>  
> -	if (!mrenclave_ecreate(ctx, encl->src_size))
> +	if (!mrenclave_ecreate(ctx, encl->encl_size))
>  		goto err;
>  
>  	for (i = 0; i < encl->nr_segments; i++) {

As I mentioned in feedback to previous version, even though
encl_size is now provided, this misses that mrenclave_ecreate()
continues to recompute it within.

Reinette


