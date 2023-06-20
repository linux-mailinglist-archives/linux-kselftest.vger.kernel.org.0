Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BBB736C38
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 14:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjFTMrd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 08:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTMrc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 08:47:32 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EF910F4;
        Tue, 20 Jun 2023 05:47:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkAbQmXD0rW6+791JL9wN0X5B7qXZ78wRqAiOGpVSdtwl9zGzvSe8356asMTSRID6e5M47WUoejinG8XjL57q7G1P/rzdBo34iUKbH113ATpzFYHLWq6Y2m7dPu9xcToTHbrJ5gxhYDrOZ1yUeJIxJsrE26/07LQ9EuW8eqd06X7xkyKbx31A7JnOvCIiBPgqLnWRedbm9RqtwPGCOuxE6dBI/w7o/2FzOdvl5lIBpcNRacBEIPOg/qFSj3NR/gy1+7DTUjfJ3FyGbCrQMOcTwLFrMdXvEIXvUrL/vMd+wveb7mqoH3mQY0Nl+tL9qaCJm71VVd0aCzsMEEuuYBjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mroep7RWXZi7ge0FKGUaRfTEEUj1yObVwhFcsEUvavg=;
 b=EwXj6r2G1WV3CG4FMZviSbuADHrrOMekKpWvLpCofvZZEdMVvhEv8xDyYP+Z0fpB9HrCSsYA0NcVWEndyhYzz+Ri4MW/aXnB9l3ecMEyBZp0x+YM1J40qgXV1Kos47BVX/pQ7i408assViYxylantA5xwgm3vKFv/w5jrSgFETeKEI0/7sa5gWya2U2kf+RYIgX8arofZEC3dsWZ8PG/+sAwtf3CYujoIYQzrqCx1kMhNeI1PaulBKryAyUeoUNgEwuK7kDbAuKtJEaAZH6Wq2O0/IKxCj2M8WO/GkBp396pPc7ftC27pBAXa6BpcCWmj+QlBsF3lxs0m1YGrmLGTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mroep7RWXZi7ge0FKGUaRfTEEUj1yObVwhFcsEUvavg=;
 b=e1AGHjeSAMcpM0zmAyfR0bPM8A+9LD8XPB6tY6snB/Vi7Bx+5+M9PTy0WLInJgBKNJGC4JKennaG1XiPHLjFvVloXSZ2WpQJ7RZduh7sZQAp0JjvpMSHOKFpODw0+8IXOxcBA+MzQmheWNX+y9vgT0E2h3GJZ9PFOEr8xqHSMSeFdzRB+agtDnIOxSpxLis7hZ4sKYZvEQcsNZVdcKKV2jPM4bG9QtSppdScRf8A59QrOi6tBKu9EOan4AKUtdz2L9/PnZ6ghqpCFeX+0D0B6zGW01dV/oEd9nuJzVM/GxB8RCD9iZXk3OKG7D/ZqPZmlWIZmnGYYdnAB6aaQM7XSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 12:47:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Tue, 20 Jun 2023
 12:47:29 +0000
Date:   Tue, 20 Jun 2023 09:47:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Message-ID: <ZJGf3sgLKr9HLZuE@nvidia.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <BN9PR11MB5276DAF0A11809CF8433EE338C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGdiS2m8jcd5OOt5@nvidia.com>
 <BN9PR11MB5276A74B2DA86C79908A420B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZH9AGWf1yRDu/86q@nvidia.com>
 <BN9PR11MB52763C7B838B04D3200322FD8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJBL8QLLBiwRsUSI@nvidia.com>
 <BN9PR11MB527663567ECB8AD52D3170818C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527663567ECB8AD52D3170818C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:a03:338::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: ac46351a-d82f-47b8-2193-08db718c81b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wx3tuUplCCkMkqLtCpF/mWloRdmO6vqwJUB0iFnOEi+4A4RVa4b9ZV7pV7v39skh20N8Q5O7d+mfcK/+6uPAVrAcnI/pA8vvv0tc3iSlHQojcdxkO7VJh02cl5AiR18EsReo5Ysnwk2MrQiMWYW/TRW1d0GIw/hW6Bx27TKhRcV7+ygMu8zDcPvTroIJ+Wi5BslMk+fju4AXgzHctocGBOV6oagaf7zZ0xUIh27vlUsQmUy7xGPeO0qKzcqwlHtTo/TRbuehPlP9S3vFbZDcFPfELYe0fGvJEmZnr5zGBZh6jaRm46ChWoviS1Fn6ZiM/izAdnJNR0KNr7eCNkNr9Vz358cRgwTPrOJ3KSvv6ljE6KN5CJ/Oy2hrYhv7Xdxv2r5HfM+s6L1obtE875XPwlv0XLIkVmFQlyqwR7zg4z1yi1zBsRknPj0CduTgwVE4yj/B3Orcfnl+453pGkr+REH3vwb4xPmbBwK8uNFeBsJskWPtlVAnE/P/EMeSZY9LaTyzbBHOHAoIbRK/J8ZVg1sfG5k/JHiGDl7cvIcYaDCt+pU/K8H8+anQd23EEDnz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(2906002)(41300700001)(7416002)(5660300002)(8936002)(8676002)(36756003)(86362001)(478600001)(26005)(6506007)(6512007)(186003)(54906003)(6486002)(6666004)(66946007)(66556008)(66476007)(4326008)(6916009)(316002)(38100700002)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eYr4CdkCp4VEmb8Vq6dEx0b4O8LFLLS4o2BeWV32FH4T67OTKzgGF4usbT17?=
 =?us-ascii?Q?n9//knm7zSQIJNGMrRWceIF6udFhEfZJg6PomhWIAZYcGEe+qAjw+QD6LF45?=
 =?us-ascii?Q?x2tzvcQIoT5oFbiX+JEviun2g4it8uWZfDW6MtYBnZWiv00Wwn1a95aWfi6l?=
 =?us-ascii?Q?8jNqxNO4JKFYtChpKIRyYet5VqGyFFJE6mRME+eQRBIVBl7wUk//2usv3HfD?=
 =?us-ascii?Q?6lrPUSM0m5L5QOwH2w+3TWdKKOxSXLxpKoJivJ2uessrFbjJ7QWDuytsXETP?=
 =?us-ascii?Q?hfE0UOJRcNnIWcJoTGyNBfkXvKMJ1a1n/w3OYNj4q4gvAgusKq6422em7in9?=
 =?us-ascii?Q?5aEwM2Y7M7njp+QD003BwAFJ1ONxjOTBqE1VIghsbfmZ5LxVZlvoV1XLwTOC?=
 =?us-ascii?Q?0UeHPBD6ojdurQXf+OLChkTSod/k4OAY7GJMKt8tLZIwk2rY39TQ1s6ZbNna?=
 =?us-ascii?Q?ObVgDVw4kNHF3ozYNyipu+KZW7bqhf7aIWIIogDLvD4KC/FP7WYXucgTpgvS?=
 =?us-ascii?Q?r2JazSoo840GObfWiOekoPyDp9mcyWNvEU4rMFhkydlz6Wgym9p0SBvyNcBv?=
 =?us-ascii?Q?TMhtihSuGIdHyIIXB+jbkdn4nx3smDFixOQGI+BSibEZWPc7kx66CN5c5Uoq?=
 =?us-ascii?Q?XkEg5RL3b0pumcWmwzETOMfGat78Vs1mWKe6RyyhpeD24KQtKwb4dbgq1l44?=
 =?us-ascii?Q?qESAmTrgwhdUP5/8MS8sBKjN4EpmQdunxMdfOYesfBL4SwwxT3J+5lsctHjo?=
 =?us-ascii?Q?d+jm1089kwIewwroiDTVB16CNqWhDZ5qw2TccZrgnGsJav8EsE4gqRAeHMpp?=
 =?us-ascii?Q?VpnzWZ7jFy4jXRm5pt0nH2PBMTlTNzMVffocwbU4jA6lf2S1lyc9eaGGW8v9?=
 =?us-ascii?Q?5gYTM2dKN60znLaruqTYth70kDC9v6D0JcMPXLv+U22hUToPfS4+nu0qoDzV?=
 =?us-ascii?Q?CxV8t3Hfo8tJE2rnwfkv6blV2WClrGvP4nXWQVuHjC51acG+ZGjNGl7QT3wH?=
 =?us-ascii?Q?ZB6+41t0AxFD4DwyMonTdmaRMAoFpSAf/CCKnLaT9fent2TZy33fe+RkAIoN?=
 =?us-ascii?Q?60BDuyFI4LJig6LQ/uwnikMjZf0/cSOIjkJ+9s/pb0OR859QCm+xQPf7PxSG?=
 =?us-ascii?Q?ZupQDR731C+6buQTi6Oag4UZvbDzD1SaJ679dv9bMnKIRW7z+SipMbFYIimD?=
 =?us-ascii?Q?yckJJ5PH0X6JxX3ZxnnqwVGRL0ZQPEFhqUZ9U1yvVVGVnDo3X3FsFGkm0Li2?=
 =?us-ascii?Q?WRa071HIygpwNBMsLCcvxzlj78YZuH2Is/riJ4/GZ/VvtU7T5tC/jTEPDaFL?=
 =?us-ascii?Q?O5j91nPu4Hi3G4PTNKNNzWhDZOsy85rAgLzicWpVXqQmXzQxh8sEM0v6WbU9?=
 =?us-ascii?Q?EyUa8TZpPjvQ/ndQfJ8VLepEjFUxk5YQ+yZxPz9xDdUmGV4ouRS/z61yMMwZ?=
 =?us-ascii?Q?RJ18Ms8spKB68Pjg5mUELe2/ogLDC8JyyckEEkT0CUHH6v/vN6tnu1lgulhC?=
 =?us-ascii?Q?+9WAHqCCjxrT9ggNCU9ctubDaKayLutzua1RlD3Gbd4/Nf8jF6xpY4qt0OCA?=
 =?us-ascii?Q?1jPyj4vOPtbt5b4W1JEhBKGPcyNb7qO2m/88fRIh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac46351a-d82f-47b8-2193-08db718c81b1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 12:47:28.9706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76jR2BVmd7C27ylRTRm3oHwlGQTGKx3VfRP2YRMyvhBk688CB4axVRC4+MAwoYUU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 20, 2023 at 01:43:42AM +0000, Tian, Kevin wrote:
> I wonder whether we have argued passed each other.
> 
> This series adds reserved regions to S2. I challenged the necessity as
> S2 is not directly accessed by the device.
> 
> Then you replied that doing so still made sense to support identity
> S1.

I think I said/ment if we attach the "s2" iommu domain as a direct
attach for identity - eg at boot time, then the IOAS must gain the
reserved regions. This is our normal protocol.

But when we use the "s2" iommu domain as an actual nested S2 then we
don't gain reserved regions.

> Intel VT-d supports 4 configurations:
>   - passthrough (i.e. identity mapped)
>   - S1 only
>   - S2 only
>   - nested
> 
> 'S2 only' is used when vIOMMU is configured in passthrough.

S2 only is modeled as attaching an S2 format iommu domain to the RID,
and when this is done the IOAS should gain the reserved regions
because it is no different behavior than attaching any other iommu
domain to a RID.

When the S2 is replaced with a S1 nest then the IOAS should loose
those reserved regions since it is no longer attached to a RID.

> My understanding of ARM SMMU is that from host p.o.v. the CD is the
> S1 in the nested configuration. 'identity' is one configuration in the CD
> then it's in the business of nesting.

I think it is the same. A CD doesn't come into the picture until the
guest installs a CD pointing STE. Until that time the S2 is being used
as identity.

It sounds like the same basic flow.

> My preference was that ALLOC_HWPT allows vIOMMU to opt whether
> reserved regions of dev_id should be added to the IOAS of the parent
> S2 hwpt.

Having an API to explicitly load reserved regions of a specific device
to an IOAS makes some sense to me.

Jason
