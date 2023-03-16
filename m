Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36ED96BC219
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 01:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjCPAF4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 20:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjCPAFr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 20:05:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABD3BDE3;
        Wed, 15 Mar 2023 17:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678925121; x=1710461121;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=hl85tWK1jXgbi4uppdC6TH49H3R5ttCcXzE0ipR11wk=;
  b=R+81R9hRWbTCOUA1GPfFe0ZuLWRNrcwnA9LycMYPC7KKoXD+0FBg3Plc
   7q2+CKAQBnrRk3CzrWJffy+iJ0WajfNvJpxaQB72S3tMHUU3qsD6JRRL/
   mCUraUJV18KK3kdWEnazpU3W8ojlDlA4W4X0kgO7KJfN3gYRjK3lwyGCu
   X/PIkVZOumSJ7/ES1RsP4fPU/SCjLcMoqMlIsN6fR4DHnAEWqjhoCAFTJ
   FOrb0r8f4yXm9JjqyCPK/jfbZi5D2752Gh8C+sj6Ddnbh4WxSjxnJSg27
   ZA29MrvvaCCoDJA+YxrgnFbYR3XvV/TFqYwyzKNXIe5te492Gy3QbaOes
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="321690023"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="321690023"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 17:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="853795861"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="853795861"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2023 17:03:54 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 17:03:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 17:03:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 17:03:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJBmoCimTng/8Ew3auAMSdvX1bPdvf+kf36pIZUnPG4RzLLnKy8UKa1+vsAaToVv0knwLjEy6YtQEQ09Gmi6LlRtkn31Mm/pwcTdY9EVWVmo04PfPIBK3POqq28KH5uxdL72MzjgDXysRX2n0afYyT6nllNNeRiRlrPbNTuvIDW5rPYzSDT9LhJN/esawhEI1aW2U5yW7B+k0v6AW9zGbTmtRK+GV4biNoevZLyoXWep/4qGogQ2zLES37FqvnPo30CR0jsgzzL9lgZZqQkQ6JXVijwP5YZuhypkZrnGwC6Vjyxk6MizOq8ln2UgPQUnFzskmUzV2Bp/a6TtX/hI1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feNAUJ9q6iGNfBTCNs0GaH/LIL4cnR3XCxRsMUoufkA=;
 b=GRLfP546kmlBgoDzBf6I6mve15a8JAuBXfKTNbYGHAZnKQqpWIALaQM5r3ipGcRAKf+JZji1vEgNVpR0KUcrgvFk0jzbDvwEC+7W/9aUQE5rosovsLz87N2jdXjABhKigV7eZGKTs8A0ueqdevS7fArul71e16v69q6rkoxfTczKRuktoTspLzQkdhWIiGUA9Q1d8MjG8v2y+ci6QqCGyGwGcZs3RZpih77hjyJh3ZdKQdX7fxHi/DN2XWbHQoxqewRl46OuEapDYnXP+T37hkZ0luorZJ2kcxj2EF8D3eqshIIffAzut2nwShQHH5oXEXzE4dLz5H76IGr+9pc1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5340.namprd11.prod.outlook.com (2603:10b6:408:119::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 00:03:52 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Thu, 16 Mar
 2023 00:03:52 +0000
Message-ID: <2e4460cc-45b6-143d-5571-60b109adcd10@intel.com>
Date:   Wed, 15 Mar 2023 17:03:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v2 7/9] selftests/resctrl: Change name from CBM_MASK_PATH
 to INFO_PATH
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
 <20230215130605.31583-8-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230215130605.31583-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::34) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN9PR11MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: c479a1ed-f94c-4688-a9f9-08db25b1ed12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7I49YPIoiwBBbYArur23J2SKlhJBM+YJcKAYXAeoFHeMmOxI8kg9qoG1kaLigX0yxLkQv3y4Bx5dy1en6/i77gPkHtFgbdwh7UdLcxMbqb0V8gCDM2aQd76aVsL0dPUQyE+OwQdKtUi7t4Z1lLZEaVD5hgcyiXyk/P9Opyfq8WTL81/FfRs/P5HF7r/0uFVuCtzdRGqkug14X6jDYNmGtqaB/Hc+BDO5cdC9Ap/0MgSGaZBJQF07JVWGzHr9jjlR7kGCyyQeZIB2naoNmElnUNjPOC24Csmp7WnxQtpoM/+r4BfEmhEgiS8LYX6wFDO26GSoMlVxR84OoXw9iD8m5EsQHE5ezc9PPqrtqEMJXbi/hPAdYEh9E7FflE9xHi+P9MaEDp80Ncc/pXY1YwpJWMxbTqV1FFOwXoigmOCfcJXq5/RoIbUovTSD3Lg1Twqqu0GySxw+3IiyZzDmdu+gRh4Gsu4MG+ZMuhMDuGFY+kndTvxbzJhESgzLxeNLWS0cdeJYKCDQvhJihMUGUwanXiqoxQPvqEIJj9OzslKKy3kr/daY5qhCMW6ooEm5H6eQiSPjaRyZey3jpg5KKfdOR9tDm4nQ7NWahdhMjQbUh0MVDn3bqLu1bL4HScH8WIEPcDwRpV13x5S8+ifQLf/lHFHIMUHJv2WDNeES1HePW2XJmjLzQpmbyqkVMvHU7OCi8nvnDbkNelhB1sHaeyMgFUqDxrDgWJfnuqEoZjk3vQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199018)(82960400001)(31686004)(2906002)(5660300002)(4744005)(36756003)(44832011)(186003)(86362001)(110136005)(41300700001)(31696002)(66476007)(66556008)(66946007)(316002)(38100700002)(8676002)(8936002)(2616005)(478600001)(53546011)(26005)(6512007)(6486002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3Z6cWZpUHpWUXl5Z21JaVFnRFVrTGFuRnRiazVabDJTQyt4S2xGWmlYVkIw?=
 =?utf-8?B?TXBnamJ4WlltU3VwZm9QZi9rOHUrcngrdWM4QTJ2b2lFT29qM3FubGVmU0NZ?=
 =?utf-8?B?MWVqeGYySjVYL0hOQnIyYWRkbzNiSmJQaVRIUngyeU02NnltYkJ4eWdMY3R5?=
 =?utf-8?B?OGtDMytpb01EMjZnQnUvbVJqVUJnTGxNNWNwaE1zWTkyS2R1bWZVOU9mSGFo?=
 =?utf-8?B?NGtWZFI2eHFObUpxRVpGZlRqenB2cHMybWNWbjNKY3VjV0p6Z0lVYnFvNnhT?=
 =?utf-8?B?QXZuTnZlRWRNSWUyOUxsemV2VXNzM2czVXpPa2VkK3o4eFZRS29JUkRyeU92?=
 =?utf-8?B?dUxIS3FKQzY1RndiYkJlSTFpanIwM0l3ckpkeVZWNFZzc3duZG5SWmVzSDUz?=
 =?utf-8?B?cktnKzM5TlNoTkZyMSs5VG1TRmxTMkRGTWxaM1JwcGxmSlN0Zy9YcmwweDJH?=
 =?utf-8?B?NUNGZFZacXRSM2hmbFNldU4yYlh0Z0JwenkyeWxjRlNlbzFZRlBaaHJPNkt4?=
 =?utf-8?B?TFN5bmlaSVFNTjY1aGRyYlBQL203bFgvUDVQN2phamxUS3hPRWVGRGZiZnhu?=
 =?utf-8?B?bndwNkxac0VuLy8xb001cDYxbm5YRzhHMGdjMmYvSTh6Y1loYVo1bnpoekVs?=
 =?utf-8?B?ZnNMUGJZb1BhU3k2ejY4UmZkSTRzOGU1TlRzSTNUcVYvZkhFTEJUeUNDVGFu?=
 =?utf-8?B?Zk93aXI4aXprTmdhcjVJOVk3ckdZTkQzZk1mMFBqSkp2WVAwN3dVZ2QwZDVZ?=
 =?utf-8?B?YnNTWFBqUmg0WWVQUGR4d0lGNkRhU040bUU1eE9XcUZ5VGxPaytmWU9uNVNQ?=
 =?utf-8?B?SUhUSHNQYUFoV2c4SE56ZHhicnVyZmo2VFlXU0tMUEdkNE9KSHh3eGo2OFBD?=
 =?utf-8?B?cUlNb016MzJzMjhVWDZiOWlJV2ZOMVZmZGxGeUgzMDk0TGRUUERRMnNOdGVq?=
 =?utf-8?B?NU9CRktXTkZyMlJkRkdCdjFJS1REVWp2U0x3N1BpZFhkY1ZnWm5Eb2N0ZGw3?=
 =?utf-8?B?Tzg2SmRSQWZ3bVZTOVVkcnNxSjU4VkFOK3VNMU5VL3dUUEhLaGV1YlYwWFRs?=
 =?utf-8?B?aE5Fbk9adzF3cW5VdEhMbDg2YmkrQk8zbU9MMFZkZzNNdXRCYzg2c2l0cy9x?=
 =?utf-8?B?NFJaWDRRbjc1eDFzdGRNS1ZoZE1vdlhrWjlaSExBTVIzMDYvN2FTUXRJSXRr?=
 =?utf-8?B?ZEV3bXROcm05NGtkNUx1K3BxcE1MbmJNWEljOUg0ajdSaUF1RjVJYXNLQWVR?=
 =?utf-8?B?Zmc3dlJScDNCZHdLc1I3T0hGVk5FbVI3VTB3M1NjWFlDa2swYU1vYnJkMHFy?=
 =?utf-8?B?ZlFsTllNbVRDOU9OYzVNMEp2cXc4WDZ4S2N2Y3pBajZXWFllSEoyeG9jM3VN?=
 =?utf-8?B?NjB0LzYya2dtNi9OSXVUb3JYaForWWUyUlZBQ1IwTWhHMHVmWFhod1JkV1JP?=
 =?utf-8?B?Q09ReG1LQytFbXdOamdyME04bVJGWmVuMTd4MUFmckZLUjVDcWlNeXFPcDJ2?=
 =?utf-8?B?YjdFeUVsaU9mUW54T1BuallwaXNPdHdoOXFDa0g2VW9UMzBaSWw2bVR3dTc3?=
 =?utf-8?B?K1d1M0lKNmdTemJaL1JwSlBtaW5nQzJPUE5WSmY5d2VPd0VHUDFpb211UGZw?=
 =?utf-8?B?Qy9DQ0xtU3hrNnZ5cThLakNiMEJPT2JSZWd4aHdSbkNXT3draXJUejBRRGtI?=
 =?utf-8?B?OXc4R0dEcDM5SFNNVGEvU3Z2ZTFsSzhJRnNwRUpTTGVLcFBHeGphTm1PMm1k?=
 =?utf-8?B?MklNYmZXRERtV0x5MG03N20zTTJLMG5mZTRoNWRLM25Cbmxla0dEZ1NEWHps?=
 =?utf-8?B?cUVBVitPWmhOajdaSmVXM2dkaUFZVUdoTlJNaEx3QkxaN3VGMGtaSy9yVDZ3?=
 =?utf-8?B?NFdrZUFUeEhoMUpZRWIxbFY3c2x1RGNKMHViRmYxMWFNb3lkS1Izb3gwM1BP?=
 =?utf-8?B?blllZEl3aXhaaythWVFkWlNpRkRDNFJMUzhxazVrTDMyamd2UE56QWhsUHdQ?=
 =?utf-8?B?Y3BkenlDTll0ZGtDWXBqQ2VzMEZUMDM0SExKUUFlcGhZc0xDbzc4N1dzcVRR?=
 =?utf-8?B?T2dzbzZlT3NqaVc2R0hRc2hTWWtFVEh0RzdKVm1BeitoZzM4NVlUVnZCT041?=
 =?utf-8?B?SnBpblFjTlhBdWkyejFSenB1b05JUFF4d0Jpb3lWcGwzeVpaSHBqWVBsM1VD?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c479a1ed-f94c-4688-a9f9-08db25b1ed12
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 00:03:52.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5L5Hvdd+9RMtM2wA9o4DyyzB31MOIO4OloAYBfsLIWZVEBmeD9AMX9NWM8PL8igtV7XeQ0eVQ6M01++QiLTL0iexaQbLQfNoXvFCLmTBDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5340
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 2/15/2023 5:06 AM, Ilpo Järvinen wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> CBM_MASK_PATH is actually the path to resctrl/info.
> 
> Change the macro name to correctly indicate what it represents.
> 
> [ ij: Tweaked the changelog. ]
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
