Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93E568A617
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 23:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjBCWZc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 17:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjBCWZb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 17:25:31 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976BE8B7E8;
        Fri,  3 Feb 2023 14:25:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhGryv1kPvwT88MXBKlpCtK112aEkUSuep9MGRLIT5feeFmInGhnomAA+/RHFjAmWGZpXw07JTQ9ELZpEPVZa2gOiULqvLx4++5MvvWXVF1DDZxn2Q6sHSqjchVCdEWQQNakL5GVBF7i8GZfct7SOAE8sNmLkI2PY7HWETsKHl22qI6d4Gcl+F+Rpc6Z1s2cq/q40qtzGskBXQi2H+FYx6VdobDBS0FUjqQsOu5+xI+V2NcAnKKQ7M8EtdzNRLLhrSo5Tw1lFY3MwxtsAF1v/IbjR3PMJQurRcdm46BFS8NRHNOE6QHdnly1s6brq8AnLZVg0YOEqAT/oGXGZBpmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAsnfwWpyCy9xjkSWXAVZmtMa2uW38sV/pG0tS/4umc=;
 b=U9bp7umkJZJXRG6lQjMHhYiV9S1uoDhyJzG84d9GM9Ng4eqo726R0RwaCvMBMUJls3aIIEQ1EliM8Ww1WosuGGAE9NV3z1Cii9yk+zYMcKGJ433LPLKXYt89YMHLqi1d5UGc6BEWBZk70Q4iQMkyUwTjbN2OAVZ9OPx0ZxuQR+aF4tDXj/agU0HhlRAp/TCYHGNl+qnpzxCoyXh2UoFcaXsACZgN58zlxp2+qX4l97VkhKPOA1hsQWcBR6BYWZP69Sl+PWLavsWFpVBrJ/sWFg77vik1jPsb7Bz3qQnFsjoQhI0jCOX6x4n8DYxuxo1z/snXqsYAmo5HKYkjjUDMyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAsnfwWpyCy9xjkSWXAVZmtMa2uW38sV/pG0tS/4umc=;
 b=M1+Du5uJhWWbs9hUgif40a+fzE7CxwTBXR4jO4q9dRuIdQfs8C3nfr/ZrTchTGcdEfIIqnKzMBlddf6+SauH6/7FNZ2I5RvgEjX4w4GQoFUU6rkFsUtRkhtb2kmtIsDye+PHBmRQcicw/rRgTLGFq5D/vV2Zf3CKgK2ZLW31Glb1fH+n7PlRJKH5gw/H0kxZHK8e64alzpYSwIHDRUBFiuMD8GTRUYCJ3n2po537I0N/sEQUC3HCXVk5rMsdc9NfuTUtp24llZiPB0uskycE2K/NEnMOiZd2EJrrocjN7U7PtrnI8nfuSFfCNTg7pFyCtfrp+k0RjyYkp/WzC2wy8w==
Received: from DM6PR02CA0130.namprd02.prod.outlook.com (2603:10b6:5:1b4::32)
 by IA1PR12MB8310.namprd12.prod.outlook.com (2603:10b6:208:3ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Fri, 3 Feb
 2023 22:25:27 +0000
Received: from DS1PEPF0000E63A.namprd02.prod.outlook.com
 (2603:10b6:5:1b4:cafe::de) by DM6PR02CA0130.outlook.office365.com
 (2603:10b6:5:1b4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29 via Frontend
 Transport; Fri, 3 Feb 2023 22:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0000E63A.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.21 via Frontend Transport; Fri, 3 Feb 2023 22:25:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 14:25:16 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 3 Feb 2023 14:25:16 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Fri, 3 Feb 2023 14:25:15 -0800
Date:   Fri, 3 Feb 2023 14:25:14 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
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
Subject: Re: [PATCH v1 5/8] iommufd: Add replace support in
 iommufd_access_set_ioas()
Message-ID: <Y92JyoHX1MQUFpz+@Asurada-Nvidia>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <bfe5aed6d354ef547979f0b256c8a3f9bd5b223b.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276D06D3F9AA6202E20F8E68CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y9z+uAbYtgk30no+@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9z+uAbYtgk30no+@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63A:EE_|IA1PR12MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e168c0-39d2-44a5-ca3f-08db06358d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDGRRP3svOx1/tE/KNk4fAW4ZRTP35YcrYNY/wFt+HiLy0bpqd6vohYAlRNkUqEdfeIAh4nKZ7YnyQ9DXnG6fXrC6nIou436VCW+tGiSXd6rUWepCPqmt/5565DA+IkKjZ8pwsv7IZQgJ8L0GHhbL9TubKoHivojzy7KZnSEkq0VzufRzD4TOjbLqekocVjT5zvboMHPyqKeeAA19JEZvtvZSoXCM1O1FV+PnBsHX2pz5PwSJuIRhp1njCrhTWx2dj2EdeLgnNyP5Q+Ck0tvJIIZnuxLTb39b1vzsJtCDCGGj1qf6dlHwLaw5SpIsBtnl+Qout0fmXpVYVNqrkczHJwj/KIqbxfGj6rGwok+dnF8rp3UVFaM+TI4YGgQpTujJ6W0mJ/k9rfoXMcigqeqX+h/FDS8/D4pPAzUTTm0d7mORXiLChgNJBuAW/JwDcE0wnmZ4n+kvVVMl8hTkErZt82J4k/EgefbILwdXPj+n4vGphHGRmB7D0UdC7+Fh+pRFyZNr3A/p3l2GVdMO7YQeasVaGBo3p0RKQkXAD0HDG2f6goyjkBwdgr7xSd1uQC4QguQpCt0sA8Vdw3M3Din78mqt6FnvhU59739sfu0+5qjbxnhDevrm4VwxGYmt/Fw2rIP32KUybQeRgX5utB2N696HRvr/HqhV3r7SO8K5AWZLHJbrDgGtw4UFYJGtf1h
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199018)(46966006)(36840700001)(40470700004)(70206006)(70586007)(83380400001)(41300700001)(36860700001)(47076005)(82740400003)(33716001)(426003)(7636003)(336012)(82310400005)(8676002)(4326008)(55016003)(356005)(316002)(186003)(40480700001)(9686003)(40460700003)(8936002)(2906002)(26005)(6636002)(110136005)(7416002)(54906003)(478600001)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 22:25:27.3822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e168c0-39d2-44a5-ca3f-08db06358d33
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8310
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 03, 2023 at 08:31:52AM -0400, Jason Gunthorpe wrote:
> On Fri, Feb 03, 2023 at 10:10:45AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Thursday, February 2, 2023 3:05 PM
> > > 
> > > Support an access->ioas replacement in iommufd_access_set_ioas(), which
> > > sets the access->ioas to NULL provisionally so that any further incoming
> > > iommufd_access_pin_pages() callback can be blocked.
> > > 
> > > Then, call access->ops->unmap() to clean up the entire iopt. To allow an
> > > iommufd_access_unpin_pages() callback to happen via this unmap() call,
> > > add an ioas_unpin pointer so the unpin routine won't be affected by the
> > > "access->ioas = NULL" trick above.
> > > 
> > > Also, a vdev without an ops->dma_unmap implementation cannot replace its
> > > access->ioas pointer. So add an iommufd_access_ioas_is_attached() helper
> > > to sanity that.
> > > 
> > 
> > Presumably a driver which doesn't implement ops->dma_unmap shouldn't
> > be allowed to do pin/unpin. But it could use vfio_dma_rw() to access an
> > iova range. In the latter case I don't see why replace cannot work.
> > 
> > Probably what's required here is to deny !ops->dma_unmap in
> > vfio_pin/unpin_pages then making here replace always allowed?
> 
> That makes sense

Will change that in v2.

Thanks
Nic
