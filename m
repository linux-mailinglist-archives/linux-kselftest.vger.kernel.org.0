Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA15B73E66B
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 19:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjFZR3P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 13:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjFZR3O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 13:29:14 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA81610C0;
        Mon, 26 Jun 2023 10:29:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAxYoRgNRuLBmkWyzzaSo37t2Emtcz2C6evq0DjsjIFL8fECx2HbVLwQW2IssjwndaeYfUfr9DLmxCth0zgo0S+MuHzTvu9mvTzXggHJGmZfYZL2d0n4GsgDO5kq6UZe58V0D7GSOOQYNsE1+OzlTrup3BRAwvHCBrDcQw/Jext5hFnyjAqoOYUunNoSRC3wjnl2iJRqjQ5WIlzhELqBpmklCq4MIFTXjxAXf0DJ4QnZ88BxUjn94YsbOhL+bZT6pZgZa5PfGvW+0SqNv+QYprlTYklnLqSMgMUd6mUbbOzbzCEcnFf8XB27z4vODikRvdl3CkJWV6kEaDn/4JEH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mm3W0i+X/san5q5kKfX59TlP13CZe7i5D6FZCBhi/Tk=;
 b=Er9NIym6QEoRX2jGhR5Sk/jV688Ikis/DR0x80/Fd3pgoMKeyS8cXYIXx8C7C76e08i+LpXl8aeFpJsC19yfu4xlYeaZ+Gqy1N75f+P0ZZmT8Kr7YK+sdejKdPi1iWmc8e79MruT3/4h0z1bDOlN43dhs82B+3QYTfRryryF/tUwVacgPgBYWg0MWO8Rx9IQ5RRuEqMddTXEmHBHcwvjdQrDx6t7ObTdm2MqlHHc0JGSLaPprdYl30VEqAH13eSbUdLXd/Rdd/pvJg4dP+uMpGH3vifd3KcY/OU5zibg456v3re5OLwDhZnu5oMHI5zpCOWfnM059wwZWlNrri8fBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mm3W0i+X/san5q5kKfX59TlP13CZe7i5D6FZCBhi/Tk=;
 b=QjUA0DM5Wzq7a6AgACaj+aqMXCtptoF/wbe8t6Uk+Y7RxeD3/l4hUw0D5NV0Ph6gYodtgkbFhetRSiO4yiUbpabxu+vpmJMu6BHu6aS1pKV+Hwko8pr39PHapdJdKbO2RwZjWlmdme/47OnA0YDusjq++tBFONDorDNP/s4wRtDM7DlrFtt7SHPxJOPzl2RuySzT4NxWDHTC9NEdOWeW5dPD1sEqDsphLiceGyhy14OpagF1HNIXyK8R3AibvB3UX/kx4TKzELQIZtRQSEl0N1jH7/jGJ9Wpbz0jmJwi1i2t60K35n2yN5hdSEGue5xN1/P7jKx9a+H96gk/RktKYQ==
Received: from MW4PR03CA0292.namprd03.prod.outlook.com (2603:10b6:303:b5::27)
 by PH0PR12MB8797.namprd12.prod.outlook.com (2603:10b6:510:28d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 17:29:10 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::6f) by MW4PR03CA0292.outlook.office365.com
 (2603:10b6:303:b5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 17:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 17:29:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 26 Jun 2023
 10:29:01 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 26 Jun
 2023 10:29:01 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 26 Jun 2023 10:28:59 -0700
Date:   Mon, 26 Jun 2023 10:28:58 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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
Subject: Re: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Message-ID: <ZJnK2schtjrrwJ1L@Asurada-Nvidia>
References: <ZGdiS2m8jcd5OOt5@nvidia.com>
 <BN9PR11MB5276A74B2DA86C79908A420B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZH9AGWf1yRDu/86q@nvidia.com>
 <BN9PR11MB52763C7B838B04D3200322FD8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJBL8QLLBiwRsUSI@nvidia.com>
 <BN9PR11MB527663567ECB8AD52D3170818C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJGf3sgLKr9HLZuE@nvidia.com>
 <BN9PR11MB5276B852A32F53BE8EAA1A7D8C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJMvtMe5QHPM0OEJ@Asurada-Nvidia>
 <BN9PR11MB5276D6040E41595B929843168C26A@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D6040E41595B929843168C26A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|PH0PR12MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f5b451-5577-4a87-391a-08db766ada5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zCBuMnWT7K4qiyoZf/nAGpRA65O31s8X1osc/zHuCA9OEc9M7i1UeXitrrtcROvkZ0voiRiHNxl6YkMtPsFnwe/gPevFZpc6F9YN+hWx9rUwnryQs3vCLy3AjAEZiCrOZR5smR5wla/kXfpchKslQptMxmLy2r0sRaKyxrgYhmAWzWM5Kf/Jynj7KOhQ0X8oLhW/NnD3E1AIjlllSEgvcjJXtUZAR6i40X778O/PbyLgcGCmdMu/LKNMHEQhlxYqYA3iVX8K6w2A7VN5Fo5UFEQSJQ1LifeCbnSnRhO81y6xoJR4ZaDCVaSsHsdwqLKYSsnxzvkfMyNt3PFHZ580xhsIx6rwwSD+mRfnaVBc720lyf+K1Qpeeou0LneZHkVjNJ4zYTCGKc9KcuCvelRir6bw5TAoVg0GtIW4vbocbtkKWI/DOCUJjBebln4iC4Sx/mUIoPgqCj6dGflbNTXmlWwVDdS69UqmxRTOswAJLUgYfmV++ld9s7oAPJuEpmDKHM30/ai7atvpXBCfu31dbL6LxdiRshWpiLv5hZB6ix6058xcaW7ffV7xplmMeVp6TcjOR/iW/GFkhCSCIPRDA1q01totkYcAb6l5w/lvKt4dgK4Ygl/oiq87ILZ3m5tdqIKq4nBBQZ8B5qfk38LR8nBtcaUMIEF77+rhoPMb1MwitFMRx7HVSpD8PoEsDJtRz63kJPLjnzMPeovOwuigp4d0b/9BhxPPFmWy1O60qaqFtKTAdAGbzbWgcByEit74+QEcuZ/GP4kb5DFK6RaCsQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(7416002)(5660300002)(33716001)(966005)(8676002)(8936002)(9686003)(186003)(2906002)(336012)(426003)(40460700003)(478600001)(36860700001)(54906003)(86362001)(41300700001)(47076005)(83380400001)(316002)(70206006)(70586007)(6916009)(4326008)(26005)(82310400005)(40480700001)(82740400003)(356005)(7636003)(55016003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 17:29:10.4051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f5b451-5577-4a87-391a-08db766ada5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8797
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 26, 2023 at 06:42:58AM +0000, Tian, Kevin wrote:

> > > Yi/Nicolin, please update this series to not automatically add reserved
> > > regions to S2 in the nesting configuration.
> >
> > I'm a bit late for the conversation here. Yet, how about the
> > IOMMU_RESV_SW_MSI on ARM in the nesting configuration? We'd
> > still call iommufd_group_setup_msi() on the S2 HWPT, despite
> > attaching the device to a nested S1 HWPT right?
> 
> Yes, based on current design of ARM nesting.
> 
> But please special case it instead of pretending that all reserved regions
> are added to IOAS which is wrong in concept based on the discussion.

Ack. Yi made a version of change dropping it completely along
with the iommufd_group_setup_msi() call for a nested S1 HWPT.
So I thought there was a misalignment. I made another version
preserving the pathway for MSI on ARM, and perhaps we should
go with this one:
https://github.com/nicolinc/iommufd/commit/c63829a12d35f2d7a390f42821a079f8a294cff8

> > > It also implies that the user cannot rely on IOAS_IOVA_RANGES to
> > > learn reserved regions for arranging addresses in S1.
> > >
> > > Then we also need a new ioctl to report reserved regions per dev_id.
> >
> > So, in a nesting configuration, QEMU would poll a device's S2
> > MSI region (i.e. IOMMU_RESV_SW_MSI) to prevent conflict?
> >
> 
> Qemu needs to know all the reserved regions of the device and skip
> them when arranging S1 layout.

OK.

> I'm not sure whether the MSI region needs a special MSI type or
> just a general RESV_DIRECT type for 1:1 mapping, though.

I don't quite get this part. Isn't MSI having IOMMU_RESV_MSI
and IOMMU_RESV_SW_MSI? Or does it juset mean we should report
the iommu_resv_type along with reserved regions in new ioctl?

Thanks
Nic
