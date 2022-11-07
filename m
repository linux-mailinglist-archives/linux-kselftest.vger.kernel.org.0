Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C368861E894
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 03:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiKGC2b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Nov 2022 21:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiKGC23 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Nov 2022 21:28:29 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972753B8;
        Sun,  6 Nov 2022 18:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667788107; x=1699324107;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SnV2FqQtIENQxg+56yvc2j12HdWyVLpu9U7PXdR9ct8=;
  b=RGYtQZafMFF5P+mhazirNlqDvv7J70p+LBkzt0+4KNqc1t1zKG403WM6
   //Owe7iLcd4xITJEa6q53iVQzvjX7LHcxxP+fKMzWM7mGEuEq5eomNDEs
   vOlZNhxpDHpUgMldqD4a5/eYyTv/eELWJvOgESi8H4hzHq8v8sjzstXH/
   7ZfUBS+pIyEN1S+O6fVxvNADvW/p7VHoDswNyzdl+V0GrwBN6YjVP2/WH
   ttTTiYIchuaoLk6A65bbT57ysZKqUBr6R84Ef19ZaZVBx4lkcBENLyu1c
   niX5sLdLVvmrJ5pOEJ4DUoCU0MpNfB06DhfVbqQbbK63WpKk2dofT7YTg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="293651567"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="293651567"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 18:28:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="724963234"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="724963234"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Nov 2022 18:28:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 6 Nov 2022 18:28:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 6 Nov 2022 18:28:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 6 Nov 2022 18:28:25 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 6 Nov 2022 18:28:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkeFWwhYymM/eHhiTP2DXKs4ibRxTBpPicknRgNAO9wRJTgdLWrSA6Pik0DZVkwNMryDd0ZXgocKWODbaQc+PZzZ0zC8Ix10FW2lNVKFsEt6q0baBfvXqMHUDlNNkKwXSZC6itsnaubJQpzq6CQM8jnRqzBVJiw9omaKET2PFmh1nRUUZnPCcjS5T4s5dg8doDhYUupoW7w/6paYnUQHD4fZ1xL/hi0c1kh14gKD/f07Sqv4AZ9R80madUJq9u1g+xSnzAUiAAQklHzvXu8QkaObIF5B2CJfJgPxPhUoRfQOFmXSxGNE1FXSkJZVPgp/yTDW2PmGaBI4ceIY+mk2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCDtRC4vGNbeQ0Gdn+0qyoRu9dZxVAa4CFt4sZlFcIQ=;
 b=XKcwTaXzuZl4LiCBDOsw32DJuX61YRKP3lKK0nQBOJtr1WaLlQ2NknZVYYH6qUPzDcdTLDpuBnmfr0yoi+XCRK5kz3c39Et6zbSYkHxPcLfUYFSFWTilZWRWvz4j9pQ/PrzsiESV25B2hICtcmhNIsuRqti3EssYsbFTcTnhO4FkLacYDD5U4eQoyvI4m+AA/p1tXGuIhrInKUt4ee6yADIwe0l3RitgWRGwVBwPq1blvH8ftGfzsDAeItCepod2xCLqye+6jAuW3AUdig3SCwaLbnPWw2ZQjZrlwopgrKDySgHq2VFGcnjcdegxDOBUazcfmxGNsVrwnJKP0qsLWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 02:28:22 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::bb20:85b6:d9ef:423e]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::bb20:85b6:d9ef:423e%6]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 02:28:22 +0000
Date:   Mon, 7 Nov 2022 10:28:13 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] selftest/x86/meltdown: Add a selftest for meltdown
Message-ID: <Y2htPReffG50xnu8@ziqianlu-desk>
References: <Y1kwa0ZLI9xbEaHx@ziqianlu-desk1>
 <Y2eKO48Tv+UD0IpV@ziqianlu-desk1>
 <Y2eaEG5IX+tk4wuA@kroah.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y2eaEG5IX+tk4wuA@kroah.com>
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|CH0PR11MB5332:EE_
X-MS-Office365-Filtering-Correlation-Id: ba58aca1-def3-45bb-7cb2-08dac067bdb8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nm21cIZL1P14s0lmWGm/eaOnk6CGIdLjskvxTjDJ8+grwfD0/BW10E7FqX45m4koMv1R3KQJXTRfRiOPPOJxAcA7CkSOGFguQofZeqBXM6bVUn6Cu7DD7rWzcfyuQaM012QoRXu22I2rD41E6UWYeRMXITaaRSlw4D6Mar3bLBX813ZfVRyYoq4Iy+lXMNETkWGX85jjWBH65HxtaqwyIcqfANga9odfOcC5EKNVis86AVb4sVnnjwKZPstNtQ/MfS1PMrt3J0tBlFhXZbQDmMgczFjzbkrru83j3YCwv8V0Wxla0c3T0wYI93Kqx0m9YpeLgkn9OKQ19omyeeqk05iwSugKVjW+GLeWa8PDgjG3L9iA5v8h/A6y+FES3u5t9dss87shjewYXIQ7mNh45fa3wH5zdCya6613xFEoQEBBdBg+m3em540Q3z5gNslHEcEy041Y+o6VEb7M3BcRcDd0rZEXColzlGi/gGQlctFwQtHHTOmhdIeoKMyMRGFzsRgOH9lsO7JF5z/7bAcUAbddPIx9+FhN1WU3oZ8gxI3V9g1c8ywd6hwaKclCQmxIhikuoSfMuTRMEwjIrLLYmmP2cdpDj9vyMqgix8zehwLYxTvV04U4mN5a3e+4LA7azjCT4F5porZn4iYs5MTHG2htacr6qosGLh3uUwvfbNgu7uCoKnwHvBTSw0qrHnF1b+YOd9c1gA7/b0Fwr57xc8+XBr9lyznVEgCMFom22dURQh2xkb/fdsy2Dt3XNNybMHGYLicd6kNtC9fzBoRPVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199015)(6512007)(9686003)(6506007)(26005)(6666004)(186003)(83380400001)(44832011)(2906002)(8676002)(33716001)(45080400002)(6916009)(316002)(478600001)(54906003)(966005)(6486002)(38100700002)(41300700001)(5660300002)(8936002)(4326008)(66476007)(66556008)(66946007)(66899015)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TONMXzQoIfGolCG66e05Bc0ZhMWgOyVqLGikzcCZLlMYiJPodrkgSofhemY4?=
 =?us-ascii?Q?xNPahyJRCMZSTeunZumY8Mw5EdlN2RTVOmDCNHsevQ5zGplPgo9Q3aNJv0S1?=
 =?us-ascii?Q?mA6n2PIKPrgtnSIp5gioJeMl8RVty8VBL98un5WX/o8oa06/0Nf8ry5sxhEH?=
 =?us-ascii?Q?/F1Ejm6weYZfnOTGp8XLiUkoFvBsVZWs/LotxBckc1q1WQ+baLEznOnIOfGf?=
 =?us-ascii?Q?zGEc2zHR+sOA7+DuxmTbCpY+ElXxJNdnQobHDXfy5lYWTcJUu4s0auCx0dJH?=
 =?us-ascii?Q?Yaazot+52vhLjWHHiCwqbv1dxRwZAmTP0gga5ROyzja2DXo6NMDRYO7LGVpg?=
 =?us-ascii?Q?R+LJIPs6KhVek9qfTdXEPH0toEHRu9NoGY7FlxPRdRV6AZooh76z7b+X9Pq6?=
 =?us-ascii?Q?PNtYToqmDORPw51okFMUw99nQ5+kglUj/QUQBSMZlhMw4UpouMrimXZDurbW?=
 =?us-ascii?Q?hZxCo3ICuHdsBNR4LAK8w5+3a7U4LBo8j1e5FWxo1rZ1xxc0/71l6/czafC3?=
 =?us-ascii?Q?1FMK3GiJe/P4qEtkjGaPMaQZ+L9OKSg1wgF0WEoUsEiLl7jclju72YkJGwFm?=
 =?us-ascii?Q?NbyzOn8C2MjP1vbQd1USstV4JH4C+LqCJrOxOLkIujCRQyIkJltdZjcD0AOE?=
 =?us-ascii?Q?rspdxWUsl14namV/MRgLptmfHrShpQCOkM70dYAnxBoI8ABHWsaryY4UukxT?=
 =?us-ascii?Q?Y5P1h48RnybaVfndGRjQwrY6M5vMgRwlZ5Mpss6L2mUkuljbRuOlRIw5q7Rb?=
 =?us-ascii?Q?89tN5zBqFhInwBYlxAT5ndaP+Yai95N9NGW0tEwMJfcaZZjutv6OjDWpaAcc?=
 =?us-ascii?Q?ze1qZGJMl9r/xoDLZaV0zKdRQ6bGqC4oy5/rv7GaSQzsb6Dc6TCZlKFXS+qt?=
 =?us-ascii?Q?hMXedmxUqKx5GTH4P+4SkMbZ/W41kCZwULvV1giLvZ8QShbvH3aKjrqoym6w?=
 =?us-ascii?Q?1PPnGtR5KvWD+TWRN/z6SxwFG+YY7z6TjQaULcTZXoF9xnTJpdLk5yZ306E0?=
 =?us-ascii?Q?eucbqGylxHNTfcmRh5aoAbG9wFaEl2V5jPyfhNc77cT8baqcbwoe1tpRHg5k?=
 =?us-ascii?Q?BH9pTuKdotOGxqZJV5OWMRkArUuxkTrRMh4/qA097aNd7UdIwOlc7SS1fD3f?=
 =?us-ascii?Q?sxm7yMl6WzehjN5EKEzommibS5KpV3d/a70wNk3tcR87EW/2vdB5Ll0VtcOA?=
 =?us-ascii?Q?V9zGK3QCMJZBt2H4h1Gbqoq5FJ73oWxTYyZpkpVqhcsfEmNu5yyDewhTEVAQ?=
 =?us-ascii?Q?tNGkLpqJ32uqnp8OVPMMtq6viq/AqH5ncyBGR9wxZiMqc8NNCR/abum5AFWg?=
 =?us-ascii?Q?ZwwIdk5gm8bTseIwzcuVWb0C1LU/p3nXfYNkqR87mEQKhXEa8aOxlqcbiqKD?=
 =?us-ascii?Q?rqWZozFdh40kGKjQW2sXC67iPyN6VApRvYGjlh4vBBjunfCdiVgCxI1H9xYO?=
 =?us-ascii?Q?VNsr3SWXAOZe4RNVWZF1I1cqpL9244uJTASYQ/12SE4iRS5sM6WCtVIQcIga?=
 =?us-ascii?Q?4/3h7VmebI5RX/h6BiZz+/Lq0Qo/azSpPlYBsWJbxKhC93N0fcUMubUBfnMn?=
 =?us-ascii?Q?qYlb4gGsjBzrSk4UPXmVn84ra3SuP9r3i9+j2fMZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba58aca1-def3-45bb-7cb2-08dac067bdb8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 02:28:22.5838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3725bQwBT+57bo1wWx3vzHUaRebXxmeULXaywMRhYM1WAShHPmhCill+VL0mhoEk7Lpaig+us4e+R5GXPxWSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5332
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Greg,

Thanks for taking a look.

On Sun, Nov 06, 2022 at 12:27:12PM +0100, Greg KH wrote:
> On Sun, Nov 06, 2022 at 06:19:39PM +0800, Aaron Lu wrote:
> > To capture potential programming errors like mistakenly setting Global
> > bit on kernel page table entries, a selftest for meltdown is added.
> > 
> > This selftest is based on https://github.com/IAIK/meltdown. What this
> > test does is to firstly set a predefined string at a random user address
> > and then with pagemap, get the physical address of this string. Finally,
> > try to fetch the data using kernel's directmap address for this physical
> > address to see if user space can use kernel's page table.
> 
> As this is based on someone else's code, what happened to the proper
> credit for them as the author and copyright owner?

Should I list the contributors in the patch header comment section?
Something like this:

The original code is contributed by:
$ git shortlog -sne --all
    24  Michael Schwarz <michael.schwarz91@gmail.com>
    23  Michael Schwarz <michael.schwarz@student.tugraz.at>
     9  Pavel Boldin <boldin.pavel@gmail.com>
     6  Daniel Gruss <lava@gruss.cc>
     3  Daniel Gruss <daniel.gruss@iaik.tugraz.at>
     3  Jared Deckard <jdeckard@equityins.net>
     3  Moritz Lipp <github@mlq.me>
     2  Matteo Croce <mcroce@redhat.com>
     2  Raphael Carvalho <raphael.scarv@gmail.com>
     2  asgh <asgh@users.noreply.github.com>
     1  Eduardo Marques <eduardorbmarques@gmail.com>
     1  Egor Vorontsov <sdoregor@sdore.me>
     1  Jakub Wilk <jwilk@jwilk.net>
     1  Jason Davies <jason@jasondavies.com>
     1  Lukasz Gryglicki <lukaszgryglicki@o2.pl>
     1  Michael Schwarz <michael.schwarz@iaik.tugraz.at>
     1  Raphael S. Carvalho <raphaelsc@scylladb.com>
     1  Steven <steven@ceriously.com>
     1  Vamsi Krishna <vamsi3@outlook.com>
     1  pierwill <19642016+pierwill@users.noreply.github.com>
     1  ysiyer <yegnesh.s.iyer@intel.com>

As for copyright, the only copyright I can find in the referenced repo
is in the LICENSE file and it is: Copyright (c) 2018 meltdown, I'm not
sure if I'm allowed to add copyright statement for others.

> > Per my tests, this test works well on CPUs that have TSX support. For
> > this reason, this selftest only works on CPUs that supports TSX.
> > 
> > This test requires the knowledge of direct map base. IAIK used the
> > following two methods to get direct map base:
> > 1 through a kernel module to show phys_to_virt(0);
> > 2 by exploiting the same HW vulnerability to guess the base.
> > Method 1 makes running this selftest complex while method 2 is not
> > reliable and I do not want to use a possibly wrong value to run this
> > test. Suggestions are welcome.
> > 
> > Tested on both x86_64 and i386_pae VMs on a host with i7-7700K cpu,
> > success rate is about 50% when nopti kernel cmdline is used.
> > 
> > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > ---
> > v2:
> > - Added [SKIP], [INFO] prefix to some prints;
> > - Do not run 32bits test on 64bits host since it doesn't make sense to
> >   do that;
> > - Minor comment update.
> > 
> >  tools/testing/selftests/x86/Makefile   |   2 +-
> >  tools/testing/selftests/x86/meltdown.c | 418 +++++++++++++++++++++++++
> >  2 files changed, 419 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/x86/meltdown.c
> > 
> > diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> > index 0388c4d60af0..36f99c360a56 100644
> > --- a/tools/testing/selftests/x86/Makefile
> > +++ b/tools/testing/selftests/x86/Makefile
> > @@ -13,7 +13,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh "$(CC)" trivial_program.c -no-pie)
> >  TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
> >  			check_initial_reg_state sigreturn iopl ioperm \
> >  			test_vsyscall mov_ss_trap \
> > -			syscall_arg_fault fsgsbase_restore sigaltstack
> > +			syscall_arg_fault fsgsbase_restore sigaltstack meltdown
> >  TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
> >  			test_FCMOV test_FCOMI test_FISTTP \
> >  			vdso_restorer
> > diff --git a/tools/testing/selftests/x86/meltdown.c b/tools/testing/selftests/x86/meltdown.c
> > new file mode 100644
> > index 000000000000..8c0c1db49096
> > --- /dev/null
> > +++ b/tools/testing/selftests/x86/meltdown.c
> > @@ -0,0 +1,418 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> 
> That's nice but that does NOT reflect the license of the code below, as
> you state in the comments.
> 
> You might want to get an Intel lawyer to look this over and give you
> advice on how to properly tag this license.

Thanks for the advice.

I've gone through our internal process and was told it is OK to
relicense zlib licensed code to GPLv2.

> 
> > +/*
> > + * This selftest is based on code from https://github.com/IAIK/meltdown
> > + * and can be used to check if user space can read data through kernel
> > + * page table entries.
> > + *
> > + * Note for i386 test: due to kernel prefer to use high memory for user
> > + * programs, it is necessary to restrict the available memory under that
> > + * of low memory size(around ~896MiB) so that the memory hosting "string"
> > + * in main() is directly mapped.
> > + *
> > + * Note for both x86_64 and i386 test: the hardware race window can not be
> > + * exploited 100% each time so a single run of the test on a vulnerable system
> > + * may not FAIL. My tests on a i7-7700K cpu have a success rate about 50%.
> > + *
> > + * The original copyright and license information are shown below:
> > + *
> > + * Copyright (c) 2018 meltdown
> 
> I don't see that copyright in the original github repo, are you sure
> about that?  I see individual developers contributing there instead.
> Please keep authorship information when you know it.

There is a license file in this repo and I've kept the content intact
in the patch, please see this:
https://github.com/IAIK/meltdown/blob/master/LICENSE

Thanks,
Aaron
