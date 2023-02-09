Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AC7691237
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 21:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjBIUuD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 15:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBIUuB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 15:50:01 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAA1658DF;
        Thu,  9 Feb 2023 12:50:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZA8sjcJ6j91tXEJ0bTvqUK6B3WHjQn+swVhb3KfNPtRsiKnKi7u2MB9rqt2JpYxHKcv/BG9REIdRx/7dmSEDBIfHC5xW3pKQCCzAHLD6yYvJTYUg/6ejkOavUi0bfuRotwV07wO/RlEj6kICZ92XxX9NBSJl0dILs+bjKiiD+5DzyZsgDIngBfJZdMDOGUXSRVifU9eNF2Pbu89tZRFz51ZJsb7xL4H7x/nYEu0MkUF8sc+sxfxaF09pZpX1JY42YsOgNgu1VV6p3KSYawFBgtoa+GCJT1RoY51lbBAA/DhX3NqffsCnn41j074yIskq0YY4qdzQRtI+k0+rOYDgDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qzuvdmeHEJhUJ1rBs8dcm1hYCZth0hWdhxV5e9oyVY=;
 b=CftRGNI3DB509/dNGWf+Ol1amElSC3cX7zOSmJm6pxWfFCc+i6Q28cXBqHFxBzy/FsHAtDK0FLZP0UTnxrXRxBhUuHsapxDtNCE3k33B2PLpfH7bHg28G+Q6DfYNA91+/Hl053xaXdUuShyPiP/FUTMa9GjiITdK1JHK1QPjAsXj4MBgBrpEXjnh0mEOFMch8od8NqOIygkHiuSHibKK56suNyjx9lWhZHGfrqdYeazeisNu9DTxFmBn2TPqMsyMFhCNQYrQZmkJYfIS+5aTgKTOX+bHs0clVG9ZleHCe2H4yr0AqcoPvwg6UHV+U4d+FOV+Xus8jokWGRZRlofFKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qzuvdmeHEJhUJ1rBs8dcm1hYCZth0hWdhxV5e9oyVY=;
 b=aFwQZTjgFj8lap6Buh8Jr1vD4DAz46BnsVTLZlwljs0pxonE1UigHR2ZAk1P+6miqAQkAI44BeVB81OCFj4Be+jYu1HS7/7of0jdnd9Vst9WDeCUFwn5Dnu0ib5IOW696UKSY/GpaJInpA+vQsE5aSsVgKcHWzo1W6Kk5gWCqwLE3roH9SXEBuqjceEexT3CDm1Sol9Gorj8ZX2JHSSmFD2uWHB3/Ke0xuaXro6K+WcCjYYHkEUPG3HNxYje7m7xtOPCBaGLu9Wy6UkqchrAIwGukhTKtyQt4utpDdciAqraFFKdmfJcPTUhe9o563BbKk/lEwiNtYEtO9HqgJzQOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 20:49:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 20:49:57 +0000
Date:   Thu, 9 Feb 2023 16:49:55 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 05/10] iommufd: Add replace support in
 iommufd_access_set_ioas()
Message-ID: <Y+Vcc6x2JVPwkl5+@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <931be169ff4a1f4d4f1ed060d722c2dc17ce6667.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276AE27E37866B82A6E03608CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+VXfQbXakNSHSLw@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+VXfQbXakNSHSLw@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR01CA0011.prod.exchangelabs.com (2603:10b6:208:10c::24)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d95b749-2982-4397-7cc1-08db0adf344e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mp7vMnuxgN5T+Q+wnOaC/AquRUbf6EEhtMZXWIVRAdgCOHe/OOeeuoWOCJ4CetMeBQeqSmdaaBGR2wgUy0Hl189Iw5TlDor8tfvc10XQY+tptNn3nRSsIjxIJ/bCPb1ycAVaQk4FuJiwWF5GmJPDJ4x/dSUXxrqfTOV08Q/BHkhR8oV3RR/tCK295vtnSph+UBesFBNHL5c11ndh3Jpfqxo0OYIzL1dsLLQpwPUzK8LIKFjgifdzDMuPmHTkPRc4X/GeYyhCDaZgd/b3JORotgALfGKNh3AS2+XDYyzatFGfpsdZTmUD1PEKNVOBTHENCNmhHoqUYo4kUk5HkD63t0x2RW45UGHZOajQ4TH3/HIwiUfQ3SWvzVAGnkGoDqVRjZdU8dHl9pyt6Z1qC+vvF5lFFiW5V4QJAJNXiMi20pzNK+RYSBOcXLNqF7laiaX9L91gxQzhc3ctKlXfMfy0ljwCAIChhzRuC2c8WnhllpK+/Bme9U80TfsbD1lMJ+O7LhNcFPDMooge0r9vvM5934zVMinCgYyI9MgkqUFdgCw02TLJqVHOpJxdGShrzc+0AMd2hxOAkrEGHidfP7SR7c/3CXT1nmHgHJelqsHkfkCcCmfKTVD2K8hBCAvrjv4AY5LKyCdMzdeaPU+S7m1Thw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199018)(38100700002)(41300700001)(6862004)(6512007)(6506007)(8936002)(26005)(8676002)(186003)(66556008)(4326008)(66476007)(66946007)(2616005)(5660300002)(7416002)(36756003)(316002)(37006003)(86362001)(6636002)(54906003)(478600001)(6486002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r+fTq31BmkvM3pY1fV9K4G9ff8ZOgp6IiGcIOEUiI7NwHjFFQs2lQFbXHtYe?=
 =?us-ascii?Q?pfAGw8XDTKyCwmkKTvpv4XjGDTyC0ARIzdva5kD2IIDlFAIDDQIGuMdlRhmB?=
 =?us-ascii?Q?upXA/58RX5DgGoCg8Y33DNtv9k+dVxIbWyLwrmYvZe8znFBAgahSIsCTxVdj?=
 =?us-ascii?Q?pBBWmVoWTr8mVrbNnlgKV1LKSGlw4vFAekkKgSpofCIkwED2UcN0Lcu40Ugn?=
 =?us-ascii?Q?uTJAL+FKvtGC0Xr4RIoRWKUjOixL7o0p6tkH6KGpUT+81rpPGHm0PPT7xtGo?=
 =?us-ascii?Q?T60BpdWf6p7jkMgWU3vCEn1SLp4djjz9AmDC3fa+Okyycp8Ejk+lDyz6NlN4?=
 =?us-ascii?Q?gEauRA6ANyj77PFQ2Ldyh0h4STvBLT1YqccGZ0yVtnv2f5EBF15wNS6B2efm?=
 =?us-ascii?Q?RDGhrs3u4UooLs1dVpLEXOuZL4BCPjplawo8x9ERa1vptEN5x5otyo5+8zuu?=
 =?us-ascii?Q?fWzSuFw36rZUPmwLPI8M11ZUKtsZ3WY0XJQu094nwJGz9c1aAAYseqIbg2Dp?=
 =?us-ascii?Q?eNkyZnjQOtS8fZQKDIyMoQopWYdoImfXQlf38sUQxnp66wgElpTdo+RN80nL?=
 =?us-ascii?Q?pRybbU7xi+EqzWvuQHtBDYarqQVveHaO5BdizrkWR4YrqnQgXxa2RgrmTOX6?=
 =?us-ascii?Q?7hEL9vRDeyqHD9ejozWLmeNSelw99sMOdIIKEflBmrR0K9c25peRvBxBo0/v?=
 =?us-ascii?Q?DPzvw4rC/y2HKvd1wGYsJer66kz00v+M7wZoDUD5MJwT+sAkgqn1lsygCkuq?=
 =?us-ascii?Q?Jv9ez3xHf9pZLxKBvHMG3o/QjPauPssQ4CcADi/+IhISEWkPJEeugsHswwtx?=
 =?us-ascii?Q?jyn1HO22b3zYDs0hDzz7dbSiTCu/tmj4W1F0rlWXkOoOMiQnfWgdxJIcgXQa?=
 =?us-ascii?Q?rKW7BTY2dlkmqQbYiEZSZXKRqkjoEKFkKjJUqeqXXWZXMhWxp7r6mXdWj6fC?=
 =?us-ascii?Q?xDhVjLHG6vmk6tK9q2gpDzBUvALRSz2+Mx8TolS0ne4d0J7J0X8+BNYxPffZ?=
 =?us-ascii?Q?JaMrrFBk176AOB4iGlgkg/0lqaj4XcpVWITrVPll6c3tI+Q9TuPjqsyL0/Pp?=
 =?us-ascii?Q?GatuspV0hWfAgqtzlEpC0bPKMkmGlz7i25Jv//JSjOS5gFI4FD7xbgnII6b7?=
 =?us-ascii?Q?XpVn5JKP2HvWAIBbbnbvqhomuwzHOI8QZ9ldAaEcdKMiYVRRklszWaKWtOH2?=
 =?us-ascii?Q?EqFNX9pyewiJOapIzAIdoLRXvTqV3grzQAgt+dV6tXUh08oGRNUx5TyW2GBq?=
 =?us-ascii?Q?hpz0+HHd8SEynZ/DRNtXo7UyLg5C+N/D9QTRybIdo8UYXVGtKX1FfQdPsIEY?=
 =?us-ascii?Q?ekB3lzR0F1LWvMv0w+5yX6iXT5AuR+GuEDI78iw2dOOFQmjjuKysOxzJyaRs?=
 =?us-ascii?Q?TunjOoyGfI/FLSJiFluZeeM+Pxf7A3MsegbfHg+4BHq+zHv4KLDTC6/kcPyc?=
 =?us-ascii?Q?PR4+v192Wsm6dX9fvvV5Ta4q76/NTbaV7MwAadVFINk0Ry9fEoHupMpUBMw/?=
 =?us-ascii?Q?ua3Ha7ay0K1pyUKCdXUb2UtYDZx8JSG/e6vcgfnQr5qdmrlwL8SvxBoKeliz?=
 =?us-ascii?Q?xTtlbQ23ZZjmAeqp+yB7OS/NplSykwMnYqgDTTSC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d95b749-2982-4397-7cc1-08db0adf344e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 20:49:57.6788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aG1f12+iPtbD2BKA++XTVGY8eaYSMyTRKRidNxyZGPjeN+3GqvtXg2PiFcvgQRg/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 09, 2023 at 12:28:45PM -0800, Nicolin Chen wrote:
> On Thu, Feb 09, 2023 at 03:13:08AM +0000, Tian, Kevin wrote:
>  
> > > --- a/drivers/iommu/iommufd/device.c
> > > +++ b/drivers/iommu/iommufd/device.c
> > > @@ -509,11 +509,23 @@ int iommufd_access_set_ioas(struct
> > > iommufd_access *access, u32 ioas_id)
> > >               iommufd_ref_to_users(obj);
> > >       }
> > >
> > > +     /*
> > > +      * Set ioas to NULL to block any further iommufd_access_pin_pages().
> > > +      * iommufd_access_unpin_pages() can continue using access-
> > > >ioas_unpin.
> > > +      */
> > > +     access->ioas = NULL;
> > > +
> > >       if (cur_ioas) {
> > > +             if (new_ioas) {
> > > +                     mutex_unlock(&access->ioas_lock);
> > > +                     access->ops->unmap(access->data, 0, ULONG_MAX);
> > > +                     mutex_lock(&access->ioas_lock);
> > > +             }
> > 
> > why does above only apply to a valid new_ioas? this is the cleanup on
> > cur_ioas then required even when new_ioas=NULL.
>   
> Though it'd make sense to put it in the common path, our current
> detach routine doesn't call this unmap. If we do so, it'd become
> something new to the normal detach routine. Or does this mean the
> detach routine has been missing an unmap call so far?

By the time vfio_iommufd_emulated_unbind() is called the driver's
close_device() has already returned

At this point the driver should have removed all active pins.

We should not call back into the driver with unmap after its
close_device() returns.

However, this function is not on the close_device path so it should
always flush all existing mappings before attempting to change the
ioas to anything.

Jason
