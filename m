Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1389B738CD7
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 19:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjFUROD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 13:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjFURNy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 13:13:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A1819AD;
        Wed, 21 Jun 2023 10:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7Dl9TlAOFcclFVt7weQp0FAj3u8yV+Te66lGuNT91374GsKXhblrhfZWnh52DbBirINjqBJFB6SPp8XEHJbYUGM5+uBFdlygilBb1L/iUhihJ/UDDa8NNyHVMKQ00KyASu9wdpsIaLhZxmaUdXFoUJ0YaS8DFN1mV/OHSlVhuC9hjbfU2JoTSRvXrg/8TNMgOBxMgpth9GTPuc46m2jrTS7LB2bEsA28hvncLhPxCq0fEX+R0jeN9FR2W22KRE0ZUFvL1ttMj034XPZbC6DT97cHn1yaj3gt/LV/Mfe23nsGsGNIu272N+/x6gvE/hSU/8HFl1hEwRdQVV+twI8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmafzQVzyRQAiBn1bxXTo6/xxqboTtgTBZeq4FQt3Uw=;
 b=IULBlccwYjoBnYu5fzqceThoABb9jtYmZOJQ6MM78n2bIRmMmngi7EJyX39N8uOLLPrzhYED0wVmgYeCSaQY/mvnfUHjlD6M5hcRq7mVZJymkpvI1gy03kuvxqMGAEpiqsUUNsZaX6PhbxyT7QghGvfK4fpjOMQPyJtKZBMDiw+lFX4uT2YZcreu88fL/HFekZDYvgNVgCrShuZ4Mdjtx4WYi4+xFzKkNjD+/utm+tHQAQDx6JyLHTBMKcs5Km+5fJvyFKkicLEhP0x5P/2/h0oPOwXzA+L5om3+6pCjuXC/XqbLaA21lo/Z9dNgB2FU7+xIepXZqu2Kh9EicXwaPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmafzQVzyRQAiBn1bxXTo6/xxqboTtgTBZeq4FQt3Uw=;
 b=V+iLh2iHNItDK1UbV4NFb7NY/l6KlkGwr2/KhzWjZLHEoIQsWs+yOh0Zjt677h6A8e8eaZFSCv7eukSNOFCx7miGp8Y6PBdAhaKHep7xTilsHoZG5AXOFf9Kytc4xRT7SDWDa3SpYtsAZbM+EXVeVL7G1suweAmUqDXgIVSs41FFQNmERZxZsy6e/DuM88DdaM2nWbHbilRo5vd2r8oXw3ZCrl9mb6NVeBDMa4iKMKoXIUAJyQyIRvw3UMIx8rzHdSCqOXuO1a9yUwX3lDTZAvuE3yq7lI8T1MPvBpLM18SLCRjoby03GX3Gqh0oh3WSAFDQ/uRISmJQBD9hQH47zA==
Received: from SN4PR0501CA0025.namprd05.prod.outlook.com
 (2603:10b6:803:40::38) by CO6PR12MB5428.namprd12.prod.outlook.com
 (2603:10b6:5:35c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 17:13:49 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:803:40:cafe::a0) by SN4PR0501CA0025.outlook.office365.com
 (2603:10b6:803:40::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Wed, 21 Jun 2023 17:13:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 17:13:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 10:13:27 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 21 Jun
 2023 10:13:27 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 21 Jun 2023 10:13:25 -0700
Date:   Wed, 21 Jun 2023 10:13:24 -0700
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
Message-ID: <ZJMvtMe5QHPM0OEJ@Asurada-Nvidia>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <BN9PR11MB5276DAF0A11809CF8433EE338C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGdiS2m8jcd5OOt5@nvidia.com>
 <BN9PR11MB5276A74B2DA86C79908A420B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZH9AGWf1yRDu/86q@nvidia.com>
 <BN9PR11MB52763C7B838B04D3200322FD8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJBL8QLLBiwRsUSI@nvidia.com>
 <BN9PR11MB527663567ECB8AD52D3170818C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJGf3sgLKr9HLZuE@nvidia.com>
 <BN9PR11MB5276B852A32F53BE8EAA1A7D8C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B852A32F53BE8EAA1A7D8C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|CO6PR12MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: 54abb680-5565-4595-e8d7-08db727ae149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hyCRFDA5hJsbBo7OHwRhg+C0CszU3PRTN654U9ITrPOw0dUmX19wwN9czi6Dbk5p5DuMn+JZijCZ02yb9xRsVilWVBFpROf4WwGpNuUURa0EEoJTwkmUEY7xsV1RCxDOu3E26pwwQ8g0uXmtQngoQ88qsdaoG+Tj+mpS4+SYRVvOy/tcB3CZXNAvcP4wETzzzu5FtRnsB0Eh/c5r6RJNVnCR/ZHJwUDvdtfC2dwKAjcVO4phrsZ/guPAN6XUy8dofcrszILe65AJ0wBlqA47WmgHlWEELZEpgXfCJi6YED0ju9AgtFmrfcW6f4uKWsoilUIMRX8f8V4HmPyLn2KDOj4j1hhpnxI6pxwgMjwRH7pj65ytXofXQKE1ULzjAccqVjO0/R2gcaJ9lVjzat3zwZfRRWXlUSVcPeM8OxgY7HOrHRyCja5Me3MhoWdz59MATbSqkwDsD2vXicBu+R/C9eC0/KvsCHEtOEIGgH02Y9zx0E3FdXhUjx3jAA3OeUFVwZvHekPh7ZKS1d2O7v0jqFNo498ha4Kir5SIdU9uorzaEAlmnGc9w6PE7vbXQCiblL0FMXtebtjzGk4x8nb0ON2+nQElPIMIX1ND1eJnQiwd3QLfFIy4MAODKlSJwPBqogQWGQ08qLlXvjBvigf6Ga9QpSzB3LXal+D4EEn9UY0WuzKoQmLK1Mgnnu+Vm62a8S5MvPyeo2/LylAPblka5hGR+3LupOc6B+Iou0y8Zhw=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(36860700001)(40460700003)(356005)(6916009)(70206006)(5660300002)(33716001)(8936002)(8676002)(7416002)(316002)(7636003)(4326008)(55016003)(40480700001)(41300700001)(82740400003)(70586007)(47076005)(26005)(2906002)(9686003)(426003)(478600001)(186003)(86362001)(54906003)(83380400001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 17:13:49.2944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54abb680-5565-4595-e8d7-08db727ae149
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5428
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

On Wed, Jun 21, 2023 at 06:02:21AM +0000, Tian, Kevin wrote:

> > On Tue, Jun 20, 2023 at 01:43:42AM +0000, Tian, Kevin wrote:
> > > I wonder whether we have argued passed each other.
> > >
> > > This series adds reserved regions to S2. I challenged the necessity as
> > > S2 is not directly accessed by the device.
> > >
> > > Then you replied that doing so still made sense to support identity
> > > S1.
> >
> > I think I said/ment if we attach the "s2" iommu domain as a direct
> > attach for identity - eg at boot time, then the IOAS must gain the
> > reserved regions. This is our normal protocol.
> >
> > But when we use the "s2" iommu domain as an actual nested S2 then we
> > don't gain reserved regions.
> 
> Then we're aligned.
> 
> Yi/Nicolin, please update this series to not automatically add reserved
> regions to S2 in the nesting configuration.

I'm a bit late for the conversation here. Yet, how about the
IOMMU_RESV_SW_MSI on ARM in the nesting configuration? We'd
still call iommufd_group_setup_msi() on the S2 HWPT, despite
attaching the device to a nested S1 HWPT right?

> It also implies that the user cannot rely on IOAS_IOVA_RANGES to
> learn reserved regions for arranging addresses in S1.
> 
> Then we also need a new ioctl to report reserved regions per dev_id.

So, in a nesting configuration, QEMU would poll a device's S2
MSI region (i.e. IOMMU_RESV_SW_MSI) to prevent conflict?

Thanks
Nic
