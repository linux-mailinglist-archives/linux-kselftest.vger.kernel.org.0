Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CE64EA314
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Mar 2022 00:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiC1Wln (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 18:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiC1Wlm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 18:41:42 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7A04A934;
        Mon, 28 Mar 2022 15:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648507200; x=1680043200;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TCh4WF0ClaF9C3bW6gc5w/c2kolTTL+j4EmKDXxvAbE=;
  b=hgcGOma+jgL+7+jYeuNo3saAemPPPAwKnIEJFfcrm3hKg0kwRjF2dyC8
   NSpKaI26K9sMPsk9vJaJbnfB9zcvx84O/vvnTcLn6rpbieuC4dJ47xH5m
   C1ImrSkzVQciy+wDGItZy9avlXYzktuSwCiZ9wUhgImGNdzqWrRW7G3jw
   sag+q1Qe7TgdPWmnA3vszwEibxzqMOtKkOthOMaEpYNLGHVLT0Dtfu9cM
   ML0GguF9XMknLGfbc7I2je0GjkrtxhCM0X/WfizkwcI4yZM4iFPaeGy9H
   ip0wc4b1OY1cT8XQfhwdYNhT953klgw+Td4rNV+KjdvU61U1tkogqZA+P
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="319808987"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="319808987"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 14:49:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="554051660"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga007.fm.intel.com with ESMTP; 28 Mar 2022 14:49:11 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 28 Mar 2022 14:49:11 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 28 Mar 2022 14:49:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 28 Mar 2022 14:49:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 28 Mar 2022 14:49:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvEovJBOaF5em9D/UjUc82wfiztctSwNjZMzt7sTSR4a9URWHGof2u7k9BrxsmkQxyorQ04aIfP1Jo/3tki5g2fzStan97q7JcuQ6SpgdDTZpYQbYoEMDKvDl+FuZ+tEejlSoDWVY8lUbcN6AYp8JWma+RMJFabZgllVardvTCjHoRvpy2eaYEWQSEdC6kA71sJGGpK6O0xGRXG2gjw8z2YeADNigTS11LecoHga6u0J2sYV2PX2t1dDg+Uiew+CqNBvBWr/LscaAYRChYYOZsS31Yg/WMLEPrgIX7A6TxYUuVM9Cl6SFVKn6EMs9BTS1U8Az8EQXupyzf0x0fZEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euGoCJXjzipvX2Aw2Tur6cjlYE4/zYzyKYM3hds8BDc=;
 b=kv0+5e2rnKNv27YFkhvRt4+7MbH4U7mVrpMI3VfFs9K8EoqMFbGsAszzMMOL5FTG05wilt01uukhRtrRipo44rhFkiNGKVsgj2IJg1X2yoLspX9f+HIlJFXc9nBRb3YCtuEJU31Enrrcz2x9LA2geNnPFvDnnnAXUwHsgnzxM5Pjk11kDhHt3XQMYMv4SrykyGnOmMtjJ9yr5F/GrJv715k5FYmcu2XBEuG3XmiVQVXrQIIin+k5ajcswpby7sfGXT2tNBUb5YbwmUXADUUPT3nzS+dU4KFAnnye6CN9q7rRkSZELVVWUWvDrTBkgv9V4jEpmgXicEkSQod5sXC53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1908.namprd11.prod.outlook.com (2603:10b6:404:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 21:49:08 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%8]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 21:49:08 +0000
Message-ID: <7b7732ec-c7ff-cf92-510f-64c83ed985cd@intel.com>
Date:   Mon, 28 Mar 2022 14:49:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] selftests/sgx: Use rip relative addressing for
 encl_stack
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:INTEL SGX" <linux-sgx@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220322074313.7444-1-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220322074313.7444-1-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0050.namprd16.prod.outlook.com
 (2603:10b6:907:1::27) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29f392fa-e79e-40e6-e2b7-08da1104c975
X-MS-TrafficTypeDiagnostic: BN6PR11MB1908:EE_
X-Microsoft-Antispam-PRVS: <BN6PR11MB1908163EE54F74E645A6711CF81D9@BN6PR11MB1908.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ui/nKDTfW7F1B/OGqkCW2nfKzzEhXE7HekitlPOt+HjMxlxbqBB+n/m+DRZrfr13RLJ8UdDKGmFe0m6IwZdsyRNNOpNFHM+mJpsL7cvk48mnW9SWMi82bq2vgXQahYJ+u/SFiTSUB9+IWTzZGyc3BzBODHlhqWNR1Rye2hFlRfX/2X81TudgZFObIuteessda3GijpxKjFMH5/ErXO+hcRvnajFiEj7+34C20M1rTi7mmQz0vz32B5UQQ6VEV3AtHQQQ+3Byc/vVaCdbj1n4LsnLQGjwLbcD0l5K/P7oZDfZashSkQJgdQZzxQky6Vb7bVI8naTaxMs2lcb0JNbGPjfEc3iQlhHt9HtBNolii066zciIZyoHyguIkcPXB2lEK89VbfgzNDfFfd8w/OG28JentTF1qHXRzVW1KWURJPaPrRS8qpRLBFk0Iu7kXrl9P5K6pXm6NWw7aRIKCzjCAW9HDtlyysCx/WwOrkMh97lrBQAh3y4bbehWmn8TS0l3VIIy6NdlhSjTfZ2fvCqJDBbzcJ/rOgB0YWaLd7QYjDUxHn5qlkIoHNbsLN9MXHf+mgdwwzOKvxOdZ1IfLLVhEQTYrrywYmqQ2FjWcka4OpBb/+cy60TxGxbzGqUEX1fW7v9H3NzoZ0PrIrcM92a3W49U4R1YPUMULaokx1IZp/LjZcf1PrkawAfm3cXIAeUvly7ZB6At/78hS7myuTlyKb6sPGZlAOgbA4mltFdmmtHdHF/sUwuZXvDaErjrtXxBzPQF8cF/MrJG3tTkvM4k7zeyLCpjZrlquJIE5IoobZVK8ubv34dvo+41FU9BuE+1HvoFuJjHxYBZ9C3/sRitaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(53546011)(83380400001)(316002)(2616005)(5660300002)(8936002)(36756003)(44832011)(2906002)(31696002)(508600001)(66476007)(6486002)(86362001)(54906003)(66556008)(186003)(26005)(38100700002)(6512007)(110136005)(8676002)(4326008)(6666004)(966005)(66946007)(6506007)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEhpcTJIQzdEcWZjMzZxYWhjcnowdzNwZHJpdUZiUkVhSG1BSXF0cVIxbytT?=
 =?utf-8?B?OTJzODJJVi9ZRE1pL2pOU2ppdFBma2FxdWpZRlBhMjVaaUFjbmNaRlZJQ01J?=
 =?utf-8?B?S0NzUUJYNS9CbFdyem1PeUlwWlBhSzhuRS9Ic0ZyUUd5eWFSWXhqRERGY0N0?=
 =?utf-8?B?eUpMSkRNbC9xMElWeUp5cit4bGJ4RjVyZko3QzQ0RjJjUDZxV1krN0psaVFG?=
 =?utf-8?B?TVBRaFJkR24vSlBUM21kdmcvQi94RmtBQmhVNEkwajFJQjhRR0puUlhkRTlF?=
 =?utf-8?B?OExtVnY0WHQ0VmZqK3N5M05XK0tKS1IxNkVMMFlNQnJxYm53TWdoVkFGN041?=
 =?utf-8?B?ZXdkL0ZiczZrSFNSaG4zOUNmYzA4K0dsTVMwK2JzSHdhaWVnbWFzOTlJQlR4?=
 =?utf-8?B?NWthdVBvTDN3SjRTdXVVU2F0Z2NsbUhnRklqRmtBVWhJdXlQUGpXajEwTG1x?=
 =?utf-8?B?RWs4VHliY0R5UnBRTzE1YSsxcHk5YUU2eFRnMXNjLzU2cWFzYmlnSVF2N0dS?=
 =?utf-8?B?UEpvR29PWDJxUGd0OHpja1YreXpZdTZyNG9rRzVmV1VFMUc1Y3I2eXAwL0JP?=
 =?utf-8?B?WXBQR2NOeFNSc0lSVHZGNmc4NGhPeHJPdHhNUkQ5cmpqelY3UWtRMGg4OEQw?=
 =?utf-8?B?RVcrS0RBTXpMa3VqZ0VvUmZxZHNXVzFpdE9UaGhhUkRhVzRNSU1YOWhkR1Bw?=
 =?utf-8?B?Y1BVS2IwcW9KWDRQS0VpNjhSUkF4ampYQmNyaHhwS28yU29wcUMvUHE3QnBG?=
 =?utf-8?B?Y3FCcGRQcEwzSGlUcjllM0dmTi8rbHY0a1dNeWFpYTFWdG5RNWlTMlhjRGpu?=
 =?utf-8?B?enVzb3Jpa01jbTZnYzhydzBEbkFXRDQ0SlF4VEhQWnpKN3FPY01xQnpKWUor?=
 =?utf-8?B?RHp4aUJnRjRaZE90NTJSREpKTEh3OGxOc01yaTJMd2V5N0RQODZ0eFlWS3Rk?=
 =?utf-8?B?dG44NXdKcmZRUG1lOFVSZFp6bWFYd0pWQ2M5NmpNTzl4ZTVpelcwZkJXZ2pS?=
 =?utf-8?B?S0paMC96Y2tDRlNnTFZSN1dmYzhneC95dFlhVnJTRWJQa1hJV3FGaDVibm1n?=
 =?utf-8?B?cjFIUzloeU9BUVNxemYxc0p4WlhNRzkvTkg4Uno1NWtqVjFNeVNzYURlSk1y?=
 =?utf-8?B?d3FrNGpYejRralFUb25WK0JXQi9EUzA2NFJjZHVzY21LNUdrNG55NlNZQUVV?=
 =?utf-8?B?OWNrcFhpVlRzaWdyVDVtSzNydm5tTVB5aTRka2p1VHFxNjlBTzBDZVZVS2FP?=
 =?utf-8?B?L2R5ZDd0dnJ0ellvRDZGaTIyMFJueWR3UWtmUzFzS1RjdnRJR0dQM281dzBP?=
 =?utf-8?B?VWdtUnFSdjBxTTJKYktCeDNCQmMyN1dYOFBJUmpwdUJWVGJicWNaaWRhZmZR?=
 =?utf-8?B?My9tZ0FoU09PUTBqUGdacnFBWDgvUzdxdkV2Zm11dTAwaWx4ZzMvZ29zcXhK?=
 =?utf-8?B?MUxsSFlIa2hISGx1U3U1dHVTNnk0cVJDSGlzbDZzLytNNnFKay9aTXZzZUx0?=
 =?utf-8?B?cm1pT0dMQlZUdW5sdmpLUmxMblB0ekluNlBTRFVHZlJZNEJyQWhrMkw4OU1D?=
 =?utf-8?B?WERtL01YaGRtRDRmVTI0VWVXOVY3aVJub0dTRTIvRmZHdVdXS2VaWGdpb1VI?=
 =?utf-8?B?MUFMYkJ1dUJDaDV1YThra282c281d0tuN3FxODdXbVUrYU9TTEhvbG9kVStB?=
 =?utf-8?B?YmRJNzdEcFk5ZDlsOTFFR29XSmxoMzQ1L0g1cFgyREs4djJ4ZDMrTGRnQjRr?=
 =?utf-8?B?bVJGUDVka1FRajVKNGxKNlBkemV5Y291NStqNmo0UnFFemZHRnEyZFVaSXlV?=
 =?utf-8?B?dDltdDREeXBnRzE3anVPSkFnVXE0WW1ZMlVxQnNpM2VlQlRSQ21IZXlKb09B?=
 =?utf-8?B?VjlXWXo3S1N6ZWwzZktDNVJLYmtEMmlNUkpHaVFtckZCd0ZpMjlLa1VoSzlJ?=
 =?utf-8?B?SjJtL0JpM3pWdE5UZ0dvQVNjMXJGS1kwV2w4VHBnOHBqanMwYmFjTEIzS0hH?=
 =?utf-8?B?ZURvb2ZCU3lDT1ZoZ1ZRd3ZmYlcxS24rNXdwL0RNMXNMbjJLR29qaThNRTV4?=
 =?utf-8?B?ek5RWm1LeFEvSW85cE5zMGlFdTVtc1FzOTVqeTdUM1A0NUtQdDBMU0dNU0Z0?=
 =?utf-8?B?VnAybE5CbVhzaEZ0aXNRaEdGRkhaQThGQXJpZ3NPbWoxaElZVnVKYUZGelZV?=
 =?utf-8?B?TW1GS29md2dVUTc4NU5wOVdDVkUrbnhuZ2RGOVN6VUxDanVnVGc5MFpRSmdo?=
 =?utf-8?B?NDFoNkFRYno3ZFYyN21CbWc0b1Zpa2tHU2JWeTVSNjgxL25TR2U3NzRVMEll?=
 =?utf-8?B?UG85aWVCaVJuRUYxN2lQZEdXMWtxbnBMOFZiejB3RVFVZllkK2VPVUVycDVW?=
 =?utf-8?Q?nK2s3gyfR9mMwb4o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f392fa-e79e-40e6-e2b7-08da1104c975
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 21:49:08.6333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/+l04TmlRKsgw7qK46qYmoYI7QA3MwdZyTyYQ2R6Oyywqm1dkRv+IH7vWxZCYVneReu786l2FXqgDefzckgwLuodWiO7T4lbex0bHvCkDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1908
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 3/22/2022 12:43 AM, Jarkko Sakkinen wrote:
> Simplify the test_encl_bootstrap.S flow by using rip-relative addressing.
> Compiler does the right thing here, and this removes dependency on where
> TCS entries need to be located in the binary, i.e. allows the binary layout
> changed freely in the future.
> 
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  tools/testing/selftests/sgx/test_encl_bootstrap.S | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
> index 82fb0dfcbd23..1c1b5c6c4ffe 100644
> --- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
> +++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
> @@ -40,11 +40,7 @@
>  	.text
>  
>  encl_entry:
> -	# RBX contains the base address for TCS, which is the first address
> -	# inside the enclave for TCS #1 and one page into the enclave for
> -	# TCS #2. By adding the value of encl_stack to it, we get
> -	# the absolute address for the stack.
> -	lea	(encl_stack)(%rbx), %rax
> +	lea	(encl_stack)(%rip), %rax
>  	xchg	%rsp, %rax
>  	push	%rax
>  

The goal of the above snippet is to set RSP to ensure that each thread has its own stack.

Since EENTER computes RIP as EnclaveBase + TCS.OENTRY, by using offset from RIP this
would result in all TCS with OENTRY of encl_entry to use the same stack, no?

Could you please consider the following as an alternative:
https://lore.kernel.org/lkml/65c137c875bd4da675eaba35316ff43d7cfd52f8.1644274683.git.reinette.chatre@intel.com/

The idea in that patch is that a new TCS would always need to be accompanied by a
dedicated stack so, at least for testing purposes, the TCS and stack can be dynamically
allocated together with the TCS page following its stack.  This seems much simpler
to me and also makes the following patch unnecessary.

Reinette
