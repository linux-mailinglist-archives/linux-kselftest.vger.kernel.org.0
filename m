Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D4A6BC1F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 01:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjCPABv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 20:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjCPABt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 20:01:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80DE24C8F;
        Wed, 15 Mar 2023 17:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678924907; x=1710460907;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=kKXeJLfKRLeJWCJtoguUp/bDXNY63VOrxShS+hL83Og=;
  b=H5MXHHxXGbJbgIHE4EmuXe+RaovMgQcYrZr1Mk+a46GGDcLp9E8q1olU
   9Rk/R1dG4h1hr5JRAkxelm1YUuLPj8YNZYi4glcGnFdLo5L2SX53ADG53
   5o2y5CPkWJZCmJ1XHjtKB7Ci2N6bswO+gPqjO97nNf7vrVV65WyaSM2h4
   rPphsGQXsnWnniTaU04guPh8Xy+g73/8I0V7GV/D0jrDigYehR6HkTCnz
   lgiueC1FOYnCnvVE1Dy/NL1GDOybxpQ+JIVG52tdFbafGxN0FjUjIrxLT
   qSNOFNS22B90AnyCqtMhoYirw7s1N/TnREHNsSRfLo/1UrpG2ma8Q8wdC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="424119554"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="424119554"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 17:01:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="743906693"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="743906693"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 15 Mar 2023 17:01:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 17:01:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 17:01:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 17:01:45 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 17:01:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLtupiQklbDwWBWShrOiYEBg1COGfL6AZwGEybJzKjm2yq7nFxNQazUv+GvXn5sBV2LB0XF7TWw5dy5jpZKUXLwcQRuFeYQENn3gY61zyet2h+ZC3Z5Mkyr7O9rt27KnI5s4kFAeMUpdIFZhwlb3m8AsjUzLheHfgLg4MKDoYfnv5UJt6/oxB6TFtnS//WYXfv9wg1x2LZ1TL0bpDqfH6HlvkSlRYeQIle7ze0BlAyS8PpkNFfsE0sdfYKIVkoRqUun6H5ULi0MxxO9/Wilr7p8evMDFl6jYCy3ED80qnmVs6ArMEAFvCkJTxDwXdoFRtGjbZKWIGd9txLK/o+o07g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0UZ0f7rQo3cOGeZXOAKp7Ia1nVSNRocTyQKATmdS6I=;
 b=A2stbzj/ZaudSblUrHoujCYcGfre3yrQP0Ki28A6Ij45pMn/XDgbK5GjTOXDcALqniGJ/zmvnkNW1i3sVPwwq1KtDOMCUsPnFKwmdKgkcNuhBrpQg9CApQy6rIHcDo+vzfX6nIAfdwFg3jt75NlCexsTMvMK3tJAuOq5TS0KaAkXiR9gJ3xvFP4MiFqi5he4HQLi/ilGRTQ8EfQIbpUwehBMbDIFE6rZxom1NqTHN0a4Rr5WY59iCCBbBvH4mopBP/B63Q1FKEiEMiEWuJXRAENTJEf+bEeFrTux7fw73/4thhyr9tLpSJ38joQWLslzpKnQV1IhTrAr+++u7gFjCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY8PR11MB7083.namprd11.prod.outlook.com (2603:10b6:930:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 00:01:44 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Thu, 16 Mar
 2023 00:01:44 +0000
Message-ID: <dd0b7a91-14b4-8ecb-e62a-7deb966072e2@intel.com>
Date:   Wed, 15 Mar 2023 17:01:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/9] selftests/resctrl: Move ->setup() call outside of
 test specific branches
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
 <20230215130605.31583-3-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230215130605.31583-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY8PR11MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a82a39c-753a-4be4-8078-08db25b1a0ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXzJzAWMA0qOq+/zSQz0pikqY4y+KKJmyXZFXtAo2GZNVEiOaoj23z+SVEYPSvPO9BJwj95yVmdBnUd5A26wKY4VQq1L67IuOyyBqTgTN3BnifzQaK099tA/YbkSDIalBQl6rI4U90OncB131K1f9qzra8V88mIFUU4f6IWihW2SARpuhBP+lN2AqIGNwXH6kS016DPDWFz4mLwAGY03n9u49nphIJg7BSkLpPoZqRrdRk7/a62Hwj8rtij5cm+zx+BN5zYkbIvJYNk251/2eZrgJQUCgYa7U9RjmjM2DVCV44RwKU58HpZa6XB8IQgctQk0zccHO8rfkc5L7RuSqeQVe3b6/FMCZcnOnlcWRAONHKMAlwMk90fCufiIfL6sQar4mss16I/71biKpd0aTC+QEz1Q2w3JZfITjZqIFTv5H1hY+ozdcMiSH8pWwnGIwTJcKF2H+V/CmkgwiuTXewlAYBYpp8AAhue64RHDYJjVDQrpQhhpVrs/Wk65HmaQfEqVVnFx5RmoBvD4V6fF92I3raZpPAEVhAtsW5usbHTuV6bFaadbHo/Ul8LYtWLWiRuLauAlBQDEja0NvdzPYUev6QBxhpuw6Yc4dST06hwPqxDDPS2V1eROyMDa+RFYpmxRK6NnUvRXf+dO8VMYY6QqAKzFnFU6/ImEYcfCKQRU4XABqQedKcP3c4+531V0cXVc02hHIn+zJHB1QQaG1eUh80dU5qJ+lE7+6+02HwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199018)(31686004)(41300700001)(8936002)(5660300002)(44832011)(38100700002)(31696002)(36756003)(86362001)(4744005)(82960400001)(2906002)(478600001)(6486002)(6666004)(66476007)(66556008)(8676002)(66946007)(2616005)(110136005)(316002)(6512007)(186003)(26005)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1RxeW14VnYzWjlYT1pIelNITkVOUFBCeWt6UjM1alBIUGpNd09McEFyWXA2?=
 =?utf-8?B?QTZjc2NTRjJrS293ZmNybUNkTU5QNEhIcjVTWlVjM2ZGZ2FDQ0t3Y1NhOHB1?=
 =?utf-8?B?c1hXZUNXYnBkazU0TGRrKzVvcmsxSDQ4SjhjRmVGQXRvV1RwdzBwWFQrMTB3?=
 =?utf-8?B?VEZHc0dNS0ZiR0JqbUx6YnNsMm5QSTRoTzU4cDZSNjJKWDc5N2hhdkNpaVFz?=
 =?utf-8?B?QlBQeW1Oa2c3cDNKTWVXaTVxUENDbUhnaEIxcFdwKy9OVUpSM21UVCtwc21u?=
 =?utf-8?B?Y1VjMm1oZjh3aTNLT0tyUzhoQnYvL2dnNHBORFgzUW54Z0VIdXVoNzZVVVh1?=
 =?utf-8?B?MjFRZEFic3E0U0NocjVCNFk1SjczaVA4MHQxSDdEVEZYZTBpU1Z6MW9Jc3BS?=
 =?utf-8?B?amFGMWlkbk9GQzY0Ly9CbjFaYnljajFiRzlDYmtmckp3eVpNK0IvczhucjdU?=
 =?utf-8?B?NFhRZTk4a2xvY2JQWVAxZFFJSVVYSFRJMXJUNlpaY0d4TW14cU1VSSt0VUxX?=
 =?utf-8?B?SFRPbHA1NHhOT1RHYk41RzBSOTJ0ZFF5TTEyeFQ5M2pFVTQxSHJXcnQrTTg1?=
 =?utf-8?B?NkJRUlVWUXkyb2p1amNubStUSGJjV0FrSHpjcXlkUUV1aXVCUHRJYUZzQUs3?=
 =?utf-8?B?cXRkc2ZnT0RrQi91WlV2ODR1c01nOXZXc1lTbjVpUzhsYi9MUkpJaUJ4R2NR?=
 =?utf-8?B?VG8xZ0grQVgxT1FEekVqV0d3VmZxS2ZXUjFuaXdJeG9sUi9BcFVqZkJXWXRx?=
 =?utf-8?B?M0M3ZFFyM09kSkRrODhNY1VlQXIvMXFmcjJvWXFhZ3pES3ZVQmdwZndtRzJW?=
 =?utf-8?B?K2xQb3JZZmQ5Z0JPRVhYQ3dBZmw4S1hmc0VNTFdlUGc5SFc1Rk9hdmVkWUZS?=
 =?utf-8?B?VXZZRW9EZEVvcHVJQ3ltMzJQM1RpN29kVXl3b1hlaE5lWkNPbCtZSTZtMmMx?=
 =?utf-8?B?YWZRR282U1B4L3BNMHBmU1FFRkNZZ2RoRXFmeitTMU5sUHg0VE9UN0haeDJ2?=
 =?utf-8?B?NzB1Tzc2VzRWQXVJMUxucjNURmIzN2Erejlsb3IxNE9SWElmTTkyWG9hUzNV?=
 =?utf-8?B?UmxSOUVqcmN3NWovdVdteEk5b2NXeHFPbklseFlvc3o3TXFTamFPUnZNMng0?=
 =?utf-8?B?T0d0cWNDZHRIbHh6dDRFeU1LbzBIYXRqNm5sUmlsQVhYTDlTVzIxVHBIVXNr?=
 =?utf-8?B?eExTUWtiTnFtY2VPTTdvUEx4RlJDYlluWFRQN0RUTllaVXBnd1FLd2lEeVd4?=
 =?utf-8?B?WHc0UnpXcy9vTStYcGlZYlorR2NvYVdiaVcvM0pLa3pLSTczNFJhTHNsUzZ6?=
 =?utf-8?B?clprdHNKdFVWbkUySmt4OFI1UGxsYy93T2s1Q3lMM0RvTm9BVlRTZEdUQ2Ev?=
 =?utf-8?B?UFcraFhNdFRmVWhRRS9vT3FDM3JScG5MZVdOUjRyWTVTUkFwNVJMU0lPMEk1?=
 =?utf-8?B?QWRXQWNzTmJ1M3RuSXFTL0pKeER1cDhtaUVuMVRlWTBRRjNBODRubEhVR3Bi?=
 =?utf-8?B?cFJldjhWOUxXYlZDMzBwQ3V3L2FWTmpzRVdIUDhsaElKNm9uMkxaUXMyL1NM?=
 =?utf-8?B?OXFQQkp4MHNzdG1LdHBINDVNMXpUWFdpOXpTWE9YRUxVeHNRcit4bzA4QkRP?=
 =?utf-8?B?ZXc5MjNmb1BaZVhERFBUdTAwZFFwZGVKanl3VTl4N0tOandWNm4vejNYR01S?=
 =?utf-8?B?QlVVRm1wL21VQ1pHaFhJaEphVFhJNjdJZ1hLbUxrWlJFWHY4bEYwaGNYNEc4?=
 =?utf-8?B?eE5TNWtTNXkwMHl0b2JrdWdNVVp6UGs0anU5WjRyS1E0U1p6MzZGWXZoa1c3?=
 =?utf-8?B?Rlk0bFJZNWtrMzFLQy9NVEFKZjN5WUY0WEpZT1RJOXB0MGVkR2kxYTNnL3hk?=
 =?utf-8?B?bEh5d05RN2VNRmwzYWJLd2hJMERTaEVjMThHVlk3QWVwWjRFVGZuYjhOWkh1?=
 =?utf-8?B?eTArNlNCRVBqYklSZ2NraWdWckNPbERuQzdVeEhCMWQrV3NiTFhISFg2bVNC?=
 =?utf-8?B?OFFDdDlCS05zV1RhK00xSUZsbDhqa1FvR1BvTUNCZUY0ODdNZ0h5d2RlSE15?=
 =?utf-8?B?K3lFUmJEYUFPUVV1UnJiWmdHK2R0VjNOVERkM1JqTEtwWVhJQ3RHTmtZRzdD?=
 =?utf-8?B?YzQ3V2NvNnBKZnJ6ZVlyV2pRVWJIcW9TNmErcUt0UDVSdm85a1BwUWxkb3Rw?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a82a39c-753a-4be4-8078-08db25b1a0ac
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 00:01:44.0186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDiAfRDEOR9Yi1lLlOmQjjLrUXDTj39LMAwS2mlEQo8+OMxzAQl/0mmWLAd/iFGL2Db+GlaUksBted5/tIXLtWtLDSqKRURlL5CMFE7BkHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7083
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 2/15/2023 5:05 AM, Ilpo Järvinen wrote:
> resctrl_val() function is called only by MBM, MBA, and CMT tests which

Surely not a reason for a resubmit, but just fyi ... using "()" implies
that it is a function so there is no need to add the text "function".

> means the else branch is never used.
> 
> Both test branches call param->setup().
> 
> Remove the unused else branch and place the ->setup() call outside of
> the test specific branches reducing code duplication.
> 
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
