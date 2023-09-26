Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525EF7AFA1F
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 07:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjI0Fch (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 01:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjI0Fbx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 01:31:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB1593EF;
        Tue, 26 Sep 2023 15:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695766484; x=1727302484;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PU/28rhQaCvit4L1SyhTFmhAZOiImiGqxQr9WCu8ih0=;
  b=FbRyxE/pRyo3Wcp8u2HoHbjgBbnhXFvMtSZXF8winvGvtTSRSsp0gE2n
   8Y7yW31wo+cYK10u8rx6ykYvqhOXTx3lKxuQcGgcKzlyu0fIWCVvz3rIw
   LAl7vLFTvjL5rIoEMpOLr6rum+gzYxLXjoDOKh4/4cNKYt4HlZo1xidI4
   33J2KbQ8d3L1JHlfD6H6TqX3Bl636j8ABgf+bceFUp7Z1nmG0BlG3Z2/+
   29RLwnnuMPzllEjCymD8CvWTkmBiJxqEviE4+50PPbpJhs4c/j4kU5B2O
   LrgJJo4VwLoVdYHKW33oh2kqRSGHBW7hw7sbAa/WCO5RmBZp8EgKzGMHM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385526706"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="385526706"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 14:39:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="1079866728"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="1079866728"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 14:39:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 14:39:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 14:39:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 14:39:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 14:39:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWqhihScjNPLwNal9vve3i76AzhnlkBI6ThYBYuA16hPxB9wadt8R+1J0Gzsb66WxKKvHWmhYOxzijwt7ARZtDB0kTSeuEw/7pf435ZFMdHnpO01TVpToIVEtvYC/EFkGKgY9vxYFNEpzwe8USs/BTnKbawyhL/9R+8a2+N+j/4MZaav8jZXzim7C64mdMoIkl2u441sBzNs6/ZrFbwI31na4S6WZCTWyCdcH+8MVGgWXgcoWfB3+IsEap+KwDWjuCwgxQvb8GjBF5+fy8qgDWs5wj7Rdd0dzR+lG2L2R3bzuYO7n7cqLvLKnuZUePZP6DKVsJu50Qv7+C/lnoZ7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKA4I3rc00r+ouar130IJjosx+hFDFY6sH1Z3iqgjaE=;
 b=aVlisTC+a/Q0PWdRa7ByTx+Yn+CA1geyhZ/GqGgeBsJDoz0XI5zNuWF7Fs5z8YEppe6B+leRiiKSRkkLPURuBabi8OBYoy0gOj8kthZFUqRrEvL6O5oHONKcCALOrOfyXg07TdvObC3hg2amvkRw0FAgTWNDkuZmbBfrCF6tSFKndpq/tum3UFPm1qV/p8Uf4dxp1rxzCa5AHPuS6082tJsBVkaowfdHZeh27BpeaitcjfhOfpa9l7fV+lbO8JjsraHM6GJlMmyRJBlYkNybeoRtpNPahKLUYryw/GlaPdWqYB/DwR0PvZuTVZ1qCj91y0q1TEEhFf/iBUczdMWmEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5131.namprd11.prod.outlook.com (2603:10b6:806:116::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Tue, 26 Sep
 2023 21:39:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 21:39:52 +0000
Message-ID: <36e02c1f-fecf-f6c0-3baa-96fa15e6327d@intel.com>
Date:   Tue, 26 Sep 2023 14:39:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/6] selftests/resctrl: Move _GNU_SOURCE define into
 Makefile
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        <stable@vger.kernel.org>
References: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
 <20230915154438.82931-4-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230915154438.82931-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:303:8c::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5131:EE_
X-MS-Office365-Filtering-Correlation-Id: f4bea5b1-18d3-42b8-277f-08dbbed91dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVEvZHntqv0wo4SA3PAwq7g7RSafHsIaL3C6nEsQdZ32Zz/UJoxGeDw6hOBSTsk1FKS6djseRzBwcJqQwJ1f8QtV0i+j6+Rv0VPsAhqVeZwsjuhEenpAbRvA7VKHW9q3BIP21HmJg1prnUX+h+RgixpkcocowxtJEunBqpXrzef9OqQrHe3Bo6ekX+Y+BZXkpFx7XbJ7x0hL/hza8jVoXjVa5xj4xFt0wtBA4EnBZYXwMrkdDDtdPyCb0yRrnDyfpl9zYrlZMDaWArx+KW/o8KnWaEbOeB7EYZ2fBQwC8KXfbNXDD6Mk//Nu9+Z4f6vloVmPR+zKbxTBwlgkMbcdLpbbN+XalsL1Rqbr6AyE6zF0jDAdmcqnUDdeYucPOVHJK8XFXS8cMOfhgPS7CkaAsHBZM7ZwQzVg1mdHIFnXewkoK552QRqpZBfxDHERTYmpYBT1uhCNUxERWHVYf+AYxTOfuTKzMNXSbigqFgEe+o62ToW6XKJhHQRKPKYsHg6J5lyyc8CdsNNMhKD/9tr91S22uWT626VzQa4GIaBktA6CW+g35GSg/oz6U7ZYx5dnpFGg3yW37QOpbYx43vLNdIN4NQPsFvQFTotHMW8nUvuI6eDUtmCFmuPEpNigBjO7sSSYSMkRMH0VDorAYQXmBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(451199024)(186009)(1800799009)(38100700002)(110136005)(6512007)(6506007)(6666004)(31696002)(53546011)(6486002)(83380400001)(44832011)(478600001)(31686004)(66556008)(6636002)(316002)(54906003)(66476007)(86362001)(66946007)(41300700001)(8936002)(26005)(4326008)(8676002)(4744005)(66574015)(5660300002)(36756003)(2616005)(82960400001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkRTU1piekFueTZKbVorOTNYT2V6U0NBczBxY2gzRWtRSTVVQkhJNGorUnd0?=
 =?utf-8?B?MU8wWjhwN1I0dkJJU092MmMxa29XZlF2eUFDZ28zeE90blM0R1Q5RnNCdklH?=
 =?utf-8?B?QjFNZUNVY2tFVTVwV2lFNkZodHppNklCa25FVENaT3IweU00dzJqSTdTaUlk?=
 =?utf-8?B?RTAzS2VJdk13eGQ2OW5uajJkVWs3T3RsWmpXUUgvdXVSZ3g2ekZnRnZCSmdr?=
 =?utf-8?B?QnRXMm96RDdzdXVWeU16Yno1eXM1L1Ztc1RvY1RRcFU1SkRWV3pyeEpuTFpi?=
 =?utf-8?B?Qk9CRXVhRTQ5Q0R2Rmh6VlBHRkhWZ0NEQnVVNHZHbmFuNTlpWjJvdDk2TzVr?=
 =?utf-8?B?ZG5xWkZCTEVKQjA4UWRHUDhOUVF1ZlhkN3B1TkJTcmZya0xLWW9vVktSZ09M?=
 =?utf-8?B?M1psVG1IbTVLU0tKbHErZUFZYU1MMU1tUTU4NnFHNTQ2bGk1NUpnRWtEZW0v?=
 =?utf-8?B?VTRXM2dCTzV2RzV2VW5CdEMzV1VTaDJpSEo3aC9jb09TbFJXUC9vZU5RTE80?=
 =?utf-8?B?TjFYb016ZVE2UWMxY3dObkU4MFJSNlBkazU0QzcyeUtpbnFMWU5yd3Jsd0Fl?=
 =?utf-8?B?eDQ3cWFQUVNJOThFcmdmREJOZTlPT1RJUWIwVlptZmxGVHYzN1BXd0ZVNHpl?=
 =?utf-8?B?b3J5Mi9iVjgzTUZCRzh2TXpFZWdHSE5JTktkQW5peG9abkE1WjV5b3JKR1dz?=
 =?utf-8?B?b0ZUOTdZdnJkWUZVSkJrd0tvcStyakxwc2FIUzUyMldSalNEUFpJZWg1d1V1?=
 =?utf-8?B?bk1hSWxTdENZVEhZR0JCa2JLUUpRNThpNjNMUWJKb1VreFNRa3hBakMyRWtw?=
 =?utf-8?B?V1V5Q3AzNCtFMGVqbzE0djhhdnUwVEUwa01wdXpmdlphaGVxWCtnZXZhV1li?=
 =?utf-8?B?bzQ5RytkLzhuSC9ac2FkVi8zNS9sRFhMZTZqWFpkdnIvb0FPTmtpWlBCT3RP?=
 =?utf-8?B?MC9FV2x6dUVocmN1NG1DQzlxd0lpNEEybTdodDJabmVFVXh5V1NBZERyZXM2?=
 =?utf-8?B?THBzQ3VPYWRMZkgzNUV6UWVTMk4rMlNqNW1pSThSN3Rrb3hWNVNhR1dmblI0?=
 =?utf-8?B?T2s5SnI4VU81U1pEaWpoODN6MFRZMi8zb2RyVVd2Q0ZQbmZxME1oMzFiVDRE?=
 =?utf-8?B?MGlCZzJSNjhDM3drQWJKcmtZcEFleUhrSS9iTDR6QkhQTlhFZ1ExOVJuNmx3?=
 =?utf-8?B?NDN0SkNWa1JnTkw1WWR5dlVnZE14bWpNUEw4NHF5ZVNLTitRaFp4N1ZSRks2?=
 =?utf-8?B?d0RWd0dMWk5mVGpPdmZHdXhZOHhxUEtzM2RodFVHSC9NL0E5TWhJNFhmUE5Q?=
 =?utf-8?B?anZJTXFoRGlpZlZVNW9EQ1UySkZHRGpNRFprTG9IOVdqRzM2eHJra0FSQUFU?=
 =?utf-8?B?YVcrbnRVbzVTYXNUZ3pQbFB2bnZFbm9ScERQL01sNnExTHRGdHE5dkx0bW1D?=
 =?utf-8?B?UDB6eVpkMXVYaHdaQ0lPTFNHOGdDWnBJcnhVWS9uNkoyNWZLYzhmWVBCNGo5?=
 =?utf-8?B?N0xEWjFTb21tcHVFcHhqQmRrTjNkTU9rZjdvK3dJanloK3RxazVIYXNFdFA0?=
 =?utf-8?B?akluVE5QM2JhTXkwL1llOXdMQ0lPR1BTQUQ4eWFyZVRmc1dmRXdvV01XZXMv?=
 =?utf-8?B?L1VpSVlWSTBoREE4d25qMHlzQkhlTEhxWTc5Smx0RUNBR2p6dVJ2OGdmY29X?=
 =?utf-8?B?T2ZGZHZaeXZ3bkx0aHNnSE9QQk1BSE9pQkhVU3dTOUV1aTMxWG81VVZsMCtl?=
 =?utf-8?B?V0hhT213TmxCRnErNUp2cWJqWUoxSnNmZWdjbWRtZlFWU0kwT2NMaW13VVpD?=
 =?utf-8?B?UlVreHlKMGNzMEIxYTBHTkdBMHQwbGtkM0tYTWprV2gwN1hqTE9UQlR5OFEy?=
 =?utf-8?B?YW9BZ2djYk1NaVJpVlFEa1lRdFdFSFZKbDZ5NU9uZjV2MXFIQnBLc0FxeThE?=
 =?utf-8?B?UkJnTVh2MjNBUy9rYkVTS1d4MWk5VlhoOEtLSjRlWXlxdjJmZ1YrNjJxWlNK?=
 =?utf-8?B?RVA4aWJYOG5qQlV2cHc4V0pJMmFoeVZ0WnhJQVpzTFErOStZNllxMFFCUGVW?=
 =?utf-8?B?d3hDVU1YMkd3bnI5Z091dDNxMTloY0dlK0VpU0ExM0pxT2Fqc21lU2phS0hy?=
 =?utf-8?B?by9oZnVRcE1ZZEVaVW5keU1FZFRYL2hDVTMyMDNYSVpMb3l3cmU1M2pmR3c5?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bea5b1-18d3-42b8-277f-08dbbed91dff
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:39:52.4536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVraXTbQSCEyDDoE+V0m/B7jR9u1YZ9C/Y7iaKjBlE7584hwleyIzGTlpA+ofBjfaAnkbg3T66AgRtWzgBvtLx80DBcomE6DPiz9AiyX5Gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5131
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/15/2023 8:44 AM, Ilpo Järvinen wrote:
> Currently, _GNU_SOURCE is defined in resctrl.h. Defining _GNU_SOURCE

nitpick: If you do submit a new version, could you please drop the
"Currently".

> has a large impact on what gets defined when including headers either
> before or after it. This can result in compile failures if .c file
> decides to include a standard header file before resctrl.h.
> 
> It is safer to define _GNU_SOURCE in Makefile so it is always defined
> regardless of in which order includes are done.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: <stable@vger.kernel.org>

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
