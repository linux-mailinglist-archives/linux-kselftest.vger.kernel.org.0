Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6FC61FDB7
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 19:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiKGSkC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 13:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiKGSjt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 13:39:49 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FF41DA7F
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 10:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667846329; x=1699382329;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=N+CEEZouORCw3PbIgESSxwy065L/IpAxswmLC0fLS38=;
  b=IM84V+vgysyCsvS6U7wYLJ6sKD9nDQQXrCpQf3pNIj0fKzjxznH7I6i5
   RxhmtSXAKAJdz/VDduD5A2EPbIHGg9943Jjua2yVyvlL5prDorProN+ct
   OxbdLKpBDNJL/Fg6076ybdf4s5nf4vD9iM6FBveVckQKYH0oJ/y+jwL4p
   8v/vL0yK5B0MVOP5VvxUvDhi49WxzZ6kMyr9BAT8i+Vug2NjUfuO+ceuJ
   IklIBeAsCn5lKL7maI4PPZFtDT70k0d/9jw7agaOQzPKcI/uQY7wcdM3w
   Feji70CfjjmooYjovREj8dQMs+sP+8OKv9zmuSCbzIb5vjOd9PJmVE02y
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="290212304"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="290212304"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 10:38:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="613970105"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="613970105"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 07 Nov 2022 10:38:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 10:38:15 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 10:38:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 10:38:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 10:38:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DC+vKKTwi6W2AyXtkrLQ1fUaxVfG/f7Ss+nTW7BVdN+MosCH5eZp8bOVs5BNryazhs8sa/6tM0rTtzO2KOFI+WtQQn1F4o4mOVRJCYlKo7kc4TNhZLM5PfajqhNvu67R4Kd3n54Jsb4TMX28okIcozwjENEY2oD1jCdHYPmImsHqUz4n6soS+6FEXKq9TQssDrFE6ddCPsw5y6UHZhN5dOs4r82PLSc+vONB4PcYv86ZrpkMz9A2S3ciLKCQKmwL2pFakJA3R/yBK+12iUAB4sbBrHWeiG+K7z9On4x6SqTN4YygKNgbZ35k18PGDoEy237dgqdpGuYUJAxe2HnR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ompKoPNIJ0I2u854Ux+R6l/uE42frnO7j03jIEXDOr0=;
 b=R/RoU9Dk68ajZHmqN8nhKucZyQ7A9jFM5+un1eACxRT1t+tqYUwQGWU8H4LAjifvQEb4H//naxNURDnYXgWrKDzuSfwxWRQHEG/1NcBT5BcPiQcd8uPaKbJGZTdbGnEnJI2IWODmvT1obbC+e1nAdWruGN5/DsuyVJ5MSW8xjTzyJvoAhkyq/rIspwq23y74IsQe8iC9ZaGPEsT57FcgFN2byWHOkBCVsfk4fVQCbJfiq7CBGaNfJab/D4NGrR1pranEh2n/0a7FngtV+M5/UE7Rp5BAi1MMxnTyAoygcpIouEapY/d27PGK82sMhj4SzHxAWMsfNNhgeVsqrR6YRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 BN9PR11MB5403.namprd11.prod.outlook.com (2603:10b6:408:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 18:38:13 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::22c6:b7ab:a8ec:a6d8]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::22c6:b7ab:a8ec:a6d8%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 18:38:12 +0000
Date:   Mon, 7 Nov 2022 19:38:09 +0100
From:   =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
To:     Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
CC:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <igt-dev@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <intel-gfx@lists.freedesktop.org>
Subject: Re: KUnit issues - Was: [igt-dev] [PATCH RFC v2 8/8] drm/i915: check
 if current->mm is not NULL
Message-ID: <20221107183809.z5ntt6fj5ohs4bnn@nostramo>
References: <20221103162302.4ba62d72@maurocar-mobl2>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221103162302.4ba62d72@maurocar-mobl2>
X-ClientProxiedBy: LO2P265CA0230.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::26) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5373:EE_|BN9PR11MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: b51e6e83-80b1-4e4f-a5ea-08dac0ef39ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZTnH4+L4ZqwYGYEUziJ4x/bGofOLUUa3fGGBkSigvAD2E/s92qZFFgnnFBfjFhioVeKEV+hzXG1mAfut2sMtQKaXq+3jKhQlvyLo5kkYtkT4DpS6ddM2RpAtthnOywoHkD7jTnI4I3KLBrpXiK0i3bLYVXu805E+t4XDNiL+HD4JQTiz+IanLDxht61U8g1bEdwSjVLyyIMykhEQn3f3Vdr0O26uRjarRu+mSCae7srOqabOVaXqE13i5dtf4Meaib59e5bjDEsvWbDVzCzqG8ZTCEOB1ADsWuiHLkQ9v1AVpb/GuYC4pHw3tdox7MLSXWK+qnDKy6HyBgSbwDk7HQpcOfGphvzzUQl4m8ChBx36FCCtRt8IFobHAe5YL2DhsLN2NpFz9xXMqxnQe8VulbtK1f1mlHRhcvjTfy6kZmu7TabJ3y41+qril7d/LY+CpETBOEpyHpsKUi2UDzp3Cg3Sj31zVBYOSADFIsuuabmsTkQilHFBFihNc/5DniqjgaVV1BDWVjVpPNnnqgZrFCqyS4sc3xg2jL4mD/NTEBfYWRhyqivoltt7TUgPr9v3GECyl8tyqvUcSU2k7BNzIkFXhJfDm1l18HmSgAnCd9Q39lRWSPBer1CIKWgClHL4Iwb7NRlCpA09LlDdyvbm9vRqp06/Jckpw2YH1XnK6+qiY1VhMJB2mjkphD3xzn8I2rzPUEvrXGYot165EAuAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199015)(6512007)(26005)(9686003)(6666004)(186003)(1076003)(6506007)(66946007)(2906002)(316002)(4326008)(33716001)(6916009)(54906003)(6486002)(8676002)(38100700002)(41300700001)(5660300002)(8936002)(66556008)(66476007)(478600001)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blhwNmp5bU5vRTZkNm9XVWc2akQ2ZXp3c1BQVVZLT0hXNUlYV0txQkkxcGdZ?=
 =?utf-8?B?MGdrZXR1VWtHYXpDd2Z4eC9JT3UyTmJjbDdOaUs4MG9oQi9IeVhRb1BRdkJv?=
 =?utf-8?B?eDdkSHhNSzJUbXZ5U09qMXVpWUVTVk9EU2Uya3d3Qk9ZZ3p6UVJNdlE3RzQ4?=
 =?utf-8?B?Zis2UGc2T0xaQWN6U0J6NzhaNlFVa1NkLzZrUThaSnFpV1E0VmV0bHdiaWd2?=
 =?utf-8?B?Zng0WG9KYTF4MUlISmlhazJmKy9FL3JEdUcyWUhUWWhZZ3FpNHdvZ2ZmaVRt?=
 =?utf-8?B?N2xJYkI2bGVYMVJtaEdRVUJZYklVdGhOZmxycy9xZlJ6VlN4WmNNVE5OMDl5?=
 =?utf-8?B?Q2Rwa2pyOHBuZEl2ZlpaV00vOUFLalBMSE9lTm1yZGVGc1lPT2RKeUxKSWE5?=
 =?utf-8?B?KzJKVVpKa3JUaE1sb0xmY1hIRXl2RWkyVHd5ZERGdDJpNkJrU2p6c2VSZXNJ?=
 =?utf-8?B?SGlvblFUMi8vMWdrYm03dy9QZXA1UldHZUo5NUgrZ3hyOFp4QTRxTzFDVnN2?=
 =?utf-8?B?ZUtGckJPY3RJY1F5eWoxNDRCeUs1a0dwbUZhb3d3ZnluUTVQaE91ck54QXMv?=
 =?utf-8?B?bHlaVGEyY1FoTmF6R3MrVUJmT0FUNEVLWXZwajM3OEo5WHpxbmhZTDdPZVA1?=
 =?utf-8?B?Rkw4S3hzUG5BOTFkQ2lkS242ZlpVZi9NeTk5bS9aQUovVElJVWxHZ2xBVFEz?=
 =?utf-8?B?MzZyQXRVbHM0S2ZnMWd2R0hiUUdOZ3NjZFBXVnY5K2FxZFI0RGV4K1VkR3dY?=
 =?utf-8?B?R0lGWW9iNGt2bUhPbnJHTWh0alowRXBZZ0dSTXJ2eDEvQUFkdFpkWGl0MG95?=
 =?utf-8?B?M1lhSXNFUUFQVWswd1RUa0ZPMXMvRVdlWWVlQzd1VXRzSVl2LzVDYXU1R0Jj?=
 =?utf-8?B?ZWV1ZVFLZkRtR1RSQ1hGTDhUMW5VcGlYck5UNFcycDVjZ1Z6ckRVcXlMWkZJ?=
 =?utf-8?B?NkNlVmU4c3NKQ0Z4UlRodGdkYnJtQ1EzMDlnZUdKN3gwV0hGVjB6MGIyZFBR?=
 =?utf-8?B?VWxsNEtkaks4WHhyQUtHdEJRUVc1T2VkY0NzTnZEZWlIc1h5NWF3c1V1WlY3?=
 =?utf-8?B?MTZScHU3bmJhMHZWVWNoSnJlVzU1bGNnaHU2NHhac0c5VEpIS1A4dmdKYWF3?=
 =?utf-8?B?K1dzbVhTRERpeU9LakIxVmhvSHF5T0U5RktqR2JQRUZLczVOd0tRU2xpb3Zv?=
 =?utf-8?B?L0pMNS9JMjcrSjFhSEs5WDJZWHZmK3p0QitoWFd4bkhSTEpCYk9QMnNFUmVP?=
 =?utf-8?B?K3NBZi91RVVycFhsWE1iQVNkczdzNWRWN1dGd3NXandSaGpIVlJkeFB3WnlE?=
 =?utf-8?B?VzREZm8vdmg4RmdoRE00YTNyTC9tUFFtTEI0UzNzRVFWM3dnY1pZQlZFNHVa?=
 =?utf-8?B?cnQ2UVVreHpxeVpQQVZKU2lCeUFWVjVZbDVLamlYRXkwM0ZrWkZHWmpRbmYv?=
 =?utf-8?B?UmpWTlgvUUlRM1ZvVUl5eGlWaFRXQjc1eEFDMDQzaFhYeEVoa1VlSkJmaHFP?=
 =?utf-8?B?NUt2Z2w2YXRqT0R4V0ZHQS9YcnpNQmFicjVBZ3ZaQTdiQnVLRHRqSWZ3bUJa?=
 =?utf-8?B?bC83ZE5uVStLc2lYMUpZSmNpdmswMndQdThyeDZxZ3o2bXphZEMwalhQUmRs?=
 =?utf-8?B?L0wwZmZtRzNFR1o4QS9zTlppSi9YYUQxQjJBU0tkRFZaaWJ2V2FJVXlMcWR0?=
 =?utf-8?B?bERxMzVlakhqYlNPTlhnRE8zWFVJK3RreVJZNFQzM0x1c3BMRmlTTnN5OHJ6?=
 =?utf-8?B?UHowZEt0UTRSTC9mWVR2ekJPUUgvN2JvWWJjV1NCSmNocjVnbU56ZVlpNDZD?=
 =?utf-8?B?SXdSRWdONGpKK3F0aGZmQVd5NEliOTIvejdmaW9FclFKQnBXdUE2WlZEVFM5?=
 =?utf-8?B?c3pwT1V1aUtRZ3ViZ0hpOTJRUTNockdTdUV4cFZuaExXNms3K2V1TytlbWJR?=
 =?utf-8?B?WTFacS9HdjJOV1RndFVscXhCUWNDQzA0RWdmSkk5ZGhWOGF5RzhzVVVSQVI0?=
 =?utf-8?B?K2lqNnk3VVBrQ1ZNTHNERmIzY0xxT3FsOG81V2M5bFVQUS9yN0pxeW80TjdY?=
 =?utf-8?B?SW96OWJlQWtNYlRkdzNqVkhvVjJDSmhIcndPajlVclc4WEw3WERIam5nLzlL?=
 =?utf-8?B?aWY5VHRWc0NnajVIZUw2Ykl3K21iaGRRYW1lWkNMZVpkbHY3akozRGNEazl2?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b51e6e83-80b1-4e4f-a5ea-08dac0ef39ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 18:38:12.9188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bA3q/9Z7qOrpbTwHo+rLBGLlGeMr910vXIrl1vVNnavDStDxGQ+cQ2xfjnD462vnU4UErxpK47OeyXGHe51ELe2XHZiOrFBgvOYWIXtN3Xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5403
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 03, 2022 at 04:23:02PM +0100, Mauro Carvalho Chehab wrote:
> Hi,
> 
> I'm facing a couple of issues when testing KUnit with the i915 driver.
> 
> The DRM subsystem and the i915 driver has, for a long time, his own
> way to do unit tests, which seems to be added before KUnit.
> 
> I'm now checking if it is worth start using KUnit at i915. So, I wrote
> a RFC with some patches adding support for the tests we have to be
> reported using Kernel TAP and KUnit.
> 
> There are basically 3 groups of tests there:
> 
> - mock tests - check i915 hardware-independent logic;
> - live tests - run some hardware-specific tests;
> - perf tests - check perf support - also hardware-dependent.
> 
> As they depend on i915 driver, they run only on x86, with PCI
> stack enabled, but the mock tests run nicely via qemu.
> 
> The live and perf tests require a real hardware. As we run them
> together with our CI, which, among other things, test module
> unload/reload and test loading i915 driver with different
> modprobe parameters, the KUnit tests should be able to run as
> a module.

Note that KUnit tests that are doing more of a functional/integration
testing (on "live" hardware) rather than unit testing (where hardware
interactions are mocked) are not very common.
Do we have other KUnit tests like this merged?
Some of the "live tests" are not even that, being more of a pure
hardware tests (e.g. live_workarounds, which is checking whether values
in MMIO regs stick over various HW state transitions).

I'm wondering, is KUnit the right tool for this job?

-Michał
