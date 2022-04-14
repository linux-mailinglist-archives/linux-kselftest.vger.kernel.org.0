Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0CE50193D
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 18:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbiDNQ6r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 12:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343870AbiDNQ6Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 12:58:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4142914B852;
        Thu, 14 Apr 2022 09:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649953863; x=1681489863;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yH4d9hMX9GCOinN5uLWqcnW7zl5RaY9KVGr/Hrl9dZo=;
  b=S0nkxfXTcx7eRRNS5ZUyq7hWTOiTdaCTocD+jqDAtGOHuZ+q5er8sqTZ
   STYJ8Q8E7EpMNCZrbusyZ7lm5YlKwb7MMkyHuGmrAsi3KoTOvq1704clF
   3OJxmtP+bzgYimKh65/sFiaMysfV1zyHBUzzi5c608phMVKXbxN+CCjfj
   82WlJbsKVPhkkKSgUcZbyit4Oom2znHVH6GJ6DEC4VFvICiL/O8cT/1Iz
   YNFMTprMU5Gtzn8pOYbnrfrjHMesWI6jcM1h9NbyKmEpU+5MwBREQ82A+
   V0wjrpw9XJoWW47fpO1tW3/uZ8ap0oCnuUUaJuTfWZUGSc+siwKPTBfAZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="262415282"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="262415282"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 09:30:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="527455879"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 14 Apr 2022 09:30:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 09:30:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Apr 2022 09:30:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Apr 2022 09:30:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KD47kknTg4523tmThuAuh4dM5UsEQ/vSPCw8TI4m1tK/Wj1hHQ+kw8TZR0HI68qeK9l6q9lrAYUYGjlZfxK7bqWtRgJtlOH5J4/dvgG5EbXPjP755ZPDbvHvJWFPnqcEWgdJWuAaEfK0U80Xr1etUZiqpif/ablkWUYcZg/nqkMmQw45HCIYos1yJvrp1XNNZMQE7M5rtF7GpN447fsYg2KICGpMOgd39EhvgNlpjY7/fIXPHVOPIMGdebdbXYf4XO26tJ++q24opLMpoT2XFV2osgOOlVA8wJnu6i3VNYjgAygOUCvOn9wuwRHgiQFGpPOzdHYoITn1CZ93D9iI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/M7ZaAHJa2K8LkNyeLMddLrH4fI2MxewlRq//V6TzYQ=;
 b=gINXEynbX5vjPkvqj94wQyIMGF+IUSm6bGaSnL5+gLalPOzCige3fB5PNT718W6voiuKZCXbbsUDth4H5k1H/lv0mDCkB/4c2XC5DVO48EZOCdW7bx++HnJppYobbvAAGvS+BvtBSZW8Mk3g3NCve8jwWT0r7EoyVvuXMn4t4bN9wbEzPXAYcECrkRJEwWZ1bqEvG3ib7Pz2XeQTr03kEntLoWq8Y8uaQ17fSgdaXGaXKm8XUV24f0vKPMRbC2r88TvCwsAawkGtY/b+yemjpQyecppD8MwYjYN5aG/V/9RsbFbjnDjRZeP7whcXvVx9h5SiV+BxWVy9OUoDBu12IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1443.namprd11.prod.outlook.com (2603:10b6:405:8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 16:30:39 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 16:30:39 +0000
Message-ID: <767b99c5-f28e-4b8f-5147-6e1d290ca5c6@intel.com>
Date:   Thu, 14 Apr 2022 09:30:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.0
Subject: Re: [PATCH V4 14/31] x86/sgx: Support VA page allocation without
 reclaiming
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
 <0ab32196f5056b25c34fb89fcc4dc28a5d875d2e.1649878359.git.reinette.chatre@intel.com>
 <bf2fcc93babdbf541fffc6cc5f5756f391773a75.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <bf2fcc93babdbf541fffc6cc5f5756f391773a75.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0133.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::18) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca457455-f9f5-4121-7dec-08da1e341c57
X-MS-TrafficTypeDiagnostic: BN6PR11MB1443:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB14436DE1BBFF41EAE333CA82F8EF9@BN6PR11MB1443.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2yIg0mWz5Y0tSt82WNcket26NiFlhko4u0DXDxAo/EJZFW6kZOMZlSqpJ62UVkR/GvG9yKlmtvJgmqxrxzcLed4a4WSxkxxQqCLIlyZlx70GBXlm5rIz1J2YFcvkMRnftpGl2e14FMyt0QXnPwVZTXmHFoAWFT3k/CwHzONRBwNTnF1W1jNVBldaLFgZobMglll2g2UkfiVAJPKFBNa1DHwUBVYxkxkxxjZFzHL4Gq+4f2MRgnH/AinNx3tnGqdyRVL12p+kqHn4FZ9evEX+5ePORlL8XvRsPu36qGBX4A/f+QpJEJAs7tZWLYePqgZ1RCfSFr5mjOMvrSQWGto9/8aakYcosb4B9Xe5Mb7cpkxVfFAti9TjyU6IupSGuQzD9niAA6aYt4uS1bMWmRL5XXAQu0Mpv6xZ5hAlPSeEZ7RYmhImODktX9OZq4p+gx/vdQ6dJuhQc7FyPUM2YRlolfJk+roqavesjf0UxuHNheF5/L4d5e7L/mqSdmuDiPw0eTUUwVH+sXS/BHfuqSnmxUKgvNdjC7U7nn+4ZvZxsMseM9xcJ13U36xMVmWRJRoMcoUOtDbs2uW+Bfa60bv2+DcuzgYpsPRv8/a+WjxV/1tQPbpy9gqw9N3qA0yvLK4lOBFTdLX45SVh5RnjFBrVKLqsERLIp+0//Jv9QADbIshV8eTWXXE8fmFxYwiU6+quGAUSYEyhYbZhkUuwAQJ2G2mac1ezHus997J0oocq907G9wxKn0FNWmxTu/vDQBDJJsfcy2mVvhU5qog93xa6dA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(5660300002)(6666004)(66476007)(66946007)(86362001)(31696002)(66556008)(186003)(2616005)(36756003)(83380400001)(8936002)(31686004)(44832011)(7416002)(2906002)(921005)(26005)(53546011)(6506007)(82960400001)(316002)(38100700002)(6486002)(508600001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzVHU2V3Vjh6QnpaZ0Nyc0FBbThWczVyVmFlQWh0NU9IdXkvRXEwRHNyWVp1?=
 =?utf-8?B?dXVSYU0rdWZWTWFiMmlRc0h1bE5XeVZEQ0NtTGlxN0M1K3grYkRMa0hiZWx2?=
 =?utf-8?B?TEQrK3BBQUpOOG9UOW1FWFB3L1BTQVNBZW9LSVBlQzFHRCtlektCaW05U0tC?=
 =?utf-8?B?TEkzenlFcXVFZFpTNGJNSUVHbGdZVStmYmJCREtPdU9QNG5RZEZRL3BKL05j?=
 =?utf-8?B?RFZEV2VQb3hWQ0Z5ZG05RkFhVEZGTnJmaDVpRzJhbmZQWlhBbUV3eG9aZndS?=
 =?utf-8?B?QnNEYm9pU05yY0pmbDdKSzFBcWIxRzN6d1hRbEJXK0Q0SjE0Z0REemREalZO?=
 =?utf-8?B?TG91WTlnaGRKRU1kYWNHTEtVaG96WVFTYTc3QzhseVlqZ1k0M04vZVpzYTdT?=
 =?utf-8?B?WVdSaGg5enB5bDhHd2RMeGNaaXFqTWVoQ3NrUi9EQkVRaHk3U0VXU2xVVFVZ?=
 =?utf-8?B?Tjh0VHYwRnhzdS93ODhGK0JqVHc4WEFLcDF4ai9SamFwcVhHWVFMZlRMWGRT?=
 =?utf-8?B?a3lEN21BOWtuNkhBQ0U5RzFzbk9GbXc1alFsWnhDSnlYalQzT2htNDE5b1Vw?=
 =?utf-8?B?ZCt1eUhNTDZMOGYyYW03dDdHZ1lrM2ZlNmdCVFpROW4wc2MxWTZzRHpCM2hV?=
 =?utf-8?B?QkcyREVLNVhJQkZhZlF1TEZKVExaRWFIajNwTEpYOGphbEpjMVpicUJpUHN3?=
 =?utf-8?B?T1ZENHBpbjh3S3d6TU8vYXJoeHBRbnFFazFDMmxKak91WXoyd3VVNFRpNmQr?=
 =?utf-8?B?VU1ZM1BMOElvZkE2eHphUGZUb2QzZVI5aU9YQ0JwVmlkeGh0TFhHdmpxYUxm?=
 =?utf-8?B?Rm1ZMktiazVTL0pSNnowV2RwODR0REt2aUM2b1FsRzBpTUhQN0VobTh1aWZY?=
 =?utf-8?B?dnBqOGtJa2hkOHBFaEE4K2t6aEEzU21jY0hJMFlKaUZhSWQyRzdZQVpkYjRt?=
 =?utf-8?B?bFdObG4rbk1SYzk4WXQ5aTc4bSs1OW12dHNpK3VSbjZ6Z2VxYk9sTnR6WnBx?=
 =?utf-8?B?ZlI0dDF2Y2JJYjZkVHAyaFVISVdXWThoa0twYk9SNENrdEdXQUVja051VUxa?=
 =?utf-8?B?UEgzUjNqSEtiZEsxZXZ0OVUyQ3gzVy9wazhVRjI2cHZmYU9nS0NCbERsMEdE?=
 =?utf-8?B?a0RkQ1NIN0tOeDk1ZzdlMEh0YjBEdVE5dXRVUGJWWEVDam9FWXFQbjZ5djZq?=
 =?utf-8?B?UzVDSDJPUzN2czNPOENER0M0a0FFciswMkxTK3JDMU1IZ3ZLVWtya05JUXNi?=
 =?utf-8?B?Z2F3aWpXUHZoTUo4NGV6ZnJmTm1VZU04Q25YMnhiaDBLWUVIVndmREUrYjdx?=
 =?utf-8?B?TlRSSVhDQWhDL1M1UGVWLytMa2JOVGQyYlE4WFVSRFM1ZHlJRVIxNDBheDk2?=
 =?utf-8?B?MysvRWdrZVVXWUN4QzhQRngyTlBrMjMxNVNCVEFGMlkxcjM2NWxibndXRlNl?=
 =?utf-8?B?WFFIb3UxTmtPbkY5ajc5WHR1dkIrVTgzRlI0QVZPTFFHVnR2UmJvS0ZraTN4?=
 =?utf-8?B?S0E4UW9ua0tRU25uUlJkVlVCUVlYTGVBeGlMU2Y4dm9oVE5RditnVWQyM0Y3?=
 =?utf-8?B?b0hQVHBpVENvdzdTUm1uNDAwZEYzRnY3NitvMkdtdU02a1ZuRDZZQnNva21m?=
 =?utf-8?B?WWU4b21vQVN4WS9SVUdFZjZRRXlOMTBjbndzVlBVcXJiaXJua2t2NlA4ZytD?=
 =?utf-8?B?MGg5Y2EyNEdqalNhRnNSRkhTOVdBcnV1cE0wTzgwQkhuYUVROVpjQkM0WEJp?=
 =?utf-8?B?UFhnWGFNNXI1Y3FKQXFZeWxZWEJJbVVpcHNLODdlMTFhVmYrbVk0aDNOd3gr?=
 =?utf-8?B?SjIyRTdYM1RaSnVvK3VlN2RnL1pnOHNGb1NKOWdTcU5UWURoMGFlWDVIZEJP?=
 =?utf-8?B?TkIyVlU0QjdjNlBVQXg5WTBEMmhiWC85OGdURUlhb0gzUnJBWmRUTHoreWZq?=
 =?utf-8?B?NmJieElQZm1OZWZqYmFIYjNua0JWZEhQYkhOVU8xZXkzV0I1L093bzdDZWtk?=
 =?utf-8?B?TnZDTk1VYTMzMWh5L3NZaWE2eEd6cG9ZVUhIc2tlUjJNNHpld0t1WXZNMDJ0?=
 =?utf-8?B?clNpaElaRk5LZ2dtV0tneENhR1N3cTNOL3FuanlFclRFQVB4dGxZWlNvME1y?=
 =?utf-8?B?L3hDUWRoRkluUXFsdkFCbXhuSnRnVnlZWlY5eEVJcUg0RUsrQys3L09PeDE3?=
 =?utf-8?B?a2xZTjVUSkZwTGlRWWhkLzlQekZySTNGQTBCUmVvZ3JMSldGK2ZYVTl0Y0Zi?=
 =?utf-8?B?QW14ZjdxZnQ5c21OakY0Vi9GUk01NXlLa2JncTNZM1Z1anQ3bWhrSDlOSnRI?=
 =?utf-8?B?RnloQ1FCNUxzUS9XNkxzclBKaEhSV1dsVzlkUFFRZ29YM3FqR25UNFhNb05T?=
 =?utf-8?Q?wxUdDQ3nydDIUYXo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca457455-f9f5-4121-7dec-08da1e341c57
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 16:30:39.1162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyDmmKXoEyhEeeClMWlkoqMKyT6UEYElcoLC2mQjdaU6FvcJOUYAut/YThLwfT0e46wFtCZ+JGbBq+MZIjNWxYAakSI+2/dnOTcV90y2Kb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1443
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 4/14/2022 4:18 AM, Jarkko Sakkinen wrote:
> On Wed, 2022-04-13 at 14:10 -0700, Reinette Chatre wrote:
>> struct sgx_encl should be protected with the mutex
>> sgx_encl->lock. One exception is sgx_encl->page_cnt that
>> is incremented (in sgx_encl_grow()) when an enclave page
>> is added to the enclave. The reason the mutex is not held
>> is to allow the reclaimer to be called directly if there are
>> no EPC pages (in support of a new VA page) available at the time.
>>
>> Incrementing sgx_encl->page_cnt without sgc_encl->lock held
>> is currently (before SGX2) safe from concurrent updates because
>> all paths in which sgx_encl_grow() is called occur before
>> enclave initialization and are protected with an atomic
>> operation on SGX_ENCL_IOCTL.
>>
>> SGX2 includes support for dynamically adding pages after
>> enclave initialization where the protection of SGX_ENCL_IOCTL
>> is not available.
>>
>> Make direct reclaim of EPC pages optional when new VA pages
>> are added to the enclave. Essentially the existing "reclaim"
>> flag used when regular EPC pages are added to an enclave
>> becomes available to the caller when used to allocate VA pages
>> instead of always being "true".
>>
>> When adding pages without invoking the reclaimer it is possible
>> to do so with sgx_encl->lock held, gaining its protection against
>> concurrent updates to sgx_encl->page_cnt after enclave
>> initialization.
>>
>> No functional change.
>>
>> Reported-by: Haitao Huang <haitao.huang@intel.com>
>> Tested-by: Haitao Huang <haitao.huang@intel.com>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thank you.

> 
> Nit: I don't think tested-by is in the right patch here. Maybe
> Haitao's tested-by should be moved into patch that actually adds
> support for EAUG? Not something I would NAK this patch, just
> wondering...

Yes, that is a good point. While this is the bulk of the fix where
the new API is introduced, the test is only applicable when this API
is used and that is in "x86/sgx: Support adding of pages to an
initialized enclave". I will move the "Tested-by" to that patch.

Reinette
