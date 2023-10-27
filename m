Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF817D96CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 13:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345771AbjJ0Ljo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 07:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345761AbjJ0Ljm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 07:39:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0792FAC;
        Fri, 27 Oct 2023 04:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698406781; x=1729942781;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=6aYESNfP94LgZCk2pzEKubGHtsV6w8TTuTWcQOUC62M=;
  b=YCPw3FY831Md3lco+1wnSjPwMpyUoaMASBNqMVmA58Dgj5Ur6eBHcVlv
   y4uwYq+XOPGCf6XqcySGHXxI7N+OkG6Vh6sPXuXB3SQQaFCekp8x4b6KL
   Yc4LA/Mh5DhqkRMO6DSIi8vLo7YoxdeHX/IU4fc4SazFsfVk6yxkB/QX6
   /KdSbcko6x8cc+55mpZJK2ZZT1+7/kKfxcA0kw9t1ZIOzuQ23C8DoBKhK
   eLX6DQ4WGpLh6hYA2KkkWDPS7w76IbiREYS0NhcLG6XoPbMWqtcV85aaF
   4qf0U1jonBaindr5CMhziBgxcvupgtPOaPS/6oWNi84N/iHlywVjP1VXw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="473999020"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="473999020"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:39:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="794556740"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="794556740"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 04:39:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 04:39:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 04:39:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 04:39:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqFBKYC+dgr/+ndfnbdGVtQO8nPmR3m7VESHq0Mi2R92aK1nePYcZCZiC76Yz3vBVZrr7gPLUeWpoPq58QSGwze1ug1TqTGbwY8q8xEeOE9O/t7WX39n8+Gq3mimnQwBFXIbWUWPGHdaFhL/8FTCKQZE/OpbdfTqC4njvWw+NxjpnYUho75g4kcSQ/iJXeCj2OaxEcRZ/+E8HxFA3idArvKAMfN3gIJnOT9miygJRV1Qzz+N5w0E5Vmh3DK8DhCw1EjZcZP2TyQiX5IhOJ1h+L125k3kOGYjBRd5KvuH8+0TGDCtxkDfSXXrnTZyMTg029R/+GBuL+WtoM5Q9MbEfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5KIG8XAfHKdP4uOgu8ARZN5rwZXcgRy7bflrEk7/3Y=;
 b=U5j/OvBZa2SCQU+lsiCxlIdByLHmJyfYft4oa93WAlNtTT6yoapYFqQAhkPGVq+VOR1pxmSqEdYW7OPLSelqPgZrRo1AoGGUR0hH28vR+E3NrvfRO6Q9LKCmuUUCsmDsxte3Z8LmDWGkmmqZbo2oqtaUAtLbsTbvdeNpsn91RSCaHtwytHGoBuK8VbOoQKNHLeE2TWqbb4twHiPqo7qwrSYrZfRJM9RhwB5p8pw8OOH+zL/NkR7ouphOL60YVB/iiKhN339mSJF5D87CTgJw2ggFnt+PZdDcwAr7zHLChDjYBz/aoE5EIqi4IWDw5XoNOZJAqO0C5hBj9AuL6rJhwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by IA1PR11MB6348.namprd11.prod.outlook.com (2603:10b6:208:3af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 11:39:37 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 11:39:37 +0000
Date:   Fri, 27 Oct 2023 13:39:31 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/24] selftests/resctrl: Refactor get_cbm_mask()
Message-ID: <wlemodlvfokzfdswamwmdqeg5av7ylrj2w6i6orif6vf6jd7hc@zqmdopz64keb>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024092634.7122-4-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: WA0P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::10) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|IA1PR11MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb9fbc8-2ebe-49e3-ff82-08dbd6e165e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DnrjeNonmr3mg1bucmlBOqsgSL8fou1Kqs8tdtY63bHyP1E8uZXKJH+HPFNw9uEuCXWpcogPM3cgVsVjhMhq3CerMp+QzUiLchLZ4g3pqPNf7sAv2sYb5Cyju5g06MeBvL+1MyYhrzZd7t3rYQfuAS0WMypsIdiU/xOht0d3zET0RogXEZ69/zHNWkAT9mW9OMkbnYKFE8WDX4lZCuQjnvzrY38/9Rde+d6DPIQfuYTAoHOP0MqQVBp+GQ6MNC9NmhQaBZJtMH15s10d+1yhZ+HIOTcaLK4XFZTyaVi37aOERSGmIGBFtUMO0iZ1n8xYYQg7x2SCiJmOcdpKqqMZNd6pm5aFZw3e61NQTyi9CCmtT/hYlaFlj7g9eyNg51s106eKSISHNKDDSXb3uK4IYdKbN3oMnDFXzSr8DvyFAVrokn/j+Qvkru5/b/+IyejzZoDHrXD8fdJHXDQrix8SGDUOVtgLtm3Dv5Ew4I+pJTA5tNwx6v/jej4AG13NSO3uTB5Imb6NsY7sPopGP7w50k8BVLENkPqiksu5gShtmeiQFy8Yrry/fWtkq/vCLwzh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(26005)(33716001)(4001150100001)(38100700002)(5660300002)(41300700001)(2906002)(86362001)(4326008)(8936002)(8676002)(6506007)(6916009)(478600001)(9686003)(82960400001)(66556008)(54906003)(66946007)(316002)(66476007)(6512007)(6486002)(53546011)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?43AdKGhTHbudhtdoyQfljrcIBfFXhkosXQkrp3RtCMrbtOsl9mLvXqYUvJ?=
 =?iso-8859-1?Q?O8vKPS9tel+dWAQBzor6oxqAwDLb+/rGxuivBMZb+z2eesyEG1YMRyatme?=
 =?iso-8859-1?Q?qw1LujSfQe0Cbo5JHk8gewt4ud9Tgqy+/Kb2Du1X+PymJGvpL9VajDhb1Z?=
 =?iso-8859-1?Q?f35ezVx6rGV34W+SEVTM1yBFzHGpGfiayR1P1yYlVkok2aLtv9zjH67Oq9?=
 =?iso-8859-1?Q?NArd+Ojyhmo0W5xeksWMW1lZTrqyxiGsmPXf3pFGBEyITQ39quUlOgzaNg?=
 =?iso-8859-1?Q?Q+YKEgZ6L0AMie1MOfpXrjtkj0EZX8T7NBWARUZZgN4RZIdX/zCyiqRXzh?=
 =?iso-8859-1?Q?sHw5k9vdk31P/r/d4jPJtXnkMp01p3R5JxPj9pzWs80PMERr2tC9NpB4Nn?=
 =?iso-8859-1?Q?0mCM6Hl8mxSbqFUBysvd3gb/qCFHZ/ENwZUY7B2TprqrdL5efz3KaEfSY9?=
 =?iso-8859-1?Q?8SjidPUYkdyAGa0HdkXkCXPabVeV3cs4k+O6k3a3ruP6V454st6QQf6ELS?=
 =?iso-8859-1?Q?u037meoHI91dnLnBeAzQ1tAGnm3BFshfiEkNgoKOm3tnG+X49xYww/tmIr?=
 =?iso-8859-1?Q?yDmkm7SvOwL0UHWkX56AdsdfigmYbQru/l1uymPYuwV6DCSnSUOEX05dbM?=
 =?iso-8859-1?Q?R0XdVkmVR1qKZX9Ur1ox+6ePeOOzcIESOxz6Hth+4WoGP1I+udd3J+l02T?=
 =?iso-8859-1?Q?TBo5JSNWGZjwOmKA8IksWXgv9JY8xMeaF0990WVcg/saSNB6G101Mkd18Y?=
 =?iso-8859-1?Q?jjubs3vqkxJzClXCW76dkxmhkatPZ10Bu0f10tnxzU/3fPFLYD9FIxzrCh?=
 =?iso-8859-1?Q?+xJbtaQERjxAurQenkp/cC4/UD9LcAldRQsUKLZp8DprRv8NYRsOSHRUWI?=
 =?iso-8859-1?Q?9nCvK3HG9V2bZ7+RfCvRbuzOkWJfUQSzYD0AwIK51vSTRfzFToxK1z532J?=
 =?iso-8859-1?Q?zJRg6ZDRXOug1eXB30+gLtoBjiSTSGJr9nkbTLkNM5ITZISvPqt+v/xByG?=
 =?iso-8859-1?Q?x4AK7PfaPp/OoH4i9joZYn/a3xNMVab9Uo8GYuXqHXxqsRs1zccNWO4Ifv?=
 =?iso-8859-1?Q?SNxizdbUtufXaCYrEsLqBbtWkLdmlcXNrSDlthpok75eZ9kio0DouD5042?=
 =?iso-8859-1?Q?DR6xFaMRi6QGfIAoraMW4LtNCNyuorcqx756kkhJa7wN1/JOgTZZZ6yAhZ?=
 =?iso-8859-1?Q?9IlEYDfvZ++xvpyLmKmYVzhXs2JjZxsLeiQ7a6EsItVtTOYaENFuBI0nxh?=
 =?iso-8859-1?Q?13yQbR1FriPO4mZ5KWFnix60PPbUcgFZtvnkF/E/K4XZnN2gt0dC0CkDSN?=
 =?iso-8859-1?Q?G9sGED6yZYirBWvIkG+j7LKfqmegTdweOEsZFyorqXsDXShQmUyFIVLF9z?=
 =?iso-8859-1?Q?o7Bn80cWxjaylQ8SUrUjqc2UWDMMTX9dLA0slao/XYawcJ1uYHR/xmBjBi?=
 =?iso-8859-1?Q?S0O16nbnUY9CIbR3w2ffpD0xY8Ono/FSCJvrCSlb3c442c6H9Ju16RK2lV?=
 =?iso-8859-1?Q?2jvqJKrIYOa9pYW44EUYwex5PZihvbaKXFdPNhUsxNkuQgUpPvp9CKBXVa?=
 =?iso-8859-1?Q?7GYma5HqhPnPTK8x64TdonuTy/jFdU/F8cBmTFrWBmP1VcLSRQH/79w656?=
 =?iso-8859-1?Q?Yv7xeE2N9l9lA9kU1yU++jYyRLQO7LbLCsuJszb8Ask/oil262+9CkBic2?=
 =?iso-8859-1?Q?6k36ru0PAsodhfPhVZM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb9fbc8-2ebe-49e3-ff82-08dbd6e165e9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 11:39:37.0242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hY6D2HiAFjcBZMYZuAA7V+zHSqhoAiDreEJJsdLdvEFyQTEwnqIyxElHFPMN7j7s2kC2GTxjajzXL9lB5OPAlVQboFzSNv0uRy0e85+MqVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6348
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-10-24 at 12:26:13 +0300, Ilpo Järvinen wrote:
>Callers of get_cbm_mask() are required to pass a string into which the
>CBM bit mask is read. Neither CAT nor CMT tests need the mask as string

"CBM bit mask" -> "CBM" / "capacity bitmask (CBM)"?

Generally isn't cbm_mask an odd name because of the repetition (capacity bitmask
mask)? After looking at x86/resctrl files putting "mask" after "cbm" only
happens there. Maybe a better naming scheme here would be get_cbm_bits()?

>but just convert it into an unsigned long value.
>
>The bit mask reader can only read .../cbm_mask files.
>
>Generalize the bit mask reading function into get_bit_mask() such that
>it can be used to handle other files besides the .../cbm_mask and
>handle the unsigned long conversion within get_bit_mask() using
>fscanf(). Alter get_cbm_mask() to construct the filename for
>get_bit_mask().
>
>Also mark cache_type const while at it.
>
>Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
>Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>---

-- 
Kind regards
Maciej Wieczór-Retman
