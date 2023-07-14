Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729A3752E1D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 02:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjGNAEx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 20:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjGNAEx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 20:04:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262502719;
        Thu, 13 Jul 2023 17:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689293092; x=1720829092;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=yOffGHQ6m9spQyRISALTKdwrJ4Q2D6dgXn26iCWOhcE=;
  b=XN9jePWYOJ3MauFQUaVBG7XKbRrWizz93lvbMkLKw9FhnON0PhXY60zH
   gDXY74SWOGucg1mJ66sD2qcZ4XiG1LM6+tMWnPrcZwbrVikquGnqU4zAq
   jPduF3J6n/wTYLJUW3QHUo/K+xoo4JWD8l7ZtVzowK1Oq32vZQIYX6iX3
   us1151XqxAXR36QjSgKOJ7Q6/KEPCWHAi9Bv1LTLHXG1de+Dh2sgF3q+e
   Eb4d8ifwPvIsq6XmuDiCnoKl8rzabi3V6oIdwOcDtl4y+Uik//D6bLynx
   E9n6gyA0nEPWYX7JAggBHjB9hMPYrb+/mscb7+fWB4JtgF39VDPZFPXPq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="355286816"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="355286816"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 17:04:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="1052840997"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="1052840997"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jul 2023 17:04:50 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 17:04:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 17:04:49 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 17:04:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLUb/lDnpKijNmtnTev81C4hc4Zm8MzHosmy7kJ1foPe9wmra50l4U7bWMgZwmhNeSIV4d7Gzn6utFqQkXc+DOoqbMLNtSK6pn2XKM8+6TkZIvZcXSrW0aXpS1mOsAeHP5qm2Ot6AlMsu9a8+8kMQ+snJcjHM1U1PaPwoTnFoG84JaYymB0BWE2h8DTL3QwbR/fusyl3vCYV0kvKYaSd8O1EZLb0zQxiDcoZhSHTg+Akxcs7IggZOdq1AvWMcfcpXNx2bIaCUHlcUpbxB6uq2q8SAeu5Z0Zl9869/OR7ICdKpFeZWRp4z8th+Tjkxh7UdwzO4JSyjyvPCLlp+Ga9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnlMZogF+x/LFy/XcDYAj0HhX2FIA2CRtjQRd7kYuqo=;
 b=PmbFlPXv/ZJiGSVUNKVFJkMW+u04x2z5mYLBYdWef2KoOvtEPzo5VzkadUgHtOX2xcxlD1r+I9WSV0xw6VV55wFu89QoecC8nqUYaKYghc8PJOeDkald0LUxGKz33B8sNyq1RgUxehEDNEAa1gBgtcT0ptQPPjPeRkiIeTxQnSCs0u5DSUERIp3ytY5OppAhTmb7R+PIYxqK4NEZcXMq1cIsiNfY2/oe9IOa8gz2wNrzCEhMrK91SxVL/uOl5F85sOpX3eKgYG6S/ndPFBTrZi7h27TJ1A4tGp/K5wGmip+4JNyBosgcwwyv7Egp8YnJoxSY5zxBRyOgYwQ3LKwC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5348.namprd11.prod.outlook.com (2603:10b6:610:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 00:04:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.017; Fri, 14 Jul 2023
 00:04:47 +0000
Message-ID: <2622f293-9de9-c876-2892-bb3a1747dae5@intel.com>
Date:   Thu, 13 Jul 2023 17:04:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 17/19] selftests/resctrl: Move CAT/CMT test global vars
 to function they are used in
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-18-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713131932.133258-18-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5348:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc2eb79-0fcb-4ab8-2852-08db83fdef8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5acoRhylubtts+T87SAgT/3bOL2OXY7mwR79F62GGnO65R64ovVJH6VLxuU/lQ/jaeJKS/vlVnHs70sPML3KN+iWa60SUtzUnL6ZPPJaew+jLieJZ1xsMp5oqnchAQVAm+JhEAbIeufMWMKwtfEXAqB0Mfkw1rebubmxW8L616/K+k7k/pcsx8+11m8Cqmrt27h3t3HfMgG3hQLjH4pEgkXm/ZWOkR039Gew/hM5SDWHIMKzsuCXtbJ4VnFm66PRisTepJGhNtEn5EAHMCoQD9kmatgxpbAXG9V476IB0zaTF2vfjAnVX2r8pPTZYRKlULfOtUjX15how3CaCXvvQX53aj/+WWufoaCuTETqFoSzNYqGJgYZWMpVPQcqMcCRF/spXisy/kKOau5ESHIArhJUONXabHqP9sa+DUwQ2kRoRhLQHBNYLsAt9plYI+dKnu9LIuERHuSapPiM1ZPFzGg0hMPsiSDZM74oaIreBk1uC8OK6XPiLrAzAT7WVCXKbIi/DCSdmGfR5qkvfncCBzWWH+2f46Ph6SxYpm3gQobcA9AQbpPdw51eOuEozy48/VYh/YGiX9sM4nj80rO6GLhSb2YdXnC9Iorkq8PThWbov/5YOcsycQsuDwYGwHWtnWZ9lFoY+4eLUgE2TFGGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(2616005)(478600001)(82960400001)(6666004)(31686004)(186003)(6506007)(53546011)(26005)(6512007)(66946007)(41300700001)(66556008)(4744005)(86362001)(316002)(66476007)(2906002)(8936002)(6486002)(36756003)(38100700002)(110136005)(44832011)(31696002)(5660300002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHRhb0hhSDJLUVkrdzBiQjlhQ2tjSTYzNDdzaWJLY3Ura2RiMzZVT2Z3TEN4?=
 =?utf-8?B?M1ZESk55S0RqYURwc3dPZ3RsYisrWk9xRmxORS9CVmI2ektlWndBR2N3Yzcy?=
 =?utf-8?B?MWZLdk9NNE1nbnFnU001RXRpL2tCQ2NuQVNBNUF0SC9FRUQ0VHV6NGlvVmVr?=
 =?utf-8?B?UmNWcHRLMzlLT2R6eW1HK0drNGNJakhrQXVHMkltYlNlNk5EcC9rUEtzWjBW?=
 =?utf-8?B?ZjFQK2k4SGp6djZSaDJmVk1oODRiSmR4SkF6dWNlemxLdCttWjdPVUViM1FT?=
 =?utf-8?B?eTd5S3V0TEhRU2tMaFlIdlJzTW14K1hlMjlvK1NmeE1mb2JpVFhoWWNyOEtP?=
 =?utf-8?B?aGQ4QTZ6eEs5QVR6ekY2RFdZOTFnOWRIRDZZZ2gxK00xU0x1a1N0WHJ5bTYr?=
 =?utf-8?B?cnZuY1Q0V3h5eWZBM2Y0YnNyWUJvOXNzUDNBOG40Q3lTdGVHQk9RN3IrZGVQ?=
 =?utf-8?B?NEtDL1hXbi84MFNlY2VsZXRqK3ZWWkJlaEkwZ3grZFloUHhCd0lqc29XSi9s?=
 =?utf-8?B?dnYvQkw0ekp0QzFuWEpjOTlFL2dnOHFNSDV5eGdwTXo3RCtucXRwODUxM0c5?=
 =?utf-8?B?UU84bEhqemxRdEZ2UzN3eFlRa3h1Q29KeDdxU09GdVJOUUlHVldVckw4OFQ3?=
 =?utf-8?B?ekdsTHdkWjFDWDg3c2M1c1hnZGoxQUFZVVVtWDRTVnhCZVJ0RmJDbDdqNFRs?=
 =?utf-8?B?aTYrMUpxTHFIalNuZHo5Mzd1UFFDVGFrUS9aWlVHMFhyV2hTV3BjOUoycHEw?=
 =?utf-8?B?dFNVbW9KOE8zN1h1MG1aSVhDWWFQUlNEbnVPcWVCeGVya25NRzltejYvamZY?=
 =?utf-8?B?TXBTbC9FU2c2bzJ1N2kxZkVxdEtDUzNaYWxmWm5LOUVRM3pGMkNXd3BxblVF?=
 =?utf-8?B?SG9MSEFqMkpQUmlueStmZzZPSVJNY2ZZYm13T2ExOGQ3eWUzaGE0OTRpS05B?=
 =?utf-8?B?SXd3SGgrNUNtWjY5QmY5c21kTUNyWkV5SXB6YnBWY2c2QVdaU1FVUFdDbnM3?=
 =?utf-8?B?ZGI1S1MzZVUrbmlyNVkrL09qWmNMcThsVU5HV0ZhaGNCZjE0NmxhNnFEeVdj?=
 =?utf-8?B?b2F1eWs4VzE0UHBYdHpQY3d0V1BYR3J3ZjFYZCtYbnZzZUtlcTNac3J0aWdX?=
 =?utf-8?B?ZU1pSzNXR1owbGxtNVo4aDJobDVPc0VxSEZWZ1M4TENOSVVyK1RlRXRSR2tO?=
 =?utf-8?B?eFZpcmMvci9sam1BYlNMUGg1RGtaZlVWd0oxZHQxSDJ3bnZFNEtJTkxuYjQ3?=
 =?utf-8?B?eHlWTUdvV0cyeUNnRnZGNndzOWEzM0FYcUJyK0E0NzVZdTlvZWd4QWZhcUxX?=
 =?utf-8?B?M08xa09nUFBYSUNMWTg2Ykh6YWJzbEhWR0o4K0MyRzV6WDNOeHc2aEZ2Y0lz?=
 =?utf-8?B?TzVmQnk2QmJPbS9wTDU5S2Rob0JRdXNMZ3pZYWdaMGZXOVU5SkRja2drbG9n?=
 =?utf-8?B?dlJ6aGYxdnp0dlBWTlBMa2phMGphS0RTUVNIWHpYYWFGTVptRmpkd3lwL1Ju?=
 =?utf-8?B?TFdIalhwaUdMNUZqdCtNMmRvbHNXVmZOVWdML2JvQVI3MlhKVmdnbEFndWk1?=
 =?utf-8?B?dytoYjRnTUlRV1FzRXVkUUxINmtJZDhIZzc5dG9mRUVGbE5zTExVeUlwZzd3?=
 =?utf-8?B?SkM1Q04zL0pxS015ZVlDbGNCTW45aVg5ZDFOc0JORnRoUHdqL3RWd0RKdWNw?=
 =?utf-8?B?ZzJjaXJjV2VaWGE1TjBvMTRKUE1lcjJuWDA0MVBmNGlnOGxHcjk0T2tkS0xF?=
 =?utf-8?B?RjZnUDh0c2FSQyszNHpuUCtwSzBncjdiSW93ZW9xZE1DazFUemkyOXMvdnM1?=
 =?utf-8?B?U2dTMHBlbjd1U3pzZFZrbE43anBNQUpZMFhEaXkvNWNhTmQrZ2g2L3dqR01V?=
 =?utf-8?B?Uks2WE5KM2xuYWZPMlF6b2xkODBMcG5pVjJPOGI3MzZKelpsOHV3Wk1KaWxQ?=
 =?utf-8?B?UVZpVnV6T3IxS0VYZXJKM3oxRVBhUEdlck9rSDZoalJVdUF3aTB4QTZCMEdO?=
 =?utf-8?B?VTdpeU1mUS9nb0MrcGpFMHZYdUlDK1BSUS9CT2c2SldCZ1VPZ25STGZ1V3Yw?=
 =?utf-8?B?ek14eWtLRW0rbjJhdjMvRndGeU5Pbk92TVEyd0dMMDErUWNoM3lYMkFzN3Zr?=
 =?utf-8?B?eS9vaXZmQlgrSFpuemVEdU5tU1FTNHBGS2YwUElhV0ZjalFRNHVsclFXanMw?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc2eb79-0fcb-4ab8-2852-08db83fdef8e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 00:04:47.3781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjiIXkzT8ENmhbS3b5QpznoEOYTfBNYGmeJyvMFIBAZwqxXiCH62JaRXmHTa+tezFknX8r/IcoZCcGKCjow3bk8xj+D6GgsHhgbyBboYr3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5348
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> CAT and CMT tests have count_of_bits, long_mask, cbm_mask, and
> cache_size global variables that can be moved into the sole using
> function.
> 
> Make the global variables local variables of the relevant function to
> scope them better.
> 
> While at it, move cache_size initialization into the declaration line.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
