Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D4C7CB182
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 19:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjJPRqc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 13:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjJPRqb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 13:46:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248889F;
        Mon, 16 Oct 2023 10:46:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOPlksfz7hYbLFVufRRDspDkQWoIPWJkp929ZOb36sJL0OxW4d6WNfELsTpjYUmBW19TsI+Qqdn+gaf79k/S5c+6bUxncuqFCAJXd1Gi08fl26N9syElcUdP+hwWZAowaeXHg/D1eWsiJ9FDpfeIBoeGgRlR0I/46+jrYYRsK3YV9srL6W5xYeZYpS2b1cv+n0Zb4gYWSy7BTfmH740VeZJTcMazSdCJXVc3aaC8kbXJFaUp5i1QEkciLRZ5ehQM/WZZJotRqz/OV0iYndHN+wobJ/qNUM6g9QdakuzCjiInEO7z3JGPZn9deArLIv39T7OueRpoPoFFBVAEIy/ztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15uE4DSkg2AyvMelVDkZH4tovHTZJdm2K71GECmLDu4=;
 b=cS8WASBCwfA5zhSGbpM3hcmN8AMFtmhrtN86AxgXps/VODmkD9vdTbNrE/JnsYxWDUtj8fVJw8Nw+T/iLenlgnHORh1oPU0qv2wpfWH5+MmRkS28Zaztm9N7JClIPlqmQQVaMH7hVk6Ilc4ZWqjKSWNywKWVnWRhMcYYLhtII04r8wmwJA89fkDEo9pogzBYYBemk8yBB4gxqRKEKKzpZmFeKJ+aU0hOerVqRPlhCBAlnPsEeBkNDHeBN7UXHBJjSX3Vu/W2HCQdDtyCkdXOozkjAzqy8rkzD+r+h1llBsbKm9/wDuy2pd9G4WgkTsWEcugCDiTddVu3c/nUAQ8GJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15uE4DSkg2AyvMelVDkZH4tovHTZJdm2K71GECmLDu4=;
 b=VEiIKzB0CJrIM3nD4O1EgM7wr5e6uegutDC11YQS5UGNOwse3M9hyVZzZuZNIWFuL68/PdGPiuttY5MUzwEiYu4COsqRK/hmDP/a855BhPpiEYM1HCTDWRwGYml04QVq+0mDHEHuvsfDSrJlIpnFfMedlIYojkIeFFhkw5mHtGmVyty+ARimF+Y4MAkfeHni2q1/WTJ75gcWnIOHV7zPf+Xc4vgSQt379B2B+6HaMpV+zp4JyYZdWSxCzmSz0Evq7TUPfGhE1OFtlAtmsgsPyOH5+/DcwUZ6pLrWItzhvYgKAiD+Hbfq36iNdHDEkCoLNKaSHqEF/Fat7AqQeBwEbQ==
Received: from DM6PR02CA0112.namprd02.prod.outlook.com (2603:10b6:5:1b4::14)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 17:46:27 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::b6) by DM6PR02CA0112.outlook.office365.com
 (2603:10b6:5:1b4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 16 Oct 2023 17:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 17:46:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 10:46:13 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 10:46:13 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 10:46:12 -0700
Date:   Mon, 16 Oct 2023 10:46:10 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Yi Liu <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
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
        "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2 1/6] iommu: Add new iommu op to create domains owned
 by userspace
Message-ID: <ZS124n0LYj4kl/4c@Asurada-Nvidia>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
 <20230928071528.26258-2-yi.l.liu@intel.com>
 <ZSuROTyaxePoVFA+@Asurada-Nvidia>
 <20231016120454.GS3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231016120454.GS3952@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|BL1PR12MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d3ce442-29b6-4531-eb0c-08dbce6fd251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVOR8PcYm+gaXAOJv3Thn+1sfMsAxjdQ0ilQPJNakSL9agIkDRGDt+mYIBgIaXURzXX8SX7mCaL7J054SjUivuihzMUUffj4GLqfzeGp/cuoStGIE5ECX+mLXlZ158n2M2joD6R1Kysz9Xdi/eBe7ZlOBr/yue4tC7QLOwEyk+TR1QdFs0VUbh8936mVa3r+h1ALZMaTAu38i8vaPPD9GGHJtWk391QLFHLUW05kRBHVZ/sF7Bp/TYiRIQqAkD8aBCQfg7EdzUtHHSOX58U5oiiHMlfNDNkicYYmrwzY/opFTKKI4WgIRSQodqEbq+kFPfu2SQbhgw9Xdm4VHjcXG8iRYeYEIinQPV4LECtDhfLootnPGp/CtpGpbEXBW5LsbQ4PGuCsMTa0eVBk05CvbhMayRo/E5EpY1y47OUy+l/ndCuPi8KaYIiOm4APEUZHihyELseNXcl3Viuf8cght4qfFKmhLAx7LZ9PoXvaRQ5TsIr4Iq7MwVKIzipEg/aM0RqQ3xhJdXTYDkRWlhX/JnIQ0B1ygmAlO1gDTHiI3rtVV8errAwIgNIxtbAJTm4BlXN1Raj06mA1tlUCXz/AJjMqVYrqwF3i5+XpiF+meqdumBAAdYGWaIREbT0lmJ5ZnTWS1B6CNI5WGVohB1yM7ZLvOfUGNva9rrx8e9hpwpdovqZNw1cLvf15Wx2cBg7kFOIeVboYfH5LA9B0ekpMSBqR2J2LTWva+WvWaq9vnt7B/qSi23r0/O1Bw/vA0MHD
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(83380400001)(336012)(26005)(426003)(5660300002)(4326008)(41300700001)(6862004)(8676002)(8936002)(40460700003)(86362001)(7636003)(356005)(40480700001)(55016003)(82740400003)(36860700001)(33716001)(47076005)(2906002)(478600001)(316002)(7416002)(54906003)(6636002)(70206006)(70586007)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 17:46:26.6926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3ce442-29b6-4531-eb0c-08dbce6fd251
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 16, 2023 at 09:04:54AM -0300, Jason Gunthorpe wrote:
> On Sun, Oct 15, 2023 at 12:14:01AM -0700, Nicolin Chen wrote:
> > On Thu, Sep 28, 2023 at 12:15:23AM -0700, Yi Liu wrote:
> > 
> > > diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> > > index b4ba0c0cbab6..4a7c5c8fdbb4 100644
> > > --- a/include/uapi/linux/iommufd.h
> > > +++ b/include/uapi/linux/iommufd.h
> > > @@ -347,10 +347,20 @@ struct iommu_vfio_ioas {
> > >  };
> > >  #define IOMMU_VFIO_IOAS _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VFIO_IOAS)
> > > 
> > > +/**
> > > + * enum iommufd_hwpt_alloc_flags - Flags for HWPT allocation
> > > + * @IOMMU_HWPT_ALLOC_NEST_PARENT: If set, allocate a domain which can serve
> > > + *                                as the parent domain in the nesting
> > > + *                                configuration.
> > 
> > I just noticed a nit here: we should probably align with other
> > parts of this file by using "HWPT" v.s. "domain"? I.e.
> > 
> > + * @IOMMU_HWPT_ALLOC_NEST_PARENT: If set, allocate a HWPT which can serve
> > + *                                as the parent HWPT in the nesting
> > + *                                configuration.
> 
> Yes

Should we resend? Or would it be possible for you to update it
in your for-next tree?
