Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6396668B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jan 2023 03:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbjALCJz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Jan 2023 21:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbjALCJx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Jan 2023 21:09:53 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A143E47;
        Wed, 11 Jan 2023 18:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673489392; x=1705025392;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bI11TQDyPFErpydG78nahFuueKmJzecO+iVvgJQBk/c=;
  b=aB4mh2ygbbDDg9Sol99p6DJpQNuGetBTlfkWezL8JEcEDj0l0NXZebyz
   SEMQnWXWF1maUqe0OAPtNJesbKJjxPzN8TIkkCD6jjdzqydaZJgGWN7Gf
   P1BHB2arAKAVt08jgDclNffmEIpvyrXnfem57YcgRL8aHylqzXpPGIMv9
   SsgCWke39KnLAWwN4tJQ6tyYU4XJWjBhlx0Mk+CswoPBI9nICLecJKTMB
   Ds1M1oeUDXjzEsND1cDuRhP2DMNuI2JgjrbrL/yv33H0X0MaCGTq1tQwa
   mmBPRemFtb7gGXa+A+TvP27/UmLo2vWPi/y4tjPmcugKhUgwzI7/tTfuH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="321281418"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="321281418"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 18:09:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="765389505"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="765389505"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jan 2023 18:09:46 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 18:09:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 18:09:45 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 18:09:45 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 18:09:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PknU+eyfP1fMKZpuzdaDHd7GINFzGHeV/cBWrLg72sJWhd5yXjrQnUZrwAyicxE2TSjn/1TTHUQCIv7uA5swlq240s+a8Zat2GjfI/SXly3QtblvAWSVCr3Y9CMYF7Eepkpd5oz3otWNYC8deHFP8oKgw/qS7nKX8G+K7Cnv74sYsObgbmeZViP6+B0uQxImnTcl5KZ1eS2GIpT3BA6D+sY6TiTMFUtkLuVNqdD/v23AFjn2mAr68aXiRcSFzgsqhyv+u5b1ChzYySKtGA5iaZ1o0Voz47LCAjAh0dov/jXBJ32In5jYS75R1GkC/PvDlj6kIsSv1Dreb24c565SeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7LXWKznn574CPaxojWfQl1z7DS7QqPsOwXRFoE0ZPw=;
 b=lTDdbO+7EHq1iOaayzqbYEpH2catIIYStMWfvO+W/32VuCWdNtjeoTta4yrJ2ZNal4fH5fstYPlGECX4tzvE0fugFBQhPhrupzW8eSahXygG2P+AfA8vhVhMT17rMnviY2aiA1ZGeATVhO/mLeOWg5sUPuRbYua88njjvFyp5h9uTK6ZxOlIQ7NNmXEJ8X15kPrzUcPx64gX+T/DxCA1+qhBRV+vdb2fciaRi8U+hHhD9Bxbp7d81mOe12AiagLqyUXOXnEEQSlSM4vqXvu41WZXcUGhahcg3ncA7S6Lmkauty3WO/CkWDTLsHTp0WsnZtAB2UuLtTuFrhApAM0asA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 02:09:43 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::fa67:cc38:6224:ec80]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::fa67:cc38:6224:ec80%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 02:09:43 +0000
Date:   Thu, 12 Jan 2023 10:10:36 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
CC:     <skhan@linuxfoundation.org>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Heng Su <heng.su@intel.com>, <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] selftests/filesystems: Grant executable
 permission to run_fat_tests.sh
Message-ID: <Y79sHLMU4BYEwFAn@xpf.sh.intel.com>
References: <cover.1673424747.git.pengfei.xu@intel.com>
 <dfdbba6df8a1ab34bb1e81cd8bd7ca3f9ed5c369.1673424747.git.pengfei.xu@intel.com>
 <667c1b8e-b46c-c830-8f01-9e97e64e4e4e@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <667c1b8e-b46c-c830-8f01-9e97e64e4e4e@redhat.com>
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SJ0PR11MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: df57effe-51d6-44cd-6fc8-08daf44211d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UPigf2ZNaenCosaUaVLkobaHUtUhE7ffXqElkgCcjtWySE9Pex++9ny3MwEcW3lykEyFOTlJjipNbDgHuI7/dBSOhMSZn+d6fWvrlpTFbHMRN7sTzWQ+5kcCHWYLsQmYYWqMm2g28Wa9hytlPCn5mMUVNXXWPAuF+fGAjhvMr/TpjiZVgsjb1AnhkRYgUynqlloNvCpRKAcTBD7bIbqq2zn+6WcmK4PeQzHIpRVVAPekP0BL+pQjVsw4Sb7BOQyR3VfybZx7OVEConRMHSc1c2RHYDVKGi3RgQrLmwzXq4bRo6JHtg0WnRS/LeKSWIbQ1Fo/QZuQmLJDfaXGPvfgdmKskFmXO2UUPCgwHw2fqtcXjVeietuT55yBBhOtNvA46NOkWKjtnMX57l/Z3PL9ycWHQoyUkS37h3fCCKSfiyWV7JLx2qtFZD2Bq+9PI0mNpCbBt9stiX6DAFegE1Xg9leAYkkfdPtZLexuNtdn2miEudNpW6oUdpV73VOQitKyChsDNTZQHeHhEKjNTpCDFcCEJNzTS2xJB0tvSXvvkDe18LZSW4xYNwoQUpsiBCFOuiQEUp4CXZGYVskfeRGRAEYApgnceiHbCu0o2ifjaD7EHC3w9CjbZRtGYciiYsQmRtlZacm2b067prIv7z7z6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199015)(316002)(86362001)(26005)(6512007)(5660300002)(44832011)(186003)(478600001)(6486002)(41300700001)(66556008)(66946007)(66476007)(4326008)(6916009)(8676002)(8936002)(83380400001)(6666004)(53546011)(6506007)(82960400001)(38100700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a/UClpWnn5v1mX4DjPHTl26tR336EoMxUp3e8DBE0OasslY52zyKzjmsLBuA?=
 =?us-ascii?Q?TTQsCSkNJ5Glq114iCW9B7CXCN5+cQ5hoWnKB5yUY+GDOjxgSZEV/8t9/H0/?=
 =?us-ascii?Q?bldjcnf4+u6pdekY+qGkRN+sPwohuJlaLpD0amFz/CptBFQkrpk64jprq6ME?=
 =?us-ascii?Q?GdrRgEhqlua2vIvLU0jwgtQkd/dqNO5o/WcuvrDvv5qfirzFVnHGAncqkylo?=
 =?us-ascii?Q?uuP1QOaVvoI4QX+AW162wfLhA/fLXG0yFmA+emUiezb2sLXSnBT7Pp+bkj6P?=
 =?us-ascii?Q?HQV4GuSCgN0e0wKT7jupmEsXZ6wLA3K6GbmcnDJ6VeNa+KuNJq0NGt+F8CPl?=
 =?us-ascii?Q?uyJQ+kO9hF34ietbs0ICOzumMzEO/dz+2S3hL9QTvlnkpErXAFAgq+YdDG5b?=
 =?us-ascii?Q?MhVol+ZO7+VE0L4VWxwCVc3qScRv5xNSg3d36yFoBP5ipcSjO2uVDvC14+Yf?=
 =?us-ascii?Q?pcfUiYQQENxr6CY9UZwyuq0B+O4EF4+TG7ZjN9UzDSsd+kqm3D7G4MyuWfBV?=
 =?us-ascii?Q?rpw+ABemXtO/aE9fCXsS0yAmzU9Swcznm7dHPkbRnGlNKMKPxisOs001qPvA?=
 =?us-ascii?Q?2OE1mB7P0/Eudh+MG2Bwarx71qe8xP5sf3BuiMPdRVfVzflACpyM2BScfPOe?=
 =?us-ascii?Q?ejNSofHqnR6QOp2JlKeOncqv30HdPSllulBqr+4ZwihXjiO5usX9MuhCGi+b?=
 =?us-ascii?Q?Dp6bn7G7HHHwC2S5vzTLE38qkH79QDnifuKAuWVXepTOqlhaoQ1t9WJsNHim?=
 =?us-ascii?Q?PwFCdPgKWM8okeFOGy++vJgMFH6LDhkxn69k7QZrihpD4cMP2h+8I/JnF/sC?=
 =?us-ascii?Q?9Y4Uwwaoz2/Wg7vET1u7+B8PzIkm3FV2FmqBrfRkt8POwCHkR5BO9PL7841O?=
 =?us-ascii?Q?Bv9nMUUALRr/H3UtkGp2HyfXzim7kA6nMbHcs6hPuG7DgN8YBwXjJpZujcph?=
 =?us-ascii?Q?MXeoLFUdJQ/isCMBaI4p3nkFLJTnubOuK7CAB7BIfo9h05GJ2c20EC/Hk0hH?=
 =?us-ascii?Q?eIaRl/uDMkPOUPCDHFlvRx6ge4IPpCF7K0tzSGFvQs+guzBCFO36mpNJZPgc?=
 =?us-ascii?Q?fAA29l21iGXi8yOwzbhZBTkA9O1b09xq2Qgu/y52DhuGn0lw4CVDqbvyoLQO?=
 =?us-ascii?Q?LEtfmRdbWu+Z8/ozxLGp0FLzCQpEGMOVeZ2e5rD1fGfjvWHA+vwK/0u7vdwH?=
 =?us-ascii?Q?FR7q1HoymQmqbOBmd9De1t2fDep+7AFXsmXkGGEwi282qn8znuNT0/akoVoW?=
 =?us-ascii?Q?iGylRB3im9cGAB0uRza1m+/lGbM4jeRiaAe4Hz+IJnJkrFIEJVdNHv5DnWNY?=
 =?us-ascii?Q?aSEGgbee7j+5QBmzqQMijPkHiDmiLkZgH1w5AL0sZL1d5TGbZz5MQEIgbpvQ?=
 =?us-ascii?Q?VAP459xxG2lCnO6fA/HOlp+qiR+9RJMs7E3OQW+pGDjy4CIx9PmQswfMnYyg?=
 =?us-ascii?Q?+5gKd8+0dpQpltl7lCHkAxhF/z8e6kFmsHDc76QLeIQc9H+WqaSZtZYlK6VZ?=
 =?us-ascii?Q?TadqYzPxZStyR+jY7lUgCIDREan5Kq365DmA5w3MWct0KJFYnUbaP5cW2jCp?=
 =?us-ascii?Q?OwIwWKPJ5ra0oOLCBGrIz+3nK7GPzVRjuy2xSFb0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df57effe-51d6-44cd-6fc8-08daf44211d2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 02:09:43.1618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5yC4kgaH/EtcJBWTU2PEBogoVuv3kGMPXeAQH1YF4RtU8uxmSqfD3sJYcdVqRjQSmdHMzpUttc1RMTJtuWC2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5613
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Javier Martinez Canillas,

On 2023-01-11 at 15:47:00 +0100, Javier Martinez Canillas wrote:
> Hello Pengfei Xu,
> 
> On 1/11/23 09:15, Pengfei Xu wrote:
> > When use tools/testing/selftests/kselftest_install.sh to make the
> > kselftest-list.txt under tools/testing/selftests/kselftest_install.
> > 
> > Then use tools/testing/selftests/kselftest_install/run_kselftest.sh to
> > run all the kselftests in kselftest-list.txt, it will be blocked by
> > case "filesystems/fat: run_fat_tests.sh" with "Warning: file run_fat_tests.sh
> > is not executable", so grant executable permission to run_fat_tests.sh to
> > fix this issue.
> > 
> > Fixes: dd7c9be330d8 ("selftests/filesystems: add a vfat RENAME_EXCHANGE test")
> > Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> > ---
> 
> Indeed, thanks for fixing this.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
  Thanks for your tag, thank you and Andrew Morton, and I'm glad it's helpful.

  Thanks!
  BR.
> 
> I wonder how I didn't get this when running the test with:
> 
> make TARGETS="filesystems/fat" kselftest
> 
> -- 
> Best regards,
> 
> Javier Martinez Canillas
> Core Platforms
> Red Hat
> 
