Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1A579DF9D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 07:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjIMF7T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 01:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjIMF7S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 01:59:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD29DC;
        Tue, 12 Sep 2023 22:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694584754; x=1726120754;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=SacvpCQm01o69x6JqF8Hk3lA16pR/KCgLJZT1LlHFwg=;
  b=KoiJbCD92cFgJM87Ys8aKf2xCmbxXHCbfhHGMWiewiFSyTyTm9nu49NN
   6ZfXNJpIz9qPIoAWgqg83cG/ryUTAQbsd0SzIpLtSumMiSc03mlXE/wWF
   /32YyhOE5wdyTNmuiVq5WoM4g4YU52GGDhbWawhv79J8TmuEsxrItjvZ4
   +N4NsJ61SE6Gl7IhXGvp+07/oSImdsPi6wDBoG0ThbBEtCNJ8s8Mk6K06
   KEvYMawic3R2d4F5HnPUOmmBbF9Hoyi053V6pNqr1tVuhelT8ixvYlY4K
   09H6TKLjOgIitjfqfI79igzii1uRZlAWWcLLmU7FzzbRFADpDF4yFHS2W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="381270126"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="381270126"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 22:59:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="720688634"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="720688634"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 22:59:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 22:59:13 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 22:59:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 22:59:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 22:59:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/mx9yzo3iESED9Vc9eBcyiciUjX6fk5qEaaOE3SIT5H+fN2mfL9xX325x/NOKM5LZs7zM7Q6q3GvRX2cDlv9GTveqFpylr3vmxwKDB6G/NFmBBL9LlfxwIY1RaEc/bR6gFqX4R39kL80QEjz4gakJ21NSGMltRXYfJEKfnQzFfA9DLMVDd0cpJPIahTwR4aH98GuoSdJ9z66IUEI0ODslRe3dhHDSHHZtpYa7e1Vc+X9WcH+ugZaF5wI7ht7mieZmilK4O9cM7nhvUtn9vLVx5COaFMZitoTOvlQ2GoBIbUrY9TNIX3AwTwiiB7fZsT3O4d/9DVHbw9otOpdZySLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFkGO4veBBH4eB/8TKhJthLpb9/K+yz9f3WRy3JkWsI=;
 b=XNPX+FIn4Y4HWyMvmOo5wRB3nM3apE8QTR+6KKQDx8qqgAXg6DHDEZlLj8yiMVDSQrW+XXIWRA5NIm8c8ax9IxB2dVDTx2rbpQ2fzrO/pwfV34uH2d1e+s5CZ8SGObyp6/6khNPpwVUuidYI6mvcPj1j86OltplkxPya7idn8+jYayJX8SXpgrZ6yZYhJzDmJYvmUMpgy4+DhxHGLi/EKnaAWne7lN270CM3wms4WBSDTFVrR4HBAxzlR36W9e/8gowXpw8/ow9hEFlyrOnfykIbwBehrEsix00O53Q2iQIr9bbVbroex8Nv6JoVAoshXK73ju7vkfE3ScUXdUVl6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CH0PR11MB5491.namprd11.prod.outlook.com (2603:10b6:610:d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 05:59:11 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6745.034; Wed, 13 Sep 2023
 05:59:11 +0000
Date:   Wed, 13 Sep 2023 07:59:04 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RESEND v3 1/2] selftests/resctrl: Fix schemata write
 error check
Message-ID: <jyxp5mspjn7xbmclj5sumbsuwd424fqmdvntiiuq24tiz5yqb4@qunho7whbamf>
References: <cover.1693575451.git.maciej.wieczor-retman@intel.com>
 <960b5302cee8e5bb0e83dcf20cd2ef4d353b7b0b.1693575451.git.maciej.wieczor-retman@intel.com>
 <99eabc5c-f5e3-27dd-0a29-ad0cdb7b4239@intel.com>
 <sr6ana6d7ebtuxbhjuo6kcnhnn2zzvg3ivve6mndqeb3nxrzo7@mrfmtzlxlwdh>
 <a7f0dfb9-c841-b240-fca9-b908517a44d0@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7f0dfb9-c841-b240-fca9-b908517a44d0@intel.com>
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CH0PR11MB5491:EE_
X-MS-Office365-Filtering-Correlation-Id: a0fddcea-dc62-423e-bd17-08dbb41e8cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFyDfLcYupBjEluppPD0Rdrtlo4gBLKSk4pk7w8eGmcMhV6+XFu01loQ3ctRBB9Nwbgyq8Tx8j24/jI+6HQ85cxcx5GrjFioHzaT8xtwMDRyA6fIaOSwpiRkk2L23/N8FMATgBXuPGL7JwMBLCvhvZMn54cgmvDihfF84pg8n1KdrrQYC1+VwdsR+lormEru/C06dHXb7WIfy2/4xrIIecAPUlRNvlT34+mLRX5J2GXQ4NgHIgtcufxn54c91JHuV/7bFgNULDzTWxojXwlmqFWr734UVWN/Px4peWEZhYDwaAw9XFqANhCJh95fTegUBa42i7Slj0bbBSXCav7CtWrDSNXVr87WYA+plP70UYF1LNeCHjuGD+BTD7g1VSYII5E8dKtrz5ShWIOhF3R4kRA68koKLmyLzukVkB167Ng82NjFATSvKnkg1Q42Fe2BHjV3GH1KyFqgIE4g6JC0tBqjgUugKUFn1HRXVsX/UAn3v84L08xJLOmeyVe4/IrmgH077ynlmJhgiXptDUqMCw232BvxlY466Yty56SZnQh8V2v3eMql+CSSdkOywKNd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(136003)(366004)(396003)(346002)(1800799009)(186009)(451199024)(6666004)(6506007)(53546011)(6486002)(86362001)(38100700002)(82960400001)(26005)(66574015)(2906002)(9686003)(6512007)(478600001)(83380400001)(4326008)(6862004)(5660300002)(8676002)(41300700001)(8936002)(33716001)(6636002)(66476007)(316002)(54906003)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnZNK1RSTXp4RGVLNldlSnltQ25kYnpESmk0VzFwQm4wYUF3aEdtS3I2RDJi?=
 =?utf-8?B?QmpVcTFIRytKd3hHM2x6YXhJV0YvRU1PdHRobGtQdlZNcVdUakw4RnAzT3Uv?=
 =?utf-8?B?anRoRmVvNzlDNlVTSVg2WVZiVXRLeWRsd0x2VVphTUl5WEVOUG9tT1Z6SUNp?=
 =?utf-8?B?R2s0N3Z1ZHZlRStaaHl5aUs0Y0t6ZGg5TmFCUHpTYStlUzFEVDFxaUxmWGh1?=
 =?utf-8?B?NnB3a1IxNFZrUVZJVVR2Vktma2EyS21DSlhQL1Q1eGlRVkorRXRIWjlpM1Jm?=
 =?utf-8?B?Z1FocFMyNnRFNHBFK3FRa2VOai94ZWtlVkJPS0VJbmh6eTBHaDZqR05WUFI0?=
 =?utf-8?B?bUpSQXdFRXo1ODJVbTVBNGVRR0t2d2crWkZIQWQxRlVzbnBGOHpnNnZOSytG?=
 =?utf-8?B?akVmZDdhZjJ3cG04bWlFVnFTZDJJQnh1NEJjS2tUZnRaQ21JaUlScmwvcXNN?=
 =?utf-8?B?b2hBU05zWVdWOUROZFo5c1RpL1BDSWxvOTZFSksvbzRsMjVSb1JXRmcvV1Bq?=
 =?utf-8?B?U3BTR3A3UGZ0OFlkamd4VFZQcDRNa3V3aGY1bUhweVpwK25kajRCaGkrcExK?=
 =?utf-8?B?bkppN0ZZWXIxQXRhb1NhMHBHQ1Rrbm1lMDM3YVR1TktVaXQ3TjdzckY2N2FM?=
 =?utf-8?B?Z01LN1M2Rm9BdW80Qno2YmRUZWcyb2hCSHpkcGg4SEdVQnhGVlduQm4xUDlX?=
 =?utf-8?B?c2ViWTdYNHZUeVlVQncrV1VLWjlxajJ3UVpzM0FZWGQ2V25wMlFEcno5TkZo?=
 =?utf-8?B?ZUFvbkFHTE51OGVzci9jVEM5YTBDZk54TTFHS3dOQTM1SXBEek9RNG5UNi9F?=
 =?utf-8?B?dWNyZ3M4ZngzNm9FQktjbmMzcHQ1ZTdjUnFRRmR2UTc2eTlrSmNZYnFlZko5?=
 =?utf-8?B?TWF2cVNVZDBNOEFoN2d6Q1RLcGswdExUSUdsK1dZZmRucDY0dDRxV1R2Wjh3?=
 =?utf-8?B?UlVycURYRDA2M1dDOGxOU3RNNmFnNFg3VS9scm90NElpR2dVcXhJejEzZFNo?=
 =?utf-8?B?Q1lCR2t4SFBiVDJUNEtocWdvMVVMTTZGMFdkYlpGelB1MjFqZUdDT3oxZXpx?=
 =?utf-8?B?OWVGMGZ0ekZXZlZER3hBM293M05LM2JMN3FWU052RE5xY2xDcDUwK2lvQk9L?=
 =?utf-8?B?aG1kaUlwMCtTZmhUWkNTUVcvQWw3QjI3SGMwNldOVmo1RmpoeG1vSlhpSmh6?=
 =?utf-8?B?V29rOVNHV2tZcEVuVEhZdGdXckNxYXNobXJZN2NSZmZSeE96MzdEKzlvOFZy?=
 =?utf-8?B?MXBodmZnNzFDQUh3SkdWR0lYa3N0dDlEY0RKT3lSODdwdDBwelZNSjNQVm0v?=
 =?utf-8?B?RTcxWlJOZDVaaHVrOW1DbktzVmFWbmE1amVhWHNIU3k5UHdhNTEyQ2FFbE9v?=
 =?utf-8?B?QS9EWS9FM1ZYR0hIUWg2Y0JQcGVNZjRWcnE1M0tZbi9OOCtZT0M5YWpYc2JC?=
 =?utf-8?B?RGM4U1pNZW45M3UrQmZSZCtOeG1UVnA1bnNCbTRBZ1RjWWVqemlIMlEwOVla?=
 =?utf-8?B?a1BFSHlOTHVlTXpmZmpaWWpmdFYrQzVxV2p0UlFpc01uL3MzQjhvMVl3czJu?=
 =?utf-8?B?QVA5b1I4bGNubkR1aTJ1TTByMnFONzI4TVJOVC9VL0IzQzdDWjRVVHQxa0tD?=
 =?utf-8?B?dG1vb3NvTm53Y3NsdWh4L0YrMnlwSTFNcENEYmlFUnAvOHFuNGZLQ3hOTTI3?=
 =?utf-8?B?clpPMkdiZHNMd0FWM3R4eXlqVUFRK2xZa2MyRFlmTUZrQkE3bmQvSkgwc2J1?=
 =?utf-8?B?eFdxeFVOR0tyTVNJS0NWaHZ3OWxTdFp4UmlINldMSGl5VmhjVzlYaXR0RCtl?=
 =?utf-8?B?bU9uVFNkZHZMV0xqcFlyQk84ekhIdXFEZ1RQV1h5WnBEWnpuMmd0RGR3T216?=
 =?utf-8?B?OE9XMGg0elZVS0hKZkZHUjN6WnhOdThPaXZzemZCY2w3dHpDYkM0dmlDUjNz?=
 =?utf-8?B?bVFCZnlGZ0MxcnBDN015R2x3aFN2ZnlIajZkWFpidyt5VDluWEJ6aW9melN6?=
 =?utf-8?B?Wm56c3M2TUduamxRVzR3YUhPS3lyMVgwOVAxeGJLNEdmQkFHbGRTclRGcTZS?=
 =?utf-8?B?VGk4N1F5Nno0K0JabkhlWGYyWStzVHZhbGFDcTJsODdKNEh5U2ZORlNEWnIw?=
 =?utf-8?B?WndRVzR0OXg5QVZlU29jbUQwcmlRbnhSVW13dDVtMG5DYVJ0THp4cUdYcWVG?=
 =?utf-8?Q?tazPb6vs7Oa6Zws2HAmCjj4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fddcea-dc62-423e-bd17-08dbb41e8cd3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 05:59:10.9558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/vTWtak+E+xvo8MUEHggATR4PFfOgcQ2xIlnBheo5j07zYla2d5itRIFUaIBqddD/vzQNL3pMeOkyINYtqLVrSXHrrE8Tmjl0Wo6mjCgvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5491
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-09-12 at 09:00:28 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 9/11/2023 11:32 PM, Maciej Wieczór-Retman wrote:
>> On 2023-09-11 at 09:59:06 -0700, Reinette Chatre wrote:
>>> Hi Maciej,
>>> When I build the tests with this applied I encounter the following:
>>>
>>> resctrlfs.c: In function ‘write_schemata’:
>>> resctrlfs.c:475:14: warning: implicit declaration of function ‘open’; did you mean ‘popen’? [-Wimplicit-function-declaration]
>>>  475 |         fd = open(controlgroup, O_WRONLY);
>>>      |              ^~~~
>>>      |              popen
>>> resctrlfs.c:475:33: error: ‘O_WRONLY’ undeclared (first use in this function)
>>>  475 |         fd = open(controlgroup, O_WRONLY);
>>>      |                                 ^~~~~~~~
>>> resctrlfs.c:475:33: note: each undeclared identifier is reported only once for each function it appears in
>> 
>> Hmm, that's odd. How do you build the tests?
>
>I applied this series on top of kselftest repo's "next" branch.
>
>I use a separate build directory and first ran "make headers". After that,
>$ make O=<build dir> -C tools/testing/selftests/resctrl

I do the same, just without the build directory, but that shouldn't
matter here I guess.

>> I use "make -C tools/testing/selftests/resctrl" while in the root kernel
>> source directory. I tried to get the same error you experienced by
>> compiling some dummy test program with "open" and "O_WRONLY". From the
>> experiment I found that the "resctrl.h" header provides the declarations
>> that are causing your errors.
>
>From what I can tell resctrl.h does not include fcntl.h that provides
>what is needed.

I found out you can run "gcc -M <file>" and it will recursively tell you
what headers are including other headers.

Using this I found that "resctrl.h" includes <sys/mount.h> which in turn
includes <fcntl.h> out of /usr/include/sys directory. Is that also the
case on your system?

-- 
Kind regards
Maciej Wieczór-Retman
