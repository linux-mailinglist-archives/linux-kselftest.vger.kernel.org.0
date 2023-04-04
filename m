Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DE86D630E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 15:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbjDDNgO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 09:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbjDDNgK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 09:36:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5F3423F
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Apr 2023 06:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680615345; x=1712151345;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZaS6YgN5FRHdyKw9T2I15tPbZqGk2LR7CQH2G7HPj5k=;
  b=UGm1ILfH2FqgzcIQoxC/s6H+Ma3q3+IKXIPaYgLp4DzC/trCbjOyYhjb
   BBp+X0/6Oar20j5BbY2EwkYZ2pkJyIx/KYLVufwTaaGyl6t0NsUsTMS1f
   5OnRGY2aK6M1X283g9SsCF6G7IcuShSApkSzSYcsjP3J/mHjDHNtO1bdb
   lMuetf91nneQcjJnTWdPIM69dnufd2XEe/DBVNd9XIkVuyLfk0MyhL6JF
   /O3j909TpjAnggGWYaiEvjExjQGUlYaAiS8QII529RdJCicmCRMpR0Rru
   l0QR/qwVpOJDzo2TaXqknclxG8icPHx0F+oKiqmfxNEDNejB5lrEUNWq1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="404943178"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="404943178"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 06:34:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="775639039"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="775639039"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Apr 2023 06:34:38 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 06:34:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 06:34:38 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 06:34:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJ7T6bIBikXpVqhAvLbUdUxHjlTwD0phITmUZaEq1U8HlBmf8aCX0UzDH7B/2UiONgCEmQFSmpnTCzn4j2TT+FlxHacecfsEiQigRFpVeIhgPkF4sP91F7RgllEKhVVYPUu33BEN6tN5qPaaWKkE33NCfMTPev5s5l9IITjHKrXpwwnLdmsIUulFDsvMD+sa03094nBqdCqU29aC8+QrneDGRPLW6kfEHvn+uQlloASSl81WSHh+sjNV+pFCeztnSCzuZA2xvsrqwS3FEw1QVcCN4VeB3Jv+zeQSir89jiBJYMcJ/mtYytbthZojIoKc2Bgo1CmRjqi9hu6csZkc6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sl/yv1PCzl0gqjTF2Udyqgma7Gy4Ju4ZauPnovChMuM=;
 b=Zh9ROqpz6bKGxH18c6qjCo8aVFzFGtXCm44KWCDgy29LdlaXfh0wPvPtJ0vrjq1UAMWpK7s6i10UYt90aLHnmJQSYv+p83+62CvJeBDp//o6ylTU8HpnQ2HpRh/oVWsGQYCQSGSyNDlwAimf1Jcr4NM7qLb1Cmqin13B2+4o33I3OpYb4/X2kJisjcdeHhiakKa3LH9Vklgz+w63DVpM8mWz57Z2bZku5FeKixapqOwlJw9BbdM161XNicd4wztdJCai0B6DugQ330fykaOXst93T4DJMo7UmN1ufPk5s+NgA25XEwqqLuS1ro3RiML8RhYcCmZQrma/nbCzROQzvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DS0PR11MB7623.namprd11.prod.outlook.com (2603:10b6:8:142::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 13:34:36 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%7]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 13:34:36 +0000
Date:   Tue, 4 Apr 2023 21:36:10 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <iommu@lists.linux.dev>, Kevin Tian <kevin.tian@intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>, <heng.su@intel.com>,
        <lkp@intel.com>
Subject: Re: [PATCH 3/4] iommufd: Do not corrupt the pfn list when doing
 batch carry
Message-ID: <ZCwnyjMTpEL8+tNy@xpf.sh.intel.com>
References: <0-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
 <3-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
 <ZCfPTfmYA7SvNd+a@xpf.sh.intel.com>
 <ZCp6IOS0UtUE8z9o@xpf.sh.intel.com>
 <ZCwfwwA4s/6Eorfm@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZCwfwwA4s/6Eorfm@nvidia.com>
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DS0PR11MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: d48caa66-b8cf-4ca6-2f61-08db35115507
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i35MaCGwhqk4ltwGe8+JQGQXwLNWlsQgzk+pZcE/Nlcx9Wjar1wmSNzA6+5EKruu2aC+yAYpnhXosrZ0DU4+jQTqbYuAmRTiBEU9dyXqFJ+gO8pLpkaljqfUNgxYZhNiw7/9qcWCpQ6+iZfsZ1nZ8TyBCQCR922myLsGbin7xKB5TyEkUu9HPvJLzTk0ANiBQ47C6DDmNPaoCHrIE7m4z7U7o7PytuHzMaN/aJ5LZN0aK2Vh05il1WMv5dj1QpOEBS1550I4t9CXbz1Dz7hXBwHKwXsGQYA56JzJMesGv7caE6eb26ihge0hl7hxzOLxY+per/bqf9FapnKRLor90YV6O6+xjnOZUoR7AKl0TuF0i28eJz5JDNCgI2jS9KM9MAB2m0cmDqD9JByQLWarY6qwlB3h33nkTnQi+2S8LI0lZGdiaodcc2y/hu3QTKmJdXhFjUhu7hSel6F8ZfXQ/6hXIj4+NSnJjdjpi94DFnUwk3ww+4QHKXMvOu7F0VZipaJg65Jr5i5rwCIs/y1AhHDrWuJohavae02TwWn10YJdo+TtYC3I2PBXC0DHoVnS1VZmpuqzyJ+xSf5eDHb2CFwRKumYLLU68Ym8g+LzPHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(5660300002)(6916009)(66476007)(4326008)(66556008)(66946007)(82960400001)(41300700001)(8676002)(8936002)(38100700002)(86362001)(44832011)(2906002)(4744005)(6666004)(6486002)(478600001)(186003)(6506007)(53546011)(6512007)(26005)(107886003)(54906003)(316002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oN27072aWE2n3OqSGHr1LSH2pukCdTUY14oYP/dg6WBoNu/OP4Wg0mir6n2d?=
 =?us-ascii?Q?2DD0Yea+77wjtVCFG6oGEouPnEU44iBaJtgPkRmsjJjrjIJn/XXOqItM3xxA?=
 =?us-ascii?Q?Hyz6mReWuY7tz4IMpar2o58oXW+JPpz7gGAtYhZV2RmMVlMgOwG9LqgPqD6r?=
 =?us-ascii?Q?0AQ6D2N8w2KJ8LGMYsKd3fWUDPcv7lAgGd4zLGOBnodHdR4p19hN78EicX0W?=
 =?us-ascii?Q?JHM2g4wF7/C+GaKuqSEJhRyb72dlaLtW+oa0Ydwg5HFiLbuVKiX9WmNJfqzw?=
 =?us-ascii?Q?/VL/GdnGxroykhyqDrjQJ+WnpPhPdv3vBZ0f1S+VgzwTLUgKH6pS57flCEEN?=
 =?us-ascii?Q?zSPguX+GA/r0/x1NwBp2rzc3B4EtR8Z53wAR0Ibnou58YpkJYEaArMFopYjZ?=
 =?us-ascii?Q?KglssfSk+lkPsPLdtzmT9Hm08Gy4tkKBnoFfhG/shpLmaOtDIDFGuqda/mYo?=
 =?us-ascii?Q?Pe0+iF3szM28X9lOQLRZvDS06YVklBkXV1weAuH0UfWEV3Zq/NyJjclUj9lG?=
 =?us-ascii?Q?fO3SWW4080VWhdgMXvhjMD8IOjnDtI6FVTsoiif2GKp8rIuYMHaKmt5P4UM5?=
 =?us-ascii?Q?Z72d2izbQGHLMZGg2qYU1O8R++iR63DJTukCMNPzS3I+Qt3jtxYSdUccZMkS?=
 =?us-ascii?Q?3RZi+SQaKlG3iPNjHkhfmPB22JvAZIuAH3QzbOocAhI6ltbdAMTKkKbPEBqY?=
 =?us-ascii?Q?nObrW6MEUElOE2AWt9ZVylAUlYlfRtzr1F2F6RJ/Yua1JcYF5CqAk6rG5WVY?=
 =?us-ascii?Q?Mvjsy9/fHMedxxK+Qhnvcw1Btbh4TRonypnD5bvoqFjyBPC9moP9U1AHdx11?=
 =?us-ascii?Q?IvC86IQui9tHWiV1jZsrrFJRbQ2jU3T9s3+JSy0mUCQHu/JGID1/CBC1vTPE?=
 =?us-ascii?Q?a4SRuR5hb0C/DUgECNSQkjUoHH0K1DsHGc5klKoXh38VLG88WT1jAXHIe4zp?=
 =?us-ascii?Q?jcxB22n1ygQuv7SxIPzhtFAmDRRTgfD7Ac6sWphwnd8hpjq5b9kZckJDrVgd?=
 =?us-ascii?Q?nXKlqnmFfoEXnFBCs8tPPOHmAaZwDQFs0Yw8otLUZsZ5faFinqT0lKjFBTUl?=
 =?us-ascii?Q?TBfgEWlxY7v42cpe0KVX2WvI0us1ZTEhKeNxpG8l4Yk6e+OICq6YahY07W+I?=
 =?us-ascii?Q?APsPxHkQ7W4rZhhmy/HLwpniiCYSF9p8KOPEUJwNPLm8e7l8OKWIE60NlWpr?=
 =?us-ascii?Q?4TS+Vhx3UUQn+7ySUSquS4PJsoRs5qKFNCZNl2VhaHUTlSBomG0aPIWTs5gE?=
 =?us-ascii?Q?P5bTMTVXWNBjFIAX1ANldLUOOxw5Z52BVNUMB4+RYYwYP92NHVK0UtA0oIem?=
 =?us-ascii?Q?00x5+Xligi0lO3KK0YOd46ME55bIDJk41psirmhvxgRW+t2e1AEBMlKp3rcS?=
 =?us-ascii?Q?/kstELmK9+kWeln3hTCOM07CILzBGj+9GR3VaP0m4qq75D+wxcnXk2nyg2uk?=
 =?us-ascii?Q?LHrajfMCnG73THTi8kxAZC7pYLHhzkp+Ii/pbc8aCGGC8tvqChu+TNx75Z7Y?=
 =?us-ascii?Q?G/tTszUIljp1jV61JI5IXen/9aZAZocjFRKDyUN84ufJgiRjNVxl/B826MF4?=
 =?us-ascii?Q?1MZJkKwZB7imiVwQPIO5c4DYgCXMwflpYT55taEH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d48caa66-b8cf-4ca6-2f61-08db35115507
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 13:34:36.2109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qXTVv2KMs1/umkJipWJh1w8kL143Q0OcNoJ2s/lU/H3A0vMjX8DER81kikkqGHNqV5PSAG2d7eCogKsEGtiKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7623
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jason,

On 2023-04-04 at 10:01:55 -0300, Jason Gunthorpe wrote:
> On Mon, Apr 03, 2023 at 03:02:56PM +0800, Pengfei Xu wrote:
> > Hi Jason,
> > 
> >   Could you add "Tested-by" tag from me?
> 
> Yes, I did, in future you can respond to the cover letter with that
> tag and the tools will pick it up
> 
  Ah, I see, I will do that next time, thanks for suggestion!

  BR.
  Thanks!

> Jason
