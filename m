Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30F669B24F
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Feb 2023 19:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBQSUo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Feb 2023 13:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBQSUn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Feb 2023 13:20:43 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6044B5959B;
        Fri, 17 Feb 2023 10:20:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oF/xnsRZ26KYGrvB19BuSQW1BHisolr5hbC9fzBX/ZKa8Flj2WjY54IaRdTIjQaOYkRa76flkx4H+ZJ7owZfXQJKbHpxh+wK1yP78/yn4eX7ilGxEbzbUXEVe+cu5yhfAsMYpVe0myntkR8l85QHhPeXobAJUlGA4VHLnQ0exv5dcgueawiS+eXEyjtkjU+krdok9gbX0lhSPP1ye1WpcK4TBL3pbA7RQ8CuuTbt0BcTNKuPWKPiY9fD32PEtQ046SyOVD4sBNHFo35frKh5f5+CD1PiS0cmkLHtfSw6Zq952I580UbRkVT5+d2+e7soU/ZvaRYJsMEC4350nG+5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNWbJ2BKiILDAR5ZaJTsujZ0+6hY/AgEr44XX2lA7Ic=;
 b=itFzZmwy0cM7N2NZxVkGbS3pfoI4bKMTaXOdWHIKzY61rWNpohzuqI9aT6Gb1IQ5HZRgBNbSpF++Q9aLAwmbIAqA6ZVF0WQY9bunfxLQFot2avxf8QE3R9nWnbl4JtQD/NrO3W1/gf+6EV9+UeKhwXPH8RVeaa7Ks0TpzOg2nJate/V7riJ2anSNtSBz/B5M4zIC0Q7hJ5oIBM0G284XYbrItCOhDsvknAO5z0YezXcnjsbXzzw3JHlNTiFcXEU41ftJ1LRc+o3Lzn92emjIowxIC8IKPEMywXXstHnAm3mbGJdYvVdA89//i39o1fC271rIGsRApydOdnarISsXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNWbJ2BKiILDAR5ZaJTsujZ0+6hY/AgEr44XX2lA7Ic=;
 b=aohbWF3oDrgSPqZAwpeyLXx4XHDjj/bySdGEDkZCgkPNzI0E5YTULqp2f2JQkdBO5Qof+aWORrfMa963QA0DP8EZqfhchioJb+tndq4C7U8eNNoAkocUYVvTBjDQ2zDLHQxiHQZw9LpOALxBv3bnIAaA/VgpQu6WAfgFei3DmlOXcMQu7g60xxReQnpYupa4yZQ9MR1sPVDsWO0Ma/HADk2drflv7hYPtTEpThfZbpoHIXV27zc+oxfr4w+P0L8Aq4ZoGugybp6gWTYk5X8cWSU+HlzkbOe+FRPSrvkoprQS8Q8KCUuMh9WvFHoPSh0fFdoGxrx+ZVf92Cq8QEDRNA==
Received: from DM6PR02CA0091.namprd02.prod.outlook.com (2603:10b6:5:1f4::32)
 by BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 18:20:40 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::d) by DM6PR02CA0091.outlook.office365.com
 (2603:10b6:5:1f4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.17 via Frontend
 Transport; Fri, 17 Feb 2023 18:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.17 via Frontend Transport; Fri, 17 Feb 2023 18:20:40 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 17 Feb
 2023 10:20:28 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 17 Feb
 2023 10:20:28 -0800
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Fri, 17 Feb 2023 10:20:27 -0800
Date:   Fri, 17 Feb 2023 10:20:25 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
CC:     <joro@8bytes.org>, <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 00/17] Add Intel VT-d nested translation
Message-ID: <Y+/FOar7KXKAb2VQ@Asurada-Nvidia>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230209043153.14964-1-yi.l.liu@intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|BL1PR12MB5159:EE_
X-MS-Office365-Filtering-Correlation-Id: edb699f7-016a-4a35-bdd7-08db1113acbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/YMYLR3ANt46mT2XH2GZ5d/kMu2vA/OhJdj2leOMdMA2iuU4N6wk1jsTxLslm7/4ojKdQPHFS3dGNCibf2e2txv2ebG3GHscF4vjy1Ng2yneAF2siUTMM/70PZyHeHL4zq1E2T9iqsxda5FFbfT0PT175fdDR0sT+u8JVuOltE6BNMUVbhzpLpwb7iTkPbVi3n6JbmcaCN4un7C4PooEVi2KRCy6RSGc67SOj7+gUjMKIz/VIrd74Zc28b/5RGzklnsImp7yLidUnFS8/EOrU+Ijyvh/PoiwvfebLfmbm6gzdmKF/04oS+EmgWgWQ2/f62asEk5Lie42ZM/l1o0JBJia3YFGNeg2h/LNwQX/EbxXHlc8nrTX/7wjnk5iNVVcM9jyuBNhQ2FNZQIsIZMiGk5dyFXrn+qW8CwxFgrfA0j2ajcRbvPeMKfBpJiNuWbbyvK5qFT94+SWanotf0iGH0D+j9v7IuyctP5l/wVHbh0Aq9qPC5T7lZLT6nLq0eExy76dsFdmfrTLD9tef+liY/gBckt79sfXTp/8cFL9OzA2tXoWtbw3lvcOO+SupwxwBaX+MRS6ctGfrIot6Hm31jiDEHtAAD9CIwyu9fAN7ZrOiFim91ysac8fk14V9QigtdYmkEIF+Ay40M9ukEA2QXqylkSoT45ZNBaeOfs5cCcRRTKxBD/gMT6mEProeT9WPAok1npyBpionRCrrbSFnxHRMnURrpj8Y1srpJYOUstwGsBj1Ng7B0QqVyl2ud/
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199018)(40470700004)(36840700001)(46966006)(2906002)(54906003)(8936002)(82740400003)(316002)(7416002)(5660300002)(40460700003)(70206006)(356005)(70586007)(8676002)(41300700001)(6916009)(426003)(4326008)(47076005)(336012)(33716001)(86362001)(7636003)(40480700001)(83380400001)(36860700001)(966005)(55016003)(478600001)(82310400005)(26005)(9686003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 18:20:40.1948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb699f7-016a-4a35-bdd7-08db1113acbf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Yi,

On Wed, Feb 08, 2023 at 08:31:36PM -0800, Yi Liu wrote:

> Nicolin Chen (6):
>   iommufd: Add/del hwpt to IOAS at alloc/destroy()
>   iommufd/device: Move IOAS attaching and detaching operations into
>     helpers
>   iommufd/selftest: Add IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE test op
>   iommufd/selftest: Add coverage for IOMMU_HWPT_ALLOC ioctl
>   iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
>   iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl
> 
> Yi Liu (6):
>   iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
>   iommufd: Split iommufd_hw_pagetable_alloc()
>   iommufd: Add kernel-managed hw_pagetable allocation for userspace
>   iommufd: Add infrastructure for user-managed hw_pagetable allocation
>   iommufd: Add user-managed hw_pagetable allocation

Just want to let you know that Jason made some major changes
in device/hw_pagetable and selftest (mock_domain):
https://github.com/jgunthorpe/linux/commits/iommufd_hwpt

So most of changes above need to be redone. I am now rebasing
the replace and the nesting series, and probably will finish
by early next week.

If you are reworking this series, perhaps can hold for a few
days at these changes.

Thanks
Nic
