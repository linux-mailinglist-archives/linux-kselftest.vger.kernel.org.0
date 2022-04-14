Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FF6501954
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 18:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbiDNRAh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 13:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiDNQ75 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 12:59:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAADA76D4;
        Thu, 14 Apr 2022 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649953983; x=1681489983;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IHR1EdbHtiQuBlsOw+/ScYwyuBZ7M8FifIw/p8jZkto=;
  b=F0UGzJNAz3hjawCANaHOcbjl3FG3ETjKR5XB77n7C2Yu9h05GARO+J5s
   OHWtuRyUwF1c9wbc3vsv1odNHhxSVGQdwLevZmaMwpkuk4mizdq3TU1AJ
   7jSL23xkTC19GGLdv0TYR/4cPJGm4HU9xbWK/dOuMbPzBWz+vOl3eE6Wg
   TYCM6oz0dprpwSft3S3OC/cJVbFuDOjurmU9bWMyPKOYWMn/x8+74fdBe
   fysyrrpmd7ynVWW2Y768Wl4kdZ9ILFcL4CU4PBdW8j77RYqFNNCExg6BO
   X0KgxmE4wnZspibi2FeGPqLIzPvZLNEHV5Jt31KrKh1O7pS8IdB2SoW7E
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="242905049"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="242905049"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 09:32:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="560259106"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga007.fm.intel.com with ESMTP; 14 Apr 2022 09:32:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 09:32:44 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 09:32:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Apr 2022 09:32:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Apr 2022 09:32:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYfDGpOi6n3DO0rw16Ge3tnlHJSrfrziGjTW4Q6W2L44tM/ogK0DjJSa3u7GytHot+k63SearNchLP2zst04+qnUsm1Jbd3a8HtYzv0a9VGGPfi2H5wznFSK+VdgfeC6HZstYIt63xwMY99ezX8VwqFCnSwLdPNPGKu4dpuAV/dxwPj/5BQz4G1l8MYwj6k86cQxgq+7YGXmAYWonJO9evxlFQ9RcwhFhSn53e8xHJwsgguVPG7FRSxJJ5nNi3m7ko+G2+ZZYp0+3WsrAZQI3Vfn5/b4LdGQuO+rn4NAc50JaiHThz/DnMBdc7w2kUlKxd2gS5eWY1VBZtoZ10pHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNva53Ww6Rc2bDZ6ki18TBfcoS8NB0OSGVKjWOm0X1A=;
 b=ke9oqXtT2Mu4S06SJG9UyjN+uK4yxRXbrajzLBefc38GkBnq2yiUg2GaTenew4jQ5h30ofGx3bm6udhIEtcXzW/Dp8/W39TQJ12k3k6Wpx1mILzAesS6bzuxgCrLkMCp8VCzqgi8UEDDJm9yS/zpCpWOsYwV/SVs35hGED+2Yrj+UXC+pNEB0M3qnyOlPt1r25xcHm5D3LtuIJusDr/wAP1Z/zDQ++BLv813T4u8VO5Rr3qVIkBanps+tbczF2WQO/pR1dSn0EFNF8wG9ezj7F9gx6DJPAPrpPOBXS9WP0Xx3baDCO9tTLpsrxLMcWEECcSRiHBZ/SNFNEX3ttXEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM5PR1101MB2347.namprd11.prod.outlook.com (2603:10b6:3:a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 16:32:40 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 16:32:40 +0000
Message-ID: <0e08fbd5-d350-4acb-37a0-1e355c95d174@intel.com>
Date:   Thu, 14 Apr 2022 09:32:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.0
Subject: Re: [PATCH V4 21/31] Documentation/x86: Introduce enclave runtime
 management section
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <dave.hansen@linux.intel.com>,
        <tglx@linutronix.de>, <bp@alien8.de>, <luto@kernel.org>,
        <mingo@redhat.com>, <linux-sgx@vger.kernel.org>, <x86@kernel.org>,
        <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <vijay.dhanraj@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1649878359.git.reinette.chatre@intel.com>
 <21b97a8e9275706f14d6bc652a0f2cfdd5d9648e.1649878359.git.reinette.chatre@intel.com>
 <c0e3765e0b82beb9b4f1ae1d7ef879abd923e063.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c0e3765e0b82beb9b4f1ae1d7ef879abd923e063.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::23) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b97cf767-f5a7-4fa4-ff7d-08da1e3464b5
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2347:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR1101MB2347BC20ACE28FF0DF146496F8EF9@DM5PR1101MB2347.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MIA/aKxleJWEAf01EzDALHrCjpL2pfEQd9Pccy0F7AClI+UsNDRMGzfJf9SoNft0lAeLG7jlFH5m1jX/EEpr8egF5mQeiZuN6ZsrCcCsjuHnSL9PbVAkTJqENJvoV/NMogJ8BREIa3Agnc1DDDkU8uYjYxLuMWUJjgyVnDvAobuVAzPRVy/SMcMSIzqEC21Kqcd+/g9qG7i6W2C3WzH8NkBKv1hU/iE6I/n4KmorJTMsmARt5DtcC6RWC2ZZsHPfDYRUJyoajJGGYuGqwmpBLpWOdWRKCVhLce3yiBr+wjpBDpAj2QJDtZ07fGVWAbDe45DGpU1nbcA/Yx5xwosPjPr+uD5eWNE25nf28bz9VVujgRntDRObdAz6XYbyjQS6CXQg5/gMNn6ey5umZpGwNzTSxdsXP1Rs8dveUtkM7FZ4opDyay57zRAYZKzxcJ5LfGMnl3n4LzMLRmPy/JnJD5pz9yC6dRGyJOdMHwS536kzJt/7v/380ZcS5bmJY7gSnc7TKTQ919xo8xzH4qpHN3vbJfGon8nra944R5apYdBNTx+8WFqhUzIMxFTbWBL0V4SMFuzalpkMg0Fm33keJXbpykzHxjNmPS581c40YKLTQgwmZ3OVGbcz6ir7AgprmpnH84hOdjamFF3sNkkaDjDzP8XCrgzS5fBgDSxCxqG1jzC0Pue/tZRrJX09BAJdkafOiEvBMqyi3avXy78lsBcxkfoceuBYpaLkN02YPD+ZHGvEbMOm6tGJh7EEpkV6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(2616005)(86362001)(186003)(6486002)(26005)(6506007)(4326008)(53546011)(66556008)(6666004)(66946007)(8676002)(6512007)(66476007)(2906002)(8936002)(5660300002)(31696002)(82960400001)(44832011)(921005)(38100700002)(36756003)(7416002)(83380400001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjRXNzdTc1RRUzQwNXRxaGgrbk12a3hCRnV1ODR6R05OdkxtZ0F4U0hsa0lK?=
 =?utf-8?B?MUxwN1dyRmJsQnRuQ2pTelJIc2xQY01aeTZYK3IycGJBcjA3QlM4cDZsVU1v?=
 =?utf-8?B?cGlSVGg4ZVhYK3BXaDVEamtRWStGWG0wZWQrNWg2RWpWM1NQRFpmUFloTEtv?=
 =?utf-8?B?aDdQOXJYcFI1djNMd1B3REsyT1grdzlrMkVpbzMyemp2R2VsRk90NU9mQzhI?=
 =?utf-8?B?SFI4QlV0VTdSYVM0SHA4ZjAwTm5SeitvRVVFdjZvU3QzYnRzR0lESlR1aWlL?=
 =?utf-8?B?T1lDZmtCZG1IVkNzamZybWI4U1QwSlh5SVJQVmVmQkZHRmJqeVB1dUkwbkdY?=
 =?utf-8?B?aGVuLzdMSmxqTDRXNnljR3o0Y3BHcjVJSmVPTk5NemJ0NWFWVnFWSWZmZjN0?=
 =?utf-8?B?aXY0NkIyY0RzeWFKTjNMMHJYOFd0TGo4MklsSlBHR25zNDVJK01HcldnbzlQ?=
 =?utf-8?B?UnlQRFByRXh6TGNaU0xNL0IwS1NYemtCY0pFWDRVRW5MK3ZpMkEwbm5VY3hh?=
 =?utf-8?B?Z0w5bEt4NmRZMXNlQndidmYrZFMvRzByQ094VlZpd3dpbDh2dnpMVVh5QmVP?=
 =?utf-8?B?ODlTN0w5MEJTSklGOTY3cmh5KzBsTEtXU0hNQ2NLY0w2SzhseDZHbjFMenR4?=
 =?utf-8?B?RmwxdldXelNKS1pYMnE2dmtNYnYvVGdzNWNvcEZaUEM3Y0F4eVVDVkxtMmlH?=
 =?utf-8?B?dU5aMGNtTGNQcTNLRGlGODdCNytrRDYrSkt1djVFU3ZPRTJIYW9BWUt5cGdt?=
 =?utf-8?B?aHpWbVpLSWUrQmpINUZVclV6MzR5enF3T1ZTRStCa016ejdlSjBXTWlXcUZv?=
 =?utf-8?B?aGdhdFAvTUMzNVFNMDBWNUxXSE56bDZyVytmWUlQOERZdlliNnlxT1lHUFBF?=
 =?utf-8?B?N2tHelZKNmtSRG5pWkI4S1pQZ0pWdWFjcERyMkFFU21La1Vkc2JEMk84TjNY?=
 =?utf-8?B?WFZ3alh0VWoza0NzNzlJYTIvb0FnbldPalFuRHlZbW9wejB5ZVM3OUVVUXBa?=
 =?utf-8?B?cW8wNGw5ekdaMG5oV0QrVjNjSExQRitaR0lLa1dZQkVFQy9pU09MUW1Gemw5?=
 =?utf-8?B?aWVsRFFFeFVzNklHNU5QVzQxU1FJTnZBZ2UzZ2g2S08yNVFSeCs2Vk91TUtB?=
 =?utf-8?B?cDFTVExxSWFFVzFLTmw3Z2wzWkFINzBiRTNsSzRIK2Nud2duQ0NtSXhHTFhj?=
 =?utf-8?B?S2dlODlMU3NDb1AreThvc2NraFJ1ZGdmeENCVlA0SzNYUVROalBLOW5XQlpZ?=
 =?utf-8?B?MHhOdUxucjJ6RzNkMHo3dmxZZjFLb0VMZUR4TjhzOEtiVzlWdVBMVHgyTlVU?=
 =?utf-8?B?QXpsTUpiVXpOVlRCbGp5SURyMVdzdTh6R1dDUzVtRVdmRmhmUWV1MEdtUStV?=
 =?utf-8?B?Wm1WZkVNRDVLWmk1S25iMUY5Yjk2cWJIbWNkOUZReHk4a0RzK1RmUGRkR2h3?=
 =?utf-8?B?NU9CR0pTMEZzNEo3NWovNSs2RWZnOHhPazkyMitLZndMUnFqMFVpOGtqTnpB?=
 =?utf-8?B?WlFlZnBMTFF2TjI2RVRsWEIxL2JOaTZKQlhFSkN4MFczMzE1ekZDVG1nM2R0?=
 =?utf-8?B?ZkoyalAvMUhNTDJ3eHNlTm9SdkQybjYzRFZ5N3FCS3NodklDZVQzMEVNTU10?=
 =?utf-8?B?cDBQWGdSRWVVL2p6Sy9qaHo2OEVVZ1JUdFkyNkRySTdGWndzOWlDRFROOXNG?=
 =?utf-8?B?OWNSQWo4L2dkbG5heVY2MEh4L2lZZ2JHRSt0bHZueGRkbWlMS1p3ZTl2U1ov?=
 =?utf-8?B?bnhEYTd2a3NLSXRwOUU4dWozVkZHUHNXSnMzeC9SdWdDWXV0cG9kU0ZPSG1a?=
 =?utf-8?B?cW5JM1pUdWxVbUgwSXpIY1ZUZGhIcGtGdUJnRXpEcGdUZDhpcEVEUzN2VXk4?=
 =?utf-8?B?aE5yZ0VnajFuRnJLcHl0VkxUYWtkcnVjTmVGNFJWTUNWNHpPcWNLQ3lNVXA0?=
 =?utf-8?B?dUtGcGhuUXV1NnBib0pQalhzcDAxSHBEVE1kTlJHYVRZdGZnQ1Q3N0ZIZG94?=
 =?utf-8?B?RW9KY2tpQ3ZFdXlNS2JVNkUxTnVtMEVPU1RUaEowK3VGSkJsc29NTU9BUlFV?=
 =?utf-8?B?a3BiOWVNVjVZaWhlSTF4a0YwcmhwSE1LN1drLy9RczhGK21QU0dIWGZCOGRn?=
 =?utf-8?B?NFhQdEZ6OHpFWHVuTjlGdWcvOWhCSHg0Mi9HR0RwSUtHZ2c2R2JJUldVa1BL?=
 =?utf-8?B?VW1HZ0tKSWJndkpkeVRkNDJIa3luZ0tSNWJEdkx5M2JGYTAyR2dtNWU0RnhX?=
 =?utf-8?B?TnhleFJ6TjRlbXhDTG0yTElOMXVwY0s1MUlqaGV2Tmp2WGFGNzc0bHRMT1Zp?=
 =?utf-8?B?MVhKbDZrOW81YUs2cWI5NW9EcjA5WVQrR0Z2NXVqNEorRTkxZjhZOE05UnRG?=
 =?utf-8?Q?Go6v6qHOyXX82GkY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b97cf767-f5a7-4fa4-ff7d-08da1e3464b5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 16:32:40.5315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGsor5owwT87K90jCcelbELLl12G51/KpKdzldZB7W5hyM7g9ZKR5T7AHfhoOQ2cb6TNCAJXwTuHXylZaQ1d2RBJcq8X39IRR7fKGVYACL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2347
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 4/14/2022 4:21 AM, Jarkko Sakkinen wrote:
> On Wed, 2022-04-13 at 14:10 -0700, Reinette Chatre wrote:
>> Enclave runtime management is introduced following the pattern
>> of the section describing enclave building. Provide a brief
>> summary of enclave runtime management, pointing to the functions
>> implementing the ioctl()s that will contain details within their
>> kernel-doc.
>>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>> No changes since V3.
>>
>> Changes since V2:
>> - Remove references to ioctl() to relax permissions and update to reflect
>>   function renaming sgx_ioc_enclave_restrict_perm() ->
>>   sgx_ioc_enclave_restrict_permissions().
>> - Rename sgx_ioc_enclave_modt -> sgx_ioc_enclave_modify_type
>>
>> Changes since V1:
>> - New patch.
>>
>>  Documentation/x86/sgx.rst | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
>> index 265568a9292c..10287c558485 100644
>> --- a/Documentation/x86/sgx.rst
>> +++ b/Documentation/x86/sgx.rst
>> @@ -100,6 +100,21 @@ pages and establish enclave page permissions.
>>                 sgx_ioc_enclave_init
>>                 sgx_ioc_enclave_provision
>>  
>> +Enclave runtime management
>> +--------------------------
>> +
>> +Systems supporting SGX2 additionally support changes to initialized
>> +enclaves: modifying enclave page permissions and type, and dynamically
>> +adding and removing of enclave pages. When an enclave accesses an address
>> +within its address range that does not have a backing page then a new
>> +regular page will be dynamically added to the enclave. The enclave is
>> +still required to run EACCEPT on the new page before it can be used.
>> +
>> +.. kernel-doc:: arch/x86/kernel/cpu/sgx/ioctl.c
>> +   :functions: sgx_ioc_enclave_restrict_permissions
>> +               sgx_ioc_enclave_modify_type
>> +               sgx_ioc_enclave_remove_pages
>> +
>>  Enclave vDSO
>>  ------------
>>  
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 

Thank you.

Reinette
