Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FC675322E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 08:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbjGNGoe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 02:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbjGNGoP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 02:44:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7231E30DB;
        Thu, 13 Jul 2023 23:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689317051; x=1720853051;
  h=message-id:date:subject:to:references:from:in-reply-to:
   mime-version:content-transfer-encoding;
  bh=DGViMoVN5Ak4tj+UyvwMI4tg2hI543mMo7OfF7WH8JI=;
  b=iBQtpJCswt4GphGG4o0K+4LhYikduNPwEUInCWSnd41aZnUCAeZlxEa3
   MgNLfUaEG2O6cdNKipD1ZR8eyFdf5/t46IZR5BfPRwwP9nXJ8Kc5bi0oj
   GvWqHtiogmsvec8CkNt7lXKfSK1yxWBNUNX6SGHhxNC6KV2XbjXjTw/RP
   Ny+Qhi5QrXYlNABJw7lz9RdwEZUEgUX16heJW1+aeA+K0S1yPeygLeBom
   M4flNm3IpG46RJ13VcS8dNGiFY10fcu5ZN/HveWuK6QeB6phjMS6RPxM2
   kkJr09UEsca1JtEVVopGePUrZOdL5FVYrzko4o9+YsvJhcZsbOX7HgXA6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="431576357"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="431576357"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 23:44:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="835923579"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="835923579"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jul 2023 23:44:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 23:44:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 23:44:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 23:44:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 23:44:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnUPB9fKKIhHthL+oKWRFWV6qyIax6IJ+UqSm0BAlLka0xS/rmukLVle/d2JlKboeGQtJRH8MHk/foUfXLCBuI7IOSi3BTEkFQvM4m+DpOpTql5rhJHDxTESXgpFytyQUYMPsvYPekCt8VEu+wW318gd84hi3/kgNjjy8lIDDHI1er1Z9q/vU+QNHyzvBEx3tQOVXm9ALasRjjjdkcAv361RqN3kS4Pa/Spg4zoG027KSGRihWSCT/Tadf7Uo7//zMrzggKqcMHms+8uPsL09LFk9At4IQgfZUQyeesDM8CN8jh70A2qtAp9iKVEToZ1VnAxfuld0e5GFcYylABXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXzmO9Z7EM6tUjGJ3yhai6YmXNY9zfVRrf0jTt5gBSk=;
 b=NYn8CETsOZdmULDhA8lUiM6BWxB9Ndvm/bbp//GAHx4tOH2NG28Y/ivf68fUNl51CREm+fZD66VBKRJgShG5exCmmI/HA6T5JYYHsJAPMMQu4ugqSRVUXf4br148gNW1zqEYngykY09GlH+agw7InmGSTdbIw9f7JzuCQOUL5xV6ARjvrOTND7/W9eSNGAn2NzqkakIJvpk3YuRB0Gvtxqe3FDDcFUMkqL2lSaDJfF8PlDa+DebYneilFyIQ3Qhn6+R/8ZS1aKLqntmQCC1acWnmnBK/Um8DdeYafndKu/Nkq7BYqD+ZUk9LXHr6PmdQddQEZSi28/+fDCtCFt5r3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by MW4PR11MB7104.namprd11.prod.outlook.com (2603:10b6:303:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Fri, 14 Jul
 2023 06:44:06 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::cf2b:acb9:e332:a123]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::cf2b:acb9:e332:a123%7]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 06:44:06 +0000
Message-ID: <0c94daef-3642-9e8e-0e8a-3f8eaa2953e3@intel.com>
Date:   Fri, 14 Jul 2023 08:43:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 10/19] selftests/resctrl: Express span internally in
 bytes
Content-Language: pl
To:     Reinette Chatre <reinette.chatre@intel.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-11-ilpo.jarvinen@linux.intel.com>
 <1dd10447-b03d-937a-fe55-ff324864c358@intel.com>
From:   "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
In-Reply-To: <1dd10447-b03d-937a-fe55-ff324864c358@intel.com>
X-ClientProxiedBy: BE1P281CA0470.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7f::11) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|MW4PR11MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: f20d743d-a895-4c61-6a24-08db8435b865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /LAbq1NoMxksg+wNnAcLgSS6SNceZBiTSIPxJFiuNd09Nx/EYOxJX55EZF0GFWOipDPPiTojRcVNWNrRw/yXPJgW9c59fU/AE6kq6+S6uxKBo5SXo39yFfwXfn3F4EDvyuHmBAPpAgVuk3+dPOs7VIb47F9VbnVr4UqOgNC5mzvPaNuaQMQ3GTaCndJaMp+yTz/zOSxIJDultdaK9bnDQPBb1iTXaU9a1bETF2ND0QVMN0nxR7yF8YM2nUcPbawRt1zO+YsGBV4DIWsKDFUk9ISbc+qp68HXRUTIY5lcwjmz2RjAQwO1EVZ/ACHmfSeq3fE8fQyHlNlApYs30Ex0OaUFhcSnNzBW/QCCVnwx9lG4JheFOuwtmc4QPx4IRhBNJIOiAxGwEQtCbVRpPyaCx7GSrFATk//0laJEhmLG6tWP0APusaEqRC7Q3OqNQ+B4NALo8KCZm6wm3vrZC1grmPUdfWHKyoN3VJbfwPZ+iSzMjYDc1M7io9AF8gJR4zayaA1nXhPn4I3ImpSaK67WC83uG1Kz8AOrfj6PQPcR/2Lc0aFC39NJUnFKj1d2Z/OmSKqlfjsvMqo4Qtbmxm61cbTObYCLNW2MWs8cvFmmkInmOI+mjjKzkzihOwsxuzj7WpI44xy5fMWAwCJ8/6ZqWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(110136005)(478600001)(6486002)(6666004)(186003)(2616005)(6506007)(53546011)(2906002)(6512007)(66946007)(5660300002)(66476007)(316002)(41300700001)(82960400001)(66556008)(8936002)(8676002)(38100700002)(31696002)(36756003)(86362001)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzdaMkdTcERvdlZ3QU9CMUF3NmIwbzFySVJoeVJwaDRFNDVLbk82VEpDNGR1?=
 =?utf-8?B?TlJOdTNHd1g3RmJMTkh3Q1B4Wk02MnhKSnd1cWIrTnJzU0FSTGN4MklJOEFD?=
 =?utf-8?B?UkYvTExudXdFYllNaUxwZ3RrVExGcmdlSHhOQStBSWxxaXBIQ3VOWm8vVFJu?=
 =?utf-8?B?dlFDa1pCd1dGcjFaK1NOS01rY05FYnFrQWx2enB5Tnk5L2RsUU16Vkc0NDNQ?=
 =?utf-8?B?cmltendPUVdYSXZFVU5hdUoweE1ZRTlGaUx3aUVJeFhSRGZGTENIY0N3NktI?=
 =?utf-8?B?d2tBZi9KM054RXE1eDE3dXZGLzhNa2VoZnNhWTRHRjhVMHZLZnBsQWUzNm9y?=
 =?utf-8?B?U0ZFOEJhcFM0TWhib3hheEhvOS9vUVJOaHJIY0hkcURxaTVJckRSUmE0a3Bk?=
 =?utf-8?B?NS9sa2ZDbjdoeTRRVzRZd0ZONHFrcVdxNDRZeEpPaTU0RGUzMEhBTXpEaDZM?=
 =?utf-8?B?VGs3OXY4cDVWcUR3blJMOTFsT056L0xRVG5CSmhsWjkrKzM3RWs1OEJaeG1R?=
 =?utf-8?B?eERpR0Y5b2pkMzB6eDhhRGEwczhVeE9OVy9WSTNrWDZKOFRYK08yS3ZUNHhz?=
 =?utf-8?B?NVFzVnF1ZC80c3dQSStSN09iZGdiczE3NEpaTm45alk5bi9RbjVPU1lEQnl4?=
 =?utf-8?B?MjdCMlV2WEJKR2YrSmJOeXlXcFNUWHdIKzU3dWNPT2p6V2w4MFpXTUY3OUlJ?=
 =?utf-8?B?N0JURHVJcTFPQmhXSmxkeDVJbG0raWRLQTltM2hPbFd3U3dqZFRxSzQzbk81?=
 =?utf-8?B?ckFybzdzc05BRVVxaC8zdmg2eFA0NjkrV0JOeDl3cFpJQlhGMk96a2lHRklO?=
 =?utf-8?B?QmFXdXQ2RmxHZXNSREFHdGp5RnUvcmx2NXZOdFB0dTdNUmkxLzhRRHk0U0xD?=
 =?utf-8?B?djFTWW1QMGdyUGtET2NaV3pjUlBGZFB6MU1iQVY1akxiSE1XUDJvY2ErOC9D?=
 =?utf-8?B?cHBEL0J0UXVZSFVwSU5WbVF6dGtxQVB6NGo5VFZ2emQ1aGlVLzRqeEowVm92?=
 =?utf-8?B?N0I5bkZZNlpjWjJRYVYzQjlNVldEck14MlNhRmxiWmVvV3gxdWN4aTMrS1I0?=
 =?utf-8?B?U0orUG96UDBUNjg3MVowVEtkTEtZQUwxRG9SOUZ0eDBlcURvdjVkWkR5cFVF?=
 =?utf-8?B?L0xBUk52MDVXcmMwVE1UbEZnUXVFdVBJSUdIUUg1ZS9YR0hyRUhHNE9sQWtM?=
 =?utf-8?B?elliY1BBVjgzaFhYVjc3YkF0bm90U2NwU3p5ZWtFajZPTlZkNVh4SzA4L1B0?=
 =?utf-8?B?MjFaUm5GNEsvaUtab0NvT0lnZDRoVTlsNnVLRkEzOXd4aXhMRFYzMlVSQkI3?=
 =?utf-8?B?WUNnbFBmQTE1ZnpJZmVZUE1ySk5HTUFIdFZoL21ZTE1ySUl4UzhYSEhxWHgr?=
 =?utf-8?B?UDIzd3YyVG9TZlM3VFQwNVVGRExyWEJCSkpHRkt6eFBSUFlRaXp1T0FOMXJ0?=
 =?utf-8?B?WVFsTFFBeDh6ZE1rd29meVRMTmpGSk9xanV6a3dnMnpENmQ1R0VYSzBkVS8r?=
 =?utf-8?B?emVWckdYdGt1TWtyVzdsVFI2YmdzZEx3bkVjZkFnL3RnVkdvTWphWUcyckxp?=
 =?utf-8?B?OGhSRmpici9UYWRscEE1cFF3czNDeWYrVXhLVUVhNVNmQ1Ftck9DM0N6cWhp?=
 =?utf-8?B?TUpGM0JiT0FFMFJpUUZPcnF3dldaZnJWdWROcnhld1JrczYwRGNFT0lSYWpu?=
 =?utf-8?B?RG4ya3hnTlEwWm1pYkNHR2djVStoM1pISWU1MjZSQkNVek5peFlZUEJud0h1?=
 =?utf-8?B?OVMrMTYzNzBnd0NuT3VwV1pxamR5NmFJYi8vTnd5UzMreEFEdnJPdlVwa0Rm?=
 =?utf-8?B?ck9ObVl0YXZZd1pHRFBmaVRNQW5RTm9FVVhqa2ZNbmZpbkI1TVZhY0M5ajBD?=
 =?utf-8?B?dHZObENVdUh4MEdpMEpPb2JkVWVQMmhiQnZ2VU9yTnZHOW1WNWZyNnF5MUN1?=
 =?utf-8?B?cGR6MjBsYlZLcnVZa1h1M1orZXFXMDZXb1FxSVB2L25uem1VMTl5bnlPS2d1?=
 =?utf-8?B?bnZ4UC83clJvRVh3WXBlV1hLMWliQ1Q4RklXTzVSSEFDdVNVWWYyVEQwVFRm?=
 =?utf-8?B?d0pOQkxlZUp0K21wcVQ5TnlnZ3ZiUWtJVDhrTFYrZkY0NmpqMjNnMENRbXdN?=
 =?utf-8?B?M3pGUEczRlZJZVZIMFN4QVNMMlQzMlJnUGJVTFBkK2hrZEFhNVFvTXpkK3Vu?=
 =?utf-8?Q?6Wfv86Pi5Vk8YhTJY/kqigs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f20d743d-a895-4c61-6a24-08db8435b865
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 06:44:06.6611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5c7FEGDJs0kls2qsL4U9upKajJbbNMBj5xMcRtr037LHEGQK7uzBzShB1GU6M+k9XxFw+rNR1vRxnDPdygWl8RIf8fdcxC24TV3Al5sf4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7104
X-OriginatorOrg: intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUhCgpPbiAxNC4wNy4yMDIzIDAxOjAwLCBSZWluZXR0ZSBDaGF0cmUgd3JvdGU6
Cj4gSGkgSWxwbywKPiAKPiBPbiA3LzEzLzIwMjMgNjoxOSBBTSwgSWxwbyBKw6RydmluZW4gd3Jv
dGU6Cj4+IE1CQSBhbmQgTUJNIHRlc3RzIHRvIHVzZSBtZWdhYnl0ZXMgdG8gcmVwcmVzZW50IHNw
YW4uIENNVCB0ZXN0IHVzZXMKPj4gYnl0ZXMuIFRoZSBkaWZmZXJlbmNlIHJlcXVpcmVzIHJ1bl9i
ZW5jaG1hcmsoKSB0byBzaXplIHRoZSBidWZmZXIKPj4gZGlmZmVyZW50bHkgYmFzZWQgb24gdGhl
IHRlc3QgbmFtZSwgd2hpY2ggaW4gdHVybiByZXF1aXJlcyBwYXNzaW5nIHRoZQo+PiB0ZXN0IG5h
bWUgaW50byBydW5fYmVuY2htYXJrKCkuCj4+Cj4+IENvbnZlcnQgTUJBIGFuZCBNQk0gdGVzdHMg
dG8gdXNlIGludGVybmFsbHkgYnl0ZXMgbGlrZSBDTVQgdGVzdCB0bwo+PiByZW1vdmUgdGhlIGlu
dGVybmFsIGluY29uc2lzdGVuY3kgYmV0d2VlbiB0aGUgdGVzdHMuIFJlbW92ZSB0aGUgdGVzdAo+
PiBkZXBlbmRlbnQgYnVmZmVyIHNpemluZyBmcm9tIHJ1bl9iZW5jaG1hcmsoKS4KPiAKPiBJZiBJ
IHVuZGVyc3RhbmQgY29ycmVjdGx5IHRoZSBpbnRlbnRpb24gaXMgdG8gYWx3YXlzIHVzZSBieXRl
cyBpbnRlcm5hbGx5Cj4gYW5kIG9ubHkgY29udmVydCB0byBtZWdhYnl0ZXMgd2hlbiBkaXNwbGF5
ZWQgdG8gdXNlciBzcGFjZS4gVGhlIGFib3ZlCj4gaW1wbGllcyB0aGF0IHRoaXMgdGFrZXMgY2Fy
ZSBvZiB0aGUgY29udmVyc2lvbiBidXQgdGhlcmUgc3RpbGwgc2VlbXMKPiB0byBiZSBwbGFjZXMg
dGhhdCB0aGF0IGRvIG5vdCBmb2xsb3cgbXkgdW5kZXJzdGFuZGluZy4gRm9yIGV4YW1wbGUsCj4g
cmVzY3RybF92YWwuYzptZWFzdXJlX3ZhbHMoKSBjb252ZXJ0cyB0byBtZWdhYnl0ZXMgYmVmb3Jl
IHByb2NlZWRpbmcuCgpEb2Vzbid0IHRoZSB1c2UgY2FzZSBpbnNpZGUgcmVzY3RybF92YWwuYzpt
ZWFzdXJlX3ZhbHMoKSBzYXRpc2Z5CnRoZSBpZGVhIG9mIG9ubHkgZGlzcGxheWluZyBkYXRhIHRv
IHRoZSB1c2VyIHNwYWNlPyBGcm9tIG15CnVuZGVyc3RhbmRpbmcgaXQgcmVhZHMgdGhlIG51bWJl
ciBvZiBieXRlcyBhbmQgb25seSBjb252ZXJ0cyB0bwpNQiB3aGVuIHByaW50aW5nIHRoZSB2YWx1
ZS4gT3IgZGlkIEkgbWlzcyBzb21lIGRldGFpbCB0aGVyZT8KCj4gCj4gV2hpbGUgTUJBLCBNQk0s
IGFuZCBDTVQgdGVzdHMgdXNlIHJlc2N0cmxfdmFsKCkgZm9yIHRlc3RpbmcgaXQgc2VlbXMKPiBh
cyB0aG91Z2ggdGhlIGZ1bmN0aW9uIHN0aWxsIGV4aXRzIHdpdGggdGhlIE1CQS9NQk0gZGF0YSBy
ZWNvcmRlZCBpbgo+IG1lZ2FieXRlcyB3aXRoIHRoZSBDTVQgZGF0YSByZWNvcmRlZCBpbiBieXRl
cy4gVGhhdCBzZWVtcyB0byBiZSB3aHkKPiBzaG93X21iYV9pbmZvKCkgbmVlZHMgbm8gY29udmVy
c2lvbiB3aGVuIGRpc3BsYXlpbmcgdGhlIGRhdGEuCj4gCj4gUmVpbmV0dGUKCktpbmQgcmVnYXJk
cwpNYWNpZWogV2llY3rDs3ItUmV0bWFuCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KSW50ZWwgVGVjaG5vbG9neSBQ
b2xhbmQgc3AuIHogby5vLgp1bC4gU2xvd2Fja2llZ28gMTczIHwgODAtMjk4IEdkYW5zayB8IFNh
ZCBSZWpvbm93eSBHZGFuc2sgUG9sbm9jIHwgVklJIFd5ZHppYWwgR29zcG9kYXJjenkgS3Jham93
ZWdvIFJlamVzdHJ1IFNhZG93ZWdvIC0gS1JTIDEwMTg4MiB8IE5JUCA5NTctMDctNTItMzE2IHwg
S2FwaXRhbCB6YWtsYWRvd3kgMjAwLjAwMCBQTE4uClNwb2xrYSBvc3dpYWRjemEsIHplIHBvc2lh
ZGEgc3RhdHVzIGR1emVnbyBwcnplZHNpZWJpb3JjeSB3IHJvenVtaWVuaXUgdXN0YXd5IHogZG5p
YSA4IG1hcmNhIDIwMTMgci4gbyBwcnplY2l3ZHppYWxhbml1IG5hZG1pZXJueW0gb3Bvem5pZW5p
b20gdyB0cmFuc2FrY2phY2ggaGFuZGxvd3ljaC4KClRhIHdpYWRvbW9zYyB3cmF6IHogemFsYWN6
bmlrYW1pIGplc3QgcHJ6ZXpuYWN6b25hIGRsYSBva3Jlc2xvbmVnbyBhZHJlc2F0YSBpIG1vemUg
emF3aWVyYWMgaW5mb3JtYWNqZSBwb3VmbmUuIFcgcmF6aWUgcHJ6eXBhZGtvd2VnbyBvdHJ6eW1h
bmlhIHRlaiB3aWFkb21vc2NpLCBwcm9zaW15IG8gcG93aWFkb21pZW5pZSBuYWRhd2N5IG9yYXog
dHJ3YWxlIGplaiB1c3VuaWVjaWU7IGpha2lla29sd2llayBwcnplZ2xhZGFuaWUgbHViIHJvenBv
d3N6ZWNobmlhbmllIGplc3QgemFicm9uaW9uZS4KVGhpcyBlLW1haWwgYW5kIGFueSBhdHRhY2ht
ZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgbWF0ZXJpYWwgZm9yIHRoZSBzb2xlIHVzZSBv
ZiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQg
cmVjaXBpZW50LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxldGUgYWxsIGNvcGll
czsgYW55IHJldmlldyBvciBkaXN0cmlidXRpb24gYnkgb3RoZXJzIGlzIHN0cmljdGx5IHByb2hp
Yml0ZWQuCg==

