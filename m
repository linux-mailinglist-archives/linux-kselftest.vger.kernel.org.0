Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4830D752D3A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 00:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjGMWv1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 18:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjGMWvZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 18:51:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF802D46;
        Thu, 13 Jul 2023 15:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689288682; x=1720824682;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ZSQ+mE5IDdzCmSHKC36/GlJVM5qa6vYQ1CAuVxwxKeA=;
  b=Z89GLY5Wfu3sMbY8SOGWuxxHsmRfqbTcRIajPLIo6ZRIWbPD6C7WJMBZ
   gz70k+H7lGXKl/P2ZtdThTEKQsBP5ocqXoIwdPlYPBlhSYX7uHT0bgxBx
   kW07ksFdTFrXIQ35xC/jZUY4xafZUVA4UHWtRJgZ3FDYHmPhm5rz7POko
   NJSkmHspXXtIkFJ5My1NFz70IM1RIjEnnIl6xl0nvEoBAIN/OQPpu+Qex
   HpllqLxmqdswghs1/ULBctD9/2VioXCvCupscBwKxACLQHo9k22K0Owp1
   NAW9/DZ2fpXEx8tAMv5BruK27aOLYxQn0eQV6Hhh9wgif0pr2PvBam0Bw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="355271847"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="355271847"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 15:51:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="757347016"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="757347016"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 13 Jul 2023 15:51:16 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 15:51:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 15:51:16 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 15:51:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6aspS8ftQWlNvp7zIOAg8CvJFCZzdsVVncHdlhlN4XYhGlDa+hSkJDFqh3f1Ywt7UL/e1Eg4/uk3jPGG3bTv/deEpccslt17JkoX7B0PNo+ud0UHTslZn49ljz3hbnatq8cVA58WhFzrK5UapL62q4tAwauNmXST/xdKbU3V24cqOQaF/P9lSnihaU4LAl0PGEcnClhACOGnClqNP+djbKQpcHD29v539fSOHt0y+XeDqyRn5s+yE+ov+FV9/enNBkVt+dB+eWWPfdGwacJ4XIvhWXc4N0DJJ1dYA6CqMGVn2qpG0ZRDbDcNS8MPycVbjWbpduWRq2V/5Q8RHMuaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSgsrMHxfcU79L9N0PzLL6AbiWsm0Ac/f0oJiA+Ygrg=;
 b=VX1fO0lH0oK+W8wEt0hGMx3F0qSaEEPx9NgcVMLpwORmZTCkHjEpmLqJmDc2VcxYQ6oETVCQplWS8SlUbFDt1om/nM3W848cj6wUlNBNVgD4oECFR8xNm9xEGl1zOw/ZpWCVH66lSA0w3XuC0Qv2EwN0oGFPRtmC8HgHW2fhruHT8yG5qbdKf3tMC95Ah0pJyhImma6c41t2sjnaB+lx1ICiRzyqavx/9PEQriDThAW9lLhj5YLZdWL2QSpqcjWmThjYhSpsC1srrGxhawcZ0bcu3FaSft8u+wF3+rs7lT/w0hirWRIcI169sCJP5dnCQzrznAJUfK1yWOG9JhTSTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4689.namprd11.prod.outlook.com (2603:10b6:5:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.26; Thu, 13 Jul
 2023 22:51:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 22:51:14 +0000
Message-ID: <b4fe2ca1-aba7-cc0b-b8a8-751181e11ee8@intel.com>
Date:   Thu, 13 Jul 2023 15:51:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 03/19] selftests/resctrl: Unmount resctrl FS if child
 fails to run benchmark
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-4-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713131932.133258-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:303:b8::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4689:EE_
X-MS-Office365-Filtering-Correlation-Id: a79a94fe-3537-43ae-5d50-08db83f3a90e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0FRi7w2LgDZ3PjXcftsoW9zrr3vyYYIIESaUwAJQSQkSzC7rQIu0ZSfp2FaeDesoACz3LRskBjbhp+DMKrj2pdGqvsG4g5fkrNg+XDQSNHkZ2Uk1QjoHNoYPmA8HwgDptQ1ylSyk3+MCuTGMmoXBYemgmc1VcLZCM8v7hBYACgi6aDO3W44UsR4gOi/gq+Evl6sEJzCBwLvpHARnheYg9goUqMXupE6CfYWiDy4PtHq434Of/I1T6AjdUopq4RJTdvFuTAzqmX3ZrHRjBp9rFrz/kyhDKLZ3m2PhcjmGAOXVHCRHGZfghlNu30oYi+9fcdaiXwQBupXndAJAxIOvK9OivxP9eL0mNCckUVNadJz6cy2Epsz7oZZHPYu1MlcJgEOlGp1eASESpvzQGHsRuN8HugM/MHnL2EX0LS0S7pjad+HrrNPK5FY2VtRFqWxsD69ViIw9owViGBCH19XdbPDVGJ1krDV8A3mGnSTfWeezsuT9iRayGlum/+CbRGu+Dwp3cw3Ds16UGNP0p3r+eAasRnjYw5wRiY92AFyYlu/01BxaDBCzdOHxVAq7bsX3vG6NCQC6tfWKhEpZoNsaAU78Umv96OyWSYRj3dgq19DhJ7LBrH+QfuFByjylS6HOxms/bMJJssfvriHRP+FTnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(53546011)(186003)(41300700001)(26005)(6506007)(478600001)(110136005)(31686004)(316002)(66556008)(66946007)(66476007)(8936002)(5660300002)(8676002)(44832011)(6666004)(6512007)(6486002)(2616005)(4744005)(2906002)(38100700002)(82960400001)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUc3T24rdE9iUkZ0MmhNS2I4TUsxa2R2ckROOGV0dkVrVExFcEhncnFDMndZ?=
 =?utf-8?B?bHNEYlVZZzVSZVlQTnVVb095c2hCWitXMi9YV25CZVZTMEV5Ymt2K3pweVZy?=
 =?utf-8?B?emViTVM0TGo0WFpMWnRiSngvZHlZQTd3amxqTlFrRkFaS2ozWU1FM3ErZFg2?=
 =?utf-8?B?dVNHNUJIdGdyQ3g0UTEzNUFhdnFhOE5vWXdrOURZRTVQWDNqblJSUmQzd01u?=
 =?utf-8?B?ZG51V3pBVHBYaStlNlIzRUhOWkkrUFZVMUpua2hGVjFSR1MzZTJXRHVrWnNM?=
 =?utf-8?B?Snh5TEwrbnh3L1diUnNzTHdEbGkreDV2ekxCaWZHU25pdWxJb3dWRGpzdmQv?=
 =?utf-8?B?dlQ1QTJaK2ZkVGozK2VxRXBKTDA0dUdrNVpWa1VnWXhaYjh1RXl5NlVQcjJl?=
 =?utf-8?B?SVExb0Q4bWVURER3bVdmbjhnRUhjNFhTRWN2cmpzOVlQR1gxbVNHMTdiNHow?=
 =?utf-8?B?YlhWOE9mQmlMSlVLMlIvTDlCU055Ny9EZ3B2U29iSzM2WmY0VHFUZFh4QnJZ?=
 =?utf-8?B?aXJLZTlQVFFkYUpiK1crUUVTZnRkcWlkaUxYOHBlT2IwaDFxMmQvQ3dwMjdO?=
 =?utf-8?B?eVJNdzVWZlFnMEJZaHd2Q0pKMUdES0FBSUQ3TEw2U1ZEZUd2alpETGtyeDhQ?=
 =?utf-8?B?WTBiQ0FITzhwY3J3OUJ4aGFqYzNzOEtKV3pUMGRqV2NsaWowQTBqOVdIZGl0?=
 =?utf-8?B?VnpQenl4WDRoQjdreTNBMHZIRTNKSFNNOTRGMnB6ZmFFQldOZHYzU2FzQXVX?=
 =?utf-8?B?MDh4a3Avc0QvS0VBSDE3T0VhaUNmUHFQR09OOUdYWTdGZHJZR1lxMEMxRk1m?=
 =?utf-8?B?dm4xaEdHaUVpMjRNN2trd0hiOU4vQTY1TjlzVC9vMlBkdUJSYjhZTTdJL1RB?=
 =?utf-8?B?TEN6aUdYL0ZzZkxSbndaYnByUkRZWTNyWWlDVXdQRVF3OXF1YzFiaXp5RGxj?=
 =?utf-8?B?cWkySFBwN3hXTHJKWnBvT0dlM2xrNTBlamMxVHRrV3I4R1UyV1g4bVZqRE9S?=
 =?utf-8?B?S2dBVitPejVyNm9ualJhQUlKc054OXpSTFRzWkh5Wm5hWG11MllEOWZ1SGxl?=
 =?utf-8?B?aWdlMHlnUDFZdWpOUkFDTFl0U0J5WFQxUnd1OW5Jc2FlZ285ZTd0K3FLVmtl?=
 =?utf-8?B?UXRBbENMaHNJLzNScGNmSTQrVnNZTUJGdHF0YkNaTGlxQkRLdHBWSDNMM2s0?=
 =?utf-8?B?dXEyTkhpMDllOVo0aXFsd1krMGRVRTZXRGJraTAzLzZiNk9oTW5UT2NpM2ph?=
 =?utf-8?B?d0tVQTBUV0FOTWJESHlxOVd6YkdKeG50ZjI0RFVucEI4M3lsYXJOWlRkakZO?=
 =?utf-8?B?QXFXWk1tM2krUE85Y2RvVWxxaWdLQ2ZVa3h2eHJnQlpvSkVOa0JuaU1yVGtr?=
 =?utf-8?B?MCtkR2RlS2VRR1Z4UTlQSnpOenVWL28zbmJUcHFUTDhlVGs1Y25CcnhrRkEz?=
 =?utf-8?B?bytIWWxWTkpJL0pxSEJSRUFnNkh3eXRYR29qdDZydXhEcU02aWRBbzYxU3o2?=
 =?utf-8?B?Tm1xQk95MHBCdnYrOW9xbHdHRHBoSHpFU294YWl4aWdibkRrSHQ1NllYM1JD?=
 =?utf-8?B?OVdaUG4rcnp1VE4rZlNOdCtoeFBSRWliUW5sa3k3N2U0MlVDNjVqUnRsOWxH?=
 =?utf-8?B?MkUxV21JME1OTGJTdjk3N3lzOVlCWU9neklNUWJ3TGhaOEhOdnY4d0ZsWDJk?=
 =?utf-8?B?SWtVV1RXYnFwL0I3akNBaXFhOTI1YmhERW1xdTAreUUvNHFjY1lXTlZBK01l?=
 =?utf-8?B?bXNZeVlsbWpkSFNNdERqZForUnVkeFMrbkloSHBsSmhoVHc1c0cvekJpdEtH?=
 =?utf-8?B?cDJ5RkE0cDcvbmxnZFRFY1hyTHo2ZXl2RVhuV3BlNWRDWmw3RVEzRjl2MnNi?=
 =?utf-8?B?R1hvNFFMYXh3cEk1RDA3dmIrdDRnellVZ2hWVUhEUHU2RWN2Zk13LzZWcHhY?=
 =?utf-8?B?MGpvOFQ0TVFjb2R0elY3dG5jeENEaUVPb2k1T2NZeWEzTkhWa1RKUVVpdDVq?=
 =?utf-8?B?VytTM1FUTGtVVndkRGNCR3pvNWxDMVlaWU5BbVlHanFYdzY5eHJPOHZ0Z3or?=
 =?utf-8?B?bXVkRGNUY0VLZE5mOFFKbUZKeFExZCtEaFpkRWhxZkJRNy9UanJSQ2s4NEJE?=
 =?utf-8?B?dEw0UlJOdUN6TFd4c1FNVzhHZmRxUm51R2kzVDdyektYK2dQTEE1Z0x3K2Iv?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a79a94fe-3537-43ae-5d50-08db83f3a90e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 22:51:14.1072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0X/KbYO5w+O0Ltct3VQ+nx3IdYi4+l0z/s4sCs4qji7p7tMR7ccO8IlQHS2HNY63lLQxO1b8ekQ6VsYwCelH+lDwZ64bBhnkmwwSLphHfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4689
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> A child calls PARENT_EXIT() when it fails to run a benchmark to kill
> the parent process. PARENT_EXIT() lacks unmount for the resctrl FS and
> the parent won't be there to unmount it either after it gets killed.
> 
> Add the resctrl FS unmount also to PARENT_EXIT().
> 
> Fixes: 591a6e8588fc ("selftests/resctrl: Add basic resctrl file system operations and data")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
