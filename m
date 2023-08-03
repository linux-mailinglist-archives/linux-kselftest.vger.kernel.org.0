Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED3576DEAE
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 05:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjHCDE7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 23:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHCDE6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 23:04:58 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC18919B9;
        Wed,  2 Aug 2023 20:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpOEJmzlr4cuEjOwhdHT3G7hkGyHBil5z6PPVT2H/oOzJFTjNDDHNURGZIYdOvGakuO3/rh4Ud8IekORVQPljmi/5iV/+lquSp+JUrP7PZJWnttKcjwKa3uiRnw2PhnRamFsKMVvXjA/ep7lDtLvorlQcqQqW3SLx6hp5xBFE/NPB5xHmF+G8IMUFMNqpzqdmK9qJOUoJ1ukkPMvcrwvTODocVcdPdULz1N07c3IoT0Kp4LslmKEy4Itn7vjDkhqi922WHuKOCjUy0zEFFFDPNDsS7XAvlQd1NEVO9ldgeZkEz7SHJC4AtpcRpTM9ZHo7wGkNZiwRrazAdrKkm1drQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHvn7ob29rE0+h/7qdv4eblqF46D//wmSPsZfWNt6Qg=;
 b=IXPbj4v8UM7rmypf1CUQRpS07e7Sk6XptlHslXZbXB90y+4g+uI8pE7IfnghI/VpbLLIptE8Y9VmRiG30Ixzq+UIr4aWkbxpUr2pdv95lj2VTjq8R8e7X2CCG87ob3A7tti+jSpvc1fhDaJ3SZJ1wcC6i4rrZLjzaWrfzyzNw2H5UwFThxj6tefCz/z2EpoLsg5wLoLXu+Xs02MQbGsEyW79HtMpX/C/dlEf060tGiEyplZZuS3bU8Er857viA0pfx4XeQqqflJ67HffD5Rlbq5A2W+52kF1Fv/0Ue3NTWg7GqJW+zKCdhYGo4mE6op85FxWE+6HI8qYZQpLFEBHaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHvn7ob29rE0+h/7qdv4eblqF46D//wmSPsZfWNt6Qg=;
 b=oEaKffwKVoMZQeYzJyo+6vYxD9z547pMbCxJTK5W63RPO2Vc1S1PwRFa0BezyRFRKcqKREJrvT26KR9ZTM/akc3gSNbu4fo9K3+jDO8ugzgGHx89KrAwRRYM9H+6Ja4uVo+fWzHRvh+mLU7oJkOOOb9h8wfINWNmdxaFpR0HL7AqhRbtqLQ709dnCbagzRYgq+vsx8Br1NcceamnX+B5wM3Xo88qyUCIsIvXsnXUqZ+6RS2tUBluCsR6/58TEeIpZduHK2F6IcrOLyrT0l76KfMTPbOG5HMwpV07kC3wxEbEvBOc/KBtm6WMZAOTB1cTxlM+QZipzgOEB0iZbqDFnA==
Received: from MW2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:907::15) by
 PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Thu, 3 Aug 2023 03:04:55 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::d7) by MW2PR16CA0002.outlook.office365.com
 (2603:10b6:907::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Thu, 3 Aug 2023 03:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 03:04:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 20:04:43 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 20:04:43 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 2 Aug 2023 20:04:42 -0700
Date:   Wed, 2 Aug 2023 20:04:40 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: Re: [PATCH v3 02/17] iommu: Add nested domain support
Message-ID: <ZMsZSJjjrB4y8udO@Asurada-Nvidia>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-3-yi.l.liu@intel.com>
 <ZMPz8MIevHBd6zsI@nvidia.com>
 <ZMsSvM/gC9016CS4@Asurada-Nvidia>
 <DS0PR11MB752948714F908244DABD27F9C308A@DS0PR11MB7529.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DS0PR11MB752948714F908244DABD27F9C308A@DS0PR11MB7529.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|PH0PR12MB5404:EE_
X-MS-Office365-Filtering-Correlation-Id: b38951dd-589f-433a-751f-08db93ce69b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAVw9oNol0fHYhq6sM7WJ9ev9ChY9DOR/AaykioUg+Ft3hmYMSj4T8FmUuRtMPTkJ5FNul2Cga06U2tDZ0qL3HQ1m8L+N6V9jzwjLTZ5AZaoQ/Fu/vFsawzYlJzK/10QS7aIab/2gdSR+R5qFOwRJBjm/Lf3kQRRP1naaGg8DxE6HxVY98A20D7h1tvOVOFefaRMSMZ8DvxavDrjUV1qdDwMGxmUYY8ROlTknYxLYqUhlxaSGmhom2bQ6FRgLLSxd+YGZmejnNAtXntGj1KzYVePrToyCzMsUfPxX2e3soMM1Gg80HDpEkaiN7sikBnvdMeCh1+cpNIOVVrOtjLNG+JgoLJZ5ztRZKHaU4ZMemPV04VGuQozxunbWzW8fau8GijPp+xONWCcC2M0Fom38yjIxmCe4mi+KDKK63kJpbP3fy+wL+O1EIEHxrkScGlvQeuHPn1ivm6Lyhu5rnBPMbnxJmMQmX21aXnvAblgbLh3QoHvZXgDIWBVRrf3PlF9og+Ee9ialG2SsvrOywZT9OVA6Yv4qm1imNc+4O0NpIymlIE/a9YIqGfPpSy55ghLdOXAQjF2B4j3HnmCwR+BrokFC/1ughrM6Ss+T5uczzP/7OmEokz9xdiVx0SDhIHLoLfQU+KdkgoKXnvGrx8u/0pvVIkWDXqi8TUs7pEI5AKDmfcm3Ym4dhBctX8Mx1v1o5LKjGpWU/sG+MXk2blFT7S3M1Y/tszrvMlz8Qu7xPVUwZd2iXyEwPgrUjr5TyXj
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(426003)(336012)(26005)(186003)(83380400001)(47076005)(36860700001)(316002)(70206006)(70586007)(2906002)(4326008)(6916009)(5660300002)(7416002)(41300700001)(8676002)(8936002)(9686003)(478600001)(54906003)(40480700001)(55016003)(356005)(7636003)(82740400003)(33716001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 03:04:54.7970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b38951dd-589f-433a-751f-08db93ce69b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5404
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 03, 2023 at 02:53:34AM +0000, Liu, Yi L wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Thursday, August 3, 2023 10:37 AM
> >
> > On Fri, Jul 28, 2023 at 01:59:28PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Jul 24, 2023 at 04:03:51AM -0700, Yi Liu wrote:
> > >
> > > > @@ -350,6 +354,10 @@ struct iommu_ops {
> > > >   * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
> > > >   * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
> > > >   *            queue
> > > > + * @cache_invalidate_user: Flush hardware TLBs caching user space IO mappings
> > > > + * @cache_invalidate_user_data_len: Defined length of input user data for the
> > > > + *                                  cache_invalidate_user op, being sizeof the
> > > > + *                                  structure in include/uapi/linux/iommufd.h
> > > >   * @iova_to_phys: translate iova to physical address
> > > >   * @enforce_cache_coherency: Prevent any kind of DMA from bypassing
> > IOMMU_CACHE,
> > > >   *                           including no-snoop TLPs on PCIe or other platform
> > > > @@ -379,6 +387,9 @@ struct iommu_domain_ops {
> > > >                          size_t size);
> > > >   void (*iotlb_sync)(struct iommu_domain *domain,
> > > >                      struct iommu_iotlb_gather *iotlb_gather);
> > > > + int (*cache_invalidate_user)(struct iommu_domain *domain,
> > > > +                              void *user_data);
> > >
> > > If we are doing const unions, then this void * should also be a const
> > > union.
> >
> > Unlike iommu_domain_user_data is a union on its own, all invalidate
> > user data structures are added to union ucmd_buffer. It feels a bit
> > weird to cross reference "union ucmd_buffer" and to pass the naming
> > "ucmd_buffer" in this cache_invalidate_user.
> >
> > Any suggestion?
> 
> I think we can have a union like iommu_user_cache_invalidate, every new
> data structures should be put in this union, and this union is put in the
> ucmd_buffer.

Ah, that should do the job.

Thanks!
