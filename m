Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F2750ED09
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 01:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbiDYX7T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 19:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiDYX7S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 19:59:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35257377D7;
        Mon, 25 Apr 2022 16:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650930973; x=1682466973;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1m3FzmpbI56vTbERDVOZmz30tK8SJpjVZQdH0thlztM=;
  b=XEAtPpqI9BvHmJm6E4SjSMxCsjupRg9eHEoJfBUv5G1uE6QU6yc5XRq5
   Xji3xsbS+MDkDw/MLF5699o2+Mrrq4Iyt4SBXOQGy8tbRXack9wm4DJYN
   6qIXzJPgtH9rruROunHCC2BbcxG45zcksKhCqDUKcGoDj9/0m0oVhepHB
   SFcBlUZ7nxWp9njrzZgLFx1Sh5seiBDUaa9P2V5NejMJqYj1oWbY4xrYZ
   xEq461UC/cu3t7LXOLxRiY1zPonkHEus2/DNOF8JVdDaB3++GplgJo0r8
   a7Rrh1R7a+N7ezfH3enpcTpJy0KhuZp5nDtoErb5zyTHQMpKdCM0+R9Ad
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="262993214"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="262993214"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 16:56:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="628253912"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga004.fm.intel.com with ESMTP; 25 Apr 2022 16:56:12 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 16:56:12 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 16:56:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 25 Apr 2022 16:56:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Apr 2022 16:56:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+I/9XFb1niwIHJ6wl74KZA3HZDzlyJEe9qOp6ILYkYhE2/bog6aNetkDT/7OiAAu8gcRLotmz34u8lM7Ioj7Jkou+qriwqOMHt6d6UGKEtyEm23LLk2vITo0z7gZoqAsFmoFfCt0lLy2CgPyZUCwNWtVVkqv495I7VcinT4DrfWVbQPi+VxUa3Sz+m43Ma5JEKOI6wc0m3fOjV+naK8+f6a7+tOwhELMdOxnHN35oD4B05VFlMsJRjsfMy/VSsgbbh4dkTGkEi2MuKFsLWWW7tRSUQnp+o82MXPbPHtBEp3svv3De/K45R1Kgk/dslcon50ai7gcQ0CM2WjWlOHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6WxTdWMzb3XSEF17wDSqQu9Os9WT9TNyt0h0eR93Lw=;
 b=kAR0pCEztltEVsAlbDBK92pVYgenSeFus6y/lGwmmcieEP6HQhjizWnZToFqOM7Lle8m+lnefiboJQMX+Ef+Wp6/KoNwO/PSAY6KDrbSWC+K+I4rKJuJteNelnQLzfSNcdj06RgPKw7GUhOMqcUFlKOFl5XSeWwbkuO/CZupfp3bIgr16nqWpbAfpBco7MjuC8p+I50jUrOaSl/6mnM4IOEg2uZGlkYJPEE9kMTIFLKa9MGsSml2Mc6k9Pg8KYO41yQmhCWF6DHWnHbStL8TcO+dttbqCMVPHQ/r2EjfYhMqVZCdAu6yPatQvu8Tk4gW+jA5h4IjY7cYnA9ZhTB28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by MW3PR11MB4761.namprd11.prod.outlook.com (2603:10b6:303:53::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 23:56:08 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525%2]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 23:56:08 +0000
Message-ID: <d8aceb1e-c6ef-1ca0-f11e-e7e83e634854@intel.com>
Date:   Mon, 25 Apr 2022 16:56:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.0
Subject: Re: [PATCH V4 00/31] x86/sgx and selftests/sgx: Support SGX2
Content-Language: en-US
To:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1649878359.git.reinette.chatre@intel.com>
 <2f4338f37943c2b067db16ae65c9af665d3b51d9.camel@kernel.org>
 <9fbf26c8-5808-20c5-8653-d4f36bf398a4@intel.com>
 <42a52a6018e8dadb4c3eebefaae4dab31c0d5721.camel@kernel.org>
 <DM8PR11MB5591BBA189BC4EA5CFE2C7EAF6EF9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <54f053d8bb6b72725b2351fc2016d20b65cebbf1.camel@kernel.org>
 <DM8PR11MB559180D1BA05B0E77D354467F6F49@DM8PR11MB5591.namprd11.prod.outlook.com>
 <a94e4098-f5c1-f9ff-fab0-c2e5210cf188@intel.com>
 <YmJyYwp9UHRLWaTw@kernel.org>
 <DM8PR11MB5591CACC6757FE71B3E19FC3F6F89@DM8PR11MB5591.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <DM8PR11MB5591CACC6757FE71B3E19FC3F6F89@DM8PR11MB5591.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:a03:333::16) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 936a1a62-450b-4a3f-dbb9-08da27172ab6
X-MS-TrafficTypeDiagnostic: MW3PR11MB4761:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MW3PR11MB47616EE37B3C6B400AF07D35F8F89@MW3PR11MB4761.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yl2pfA3SafLgeieN9PiC1IeyBeKOpsW9Sshs/2L5AEbaPd0SpVDC3qGoI+zEmEXArBcYRz3dviOzLMMzz4IhTSidO9NdBqotMQb6sJhm8+KAHCTtvTUPUE8vDnH1tfPFSbW8pVv2EVx3GAbVwGtexPwKKtrxfY8Hj86rbDuU6rgxN0llMb8H3irkGfT+pcQD5ZkQfnkY8PT/rrYLaNAzbuwQPm5f+mkfS1CEuLpS7geajM1m9ikbZw+r515aIsq21TSXrEQ9jjFzLGjM0Z3qqIHeoWPbTqeIWudWMe2VcmZtOVMD19MMBUGWlIARiCI9t1G+7Alg3hfAXi74bY4n/Q7rAh7C8MIOtYM1ENs1Q+BgbFL6qQhkcA0ld0a4EqyQQY+MnYJ/S8+Ue2sO9yuDafVNz3NVSS/FVCqg2LcwC5+aF1IjBe6/Ls9BMZ4zwk2mwKnkS0oFW0fGDaDkfsnytF3SOmmRjIQ4Q0TZGPYQgqg5q2s84zh6MoKavG6PdGmpiIC43NXOLYB2QZEYWbZnL9oKpmv6HJ6QN1XwDHswakYDeuR6UrCst52YTph9BE3zMQhXEDYKGqZVtkzEyfgtqIoxX0zRpIzm1Il4xOYGOKdHw8cCE3RrbGA/PHcWea/xqHe1PZKUBuIV2lBjD+PQb4WeAZuZC3Qqg2XeVEUSFxDhmBZOT8yRJ3/dXrTTxc3oyt3/ppQuRNQJ2DKLsh0UwclEmd+Bu/u94aoo3VRxezi0XYOhsZfwkbLWhenweulh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(86362001)(6506007)(53546011)(2616005)(5660300002)(66946007)(7416002)(8676002)(4326008)(316002)(31686004)(44832011)(36756003)(8936002)(66476007)(66556008)(6666004)(6486002)(54906003)(26005)(6512007)(38100700002)(82960400001)(31696002)(83380400001)(508600001)(186003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnR3V0YrTWFBNmxvLzF4eVVteEVqaU9wTzhiR0dpR0tScTVxbWtoUUs3Y292?=
 =?utf-8?B?eVJESkRCNSttN09LMGs2clZXOEVmbkZsN2JQZGNvL21pWEFLT1BCVmhzL0ZW?=
 =?utf-8?B?K0NVUERNMjhQYkwzZ1c3VlNpQXdxSktYMThzL2dVQzlaZWk1d1VILzhrMFR2?=
 =?utf-8?B?UjU4VGo2QkUrb2MyVzEvdThuTjlTT1pqM204ZHU1WUtCQWpjU3RLM1lzK1U2?=
 =?utf-8?B?cW1kOW5HN1ZubHZaMzlFOExtUFZPek8zbU56bjVwVzJVak16UHFhOFBEZ08w?=
 =?utf-8?B?cXgwWFRKWGltOUxwc2RMckhXZ01YaTIvRkJWZUpUclFTRE1TYjhxYU9rNldI?=
 =?utf-8?B?SXFWQ0dHa3VzUmwvUTU5ZytSSUhuak5LaEI2NEtkNkMwTCtsQkpYTUlXdUUw?=
 =?utf-8?B?NDUxWG93U2U5RHpheXNXZWJ0RHBRM2RxOEE4c25MbTNta2gybVQ2ZlMrVFhQ?=
 =?utf-8?B?dUNoWVltYVZnQnNDZWdCcDhCeXcwams3WDNVY1FlT2cyRkgxaEIreXJKNmdQ?=
 =?utf-8?B?azBWMDNicXNEWlgxV3l6K3lOSkh2L1pTM3Y4d2FGZlFwSUlXZzFjZVVBVVhS?=
 =?utf-8?B?ZU9TTWJrdVQ2NXVXbGNNY0JBZ1dKRzlOYUNhNmJkZGZ1NWVGaEdCWnVwcDBp?=
 =?utf-8?B?dW5FN21KaHg2bkJlbDV6cWJtVUJQOTRuLzZFT3hZLzk4VlpMaGgyZlBhOXo0?=
 =?utf-8?B?MXlMWjdVS3BIV0x5V2ZER1hLTXR0ODlhQ1BCcHlPZ2c4NDRUbjJ2SXVPMGZZ?=
 =?utf-8?B?aUFCaEtvaUpMWHg2UWxiTnBiRUkrbm5ackp2TnoyZkdFZndGamxZMmdXWFND?=
 =?utf-8?B?TzZGM1JUWi9TNzZJTWNWYzhUeDVyQVVWREhITnExUUw3U3FzSjVScHJ2L0E3?=
 =?utf-8?B?K0ROazlTRGxPR0czT1RlLzV5VEtjcTVIOU1OWG9RN3NHbWlGYm1pb2RnWGFn?=
 =?utf-8?B?V0JoTnl6UTdkMTZ1aVNhdUNWcjZuWk9rWWpIcWF4N294MHVycXlVRUMxeE5a?=
 =?utf-8?B?SkhLM2VTQUlVbzg1QmR1VTZNcUwxQVUyZFZ4OWtRU1FleE90dWVURm90OEVC?=
 =?utf-8?B?Z0F5V2dzalQ2SFVRQTkwRGorKzJiU1V5amJyVzVZWHY2bFNqZGcyTllTL3Fu?=
 =?utf-8?B?bzRvWDBzY29RUVphb0VtSWRnY1hENFMra05FMkZacENJR2kySTZ1aHZwWk55?=
 =?utf-8?B?VldPYjNqSkt3cVVMV2xtdUVXNkp0Zm9mbjkzRWloWkw5ODdFdTdUTDYxM0x1?=
 =?utf-8?B?MHJDT1B4dTU2Z3FBalhHdW05VG9OcHRXaVFaaGdZSmhzT1VEY1g1S0VzV3dM?=
 =?utf-8?B?aU1JZy8zZE9qalJyREdrL0RyaFNJc2JHbWQwNGtoV2tYclRFN1loM0NhNGI0?=
 =?utf-8?B?SHE5TTFITGE2WWNZd2s0bFJQYi9xYzJJOERLWHQxdkFaSm1DQlIrZDJCekta?=
 =?utf-8?B?WGhya0JGVzhHcHA2RUxFbXhVeTJraW9wcTUvSGJ4L2VQdjZDSEVuUDhFdVpT?=
 =?utf-8?B?QnlyK1ppQ1h2ZmpEc0cwMVdNbFM0eUM3U3habi9FV1N4OEtBRnUxMnF5byta?=
 =?utf-8?B?bnRsVnJPS2ExYVRYa0FsRmhobnd2RHZRSXRmZks3TFRaNGxsSm9nZUxqTFJl?=
 =?utf-8?B?SitqMzhoM1hLamd0dXlySC84Z1VhMTlhaXpFZzlnT1RtVVlvaCtaNURiakFT?=
 =?utf-8?B?SEQ2Y2FSV09GZzRFbnd1OGdqSmtuaHNLR1ZKZHQwWWxFT0ZSbEZvZXRBMjdJ?=
 =?utf-8?B?eVJEUVdYQ1BHK0FlbC85ZG5XL2FTcUQyZ244ajA5VDBMOFFlNDA2MGRwKzBE?=
 =?utf-8?B?bFRpeUduYkgvWlpyYUc1VVBPc2lZeVhERTRLSmhtV0w4NFRtNGxuU0pKVFdv?=
 =?utf-8?B?VjZteDJNcDF5QnFDT2QwZWQyODIrMDFraFRwYWRzd1V3empnaGhvekRZNUNw?=
 =?utf-8?B?eHYxVEgrSGZFUlp0ekdSamp1Q2dlZnhoMGM2akJzakRUdUpyQnhIb1hoWXA1?=
 =?utf-8?B?SzdaZ0RKZ1VtVDBTN3JMR3UxVnZaQzVrQktFNzdOUGlQK21CUUVaeXZiNVhS?=
 =?utf-8?B?UVBpbFlYaW9pSVpGZ3M0YWtROXBVUlZNL2dveHZvc005L1drK2gxZ1gwZklt?=
 =?utf-8?B?blJ6eTRVbHByUmF6MThXcTJ5Q3hmNkZ6TXVzaTR2NHZoenQyRWFGZG1NRVZF?=
 =?utf-8?B?N0VFUEhCaEdQeTlmZ3RYaExLTjNVTkt1OGpRcitzT2FRSUg3Tmp0Y1FIRytx?=
 =?utf-8?B?S2VRbWVOejlDYU9WMmtpQ0VQZlBreVhWblVDZFBjRnkwbjhNR2pQdVMrdCtn?=
 =?utf-8?B?UkxIdVRoelAvcDhkaUF0Y20wS1Mxc0IyQVlXckVwMHBNY29KWjA0OHZvempZ?=
 =?utf-8?Q?K/ziq93nVfq7eIxo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 936a1a62-450b-4a3f-dbb9-08da27172ab6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 23:56:08.2891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqi+z2IG2GaSZ5DjM8mhYeBKsFhTi8rgMGfJ1m0/A2h9bZfHsMs5PuzF6xCqlitUwxsVN9Sppcv+NTRgqc+nlqmAXdYDxerGeACLWCmg6+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4761
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Vijay,

On 4/25/2022 1:17 PM, Dhanraj, Vijay wrote:
>> On Thu, Apr 21, 2022 at 08:29:31PM -0700, Reinette Chatre wrote:
>>> On 4/21/2022 4:46 PM, Dhanraj, Vijay wrote:
>>>> I evaluated V4 patch changes with Gramine and ran into an issue when
>> trying to set EPC page permission to PROT_NONE. It looks like with V3 patch
>> series a change was introduced which requires kernel to have at least R
>> permission when calling RESTRICT IOCTL. This change was done under the
>> assumption that EPCM requires at least R permission for EMODPE/EACCEPT
>> to succeed. But when testing with V2 version, EACCEPT worked fine with
>> page permission set to PROT_NONE.
>>>>
>>>> Thanks to @Shanahan, Mark for confirming that EPCM does not need to
>> have R value to allow EACCEPT or EMODPE. Given this, can we please revert
>> this change?
>>>>
>>>
>>> Thank you very much for pointing this out. I can revert the change to
>>> what was done in V2 where the only check is to ensure that W requires R.
>>> This is a requirement of EMODPR. Could you please check if this
>>> snippet results in things working for you again?
>>>
>>> ---8<---
>>> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c
>>> b/arch/x86/kernel/cpu/sgx/ioctl.c index 83674d054c13..7c7c8a61196e
>>> 100644
>>> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
>>> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
>>> @@ -855,12 +855,8 @@ static long
>> sgx_ioc_enclave_restrict_permissions(struct sgx_encl *encl,
>>>  	if (params.permissions & ~SGX_SECINFO_PERMISSION_MASK)
>>>  		return -EINVAL;
>>>
>>> -	/*
>>> -	 * Read access is required for the enclave to be able to use the page.
>>> -	 * SGX instructions like ENCLU[EMODPE] and ENCLU[EACCEPT]
>> require
>>> -	 * read access.
>>> -	 */
>>> -	if (!(params.permissions & SGX_SECINFO_R))
>>> +	if ((params.permissions & SGX_SECINFO_W) &&
>>> +	    !(params.permissions & SGX_SECINFO_R))
>>>  		return -EINVAL;
>>>
>>>  	if (params.result || params.count)
>>
>> Just adding that it's fine for me to revert this.
> 
> Thanks, I verified your patch and now I am able to set EPCM page permission with PROT_NONE.
> 
> I also verified the following SGX2 interfaces,
> SGX_IOC_ENCLAVE_MODIFY_TYPES
> SGX_IOC_ENCLAVE_REMOVE_PAGES
> SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
> 
> And also tested dynamically adding pages to enclave using #PF based approach and this works as expected.
> 
> Please feel free to add my Tested-by for the below patches which test the above IOCTLs
> 
> [PATCH V4 16/31] x86/sgx: Support adding of pages to an initialized enclave
> [PATCH V4 15/31] x86/sgx: Support restricting of enclave page permissions
> [PATCH V4 18/31] x86/sgx: Support modifying SGX page type
> [PATCH V4 19/31] x86/sgx: Support complete page removal
> 

Thank you very much for all the testing. I will include the above snippet into
V5 of "x86/sgx: Support restricting of enclave page permissions" and add your
Tested-by tag to the four patches you listed.

Reinette


