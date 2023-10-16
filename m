Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4497C9EB9
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 07:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjJPF26 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 01:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJPF25 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 01:28:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB107DC;
        Sun, 15 Oct 2023 22:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697434136; x=1728970136;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3HbN/fkDj4tXmG+zWOVCT3Xu+4DiX6ZKaYLrMeHvf/0=;
  b=LQ/TXn7n0cYKFVBsVT8jL+S3+bqe23N0vaUnqUccLwSdsjvzcoB8/ycW
   oblgykiJw6B1Ksz5vEVVTpcaDfaHr+BNj9nmvJqtueWmG+LHjTL3u0hls
   yiKHQK+7np3v4kj689hArvIRdHXspdgsqjEDsEM8CUn7rOLp2XqO6dY1W
   3x7sZLr4rzYapLHUqhCR0iZbwi6xdhs85PAzTEeQFg6y2yd2Lynxd/IhA
   kxAWEypCxzn/vBQxgcsgHV0/WmjmkgBRxcWCy8mJfU97EIvxL/9X9ZeCu
   Fa3PNgy7fqETULL017OYPO7QEED+3HeyBA1DYRcjQpCYqdXF8ebVhmK4T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389307700"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="389307700"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="784969729"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="784969729"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2023 22:28:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 15 Oct 2023 22:28:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 15 Oct 2023 22:28:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 15 Oct 2023 22:28:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8eXSyxSuvVp0KHM2E3o/X4jrbKiP19d9A8sSLfYiUXeFJ4LIMrR2FIFDXdiOOmdfH25lNjn65RoBOH1vSTk4zaKH/6JJx4IP0LkOPb7Wwbg4eY79Lbd/L9CmVdP42erAR8danSy9Ioyba3NgU7e4yT5ducbYRWT7DgVvptxL5jjR5yRt09UO6Dt5Ujlkdb6CKraOq2SBuYBGiuk/hRE901Rcha9WHTGbnwWOVG5wiE8kDgzf5UxFcoWV8hEoVjNEyGFPuoN3wFI/zUWpiyl6wj7ImzpN9pSLGRZrnXfSv+7nKiPT+7wyReY6z/Ch+btImlTE/RSip0es9AfBDuNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arJ/CAYlaXGZnptd6jeqcQNwr+B8KHmbFqXGV2bx/R4=;
 b=cIZACD9qJWRWZs1pHPNd52a+EbJ3ekgoM9+AzDKGEffOTdzbINdwkMwlxmQgeld4MMKdMvQ8CzDmq4wsstAZCwdB/t45xeOh2XbcdyvkMrg+5khx8sBUmKHhxbKvaenJGx/1bw6VFyDdD0dREWJ+W6GS1K2Q/RCMyc6cLuNs7WR9SmRrgK3byDtIV8PiRDaVOv/wJd8ItzvvqAAuen+RXrCWCnmI2RL9U8wctz9Z2AUiAr/AZ4c9pcD/psle5XMrnjvGVvfywBufCYXz5q1n2nGozWEP5vLPufKu1GZJfPXmmFapD/AWAq4a0ACU7SdEkzxnSHHpuZcmWBJbWsBzwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by IA0PR11MB7792.namprd11.prod.outlook.com (2603:10b6:208:409::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 05:28:50 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 05:28:50 +0000
Date:   Mon, 16 Oct 2023 07:28:44 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Shuah <shuah@kernel.org>
CC:     <akpm@linux-foundation.org>, <christian@kellner.me>,
        <fenghua.yu@intel.com>, <keescook@chromium.org>,
        <ndesaulniers@google.com>, <coltonlewis@google.com>,
        <dmatlack@google.com>, <vipinsh@google.com>, <seanjc@google.com>,
        <brauner@kernel.org>, <pbonzini@redhat.com>, <hannes@cmpxchg.org>,
        <nphamcs@gmail.com>, <reinette.chatre@intel.com>,
        <ilpo.jarvinen@linux.intel.com>, <linux-kselftest@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v6 0/8] Add printf attribute to kselftest functions
Message-ID: <s3wj75zwkwwmvllobuevhf7nbkhyn2a2kwis7oyt3nwsnl5j36@ju5xzn6pw5p5>
References: <cover.1697196663.git.maciej.wieczor-retman@intel.com>
 <0efe3ba3-b62f-4447-a195-2447e1152a22@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0efe3ba3-b62f-4447-a195-2447e1152a22@kernel.org>
X-ClientProxiedBy: VI1PR04CA0068.eurprd04.prod.outlook.com
 (2603:10a6:802:2::39) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|IA0PR11MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 162bbef3-ee24-4a2a-cfa0-08dbce08c738
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlzNYtMMZbvA+EQVvfTFtP1LuJit8jEHAOExcUlHL1cKs/Ra63dz1xN/1Q0H72zm3sDjV3E0chcl/sB4k1iQH81ks/GZLJYwYQQmX9T2yV5yKm0TwcE4RCP3XUcCMusuP3CUfVzP4SzxP0GoagoNttkNG4NW2wDLvogbZBORYYWXX8el3TgEZt9kZrBGl5P4yLpI4EFU3MXpyteA2SWtwTws7dgQ/Gr8gOHhkodlj6H9PkPpGY/DexCMPtlqLZ4Ilr/CggTAnFehyEYhXoP4iaVpw0PlMSFcV9WDwOO1gCn4SU8ff3XQUsO87EY4C+VWMynfrUwGmilzU4KFpIA64XUiAV5B3OzkFqsYxMU2PajwAK4CpzJ+nkHooFusVjtKKhhUIGSX6KiNW8x4jNyCvLhMwFvrENO1h5Ys3bFh1XA1Hs8xCjYJh9O5Yo3ZYS4IxP5ytjrCNoKbErxSklPtgfbPscg2j+BLrzc/o179F0E0i/ubDWA8o4wgGHoRP82ZPYeN1E0+r39eoHZjBuBRfbOUXDMp7fojHw9A1Zo/0xMnIyHx3RBXFnX/tON/9ViHM8So6ejtgf6iKC6iD5kc8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(7416002)(4001150100001)(2906002)(5660300002)(41300700001)(8936002)(4326008)(8676002)(6916009)(316002)(66946007)(33716001)(478600001)(966005)(6486002)(6506007)(6666004)(83380400001)(53546011)(66556008)(66476007)(66574015)(26005)(86362001)(82960400001)(6512007)(9686003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?hyIJdKOvU+OFrneiR80DQuiFXRzagUv4SWP/JC0xkqt/p+g3LI+tDJPfhq?=
 =?iso-8859-1?Q?yZp94L+MW4TfIONkP8hODmxzKi9cbAk+16nw1MSs+YkP6+KYv0eLRj8B9e?=
 =?iso-8859-1?Q?bw6Un2AGW7goIgZsyarPQsC9EFLikTN7ytay58cUoeV1RwC9FuO/b1iqs7?=
 =?iso-8859-1?Q?ZNMJ+7WjoO/Mbyqn0mn6h8mSVbxfkuU2AmkG57Mh4/OujxHC5q7QYkSLnZ?=
 =?iso-8859-1?Q?HiMUEUqrKMVdP4UvTjSGIsABEn2szmPsoFuG7vTKPWngft2WLyYOXZeLwJ?=
 =?iso-8859-1?Q?fXpC50iEjDupfwsR3noPeeEsYDqbSiz+mMAPtl23sOg4mKEr9MsZshTHKu?=
 =?iso-8859-1?Q?NbBH0HgwLG5Kn7T2oapjCqdYPVNK7PGam20NawF+8dT51+z3NXu0IzvY9N?=
 =?iso-8859-1?Q?Xd+6th2UCgJ3lERCdmhqYVCLAL5LdMxoRs8ZPUyTh8WgXPKx7UlM0JUGXZ?=
 =?iso-8859-1?Q?7MBmui5ZGT+UOBlS8MJAZteHfj1Cy02YK+BbYpmOEL7O67bp/iS3CwWZmV?=
 =?iso-8859-1?Q?IDhp54SWP7IL5Hzu5Q8Yrb4jv592PktBeWLOhL6GDKWHPuZH9QLgW3x3xG?=
 =?iso-8859-1?Q?NMEDtlFUsVIZZ3pLaCd+PkBl/cb2zICq7rRjJKCQoGS0q88PwMt3dh1Nvk?=
 =?iso-8859-1?Q?Cy7SuHVs3WmCxPJGpriV5x0il5Zbpy4KVhRAjPpJFnfriSQXmzc/TK7qjP?=
 =?iso-8859-1?Q?N1HBjIr5qfLi+igF/y9Eo3umf1TD+AwaVPGy8mtMzFWUNeBtWaNfdd6gOX?=
 =?iso-8859-1?Q?UlvngY4SuEMRW0NEsg/3bZnQ8COwnRIW4wekQyg/Emqd3ETSsod5mAXolG?=
 =?iso-8859-1?Q?BM7LlOHdaEgHhtgnskXIWSwAmS8xHA647BRx6+0YeX1XbZ4IB/8BJq2tNo?=
 =?iso-8859-1?Q?1ypAuol8gvMcqOJQAKOvE8FJajZbUVfESD6g7pV2M/XASZ6lfbpMjoZ5T5?=
 =?iso-8859-1?Q?DZK2oiHYkc8JV47+ZIH4vgYOuLCfqGbgmHawgmU0ukDYHiDH/428B0qh1D?=
 =?iso-8859-1?Q?pilDjxOPMvknWG/eSLmnVa3vEZE3AiQHjsnG+/xSaBTSOzjXtG7omVy0jE?=
 =?iso-8859-1?Q?wgi7SXeSgNdBpISEhQhUGc33vZlEOwOnVHnfNq79enfrGrYiURWm06OpDP?=
 =?iso-8859-1?Q?r6IrI4TxYFgwAafN96C2Ulvy6eXQRyJTm7OxHjgzHf1jGawz1ueVvz+Fio?=
 =?iso-8859-1?Q?zdOkqhRSf0SaNSEwmVxpyaeaZU7/X339CvDf7YaP07yN+Z2MWIbLjGf0tD?=
 =?iso-8859-1?Q?mfLFk89FEdXhKaGBR0SHNxYOreQzaob2MINCOrKBl8EXVGpbFq77Q5oG4L?=
 =?iso-8859-1?Q?Uq1i9C2XBcqmliSA5EtYFUvybxUHw+KEFXYJYrxADoA9wOjj1lgme0sGeU?=
 =?iso-8859-1?Q?4awgf07YDVjvMkzbcfNVwBt5/BPJsCQTV4oqjDKi//RFVK3L3+MZ4jgQlJ?=
 =?iso-8859-1?Q?7CbBSMAkp7qzBfvbQXz+dSXfnuPvQhAI7ABLgE9AMbfF1goIGj8g7w+5Kk?=
 =?iso-8859-1?Q?UaFsF5kmXnkmZ8ESvkSM53w5ynVdMomBo/UaK0JUtyGCQlXxh7CLduCFDR?=
 =?iso-8859-1?Q?6pmqeRFiFEMTqRybduWqSwvG4e/VvB8e9v3fmKzvchCpUNHYrx6+ShImAm?=
 =?iso-8859-1?Q?qcvf5vxxOsjy5sR4bTSWCoD44eC49kmIQnarG9Jx2QbzGFh38WpMz7WFPq?=
 =?iso-8859-1?Q?Mj+/PIMwdWbjyVcQrA8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 162bbef3-ee24-4a2a-cfa0-08dbce08c738
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 05:28:50.2254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kE1/4gHUp7rnKRIrp9TZLldNX2vMv+3fk+2janYi0C46itN5rXV3vv1+l0/UKwWfRTatLo9bRKCHph4pqawSpCNQZFvRt4bdh2+cqS4JzLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7792
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-10-13 at 15:03:11 -0600, Shuah wrote:
>On 10/13/23 05:36, Maciej Wieczor-Retman wrote:
>> kselftest.h declares many variadic functions that can print some
>> formatted message while also executing selftest logic. These
>> declarations don't have any compiler mechanism to verify if passed
>> arguments are valid in comparison with format specifiers used in
>> printf() calls.
>> 
>> Attribute addition can make debugging easier, the code more consistent
>> and prevent mismatched or missing variables.
>> 
>> The first patch adds __printf() macro and applies it to all functions
>> in kselftest.h that use printf format specifiers. After compiling all
>> selftests using:
>> 	make -C tools/testing/selftests
>> many instances of format specifier mismatching are exposed in the form
>> of -Wformat warnings.
>> 
>> Fix the mismatched format specifiers caught by __printf() attribute in
>> multiple tests.
>> 
>> Series is based on kselftests next branch.
>> 
>> Changelog v6:
>> - Add methodology notes to all patches.
>> - No functional changes in the patches.
>> 
>
>Applied this series and the following three - all 25 patches are
>in linux-kselftest next for Linux 6.7-rc1.
>
>[1] https://lore.kernel.org/all/cover.1696932728.git.maciej.wieczor-retman@intel.com/
>[2] https://lore.kernel.org/all/20231002094813.6633-1-ilpo.jarvinen@linux.intel.com/
>[3] https://lore.kernel.org/all/20230904095339.11321-1-ilpo.jarvinen@linux.intel.com/
>
>thanks,
>-- Shuah
>

Thank you!

-- 
Kind regards
Maciej Wieczór-Retman
