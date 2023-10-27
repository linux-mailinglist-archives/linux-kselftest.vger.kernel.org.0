Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34E17D989F
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 14:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345895AbjJ0Mmm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 08:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345650AbjJ0Mml (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 08:42:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941ABBF;
        Fri, 27 Oct 2023 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698410559; x=1729946559;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=0t9pmSGh6X4vJ7YfA+mN+MV1Q4hZ+XpxrK5mabJrMyA=;
  b=IzEE3UmXtEygI9jCGgd1881lnV6T/7bxSpISYY6IVUICFPeCG3AXrupD
   4cirJijPsedavOATrKxlkWqxmlufFPViFWfLQpFcfW3MjfubB4FyNsAxz
   Cci6CntEgZ3CthAn2ob98VGD5B5qmH6OQ+qqkq4QAfRf3AoDvhupfzr5u
   6AIP3fpE4Ya4sVsWt112JQyH/vBCklT5aTsji4F1IgLKV3BJxOAq955s5
   0BYInAaXgbXJGIVdtJ5tfwQ4hmwzz6OK96EgmadxMDgXLi6VKnuDdib3u
   an7GO7HVZhh4BJ2fkc2R/LwF/cTovDOFsfkFBj8BTzNUCa/IAP5P1nixQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="452005303"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="452005303"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:42:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="7219424"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 05:41:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 05:42:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 05:42:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 05:42:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 05:42:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsIHb+Gcd4uRendwV+zXBVHTeQWoWcYNZlcRBFlgnPxbQ+HF+/YA+8GBKJvjLSs2F5CnhSsJ0DY226579Mw4V4DgrQjhu90lFXbgAeenCrR2SdogC4n5n1pr5T0nRZTFfwJCXUtSq9cIhdddqudqY6G4GUPcaDcAec+wlx+3JgkXjkBdP00dJ0LbUlzcB/a1usG7y8UwNBfFz20VRpCVJMqsuJfludTn2LBlch9V4ZSOPhV6p1BcwplNKH6eKiIP7jpXX6JK2NOwJc/FlVSwphAd73QhOrxsMJpjqIksMLXtSeo1w8njLp1J22pG5BmMc0QxE0onPrZtdVhXmWrFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHLwMSU7h++rSyX68kv9qpLTt78dcWzyw70pz0odANg=;
 b=LUU/psmnMglO/IcoKrAhumUgyjJUHH6KnL2fN0spn3gTPWZ+iRQ9GPz3xF9LTFHStvHCN95AEw61fWiPbiiQxPUWjL3RfgiLGlDKBrr6ar1XPkwRAi23ABRhV6xdGWrfP5RHfnI9I7fGATPIeFjmAJ6/Hil7Fzv3j0w6l7QQ+TqRDhacZxUwHYoA5qk1Vfl1s6xfv0g3NbmLE4KaPuon12Mz+Nku3hEEjj4LkR1N6GZST2MGfhNNzQqzJ0qj/YhZ8Yk6Rg3pXgSVzv5dihIcL0T47XKRvDzw1NDOIP8Qm4mUjNPGzjN2YcMKIDREn+bvcMNE73X5pYa39/PYI1aklQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Fri, 27 Oct
 2023 12:42:28 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 12:42:25 +0000
Date:   Fri, 27 Oct 2023 14:42:18 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 21/24] selftests/resctrl: Get resource id from cache id
Message-ID: <cb2ctfignowlom7lb2t5zhdgtm4s2jlzlvtumlnvxecwwtjk34@ysgepmgkv6bb>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-22-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024092634.7122-22-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: FR0P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::15) To DM4PR11MB6239.namprd11.prod.outlook.com
 (2603:10b6:8:a7::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ0PR11MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9e9d68-3287-4ff0-9dba-08dbd6ea2aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T0KlesGrK5weUShtqRia8tHHrdbd1hg+nUVxMzlQdK5b1Be1pa+u4NK9R+ZOLzgzSc/QooXCoWCqtSvjKxSy6yUyvWsGfOxC2ReofZF/SV9P9ie113JJasBTPgrN3Yj4B6b9LM0pTugl4gdhlj7bVYMio4cI1heVvTpT6VkNbNDvK3KGu2sPB+2D2CBhIw179r5M7i0oMC5NgtVKU/Msbv24F2ByHDEDC3nQY2+qqGTSsdNRN6mWDQMorPuonRno7zPg16fvYOLEqvUrorlWp/yqGQbkMWGAwLQnF31CU869nj1kysb/sZlwNDKZvNsRL97VkVCuY7LX0doN8fhVh4eh5oVhoFZ7Uljxgzd7YYh8N5lkbnCqSZftxH4LpVfg+T4PGNHzni/swFtI5PJdmWrGsdjU6q8G51F15v8kQ5K07H9yY1Ek8rCgXtCszKpCpqa8wtwVeM7opRCXDGG7Ag3D5Qm7GuRkLcGyx2roNNGTzUFrgi3/tKGTiMccx8iAjKMmyiIRFIP+Ds4CFTAZx05OjBEoZjWzWY0kKhtPtrwoAzT3akkeg1Uo0Z6be5zH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(5660300002)(83380400001)(316002)(26005)(53546011)(66476007)(66574015)(9686003)(6512007)(54906003)(6666004)(82960400001)(478600001)(38100700002)(66556008)(6486002)(6506007)(33716001)(41300700001)(8676002)(66946007)(4326008)(86362001)(8936002)(6916009)(4001150100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?uRgJ3fh9SN/Wr6v1t/tPJUuhupDHfud7riBooNQ3/PV8GTYlD9k2PqN0Nf?=
 =?iso-8859-1?Q?QzrvTcBNykAz0fM3jR+ZcjjuBhHqwbwhdU1IxF3SeTmpqYzD6r6Z9bWIKz?=
 =?iso-8859-1?Q?TW7gih9JCn/eXCDKRJy+uN3KE96VF0MRekHL4Qlhhnjfc20t7XD2vvJn3p?=
 =?iso-8859-1?Q?tPtnCx7qV9BPfDYrwZ08gWVIqb+4ZMoWMQS/79PMyjtKQIjeE9jzEMPapc?=
 =?iso-8859-1?Q?HlCulAnHsPqxJD5kQUWtiGB6hLOty/sSnux7/lI829jc1rrJMwbJmxY/VM?=
 =?iso-8859-1?Q?TOhsZ/U7JIF2PbnrkVxy6NQuRey5RWsvR46QooPkf+DmYymbBEnYz3Rsu6?=
 =?iso-8859-1?Q?5k3QxeugEdL4b3SRRqWzLH2hKGeYlwYsRa9uDJ2b8RnFi/SoBb/w09W2vz?=
 =?iso-8859-1?Q?QZ3zmDjXd44VtJ4yhV+U1W5gELtfofKVp0CuoR1UxchJy+qP0VRdoERQRk?=
 =?iso-8859-1?Q?/C0Sz0NtmbDPGJ5idNzYZ4rbZiDgcAOIOSzdB+Zj2rjDUDfUdhzDBVtvYH?=
 =?iso-8859-1?Q?50dW1uMXBu2bHKJJcv3ejwqKfINmfgn5eum2qoIXMah5jlsHayI5OhNUWt?=
 =?iso-8859-1?Q?lgsjnKrA31shExF+Pz05hFr4eHzH7SYndkU7KXS7w6lIOOO1wCEglnke3u?=
 =?iso-8859-1?Q?MKvxJvppqTNyBbeZX4YKJT1b0/NYaC/QpygvvEO8yyCGZeLe/zATg1JbDO?=
 =?iso-8859-1?Q?sISaus82r0EmVrLsdOZ3ef+6V4VN+lipbXgQuY9y7fUmdWTvh2Po6CE04d?=
 =?iso-8859-1?Q?xmTWZoRTs8asXyLMymtrY4NJhLg86o9fFWBH+gfD/BP8lK19ta7DAus5Hy?=
 =?iso-8859-1?Q?9V5x91EHmGC/BaXOjAXEh77tYSjJvQ/ns5Bo/5aiYszKKtQxNs/NisrNky?=
 =?iso-8859-1?Q?vybu56B6OAhQCjyKH6TyCpDMaLUmziuorKHrOPDiMEFQZPe3U1zdYWYsTQ?=
 =?iso-8859-1?Q?EYSvkK75bv6UJrrJhQpIAR+TFRgVx5ijVPUiMrG2CEy22rlDGj3EcPu6Wj?=
 =?iso-8859-1?Q?W6F2cS/RJYpwj4NPb1C1qGT1ZvQjL4kJWVHoAITH+uKPXGmlnbDTJBMg01?=
 =?iso-8859-1?Q?LIQ9d/OeRP6ccyfloDavZ0v+oPXz3UuV5P63pcPVViNkI+8xDayXrfMTgd?=
 =?iso-8859-1?Q?tc0Ko9yknX8UboXsAZ43mT9tEruc8NUwVv61DHH7qEeuNGYV8DMtRW2BxA?=
 =?iso-8859-1?Q?VYA1qbgdNrxd9nwyjxZ1XIQj+eKckGmbV+d5xfrScpB3OicXZV8XJs2aJm?=
 =?iso-8859-1?Q?86SBvTR01H3fyXn/eTf0lUgyOBRLDO9Cd605gXxGVquNEVxtb5Gc4NrF2Y?=
 =?iso-8859-1?Q?kODVscmWJ38mN90vjdKkbgSj5EO7qVUeqKSmoAc0GkqjEokM3GMuCO/j2B?=
 =?iso-8859-1?Q?OzQMOJOT28ZeLme7k+RrwOSXZSXfsll/C9zv6NZAd9o2R8zYvpZZqgJhhG?=
 =?iso-8859-1?Q?MOSdyuPHOfumNjKMgPtZCjyEzEW1wd8grE6vS4feYKxhwMi982GskoI1cv?=
 =?iso-8859-1?Q?7KajFZEBzaya1u0ySCI0KgDiy7BmzHqtMOCv5KGiIPwPBygz5ybbiNXFWM?=
 =?iso-8859-1?Q?YSpMUwTUd2WQsVkw/ez9WZZQZH5aLLb2pEyNs8WWZQgrIHe4FA6WufuE6k?=
 =?iso-8859-1?Q?LGwiRivgmjZAWU7SP6BKXiTCedwYsCEiPJ+6E4s41T+MDbayPyuJiT8VfJ?=
 =?iso-8859-1?Q?Aez8y83JDFBhyoziB6g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9e9d68-3287-4ff0-9dba-08dbd6ea2aef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6239.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 12:42:24.4669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKyVZuqLR5k7PH1YhdJ7nVxox18Nmg9QufaDh9Q4q+BTMuPVosgSgXCPhBj5LNGlEtBtMoM/VdXP74amewA40gpM6PZ8yrwORqSmWDZBkbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5769
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-10-24 at 12:26:31 +0300, Ilpo Järvinen wrote:
>Resource id is acquired differently depending on CPU. AMD tests use id
>from L3 cache, whereas CPUs from other vendors base the id on topology
>package id. In order to support L2 CAT test, this has to be
>generalized.
>
>The driver side code seems to get the resource ids from cache ids so
>the approach used by the AMD branch seems to match the kernel-side
>code. It will also work with L2 resource IDs as long as the cache level
>is generalized.
>
>Using the topology id was always fragile due to mismatch with the
>kernel-side way to acquire the resource id. It got incorrect resource
>id, e.g., when Cluster-on-Die (CoD) is enabled for CPU (but CoD is not
>well suited for resctrl in the first place so it has not been a big
>issues if test don't work correctly with it).

"not been a big issues" -> "not been a big issue"?

"if test don't work correctly" -> "if test doesn't work correctly" / "if tests
don't work correctly"?

>
>Taking all the above into account, generalize the resource id
>calculation by taking it from the cache id and do not hard-code the
>cache level.

In x86/resctrl files group of CPUs sharing a resctrl resource is called a
domain. Because of that I think "resource id" terms should be substituted with
"domain id" to match core resctrl code.

>
>Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>---
> tools/testing/selftests/resctrl/resctrl.h     |  2 +-
> tools/testing/selftests/resctrl/resctrl_val.c |  4 +--
> tools/testing/selftests/resctrl/resctrlfs.c   | 31 ++++++++++++-------
> 3 files changed, 23 insertions(+), 14 deletions(-)
>

-- 
Kind regards
Maciej Wieczór-Retman
