Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4873D77D138
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 19:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbjHORgn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 13:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHORgZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 13:36:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E20A10EC;
        Tue, 15 Aug 2023 10:36:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrslXxdO0fnTUdnLOsKBK/kjGZLb5Qr0T29tF4kyS8AdpkMgIz8jSlcqPRksCcKOzKN6vQUwihrAb32o3CVPq1Re51jodc8+4d+zwpA3W+Xe1cinfnozk1UrI0o/rhpxRZQ29CVzp/MditLcpdfTRX9SUJzU6CQ/RyOb+8pxWZceZPTwqrluao7D8C9ThKjx5QX2VIUGzps3IIJKElErdy3taZZmRsc2INQINuoyZfnXgJ9SqqB9YaIB/JOX2vrKw9TY/GvHTwp1N8I7ViPq+7SAWNJsm1aWlPhSAFupiZoawwJKToLkxeZ4lMx9rWw3M58yWCVOP4FU7ZQ89KUrfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Op4/7KZ6oAUsKdBLWy9AVJT70i62pLtUHVQXqUCz0jE=;
 b=NSsoxc9nsT30tBxZrorAbtBOGjb0BunvRPxgMMIpXWnLyPbf6Lq2xnc5CXfbL1gZVvG/ENwB0XsLNctYVDEK9lUptCeQqIImeu6pERKrWUXE8gzMxWxmr/6KGPCnS3osdvOB78kKfv0xPdf7UKFPKSBpePg6nDZrXnJMvK1N89WopsXeWcM4h41PUCR+vJYajkFVDJ8TAfUgl00QJVjWGrR8DkDxEFqx/HiZrWTyZAGbo4EF5/ENSELoEMxeIeKznq1weVOFj+jkDNT2AppZJpdvnf0q/SM35wpzdGj6YF9Ve+t7jrWTmpa0zl65iJMKrEkEa9LbTL8ucaB4CcVm3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Op4/7KZ6oAUsKdBLWy9AVJT70i62pLtUHVQXqUCz0jE=;
 b=hf4CnR7Tub5gNtCsAf6azN6OMp21gX1mQaBKbYO+uwv5SolPcIeBHncfq4vF36EjqVVC74h8Y/S1tA1Vgy2BdvXqgCWotlPPx6tilVVEmBw51VNzA3ogxkFvKcWZDoSFzDl0vL1nGtg9Ajm3+TJ8LQ2p4tockAPrPmugHjJohIRyGm9y3Gc+ndK1rCWgJz2fl951TmHSYsJ3OFi/Id5zWroKCUjbOcLGUkmDYDyNQcVqar35nQIa2WbYAx0KOZ/0DB//d5uI6bzt9HuAc5ieKMUGmg71bOxeFh2usQgCJzn5ocq+tM8qSZG9frwiMZaGLCGbk522RL5SY70hAZuM+A==
Received: from DM6PR17CA0014.namprd17.prod.outlook.com (2603:10b6:5:1b3::27)
 by DM4PR12MB8497.namprd12.prod.outlook.com (2603:10b6:8:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 17:36:20 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::f6) by DM6PR17CA0014.outlook.office365.com
 (2603:10b6:5:1b3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 17:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 17:36:20 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 15 Aug 2023
 10:36:06 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 15 Aug
 2023 10:36:06 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 15 Aug 2023 10:36:04 -0700
Date:   Tue, 15 Aug 2023 10:36:03 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <kevin.tian@intel.com>,
        <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
        <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v7 3/4] iommufd: Add IOMMU_GET_HW_INFO
Message-ID: <ZNu3gw/d0wj4qBpU@Asurada-Nvidia>
References: <20230811071501.4126-1-yi.l.liu@intel.com>
 <20230811071501.4126-4-yi.l.liu@intel.com>
 <ZNuq+17Gv/d3lEin@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZNuq+17Gv/d3lEin@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT113:EE_|DM4PR12MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3d8e61-17e0-4cfb-b512-08db9db62321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmujjCQ3isQQ6Uu9MX7xRDYSPsBfVnCIFin5bYVlkbM0/WU5tVSqWWpzpblk/buOOG5PZcom8XzoKIb/TjJJM2a9alWrlIOGTP3sCnMhTFNdNdv3Q5FivBFENxSpuUdiB35aF2qY3KEtquZz9DfM02gi6uFr6age84KKxwJY4/p8z2Cx73XverfyYiDnWGNGHQDMyz45N7R7tfEgbhVjZIsqK8FW4+i5YktlvwHuX1mZvh0TnT0tCLNXynwslYT5F+cKxDwpuDrvgQJgF+iMRAqRCVYEmDEvHL5eMuIb5R9pDTpCrvAFUPs4uTkIXjXH1siAijerJqPGSeuf5L1//SDmPxUwVC07M0fExwPOyg/iCtMR9zMlpnnR65RVUF95Xl9yCJP+8sR6x99y0FbFWirmdmxPpiytSfV620fI35UHvWxDBPQGUy2JXTcQ32GoH0jrERQGKCDV5xFoeyipKNmqhsPAZV/X/j1P/1tJx+mE8FYXOlywb7LCc7cm3RaketbS2PdzmIEof7fw2dweL+y73U0CncyFFkUyVdmrl7oBOYLbRmwgJX4gcGjWPdRAnkEXe9c6SpyIuaDTuhB7kniK6eN+BXh3nvfx8k6Fd9+ZmhhWQVnSYfleQizcusDNTW++zGSxbBvi5hMFY58i5fG1z/Z5ywr8L95sedo17DOgXJbLY5INt37sOrvZWVMj1kTS+pdZBH753T+Scun8ZPQ/upgdCz6b+tCIRDvly35Hj8p5NGf7OMzc2O3dSSPd
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(7416002)(9686003)(6636002)(40480700001)(36860700001)(478600001)(40460700003)(33716001)(8676002)(55016003)(7636003)(4326008)(70586007)(54906003)(70206006)(82740400003)(6862004)(8936002)(356005)(2906002)(26005)(316002)(47076005)(426003)(336012)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 17:36:20.0515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3d8e61-17e0-4cfb-b512-08db9db62321
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8497
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 15, 2023 at 01:42:35PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 11, 2023 at 12:15:00AM -0700, Yi Liu wrote:
> > Under nested IOMMU translation, userspace owns the stage-1 translation
> > table (e.g. the stage-1 page table of Intel VT-d or the context table
> > of ARM SMMUv3, and etc.). Stage-1 translation tables are vendor specific,
> > and need to be compatible with the underlying IOMMU hardware. Hence,
> > userspace should know the IOMMU hardware capability before creating and
> > configuring the stage-1 translation table to kernel.
> > 
> > This adds IOMMU_GET_HW_INFO ioctl to query the IOMMU hardware information
> > (a.k.a capability) for a given device. The returned data is vendor specific,
> > userspace needs to decode it with the structure mapped by the @out_data_type
> > field.
> > 
> > As only physical devices have IOMMU hardware, so this will return error
> > if the given device is not a physical device.
> > 
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > ---
> >  drivers/iommu/iommufd/main.c | 85 ++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/iommufd.h | 36 +++++++++++++++
> >  2 files changed, 121 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> > index 94c498b8fdf6..d459811c5381 100644
> > --- a/drivers/iommu/iommufd/main.c
> > +++ b/drivers/iommu/iommufd/main.c
> > @@ -17,6 +17,7 @@
> 
> I was looking at this more and this code should be in device.c:
>   
> > +static int iommufd_fill_hw_info(struct device *dev, void __user *user_ptr,
> > +				unsigned int *length, u32 *type)
> > +{
> 
> Since it is working on devices
> 
> main.c is primarily for context related stuff

Ack for that. We'd make similar changes to the other handlers too.

Thanks
Nic
