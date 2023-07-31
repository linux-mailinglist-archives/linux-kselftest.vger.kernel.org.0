Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57DC76976A
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 15:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjGaNXy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 09:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjGaNXw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 09:23:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB3710DF;
        Mon, 31 Jul 2023 06:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcjKVJv3oRNBDCYvwaTNLEi4l3ocLGXPwxtLVQXDHOhdbeeb4fbjKFhYSxxPnI4zSYjW63PSyZ3cCDFBF2PvYsJE2sgz1FVz290rrGscT40L90dhcGsivNHMpmIE1MnJ/yE8tiH/5qBEf2bW4+haVnfiDlYlbvlX42L0XhceEpBvWGjEpwJegmTbTrKllpR2kdTfwJjciZGq68IbCelRxUQTqeMnxHi0co8lJ+JLDowdt/x2kU3B8nZFmwyyNzPGvXfM0y4pZSBLZdjCW2iQ0KU6I5Wp43KycIy4CRmQAATMFr5lfj1ifqz7a3GFezzvfJNuiF6rqx5XnHLHDFAjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQU3+6qSurQmBqvQ24EJFqnP7/tgsu8Z/veTNRvTpew=;
 b=JDK723zIjeuDv0v5SA8rb1U0+lbUIu9Wdqoz/vQfP+NZ451Jo+VUj1E2iDaWC6s2kaqZbnZH6s59ssTBabA1y/bvFlv2X1kDk+fi88hLKXvSZSaaJtiEafu+3Pqjn3UNQqHWttYs+rZdk3WNS1VtTY1rrlEkI2QsFHQj/QJJHtAflJ5ho1FQX+p2j7rCCKxRzzHUvosZ9w2joA9WQRVs4m3rhPsBY3q8AD2Xgi0411q3HEmhp+5oUd1V6EhC1r7hzcxYyKmztXV6KEYhqnd3zvafu8gs7bONHB/ghCtEyUPl/rzZ4OLcMQEo61AAaU4NYpdMF1fy1lQrwSOov2hGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQU3+6qSurQmBqvQ24EJFqnP7/tgsu8Z/veTNRvTpew=;
 b=CRETNlTzDge+7FrKds852OehtHr7TJ+UKUEpcD/TAZp4+U1+DCzf/yte+ZI9GC+FTZfybR+b0Z3wdVoDHssv95WroOtl5hsShw5TImzBvz7xFz6+Zo1FeWNJ2BXWIrHITufj+jDwa+yzEJm0NIjh+fHBK/VBPNDG1l3nZOMqsFBDaD7/8H09gbWVYpDI3DKN1tlnfRY7yUz9Zvwh0bIysNLfiMsoOg+xisGwZCVQCD6+p/CZHll94FC/uUndso+p0pgR+mldrQ6ogkvW8w4CWE1iazDznaMQyfWDIkmEsnxf18LAfYaD1pzbcdvTNoqTyTydUhEUyeMbnYauN0zvQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 13:23:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 13:23:49 +0000
Date:   Mon, 31 Jul 2023 10:23:46 -0300
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
Subject: Re: [PATCH v3 07/17] iommufd: Add IOMMU_RESV_IOVA_RANGES
Message-ID: <ZMe14r37YkdOKulU@nvidia.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-8-yi.l.liu@intel.com>
 <ZMP+lvbhAwEbhjx/@nvidia.com>
 <BN9PR11MB52764E058BDC007FCF2F240B8C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764E058BDC007FCF2F240B8C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 283f7184-26c0-4f3c-fcd8-08db91c96016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jBK1ND9F5c9EKgybC/hWA3QE6THJsMkZkRkFktvD124jicTL+so8i/pN4a0xbIhGA44C6srN0+gqM36Z/zQmCuwFM0nYCtdCyvYbMHLPebuREjubiuqCMlQ96aiO8poF9lhBOmksS9+wt3tFHL3yyYT3lsOdnUtWlYomofVkmlWJeNAG4yVwtw2NW6/kdELtcY+t3yhJjYhGXCjxsoniAT5OQ7uxRfXj6O3oQOxJKqaYxfZloKhQL0Q2DXdX4kD/oR3pB4iPHqHmk/Wj+OCnt+42h2ne7T/uLyJDo1dJ3uk0yqNy6+E/dakZPNmHeTZlmtLJDp4g2ynJzEPz58iGWrClW1c5m/mF70dubPgRvjP3WxBsfPisHE1W9JKbJJkFbgNtfZJa+37pk9vnKBo4SrOUYRf6ZEUesncBmpuryXDpHK4dDo19MNsDLaSDamHzVNI4yKJ7nYMzhByfCp9RCoUbInRArUs0FmzQcaLBgYVAFawCXtD6JcjQtg9HScxsJebrqoJuqCd6TOip2pjcr6064C6/qC5owDPDsFOzK5NYezWX3mHbU/Ac+DJT6Z9H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(6512007)(6486002)(36756003)(2616005)(26005)(6506007)(83380400001)(186003)(66946007)(66556008)(7416002)(54906003)(86362001)(66476007)(316002)(4326008)(5660300002)(6916009)(8676002)(8936002)(41300700001)(38100700002)(2906002)(6666004)(66899021)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WgpSwjShr+j4iz3JL/med9lnsB/e2ftiv+OqOps1LB2doKfKGptHR8UyrSmZ?=
 =?us-ascii?Q?each9eDDeQ+TK0UYN+8WBj9hEVhkwsIKLCMJ7BZY2G+hw2kk+lHTxxS2AOSf?=
 =?us-ascii?Q?qndkPB8DdZA7BwS64dFrcxzYJnN16Qhh1+KEn8rXPs88MqKcquscN0K7VaW9?=
 =?us-ascii?Q?8QrCCJp0NweVZvrCfmXOJGdm+DQH6AFI/i+nNBqQkBmnp4y4WRbX/r7O3h31?=
 =?us-ascii?Q?wLXJHm6bbREvsYV3Pi5eSiF0tAJ/HH4vtT5fAGg7t7r6xgaCmHpM1ByMj99g?=
 =?us-ascii?Q?PgjJpNgtNDRpecWwMVhMjoj6rkQiMJzeqGlhBhhq3Chd/Da2ciAJc3JhA091?=
 =?us-ascii?Q?xo/1/Apg6+4/6XFBHOz1zsxEOsI7SjJzI8Q+PCVHaMCO3VGulBYY7Zvgg0ch?=
 =?us-ascii?Q?rkFDp5jncTBgIqzt9bpUbjwljIFFRDGCJtf6Ksny0Ies7L9uggQ4WidXqBXK?=
 =?us-ascii?Q?IdZh6NufcNVnVyNbtQLx5hx+2NCGnVt5zAjGAcb2DkoTcvuFfWwGXeUW8hT6?=
 =?us-ascii?Q?aT0V2HrsmKmmdMx63+bbPh7GWkNsUscZK5oE96xYZCOfpm2LctM54mDNj8qL?=
 =?us-ascii?Q?RhzqxK7ozvHmqsHrc1aQTns3IXK1ky5lXGfqDfnlEDjC9RB/cp9+/zOKYGxf?=
 =?us-ascii?Q?JrUz3z4Rw1NsMSb5DU2AndOTW7GppInC1SG6geYjnh8VVlV2/gTHSCvDtNKR?=
 =?us-ascii?Q?RTiGyWIEe0+ux9dWSQ7M1ij1ajV0ND57g/ti45QcJdYqvaZxmCZRCXsf5BDN?=
 =?us-ascii?Q?aZyH/ktyrMK5Cbn/Elg/HTuudKkOKD+o+ERvssEtYcuIWaxysRjsgIYVC8ZB?=
 =?us-ascii?Q?U4yjf8tXKMjWcF5bYGrJ0dD/Bvx7WRLNTbcRHGbBVymYJ8w7r3z5xDaf0Py/?=
 =?us-ascii?Q?dsZGRRZ4WypGG9PdLCMrwwZFe5iR+Qi/vafF8BsGL53IFsA4eUfq4/IgStsU?=
 =?us-ascii?Q?keGj3w6pjYFnwfTLgu/Mt2JpQtbKJqCYZVZleQ1ZuLOzrtgnWDMsBAA70xyn?=
 =?us-ascii?Q?4g+ZfGgOns8dOw2RDuxTiauAa4qY4jkttt32CygXdINNDhcAwUzBq8dmb/qu?=
 =?us-ascii?Q?cdfarPpBgddvbEgO2WpgczFkBcGZpxbvTSqjnRAJ7laJPEsqZ0BddZRxm8I9?=
 =?us-ascii?Q?0+cYPfbOOy248X2+agZvoUlAgboeOKl0kAOKHG/nvHfYUHo0mbZ9o9UvkBZS?=
 =?us-ascii?Q?tj9mFXIa10ZZnCwsmJq8/n2GSzQZzcvBF26xyCUw3If4chw/K8kNDiRWTTxk?=
 =?us-ascii?Q?psJV3ILh9eicko0sYUgDlpY+HXRoA+u3/MTdgR3gyHxa63HyXHuEDd05fz/F?=
 =?us-ascii?Q?ZWl9eg8avPlfOXdDQR9TJz35APqTa2kphSlOPJfycwy83KlLYl0GdL1rSQ4d?=
 =?us-ascii?Q?pDXEDHuIGN/0ujnPR+Pjb1abuDyv7EJnrPM0fPe/3Xg3R2eGntL154VBMbyy?=
 =?us-ascii?Q?1AGI9gLkMtvcydE4nrH+qUSSR6v06wsMdFLPuQ03EO7wDrfqSNf1O1skN2HS?=
 =?us-ascii?Q?2g7Jn+qjHHxMHiklD2Duqr4XSYN9eI90f2sPasGFaWf8mCE7VOFBJKeVnowC?=
 =?us-ascii?Q?njOyjvkcx/J32LNwvuvaqbDkjDnjIBCaTpG2Ri8S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283f7184-26c0-4f3c-fcd8-08db91c96016
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 13:23:49.1796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjIoxjspILEdF+WNd2vq2xawT1S4VZLiNRkGl5YER95eZfMHVkmzSinS1DZBfJPX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 06:21:44AM +0000, Tian, Kevin wrote:

> > As it is, userspace will have to aggregate the list, sort it, merge
> > adjacent overlapping reserved ranges then invert the list to get an
> > allowed list. This is not entirely simple..
> > 
> > Did you already write an algorithm to do this in qemu someplace?
> 
> Qemu is optional to aggregate it for S2 given IOMMU_IOAS_IOVA_RANGES
> is still being used. If the only purpose of using this new cmd is to report
> per-device reserved ranges to the guest then aggregation is not required.

I don't think it is entirely optional.. If qmeu doesn't track this,
then it will have failures when attaching the S2 to the device. It
needs to make sure it punches the right holes in the guest memory map
to be compatible with the VFIO HW.

I suppose in reality the reserved regions are fairly predictable and
probably always match the existing qemu memory map so you can ignore
this and still work.

Plus most qemu cases don't deal with hotplug so you can build up the
identity ioas with all the devices and then use IOMMU_IOAS_IOVA_RANGES
as you say and still work.

> Arguably IOMMU_IOAS_IOVA_RANGES becomes redundant with this
> new cmd. But it's already there and as you said it's actually more
> convenient to be used if the user doesn't care about per-device
> reserved ranges...

Yes and yes

So, I guess we should leave it like this?

Jason
