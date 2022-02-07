Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0074AC940
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 20:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiBGTNi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 14:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbiBGTNO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 14:13:14 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE805C0401DA;
        Mon,  7 Feb 2022 11:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644261193; x=1675797193;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9WP0PgJD/v6ur//N0Xxz8asuG892eTfWEP/QlApyKjA=;
  b=hfn9c+MLDMluz0FnP2Y3pdJcwnohup578QbHpQXuXLyNbcitveWzNnif
   O2C+jonMrsZ1QlvVRZ8TzajqmxYkurD2kkhXvuHiac7LN7ckctkVm3d2b
   RW0uNaOkyZhqbM7+iGQZj9ltu4BKBbri3JL8CwyMYN3yTBTY8XakXq7up
   qmRytx8WZ7pntU3tEKXhonOLZAejiJTtPHZb4Ftr60X0X8j7hgDPyzVqg
   dtZR2hZ48hgnV6jfX1/x6U7M53eUyBm6c/J9Qv1S8dytzvke53EuJQDNv
   twmK6cFmVYOTYN9KSKgALRp8lZ7wtjmoL8Dx6TWXJJMOMCWGEFAP/lHnY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="249000044"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="249000044"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 11:13:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="536311232"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 07 Feb 2022 11:13:13 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 7 Feb 2022 11:13:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 7 Feb 2022 11:13:13 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 7 Feb 2022 11:13:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr2lf93vhl0mOeUoxf/lsc2T1BSfUruToad/+ARh8sZDmuJwfUGlcaoMO936+ko/f3IZr5qcJw+u5TiNdQ32nKtKhOAmWhB4Fg96DRGAlVQY7oOkI4ETIi64TvdzZliFjhi0E/ZYqtEZifCZEY+INgurrjo4J6n76rr0Rmrv9qVrtzB4dfhgpn0p+BId1DXqo3SoXhXlDry3S3oK6O+cUtrPwt9AzUu7vsbb4XYrr4fTBJTtKzL3hUpdQa12ib7inFp/t+xMP/xAQCd7WqJeoFmsOZmkWLgqobrWZkvNCDbSIK2gY6I7Lyp1wy5WQXEveR6nRTurUKnT5ljeBbZLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8/xxDOGW8qnn6P20/U0QSCR5eb+qfDmQvqWTmyl9u4=;
 b=WaO35THftktoE/FBJYujyq55s8EnWb3sjUFAqgGHGUQF8Kq1s4QOitP9U7lX5FUQ/YZmGPaLp1ZpKb/6JqgWZQO801+25cTLRr8wxUYSTn7c1asCBhpTz1n3xjIPD71lSQy7IJ0mLQNMeS7zUZxTrQ35GWSofeF6IeEfaP5OW7AR3ksiEhU+D+MPXjlYPkk6+YnyVxDcLnLdP1R86wNrTsH3UUYTXifRgtXpmHyrGO5Hhq/T9nAjg8lQ87A/jpHmG9p6/CuA5y6j39ewKAiJGYP2CvoKqo/thplGZRxorvgpoY0jzL/jrLUrHBk1zyCDFqQ0tThplRjWCiwyKJylOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BYAPR11MB2919.namprd11.prod.outlook.com (2603:10b6:a03:8d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 19:13:10 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 19:13:10 +0000
Message-ID: <58794e0e-43f5-f6cb-6b34-ad299ddac69f@intel.com>
Date:   Mon, 7 Feb 2022 11:13:04 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.1
Subject: Re: [PATCH 0/3] selftests: Remove duplicate CPUID wrappers
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        "Florian Weimer" <fweimer@redhat.com>,
        "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Thiago Jung Bauermann" <bauerman@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>, <linux-mm@kvack.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
References: <cover.1644000145.git.reinette.chatre@intel.com>
 <81df8c0e-fde6-f3b8-f988-b539f193635b@linuxfoundation.org>
 <c61a227e-e35e-55a8-3571-6e015e222d5f@intel.com>
 <3787aee3-064a-dce7-1ab1-0dcabd56a100@linuxfoundation.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <3787aee3-064a-dce7-1ab1-0dcabd56a100@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:303:b5::8) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ee1d87d-56a6-410f-504d-08d9ea6de13f
X-MS-TrafficTypeDiagnostic: BYAPR11MB2919:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB29198DE807905F58AD760422F82C9@BYAPR11MB2919.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7gkyON0KwqXLi4E4Q8ReGSuPD+gUMVAU/SrGml8GA/z3iXPFV2qMNUfREun+vIebt4Qxu2dkof+/m01y50jISr+xkZNnCeb65WbQihgQJh5U+wi9RSCU6lSwfZ7VlrXUvzRaDEGPTl3zKC6GN/cN51g32da3BzPAizxiCVhENsd5Vpnp52KcoOGxl0quT/bri9jf2yMAqCdj858Z5w0Kghs1ermCAFUgzWMoEvYEXi3JRPSSJqhEiVLnPtaQuFjioQwGa4qzrNd8jY9MGWV7+segVIPhacldflLQauat52wjJqNU/A8+/xpPe2gKK0msW2ny2PdScVurg/+2IzHWwCYQ39O2V5Fa5UyZ3tT9CXKfKWxPpxhAHLBG7FEmJgVPKIt7Dex3dPmmbOgMcy+JmwHRm839z3pau7lVOoGu9QSm0QvGqzYzidg9PCShCpLzJ/poO9MkasX17Kb7EpJ2mgmGv11ieNO/fJrdwLd+rjc3j444pE5oUCMm9e3JvgZF+4WMfxfU7y6UtSbxCGqD4wNufAJxdxkZG5R2KQw4dLZ3m734Pi4XIUVaLOYX6Gdqx/WJwhu0vKpj1EkpzoF8/8gUQHQgQFJ4hMMAw/cfxQwwuVTFwpaGsgKvhtsuEklMRIPxuFfhvZgxsPDALLdM2prl/0Z8trgT5cVR6/rcHS4Mh6G0/VjZwmUJz4YTTsEpwz3lThsA2y6oMVtMil71VXqnKA8OJpEgA2LTYndFrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(83380400001)(53546011)(54906003)(6512007)(6666004)(316002)(82960400001)(4326008)(31696002)(86362001)(26005)(31686004)(38100700002)(2906002)(36756003)(66946007)(66476007)(66556008)(508600001)(8676002)(8936002)(6486002)(44832011)(7416002)(5660300002)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2JlZVFTMW9ZY2xBVjBwVTBQakNTaUhxdlBGTDBIbHQrR0t5NVBsdTgrdnFY?=
 =?utf-8?B?NUMwWXVSWDFhYVFudEtWM0s4Y09MZkZZaFZqMzJ3enJvekNYTFRkS0IreDlZ?=
 =?utf-8?B?aWVZL043MDNBa0dBKzhNaHU5NjA4T3hxRkp0QTZNN0ZSUXRIeHhqT09LSG9q?=
 =?utf-8?B?TnkyYVJIdGdpRSsxamlYZGZ6YU9xRkgwQVRPMnA2VzAycTd5dDZXRm0vMDJn?=
 =?utf-8?B?ajBPSjBHN2NoMnBlMUdnNGJ3RUp2RDVpN2c1VmF6S3JDcFFVcFdOcStzRTla?=
 =?utf-8?B?d0prKzg5VCtpbHN6T1ZCQ0hzZzF1aTZJM3JldnNuSDZNSEhmVWxrdStDOTZ6?=
 =?utf-8?B?WnFnLzVLYnQ2Ty9FbW05K09TU29jWVUybDMrMzZ6UlR4dm1yVTlKZFU3Z045?=
 =?utf-8?B?a0J6T1N6OFZhR3hQL2hwQXdNd0VjSm5sVURtWjYvMG9TZzlsVzB0Qk4vazdT?=
 =?utf-8?B?dDVrYzBqODVnclZtS2tzUnlFUXFZVG8zZVdtbnRCLzg3QTFhMEdqYlZ6TFUv?=
 =?utf-8?B?c3lZdzB5VWc1V1NES2pGdGMwL1BjaGxmTTI1TUJ6RVN4RllvUXpOQVYxNkti?=
 =?utf-8?B?V0U1Zjd2REx2SHU3WVdBS2x4dXB1V1dHSm9nbnQvQ0Q2aTNNYVlWME0xalBv?=
 =?utf-8?B?R1IrQXJ0OTZCOW9sVDVCMUl6c0t5L25hUzMxUXJRMlFyajJQSkRTQVVheEVv?=
 =?utf-8?B?UmpDWnBpZXJ6azhZcWd6ZmxjK1QyTXFpWmVhRW1ONGsvQkcwRW5GSXRvSlJC?=
 =?utf-8?B?YlduK3NIOVdjem1iVWVmWE8zVXRtM00xenVCYy9McVFYZzRqVlRFLzZ1M1k2?=
 =?utf-8?B?dk9DaUdTbnhYZkM4ckorU0VmRDNtTTdXNFJoclVFSUNJN3k5RWp3Uk9VTlM3?=
 =?utf-8?B?M3drc1FTYU12OFNoYWV5SEZFL0s5cloyTTVINWtrNWphRW5iTjBMUWRrMnpD?=
 =?utf-8?B?S3lDUGhOOGFRRWNDSlJsVzh6dE9oZUE1aFFkMXZLblAybENad0VYYTZvcVF6?=
 =?utf-8?B?bksra3pRbzFIRXJrMC9iWXJ4czB2T3VjVE9GRWkxRjB1dlBucWlsOHdRejY4?=
 =?utf-8?B?USs4Ym1mZ0MyT1czbXY2Ty9VK2FaL1Z2UTVvM1FDYkFPazdzZVJiNzIyMGUz?=
 =?utf-8?B?MWtlZ3g4R1cweVl0ZnB1WWZpeTZhTFNlYUhrUU04REtCSXpTMm5yMGVtVkl2?=
 =?utf-8?B?bDFnS1RTcCtxeDc2RWUreFlHVE1GQmtBOTFtMTYvcXlia0FWZmQrWlUzc1J0?=
 =?utf-8?B?cFU2ZHorTTJFU2thRENWTFpvaTJkRHhQSkRJb0RacDR4MWFFTzAxd0JBTzBH?=
 =?utf-8?B?emU1U2NSS2VYeG5KQjA4Y3dQcXNUWnVFU0tLWjc0TVZ5RjZxTUsxVWpSK3Ba?=
 =?utf-8?B?Rm94ZVBhMzdtcWIxeCtRN085cnRYTDlpZmxCNEpqY1BrTGsxTXpISEVNNVFz?=
 =?utf-8?B?eFJrMHVSSVQyZ0JNYnd2UFp0M1BIQ3laQlBVNkgxWUxBVmxva3JScDV6dmt5?=
 =?utf-8?B?MmZ3NkNkRHNESlplWGtXamsvamdDMEVMVEIrYWQ3QW8vL0FvOVM0YmpKV25E?=
 =?utf-8?B?SHJZeGZUQmRtUTRkSFYwbzRhY29mSHFpb2Z4dGo4OU5qOHBvbXBEZUZHbGRB?=
 =?utf-8?B?QW5DREJPQ3dsbjFrRUx0NGZNdmFSQi92VDU2cmc3K2E5SlZyRE9QeUpFL1B5?=
 =?utf-8?B?bHhXZ0grbkpLTDZ5dllzRXJNMmt5N3NpemRtVmlmN0dRU1VsL3FrREJhSnlS?=
 =?utf-8?B?RHd1MnhDdml3ZU05K25vRkZ4TWZMdldoMzRVNnlUMi9LNjZET2srbEh0WVY1?=
 =?utf-8?B?bnBEUFBXS3hlYmtLZVhmSzBjd0d0Q2hTNUtHVnV6eE9PYUtwZC9HeDZEREJq?=
 =?utf-8?B?enUxYXYzSGlYNWxscVRWc1Z5ZHRUUTdlcFhDV1QvK1IzUEFqU3JNSkRoK2RP?=
 =?utf-8?B?UWNSdno5N0FyQURaWjdLQ2JWelc5aGt1VlFENHNRczZDbXFOeUpSbG1XQnN0?=
 =?utf-8?B?WVFITzFuLytaRXIvQ24vazVheWZkU1VYVXBDSk5ycUFkT2JGaUNrS2hISE9X?=
 =?utf-8?B?UEFtTFA4LzkzZXpNYVVOendseTk5QTFFK2dJN2N2ZDRwQmV1YXhxT240OUhF?=
 =?utf-8?B?SjZPWTE3cmw0TWU0S2d0NmppMENxQXZDMXhCWkNSMVNZaU9kNE5tTmh1RTNG?=
 =?utf-8?B?VG1WR2dEajYvN29yeFdnckdXYmVuVnRhd0VmSVVoNTlNVHNGUlJUR2U4TWVV?=
 =?utf-8?B?bkdKakRLVHBuTnhMRi9ocG5Bb0ZBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee1d87d-56a6-410f-504d-08d9ea6de13f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 19:13:10.4899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKzawO33iX1y0Dr4QUNVnE7t9iKLh67o9XaAfsZ1s7tizybDn82xoI1MR7byvEWR6pIh3YjJFq1352twOM2mxPmAsXn93MSWZTq97UWkb1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2919
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 2/7/2022 10:00 AM, Shuah Khan wrote:

> 
> This will work fine on newer versions of gcc/clang. However this could
> fail when mainline kselftest is used on stable releases on test rings
> and so on, especially if they have older versions of gcc/clang.

Indeed. It thus seems that kselftest has a minimal required version for
gcc/clang that is not the current mainline minimal version but the
minimal version of the oldest supported stable kernel, which is v4.9.

__cpuid_count() was added to gcc in commit:
cb0dee885cb30b4e9beeef070cf000baa7d09abe and thus available since
gcc 4.4.

Looking at Documentation/Changes or later Documentation/process/changes.rst
kernels v4.9 and v4.14 have the minimal required version of
gcc of 3.2. So this change would encounter an issue if mainline
kselftest is used to test a v4.9 or v4.14 kernel on a system that only
supports its minimal gcc.

Kernel v4.19 moved the gcc minimal required version to 4.6 that does
contain this macro.

There does not seem to be a minimum required version of clang/LLVM
in v4.19. The first time I see a minimal version for Clang/LLVM
for a stable kernel is in kernel v5.10 with Clang/LLVM minimal
version 10.0.1 and from what I can tell the __cpuid_count() macro
was added to Clang/LLVM in version 3.4.0 
(commit 4dcb5dbb53ea4fbeab48bc6bc3c4d392361dabc1).

> 
> We will have to find a solution for this. Instead of deleting the local
> define, let's keep it under ifndef __cpuid_count
> 
> /usr/lib/gcc/x86_64-linux-gnu/11/include/cpuid.h
> 
> #define __cpuid_count(level, count, a, b, c, d)                         \
>   __asm__ __volatile__ ("cpuid\n\t"                                     \
>                         : "=a" (a), "=b" (b), "=c" (c), "=d" (d)        \
>                         : "0" (level), "2" (count))
> 

Will do. I see that gcc obtained the volatile qualifier in v11.1 so I can use
the most recent macro as you have here.

Reinette
