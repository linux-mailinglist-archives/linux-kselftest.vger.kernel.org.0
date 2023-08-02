Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B91876DBB0
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 01:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjHBXmd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 19:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjHBXmc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 19:42:32 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5D330C2;
        Wed,  2 Aug 2023 16:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DedJCHnK4kS6g8wt6Ri1khKO249Uevc+uuBXRIR4wuXHlh7Z8RptIunx3E4YXeTT67LNNgqMm3nNWXFbos3Lq8A8tTLk5WA9J7rAoNr0I/KiIOhzlVjxE7KWhUkhPV16w4P3eqrFnBDVqE1oLJH17jgI2EltfRNImICv1KJBxdPmRKQwps03reojM9aodCgqDIjppnXUqtqjbzUBoyCn+3+m1yctBqtXv1LDMQdm7PHbSUSGHcz1GrUZRK5CrUpoLjj/mZlPJ/XsAsZ+ggSH8MHhVlKJHFLAMnKynNUS+fbp70szaDvcty3k6nesqjNtxTg2yFBEEkhoUvfExb/nxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVb7sAyH4v5D3Y404hctFhh+GmDP/xe0ddmv1wqVr/Q=;
 b=JMnQuKdBCNVDiGgDCMHHkxJwj+hyJnOAup/HPLwnq0Pk51imamGNvAcEU02g8F0Y+/ORCFYji4ae6404Nr/lfmfBZF7EUpJ6ub41uGk4+eLjQIr21pGDhx/cszB70DbqowVnYO0veNX/qtw0E6K5+grItMwEB65HGpO0RvbL/XTlxscOHP63oURihg4hhrOwmHM/lUtZUovuxL+HLBhBNheirwmpmJDLAj7rZo+U93ibzIk8GSCBjkLOGXEaiCHNnFPPnRYUzLUheJSaHoRWvV3ZLZ3e6v1o7xUW9mHtclTFqO7WsDCXYzI0u5qJNVdjx/0Mr9F1qmZoblQBZTfg9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVb7sAyH4v5D3Y404hctFhh+GmDP/xe0ddmv1wqVr/Q=;
 b=tvG/3LBCBM+5tBMPAzo+G0xr/UQJ40XahH1eC41WwTpcpdEtuU1aQJutgvcT0vH45f36DYNJdvHWHJuSQdpfBu+n45TOStdHRxLEp5jVI44vwLcsqC5Y0cmtydOLkeQx9vcAhr/tcVRm3j3bFlY9YC67BhUS2+kdttom23f3juM+5iIL6ANlQdZ1j0jvC3HCb+pIbUJQJGN1zM+1XG7Wek5LDko3Xv10RGuos0nGq6Tr9WSog4GLyGzeo6HfzOpn1sZyTI6fEqRZVo4S6hlVPFZIZAulhCyhizL3JcZXW9LEsF4O0WgdrSYkTt9b/krG5dlqRgCsPNubcTHwAD8AIQ==
Received: from SN7P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::12)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 23:42:26 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::99) by SN7P220CA0007.outlook.office365.com
 (2603:10b6:806:123::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 23:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 23:42:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 16:42:13 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 16:42:13 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 2 Aug 2023 16:42:11 -0700
Date:   Wed, 2 Aug 2023 16:42:10 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
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
Subject: Re: [PATCH v3 08/17] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Message-ID: <ZMrp0ofsx8M6fT/S@Asurada-Nvidia>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-9-yi.l.liu@intel.com>
 <ZMQBLTm+U+5bgC/Z@nvidia.com>
 <BN9PR11MB5276C84452E56AB03B819D208C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMe0IQksFgV6yKTB@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZMe0IQksFgV6yKTB@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 339fe851-1e63-463d-f0ba-08db93b22016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nP28xwqz7fjq7ZL5v4xFkvWSL7rOwwmM0ZwU3MyMJ4QtNRKlb0SFj3jBDQ2l5ukVpjtWcY07CQGIVdV09Y9ge7AW1vuqtWOIv+bLuedaDBa8ANjIoOGqE7Cb3pwiDIC1xyIx8pbzqA4rPcEID9KNa8krDFCrVi3vG9gVyTqG284Jgmby01/l0MDZnf3tnIkdPnme92eq7uNWqm0zBLaeSxnhE/lu6S3FAmjhwsYiVcN0CuHorZ+VEgjWeIbvlbIx3fqGwV8Ik8djdraswfQQw7YcpC3eubdiznmghWEktRIYIyZs1J1pKGg6MrRlhpWz4X3NK/zbPcgM+DDxHg8RRk7nhmU16oFF8FnD/LHZg3SgyJuVmnKk54ur1X8LbcPVV/oFxBDLtPNa0+YFSzPVz3l+7MU1dh+pASftii3zrO0VQUJZWFzz+Qk6LR1QM5+Wz0R9S18dqI6ilIUgiWHhLX1S4kFBlhsjZWWNF/AeMnwCiDggchKIpkfpLr64cs5q5D8N3fk///bZ1U+0XToa4BNA/UkMS4KbxDQ10cwfkd6VWiyyKGCl516kKo42yJnY+CcpiRey5+IMKrpdOrx9w9/tCuYhhoNfOFfKASzVFRgmqpZpW+Z+bCv+xj6YvX8JwjkroyMHx8yGOycY5DpbTXnIx5CL2gbLGTG3D1KprqGgfGz7C/ix7xPoyFVrS5883ZpRswl9pq365zE2O9b8uisBvBc1HuFwF2taTKDNHpA=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(40480700001)(55016003)(336012)(186003)(40460700003)(9686003)(316002)(478600001)(86362001)(7636003)(54906003)(70206006)(70586007)(33716001)(6636002)(4326008)(82740400003)(356005)(26005)(41300700001)(6862004)(8936002)(8676002)(7416002)(426003)(47076005)(83380400001)(36860700001)(5660300002)(66899021)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 23:42:25.3486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 339fe851-1e63-463d-f0ba-08db93b22016
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 10:16:17AM -0300, Jason Gunthorpe wrote:
 
> > Ideally expanding uAPI structure size should come with new flag bits.
> 
> Flags or some kind of 'zero is the same behavior as a smaller struct'
> scheme.
> 
> This patch is doing the zero option:
> 
>  	__u32 __reserved;
> +	__u32 hwpt_type;
> +	__u32 data_len;
> +	__aligned_u64 data_uptr;
>  };
> 
> hwpt_type == 0 means default type
> data_len == 0 means no data
> data_uptr is ignored (zero is safe)
> 
> So there is no need to change it

TEST_LENGTH passing ".size = sizeof(struct _struct) - 1" expects a
-EINVAL error code from "if (ucmd.user_size < op->min_size)" check
in the iommufd_fops_ioctl(). This has been working when min_size is
exactly the size of the structure.

When the size of the structure becomes larger than min_size, i.e.
the passing size above is larger than min_size, it bypasses that
min_size sanity and goes down to an ioctl handler with a potential
risk. And actually, the size range can be [min_size, struct_size),
making it harder for us to sanitize with the existing code.

I wonder what's the generic way of sanitizing this case? And, it
seems that TEST_LENGTH needs some rework to test min_size only?

Thanks
Nic
